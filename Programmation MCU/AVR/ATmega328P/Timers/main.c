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
#include "timer0_hal.h"

int main(void)
{
    uint8_t run = 0;                                        // Compteur 8 bits pour les leds
    uint16_t adc = 0;                                       // Stocke la valeur de l'ADC
    uint32_t holder = 0;                                    // Stock le temps actuel
    
    DDRD |= 0xF0;                                           // PD4-7 en sortie
    DDRB |= 0x0F;                                           // PB0-3 en sortie
    
    adc_init();                                             // Initialise l'ADC
    adc_pin_enable(ADC5_PIN);                               // Désactive la partie numérique de A5
    adc_pin_select(ADC5_PIN);                               // Connecte le canal 5 à l'ADC
    
    timer0_init();                                          // Démarre le timer
    
    sei();                                                  // Active les intteruptions
    
    PORTD &= 0x0F;                                          // PD4-7 à 0
    PORTB &= 0xF0;                                          // PB0-3 à 0
    PORTD |= ((run & 0x0F) << 4);                           // PD4-7 aux 4 bits bas de run
    PORTB |= ((run & 0xF0) >> 4);                           // PB0-3 aux 4 bits haut de run
    
    adc = adc_convert();
    holder = millis();                                      // Sauvegarde du temps actuel
    
    /* Replace with your application code */
    while(1)                                                // Boucle principale
    {
        if(millis_end(holder, adc))                         // C'est t'il écouller "adc" milliseconde depuis holder ?
        {
            run++;                                          // On incrémente le compteur (led)
            PORTD &= 0x0F;                                  // PD4-7 à 0
            PORTB &= 0xF0;                                  // PB0-3 à 0
            PORTD |= ((run & 0x0F) << 4);                   // PD4-7 aux 4 bits bas de run 
            PORTB |= ((run & 0xF0) >> 4);                   // PB0-3 aux 4 bits haut de run        
            adc = adc_convert();                            // On relier la valeur du potentiomètre
            holder = millis();                              // On reprend le temps actuel
        }
    }
}
