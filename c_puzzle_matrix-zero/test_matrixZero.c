/* test_matrixZeros.c - Tests the matrix zero puzzle.
 *
 * Author: Luis Martin Gil <martingil.luis@gmail.com>
 * Web:    www.luismartingil.com
 *
 * This is free software; you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation; either version 2 of the License, or
 * (at your option) any later version.
 *
 * matrixZero is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this library; if not, write to the Free Software
 * Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301  USA
 */

#include <stdio.h>
#include "matrixZero.h"

#define MAX 1000
#define MAX_LIST 1000

struct _test {
  char* name;
  int size;
  int array[MAX]; // row
  int expected;
};

struct _test row_tests[MAX_LIST] = {

  {"row_test0-1", 0, { }, 0},  // Expected 0 zeros

  {"row_test1-1", 1, { 1 }, 0}, // Expected 0 zeros
  {"row_test1-2", 1, { 0 }, 1}, // Expected 1 zeros

  {"row_test4-1", 4, { 0, 0, 0, 1 }, 3}, // Expected 3 zeros
  {"row_test4-2", 4, { 0, 0, 0, 0 }, 4}, // Expected 4 zeros
  {"row_test4-3", 4, { 1, 1, 1, 1 }, 0}, // Expected 0 zeros
  {"row_test4-4", 4, { 0, 0, 1, 1 }, 2}, // Expected 2 zeros

  {"row_test6-1", 6, { 0, 0, 1, 1, 1, 1 }, 2}, // Expected 2 zeros
  {"row_test6-2", 6, { 0, 1, 1, 1, 1, 1 }, 1}, // Expected 1 zeros
  {"row_test6-3", 6, { 0, 0, 0, 0, 0, 0 }, 6}, // Expected 6 zeros
  {"row_test6-4", 6, { 0, 1, 1, 1, 1, 1 }, 1}, // Expected 1 zeros

  {"row_test16-1", 16, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1 }, 12}, // Expected 12 zeros
  {"row_test16-2", 16, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1 }, 11}, // Expected 11 zeros
  {"row_test16-3", 16, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0 }, 16}, // Expected 16 zeros
  {"row_test16-4", 16, { 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 1, 1, 1, 1, 1 }, 11}, // Expected 11 zeros
  {"row_test16-5", 16, { 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1 }, 0}, // Expected 0 zeros

};

struct _test matrix_tests[MAX_LIST] = {

  {"matrix_test1-1", 1, { 1 }, 1},  // Expected row 1
  {"matrix_test1-2", 1, { 0 }, 1},  // Expected row 1

  {"matrix_test44-1", 4, 
   { 0, 0, 0, 1 ,
     0, 0, 0, 1 ,
     0, 0, 0, 1 ,
     0, 0, 0, 1 }, 1},  // Expected row 1

  {"matrix_test44-2", 4, 
   { 0, 0, 1, 1 ,
     0, 1, 1, 1 ,
     0, 0, 1, 1 ,
     0, 1, 1, 1 }, 1},  // Expected row 1

  {"matrix_test44-3", 4,
   { 0, 1, 1, 1 ,
     0, 1, 1, 1 ,
     0, 0, 1, 1 ,
     0, 1, 1, 1 }, 3},  // Expected row 3

  {"matrix_test44-4", 4,
   { 0, 1, 1, 1 ,
     0, 0, 1, 1 ,
     1, 1, 1, 1 ,
     1, 1, 1, 1 }, 2}, // Expected row 2

  {"matrix_test55-1", 5,
   { 0, 1, 1, 1, 1,
     0, 0, 1, 1, 1,
     1, 1, 1, 1, 1,
     1, 1, 1, 1, 1,
     0, 0, 0, 0, 0}, 5},  // Expected row 5

  {"matrix_test55-2", 5,
   { 0, 0, 0, 0, 1,
     0, 0, 1, 1, 1,
     1, 1, 1, 1, 1,
     0, 0, 0, 0, 0,
     0, 1, 1, 1, 1}, 4},  // Expected row 4

};

int executeTests(struct _test test, int (*f)(int[], int)) {
  int result = 0;
  
  // Execute the test
  result = f(test.array, test.size);
  printf("%s result %i...", test.name, result);

  if (test.expected == result) {
    printf("correct\n");
  } else {
    printf("fail! Expected:%i as result\n", test.expected);
  }

  return 0;
}


int main (void) {
  int i = 0;  

  // Performing the row tests with the fun rowZeros
  int row_tests_len = sizeof(row_tests) / sizeof(row_tests[0]);
  for (i = 0; i < row_tests_len; i = i + 1) {
    if (row_tests[i].name == NULL) break;
    executeTests(row_tests[i], rowZeros);
  }

  // Performing the matrix tests with the fun matrixZeros
  // Making sure this algorithm works! ;-)
  int matrix_tests_len = sizeof(matrix_tests) / sizeof(matrix_tests[0]);
  for (i = 0; i < matrix_tests_len; i = i + 1) {
    if (matrix_tests[i].name == NULL) break;
    executeTests(matrix_tests[i], matrixZeros);
  }
  
  return 0;

}
