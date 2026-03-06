/*
 * File:   wdt_hal.c
 * Author: Antoine Polo
 *
 * Created on March 5, 2026, 4:06 PM
 */


#include "wdt_hal.h"

void WDT_off(uint8_t int_enable)                                                // Permet de désactiver le watchdog
{    
    if(int_enable != 0)                                                         // Si la variable est différente de 0
    {
        cli();                                                                  // On désactive les intéruptions globales
    }
    
    wdr();                                                                      // On remet le timer du watchdog à 0

    MCUSR &= ~(1<<WDRF);                                                        // On efface le flag WDRF pour pouvoir désactiver le watchdog

    WDTCSR |= (1<<WDCE) | (1<<WDE);                                             // On permet la modification du watchdog

    WDTCSR = 0x00;                                                              // On met tout à 0, ça coupe le watchdog
    
    if(int_enable != 0)                                                         // Si on avait couper les interrutpions
    {
        sei();                                                                  // On les réactives
    }
}

void WDT_enable(void)                                                           // On active le watchdog avec un paramètre par défaut
{
    wdr();                                                                      // On reset le compteur
    MCUSR &= ~(1<<WDRF);                                                        // On nettoie le flag de reset
	WDTCSR |= (1<<WDCE) | (1<<WDE);                                             // On autorise la modification
	WDTCSR |=  (1<<WDE);                                                        // On active le watchdog
}

void WDT_prescaler_change(uint8_t int_enable, wdt_timeout_e timeout)            // Définit le temps que le watchdog attend avec de redémarrer le microcontrôlleur
{
    if(int_enable != 0)                                                         // Protection contre les interruptions
    {
        cli();
    }
    wdr();                                                                      // On reset le compteur

    WDTCSR |= (1<<WDCE) | (1<<WDE);                                             // On autorise le changement de configuration
    WDTCSR = (timeout<<WDP0) | (1<<WDE);                                        // On configure le nouveau timeout
    
    if(int_enable != 0)                                                         // On réactive les interruptions
    {
        sei();
    }
}