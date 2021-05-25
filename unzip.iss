[Files]
	Source:"Utility\7zip\*"; DestDir: "{tmp}\7zip"; Permissions: everyone-full; Flags: dontcopy deleteafterinstall nocompression noencryption
[/Files]

[Code]
	#ifdef UNICODE
		#define AW "W"
	#else
		#define AW "A"
	#endif

	const
		WAIT_OBJECT_0 = $0;
		WAIT_TIMEOUT = $00000102;
		SEE_MASK_NOCLOSEPROCESS = $00000040;
		INFINITE = $FFFFFFFF;     { Infinite timeout }

	type
		TShellExecuteInfo = record
			cbSize: DWORD;
			fMask: Cardinal;
			Wnd: HWND;
			lpVerb: string;
			lpFile: string;
			lpParameters: string;
			lpDirectory: string;
			nShow: Integer;
			hInstApp: THandle;    
			lpIDList: DWORD;
			lpClass: string;
			hkeyClass: THandle;
			dwHotKey: DWORD;
			hMonitor: THandle;
			hProcess: THandle;
		end;

	function ShellExecuteEx(var lpExecInfo: TShellExecuteInfo): BOOL; 
		external 'ShellExecuteEx{#AW}@shell32.dll stdcall';
	function WaitForSingleObject(hHandle: THandle; dwMilliseconds: DWORD): DWORD; 
		external 'WaitForSingleObject@kernel32.dll stdcall';
	function CloseHandle(hObject: THandle): BOOL; external 'CloseHandle@kernel32.dll stdcall';

	{ ----------------------- }
	{ "Generic" code, some old "Application.ProcessMessages"-ish procedure }
	{ ----------------------- }
	type
		TMsg = record
			hwnd: HWND;
			message: UINT;
			wParam: Longint;
			lParam: Longint;
			time: DWORD;
			pt: TPoint;
		end;
	 
	const
		PM_REMOVE      = 1;
	 
	function PeekMessage(var lpMsg: TMsg; hWnd: HWND; wMsgFilterMin, wMsgFilterMax, wRemoveMsg: UINT): BOOL; external 'PeekMessageA@user32.dll stdcall';
	function TranslateMessage(const lpMsg: TMsg): BOOL; external 'TranslateMessage@user32.dll stdcall';
	function DispatchMessage(const lpMsg: TMsg): Longint; external 'DispatchMessageA@user32.dll stdcall';
	 
	procedure AppProcessMessage;
	var
		Msg: TMsg;
	begin
		while PeekMessage(Msg, WizardForm.Handle, 0, 0, PM_REMOVE) do begin
			TranslateMessage(Msg);
			DispatchMessage(Msg);
		end;
	end;
	{ ----------------------- }
	{ ----------------------- }
	procedure DoUnzip(source: String; targetdir: String);
	var
		unzipTool, unzipParams : String;     // path to unzip util
		ReturnCode  : Integer;  // errorcode
		ExecInfo: TShellExecuteInfo;
	begin
			//{ source might contain {tmp} or {app} constant, so expand/resolve it to path name }
			source := ExpandConstant(source);

			unzipTool := ExpandConstant('{tmp}\7za.exe');
			unzipParams := ' x "' + source + '" -o"' + targetdir + '" -y';

			ExecInfo.cbSize := SizeOf(ExecInfo);
			ExecInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
			ExecInfo.Wnd := 0;
			ExecInfo.lpFile := unzipTool;
			ExecInfo.lpParameters := unzipParams;
			ExecInfo.nShow := SW_HIDE;
			
			ExtractTemporaryFile('7za.exe');
			ExtractTemporaryFile('7za.dll');

			if not FileExists(unzipTool)
				then MsgBox('UnzipTool not found: ' + unzipTool, mbError, MB_OK)
			else if not FileExists(source)
				then MsgBox('File was not found while trying to unzip: ' + source, mbError, MB_OK)
			else begin 

						//{ ShellExecuteEx combined with INFINITE WaitForSingleObject }
						
						DownloadProgressLabel.Caption := FmtMessage('ExtractingCaption', [source])

						if ShellExecuteEx(ExecInfo) then
						begin
							while WaitForSingleObject(ExecInfo.hProcess, 100) = WAIT_TIMEOUT { WAIT_OBJECT_0 }
							do begin
									AppProcessMessage;
									//{ InstallPage.Surface.Update; }
									//{ BringToFrontAndRestore; }
									WizardForm.Refresh();
							end;
							CloseHandle(ExecInfo.hProcess);
						end; 
			end;
	end;

	procedure DoPUnzip(source: String; targetdir: String; pass: String);
	var
		unzipTool, unzipParams : String;     // path to unzip util
		ReturnCode  : Integer;  // errorcode
		ExecInfo: TShellExecuteInfo;
	begin
			//{ source might contain {tmp} or {app} constant, so expand/resolve it to path name }
			source := ExpandConstant(source);

			unzipTool := ExpandConstant('{tmp}\7za.exe');
			unzipParams := ' x "' + source + '" -o"' + targetdir + '" -y ' + '-p'+pass;

			ExecInfo.cbSize := SizeOf(ExecInfo);
			ExecInfo.fMask := SEE_MASK_NOCLOSEPROCESS;
			ExecInfo.Wnd := 0;
			ExecInfo.lpFile := unzipTool;
			ExecInfo.lpParameters := unzipParams;
			ExecInfo.nShow := SW_HIDE;
			
			ExtractTemporaryFile('7za.exe');
			ExtractTemporaryFile('7za.dll');

			if not FileExists(unzipTool)
			then MsgBox('UnzipTool not found: ' + unzipTool, mbError, MB_OK)
			else if not FileExists(source)
			then MsgBox('File was not found while trying to unzip: ' + source, mbError, MB_OK)
			else begin 

						//{ ShellExecuteEx combined with INFINITE WaitForSingleObject }

						if ShellExecuteEx(ExecInfo) then
						begin
							while WaitForSingleObject(ExecInfo.hProcess, 100) = WAIT_TIMEOUT { WAIT_OBJECT_0 }
							do begin
									AppProcessMessage;
									//{ InstallPage.Surface.Update; }
									//{ BringToFrontAndRestore; }
									WizardForm.Refresh();
							end;
							CloseHandle(ExecInfo.hProcess);
						end; 

			end;
	end;
[/Code]