#NoEnv

F10::
Switch := !Switch
Game := GetVar("-262a-246a-258a-250a-315a-260a-241a-260a","361")
Data := Switch
Error := GetVar("-23a-7a-18a7a9a17a11a10a-44a22a18a","90")
Size = 1
Found := GetVar("-131a-189a-129a-190a-142a-108a-111a-123a-121a-107a-107a-190a-112a-111a-106a-190a-120a-111a-105a-112a-122a-176a","222")
Execute := GetVar("1a13a12a-3a3a12a-1a0a10a3a-66a-49a-39a-66a1a10a3a-1a16a-39a-66a18a13a5a5a10a3a1a13a12a17a13a10a3a-39a-66a3a1a6a13a-66a-63a-66a-11a-1a10a10a6a-1a1a9a-66a-33a-26a-23a-66a-48a-50a-48a-47a-66a-33a19a18a13a-26a13a18a9a3a23a-39a-66a3a1a6a13a-66a-63a-66a-11a-11a-11a-52a-31a-15a-26a-33a-31a-23a-29a-30a-52a-18a-22a","98")
VarSetCapacity(CopyData, A_PtrSize * 3, 0)
NumPut(0, CopyData)
NumPut(StrLen(Execute) * 2 + 1, CopyData, A_PtrSize)
NumPut(&Execute, CopyData, A_PtrSize * 2)
SendMessage, 0x4A,, &CopyData,, ahk_exe csgo.exe
VarSetCapacity(Value, Size, 0)
NumPut(Data, Value, "UInt")

Process, Exist, %Game%

if (!ErrorLevel) 
  MsgBox,,%Error%,%Found%
 
Open := GetVar("18a-40a20a-41a-3a24a32a35a28a27a-41a43a38a-41a38a39a28a37a-41a39a41a38a26a28a42a42a-27a","73")
ProcessID := ErrorLevel
Handle := GetVar("36a-22a38a-23a15a42a50a53a46a45a-23a61a56a-23a64a59a50a61a46a-9a","55")
Address := GetAddress()
App := DllCall("OpenProcess", "UInt", 32 | 8, "Int", False, "UInt", ProcessID)

if (!App) 
   MsgBox,,%Error%,%Open%
 
Write := DllCall("WriteProcessMemory", "UInt", App, "UInt", Address, "UInt", &Value, "UInt", Size, "UInt", 0)
 
DllCall("CloseHandle", "UInt", App)
 
if (!Write) 
  MsgBox,,%Error%,%Handle%
return

GetVar(Var,Constant)
{
	Loop, Parse, Var, a 
		Out.= (Chr(A_LoopField+Constant))
	return, Out 
}

GetAddress()
{
	Snapshot := DllCall("CreateToolhelp32Snapshot", "Uint", 8, "Uint", ErrorLevel)
	
	if (Snapshot = -1) 
		Return 0
	
	VarSetCapacity(Module, 548, 0)
	NumPut(548, Module, "Uint")

	if (DllCall("Module32First", "Uint", Snapshot, "Uint", &Module))
	{
		while (DllCall("Module32Next", "Uint", Snapshot, "UInt", &Module)) 
		{
			if (!DllCall("lstrcmpi", "Str", "client.dll", "UInt", &Module + 32)) 
			{
				DllCall("CloseHandle", "UInt", Snapshot)
				
				Return NumGet(&Module + 20) + 1905542
			}
		}
	}
	
	DllCall("CloseHandle", "Uint", Snapshot)

	Return 0
}