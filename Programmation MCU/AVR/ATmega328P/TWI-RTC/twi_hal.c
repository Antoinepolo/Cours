/*
 * File:   twi_hal.c
 * Author: Antoine Polo
 *
 * Created on March 10, 2026, 6:07 PM
 */
 
#include "twi_hal.h"

volatile uint8_t status = 0xF8;                                                 // Variable pour stocker le status du module TWI

ISR(TWI_vect)                                                                   // Interrutpion déclenchée quand le module TWI finit une action
{
	status = (TWSR & 0xF8);                                                     // On set la flag de status au code d'état (on utilise un masque pour ne garder que l'utile)
}

static uint8_t twi_start(void)                                                  // Fonction pour générer une condition de start sur le bus I2C
{
	uint16_t i = 0;                                                             // Compteur pour la gestion du timeout
	TWCR = (1 << TWINT) | (1 << TWSTA) | (1 << TWEN) | (1 << TWIE);             // On configure le registre TWCR
    
    /*
       - TWINT : Efface le flag (mis à 1) pour lancer l'opération.
       - TWSTA : Demande au matériel de générer un signal START.
       - TWEN  : Active le module TWI (Two Wire Interface).
       - TWIE  : Active l'interruption TWI pour mettre à jour la variable 'status'.
    */
	
	while(status != TWI_START)                                                  // Boucle d'attente, on attend que l'ISR confirme le succès du start
    {
		i++;                                                                    // On incrémente le compteur de sécurité
		if(i >= TWI_TIMEOUT)                                                    // Si le bus est occupé ou bloqué (on atteint le timeout)
        {
			return TWI_ERROR_START;                                             // On sort avec une erreur
		}
	}
	return TWI_OK;                                                              // Si tout c'est bien passé, on retourne un code bon 
}

static void twi_stop(void)                                                      // Fonction pour généré une condition stop (libérer le bus I2C)
{
	
	TWCR = (1 << TWINT) | (1 << TWSTO) | (1 << TWEN) | (1 << TWIE);             // On configure le registre TWCR
    
    /*
       - TWINT : Mis à 1 pour effacer le flag et exécuter la commande.
       - TWSTO : Demande l'envoi de la condition de STOP sur le bus.
       - TWEN  : Maintient le module TWI activé.
       - TWIE  : Active l'interruption (bien que le STOP ne génère pas d'interruption TWI).
    */
}

static uint8_t twi_restart(void)                                                // Fonction pour générer un repeated start, c'est utile pour passer de lecture à écriture
                                                                                // relâcher le bus
{
	uint16_t i = 0;                                                             // Compteur de sécurité pour le timeout
	TWCR = (1 << TWINT) | (1 << TWSTA) | (1 << TWEN) | (1 << TWIE);             // On configure le registre TWCR (comme pour le start)
	
	while(status != TWI_RSTART)                                                 // On attend que le status devienne TWI_RSTART
    {
		i++;                                                                    // On incrémente le compteur de sécurité
		if(i >= TWI_TIMEOUT)                                                    // Si on a atteint le timeout
        {
			return TWI_ERROR_START;                                             // On retourne une erreur
		}
	}
	return TWI_OK;                                                              // Si tout c'est bien passer, on retourne un message pour dire que c'est bon
}

static uint8_t twi_addr_write_ack(void)                                         // Fonction pour vérifier que l'esclave a bien reçu l'adresse en mode écriture et renvoyé un ACK
{
	uint16_t i = 0;                                                             // Compteur pour le timeout
	
	TWCR = (1 << TWINT) | (1 << TWEN) | (1 << TWIE);                            // On configure le registre TWCR
    
    /*
       - TWINT : Mis à 1 pour lancer la transmission de l'adresse (précédemment chargée dans TWDR).
       - TWEN  : Maintient le module TWI activé.
       - TWIE  : Active l'interruption pour capturer le code de statut.
    */
    
	while(status != TWIT_ADDR_ACK)                                              // Temps que le code de status ne vaut pas TWIT_ADDR_ACK
    {
		i++;                                                                    // On incrémente le compteur
		if(i >= TWI_TIMEOUT)                                                    // Si on atteint le tiemout
        {
			return TWI_ERROR_START;                                             // On retourne une erreur
		}
	}
	return TWI_OK;                                                              // Si tout c'est bien passé, on retourne un message d'OK
}

