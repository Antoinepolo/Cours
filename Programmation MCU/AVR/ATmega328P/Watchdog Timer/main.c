/*
 * File:   main.c
 * Author: Antoine Polo
 *
 * Created on March 5, 2026, 4:00 PM
 */

#define F_CPU 16000000

#include <stdint.h>
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include "uart_hal.h"
#include "wdt_hal.h"
int main(void)
{
	uint8_t i = 0;                                                              // Variable pour la boucle
	WDT_off(0);                                                                 // On coupe le watchdog
	WDT_prescaler_change(0,wdt_timeout_2s);                                     // On définit le temps max sur 2s
	
	DDRD |= (1 << DDD7) | (1 << DDD6);                                          // PD6/7 en sortie
	
	for(i = 0; i < 3; i++){                                                     // On fait clignoter les LEDs
		PORTD |= (1 << PORTD7 | 1 << PORTD6);
		_delay_ms(200);
		PORTD &= ~(1 << PORTD7 | 1 << PORTD6);
		_delay_ms(200);
	}
	
	uart_init(9600,0);                                                          // On initialise l'UART


	sei();                                                                      // On active les interruptions globales
	uart_send_string((uint8_t*)"\n\rProgram Start\n\r");                        // On envoie un message pour dire que le programme à démarrer
	
	
	
    while(1)                                                                    // On refait clignoter les LEDs
    {
		for(i = 0; i < 15; i++){
			PORTD |= 1 << PORTD7;
			PORTD &= ~(1 << PORTD6);
			_delay_ms(200);
			PORTD |= 1 << PORTD6;
			PORTD &= ~(1 << PORTD7);
			_delay_ms(200);
			wdr();
		}
		break;
    }
	wdr();                                                                      // On reset le compteur 
	while(1){                                                                   // Boucle infinie vide
		
	}
}
