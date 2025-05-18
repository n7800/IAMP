{
Business Source License 1.1

Parameters

Licensor:             InstallAware Software

Licensed Work:        InstallAware (Multi Platform) 2025
                      The Licensed Work is (C) 1996-2025 InstallAware Software

Additional Use Grant: You may make use of the Licensed Work, provided that
                      you may not use the Licensed Work at a Sanctioned Entity.

                      Sanctioned Entities are individuals, organizations, or
                      legal persons who have been formally designated by the
                      Licensor as having materially violated intellectual
                      property rights, breached license terms, or engaged in
                      unethical exploitation of (open-source) technologies,
                      including this software.

                      As of the first publicly available distribution of this
                      specific version of the Licensed Work under this
                      License, the following are designated as Sanctioned
                      Entities:

                      Future US, Inc.
                      L3Harris Technologies, Inc.
                      Wolters Kluwer N.V.

                      This includes any individuals, organizations, or
                      entities, acting in any capacity and at any time,
                      either directly or indirectly, on behalf of or under
                      the control and influence of the Sanctioned Entities,
                      such as (but not only) current and future:

                      Subsidiaries
                      Affiliates
                      Contractors
                      Agents
                      Employees
                      Parent companies
                      Acquisitions
                      Assignees
                      Joint Ventures
                      Franchisees
                      
                      Entities may petition the Licensor for removal from the
                      Sanctioned Entities list. Any such removal is at the
                      sole discretion of the Licensor and must be issued in a
                      public update to the Licensed Work under this License
                      as documented in this Additional Use Grant parameter.

Change Date:          2029-05-19

Change License:       GNU Affero General Public License version 3 (AGPLv3)

For information about alternative licensing arrangements for the Software,
please visit: https://www.installaware.com/

Notice

The Business Source License (this document, or the “License”) is not an Open
Source license. However, the Licensed Work will eventually be made available
under an Open Source License, as stated in this License.

License text copyright (c) 2017 MariaDB Corporation Ab, All Rights Reserved.
“Business Source License” is a trademark of MariaDB Corporation Ab.

Terms

The Licensor hereby grants you the right to copy, modify, create derivative
works, redistribute, and make non-production use of the Licensed Work. The
Licensor may make an Additional Use Grant, above, permitting limited
production use.

Effective on the Change Date, or the fourth anniversary of the first publicly
available distribution of a specific version of the Licensed Work under this
License, whichever comes first, the Licensor hereby grants you rights under
the terms of the Change License, and the rights granted in the paragraph
above terminate.

If your use of the Licensed Work does not comply with the requirements
currently in effect as described in this License, you must purchase a
commercial license from the Licensor, its affiliated entities, or authorized
resellers, or you must refrain from using the Licensed Work.

All copies of the original and modified Licensed Work, and derivative works
of the Licensed Work, are subject to this License. This License applies
separately for each version of the Licensed Work and the Change Date may vary
for each version of the Licensed Work released by Licensor.

You must conspicuously display this License on each original or modified copy
of the Licensed Work. If you receive the Licensed Work in original or
modified form from a third party, the terms and conditions set forth in this
License apply to your use of that work.

Any use of the Licensed Work in violation of this License will automatically
terminate your rights under this License for the current and all other
versions of the Licensed Work.

This License does not grant you any right in any trademark or logo of
Licensor or its affiliates (provided that you may use a trademark or logo of
Licensor as expressly required by this License).

TO THE EXTENT PERMITTED BY APPLICABLE LAW, THE LICENSED WORK IS PROVIDED ON
AN “AS IS” BASIS. LICENSOR HEREBY DISCLAIMS ALL WARRANTIES AND CONDITIONS,
EXPRESS OR IMPLIED, INCLUDING (WITHOUT LIMITATION) WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE, NON-INFRINGEMENT, AND
TITLE.

MariaDB hereby grants you permission to use this License’s text to license
your works, and to refer to it using the trademark “Business Source License”,
as long as you comply with the Covenants of Licensor below.

Covenants of Licensor

In consideration of the right to use this License’s text and the “Business
Source License” name and trademark, Licensor covenants to MariaDB, and to all
other recipients of the licensed work to be provided by Licensor:

1. To specify as the Change License the GPL Version 2.0 or any later version,
   or a license that is compatible with GPL Version 2.0 or a later version,
   where “compatible” means that software provided under the Change License can
   be included in a program with software provided under GPL Version 2.0 or a
   later version. Licensor may specify additional Change Licenses without
   limitation.

2. To either: (a) specify an additional grant of rights to use that does not
   impose any additional restriction on the right granted in this License, as
   the Additional Use Grant; or (b) insert the text “None”.

3. To specify a Change Date.

4. Not to modify this License in any other way.
}
unit uImageListPool;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils,
  Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, Menus, ImgList, ExtCtrls, StdCtrls,
  mUtils, LazFileUtils, uRunApp, uSleep, uRunAppAs;

