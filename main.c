#define RCC_BASE 0x40023800U
#define RCC_AHB1ENR (*((unsigned int*)(RCC_BASE + 0x30U)))
#define GPIOC_BASE 0x40020800U
#define GPIOC_DIR (*((unsigned int*)(GPIOC_BASE)))
#define GPIOC_OUT (*((unsigned int*)(GPIOC_BASE + 0x14U)))

int main()
{
    RCC_AHB1ENR |= 1<<2; //enable GPIOC clock
	GPIOC_DIR = 0x04000000; //set pin13 dir as output

    while(1)
    {
        GPIOC_OUT = 0x00000000; 
        for(unsigned int counter=0; counter<0xFFFFF; counter++);
        GPIOC_OUT = 0x00002000;
        for(unsigned int counter=0; counter<0xFFFFF; counter++);
    }
    return 0;
}