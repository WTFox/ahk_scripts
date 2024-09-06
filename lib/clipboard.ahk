; Clipboard history limit
global ClipboardHistory := []
MaxClipboardItems := 10

; Track clipboard changes
SetTimer(CheckClipboard, 500)

ClipboardIsBlank() {
    return (Clipboard = "")
}

CheckClipboard() {
    static prevClipboard := ""
    if (Clipboard != prevClipboard && !ClipboardIsBlank()) {
        prevClipboard := Clipboard
        AddToClipboardHistory(Clipboard)
    }
}

AddToClipboardHistory(newItem) {
    ; Avoid duplicates
    if (ClipboardHistory.Has(newItem)) {
        return
    }

    ; Add new item to history
    ClipboardHistory.Push(newItem)

    ; Limit history size
    if (ClipboardHistory.Length() > MaxClipboardItems) {
        ClipboardHistory.RemoveAt(1)  ; Remove oldest entry
    }
}

ShowClipboardMenu() {
    if (ClipboardHistory.Length() = 0) {
        MsgBox("Clipboard history is empty!")
        return
    }

    menu := Gui()
    menu.SetFont("s10")  ; Set font size for readability

    ; Add items to the menu
    for index, item in ClipboardHistory {
        ; Truncate long items for display
        displayText := SubStr(item, 1, 50)
        if (StrLen(item) > 50) {
            displayText .= "..."
        }

        ; Create a button for each clipboard item
        menu.Add("Button", displayText, Func("OnClipboardItemClick").Bind(index))

        ; Create another button, that produces SpongeBob text
        menu.Add("Button", "sPoNgEbOb", Func("OnClipboardItemClickSpongeBob").Bind(index))
    }

    ; Show the menu GUI at the current mouse position
    x := A_CaretX
    y := A_CaretY
    menu.Show("w300", , x, y)  ; Width 300, show near the cursor
}

OnClipboardItemClick(index) {
    ; Set the clipboard to the selected item
    global ClipboardHistory
    Clipboard := ClipboardHistory[index]

    ; Paste the selected clipboard item
    Send("^v")  ; Simulate Ctrl+V to paste
}

OnClipboardItemClickSpongeBob(index) {
    ; Set the clipboard to the selected item
    global ClipboardHistory
    Clipboard := ClipboardHistory[index]
    ; SpongeBob-ify the selected clipboard item
    SpongeBobText := ""
    ToggleCase := 1
    for i, char in Clipboard {
        if (char is alpha) {
            SpongeBobText .= ToggleCase ? StrUpper(char) : StrLower(char)
            ToggleCase := !ToggleCase
        } else {
            SpongeBobText .= char
        }
    }
    ; Paste the SpongeBob-ified text
    Clipboard := SpongeBobText
    Send("^v")  ; Simulate Ctrl+V to paste
}
