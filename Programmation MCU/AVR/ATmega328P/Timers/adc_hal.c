/*
 * File:   adc_hal.c
 * Author: Antoine Polo
 *
 * Created on February 21, 2026, 2:38 PM
 */

#include "adc_hal.h"

volatile static uint8_t adc_convert_done = 1;               // Variable qui peut changer à tout moment grâce à une interruption
                                                            // Elle sert de drapeau pour savoir si la conversion est terminée

ISR(ADC_vect)                                               // interruption qui dès que l'ADC finit de traduire la tension analogique
{                                                           // valeur numérique met le flag à 1
    adc_convert_done = 1;
}

void adc_init(void)                                         // Initialise l'ADC
{       
    ADMUX |= 0b01 << REFS0;                                 // Configure la référence de tension sur AVcc
    ADCSRA |= 1 << ADEN | 1 << ADIE | 0b111 << ADPS0;       // Controle et status
    /* 
     * ADEN : Active le module ADC
     * ADIE : Active l'interruption
     * ADPS0 : Prescaler de 128, il règle la vitesse de l'ADC
     *         Elle doit se trouvée entre 50kHz et 200kHz,
     *         ici on est à 125kHz (16MHz / 128).
     */
}

void adc_pin_enable(uint8_t pin)                            // Désactive la partie numéirque de la broche                            
{
    DIDR0 |= 1 << pin;                                      
}

void adc_pin_disable(uint8_t pin)                           // Active la partie numérique de la broche
{
    DIDR0 &= ~(1 << pin);
}

void adc_pin_select(uint8_t source)
{
    ADMUX &= 0xF0;                                          // On efface les 4 bits de poids faible (le canal précédent)
    ADMUX |= source;                                        // On écrit le nouveau canal (0 à 7)
}

uint16_t adc_convert(void)
{
    uint8_t adcl = 0;
    uint8_t adch = 0;
    
    adc_convert_done = 0;                                   // On dit qu'une conversion est en cours
    
    ADCSRA |= 1 << ADSC;                                    // On lance la conversion
    while(adc_convert_done == 0);                           // On attend l'ISR
    
    adcl = ADCL;                                            // On lit d'abbord les bits de poids faible
    adch = ADCH;                                            // Puis les bits de poids fort
    
    return (adch << 8 | adcl);                              // On combine les deux résultats pour avoir un résultat de 10 bits
}