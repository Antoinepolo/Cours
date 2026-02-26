/*
 * File:   eeprom.c
 * Author: Antoine Polo
 *
 * Created on February 24, 2026, 11:44 AM
 */

#include "eeprom.h"

uint8_t EEPROM_read(uint16_t uiAddress, uint8_t *data)
{
    if(uiAddress > EEPROM_SIZE)                                             // On vérifie la taille de l'adresse demandée
    {
        return EEPROM_INVALID_ADDR;                                         // On retourne une erreur si elle dépasse la limite
    }
    
    while(EECR & (1<<EEPE));                                                // On attend que toute écrite précédente soit terminée
    // Configurer le registre d'adresse (16 bits séparer en 2)  
    EEARH = (uiAddress & 0xFF00) >> 8;                                      // Partie haute
    EEARL = (uiAddress & 0x00FF);                                           // Partie basse

    EECR |= (1<<EERE);                                                      // On lance la lecture
    
    // On récupère les données dans le registre et on donner au copie via le pointeur
    *data = EEDR;
    return EEPROM_OK;
}

uint8_t EEPROM_write(uint16_t uiAddress, uint8_t ucData)
{
    if(uiAddress > EEPROM_SIZE)                                             // On vérifie la taille de l'adresse demandée
    {
        return EEPROM_INVALID_ADDR;                                         // On retourne une erreur si elle dépasse la limite
    }
    
    while(EECR & (1<<EEPE));                                                // On attend que toute écrite précédente soit terminée
    // Configurer le registre d'adresse (16 bits séparer en 2)
    EEARH = (uiAddress & 0xFF00) >> 8;                                      // Partie haute
    EEARL = (uiAddress & 0x00FF);                                           // Partie basse
    EEDR = ucData;                                                          // Charge la donnée
    
    EECR |= (1<<EEMPE);                                                     // On met à 1 le bit Master Write Enable
    EECR |= (1<<EEPE);                                                      // Ecrire la valeur
    return EEPROM_OK;
}

uint8_t EEPROM_update(uint16_t uiAddress, uint8_t ucData)
{
    uint8_t err = EEPROM_OK;                                                // Variable pour stocker les erreurs
    if(uiAddress > EEPROM_SIZE)                                             // Si l'adresse dépasse la taille maxile
    {
        return EEPROM_INVALID_ADDR;                                         // On retourne une erreur
    }
    uint8_t value = 0;                                                      // Variable pour stockée la valeur lue
    
    err = EEPROM_read(uiAddress, &value);                                   // On lit la valeur actuelle à l'adresse                      
    if(err != EEPROM_OK)                                                    // Si il y a eu une erreur
    {
        return err;                                                         // On retourne l'erreur
    }
    
    if(value == ucData)                                                     // Si la valeur est la bonne on ne change pas
    {
        return EEPROM_OK;                                                   // Et on retourne un code OK
    }
    
    err = EEPROM_write(uiAddress, ucData);                                  // On écrit la valeur
    if(err != EEPROM_OK)                                                    // Si il y a eu une erreur
    {
        return err;                                                         // On la renvoie
    }
    
    err = EEPROM_read(uiAddress, &value);                                   // On vérifie si la valeur écrite est la bonne
    if(err != EEPROM_OK)                                                    // Si on a eu une erreur
    {
        return err;                                                         // On la retourne
    }
    if(value != ucData)                                                     // Si la valeur n'est pas la bonne
    {
        return EEPROM_WRITE_FAIL;                                           // On retourne une erreur d'écriture
    }
    
    return EEPROM_OK;                                                       // Si il n'y a pas eu d'écriture ou retourne un code OK
}

uint8_t EEPROM_update_batch(uint16_t uiAddress, void *data, uint16_t len)   // Fonction d'écriture en bloc
{
    uint16_t i = 0;                                                         // Variable d'itération
    uint8_t err = EEPROM_OK;                                                // Variable pour les erreurs
    uint8_t *data_cast = (uint8_t *)data;                                   // On transforme le pointeur générique (void) en pointeur d'octet (uint8_t)
    
    for(i = 0; i < len; i++)                                                // On boucle sur la longueur a écrire
    {
        err = EEPROM_update(uiAddress + i, data_cast[i]);                   // On appelle la fonction updatepour chaque octet en incrémentant l'adresse
        if(err != EEPROM_OK)                                                // Si on a une erreur
        {
            return err;                                                     // On la retourne
        }
    }
    
    return EEPROM_OK;                                                       // Si il n'y a pas eu d'erreur, on retourne OK
}

uint8_t EEPROM_read_batch(uint16_t uiAddress, void *data, uint16_t len)     // Fonction pour lire en bloc
{
    uint16_t i = 0;                                                         // Variable pour la boucle
    uint8_t err = EEPROM_OK;                                                // Variable pourles erreurs
    uint8_t *data_cast = (uint8_t *)data;                                   // Cast le type void en uint8_t
    
    for(i = 0; i < len; i++)                                                // Boucle sur la longueur à lire
    {
        err = EEPROM_read(uiAddress + i, &data_cast[i]);                    // On lit octet par octet
        if(err != EEPROM_OK)                                                // Si on a une erreur
        {
            return err;                                                     // On la retourne
        }       
    }
    
    return EEPROM_OK;                                                       // Sinon on retourne un code OK
}