RequestExecutionLevel user
OutFile "DefineNetFrameworkNetCore.exe"
!define NetFramework48 $9
!define NetCore6 $8

Section

	
	StrCpy ${NetFramework48} "4.8.03752"
	StrCpy ${NetCore6} "6.0.9"
	

		ReadRegStr $0 HKLM "SOFTWARE\Microsoft\NET Framework Setup\NDP\v4\Full" "Version"
		;MessageBox MB_OK "Version NET Framework [$0]"
		StrCmp $0 ${NetFramework48} 0 +3
			MessageBox MB_OK "Version NetFrameWork [$0] already installed"
			Goto +2
		MessageBox MB_OK "Version NetFrameWork ${NetFramework48} not installed!"
		;Return

	
	


		SetRegView 64
		ReadRegStr $0 HKLM "SOFTWARE\dotnet\Setup\InstalledVersions\x64\sharedhost" "Version"
		;MessageBox MB_OK "Version NetCore [$0]"
		StrCmp $0 ${NetCore6} 0 +3
			MessageBox MB_OK "Version NetCore [$0] already installed"
			Goto +2
		MessageBox MB_OK "Version NetCore ${NetCore6} not installed!"

	
	

	SectionEnd