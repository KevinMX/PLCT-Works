# 在 D1 上运行 Core-V-MCU BSP

### 需要准备的依赖项

1. 一台运行 Ubuntu 的 x86_64 PC，虚拟机/WSL 亦可，用于编译 bsp 本体。如使用笔者提供的 bsp elf 二进制，可忽略此项。
2. 一块采用了 D1 SoC 的开发板（如荔枝派 RV / 哪吒 D1），并在上面安装 openEuler RISC-V 23.03 preview。

> 理论上其他采用 RV64 SoC 且运行 openEuler RISC-V 的开发板也通用。

### 编译 BSP

> Note: 可直接下载笔者编译好的 BSP 二进制，跳过编译部分。文件位于本目录下，见[此处](./rtthread.elf)。

> sha256sum: 37022bfc82187beb9647b91b4f39295affecf74763472243b672541762df27a1

此部分在 `Ubuntu 23.04 x86_64` 下进行。

1. 新建一个工作目录，比如：`mkdir rt-thread && cd rt-thread`

2. 安装 `unzip` 和 `git`：

`sudo apt install -y unzip git`

3. 下载并解压 rv32 工具链。

```bash
wget https://github.com/Yaochenger/openhw-/raw/master/toolchain/gcc_riscv32.zip
unzip gcc_riscv32.zip
```

4. 准备编译环境，执行如下命令：

```bash
wget https://gitee.com/RT-Thread-Mirror/env/raw/master/install_ubuntu.sh
bash install_ubuntu.sh --gitee
```

> Note: Ubuntu 23.04 下可能提示未找到 qemu 软件包，可以忽略这个报错。

5. 下载 RT-Thread 源码。

```bash
git clone --depth=1 https://github.com/RT-Thread/rt-thread
cd rt-thread/bsp/core-v-mcu/core-v-cv32e40p
```

6. 修改 rtconfig.py 中指定的默认 toolchain 路径。

将第 15 行的：
```python
EXEC_PATH   = r'D:\RT-ThreadStudio\repo\Extract\ToolChain_Support_Packages\RISC-V\RISC-V-GCC-RV32\2022-04-12\bin'
```

修改为：
```python
EXEC_PATH   = '~/rt-thread/gcc_riscv32/bin'
```

修改完成后，执行如下命令进行编译：

```bash
source ~/.env/env.sh
scons --exec-path="$HOME/rt-thread/gcc_riscv32/bin"
```

编译结束后会有类似如下输出：

```bash
riscv32-unknown-elf-size rtthread.elf
   text    data     bss     dec     hex filename
  65440   91796   71028  228264   37ba8 rtthread.elf
scons: done building targets.
```

可以看到输出一个 `rtthread.elf`，稍候我们会用到它。

### 编译 QEMU for RV64

> Note: 可直接下载笔者编译好的 QEMU 二进制，跳过较为耗时的编译部分。文件位于本目录下，见[此处](./qemu.tar.zst)。下载后直接 `tar -xf qemu.tar.zst` 解压即可。需要安装 `zstd`。

> 注意，仍需按照第一步安装相关依赖库。

> sha256sum: d11ce6ebe893ff3def0d42ea3df4640d0e13ac9ff16e1c749ef33f71a2fb3c2c

Core-V-MCU 目前需要使用 QEMU 进行模拟，相关支持暂未合入 QEMU 主线，需要使用 PLCT Lab 提供的 QEMU 源码进行编译。

本部分在开发板上进行。

1. 安装依赖包

```bash
sudo dnf install -y git glib2-devel libfdt-devel pixman-devel zlib-devel bzip2 ninja-build python3 \
                    libaio-devel libcap-ng-devel libiscsi-devel capstone-devel \
                    gtk3-devel vte291-devel ncurses-devel \
                    libseccomp-devel nettle-devel libattr-devel libjpeg-devel \
                    brlapi-devel libgcrypt-devel lzo-devel snappy-devel \
                    librdmacm-devel libibverbs-devel cyrus-sasl-devel libpng-devel \
                    libuuid-devel pulseaudio-libs-devel curl-devel libssh-devel \
                    systemtap-sdt-devel libusbx-devel
```

2. 拉取源码：

```bash
git clone https://github.com/plctlab/plct-qemu --depth=1 -b plct-corev-upstream-sync-dma
cd plct-qemu
```

3. 使用 oErv 23.03 / GCC 10.3.1 进行编译时，直接编译会出现报错，需要修改两处源码。

`net/dump.c` 第 89 行：

```C
if (writev(s->fd, dumpiov, cnt + 1) != sizeof(hdr) + caplen) {
```

修改为：
```C
if (writev(s->fd, &dumpiov[0], cnt + 1) != sizeof(hdr) + caplen) {
```

`include/qemu/int128.h` 第 183 行：

```C
#if __has_builtin(__builtin_bswap128)
```

修改为：

```C
#if 0
```

4. 配置并编译 QEMU（只编译需要的 riscv32 部分以节省时间）：

```bash
mkdir build && cd build
../configure --target-list=riscv32-softmmu
make -j$(nproc)
```

编译完成后，应当能够在当前目录下看到 `qemu-system-riscv32` 二进制。

5. 将先前编译好的 `rtthread.elf` 文件复制到 `qemu-system-riscv32` 同一目录下，执行：

```bash
./qemu-system-riscv32 -M core_v_mcu -bios none -kernel rtthread.elf -nographic -monitor none -serial stdio
```

按 `Tab` 可查看支持的指令。

运行输出如下：

```bash
[openeuler@openeuler-riscv64 build]$ ./qemu-system-riscv32 -M core_v_mcu -bios none -kernel rtthread.elf -nographic -monitor none -serial stdio

 \ | /
- RT -     Thread Operating System
 / | \     5.0.1 build May 15 2023 20:06:28
 2006 - 2022 Copyright by RT-Thread team
Hello RT-Thread!
msh >
RT-Thread shell commands:
pin              - pin [option]
clear            - clear the terminal screen
version          - show RT-Thread version information
list             - list objects
help             - RT-Thread shell help.
ps               - List threads in the system.
free             - Show the memory usage in the system.

msh >
```

## 参考资料

[Core-V-MCU BSP 说明](https://github.com/Michaelnlearn/PlctWorking/tree/main/RT-Thread)

[QEMU Wiki](https://wiki.qemu.org/Hosts/Linux)

[aarch64:qemu6.2.0 compile error](https://gitlab.com/qemu-project/qemu/-/issues/1064)

[lore.kernel.org](https://lore.kernel.org/all/20220109205748.4127032-1-philipp.tomsich@vrull.eu/)