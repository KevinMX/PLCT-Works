# month 13

记录本月产出。

## RuyiSDK

### ruyi 包管理器

WCH 仅文档部分开发板 `device provision` 测试正常。

https://asciinema.org/a/xyQ3yttDgMf7p5bfcpDg8Lfzc

缺陷报告：

- `sudo` 调用逻辑变更导致 `fastboot` 无法检测到设备：issue [#39](https://github.com/ruyisdk/ruyi/issues/39) 重开

### 操作系统支持矩阵

新增：

- Milk-V Duo S 
    - [NuttX](https://github.com/ruyisdk/support-matrix/commit/f3c5b10fd95dede2a3718d77609ca8dfce392adc)
        - [新版本重新测试](https://github.com/ruyisdk/support-matrix/commit/80c73da428c7c35018f6d8d277c260a6555dafe4)
    - [BuildRoot](https://github.com/ruyisdk/support-matrix/commit/e7836356d5c90cde83cfdf7baa6ed008b9cf5ba2)
    - [Debian](https://github.com/ruyisdk/support-matrix/commit/e7836356d5c90cde83cfdf7baa6ed008b9cf5ba2)
- Microchip Polarfire SoC FGPA Icicle Kit
    - [Ubuntu](https://github.com/KevinMX/support-matrix/blob/main/Icicle/Ubuntu/README.md)
    - [Yocto/OpenEmbedded](https://github.com/KevinMX/support-matrix/blob/main/Icicle/Yocto/README.md)
    - [BuildRoot](https://github.com/KevinMX/support-matrix/blob/main/Icicle/BuildRoot/README.md)

审核实习生提交的 PR：

https://github.com/KevinMX/support-matrix/pull/11

https://github.com/KevinMX/support-matrix/pull/12

https://github.com/KevinMX/support-matrix/pull/13

https://github.com/KevinMX/support-matrix/pull/14

https://github.com/KevinMX/support-matrix/pull/15

https://github.com/KevinMX/support-matrix/pull/16

https://github.com/KevinMX/support-matrix/pull/17

https://github.com/KevinMX/support-matrix/pull/18

### 其他内容

#### 硬件自动化测试

[SDWireC](https://github.com/Badger-Embedded/badgerd-sdwirec) PCB 重新打板，验证已通过，准备投入使用。

图片见：https://github.com/KevinMX/PLCT-Tarsier-Works/blob/main/outcome/month13/SDWireC_final.png

#### 软件所公众开放日

公众开放日 PPT、Demo 等内容准备。

- [InferLLM](https://github.com/KevinMX/PLCT-Tarsier-Works/tree/main/misc/month9/InferLLM)