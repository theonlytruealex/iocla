// SPDX-License-Identifier: BSD-3-Clause

#include <stdio.h>
#include <stdlib.h>
#include <string.h>

/*
 * Functie generica pentru calcularea valorii maxime dintr-un array.
 * n este dimensiunea array-ului
 * element_size este dimensiunea unui element din array
 * Se va parcurge vectorul arr, iar la fiecare iteratie sa va verifica
 * daca functia compare intoarce 1, caz in care elementul curent va fi
 * si cel maxim.
 * Pentru a folosi corect aritmetica pe pointeri vom inmulti indexul curent
 * din parcurgere cu dimensiunea unui element.
 * Astfel, pentru accesarea elementului curent avem:
 * void *cur_element = (char *)arr + index * element_size;
 */

void *find_max(void *arr, int n, int element_size,
               int (*compare)(const void *, const void *)) {
  void *max_elem = arr;

  (void)n;
  (void)element_size;
  (void)compare;
  int i;
  for (i = 0; i < n; i++) {
    if (compare((char *)arr + i * element_size, (char *)max_elem)) {
      max_elem = arr + i * element_size;
    }
  }
  return max_elem;
}

/*
 * a si b sunt doi pointeri la void, dar se specifica in enunt
 * ca datele de la acele adrese sunt de tip int, asadar trebuie
 * castati.
 * Functia returneaza 1 daca valorea de la adresa lui a este mai
 * mare decat cea de la adresa lui b, in caz contrar returneaza 0.
 */

int compare(const void *a, const void *b) {
  int *x = (int *)(a);
  int *y = (int *)(b);
  if (*x > *y) {
    return 1;
  }
  return 0;
}

/*
 * Se citeste de la tastatura un vector si se cere sa se afle
 * elementul maxim folosind functia find_max.
 */
int main(void) {
  int n;

  scanf("%d", &n);

  int *arr = malloc(n * sizeof(*arr));

  for (int i = 0; i < n; ++i) scanf("%d", &arr[i]);
  int *ans = (int *)(find_max(arr, n, 4, compare));
  printf("%d\n", *ans);
  free(arr);
  return 0;
}
