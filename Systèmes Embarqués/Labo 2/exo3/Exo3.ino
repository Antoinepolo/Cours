/*
Consigne :

Réalisez un programme permettant d’afficher en continu la valeur de luminosité perçue par une photorésistance dans le circuit adéquat (voir figure 3) avec la lecture analogique.
*/

#define PhotoResistance A0

void setup() {
  pinMode(PhotoResistance, INPUT);
  Serial.begin(9600);
}

void loop() {
  int valeur = analogRead(PhotoResistance);
  Serial.println(valeur);
}