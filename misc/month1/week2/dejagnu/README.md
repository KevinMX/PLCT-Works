# 与 openEuler x86_64 对比

统计 `dejagnu` 编译器测试中，非预期失败/FAIL，并且与 openEuler x86_64 不同的部分。

点击标题可跳转到对应的单项错误日志。

### [gcc](./gcc)

| 失败项                                                                                                                                                                                                                           | CMD                                                                | x86 情况     | oErv 重测结果 |
|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------|------------|-----------|
| FAIL: gcc.dg/autoprefetch/get-edge-prob-non-init.c (test for excess errors)                                                                                                                                                   | runtest -v --tool gcc dg.exp=get-edge-prob-non-init.c              | PASS       | FAIL      |
| FAIL: gcc.dg/debug/dwarf2/inline5.c scan-assembler-not \\(DIE \\(0x([0-9a-f]*)\\) DW_TAG_lexical_block\\)[^#/!@;\\|]*[#/!@;\\|]+ +[^(].*DW_TAG_lexical_block\\)[^#/!@;\\|x]*x\\1[^#/!@;\\|]*[#/!@;\\|] +DW_AT_abstract_origin | runtest -v --tool gcc dg.exp=inline5.c                             | PASS       | FAIL      |
| FAIL: c-c++-common/patchable_function_entry-decl.c  -Wc++-compat   scan-assembler-times nop\|NOP 2                                                                                                                             | runtest -v --tool gcc dg.exp=patchable_function_entry-decl.c       | PASS       | FAIL      |
| FAIL: c-c++-common/patchable_function_entry-default.c  -Wc++-compat   scan-assembler-times nop\|NOP 3                                                                                                                          | runtest -v --tool gcc dg.exp=patchable_function_entry-default.c    | PASS       | FAIL      |
| FAIL: c-c++-common/patchable_function_entry-definition.c  -Wc++-compat   scan-assembler-times nop\|NOP 1                                                                                                                       | runtest -v --tool gcc dg.exp=patchable_function_entry-definition.c | PASS       | FAIL      |
| FAIL: c-c++-common/spec-barrier-1.c  -Wc++-compat  (test for excess errors)                                                                                                                                                   | runtest -v --tool gcc dg.exp=spec-barrier-1.c                      | PASS       | FAIL      |
| FAIL: gcc.dg/tree-ssa/phi-opt-22.c scan-tree-dump-not phiopt2 "if"                                                                                                                                                            | runtest -v --tool gcc tree-ssa.exp=phi-opt-22.c                    | UNRESOLVED | FAIL      |
| FAIL: gcc.dg/tree-ssa/phi-opt-22.c scan-tree-dump-times phiopt2 " << " 3                                                                                                                                                      | runtest -v --tool gcc tree-ssa.exp=phi-opt-22.c                    | UNRESOLVED | FAIL      |
| FAIL: gcc.dg/tree-ssa/pr96928-1.c scan-tree-dump-times phiopt2 " = ~" 1                                                                                                                                                       | runtest -v --tool gcc tree-ssa.exp=pr96928-1.c                     | UNRESOLVED | FAIL      |

### [g++](./g++)

| 失败项                                                                                                                  | CMD                                                                | x86 情况 | oErv 重测结果 |
|----------------------------------------------------------------------------------------------------------------------|--------------------------------------------------------------------|--------|-----------|
| FAIL: g++.dg/opt/pr99305.C  -std=gnu++98  scan-tree-dump-times optimized " = \\(unsigned char\\) c_[0-9]*\\(D\\);" 3 | runtest -v --tool g++ dg.exp=pr99305.C                             | PASS   | FAIL      |
| FAIL: g++.dg/opt/pr99305.C  -std=gnu++14  scan-tree-dump-times optimized " = \\(unsigned char\\) c_[0-9]*\\(D\\);" 3 | runtest -v --tool g++ dg.exp=pr99305.C                             | PASS   | FAIL      |
| FAIL: g++.dg/opt/pr99305.C  -std=gnu++17  scan-tree-dump-times optimized " = \\(unsigned char\\) c_[0-9]*\\(D\\);" 3 | runtest -v --tool g++ dg.exp=pr99305.C                             | PASS   | FAIL      |
| FAIL: g++.dg/opt/pr99305.C  -std=gnu++2a  scan-tree-dump-times optimized " = \\(unsigned char\\) c_[0-9]*\\(D\\);" 3 | runtest -v --tool g++ dg.exp=pr99305.C                             | PASS   | FAIL      |
| FAIL: c-c++-common/patchable_function_entry-decl.c  -std=gnu++98  scan-assembler-times nop\|NOP 2                     | runtest -v --tool g++ dg.exp=patchable_function_entry-decl.c       | PASS   | FAIL      |
| FAIL: c-c++-common/patchable_function_entry-decl.c  -std=gnu++14  scan-assembler-times nop\|NOP 2                     | runtest -v --tool g++ dg.exp=patchable_function_entry-decl.c       | PASS   | FAIL      |
| FAIL: c-c++-common/patchable_function_entry-decl.c  -std=gnu++17  scan-assembler-times nop\|NOP 2                     | runtest -v --tool g++ dg.exp=patchable_function_entry-decl.c       | PASS   | FAIL      |
| FAIL: c-c++-common/patchable_function_entry-decl.c  -std=gnu++2a  scan-assembler-times nop\|NOP 2                     | runtest -v --tool g++ dg.exp=patchable_function_entry-decl.c       | PASS   | FAIL      |
| FAIL: c-c++-common/patchable_function_entry-default.c  -std=gnu++98  scan-assembler-times nop\|NOP 3                  | runtest -v --tool g++ dg.exp=patchable_function_entry-default.c    | PASS   | FAIL      |
| FAIL: c-c++-common/patchable_function_entry-default.c  -std=gnu++14  scan-assembler-times nop\|NOP 3                  | runtest -v --tool g++ dg.exp=patchable_function_entry-default.c    | PASS   | FAIL      |
| FAIL: c-c++-common/patchable_function_entry-default.c  -std=gnu++17  scan-assembler-times nop\|NOP 3                  | runtest -v --tool g++ dg.exp=patchable_function_entry-default.c    | PASS   | FAIL      |
| FAIL: c-c++-common/patchable_function_entry-default.c  -std=gnu++2a  scan-assembler-times nop\|NOP 3                  | runtest -v --tool g++ dg.exp=patchable_function_entry-default.c    | PASS   | FAIL      |
| FAIL: c-c++-common/patchable_function_entry-definition.c  -std=gnu++98  scan-assembler-times nop\|NOP 1               | runtest -v --tool g++ dg.exp=patchable_function_entry-definition.c | PASS   | FAIL      |
| FAIL: c-c++-common/patchable_function_entry-definition.c  -std=gnu++14  scan-assembler-times nop\|NOP 1               | runtest -v --tool g++ dg.exp=patchable_function_entry-definition.c | PASS   | FAIL      |
| FAIL: c-c++-common/patchable_function_entry-definition.c  -std=gnu++17  scan-assembler-times nop\|NOP 1               | runtest -v --tool g++ dg.exp=patchable_function_entry-definition.c | PASS   | FAIL      |
| FAIL: c-c++-common/patchable_function_entry-definition.c  -std=gnu++2a  scan-assembler-times nop\|NOP 1               | runtest -v --tool g++ dg.exp=patchable_function_entry-definition.c | PASS   | FAIL      |
| FAIL: c-c++-common/spec-barrier-1.c  -std=gnu++98 (test for excess errors)                                           | runtest -v --tool g++ dg.exp=spec-barrier-1.c                      | PASS   | FAIL      |
| FAIL: c-c++-common/spec-barrier-1.c  -std=gnu++14 (test for excess errors)                                           | runtest -v --tool g++ dg.exp=spec-barrier-1.c                      | PASS   | FAIL      |
| FAIL: c-c++-common/spec-barrier-1.c  -std=gnu++17 (test for excess errors)                                           | runtest -v --tool g++ dg.exp=spec-barrier-1.c                      | PASS   | FAIL      |
| FAIL: c-c++-common/spec-barrier-1.c  -std=gnu++2a (test for excess errors)                                           | runtest -v --tool g++ dg.exp=spec-barrier-1.c                      | PASS   | FAIL      |

### [gfortran](./gfortran)

| 失败项                                                                                                                                  | CMD                                            | x86 情况 | oErv 重测结果 |
|--------------------------------------------------------------------------------------------------------------------------------------|------------------------------------------------|--------|-----------|
| FAIL: gfortran.dg/pr45636.f90   -O   scan-tree-dump-times forwprop2 "memset" 0                                                       | runtest -v --tool gfortran dg.exp=pr45636.f90  | PASS   | FAIL      |
| FAIL: gfortran.dg/pr95690.f90   -O   (test for errors, line 5)                                                                       | runtest -v --tool gfortran dg.exp=pr95690.f90  | PASS   | FAIL      |
| FAIL: gfortran.dg/pr95690.f90   -O  (test for excess errors)                                                                         | runtest -v --tool gfortran dg.exp=pr95690.f90  | PASS   | FAIL      |
| FAIL: gfortran.dg/ieee/ieee_6.f90   -O0  execution test                                                                              | runtest -v --tool gfortran ieee.exp=ieee_6.f90 | PASS   | FAIL      |
| FAIL: gfortran.dg/ieee/ieee_6.f90   -O1  execution test                                                                              | runtest -v --tool gfortran ieee.exp=ieee_6.f90 | PASS   | FAIL      |
| FAIL: gfortran.dg/ieee/ieee_6.f90   -O2  execution test                                                                              | runtest -v --tool gfortran ieee.exp=ieee_6.f90 | PASS   | FAIL      |
| FAIL: gfortran.dg/ieee/ieee_6.f90   -O3 -fomit-frame-pointer -funroll-loops -fpeel-loops -ftracer -finline-functions  execution test | runtest -v --tool gfortran ieee.exp=ieee_6.f90 | PASS   | FAIL      |
| FAIL: gfortran.dg/ieee/ieee_6.f90   -O3 -g  execution test                                                                           | runtest -v --tool gfortran ieee.exp=ieee_6.f90 | PASS   | FAIL      |
| FAIL: gfortran.dg/ieee/ieee_6.f90   -Os  execution test                                                                              | runtest -v --tool gfortran ieee.exp=ieee_6.f90 | PASS   | FAIL      |