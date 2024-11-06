/*Include---------------------------*/
#include"stm32f10x.h"		//包含所有的头文件
#include<stdio.h>

//----------------函数声明--------------------
void Delay_MS(u16 dly);
void RCC_Configuration(void);
void GPIO_Configuration(void);


/*******************************************************************************
* Function Name  : main
* Description    : Main program.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/ 

  int  main(void)
{ 
  u8 K8, K9; 

//  GPIOA->CRL=0x01;	//A0为推挽输出模式、最大速度为10MHz 
//  GPIOA->CRH=0x04;  //A8为浮空输入模式
//  while(1)
//  {
//    if((GPIOA->IDR&0x0100)==0x0100)
//    GPIOA->ODR=0x01;
//	else
//	GPIOA->ODR=0x00;
//}
 RCC_Configuration();
 GPIO_Configuration();
 while(1)
 { 
   K8 = GPIO_ReadInputDataBit(GPIOA, GPIO_Pin_8);
   K9 = GPIO_ReadInputDataBit(GPIOA, GPIO_Pin_9);

   if ((K9==0)&(K8==0)) GPIO_ResetBits(GPIOA , GPIO_Pin_0);         
   else                GPIO_SetBits(GPIOA, GPIO_Pin_0);	
   if ((K9==0)&(K8==1)) GPIO_ResetBits(GPIOA , GPIO_Pin_1);         
   else                GPIO_SetBits(GPIOA, GPIO_Pin_1);
   if ((K9==1)&(K8==0)) GPIO_ResetBits(GPIOA , GPIO_Pin_2);         
   else                GPIO_SetBits(GPIOA, GPIO_Pin_2);
   if ((K9==1)&(K8==1))GPIO_ResetBits(GPIOA , GPIO_Pin_3);         
   else                GPIO_SetBits(GPIOA, GPIO_Pin_3);
 }

}

/*******************************************************************************
* Function Name  : Delay_Ms
* Description    : delay 1 ms.
* Input          : dly (ms)
* Output         : None
* Return         : None
*******************************************************************************/
void Delay_MS(u16 dly)
{
	u16 i,j;
	for(i=0;i<dly;i++)
		for(j=1000;j>0;j--);
}

/*******************************************************************************
* Function Name  : RCC_Configuration
* Description    : Configures the different system clocks.
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
void RCC_Configuration(void)
{
	//----------使用外部RC晶振-----------
	RCC_DeInit();			//初始化为缺省值
	RCC_HSEConfig(RCC_HSE_ON);	//使能外部的高速时钟 
	while(RCC_GetFlagStatus(RCC_FLAG_HSERDY) == RESET);	//等待外部高速时钟使能就绪
	
	FLASH_PrefetchBufferCmd(FLASH_PrefetchBuffer_Enable);	//Enable Prefetch Buffer
	FLASH_SetLatency(FLASH_Latency_2);		//Flash 2 wait state
	
	RCC_HCLKConfig(RCC_SYSCLK_Div1);		//HCLK = SYSCLK
	RCC_PCLK2Config(RCC_HCLK_Div1);			//PCLK2 =  HCLK
	RCC_PCLK1Config(RCC_HCLK_Div2);			//PCLK1 = HCLK/2
	RCC_PLLConfig(RCC_PLLSource_HSE_Div1,RCC_PLLMul_9);	//PLLCLK = 8MHZ * 9 =72MHZ
	RCC_PLLCmd(ENABLE);			//Enable PLLCLK

	while(RCC_GetFlagStatus(RCC_FLAG_PLLRDY) == RESET);	//Wait till PLLCLK is ready
    RCC_SYSCLKConfig(RCC_SYSCLKSource_PLLCLK);	//Select PLL as system clock
	while(RCC_GetSYSCLKSource()!=0x08);		//Wait till PLL is used as system clock source
	
	//---------打开相应外设时钟--------------------
	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOA,ENABLE);	//使能APB2外设的GPIOA的时钟	
	//RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOC,ENABLE);	//使能APB2外设的GPIOC的时钟		 
}

/*******************************************************************************
* Function Name  : GPIO_Configuration
* Description    : 初始化GPIO外设
* Input          : None
* Output         : None
* Return         : None
*******************************************************************************/
//void GPIO_Configuration(void)
//{
//	GPIO_InitTypeDef	GPIO;		//声明一个结构体变量
//	GPIO.GPIO_Pin = GPIO_Pin_0; 	//选择PX.3
//	GPIO.GPIO_Speed = GPIO_Speed_10MHz;	 //管脚频率为50MHZ
//	GPIO.GPIO_Mode = GPIO_Mode_Out_PP;	 //输出模式为推挽输出
//	GPIO_Init(GPIOA,&GPIO);				 //初始化GPIOA寄存器
//
//	GPIO.GPIO_Pin = GPIO_Pin_8;
//	GPIO.GPIO_Mode = GPIO_Mode_In_F;	 //输出模式为推挽输出
//	GPIO_Init(GPIOA,&GPIO);				 //初始化GPIOA寄存器	
//} 

  void GPIO_Configuration(void)
{
  	GPIO_InitTypeDef GPIO;
 
  	/* 设置PA0口为推挽输出，最大翻转频率为50MHz*/
  	GPIO.GPIO_Pin = GPIO_Pin_0|GPIO_Pin_1|GPIO_Pin_2|GPIO_Pin_3;
  	GPIO.GPIO_Speed = GPIO_Speed_50MHz;
  	GPIO.GPIO_Mode = GPIO_Mode_Out_PP;
  	GPIO_Init(GPIOA , &GPIO);
 
  	/* 设置PA8为浮空输入*/
  	GPIO.GPIO_Pin = GPIO_Pin_8|GPIO_Pin_9;
  	GPIO.GPIO_Mode = GPIO_Mode_IN_FLOATING; 
  	GPIO_Init(GPIOA , &GPIO);
    
}
