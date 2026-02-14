/*
 * File:   main.c
 * Author: Antoine Polo
 *
 * Created on February 14, 2026, 12:20 PM
 */


#define F_CPU 16000000UL
#include <xc.h>
#include <util/delay.h>
#include <avr/interrupt.h>

volatile uint8_t counter = 0x10;    // Variable partagée entre le programme principal et les intéruptions

// Interruption 0 liée à la broche physique PD2
ISR(INT0_vect)
{
    if(counter >= 0x80) // Si on est sur la denrière led on revient à la première
    {
        counter = 0x10;
    }
    else                // Sinon, on passe à la suivante
    {
        counter *= 2;
    }
}

// Interruption 0 liée à la broche physique PD3
ISR(INT1_vect)
{
    if(counter <= 0x10)
    {
        counter = 0x80;
    }
    else
    {
        counter /= 2;
    }
}

int main(void)
{
    // On définit les entrées sortie de manière à ne pas les écrasées
    DDRD &= 0xF3;   // 0b11110011
    DDRD |= 0xF0;   // 0b11110000
    
    // On active les pull-ups sur PD2 et PD3
    PORTD = 0x0C;   // 0b00001100
    
    // Configuration des interruptions
    EICRA |= (0b10 << ISC10) | (0b10 << ISC00); // On configure en descendant pour l'intéruption 0 et 1
    EIMSK = 0x03;                               // On active les intéruption 0 et 1  
    
    sei();                                      // On active globalement les intéruption
    
    while (1)
    {
        PORTD &= 0x0F;                          // On éteint les bits 4 à 7
        PORTD |= counter;                       // On allume les leds correspondant au conteur
    }
    
    return 0;
}
