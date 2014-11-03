#Region: Headers
#AutoIt3Wrapper_Res_Icon_Add=J:\Surse\Programe\TaskManagerPro_fara_reclama\TaskManagerPro_fara_reclama\Source\res.ico
#include <Process.au3>
#include <ButtonConstants.au3>
#include <GUIConstantsEx.au3>
#include <ListViewConstants.au3>
#include <StaticConstants.au3>
#include <WindowsConstants.au3>
#include <String.au3>
#include <EditConstants.au3>
#include <Misc.au3>
#NoTrayIcon
#EndRegion
#Region: Check and register program to startup
$reg = RegRead("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "Task Manager Pro")
$Cale = @ScriptDir & "\Task Manager Pro.exe"
If $reg == "" Then
	RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "Task Manager Pro", "REG_SZ", $Cale)
ElseIf $reg <> $Cale Then
	RegDelete("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "Task Manager Pro")
	RegWrite("HKEY_CURRENT_USER\Software\Microsoft\Windows\CurrentVersion\Run", "Task Manager Pro", "REG_SZ", $Cale)
EndIf
#EndRegion
#Region: Check if already running
Global $aIconHandles
Global $tImageList[64]
Global $tIL = 0
If WinExists("Task Manager Pro - Main") = 1 And WinExists("Task Manager Pro - Options") = 1 And WinExists("Task Manager Pro - CMD") = 1 And WinExists("Task Manager Pro - About") = 1 And WinExists("Task Manager Pro - Meminfo") = 1 And WinExists("Task Manager Pro - Clock/Autoshutdown") = 1 And WinExists("Task Manager Pro - Website Locker\Unlocker") = 1 Then
	_MsgBox("Warning!","Task Manager Pro is already running!")
	Exit
EndIf
#EndRegion
#Region: Getting CPU Data
Global $CPU_DATA
$CPU_DATA =_GetCPUData()
#EndRegion
#Region: Tray Initialization
Opt("TrayMenuMode", 1)
$Tray_WEBSITELOCKERUNLOCKER = TrayCreateItem("Website Locker/Unlocker")
$Tray_CMD = TrayCreateItem("Pro Cmd")
$Tray_Otherinfo = TrayCreateItem("Other Info")
$Tray_PCControl = TrayCreateItem("PC Control")
$Tray_UserManager = TrayCreateItem("User Manager")
$Tray_State = TrayCreateItem("Hide Main")
TrayCreateItem("")
$Tray_Settings = TrayCreateItem("Settings")
$Tray_About = TrayCreateItem("About")
TrayCreateItem("")
$Tray_Exit = TrayCreateItem("Exit")
TraySetState()
TraySetIcon(@ScriptDir & "\res.ico")
#EndRegion
#Region: GUI Initialization
Global $N1, $N2, $S1, $S2, $S3, $S4, $S5, $S6, $S7, $S8, $S9, $S10, $S11, $S12, $S13, $S14, $S15, $S16, $SaveAdress, $DelayTime4Save
$Width = 650
$Height = 522
$Main = GUICreate("Task Manager Pro - Main", $Width, $Height, -1, -1, BitOR($WS_POPUP, $WS_BORDER), 136)
$Close_Main = GUICtrlCreateLabel("X", $Width - 15, 0, 11, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Comic Sans MS")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetCursor(-1, 0)
$Open_Options = GUICtrlCreateLabel("+", $Width - 30, 0, 11, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Comic Sans MS")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetCursor(-1, 0)
$Minimize_Main = GUICtrlCreateLabel("_", $Width - 45, 0, 11, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Comic Sans MS")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetCursor(-1, 0)
GUICtrlCreateLabel(" Task Manager Pro", 0, 4, @DesktopWidth, 20, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlCreateGraphic(0, 0, @DesktopWidth, 22)
GUICtrlSetBkColor(-1, 0x000000)
$WinList = GUICtrlCreateListView("Win Name|Handle|PID|X Pos|Y Pos|Width|Height|Visible|Process Name|Process Priority|R-O|W-O|I/O-O|R-B|W-B|T-B|Mem Usage|Peak Mem Usage", 8, 30, 633, 281 + 106)
$Close = GUICtrlCreateButton("Win Close", 8, 424, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$SetX = GUICtrlCreateButton("Set Coord X", 168, 424, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$SetY = GUICtrlCreateButton("Set Coord Y", 248, 424, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$SetWidth = GUICtrlCreateButton("Set Width", 408, 424, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$SetHeight = GUICtrlCreateButton("Set Height", 328, 424, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$SetTitle = GUICtrlCreateButton("Set Title", 488, 424, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$Hide = GUICtrlCreateButton("Hide", 8, 456, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$Maximize = GUICtrlCreateButton("Maximize", 328, 456, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$Minimize = GUICtrlCreateButton("Minimize", 408, 456, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$MinimizeAll = GUICtrlCreateButton("Minimize All", 168, 456, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$UnminimizeAll = GUICtrlCreateButton("Unminimize All", 248, 456, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$SetPriority = GUICtrlCreateButton("Set Priority", 568, 424, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$Show = GUICtrlCreateButton("Show", 88, 456, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$Update = GUICtrlCreateButton("Update", 568, 456, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$ProcessClose = GUICtrlCreateButton("Process Close", 488, 456, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$WinKill = GUICtrlCreateButton("Win Kill", 88, 424, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$SaveList = GUICtrlCreateButton("Save List", 8, 488, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$MemoryInfo = GUICtrlCreateButton("Other Info", 168, 488, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$PCClock = GUICtrlCreateButton("PC Control", 88, 488, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$_UserManager = GUICtrlCreateButton("User Manager", 248, 488, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$_WebsiteLockerUnlocker = GUICtrlCreateButton("Website L/U", 328 , 488, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$_ProCMD = GUICtrlCreateButton("Pro Cmd", 408, 488, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$_HomePage = GUICtrlCreateButton("Home Page", 488 , 488, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$About = GUICtrlCreateButton("About", 568, 488, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
GUISetState(@SW_HIDE, $Main)

$Width = 258
$Height = 578
$Options = GUICreate("Task Manager Pro - Options", $Width, $Height, -1, -1, BitOR($WS_POPUP, $WS_BORDER),136)
$Close_Options = GUICtrlCreateLabel("X", $Width - 15, 0, 11, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Comic Sans MS")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetCursor(-1, 0)
GUICtrlCreateLabel(" Options", 0, 4, @DesktopWidth, 20, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlCreateGraphic(0, 0, @DesktopWidth, 22)
GUICtrlSetBkColor(-1, 0x000000)
GUICtrlCreateLabel("Max number if items in list:", 8, 24, 126, 17)
$MaxNOI = GUICtrlCreateInput("2048", 136, 24, 113, 21, $ES_NUMBER)
GUICtrlCreateGroup("WinList filters", 8, 120, 241, 81)
$N1 = GUICtrlCreateCheckbox("Visible windows", 16, 144, 97, 17)
$N2 = GUICtrlCreateCheckbox("NULL Caption", 16, 168, 97, 17)
$N3 = GUICtrlCreateCheckbox("Invisible windows", 128, 144, 105, 17)
$N4 = GUICtrlCreateCheckbox("Non-NULL Captions", 128, 168, 121, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Save list options", 8, 208, 241, 361)
GUICtrlCreateGroup("Save only:", 16, 224, 225, 233)
$S1 = GUICtrlCreateCheckbox("Win Name", 24, 240, 97, 17)
$S2 = GUICtrlCreateCheckbox("Win Handle", 24, 264, 97, 17)
$S3 = GUICtrlCreateCheckbox("PID", 24, 288, 97, 17)
$S4 = GUICtrlCreateCheckbox("Pos X", 24, 312, 97, 17)
$S5 = GUICtrlCreateCheckbox("Pos Y", 24, 336, 97, 17)
$S6 = GUICtrlCreateCheckbox("Width", 24, 360, 97, 17)
$S7 = GUICtrlCreateCheckbox("Height", 24, 384, 97, 17)
$S8 = GUICtrlCreateCheckbox("Visible", 24, 408, 97, 17)
$S9 = GUICtrlCreateCheckbox("R-O", 136, 264, 97, 17)
$S10 = GUICtrlCreateCheckbox("W-O", 136, 288, 97, 17)
$S11 = GUICtrlCreateCheckbox("I/O-O", 136, 312, 97, 17)
$S12 = GUICtrlCreateCheckbox("R-B", 136, 336, 97, 17)
$S13 = GUICtrlCreateCheckbox("W-B", 136, 360, 97, 17)
$S14 = GUICtrlCreateCheckbox("T-B", 136, 384, 97, 17)
$S15 = GUICtrlCreateCheckbox("Mem Usage", 136, 408, 97, 17)
$S16 = GUICtrlCreateCheckbox("Peak Mem Usage", 136, 432, 97, 17)
$S17 = GUICtrlCreateCheckbox("Process Name", 24, 432, 97, 17)
$S18 = GUICtrlCreateCheckbox("Process Priority", 136, 240, 97, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Auto-Save list options:", 16, 464, 225, 65)
GUICtrlCreateLabel("Save list to:", 24, 480, 59, 17)
GUICtrlCreateLabel("Save list at every: ", 24, 504, 91, 17)
GUICtrlCreateLabel("miliseconds.", 176, 504, 61, 17)
$DelayTime4Save = GUICtrlCreateInput("0", 112, 504, 57, 21, $ES_NUMBER)
$SaveAdress = GUICtrlCreateInput("", 88, 480, 81, 21, $ES_READONLY)
$Browse = GUICtrlCreateButton("Browse", 176, 480, 59, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$V1 = GUICtrlCreateCheckbox("Overwrite save file", 16, 544, 121, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateLabel("Update data at every:", 8, 48, 107, 17)
$Update_Delay = GUICtrlCreateInput("750", 120, 48, 105, 21, $ES_NUMBER)
GUICtrlCreateLabel("ms.", 232, 48, 20, 17)
$V2 = GUICtrlCreateCheckbox("Show a tray message when hide main window", 8, 72, 241, 17)
$V3 = GUICtrlCreateCheckbox("Enable F12 shortcut", 8, 96, 145, 17)
GUISetState(@SW_HIDE, $Options)

$Width = 482
$Height = 74
$GUI_ABOUT = GUICreate("Task Manager Pro - About", $Width, $Height, -1, -1, BitOR($WS_POPUP, $WS_BORDER),136)
$Close_ABOUT = GUICtrlCreateLabel("X", $Width - 15, 0, 11, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Comic Sans MS")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetCursor(-1, 0)
GUICtrlCreateLabel(" About", 0, 4, @DesktopWidth, 20, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlCreateGraphic(0, 0, @DesktopWidth, 22)
GUICtrlSetBkColor(-1, 0x000000)
$LBL_RECL_1 = GUICtrlCreateLabel("This program was coded by Murtaza Alexandru (a.k.a. Challenge from skullbox or alpha-thema ).", 16, 24, 454, 17)
$LBL_RECL_2 = GUICtrlCreateLabel("For any questions or any bug report please give me a replay on my website: www.alpha-thema.com", 8, 48, 468, 17)
GUISetState(@SW_HIDE, $GUI_ABOUT)

$Width = 434
$Height = 458
$GUI_MEMINFO = GUICreate("Task Manager Pro - Meminfo", $Width, $Height, -1, -1, BitOR($WS_POPUP, $WS_BORDER),136)
$CLOSE_MEMINFO_GUI = GUICtrlCreateLabel("X", $Width - 15, 0, 11, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Comic Sans MS")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetCursor(-1, 0)
GUICtrlCreateLabel(" Otherinfo", 0, 4, @DesktopWidth, 20, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlCreateGraphic(0, 0, @DesktopWidth, 22)
GUICtrlSetBkColor(-1, 0x000000)
GUICtrlCreateGroup("Desktop Information", 8, 24, 201, 121)
GUICtrlCreateLabel("Desktop Width:", 24, 48, 78, 17)
GUICtrlCreateLabel("Desktop Height: ", 24, 72, 84, 17)
GUICtrlCreateLabel("Desktop Depth: ", 24, 96, 82, 17)
GUICtrlCreateLabel("Descktop Refresh Rate:", 24, 120, 119, 17)
$LBL_DT_Width = GUICtrlCreateLabel("", 112, 48, 54, 20)
$LBL_DT_Height = GUICtrlCreateLabel("", 112, 72, 54, 20)
$LBL_DT_Depth = GUICtrlCreateLabel("", 112, 96, 54, 20)
$LBL_DT_ReRate = GUICtrlCreateLabel("", 144, 120, 54, 20)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Operating System Info", 224, 24, 201, 121)
GUICtrlCreateLabel("OS Language: ", 240, 48, 76, 17)
GUICtrlCreateLabel("OS Type:", 240, 72, 49, 17)
GUICtrlCreateLabel("OS Version:", 240, 96, 60, 17)
GUICtrlCreateLabel("OS Service Pack:", 240, 120, 89, 17)
$LBL_OS_LANG = GUICtrlCreateLabel("", 320, 48, 70, 20)
$LBL_OS_TYPE = GUICtrlCreateLabel("", 296, 72, 110, 20)
$LBL_OS_VERSION = GUICtrlCreateLabel("", 304, 96, 70, 20)
$LBL_OS_SERVICE_PACK = GUICtrlCreateLabel("", 336, 120, 85, 20)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Computer Information", 8, 152, 201, 121)
GUICtrlCreateLabel("Computer Name:", 16, 176, 83, 17)
GUICtrlCreateLabel("Current Logged On User:", 16, 200, 122, 17)
GUICtrlCreateLabel("Internet Conection:", 16, 224, 94, 17)
$LBL_INTERNET_CONECTION = GUICtrlCreateLabel("", 112, 224, 60, 20)
$LBL_Computer_Name = GUICtrlCreateLabel("", 104, 176, 60, 20)
$LBL_Cur_LogOnUser = GUICtrlCreateLabel("", 144, 200, 60, 20)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Ip Adresses", 224, 152, 201, 121)
GUICtrlCreateLabel("Ip Adress 1:", 232, 176, 60, 17)
GUICtrlCreateLabel("Ip Adress 2:", 232, 200, 60, 17)
GUICtrlCreateLabel("Ip Adress 3:", 232, 224, 60, 17)
GUICtrlCreateLabel("Ip Adress 4:", 232, 248, 60, 17)
$LBL_IP1 = GUICtrlCreateLabel("", 296, 176, 70, 20)
$LBL_IP2 = GUICtrlCreateLabel("", 296, 200, 70, 20)
$LBL_IP3 = GUICtrlCreateLabel("", 296, 224, 70, 20)
$LBL_IP4 = GUICtrlCreateLabel("", 296, 248, 70, 20)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("RAM/Pagefile Infos", 8, 280, 201, 169)
GUICtrlCreateLabel("Total Physical RAM: ", 16, 304, 103, 17)
GUICtrlCreateLabel("Available Physical RAM:", 16, 328, 119, 17)
GUICtrlCreateLabel("Total Pagefile:", 16, 352, 72, 17)
GUICtrlCreateLabel("Available Pagefile:", 16, 376, 91, 17)
GUICtrlCreateLabel("Total Virtual RAM:", 16, 400, 90, 17)
GUICtrlCreateLabel("Available Virtual RAM:", 16, 424, 109, 17)
$LBL_TOTAL_RAM = GUICtrlCreateLabel("", 120, 304, 70, 20)
$LBL_A_RAM = GUICtrlCreateLabel("", 136, 328, 70, 20)
$LBL_TOTAL_PAGEFILE = GUICtrlCreateLabel("", 88, 352, 70, 20)
$LBL_A_PAGEFILE = GUICtrlCreateLabel("", 112, 376, 70, 20)
$LBL_TOTAL_VRAM = GUICtrlCreateLabel("", 112, 400, 70, 20)
$LBL_A_VRAM = GUICtrlCreateLabel("", 128, 424, 70, 20)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("Other Info", 224, 280, 201, 169)
GUICtrlCreateLabel("PC Uptime:", 232, 304, 57, 17)
GUICtrlCreateLabel("Number of Threads:", 232, 328, 98, 17)
GUICtrlCreateLabel("Memory Usage:", 232, 352, 78, 17)
GUICtrlCreateLabel("Number of Processes:", 232, 376, 120, 17)
$LBL_PC_UPTIME = GUICtrlCreateLabel("", 296, 304, 54, 20)
$LBL_N_OF_T = GUICtrlCreateLabel("", 336, 328, 54, 20)
$LBL_MEM_USAGE = GUICtrlCreateLabel("", 312, 352, 54, 20)
$LBL_N_OF_P = GUICtrlCreateLabel("", 342, 376, 54, 20)
GUICtrlCreateLabel("CPU Type:", 232, 400, 56, 17)
$LBL_CPU_TYPE = GUICtrlCreateLabel($CPU_DATA[0], 288, 400, 130, 40)
GUICtrlCreateLabel("CPU Number of cores:", 232, 424, 110, 17)
$LBL_CPU_NUMBER_OF_CORES = GUICtrlCreateLabel($CPU_DATA[1], 344+20, 424, 60, 20)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_HIDE, $GUI_MEMINFO)

$Width = 330
$Height = 338
$GUI_PCCONTROL = GUICreate("Task Manager Pro - Clock/Autoshutdown", $Width, $Height, -1, -1, BitOR($WS_POPUP, $WS_BORDER),136)
$CLOSE_PCCONTROL_GUI = GUICtrlCreateLabel("X", $Width - 15, 0, 11, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Comic Sans MS")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetCursor(-1, 0)
GUICtrlCreateLabel(" PC Control", 0, 4, @DesktopWidth, 20, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlCreateGraphic(0, 0, @DesktopWidth, 22)
GUICtrlSetBkColor(-1, 0x000000)
GUICtrlCreateGroup("Clock/Auto-Shutdown", 8, 24, 217, 305)
GUICtrlCreateGroup("Condition", 16, 40, 201, 81)
$OPT_ATT = GUICtrlCreateRadio("At The Time:", 24, 64, 81, 17)
$HH = GUICtrlCreateInput("", 112, 64, 25, 21, $ES_NUMBER)
GUICtrlCreateLabel(":", 144, 64, 7, 17)
$MM = GUICtrlCreateInput("", 152, 64, 25, 21, $ES_NUMBER)
$OPT_TIME = GUICtrlCreateRadio("Then time reach:", 24, 88, 97, 17)
$MS = GUICtrlCreateInput("", 128, 88, 49, 21, $ES_NUMBER)
GUICtrlCreateLabel("ms.", 184, 88, 20, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("What to do:", 16, 128, 201, 161)
$OPT_SHUTDOWN = GUICtrlCreateRadio("Shutdown", 24, 144, 113, 17)
$OPT_RESTART = GUICtrlCreateRadio("Restart", 24, 168, 113, 17)
$OPT_HIBERNATE = GUICtrlCreateRadio("Hibernate", 24, 192, 113, 17)
$OPT_LOGOFF = GUICtrlCreateRadio("Logoff", 24, 216, 113, 17)
$OPT_STANDBY = GUICtrlCreateRadio("Standby", 24, 240, 113, 17)
$OPT_SHOWMSGTOTRAY = GUICtrlCreateRadio("Show an message to tray", 24, 264, 137, 17)
GUICtrlCreateGroup("", -99, -99, 1, 1)
$StartStop = GUICtrlCreateButton("Start Clock", 16, 296, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUICtrlCreateGroup("PC Commands", 232, 24, 89, 185)
$Shutdown = GUICtrlCreateButton("Shutdown", 240, 48, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$Restart = GUICtrlCreateButton("Restart", 240, 80, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$Hibernate = GUICtrlCreateButton("Hibernate", 240, 112, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$Logoff = GUICtrlCreateButton("Logoff", 240, 144, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$Standby = GUICtrlCreateButton("Standby", 240, 176, 75, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
GUICtrlCreateGroup("", -99, -99, 1, 1)
GUISetState(@SW_HIDE, $GUI_PCCONTROL)

$X = 30
$Width = 226
$Height = 90 + $X
$UserManager_GUI = GUICreate("Task Manager Pro - User Manager", $Width, $Height, -1, -1, BitOR($WS_POPUP, $WS_BORDER),136)
$CLOSE_UserManager_GUI = GUICtrlCreateLabel("X", $Width - 15, 0, 11, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Comic Sans MS")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetCursor(-1, 0)
GUICtrlCreateLabel(" User Manager", 0, 4, @DesktopWidth, 20, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlCreateGraphic(0, 0, @DesktopWidth, 22)
GUICtrlSetBkColor(-1, 0x000000)
GUICtrlCreateLabel("User:", 8, 8 + $X, 29, 17)
GUICtrlCreateLabel("Pass:", 8, 32 + $X, 30, 17)
$TUser = GUICtrlCreateInput(@UserName, 40, 8 + $X, 177, 21)
$TPass = GUICtrlCreateInput("", 40, 32 + $X, 177, 21, $ES_PASSWORD)
$_Change = GUICtrlCreateButton("Change", 8, 56 + $X, 65, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$_Delete = GUICtrlCreateButton("Delete", 80, 56 + $X, 65, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$_Create = GUICtrlCreateButton("Create", 152, 56 + $X, 65, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
GUISetState(@SW_HIDE, $UserManager_GUI)

$X = 20
$ADD = 50
$Width = 418 + $ADD
$Height = 450 + $X
$GUI_CMD = GUICreate("Task Manager Pro - CMD", $Width, $Height, -1, -1, BitOR($WS_POPUP, $WS_BORDER),136)
$CLOSE_CMD_GUI = GUICtrlCreateLabel("X", $Width - 15, 0, 11, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Comic Sans MS")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetCursor(-1, 0)
GUICtrlCreateLabel(" Pro Cmd", 0, 4, @DesktopWidth, 20, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlCreateGraphic(0, 0, @DesktopWidth, 22)
GUICtrlSetBkColor(-1, 0x000000)
GUICtrlCreateLabel("Command:", 8, 8 + $X, 54, 17)
$Input1 = GUICtrlCreateInput("", 64 , 8 + $X, 249 + $ADD, 21)
$Send = GUICtrlCreateButton("Send", 320 + $ADD, 4 + $X, 89, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$Command_History = GUICtrlCreateEdit("", 8, 40 + $X, 401 + $ADD, 401, 2048+2097152)
GUICtrlSetData(-1, "")
GUISetState(@SW_HIDE, $GUI_CMD)

$X = 20
$Width = 490
$Height = 305 + $X
$GUI_WEBSITELOCKERUNLOCKER = GUICreate("Task Manager Pro - Website Locker\Unlocker", $Width, $Height, -1, -1, BitOR($WS_POPUP, $WS_BORDER),136)
$CLOSE_WEBSITELOCKERUNLOCKER = GUICtrlCreateLabel("X", $Width - 15, 0, 11, 20)
GUICtrlSetFont(-1, 10, 800, 0, "Comic Sans MS")
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlSetCursor(-1, 0)
GUICtrlCreateLabel(" Website Locker\Unlocker", 0, 4, @DesktopWidth, 20, -1, $GUI_WS_EX_PARENTDRAG)
GUICtrlSetColor(-1, 0xFFFFFF)
GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
GUICtrlCreateGraphic(0, 0, @DesktopWidth, 22)
GUICtrlSetBkColor(-1, 0x000000)
$SiteList_BlockedWebSites = GUICtrlCreateListView("Websites", 8, 8 + $X, 474, 254)
$Load_BlockedWebSites = GUICtrlCreateButton("Load", 8, 272 + $X, 91, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$Save_BlockedWebSites = GUICtrlCreateButton("Save", 104, 272 + $X, 91, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$Add_BlockedWebSites = GUICtrlCreateButton("Add Website", 200, 272 + $X, 91, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$Delete_BlockedWebSites = GUICtrlCreateButton("Delete Website", 296, 272 + $X, 91, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
$Clear_BlockedWebSites = GUICtrlCreateButton("Clear List", 392, 272 + $X, 91, 25, 0)
_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
GUISetState(@SW_HIDE, $GUI_WEBSITELOCKERUNLOCKER)
#EndRegion
#Region: CheckBox initialization
Global $ssl1 = "0"
Global $ssl2 = "1"
Global $ssl3 = "1"
Global $ssl4 = "1"
Global $ssl5 = "1"
Global $ssl6 = "1"
Global $ssl7 = "1"
Global $ssl8 = "1"
Global $ssl9 = "1"
Global $ssl10 = "1"
Global $ssl11 = "1"
Global $ssl12 = "1"
Global $ssl13 = "1"
Global $ssl14 = "1"
Global $ssl15 = "1"
Global $ssl16 = "1"
Global $ssl17 = "1"
Global $ssl18 = "1"
Global $ssl19 = "1"
Global $ssl20 = "0"
Global $ssl21 = "1"
Global $ssl22 = "1"
Global $ssl23 = "0"
Global $ssl24 = "1"
Global $ssl25 = "1"
Global $ssl26 = "1"
#EndRegion
#Region: Check if is first time executed
Global $Adress
$Adress = @ProgramFilesDir & "\Alpha-Thema\Task Manager Pro\tmp.ini"
DirCreate(@ProgramFilesDir & "\Alpha-Thema\")
DirCreate(@ProgramFilesDir & "\Alpha-Thema\Task Manager Pro\")
If FileExists($Adress) = 0 Then
	_SaveOptData($Adress)
	_MsgBox("Info", "First-time initialization executed succesfully!")
Else
	_LoadOptData($Adress)
EndIf
#EndRegion
#Region: Check if is started by windows 
If _PCUptime_InSec() > 300 Then
	GUISetState(@SW_SHOW,$Main)
EndIf
#EndRegion
#Region: List Initialization For Win List
Global $ListMaxLength = 2048
Global $List[$ListMaxLength]
Global $ListB[$ListMaxLength]
Global $ListData[$ListMaxLength]
Global $ListC[$ListMaxLength]
_LoadOptData($Adress)
_Init()
#EndRegion
#Region: Initialization For Clock
Global $CLOCK_COND
Global $CLOCK_MM
Global $CLOCK_HH
Global $CLOCK_MS
Global $CLOCK_WTD
Global $CLOCK_TIMER
$CLOCK_COND = 0
$CLOCK_WTD = 0
$TTSVoice = ObjCreate("Sapi.SpVoice")
#EndRegion
#Region: List Initialization And Other Data For Website Locker
Const $ListMaxLength_BlockedWebSites = 256
Global $List_BlockedWebSites[$ListMaxLength_BlockedWebSites]
Global $ListB_BlockedWebSites[$ListMaxLength_BlockedWebSites]
If IsAdmin() = 1 Then
	_Init_BlockedWebSites()
EndIf
#EndRegion

#Region: Initialization for GUI CMD 
Global $Type
Global $VarId
Global $Data_Command_History = ""
Global $Variable_Data[500000]
Global $Err
#EndRegion
#Region: Timers Initialization
$T_S = TimerInit()
$T_F12 = TimerInit()
$T = TimerInit()
$CMD_TIMER = TimerInit()
_Update()
#EndRegion
#Region: Main
While 1
	_UpdateClock()
	If _IsVisible("Task Manager Pro - Website Locker\Unlocker") = 1 Then
		If IsAdmin() = 0 Then
			GUISetState(@SW_HIDE,$GUI_WEBSITELOCKERUNLOCKER)
			_MsgBox("Error! Admin requiered!", "You must be an administrator to use this feature!")
		EndIf
	EndIf
	If _IsVisible("Task Manager Pro - User Manager") = 1 Then
		If IsAdmin() = 0 Then
			GUISetState(@SW_HIDE,$GUI_CMD)
			_MsgBox("Error! Admin requiered!", "You must be an administrator to use this feature!")
		EndIf
	EndIf
	If _IsVisible($GUI_CMD) = 1 Then
		If _IsPressed("0D") = 1 And WinActive("Task Manager Pro - CMD") = 1 And TimerDiff($CMD_TIMER) > 500 Then
			_Execute(GUICtrlRead($Input1))
			$CMD_TIMER = TimerInit()
		EndIf
	EndIf
	If _IsPressed("7B") = 1 And $ssl25 = "1"  Then
		If TimerDiff($T_F12) > 250 Then
			If _IsVisible("Task Manager Pro - Main") Then
				GUISetState(@SW_HIDE, $Main)
				$T_F12 = TimerInit()
			Else
				$T_F12 = TimerInit()
				GUISetState(@SW_SHOW, $Main)
				WinSetState("Task Manager Pro - Main", "", @SW_SHOW)
				WinActivate("Task Manager Pro - Main")
			EndIf
		EndIf
	EndIf
	If _IsVisible($Main) = 1 Then
		TrayItemSetText($Tray_State, "Hide Main")
	Else
		TrayItemSetText($Tray_State, "Show Main")
	EndIf
	If Int(GUICtrlRead($Update_Delay)) <> 0 Then
		If TimerDiff($T) > Int(GUICtrlRead($Update_Delay)) Then
			_Update()
			$T = TimerInit()
		EndIf
	EndIf
	If GUICtrlRead($DelayTime4Save) = "" Then
		GUICtrlSetData($DelayTime4Save, "0")
	EndIf
	If Int(GUICtrlRead($DelayTime4Save)) <> 0 Then
		If TimerDiff($T_S) > Int(GUICtrlRead($DelayTime4Save)) Then
			If FileExists(GUICtrlRead($SaveAdress)) = 1 Then
				If $ssl23 = "1"  Then FileDelete(GUICtrlRead($SaveAdress))
			EndIf
			_SaveList(GUICtrlRead($SaveAdress))
			$T_S = TimerInit()
		EndIf
	EndIf
	$tMsg = TrayGetMsg()
	Switch $tMsg
		Case $Tray_UserManager
			If IsAdmin() = 1 Then
				GUISetState(@SW_SHOW, $UserManager_GUI)
				WinSetState("Task Manager Pro - User Manager", "", @SW_SHOW)
			Else
				_MsgBox("Error! Admin requiered!", "You must be an administrator to use this feature!")
			EndIf
		Case $Tray_Settings
			GUISetState(@SW_SHOW, $Options)
			WinSetState("Task Manager Pro - Options", "", @SW_SHOW)
		Case $Tray_PCControl
			GUISetState(@SW_SHOW, $GUI_PCCONTROL)
			WinSetState("Task Manager Pro - Clock/Autoshutdown", "", @SW_SHOW)
		Case $Tray_Otherinfo
			GUISetState(@SW_SHOW, $GUI_MEMINFO)
			WinSetState("Task Manager Pro - Meminfo", "", @SW_SHOW)
		Case $Tray_Exit
			_SaveOptData($Adress)
			Exit
		Case $Tray_State
			If TrayItemGetText($Tray_State) = "Hide Main"  Then
				GUISetState(@SW_HIDE, $Main)
				TrayItemSetText($Tray_State, "Show Main")
			Else
				GUISetState(@SW_SHOW, $Main)
				WinSetState("Task Manager Pro - Main", "", @SW_SHOW)
				TrayItemSetText($Tray_State, "Hide Main")
			EndIf
		Case $Tray_About
			GUISetState(@SW_SHOW, $GUI_ABOUT)
			WinSetState("Task Manager Pro - About", "", @SW_SHOW)
		Case $Tray_CMD
			GUISetState(@SW_SHOW,$GUI_CMD)
			WinSetState("Task Manager Pro - CMD","",@SW_SHOW)
		Case $Tray_WEBSITELOCKERUNLOCKER
			If IsAdmin() = 0 Then
				GUISetState(@SW_HIDE,$GUI_WEBSITELOCKERUNLOCKER)
				_MsgBox("Error! Admin requiered!", "You must be an administrator to use this feature!")
			Else
				GUISetState(@SW_SHOW,$GUI_WEBSITELOCKERUNLOCKER)
				WinSetState("Task Manager Pro - Website Locker\Unlocker","",@SW_SHOW)
				_Load_BlockedWebSites()
			EndIf
	EndSwitch
	$nMsg = GUIGetMsg()
	Switch $nMsg
		Case $_HomePage
			ShellExecute("http://www.alpha-thema.com")
		Case $_ProCMD
			GUISetState(@SW_SHOW,$GUI_CMD)
			WinSetState("Task Manager Pro - CMD","",@SW_SHOW)
		Case $_WebsiteLockerUnlocker
			If IsAdmin() = 0 Then
				GUISetState(@SW_HIDE,$GUI_WEBSITELOCKERUNLOCKER)
				_MsgBox("Error! Admin requiered!", "You must be an administrator to use this feature!")
			Else
				GUISetState(@SW_SHOW,$GUI_WEBSITELOCKERUNLOCKER)
				WinSetState("Task Manager Pro - Website Locker\Unlocker","",@SW_SHOW)
				_Load_BlockedWebSites()
			EndIf
		Case $CLOSE_WEBSITELOCKERUNLOCKER
			GUISetState(@SW_HIDE,$GUI_WEBSITELOCKERUNLOCKER)
		Case $Load_BlockedWebSites
			_Load_BlockedWebSites()
		Case $Save_BlockedWebSites
			_Save_BlockedWebSites()
		Case $Add_BlockedWebSites
			$Data = InputBox("Site Locker/Unlocker","Type here the website you want to lock.")
			If @error <> 1 And $Data <> "" Then
				_AddToList_BlockedWebSites($Data)
			EndIf
		Case $Delete_BlockedWebSites
			_DeleteFromList_BlockedWebSites(GUICtrlRead(GUICtrlRead($SiteList_BlockedWebSites)))
		Case $Clear_BlockedWebSites
			_ClearList_BlockedWebSites()
		Case $StartStop
			If GUICtrlRead($StartStop) = "Stop Clock" Then
				GUICtrlSetData($StartStop,"Start Clock") 
				$CLOCK_COND = 0
				$CLOCK_WTD = 0
			Else
				If GUICtrlRead($OPT_ATT) = $GUI_CHECKED Then
					$CLOCK_HH = Int(GUICtrlRead($HH))
					$CLOCK_MM = Int(GUICtrlRead($MM))
					If GUICtrlRead($HH) = "" Or GUICtrlRead($MM) = "" Then
						_MsgBox("Error!","Please type something in both inputs!")
					Else
						$CLOCK_COND = 1
					EndIf
				ElseIf GUICtrlRead($OPT_TIME) = $GUI_CHECKED Then 
					$CLOCK_MS = Int(GUICtrlRead($MS))
					If GUICtrlRead($MS) = "" Then
						_MsgBox("Error!","Please type something in the input!")
					Else 
						$CLOCK_COND = 2
					EndIf
				Else
					_MsgBox("Error!","Please choose a condition!")
				EndIf
				
				If $CLOCK_COND <> 0 Then
					If GUICtrlRead($OPT_SHUTDOWN) = $GUI_CHECKED Then
						$CLOCK_WTD = 1
					ElseIf GUICtrlRead($OPT_HIBERNATE) = $GUI_CHECKED Then
						$CLOCK_WTD = 2
					ElseIf GUICtrlRead($OPT_LOGOFF) = $GUI_CHECKED Then
						$CLOCK_WTD = 3
					ElseIf GUICtrlRead($OPT_RESTART) = $GUI_CHECKED Then
						$CLOCK_WTD = 4
					ElseIf GUICtrlRead($OPT_SHOWMSGTOTRAY) = $GUI_CHECKED Then
						$CLOCK_WTD = 5
					ElseIf GUICtrlRead($OPT_STANDBY) = $GUI_CHECKED Then
						$CLOCK_WTD = 6
					Else
						_MsgBox("Error!","Please choose what to do after the condition will be true!")
					EndIf
				EndIf
				If $CLOCK_COND <> 0 And $CLOCK_WTD <> 0 Then
					GUICtrlSetData($StartStop,"Stop Clock")
					If $ClOCK_COND = 2 Then
						$CLOCK_TIMER = TimerInit()
					EndIf
				EndIf
			EndIf
		Case $Send
			_Execute(GUICtrlRead($Input1))
		Case $CLOSE_CMD_GUI
			GUISetState(@SW_HIDE,$GUI_CMD)
		Case $_UserManager
			If IsAdmin() = 1 Then
				GUISetState(@SW_SHOW, $UserManager_GUI)
				WinSetState("Task Manager Pro - User Manager", "", @SW_SHOW)
			Else
				_MsgBox("Error! Admin requiered!", "You must be an administrator to use this feature!")
			EndIf
		Case $CLOSE_UserManager_GUI
			GUISetState(@SW_HIDE, $UserManager_GUI)
		Case $_Change
			If FileExists("temp.bat") = 1 Then
				FileDelete("temp.bat")
			EndIf
			$User = GUICtrlRead($TUser)
			$Pass = GUICtrlRead($TPass)
			FileWrite("temp.bat", "net user " & $User & " " & $Pass)
			Run("temp.bat", "", @SW_HIDE)
			Sleep(500)
			FileDelete("temp.bat")
		Case $_Delete
			If FileExists("temp.bat") = 1 Then
				FileDelete("temp.bat")
			EndIf
			$User = GUICtrlRead($TUser)
			$Pass = GUICtrlRead($TPass)
			FileWrite("temp.bat", "net user " & $User & " /delete")
			Run("temp.bat", "", @SW_HIDE)
			Sleep(500)
			FileDelete("temp.bat")
		Case $_Create
			If FileExists("temp.bat") = 1 Then
				FileDelete("temp.bat")
			EndIf
			$User = GUICtrlRead($TUser)
			$Pass = GUICtrlRead($TPass)
			FileWrite("temp.bat", "net user " & $User & " /ADD")
			Run("temp.bat", "", @SW_HIDE)
			Sleep(500)
			FileDelete("temp.bat")
			If $Pass <> "" Then
				FileWrite("temp.bat", "net user " & $User & " " & $Pass)
				Run("temp.bat", "", @SW_HIDE)
				Sleep(500)
				FileDelete("temp.bat")
			EndIf
		Case $CLOSE_PCCONTROL_GUI
			GUISetState(@SW_HIDE, $GUI_PCCONTROL)
		Case $PCClock
			GUISetState(@SW_SHOW, $GUI_PCCONTROL)
			WinSetState("Task Manager Pro - Clock/Autoshutdown", "", @SW_SHOW)
		Case $Shutdown
			Shutdown(1)
		Case $Restart
			Shutdown(2)
		Case $Hibernate
			Shutdown(64)
		Case $Logoff
			Shutdown(0)
		Case $Standby
			Shutdown(32)
		Case $About
			GUISetState(@SW_SHOW, $GUI_ABOUT)
			WinSetState("Task Manager Pro - About", "", @SW_SHOW)
		Case $LBL_RECL_1
			ShellExecute("http://www.alpha-thema.com")
		Case $LBL_RECL_2
			ShellExecute("http://www.alpha-thema.com")
		Case $Minimize_Main
			WinSetState("Task Manager Pro - Main", "", @SW_MINIMIZE)
		Case $CLOSE_MEMINFO_GUI
			GUISetState(@SW_HIDE, $GUI_MEMINFO)
		Case $Close_ABOUT
			GUISetState(@SW_HIDE, $GUI_ABOUT)
		Case $SaveList
			$TMP = FileOpenDialog("Please locate me to your save file", @WindowsDir & "", "Text format (*.txt;*.ini)")
			If $TMP <> "" Then
				FileDelete($TMP)
				_SaveList($TMP)
			EndIf
		Case $MemoryInfo
			GUISetState(@SW_SHOW, $GUI_MEMINFO)
			WinSetState("Task Manager Pro - Meminfo", "", @SW_SHOW)
		Case $Browse
			$TMP = FileOpenDialog("Please locate me to your save file", @WindowsDir & "", "Text format (*.txt;*.ini)")
			GUICtrlSetData($SaveAdress, $TMP)
		Case $ProcessClose
			_PClose(GUICtrlRead(GUICtrlRead($WinList)))
		Case $WinKill
			_Kill(GUICtrlRead(GUICtrlRead($WinList)))
		Case $Close_Main
			GUISetState(@SW_HIDE, $Main)
			If $ssl26 = "1"  Then
				TrayTip("Info", "Click here to show Task Manager Pro!", 0)
			EndIf
			TrayItemSetText($Tray_State, "Show")
		Case $Open_Options
			GUISetState(@SW_SHOW, $Options)
			WinSetState("Task Manager Pro - Options", "", @SW_SHOW)
		Case $Close_Options
			_Apply()
			GUISetState(@SW_HIDE, $Options)
		Case $Close
			_Close(GUICtrlRead(GUICtrlRead($WinList)))
		Case $SetX
			$Data = GUICtrlRead(GUICtrlRead($WinList))
			If $Data = "0"  Then
				_MsgBox("Error", "No item selected! Please select an window before push a button.")
			Else
				$TMP = _InputBox("Task Manager Pro", "Type here the new X position.")
				If $TMP <> " CLOSED " And $TMP <> "" Then
					_SetX($Data, $TMP)
				EndIf
				If $TMP = "" Then
					_MsgBox("Error", "Please type something in inputbox before push OK!")
				EndIf
			EndIf
		Case $SetY
			$Data = GUICtrlRead(GUICtrlRead($WinList))
			If $Data = "0"  Then
				_MsgBox("Error", "No item selected! Please select an window before push a button.")
			Else
				$TMP = _InputBox("Task Manager Pro", "Type here the new Y position.")
				If $TMP <> " CLOSED " And $TMP <> "" Then
					_SetY(GUICtrlRead(GUICtrlRead($WinList)), $TMP)
				EndIf
				If $TMP = "" Then
					_MsgBox("Error", "Please type something in inputbox before push OK!")
				EndIf
			EndIf
		Case $SetHeight
			$Data = GUICtrlRead(GUICtrlRead($WinList))
			If $Data = "0"  Then
				_MsgBox("Error", "No item selected! Please select an window before push a button.")
			Else
				$TMP = _InputBox("Task Manager Pro", "Type here the new height.")
				If $TMP <> " CLOSED " And $TMP <> "" Then
					_SetHeight(GUICtrlRead(GUICtrlRead($WinList)), $TMP)
				EndIf
				If $TMP = "" Then
					_MsgBox("Error", "Please type something in inputbox before push OK!")
				EndIf
			EndIf
		Case $SetWidth
			$Data = GUICtrlRead(GUICtrlRead($WinList))
			If $Data = "0"  Then
				_MsgBox("Error", "No item selected! Please select an window before push a button.")
			Else
				$TMP = _InputBox("Task Manager Pro", "Type here the new width.")
				If $TMP <> " CLOSED " And $TMP <> "" Then
					_SetWidth(GUICtrlRead(GUICtrlRead($WinList)), $TMP)
				EndIf
				If $TMP = "" Then
					_MsgBox("Error", "Please type something in inputbox before push OK!")
				EndIf
			EndIf
		Case $SetTitle
			$Data = GUICtrlRead(GUICtrlRead($WinList))
			If $Data = "0"  Then
				_MsgBox("Error", "No item selected! Please select an window before push a button.")
			Else
				$TMP = _InputBox_TextSuport("Task Manager Pro", "Type here the new title.")
				If $TMP <> " CLOSED " And $TMP <> "" Then
					_SetTitle(GUICtrlRead(GUICtrlRead($WinList)), $TMP)
				EndIf
				If $TMP = "" Then
					_MsgBox("Error", "Please type something in inputbox before push OK!")
				EndIf
			EndIf
		Case $Hide
			_Hide(GUICtrlRead(GUICtrlRead($WinList)))
		Case $Maximize
			_Maximize(GUICtrlRead(GUICtrlRead($WinList)))
		Case $Minimize
			_Minimize(GUICtrlRead(GUICtrlRead($WinList)))
		Case $MinimizeAll
			WinMinimizeAll()
		Case $UnminimizeAll
			WinMinimizeAllUndo()
		Case $SetPriority
			$Data = GUICtrlRead(GUICtrlRead($WinList))
			If $Data = "0"  Then
				_MsgBox("Error", "No item selected! Please select an window before push a button.")
			Else
				$TMP = _InputBox("Task Manager Pro", "Type here the new priority (1,2,3,4,5).")
				If  $TMP <> "" And $TMP <> " CLOSED " Then
					_SetPriority($Data, $TMP)
				EndIf
				If $TMP = "" Then
					_MsgBox("Error", "Please type something in inputbox before push OK!")
				EndIf
			EndIf
		Case $Show
			_Show(GUICtrlRead(GUICtrlRead($WinList)))
		Case $Update
			_Update()
	EndSwitch
WEnd
#EndRegion

#Region: Functions
Func _VistaLikeRenderButton($hButton, ByRef $tBUTTON_IMAGELIST, ByRef $aImagesHandles)

	$hButton = GUICtrlGetHandle($hButton) 
	If Not $hButton Then
		Return SetError(1, 0, 0)
	EndIf

	Local $aButtonSize = WinGetClientSize($hButton)
	If @error Then
		Return SetError(2, 0, 0) 
	EndIf

	If Not UBound($aImagesHandles) = 31 Then
		$aImagesHandles = _CreateArrayHIcons()
		If @error Then
			Return SetError(3, @error, 0)
		EndIf
	EndIf

	Local $aCall = DllCall("comctl32.dll", "hwnd", "ImageList_Create", _
			"int", $aButtonSize[0] - 6, _
			"int", $aButtonSize[1], _
			"dword", 32, _ 
			"int", 31, _
			"int", 1)

	If @error Or Not $aCall[0] Then
		Return SetError(4, 0, 0) 
	EndIf

	Local $hImageListInThread = $aCall[0]

	DllCall("comctl32.dll", "int", "ImageList_ReplaceIcon", _
			"hwnd", $hImageListInThread, _
			"int", -1, _ ;
			"hwnd", $aImagesHandles[27]) 

	DllCall("comctl32.dll", "int", "ImageList_ReplaceIcon", _
			"hwnd", $hImageListInThread, _
			"int", -1, _ 
			"hwnd", $aImagesHandles[28])

	DllCall("comctl32.dll", "int", "ImageList_ReplaceIcon", _
			"hwnd", $hImageListInThread, _
			"int", -1, _ 
			"hwnd", $aImagesHandles[29]) 

	DllCall("comctl32.dll", "int", "ImageList_ReplaceIcon", _
			"hwnd", $hImageListInThread, _
			"int", -1, _ 
			"hwnd", $aImagesHandles[30]) 

	DllCall("comctl32.dll", "int", "ImageList_ReplaceIcon", _
			"hwnd", $hImageListInThread, _
			"int", -1, _ 
			"hwnd", $aImagesHandles[0])

	$tBUTTON_IMAGELIST = DllStructCreate("hwnd ImageList;" & _
			"int Left;" & _
			"int Top;" & _
			"int Right;" & _
			"int Bottom;" & _
			"dword Align")

	DllStructSetData($tBUTTON_IMAGELIST, "Align", 4) 
	DllStructSetData($tBUTTON_IMAGELIST, "ImageList", $hImageListInThread)

	Local $pBUTTON_IMAGELIST = DllStructGetPtr($tBUTTON_IMAGELIST)

	$aCall = DllCall("kernel32.dll", "ptr", "GetModuleHandleW", "wstr", "kernel32.dll")
	If @error Or Not $aCall[0] Then
		Return SetError(5, 0, 0)
	EndIf

	Local $hHandle = $aCall[0]

	Local $aSleep = DllCall("kernel32.dll", "ptr", "GetProcAddress", "ptr", $hHandle, "str", "Sleep")
	If @error Or Not $aCall[0] Then
		Return SetError(5, 0, 0)
	EndIf
	Local $pSleep = $aSleep[0]

	$aCall = DllCall("kernel32.dll", "ptr", "GetModuleHandleW", "wstr", "comctl32.dll")
	If @error Or Not $aCall[0] Then
		Return SetError(6, 0, 0)
	EndIf

	$hHandle = $aCall[0]

	Local $aImLReplaceIcon = DllCall("kernel32.dll", "ptr", "GetProcAddress", "ptr", $hHandle, "str", "ImageList_ReplaceIcon")
	If @error Or Not $aCall[0] Then
		Return SetError(6, 0, 0)
	EndIf
	Local $pImLReplaceIcon = $aImLReplaceIcon[0]

	$aCall = DllCall("kernel32.dll", "ptr", "GetModuleHandleW", "wstr", "user32.dll")
	If @error Or Not $aCall[0] Then
		Return SetError(7, 0, 0)
	EndIf

	$hHandle = $aCall[0]

	Local $aSendMessageW = DllCall("kernel32.dll", "ptr", "GetProcAddress", "ptr", $hHandle, "str", "SendMessageW")
	If @error Or Not $aCall[0] Then
		Return SetError(7, 0, 0)
	EndIf
	Local $pSendMessageW = $aSendMessageW[0]

	Local $aGetWindowLongW = DllCall("kernel32.dll", "ptr", "GetProcAddress", "ptr", $hHandle, "str", "GetWindowLongW")
	If @error Or Not $aCall[0] Then
		Return SetError(7, 0, 0)
	EndIf
	Local $pGetWindowLongW = $aGetWindowLongW[0]

	Local $tHandles = DllStructCreate("hwnd[27]")
	For $i = 1 To 27
		DllStructSetData($tHandles, 1, $aImagesHandles[$i - 1], $i)
	Next

	Local $pHandles = DllStructGetPtr($tHandles)

	$aCall = DllCall("kernel32.dll", "ptr", "VirtualAlloc", _
			"ptr", 0, _
			"dword", 512, _
			"dword", 4096, _ 
			"dword", 64) 

	If @error Or Not $aCall[0] Then
		Return SetError(8, 0, 0)
	EndIf

	Local $pRemoteCode = $aCall[0]

	Local $tCodeBuffer = DllStructCreate("byte[512]", $pRemoteCode)

	DllStructSetData($tCodeBuffer, 1, _
			"0x" & _
			"" & _ 
			"BB" & SwapEndian($pHandles) & _              
			"" & _ 
			"8B03" & _                                   
			"" & _ 
			"50" & _                                   
			"68" & SwapEndian(4) & _                       
			"68" & SwapEndian($hImageListInThread) & _    
			"B8" & SwapEndian($pImLReplaceIcon) & _       
			"FFD0" & _                                    
			"" & _ 
			"68" & SwapEndian($pBUTTON_IMAGELIST) & _      
			"68" & SwapEndian(0) & _                       
			"68" & SwapEndian(5634) & _                  
			"68" & SwapEndian($hButton) & _              
			"B8" & SwapEndian($pSendMessageW) & _         
			"FFD0" & _                                  
			"" & _ ; 
			"68" & SwapEndian(0) & _                      
			"68" & SwapEndian(1) & _                      
			"68" & SwapEndian(10) & _                    
			"68" & SwapEndian($hButton) & _             
			"B8" & SwapEndian($pSendMessageW) & _        
			"FFD0" & _                                  
			"" & _ 
			"68" & SwapEndian(150) & _                    
			"B8" & SwapEndian($pSleep) & _                
			"FFD0" & _                                     
			"" & _
			"68" & SwapEndian(-16) & _                 
			"68" & SwapEndian($hButton) & _              
			"B8" & SwapEndian($pGetWindowLongW) & _       
			"FFD0" & _                                    
			"" & _ 
			"A9" & SwapEndian(7) & _                      
			"74" & Hex(-36, 2) & _                         
			"" & _ 
			"68" & SwapEndian(0) & _                     
			"68" & SwapEndian(0) & _                      
			"68" & SwapEndian(242) & _                    
			"68" & SwapEndian($hButton) & _                
			"B8" & SwapEndian($pSendMessageW) & _         
			"FFD0" & _                                     
			"" & _ 
			"83F8" & Hex(8, 2) & _                         
			"75" & Hex(-68, 2) & _                         
			"" & _ 
			"83C3" & Hex(4, 2) & _                         
			"81FB" & SwapEndian($pHandles + 27 * 4) & _    
			"" & _ 
			"72" & Hex(5, 2) & _                           
			"" & _ 
			"E9" & SwapEndian(-163) & _                    
			"" & _ 
			"E9" & SwapEndian(-163) & _                    
			"C3" _                                         
			)

	$aCall = DllCall("kernel32.dll", "ptr", "CreateThread", _
			"ptr", 0, _
			"dword", 0, _
			"ptr", $pRemoteCode, _
			"ptr", 0, _
			"dword", 0, _
			"dword*", 0)

	If @error Or Not $aCall[0] Then
		Return SetError(9, 0, 0)
	EndIf

	Local $hRenderingThread = $aCall[0]

	Return SetError(0, 0, $hRenderingThread)

EndFunc   

Func _CreateArrayHIcons($sFile = "")

	Local $a_hCall = DllCall("kernel32.dll", "hwnd", "GetModuleHandleW", "wstr", "gdiplus.dll")

	If @error Then
		Return SetError(1, 0, "") 
	EndIf

	If Not $a_hCall[0] Then
		Local $hDll = DllOpen("gdiplus.dll")
		If @error Or $hDll = -1 Then
			Return SetError(2, 0, "") 
		EndIf
	EndIf

	Local $tGdiplusStartupInput = DllStructCreate("dword GdiplusVersion;" & _
			"ptr DebugEventCallback;" & _
			"int SuppressBackgroundThread;" & _
			"int SuppressExternalCodecs")


	DllStructSetData($tGdiplusStartupInput, "GdiplusVersion", 1)

	Local $a_iCall = DllCall("gdiplus.dll", "dword", "GdiplusStartup", _
			"dword*", 0, _
			"ptr", DllStructGetPtr($tGdiplusStartupInput), _
			"ptr", 0)

	If @error Or $a_iCall[0] Then
		Return SetError(3, 0, "")
	EndIf

	Local $hGDIplus = $a_iCall[1] 

	Local $hMemory 
	Local $pBitmap 

	If $sFile Then 

		$a_iCall = DllCall("gdiplus.dll", "dword", "GdipLoadImageFromFile", _
				"wstr", $sFile, _
				"ptr*", 0)

		If @error Or $a_iCall[0] Then
			DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
			Return SetError(4, 0, "") 
		EndIf

		$pBitmap = $a_iCall[2] 

	Else

		Local $bBinary = "0x474946383961010015008780002C628B9EB0BACFCFCFCEE9F899D4E6C3D8E3CC" & _
				"DCE4B6DEF525CFFBEBEBEB68B3DBCDD8DDB5EBF9E9F5FBC0DCEC39CDF270D7F7" & _
				"D8D8D8C7D6DDCCE4F3DEEFF5E8F1F6CDD3D6D4DFE630CEF6C1E4F8C4DAE699E8" & _
				"FCD6D9DABBE1F6E9F0F3C9E0EC85D5EEE7F4FBD4D4D4C2ECF8B4D2DBD2E4EE7F" & _
				"C2E5CDE2EEF4F4F4C0E2F5D9E0E3E5F0F4CED4D7C8E4F5D7EFF5A7D3E0BCDBED" & _
				"2FD4FFE8EFF3CDDBE1C1E1F238D6FDDBDFE1C7D8E131D4FFC4DCEA92E7FDC2D1" & _
				"D5BEDAEBD0E0E92FCEF778BDE2E9F6FCD9DDDFF0F3F4D6E1E7A7E9FBD4DEE393" & _
				"CEEDD2D5D641D7FC707070CFD2D3D0EEF698D1EFD1DFE7EAEDEE72B9DFD2D8DA" & _
				"ECF4F77ED6F1C9D7DED0E6F2DDF0FAEDF3F637CDF3C4E5F6D7DCDEBEE0F3F0F0" & _
				"F18CCAEBE4F3FCCAE9FABEDDEEC7E1EFCADDE6C9D0D2D8E1E53C7FB1ADB2B5A0" & _
				"D3E3C2D8E5CCDEE8B8DDF228CFFA6DB6DDBCECF8C5DFEE77D6F4D9DBDCC5D7E0" & _
				"CDE7F6E8F3F9D0D3D4C8DBE5A0E9FBD4DADCECF1F3CAE3F28BD5ECE5F4FCD4D7" & _
				"D8C9EDF7BBD1D886C6E8D0E2ECFCFCFCAED2DD92D4E9C9D5DBAEEAFA44D8FBD8" & _
				"EEFAD0DCE3E5F2FBCCD5D9C8E7F9ECEFF03DD6FDCADAE234D5FEC0D9E82DCEF8" & _
				"DCDEDFD4E3EBD0D6D9D1D1D1D3ECF9ECEDEDD1D9DDECF4F8E1F2FB34CEF4C5E6" & _
				"F9BEE3F7BDDEF1C4E2F3C8DDE9DADADAF2F2F2CFD7DBEFEFEFEAF1F4BBDFF3CB" & _
				"DFEAC3E3F6C1DEEFC9E7F7C7E5F73AD6FDEEF0F2EFEFF0D2E1EAD6DDE0E6F1F7" & _
				"2BCEF9CFDADFD6D6D6D3DBDFC6DEEBC2DBE9CEDDE6C6DBE7CFE3EEBFDFF133D5" & _
				"FE3FD7FCEBF5FBEEF4F7EFF3F646D8FB36D5FE3BCDF132CEF5EAF1F3EAEFF1E6" & _
				"F3FBCEE4F036CDF4EBF3F7C9E6F7C3E0F0D3DEE5CBD6DCF1F2F2BADCF0C6E1F1" & _
				"CBD4D8C3DDECCBE5F5E9F2F7EBEEEFD2D2D2EDEEEEDBDBDBF3F3F3EFF1F3D6DF" & _
				"E3E6F5FCE7F0F6EDF4F9EAF6FC42D7FCEDF1F33BD6FDEAF5FAEEF3F529CFF9CB" & _
				"E3F0D1DCE1EBF0F2E9F0F4C5D9E4CEE1ECE9EEF1DADCDDEBECECD1E5F0CBE8F8" & _
				"CEE6F4CBD9E0DDDDDDD5E2E9ECEFEFD3E0E8E7F0F5E7F2F9D7DEE1E6F1F8E7F2" & _
				"F7EEF1F4ECF5FAF0F1F200000021FF0B4E45545343415045322E300301000000" & _
				"21F904050000FF002C000000000100150000081A00C900BBE36CCB9656D72CB9" & _
				"8BD4EE0D873D47E62811238C4C400021F904050000FF002C0000010001001300" & _
				"000818000BAD10A28D15AB7AD59CD80892C50E94492C2CEC7810100021F90405" & _
				"0000FF002C000001000100130000081800C151F82744DBBF45FFFEA9C8F78AD6"
		$bBinary &= "255189A2F5B912100021F904050000FF002C00000100010013000008170091B8" & _
				"20C7AF20BA62ECC66C2B724ED682668348200B080021F904050000FF002C0000" & _
				"01000100130000081700792DF945EE5FB87F08875C60766886BC291202690A08" & _
				"0021F904050000FF002C00000100010013000008180019F1F165855C14621E64" & _
				"D0B3D7E496814637E0BC1816100021F904050000FF002C000001000100130000" & _
				"081800C58DF817C5CA3F52E9FE4972D5034D183AEA0A98C110100021F9040500" & _
				"00FF002C00000100010013000008170057B1C114A520B50AF74AFC5967EA132E" & _
				"0D6708F808080021F904050000FF002C0000010001001300000817006B30F086" & _
				"09D3BF83DDDEE53AF1A1560E5B8F04410A080021F904050000FF002C00000100" & _
				"01001300000817008311EA87A9A09C7DB0A81C3307A68D34073CF2C40A080021" & _
				"F904050000FF002C0000010001001300000818001D11F9D7ABD7BF7FF8F4C59B" & _
				"8007DA32545F60802817100021F904050000FF002C0000010001001300000818" & _
				"0077D5E9356E5C8310C610C599D6C2130D5D9D9E495113100021F904050000FF" & _
				"002C000001000100130000081700716CF8F7EDDBBF83FFE02953752A85965269" & _
				"DC2008080021F904050000FF002C00000100010012000008160063E8F806A420" & _
				"376E5DBC28DA948153870E072004040021F904050000FF002C00000100010012" & _
				"0000081700716CE8F5ED5B8310C610C153A6EA540A2DA5D2B809080021F90405" & _
				"0000FF002C00000100010013000008170077D5F9376EDCBF83FFE24C6BE18986" & _
				"AE4ECFA4A809080021F904050000FF002C0000010001001300000818001D11E9" & _
				"D7ABD73839F8F4C59B8007DA32545F60802817100021F904050000FF002C0000" & _
				"010001001300000818008311FA8709D3BF7FFB605139660E4C1B690E78E48915" & _
				"100021F904050000FF002C0000010001001300000818006B30F0F6EF5F326A15" & _
				"BABDCB75E243AD1CB61E098214100021F904050000FF002C0000010001001300"
		$bBinary &= "0008170057B1C11425CABF83F74AFC5967EA132E0D6708F808080021F9040500" & _
				"00FF002C000001000100130000081800C58DF0F5CF4A1452E9644872D5034D18" & _
				"3AEA0A98C110100021F904050000FF002C00000100010013000008180019F1F9" & _
				"6785DC3F621EFED1B3D7E496814637E0BC1816100021F904050000FF002C0000" & _
				"01000100130000081800792DF9458E5F3874C5D80DB9C0ECD00C79532404D214" & _
				"100021F904050000FF002C00000100010013000008160091B820C7EF9F418363" & _
				"B61539276B41B341249005040021F904050000FF002C00000100010013000008" & _
				"1800C1511022441BAB45D59CA8C8F78AD6255189A2F5B912100021F904050000" & _
				"FF002C0000010001001300000818000BADF8A78DD5BF7AFFFED90892C50E94492" & _
				"C2CEC7810100021F904050000FF002C00000100010013000008180081DD71B665" & _
				"4BAB6B96DC456AF786C39E237394881116100021F904050A00FF002C000000000" & _
				"100150000081A0093000A15EADFBF5196DC2598870D54845922AC5112902D4940" & _
				"0021F904050A00FF002C000000000100150000081A00C900BBE3CCDFBF56D72CB" & _
				"98BD4EE0D873D47E62811238C4C400021F904050A00FF002C0000000001001500" & _
				"00081A000104D0A3275315439506A4C2C2C408173F267E3C59A30040400021F90" & _
				"4050A00FF002C000000000100150000080E00CB004241B0A0C183040195090800" & _
				"3B"

		Local $tBinary = DllStructCreate("byte[" & BinaryLen($bBinary) & "]")
		DllStructSetData($tBinary, 1, $bBinary)

		$a_hCall = DllCall("kernel32.dll", "hwnd", "GlobalAlloc", _
				"dword", 2, _  
				"dword", DllStructGetSize($tBinary))

		If @error Or Not $a_hCall[0] Then
			DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
			Return SetError(5, 0, "") 
		EndIf

		$hMemory = $a_hCall[0] 

		Local $a_pCall = DllCall("kernel32.dll", "ptr", "GlobalLock", "hwnd", $hMemory)

		If @error Or Not $a_pCall[0] Then
			DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
			DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
			Return SetError(6, 0, "")
		EndIf

		Local $pMemory = $a_pCall[0] 

		DllCall("kernel32.dll", "none", "RtlMoveMemory", _
				"ptr", $pMemory, _
				"ptr", DllStructGetPtr($tBinary), _
				"dword", DllStructGetSize($tBinary))

		DllCall("kernel32.dll", "int", "GlobalUnlock", "hwnd", $hMemory)

		$a_iCall = DllCall("ole32.dll", "int", "CreateStreamOnHGlobal", _
				"ptr", $pMemory, _
				"int", 1, _
				"ptr*", 0)

		If @error Or $a_iCall[0] Then
			DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
			DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
			Return SetError(7, 0, "")
		EndIf

		Local $pStream = $a_iCall[3] 

		$a_iCall = DllCall("gdiplus.dll", "dword", "GdipCreateBitmapFromStream", _
				"ptr", $pStream, _
				"ptr*", 0)

		If @error Or $a_iCall[0] Then
			DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory)
			DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
			Return SetError(8, 0, "")
		EndIf

		$pBitmap = $a_iCall[2] 

	EndIf

	$a_iCall = DllCall("gdiplus.dll", "dword", "GdipImageGetFrameDimensionsCount", _
			"ptr", $pBitmap, _
			"dword*", 0)

	If @error Or $a_iCall[0] Then
		DllCall("gdiplus.dll", "dword", "GdipDisposeImage", "ptr", $pBitmap)
		DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
		If $hMemory Then DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory) 
		Return SetError(9, 0, "")
	EndIf

	Local $iFrameDimensionsCount = $a_iCall[2] 

	Local $tGUID = DllStructCreate("int;short;short;byte[8]")

	$a_iCall = DllCall("gdiplus.dll", "dword", "GdipImageGetFrameDimensionsList", _
			"ptr", $pBitmap, _
			"ptr", DllStructGetPtr($tGUID), _
			"dword", $iFrameDimensionsCount)

	If @error Or $a_iCall[0] Then
		DllCall("gdiplus.dll", "dword", "GdipDisposeImage", "ptr", $pBitmap)
		DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
		If $hMemory Then DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory) 
		Return SetError(10, 0, "")
	EndIf

	$a_iCall = DllCall("gdiplus.dll", "dword", "GdipImageGetFrameCount", _
			"ptr", $pBitmap, _
			"ptr", DllStructGetPtr($tGUID), _
			"dword*", 0)

	If @error Or $a_iCall[0] Then
		DllCall("gdiplus.dll", "dword", "GdipDisposeImage", "ptr", $pBitmap)
		DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
		If $hMemory Then DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory) 
		Return SetError(11, 0, "") 
	EndIf

	Local $iFrameCount = $a_iCall[3]

	Local $aHBitmaps[$iFrameCount]

	For $i = 0 To $iFrameCount - 1

		$a_iCall = DllCall("gdiplus.dll", "dword", "GdipImageSelectActiveFrame", _
				"ptr", $pBitmap, _
				"ptr", DllStructGetPtr($tGUID), _
				"dword", $i)

		If @error Or $a_iCall[0] Then
			$aHBitmaps[$i] = 0
			ContinueLoop
		EndIf

		$a_iCall = DllCall("gdiplus.dll", "dword", "GdipCreateHICONFromBitmap", _
				"ptr", $pBitmap, _
				"hwnd*", 0)

		If @error Or $a_iCall[0] Then
			$aHBitmaps[$i] = 0 
			ContinueLoop
		EndIf

		$aHBitmaps[$i] = $a_iCall[2] 

	Next

	DllCall("gdiplus.dll", "dword", "GdipDisposeImage", "ptr", $pBitmap)
	DllCall("gdiplus.dll", "none", "GdiplusShutdown", "dword*", $hGDIplus)
	If $hMemory Then DllCall("kernel32.dll", "int", "GlobalFree", "hwnd", $hMemory) ; free memory

	Return SetError(0, 0, $aHBitmaps)

EndFunc   

Func SwapEndian($iValue)
	Return Hex(BinaryMid($iValue, 1, 4))
EndFunc   

Func _ILDown()
	$tIL = $tIL - 1
EndFunc

Func _GetNewIL()
	$tIL = $tIL + 1
	Return $tIL
EndFunc 

Func _Speak($Text)
	$TTSVoice.Speak($Text,3)
EndFunc

Func _UpdateClock()
	If $CLOCK_COND <> 0 And $CLOCK_WTD <> 0 Then
		Switch $CLOCK_COND
			Case 1
				If @HOUR >= $CLOCK_HH And @MIN >= $CLOCK_MM Then
					_ClockDoAction()
				EndIf
			Case 2
				If TimerDiff($CLOCK_TIMER) > $CLOCK_MS Then
					_ClockDoAction()
				EndIf
		EndSwitch
	EndIf
EndFunc

Func _ClockDoAction()
	Switch $CLOCK_WTD
		Case 1
			Shutdown(1)
		Case 2
			Shutdown(64)
		Case 3
			Shutdown(0)
		Case 4
			Shutdown(2)
		Case 5
			TrayTip("Clock", "The time is: " & @HOUR & ":" & @MIN & ":" & @SEC, 0)
			_Speak("The time is: " & @HOUR & ":" & @MIN & ":" & @SEC)
		Case 6
			Shutdown(32)
	EndSwitch
	$CLOCK_COND = 0
	$CLOCK_WTD = 0
	GUICtrlSetData($StartStop,"Start Clock") 
EndFunc

Func _GetCPUData()
	Local $HKCU = "HKEY_CURRENT_USER"
	Local $HKLM = "HKEY_LOCAL_MACHINE"
	Local $ProcessorInfo[2]
	$ProcessorInfo[0] = StringStripWS(RegRead($HKLM & "\HARDWARE\DESCRIPTION\System\CentralProcessor\0", "ProcessorNameString"), 4)
	$ProcessorInfo[1] = EnvGet("NUMBER_OF_PROCESSORS") ;
	Return $ProcessorInfo
EndFunc

Func _InputBox_TextSuport($Title, $Text, $Width = 330, $Height = 138)
	SetError(0)
	Local $GUI_INPUT
	Local $CLOSE_INPUT
	Local $Ok
	Local $Cancel
	Local $Input
	Local $Ret
	$GUI_INPUT = GUICreate($Title, $Width, $Height, -1, -1, BitOR($WS_POPUP, $WS_BORDER),136)
	$CLOSE_INPUT = GUICtrlCreateLabel("X", $Width - 15, 0, 11, 20)
	GUICtrlSetFont(-1, 10, 800, 0, "Comic Sans MS")
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel(" " & $Title, 0, 4, @DesktopWidth, 20, -1, $GUI_WS_EX_PARENTDRAG)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlCreateGraphic(0, 0, @DesktopWidth, 22)
	GUICtrlSetBkColor(-1, 0x000000)
	$Ok = GUICtrlCreateButton("Ok", 32, 104, 115, 25, 0)
	_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
	$Cancel = GUICtrlCreateButton("Cancel", 184, 104, 115, 25, 0)
	_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
	GUICtrlCreateLabel($Text, 8, 32, $Width, 17)
	$Input = GUICtrlCreateInput("", 8, 80, 313, 21)
	GUISetState(@SW_SHOW, $GUI_INPUT)
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $CLOSE_INPUT
				$Ret = " CLOSED "
				ExitLoop
			Case $Ok
				ExitLoop
			Case $Cancel
				$Ret = " CLOSED "
				ExitLoop
		EndSwitch
	WEnd
	If $Ret <> " CLOSED " Then
		$Ret = GUICtrlRead($Input)
		$Ret = $Ret
	EndIf
	GUIDelete($GUI_INPUT)
	_ILDown()
	_ILDown()
	Return $Ret
EndFunc

Func _InputBox($Title, $Text, $Width = 330, $Height = 138)
	SetError(0)
	Local $GUI_INPUT
	Local $CLOSE_INPUT
	Local $Ok
	Local $Cancel
	Local $Input
	Local $Ret
	$GUI_INPUT = GUICreate($Title, $Width, $Height, -1, -1, BitOR($WS_POPUP, $WS_BORDER),136)
	$CLOSE_INPUT = GUICtrlCreateLabel("X", $Width - 15, 0, 11, 20)
	GUICtrlSetFont(-1, 10, 800, 0, "Comic Sans MS")
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlSetCursor(-1, 0)
	GUICtrlCreateLabel(" " & $Title, 0, 4, @DesktopWidth, 20, -1, $GUI_WS_EX_PARENTDRAG)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlCreateGraphic(0, 0, @DesktopWidth, 22)
	GUICtrlSetBkColor(-1, 0x000000)
	$Ok = GUICtrlCreateButton("Ok", 32, 104, 115, 25, 0)
	_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
	$Cancel = GUICtrlCreateButton("Cancel", 184, 104, 115, 25, 0)
	_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
	GUICtrlCreateLabel($Text, 8, 32, $Width, 17)
	$Input = GUICtrlCreateInput("", 8, 80, 313, 21, $ES_NUMBER)
	GUISetState(@SW_SHOW, $GUI_INPUT)
	While 1
		$nMsg = GUIGetMsg()
		Switch $nMsg
			Case $CLOSE_INPUT
				$Ret = " CLOSED "
				SetError(1)
				ExitLoop
			Case $Ok
				ExitLoop
			Case $Cancel
				$Ret = " CLOSED "
				SetError(1)
				ExitLoop
		EndSwitch
	WEnd
	If $Ret <> " CLOSED " Then
		$Ret = GUICtrlRead($Input)
		$Ret = Int($Ret)
	EndIf
	GUIDelete($GUI_INPUT)
	_ILDown()
	_ILDown()
	Return $Ret
EndFunc

Func _Load_BlockedWebSites()
	_ClearList_BlockedWebSites()
	Local $File
	Local $Data
	$File = FileOpen($Adress_BlockedWebSites,0)
	SetError(0)
	$Data = FileReadLine($File)
	While @error <> -1 
		$Data = StringSplit($Data," ")
		$Data = $Data[2]
		If $Data = "" Then
			FileClose($File)
			FileDelete($Adress_BlockedWebSites)
			FileWrite($Adress_BlockedWebSites,"")
			Return 0
		Else
			_AddToList_BlockedWebSites($Data)
		EndIf
		$Data = FileReadLine($File)
	WEnd
	FileClose($File)
EndFunc

Func _Save_BlockedWebSites()
	Local $i
	Local $File
	Local $Data
	If FileExists($Adress_BlockedWebSites) = 1 Then
		FileDelete($Adress_BlockedWebSites) 
	EndIf
	$i = 1
	$File = FileOpen($Adress_BlockedWebSites,1)
	While $i < $ListMaxLength_BlockedWebSites
		If $ListB_BlockedWebSites[$i] = 1 Then
			$Data = GUICtrlRead($List_BlockedWebSites[$i])
			$Data = StringSplit($Data,"|")
			$Data = $Data[1]
			FileWriteLine($File,"127.0.0.0 " & $Data)
		EndIf
		$i = $i + 1
	WEnd
	FileClose($File)
EndFunc

Func _Init_BlockedWebSites()
	Local $i
	While $i < $ListMaxLength_BlockedWebSites
		$List_BlockedWebSites[$i] = 0
		$ListB_BlockedWebSites[$i] = 0
		$i = $i + 1
	WEnd
	Global $Adress_BlockedWebSites
	$Adress_BlockedWebSites = @WindowsDir & "\system32\drivers\etc"
	If FileExists($Adress_BlockedWebSites & "\temp") = 0 Then
		FileWrite($Adress_BlockedWebSites & "\temp","")
		FileDelete($Adress_BlockedWebSites & "\hosts")
		FileWrite($Adress_BlockedWebSites & "\hosts","")
	EndIf
	If FileExists($Adress_BlockedWebSites & "\hosts") = 0 Then
		FileWrite($Adress_BlockedWebSites & "\hosts","")
	EndIf
	$Adress_BlockedWebSites = $Adress_BlockedWebSites & "\hosts"
EndFunc

Func _ClearList_BlockedWebSites()
	Local $i
	$i = 1
	While $i < $ListMaxLength_BlockedWebSites
		GUICtrlDelete($List_BlockedWebSites[$i])
		$ListB_BlockedWebSites[$i] = 0
		$i = $i + 1
	WEnd
EndFunc

Func _GetNumberOfItems_BlockedWebSites()
	Local $i
	Local $k 
	$k = 0
	$i = 1
	While $i < $ListMaxLength_BlockedWebSites
		If $ListB_BlockedWebSites[$i] = 1 Then
			$k = $k + 1
		EndIf
		$i = $i + 1
	WEnd
	Return $k
EndFunc

Func _GetFreeListId_BlockedWebSites()
	Local $i
	$i = 1
	While $i < $ListMaxLength_BlockedWebSites
		If $ListB_BlockedWebSites[$i] = 0 Then
			ExitLoop
		EndIf
		$i = $i + 1
	WEnd
	Return $i
EndFunc

Func _DeleteFromList_BlockedWebSites($Data)
	Local $i 
	$i = 1
	While $i < $ListMaxLength_BlockedWebSites
		If GUICtrlRead($List_BlockedWebSites[$i]) = $Data And $ListB_BlockedWebSites[$i] = 1 Then
			GUICtrlDelete($List_BlockedWebSites[$i])
			$ListB_BlockedWebSites[$i] = 0
			ExitLoop
		EndIf
		$i = $i + 1
	WEnd
EndFunc

Func _AddToList_BlockedWebSites($Data)
	Local $k
	$k = _GetFreeListId_BlockedWebSites()
	$List_BlockedWebSites[$k] = GUICtrlCreateListViewItem($Data, $SiteList_BlockedWebSites)
	$ListB_BlockedWebSites[$k] = 1
EndFunc

Func _UpdateOtherInfo()
	Local $mem = MemGetStats()
	Local $totalram = $mem[1] / 1024
	Local $availableram = $mem[2] / 1024
	Local $totalpagefile = $mem[3] / 1024
	Local $availablepagefile = $mem[4] / 1024
	Local $totalvirtual = $mem[5] / 1024
	Local $avaiablevirtual = $mem[6] / 1024
	Local $language
	Local $osversion
	Local $ostype
	Local $TMP
	
	GUICtrlSetData($LBL_TOTAL_RAM, Round($totalram, 2) & " MB")
	GUICtrlSetData($LBL_A_RAM, Round($availableram, 2) & " MB")
	GUICtrlSetData($LBL_TOTAL_PAGEFILE, Round($totalpagefile, 2) & " MB")
	GUICtrlSetData($LBL_A_PAGEFILE, Round($availablepagefile, 2) & " MB")
	GUICtrlSetData($LBL_TOTAL_VRAM, Round($totalvirtual, 2) & " MB")
	GUICtrlSetData($LBL_A_VRAM, Round($avaiablevirtual, 2) & " MB")
	
	GUICtrlSetData($LBL_PC_UPTIME, _PCUptime())
	$TMP = WinList()
	GUICtrlSetData($LBL_N_OF_T, $TMP[0][0])
	GUICtrlSetData($LBL_MEM_USAGE, $mem[0] & "%")
	$TMP = ProcessList()
	GUICtrlSetData($LBL_N_OF_P, $TMP[0][0])
	
	GUICtrlSetData($LBL_IP1, @IPAddress1)
	GUICtrlSetData($LBL_IP2, @IPAddress2)
	GUICtrlSetData($LBL_IP3, @IPAddress3)
	GUICtrlSetData($LBL_IP4, @IPAddress4)
	
	GUICtrlSetData($LBL_DT_Width, @DesktopWidth)
	GUICtrlSetData($LBL_DT_Height, @DesktopHeight)
	GUICtrlSetData($LBL_DT_Depth, @DesktopDepth)
	GUICtrlSetData($LBL_DT_ReRate, @DesktopRefresh)
	
	GUICtrlSetData($LBL_Computer_Name, @ComputerName)
	GUICtrlSetData($LBL_Cur_LogOnUser, @UserName)
	
	Select
		Case StringInStr("0413,0813", @OSLang)
			$language = "Dutch"

		Case StringInStr("0409,0809,0c09,1009,1409,1809,1c09,2009,2409,2809,2c09,3009,3409", @OSLang)
			$language = "English"

		Case StringInStr("040c,080c,0c0c,100c,140c,180c", @OSLang)
			$language = "French"

		Case StringInStr("0407,0807,0c07,1007,1407", @OSLang)
			$language = "German"

		Case StringInStr("0410,0810", @OSLang)
			$language = "Italian"

		Case StringInStr("0414,0814", @OSLang)
			$language = "Norwegian"

		Case StringInStr("0415", @OSLang)
			$language = "Polish"

		Case StringInStr("0416,0816", @OSLang)
			$language = "Portugese"

		Case StringInStr("040a,080a,0c0a,100a,140a,180a,1c0a,200a,240a,280a,2c0a,300a,340a,380a,3c0a,400a,440a,480a,4c0a,500a", @OSLang)
			$language = "Spanish"

		Case StringInStr("041d,081d", @OSLang)
			$language = "Swedish"

		Case Else
			$language = "Other"
	EndSelect
	GUICtrlSetData($LBL_OS_LANG, $language)

	Select
		Case StringInStr("WIN32_NT", @OSTYPE)
			$ostype = "NT/2000/XP/2003"
		Case Else
			$ostype = "95/95/ME"
	EndSelect
	GUICtrlSetData($LBL_OS_TYPE, $ostype)
	
	Select
		Case StringInStr("WIN_2003", @OSVersion)
			$osversion = "Windows 2003"
		Case StringInStr("WIN_XP", @OSVersion)
			$osversion = "Windows XP"
		Case StringInStr("WIN_2000", @OSVersion)
			$osversion = "Windows 2000"
		Case StringInStr("WIN_NT4", @OSVersion)
			$osversion = "Windows NT 4"
		Case StringInStr("WIN_ME", @OSVersion)
			$osversion = "Windows ME"
		Case StringInStr("WIN_98", @OSVersion)
			$osversion = "Windows 98"
		Case Else
			$osversion = "WIndows 95"
	EndSelect
	GUICtrlSetData($LBL_OS_VERSION, $osversion)
	
	GUICtrlSetData($LBL_OS_SERVICE_PACK, @OSServicePack)
	
	If _ConnectedToInternet() Then
		GUICtrlSetData($LBL_INTERNET_CONECTION,"Yes")
	Else
		GUICtrlSetData($LBL_INTERNET_CONECTION,"No")
	EndIf
EndFunc   

Func _ConnectedToInternet()
    Local Const $NETWORK_ALIVE_LAN = 0x1  ;net card connection
    Local Const $NETWORK_ALIVE_WAN = 0x2  ;RAS (internet) connection
    Local Const $NETWORK_ALIVE_AOL = 0x4  ;AOL
   
    Local $aRet, $iResult
   
    $aRet = DllCall("sensapi.dll", "int", "IsNetworkAlive", "int*", 0)
   
    If BitAND($aRet[1], $NETWORK_ALIVE_LAN) Then $iResult &= "LAN connected" & @LF
    If BitAND($aRet[1], $NETWORK_ALIVE_WAN) Then $iResult &= "WAN connected" & @LF
    If BitAND($aRet[1], $NETWORK_ALIVE_AOL) Then $iResult &= "AOL connected" & @LF
   
    Return $iResult
EndFunc

Func _PCUptime()
	Local $day = ""
	Local $type = ""
	Local $hour = 0
	Local $min = 0
	Local $sec = 0
	Local $uptime
	$Ret = DllCall("kernel32.dll", "long", "GetTickCount")
	If IsArray($Ret) Then
		$msec = StringRight("00" & Mod($Ret[0], 1000), 3)
		$uptime = Int($Ret[0] / 1000)
		$sec = StringRight("00" & Mod($uptime, 60), 2)
		If $uptime >= 60 Then
			$uptime = Int($uptime / 60)
			$min = StringRight("00" & Mod($uptime, 60), 2)
			If $uptime >= 60 Then
				$uptime = Int($uptime / 60)
				$hour = StringRight("00" & Mod($uptime, 24), 2)
				If $uptime >= 24 Then
					$day = Int($uptime / 24)
					$type = ""
					If $day > 1 Then $type = "s"
					$type = " Day" & $type & " "
				EndIf
			EndIf
		EndIf
		Return ($day & $type & $hour & ":" & $min & ":" & $sec)
	EndIf
EndFunc   

Func _PCUptime_InSec()
	Local $day = ""
	Local $type = ""
	Local $hour = 0
	Local $min = 0
	Local $sec = 0
	Local $uptime
	$Ret = DllCall("kernel32.dll", "long", "GetTickCount")
	If IsArray($Ret) Then
		$msec = StringRight("00" & Mod($Ret[0], 1000), 3)
		$uptime = Int($Ret[0] / 1000)
		$sec = StringRight("00" & Mod($uptime, 60), 2)
		If $uptime >= 60 Then
			$uptime = Int($uptime / 60)
			$min = StringRight("00" & Mod($uptime, 60), 2)
			If $uptime >= 60 Then
				$uptime = Int($uptime / 60)
				$hour = StringRight("00" & Mod($uptime, 24), 2)
				If $uptime >= 24 Then
					$day = Int($uptime / 24)
					$type = ""
					If $day > 1 Then $type = "s"
					$type = " Day" & $type & " "
				EndIf
			EndIf
		EndIf
		$day = Int($day)
		$hour = Int($hour)
		$min = Int($min)
		$sec = Int($sec)
		$hour = $hour + $day * 24
		$min = $min + $hour * 60
		$sec = $sec + $min * 60
		Return $sec
	EndIf
EndFunc  

Func _MsgBox($Title, $Msg)
	Local $GUI_MSG_CLOSE
	Local $MSG_BOX_GUI
	$Width = StringLen($Msg) * 5.2
	$Height = 78
	$MSG_BOX_GUI = GUICreate("Task Manager Pro _", $Width, $Height, -1, -1, BitOR($WS_POPUP, $WS_BORDER),136)
	$GUI_MSG_CLOSE = GUICtrlCreateLabel("X", $Width - 15, 0, 11, 20)
	GUICtrlSetFont(-1, 10, 800, 0, "Comic Sans MS")
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	GUICtrlSetCursor(-1, 0)
	$Formtitle = GUICtrlCreateLabel(" " & $Title, 0, 4, @DesktopWidth, 20, -1, $GUI_WS_EX_PARENTDRAG)
	GUICtrlSetColor(-1, 0xFFFFFF)
	GUICtrlSetBkColor(-1, $GUI_BKCOLOR_TRANSPARENT)
	$Formtitlebackground = GUICtrlCreateGraphic(0, 0, @DesktopWidth, 22)
	GUICtrlSetBkColor(-1, 0x000000)
	$Msg = GUICtrlCreateLabel($Msg, 8, 24, 4000, 17)
	$OK = GUICtrlCreateButton("Ok", $Width / 2 - 75 / 2, 48, 75, 25, 0)
	_VistaLikeRenderButton(-1, $tImageList[_GetNewIL()], $aIconHandles)
	GUISetState(@SW_SHOW, $MSG_BOX_GUI)
	$V = GUIGetMsg()
	While $V <> $GUI_MSG_CLOSE And $V <> $OK
		$V = GUIGetMsg()
	WEnd
	_ILDown()
	GUIDelete($MSG_BOX_GUI)
EndFunc   

Func _SaveList($SaveAdress2)
	Local $File
	Local $i
	If $SaveAdress2 = "" Then Return 1
	$File = FileOpen($SaveAdress2, 1)
	$Data = "Date: " & @YEAR & "\" & @MON & "\" & @MDAY & "   " & @HOUR & ":" & @MIN & ":" & @SEC
	FileWriteLine($File, $Data)
	$i = 1
	While $i < $ListMaxLength
		If $ListData[$i] <> "" Then
			$Data = StringSplit($ListData[$i], "|")
			If $ssl3 = "1"  Then
				FileWrite($File, $Data[1] & " | ")
			EndIf
			If $ssl4 = "1"  Then
				FileWrite($File, $Data[2] & " | ")
			EndIf
			If $ssl5 = "1"  Then
				FileWrite($File, $Data[3] & " | ")
			EndIf
			If $ssl6 = "1"  Then
				FileWrite($File, $Data[4] & " | ")
			EndIf
			If $ssl7 = "1"  Then
				FileWrite($File, $Data[5] & " | ")
			EndIf
			If $ssl8 = "1"  Then
				FileWrite($File, $Data[6] & " | ")
			EndIf
			If $ssl9 = "1"  Then
				FileWrite($File, $Data[7] & " | ")
			EndIf
			If $ssl10 = "1"  Then
				FileWrite($File, $Data[8] & " | ")
			EndIf
			If $ssl11 = "1"  Then
				FileWrite($File, $Data[9] & " | ")
			EndIf
			If $ssl21 = "1"  Then
				FileWrite($File, $Data[10] & " | ")
			EndIf
			If $ssl22 = "1"  Then
				FileWrite($File, $Data[11] & " | ")
			EndIf
			If $ssl12 = "1"  Then
				FileWrite($File, $Data[12] & " | ")
			EndIf
			If $ssl13 = "1"  Then
				FileWrite($File, $Data[13] & " | ")
			EndIf
			If $ssl14 = "1"  Then
				FileWrite($File, $Data[14] & " | ")
			EndIf
			If $ssl15 = "1"  Then
				FileWrite($File, $Data[15] & " | ")
			EndIf
			If $ssl16 = "1"  Then
				FileWrite($File, $Data[16] & " | ")
			EndIf
			If $ssl17 = "1"  Then
				FileWrite($File, $Data[17] & " | ")
			EndIf
			If $ssl18 = "1"  Then
				FileWrite($File, $Data[18] & " | ")
			EndIf
			FileWriteLine($File, "************************************************************************************************************")
			FileWriteLine($File, " ")
		EndIf
		$i = $i + 1
	WEnd
	FileClose($File)
EndFunc   

Func _LoadOptData($Adress)
	Local $Data
	Local $NOI
	$Data = FileRead($Adress)
	$Data = _StringEncrypt(0,$Data,"_PASSWORD_")
	$Data = StringSplit($Data,"|")
	$NOI = UBound($Data)
	If $NOI < 29 Then
		_MsgBox("Warning!","Another version of Task Manager Pro has been used/found. The setting will restore to default!")
		_SaveOptData($Adress)
		Return 0
	EndIf
	If $Data[1] = "1" Then
		GUICtrlSetState($N1,$GUI_CHECKED)
		$ssl1 = "1"
	Else
		$ssl1 = "0"
		GUICtrlSetState($N1,$GUI_UNCHECKED)
	EndIf
	If $Data[2] = "1" Then
		GUICtrlSetState($N2,$GUI_CHECKED)
		$ssl2 = "1"
	Else
		$ssl2 = "0"
		GUICtrlSetState($N2,$GUI_UNCHECKED)
	EndIf
	If $Data[3] = "1" Then
		$ssl3 = "1"
		GUICtrlSetState($S1,$GUI_CHECKED)
	Else
		$ssl3 = "0"
		GUICtrlSetState($S1,$GUI_UNCHECKED)
	EndIf
	If $Data[4] = "1" Then
		$ssl4 = "1"
		GUICtrlSetState($S2,$GUI_CHECKED)
	Else
		$ssl4 = "0"
		GUICtrlSetState($S2,$GUI_UNCHECKED)
	EndIf
	If $Data[5] = "1" Then
		$ssl5 = "1"
		GUICtrlSetState($S3,$GUI_CHECKED)
	Else
		$ssl5 = "0"
		GUICtrlSetState($S3,$GUI_UNCHECKED)
	EndIf
	If $Data[6] = "1" Then
		$ssl6 = "1"
		GUICtrlSetState($S4,$GUI_CHECKED)
	Else
		$ssl6 = "0"
		GUICtrlSetState($S4,$GUI_UNCHECKED)
	EndIf
	If $Data[7] = "1" Then
		$ssl7 = "1"
		GUICtrlSetState($S5,$GUI_CHECKED)
	Else
		$ssl7 = "0"
		GUICtrlSetState($S5,$GUI_UNCHECKED)
	EndIf
	If $Data[8] = "1" Then
		$ssl8 = "1"
		GUICtrlSetState($S6,$GUI_CHECKED)
	Else
		$ssl8 = "0"
		GUICtrlSetState($S6,$GUI_UNCHECKED)
	EndIf
	If $Data[9] = "1" Then
		$ssl9 = "1"
		GUICtrlSetState($S7,$GUI_CHECKED)
	Else
		$ssl9 = "0"
		GUICtrlSetState($S7,$GUI_UNCHECKED)
	EndIf
	If $Data[10] = "1" Then
		$ssl10 = "1"
		GUICtrlSetState($S8,$GUI_CHECKED)
	Else
		$ssl10 = "0"
		GUICtrlSetState($S8,$GUI_UNCHECKED)
	EndIf
	If $Data[11] = "1" Then
		$ssl11 = "1"
		GUICtrlSetState($S9,$GUI_CHECKED)
	Else
		$ssl11 = "0"
		GUICtrlSetState($S9,$GUI_UNCHECKED)
	EndIf
	If $Data[12] = "1" Then
		$ssl12 = "1"
		GUICtrlSetState($S10,$GUI_CHECKED)
	Else
		$ssl12 = "0"
		GUICtrlSetState($S10,$GUI_UNCHECKED)
	EndIf
	If $Data[13] = "1" Then
		$ssl13 = "1"
		GUICtrlSetState($S11,$GUI_CHECKED)
	Else
		$ssl13 = "0"
		GUICtrlSetState($S11,$GUI_UNCHECKED)
	EndIf
	If $Data[14] = "1" Then
		$ssl14 = "1"
		GUICtrlSetState($S12,$GUI_CHECKED)
	Else
		$ssl14 = "0"
		GUICtrlSetState($S12,$GUI_UNCHECKED)
	EndIf
	If $Data[15] = "1" Then
		$ssl15 = "1"
		GUICtrlSetState($S13,$GUI_CHECKED)
	Else
		$ssl15 = "0"
		GUICtrlSetState($S13,$GUI_UNCHECKED)
	EndIf
	If $Data[16] = "1" Then
		$ssl16 = "1"
		GUICtrlSetState($S14,$GUI_CHECKED)
	Else
		$ssl16 = "0"
		GUICtrlSetState($S14,$GUI_UNCHECKED)
	EndIf
	If $Data[17] = "1" Then
		$ssl17 = "1"
		GUICtrlSetState($S15,$GUI_CHECKED)
	Else
		$ssl17 = "0"
		GUICtrlSetState($S15,$GUI_UNCHECKED)
	EndIf
	If $Data[18] = "1" Then
		$ssl18 = "1"
		GUICtrlSetState($S16,$GUI_CHECKED)
	Else
		$ssl18 = "0"
		GUICtrlSetState($S16,$GUI_UNCHECKED)
	EndIf
	GUICtrlSetData($SaveAdress,$Data[19])
	GUICtrlSetData($DelayTime4Save,$Data[20])
	GUICtrlSetData($MaxNOI,$Data[21])
	If $Data[22] = "1" Then
		$ssl19 = "1"
		GUICtrlSetState($N3,$GUI_CHECKED)
	Else
		$ssl19 = "0"
		GUICtrlSetState($N3,$GUI_UNCHECKED)
	EndIf
	If $Data[23] = "1" Then
		$ssl20 = "1"
		GUICtrlSetState($N4,$GUI_CHECKED)
	Else
		$ssl20 = "0"
		GUICtrlSetState($N4,$GUI_UNCHECKED)
	EndIf
	If $Data[24] = "1" Then
		$ssl21 = "1"
		GUICtrlSetState($S17,$GUI_CHECKED)
	Else
		$ssl21 = "0"
		GUICtrlSetState($S17,$GUI_UNCHECKED)
	EndIf
	If $Data[25] = "1" Then
		$ssl22 = "1"
		GUICtrlSetState($S18,$GUI_CHECKED)
	Else
		$ssl22 = "0"
		GUICtrlSetState($S18,$GUI_UNCHECKED)
	EndIf
	GUICtrlSetData($Update_Delay,$Data[26])
	If $Data[27] = "1" Then
		$ssl23 = "1"
		GUICtrlSetState($V1,$GUI_CHECKED)
	Else
		$ssl23 = "0"
		GUICtrlSetState($V1,$GUI_UNCHECKED)
	EndIf
	If $Data[28] = "1" Then
		$ssl25 = "1"
		GUICtrlSetState($V3,$GUI_CHECKED)
	Else
		$ssl25 = "0"
		GUICtrlSetState($V3,$GUI_UNCHECKED)
	EndIf
	If $Data[29] = "1" Then
		$ssl26 = "1"
		GUICtrlSetState($V2,$GUI_CHECKED)
	Else
		$ssl26 = "0"
		GUICtrlSetState($V2,$GUI_UNCHECKED)
	EndIf
EndFunc

Func _SaveOptData($Adress)
	FileDelete($Adress)
	$Data = $ssl1
	$Data &= "|" & $ssl2
	$Data &= "|" & $ssl3
	$Data &= "|" & $ssl4
	$Data &= "|" & $ssl5
	$Data &= "|" & $ssl6
	$Data &= "|" & $ssl7
	$Data &= "|" & $ssl8
	$Data &= "|" & $ssl9
	$Data &= "|" & $ssl10
	$Data &= "|" & $ssl11
	$Data &= "|" & $ssl12
	$Data &= "|" & $ssl13
	$Data &= "|" & $ssl14
	$Data &= "|" & $ssl15
	$Data &= "|" & $ssl16
	$Data &= "|" & $ssl17
	$Data &= "|" & $ssl18
	$Data &= "|" & GUICtrlRead($SaveAdress)
	$Data &= "|" & GUICtrlRead($DelayTime4Save)
	$Data &= "|" & GUICtrlRead($MaxNOI)
	$Data &= "|" & $ssl19
	$Data &= "|" & $ssl20
	$Data &= "|" & $ssl21
	$Data &= "|" & $ssl22
	$Data &= "|" & GUICtrlRead($Update_Delay)
	$Data &= "|" & $ssl23
	$Data &= "|" & $ssl25
	$Data &= "|" & $ssl26
	$Data = _StringEncrypt(1, $Data, "_PASSWORD_")
	FileWrite($Adress, $Data)
EndFunc  

Func _Apply()
	If GUICtrlRead($N1) = $GUI_CHECKED Then
		$ssl1 = "1"
	Else
		$ssl1 = "0"
	EndIf
	If GUICtrlRead($N2) = $GUI_CHECKED Then
		$ssl2 = "1"
	Else
		$ssl2 = "0"
	EndIf
	If GUICtrlRead($S1) = $GUI_CHECKED Then
		$ssl3 = "1"
	Else
		$ssl3 = "0"
	EndIf
	If GUICtrlRead($S2) = $GUI_CHECKED Then
		$ssl4 = "1"
	Else
		$ssl4 = "0"
	EndIf
	If GUICtrlRead($S3) = $GUI_CHECKED Then
		$ssl5 = "1"
	Else
		$ssl5 = "0"
	EndIf
	If GUICtrlRead($S4) = $GUI_CHECKED Then
		$ssl6 = "1"
	Else
		$ssl6 = "0"
	EndIf
	If GUICtrlRead($S5) = $GUI_CHECKED Then
		$ssl7 = "1"
	Else
		$ssl7 = "0"
	EndIf
	If GUICtrlRead($S6) = $GUI_CHECKED Then
		$ssl8 = "1"
	Else
		$ssl8 = "0"
	EndIf
	If GUICtrlRead($S7) = $GUI_CHECKED Then
		$ssl9 = "1"
	Else
		$ssl9 = "0"
	EndIf
	If GUICtrlRead($S8) = $GUI_CHECKED Then
		$ssl10 = "1"
	Else
		$ssl10 = "0"
	EndIf
	If GUICtrlRead($S9) = $GUI_CHECKED Then
		$ssl11 = "1"
	Else
		$ssl11 = "0"
	EndIf
	If GUICtrlRead($S10) = $GUI_CHECKED Then
		$ssl12 = "1"
	Else
		$ssl12 = "0"
	EndIf
	If GUICtrlRead($S11) = $GUI_CHECKED Then
		$ssl13 = "1"
	Else
		$ssl13 = "0"
	EndIf
	If GUICtrlRead($S12) = $GUI_CHECKED Then
		$ssl14 = "1"
	Else
		$ssl14 = "0"
	EndIf
	If GUICtrlRead($S13) = $GUI_CHECKED Then
		$ssl15 = "1"
	Else
		$ssl15 = "0"
	EndIf
	If GUICtrlRead($S14) = $GUI_CHECKED Then
		$ssl16 = "1"
	Else
		$ssl16 = "0"
	EndIf
	If GUICtrlRead($S15) = $GUI_CHECKED Then
		$ssl17 = "1"
	Else
		$ssl17 = "0"
	EndIf
	If GUICtrlRead($S16) = $GUI_CHECKED Then
		$ssl18 = "1"
	Else
		$ssl18 = "0"
	EndIf
	If GUICtrlRead($N3) = $GUI_CHECKED Then
		$ssl19 = "1"
	Else
		$ssl19 = "0"
	EndIf
	If GUICtrlRead($N4) = $GUI_CHECKED Then
		$ssl20 = "1"
	Else
		$ssl20 = "0"
	EndIf
	If GUICtrlRead($S17) = $GUI_CHECKED Then
		$ssl21 = "1"
	Else
		$ssl21 = "0"
	EndIf
	If GUICtrlRead($S18) = $GUI_CHECKED Then
		$ssl22 = "1"
	Else
		$ssl22 = "0"
	EndIf
	If GUICtrlRead($V1) = $GUI_CHECKED Then
		$ssl23 = "1"
	Else
		$ssl23 = "0"
	EndIf
	If GUICtrlRead($V2) = $GUI_CHECKED Then
		$ssl26 = "1"
	Else
		$ssl26 = "0"
	EndIf
	If GUICtrlRead($V3) = $GUI_CHECKED Then
		$ssl25 = "1"
	Else
		$ssl25 = "0"
	EndIf
	$ListMaxLength = Int(GUICtrlRead($MaxNOI))
	If $ListMaxLength > 2048 Then
		$ListMaxLength = 2048
		GUICtrlSetData($MaxNOI, "2048")
	EndIf
EndFunc   

Func _Update()
	Local $TMP
	Local $i
	Local $Data
	Local $WinName, $X, $Y, $Width, $Height, $TMP2, $Visibility, $OK = 0
	Local $IO_OP[6]
	$TMP = WinList()
	$i = 1
	_Init2()
	_UpdateOtherInfo()
	$NOI_IL = 0
	While $i <= $TMP[0][0]
		$OK = 1
		If $ssl1 = "1"  And _IsVisible($TMP[$i][1]) = 1 Then
			$OK = 0
		EndIf
		If $ssl19 = "1"  And _IsVisible($TMP[$i][1]) = 0 Then
			$OK = 0
		EndIf
		If $ssl20 = "1"  And $TMP[$i][0] <> "" Then
			$OK = 0
		EndIf
		If $ssl2 = "1"  And $TMP[$i][0] = "" Then
			$OK = 0
		EndIf
		If $OK = 1 Then
			$NOI_IL = $NOI_IL + 1
			If $NOI_IL = $ListMaxLength And $ssl24 = "1"  Then
				_MsgBox("Warning!", "Number of windows in list exceded! Max number auto-setted to 2048!")
				$ListMaxLength = 2048
				$i = 0
				While $i < $ListMaxLength
					GUICtrlDelete($List[$i])
					$ListB[$i] = 0
					$ListData[$i] = ""
					$ListC[$i] = 0
					$i = $i + 1
				WEnd
				GUICtrlSetData($MaxNOI, 2048)
				Return 1
			EndIf
			$Data = ""
			$WinName = $TMP[$i][0]
			StringReplace($WinName, "|", "")
			$HANDLE = $TMP[$i][1]
			$PID = WinGetProcess($HANDLE)
			$TMP2 = WinGetPos($HANDLE)
			If @error <> 1 Then
				$X = $TMP2[0]
				$Y = $TMP2[1]
				$Width = $TMP2[2]
				$Height = $TMP2[3]
			Else
				$X = "Unknown"
				$Y = "Unknown"
				$Width = "Unknown"
				$Height = "Unknown"
			EndIf
			$TMP2 = ProcessGetStats($PID, 1)
			If $TMP2 <> 0 Then
				$RO = $TMP2[0]
				$WO = $TMP2[1]
				$IOO = $TMP2[2]
				$RB = $TMP2[3]
				$RW = $TMP2[4]
				$RT = $TMP2[5]
			Else
				$RO = "Unknown"
				$WO = "Unknown"
				$IOO = "Unknown"
				$RB = "Unknown"
				$RW = "Unknown"
				$RT = "Unknown"
			EndIf
			$TMP2 = ProcessGetStats($PID, 0)
			If $TMP2 <> 0 Then
				$M1 = $TMP2[0]
				$M2 = $TMP2[1]
			Else
				$M1 = "Unknown"
				$M2 = "Unknown"
			EndIf
			If _IsVisible($HANDLE) = 1 Then
				$Visibility = "Yes"
			Else
				$Visibility = "No"
			EndIf
			$PID_Name = _ProcessGetName($PID)
			$Priority = _ProcessGetPriority($PID)
			If $Priority = 0 Then
				$Priority = "0 - Idle/Low"
			EndIf
			If $Priority = 1 Then
				$Priority = "1 - Below Normal"
			EndIf
			If $Priority = 2 Then
				$Priority = "2 - Normal"
			EndIf
			If $Priority = 3 Then
				$Priority = "3 - Above Normal "
			EndIf
			If $Priority = 4 Then
				$Priority = "4 - High"
			EndIf
			If $Priority = 5 Then
				$Priority = "5 - Realtime"
			EndIf
			$A = _GetFreeListId()
			$Data = $WinName & "|" & $HANDLE & "|" & $PID & "|" & $X & "|" & $Y & "|" & $Width & "|" & $Height & "|" & $Visibility
			$Data = $Data & "|" & $PID_Name & "|" & $Priority
			$Data = $Data & "|" & $RO & "|" & $WO & "|" & $IOO & "|" & $RB & "|" & $RW & "|" & $RT
			$Data = $Data & "|" & $M1 & "|" & $M2
			If _DataAlreadyInList($Data) = 0 Then
				_AddToList($Data, $A)
			EndIf
		EndIf
		$i = $i + 1
	WEnd
	$i = 1
	While $i < $ListMaxLength
		If $ListC[$i] = 0 And $ListB[$i] = 1 Then
			GUICtrlDelete($List[$i])
			$ListB[$i] = 0
			$ListData[$i] = ""
			$ListC[$i] = 0
		EndIf
		$i = $i + 1
	WEnd
EndFunc   

Func _PClose($Data)
	If $Data = "0"  Then
		_MsgBox("Error", "No item selected! Please select an window before push a button.")
		Return 0
	EndIf
	Local $TMP
	$TMP = StringSplit($Data, "|")
	ProcessClose($TMP[3])
EndFunc   

Func _Kill($Data)
	If $Data = "0"  Then
		_MsgBox("Error", "No item selected! Please select an window before push a button.")
		Return 0
	EndIf
	Local $TMP
	$TMP = StringSplit($Data, "|")
	WinKill($TMP[1])
EndFunc  

Func _Close($Data)
	If $Data = "0"  Then
		_MsgBox("Error", "No item selected! Please select an window before push a button.")
		Return 0
	EndIf
	Local $TMP
	$TMP = StringSplit($Data, "|")
	WinClose($TMP[1])
EndFunc  

Func _SetX($Data, $NewData)
	Local $TMP
	$TMP = StringSplit($Data, "|")
	WinMove($TMP[1], "", $NewData, $TMP[5])
EndFunc   

Func _SetY($Data, $NewData)
	Local $TMP
	$TMP = StringSplit($Data, "|")
	WinMove($TMP[1], "", $TMP[4], $NewData)
EndFunc  

Func _SetHeight($Data, $NewData)
	Local $TMP
	$TMP = StringSplit($Data, "|")
	WinMove($TMP[1], "", $TMP[4], $TMP[5], $TMP[6], $NewData)
EndFunc  

Func _SetWidth($Data, $NewData)
	Local $TMP
	$TMP = StringSplit($Data, "|")
	WinMove($TMP[1], "", $TMP[4], $TMP[5], $NewData)
EndFunc  

Func _SetTitle($Data, $NewData)
	Local $TMP
	$TMP = StringSplit($Data, "|")
	WinSetTitle($TMP[1], "", $NewData)
EndFunc 

Func _Hide($Data)
	If $Data = "0"  Then
		_MsgBox("Error", "No item selected! Please select an window before push a button.")
		Return 0
	EndIf
	Local $TMP
	$TMP = StringSplit($Data, "|")
	WinSetState($TMP[1], "", @SW_HIDE)
EndFunc   

Func _Show($Data)
	If $Data = "0"  Then
		_MsgBox("Error", "No item selected! Please select an window before push a button.")
		Return 0
	EndIf
	Local $TMP
	$TMP = StringSplit($Data, "|")
	WinSetState($TMP[1], "", @SW_SHOW)
EndFunc   

Func _SetPriority($Data, $NewData)
	Local $TMP
	$TMP = StringSplit($Data, "|")
	ProcessSetPriority($TMP[3], $NewData)
EndFunc  

Func _Minimize($Data)
	If $Data = "0"  Then
		_MsgBox("Error", "No item selected! Please select an window before push a button.")
		Return 0
	EndIf
	Local $TMP
	$TMP = StringSplit($Data, "|")
	WinSetState($TMP[1], "", @SW_MINIMIZE)
EndFunc  

Func _Maximize($Data)
	If $Data = "0"  Then
		_MsgBox("Error", "No item selected! Please select an window before push a button.")
		Return 0
	EndIf
	Local $TMP
	$TMP = StringSplit($Data, "|")
	WinSetState($TMP[1], "", @SW_MAXIMIZE)
EndFunc   

Func _Init()
	Local $i
	While $i < $ListMaxLength
		$List[$i] = 0
		$ListB[$i] = 0
		$ListData[$i] = ""
		$ListC[$i] = 0
		$i = $i + 1
	WEnd
EndFunc   

Func _Init2()
	Local $i
	$i = 1
	While $i < $ListMaxLength
		$ListC[$i] = 0
		$i = $i + 1
	WEnd
EndFunc   

Func _ClearList()
	Local $i
	$i = 1
	While $i < $ListMaxLength
		GUICtrlDelete($List[$i])
		$ListB[$i] = 0
		$ListData[$i] = ""
		$ListC[$i] = 0
		$i = $i + 1
	WEnd
EndFunc   

Func _GetFreeListId()
	Local $i
	$i = 1
	While $i < $ListMaxLength
		If $ListB[$i] = 0 Then
			ExitLoop
		EndIf
		$i = $i + 1
	WEnd
	Return $i
EndFunc   

Func _AddToList($Data, $k)
	$List[$k] = GUICtrlCreateListViewItem($Data, $WinList)
	$ListData[$k] = $Data
	$ListC[$k] = 1
	$ListB[$k] = 1
EndFunc   

Func _IsVisible($HANDLE)
	If BitAND(WinGetState($HANDLE), 2) Then
		Return 1
	Else
		Return 0
	EndIf
EndFunc   

Func _DeleteFromList($Data)
	Local $i
	$i = 1
	While $i < $ListMaxLength
		If $ListData[$i] = $Data And $ListB[$i] = 1 Then
			GUICtrlDelete($List[$i])
			$ListB[$i] = 0
			$ListData[$i] = ""
			$ListC[$i] = 0
			ExitLoop
		EndIf
		$i = $i + 1
	WEnd
EndFunc   

Func _DataAlreadyInList($Data2)
	Local $i
	Local $Ret
	Local $TMP
	Local $HANDLE
	$HANDLE = StringSplit($Data2, "|")
	$HANDLE = $HANDLE[2]
	$Ret = 0
	$i = 1
	While $i < $ListMaxLength
		If $ListB[$i] = 1 Then
			$TMP = StringSplit($ListData[$i], "|")
			If $ListData[$i] = $Data2 Then
				$ListC[$i] = 1
				$Ret = 1
				ExitLoop
			ElseIf $HANDLE = $TMP[2] Then
				$ListData[$i] = $Data2
				GUICtrlSetData($List[$i], $ListData[$i])
				$ListC[$i] = 1
				$Ret = 1
				ExitLoop
			EndIf
		EndIf
		$i = $i + 1
	WEnd
	Return $Ret
EndFunc   

Func _Execute($Expresion)
	GUICtrlSetData($Input1,"")
	$Data_Command_History = $Data_Command_History & @CRLF & $Expresion
	Local $OutPut
	Local $Func
	Local $Parameters
	Local $TempVal
	Local $CExpresion
	Local $RetVal
	$RetVal = ""
	
	$CExpresion = _ParsExp($Expresion) 
	If $Type <> 2 Then
		_AddMsgToEdit("Parsing expresion " & '"' & $Expresion & '"' & " ... ")
	EndIf
	If $Err <> 0 Then
		If $Err = 1 Then
			_AddMsgToEdit("Error 1: more " & '"' & "(" & '"' & " then " & '"' & ")" & '"' & " in expresion: " & '"' & $Expresion & '"')
		EndIf
		If $Err = 2 Then
			_AddMsgToEdit("Error 2: more " & '"' & ")" & '"' & " then " & '"' & "(" & '"' & " in expresion: " & '"' & $Expresion & '"')
		EndIf
		_AddMsgToEdit("Command aborded ... ")
	EndIf
	If $Err = 0 Then
		If $Type <> 2 Then
			_AddMsgToEdit("Expresion seems to have no error.")
			_AddMsgToEdit("Trying to execute expresion ... ")
		EndIf
		SetError(0)
		If $Type = 0 Then
			$RetVal = Execute($CExpresion)
			If @error = 0 Then
				_AddMsgToEdit("Command succesfully executed!")
				If $RetVal = "" Then
					_AddMsgToEdit("Function returned with no value.")
				EndIf
				If $RetVal <> "" Then
					_AddMsgToEdit("Function returned with this value: " & $RetVal)
				EndIf
			EndIf
			If @error <> 0 Then
				_AddMsgToEdit("An error have found in syntax.")
				_AddMSgToEdit("Correct functions have been executed.")
			EndIf
		EndIf
		If $Type = 1 Then
			$RetVal = Execute($CExpresion)
			If @error = 0 Then
				_AddMsgToEdit("Command succesfully executed!")
				If $RetVal = "" Then
					_AddMsgToEdit("Function returned with no value in variable: " & $VarId)
				EndIf
				If $RetVal <> "" Then
					_AddMsgToEdit("Function returned with this value: " & $RetVal & " in variable: " & $VarId)
					$Variable_Data[$VarId] = $RetVal 
				EndIf
			EndIf
			If @error <> 0 Then
				_AddMsgToEdit("An error have found in syntax.")
				_AddMSgToEdit("Correct functions have been executed.")
			EndIf
		EndIf
		If $Type = 2 Then
			$CExpresion = $Expresion
			$Type2 = StringSplit($CExpresion,"\")
			If UBound($Type2) >= 2 Then
				If StringLower($Type2[2]) = "bat" Then
					$CMD_EXP = StringMid($CExpresion,6,StringLen($CExpresion)-5)
					$CMD = Run(@Comspec & " /c " & $CMD_EXP,"",@SW_HIDE,6)
					While 1
						$Line = StdoutRead($CMD)
						If @error Then ExitLoop
						If $Line <> "" And $Line <> " " Then
							$OutPut &= $Line & @CRLF 
						EndIf
					WEnd
					While 1
						$Line = StdErrRead($CMD)
						If @error Then ExitLoop
						If $Line <> "" And $Line <> " " Then
							$OutPut &= $Line & @CRLF 
						EndIf
					WEnd
					ProcessClose($CMD)
					If StringInStr($OutPut,"") Then
						GUICtrlSetData($Command_History,"")
						$OutPut = ""
					EndIf
					_AddMsgToEdit($OutPut)
				ElseIf StringLower($Type2[2]) = "tok" Then
					$TOK_CMD = StringMid($CExpresion,6,StringLen($CExpresion)-5)
					If StringLower($TOK_CMD) = "clear" Then
						GUICtrlSetData($Command_History,"")
						Return 0
					Else
						_AddMsgToEdit('"' & $Type2[3] & '"' & " is not a command for this type of execute.")
					EndIf
				Else
					_AddMsgToEdit("Error: " & '"' & $Type2[2] & '"' & " is not a type of execute.")
				EndIf
			EndIf
			If $Type <> 2 Then
				_AddMsgToEdit("Command succesfully executed!")
			EndIf
		EndIf
	EndIf
EndFunc

Func _IsNumber($s)
	Local $Ok10 = 1
	Local $i_1
	$i_1 = 1
	While $i_1 < StringLen($s)-1
		If StringMid($s,$i_1,1) <> '0' And StringMid($s,$i_1,1) <> '1' And StringMid($s,$i_1,1) <> '2' And StringMid($s,$i_1,1) <> '3' And StringMid($s,$i_1,1) <> '4' And StringMid($s,$i_1,1) <> '5' And StringMid($s,$i_1,1) <> '6' And StringMid($s,$i_1,1) <> '7' And StringMid($s,$i_1,1) <> '8' And StringMid($s,$i_1,1) <> '9' Then
			$Ok10 = 0
			ExitLoop
		EndIf
		$i_1 = $i_1 + 1
	WEnd
	Return $Ok10
EndFunc

Func _IsNotInAString($i,$Expresion)
	Local $j
	Local $Ok = 1
	Local $Ok2 = 0
	Local $k
	$j = 1
	While $j < StringLen($Expresion)
		If StringMid($Expresion,$j,1) = '"' Then
			If $Ok2 = 0 Then
				$k = $j
				$Ok2 = 1
			ElseIf $Ok2 = 1 Then
				$Ok2 = 0
				If $i > $k And $i < $j Then
					$Ok = 0
					ExitLoop
				EndIf
			EndIf
		EndIf
		$j = $j + 1
	WEnd
	Return $Ok
EndFunc

Func _ParsExp($Expresion)
	Local $i
	Local $P1 
	Local $P2
	Local $NExp
	Local $VarIdTmp
	$Err = 0
	$Type = 0
	$P1 = 0
	$P2 = 0
	While StringMid($Expresion,1,1) = ' '
		$Expresion = StringMid($Expresion,2,StringLen($Expresion))
	WEnd
	$i = 1
	While $i < StringLen($Expresion)
		If _IsNotInAString($i,$Expresion)=1 Then
			If StringMid($Expresion,$i,1) = ' ' Then
				$Expresion = StringMid($Expresion,1,$i-1) & StringMid($Expresion,$i+1,StringLen($Expresion))
				$i = $i - 1
			EndIf
		EndIf
		$i = $i + 1
	WEnd
	
	If StringMid($Expresion,1,1) = '$' Then
		$Type = 1
		$i = 2
		$VarId = ""
		While StringMid($Expresion,$i,1) <> '='
			$VarId = $VarId & StringMid($Expresion,$i,1)
			$i = $i + 1
		WEnd
		$Expresion = StringMid($Expresion,$i+1,StringLen($Expresion))
	EndIf
	If StringMid($Expresion,1,1) = '\' Then
		$Type = 2
		$Expresion = $Expresion 
	EndIf
	If $Type = 1 Or $Type = 0 Then
		$i = 1
		$NExp = ""
		While $i <= StringLen($Expresion)
			$OK = 1
			If _IsNotInAString($i,$Expresion) = 1 Then
				If StringMid($Expresion,$i,1) = '$' Then
					$VarIdTmp = ""
					$i = $i + 1
					While StringIsAlNum(StringMid($Expresion,$i,1)) = 1 
						$VarIdTmp = $VarIdTmp & StringMid($Expresion,$i,1)
						$i = $i + 1
					WEnd
					$i = $i - 1
					$NExp = $NExp & $Variable_Data[$VarIdTmp]
					$OK = 0
				EndIf
				If StringMid($Expresion,$i,1) = '(' And $OK = 1 Then
					$P1 = $P1 + 1
					$OK = 0
					$NExp = $NExp & '('
				EndIf
				If StringMid($Expresion,$i,1) = ')' And $OK = 1 Then
					$P2 = $P2 + 1
					$NExp = $NExp & ')'
				EndIf
				If $OK = 1 And StringMid($Expresion,$i,1) <> ')' And StringMid($Expresion,$i,1) <> '(' And StringMid($Expresion,$i,1) <> '$' Then
					$NExp = $NExp & StringMid($Expresion,$i,1)
					$OK = 0
				EndIf
			EndIf
			If _IsNotInAString($i,$Expresion) = 0 Then
				$NExp = $NExp & StringMid($Expresion,$i,1)
			EndIf
			$i = $i + 1
		WEnd
		If $P1 > $P2 Then 
			$Err = 1
		EndIf
		If $P1 < $P2 Then
			$Err = 2
		EndIf
	EndIf
	$Expresion = $NExp
	Return $Expresion
EndFunc

Func _AddMsgToEdit($Msg)
	GUICtrlSetData($Command_History,GUICtrlRead($Command_History) & $Msg & @CRLF)
EndFunc
#EndRegion