/*
 * File:   main.c
 * Author: antoinepolo
 *
 * Created on February 13, 2026, 6:09 PM
 */

#define F_CPU 16000000UL
#include <xc.h>
#include <util/delay.h>

int main(void)
{
    
    uint16_t run = 1;
    
    DDRD = 0xFF;            //0b11111111
    
    while(1)
    {
        PORTD = 0x00;       //0b00000000
        _delay_ms(250);
        PORTD = run;
        _delay_ms(250);
        
        //0b00000001
        //0b00000010
        //0b00000100
        //0b00001000
        //0b00010000
        //0b00100000
        //0b01000000
        //0b10000000
        //0b00000001
        
        if (run >= 0x80)
        {
            run = 1;
        }
        else
        {
            run *= 2;
        }
    }
    
    return 0;
}
