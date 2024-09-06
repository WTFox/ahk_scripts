#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

If Not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}

RunWait, fix-audio.bat

ExitApp
