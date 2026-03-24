/*
Réalisez un programme permettant d’allumer une LED si le message « ON » est envoyé par le moniteur série et l’éteindre avec le message « OFF ».
*/

#define LED 3

String etat = "OFF";

void setup() {
    pinMode(LED, OUTPUT);
    Serial.begin(9600);
}

void loop() {
  // On vérifie qu'il y a quelques chose dans le buffer
  if(Serial.available() > 0) {
    etat = Serial.readString();
    etat.trim();
  }

  // Si On
  if(etat == "ON") {
    digitalWrite(LED, HIGH);
  }

  // Si OFF
  if(etat == "OFF") {
    digitalWrite(LED, LOW);
  }
}