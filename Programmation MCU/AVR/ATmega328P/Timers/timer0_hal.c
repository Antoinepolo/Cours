/*
 * File:   timer0_hal.c
 * Author: Antoine Polo
 *
 * Created on February 22, 2026, 9:39 PM
 */


#include "timer0_hal.h"

volatile static uint32_t millis_c = 0;                          // La variable est static et donc lisible uniquement par ce fichier

ISR(TIMER0_COMPA_vect)
{
    millis_c++;                                                 // S'incrémente toutes les millisecondes
}

void timer0_init(void)
{
    TCCR0A |= (0b10 << WGM00);                                  // Mode clear timer on compare
                                                                // Il va donc ce reset dès qu'il atteint la valeur de OCR0A
    OCR0A = 249;                                                // Valeur de comparaison (TOP), c'est là qu'on reset
                                                                // Le compteur va compter jusqu'à OCR0A et retombe à 0
    TIMSK0 |= (1 << OCIE0A);                                    // Active l'intéruption de comparaison, on execute l'ISR
    TCCR0B |= (0b011 << CS00);                                  // Prescaler de 64, un seul battement d'horloge tout les 64 cycles processeur
}

uint32_t millis(void)                                           // Fonction qui renvoie le nombre de millisecondes depuis le démarrage
{
    return millis_c;
}

uint8_t millis_end(uint32_t start_time, uint32_t delay_time)    // Fonction qui vérifie si un délais est écouler depuis start_time
{
    return ((millis() - start_time) >= delay_time);
}