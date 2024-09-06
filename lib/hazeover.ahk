global isDimmed := false
global dimOverlay := Gui()

; Create the dim overlay
CreateDimOverlay() {
    global dimOverlay
    ; Make the overlay a full-screen transparent window
    dimOverlay := Gui("+AlwaysOnTop +ToolWindow -Caption -Border")
    dimOverlay.BackColor := "Black"  ; Black background

    ; Set the overlay to be semi-transparent
    dimOverlay.Opt("+LastFound")
    WinSetTransparent(150)  ; 0 = fully transparent, 255 = fully opaque

    ; Cover the full screen
    dimOverlay.Show("Maximize")
}

; Function to toggle dimming on/off
ToggleDim() {
    global isDimmed
    isDimmed := !isDimmed

    if isDimmed {
        CreateDimOverlay()
        UpdateActiveWindowHole()
        SetTimer(UpdateActiveWindowHole, 100)  ; Update every 100ms
    } else {
        SetTimer(UpdateActiveWindowHole, "Off")
        dimOverlay.Hide()
    }
}

; Function to update the hole over the active window
UpdateActiveWindowHole() {
    global dimOverlay

    ; Get the active window
    WinGetActivePos(&x, &y, &width, &height)
    
    ; Reset the GUI to make sure the previous hole is filled
    dimOverlay.Hide()
    dimOverlay.Show("Maximize")

    ; Create a transparent hole over the active window
    WinSetRegion(x, y, width, height, "Remove")
}

; Ensure the overlay is removed when exiting
OnExit("OnExit")

OnExit() {
    dimOverlay.Destroy()
}
