#ifndef ADC_HAL_H_
#define ADC_HAL_H_

#include <stdint.h>                                 // Type comme uint8_t
#include <avr/io.h>                                 // Contient les registres
#include <util/delay.h>                             // Fonction delay
#include <avr/interrupt.h>                          // Nécéssaire pour les intéruptions

#define ADC_VOLT(x) (x * (5.0/1024.0))              // Macro de conversion pour passer de binaire à volt

enum                                                // Enumérateur pour ne pas avoir à écrire les valeurs
{
    ADC0_PIN,
    ADC1_PIN,
    ADC2_PIN,
    ADC3_PIN,
    ADC4_PIN,
    ADC5_PIN,
    ADC6_PIN,
    ADC7_PIN,
    ADC8_TEMPERATURE,                               // Capteur de température interne
    ADC_1V1 = 0b1110,                               // Ici on force a reprendre à 14
                                                    // C'est la référence de tension interne de 1.1V
    ADC_GND                                         // Connecte l'ADC à la masse
};

// Prototype des fonctions
void adc_init(void);
void adc_pin_enable(uint8_t pin);
void adc_pin_disable(uint8_t pin);
void adc_pin_select(uint8_t source);
uint16_t adc_convert(void);

#endif /* ADC_HAL_H_ */