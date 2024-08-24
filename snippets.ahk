#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
#SingleInstance, force
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

:*:@@::anthonyfox1988@gmail.com

; shift + ctrl + 1 -> Terminal
; ^+1::SwitchToApp("wezterm-gui.exe")
; <F8> -> Terminal
F8::SwitchToApp("wezterm-gui.exe")

; shift + ctrl + 2 -> Firefox
; ^+2::SwitchToApp("firefox.exe")
; <F9> -> Firefox
F9::SwitchToApp("firefox.exe")

; shift + ctrl + 3 -> Discord
; ^+3::SwitchToApp("Discord.exe")
; <F10> -> Discord
F10::SwitchToApp("Discord.exe")

; ------------

SwitchToApp(name) {
  windowHandleId := WinExist("ahk_exe " name)
  windowExistsAlready := windowHandleId > 0

  ; If the Windows Terminal is already open, determine if we should put it in focus or minimize it.
  if (windowExistsAlready = true) {
    activeWindowHandleId := WinExist("A")
    windowIsAlreadyActive := activeWindowHandleId == windowHandleId

    if (windowIsAlreadyActive) {
      ; Minimize the window.
      WinMinimize, "ahk_id %windowHandleId%"
    } else {
      ; Put the window in focus.
      WinActivate, "ahk_id %windowHandleId%"
      WinShow, "ahk_id %windowHandleId%"
    }
  }
  ; Else it's not already open, so launch it.
  else {
    Run, wt
  }
}

