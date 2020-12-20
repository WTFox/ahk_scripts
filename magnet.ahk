#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
; #Warn ; Enable warnings to assist with detecting common errors.
#SingleInstance, force
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

; Window management
; Control + Win + X

; Left two thirds
#^e::ResizeAndMoveWindow(Round(A_ScreenWidth/3)*2, A_ScreenHeight, 0, 0)

; Right two thirds
#^t::ResizeAndMoveWindow(Round(A_ScreenWidth/3)*2, A_ScreenHeight, A_ScreenWidth-Round(A_ScreenWidth/3)*2, 0)

; Left third
#^d::ResizeAndMoveWindow(Round(A_ScreenWidth/3), A_ScreenHdfqeight, 0, 0)

; Middle third
#^f::ResizeAndMoveWindow(Round(A_ScreenWidth/3), A_ScreenHeight, A_ScreenWidth-Round((A_ScreenWidth/3)*2), 0)

; Right third
#^g::ResizeAndMoveWindow(Round(A_ScreenWidth/3), A_ScreenHeight, A_ScreenWidth-Round((A_ScreenWidth/3)*1), 0)

; Bottom left quarter
#^j::ResizeAndMoveWindow(Round(A_ScreenWidth/2), Round(A_ScreenHeight/2), 0, Round(A_ScreenHeight/2))

; Bottom right quarter
#^k::ResizeAndMoveWindow(Round(A_ScreenWidth/2), Round(A_ScreenHeight/2),Round(A_ScreenWidth/2), Round(A_ScreenHeight/2))

; Top left quarter
#^u::ResizeAndMoveWindow(Round(A_ScreenWidth/2), Round(A_ScreenHeight/2),0,0)

; Top right quarter
#^i::ResizeAndMoveWindow(Round(A_ScreenWidth/2), Round(A_ScreenHeight/2), Round(A_ScreenWidth/2), 0)

; Full Screen
#^Enter::ResizeAndMoveWindow(A_ScreenWidth, A_ScreenHeight, 0, 0)

; Center the window
#^c::
    WinGetPos, X, Y, W, H, A
    DestX := Round(A_ScreenWidth/2) - Round(W/2)
    DestY := Round(A_ScreenHeight/2) - Round(H/2)
    ResizeAndMoveWindow(W, H, DestX, DestY)
Return

; Focus view
#^m::
    WinGetPos, X, Y, W, H, A

    W := Round(A_ScreenWidth * 0.80)
    H := Round(A_ScreenHeight * 0.85)

    DestX := Round(A_ScreenWidth/2) - Round(W/2)
    DestY := Round(A_ScreenHeight/2) - Round(H/2)

    ResizeAndMoveWindow(W, H, DestX, DestY)
Return

; Functions

ResizeAndMoveWindow(Width=0, Height=0, DestX=0, DestY=0) {
    WinGetTitle, WinTitle, A

    if WinTitle = Cortana
        Return
    if WinActive("ahk_exe explorer.exe") and !WinTitle
        Return

    WinGetPos,,,,,A
    WinMove,A,,%DestX%,%DestY%,%Width%,%Height%
Return
}
