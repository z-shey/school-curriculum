// void EXTI0_IRQHandler(void)
// {
//     EXTI9_5_IRQHandler(); // 嵌套EXTI8的处理
// }

/*
#include "stm32f10x.h"
#include <stdio.h>

void GPIO_Configuration()
{
	GPIO_InitTypeDef GPIO_InitStructure;

	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_8 | GPIO_Pin_9;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_IN_FLOATING;
	GPIO_Init(GPIOA, &GPIO_InitStructure);

	GPIO_InitStructure.GPIO_Pin = GPIO_Pin_0 | GPIO_Pin_1 | GPIO_Pin_2 | GPIO_Pin_3;
	GPIO_InitStructure.GPIO_Speed = GPIO_Speed_50MHz;
	GPIO_InitStructure.GPIO_Mode = GPIO_Mode_Out_PP;
	GPIO_Init(GPIOA, &GPIO_InitStructure);
}

int main(void)
{
	u8 K8, K9;

	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA, ENABLE);

	GPIO_Configuration();

	while (1)
	{
		K8 = GPIO_ReadInputDataBit(GPIOA, GPIO_Pin_8);
		K9 = GPIO_ReadInputDataBit(GPIOA, GPIO_Pin_9);

		if ((K9 == 0) & (K8 == 0))
		{
			GPIO_ResetBits(GPIOA, GPIO_Pin_0);
		}
		else
		{
			GPIO_SetBits(GPIOA, GPIO_Pin_0);
		}

		if ((K9 == 0) & (K8 == 1))
		{
			GPIO_ResetBits(GPIOA, GPIO_Pin_1);
		}
		else
		{
			GPIO_SetBits(GPIOA, GPIO_Pin_1);
		}

		if ((K9 == 1) & (K8 == 0))
		{
			GPIO_ResetBits(GPIOA, GPIO_Pin_2);
		}
		else
		{
			GPIO_SetBits(GPIOA, GPIO_Pin_2);
		}

		if ((K9 == 1) & (K8 == 1))
		{
			GPIO_ResetBits(GPIOA, GPIO_Pin_3);
		}
		else
		{
			GPIO_SetBits(GPIOA, GPIO_Pin_3);
		}
	}
}
*/
