/*
 * File:   main.c
 * Author: Antoine Polo
 *
 * Created on February 24, 2026, 11:43 AM
 */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include "eeprom.h"

int main(void)
{
    uint8_t run = 0;                                // Variable pour la valeur a affichée
    uint8_t err = 0;                                // Variable pour les erreurs
    
    DDRD |= 0xF0;                                   // PD4-7 en sortie
    DDRB |= 0x0F;                                   // PB0-3 en sortie
    
    sei();                                          // Active les interruption de manière globale
    
    err = EEPROM_read(96, &run);                    // On lit la valeur dans la case 96
    
    uint8_t c = run + 1;                            // On prépare la valeur pour le prochain redémarrage
    
    err = EEPROM_update(96, c);                     // On écrit la nouvelle valeur dans l'eeprom
    
    PORTD &= 0x0F;                                  // On met tout à 0
    PORTB &= 0xF0;                                  // Ici aussi
    PORTD |= ((run & 0x0F) << 4);                   // On affiche la première parite de run
    PORTB |= ((run & 0xF0) >> 4);                   // Et ici la deuxième
    
    /* Replace with your application code */
    while (1)
    {
    }
}