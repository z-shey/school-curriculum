#include "stm32f10x.h"
#include <stdio.h>

void Delay_MS(u16 dly);        // 声明一个延时函数，参数为16位无符号整数，表示延时的毫秒数。
void GPIO_Configuration(void); // 声明GPIO配置函数。
void EXTI_Configuration(void); // 声明外部中断配置函数。
void NVIC_Configuration(void); // 声明中断控制器配置函数。

int main(void)
{
    u8 i;                                                 // 定义一个8位无符号整数变量i，用于循环计数
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE); // 使能GPIOA的时钟
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB, ENABLE); // 使能GPIOB的时钟

    GPIO_Configuration(); // 调用GPIO配置函数
    EXTI_Configuration(); // 调用外部中断配置函数
    NVIC_Configuration(); // 调用中断控制器配置函数

    // 无限循环
    while (1)
    {
        for (i = 0; i < 8; i++) // 循环8次，依次点亮PA0-PA7口
        {
            GPIO_Write(GPIOA, 0x01 << i); // 将GPIOA的第i位设置为高电平，其他位保持不变，二进制位操作， 0000 0001
            Delay_MS(500);
        }
    }
}

// 延时函数实现
void Delay_MS(u16 dly)
{
    u16 i, j;
    for (i = 0; i < dly; i++)
        for (j = 1000; j > 0; j--)
            ;
}

// GPIO配置函数实现
void GPIO_Configuration(void)
{
    GPIO_InitTypeDef GPIO_InitStructure; // 定义GPIO初始化结构体

    /* 设置PA0-PA7口为推挽输出，最大翻转频率为50MHz */
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0 | GPIO_Pin_1 | GPIO_Pin_2 | GPIO_Pin_3 | GPIO_Pin_4 | GPIO_Pin_5 | GPIO_Pin_6 | GPIO_Pin_7;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz; // 设置引脚速度为50MHz
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;  // 设置为推挽输出模式
    GPIO_Init(GPIOA, &GPIO_InitStructure);            // 初始化GPIOA

    /* 设置PB8 PB0为上拉输入 */
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8 | GPIO_Pin_0; // 设置GPIOB的8号和0号引脚
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU;          // 设置为上拉输入模式
    GPIO_Init(GPIOB, &GPIO_InitStructure);                 // 初始化GPIOB
}

// 外部中断配置函数实现
void EXTI_Configuration(void)
{
    EXTI_InitTypeDef EXTI_InitStructure; // 定义外部中断初始化结构体

    EXTI_DeInit(); // 先对外部中断进行去初始化

    GPIO_EXTILineConfig(GPIO_PortSourceGPIOB, GPIO_PinSource8); // 将GPIOB的8号引脚配置为EXTI8
    EXTI_InitStructure.EXTI_Line = EXTI_Line8;                  // 设置外部中断线为EXTI8
    EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;         // 设置为中断模式
    EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Falling;     // 设置触发方式为下降沿触发
    EXTI_InitStructure.EXTI_LineCmd = ENABLE;                   // 使能外部中断线
    EXTI_Init(&EXTI_InitStructure);                             // 初始化外部中断线

    GPIO_EXTILineConfig(GPIO_PortSourceGPIOB, GPIO_PinSource0); // 将GPIOB的0号引脚配置为EXTI0
    EXTI_InitStructure.EXTI_Line = EXTI_Line0;                  // 设置外部中断线为EXTI0
    EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;         // 设置为中断模式
    EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Falling;     // 设置触发方式为下降沿触发
    EXTI_InitStructure.EXTI_LineCmd = ENABLE;                   // 使能外部中断线
    EXTI_Init(&EXTI_InitStructure);                             // 初始化外部中断线
}

// 中断控制器配置函数实现
void NVIC_Configuration(void)
{
    NVIC_InitTypeDef NVIC_InitStructure;            // 定义中断控制器初始化结构体

    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1); // 设置NVIC优先级分组为1

    // 中断线5至9共用一个中断EXTI9_5_IRQn
    NVIC_InitStructure.NVIC_IRQChannel = EXTI9_5_IRQn;        // 配置外部中断9_5，EXTI_Line5 至 EXTI_Line9，其中就有EXTI_Line8
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1; // 占先式优先级设为1
    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;        // 副优先级设置为0
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;           // 中断使能
    NVIC_Init(&NVIC_InitStructure);                           // 中断初始化

    NVIC_InitStructure.NVIC_IRQChannel = EXTI0_IRQn;          // 配置外部中断0
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0; // 占先式优先级设为0
    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;        // 副优先级设置为0
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;           // 中断使能
    NVIC_Init(&NVIC_InitStructure);                           // 中断初始化
}

// EXTI9_5中断处理函数
void EXTI9_5_IRQHandler(void)
{
    if (EXTI_GetFlagStatus(EXTI_Line8) != RESET) // 判断是否置位，RESET 表示中断标志位没有被设置，而 SET 表示中断标志位已经被设置
    {
        u8 i;                   // 循环计数
        for (i = 0; i < 6; i++) // 循环6次
        {
            GPIO_Write(GPIOA, 0xF0); // 将GPIOA的高4位设置为高电平，低4位保持不变，二进制为 1111 0000
            Delay_MS(500);
            GPIO_Write(GPIOA, 0x0F); // 将GPIOA的低4位设置为高电平，高4位保持不变，二进制为 0000 1111
            Delay_MS(500);
        }
    }
    EXTI_ClearFlag(EXTI_Line8); // 清除Line8标志位，清除中断标志位以避免重复触发中断
}

// EXTI0中断处理函数
void EXTI0_IRQHandler(void)
{
    if (EXTI_GetFlagStatus(EXTI_Line0) != RESET) // 判断是否置位
    {
        u8 i;                   // 用于循环计数
        for (i = 0; i < 6; i++) // 循环6次
        {
            GPIO_Write(GPIOA, 0x00); // 将GPIOA的所有位设置为低电平
            Delay_MS(500);
            GPIO_Write(GPIOA, 0xFF); // 将GPIOA的所有位设置为高电平，即全亮，二进制为 1111 1111
            Delay_MS(500);
        }
    }
    EXTI_ClearFlag(EXTI_Line0); // 清除Line0标志位
}