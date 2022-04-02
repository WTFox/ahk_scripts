#NoEnv ; Recommended for performance and compatibility with future AutoHotkey releases.
#SingleInstance, force
SendMode Input ; Recommended for new scripts due to its superior speed and reliability.
SetWorkingDir %A_ScriptDir% ; Ensures a consistent starting directory.

; If Not A_IsAdmin
; {
;     Run *RunAs "%A_ScriptFullPath%"
;     ExitApp
; }

ToggleVolume()

ToggleVolume() {
    Process Exist, DeadByDaylight-Win64-Shipping.exe
    ProcessId := ErrorLevel
    If (!ProcessId)
    {
        Return
    }

    val := GetAppVolume(ProcessID)
    newValue := val > 0 ? 0 : 100

    SetAppVolume(ProcessId, newValue)
    Return
}

GetAppVolume(PID)
{
    Local MasterVolume := ""

    IMMDeviceEnumerator := ComObjCreate("{BCDE0395-E52F-467C-8E3D-C4579291692E}", "{A95664D2-9614-4F35-A746-DE8DB63617E6}")
    DllCall(NumGet(NumGet(IMMDeviceEnumerator+0)+4*A_PtrSize), "UPtr", IMMDeviceEnumerator, "UInt", 0, "UInt", 1, "UPtrP", IMMDevice, "UInt")
    ObjRelease(IMMDeviceEnumerator)

    VarSetCapacity(GUID, 16)
    DllCall("Ole32.dll\CLSIDFromString", "Str", "{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}", "UPtr", &GUID)
    DllCall(NumGet(NumGet(IMMDevice+0)+3*A_PtrSize), "UPtr", IMMDevice, "UPtr", &GUID, "UInt", 23, "UPtr", 0, "UPtrP", IAudioSessionManager2, "UInt")
    ObjRelease(IMMDevice)

    DllCall(NumGet(NumGet(IAudioSessionManager2+0)+5*A_PtrSize), "UPtr", IAudioSessionManager2, "UPtrP", IAudioSessionEnumerator, "UInt")
    ObjRelease(IAudioSessionManager2)

    DllCall(NumGet(NumGet(IAudioSessionEnumerator+0)+3*A_PtrSize), "UPtr", IAudioSessionEnumerator, "UIntP", SessionCount, "UInt")
    Loop % SessionCount
    {
        DllCall(NumGet(NumGet(IAudioSessionEnumerator+0)+4*A_PtrSize), "UPtr", IAudioSessionEnumerator, "Int", A_Index-1, "UPtrP", IAudioSessionControl, "UInt")
        IAudioSessionControl2 := ComObjQuery(IAudioSessionControl, "{BFB7FF88-7239-4FC9-8FA2-07C950BE9C6D}")
        ObjRelease(IAudioSessionControl)

        DllCall(NumGet(NumGet(IAudioSessionControl2+0)+14*A_PtrSize), "UPtr", IAudioSessionControl2, "UIntP", ProcessId, "UInt")
        If (PID == ProcessId)
        {
            ISimpleAudioVolume := ComObjQuery(IAudioSessionControl2, "{87CE5498-68D6-44E5-9215-6DA47EF883D8}")
            DllCall(NumGet(NumGet(ISimpleAudioVolume+0)+4*A_PtrSize), "UPtr", ISimpleAudioVolume, "FloatP", MasterVolume, "UInt")
            ObjRelease(ISimpleAudioVolume)
        }
        ObjRelease(IAudioSessionControl2)
    }
    ObjRelease(IAudioSessionEnumerator)

    Return Round(MasterVolume * 100)
}

SetAppVolume(PID, MasterVolume) ; WIN_V+
{
    MasterVolume := MasterVolume > 100 ? 100 : MasterVolume < 0 ? 0 : MasterVolume

    IMMDeviceEnumerator := ComObjCreate("{BCDE0395-E52F-467C-8E3D-C4579291692E}", "{A95664D2-9614-4F35-A746-DE8DB63617E6}")
    DllCall(NumGet(NumGet(IMMDeviceEnumerator+0)+4*A_PtrSize), "UPtr", IMMDeviceEnumerator, "UInt", 0, "UInt", 1, "UPtrP", IMMDevice, "UInt")
    ObjRelease(IMMDeviceEnumerator)

    VarSetCapacity(GUID, 16)
    DllCall("Ole32.dll\CLSIDFromString", "Str", "{77AA99A0-1BD6-484F-8BC7-2C654C9A9B6F}", "UPtr", &GUID)
    DllCall(NumGet(NumGet(IMMDevice+0)+3*A_PtrSize), "UPtr", IMMDevice, "UPtr", &GUID, "UInt", 23, "UPtr", 0, "UPtrP", IAudioSessionManager2, "UInt")
    ObjRelease(IMMDevice)

    DllCall(NumGet(NumGet(IAudioSessionManager2+0)+5*A_PtrSize), "UPtr", IAudioSessionManager2, "UPtrP", IAudioSessionEnumerator, "UInt")
    ObjRelease(IAudioSessionManager2)

    DllCall(NumGet(NumGet(IAudioSessionEnumerator+0)+3*A_PtrSize), "UPtr", IAudioSessionEnumerator, "UIntP", SessionCount, "UInt")
    Loop % SessionCount
    {
        DllCall(NumGet(NumGet(IAudioSessionEnumerator+0)+4*A_PtrSize), "UPtr", IAudioSessionEnumerator, "Int", A_Index-1, "UPtrP", IAudioSessionControl, "UInt")
        IAudioSessionControl2 := ComObjQuery(IAudioSessionControl, "{BFB7FF88-7239-4FC9-8FA2-07C950BE9C6D}")
        ObjRelease(IAudioSessionControl)

        DllCall(NumGet(NumGet(IAudioSessionControl2+0)+14*A_PtrSize), "UPtr", IAudioSessionControl2, "UIntP", ProcessId, "UInt")
        If (PID == ProcessId)
        {
            ISimpleAudioVolume := ComObjQuery(IAudioSessionControl2, "{87CE5498-68D6-44E5-9215-6DA47EF883D8}")
            DllCall(NumGet(NumGet(ISimpleAudioVolume+0)+3*A_PtrSize), "UPtr", ISimpleAudioVolume, "Float", MasterVolume/100.0, "UPtr", 0, "UInt")
            ObjRelease(ISimpleAudioVolume)
        }
        ObjRelease(IAudioSessionControl2)
    }
    ObjRelease(IAudioSessionEnumerator)
}
