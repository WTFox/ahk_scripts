SpongebobText(text) {
    result := ""
    for k, v in StrSplit(text) {
        result .= (Mod(k, 3) ? StrLower(v) : StrUpper(v))
    }
    return result
}

PasteSpongebobText() {
    ClipWait
    if (A_Clipboard != "") {
        Send Trim(SpongebobText(A_Clipboard))
    }
}