type

  TImageListPool = class(TForm)
    ImageList: TImageList;
    Popup: TPopupMenu;
    InstallComponentwithSubComponents1: TMenuItem;
    InstallComponentOnly1: TMenuItem;
    N1: TMenuItem;
    DoNotInstallComponentorSubComponents1: TMenuItem;
    DoNotInstallComponentOnly1: TMenuItem;
    Entirefeaturewillbeunavailable1: TMenuItem;
    Image: TImage;
    tdnTimer: TTimer;
    thzTimer: TTimer;
    thyTimer: TTimer;
    thxTimer: TTimer;
    traxTimer: TTimer;
    tdemTimer: TTimer;
    traTimer: TTimer;
    tfafTimer: TTimer;
    plugTimer: TTimer;
    ImageList7: TImageList;
    Win7Timer: TTimer;
    ImageListWin7: TImageList;
    Image7Off: TImage;
    Image7On: TImage;
    TimerWin7: TTimer;
    ApplicationEvents: TApplicationProperties;
    spoolTimer: TTimer;
    Marechal: TTimer;
    tcemTimer: TTimer;
    teemTimer: TTimer;
    thrmTimer: TTimer;
    trsTimer: TTimer;
    tcfTimer: TTimer;
    sTimer: TTimer;
    procedure ApplicationEventsDropFiles(Sender: TObject;
      const FileNames: array of string);
    procedure tdnTimerTimer(Sender: TObject);
    procedure TrayDblClick(Sender: TObject);
    procedure TrayClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure InstallComponentwithSubComponents1Click(Sender: TObject);
    procedure InstallComponentOnly1Click(Sender: TObject);
    procedure DoNotInstallComponentorSubComponents1Click(Sender: TObject);
    procedure DoNotInstallComponentOnly1Click(Sender: TObject);
    procedure thzTimerTimer(Sender: TObject);
    procedure thyTimerTimer(Sender: TObject);
    procedure thxTimerTimer(Sender: TObject);
    procedure traxTimerTimer(Sender: TObject);
    procedure tdemTimerTimer(Sender: TObject);
    procedure traTimerTimer(Sender: TObject);
    procedure tfafTimerTimer(Sender: TObject);
    procedure plugTimerTimer(Sender: TObject);
    procedure Win7TimerTimer(Sender: TObject);
    procedure TimerWin7Timer(Sender: TObject);
    procedure ApplicationEventsMessage(var Msg: tagMSG; var Handled: Boolean);
    procedure spoolTimerTimer(Sender: TObject);
    procedure MarechalTimer(Sender: TObject);
    procedure tcemTimerTimer(Sender: TObject);
    procedure teemTimerTimer(Sender: TObject);
    procedure thrmTimerTimer(Sender: TObject);
    procedure trsTimerTimer(Sender: TObject);
    procedure tcfTimerTimer(Sender: TObject);
    procedure sTimerTimer(Sender: TObject);
  private
    
  public
    procedure SetNodeSelection(Node: TTreeNode; Recurse, Selected: Boolean);
    procedure ProcessDelayTrayShowForm;
    procedure ProcessTrayClick;
    function IsLicensed: String;
  end;

var
  ImageListPool: TImageListPool;
  PopNode: TTreeNode;

implementation

uses
  mscriptexec, uPool, uDlgAPI, uDirectExtractMedia, uDownload, uExtractMedia, uCopyMedia, uGrabMedia;

{$R *.lfm}

procedure TImageListPool.SetNodeSelection(Node: TTreeNode; Recurse, Selected: Boolean);
var
  s: String;
  i: Integer;
begin
  if Node.Data <> nil then
  begin
    SetSelectionEx(Integer(Node.Data) -1, Selected);
    if Selected then
      Node.ImageIndex := 1
    else
      Node.ImageIndex := 0;
    Node.SelectedIndex := Node.ImageIndex;
  end;
  if Recurse then
    for i := 1 to Node.Count do
    begin
      s := mscriptexec.Components[Integer(Node[i -1].Data) -1];
      if not GetAnyParentComponentBars(s) then
        SetNodeSelection(Node[i -1], True, Selected);
    end;
end;

procedure TImageListPool.spoolTimerTimer(Sender: TObject);
begin
  spoolTimer.Enabled := false;
  {$IFDEF USEVARMANAGER}
  if VarManager['MYAH_LastActiveTick'] <> VarManager['MYAH_LastDelegateTick'] then
  begin
    
    VarManager['MYAH_LastActiveTick'] := VarManager['MYAH_LastDelegateTick'];
    spoolTimer.Enabled := True;
    Exit;
  end;
  {$ELSE}
  if GETVARIABLE('MYAH_LastActiveTick') <> GETVARIABLE('MYAH_LastDelegateTick') then
  begin
    
    SetVariable('MYAH_LastActiveTick', GetVariable('MYAH_LastDelegateTick'),'');
    spoolTimer.Enabled := True;
    Exit;
  end;
  {$ENDIF}
  KillThread(thSpoolerThread.Handle);
  thSpoolerFinished := True;
