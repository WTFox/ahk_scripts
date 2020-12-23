#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

; dbd-launcher.ahk
;
; This script makes running DeadByDaylight on a widescreen monitor little less dumb.
;
; It does the following:
;
; - Sets resolution to DBDResolutionX x DBDResolutionY
; - Launches DeadByDaylight
; - Checks every two seconds to see if the game has exited
; - Once DBD exits, this script sets the resolution back to ResolutionX x ResolutionY
;
; Author: /u/wtfox

STEAM_ID := 381210

; Set these values to the resolution you normally have. They default to the resolution
; of your monitor.
ResolutionX := A_ScreenWidth
ResolutionY := A_ScreenHeight

; This will be the resolution in which DBD runs
DBDResolutionX := 2560
DBDResolutionY := 1440

ChangeResolution(DBDResolutionX, DBDResolutionY)

Run, steam://rungameid/%STEAM_ID%
WinWaitActive, DeadByDaylight

Loop
{
    Sleep 1000
    If !ProcessExist("DeadByDaylight-Win64-Shipping.exe")
    {
        ChangeResolution(ResolutionX, ResolutionY)
        ExitApp
    }
}

; --- Helper Functions ---

ChangeResolution(Screen_Width, Screen_Height, Color_Depth:=32)
{
    VarSetCapacity(Device_Mode, 156, 0)
    NumPut(156, Device_Mode, 36)
    DllCall("EnumDisplaySettingsA", UInt, 0, UInt, -1, UInt, &Device_Mode)
    NumPut(0x5c0000, Device_Mode, 40)
    NumPut(Color_Depth, Device_Mode, 104)
    NumPut(Screen_Width, Device_Mode, 108)
    NumPut(Screen_Height, Device_Mode, 112)

    Return DllCall("ChangeDisplaySettingsA", UInt, &Device_Mode, UInt, 0)
}

ProcessExist(Name){
    Process, Exist, %Name%
    return Errorlevel
}
