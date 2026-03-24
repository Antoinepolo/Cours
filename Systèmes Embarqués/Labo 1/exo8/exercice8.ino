#define LED 3
#define BOUTON 2

#define SEUIL 500
#define DELAI 250
#define ECART 5

/*
Objectifs :

- Si on appuie rappidement, il fonctionne comme un télérupteur (exo 6)
- Si on appuie de manière prolonger il faut varier la lumineusité (vers le haut ou bas, inversement à la dernière fois)
*/

// On déclare les variables globales :
bool etatLed = false;
bool dernierEtatBouton = HIGH;
bool augmentation = false;
int lum = 10;
long dernierAppui = 0;

void setup() {
  pinMode(LED, OUTPUT);
  pinMode(BOUTON, INPUT_PULLUP);
  Serial.begin(9600);
}

void loop() {
  static bool variationEnCours = false;
  static long debutAppui = 0;
  bool etatBouton = digitalRead(BOUTON);


  /*======================================================================================================================*/

  // On reprend la vérification de l'exo 6 pour vérifier un changement d'état

  /*======================================================================================================================*/

  if(etatBouton == LOW && dernierEtatBouton == HIGH) {
    debutAppui = millis();
    variationEnCours = false;
  }

  /*======================================================================================================================*/

  // On s'occupe de la luminosité

  /*======================================================================================================================*/

  if (etatBouton == LOW && (millis() - debutAppui > DELAI)) {
    variationEnCours = true;

    if(augmentation) { // On gère une augmentation de la luminosité
      if(lum < 255) {
        lum += 5;
        if(lum > 255) {
          lum = 255; // Pour éviter un dépassement (impossible car coder sur 8 bits)
        }
      }
    } else {
      if (lum > 0) { // On gère une diminution de la luminosité
        lum -= 5;
        if(lum < 0) {
          lum = 0;
        }
      }
    }
    analogWrite(LED, lum);
    delay(50);
  }

  /*======================================================================================================================*/

  // On s'occupe du ON/OFF

  /*======================================================================================================================*/

  if(etatBouton == HIGH && dernierEtatBouton == LOW) {
    if(!variationEnCours) {
      etatLed = !etatLed;
      analogWrite(LED, etatLed ? lum : 0);
    } else {
      augmentation = !augmentation;
    }
  }

  // On définit le dernier etat du bouton sur l'etat actuel
  dernierEtatBouton = etatBouton;
}