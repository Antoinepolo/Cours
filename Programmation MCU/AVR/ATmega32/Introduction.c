/*
 * File:   main.c
 * Author: Antoine Polo
 *
 * Created on February 26, 2026, 5:22 PM
 */

#define F_CPU 16000000


#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
    DDRB = 0b00000001;
    while (1)
    {
        PORTB = 0b00000001;
        _delay_ms(500);
        PORTB = 0b00000000;
        _delay_ms(500);
    }
}
