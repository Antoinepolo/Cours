#define LED_1 12
#define LED_2 13
#define BUTTON_1 1
#define BUTTON_2 2

void setup() {
  pinMode(BUTTON_1, INPUT_PULLUP);
  pinMode(LED_1, OUTPUT);
  pinMode(BUTTON_2, INPUT_PULLUP);
  pinMode(LED_2, OUTPUT);
  Serial.begin(9600);
}

void loop() {
  boolean etat1 = !digitalRead(BUTTON_1);
  digitalWrite(LED_1, etat1);
  boolean etat2 = !digitalRead(BUTTON_2);
  digitalWrite(LED_2, etat2);
}
