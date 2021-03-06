program YaLife;

uses
  Forms,
  UI.Forms.FmBase in 'UI.Forms.FmBase.pas' {BaseForm},
  UI.Frames.FrBase in 'UI.Frames.FrBase.pas' {BaseFrame: TFrame},
  UI.Forms.FmMain in 'UI.Forms.FmMain.pas' {MainForm},
  UUtils in 'UUtils.pas',
  Engine.UCommon in 'Engine.UCommon.pas',
  Engine.URules in 'Engine.URules.pas',
  Engine.UGrid in 'Engine.UGrid.pas',
  Engine.UCompressedGrid in 'Engine.UCompressedGrid.pas',
  UStructs in 'UStructs.pas',
  Engine.UPattern in 'Engine.UPattern.pas',
  UComparers in 'UComparers.pas',
  Filters.URLE in 'Filters.URLE.pas',
  Filters.UPlainText in 'Filters.UPlainText.pas',
  Filters.ULife106 in 'Filters.ULife106.pas',
  Filters.ULife105 in 'Filters.ULife105.pas',
  Filters.UNative in 'Filters.UNative.pas';

{$Resource Resources.res}
{$Resource Version.res}

begin
  ReportMemoryLeaksOnShutdown := DebugHook <> 0;
  Application.Initialize;
  Application.MainFormOnTaskbar := True;
  Application.ModalPopupMode := pmAuto;
  Application.CreateForm(TMainForm, MainForm);
  Application.Run;
end.