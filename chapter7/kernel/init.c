#include "init.h"
#include "interrupt.h"
#include "print.h"
#include "../device/timer.h"

void init_all() {
    put_str("init_all.\n");
    idt_init();
    timer_init();
}