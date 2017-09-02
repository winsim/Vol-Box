/*
   A fairly simple project to create a 'USB Volume Control Box' using rotary encoders and an Arduino with the ATmega32U4.
  I used a clone Arduino Pro Micro (Same design as Sparkfun's Pro Micro) but you could also use an Arduino Leonardo or Arduino Micro.
  This project requires the use of rotary encoders, which work in a much different way than a potentiometer. 
  The encoders that I used have a push button as well, this button will be used for muting. 

  Feel free to edit and use this code as you please!   
  - winsim 
*/


#include <Encoder.h>
// The rotary encoder library: https://github.com/PaulStoffregen/Encoder

#include <HID-Project.h>
// The HID library which produces the multimedia keys (Volume UP,DOWN and MUTE):  https://github.com/NicoHood/HID

int accel = 2;
// This is an acceleration factor. Use between 1 and 8 to suit how quickly the volume goes up or down.

const int mute0Pin = 4;
const int mute1Pin = 5;
const int mute2Pin = 8;
// The digital pins to which the rotary encoder push button is connected to. Assumes that the pin has a pull-down resistor.

int LED0 = 14;
int LED1 = 15;
int LED2 = 10;
// The digital pins to which the LEDs are connected to. 

const int buttonSource = 16;
// The digital pin to which the SoundSwitch button is connected to. 

Encoder encoder0(2, 3);
Encoder encoder1(7, 6);
Encoder encoder2(0, 1);
// These are the pins to which the rotary encoder is connected.
// Pins 0,1,2,3,7 are the interrupt pins on a Sparkfun Pro Micro 5V/16MHz, which give best performance with a rotary encoder. 
// Use other pins if you wish, but performance may suffer. Avoid using pins that have LED's attached.

long old0Position  = -999;
long old1Position  = -999;
long old2Position  = -999;
// Variables

int button0State;
int lastButton0State = LOW;
int button1State;
int lastButton1State = LOW;
int button2State;
int lastButton2State = LOW;
int stateSource = 0;
// Input States

long lastDebounceTime = 0;
long debounceDelay = 80;  // Button debounce time in millseconds. Increase if mute button doesnt work properly.
// Debounce

bool downSource = false;

void setup() {
  pinMode(mute0Pin, INPUT);
  pinMode(mute1Pin, INPUT);
  pinMode(mute2Pin, INPUT);
  pinMode(LED0, OUTPUT);
  pinMode(LED1, OUTPUT);
  pinMode(LED2, OUTPUT);
  pinMode(buttonSource, INPUT);
  
  Serial.begin(38400);
  Serial.println("Debug Output:");
  Consumer.begin();
  Keyboard.begin();


// Flash LEDs:
  digitalWrite(LED0, HIGH); delay(200);
  digitalWrite(LED1, HIGH); delay(200);
  digitalWrite(LED2, HIGH); delay(200);
  digitalWrite(LED0, LOW); delay(200);
  digitalWrite(LED1, LOW); delay(200);
  digitalWrite(LED2, LOW); delay(200);
    digitalWrite(LED0, HIGH); delay(200);
    digitalWrite(LED1, HIGH); delay(200);
    digitalWrite(LED2, HIGH); delay(200);
    digitalWrite(LED0, LOW); delay(200);
    digitalWrite(LED1, LOW); delay(200);
    digitalWrite(LED2, LOW); delay(200);
      digitalWrite(LED0, HIGH); delay(200);
      digitalWrite(LED1, HIGH); delay(200);
      digitalWrite(LED2, HIGH); delay(200);
      digitalWrite(LED0, LOW); delay(200);
      digitalWrite(LED1, LOW); delay(200);
      digitalWrite(LED2, LOW); delay(200);
      // Flashes the LEDs three (3) times upon start up
}