static uint8_t twi_data_write_ack(void)                                         // Fonction pour vérifier qu'un octet de donnée a bien été reçu par l'esclave avec un ACK
{
	uint16_t i = 0;                                                             // Compteur pour le timeout
	
	TWCR = (1 << TWINT) | (1 << TWEN) | (1 << TWIE);                            // On configure le registre TWCR
    
    /*
       - TWINT : Mis à 1 pour lancer la transmission de la donnée (chargée dans TWDR).
       - TWEN  : Module toujours actif.
       - TWIE  : Interruption active.
    */
    
	while(status != TWIT_DATA_ACK)                                              // Temps que le code de status ne vaut pas TWIT_DATA_ACK
    {
		i++;                                                                    // On incrémente le compteur
		if(i >= TWI_TIMEOUT)                                                    // Si on atteint le tiemout
        {
			return TWI_ERROR_START;                                             // On retourne une erreur                                          
		}
	}
	return TWI_OK;                                                              // Si tout c'est bien passé, on retourne un message d'OK
}

static uint8_t twi_addr_read_ack(void)                                          // Fonction pour vérifier que l'esclave a bien reçu l'adresse en mode lecture             
{
	uint16_t i = 0;                                                             // Compteur pour le timeout
	
	TWCR = (1 << TWINT) | (1 << TWEN) | (1 << TWIE);                            // On lance la transmission de l'adresse précédement chargée dans TWDR
	while(status != TWIR_ADDR_ACK)                                              // Temps que le code de status ne vaut pas TWIR_ADDR_ACK
    {
		i++;                                                                    // On incrémente le compteur
		if(i >= TWI_TIMEOUT)                                                    // Si on atteint le tiemout
        {
			return TWI_ERROR_START;                                             // On retourne une erreur                                             
		}
	}
	return TWI_OK;                                                              // Si tout c'est bien passé, on retourne un message OK
}

static uint8_t twi_data_read_ack(uint8_t ack)                                   // Fonction pour lire une donnée et choisir d'envoyer un ACK ou un NACK
{
	uint16_t i = 0;                                                             // Compteur pour le timeout
	if(ack != 0)                                                                // Si on demande un autre octet après celui ci (ACK)
    {
		TWCR = (1 << TWINT) | (1 << TWEN) | (1 << TWIE) | (1 << TWEA);          // On configure le registre TWCR pour générer un ACK après la réception
		while(status != TWIR_DATA_ACK)                                          // Temps qu'on a pas reçu le flag TWIR_DATA_ACK
        {
			i++;                                                                // On incrémente le compteur
			if(i >= TWI_TIMEOUT)                                                // Si on atteint le timeout
            {
				return TWI_ERROR_START;                                         // On renvoie un message d'erreur
			}
		}
	}
    else                                                                        // Si c'est le dernier octet, onrenvoie un NACK
    {
		
		TWCR = (1 << TWINT) | (1 << TWEN) | (1 << TWIE);                        // On configure le registre TWCR pour générer un NACK et signaler à l'esclave la fin du transfert
		while(status != TWIR_DATA_NACK)                                         // Temps que le status est différent de TWIR_DATA_NACK
        {
			i++;                                                                // On incrémente le compteur
			if(i >= TWI_TIMEOUT)                                                // Si on atteint le timeout
            {
				return TWI_ERROR_START;                                         // On retourne un message d'erreur
			}
		}
		
	}
	return TWI_OK;                                                              // Si tout c'est bien passé, on retourne un message OK
}

