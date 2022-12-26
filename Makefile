TARGET = main

STR_UP=startup_stm32f10x_ld
STR_UP_S=$(STR_UP).s
STR_UP_O=$(STR_UP).o
STM_TYPE_DEF=STM32F10X_LD
LSCRIPT=stm32_flash.ld

export CC             = arm-none-eabi-gcc           
export AS             = arm-none-eabi-as
export LD             = arm-none-eabi-ld
export OBJCOPY        = arm-none-eabi-objcopy

INC_FLAGS= -I ./LIB/CORE -I ./LIB/STDPERI/INC -I ./SYS -I ./USER 

CFLAGS =  -W -Wall -g -mcpu=cortex-m3 -mthumb -D $(STM_TYPE_DEF) -D USE_STDPERIPH_DRIVER $(INC_FLAGS) -O0 -std=gnu11
C_SRC=$(shell find ./ -name '*.c')  
C_OBJ=$(C_SRC:%.c=%.o)        

.PHONY: all clean update      

all:$(STR_UP_O) $(C_OBJ)
	$(CC) $(STR_UP_O) $(C_OBJ) -T $(LSCRIPT) -o $(TARGET).elf   -mthumb -mcpu=cortex-m3 -Wl,--start-group -lc -lm -Wl,--end-group -specs=nano.specs -specs=nosys.specs -static -Wl,-cref,-u,Reset_Handler -Wl,-Map=Project.map -Wl,--gc-sections -Wl,--defsym=malloc_getpagesize_P=0x80 
	$(OBJCOPY) $(TARGET).elf  $(TARGET).bin -Obinary 
	$(OBJCOPY) $(TARGET).elf  $(TARGET).hex -Oihex

$(C_OBJ):%.o:%.c
	$(CC) -c $(CFLAGS) -o $@ $<
$(STR_UP_O):$(STR_UP_S)
	$(CC) -c -g -Wa,--warn -mthumb -mcpu=cortex-m3 -o $@ $<
clean:
	rm -f $(shell find ./ -name '*.o')
	rm -f $(shell find ./ -name '*.d')
	rm -f $(shell find ./ -name '*.map')
	rm -f $(shell find ./ -name '*.elf')
	rm -f $(shell find ./ -name '*.bin')
	rm -f $(shell find ./ -name '*.hex')

update:
	stm32flash -w main.hex -v -g 0x0 /dev/ttyUSB0
