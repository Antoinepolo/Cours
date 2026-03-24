#define LED_1 12
#define LED_2 13

void setup() {
  pinMode(LED_1, OUTPUT);
  pinMode(LED_2, OUTPUT);
}

void loop() {
  digitalWrite(LED_1, HIGH);
  digitalWrite(LED_2, LOW);
  delay(500);
  digitalWrite(LED_1, LOW);
  digitalWrite(LED_2, HIGH);
  delay(500);
}