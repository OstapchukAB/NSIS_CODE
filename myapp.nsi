; Script generated with the Venis Install Wizard

; Define your application name
!define APPNAME "MyAPPTonic"
!define APPNAMEANDVERSION "MyAPPTonic 1"

; Main Install settings
Name "${APPNAMEANDVERSION}"
InstallDir "$PROGRAMFILES\MyAPPTonic"
InstallDirRegKey HKLM "Software\${APPNAME}" ""
OutFile "myapp"

; Use compression
SetCompressor LZMA

; Modern interface settings
!include "MUI.nsh"

!define MUI_ABORTWARNING
!define MUI_FINISHPAGE_RUN "$INSTDIR\WinFormTest.exe"

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

Section "MyAPPTonic" Section1

	; Set Section properties
	SetOverwrite on

	; Set Section Files and Shortcuts
	SetOutPath "$INSTDIR\"
	File "MyApplication\WinFormTest.deps.json"
	File "MyApplication\WinFormTest.dll"
	File "MyApplication\WinFormTest.exe"
	File "MyApplication\WinFormTest.pdb"
	File "MyApplication\WinFormTest.runtimeconfig.json"
	CreateShortCut "$DESKTOP\MyAPPTonic.lnk" "$INSTDIR\WinFormTest.exe"
	CreateDirectory "$SMPROGRAMS\MyAPPTonic"
	CreateShortCut "$SMPROGRAMS\MyAPPTonic\MyAPPTonic.lnk" "$INSTDIR\WinFormTest.exe"
	CreateShortCut "$SMPROGRAMS\MyAPPTonic\Uninstall.lnk" "$INSTDIR\uninstall.exe"

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
!insertmacro MUI_FUNCTION_DESCRIPTION_END

;Uninstall section
Section Uninstall

	;Remove from registry...
	DeleteRegKey HKLM "Software\Microsoft\Windows\CurrentVersion\Uninstall\${APPNAME}"
	DeleteRegKey HKLM "SOFTWARE\${APPNAME}"

	; Delete self
	Delete "$INSTDIR\uninstall.exe"

	; Delete Shortcuts
	Delete "$DESKTOP\MyAPPTonic.lnk"
	Delete "$SMPROGRAMS\MyAPPTonic\MyAPPTonic.lnk"
	Delete "$SMPROGRAMS\MyAPPTonic\Uninstall.lnk"

	; Clean up MyAPPTonic
	Delete "$INSTDIR\WinFormTest.deps.json"
	Delete "$INSTDIR\WinFormTest.dll"
	Delete "$INSTDIR\WinFormTest.exe"
	Delete "$INSTDIR\WinFormTest.pdb"
	Delete "$INSTDIR\WinFormTest.runtimeconfig.json"

	; Remove remaining directories
	RMDir "$SMPROGRAMS\MyAPPTonic"
	RMDir "$INSTDIR\"

SectionEnd

; On initialization
Function .onInit

	!insertmacro MUI_LANGDLL_DISPLAY

FunctionEnd

; eof