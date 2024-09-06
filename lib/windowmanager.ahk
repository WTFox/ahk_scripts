class WindowManager {
  static history := Map()

  static FocusView() {
    this.StoreSizeAndPositionOfActiveWindow()

    WinGetPos &X, &Y,,, "A"

    local W := Round(A_ScreenWidth * 0.60)
    local H := Round(A_ScreenHeight * 0.80)

    local DestX := Round(A_ScreenWidth / 2) - Round(W / 2)
    local DestY := Round(A_ScreenHeight / 2) - Round(H / 2)

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
    WinGetPos &X, &Y, &W, &H, "A"

    W := Round(W * 1.1)
    H := Round(H * 1.1)

    this.ResizeAndMoveWindow(W, H, X, Y)
  }

  static Shrink() {
    this.StoreSizeAndPositionOfActiveWindow()
    WinGetPos &X, &Y, &W, &H, "A"
    W := Round(W * 0.9)
    H := Round(H * 0.9)
    this.ResizeAndMoveWindow(W, H, X, Y)
  }

  static Undo() {
      winTitleToRestore := WinGetTitle("A")  ; Correct assignment

      if !this.history.Has(winTitleToRestore) {
          MsgBox "No history found for this window!"
          return
      }

      size := this.history[winTitleToRestore].Pop()

      if !size {
          MsgBox "No stored sizes found for this window!"
          return
      }

      this.ResizeAndMoveWindow(size.width, size.height, size.destX, size.destY)
  }

  static CenterWindow() {
    WinGetPos &X, &Y, &W, &H, "A"
    DestX := Round(A_ScreenWidth/2) - Round(W/2)
    DestY := Round(A_ScreenHeight/2) - Round(H/2)
    this.ResizeAndMoveWindow(W, H, DestX, DestY)
  }

  static StoreSizeAndPositionOfActiveWindow() {
      activeWinTitle := WinGetTitle("A")

      WinGetPos &X, &Y, &W, &H, "A"

      if !this.history.Has(activeWinTitle)
          this.history[activeWinTitle] := []

      this.history[activeWinTitle].Push({width: W, height: H, destX: X, destY: Y})
  }

  static ResizeAndMoveWindow(Width:=0, Height:=0, DestX:=0, DestY:=0) {
    activeWinTitle := WinGetTitle("A")

    if (activeWinTitle = "Cortana") {
        return
    }

    WinGetPos &X, &Y, &W, &H, "A"
    WinMove DestX, DestY, Width, Height, "A"
  }

  static SwitchToApp(name) {
      windowHandleId := WinExist("ahk_exe " name)
      windowExistsAlready := windowHandleId > 0

      ; If the application is already open, determine if we should put it in focus or minimize it.
      if (windowExistsAlready = true) {
          activeWindowHandleId := WinExist("A")
          windowIsAlreadyActive := activeWindowHandleId == windowHandleId

          if (windowIsAlreadyActive) {
              ; Minimize the window.
              WinMinimize "ahk_id " windowHandleId
          } else {
              ; Put the window in focus.
              WinActivate "ahk_id " windowHandleId
              WinShow "ahk_id " windowHandleId
          }
      } else {
          ; Else it's not already open, so launch it.
          Run(name)
      }
  }
}
