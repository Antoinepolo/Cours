/*
 * File:   main.c
 * Author: Antoine Polo
 *
 * Created on February 14, 2026, 11:34 AM
 */


#define F_CPU 16000000UL
#include <xc.h>
#include <util/delay.h>

int main(void)
{
    
    uint16_t run = 1;                       // Int de 16 bits
    
    DDRD = 0xFF;                            // Tout en sortie
    
    DDRB &= 0xF9;                           // PORTB1 et 2 en entrée, le reste en sortie
    
    PORTB = (1 << PORTB1) | (1 << PORTB2);  // On active le pull-up sur nos deux pins
    
    while(1)
    {
        if((PINB & (1 << PINB1)) == 0)      // On vérifie si le bouton est appuyé
        {
            _delay_ms(250);                 // Délais anti-rebond
            if(run >= 0x80)                 // Si la dernière LED est allumé
            {       
                run = 1;                    // On reset    
            }
            else
            {
                run *= 2;                   // Sinon on multiplie par 2
            }
        }
        
        if((PINB & (1 << PINB2)) == 0)
        {
            _delay_ms(250);
            if(run <= 1)
            {
                run = 0x80;
            }
            else
            {
                run /= 2;
            }
        }
        
        PORTD = run;
    }
        
    return 0;
}
