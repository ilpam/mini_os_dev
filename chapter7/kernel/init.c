#include "init.h"
#include "interrupt.h"
#include "print.h"

void init_all() {
    put_str("init_all.\n");
    idt_init();
}