#include"sys_inc.h"

#include"stm32f10x_it.h"
#include"stm32f10x_conf.h"
#define time 0x50000

uint32_t nCount;
int main()
{
	
	GPIO_InitTypeDef gpioInit;
	
	gpioInit.GPIO_Pin = GPIO_Pin_13;
	gpioInit.GPIO_Speed = GPIO_Speed_10MHz;
	gpioInit.GPIO_Mode = GPIO_Mode_Out_OD;

	RCC_APB2PeriphClockCmd(RCC_APB2Periph_GPIOC,ENABLE);
	GPIO_Init(GPIOC,&gpioInit);

	
	while(1)
	{
		GPIO_ResetBits(GPIOC,0x2000);
	//	GPIO_Write(GPIOC,0x1000);
		for(nCount = time;nCount != 0x0;nCount--);
		GPIO_SetBits(GPIOC,0x2000);
	//	GPIO_Write(GPIOC,0x0000);
		for(nCount = time;nCount != 0x0;nCount--);
	}
	




}

