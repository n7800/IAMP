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

unit uPool;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils,
  Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, Buttons, MaskEdit, ComCtrls,
  checklst, mUtils, RunFus, PropIntf, Menus,
  uLazPopup, FileLbl, ShellCtrls, FDMain;

type

  TPoolTemplate = class(TForm)
    Designer: TRFDesigner;
    procedure MaskEdit1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure Memo1Change(Sender: TObject);
    procedure RichEdit1Change(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure Label1Click(Sender: TObject);
    procedure GlowLabel1Click(Sender: TObject);
    procedure Edit1Change(Sender: TObject);
    procedure RzBmpButton1Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
    procedure RadioButton1Click(Sender: TObject);
    procedure ListBox1Click(Sender: TObject);
    procedure ComboBox1Click(Sender: TObject);
    procedure ComboBox1Change(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure MaskEdit1Change(Sender: TObject);
    procedure Image1Click(Sender: TObject);
    procedure Shape1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TrackBar1Change(Sender: TObject);
    procedure CheckListBox1Click(Sender: TObject);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView1Change(Sender: TObject; Node: TTreeNode);
    procedure TreeView1MouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure TreeView1KeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FileListBox1Change(Sender: TObject);
    procedure DirectoryListBox1Change(Sender: TObject);
    procedure DriveComboBox1Change(Sender: TObject);
    procedure Timer1Timer(Sender: TObject);
    procedure MetaTimerTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure AeroButton1Click(Sender: TObject);
    procedure AeroPngButton1Click(Sender: TObject);
    procedure AeroBackButton1Click(Sender: TObject);
    procedure FormCanResize(Sender: TObject; var NewWidth, NewHeight: Integer;
      var Resize: Boolean);
    procedure FormMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FormKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  protected
    procedure WMEraseBkgnd(var Message: TWMEraseBkgnd); message WM_ERASEBKGND;
  private
    FWindowIsActive: Boolean; 
    procedure WMNCHitTest(var Msg: TWMNCHitTest); message WM_NCHitTest;
  public
    MyahSmartShape: TShape;
    FDPIScale: Boolean;
    Timer, MetaTimer: TTimer;
    FCanClose: Boolean;
    FModalEx: Integer;
    FModalExReturn: String;
    FRules: String;
    FStarted: Boolean;
    FStart: Boolean;
    FNonModal: Boolean;
    FFinish: Boolean;
    FTimer: TTimer;
    FSoloMemo: String;
    FSoloRich: String;
    FCurrentComponent: String;
    MemoWindowProc: TWndMethod;
    RichWindowProc: TWndMethod;
    MemoBuffer: TMemo;
    procedure SetAllDirectoryEditText(Path: String);
    procedure SetCustomDirectoryEditText(Path, CustomVariable: String);
    procedure ReflectRules;
    procedure ReflectComponentInfo;
    procedure NewFileSystemReflection;
    function GetPropertyAsString(ControlName, ControlProperty: String): String;
    procedure SetPropertyAsString(ControlName, ControlProperty, NewValue: String);
    property Rules: string read FRules write FRules;
    property SoloRich: string read FSoloRich write FSoloRich;
    property SoloMemo: string read FSoloMemo write FSoloMemo;
    constructor CreateEx(LFMFile: String);
    procedure CreateParams(var Params: TCreateParams); override;
    procedure SmartResolveValue(var Value: String);
    procedure Bug;
    function IsLicensed: String;
    procedure TransitionCompleted(FormA, FormB: TCustomForm; var RestoreFormA: Boolean);
    procedure ShowHide(const FromForm, ToForm: TCustomForm);
    procedure DisplaySystemMenu(X, Y: Integer);
  published
    property WindowIsActive: Boolean read FWindowIsActive; 
  end;

var
  InsideTransition: Boolean = false;
  GlobalAbort: Boolean;
  PoolTemplate: TPoolTemplate;
  BlockUpdates: Boolean;
  
  poolDlgRootFolder: String;
  NextFile, PresentFile: String; 
  TargetDirCached, TargetDirExisting: String;
  LastHTMLFile: String = '';
  FirstAppend: Boolean = True;

implementation

uses uImageListPool, mscriptexec,
  {$IFDEF SUPERSMALL}
  uDlgAPIIntf;
  {$ELSE}
  uDlgAPI;
  {$ENDIF}

{$R *.lfm}

constructor TPoolTemplate.CreateEx(LFMFile: String);
var
  s: String;
  fs: TFileStream;
begin
  GetDir(0, s);
  ChDir(ExtractFilePath(LFMFile));
  inherited Create(nil);
  fs := TFileStream.Create(LFMFile, fmOpenRead);
  Designer.LoadFromStream(fs, dfmText);
  fs.Free;
  
  ChDir(s);
  FNonModal := false;
  FStarted := false;
  FStart := false;
  FFinish := false;
  MetaTimer := TTimer.Create(Self);
  MetaTimer.Enabled := false;
  MetaTimer.OnTimer := MetaTimerTimer;
  Timer := TTimer.Create(Self);
  Timer.Enabled := True;
  Timer.Interval := 1000;
  Timer.OnTimer := Timer1Timer;
  FTimer := Timer;
  Hint := ExtractFileName(LFMFile);
  MemoBuffer := nil;
  MyahSmartShape := nil;
  
  KeyPreview := True;
end;

function TPoolTemplate.GetPropertyAsString(ControlName, ControlProperty: String): String;
var
  i, j: Integer;
  pi: TPropertyInterface;
begin
  Result := '';
  
  for i := 1 to ComponentCount do
    if AnsiUpperCase(Components[i -1].Name) = AnsiUpperCase(ControlName) then
    begin
      
      pi := TPropertyInterface.Create(nil);
      pi.Instance := Components[i -1];
      for j := 1 to pi.Count do
        if AnsiUpperCase(pi.Properties[j -1].Name) = AnsiUpperCase(ControlProperty) then
        begin
          
          Result := pi.Properties[j -1].AsString;
          pi.Free;
          Exit;
        end;
      pi.Free;
    end;
end;

procedure TPoolTemplate.SetPropertyAsString(ControlName, ControlProperty, NewValue: String);
var
  i, j: Integer;
  pi: TPropertyInterface;
  
begin
  
  for i := 1 to ComponentCount do
    if AnsiUpperCase(Components[i -1].Name) = AnsiUpperCase(ControlName) then
    begin
      
      pi := TPropertyInterface.Create(nil);
      pi.Instance := Components[i -1];
      for j := 1 to pi.Count do
        if AnsiUpperCase(pi.Properties[j -1].Name) = AnsiUpperCase(ControlProperty) then
        begin
          
          pi.Properties[j -1].AsString := NewValue;
          
          pi.Free;
          
          Exit;
        end;
      pi.Free;
    end;
  
end;

procedure TPoolTemplate.ReflectRules;
var
  i: Integer;
  l: TStringList;
  srcControl, srcProperty, srcValue: String;
  trgControl, trgProperty, trgValue: String;
  srcReverse: Boolean;
  
begin
  
  l := TStringList.Create;
  l.CommaText := Rules;
  for i := 1 to l.Count do
  begin
    
    ParseRule(l[i -1], srcReverse,
      srcControl, srcProperty, srcValue, trgControl, trgProperty,
      trgValue);
    
    SmartResolveValue(srcValue);
    if (GetPropertyAsString(srcControl, srcProperty) = srcValue) xor srcReverse then
    begin
      
      SmartResolveValue(trgValue);
      SetPropertyAsString(trgControl, trgProperty, trgValue);
    end;
    
  end;
  l.Free;
  
end;

procedure TPoolTemplate.SetAllDirectoryEditText(Path: String);
var
  i: Integer;
  s: String;
begin
  if TargetDirCached <> '' then
    s := TargetDirCached
  else
    s := Path; 
  if Path = '' then s := '' 
  else
  if AnsiPos(AnsiLowerCase(Path), AnsiLowerCase(s)) = 1 then 
    s := s
  else 
    s := AssertDir(Path) + TargetDirExisting;
  for i := 1 to ComponentCount do
    if Components[i -1] is TEdit then
      if TEdit(Components[i -1]).Tag = 2 then
      begin
        TEdit(Components[i -1]).Text := s;
        Edit1Change(TEdit(Components[i -1]));
      end;
  ReflectComponentInfo;
  ReflectRules;
end;

procedure TPoolTemplate.SetCustomDirectoryEditText(Path,
  CustomVariable: String);
var
  i: Integer;
  s: String;
begin
  SureSetVariable(AnsiUpperCase(CustomVariable), AssertDir(Path), 'SetCustomDirectoryEditText'); 
  ReflectComponentInfo;
  NewFileSystemReflection;
  ReflectRules;
end;

procedure TPoolTemplate.FormCreate(Sender: TObject);
begin
  FDPIScale := false;
  
end;

procedure TPoolTemplate.Label1Click(Sender: TObject);
var
  l: TLabel;
  s: String;
begin
  FModalEx := -1;
  if BlockUpdates then Exit;
  l := TLabel(Sender);
  if l.Tag = 1 then FModalEx := mrYes;
  if l.Tag = 2 then FModalEx := mrNo;
  if l.Tag = 3 then
  begin
    if MessageBox(Handle, PChar(msg22),
      PChar(BrandEx), mb_IconQuestion + mb_YesNo + mb_DefButton2) = id_Yes then
    begin
      SetVariable('MYAH_IsCancelled', 'TRUE', 'ShowDesign') ;
      TLabel(Sender).Enabled := false;
      if not FStarted then FModalEx := mrCancel;
      
    end;
  end;
  if l.Tag = 4 then
  begin
    if Dialogs.SelectDirectory('', '', s, True) then
    
      SetAllDirectoryEditText(s);
  end;
  if l.Tag = 5 then
  begin
    FModalEx := mrAll;
    FModalExReturn := TLabel(Sender).Name;
  end;
  if l.Tag = 6 then
  begin
    if Dialogs.SelectDirectory('', '', s, True) then
    
      if s <> '' then 
        SetCustomDirectoryEditText(s, l.Name);
  end;
  {$IFDEF NOCACHE}
  if FModalEx <> -1 then
    ModalResult := FModalEx;
  {$ENDIF}
  ReflectRules;
end;

procedure TPoolTemplate.GlowLabel1Click(Sender: TObject);
begin
end;

procedure TPoolTemplate.Edit1Change(Sender: TObject);
var
  i: Integer;
begin
  if BlockUpdates then Exit;
  SureSetVariable(AnsiUpperCase(TEdit(Sender).Hint), TEdit(Sender).Text, 'Edit1Change'); 
  ReflectComponentInfo;
  NewFileSystemReflection;
  ReflectRules;
  if TEdit(Sender).MaxLength <> 0 then
    if TEdit(Sender).MaxLength = Length(TEdit(Sender).Text) then
      for i := 1 to ControlCount do
      try
        if TWinControl(Controls[i -1]).TabOrder = TEdit(Sender).TabOrder +1 then
          try
            TWinControl(Controls[i -1]).SetFocus;
          except
          end;
      except
      end;
end;

procedure TPoolTemplate.Bug;
begin
  RecreateWnd(Self); 
end;

procedure TPoolTemplate.Button1Click(Sender: TObject);
var
  b: TButton;
  s: String;
begin
  FModalEx := -1;
  if BlockUpdates then Exit;
  b := TButton(Sender);
  if b.Tag = 1 then FModalEx := mrYes;
  if b.Tag = 2 then FModalEx := mrNo;
  if b.Tag = 3 then
  begin
    if MessageBox(Handle, PChar(msg22),
      PChar(BrandEx), mb_IconQuestion + mb_YesNo + mb_DefButton2) = id_Yes then
    begin
      SetVariable('MYAH_IsCancelled', 'TRUE', 'ShowDesign') ;
      TButton(Sender).Enabled := false;
      if not FStarted then FModalEx := mrCancel;
      
    end;
  end;
  if b.Tag = 4 then
  begin
    if Dialogs.SelectDirectory('', '', s, True) then
    
      if s <> '' then 
        SetAllDirectoryEditText(s);
  end;
  if b.Tag = 5 then
  begin
    FModalEx := mrAll;
    FModalExReturn := TButton(Sender).Name;
  end;
  if b.Tag = 6 then
  begin
    if Dialogs.SelectDirectory('', '', s, True) then
    
      if s <> '' then 
        SetCustomDirectoryEditText(s, b.Name);
  end;
  {$IFDEF NOCACHE}
  if FModalEx <> -1 then
    ModalResult := FModalEx;
  {$ENDIF}
  ReflectRules;
end;

procedure TPoolTemplate.CheckBox1Click(Sender: TObject);
begin
  if BlockUpdates then Exit;
  SureSetVariable(AnsiUpperCase(TCheckBox(Sender).Hint),
    MyBoolToStr(TCheckBox(Sender).Checked, True), 'CheckBox1Click'); 
  ReflectRules;
end;

procedure TPoolTemplate.RadioButton1Click(Sender: TObject);
var
  i: Integer;
begin
  if BlockUpdates then Exit;
  
  for i := 1 to ComponentCount do
    if Components[i -1] is TRadioButton then
      if TRadioButton(Components[i -1]).Hint <> '' then
        SureSetVariable(AnsiUpperCase(TRadioButton(Components[i -1]).Hint),
          MyBoolToStr(TRadioButton(Components[i -1]).Checked, True), 'RadioButton1Click'); 
  ReflectRules;
end;

procedure TPoolTemplate.ListBox1Click(Sender: TObject);
var
  l: TStringList;
  i: Integer;
begin
  if BlockUpdates then Exit;
  l := TStringList.Create;
  l.Text := TListBox(Sender).Items.Text;
  for i := TListBox(Sender).Items.Count downto 1 do
    if not TListBox(Sender).Selected[i -1] then
      l.Delete(i -1);
  
      SureSetVariable(AnsiUpperCase(TListBox(Sender).Hint),
        StringReplace(l.Text, LineEnding, '$NEWLINE$', [rfReplaceAll, rfIgnoreCase]), 
        'ListBox1Click'); 
  l.Free;
  
  ReflectRules;
end;

procedure TPoolTemplate.ComboBox1Click(Sender: TObject);
begin
  if BlockUpdates then Exit;
  SureSetVariable(AnsiUpperCase(TComboBox(Sender).Hint), TComboBox(Sender).Text, 'ComboBox1Click'); 
  ReflectRules;
end;

procedure TPoolTemplate.ComboBox1Change(Sender: TObject);
begin
  if BlockUpdates then Exit;
  SureSetVariable(AnsiUpperCase(TComboBox(Sender).Hint), TComboBox(Sender).Text, 'ComboBox1Change'); 
  ReflectRules;
end;

procedure TPoolTemplate.AeroBackButton1Click(Sender: TObject);
begin
end;

procedure TPoolTemplate.AeroButton1Click(Sender: TObject);
begin
end;

procedure TPoolTemplate.AeroPngButton1Click(Sender: TObject);
begin
end;

procedure TPoolTemplate.BitBtn1Click(Sender: TObject);
var
  b: TBitBtn;
  s: String;
begin
  FModalEx := -1;
  if BlockUpdates then Exit;
  b := TBitBtn(Sender);
  if b.Tag = 1 then FModalEx := mrYes;
  if b.Tag = 2 then FModalEx := mrNo;
  if b.Tag = 3 then
  begin
    if MessageBox(Handle, PChar(msg22),
      PChar(BrandEx), mb_IconQuestion + mb_YesNo + mb_DefButton2) = id_Yes then
    begin
      SetVariable('MYAH_IsCancelled', 'TRUE', 'ShowDesign') ;
      TBitBtn(Sender).Enabled := false;
      if not FStarted then FModalEx := mrCancel;
      
    end;
  end;
  if b.Tag = 4 then
  begin
    if Dialogs.SelectDirectory('', '', s, True) then
    
      SetAllDirectoryEditText(s);
  end;
  if b.Tag = 5 then
  begin
    FModalEx := mrAll;
    FModalExReturn := TBitBtn(Sender).Name;
  end;
  if b.Tag = 6 then
  begin
    if Dialogs.SelectDirectory('', '', s, True) then
    
      if s <> '' then 
        SetCustomDirectoryEditText(s, b.Name);
  end;
  {$IFDEF NOCACHE}
  if FModalEx <> -1 then
    ModalResult := FModalEx;
  {$ENDIF}
  ReflectRules;
end;

procedure TPoolTemplate.SpeedButton1Click(Sender: TObject);
var
  b: TSpeedButton;
  s: String;
begin
  FModalEx := -1;
  if BlockUpdates then Exit;
  b := TSpeedButton(Sender);
  if b.Tag = 1 then FModalEx := mrYes;
  if b.Tag = 2 then FModalEx := mrNo;
  if b.Tag = 3 then
  begin
    if MessageBox(Handle, PChar(msg22),
      PChar(BrandEx), mb_IconQuestion + mb_YesNo + mb_DefButton2) = id_Yes then
    begin
      SetVariable('MYAH_IsCancelled', 'TRUE', 'ShowDesign') ;
      TSpeedButton(Sender).Enabled := false;
      
      if not FStarted then FModalEx := mrCancel;
    end;
  end;
  if b.Tag = 4 then
  begin
    if Dialogs.SelectDirectory('', '', s, True) then
    
      SetAllDirectoryEditText(s);
  end;
  if b.Tag = 5 then
  begin
    FModalEx := mrAll;
    FModalExReturn := TSpeedButton(Sender).Name;
  end;
  if b.Tag = 6 then
  begin
    if Dialogs.SelectDirectory('', '', s, True) then
    
      if s <> '' then 
        SetCustomDirectoryEditText(s, b.Name);
  end;
  {$IFDEF NOCACHE}
  if FModalEx <> -1 then
    ModalResult := FModalEx;
  {$ENDIF}
  ReflectRules;
end;

procedure TPoolTemplate.MaskEdit1Change(Sender: TObject);
var
  i: Integer;
begin
  if BlockUpdates then Exit;
  SureSetVariable(AnsiUpperCase(TMaskEdit(Sender).Hint), TMaskEdit(Sender).Text, 'MaskEdit1Change'); 
  ReflectComponentInfo;
  NewFileSystemReflection;
  ReflectRules;
end;

procedure TPoolTemplate.Image1Click(Sender: TObject);
var
  b: TImage;
  s: String;
begin
  FModalEx := -1;
  if BlockUpdates then Exit;
  b := TImage(Sender);
  if b.Tag = 1 then FModalEx := mrYes;
  if b.Tag = 2 then FModalEx := mrNo;
  if b.Tag = 3 then
  begin
    if MessageBox(Handle, PChar(msg22),
      PChar(BrandEx), mb_IconQuestion + mb_YesNo + mb_DefButton2) = id_Yes then
    begin
      SetVariable('MYAH_IsCancelled', 'TRUE', 'ShowDesign') ;
      TImage(Sender).Enabled := false;
      
      if not FStarted then FModalEx := mrCancel;
    end;
  end;
  if b.Tag = 4 then
  begin
    if Dialogs.SelectDirectory('', '', s, True) then
    
      SetAllDirectoryEditText(s);
  end;
  if b.Tag = 5 then
  begin
    FModalEx := mrAll;
    FModalExReturn := TImage(Sender).Name;
  end;
  if b.Tag = 6 then
  begin
    if Dialogs.SelectDirectory('', '', s, True) then
    
      if s <> '' then 
        SetCustomDirectoryEditText(s, b.Name);
  end;
  {$IFDEF NOCACHE}
  if FModalEx <> -1 then
    ModalResult := FModalEx;
  {$ENDIF}
  ReflectRules;
end;

function TPoolTemplate.IsLicensed: String;
begin
  Result := '';
end;

procedure TPoolTemplate.Shape1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  b: TShape;
  s: String;
begin
  FModalEx := -1;
  if BlockUpdates then Exit;
  b := TShape(Sender);
  if b.Tag = 1 then FModalEx := mrYes;
  if b.Tag = 2 then FModalEx := mrNo;
  if b.Tag = 3 then
  begin
    if MessageBox(Handle, PChar(msg22),
      PChar(BrandEx), mb_IconQuestion + mb_YesNo + mb_DefButton2) = id_Yes then
    begin
      SetVariable('MYAH_IsCancelled', 'TRUE', 'ShowDesign') ;
      TShape(Sender).Enabled := false;
      
      if not FStarted then FModalEx := mrCancel;
    end;
  end;
  if b.Tag = 4 then
  begin
    if Dialogs.SelectDirectory('', '', s, True) then
    
      SetAllDirectoryEditText(s);
  end;
  if b.Tag = 5 then
  begin
    FModalEx := mrAll;
    FModalExReturn := TShape(Sender).Name;
  end;
  if b.Tag = 6 then
  begin
    if Dialogs.SelectDirectory('', '', s, True) then
    
      if s <> '' then 
        SetCustomDirectoryEditText(s, b.Name);
  end;
  {$IFDEF NOCACHE}
  if FModalEx <> -1 then
    ModalResult := FModalEx;
  {$ENDIF}
  ReflectRules;
end;

procedure TPoolTemplate.ShowHide(const FromForm, ToForm: TCustomForm);
begin
end;

procedure TPoolTemplate.TrackBar1Change(Sender: TObject);
begin
  if BlockUpdates then Exit;
  SureSetVariable(AnsiUpperCase(TTrackBar(Sender).Hint),
    IntToStr(TTrackBar(Sender).Position), 'TrackBar1Change'); 
  ReflectRules;
end;

procedure TPoolTemplate.TransitionCompleted(FormA, FormB: TCustomForm;
  var RestoreFormA: Boolean);
begin
  
  RestoreFormA := true;
end;

procedure TPoolTemplate.CheckListBox1Click(Sender: TObject);
begin
  if BlockUpdates then Exit;
  if TCheckListBox(Sender).ItemIndex = -1 then Exit;
  
  if TCheckListBox(Sender).Tag = 1 then
  begin
    FCurrentComponent := TCheckListBox(Sender).Items[TCheckListBox(Sender).ItemIndex];
    ReflectComponentInfo;
  end;
  ReflectRules;
end;

procedure TPoolTemplate.CheckListBox1ClickCheck(Sender: TObject);
var
  l: TStringList;
  i: Integer;
begin
  if TCheckListBox(Sender).Tag = 1 then
  begin
    SetComponentsFlat(TCheckListBox(Sender));
    ReflectComponentInfo;
  end
  else
  begin
    l := TStringList.Create;
    l.Text := TCheckListBox(Sender).Items.Text;
    for i := TCheckListBox(Sender).Items.Count downto 1 do
      if not TCheckListBox(Sender).Checked[i -1] then
        l.Delete(i -1);
    
    SureSetVariable(AnsiUpperCase(TCheckListBox(Sender).Hint),
      StringReplace(l.Text, LineEnding, '$NEWLINE$', [rfReplaceAll, rfIgnoreCase]), 
      'CheckListBox1ClickCheck'); 
    l.Free;
  end;
  ReflectRules;
end;

procedure TPoolTemplate.ShellTreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  if BlockUpdates then Exit;
  SureSetVariable(AnsiUpperCase(TShellTreeView(Sender).Hint),
    TShellTreeView(Sender).Path, 'ShellTreeView1Change'); 
  NewFileSystemReflection;
  if TShellTreeView(Sender).Tag = 1 then
    SetAllDirectoryEditText(TShellTreeView(Sender).Path);
  ReflectRules;
end;

procedure TPoolTemplate.TreeView1Change(Sender: TObject; Node: TTreeNode);
begin
  if BlockUpdates then Exit;
  if Node = nil then Exit;
  
  if TTreeView(Sender).Tag = 1 then
  begin
    FCurrentComponent := '';
    while Node <> nil do
    begin
      FCurrentComponent := Node.Text + '\' + FCurrentComponent;
      Node := Node.Parent;
    end;
    Delete(FCurrentComponent, Length(FCurrentComponent), 1);
    ReflectComponentInfo;
  end;
  ReflectRules;
end;

procedure TPoolTemplate.TreeView1MouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  pX: TPopupMenu;
  mi: TMenuItem;
  p: TPoint;
  s: String;
  t: TTreeView;
begin
  t := TTreeView(Sender);
  if t.Selected = nil then Exit;
  if t.Selected.Data = nil then Exit;
  if not (htOnIcon in t.GetHitTestInfoAt(X, Y)) then Exit;
  
  if t.Selected.Data <> nil then
  begin
    
    s := mscriptexec.Components[Integer(t.Selected.Data) -1];
    if GetAnyParentComponentBars(s) then Exit;
  end;
  
  GetCursorPos(p);
  PopNode := t.Selected;
  {$IFDEF WINDOWS}
  
  {$IFDEF INTEROP}
  
  LazPopup := TLazPopup.Create(nil);
  LazPopup.Left := p.X;
  LazPopup.Top := p.Y;
  LazPopup.ShowModal;
  LazPopup.Free;
  
  {$ELSE}
  ImageListPool.Popup.Popup(p.X, p.Y);
  {$ENDIF}
  {$ELSE}
  ImageListPool.Popup.Popup(p.X, p.Y);
  {$ENDIF}
  
  ReflectComponentInfo;
  ReflectRules;
end;

procedure TPoolTemplate.WMEraseBkgnd(var Message: TWMEraseBkgnd);
begin
  if AnsiCompareText(RuntimeSubstituteCompilerVariables('#NO_ERASE#'), 'TRUE') = 0 then
    Message.Result := 0
  else
    inherited;
end;

procedure TPoolTemplate.WMNCHitTest(var Msg: TWMNCHitTest);
begin
  inherited;
end;

procedure TPoolTemplate.FileListBox1Change(Sender: TObject);
begin
end;

procedure TPoolTemplate.DirectoryListBox1Change(Sender: TObject);
begin
end;

procedure TPoolTemplate.DisplaySystemMenu(X, Y: Integer);
begin
end;

procedure TPoolTemplate.DriveComboBox1Change(Sender: TObject);
begin
end;

procedure TPoolTemplate.FormKeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  
  b: Boolean;
  i: Integer;
begin
  
  if (Key = 39) or (Key = 37) then
    if not ((((ActiveControl is TMaskEdit) or (ActiveControl is TEdit)) or
      ((ActiveControl is TMemo) or (ActiveControl is TListBox))) or
      (((ActiveControl is TComboBox) or (ActiveControl is TPageControl)) or
      (((ActiveControl is TTreeView) or (ActiveControl is TShellTreeView))
      or (ActiveControl is TTrackBar))) or
      (((ActiveControl is TUpDown) or (ActiveControl is TCheckListBox)))) then
    begin
      if BlockUpdates then Exit;
      for i := 1 to ComponentCount do
        if (((Components[i -1] is TLabel) or
          false) or
          ((Components[i -1] is TButton) or
          ((Components[i -1] is TBitBtn) or
          (Components[i -1] is TSpeedButton))) or
          (((Components[i -1] is TImage) or
          (Components[i -1] is TShape)))) then
        begin
          FModalEx := -1;
          if (Components[i -1].Tag = 1) and (Key = 39) then
          begin
            if TControl(Components[i -1]).Enabled then
              FModalEx := mrYes;
          end
          else
          if (Components[i -1].Tag = 2) and (Key = 37) then
          begin
            if TControl(Components[i -1]).Enabled then
              FModalEx := mrNo;
          end;
          {$IFDEF NOCACHE}
          if FModalEx <> -1 then
            ModalResult := FModalEx;
          {$ENDIF}
          if FModalEx <> -1 then
            Break;
        end;
    end;
end;

procedure TPoolTemplate.FormMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
end;

procedure TPoolTemplate.Timer1Timer(Sender: TObject);
begin
  Timer.Enabled := false;
  if FFinish then
  begin
    FFinish := false;
    
    begin
      
    end;
    Exit;
  end;
  if FStart = false then
  begin
    
    begin
      if MonitorGlobalProgress then
        
        BindProgress('$MYAH$', 0, 0, 0, True); 
      
    end;
    Timer.Enabled := True;
    Exit;
  end;
  if FStarted then
  begin
    if WindowState <> wsMinimized	then
    begin
       
                      BindProgress('$MYAH$', 0, 0, 0, True);
      
    end;
      {$IFDEF USEVARMANAGER}
      if VarManager['MYAH_thFinished'] = 'TRUE' then
      {$ELSE}
      if MyStrToBool(GETVARIABLE('MYAH_thFinished')) then
      {$ENDIF}
    begin
      
      {$IFDEF NOCACHE}
      ModalResult := mrOk;
      {$ELSE}
      FModalEx := mrOk;
      {$ENDIF}
    end;
  end
  else
  begin
    FStarted := True;
{$IFDEF USEVARMANAGER}
    VarManager['MYAH_thCancelled'] := 'FALSE';
    VarManager['MYAH_thFinished'] := 'FALSE';
{$ELSE}
    SETVARIABLE('MYAH_thCancelled', 'FALSE','');
    SETVARIABLE('MYAH_thFinished', 'FALSE','');
{$ENDIF}
    
  end;
  
  Timer.Enabled := True;
end;

procedure TPoolTemplate.FormShow(Sender: TObject);
type
  PWTA_OPTIONS = ^WTA_OPTIONS;
  WTA_OPTIONS = packed record
    dwFlags: DWORD;         
    dwMask: DWORD;          
                            
  end;
  _WTA_OPTIONS = WTA_OPTIONS;
  TWTAOptions = WTA_OPTIONS;
  PWTAOptions = ^TWTAOptions;
  TChangeWindowMessageFilterEx = function(hwnd: THandle; msg: UINT; action: DWORD; pChangeFilterStruct: Pointer): Boolean; stdcall;
  TSetWindowThemeAttribute = function(hwnd: HWND; eAttribute: Cardinal; pvAttribute: Pointer; cbAttribute: DWORD): HResult; stdcall;
var
  s: String;
begin
  if IsVarDefined('TARGETDIR') then 
    TargetDirCached := ElimDoubles(GetVariable('TARGETDIR')) 
  else
    TargetDirCached := '';
  TargetDirExisting := TargetDirCached;
  while not DirectoryExists(TargetDirExisting) do
  begin
    if AssertDir(ExtractFilePath(ExcludeTrailingPathDelimiter(TargetDirExisting))) = TargetDirExisting then Break; 
    TargetDirExisting := AssertDir(ExtractFilePath(ExcludeTrailingPathDelimiter(TargetDirExisting)));
  end;
  if TargetDirExisting <> '' then
  begin
    s := TargetDirCached;
    Delete(s, 1, Length(AssertDir(TargetDirExisting)));
    TargetDirExisting := s;
  end;
end;

procedure TPoolTemplate.CreateParams(var Params: TCreateParams);
begin
  inherited CreateParams(Params);
end;

procedure TPoolTemplate.NewFileSystemReflection;
var
  b: Boolean;
  i: Integer;
begin
  try
    b := BlockUpdates;
    BlockUpdates := True;
    for i := 1 to ComponentCount do
      if Components[i -1].Tag = 100 then
      try
        
        if Components[i -1] is TEdit then
          TEdit(Components[i -1]).Text := ElimDoubles(GetVariable(TEdit(Components[i -1]).Hint));
        if Components[i -1] is TMaskEdit then
          TMaskEdit(Components[i -1]).Text := ElimDoubles(GetVariable(TMaskEdit(Components[i -1]).Hint));
        if Components[i -1] is TShellTreeView then
          if DirectoryExists(ElimDoubles(GetVariable(TShellTreeView(Components[i -1]).Hint))) then
          begin
            TShellTreeView(Components[i -1]).Path := ElimDoubles(GetVariable(TShellTreeView(Components[i -1]).Hint));
            TShellTreeView(Components[i -1]).Selected.Expanded := false;
            TShellTreeView(Components[i -1]).Selected.SelectedIndex := TShellTreeView(Components[i -1]).Selected.SelectedIndex;
            TShellTreeView(Components[i -1]).Selected.Expanded := True;
          end;
      except
        
      end;
  finally
    BlockUpdates := b;
  end;
end;

procedure TPoolTemplate.ReflectComponentInfo;
var
  i, j: Integer;
  s: String;
  st: TStaticText;
  fl: TFileLabel;
begin
  for i := 1 to ComponentCount do
    if (Components[i -1] is TStaticText) then
    begin
      if Components[i -1] is TStaticText then
      begin
        st := TStaticText(Components[i -1]);
        j := st.Tag;
      end;
      s := '$MYAHVOID$';
      if j = 2 then
      begin
        try
          s := SingleLineToMultiLine(GetComponentHint(FCurrentComponent));
        except
          s := ''; 
        end;
      end;
      if j = 3 then
      begin
        try
          s := GetComponentRequiredSpaceEx(FCurrentComponent);
        except
          s := ''; 
        end;
      end;
      if j = 4 then
      begin
        try
          s := GetTotalRequiredSpaceEx;
        except
          s := ''; 
        end;
      end;
      if j = 5 then
      begin
        try
          s := GetTotalSpaceEx;
        except
          s := ''; 
        end;
      end;
      if j = 6 then
      begin
        try
          s := GetDifferenceEx;
        except
          s := ''; 
        end;
      end;
      if s <> '$MYAHVOID$' then
      begin
        if Components[i -1] is TStaticText then
          st.Caption := s;
      end;
    end
    else
    if (Components[i -1] is TFileLabel) then
    begin
      if Components[i -1] is TFileLabel then
      begin
        fl := TFileLabel(Components[i -1]);
        j := fl.Tag;
      end;
      s := '$MYAHVOID$';
      if j = 2 then
      begin
        try
          s := SingleLineToMultiLine(GetComponentHint(FCurrentComponent));
        except
          s := ''; 
        end;
      end;
      if j = 3 then
      begin
        try
          s := GetComponentRequiredSpaceEx(FCurrentComponent);
        except
          s := ''; 
        end;
      end;
      if j = 4 then
      begin
        try
          s := GetTotalRequiredSpaceEx;
        except
          s := ''; 
        end;
      end;
      if j = 5 then
      begin
        try
          s := GetTotalSpaceEx;
        except
          s := ''; 
        end;
      end;
      if j = 6 then
      begin
        try
          s := GetDifferenceEx;
        except
          s := ''; 
        end;
      end;
      if s <> '$MYAHVOID$' then
      begin
        if Components[i -1] is TFileLabel then
          fl.FileName := s;
      end;
    end;
end;

procedure TPoolTemplate.MetaTimerTimer(Sender: TObject);
begin
  MetaTimer.Enabled := False;
end;

procedure TPoolTemplate.FormCanResize(Sender: TObject; var NewWidth,
  NewHeight: Integer; var Resize: Boolean);
begin
  
  Resize := false;
end;

procedure TPoolTemplate.FormCloseQuery(Sender: TObject;
  var CanClose: Boolean);
begin
  {$IFDEF NOCACHE}
  CanClose := True;
  {$ELSE}
  {$IFNDEF STATICFLASH}
  CanClose := FCanClose;
  {$ELSE}
  CanClose := True;
  {$ENDIF}
  {$ENDIF}
  
  if not CanClose then
  begin
    if MessageBox(Handle, PChar(msg22),
      PChar(BrandEx), mb_IconQuestion + mb_YesNo + mb_DefButton2) = id_Yes then
    begin
      SetVariable('MYAH_IsCancelled', 'TRUE', 'ShowDesign') ;
      TButton(Sender).Enabled := false;
      if not FStarted then FModalEx := mrCancel;
    end;
    {$IFDEF NOCACHE}
    if FModalEx <> -1 then
      ModalResult := FModalEx;
    {$ENDIF}
  end;
end;

procedure TPoolTemplate.SmartResolveValue(var Value: String);
var
  valX, valY, ValueX: String;
begin
  ValueX := '$MYAH$'; 
  try
    if AnsiPos('.', Value) <> 0 then
    begin
      valX := Copy(Value, 1, AnsiPos('.', Value) -1);
      valY := Copy(Value, AnsiPos('.', Value) +1, Length(Value));
      try
        ValueX := GetPropertyAsString(valX, valY);
      except
      end;
    end;
  except
  end;
  if ValueX <> '$MYAH$' then 
    Value := ValueX;
end;

procedure TPoolTemplate.RichEdit1Change(Sender: TObject);
begin
end;

procedure TPoolTemplate.Memo1Change(Sender: TObject);
begin
  if BlockUpdates then Exit;
  SureSetVariable(AnsiUpperCase(TMemo(Sender).Hint),
    MultiLineToSingleLine(TMemo(Sender).Text), 'Memo1Change'); 
  ReflectComponentInfo;
  ReflectRules;
end;

procedure TPoolTemplate.RzBmpButton1Click(Sender: TObject);
begin
end;

procedure TPoolTemplate.MaskEdit1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  i: Integer;
begin
  if TMaskEdit(Sender).SelLength = 0 then
  begin
    for i := 1 to ControlCount do
    try
      if TWinControl(Controls[i -1]).TabOrder = TMaskEdit(Sender).TabOrder +1 then
        try
          TWinControl(Controls[i -1]).SetFocus;
        except
        end;
    except
    end;
  end;
end;

procedure TPoolTemplate.TreeView1KeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  p: TPoint;
  s: String;
  t: TTreeView;
begin
  if Key = 93 then 
  begin
    t := TTreeView(Sender);
    if t.Selected = nil then Exit;
    if t.Selected.Data = nil then Exit;
    
    if t.Selected.Data <> nil then
    begin
      
      s := mscriptexec.Components[Integer(t.Selected.Data) -1];
      if GetAnyParentComponentBars(s) then Exit;
    end;
    
    p := t.Selected.DisplayRect(True).BottomRight;
    p := t.ClientToScreen(p);
    PopNode := t.Selected;
    ImageListPool.Popup.Popup(p.X, p.Y);
    
    ReflectComponentInfo;
    ReflectRules;
  end;
end;

end.
