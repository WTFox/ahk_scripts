class WindowManager {
  static history := {}

  static FocusView() {
    this.StoreSizeAndPositionOfActiveWindow()
    WinGetPos, X, Y, W, H, A

    W := Round(A_ScreenWidth * 0.60)
    H := Round(A_ScreenHeight * 0.80)

    DestX := Round(A_ScreenWidth/2) - Round(W/2)
    DestY := Round(A_ScreenHeight/2) - Round(H/2)

    this.ResizeAndMoveWindow(W, H, DestX, DestY)
  }

  static LeftTwoThirds() {
    this.StoreSizeAndPositionOfActiveWindow()
    this.ResizeAndMoveWindow(Round(A_ScreenWidth/3)*2, A_ScreenHeight, 0, 0)
  }

  static SixteenNineCentered() {
    this.StoreSizeAndPositionOfActiveWindow()
    desiredWidth := 2560
    desiredHeight := 1439
    this.ResizeAndMoveWindow(desiredWidth, desiredHeight, Round(A_ScreenWidth/2) - Round(desiredWidth/2), 0)
  }

  static StreamerRes() {
    this.StoreSizeAndPositionOfActiveWindow()
    desiredWidth := 2560
    desiredHeight := 1439
    this.ResizeAndMoveWindow(desiredWidth, desiredHeight, A_ScreenWidth - desiredWidth, 0)
  }

  static SixteenNine() {
    this.StoreSizeAndPositionOfActiveWindow()
    desiredWidth := A_ScreenWidth * 0.75
    desiredHeight := A_ScreenHeight - 1
    this.ResizeAndMoveWindow(desiredWidth, desiredHeight, Round(A_ScreenWidth/4), 0)
  }

  static LeftHalf() {
    this.StoreSizeAndPositionOfActiveWindow()
    this.ResizeAndMoveWindow(
      Round(A_ScreenWidth/2),
      A_ScreenHeight,
      0,
      0
    )
  }

  static RightHalf() {
    this.StoreSizeAndPositionOfActiveWindow()
    this.ResizeAndMoveWindow(
      Round(A_ScreenWidth/2),
      A_ScreenHeight,
      Round(A_ScreenWidth/2),
      0
    )
  }

  static RightTwoThirds() {
    this.StoreSizeAndPositionOfActiveWindow()
    this.ResizeAndMoveWindow(
      Round(A_ScreenWidth/3)*2,
      A_ScreenHeight,
      A_ScreenWidth-Round(A_ScreenWidth/3)*2,
      0
    )
  }

  static LeftThird() {
    this.StoreSizeAndPositionOfActiveWindow()
    this.ResizeAndMoveWindow(
      Round(A_ScreenWidth/3),
      A_ScreenHeight,
      0,
      0
    )
  }

  static MiddleThird() {
    this.StoreSizeAndPositionOfActiveWindow()
    this.ResizeAndMoveWindow(
      Round(A_ScreenWidth/3),
      A_ScreenHeight,
      A_ScreenWidth-Round((A_ScreenWidth/3)*2),
      0
    )
  }

  static RightThird() {
    this.StoreSizeAndPositionOfActiveWindow()
    this.ResizeAndMoveWindow(
      Round(A_ScreenWidth/3),
      A_ScreenHeight,
      A_ScreenWidth-Round((A_ScreenWidth/3)*1),
      0
    )
  }

  static BottomLeftQuarter() {
    this.StoreSizeAndPositionOfActiveWindow()
    this.ResizeAndMoveWindow(
      Round(A_ScreenWidth/3),
      Round(A_ScreenHeight/2),
      0,
      Round(A_ScreenHeight/2)
    )
  }

  static BottomRightQuarter() {
    this.StoreSizeAndPositionOfActiveWindow()
    this.ResizeAndMoveWindow(
      Round(A_ScreenWidth/3),
      Round(A_ScreenHeight/2),
      A_ScreenWidth-Round(A_ScreenWidth/3),
      Round(A_ScreenHeight/2)
    )
  }

  static TopLeftQuarter() {
    this.StoreSizeAndPositionOfActiveWindow()
    this.ResizeAndMoveWindow(
      Round(A_ScreenWidth/3),
      Round(A_ScreenHeight/2),
      0,
      0
    )
  }


  static TopRightQuarter() {
    this.StoreSizeAndPositionOfActiveWindow()
    this.ResizeAndMoveWindow(
      Round(A_ScreenWidth/3),
      Round(A_ScreenHeight/2),
      Round(A_ScreenWidth - (A_ScreenWidth/3)),
      0
    )
  }

  static FullScreen() {
    this.StoreSizeAndPositionOfActiveWindow()
    this.ResizeAndMoveWindow(
      A_ScreenWidth,
      A_ScreenHeight,
      0,
      0
    )
  }

  static Centered() {
    this.StoreSizeAndPositionOfActiveWindow()
    this.CenterWindow()
  }

  static Expand() {
    this.StoreSizeAndPositionOfActiveWindow()
    WinGetPos, X, Y, W, H, A

    W := Round(W * 1.1)
    H := Round(H * 1.1)

    this.ResizeAndMoveWindow(W, H, X, Y)
  }

  static Shrink() {
    this.StoreSizeAndPositionOfActiveWindow()
    WinGetPos, X, Y, W, H, A
    W := Round(W * 0.9)
    H := Round(H * 0.9)
    this.ResizeAndMoveWindow(W, H, X, Y)
  }

  static Undo() {
    this.history
    WinGetTitle, winTitleToRestore, A
    size := this.history[winTitleToRestore].Pop()
    this.ResizeAndMoveWindow(size.width, size.height, size.destX, size.destY)
  }

  ; Center the window
  static CenterWindow() {
      WinGetPos, X, Y, W, H, A
      DestX := Round(A_ScreenWidth/2) - Round(W/2)
      DestY := Round(A_ScreenHeight/2) - Round(H/2)
      this.ResizeAndMoveWindow(W, H, DestX, DestY)
  }

  ; Store the current window size and position
  static StoreSizeAndPositionOfActiveWindow() {
      WinGetTitle, activeWinTitle, A
      WinGetPos, _X, _Y, _W, _H, A

      if !this.history.HasKey(activeWinTitle)
          this.history[activeWinTitle] := []

      this.history[activeWinTitle].Push({width: _W, height: _H, destX: _X, destY: _Y})
  }

  ; Resize and move the window to the specified dimensions and position
  static ResizeAndMoveWindow(Width=0, Height=0, DestX=0, DestY=0) {
      WinGetTitle, activeWinTitle, A

      if activeWinTitle = Cortana
          Return
      if WinActive("ahk_exe explorer.exe") and !activeWinTitle
          Return

      WinGetPos,,,,,A
      WinMove,A,,%DestX%,%DestY%,%Width%,%Height%
  }

  static SwitchToApp(name) {
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
}
