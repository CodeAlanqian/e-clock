![img](.\md_pic\wps1.png)

 

![img](.\md_pic\wps2.png) 

 



专业：__通信工程__  学号：____姓名：__龚易乾___指导老师：____

 

电子与信息工程学院

2023年2月

有任何疑问可以联系邮箱：codealan@qq.com

# 综合设计实验

## 实验目的

熟练掌握Quartus等EDA设计与仿真工具，掌握多路选择器、N进制计数器、显示译码电路、开关电路、按键等电路的设计和调试方法。加深对《数字电子技术基础》课程内容的理解，逐步提高电路应用能力、设计能力、分析评价能力。

## 实验任务

设计一个多功能数字钟，要求如下：

1、准确计时，以数字形式显示时、分、秒；

2、12/24小时切换功能；

3、时、分、秒的校时功能；

4、秒表功能，显示分、秒、百分之一秒，暂停、复位功能；

5、时钟与秒表切换。

## 准备工作

1、了解FPGA开发板的资源。FPGA开发板上含有6位数码管，8个按键、8个LED灯

 

![img](.\md_pic\wps3.jpg) 

数码管

![img](.\md_pic\wps4.jpg) 

每位数码管的8段字符

 分析电路图可知：数码管有6位片选信号和8位段选信号，因此要搭建片选扫描电路，利用视觉暂留现象，驱动数码管显示。共阳电路，采用7474译码器。7447的主要功能是输出低电平驱动的显示码，用以推动共阳极7段LED 数码管显示相应的数字。

![img](.\md_pic\wps5.jpg)

![img](.\md_pic\wps6.jpg) 

按键                             LED灯

按键未按下时为高电平，按下时为低电平          LED灯为低电平使能，共阳电路

 

2、预想功能表

按键未按下时LED均不亮，按下某按键后，对应的LED点亮。默认为不亮

| 按键 | 未按下（1） | 按下（0） | 功能              |
| ---- | ----------- | --------- | ----------------- |
| BUT1 | 24小时制    | 12小时制  | 切换12/24小时     |
| BUT2 | 停止校时    | 时校时    | 时针校时          |
| BUT3 | 停止校时    | 分校时    | 分针校时          |
| BUT4 | 停止校时    | 秒校时    | 秒针校时          |
| BUT5 | 时钟        | 秒表      | 切换时钟/秒表模式 |
| BUT6 | 秒表暂停    | 秒表计时  | 秒表暂停/计时     |
| BUT7 | 无          | 秒表复位  | 秒表复位          |
| BUT8 | 无          | 无        | 无                |

 

 

3、电路框图

![img](.\md_pic\wps7.jpg) 

 

 

## 设计原理、电路图与仿真

考虑到电路图会比较复杂，所以我基本使用总线的接线方法去画图

 

 

**1、先搭建基本的分频器**

 

100进制计数器（两个74160）、25进制计数器、2进制计数器

![img](.\md_pic\wps8.jpg) 

100进制

![img](.\md_pic\wps9.jpg) 

25进制

![img](.\md_pic\wps10.jpg) 

利用D触发器搭建T’触发器构成2进制计数器

 

 

**2、搭建信号发生器**

原始输入时钟信号为50MHz，利用计数器分频

 

![img](.\md_pic\wps11.jpg) 

1Hz信号50M/（100*100*100*25*2）     用于产生秒信号

 

![img](.\md_pic\wps12.jpg) 

2Hz信号   用于产生校时信号

 

![img](.\md_pic\wps13.jpg) 

100Hz信号 50M/（100*100*25*2）

用于按键扫描频率和产生秒表信号

 

![img](.\md_pic\wps14.jpg) 

1250Hz  用于数码管片选扫描

 

**3、时钟**

**秒针计时**

![img](.\md_pic\wps15.jpg) 

输入信号：1Hz时钟信号，RD复位信号

输出信号： 秒信号高位（SH[3..0]）显示到第5位数码管

秒信号低位(SL[3..0])  显示到第6位数码管

SC为秒针进位信号

 

![img](.\md_pic\wps16.jpg) 

分针计时器仿真结果

 

 

 

**分针计时**

![img](.\md_pic\wps17.jpg) 

输入信号： 秒针计时器进位信号，RD复位信号

输出信号： 分信号高位（MH[3..0]）显示到第3位数码管

分信号低位(ML[3..0])  显示到第4位数码管

MC为分针进位信号

 

![img](.\md_pic\wps18.jpg) 

分钟计时器仿真结果

 

 

 

 

**24进制时钟**

![img](.\md_pic\wps19.jpg) 

输入信号：分针计时器进位信号，RD复位信号

输出信号： 时信号高位（HH[3..0]）显示到第1位数码管

时信号低位(HL[3..0])  显示到第2位数码管

HC为时针进位信号

![img](.\md_pic\wps20.jpg) 

24进制时针计时器仿真结果

**12进制时钟**

![img](.\md_pic\wps21.jpg) 

输入信号：分针计时器进位信号，RD复位信号

