/*
 * File:   main.c
 * Author: Antoine
 *
 * Created on February 27, 2026, 9:04 PM
 * 
 * Connexion :
 * ls /dev/cu.usb*
 * screen /dev/cu.usbserial-B001HF8O 9600
 */

#define F_CPU 16000000

#include <stdint.h>
#include <avr/io.h>
#include <util/delay.h>
#include <avr/interrupt.h>
#include "uart_hal.h"

int main(void)
{
    const uint8_t start[] =  "Program Start\n\r";                               // Préparation du message de démarrage
    uint8_t data;                                                               // Variable tampon pour la donnée
    uint8_t counter = 0x10; //0b00010000                                        // LED de départ (0b00010000)
    
    DDRD |= 0xF0; //0b11110000                                                  // PD4-7 en sortie
    uart_init(9600, 0);                                                         // On initialise l'UART à 9600 bauds, vitesse normale
    
    sei();                                                                      // On active les interruptions globales
    
    uart_send_string(start);                                                    // On envoie le message de démarrage
    
    while (1)                                                                   // Boucle principale
    {
        if(uart_read_count() > 0)                                               // Si on a un octet dans e buffer
        {
            data = uart_read();                                                 // On le lit
            uart_send_byte(data);                                               // On le renvoie pour l'afficher (echo)
            
            PORTD &= 0x0F;                                                      // On éteint toutes les leds 0b00001111
            PORTD |= counter;                                                   // On allume les LEDs correspondante
            
            if(counter >= 0x80)                                                 // Si on atteint la dernière LED
            {
                counter = 0x10;                                                 // On revient à la première
            }
            else                                                                // Sinon
            {
                counter *= 2;                                                   // On multiple par deux
            }
        }
    }
}
