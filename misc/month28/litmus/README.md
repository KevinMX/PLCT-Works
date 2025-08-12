# RISC-V architecture concurrency model litmus tests

Repo: https://github.com/litmus-tests/litmus-tests-riscv

```shell
sudo apt update; sudo apt install -y git bc opam make gcc
git clone https://github.com/litmus-tests/litmus-tests-riscv
opam init; opam install herdtools7
eval $(opam env)
cd litmus-tests-riscv
make run-hw-tests CORES=$(nproc)
make merge-hw-tests
make compare-hw-flat
make compare-hw-herd
```
