// #include"stm32f10x.h"
// #include<stdio.h>

// void Delay_MS(u16 dly);

// int main() {
// 	u16 i;

// 	// 1. 使能GPIOA时钟
// 	RCC->APB2ENR = 0x0004;

// 	// 2. 配置GPIOA的模式
// 	GPIOA->CRL = 0x33333333;

// 	while(1) {

// 		// 3. 循环点亮每个LED灯，使用就打开 /**/ 注释，不用就注释上
// 		/*
// 		for (i = 0; i < 8; i++) {
// 			GPIOA->BSRR = 0x01 << i;
// 			Delay_MS(500);
// 			GPIOA->BRR = 0x01 << i;
// 			Delay_MS(500);
// 		}
// 		*/

// 		// 4. 循环显示 A0 - A3亮, A4 - A7灭 A0 - A3灭, A4 - A7亮，使用就打开 /**/ 注释，不用就注释上
// 		 GPIOA->BSRR = 0x0000000F; // 点亮A0-A3
//      Delay_MS(500);            // 延时
//      GPIOA->BRR = 0x0000000F;  // 熄灭A0-A3
//      Delay_MS(500);            // 延时
//      GPIOA->BSRR = 0x000000F0; // 点亮A4-A7
//      Delay_MS(500);            // 延时
//      GPIOA->BRR = 0x000000F0;  // 熄灭A4-A7
// 		 Delay_MS(500);            // 延时
// 	}
// }

// void Delay_MS(u16 dly) {
// 	u16 i, j;
// 	for (i = 0; i < dly; i++) {
// 		for (j = 1000; j > 0; j--) ;
// 	}
// }