#SingleInstance Force
; #Warn - for help debugging

#Include "C:\dev\ahk_scripts\lib\spongebob.ahk"
#Include "C:\dev\ahk_scripts\lib\windowmanager.ahk"

::@@::anthonyfox1988@gmail.com

; Keys
; ^ = Ctrl
; ! = Alt
; + = Shift
; # = Win

; sPoNgEbOb tExT LoL
^+v::PasteSpongebobText()

; Mission control
^Up:: 
{
    Send "{LWin down}{Tab}{LWin up}"
}

; Application hotkeys
F9::WindowManager.SwitchToApp("wezterm-gui.exe")
F10::WindowManager.SwitchToApp("firefox.exe")
F11::WindowManager.SwitchToApp("Discord.exe")

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
