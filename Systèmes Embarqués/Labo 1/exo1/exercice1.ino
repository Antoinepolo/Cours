#define LED 12
#define BUTTON 1

void setup() {
  pinMode(BUTTON, INPUT_PULLUP);
  pinMode(LED, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  boolean etat = !digitalRead(BUTTON);
  digitalWrite(LED, etat);
}