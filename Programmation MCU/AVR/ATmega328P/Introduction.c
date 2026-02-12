/*
 * File:   main.c
 * Author: Antoine Polo
 *
 * Created on February 12, 2026, 7:37 PM
 */

#define F_CPU 16000000UL        // Fréquence du CPU à 16MHz
#include <xc.h>
#include <util/delay.h>

int main(void) {
    
    DDRD = 0xFF;                // 0b11111111
    
    while(1)
    {
        PORTD = 0x80;           // On allume le bit 7 (pin 13) 0B10000000
        _delay_ms(500);
        PORTD = 0x00;           // Tout les bits à 0
        _delay_ms(500);
    }
    
    return 0;  
}
