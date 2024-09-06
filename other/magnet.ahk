history := {}

; Left two thirds
!^e::
    StoreSizeAndPositionOfActiveWindow()
    ResizeAndMoveWindow(Round(A_ScreenWidth/3)*2, A_ScreenHeight, 0, 0)
Return

; 16:9 centered
!^r::
    ; 16:9.
    ; Almost the same as e and t keys, but subtracts one pixel from the bottom to
    ; prevent activating the start bar while playing games in windowed mode
    StoreSizeAndPositionOfActiveWindow()
    desiredWidth := 2560 ; A_ScreenWidth * 0.75
    desiredHeight := 1439 ;A_ScreenHeight - 1
    ResizeAndMoveWindow(desiredWidth, desiredHeight, Round(A_ScreenWidth/2) - Round(desiredWidth/2), 0)
Return

; Streamer res
!^s::
    ; 16:9.
    ; Almost the same as e and t keys, but subtracts one pixel from the bottom to
    ; prevent activating the start bar while playing games in windowed mode
    StoreSizeAndPositionOfActiveWindow()
    desiredWidth := 2560 ; A_ScreenWidth * 0.75
    desiredHeight := 1439 ;A_ScreenHeight - 1
    ResizeAndMoveWindow(desiredWidth, desiredHeight, A_ScreenWidth - desiredWidth, 0)
Return

!^y::
    ; 16:9
    ; Almost the same as e and t keys, but subtracts one pixel from the bottom to
    ; prevent activating the start bar while playing games in windowed mode
    StoreSizeAndPositionOfActiveWindow()
    desiredWidth := A_ScreenWidth * 0.75
    desiredHeight := A_ScreenHeight - 1
    ResizeAndMoveWindow(desiredWidth, desiredHeight, Round(A_ScreenWidth/4), 0)
Return

; Left half
!^h::
    StoreSizeAndPositionOfActiveWindow()
    ResizeAndMoveWindow(Round(A_ScreenWidth/2), A_ScreenHeight, 0, 0)
Return

; Right half
!^l::
    StoreSizeAndPositionOfActiveWindow()
    ResizeAndMoveWindow(Round(A_ScreenWidth/2), A_ScreenHeight, Round(A_ScreenWidth/2), 0)
Return

; Right two thirds
!^t::
    StoreSizeAndPositionOfActiveWindow()
    ResizeAndMoveWindow(Round(A_ScreenWidth/3)*2, A_ScreenHeight, A_ScreenWidth-Round(A_ScreenWidth/3)*2, 0)
Return

; Left third
!^d::
    StoreSizeAndPositionOfActiveWindow()
    ResizeAndMoveWindow(Round(A_ScreenWidth/3), A_ScreenHeight, 0, 0)
Return

; Middle third
!^f::
    StoreSizeAndPositionOfActiveWindow()
    ResizeAndMoveWindow(Round(A_ScreenWidth/3), A_ScreenHeight, A_ScreenWidth-Round((A_ScreenWidth/3)*2), 0)
Return

; Right third
!^g::
    StoreSizeAndPositionOfActiveWindow()
    ResizeAndMoveWindow(Round(A_ScreenWidth/3), A_ScreenHeight, A_ScreenWidth-Round((A_ScreenWidth/3)*1), 0)
Return

; Bottom left quarter
!^j::
    StoreSizeAndPositionOfActiveWindow()
    ResizeAndMoveWindow(Round(A_ScreenWidth/3), Round(A_ScreenHeight/2), 0, Round(A_ScreenHeight/2))
Return

; Bottom right quarter
!^k::
    StoreSizeAndPositionOfActiveWindow()
    ResizeAndMoveWindow(Round(A_ScreenWidth/3), Round(A_ScreenHeight/2), A_ScreenWidth-Round(A_ScreenWidth/3), Round(A_ScreenHeight/2))
Return

; Top left quarter
!^u::
    StoreSizeAndPositionOfActiveWindow()
    ResizeAndMoveWindow(Round(A_ScreenWidth/3), Round(A_ScreenHeight/2),0,0)
Return

; Top right quarter
!^i::
    StoreSizeAndPositionOfActiveWindow()
    ResizeAndMoveWindow(Round(A_ScreenWidth/3), Round(A_ScreenHeight/2), Round(A_ScreenWidth - (A_ScreenWidth/3)), 0)
Return

; Full Screen
!^Enter::
    StoreSizeAndPositionOfActiveWindow()
    ResizeAndMoveWindow(A_ScreenWidth, A_ScreenHeight, 0, 0)
Return

; Center the window
!^c::
    StoreSizeAndPositionOfActiveWindow()
    CenterWindow()
Return

; Focus view
!^m::
    StoreSizeAndPositionOfActiveWindow()
    WinGetPos, X, Y, W, H, A

    W := Round(A_ScreenWidth * 0.60)
    H := Round(A_ScreenHeight * 0.80)

    DestX := Round(A_ScreenWidth/2) - Round(W/2)
    DestY := Round(A_ScreenHeight/2) - Round(H/2)

    ResizeAndMoveWindow(W, H, DestX, DestY)
Return

^Up::Send {LWin down}{Tab}{LWin up}

; Enhance
!^=::
    StoreSizeAndPositionOfActiveWindow()
    WinGetPos, X, Y, W, H, A

    W := Round(W * 1.1)
    H := Round(H * 1.1)

    ResizeAndMoveWindow(W, H, X, Y)

Return

; De-Enhance
!^-::
    StoreSizeAndPositionOfActiveWindow()
    WinGetPos, X, Y, W, H, A

    W := Round(W * 0.9)
    H := Round(H * 0.9)

    ResizeAndMoveWindow(W, H, X, Y)

Return

; Restore window to previous state
!^BackSpace::
    global history
    WinGetTitle, winTitleToRestore, A
    size := history[winTitleToRestore].Pop()
    ResizeAndMoveWindow(size.width, size.height, size.destX, size.destY)
Return

; Functions

CenterWindow() {
    local
    WinGetPos, X, Y, W, H, A
    DestX := Round(A_ScreenWidth/2) - Round(W/2)
    DestY := Round(A_ScreenHeight/2) - Round(H/2)
    ResizeAndMoveWindow(W, H, DestX, DestY)
Return
}

StoreSizeAndPositionOfActiveWindow() {
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
