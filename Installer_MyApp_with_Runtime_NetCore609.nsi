!define APPNAME "Runtime .NetCore"
!define APPNAMEANDVERSION "Runtime .NetCore 6.0.9"
;RequestExecutionLevel user
; Main Install settings
Name "${APPNAMEANDVERSION}"


OutFile "Installer_MyApp_with_Runtime_NetCore609.exe"
!define NetCore6 $8
!define InstalNetCore $9


Section

  StrCpy ${NetCore6} "6.0.4"
	StrCpy ${InstalNetCore} "false"

	Call CheckNetcore
	
	StrCmp ${InstalNetCore} "false" 0 lbl_install_netCore
		;MessageBox MB_ICONINFORMATION "${InstalNetCore}"
		Call InstallMyApp
		Quit
	
	lbl_install_netCore:
	MessageBox MB_YESNO "Install .NetCore 6.0.9?" IDYES true IDNO false
	
	true:
	SetOverwrite on
	SetOutPath "$TEMP\"
	File   "TMP\windowsdesktop-runtime-6.0.9-win-x64.exe"
	ExecWait   "$TEMP\windowsdesktop-runtime-6.0.9-win-x64.exe"
	Delete "$TEMP\windowsdesktop-runtime-6.0.9-win-x64.exe"
  Call InstallMyApp
		Quit
	
	false:
  MessageBox MB_ICONINFORMATION "QUIT"
  Call InstallMyApp
		Quit
SectionEnd

	
Function InstallMyApp
		SetOverwrite on
		SetOutPath "$TEMP\"
		File   "myapp.exe"
		ExecWait   "$TEMP\myapp.exe"
		Delete "$TEMP\myapp.exe"
		Return
	FunctionEnd
	
Function CheckNetcore
	SetRegView 64
		ReadRegStr $0 HKLM "SOFTWARE\dotnet\Setup\InstalledVersions\x64\sharedhost" "Version"
		StrCmp $0 ${NetCore6} 0 +3
			MessageBox MB_ICONINFORMATION "OK! Version NetCore [$0] already installed"
			Return
		StrCpy $1 $0 1 0
		StrCpy $2 $0 1 2
		StrCpy $3 $0 1 4
		
		StrCpy $4 ${NetCore6} 1 0
		StrCpy $5 ${NetCore6} 1 2
		StrCpy $6 ${NetCore6} 1 4
		IntCmp "$1$2$3" "$4$5$6" 0 +4 +2
		Return
		MessageBox MB_ICONINFORMATION "OK! Curent version NetCore $0 more ${NetCore6}"
		Return
		MessageBox MB_ICONINFORMATION "Bad! Installed NetCore ${NetCore6} or more"
		StrCpy ${InstalNetCore} "true"
		Return
FunctionEnd

;Function CheckWindowsNt
;	ReadRegStr $R1 HKLM  "SOFTWARE\Microsoft\Windows NT\CurrentVersion" "CurrentVersion"
;		StrCmp $R1 "" +4 0
;		;MessageBox MB_ICONINFORMATION "Current Version Windows [$R1]"
;		
;		ReadRegStr $R9 HKLM "SOFTWARE\Microsoft\Windows NT\CurrentVersion" "ProductName"
;		MessageBox MB_ICONINFORMATION "[$R9],Version:[$R1]"
;	FunctionEnd