[Code]
type
  TSHFileOpStruct = record
    hwnd: HWND;
    wFunc: UINT;
    pFrom: String;
    pTo: String;
    fFlags: Word;
    fAnyOperationsAborted: BOOL; 
    hNameMappings: HWND;
    lpszProgressTitle: String;
  end; 

const
  FO_MOVE            = $0001;
  FO_COPY            = $0002;
  FO_RENAME          = $0004;

  FOF_NULL           = $0000;
  FOF_MULTIDESTFILES = $0001;
  FOF_NOCONFIRMATION = $0010;
  FOF_NOCONFIRMMKDIR = $0200;

function SHFileOperation(lpFileOp: TSHFileOpStruct): Integer;
  external 'SHFileOperationW@shell32.dll stdcall';
  
function ShellFileOperation(const Source: String; const Destination: String; const Operation: uint; const extraFlags: uint): Boolean;
var
  FileOp: TSHFileOpStruct;
  OperationResult: Integer;
begin

  FileOp.hwnd := WizardForm.Handle;
  FileOp.wFunc := Operation;
  FileOp.pFrom := Source;
  FileOp.pTo := Destination;
  FileOp.fFlags := FOF_NOCONFIRMATION or FOF_NOCONFIRMMKDIR or extraFlags;

  OperationResult := SHFileOperation(FileOp)

  if OperationResult <> 0 then
  begin
    Log('Error! Operation gave a bad result! ' + IntToStr(OperationResult))
    Result := false
    exit;
  end;

  result := true
end;

function ShellRename(const Source: String; const Destination: String): Boolean;
begin 
    result := ShellFileOperation(Source + #0#0, Destination + #0#0, FO_RENAME, FOF_NULL)
end;

function ShellCopy(const Source: String; const Destination: String): Boolean;
begin 
    result := ShellFileOperation(Source + #0#0, Destination + #0#0, FO_COPY, FOF_NULL)
end;

function ShellMove(const Source: String; const Destination: String): Boolean;
begin 
    result := ShellFileOperation(Source + #0#0, Destination + #0#0, FO_MOVE, FOF_NULL)
end;

function ShellCopyMultipleDest(const Source: array of string; const Destination: array of string): Boolean;
var 
    SourceString, DestinationString: string;
    I: Integer;
begin

    Log('Will copy the following files: ')

    for i := 0 to GetArrayLength(Source) - 1 do
    begin
        Log(Source[i] + ' ---> ' + Destination[i])
        SourceString := SourceString + Source[i] + #0
        DestinationString := DestinationString + Destination[i] + #0
    end;
    
    SourceString := SourceString + #0   
    DestinationString := DestinationString + #0   

    result := ShellFileOperation(SourceString, DestinationString, FO_COPY, FOF_MULTIDESTFILES)
end;

function ShellMoveMultiple(const Source: array of string; const Destination: String): Boolean;
var 
    SourceString: string;
    I: Integer;
begin

    Log('Will move the following files: ')

    for i := 0 to GetArrayLength(Source) - 1 do
    begin
        Log(Source[i])
        SourceString := SourceString + Source[i] + #0
    end;
    
    SourceString := SourceString + #0
    
    Log('To: ' + Destination)

    result := ShellFileOperation(SourceString, AddBackSlash(Destination) + #0#0, FO_MOVE, FOF_NULL)
end;

[/Code]