# **Vol-Box**
> A fairly simple project to create a 'USB Volume Control Box' using an Arduino Pro Micro 5v clone and AutoHotKey scripts. As well as integrating my Logitech X-240's original remote controller PCB and the bass control knob from the back of the sub box (such a horrid deisgn..) into the same enclosure as the Arduino.

###### _The Plan:_ 
 centralize ALL audio controls into one small(ish) space on my desk. Including:
   * Main volume control for Logitech X-240 speakers
   * Bass volume control for Logitech X-240 sub woofer
   * Main volume control and mute for computer via USB (done using NicoHood's HID library)
   * Google Chrome volume control and mute via USB (done using AutoHotkey Scripts)
   * Customizable game volume control and mute via USB (done using AutoHotkey Scripts)
   * 3x LEDs to show muted states of rotary encoders
   * Push button to change audio output/source (done using SoundSwitch)
###### _Why:_
   * the lightweight, always in the way or always falling off the back of my desk, often unreachable remote control for my Logitech X-240 speakers really doesn't fit at all into my computer setup and is often pushed off to the back of my desk behind the monitors and the control for the bass is located on the back of the sub box, which is also often pushed to the back of my desk making it very, very difficult to adjust the bass
   * also being as I watch a lot of Netflix and am often forced into changing the volume of whatever I'm watching via the slider given with the player, again this is a hassle.. wouldn't it be great just to have a knob to adjust the volume of Google Chrome within the volume mixer? I think it would! 
   * another problem I'm often faced with is adjusting the volume of fullscreened games.. this can be such a headache! The solution.. a knob to adjust the volume of whatever game (will have a short setup process due to having to change scripts around to your needs) I'm playing at the time within the volume mixer! 
   * sometimes you just have to adjust the master volume within the volume mixer.. soooo.. yet again, ANOTHER KNOB! Plus there's left over pins to play with! 
###### _How:_
   * Finish me! 

### _Overall Schematic: _

![](pictures/VOLBOX-breakout-final_v1_bb.jpg)

##### _Part One - Logitech X-240 Rework -_ 
###### _Step One -_ 
  * Remove PCB from inside of sub box
  * Desolder original potentiometer (bass control)
  * Solder 3x 18g wires in place of original potentiometer, secure with hot glue (I ended up using a computer PSU power cable with the                                                                                     ends cut off)
  * Feed wire through back of box and put the PCB back in place
###### _Step Two -_ 
  * Remove PCB from inside of the remote control
  * Desolder original sidewheel potentiometer (speaker volume) **BE CAREFUL! YOU MUST REMEMBER WHICH PINS WENT WHERE!**
  * Desolder original power LED
  * Solder 5x 24g wires in place of original potentiometer, secure with hot glue
  * Solder 2x 24g wires in place of original LED, secure with hot glue
  * Resecure original hot glue joints as they weren't secured very well
  * Cut 2x slots in the bottom of the enclosure to feed the PCB wires through
###### _Step Three -_
  * Drill appropriate holes in front of enclosure 
  * Mount PCB standoffs to controller board and secure to inside of enclosure with hot glue
  * Solder the other ends the 5x 24g wire to a dual-gang (stereo) potentiometer, jump the ground pins together **BE CAREFUL! THE PINOUT                                                                       ON THE BOARD IS REVERSED DUE TO CCW ROTATION TO TURN VOLUME UP!**
  * Solder the other ends of the 2x 24g wire to an orange panel-mount LED
  * Solder the other end of the new cable coming from the back of the sub box to a 10k Ω LOG potentiometer
  * Secure potentiometers and LED to front of enclosure
  * Close up and test out! 
  
###### _Schematic - _

![](pictures/VOLBOX-breakout-logitech_v1_bb.jpg)

##### _Part Two - Arduino USB Volume Control Project -_
###### _Step One -_
  * Finish me! 

###### _Schematic -_ 

![](pictures/VOLBOX-breakout-arduino_v1_bb.jpg)


#### _Bill of Materials (for Part One - Logitech X-240 Rework) -_
###### _LEDs - _
   * 1x Orange LED (panel-mount)
###### _Electromechanical - _
   * 1x 10k Ω LOG potentiometer
   * 1x 10k Ω LOG DUAL-GANG (STEREO) potentiometer
###### _Other -_ 
   * 4x PCB standoffs
   * 2x Knobs
   * 1x Enclosure (both the Arduino part and Logitech part will go in the same enclosure)

#### _Bill of Materials (for Part Two - Arduino USB Volume Control Project) -_
###### _Microcontroller -_
   * Arduino Pro Micro (5V, 16MHz)
###### _Resistors - _
   * 10x 10k Ω
   * 3x 220 Ω
###### _LEDs - _
   * 3x Red LEDs (panel-mount)
###### _Electromechanical - _
   * 2x SPST MOM NO push button (1x for Source and 1x for Arduino Reset)
   * 3x Rotary encoders with switches (5-pin)  
###### _Other - _
   * 4x PCB standoffs
   * 3x Knobs
   * 1x Enclosure



#### _Installation -_
###### _Windows:_
1. Download and install the Arduino IDE - (LINK)
2. Download the HID library - (LINK)
3. Copy and paste 'VA.ahk' from included "resources" folder into AutoHotkey's main library folder (default: C:\Users\USER\Documents\AutoHotkey\Lib)
4. Download and install SoundSwitch (optional) - (LINK)

###### _OS X & Linux:_
1. idk..



#### _Arduino Code -_
 Please download the sketch through the repository or through the download page on the wiki. Thanks!



#### _Credits - _
<!-- Markdown link & img dfn's -->
    * loiphin - [loiphin's tech](http://www.loiph.in/2014/09/arduino-leonardo-atmega32u4-based-usb.html/)
    * mrdavidjwatts - [USB-Volume-Control GitHub](https://github.com/mrdavidjwatts/USB-Volume-Control/)
    * alizaliz - [Giant USB Volume Knob](http://www.instructables.com/id/Giant-USB-Volume-Knob/)
    * Lexikos - [VA.ahk](https://github.com/ahkscript/VistaAudio/)

#### _Meta -_

Kyle Gilmour – [@YourTwitter](https://twitter.com/dbader_org) – winsimdevices@gmail.com

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/winsim/Vol-Box](https://github.com/winsim/Vol-Box/)


<!-- Markdown link & img dfn's -->
[wiki]: https://github.com/winsim/Vol-Box/wiki
