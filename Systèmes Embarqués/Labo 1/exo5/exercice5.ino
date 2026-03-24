#define LED_1 12
#define LED_2 13

/*
On veut deux LEDs avec des clignotement à fréquence différente
LED 1 : 1Hz
LED 2 : 0.8H2
Les deux avec des Duty-Cycle de 50%

On doit donc trouver la période (T) de chaque LED avec T = 1/f

Notes : On travail avec des long par la fonction millis car le résultat peut dépasser la taille d'un int
*/

// On travail avec des ms donc 1 = 1000, mais la fréquence reste la même. La division par deux est pour le duty-cycle de 50%
float F1 = (1000 / 1) / 2;
float F2 = (1000 / 0.8) / 2;

// On init le temps de base (millis retourne le temps depuis lequel le programme a démarrer)
long heureBase1 = millis();
long heureBase2 = millis();

// On fait le listing des composants
void setup() {
  pinMode(LED_1, OUTPUT);
  pinMode(LED_2, OUTPUT);
  Serial.begin(9600);
}

void loop() {
    // On regarde l'heure actuelle avec millis
    long heureActuelle1 = millis();
    // Si le temps écouler depuis le dernier changement d'état (heureActuelle - heureBase) est suppérieur ou égal à la fréquence, on inverse l'état de la led
    if ((heureActuelle1 - heureBase1) >= F1) {
      // On redéfinit l'heure de base à l'heure actuelle
      heureBase1 = heureActuelle1;
      digitalWrite(LED_1, (!digitalRead(LED_1)));
    }

    long heureActuelle2 = millis();
    if ((heureActuelle2 - heureBase2) >= F2) {
      heureBase2 = heureActuelle2;
      digitalWrite(LED_2, (!digitalRead(LED_2)));
    }
}