/*
Réalisez un programme qui permet, lors de l’appui sur un bouton poussoir, d’afficher les 26 lettres de l’alphabet (délai de 200 ms entre chaque lettre).
Si le BP est toujours enclenché après l’affichage des 26 lettres, l’affichage recommence.
Indice : utilisez des variables de type char ainsi que le code ASCII
*/

#define BOUTON 13

const int delais = 200;
char carac = 65;
long heureBase = millis();

void setup() {
  pinMode(BOUTON, INPUT_PULLUP);
  Serial.begin(9600);
}

void loop() {
  // On récupère l'heure actuelle
  long heureActuelle = millis();

  // On boucle temps que le bouton est appuye
  bool etatBouton = !digitalRead(BOUTON);

  if(etatBouton) {
    // On affiche avec un delais de 200ms

    if((heureActuelle - heureBase) >= delais) {
      heureBase = heureActuelle;
      Serial.println(carac);

      // On vérifie si le caractère ne dépasse pas le Z (90)
      if(carac < 90) {
        carac ++;
      } else {
        carac = 65;
      }
    }
  }
}