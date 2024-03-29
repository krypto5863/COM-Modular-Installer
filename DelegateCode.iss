[Code]

procedure OnResize(const Sender: TObject);
begin

	OGResizeEvent(Sender)

	ChangeBannerbutton.Left := 0
	ChangeBannerbutton.Top := 0
	ChangeBannerButton.Anchors := [akRight]
	ChangeBannerButton.Width := 20
	ChangeBannerButton.Height := 20

end;

procedure TypesComboChange(const Sender: TObject);
begin
	OGEvent(Sender)

	if (CompareText(WizardSetupType(false),'preset') = 0) then
		ApplyCustomPreset(path + '\' + PresetFile);

	FixComponents()
end;

function OnDownloadProgress(const Url, Filename: string; const Progress, ProgressMax: Int64): Boolean;
var
	Progress1, Progress2, Percent: Single;
begin

	Progress1 := Progress
	Progress2 := ProgressMax

	Percent := Progress1/Progress2 * 100

	if (Progress = ProgressMax) AND (Progress <> 0) then
	begin
		DownloadProgressLabel.Caption := CustomMessage('DownloadFinish')
	end else
	if (ProgressMax <> 0) then
	begin
		DownloadProgressLabel.Caption := FmtMessage(CustomMessage('DownloadWPercent'), [IntToStr(Progress/1024/1024), IntToStr(ProgressMax/1024/1024), Format('%.1n',[Percent])])
	end
	else
	begin
		DownloadProgressLabel.Caption := FmtMessage(CustomMessage('DownloadNoPercent'), [Progress/1024/1024])
	end;

	Result := true
end;
[/Code]