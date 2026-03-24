/*
Réalisez un programme similaire à celui du point 3 mais celui-ci ne fonctionnera plus en continu mais avec un système de requête.
La luminosité ne sera affichée que lorsque le message « Lumi » est envoyé dans le moniteur série.
*/

#define PhotoResistance A0

String message;

void setup() {
    pinMode(PhotoResistance, INPUT);
    Serial.begin(9600);
}

void loop() {
  // On vérifie qu'il y a quelques chose dans le buffer
  if(Serial.available() > 0) {
    message = Serial.readString();
    message.trim();
  }
  
  // Si le message reçu est "Lumi" alors on affiche la luminausite
  if(message == "Lumi") {
    int valeur = analogRead(PhotoResistance);
    Serial.println(valeur);
    message = "";
  }
}
