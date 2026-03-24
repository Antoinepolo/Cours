/*
Consignes :

Réalisez un programme qui permet lors de l’appui sur un bouton poussoir de compter le nombre de secondes écoulées avec le bouton enfoncé.
*/

// Question : On doit utiliser un const int, ou un define ?

#define BOUTON 13

bool estAppuye = false; // On le met à false au début
long finAppuie = 0;
long debutAppuie = 0;

void setup() {
  pinMode(BOUTON, INPUT_PULLUP);
  Serial.begin(9600);
}

void loop() {
  bool etatBouton = !digitalRead(BOUTON);

  // Si le bouton est enfoncé  et que le bouton n'est pas déjà enfoncé, alors on l'indique comme enfoncé, et on affecte le début de l'appuie au temps actuel
  if(etatBouton && !estAppuye) {
    estAppuye = true;
    debutAppuie = millis();
  }

  // Si on relache le bouton
  if(!etatBouton && estAppuye) {
    estAppuye = false;
    finAppuie = millis();
    float dureeAppuie = (finAppuie - debutAppuie) / 1000.0; // On divise par 1000 pour avoir des secondes
    Serial.print("Bouton enfoncé appuye pendant ");
    Serial.print(dureeAppuie, 2);
    Serial.println(" secondes");
  }
}