#Persistent
#SingleInstance Force
#InstallKeybdHook
#NoEnv
#HotkeyInterval 2000
#MaxThreadsPerHotkey 1
#Warn

#Include A_ScriptDir "\lib\clipboard.ahk"
#Include A_ScriptDir "\lib\hazeover.ahk"
#Include A_ScriptDir "\lib\magnet.ahk"
#Include A_ScriptDir "\lib\keys.ahk"

::@@::anthonyfox1988@gmail.com

; Dim everything but the active window
^!d::ToggleDim()

; Open clipboard history
^+v::ShowClipboardMenu()

; Application hotkeys
F9::WindowManager.SwitchToApp("wezterm-gui.exe")
F10::WindowManager.SwitchToApp("firefox.exe")
F11::WindowManager.SwitchToApp("Discord.exe")

; Mission control
^Up::Send {LWin down}{Tab}{LWin up}

; Hotkeys for moving windows around
!^e::WindowManager.LeftTwoThirds()
!^r::WindowManager.SixteenNineCentered()
!^s::WindowManager.StreamerRes()
!^y::WindowManager.SixteenNine()
!^h::WindowManager.LeftHalf()
!^l::WindowManager.RightHalf()
!^t::WindowManager.RightTwoThirds()
!^d::WindowManager.LeftThird()
!^f::WindowManager.MiddleThird()
!^g::WindowManager.RightThird()
!^j::WindowManager.BottomLeftQuarter()
!^k::WindowManager.BottomRightQuarter()
!^u::WindowManager.TopLeftQuarter()
!^i::WindowManager.TopRightQuarter()
!^Enter::WindowManager.FullScreen()
!^c::WindowManager.Centered()
!^m::WindowManager.FocusView()
!^=::WindowManager.Expand()
!^-::WindowManager.Shrink()
!^BackSpace::WindowManager.Undo()
