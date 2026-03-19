/*
 * File:   main.c
 * Author: Antoine Polo
 *
 * Created on March 10, 2026, 6:06 PM
 */

#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include "uart_hal.h"
#include "adc_hal.h"
#include "timer0_hal.h"
#include "twi_hal.h"

static char print_buffer[64] = {0};                                             // Buffer pour les chaines d'envoies de l'UART
	
#define RTC_ADDR (0x68)                                                         // Adresse I2C de la RTC

int main(void)
{
	const char start[] = "\n\rProgram Start\n\r";                               // Message de début de programme
	uint8_t run = 0;                                                            // Compteur binaire pour les LEDs
	uint16_t adc = 0;                                                           // Stocke la valeur brute du potentiomètre
	uint32_t holder = 0;                                                        // Marqueur pour le temps d'animation des LEDs
	uint32_t rtc_interval = 0;                                                  // Marqueur pour le temps de lecture RTC
	uint8_t err = 0;                                                            // Varialbe pour les erreurs I2C
	
	DDRD &= 0xF0;                                                               // PD0-3 en entrée
	DDRB &= 0x0F;                                                               // PB4-7 en entrée
	uart_init(9600,0);                                                          // Initialisation de l'UART à 9600 bauds
	adc_init();                                                                 // Initialisation de l'ADC (allume et configure)
	adc_pin_enable(ADC3_PIN);                                                   // On coupe la partie numérique de la broche A5
	adc_pin_select(ADC3_PIN);                                                   // On connecte l'ADC à la broche 5
	timer0_init();                                                              // On démarre le timer
	
	twi_init(100000);                                                           // Initialise l'I2C à 100kHZ 100khz
	
	uint8_t rtc_data[7] = {0x50,0x59,0x23,0x07,0x31,0x10,0x20};                 // Données d'initialisation de la RTC [Sec, Min, Heure, JourSem, JourMois, Mois, Année]
    
    /* Notes RTC
     * On utilise le format BCD (Binary Coded Decimal)
     * On découpe l'octet en deux, les 4 buts de poids fort représente les dizaines, et les 4 de poids faible les unités
     * Par exemple pour écrit 45 : 0100 (4) 0101 (5) -> 0x45
     */
	
	sei();                                                                      // On active les interruptions de manière globale

	uart_send_string((uint8_t*)start);                                          // On envoie le message de start dans l'UART
	
	adc = adc_convert();                                                        // Première lecture du potentiomètre pour fixer le délai initial
	holder = millis();                                                          // On initialise le premier chrono
	
	
	err = twi_wire(RTC_ADDR, 0x00, rtc_data, sizeof(rtc_data));                 // On écrit rtc_data dans la RTC
	if(err != TWI_OK){                                                          // Si on a eu une erreur
		memset(print_buffer,0,sizeof(print_buffer));                            // On clear le buffer UART
		sprintf(print_buffer,"%d error %d\r\n\n",__LINE__,err);                 // On formate le message d'erreur (ligne de l'erreur et message d'erreur I2C)
		uart_send_string((uint8_t*)print_buffer);                               // On envoie le message d'erreur
		while(1);                                                               // Boucle pour stopper le programme
	}
	
	
	rtc_interval = millis();                                                    // Initialise le chrono pour la boucle RTC
    while(1)                                                                    // Boucle principale
    {
		
		if(millis_end(rtc_interval,500)){                                       // Lecture de l'heure toutes les 500ms
			
			err = twi_read(RTC_ADDR, 0x00, rtc_data, sizeof(rtc_data));         // On lit les 7 registres de temps de la RTC, on lit l'adresse 1, puis ça s'incrémente tout seul
                                                                                // les données de retour sont stockées dans la variable rtc_data.
			if(err != TWI_OK){                                                  // Si on a une erreur
				memset(print_buffer,0,sizeof(print_buffer));                    // On vide le buffer de print de l'UART
				sprintf(print_buffer,"%d error %d\r\n\n",__LINE__,err);         // On prépare un string contenant la ligne d'erreur et le code renvoyé par le bus I2C
				uart_send_string((uint8_t*)print_buffer);                       // On envoie ce message avec l'UART
				while(1);                                                       // On bloque le programme ici pour ne pas qu'il continue
			}
			
			memset(print_buffer,0,sizeof(print_buffer));                        // On efface à nouveau le buffer de l'envoie UART
			sprintf(print_buffer,"\r20%02x/%02x/%02x %02x:%02x:%02x",           // On formate les données pour les affichées
			rtc_data[6],                                                        // Année
			rtc_data[5],                                                        // Mois
			rtc_data[4],                                                        // Jour
			rtc_data[2],                                                        // Heure
			rtc_data[1],                                                        // Minutes
			rtc_data[0]                                                         // Seconde
			);
			uart_send_string((uint8_t*)print_buffer);                           // On envoie les données formatée
			
			
			rtc_interval = millis();                                            // On met à jour le chrono
		}
            
        // Animation des LEDs (compteur binaire)
		if(millis_end(holder,adc)){                                             // Le délai entre chaque incrément est défini par la valeur de l'ADC
			run++;                                                              // On incrémente la valeur à afficher
			PORTD &= 0x0F;                                                      // On efface PD4-7
			PORTB &= 0xF0;                                                      // On efface PB0-3
			PORTD |= ((run & 0x0F) << 4);                                       // Affiche les 4 bits de poids faible de run sur PD4-7
			PORTB |= ((run & 0xF0) >> 4);                                       // Affiche les 4 bits de poids fort de run sur PB0-3
			adc = adc_convert();                                                // On fait une nouvelle conversion de l'ADC
			holder = millis();                                                  // On relance le chrono pour le prochain cycle LED
		}

    }
}
