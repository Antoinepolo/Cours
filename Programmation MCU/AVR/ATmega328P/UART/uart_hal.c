/*
 * File:   uart_hal.c
 * Author: Antoine Polo
 *
 * Created on February 27, 2026, 9:05 PM
 */

#include "uart_hal.h"

volatile static uint8_t rx_buffer[RX_BUFFER_SIZE] = {0};                        // Buffer pour stocker les octets reçu par l'UART
volatile static uint16_t rx_count = 0;                                          // Compteur du nombre d'octet actuellement non lu dans le buffer
volatile static uint8_t uart_tx_busy = 1;                                       // Flag qui indique si l'UART est occupé ou non

ISR(USART_RX_vect)                                                              // Interruption déclenchée dès qu'un octet est reçu sur le port série
{
    volatile static uint16_t rx_write_pos = 0;                                  // Position d'écriture dans le buffer
    
    rx_buffer[rx_write_pos] = UDR0;                                             // On lit le registre des données reçu et les places dans le buffer
    rx_count++;                                                                 // On incrémente le nombre d'octet disponible
    rx_write_pos++;                                                             // On avance l'index d'écriture
    if(rx_write_pos >= RX_BUFFER_SIZE)                                          // Si on dépasse la taille maximale
    {
        rx_write_pos = 0;                                                       // On revient à 0
    }
}

ISR(USART_TX_vect)                                                              // Interruption déclenchée quand une transission complète est terminée
{
    uart_tx_busy = 1;                                                           // On indique que l'UART a finit sont travail
}


void uart_init(uint32_t baud,uint8_t high_speed){                               // Initialisation de l'UART
	
	uint8_t speed = 16;                                                         // Diviseur par défaut pour le calcul du baud rate
	
	if(high_speed != 0){
		speed = 8;                                                              // On met le mode double speed, le diviseur tombe à 8
		UCSR0A |= 1 << U2X0;                                                    // On active le bit U2X0
	}
	
	baud = (F_CPU/(speed*baud)) - 1;                                            // On calcul le baud rate
	
    // On sépare les bits du baud rate en 2 registres
	UBRR0H = (baud & 0x0F00) >> 8;                                              // Bits de poids fort
	UBRR0L = (baud & 0x00FF);                                                   // Bits de poids faible
	
	UCSR0B |= (1 << TXEN0) | (1 << RXEN0) | (1 << TXCIE0) | (1 << RXCIE0);      // On active l'émetteur et le récepteur (TX et RX) ainsi que les interruption de fin
	
}

void uart_send_byte(uint8_t c)                                                  // Envoie un seul octet
{
    while(uart_tx_busy == 0);                                                   // On attend que le flag soit à un (UART dispo)
    uart_tx_busy = 0;                                                           // On indique qu'on occupe maintenant l'UART
    UDR0 = c;                                                                   // On charge la donnée dans le registre et l'envoie
}

void uart_send_array(uint8_t *c, uint16_t len)                                  // Envoie un tableau d'octet d'une longueur définie
{
    for(uint16_t i = 0; i < len; i++)
    {
        uart_send_byte(c[i]);                                                   // On appelle la fonction d'envoie sur chaque éléments
    }
}

void uart_send_string(uint8_t *c)                                               // Envoie une chaine de caractères (qui se termine par \0)
{
    uint16_t i = 0;
    
    do
    {
        uart_send_byte(c[i]);                                                   // On appelle la fonction d'envoie
        i++;
    } while(c[i] != '\0');                                                      // On continue temps qu'on a pas atteint le caractère de fin
    uart_send_byte(c[i]);                                                       // On envoie le caractère de fin
}

uint16_t uart_read_count(void)                                                  // Retourne le nombre d'octets en attente dans le buffer de réception
{
    return rx_count;
}

uint8_t uart_read(void)                                                         // Lit le prochain octet disponible dans le buffer
{
    static uint16_t rx_read_pos = 0;                                            // Position de lecture
    uint8_t data = 0;
    
    data = rx_buffer[rx_read_pos];                                              // On récupère la donnée
    rx_read_pos++;                                                              // On avance l'index
    rx_count--;                                                                 // On décrémente le conteur global
    if(rx_read_pos >= RX_BUFFER_SIZE)                                           // Si on dépasse la taille, on revient à 0                                        
    {
        rx_read_pos = 0;
    }
    return data;
}