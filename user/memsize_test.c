#include "kernel/types.h"
#include "kernel/stat.h"
#include "user/user.h"

int main() {
   printf("Process size is %d\n" ,memsize());
   int *ptr;
   ptr = malloc(20480);
   printf("Process size is %d\n" ,memsize());
   free(ptr);
   printf("Process size is %d\n" ,memsize());
   return 0;
}