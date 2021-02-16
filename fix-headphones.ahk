#SingleInstance, Force
SendMode Input
SetWorkingDir, %A_ScriptDir%

If Not A_IsAdmin
{
   Run *RunAs "%A_ScriptFullPath%"
   ExitApp
}

Gui, Add, Progress, w300 h20 cBlue vMyProgress
Gui, Show

RunWait,net stop audiosrv,,Hide
GuiControl,, MyProgress, +25

RunWait,net stop AudioEndpointBuilder,,Hide
GuiControl,, MyProgress, +25

RunWait,net start AudioEndpointBuilder,,Hide
GuiControl,, MyProgress,, +25

RunWait,net start audiosrv,,Hide
GuiControl,, MyProgress, +25

ExitApp