end;

procedure TImageListPool.sTimerTimer(Sender: TObject);
begin
  sTimer.Enabled := false;
  KillThread(ts.Handle);
  sFinished := True;
end;

procedure TImageListPool.tcemTimerTimer(Sender: TObject);
begin
  tcemTimer.Enabled := false;
  if GetVariable('MYAH_LastActiveTick') <> GetVariable('MYAH_LastDelegateTick') then
  begin
    
    SetVariable('MYAH_LastActiveTick', GetVariable('MYAH_LastDelegateTick'),'');
    tcemTimer.Enabled := True;
    Exit;
  end;
  KillThread(tcem.Handle);
  thcxFinished := True;
end;

procedure TImageListPool.tcfTimerTimer(Sender: TObject);
begin
  tcfTimer.Enabled := false;
  
end;

procedure TImageListPool.tdemTimerTimer(Sender: TObject);
begin
  tdemTimer.Enabled := false;
  {$IFDEF USEVARMANAGER}
  if VarManager['MYAH_LastActiveTick'] <> VarManager['MYAH_LastDelegateTick'] then
  begin
    
    VarManager['MYAH_LastActiveTick'] := VarManager['MYAH_LastDelegateTick'];
    tdemTimer.Enabled := True;
    Exit;
  end;
  {$ELSE}
  if GetVariable('MYAH_LastActiveTick') <> GetVariable('MYAH_LastDelegateTick') then
  begin
    
    SetVariable('MYAH_LastActiveTick', GetVariable('MYAH_LastDelegateTick'),'');
    tdemTimer.Enabled := True;
    Exit;
  end;
  {$ENDIF}
  KillThread(tdem.Handle);
  thdxFinished := True;
end;

procedure TImageListPool.teemTimerTimer(Sender: TObject);
begin
  teemTimer.Enabled := false;
  if GetVariable('MYAH_LastActiveTick') <> GetVariable('MYAH_LastDelegateTick') then
  begin
    
    SetVariable('MYAH_LastActiveTick', GetVariable('MYAH_LastDelegateTick'),'');
    teemTimer.Enabled := True;
    Exit;
  end;
  KillThread(tcem.Handle);
  thexFinished := True;
end;

procedure TImageListPool.tfafTimerTimer(Sender: TObject);
begin
  tfafTimer.Enabled := false;
  if GetVariable('MYAH_LastActiveTick') <> GetVariable('MYAH_LastDelegateTick') then
  begin
    
    SetVariable('MYAH_LastActiveTick', GetVariable('MYAH_LastDelegateTick'),'');
    tfafTimer.Enabled := True;
    Exit;
  end;
  KillThread(tfaf.Handle);
  thfFinished := True;
end;

procedure TImageListPool.thrmTimerTimer(Sender: TObject);
begin
  thrmTimer.Enabled := false;
  
end;

procedure TImageListPool.thxTimerTimer(Sender: TObject);
begin
  thxTimer.Enabled := false;
  if GetVariable('MYAH_LastActiveTick') <> GetVariable('MYAH_LastDelegateTick') then
  begin
    
    SetVariable('MYAH_LastActiveTick',GetVariable('MYAH_LastDelegateTick'),'');
    thxTimer.Enabled := True;
    Exit;
  end;
  KillThread(tem.Handle);
  thxFinished := True;
end;

procedure TImageListPool.thyTimerTimer(Sender: TObject);
begin
  thyTimer.Enabled := false;
  if GetVariable('MYAH_LastActiveTick') <> GetVariable('MYAH_LastDelegateTick') then
  begin
    
    SetVariable('MYAH_LastActiveTick',GetVariable('MYAH_LastDelegateTick'),'');
    thyTimer.Enabled := True;
    Exit;
  end;
  KillThread(tgm.Handle);
  thyFinished := True;
end;

procedure TImageListPool.thzTimerTimer(Sender: TObject);
begin
  thzTimer.Enabled := false;
  if GetVariable('MYAH_LastActiveTick') <> GetVariable('MYAH_LastDelegateTick') then
  begin
    
    SetVariable('MYAH_LastActiveTick',GetVariable('MYAH_LastDelegateTick'),'');
    thzTimer.Enabled := True;
    Exit;
  end;
  KillThread(tcm.Handle);
  thzFinished := True;
end;

procedure TImageListPool.TimerWin7Timer(Sender: TObject);
begin
  TimerWin7.Enabled := false;
