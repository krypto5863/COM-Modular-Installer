[Code]
procedure OnResize(const Sender: TObject);
begin

	OriginalResizeEvent(Sender)

	ChangeBannerbutton.Left := 0
	ChangeBannerbutton.Top := 0
	ChangeBannerButton.Anchors := [akRight]
	ChangeBannerButton.Width := 20
	ChangeBannerButton.Height := 20

end;

procedure TypesComboChange(const Sender: TObject);
begin

    OriginalTypeComboChangedEvent(Sender)

	if (CompareText(WizardSetupType(false),'preset') = 0) then
		ApplyCustomPreset(AddBackslash(ExpandConstant('{app}')) + PresetFile);

	FixComponents()

end;
[/Code]