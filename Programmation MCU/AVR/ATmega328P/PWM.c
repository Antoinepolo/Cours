/*
 * File:   main.c
 * Author: Antoine Polo
 *
 * Created on February 26, 2026, 1:00 AM
 */

#define F_CPU 16000000

#include <avr/io.h>
#include <util/delay.h>

int main(void)
{
    DDRB |= 0b00000010;                         // PB1 en sortie
    TCCR1A |= (1<<COM1A1) | (1<<WGM10);         // Configure le timer 1 (16 bits)
                                                // COM1A1 : Active le mode PWM non-inversÈ sur la sortie OC1A (PB1)
                                                // WGM10  : Active le mode fast PWM 8 bits
    TCCR1B |= (1<<WGM12) | (1<<CS11);           // Suite de la configuration
                                                // WGM12  : ComplËte le mode fast PWM, le compteur va de 0 ‡ 255
                                                // DÈfinit le prescaler sur 8, on aura donc horloge du timer = F_CPU / 8
    OCR1A = 0;                                  // DÈfinit le rapport de cycle, 0 = LED Èteinte, 255 LED allumÈ ‡ fond
    
    uint8_t timer;                              // Variable pour le timer
    
    while (1)                                   // Boucle principale
    {
        // Fade-in
        while(timer < 255)
        {
            timer++;
            OCR1A = timer;
            _delay_ms(10);
        }
        
        // Fade-out
        while(timer > 1)
        {
            timer--;
            OCR1A = timer;
            _delay_ms(10);
        }
    }
}
