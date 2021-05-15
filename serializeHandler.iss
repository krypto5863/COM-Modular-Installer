[Code]
Function HandleSer(const GamePath: String): Boolean;
begin

  If FileExists(GamePath + '\serialize_storage_config.cfg') = false then
  begin
    result := true
    exit;
  end;

  if MsgBox('We noticed you have a file that causes save data to be placed in the user Documents directory (serialize_storage_config.cfg). Normally this is removed, but it does not hurt to leave it. Shall we remove this file and place your savedata back in the game folder?', mbConfirmation, MB_YESNO) = MrYES then
  begin
    if DeleteFile(GamePath + '\serialize_storage_config.cfg') = false then
    begin
      MsgBox('Failed to delete the file at ' + GamePath + '\serialize_storage_config.cfg for an unknown reason!' , mbCriticalError, MB_OK);
      result := false;
      exit;
    end;

    if DirExists(ExpandConstant('{userdocs}\KISS\COM3D2')) then
    begin
      if Copy(ExpandConstant('{userdocs}\KISS\COM3D2'), GamePath) = false then
      begin
        MsgBox('Failed to copy the files at ' + ExpandConstant('{userdocs}\KISS\COM3D2') + ' for an unknown reason!' , mbCriticalError, MB_OK);
        result := false;
        exit;
      end;
    end;
  end;

  result := true;
end;
[/Code]