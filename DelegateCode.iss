[Code]
	procedure TypesComboChange(const Sender: TObject);
	begin
    OGEvent(Sender);

		if (CompareText(WizardForm.TypesCombo.Items.Strings[WizardForm.TypesCombo.ItemIndex],'Custom Preset') = 0) then
			ApplyCustomPreset(path + '\' + PresetFile);
	end;

  function OnDownloadProgress(const Url, Filename: string; const Progress, ProgressMax: Int64): Boolean;
	begin
		if ProgressMax <> 0 then
			Log(Format('  %d of %d bytes done.', [Progress, ProgressMax]))
		else
			Log(Format('  %d bytes done.', [Progress]));
      Result := True;
	end;
[/Code]