end;

procedure TImageListPool.traTimerTimer(Sender: TObject);
begin
  traTimer.Enabled := false;
  
  KillThread(tra.Handle);
  raFinished := True;
end;

procedure TImageListPool.traxTimerTimer(Sender: TObject);
begin
  traxTimer.Enabled := false;
  KillThread(trax.Handle);
  raxFinished := True;
end;

procedure TImageListPool.InstallComponentwithSubComponents1Click(
  Sender: TObject);
var
  n: TTreeNode;
begin
  SetNodeSelection(PopNode, True, True);
  n := PopNode.Parent;
  while n <> nil do
  begin
    SetNodeSelection(n, false, True);
    n := n.Parent;
  end;
  PopNode.TreeView.Refresh;
  TPoolTemplate(PopNode.TreeView.Parent).
  ReflectComponentInfo;
end;

function TImageListPool.IsLicensed: String;
begin
  Result := '';
end;

procedure TImageListPool.MarechalTimer(Sender: TObject);
begin
  Marechal.Enabled := false;
end;

procedure TImageListPool.plugTimerTimer(Sender: TObject);
begin
  plugTimer.Enabled := false;
end;

procedure TImageListPool.InstallComponentOnly1Click(Sender: TObject);
var
  n: TTreeNode;
begin
  SetNodeSelection(PopNode, false, True);
  n := PopNode.Parent;
  while n <> nil do
  begin
    SetNodeSelection(n, false, True);
    n := n.Parent;
  end;
  PopNode.TreeView.Refresh;
  TPoolTemplate(PopNode.TreeView.Parent).ReflectComponentInfo;;
end;

procedure TImageListPool.DoNotInstallComponentorSubComponents1Click(
  Sender: TObject);
begin
  SetNodeSelection(PopNode, True, false);
  PopNode.TreeView.Refresh;
  TPoolTemplate(PopNode.TreeView.Parent).ReflectComponentInfo;;
end;

procedure TImageListPool.ApplicationEventsMessage(var Msg: tagMSG;
  var Handled: Boolean);
begin
end;

procedure TImageListPool.DoNotInstallComponentOnly1Click(Sender: TObject);
begin
  SetNodeSelection(PopNode, false, false);
  PopNode.TreeView.Refresh;
  TPoolTemplate(PopNode.TreeView.Parent).ReflectComponentInfo;;
end;

procedure TImageListPool.FormCreate(Sender: TObject);
begin
  InstallComponentOnly1.Caption := dlg26;
  InstallComponentWithSubComponents1.Caption := dlg27;
  EntireFeatureWillBeUnavailable1.Caption := dlg28;
end;

procedure TImageListPool.TrayClick(Sender: TObject);
begin
  ProcessTrayClick;
end;

procedure TImageListPool.TrayDblClick(Sender: TObject);
begin
  ProcessTrayClick;
end;

procedure TImageListPool.tdnTimerTimer(Sender: TObject);
begin
  tdnTimer.Enabled := false;
  if GetVariable('MYAH_LastActiveTick') <> GetVariable('MYAH_LastDelegateTick') then
  begin
    
    SetVariable('MYAH_LastActiveTick',GetVariable('MYAH_LastDelegateTick'),'');
    tdnTimer.Enabled := True;
    Exit;
  end;
  KillThread(tdn.Handle);
  dnFinished := True;
end;

procedure TImageListPool.ApplicationEventsDropFiles(Sender: TObject;
  const FileNames: array of string);
var
  l: TStringList;
  t: TextFile;
  i: Integer;
  s: String;
begin
  
  {$IFDEF DARWIN}
  
  if AnsiCompareText(ExtractFileName(MyParamStr(0)), 'miafstub') = 0 then
  begin
    AssignFile(t, AssertDir(ExtractFilePath(MyParamStr(0))) + 'target.object');
    Reset(t);
    ReadLn(t, s);
    CloseFile(t);
    s := GetBundleBinary(s);
    l := TStringList.Create;
    for i := 1 to Length(FileNames) do
      l.Add(FileNames[i -1]);
    if MyFileExists(s) and FileIsExecutable(s) then
    try
      LaunchAppAndWait2(GetBundleBinary(s), l, True, false);
    except
      
    end;
     
    l.Free;
    
    Application.Terminate;
  end;
  {$ENDIF}
end;

procedure TImageListPool.trsTimerTimer(Sender: TObject);
begin
  trsTimer.Enabled := false;
  
end;

procedure TImageListPool.Win7TimerTimer(Sender: TObject);
begin
  ImageListPool.Win7Timer.Enabled := false;
end;

procedure TImageListPool.ProcessDelayTrayShowForm;
begin
end;

procedure TImageListPool.ProcessTrayClick;
begin
end;

end.
