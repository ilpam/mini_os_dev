#include "print.h"
#include "init.h"
#include "debug.h"
#include "memory.h"
#include "thread.h"

void k_thread_a(void *arg);

int main(void) {
    put_str("I am kernel.\n");
    init_all();
    //asm volatile ("sti");
    //ASSERT(1 == 2);

    put_str("Init done.\n");
    #if 0 
    void* vaddr = get_kernel_pages(3);
    put_str("\nKernel memory virtual page start address: ");
    put_int((uint32_t) vaddr);
    put_char('\n');
    #endif

    thread_start("k_thread_a", 31, k_thread_a, "argA ");

    while (1);
    return 0;
}

void k_thread_a(void *arg)
{
    char *para = arg;
    while(1) {
        put_str(para);
    }
}