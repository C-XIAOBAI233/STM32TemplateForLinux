# STM32TemplateForLinux

##简介
  这是一个stm32的project模板.仅在树莓派4b上测试过，用的是stm32f103c6的芯片.
  以普遍理性而言所有的linux环境都可使用.
  
##使用方法
  在stm32template目录中
    $ make
      以编译程序，并生成hex，bin文件
    $ make clean
      删除编译*.o文件
    $ make update
      烧录hex文件到/dev/ttyUSB0,此处使用stm32flash程序下载，
      若用其它方式请自行更改Makefile
  
##文件结构
  .
  ├── LIB
  │   ├── CORE
  │   └── STDPERI
  ├── Makefile
  ├── startup_stm32f10x_ld.s
  ├── stm32_flash.ld
  ├── SYS
  └── USER
  
  LIB:用于存储内核(CORE)与标准外设库(STDPERI)文件
      此处仅含有标准外设库(3.6.0版本)的GPIO与RCC以便测试，
      其他的库文件请自行添加
      
  Makefile:makefile
           TODO: 添加设置的说明
  startup_stm32f10x_ld.s & stm32_flash.ld:
      stm32的启动程序与链接脚本
      
  SYS:包含system_stm32f10x.h/c stm32f10x.h
      一般不用动
      
  USER:用户文件
      用于存放自己的代码.此处有一个PC13开漏输出的led测试程序
      
