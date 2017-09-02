; >> DiRT 4 Volume Control <<

SetTitleMatchMode, 3
SndVolWasStarted = 0

;Turn off SndVol after 1 second 
Loop {
  Sleep, 10
  If SndVolWasStarted = 1
  {
    GetKeyState, StateF1, F1
    GetKeyState, StateF2, F2
    If (StateF1 = "D" or StateF2 = "D")
    SndVolStartTime = %A_Now%
      Else {
        If ((A_Now - SndVolStartTime > 1) and WinExist("ahk_class #32770"))
        WinClose, ahk_class #32770
      }
    IfWinNotExist, ahk_class #32770
    SndVolWasStarted = 0
  }
}

;Hotkey to decrease volume
^F10::   ;Crtl+F10
IfWinExist, DiRT 4 
{
  IfWinNotExist, ahk_class #32770
  {
    Run, "%A_WinDir%\System32\SndVol.exe" -r 88888888
    WinWait, ahk_class #32770
    SndVolWasStarted = 1
  }
  ToolbarWindowNumber = 322
  msctls_trackbarNumber = 321
  Loop {
    ControlGetText, ControlName, ToolbarWindow%ToolbarWindowNumber%, ahk_class #32770
    If ControlName = Mute for DiRT 4
    {
      ControlSend, msctls_trackbar%msctls_trackbarNumber%, {Down 2}, ahk_class #32770 ; Use {Down 2} to change sound level faster
      Break
    } Else {
      If ToolbarWindowNumber < 328
      {
        ToolbarWindowNumber := ToolbarWindowNumber + 2
        msctls_trackbarNumber := msctls_trackbarNumber + 1
      } Else {
        If ToolbarWindowNumber = 328
        {
          ToolbarWindowNumber = 3210
          msctls_trackbarNumber := msctls_trackbarNumber + 1
        } Else {
          If ToolbarWindowNumber < 3242
          {
            ToolbarWindowNumber := ToolbarWindowNumber + 2
            msctls_trackbarNumber := msctls_trackbarNumber + 1
          } Else {
            MsgBox, 16, AutoHotkey, ERROR: Application's volume control was not found!`nThis could occur if the Volume Mixer has more than 20 opened applications
            Break
          }
        }
      }
    }
  }
}
Return

;Hotkey to increase volume
^F11::   ;Crtl+F11
IfWinExist, DiRT 4
{
  IfWinNotExist, ahk_class #32770
  {
    Run, "%A_WinDir%\System32\SndVol.exe" -r 88888888
    WinWait, ahk_class #32770
    SndVolWasStarted = 1
  }
  ToolbarWindowNumber = 322
  msctls_trackbarNumber = 321
  Loop {
    ControlGetText, ControlName, ToolbarWindow%ToolbarWindowNumber%, ahk_class #32770
    If ControlName = Mute for DiRT 4
    {
      ControlSend, msctls_trackbar%msctls_trackbarNumber%, {Up 2}, ahk_class #32770 ; Use {Up 2} to change sound level faster
      Break
    } Else {
      If ToolbarWindowNumber < 328
      {
        ToolbarWindowNumber := ToolbarWindowNumber + 2
        msctls_trackbarNumber := msctls_trackbarNumber + 1
      } Else {
        If ToolbarWindowNumber = 328
        {
          ToolbarWindowNumber = 3210
          msctls_trackbarNumber := msctls_trackbarNumber + 1
        } Else {
          If ToolbarWindowNumber < 3242
          {
            ToolbarWindowNumber := ToolbarWindowNumber + 2
            msctls_trackbarNumber := msctls_trackbarNumber + 1
          } Else {
            MsgBox, 16, AutoHotkey, ERROR: Application's volume control was not found!`nThis could occur if the Volume Mixer has more than 20 opened applications
            Break
          }
        }
      }
    }
  }
}
Return