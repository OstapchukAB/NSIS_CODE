; Script generated with the Venis Install Wizard

; Define your application name
!define APPNAME "NetCore6"
!define APPNAMEANDVERSION "NetCore6 1"

; Main Install settings
Name "${APPNAMEANDVERSION}"
InstallDir "$TEMP\MyNetCore6"

OutFile "my_setup_NetCore609.exe"

; Do not use compression
SetCompress off

; Modern interface settings
!include "MUI.nsh"

!define MUI_ABORTWARNING
;!define MUI_FINISHPAGE_RUN "$TEMP\windowsdesktop-runtime-6.0.9-win-x64.exe"

!insertmacro MUI_PAGE_WELCOME
!insertmacro MUI_PAGE_COMPONENTS
!insertmacro MUI_PAGE_DIRECTORY
!insertmacro MUI_PAGE_INSTFILES
!insertmacro MUI_PAGE_FINISH

!insertmacro MUI_UNPAGE_CONFIRM
!insertmacro MUI_UNPAGE_INSTFILES

; Set languages (first is default language)
!insertmacro MUI_LANGUAGE "English"
!insertmacro MUI_LANGUAGE "Russian"
!insertmacro MUI_RESERVEFILE_LANGDLL

Section ".NetCore6 Runtime 6.0.9 x64" Section1

	; Set Section properties
	SetOverwrite off

	; Set Section Files and Shortcuts
	SetOutPath "$TEMP\"
	File "windowsdesktop-runtime-6.0.9-win-x64.exe"

SectionEnd

Section ".NetCore SDK 6.0.4 x64" Section2

	; Set Section properties
	SetOverwrite off

	; Set Section Files and Shortcuts
	SetOutPath "$TEMP\"
	File "dotnet-sdk-6.0.400-win-x64.exe"

SectionEnd

Section -FinishSection

	WriteRegStr HKLM "Software\${APPNAME}" "" "$INSTDIR"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "DisplayName" "${APPNAME}"
	WriteRegStr HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}" "UninstallString" "$INSTDIR\uninstall.exe"
	WriteUninstaller "$INSTDIR\uninstall.exe"

SectionEnd

; Modern install component descriptions
!insertmacro MUI_FUNCTION_DESCRIPTION_BEGIN
	!insertmacro MUI_DESCRIPTION_TEXT ${Section1} ""
	!insertmacro MUI_DESCRIPTION_TEXT ${Section2} "Include Runtime .NetCore 6.0.8"
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;Uninstall section
Section Uninstall

	;Remove from registry...
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}"
	DeleteRegKey HKLM "SOFTWARE\${APPNAME}"

	; Delete self
	Delete "$INSTDIR\uninstall.exe"

	; Delete Shortcuts

	; Clean up .NetCore6 Runtime 6.0.9 x64
	Delete "$TEMP\windowsdesktop-runtime-6.0.9-win-x64.exe"

	; Clean up .NetCore SDK 6.0.4 x64
	Delete "$TEMP\dotnet-sdk-6.0.400-win-x64.exe"


SectionEnd

; On initialization
Function .onInit

	!insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd

; eof