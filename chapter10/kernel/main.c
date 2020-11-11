#include "print.h"
#include "init.h"
#include "debug.h"
#include "memory.h"
#include "thread.h"
#include "interrupt.h"
#include "console.h"

void k_thread(void *arg);

/* 
 * not allowed to add any function definition before main,
 * since main must located at virtual address 0xc0001500
 */
int main(void) 
{
    put_str("I am kernel.\n");
    init_all();
    //put_str("Init done.\n");


    thread_start("k_thread_a", 31, k_thread, "argA ");
    thread_start("k_thread_b", 8, k_thread, "argB ");

    intr_enable();

    while (1) {
        console_put_str("main ");
    }

    return 0;
}

void k_thread(void *arg)
{
    char *para = arg;
    while(1) {
        console_put_str(para);
    }
}