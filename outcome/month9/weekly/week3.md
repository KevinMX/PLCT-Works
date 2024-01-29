## week 3

2024.01.22 ~ 2024.01.26

### 本周工作

RuyiSDK / 开发板操作系统支持情况调研

- BeagleV Fire
    - 官方仅支持 Ubuntu：https://www.beagleboard.org/distros/beaglev-fire-ubuntu-2023-11-21
    - Zephyr：https://docs.zephyrproject.org/latest/boards/riscv/beaglev_fire/doc/index.html
- ESP32C3 LUATOS CORE
    - 与其他 ESP32-C3 开发板支持基本一致
    - LiteOS: https://gitee.com/LiteOS/LiteOS/tree/master/targets/ESP32
    - FreeRTOS: https://docs.espressif.com/projects/esp-idf/zh_CN/latest/esp32c3/api-reference/system/freertos_idf.html
    - RT-Thread: https://github.com/RT-Thread/rt-thread/tree/master/bsp/ESP32_C3
    - Zephyr: https://docs.zephyrproject.org/latest/boards/riscv/esp32c3_luatos_core/doc/index.html
- SiFive HiFive 1 & Rev B（两个版本硬件并不完全相同，需要测试兼容性）
    - LiteOS (for Rev B): https://gitee.com/LiteOS/LiteOS/tree/master/targets/HiFive1_Rev1_B01
    - FreeRTOS (for Rev B)：https://www.freertos.org/zh-cn-cmn-s/Using-FreeRTOS-on-RISC-V.html
    - RT-Thread (for HiFive 1)：https://github.com/RT-Thread/rt-thread/tree/master/bsp/hifive1
    - Zephyr
        - HiFive 1: https://github.com/RT-Thread/rt-thread/tree/master/bsp/hifive1
        - HiFive 1 Rev B: https://docs.zephyrproject.org/latest/boards/riscv/hifive1_revb/doc/index.html

SG2042 / Milk-V Pioneer InferGLM / ChatGLM 测试

- InferLLM 带 Vector 加速
[![asciicast](/misc/month9/InferLLM/inferllm.gif)](https://asciinema.org/a/G08ElLBG1BNBLCdJFSz0Nfp3I)

- ChatGLM.cpp 不带 Vector 加速：
![ChatGLM.cpp No Vector](/misc/month9/InferLLM/chatglm.png)

产出文档 [InferLLM on Milk-V Pioneer](/misc/month9/InferLLM/README.md)