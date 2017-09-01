# Vol-Box
> A fairly simple project to create a 'USB Volume Control Box' using an Arduino Pro Micro 5v clone, AutoHotKey scripts and my Logitech X-240's original remote controller PCB.


One to two paragraph statement about your product and what it does.

![](header.png)

## Bill of Materials (for Arduino part of project) -
### Microcontroller -
   * Arduino Pro Micro (5V, 16MHz)
### Resistors - 
   * 10x 10k Ω
   * 3x 220 Ω
### LEDs - 
   * 3x Red LEDs (panel-mount)
### Electromechanical - 
   * 2x SPST MOM NO push button (1x for Source and 1x for Arduino Reset)
   * 3x Rotary encoders with switches (5-pin)  
### Other - 
   * 4x PCB standoffs
   * 3x Knobs
   * 1x Enclosure
   
   
## Bill of Materials (for Logitech X-240 rework) -
### LEDs - 
   * 1x Orange LED (panel-mount)
### Electromechanical - 
   * 1x 10k Ω LOG potentiometer
   * 1x 10k Ω LOG DUAL-GANG (STEREO) potentiometer
### Other - 
   * 4x PCB standoffs
   * 2x Knobs
   * 1x Enclosure (both the Arduino part and Logitech part will go in the same enclosure)



## Installation -

### OS X & Linux:

```sh
UPDATE ME!
```

### Windows:

1. Download and install the Arduino IDE - (LINK)
2. Download and install SoundSwitch (optional) - (LINK)
3. 


## Arduino Code -




## Release History -

* 0.0.3 - Sep 01, 2017
    * Add: Third LED to Arduino Code
    * Add: Third rotary encoder to Arduino Code
    * Add: 'VA.ahk' to: '...\Resources'
    * Add: 'panic-button.ahk', press esc to terminate all running AHK scripts
    * Add: 'chrome-vc.ahk' to: '...\Code\AutoHotKey Scripts'
    * Add: 'dirt_rally-vc.ahk' to: '...\Code\AutoHotKey Scripts'
    * Add: 'dirt_4-vc.ahk' to: '...\Code\AutoHotKey Scripts'
    * Remove: 'chrome-nomute.ahk'
    * Remove: 'dirt_rally-nomute.ahk'
    * Remove: 'dirt_4-nomute.ahk'
    
* 0.0.2 - Aug 31, 2017
    * Add: 'chrome-nomute.ahk' to: '...\Code\AutoHotKey Scripts'
    * Add: 'dirt_rally-nomute.ahk' to: '...\Code\AutoHotKey Scripts'
    * Add: 'dirt_4-nomute.ahk' to: '...\Code\AutoHotKey Scripts'
    
* 0.0.1 - Aug 29, 2017
    * Work in progress

## Meta -

Kyle Gilmour – [@YourTwitter](https://twitter.com/dbader_org) – winsimdevices@gmail.com

Distributed under the MIT license. See ``LICENSE`` for more information.

[https://github.com/winsim/Vol-Box](https://github.com/winsim/Vol-Box/)


<!-- Markdown link & img dfn's -->
[wiki]: https://github.com/winsim/Vol-Box/wiki
