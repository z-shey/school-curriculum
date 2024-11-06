#include "stm32f10x_gpio.h"
#include "stm32f10x_exti.h"
#include <stdio.h>

void Delay_MS(u16 dly);
void GPIO_Configuration(void);
void EXTI_Configuration(void);
void NVIC_Configuration(void);

int main(void)
{
    u8 i;

    // 使能GPIOA、GPIOB和复用功能时钟
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE);
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOB, ENABLE);
    RCC_APB2PeriphClockCmd(RCC_APB2Periph_AFIO, ENABLE);

    GPIO_Configuration();
    EXTI_Configuration();
    NVIC_Configuration();

    // 主循环
    while (1)
    {
        for (i = 0; i < 8; i++)
        {
            GPIO_Write(GPIOA, ~(0x01 << i)); 
            Delay_MS(500);
        }
    }
}

void Delay_MS(u16 dly)
{
    u16 i, j;
    for (i = 0; i < dly; i++)
        for (j = 1000; j > 0; j--)
            ;
}

void GPIO_Configuration(void)
{
    GPIO_InitTypeDef GPIO_InitStructure;

    // 配置PA0-PA7为推挽输出模式，速度为50MHz
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0 | GPIO_Pin_1 | GPIO_Pin_2 | GPIO_Pin_3 | GPIO_Pin_4 | GPIO_Pin_5 | GPIO_Pin_6 | GPIO_Pin_7;
    GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
    GPIO_Init(GPIOA, &GPIO_InitStructure);

    // 配置PB8为下拉输入模式，PB0为上拉输入模式
    GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8 | GPIO_Pin_0;
    GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IPU;
    GPIO_Init(GPIOB, &GPIO_InitStructure);
}

void EXTI_Configuration(void)
{
    EXTI_InitTypeDef EXTI_InitStructure;

    // 配置PB8为下拉输入模式，PB0为上拉输入模式
    GPIO_EXTILineConfig(GPIO_PortSourceGPIOB, GPIO_PinSource8);
    GPIO_EXTILineConfig(GPIO_PortSourceGPIOB, GPIO_PinSource0);

    // 配置EXTI8（PB8）为中断模式，下降沿触发，并使能
    EXTI_InitStructure.EXTI_Line = EXTI_Line8;
    EXTI_InitStructure.EXTI_Mode = EXTI_Mode_Interrupt;
    EXTI_InitStructure.EXTI_Trigger = EXTI_Trigger_Falling;
    EXTI_InitStructure.EXTI_LineCmd = ENABLE;
    EXTI_Init(&EXTI_InitStructure);

    // 配置EXTI0（PB0）为中断模式
    EXTI_InitStructure.EXTI_Line = EXTI_Line0;
    EXTI_Init(&EXTI_InitStructure);
}

// 中断优先级配置函数
void NVIC_Configuration(void)
{
    NVIC_InitTypeDef NVIC_InitStructure;

    NVIC_PriorityGroupConfig(NVIC_PriorityGroup_1);
    NVIC_InitStructure.NVIC_IRQChannel = EXTI9_5_IRQn;
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 1;
    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 0;
    NVIC_InitStructure.NVIC_IRQChannelCmd = ENABLE;
    NVIC_Init(&NVIC_InitStructure);

    NVIC_InitStructure.NVIC_IRQChannel = EXTI0_IRQn; // 配置EXTI0中断通道
    NVIC_InitStructure.NVIC_IRQChannelPreemptionPriority = 0;
    NVIC_InitStructure.NVIC_IRQChannelSubPriority = 1;
    NVIC_Init(&NVIC_InitStructure);
}

void EXTI9_5_IRQHandler(void)
{
    if (EXTI_GetFlagStatus(EXTI_Line8) != RESET)
    {
        // 翻转GPIOA的低四位和高四位6次
        u8 i;
        for (i = 0; i < 6; i++)
        {
            GPIO_Write(GPIOA, ~(0x0F)); // 翻转低四位
            Delay_MS(500);
            GPIO_Write(GPIOA, ~(0xF0)); // 翻转高四位
            Delay_MS(500);
        }
    }
    EXTI_ClearFlag(EXTI_Line8); // 清除EXTI8中断标志
}

void EXTI0_IRQHandler(void)
{
    if (EXTI_GetFlagStatus(EXTI_Line0) != RESET)
    {
        // 翻转GPIOA所有位4次
        u8 i;
        for (i = 0; i < 4; i++)
        {
            GPIO_Write(GPIOA, 0x00); // 所有位低
            Delay_MS(500);
            GPIO_Write(GPIOA, 0xFF); // 所有位高
            Delay_MS(500);
        }
    }
    EXTI_ClearFlag(EXTI_Line0); // 清除EXTI0中断标志
}