#define LED 2
#define BOUTON 3

/*
On doit pouvoir allumer et étteindre une LED (et qu'elle reste dans son état) à l'aide d'un bouton poussoir.
Soucis, si on fait juste un programme de base quand on appuie sur le bouton cela risque d'être interpreter comme plein d'appuie
*/

bool etatLed = LOW;                                                           // Etat de la LED (LOW de base)
bool dernierEtatBouton = HIGH;                                                // On stocke le dernier état du bouton
int dernierAppui = 0;                                                         // Temps du dernière appuie sur le bouton
const int delai = 50;                                                         // Delai de 50ms pour éviter les problèmes de rebond

void setup() {
  pinMode(BOUTON, INPUT_PULLUP);
  pinMode(LED, OUTPUT);
}

void loop() {
  bool etatBouton = digitalRead(BOUTON);
  
  if(etatBouton == LOW && dernierEtatBouton == HIGH) {                        // On detecte si il y a eu ou non un changement d'etat sur le bouton

    if((millis() - dernierAppui) > delai) {                                   // On regarde si le delai s'est écouler ou pas, si non on ne rentre pas dans le if
      etatLed = !etatLed;                                                     // Si le delai est écouler, on inverse l'etat de la led, et modifie le temps du dernierAppuie
      digitalWrite(LED, etatLed);
      dernierAppui = millis();
    }
  }

  dernierEtatBouton = etatBouton;                                             // On définit le dernier etat du bouton sur l'etat actuel
}