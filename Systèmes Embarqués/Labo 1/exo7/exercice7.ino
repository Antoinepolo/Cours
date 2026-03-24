#define LED 3
#define POT A0

void setup() {
  // On n'a pas besoin de mettre les broches analogiques dans le setup
  pinMode(LED, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  int valeurPotentiometre = analogRead(POT);
  Serial.println(valeurPotentiometre);
  // On convertit la valeur du analogRead (entre 0 et 1023, 10 bits) en 8 bits, donc de 0 à 255
  analogWrite(LED, map(valeurPotentiometre, 0, 1023, 0, 255));
}