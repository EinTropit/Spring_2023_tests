#!/bin/bash

RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

EXIT_STATUS=0

ld -T ./hw3_part2.ld -o 'part2.exec' 'link_test.o' 'link_test2.o'

if [ -f "part2.exec" ]; then
    readelf -s part2.exec > ./part2_out_files/part2_s.out
    readelf -WS part2.exec > ./part2_out_files/part2_WS.out

    cat ./part2_out_files/part2_s.out | grep -ho '000000000040000c     0 NOTYPE  GLOBAL DEFAULT    3 _hw3_unicorn' > ./part2_out_files/test_1.out
    cat ./part2_out_files/part2_s.out | grep -ho '0000000000400000     0 NOTYPE  GLOBAL DEFAULT    3 _start' > ./part2_out_files/test_2.out
    cat ./part2_out_files/part2_s.out | grep -ho '0000000000060000     0 NOTYPE  LOCAL  DEFAULT    1 msg1' > ./part2_out_files/test_3.out
    cat ./part2_out_files/part2_s.out | grep -ho '0000000080000000     0 NOTYPE  LOCAL  DEFAULT    4 msg2' > ./part2_out_files/test_4.out
    cat ./part2_out_files/part2_s.out | grep -ho '0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND purple' > ./part2_out_files/test_5.out
    cat ./part2_out_files/part2_s.out | grep -ho '0000000000000000     0 NOTYPE  GLOBAL DEFAULT  UND white' > ./part2_out_files/test_6.out
    cat ./part2_out_files/part2_WS.out | grep '.data             PROGBITS        0000000000060000' | grep -ho ' 000005 00  WA  0   0  4' > ./part2_out_files/test_7.out
    cat ./part2_out_files/part2_WS.out | grep '.text             PROGBITS        0000000000400000' | grep -ho ' 000018 00  AX  0   0 16' > ./part2_out_files/test_8.out
    cat ./part2_out_files/part2_WS.out | grep '.rodata           PROGBITS        0000000080000000' | grep -ho ' 000005 00   A  0   0  4' > ./part2_out_files/test_9.out
    cat ./part2_out_files/part2_WS.out | grep '.bss              NOBITS          0000000000060008' | grep -ho ' 000032 00  WA  0   0  4' > ./part2_out_files/test_10.out

    for ((i=1; i<=10; i++)); do
        diff "./part2_exp_files/test_${i}.exp" "./part2_out_files/test_${i}.out" &>/dev/null
        if [ $? -eq 0 ]; then
            echo -e "test ${i}: ${GREEN}PASS${NC}"
        else
            EXIT_STATUS=1
            echo -e "test ${i}: ${RED}FAIL${NC}"
        fi
    done   

    ./part2.exec
    if [ $? -eq 0 ]; then
        echo -e "entry test: ${GREEN}PASS${NC}"
    else
        EXIT_STATUS=1
        echo -e "entry test: ${RED}FAIL${NC}"
    fi

else
    EXIT_STATUS=1
fi

exit ${EXIT_STATUS}