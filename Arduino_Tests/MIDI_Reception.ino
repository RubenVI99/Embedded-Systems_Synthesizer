#include <SoftwareSerial.h>
SoftwareSerial Serial1(2,3);       // Rx,Tx

#define LED         13              // Arduino Board LED is on Pin 13
#define LED_12      12              // Arduino Board LED is on Pin 12
#define NOTE_ON     144
#define NOTE_OFF    128
/*

    1. Inicializar Serial
        - 31.25kbps
        - 1 Start bit
        - 1 Stop bit
        - 8 bits de datos
    2. Recepción (buffer de 3 bytes)
        1. Confirmar recepción con byte de status
    3. Comentarios
        En teclado Rubén:
            Notas van de 21 - 108
            No hay Note Off. Se sustituye por velocidad 0
                - 144 (opcional) -> NOTA > VELOCIDAD.
                - NOTA -> 0
        Planteamiento: análisis por pares para que cuando llegue 0 sepamos que ese es el off.
*/

//variables setup

byte incomingByte;
byte note = 0;
byte velocity = 0;
int action = 2;         // 0 = note off; 1 = note on; 2 = nada


//setup: declaring iputs and outputs and begin serial
void setup() {
  pinMode(LED_12,OUTPUT);   // declare the LED's pin as output
  pinMode(LED,OUTPUT);   // declare the LED's pin as output
  Serial.begin(250000);       
  Serial1.begin(31250);
  digitalWrite(LED,LOW); 
  digitalWrite(LED_12,LOW); 
}

void loop () {
  if (Serial1.available() > 0) {
        incomingByte = Serial1.read();
        if(incomingByte >= 36 && incomingByte <= 83){
            Serial.println(incomingByte);
        }

        /* Note Off */
        if((incomingByte==0)){            // Note Off message starting 
            digitalWrite(LED,HIGH);
            digitalWrite(LED_12,LOW);
            action = 0;
        }
        if( (action == 0)&&(note == 0) ){
            // digitalWrite(LED,HIGH);
            note = incomingByte;
        }
        if( (action == 0)&&(note != 0) ){
            // digitalWrite(LED,HIGH);
            // velocity = incomingByte;
            action = 2;
        }
        /* Note On */
        if(incomingByte == 144){            // Note On message starting 
            digitalWrite(LED_12,HIGH);
            digitalWrite(LED,LOW);
            action = 1;
        }
        if( (action == 1)&&(note == 0) ){
            // digitalWrite(LED,HIGH);
            note = incomingByte;
        }
        if( (action == 1)&&(note != 0) ){
            velocity = incomingByte;
            action = 2;
        }
  }
}
