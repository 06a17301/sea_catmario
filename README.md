# sea_catmario
a game flow on SEA using Vivado 

 ‘HDMI_display.v'——例化所有子模块（顶层模块）
 ‘Driver_HDMI.v'——HDMI显示驱动
 ‘key2move.v’——用于猫里奥的按键控制、行为判断以及地图、胜负的信息存储
 ‘video.v’——用于对猫里奥以及地图图像的视频输出
 ‘state.v’——主状态机（游戏各个状态的转换）
 ‘monster.v’——用于小怪兽的位置信息存储及显示的使能信号判断

  运行的配置环境：Vivado 2018.3版
