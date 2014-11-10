# Finding row with max number of zeros in a square matrix

Input is a NxN matrix which contains only 0′s and 1′s. The condition is no 0 will occur in a row after 1. Find the index of the row which contains maximum number of zeros.

Example: lets say 5×5 matrix

0 0 0 0 1

0 0 1 1 1

1 1 1 1 1

0 0 0 0 0

0 1 1 1 1

For this input answer is 4th row. Solution should have time complexity less than N^2.

# Solution

This solution implements a O(Nlog(N)) algorithm, based on the statement that our row are "sorted".

### Output

```
$ make
gcc -c -g -Wall -fPIC -D_GNU_SOURCE test_matrixZero.c -o test_matrixZero.o
gcc -c -g -Wall -fPIC -D_GNU_SOURCE matrixZero.c -o matrixZero.o
gcc -lm -Wall test_matrixZero.o matrixZero.o  -o test

$ ./test
row_test0-1 result 0...correct
row_test1-1 result 0...correct
row_test1-2 result 1...correct
row_test4-1 result 3...correct
row_test4-2 result 4...correct
row_test4-3 result 0...correct
row_test4-4 result 2...correct
row_test6-1 result 2...correct
row_test6-2 result 1...correct
row_test6-3 result 6...correct
row_test6-4 result 1...correct
row_test16-1 result 12...correct
row_test16-2 result 11...correct
row_test16-3 result 16...correct
row_test16-4 result 11...correct
row_test16-5 result 0...correct
matrix_test1-1 result 1...correct
matrix_test1-2 result 1...correct
matrix_test44-1 result 1...correct
matrix_test44-2 result 1...correct
matrix_test44-3 result 3...correct
matrix_test44-4 result 2...correct
matrix_test55-1 result 5...correct
matrix_test55-2 result 4...correct
```