void loop() {



//Encoder 0 - MAIN MIXER VOLUME(NO MODIFIER)

  long new0Position = encoder0.read() / accel;
  if (new0Position != old0Position) {
    
    if(new0Position > old0Position) {
      Serial.println("Encoder 0 - MAIN UP");
      Consumer.write(MEDIA_VOLUME_UP);
    }
    
    if(old0Position > new0Position) {
      Serial.println("Encoder 0 - MAIN DOWN");
      Consumer.write(MEDIA_VOLUME_DOWN);
    }
    
    old0Position = new0Position;
    Serial.println(new0Position);
    
  }
  
  // read the state of the switch into a local variable:
  int reading0 = digitalRead(mute0Pin);

  // check to see if you just pressed the button 
  // (i.e. the input went from LOW to HIGH),  and you've waited 
  // long enough since the last press to ignore any noise:  

  // If the switch changed, due to noise or pressing:
  if (reading0 != lastButton0State) {
    // reset the debouncing timer
    lastDebounceTime = millis();
  } 
  
  if ((millis() - lastDebounceTime) > debounceDelay) {
    // whatever the reading is at, it's been there for longer
    // than the debounce delay, so take it as the actual current state:

    // if the button state has changed:
    if (reading0 != button0State) {
      button0State = reading0;
      
      // Toggle MUTE if digital pin reads HIGH
      if (button0State == HIGH) {
        digitalWrite(LED0, HIGH);
        Serial.println("Encoder 0 - MAIN MUTE");
        Consumer.write(MEDIA_VOLUME_MUTE);
      }
    }
  }
  // save the reading.  Next time through the loop,
  // it'll be the lastButtonState:
  
  lastButton0State = reading0;
  digitalWrite(LED0, LOW);
  
  
  
//Encoder 1 - GOOGLE CHROME VOLUME (ALT MODIFIER)

  long new1Position = encoder1.read() / accel;
  if (new1Position != old1Position) {
    
    if(new1Position > old1Position) {
      Serial.println("Encoder 1 - CHROME UP");
         Keyboard.press(HID_KEYBOARD_RIGHT_ALT);
         Keyboard.press(HID_KEYBOARD_F11);
         Keyboard.releaseAll();
    }
    if(old1Position > new1Position) {
      Serial.println("Encoder 1 - CHROME DOWN");
         Keyboard.press(HID_KEYBOARD_RIGHT_ALT);
         Keyboard.press(HID_KEYBOARD_F10);
         Keyboard.releaseAll();
    } 
    old1Position = new1Position;
    Serial.println(new1Position);  
  }
  
  // read the state of the switch into a local variable:
  int reading1 = digitalRead(mute1Pin);

  // check to see if you just pressed the button 
  // (i.e. the input went from LOW to HIGH),  and you've waited 
  // long enough since the last press to ignore any noise:  

  // If the switch changed, due to noise or pressing:
  if (reading1 != lastButton1State) {
    // reset the debouncing timer
    lastDebounceTime = millis();
  } 
  
  if ((millis() - lastDebounceTime) > debounceDelay) {
    // whatever the reading is at, it's been there for longer
    // than the debounce delay, so take it as the actual current state:

    // if the button state has changed:
    if (reading1 != button1State) {
      button1State = reading1;

      // Toggle MUTE if digital pin reads HIGH
      if (button1State == HIGH) {
        digitalWrite(LED1, HIGH);
        Serial.println("Encoder 1 - CHROME MUTE");
         Keyboard.press(HID_KEYBOARD_RIGHT_ALT);
         Keyboard.press(HID_KEYBOARD_F12);
         Keyboard.releaseAll();
      }
    }
  }
  
  // save the reading.  Next time through the loop,
  // it'll be the lastButtonState:
  lastButton1State = reading1;
  digitalWrite(LED1, LOW);



//Encoder 2 - GAME VOLUME (CRTL MODIFIER)

  long new2Position = encoder2.read() / accel;
  if (new2Position != old2Position) {
    
    if(new2Position > old2Position) {
      Serial.println("Encoder 2 - GAME UP");
         Keyboard.press(HID_KEYBOARD_RIGHT_CONTROL);
         Keyboard.press(HID_KEYBOARD_F11);
         Keyboard.releaseAll();
    }
    
    if(old2Position > new2Position) {
      Serial.println("Encoder 2 - GAME DOWN");
         Keyboard.press(HID_KEYBOARD_RIGHT_CONTROL);
         Keyboard.press(HID_KEYBOARD_F10);
         Keyboard.releaseAll();
    }
    
    old2Position = new2Position;
    Serial.println(new2Position);
    
  }
  
  // read the state of the switch into a local variable:
  int reading2 = digitalRead(mute2Pin);

  // check to see if you just pressed the button 
  // (i.e. the input went from LOW to HIGH),  and you've waited 
  // long enough since the last press to ignore any noise:  

  // If the switch changed, due to noise or pressing:
  if (reading2 != lastButton2State) {
    // reset the debouncing timer
    lastDebounceTime = millis();
  } 
  
  if ((millis() - lastDebounceTime) > debounceDelay) {
    // whatever the reading is at, it's been there for longer
    // than the debounce delay, so take it as the actual current state:

    // if the button state has changed:
    if (reading2 != button2State) {
      button2State = reading2;

      // Toggle MUTE if digital pin reads HIGH
      if (button2State == HIGH) {
        digitalWrite(LED2, HIGH);
        Serial.println("Encoder 2 - GAME MUTE");
         Keyboard.press(HID_KEYBOARD_RIGHT_CONTROL);
         Keyboard.press(HID_KEYBOARD_F12);
         Keyboard.releaseAll();
      }
    }
  }
  
  // save the reading.  Next time through the loop,
  // it'll be the lastButtonState:
  lastButton2State = reading2;
  digitalWrite(LED2, LOW);


// Source Button - SOUNDSWAP KEYBIND

  stateSource = digitalRead(buttonSource);

  if(downSource && stateSource == LOW){downSource = false;}

/* Send key combination for Sound Switch application */
   if (!downSource && stateSource == HIGH) { 
      Keyboard.press(HID_KEYBOARD_RIGHT_CONTROL);
      Keyboard.press(HID_KEYBOARD_RIGHT_ALT);
      Keyboard.press(HID_KEYBOARD_F9);
      Keyboard.releaseAll();
      downSource = true; // Only send command once per press
   }
}