输出信号： 时信号高位（HH[3..0]）显示到第1位数码管

时信号低位(HL[3..0])  显示到第2位数码管

HC为时针进位信号

 

![img](.\md_pic\wps22.jpg) 

12进制时针计时器仿真结果

 

**4、秒表**

**分秒信号（100Hz）**

![img](.\md_pic\wps23.jpg) 

 

 

**5、按键读取电路**

![img](.\md_pic\wps24.jpg) 

消抖：以100Hz的频率扫描端口，如果0.03ms内采样结果均相同，则认为按下/松开按键，并保存到由JK触发器构成的T'触发器中。

 

![img](.\md_pic\wps25.jpg) 

按键仿真结果

 

**按键扫描电路**

![img](.\md_pic\wps26.jpg) 

将8个按键的扫描结果封装

 

6**、译码显示**

**数码管片选电路（顺序脉冲）**

![img](.\md_pic\wps27.jpg) 

由74161与74138译码模块构成，低电平使能，S为0时，被选中

不断重复扫描，达到连续显示的效果



|      |                                                              |
| ---- | ------------------------------------------------------------ |
|      | ![img](.\md_pic\wps28.jpg) |

 



顺序脉冲仿真结果

 

 

**7447译码器（段选电路）**

![img](.\md_pic\wps29.jpg) 

封装成总线的形式，方便输入输出

 

**7、LED驱动电路**

![img](.\md_pic\wps30.jpg) 

当L为1时，LED点亮

**8、模式转换器**

**二选一模式转换器（用于切换第3-6位数码管的时钟、秒表显示）**

![img](.\md_pic\wps31.jpg) 

K为输入信号，当K为1时，H24输出，当K为0时，H12输出

 

**三选一模式转换器（用于切换第1、2位数码管的12/24进制、秒表显示）**

 

![img](.\md_pic\wps32.jpg) 

由4片74153芯片构成（每片都只使用了一个4选1数据选择器）

当K0=K4等于1时，输出H24；当K4=1，K0=0时，输出H12

其他情况均输出M60

**显示片选**

![img](.\md_pic\wps33.jpg) 

 

**总电路：**



|      |                                                              |
| ---- | ------------------------------------------------------------ |
|      | ![img](.\md_pic\wps34.jpg) |

 





|      |                                                              |
| ---- | ------------------------------------------------------------ |
|      | ![img](.\md_pic\wps35.jpg) |

 



 



|      |                                                              |
| ---- | ------------------------------------------------------------ |
|      | ![img](.\md_pic\wps36.jpg) |

 



 

 

 

 

 



|      |                                                              |
| ---- | ------------------------------------------------------------ |
|      | ![img](.\md_pic\wps37.jpg) |

![img](.\md_pic\wps38.jpg)

 





|      |                                                              |
| ---- | ------------------------------------------------------------ |
|      | ![img](.\md_pic\wps39.jpg) |

 



 

 

![img](.\md_pic\wps40.jpg) 

 

 

## 调试、结论

设置引脚、编译、下载至FPGA开发板。测试结果符合预期。

## 实验过程的问题与思考

问题：

1、设计【12翻1】计时器时，从0开始或从13结束，解决方法：预置数为1，计数到12时复位；

2、Modelsim无法仿真，没有正确设置路径；

3、7447译码器6和9显示不全，最后发现是该译码器的特性，使用7448译码器更好；

4、做12/24进制时钟切换时没有考虑到秒表，只做了二选一模块，后来做四选一模块得以解决，实现12/24/秒表切换

5、有时时钟的频率不对，先不用管，后来随着新功能的加入便正常了；

6、刚开始时考虑不周，模块化低。

 

 

心得体会：

Quartus是一个十分重要的工具，它可以帮助我们完成诸如逻辑电路设计、仿真、验证、综合等一系列任务，提高了我们的设计效率和精度。

1、设计前的准备十分重要。在进行设计前，需要对所要设计的电路进行充分的思考和分析，确定各个模块的功能、输入输出等信息，为后续的设计奠定基础。

2、画电路图时需要仔细。注意电路的正确性和逻辑的完整性，以避免在后续的仿真和验证过程中出现问题。

3、仿真和验证非常重要。在完成设计后，需要进行仿真和验证，以检验电路的正确性和稳定性。通过仿真和验证可以发现并修正电路中的问题，提高电路的可靠性和鲁棒性。

4、熟练掌握Quartus的使用技巧可以提高设计的效率和精度。

5、这是一个较大的设计实验，能顺利完成我很有成就感。

6、采用模块化设计，结构清晰，便于画图、修改与阅读。在设计过程中，加深了我对《数字电子技术基础》课程内容的理解，逐步提高电路应用能力、设计能力、分析评价能力。

 

七、 参考文献

[1]《数字电子技术基础（第5版）》

[2]《EDA设计 基于Quartus的多功能数字时钟设计》

 

 

 

【后记】
验收时发现24小时制的12时在12小时制应该为12时，不该为0时
学长只能帮你们到这了

 