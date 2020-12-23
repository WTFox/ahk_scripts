#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#Warn ; Enable warnings to assist with detecting common errors.
#SingleInstance, force
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

history := {}

; Window management
; Control + Win + X

; Left two thirds
#^e::
    RecordSizeAndPosition()
    ResizeAndMoveWindow(Round(A_ScreenWidth/3)*2, A_ScreenHeight, 0, 0)
Return

; Right two thirds
#^t::
    RecordSizeAndPosition()
    ResizeAndMoveWindow(Round(A_ScreenWidth/3)*2, A_ScreenHeight, A_ScreenWidth-Round(A_ScreenWidth/3)*2, 0)
Return

; Left third
#^d::
    RecordSizeAndPosition()
    ResizeAndMoveWindow(Round(A_ScreenWidth/3), A_ScreenHeight, 0, 0)
Return

; Middle third
#^f::
    RecordSizeAndPosition()
    ResizeAndMoveWindow(Round(A_ScreenWidth/3), A_ScreenHeight, A_ScreenWidth-Round((A_ScreenWidth/3)*2), 0)
Return

; Right third
#^g::
    RecordSizeAndPosition()
    ResizeAndMoveWindow(Round(A_ScreenWidth/3), A_ScreenHeight, A_ScreenWidth-Round((A_ScreenWidth/3)*1), 0)
Return

; Bottom left quarter
#^j::
    RecordSizeAndPosition()
    ResizeAndMoveWindow(Round(A_ScreenWidth/2), Round(A_ScreenHeight/2), 0, Round(A_ScreenHeight/2))
Return

; Bottom right quarter
#^k::
    RecordSizeAndPosition()
    ResizeAndMoveWindow(Round(A_ScreenWidth/2), Round(A_ScreenHeight/2),Round(A_ScreenWidth/2), Round(A_ScreenHeight/2))
Return

; Top left quarter
#^u::
    RecordSizeAndPosition()
    ResizeAndMoveWindow(Round(A_ScreenWidth/2), Round(A_ScreenHeight/2),0,0)
Return

; Top right quarter
#^i::
    RecordSizeAndPosition()
    ResizeAndMoveWindow(Round(A_ScreenWidth/2), Round(A_ScreenHeight/2), Round(A_ScreenWidth/2), 0)
Return

; Full Screen
#^Enter::
    RecordSizeAndPosition()
    ResizeAndMoveWindow(A_ScreenWidth, A_ScreenHeight, 0, 0)
Return

; Center the window
#^c::
    RecordSizeAndPosition()
    WinGetPos, X, Y, W, H, A
    DestX := Round(A_ScreenWidth/2) - Round(W/2)
    DestY := Round(A_ScreenHeight/2) - Round(H/2)
    ResizeAndMoveWindow(W, H, DestX, DestY)
Return

; Focus view
#^m::
    RecordSizeAndPosition()
    WinGetPos, X, Y, W, H, A

    W := Round(A_ScreenWidth * 0.80)
    H := Round(A_ScreenHeight * 0.85)

    DestX := Round(A_ScreenWidth/2) - Round(W/2)
    DestY := Round(A_ScreenHeight/2) - Round(H/2)

    ResizeAndMoveWindow(W, H, DestX, DestY)
Return

; Restore window to previous state
#^BackSpace::
    global history
    WinGetTitle, winTitleToRestore, A
    size := history[winTitleToRestore].Pop()
    ResizeAndMoveWindow(size.width, size.height, size.destX, size.destY)
Return

; Functions

RecordSizeAndPosition() {
    global history
    WinGetTitle, activeWinTitle, A
    WinGetPos, _X, _Y, _W, _H, A

    if !history.HasKey(activeWinTitle)
        history[activeWinTitle] := []

    history[activeWinTitle].Push({width: _W, height: _H, destX: _X, destY: _Y})
Return
}

ResizeAndMoveWindow(Width=0, Height=0, DestX=0, DestY=0) {
    WinGetTitle, activeWinTitle, A

    if activeWinTitle = Cortana
        Return
    if WinActive("ahk_exe explorer.exe") and !activeWinTitle
        Return

    WinGetPos,,,,,A
    WinMove,A,,%DestX%,%DestY%,%Width%,%Height%
Return
}
