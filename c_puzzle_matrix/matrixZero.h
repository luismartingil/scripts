/* matrixZero.h - Implements the matrix zero puzzle.
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

#ifndef MATRIXZERO_H
#define MATRIXZERO_H

int matrixZeros(int matrix[], int n);
// Calculates the row with max number of zeros based on the puzzle.
//
// n is the row size of the matrix
// matrix is an array which represents a matrix of nxn

int rowZeros(int row[], int max);
// Calculates the number of zeros of a given array based on the puzzle.
//
// max is the max number of items to check in the array row
// row is the array to check the zeros

#endif
