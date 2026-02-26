/*
 * File:   main.c
 * Author: Antoine Polo 
 *
 * Created on February 20, 2026, 1:39 AM
 */

#define F_CPU 16000000UL

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include "adc_hal.h"

int main(void)
{
    uint8_t run = 1;                                // Variable pour l'état des leds
    uint16_t convert = 0;                           // Résultat de l'ADC
    
    DDRD |= 0xF0;                                   // 4 bits de poids forts en sortie (PD4 à PD7)
    DDRB |= 0x0F;                                   // 4 bits de poids faible en sortie (PB0 à PB3)
    
    adc_init();                                     // On allume et on configure l'ADC
    adc_pin_enable(ADC5_PIN);                       // On coupe la partie numérique de la broche A5
    adc_pin_select(ADC5_PIN);                       // On connecte l'ADC à la broche A5
    
    sei();                                          // On active globalement les interruption
    
    PORTD &= 0x0F;                                  // On met à 0 PD4 à PD7
    PORTB &= 0xF0;                                  // On met à 0 PB0 à PB3
    PORTD |= ((run & 0x0F) << 4);                   // On prend les 4 bits bas de run, les décale et les envoie sur PD4 à PD7 
    PORTB |= ((run & 0xF0) >> 4);                   // On prend les 4 bits haut de run, les décale et les envoie sur PDB0 à PB3
    /* Replace with your application code */
    while(1)
    {
        convert = adc_convert();                    // Lance la conversion et attend que l'ISR soit finie
        float volts = ADC_VOLT(convert);            // On calcul la valeur en volt (si on veut l'envoyer avec UART)
        
        run = convert >> 2;                         // On décale de 2 bit (divise par 4) pour passer de 10 bits à 8 bits
            
        PORTD &= 0x0F;                              // Efface les 4 bits de poids fort de PORTD
        PORTB &= 0xF0;                              // Efface les 4 bits de poids faible de PORTB
        PORTD |= ((run & 0x0F) << 4);               // Affiche les bits 0-3 de run sur PD4 à PD7
        PORTB |= ((run & 0xF0) >> 4);               // Affiche les bits 4-7 de rin sur PB0 à PB3
    }
}