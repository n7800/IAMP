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
unit uDlgAPI;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mUtils, LCLIntf,{$IFNDEF NOGUI}
  LCLType, Forms, uImageListPool, uPool, StdCtrls, ExtCtrls, ComCtrls, ShellCtrls,
  Buttons, CheckLst, MaskEdit, Controls, RunFus, FileLbl{$ELSE}Crt, StrUtils{$ENDIF};

{$IFDEF NOGUI}
type
  
  TPoolTemplate = TStringList;

function AsciiToInt(Ascii: Char): Integer;
function IntToAscii(Number: Integer): Char;
function DeAccelerators(Caption: String): String;
procedure TextComponentsEdit;
procedure TextMemoDisplay(Items: TStringList; pHint, sName, sHint: String);
procedure TextCheckListBoxEdit(Items: TStringList; Variable, pHint, sName: String; MultiSelect: Boolean = True);
{$ENDIF}

procedure DelegateBindProgress(Text: String; Percent, Max, Min: Int64);

procedure InitializeDlgAPI(RootFolder: String; aRDI: Boolean = false);
procedure FinalizeDlgAPI;
function LoadDesign(Name, FileName: String): {$IFDEF NOGUI}TStringList{$ELSE}THandle{$ENDIF};
procedure BindControls(Name: String);
procedure UnBindControls(Name: String);
function ShowDesign(Name: String; var ResultEx: String; Modal, ActivateTask: Boolean): Integer;
procedure HideAllDesigns(ExceptName: String);
procedure HideDesign(Name: String);
function GetActiveDesignName: String;

function FindPool(Name: String; FirstEntrant: Boolean = True): TPoolTemplate;
function BindProgress(Text: String; Percent, Max, Min: Int64; ReportInThCancelled: Boolean = false): Boolean;
function GetTransForDlgItem(Dialog, Item: String): String;

procedure AddReverseEntry(Form, Component, Entry: String); 
function ReverseLookup(Form, Component: String): String;
procedure ClearReverseEntries;

procedure ParseRule(Rule: String; var Reverse: Boolean;
  var SourceControl, SourceProperty, SourceValue,
    TargetControl, TargetProperty, TargetValue: String);

function ElimDoubles(Value: String): String;

function GetTransForScrItem(ItemDefault, ItemGuid: String; ItemOffset: Integer; Caller: String = ''): String;

var
  DeferHideHandle: THandle = 0;
  LastPoolHandle: THandle = 0;

implementation

uses
  mScriptExec;

var
  {$IFNDEF NOGUI}
  rdi: TRFInspector;
  {$ELSE}
  rdi: TStringList;
  {$ENDIF}
  LastPool: TPoolTemplate = nil;
  DlgRootFolder: String;
  FirstShow: Boolean;
  Pools, StuntedPools: TStringList;
  ActiveName: String;
  ReverseList: TStringList;
  SmartPosLeft, SmartPosTop: Integer;
  SmartPosWidth, SmartPosHeight: Integer;

procedure DelegateBindProgress(Text: String; Percent, Max, Min: Int64);
begin
  {$IFDEF USEVARMANAGER}
  VarManager['MYAH_LastDelegateTick'] := IntToStr(GetTickCount);
  {$ELSE}
  SETVARIABLE('MYAH_LastDelegateTick', IntToStr(GetTickCount),'');
  {$ENDIF}
  if Text = '$MYAH$' then 
  begin
    {$IFDEF USEVARMANAGER}
    Text := VarManager['MYAH_thProgressText'];
    Percent := StrToInt64(VarManager['MYAH_thProgress']);
    Max := StrToInt64(VarManager['MYAH_thMax']);
    Min := StrToInt64(VarManager['MYAH_thMin']);
    {$ELSE}
    Text := GETVARIABLE('MYAH_thProgressText');
    Percent := StrToInt64(GETVARIABLE('MYAH_thProgress'));
    Max := StrToInt64(GETVARIABLE('MYAH_thMax'));
    Min := StrToInt64(GETVARIABLE('MYAH_thMin'));
    {$ENDIF}
  end;
  if Percent <> -1 then 
  begin
    {$IFDEF USEVARMANAGER}
    VarManager['MYAH_thMax'] := IntToStr(Max);
    VarManager['MYAH_thMin'] := IntToStr(Min);
    VarManager['MYAH_thProgress'] := IntToStr(Percent);
    {$ELSE}
    SETVARIABLE('MYAH_thMax', IntToStr(Max),'');
    SETVARIABLE('MYAH_thMin', IntToStr(Min),'');
    SETVARIABLE('MYAH_thProgress', IntToStr(Percent),'');
    {$ENDIF}
  end;
  {$IFDEF USEVARMANAGER}
  if Text <> '$IGNORE$' then 
    VarManager['MYAH_thProgressText']:= Text;
  {$ELSE}
  if Text <> '$IGNORE$' then 
    SETVARIABLE('MYAH_thProgressText', Text,'');
  {$ENDIF}
  {$IFDEF NOGUI}
  
  BindProgress(GetVariable('MYAH_thProgressText'), StrToIntDef(GetVariable('MYAH_thProgress'), 0),
    StrToIntDef(GetVariable('MYAH_thMax'), 0), StrToIntDef(GetVariable('MYAH_thMin'), 0), false);
  {$ENDIF}
end;

{$IFDEF NOGUI}
procedure TextMemoDisplay(Items: TStringList; pHint, sName, sHint: String);
var
  s: String;
  i: Integer;
  l: TStringList;
begin
  l := TStringList.Create;
  
  if (ActivatedLanguage = '') or (GetTransForDlgItem(pHint, sName) = '') then
    l.Text :=
      MemoMultiToDefaultMultiLineAdapter(SubstituteVariables(Items.Text))
  else
    l.Text := MemoMultiToDefaultMultiLineAdapter(SubstituteVariables(
      GetTransForDlgItem(pHint, sName)));
  for i := 1 to l.Count do
    WriteLn(l[i -1]);
  if sHint <> '' then
  begin
    WriteLn(sName + '? (' + GetVariable(sHint) + ')');
    ReadLn(s);
    if s <> '' then
      SureSetVariable(sHint, s, 'TextMemoDisplay');
  end;
  l.Free;
end;

procedure TextCheckListBoxEdit(Items: TStringList; Variable, pHint, sName: String; MultiSelect: Boolean = True);
var
  c: Char;
  s, sX: String;
  i, j: Integer;
  l, lX: TStringList;
