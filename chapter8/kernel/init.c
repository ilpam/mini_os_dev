#include "init.h"
#include "interrupt.h"
#include "print.h"
#include "../device/timer.h"
#include "memory.h"

void init_all() {
    put_str("init_all.\n");
    idt_init();
    mem_init();
    timer_init();
}