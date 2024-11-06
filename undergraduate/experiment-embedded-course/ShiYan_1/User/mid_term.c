#include "stm32f10x.h"
#include <stdio.h>

void Delay_MS(u16 dly);        // 声明一个延时函数
void GPIO_Configuration(void); // 声明GPIO配置函数
void EXTI_Configuration(void); // 声明外部中断配置函数
void NVIC_Configuration(void); // 声明中断控制器配置函数

int main(void)
{
    u8 i;                                                 // 循环计数
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE); // 使能GPIOA的时钟
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOC, ENABLE); // 使能GPIOC的时钟

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

    /* 设置PC15 PC3为上拉输入 */
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_15 | GPIO_Pin_3; // 设置GPIOC的15号和3号引脚
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU;           // 设置为上拉输入模式
    GPIO_Init(GPIOC, &GPIO_InitStructure);                  // 初始化GPIOC
}

// 外部中断配置函数实现
void EXTI_Configuration(void)
{
    EXTI_InitTypeDef EXTI_InitStructure; // 定义外部中断初始化结构体

    EXTI_DeInit(); // 先对外部中断进行去初始化

    GPIO_EXTILineConfig(GPIO_PortSourceGPIOC, GPIO_PinSource15); // 将GPIOC的15号引脚配置为EXTI15
    EXTI_InitStructure.EXTI_Line = EXTI_Line15;                  // 设置外部中断线为EXTI15
    EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;          // 设置为中断模式
    EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Falling;      // 设置触发方式为下降沿触发
    EXTI_InitStructure.EXTI_LineCmd = ENABLE;                    // 使能外部中断线
    EXTI_Init(&EXTI_InitStructure);                              // 初始化外部中断线

    GPIO_EXTILineConfig(GPIO_PortSourceGPIOC, GPIO_PinSource3); // 将GPIOC的3号引脚配置为EXTI3
    EXTI_InitStructure.EXTI_Line = EXTI_Line3;                  // 设置外部中断线为EXTI3
    EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;         // 设置为中断模式
    EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Falling;     // 设置触发方式为下降沿触发
    EXTI_InitStructure.EXTI_LineCmd = ENABLE;                   // 使能外部中断线
    EXTI_Init(&EXTI_InitStructure);                             // 初始化外部中断线
}

// 中断控制器配置函数实现
void NVIC_Configuration(void)
{
    NVIC_InitTypeDef NVIC_InitStructure; // 定义中断控制器初始化结构体

    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1); // 设置NVIC优先级分组为1

    // 中断线15至10共用一个中断EXTI15_10_IRQn
    NVIC_InitStructure.NVIC_IRQChannel = EXTI15_10_IRQn;      // 配置外部中断15_10，EXTI_Line10 至 EXTI_Line15，其中就有EXTI_Line15
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1; // 占先式优先级设为1
    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;        // 副优先级设置为0
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;           // 中断使能
    NVIC_Init(&NVIC_InitStructure);                           // 中断初始化

    NVIC_InitStructure.NVIC_IRQChannel = EXTI3_IRQn;          // 配置外部中断3
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0; // 占先式优先级设为0
    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;        // 副优先级设置为0
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;           // 中断使能
    NVIC_Init(&NVIC_InitStructure);                           // 中断初始化
}

// 外部中断服务函数实现
void EXTI15_10_IRQHandler(void)
{
    if (EXTI_GetFlagStatus(EXTI_Line15) != RESET) // 判断是否置位
    {
        u8 i;                   // 用于循环计数
        for (i = 0; i < 6; i++) // 循环6次
        {
            GPIO_Write(GPIOA, 0xF0); // 将GPIOA的高4位设置为高电平，低4位保持不变，二进制为 1111 0000
            Delay_MS(500);
            GPIO_Write(GPIOA, 0x0F); // 将GPIOA的低4位设置为高电平，高4位保持不变，二进制为 0000 1111
            Delay_MS(500);
        }
    }

    EXTI_ClearFlag(EXTI_Line15); // 清除Line15标志位
}

// 外部中断服务函数实现
void EXTI3_IRQHandler(void)
{
    if (EXTI_GetFlagStatus(EXTI_Line3) != RESET) // 判断是否置位
    {
        u8 i;                   // 用于循环计数
        for (i = 0; i < 8; i++) // 循环8次
        {
            GPIO_Write(GPIOA, 0x00); // 将GPIOA的所有位设置为低电平，全灭，二进制为 0000 0000
            Delay_MS(500);
            GPIO_Write(GPIOA, 0xFF); // 将GPIOA的所有位设置为高电平，即全亮，二进制为 1111 1111
            Delay_MS(500);
        }
    }

    EXTI_ClearFlag(EXTI_Line3); // 清除Line3标志位
}