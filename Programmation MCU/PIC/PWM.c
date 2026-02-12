/*
 * File:   main.c
 * Author: Antoine
 *
 * Created on December 14, 2025, 6:53 PM
 */

// PIC18F14K50 Configuration Bit Settings

// 'C' source line config statements

// CONFIG1L
#pragma config CPUDIV = NOCLKDIV    // CPU System Clock Selection bits (No CPU System Clock divide)
#pragma config USBDIV = OFF         // USB Clock Selection bit (USB clock comes directly from the OSC1/OSC2 oscillator block; no divide)

// CONFIG1H
#pragma config FOSC = IRC           // Oscillator Selection bits (Internal RC oscillator)
#pragma config PLLEN = OFF          // 4 X PLL Enable bit (PLL is under software control)
#pragma config PCLKEN = ON          // Primary Clock Enable bit (Primary clock enabled)
#pragma config FCMEN = OFF          // Fail-Safe Clock Monitor Enable (Fail-Safe Clock Monitor disabled)
#pragma config IESO = OFF           // Internal/External Oscillator Switchover bit (Oscillator Switchover mode disabled)

// CONFIG2L
#pragma config PWRTEN = OFF         // Power-up Timer Enable bit (PWRT disabled)
#pragma config BOREN = SBORDIS      // Brown-out Reset Enable bits (Brown-out Reset enabled in hardware only (SBOREN is disabled))
#pragma config BORV = 19            // Brown-out Reset Voltage bits (VBOR set to 1.9 V nominal)

// CONFIG2H
#pragma config WDTEN = OFF          // Watchdog Timer Enable bit (WDT is controlled by SWDTEN bit of the WDTCON register)
#pragma config WDTPS = 32768        // Watchdog Timer Postscale Select bits (1:32768)

// CONFIG3H
#pragma config HFOFST = ON          // HFINTOSC Fast Start-up bit (HFINTOSC starts clocking the CPU without waiting for the oscillator to stablize.)
#pragma config MCLRE = ON           // MCLR Pin Enable bit (MCLR pin; RA3 input pin disabled)

// CONFIG4L
#pragma config STVREN = ON          // Stack Full/Underflow Reset Enable bit (Stack full/underflow will cause Reset)
#pragma config LVP = OFF            // Single-Supply ICSP Enable bit (Single-Supply ICSP disabled)
#pragma config BBSIZ = OFF          // Boot Block Size Select bit (1kW boot block size)
#pragma config XINST = OFF          // Extended Instruction Set Enable bit (Instruction set extension and Indexed Addressing mode disabled (Legacy mode))

// CONFIG5L
#pragma config CP0 = OFF            // Code Protection bit (Block 0 not code-protected)
#pragma config CP1 = OFF            // Code Protection bit (Block 1 not code-protected)

// CONFIG5H
#pragma config CPB = OFF            // Boot Block Code Protection bit (Boot block not code-protected)
#pragma config CPD = OFF            // Data EEPROM Code Protection bit (Data EEPROM not code-protected)

// CONFIG6L
#pragma config WRT0 = OFF           // Table Write Protection bit (Block 0 not write-protected)
#pragma config WRT1 = OFF           // Table Write Protection bit (Block 1 not write-protected)

// CONFIG6H
#pragma config WRTC = OFF           // Configuration Register Write Protection bit (Configuration registers not write-protected)
#pragma config WRTB = OFF           // Boot Block Write Protection bit (Boot block not write-protected)
#pragma config WRTD = OFF           // Data EEPROM Write Protection bit (Data EEPROM not write-protected)

// CONFIG7L
#pragma config EBTR0 = OFF          // Table Read Protection bit (Block 0 not protected from table reads executed in other blocks)
#pragma config EBTR1 = OFF          // Table Read Protection bit (Block 1 not protected from table reads executed in other blocks)

// CONFIG7H
#pragma config EBTRB = OFF          // Boot Block Table Read Protection bit (Boot block not protected from table reads executed in other blocks)


#include <xc.h>

#define _XTAL_FREQ 16000000UL       // On met le UL pour spécifier que c'est un long, sinon la fréquence ne rentre pas

void main(void)
{
    // On va utiliser l'horloge interne, TMR2, et CCP1 afin de faire de la PWM
    
    // On fixe la fréquence réelle du CPU à 16 MHz
    // (_XTAL_FREQ sert uniquement au compilateur pour calculer les délais)
    OSCCONbits.IRCF = 0b111;        // 16 MHz

    TRISCbits.TRISC5 = 0;           // On définit RC5 en sortie

    // Configuration de Timer2 : définit la période (fréquence) de la PWM
    // On a choisit ces valeurs pour avoir un signal PWM de 1kHz, c'est parfait pour ne pas avoir de scintillement
    // Le prescaler permet de diviser la fréquence du CPU par 1, 4 ou 16 (ralentit le compteur pour avoir des périodes plus longues)
    // PR2 est un registre qui stocke la valeur à laquelle TMR2 va se reset
    // Plus PR2 est grand, plus le cycle est long et la fréquence est basse
    // Formule fréquence PWM : F = Fosc / 4 . prescaler . (PR2 + 1)
    // Calcul : 16 MHz / (4 × (249 + 1) × 4) ≈ 1 kHz
    PR2 = 249;                      // Fréquence PWM ≈ 1 kHz
    T2CONbits.T2CKPS = 0b01;        // Prescaler 1:4
    T2CONbits.TMR2ON = 1;           // On allume le compteur

    // On définit CCP1 au mode PWM
    // Il y a d'autre mode comme 1001 pour Compare, 0100 pour Caputure
    // On n'utilise que les quatres bits de poids faible
    CCP1CON = 0b00001100;           // Permet d'activer le PWM hardware

    // On définit le duty cycle de base à 0
    // En gros on fait démarrer à 0 pour éviter les problèmes
    CCPR1L = 0;                     // 8 bits de poids fort à 0
    CCP1CONbits.DC1B = 0;           // 2 bits de poids faible à 0

    while (1)                       // Boucle principale du programme
    {                 
        // On allume, pour ça en boucle de 0 à 1023-1 (les 10 bits de PWM)
        for (unsigned int duty = 0; duty < 1023; duty++)
        {
            // Ici on configure le duty cycle, 
            // duty = 0 -> PWM = 0%
            // duty = 512 -> PWM = 50%
            // duty = 1023 -> PWM = 100%
            // Le registre du duty est composer de deux parties
            CCPR1L = duty >> 2;              // 8 MSB -> CCPRIL = duty - 2 LSB (c'est le regiustre des 8 bits de poids forts)
            CCP1CONbits.DC1B = duty & 0x03;  // 2 LSB -> CCP1CONbits.DC1B = duty - 8 MSB (registre des 2 bits de poids faible)
            __delay_ms(2);
        }

        // On éteint
        for (int duty = 1022; duty >= 0; duty--)
        {
            CCPR1L = duty >> 2;
            CCP1CONbits.DC1B = duty & 0x03;
            __delay_ms(2);
        }
    }
}
