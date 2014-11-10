/*
  Write a program that prints the numbers from 1 to 100. 
  But for multiples of three print "Fizz" instead of the number 
  and for the multiples of five print "Buzz". 
  For numbers which are multiples of both three and five print "FizzBuzz".
*/

#include <stdio.h>
#define MAX_STR_SIZE 20

int main (void) {
  int min = 1;
  int max = 100;
  int i;
  int cond1, cond2 = 0;
  char *output;
  char tmp_str[MAX_STR_SIZE];
  for (i = min; i <= max; i++) {
    cond1 = i % 3 == 0;
    cond2  = i % 5 == 0;
    if ((cond1) && (cond2)) {
	output = "FizzBuzz";
      } else if (cond1) {
      output = "Fizz";
    } else if (cond2) {
      output = "Buzz";
    } else {
      snprintf(tmp_str, MAX_STR_SIZE, "%d", i);
      output = tmp_str;
    }
    printf("%i %s\n", i, output);
  }
}
