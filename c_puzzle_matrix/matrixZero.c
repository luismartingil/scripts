/* matrixZero.c - Implements the matrix zero puzzle.
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

#include "matrixZero.h"

int matrixZeros(int matrix[], int n) {
  int zeros_tmp = 0;
  int row_max = 0;
  int zeros_max = 0;
  int success = 0;
  int i = 0; // row counter

  while (!success && i < n) {
    zeros_tmp = rowZeros(&matrix[i*n], n);
    if (zeros_tmp == n) {
      success = 1;
      row_max = i;
    } else if (zeros_tmp > zeros_max) {
      zeros_max = zeros_tmp;
      row_max = i;
    }
    i = i + 1;
  }

  if (success || i == n) {
    return row_max + 1;
  } else {
    return -1;
  }
}

int rowZeros(int row[], int max) {
  int zeros = 0;
  int success = 0;
  int ini = 0;
  int end = max - 1;
  int avg = (ini + end) / 2;

  while (!success && avg >= 0 && avg < max) {
    if (row[avg] == 1) {
      if (avg == ini) {
	success = 1;
	zeros = ini;
      } else {
	end = avg;
      }
    } else { //it's a zero
      if (avg == end) {
	success = 1;
	zeros = end + 1;
      } else {
	if (ini == end - 1) {
	  ini = end;
	} else {
	  ini = avg;
	}
      }
    }
    avg = (ini + end) / 2;
  }

  return zeros;
}
