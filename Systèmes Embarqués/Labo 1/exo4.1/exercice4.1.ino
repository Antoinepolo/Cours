#define LED_1 12
#define LED_2 13
#define BUTTON 2

#define TEMPS 500

// On init le temps
long heureBase = millis();

void setup() {
  pinMode(BUTTON, INPUT_PULLUP);
  pinMode(LED_1, OUTPUT);
  pinMode(LED_2, OUTPUT);
  Serial.begin(9600);
}

void loop() {
    // Bouton
    boolean etat = !digitalRead(BUTTON);
    digitalWrite(LED_1, etat);

    // Clignotement avec millis
    long heureActuelle = millis();
    if ((heureActuelle - heureBase) >= TEMPS) {
      heureBase = heureActuelle;
      digitalWrite(LED_2, (!digitalRead(LED_2)));
    }
}