// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

char *delete_first(char *s, char *pattern) {
  int patternSize = 0, i = 0, j = 0, checker;
  while (pattern[++patternSize] != '\0')
    ;
  while (s[i++] != '\0') {
    checker = 1;
    for (j = 0; j < patternSize; j++) {
      if (s[j + i] != '0') {
        if (s[i + j] != pattern[j]) {
          checker = 0;
          break;
        }
      } else {
        checker = 0;
        break;
      }
    }
    j = 0;
    if (checker) {
      while (s[i + j + patternSize - 1] != '\0') {
        s[i + j] = s[i + j + patternSize];
        j++;
      }
      break;
    }
  }
  return s;
}

int main(void) {
  /*
   * TODO: Este corectă declarația variabilei s în contextul în care o să apelăm
   * funcția delete_first asupra sa? De ce? Modificați dacă este cazul.
   */
  char s[14];
  strcpy(s, "Ana are mere\0");
  char *pattern = "re";
  (void)s;
  (void)pattern;

  delete_first((char *)(s), (char *)(pattern));

  // Decomentați linia după ce ați implementat funcția delete_first.
  printf("%s\n", delete_first(s, pattern));

  return 0;
}
