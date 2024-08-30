# golang SIGSEGV in preemptone reproduce

```shell
wget https://go.dev/dl/go1.23.0.linux-riscv64.tar.gz
tar -xf go1.23.0.linux-riscv64.tar.gz
export PATH=$(pwd)/go/bin:$PATH
git clone https://github.com/golang/tools.git
cd tools
git checkout c1241b9c5
go mod download
cd gopls/doc/
go mod download
cd -
go test ./... 2>&1 | tee t.log
```

Currently: test passed on Milk-V Pioneer v1.3 / RevyOS (1 pass)