begin
  l := TStringList.Create;
  lX := TStringList.Create;
  
  if (ActivatedLanguage = '') or (GetTransForDlgItem(pHint, sName) = '') then
    l.Text :=
      MemoMultiToDefaultMultiLineAdapter(SubstituteVariables(Items.Text))
  else
    l.Text := MemoMultiToDefaultMultiLineAdapter(SubstituteVariables(
      GetTransForDlgItem(pHint, sName)));
  sX := StringReplace(GetVariable(Variable), '$NEWLINE$', LineEnding, [rfReplaceAll, rfIgnoreCase]); 
  if Length(sX) >= Length(LineEnding) then
    if RPos(LineEnding, sX) = Length(sX) - Length(LineEnding) +1 then
      Delete(sX, RPos(LineEnding, sX), Length(LineEnding));
  lX.Text := sX;
  for i := l.Count downto 1 do
    if (l[i -1] = '') or (l[i -1] = LineEnding) then
      l.Delete(i -1); 
  for i := lX.Count downto 1 do
    if (lX[i -1] = '') or (lX[i -1] = LineEnding) then
      lX.Delete(i -1); 
  repeat
    WriteLn('0. ' + StringReplace(dlg15, '&', '', [rfReplaceAll, rfIgnoreCase]));
    for i := 1 to l.Count do
    begin
      s := l[i -1];
      Write(IntToAscii(i) + '. ');
      
      Write('[');
      if lX.IndexOf(s) <> -1 then
        {$IFDEF WINDOWS}
        Write('X')
        {$ELSE}
        Write('×')
        {$ENDIF}
        
      else
        Write(' ');
      Write('] ');
      WriteLn(s);
    end;
    if l.Count > 0 then
    begin
      
      c := ReadKey;
      if (c = #13) or (c = #27) then
        i := 0
      else
        i := AsciiToInt(c);
      if i <> -1 then
        if (i >= 0) and (i <= l.Count) then
        begin
          if i = 0 then
          begin
            sX := lX.Text;
            
            if Length(sX) >= Length(LineEnding) then
              if RPos(LineEnding, sX) = Length(sX) - Length(LineEnding) +1 then
                Delete(sX, RPos(LineEnding, sX), Length(LineEnding));
            SureSetVariable(Variable,
              StringReplace(sX, LineEnding, '$NEWLINE$', [rfReplaceAll, rfIgnoreCase]),
              'Text Mode T(Check)ListBox Selection');
            Break;
          end
          else
          begin
            if MultiSelect then
            begin
              if lX.Count = 0 then
                lX.Add(l[i -1])
              else
                for j := lX.Count downto 1 do
                  if AnsiCompareText(l[i -1], lX[j -1]) = 0 then
                  begin
                    lX.Delete(j -1);
                    Break;
                  end
                  else
                    if j = 1 then
                      lX.Add(l[i -1]);
            end
            else
            begin
              if lX.Count = 0 then
                lX.Add(l[i -1])
              else
                if lX.IndexOf(l[i -1]) = -1 then
                begin
                  lX.Clear;
                  lX.Add(l[i -1]);
                end
                else
                  lX.Clear;
            end;
          end;
        end;
    end
    else
    begin
      SureSetVariable(Variable, '', 'Text Mode T(Check)[List/Combo]Box Selection');
      Break;
    end;
  until false;
  l.Free;
  lX.Free;
end;

function AsciiToInt(Ascii: Char): Integer;
begin
  Result := StrToIntDef(Ascii, -1);
  if Result = -1 then
  begin
    
    Ascii := LowerCase(Ascii);
    
    Result := 10 + Ord(Ascii) - Ord('a');
  end;
end;

function IntToAscii(Number: Integer): Char;
begin
  if Number < 10 then
    Result := IntToStr(Number)[1]
  else
    Result := Chr(Ord('a') + (Number -10));
end;

function DeAccelerators(Caption: String): String;
begin
  Result := StringReplace(Caption, '&&', '$MYAH_AMPERSAND$', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '&', '', [rfReplaceAll, rfIgnoreCase]);
  Result := StringReplace(Result, '$MYAH_AMPERSAND$', '&&', [rfReplaceAll, rfIgnoreCase]);
end;

procedure TextComponentsEdit;
var
  c, cX: Char;
  s, sX, sY: String;
  i, j: Integer;
  l: TStringList;
begin
  l := TStringList.Create;
  repeat
    l.Clear;
    for i := 1 to Components.Count do
    begin
      s := Components[i -1];
      if AnsiCompareText('MYAH-PREDEF-COMPONENT', s) = 0 then Continue;
      if GetComponentDelete(s) or GetAnyParentComponentHide(s) then Continue;
      l.Add(s);
      if l.Count = 1 then
        WriteLn('0. ' + StringReplace(dlg15, '&', '', [rfReplaceAll, rfIgnoreCase]));
      Write(IntToAscii(l.Count) + '. ');
      
      Write('[');
      if GetAnyParentComponentBars(s) then
        {$IFDEF WINDOWS}
        Write('O')
        {$ELSE}
        Write('∙')
        {$ENDIF}
      else
      begin
        if GetSelection(s) then
          {$IFDEF WINDOWS}
          Write('X')
          {$ELSE}
          Write('■')
          {$ENDIF}
        else
          Write(' ');
      end;
      Write('] ');
      for j := 1 to OccurrencesOfChar(s, '\') do
        if j = OccurrencesOfChar(s, '\') then
        begin
          if i = Components.Count then
            {$IFDEF WINDOWS}
            Write('`-')
            {$ELSE}
            Write('└─')
            {$ENDIF}
          else
            if ((OccurrencesOfChar(s, '\') > OccurrencesOfChar(Components[i], '\')) or
              ((i +1) = Components.Count) and
                (OccurrencesOfChar(s, '\') < OccurrencesOfChar(Components[i], '\'))) then
              {$IFDEF WINDOWS}
              Write('`-')
              {$ELSE}
              Write('└─')
              {$ENDIF}
            else
              {$IFDEF WINDOWS}
              Write('|-')
              {$ELSE}
              
              Write('├─');
              {$ENDIF}
        end
        else
          if i = Components.Count then
            Write('  ')
          else
            {$IFDEF WINDOWS}
            Write('| ');
            {$ELSE}
            Write('│ ');
            {$ENDIF}
      WriteLn(ExtractFileName(s) + ' (' + GetComponentRequiredSpaceEx(s) + ')');
    end;
    if l.Count > 0 then
    begin
      
      cX := ReadKey;
      if (cX = #13) or (cX = #27) then
        i := 0
      else
        i := AsciiToInt(cX);
      if i <> -1 then
        if (i >= 0) and (i <= l.Count) then
        begin
          if i = 0 then Break;
          s := l[i -1];
          WriteLn(MemoMultiToDefaultMultiLineAdapter(SingleLineToMultiLine(GetComponentHint(s))));
          if not GetAnyParentComponentBars(s) then
          begin
            WriteLn('0. ' + StringReplace(dlg16, '&', '', [rfReplaceAll, rfIgnoreCase]));
            WriteLn('1. ' + StringReplace(dlg26, '&', '', [rfReplaceAll, rfIgnoreCase]));
            WriteLn('2. ' + StringReplace(dlg27, '&', '', [rfReplaceAll, rfIgnoreCase]));
            WriteLn('3. ' + StringReplace(dlg28, '&', '', [rfReplaceAll, rfIgnoreCase]));
            repeat
              c := ReadKey;
              if (c = #13) or (c = #27) then
                c := '0';
            until ((c = '0') or (c = '3')) or ((c = '1') or (c = '2'));
            if (c = '2') or (c = '3') then
              for j := 1 to l.Count do
                if AnsiPos(s, l[j -1]) = 1 then
                  if not GetAnyParentComponentBars(l[j -1]) then
                    SetSelection(l[j -1], c = '2');
            if (c = '1') or (c = '2') then
            repeat
              SetSelection(s, True);
              s := DeAssertDir(ExtractFilePath(s));
            until s = '';
            WriteLn;
          end;
        end;
    end
    else
      Break;
  until false;
  l.Free;
end;
{$ENDIF}

procedure InitializeDlgAPI(RootFolder: String; aRDI: Boolean = false);
begin
  {$IFNDEF NOGUI}
  Application.ShowMainForm := false;
  {$ENDIF}
  DlgRootFolder := RootFolder;
  {$IFNDEF NOGUI}
  poolDlgRootFolder := IncludeTrailingPathDelimiter(DlgRootFolder);
  {$ENDIF}
  FirstShow := True;
  {$IFNDEF NOGUI}
  ImageListPool := TImageListPool.Create(nil);
  {$ENDIF}
  Pools := TStringList.Create;
  StuntedPools := TStringList.Create;
  ActiveName := '';
  SetVariable('MYAH_IsCancelled', 'FALSE', 'ShowDesign') ;
  {$IFNDEF NOGUI}
  if ardi then
  begin
    rdi := TRFInspector.Create(nil);
    
    RegisterClasses([TLabel,TEdit,TMemo,TButton,TListBox,TCheckBox,TRadioButton,
      TComboBox,TGroupBox,TPanel,TBitBtn,TSpeedButton,TMaskEdit,TImage,TShape,
      TBevel,TStaticText,TFileLabel,TTrackBar,TProgressBar,TUpDown,TCheckListBox,
      TTreeView,TShellTreeView,TScrollBox]);
  end
  else
    rdi := nil;
  {$ENDIF}
end;

procedure FinalizeDlgAPI;
var
  i, j: Integer;
  frmDesign: TPoolTemplate;
begin
  {$IFNDEF NOGUI}
  if Assigned(rdi) then
    rdi.Free;
  {$ELSE}
    rdi.Clear;
  {$ENDIF}
  for i := 1 to Pools.Count do
  {$IFDEF INTEROP}
    if Assigned(Pools.Objects[i -1]) then
    begin
      TPoolTemplate(Pools.Objects[i -1]).Free;
      Pools.Objects[i -1] := nil;
    end;
  {$ELSE}
  begin
    UnbindControls(Pools[i -1]);
    frmDesign := TPoolTemplate(Pools.Objects[i -1]);
    for j := frmDesign.ComponentCount downto 1 do
      frmDesign.Components[j -1].Destroy;
    if frmDesign.Visible then
    begin
      frmDesign.FCanClose := True;
      frmDesign.Hide;
    end;
  end;
  {$ENDIF}
  StuntedPools.Free;
  Pools.Free;
  {$IFNDEF NOGUI}
  PoolTemplate.Free;
  ImageListPool.Free;
  {$ENDIF}
  ClearReverseEntries;
end;

function LoadDesign(Name, FileName: String): {$IFDEF NOGUI}TStringList{$ELSE}THandle{$ENDIF};
var
  s: String;
  i: Integer;
  Index: Integer;
  l: TStringList;
  Instance: TPoolTemplate;
  frmDesign: TPoolTemplate;
  MainHandle: THandle;
begin
  
  GetDir(0, s);
  ChDir(ExtractFilePath(FileName));
  {$IFNDEF NOGUI}
  Result := 0;
  {$ELSE}
  Result := nil;
  
  if rdi.IndexOf(Name) = -1 then
  begin
    rdi.Add(Name);
    rdi.Add(FileName);
  end;
  {$ENDIF}
  
  Index := Pools.IndexOf(AnsiUpperCase(Name));
  if Index <> -1 then
  begin
    {$IFNDEF NOGUI}
    {$IFDEF INTEROP}
    ShowWindow(TPoolTemplate(Pools.Objects[Index]).Handle, SW_HIDE);
    TPoolTemplate(Pools.Objects[Index]).Free;
    Pools.Objects[Index] := nil;
    Application.ProcessMessages;
    {$ELSE}
    UnbindControls(Name);
    frmDesign := TPoolTemplate(Pools.Objects[Index]);
    for i := frmDesign.ComponentCount downto 1 do
      frmDesign.Components[i -1].Destroy;
    {$ENDIF}
    {$ENDIF}
  end
  else
    Index := Pools.Add(AnsiUpperCase(Name));
  try
    
    {$IFNDEF NOGUI}
    Instance := TPoolTemplate.CreateEx(FileName);
    {$ELSE}
    Instance := TStringList.Create; 
    {$ENDIF}
  except
    on E: Exception do
    begin
      
      {$IFNDEF NOGUI}
      Result := INVALID_HANDLE_VALUE;
      {$ELSE}
      Result := nil;
      {$ENDIF}
      Pools.Objects[Index] := nil;
      StuntedPools.Add(IntToStr(Index));
      StuntedPools.Add(FileName);
      ChDir(s);
      Exit;
    end;
  end;
  
  StuntedPools.Add(IntToStr(Index)); 
  StuntedPools.Add(FileName);
  Pools.Objects[Index] := Instance;
  l := TStringList.Create;
  l.LoadFromFile(FileName + '.miaf', TEncoding.UTF8); 
  {$IFNDEF NOGUI}
  Instance.Rules := l.CommaText;
  {$ENDIF}
  l.Free;
  {$IFNDEF NOGUI}
  Result := Instance.Handle;
  {$ELSE}
  Result := Instance;
  {$ENDIF}
  ChDir(s);
end;

procedure BindControls(Name: String);
var
  s: String;
  i, j, k, iX: Integer;
  l: TStringList;
  Cache: TStringList;
  Pool: TPoolTemplate;
  ResolvedTargetDir: String;
  ChangeSelections: TList;
  bmi: Boolean;
  
begin
  {$IFNDEF NOGUI}
  if SilentInstall then Exit;
  ClearReverseEntries;
  ResolvedTargetDir := ElimDoubles(ResolveVariable('$TARGETDIR$')); 
  while not DirectoryExists(ResolvedTargetDir) do
  begin
    if IncludeTrailingPathDelimiter(ExtractFilePath(ExcludeTrailingPathDelimiter(ResolvedTargetDir))) = ResolvedTargetDir then Break; 
    ResolvedTargetDir := IncludeTrailingPathDelimiter(ExtractFilePath(ExcludeTrailingPathDelimiter(ResolvedTargetDir)));
  end;
  Pool := FindPool(Name);
  BlockUpdates := True;
  
  Cache := TStringList.Create;
  for i := 1 to Pool.ComponentCount do
    if Pool.Components[i -1].Name <> 'cmpFormDesigner' then 
      Cache.AddObject(Pool.Components[i -1].Name, Pool.Components[i -1]);
  Cache.AddObject(Pool.Name, Pool);
  ChangeSelections := TList.Create;
  
  for i := 1 to Cache.Count do
  begin
    if Cache.Objects[i -1] is TForm then
    begin
      AddReverseEntry(Pool.Hint, Pool.Hint, TForm(Cache.Objects[i -1]).Caption);
      TForm(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, Pool.Hint);
      if ActivatedLanguage = '' then
        TForm(Cache.Objects[i -1]).Caption := SubstituteVariables(TForm(Cache.Objects[i -1]).Caption)
      else
        TForm(Cache.Objects[i -1]).Caption := SubstituteVariables(
          GetTransForDlgItem(Pool.Hint, Pool.Hint)); 
      if NoBrand then
      begin
        if AnsiPos(BrandEy, TForm(Cache.Objects[i -1]).Caption) <> 0 then
        begin
          s := TForm(Cache.Objects[i -1]).Caption;
          Delete(s, AnsiPos(BrandEy, s), Length(BrandEy));
          TForm(Cache.Objects[i -1]).Caption := s;
        end;
      end
      else
        if AnsiPos(BrandEy, TForm(Cache.Objects[i -1]).Caption) = 0 then
          
            TForm(Cache.Objects[i -1]).Caption := TForm(Cache.Objects[i -1]).Caption + BrandEy;
    end;
    
    if Cache.Objects[i -1] is TLabel then
    begin
      
      TLabel(Cache.Objects[i -1]).OnClick := @Pool.Label1Click;
      
      AddReverseEntry(Pool.Hint, TLabel(Cache.Objects[i -1]).Name,
        TLabel(Cache.Objects[i -1]).Caption);
      TLabel(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TLabel(Cache.Objects[i -1]).Name);
      
      if ActivatedLanguage = '' then
        TLabel(Cache.Objects[i -1]).Caption := SubstituteVariables(TLabel(Cache.Objects[i -1]).Caption)
      else
        TLabel(Cache.Objects[i -1]).Caption := SubstituteVariables(
          GetTransForDlgItem(Pool.Hint, TLabel(Cache.Objects[i -1]).Name));
    end;
    if Cache.Objects[i -1] is TStaticText then
    begin
      
      AddReverseEntry(Pool.Hint, TStaticText(Cache.Objects[i -1]).Name,
        TStaticText(Cache.Objects[i -1]).Caption);
      TStaticText(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TStaticText(Cache.Objects[i -1]).Name);
      if ActivatedLanguage = '' then
        TStaticText(Cache.Objects[i -1]).Caption := SubstituteVariables(TStaticText(Cache.Objects[i -1]).Caption)
      else
        TStaticText(Cache.Objects[i -1]).Caption := SubstituteVariables(
          GetTransForDlgItem(Pool.Hint, TStaticText(Cache.Objects[i -1]).Name));
      if TStaticText(Cache.Objects[i -1]).Tag = 1 then
        TStaticText(Cache.Objects[i -1]).Caption := ResolveVariable('$PROGRESSTEXT$'); 
    end;
    if Cache.Objects[i -1] is TFileLabel then
    begin
      
      AddReverseEntry(Pool.Hint, TFileLabel(Cache.Objects[i -1]).Name,
        TFileLabel(Cache.Objects[i -1]).FileName);
      TFileLabel(Cache.Objects[i -1]).FileName := ReverseLookup(Pool.Hint, TFileLabel(Cache.Objects[i -1]).Name);
      if ActivatedLanguage = '' then
        TFileLabel(Cache.Objects[i -1]).FileName := SubstituteVariables(TFileLabel(Cache.Objects[i -1]).FileName)
      else
        TFileLabel(Cache.Objects[i -1]).FileName := SubstituteVariables(
          GetTransForDlgItem(Pool.Hint, TFileLabel(Cache.Objects[i -1]).Name));
      if TFileLabel(Cache.Objects[i -1]).Tag = 1 then
        TFileLabel(Cache.Objects[i -1]).FileName := ResolveVariable('$PROGRESSTEXT$'); 
    end;
    if Cache.Objects[i -1] is TPanel then
    begin
      
      AddReverseEntry(Pool.Hint, TPanel(Cache.Objects[i -1]).Name,
        TPanel(Cache.Objects[i -1]).Caption);
      TPanel(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TPanel(Cache.Objects[i -1]).Name);
      if ActivatedLanguage = '' then
        TPanel(Cache.Objects[i -1]).Caption := SubstituteVariables(TPanel(Cache.Objects[i -1]).Caption)
      else
        TPanel(Cache.Objects[i -1]).Caption := SubstituteVariables(
          GetTransForDlgItem(Pool.Hint, TPanel(Cache.Objects[i -1]).Name));
    end;
    if Cache.Objects[i -1] is TGroupBox then
    begin
      
      AddReverseEntry(Pool.Hint, TGroupBox(Cache.Objects[i -1]).Name,
        TGroupBox(Cache.Objects[i -1]).Caption);
      TGroupBox(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TGroupBox(Cache.Objects[i -1]).Name);
      if ActivatedLanguage = '' then
        TGroupBox(Cache.Objects[i -1]).Caption := SubstituteVariables(TGroupBox(Cache.Objects[i -1]).Caption)
      else
        TGroupBox(Cache.Objects[i -1]).Caption := SubstituteVariables(
          GetTransForDlgItem(Pool.Hint, TGroupBox(Cache.Objects[i -1]).Name));
    end;
    if Cache.Objects[i -1] is TProgressBar then
    begin
      TProgressBar(Cache.Objects[i -1]).DoubleBuffered := false or (AnsiCompareText(RuntimeSubstituteCompilerVariables('#FORCE_DOUBLEBUFFER#'), 'True') = 0);
      if TProgressBar(Cache.Objects[i -1]).Tag = 1 then
        if ResolveVariable('$PROGRESS$') <> '' then 
        begin
          
          try
            if StrToInt(ResolveVariable('$PROGRESS$')) > 100 then TProgressBar(Cache.Objects[i -1]).Position := 100 
              else if StrToInt(ResolveVariable('$PROGRESS$')) < 0 then TProgressBar(Cache.Objects[i -1]).Position := 0 
                else TProgressBar(Cache.Objects[i -1]).Position := StrToInt(ResolveVariable('$PROGRESS$')); 
          except
            TProgressBar(Cache.Objects[i -1]).Position := 100;
          end;
        end;
    end;
    if Cache.Objects[i -1] is TTrackBar then
    begin
      TTrackBar(Cache.Objects[i -1]).OnChange := @Pool.TrackBar1Change;
      if TTrackBar(Cache.Objects[i -1]).Hint <> '' then
        if ResolveVariableEx(TTrackBar(Cache.Objects[i -1]).Hint) <> '$MYAHNX$' then 
          TTrackBar(Cache.Objects[i -1]).Position := StrToInt(ResolveVariable(TTrackBar(Cache.Objects[i -1]).Hint));
    end;
    if Cache.Objects[i -1] is TButton then
    begin
        
      TButton(Cache.Objects[i -1]).OnClick := @Pool.Button1Click;
      AddReverseEntry(Pool.Hint, TButton(Cache.Objects[i -1]).Name,
        TButton(Cache.Objects[i -1]).Caption);
      TButton(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TButton(Cache.Objects[i -1]).Name);
      if ActivatedLanguage = '' then
        TButton(Cache.Objects[i -1]).Caption := SubstituteVariables(TButton(Cache.Objects[i -1]).Caption)
      else
        TButton(Cache.Objects[i -1]).Caption := SubstituteVariables(
          GetTransForDlgItem(Pool.Hint, TButton(Cache.Objects[i -1]).Name));
    end;
    if Cache.Objects[i -1] is TTabSheet then
    begin
      AddReverseEntry(Pool.Hint, TTabSheet(Cache.Objects[i -1]).Name,
        TTabSheet(Cache.Objects[i -1]).Caption);
      TTabSheet(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TTabSheet(Cache.Objects[i -1]).Name);
      if ActivatedLanguage = '' then
        TTabSheet(Cache.Objects[i -1]).Caption := SubstituteVariables(TTabSheet(Cache.Objects[i -1]).Caption)
      else
        TTabSheet(Cache.Objects[i -1]).Caption := SubstituteVariables(
          GetTransForDlgItem(Pool.Hint, TTabSheet(Cache.Objects[i -1]).Name));
    end;
    if Cache.Objects[i -1] is TSpeedButton then
    begin
      
      TSpeedButton(Cache.Objects[i -1]).OnClick := @Pool.SpeedButton1Click;
      AddReverseEntry(Pool.Hint, TSpeedButton(Cache.Objects[i -1]).Name,
        TSpeedButton(Cache.Objects[i -1]).Caption);
      TSpeedButton(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TSpeedButton(Cache.Objects[i -1]).Name);
      if ActivatedLanguage = '' then
        TSpeedButton(Cache.Objects[i -1]).Caption := SubstituteVariables(TSpeedButton(Cache.Objects[i -1]).Caption)
      else
        TSpeedButton(Cache.Objects[i -1]).Caption := SubstituteVariables(
          GetTransForDlgItem(Pool.Hint, TSpeedButton(Cache.Objects[i -1]).Name));
    end;
    if Cache.Objects[i -1] is TBitBtn then
    begin
      
      TBitBtn(Cache.Objects[i -1]).OnClick := @Pool.BitBtn1Click;
      AddReverseEntry(Pool.Hint, TBitBtn(Cache.Objects[i -1]).Name,
        TBitBtn(Cache.Objects[i -1]).Caption);
      TBitBtn(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TBitBtn(Cache.Objects[i -1]).Name);
      if ActivatedLanguage = '' then
        TBitBtn(Cache.Objects[i -1]).Caption := SubstituteVariables(TBitBtn(Cache.Objects[i -1]).Caption)
      else
        TBitBtn(Cache.Objects[i -1]).Caption := SubstituteVariables(
          GetTransForDlgItem(Pool.Hint, TBitBtn(Cache.Objects[i -1]).Name));
    end;
    if Cache.Objects[i -1] is TImage then
    begin
      
      TImage(Cache.Objects[i -1]).OnClick := @Pool.Image1Click;
      if MyFileExists(SubstituteVariables('$' + TImage(Cache.Objects[i -1]).Name + '$')) then
        TImage(Cache.Objects[i -1]).Picture.LoadFromFile(SubstituteVariables('$' + TImage(Cache.Objects[i -1]).Name + '$'));
    end;
    if Cache.Objects[i -1] is TShape then
    begin
      TShape(Cache.Objects[i -1]).OnMouseUp := @Pool.Shape1MouseUp;
    end;
    if Cache.Objects[i -1] is TMemo then
    begin
      bmi := TMemo(Cache.Objects[i -1]).MaxLength = MAXINT; 
      
      AddReverseEntry(Pool.Hint, TMemo(Cache.Objects[i -1]).Name,
        TMemo(Cache.Objects[i -1]).Text);
      TMemo(Cache.Objects[i -1]).Text := ReverseLookup(Pool.Hint, TMemo(Cache.Objects[i -1]).Name);
      TMemo(Cache.Objects[i -1]).ReadOnly := TMemo(Cache.Objects[i -1]).Hint = '';
      if TMemo(Cache.Objects[i -1]).Hint <> '' then
        TMemo(Cache.Objects[i -1]).OnChange := @Pool.Memo1Change;
      if (TMemo(Cache.Objects[i -1]).Tag = 1) or (TMemo(Cache.Objects[i -1]).Tag = 2) then
        if TMemo(Cache.Objects[i -1]).MaxLength < 1024 * 1024 then 
          TMemo(Cache.Objects[i -1]).MaxLength := 1024 * 1024; 
      if bmi then TMemo(Cache.Objects[i -1]).MaxLength := MAXINT;
      if TMemo(Cache.Objects[i -1]).Hint <> '' then
      begin
        if ResolveVariableEx(TMemo(Cache.Objects[i -1]).Hint) <> '$MYAHNX$' then 
          TMemo(Cache.Objects[i -1]).Text := ElimDoubles(ResolveVariable(TMemo(Cache.Objects[i -1]).Hint));
      end
      else
        TMemo(Cache.Objects[i -1]).Text := SubstituteVariables(TMemo(Cache.Objects[i -1]).Text);
      
      begin
        if TMemo(Cache.Objects[i -1]).Tag = 1 then
          if MyFileExists(DlgRootFolder + 'readme.' + ActivatedLanguage + '.txt') then 
            TMemo(Cache.Objects[i -1]).Lines.LoadFromFile(DlgRootFolder + 'readme.' + ActivatedLanguage + '.txt') 
          else
            if MyFileExists(DlgRootFolder + 'readme.txt') then 
              TMemo(Cache.Objects[i -1]).Lines.LoadFromFile(DlgRootFolder + 'readme.txt') 
            else
            begin
              TMemo(Cache.Objects[i -1]).Lines.Clear;
              TMemo(Cache.Objects[i -1]).Lines.Add(SAddAReadme + ActivatedLanguage + STxtOrReadmeTxtFileToYourProjectA);
            end;
        if TMemo(Cache.Objects[i -1]).Tag = 2 then
          if MyFileExists(DlgRootFolder + 'license.' + ActivatedLanguage + '.txt') then 
            TMemo(Cache.Objects[i -1]).Lines.LoadFromFile(DlgRootFolder + 'license.' + ActivatedLanguage + '.txt') 
          else
            if MyFileExists(DlgRootFolder + 'license.txt') then 
              TMemo(Cache.Objects[i -1]).Lines.LoadFromFile(DlgRootFolder + 'license.txt') 
            else
            begin
              TMemo(Cache.Objects[i -1]).Lines.Clear;
              TMemo(Cache.Objects[i -1]).Lines.Add(SAddALicense + ActivatedLanguage + STxtOrLicenseTxtFileToYourProject);
            end;
      end;
      
      TMemo(Cache.Objects[i -1]).ScrollBars := ssAutoBoth;
    end;
    if Cache.Objects[i -1] is TCheckBox then
    begin
      TCheckBox(Cache.Objects[i -1]).OnClick := @Pool.CheckBox1Click;
      if TCheckBox(Cache.Objects[i -1]).Hint <> '' then
      begin
        if ResolveVariableEx(TCheckBox(Cache.Objects[i -1]).Hint) <> '$MYAHNX$' then 
          TCheckBox(Cache.Objects[i -1]).Checked := StrToBool(ResolveVariable(TCheckBox(Cache.Objects[i -1]).Hint));
      end;
      AddReverseEntry(Pool.Hint, TCheckBox(Cache.Objects[i -1]).Name,
        TCheckBox(Cache.Objects[i -1]).Caption);
      TCheckBox(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TCheckBox(Cache.Objects[i -1]).Name);
      if ActivatedLanguage = '' then
        TCheckBox(Cache.Objects[i -1]).Caption := SubstituteVariables(TCheckBox(Cache.Objects[i -1]).Caption)
      else
        TCheckBox(Cache.Objects[i -1]).Caption := SubstituteVariables(
          GetTransForDlgItem(Pool.Hint, TCheckBox(Cache.Objects[i -1]).Name));
    end;
    if Cache.Objects[i -1] is TRadioButton then
    begin
      
      TRadioButton(Cache.Objects[i -1]).OnClick := @Pool.RadioButton1Click;
      if TRadioButton(Cache.Objects[i -1]).Hint <> '' then
      begin
        if ResolveVariableEx(TRadioButton(Cache.Objects[i -1]).Hint) <> '$MYAHNX$' then 
          TRadioButton(Cache.Objects[i -1]).Checked := StrToBool(ResolveVariable(TRadioButton(Cache.Objects[i -1]).Hint));
      end;
      AddReverseEntry(Pool.Hint, TRadioButton(Cache.Objects[i -1]).Name,
        TRadioButton(Cache.Objects[i -1]).Caption);
      TRadioButton(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TRadioButton(Cache.Objects[i -1]).Name);
      if ActivatedLanguage = '' then
        TRadioButton(Cache.Objects[i -1]).Caption := SubstituteVariables(TRadioButton(Cache.Objects[i -1]).Caption)
      else
        TRadioButton(Cache.Objects[i -1]).Caption := SubstituteVariables(
          GetTransForDlgItem(Pool.Hint, TRadioButton(Cache.Objects[i -1]).Name));
    end;
    if Cache.Objects[i -1] is TListBox then
    begin
      
      AddReverseEntry(Pool.Hint, TListBox(Cache.Objects[i -1]).Name, TListBox(Cache.Objects[i -1]).Items.Text);
      TListBox(Cache.Objects[i -1]).Items.Text := ReverseLookup(Pool.Hint, TListBox(Cache.Objects[i -1]).Name);
      if ActivatedLanguage = '' then
        TListBox(Cache.Objects[i -1]).Items.Text :=
          MemoMultiToDefaultMultiLineAdapter(SubstituteVariables(TListBox(Cache.Objects[i -1]).Items.Text))
      else
        TListBox(Cache.Objects[i -1]).Items.Text := MemoMultiToDefaultMultiLineAdapter(SubstituteVariables(
          GetTransForDlgItem(Pool.Hint, TListBox(Cache.Objects[i -1]).Name)));
      for iX := TListBox(Cache.Objects[i -1]).Items.Count downto 1 do
        if TListBox(Cache.Objects[i -1]).Items[iX -1] = '' then
          TListBox(Cache.Objects[i -1]).Items.Delete(iX -1);
      
      TListBox(Cache.Objects[i -1]).OnClick := @Pool.ListBox1Click;
      if TListBox(Cache.Objects[i -1]).Hint <> '' then
      begin
        
        begin
          l := TStringList.Create;
          l.Text := MemoMultiToDefaultMultiLineAdapter(ResolveVariable(TListBox(Cache.Objects[i -1]).Hint));
          for iX := 1 to l.Count do
            if TListBox(Cache.Objects[i -1]).Items.IndexOf(l[iX -1]) <> -1 then
              TListBox(Cache.Objects[i -1]).Selected[
                TListBox(Cache.Objects[i -1]).Items.IndexOf(l[iX -1])] := True;
          l.Free;
        end;
      end;
    end;
    if Cache.Objects[i -1] is TTreeView then
    begin
      
      TTreeView(Cache.Objects[i -1]).HideSelection := false;
      TTreeView(Cache.Objects[i -1]).OnChange := @Pool.TreeView1Change;
      TTreeView(Cache.Objects[i -1]).ReadOnly := True;
      for j := 1 to TTreeView(Cache.Objects[i -1]).Items.Count do
        TTreeView(Cache.Objects[i -1]).Items[j -1].Text := SubstituteVariables(TTreeView(Cache.Objects[i -1]).Items[j -1].Text);
      if TTreeView(Cache.Objects[i -1]).Tag = 1 then
      begin
        TTreeView(Cache.Objects[i -1]).Images := ImageListPool.ImageList;
        TTreeView(Cache.Objects[i -1]).StateImages := ImageListPool.ImageList;
        GetComponentsTree(TTreeView(Cache.Objects[i -1]));
        for j := 1 to TTreeView(Cache.Objects[i -1]).Items.Count do
          TTreeView(Cache.Objects[i -1]).Items[j -1].Expand(True);
        if TTreeView(Cache.Objects[i -1]).Items.Count > 0 then
          TTreeView(Cache.Objects[i -1]).Selected := TTreeView(Cache.Objects[i -1]).Items[0];
        TTreeView(Cache.Objects[i -1]).OnMouseUp := @Pool.TreeView1MouseUp;
        TTreeView(Cache.Objects[i -1]).OnKeyUp := @Pool.TreeView1KeyUp;
      end;
      ChangeSelections.Add(Cache.Objects[i -1]);
      
    end;
    if Cache.Objects[i -1] is TShellTreeView then
    begin
      
      TShellTreeView(Cache.Objects[i -1]).DoubleBuffered := false or (AnsiCompareText(RuntimeSubstituteCompilerVariables('#FORCE_DOUBLEBUFFER#'), 'True') = 0);
      TShellTreeView(Cache.Objects[i -1]).HideSelection := false;
      TShellTreeView(Cache.Objects[i -1]).OnChange := @Pool.ShellTreeView1Change;
      TShellTreeView(Cache.Objects[i -1]).UseBuiltInIcons := True;
      if TShellTreeView(Cache.Objects[i -1]).Hint <> '' then
      begin
        if ResolveVariableEx(TShellTreeView(Cache.Objects[i -1]).Hint) <> '$MYAHNX$' then 
          if DirectoryExists(ResolveVariable(TShellTreeView(Cache.Objects[i -1]).Hint)) then
          begin
            TShellTreeView(Cache.Objects[i -1]).Path := ResolveVariable(TShellTreeView(Cache.Objects[i -1]).Hint);
          end;
      end;
      if TShellTreeView(Cache.Objects[i -1]).Tag = 1 then 
      begin
        if DirectoryExists(ResolvedTargetDir) then
          TShellTreeView(Cache.Objects[i -1]).Path := ResolvedTargetDir
        else
          if DirectoryExists(ExtractFilePath(ResolvedTargetDir)) then
            TShellTreeView(Cache.Objects[i -1]).Path := ExtractFilePath(ResolvedTargetDir);
      end;
      if TShellTreeView(Cache.Objects[i -1]).Path <> '' then
        if DirectoryExists(TShellTreeView(Cache.Objects[i -1]).Path) then
        begin
          TShellTreeView(Cache.Objects[i -1]).Selected.Expanded := false;
          TShellTreeView(Cache.Objects[i -1]).Selected.SelectedIndex := TShellTreeView(Cache.Objects[i -1]).Selected.SelectedIndex;
          TShellTreeView(Cache.Objects[i -1]).Selected.Expanded := True;
        end;
    end;
    if Cache.Objects[i -1] is TCheckListBox then
    begin
      
      AddReverseEntry(Pool.Hint, TCheckListBox(Cache.Objects[i -1]).Name, TCheckListBox(Cache.Objects[i -1]).Items.Text);
      TCheckListBox(Cache.Objects[i -1]).Items.Text := ReverseLookup(Pool.Hint, TCheckListBox(Cache.Objects[i -1]).Name);
      if ActivatedLanguage = '' then
        TCheckListBox(Cache.Objects[i -1]).Items.Text :=
          MemoMultiToDefaultMultiLineAdapter(SubstituteVariables(TCheckListBox(Cache.Objects[i -1]).Items.Text))
      else
        TCheckListBox(Cache.Objects[i -1]).Items.Text := MemoMultiToDefaultMultiLineAdapter(SubstituteVariables(
          GetTransForDlgItem(Pool.Hint, TCheckListBox(Cache.Objects[i -1]).Name)));
      for iX := TCheckListBox(Cache.Objects[i -1]).Items.Count downto 1 do
        if TCheckListBox(Cache.Objects[i -1]).Items[iX -1] = '' then
          TCheckListBox(Cache.Objects[i -1]).Items.Delete(iX -1);
      
      TCheckListBox(Cache.Objects[i -1]).OnClick := @Pool.CheckListBox1Click;
      if TCheckListBox(Cache.Objects[i -1]).Hint <> '' then
      
        if ResolveVariableEx(TCheckListBox(Cache.Objects[i -1]).Hint) <> '$MYAHNX$' then 
        begin
          l := TStringList.Create;
          l.Text := MemoMultiToDefaultMultiLineAdapter(
            ResolveVariable(TCheckListBox(Cache.Objects[i -1]).Hint));
          for iX := 1 to l.Count do
            if TCheckListBox(Cache.Objects[i -1]).Items.IndexOf(l[iX -1]) <> -1 then
              TCheckListBox(Cache.Objects[i -1]).Checked[
                TCheckListBox(Cache.Objects[i -1]).Items.IndexOf(l[iX -1])] := True;
          l.Free;
        end;
          
      if TCheckListBox(Cache.Objects[i -1]).Tag = 1 then
      begin
        TCheckListBox(Cache.Objects[i -1]).OnClickCheck := @Pool.CheckListBox1ClickCheck;
        GetComponentsFlat(TCheckListBox(Cache.Objects[i -1]));
        
      end
      else
        if TCheckListBox(Cache.Objects[i -1]).Hint <> '' then
          TCheckListBox(Cache.Objects[i -1]).OnClickCheck := @Pool.CheckListBox1ClickCheck;
      ChangeSelections.Add(Cache.Objects[i -1]);
    end;
    if Cache.Objects[i -1] is TComboBox then
    begin
      
      AddReverseEntry(Pool.Hint, TComboBox(Cache.Objects[i -1]).Name, TComboBox(Cache.Objects[i -1]).Items.Text);
      TComboBox(Cache.Objects[i -1]).Items.Text := ReverseLookup(Pool.Hint, TComboBox(Cache.Objects[i -1]).Name);
      if ActivatedLanguage = '' then
        TComboBox(Cache.Objects[i -1]).Items.Text := MemoMultiToDefaultMultiLineAdapter(
          SubstituteVariables(TComboBox(Cache.Objects[i -1]).Items.Text))
      else
        TComboBox(Cache.Objects[i -1]).Items.Text := MemoMultiToDefaultMultiLineAdapter(SubstituteVariables(
          GetTransForDlgItem(Pool.Hint, TComboBox(Cache.Objects[i -1]).Name)));
      for iX := TComboBox(Cache.Objects[i -1]).Items.Count downto 1 do
        if TComboBox(Cache.Objects[i -1]).Items[iX -1] = '' then
          TComboBox(Cache.Objects[i -1]).Items.Delete(iX -1);
      
      TComboBox(Cache.Objects[i -1]).OnChange := @Pool.ComboBox1Change;
      if TComboBox(Cache.Objects[i -1]).Hint <> '' then
      begin
        TComboBox(Cache.Objects[i -1]).OnClick := @Pool.ComboBox1Click;
        if ResolveVariableEx(TComboBox(Cache.Objects[i -1]).Hint) <> '$MYAHNX$' then 
        begin
          
          if TComboBox(Cache.Objects[i -1]).Style = csDropDownList then
          begin
            for k := 1 to TComboBox(Cache.Objects[i -1]).Items.Count do
              if AnsiCompareText(TComboBox(Cache.Objects[i -1]).Items[k -1],
                ResolveVariable(TComboBox(Cache.Objects[i -1]).Hint)) = 0 then
              begin
                TComboBox(Cache.Objects[i -1]).ItemIndex := k -1;
                Break;
              end;
          end
          else
            TComboBox(Cache.Objects[i -1]).Text :=
              MemoMultiToDefaultMultiLineAdapter(ResolveVariable(TComboBox(Cache.Objects[i -1]).Hint));
        end;
      end;
    end;
    if Cache.Objects[i -1] is TEdit then
    begin
      
      TEdit(Cache.Objects[i -1]).OnChange := @Pool.Edit1Change;
      AddReverseEntry(Pool.Hint, TEdit(Cache.Objects[i -1]).Name,
        TEdit(Cache.Objects[i -1]).Text);
      TEdit(Cache.Objects[i -1]).Text := ReverseLookup(Pool.Hint, TEdit(Cache.Objects[i -1]).Name);
      if ActivatedLanguage <> '' then
        TEdit(Cache.Objects[i -1]).Text := GetTransForDlgItem(Pool.Hint, TEdit(Cache.Objects[i -1]).Name);
      if TEdit(Cache.Objects[i -1]).Hint <> '' then
      begin
        if ResolveVariableEx(TEdit(Cache.Objects[i -1]).Hint) <> '$MYAHNX$' then 
          TEdit(Cache.Objects[i -1]).Text := ElimDoubles(ResolveVariable(TEdit(Cache.Objects[i -1]).Hint));
      end;
      if TEdit(Cache.Objects[i -1]).Text = '' then 
      begin
        case TEdit(Cache.Objects[i -1]).Tag of
          1: TEdit(Cache.Objects[i -1]).Text := '$STARTMENU$'; 
          2: TEdit(Cache.Objects[i -1]).Text := '$TARGETDIR$'; 
          3: TEdit(Cache.Objects[i -1]).Text := '$USERNAME$'; 
          4: TEdit(Cache.Objects[i -1]).Text := '$USERCOMPANY$'; 
        end;
        TEdit(Cache.Objects[i -1]).Text := ElimDoubles(SubstituteVariables(TEdit(Cache.Objects[i -1]).Text));
      end;
    end;
    if Cache.Objects[i -1] is TMaskEdit then
    begin
      
      TMaskEdit(Cache.Objects[i -1]).OnChange := @Pool.MaskEdit1Change;
      TMaskEdit(Cache.Objects[i -1]).OnKeyUp := @Pool.MaskEdit1KeyUp;
      AddReverseEntry(Pool.Hint, TMaskEdit(Cache.Objects[i -1]).Name,
        TMaskEdit(Cache.Objects[i -1]).Text);
      TMaskEdit(Cache.Objects[i -1]).Text := ReverseLookup(Pool.Hint, TMaskEdit(Cache.Objects[i -1]).Name);
      if ActivatedLanguage <> '' then
        TMaskEdit(Cache.Objects[i -1]).Text := GetTransForDlgItem(Pool.Hint, TMaskEdit(Cache.Objects[i -1]).Name);
      if TMaskEdit(Cache.Objects[i -1]).Hint <> '' then
      begin
        if ResolveVariableEx(TMaskEdit(Cache.Objects[i -1]).Hint) <> '$MYAHNX$' then 
          TMaskEdit(Cache.Objects[i -1]).Text := ResolveVariable(TMaskEdit(Cache.Objects[i -1]).Hint);
      end;
      if TMaskEdit(Cache.Objects[i -1]).Text = '' then 
      begin
        case TMaskEdit(Cache.Objects[i -1]).Tag of
          1: TMaskEdit(Cache.Objects[i -1]).Text := '$STARTMENU$'; 
          2: TMaskEdit(Cache.Objects[i -1]).Text := '$TARGETDIR$'; 
          3: TMaskEdit(Cache.Objects[i -1]).Text := '$USERNAME$'; 
          4: TMaskEdit(Cache.Objects[i -1]).Text := '$USERCOMPANY$'; 
        end;
        TMaskEdit(Cache.Objects[i -1]).Text := SubstituteVariables(TMaskEdit(Cache.Objects[i -1]).Text);
      end;
    end;
  end;
  
  Pool.ReflectComponentInfo;
  Pool.ReflectRules;
  
  Cache.Free;
  BlockUpdates := false;
  for i := 1 to ChangeSelections.Count do
  begin
    if TComponent(ChangeSelections[i -1]) is TTreeView then
      TTreeView(ChangeSelections[i -1]).OnChange(TTreeView(ChangeSelections[i -1]),
        TTreeView(ChangeSelections[i -1]).Selected);
    if TComponent(ChangeSelections[i -1]) is TCheckListBox then
    begin
      TCheckListBox(ChangeSelections[i -1]).OnClick(TCheckListBox(ChangeSelections[i -1]));
      if (TCheckListBox(ChangeSelections[i -1]).Tag = 1) or
        (TCheckListBox(ChangeSelections[i -1]).Hint <> '') then
        TCheckListBox(ChangeSelections[i -1]).OnClickCheck(TCheckListBox(ChangeSelections[i -1]));
    end;
  end;
  {$ENDIF}
end;

procedure UnBindControls(Name: String);
var
  i: Integer;
  Cache: TStringList;
  Pool: TPoolTemplate;
  ResolvedTargetDir: String;
begin
  {$IFNDEF NOGUI}
  if SilentInstall then Exit;
  ResolvedTargetDir := ElimDoubles(ResolveVariable('$TARGETDIR$')); 
  while not DirectoryExists(ResolvedTargetDir) do
  begin
    if AssertDir(ExtractFilePath(ExcludeTrailingPathDelimiter(ResolvedTargetDir))) = ResolvedTargetDir then Break; 
    ResolvedTargetDir := AssertDir(ExtractFilePath(ExcludeTrailingPathDelimiter(ResolvedTargetDir)));
  end;
  Pool := FindPool(Name);
  DeferHideHandle := Pool.Handle;
  BlockUpdates := True;
  
  Cache := TStringList.Create;
  for i := 1 to Pool.ComponentCount do
    if Pool.Components[i -1].Name <> 'cmpFormDesigner' then 
      Cache.AddObject(Pool.Components[i -1].Name, Pool.Components[i -1]);
  Cache.AddObject(Pool.Name, Pool);
  
  for i := 1 to Cache.Count do
  begin
    
    if Cache.Objects[i -1] is TLabel then
    begin
      TLabel(Cache.Objects[i -1]).OnClick := nil;
      TLabel(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TLabel(Cache.Objects[i -1]).Name);
    end;
    if Cache.Objects[i -1] is TGroupBox then
    begin
      TGroupBox(Cache.Objects[i -1]).OnClick := nil;
      TGroupBox(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TGroupBox(Cache.Objects[i -1]).Name);
    end;
    if Cache.Objects[i -1] is TStaticText then
      TStaticText(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TStaticText(Cache.Objects[i -1]).Name);
    if Cache.Objects[i -1] is TTrackBar then
      TTrackBar(Cache.Objects[i -1]).OnChange := nil;
    if Cache.Objects[i -1] is TButton then
    begin
      TButton(Cache.Objects[i -1]).OnClick := nil;
      TButton(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TButton(Cache.Objects[i -1]).Name);
    end;
    if Cache.Objects[i -1] is TSpeedButton then
    begin
      TSpeedButton(Cache.Objects[i -1]).OnClick := nil;
      TSpeedButton(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TSpeedButton(Cache.Objects[i -1]).Name);
    end;
    if Cache.Objects[i -1] is TBitBtn then
    begin
      TBitBtn(Cache.Objects[i -1]).OnClick := nil;
      TBitBtn(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TBitBtn(Cache.Objects[i -1]).Name);
    end;
    if Cache.Objects[i -1] is TImage then
      TImage(Cache.Objects[i -1]).OnClick := nil;
    if Cache.Objects[i -1] is TShape then
      TShape(Cache.Objects[i -1]).OnMouseUp := nil;
    if Cache.Objects[i -1] is TCheckBox then
    begin
      TCheckBox(Cache.Objects[i -1]).OnClick := nil;
      TCheckBox(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TCheckBox(Cache.Objects[i -1]).Name);
    end;
    if Cache.Objects[i -1] is TRadioButton then
    begin
      TRadioButton(Cache.Objects[i -1]).OnClick := nil;
      TRadioButton(Cache.Objects[i -1]).Caption := ReverseLookup(Pool.Hint, TRadioButton(Cache.Objects[i -1]).Name);
    end;
    if Cache.Objects[i -1] is TListBox then
    begin
      TListBox(Cache.Objects[i -1]).OnClick := nil;
      TListBox(Cache.Objects[i -1]).Items.Text := ReverseLookup(Pool.Hint, TListBox(Cache.Objects[i -1]).Name);
    end;
    if Cache.Objects[i -1] is TMemo then
    begin
      TMemo(Cache.Objects[i -1]).OnChange := nil;
      TMemo(Cache.Objects[i -1]).Text := ReverseLookup(Pool.Hint, TMemo(Cache.Objects[i -1]).Name);
      if TMemo(Cache.Objects[i -1]).ReadOnly then
      begin
        if AnsiCompareText(Pool.SoloMemo, TMemo(Cache.Objects[i -1]).Name) = 0 then
        begin
          TMemo(Cache.Objects[i -1]).WindowProc := Pool.MemoWindowProc;
          Pool.MemoBuffer := nil;
          Pool.SoloMemo := '';
        end;
      end;
    end;
    if Cache.Objects[i -1] is TTreeView then
    begin
      TTreeView(Cache.Objects[i -1]).OnChange := nil;
      TTreeView(Cache.Objects[i -1]).ReadOnly := True;
    end;
    if Cache.Objects[i -1] is TShellTreeView then
      TShellTreeView(Cache.Objects[i -1]).OnChange := nil;
    if Cache.Objects[i -1] is TCheckListBox then
    begin
      TCheckListBox(Cache.Objects[i -1]).OnClick := nil;
      TCheckListBox(Cache.Objects[i -1]).Items.Text := ReverseLookup(Pool.Hint, TCheckListBox(Cache.Objects[i -1]).Name);
    end;
    if Cache.Objects[i -1] is TComboBox then
    begin
      TComboBox(Cache.Objects[i -1]).OnChange := nil;
      TComboBox(Cache.Objects[i -1]).Items.Text := ReverseLookup(Pool.Hint, TComboBox(Cache.Objects[i -1]).Name);
    end;
    if Cache.Objects[i -1] is TEdit then
    begin
      TEdit(Cache.Objects[i -1]).OnChange := nil;
      TEdit(Cache.Objects[i -1]).Text := ReverseLookup(Pool.Hint, TEdit(Cache.Objects[i -1]).Name);
    end;
    if Cache.Objects[i -1] is TMaskEdit then
    begin
      TMaskEdit(Cache.Objects[i -1]).OnChange := nil;
      TMaskEdit(Cache.Objects[i -1]).OnKeyUp := nil;
      TMaskEdit(Cache.Objects[i -1]).Text := ReverseLookup(Pool.Hint, TMaskEdit(Cache.Objects[i -1]).Name);
    end;
  end;
  
  Pool.ReflectComponentInfo;
  Pool.ReflectRules;
  
  Cache.Free;
  BlockUpdates := false;
  {$ENDIF}
end;

function ShowDesign(Name: String; var ResultEx: String; Modal,
  ActivateTask: Boolean): Integer;

function ProcessButtoniTag(iTag: Integer; sName: String; var sSelection: String): Integer;
var
  s: String;
begin
  sSelection := '';
  case iTag of
    1: Result := mrYes;
    2: Result := mrNo;
    0, 3: begin
            Result := mrCancel;
            
            SetVariable('MYAH_IsCancelled', 'TRUE', 'ShowDesign Character Mode') ;
          end;
    4: begin
         
         if MyDialogsSelectDirectory('TARGETDIR?', GetVariable('TARGETDIR'), s, True) then
           SetVariable('TARGETDIR', s, 'Text Mode Dialog Render for Button iTag');
         WriteLn('TARGETDIR=' + GetVariable('TARGETDIR'));
         Result := mrOk; 
       end;
    5: begin
         
         Result := mrAll; 
         sSelection := sName;
       end;
    6: begin
         
         if MyDialogsSelectDirectory(sName + '?', GetVariable(sName), s, True) then
           SetVariable(sName, s, 'Text Mode Dialog Render for Button iTag');
         WriteLn(sName + '=' + GetVariable(sName));
         Result := mrOk; 
       end;
  else
    Result := mrYes;
  end;
end;

var
  s, sZ: String;
  i, j, k, kX: Integer;
  PoolVis: Boolean;
  Pool: TPoolTemplate;
  {$IFDEF NOGUI} 
  t: TextFile;
  c: Char;
  b, bX, bY, bZ, bMulti: Boolean;
  iTag: Integer;
  l, lX, lY, lR, lC: TStringList;
  sX, sY, sHint, sDefault, sCaption, sName, NameEx, pHint: String;
  {$ENDIF}

procedure HandleSystemTrayCompatShow(LastPool: TPoolTemplate);
begin
  {$IFNDEF NOGUI}
  {$IFDEF INTEROP}
  Pool.Show;
  Pool.SetFocus;
  {$ELSE}
  Pool.Show;
  Pool.SetFocus;
  {$ENDIF}
  PrimaryWindowHandle := Pool.Handle; 
  
  {$ELSE}
  
  {$ENDIF}
end;

begin
  SetVariable('MYAH_IsCancelled', 'FALSE', 'ShowDesign') ;
  GetDir(0, sZ);
  s := sZ;
  ChDir(DlgRootFolder);
  Result := 0;
  ActiveName := Name;
  if SilentInstall then
  begin
    
    Result := mrYes; 
    Exit;
  end;
  {$IFNDEF NOGUI}
  Pool := FindPool(Name);
  PoolVis := Pool.Visible;
  if not FirstShow then
    if (Pool.Width <> SmartPosWidth) or (Pool.Height <> SmartPosHeight) then
      FirstShow := True;
  if FirstShow then
  begin
    Pool.Position := poScreenCenter;
    SmartPosWidth := Pool.Width;
    SmartPosHeight := Pool.Height;
  end
  else
  begin
    Pool.Position := poDesigned;
    Pool.Left := SmartPosLeft;
    Pool.Top := SmartPosTop;
  end;
  FirstShow := false;
  SetVariable('MYAH_IsCancelled', 'FALSE', 'ShowDesign') ;
  Pool.FNonModal := not Modal;
  Pool.Bug;
  if Modal then
  begin
    if ActivateTask then
      Pool.FStart := True;
    {$IFDEF NOCACHE}
    Result := Pool.ShowModal;
    {$ELSE}
    Pool.FModalEx := -1;
    Pool.FCanClose := false;
    HandleSystemTrayCompatShow(LastPool);
    
    if (LastPool <> nil) and (LastPool <> Pool) then
    begin
      
      if (GetVariable('FX') = 'SLIDE') or (GetVariable('FX') = 'FADE') then
      begin
        LastPool.AlphaBlendValue := 0;
        LastPool.AlphaBlend := True;
        Application.ProcessMessages;
      end;
      LastPool.FCanClose := True;
      LastPool.Hide;
      ShowWindow(LastPool.Handle, SW_HIDE);
      if LastPoolHandle <> 0 
        then ShowWindow(LastPoolHandle, SW_HIDE);
      if DeferHideHandle <> 0
        then ShowWindow(DeferHideHandle, SW_HIDE);
      HideAllDesigns(Name);
      if (GetVariable('FX') = 'SLIDE') or (GetVariable('FX') = 'FADE') then
      begin
        LastPool.AlphaBlendValue := 255;
        LastPool.AlphaBlend := false;
      end;
    end;
    LastPool := Pool;
    LastPoolHandle := Pool.Handle;
    
    while Pool.FModalEx = -1 do
      if not SilentInstall then
        
      begin
        Application.Idle(True);
        Application.ProcessMessages;
      end;
    Result := Pool.FModalEx;
    if Result = mrAll then
      ResultEx := Pool.FModalExReturn
    else
      ResultEx := '';
    {$ENDIF}
    ActiveName := '';
    SmartPosLeft := Pool.Left;
    SmartPosTop := Pool.Top;
  end
  else
  begin
    Result := Pool.Handle;
    {$IFDEF NOCACHE}
    Pool.Show;
    Pool.SetFocus;
    Application.ProcessMessages;
    {$ELSE}
    Pool.FCanClose := false;
    HandleSystemTrayCompatShow(LastPool);
    
    if PoolVis then
      Pool.DoubleBuffered := True;
    if (LastPool <> nil) and (LastPool <> Pool) then
    begin
      
      if (GetVariable('FX') = 'SLIDE') or (GetVariable('FX') = 'FADE') then
      begin
        LastPool.AlphaBlendValue := 0;
        LastPool.AlphaBlend := True;
        Application.ProcessMessages;
      end;
      LastPool.FCanClose := True;
      LastPool.Hide;
      ShowWindow(LastPool.Handle, SW_HIDE);
      if LastPoolHandle <> 0 then 
        ShowWindow(LastPoolHandle, SW_HIDE);
      if DeferHideHandle <> 0 then 
        ShowWindow(DeferHideHandle, SW_HIDE);
      HideAllDesigns(Name);
      if (GetVariable('FX') = 'SLIDE') or (GetVariable('FX') = 'FADE') then
      begin
        LastPool.AlphaBlendValue := 255;
        LastPool.AlphaBlend := false;
      end;
    end;
    
    LastPool := Pool;
    LastPoolHandle := Pool.Handle;
    
    Pool.DoubleBuffered := false;
    {$ENDIF}
    SmartPosLeft := Pool.Left;
    SmartPosTop := Pool.Top;
  end;
  {$ELSE}
  
  if Modal then
  begin
    NameEx := Name; 
    pHint := ExtractFileName(Name);
    Name := ExtractFileNameOnly(rdi[rdi.IndexOf(Name) +1]);
    
    WriteLn;
    WriteLn(Name + ':');
    for i := 1 to Length(Name) +1 do
      {$IFDEF WINDOWS}
      Write('=');
      {$ELSE}
      Write('=');
      {$ENDIF}
    WriteLn;
    AssignFile(t, AssertDir(DlgRootFolder) + Name + '.lfm');
    Reset(t);
    l := TStringList.Create; 
    lX := TStringList.Create; 
    lY := TStringList.Create; 
    lR := TStringList.Create; 
    lC := TStringList.Create; 
    
    while not EOF(t) do
    begin
      ReadLn(t, s);
      sX := s; 
      s := AnsiLowerCase(s); 
      
      if (AnsiPos('object', s) <> 0) and (AnsiPos(':', s) > AnsiPos('object', s)) then
      begin
        
        iTag := -1;
        sHint := '';
        sCaption := '';
        bX := false; 
        bMulti := false; 
        
        Delete(s, 1, AnsiPos('object ', s) + Length('object ') -1);
        Delete(s, AnsiPos(':', s), Length(s));
        sName := AnsiUpperCase(s);
        
        s := AnsiLowerCase(sX);
        Delete(s, 1, AnsiPos(': ', s) + Length(': ') -1);
        s := Trim(s);
        if AnsiCompareText('TMemo', s) = 0 then
        begin
          l.Add(s); 
          lY.Clear; 
        end
        else
        if AnsiCompareText('TEdit', s) = 0 then
          l.Add(s) 
        else
        if AnsiCompareText('TButton', s) = 0 then
          l.Add(s) 
        else
        if AnsiCompareText('TImage', s) = 0 then
          l.Add(s) 
        else
        if AnsiCompareText('TShape', s) = 0 then
          l.Add(s) 
        else
        if AnsiCompareText('TSpeedButton', s) = 0 then
          l.Add(s) 
        else
        if AnsiCompareText('TLabel', s) = 0 then
          l.Add(s) 
        else
        if AnsiCompareText('TComboBox', s) = 0 then
        begin
          l.Add(s); 
          lY.Clear; 
        end
        else
        if AnsiCompareText('TCheckBox', s) = 0 then
          l.Add(s) 
        else
        if AnsiCompareText('TRadioButton', s) = 0 then
          l.Add(s) 
        else
        if AnsiCompareText('TTreeView', s) = 0 then
          l.Add(s) 
        else
        if AnsiCompareText('TListBox', s) = 0 then
        begin
          l.Add(s); 
          lY.Clear; 
        end
        else
        if AnsiCompareText('TCheckListBox', s) = 0 then
        begin
          l.Add(s); 
          lY.Clear; 
        end
        else
        if AnsiCompareText('TBitBtn', s) = 0 then
          l.Add(s); 
      end
      else
      
      if AnsiCompareText(Trim(s), 'end') = 0 then
      begin
        if l.Count > 0 then 
        begin
          if not bX then
          begin
            
            if (((AnsiCompareText(l[l.Count -1], 'TButton') = 0) or (AnsiCompareText(l[l.Count -1], 'TBitBtn') = 0)) or
              ((AnsiCompareText(l[l.Count -1], 'TLabel') = 0) or (AnsiCompareText(l[l.Count -1], 'TSpeedButton') = 0))) or
              ((AnsiCompareText(l[l.Count -1], 'TImage') = 0) or (AnsiCompareText(l[l.Count -1], 'TShape') = 0)) then 
            begin
              if (iTag > 0)  then 
              begin
                if sCaption = '' then
                begin
                  
                  case iTag of
                    1: sCaption := 'Go to Next Dialog';
                    2: sCaption := 'Go to Previous Dialog';
                    
                    3: sCaption := 'Cancel';
                    4: sCaption := 'Select Target Folder';
                    5: sCaption := 'Return from Dialog: ' + sName;
                    6: sCaption := 'Select Custom Folder';
                  end;
                end;
                lX.Add(sCaption);
                lX.Add(IntToStr(iTag));
                lX.Add(sName); 
                
              end;
            end
            else
            if AnsiCompareText(l[l.Count -1], 'TCheckBox') = 0 then
            begin
              if sHint <> '' then
              begin
                lC.Add(sCaption);
                lC.Add(sHint);
              end;
            end
            else
            if AnsiCompareText(l[l.Count -1], 'TRadioButton') = 0 then
            begin
              
              begin
                lR.Add(sCaption);
                lR.Add(sHint);
              end;
            end
            else
            if AnsiCompareText(l[l.Count -1], 'TComboBox') = 0 then
            begin
              if sHint <> '' then 
                TextCheckListBoxEdit(lY, sHint, pHint, sName, false);
            end
            else
            if AnsiCompareText(l[l.Count -1], 'TListBox') = 0 then
            begin
              if sHint <> '' then 
                TextCheckListBoxEdit(lY, sHint, pHint, sName, bMulti);
            end
            else
            if AnsiCompareText(l[l.Count -1], 'TCheckListBox') = 0 then
            begin
              if iTag = 1 then
                TextComponentsEdit
              else
                if sHint <> '' then
                  TextCheckListBoxEdit(lY, sHint, pHint, sName);
            end
            else
            if AnsiCompareText(l[l.Count -1], 'TTreeView') = 0 then
            begin
              if iTag = 1 then
                TextComponentsEdit;
            end
            else
            if AnsiCompareText(l[l.Count -1], 'TMemo') = 0 then
            begin
              if iTag = 1 then
                TextFileDisplay(AssertDir(GetVariable('SUPPORTDIR')) + 'readme.txt')
              else
              if iTag = 2 then
                TextFileDisplay(AssertDir(GetVariable('SUPPORTDIR')) + 'license.txt')
              else
                
                TextMemoDisplay(lY, pHint, sName, sHint);
            end
            else
            if AnsiCompareText(l[l.Count -1], 'TEdit') = 0 then
            begin
              sDefault := ''; 
              if (iTag > 0) then 
              begin
                
                case iTag of
                  5: 
                     sDefault := sHint;
                  1: 
                     sDefault := 'STARTMENU';
                  2: 
                     sDefault := 'TARGETDIR';
                  3: 
                     sDefault := 'USERNAME';
                  4: 
                     sDefault := 'USERCOMPANY';
                end;
              end;
              if sHint = '' then 
                if sDefault <> '' then 
                  sHint := sDefault; 
              if sDefault <> '' then
                sDefault := GetVariable(sDefault);
              if sHint <> '' then
              begin
                WriteLn(sHint + '? (' + sDefault + ')');
                ReadLn(sX);
                if sX = '' then
                  sX := sDefault;
                SetVariable(sHint, sX, 'Text Mode Dialog Render for ' + Name);
                WriteLn(sHint + '=' + GetVariable(sHint));
              end;
              
            end;
          end;
          
          l.Delete(l.Count -1);
        end;
      end
      else
      if (AnsiPos('items.strings = (', s) <> 0) 
        or (AnsiPos('lines.strings = (', s) <> 0) then 
      begin
        lY.Clear;
        repeat
          ReadLn(t, s);
          if OccurrencesOfChar(s, '''') >= 2 then
          begin
            Delete(s, 1, AnsiPos('''', s));
            if s[Length(s)] = '''' then
            begin
              Delete(s, Length(s), 1);
              s := StringReplace(s, '''''', '''', [rfReplaceAll, rfIgnoreCase]);
              lY.Add(s);
            end;
          end;
        until (AnsiCompareText(Trim(s), ')') = 0) or EOF(t);
      end
      else
      
      if (AnsiPos('tag =', s) <> 0) and (l.Count > 0) then
      begin
        
        Delete(s, 1, AnsiPos('tag = ', s) + Length('tag = ') -1);
        s := Trim(s);
        i := 0;
        if TryStrToInt(s, i) then
          if i > 0 then 
            iTag := i;
        
      end
      else
      
      if ((AnsiPos('hint = ''', s) <> 0) and (l.Count > 0)) or
        ((AnsiPos('caption = ''', s) <> 0) and (l.Count > 0)) then
      begin
        
        sY := '';
        if AnsiPos('hint = ''', s) <> 0 then sY := 'hint = ''';
        if AnsiPos('caption = ''', s) <> 0 then sY := 'caption = ''';
        Delete(sX, 1, AnsiPos(sY, s) + Length(sY) -1);
        sX := Trim(sX);
        if AnsiPos('''', sX) = Length(sX) then
        begin
          Delete(sX, Length(sX), 1);
          if AnsiPos('hint = ''', s) <> 0 then sHint := sX;
          if AnsiPos('caption = ''', s) <> 0 then sCaption := DeAccelerators(SubstituteVariables(sX));
          
        end;
      end
      else
      if (AnsiPos('multiselect = ', s) <> 0) and (AnsiCompareText(l[l.Count -1], 'TListBox') = 0) then
      begin
        Delete(s, 1, AnsiPos('multiselect = ', s) + Length('multiselect = ') -1);
        s := Trim(s);
        if TryStrToBool(s, b) then
          bMulti := b;
        
      end
      else
      
      if ((AnsiPos('enabled = ', s) <> 0) and (l.Count > 0)) or
        ((AnsiPos('visible = ', s) <> 0) and (l.Count > 0)) then
      begin
        sY := '';
        if AnsiPos('visible = ', s) <> 0 then sY := 'visible = ';
        if AnsiPos('enabled = ', s) <> 0 then sY := 'enabled = ';
        
        Delete(s, 1, AnsiPos(sY, s) + Length(sY) -1);
        s := Trim(s);
        if TryStrToBool(s, b) then
          if not b then
            bX := True; 
        
      end;
    end;
    l.Free; 
    lY.Free; 
    
    CloseFile(t);
    
    if lR.Count > 0 then
    repeat
      WriteLn('0. ' + StringReplace(dlg15, '&', '', [rfReplaceAll, rfIgnoreCase]));
      bZ := false; 
      for i := 1 to lR.Count do
        if i mod 2 = 1 then
        begin
          bY := false; 
          Write(IntToAscii((i div 2) +1) + '. ');
          
          Write('[');
          if TryStrToBool(GetVariable(lR[i]), bY) then
            if bY then
              if not bZ then 
                bZ := True 
              else
                bY := false;
          if bY then {$IFDEF WINDOWS}Write('O'){$ELSE}Write('≡'){$ENDIF}
            else Write(' ');
          WriteLn('] ' + lR[i -1]); 
        end;
      repeat
        c := ReadKey;
        
        if (c = #13) or (c = #27) then
          i := 0
        else
          i := AsciiToInt(c);
      until (i >= 0) and (i <= (lR.Count div 2));
      if i = 0 then Break
      else
        for j := 1 to lR.Count do
          if j mod 2 = 1 then
            if lR[j] <> '' then 
            begin
              
              if i *2 = j +1 then
                SureSetVariable(lR[j], 'TRUE', 'Text Mode TRadioButton Toggle')
              else
              
                SureSetVariable(lR[j], 'FALSE', 'Text Mode TRadioButton Toggle');
            end;
    until false;
    if lC.Count > 0 then
    repeat
      WriteLn('0. ' + StringReplace(dlg15, '&', '', [rfReplaceAll, rfIgnoreCase]));
      for i := 1 to lC.Count do
        if i mod 2 = 1 then
        begin
          Write(IntToAscii((i div 2) +1) + '. ');
          
          Write('[');
          if not TryStrToBool(GetVariable(lC[i]), bY) then
            bY := false; 
          if bY then {$IFDEF WINDOWS}Write('X'){$ELSE}Write('√'){$ENDIF}
            else Write(' ');
          WriteLn('] ' + lC[i -1]); 
        end;
      repeat
        c := ReadKey;
        
        if (c = #13) or (c = #27) then
          i := 0
        else
          i := AsciiToInt(c);
      until (i >= 0) and (i <= (lC.Count div 2));
      if i = 0 then Break
      else
      begin
        if not TryStrToBool(GetVariable(lC[(i *2) -1]), bY) then
          bY := false; 
        if bY then
          SureSetVariable(lC[(i *2) -1], 'FALSE', 'Text Mode TCheckBox Toggle')
        else
          SureSetVariable(lC[(i *2) -1], 'TRUE', 'Text Mode TCheckBox Toggle');
      end;
    until false;
    for i := 1 to Length(Name) +1 do
      {$IFDEF WINDOWS}
      Write('=');
      {$ELSE}
      Write('=');
      {$ENDIF}
    WriteLn;
    
    if lX.Count >= 3 then 
    begin
      
      j := 0; 
      k := 0; 
      kX := -1; 
      for i := 1 to lX.Count do
        if i mod 3 = 1 then
        begin
          if AnsiCompareText(lX[i -1],
            StringReplace(dlg16, '&', '', [rfReplaceAll, rfIgnoreCase])) = 0 then
          begin
            j := 1; 
            k := ((i -1) div 3) +1; 
            Break;
          end;
        end;
      if k = 1 then kX := 2
        else kX := 1;
      if j = 0 then
        WriteLn('0. ' + StringReplace(dlg16, '&', '', [rfReplaceAll, rfIgnoreCase]));
      
      for i := 1 to lX.Count do
        if i mod 3 = 1 then
          WriteLn(IntToAscii((i div 3) +1) + '. ' + lX[i -1]);
      repeat
        c := ReadKey;
        
        if (c = #13) or (c = #27) then
        begin
          if j = 0 then 
          begin
            if c = #13 then
              i := 1 
            else
              i := 0; 
          end
          else
          begin 
            if c = #13 then
              i := kX 
            else
              i := k; 
          end;
        end
        else
          i := AsciiToInt(c);
      until (i >= j) and (i <= (lX.Count div 3));
      
      if i <> 0 then
      begin
        iTag := StrToInt(lX[(i -1) *3 +1]);
        sName := lX[(i -1) *3 +2];
        
        Result := ProcessButtoniTag(iTag, sName, sX);
      end
      else
      begin
        
        SetVariable('MYAH_IsCancelled', 'TRUE', 'ShowDesign Character Mode') ;
        Result := mrCancel;
      end;
    end
    else
    begin
      if lX.Count = 0 then
      begin
        
        SetVariable('MYAH_IsCancelled', 'TRUE', 'ShowDesign Character Mode') ;
        Result := mrCancel; 
      end
      else
        Result := ProcessButtoniTag(StrToInt(lX[1]), lX[2], sX); 
    end;
    
    lX.Free;
    
    lR.Free; 
    lC.Free; 
    if Result = mrOk then
    begin
      Result := ShowDesign(NameEx, ResultEx, Modal, ActivateTask);
    end
    else
      if Result = mrAll then
        ResultEx := sX
      else
        ResultEx := '';
  end;
  {$ENDIF}
  if DirectoryExists(sZ) then
    ChDir(sZ); 
end;

procedure HideAllDesigns(ExceptName: String);
var
  i: Integer;
begin
  
end;

procedure HideDesign(Name: String);
var
  Pool: TPoolTemplate;
begin
  {$IFNDEF NOGUI}
  Pool := FindPool(GetActiveDesignName);
  if Pool <> nil then
  begin
    Pool.FCanClose := True;
    Pool.Hide;
    PrimaryWindowHandle := 0;
    ShowWindow(Pool.Handle, SW_HIDE);
    if LastPoolHandle <> 0 then 
      ShowWindow(LastPoolHandle, SW_HIDE);
    if DeferHideHandle <> 0 then 
      ShowWindow(DeferHideHandle, SW_HIDE);
    Application.ProcessMessages;
    if Pool = LastPool then
    begin
      LastPool := nil;
      LastPoolHandle := 0;
    end;
    ActiveName := '';
    SmartPosLeft := Pool.Left;
    SmartPosTop := Pool.Top;
  end;
  Pool := FindPool(Name);
  if Pool <> nil then
  begin
    Pool.FCanClose := True;
    Pool.Hide;
    PrimaryWindowHandle := 0;
    ShowWindow(Pool.Handle, SW_HIDE);
    if LastPoolHandle <> 0 then 
      ShowWindow(LastPoolHandle, SW_HIDE);
    if DeferHideHandle <> 0 then 
      ShowWindow(DeferHideHandle, SW_HIDE);
    Application.ProcessMessages;
    HideAllDesigns(Name);
    if Pool = LastPool then
    begin
      LastPool := nil;
      LastPoolHandle := 0;
    end;
    ActiveName := '';
    SmartPosLeft := Pool.Left;
    SmartPosTop := Pool.Top;
  end;
  {$ENDIF}
  HideAllDesigns('');
end;

function GetActiveDesignName: String;
begin
  {$IFDEF INTEROPX}
  Result := ShowingDesign;
  {$ELSE}
  Result := ActiveName;
  {$ENDIF}
end;

function FindPool(Name: String; FirstEntrant: Boolean): TPoolTemplate;
var
  s: String;
  l: TStringList;
  FileName: String;
  i, Index: Integer;
  Instance: TPoolTemplate;
begin
  Result := nil;
  Index := Pools.IndexOf(AnsiUpperCase(Name));
  if Index <> -1 then
  begin
    {$IFNDEF NOGUI}
    
    {$IFDEF INTEROP} 
    if Pools.Objects[Index] = nil then
    begin
      for i := 1 to Pools.Count do
        if Pools.Objects[i -1] <> nil then
          if TPoolTemplate(Pools.Objects[i -1]).Handle <> PrimaryWindowHandle then
          begin
            
            TPoolTemplate(Pools.Objects[i -1]).Free;
            Pools.Objects[i -1] := nil;
            
            Application.ProcessMessages;
            if FirstEntrant then
            begin
              
              Result := FindPool(Name, false);
              if Result <> nil then 
                Exit;
            end;
            
            GetDir(0, s);
            FileName := StuntedPools[StuntedPools.IndexOf(IntToStr(Index)) +1];
            try
              ChDir(ExtractFilePath(FileName));
              
              Instance := TPoolTemplate.CreateEx(FileName);
            except
              
              on E: Exception do
              begin
                
                ChDir(s);
                Result := FindPool(Name);
                Exit;
              end;
            end;
            
            Pools.Objects[Index] := Instance;
            l := TStringList.Create;
            l.LoadFromFile(FileName + '.miaf', TEncoding.UTF8); 
            Instance.Rules := l.CommaText;
            l.Free;
            ChDir(s);
            Result := TPoolTemplate(Pools.Objects[Index]);
            
            Break;
          end;
    end
    else
    {$ENDIF}
    {$ENDIF}
      Result := TPoolTemplate(Pools.Objects[Index]);
  end;
end;

procedure AddReverseEntry(Form, Component, Entry: String);
begin
  if ReverseLookup(Form, Component) <> '' then Exit;
  if ActivatedLanguage <> '' then
    if GetTransForDlgItem(Form, Component) <> '' then
      Entry := GetTransForDlgItem(Form, Component);
  ReverseList.Add(AnsiUpperCase(Form));
  ReverseList.Add(AnsiUpperCase(Component));
  ReverseList.Add(Entry);
end;

function ReverseLookup(Form, Component: String): String;
var
  i: Integer;
begin
  Form := AnsiUpperCase(Form);
  Component := AnsiUpperCase(Component);
  
  for i := 1 to ReverseList.Count do
    if (i -1) mod 3 = 0 then
      if ReverseList[i -1] = Form then
        if ReverseList[i] = Component then
        begin
          Result := ReverseList[i +1];
          Exit;
        end;
  Result := '';
  
end;

procedure ClearReverseEntries;
begin
  ReverseList.Clear;
end;

function BindProgress(Text: String; Percent, Max, Min: Int64; ReportInThCancelled: Boolean = false): Boolean;
var
  i: Integer;
  h: LongWord;
  Cache: TStringList;
  Pool: TPoolTemplate;
begin
  Result := StrToBool(GetVariable('MYAH_IsCancelled')) ;
  if ReportInThCancelled then
    SETVARIABLE('MYAH_thCancelled', MyBoolToStr(Result, True),'');
  if SilentInstall then
  begin
    if ReportInThCancelled then
      SETVARIABLE('MYAH_thCancelled', MyBoolToStr(StrToBool(GetVariable('MYAH_IsCancelled')), True),'');
    Exit;
  end;
  if Text = '$MYAH$' then 
  begin
    
    Text := GETVARIABLE('MYAH_thProgressText');
    Percent := StrToInt64(GETVARIABLE('MYAH_thProgress'));
    Max := StrToInt64(GETVARIABLE('MYAH_thMax'));
    Min := StrToInt64(GETVARIABLE('MYAH_thMin'));
  end;
  if ActiveName = '' then Exit;
  Pool := FindPool(ActiveName);
  
  {$IFNDEF NOGUI}
  Cache := TStringList.Create;
  for i := 1 to Pool.ComponentCount do
    if Pool.Components[i -1].Name <> 'cmpFormDesigner' then 
      Cache.AddObject(Pool.Components[i -1].Name, Pool.Components[i -1]);
  Cache.AddObject(Pool.Name, Pool);
  
  for i := 1 to Cache.Count do
  begin
    if Cache.Objects[i -1] is TLabel then
    begin
      TLabel(Cache.Objects[i -1]).OnClick := @Pool.Label1Click;
      if TLabel(Cache.Objects[i -1]).Caption <>
        SubstituteVariables(
          ReverseLookup(Pool.Hint, TLabel(Cache.Objects[i -1]).Name)) then
        TLabel(Cache.Objects[i -1]).Caption :=
          SubstituteVariables(
            ReverseLookup(Pool.Hint, TLabel(Cache.Objects[i -1]).Name));
    end;
    if Cache.Objects[i -1] is TPanel then
    begin
      if TPanel(Cache.Objects[i -1]).Caption <>
        SubstituteVariables(
          ReverseLookup(Pool.Hint, TPanel(Cache.Objects[i -1]).Name)) then
        TPanel(Cache.Objects[i -1]).Caption :=
          SubstituteVariables(
            ReverseLookup(Pool.Hint, TPanel(Cache.Objects[i -1]).Name));
    end;
    if Cache.Objects[i -1] is TButton then
    begin
      TButton(Cache.Objects[i -1]).OnClick := @Pool.Button1Click;
      if TButton(Cache.Objects[i -1]).Caption <>
        SubstituteVariables(
          ReverseLookup(Pool.Hint, TButton(Cache.Objects[i -1]).Name)) then
        TButton(Cache.Objects[i -1]).Caption :=
          SubstituteVariables(
            ReverseLookup(Pool.Hint, TButton(Cache.Objects[i -1]).Name));
    end;
    if Cache.Objects[i -1] is TTabSheet then
      if TTabSheet(Cache.Objects[i -1]).Caption <>
        SubstituteVariables(
          ReverseLookup(Pool.Hint, TTabSheet(Cache.Objects[i -1]).Name)) then
        TTabSheet(Cache.Objects[i -1]).Caption :=
          SubstituteVariables(
            ReverseLookup(Pool.Hint, TTabSheet(Cache.Objects[i -1]).Name));
    if Cache.Objects[i -1] is TStaticText then
    begin
      if TStaticText(Cache.Objects[i -1]).Tag = 1 then
        TStaticText(Cache.Objects[i -1]).Caption := Text
      else
      begin
        if TStaticText(Cache.Objects[i -1]).Caption <>
          SubstituteVariables(
            ReverseLookup(Pool.Hint, TStaticText(Cache.Objects[i -1]).Name)) then
          TStaticText(Cache.Objects[i -1]).Caption :=
            SubstituteVariables(
              ReverseLookup(Pool.Hint, TStaticText(Cache.Objects[i -1]).Name));
      end;
    end;
    if Cache.Objects[i -1] is TFileLabel then
    begin
      if TFileLabel(Cache.Objects[i -1]).Tag = 1 then
        TFileLabel(Cache.Objects[i -1]).FileName := Text
      else
      begin
        if TFileLabel(Cache.Objects[i -1]).FileName <>
          SubstituteVariables(
            ReverseLookup(Pool.Hint, TFileLabel(Cache.Objects[i -1]).Name)) then
          TFileLabel(Cache.Objects[i -1]).FileName :=
            SubstituteVariables(
              ReverseLookup(Pool.Hint, TFileLabel(Cache.Objects[i -1]).Name));
      end;
    end;
    if Cache.Objects[i -1] is TProgressBar then
    begin
      try
        if TProgressBar(Cache.Objects[i -1]).Tag = 1 then
        begin
          
          if TProgressBar(Cache.Objects[i -1]).Style <> pbstNormal then
              TProgressBar(Cache.Objects[i -1]).Style := pbstNormal;
          
          if Max > MAXINT then
            begin
              if TProgressBar(Cache.Objects[i -1]).Max <> (Max div 1024) then
                TProgressBar(Cache.Objects[i -1]).Max := Max div 1024;
              if TProgressBar(Cache.Objects[i -1]).Min <> (Min div 1024) then
                TProgressBar(Cache.Objects[i -1]).Min := Min div 1024;
              if TProgressBar(Cache.Objects[i -1]).Position <> (Percent div 1024) then
                TProgressBar(Cache.Objects[i -1]).Position := Percent div 1024;
            end
            else
            begin
              if TProgressBar(Cache.Objects[i -1]).Max <> Max then
                TProgressBar(Cache.Objects[i -1]).Max := Max;
              if TProgressBar(Cache.Objects[i -1]).Min <> Min then
                TProgressBar(Cache.Objects[i -1]).Min := Min;
              if TProgressBar(Cache.Objects[i -1]).Position <> Percent then
                TProgressBar(Cache.Objects[i -1]).Position := Percent;
            end;
          
        end;
        if TProgressBar(Cache.Objects[i -1]).Tag = 100 then
        begin
          if TProgressBar(Cache.Objects[i -1]).Max <> 100 then
            TProgressBar(Cache.Objects[i -1]).Max := 100;
          if TProgressBar(Cache.Objects[i -1]).Min <> 0 then
            TProgressBar(Cache.Objects[i -1]).Min := 0;
          if TProgressBar(Cache.Objects[i -1]).Position <>
            StrToInt(SubstituteVariables('$' + TProgressBar(Cache.Objects[i -1]).Hint + '$')) then
            TProgressBar(Cache.Objects[i -1]).Position :=
              StrToInt(SubstituteVariables('$' + TProgressBar(Cache.Objects[i -1]).Hint + '$'));
        end;
      except
        if TProgressBar(Cache.Objects[i -1]).Position <> TProgressBar(Cache.Objects[i -1]).Max then
          TProgressBar(Cache.Objects[i -1]).Position := TProgressBar(Cache.Objects[i -1]).Max;
      end;
    end;
  end;
  
  Pool.ReflectRules;
  
  Cache.Free;
  {$ELSE}
  
  ClrScr;
  if Max <> 100 then
    Percent := ((Percent - Min) *100) div (Max - Min);
  
  WriteLn(Text + ' (' + IntToStr(Percent) + '%)');
  
  {$ENDIF}
  
end;

function GetTransForDlgItem(Dialog, Item: String): String;
var
  i: Integer;
begin
  
  Dialog := StringReplace(Dialog, '.dfm', '', [rfReplaceAll, rfIgnoreCase]);
  Dialog := StringReplace(Dialog, '.lfm', '', [rfReplaceAll, rfIgnoreCase]);
  for i := 1 to lMap.Count do
    if AnsiCompareText(lMap[i -1], Dialog) = 0 then
      if AnsiCompareText(lIndex[i -1], Item) = 0 then
      begin
        Result := lLang[i -1];
        Exit;
      end;
  Result := ReverseLookup(Dialog, Item); 
end;

function ElimDoubles(Value: String): String;
var
  b: Boolean;
  s, sX: String;
begin
  Value := SubstituteVariables(Value); 
  s := PathDelim + PathDelim;
  sX := PathDelim;
  {$IFDEF WINDOWS}
  b := AnsiPos(s, Value) = 1;
  {$ENDIF}
  Result := StringReplace(Value, s, sX, [rfReplaceAll]);
  {$IFDEF WINDOWS}
  
  if b then Result := PathDelim + Result;
  {$ENDIF}
  
end;

function GetTransForScrItem(ItemDefault, ItemGuid: String; ItemOffset: Integer;
  Caller: String): String;
var
  i: Integer;
  s: String;
begin
  Result := ItemDefault; 
  s := RuntimeSubstituteCompilerVariables('#LOCMODE#');
  if s = '#LOCMODE#' then s := 'NEWONLY';
  if s <> '' then
    if (AnsiCompareText(s, 'VARSONLY') = 0) then
      if (AnsiPos('CODEGEAR$', ItemGuid) = 0) or
        (AnsiPos('$CODEGEAR', ItemGuid) = 0) then Exit;
  for i := 1 to lIndex.Count do
    if AnsiCompareText(ItemGuid, lIndex[i -1]) = 0 then
    begin
      if s <> '' then
        if AnsiCompareText(s, 'NEWONLY') = 0 then
          if ItemDefault <> lOrg[(i -1) + (ItemOffset -1)] then Exit;
      Result := RuntimeSubstituteCompilerVariables(lLang[(i -1) + (ItemOffset -1)]);
      Exit;
    end;
end;

procedure ParseRule(Rule: String; var Reverse: Boolean; var SourceControl,
  SourceProperty, SourceValue, TargetControl, TargetProperty,
  TargetValue: String);
var
  s, sX, sXX: String;
begin
  
  s := Rule;
  Delete(s, 1, 4);
  if AnsiPos(' <> ', s) = 0 then
  begin
    sXX := ' = ';
    Reverse := false;
  end
  else
  begin
    sXX := ' <> ';
    Reverse := True;
  end;
  
  sX := Copy(s, 1, AnsiPos('.', s) -1);
  Delete(s, 1, Length(sX) +1);
  SourceControl := sX;
  
  sX := Copy(s, 1, AnsiPos(sXX, s) -1);
  Delete(s, 1, Length(sX) + Length(sXX));
  SourceProperty := sX;
  
  sX := Copy(s, 1, AnsiPos(')  THEN  ', s) -1); 
  Delete(s, 1, Length(sX) +9);
  SourceValue := sX;
  
  sX := Copy(s, 1, AnsiPos('.', s) -1);
  Delete(s, 1, Length(sX) +1);
  TargetControl := sX;
  
  sX := Copy(s, 1, AnsiPos(' := ', s) -1);
  Delete(s, 1, Length(sX) +4);
  TargetProperty := sX;
  
  sX := Copy(s, 1, AnsiPos(';', s) -1);
  Delete(s, 1, Length(sX) +1);
  TargetValue := sX;
end;

initialization
  ReverseList := TStringList.Create;
  {$IFDEF NOGUI}
  rdi := TStringList.Create;
  {$ENDIF}

finalization
  if Assigned(ReverseList) then
    FreeAndNil(ReverseList);
  {$IFDEF NOGUI}
  if Assigned(rdi) then
    FreeAndNil(rdi);
  {$ENDIF}

end.
