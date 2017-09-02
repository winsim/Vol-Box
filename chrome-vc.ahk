; >> Google Chrome Volume Control <<

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
!F10::   ;Alt+F10
IfWinExist ahk_class Chrome_WidgetWin_1
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
    if (ControlName ~= "Mute for.*- Google Chrome")
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
!F11::   ;Alt+F11
IfWinExist ahk_class Chrome_WidgetWin_1
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
    if (ControlName ~= "Mute for.*- Google Chrome")
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

;>> Google Chrome Mute <<

#NoEnv  ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn  ; Enable warnings to assist with detecting common errors.
SendMode Input  ; Recommended for new scripts due to its superior speed and reliability.
;SetWorkingDir %A_ScriptDir%  ; Ensures a consistent starting directory.
;SetWorkingDir %A_MyDocuments%\AutoHotkey\Lib\
#Include <VA>


;Hotkey to mute volume
!F12::   ;Alt+F12
  WinGet, ActivePid, PID, A
  if !(Volume := GetVolumeObject(ActivePid))
    MsgBox, There was a problem retrieving the application volume interface
  VA_ISimpleAudioVolume_GetMute(Volume, Mute)  ;Get mute state
  Msgbox % "Google Chrome " ActivePID " is currently " (mute ? "muted" : "not muted")
  VA_ISimpleAudioVolume_SetMute(Volume, !Mute) ;Toggle mute state
  ObjRelease(Volume)
return

;Required for app specific mute
GetVolumeObject(Param = 0)
{
    static IID_IASM2 := "{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}"
    , IID_IASC2 := "{bfb7ff88-7239-4fc9-8fa2-07c950be9c6d}"
    , IID_ISAV := "{87CE5498-68D6-44E5-9215-6DA47EF883D8}"
    
    ; Get PID from process name
    if Param is not Integer
    {
        Process, Exist, %Param%
        Param := ErrorLevel
    }
    
    ; GetDefaultAudioEndpoint
    DAE := VA_GetDevice()
    
    ; activate the session manager
    VA_IMMDevice_Activate(DAE, IID_IASM2, 0, 0, IASM2)
    
    ; enumerate sessions for on this device
    VA_IAudioSessionManager2_GetSessionEnumerator(IASM2, IASE)
    VA_IAudioSessionEnumerator_GetCount(IASE, Count)
    
    ; search for an audio session with the required name
    Loop, % Count
    {
        ; Get the IAudioSessionControl object
        VA_IAudioSessionEnumerator_GetSession(IASE, A_Index-1, IASC)
        
        ; Query the IAudioSessionControl for an IAudioSessionControl2 object
        IASC2 := ComObjQuery(IASC, IID_IASC2)
        ObjRelease(IASC)
        
        ; Get the session's process ID
        VA_IAudioSessionControl2_GetProcessID(IASC2, SPID)
        
        ; If the process name is the one we are looking for
        if (SPID == Param)
        {
            ; Query for the ISimpleAudioVolume
            ISAV := ComObjQuery(IASC2, IID_ISAV)
            
            ObjRelease(IASC2)
            break
        }
        ObjRelease(IASC2)
    }
    ObjRelease(IASE)
    ObjRelease(IASM2)
    ObjRelease(DAE)
    return ISAV
}
 
;
; ISimpleAudioVolume : {87CE5498-68D6-44E5-9215-6DA47EF883D8}
;
VA_ISimpleAudioVolume_SetMasterVolume(this, ByRef fLevel, GuidEventContext="") {
    return DllCall(NumGet(NumGet(this+0)+3*A_PtrSize), "ptr", this, "float", fLevel, "ptr", VA_GUID(GuidEventContext))
}
VA_ISimpleAudioVolume_GetMasterVolume(this, ByRef fLevel) {
    return DllCall(NumGet(NumGet(this+0)+4*A_PtrSize), "ptr", this, "float*", fLevel)
}
VA_ISimpleAudioVolume_SetMute(this, ByRef Muted, GuidEventContext="") {
    return DllCall(NumGet(NumGet(this+0)+5*A_PtrSize), "ptr", this, "int", Muted, "ptr", VA_GUID(GuidEventContext))
}
VA_ISimpleAudioVolume_GetMute(this, ByRef Muted) {
    return DllCall(NumGet(NumGet(this+0)+6*A_PtrSize), "ptr", this, "int*", Muted)
}
Return