uint8_t twi_read(uint8_t addr,uint8_t reg,uint8_t *data,uint16_t len)           // Fonction pour lire une certaine longueur d'octet dans le registre d'un escalve
                                                                                // à une certaine adresse
{
	
	uint16_t i = 0;                                                             // Index pour parcourir le tableau de données
	uint8_t err = TWI_OK;                                                       // Variable pour stocker les erreurs
	
	err = twi_start();                                                          // On ouvre la communication
	if(err != TWI_OK)                                                           // Si il y a eu une erreur
    {
		twi_stop();                                                             // On stop la communication
		return err;                                                             // On retourne l'erreur
	}
	TWDR = (addr << 1) | 0;                                                     // On décale l'adresse de 1 bit vers la gauche et o met le bit de poid faible à 0
	
	
	err = twi_addr_write_ack();                                                 // On attend que l'esclave réponde
	if(err != TWI_OK)                                                           // Si on a une erreur
    {
		twi_stop();                                                             // On stop la communication
		return err;                                                             // On envoie une erreur
	}
	
	TWDR = reg;                                                                 // On charge le numéro de registre que l'on veut lire
	err = twi_data_write_ack();                                                 // On attend que l'escalve confirme la récection du numéro
	if(err != TWI_OK)                                                           // Si on a une erreur
    {
		twi_stop();                                                             // On stoppe le communication
		return err;                                                             // On retourne l'erreur
	}
	
	err = twi_restart();                                                        // On redémarre le bus pour changer de mode
	if(err != TWI_OK)                                                           // Si il y a eu une erreur
    {
		twi_stop();                                                             // On ferme la communication
		return err;                                                             // On retourne l'erreur
	}
	
	TWDR = (addr << 1) | 1;                                                     // On change le bit pour demander des données

	err = twi_addr_read_ack();                                                  // On sélectionner l'esclave en mode lecture
	if(err != TWI_OK)                                                           // Si on a une erreur
    {
		twi_stop();                                                             // On ferme la communication
		return err;                                                             // On renvoie l'erreur
	}
	
	for(i = 0; i < (len - 1);i++)                                               // On boucle pour la lecture
    {
		err = twi_data_read_ack(1);                                             // On lit l'octet et envoie un ACK
		if(err != TWI_OK)                                                       // Si on a une erreur
        {
			twi_stop();                                                         // On ferme la communication
			return err;                                                         // On retourne l'erreur
		}
		data[i] = TWDR;                                                         // On stocke l'octet reçu dans un tableau
	}
	
	err = twi_data_read_ack(0);                                                 // On lit le dernier octet et on envoie un NACK
	if(err != TWI_OK)                                                           // Si on a une erreur
    {
		twi_stop();                                                             // On ferme la communication
		return err;                                                             // On retourne une erreur
	}
	data[i] = TWDR;                                                             // On ajoute le dernier octet
	
	twi_stop();                                                                 // On ferme la communication
	
	return err;                                                                 // On retourne OK si tout c'est bien passé
}

uint8_t twi_wire(uint8_t addr,uint8_t reg,uint8_t *data,uint16_t len)           // Fonction pour écrire len octets dans un escalves a une adresse
{
	
	uint16_t i = 0;                                                             // Index pour le tableau de données
	uint8_t err = TWI_OK;                                                       // Variable pour stocker les erreurs
	
	err = twi_start();                                                          // On envoie un start 
	if(err != TWI_OK)                                                           // Si on a eu une erreure
    {
		twi_stop();                                                             // On ferme la communication
		return err;                                                             // On retourne le message d'erreur
	}
	TWDR = (addr << 1) | 0;                                                     // Adresse de l'escalve + bit R/W (ici W)
	
	
	err = twi_addr_write_ack();                                                 // On attend le ACK de l'esclave
	if(err != TWI_OK)                                                           // Si on a une erreur
    {
		twi_stop();                                                             // On ferme la communication
		return err;                                                             // On l'affiche
	}
            
	TWDR = reg;                                                                 // On charge l'index du registre à modifier
	err = twi_data_write_ack();                                                 // Attente de la réception de l'ACK
	if(err != TWI_OK)                                                           // Si on a une erreur
    {
		twi_stop();                                                             // On ferme la communication
		return err;                                                             // On retourne une erreur
	}
        
	for(i = 0; i < len;i++)                                                     // Boucle pour envoyer les données
    {
		TWDR = data[i];                                                         // Chargement de la donnée
		err = twi_data_write_ack();                                             // Envoie et attente de l'ACK
		if(err != TWI_OK)                                                       // Si on a une erreur
        {           
			twi_stop();                                                         // On ferme la communication
			return err;                                                         // On retourne l'erreur
		}
	}
	
	twi_stop();                                                                 // On ferme la communication

	return err;                                                                 // On envoie un message pour dire que tout c'est bien passé
}

void twi_init(uint32_t speed)                                                   // Fonction pour initialiser la vitesse du bus I2C
{
	
	uint32_t gen_t = 0;                                                         // Variable pour stocker le résultat du calcul                                                       
   
	gen_t = (((F_CPU/speed) - 16) / 2) & 0xFF;                                  // Calcul de TWBR : SCL frequency = F_CPU / (16 + 2 * TWBR * Prescaler)
    
	TWBR = gen_t & 0xFF;                                                        // On applique la valeur calculée au registre TWBR
        
	TWCR = (1 << TWEN) | (1 << TWIE);                                           // Configuration finale du module TWI

    /* 
       - TWEN : Active physiquement le module I2C
       - TWIE : Autorise les interruptions pour que l'ISR fonctionne
    */
}