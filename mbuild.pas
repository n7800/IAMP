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
unit mbuild;

{$MODE Delphi}
{$IFDEF DARWIN}
{$modeswitch objectivec1}
{$ENDIF}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils,
  Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, mbuildthread, ComCtrls, Buttons,
  ExtCtrls, mUtils{$IFDEF DARWIN}, MacOSAll, CocoaAll,
  CocoaUtils{$ENDIF};

type

  TBuild = class(TForm)
    Cancel: TBitBtn;
    Output: TMemo;
    Timer: TTimer;
    CancelTimer: TTimer;
    Image14: TImage;
    Label6: TLabel;
    TimerEx: TTimer;
    procedure TimerExTimer(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure CancelTimerTimer(Sender: TObject);
  private
    
  public
    procedure SetBuildAnimate(Kind, State: Integer);
    procedure OutputLinesAdd(Element: String);
  end;

function SevenZipProgress(lpCurrentFileName: PCHAR; uiCompleted, uiTotal: Int64): Integer; stdcall;

var
  IsConsole: Boolean = false;
  IsConsoleEx: Boolean = false;
  Build: TBuild;
  BuildThread: TBuildThread;
  szrcs: TRTLCriticalSection;
  szFirst7Zip: Boolean;
  szMode: String;
  LastCmdFile: String = '';
  
  csGlobPwd: String;
  ConsoleBuildMirrorBuffer: TStringList;
  ConsoleBuildMirrorBufferFile: String = '';
  
  FirstShowPing: Boolean = false;

implementation

{$R mbuild.lfm}

uses
  {$IFNDEF EXPRESSX}
  uGui, moptions,
  {$ENDIF}
  mautomate, mscriptexec;

resourcestring
  SCompressing = 'Compressing ';
  SDefault = 'Default';
  SNone = 'None';
  SFast = 'Fast';
  SFair = 'Fair';
  SGood = 'Good';
  SBest = 'Best';
  SBuildingProject = 'Building Project: ';
  SPleaseChooseAValidBuildFolder = 'Please choose a valid build folder';
  SUnableToCreateBuildFolder = 'Unable to create build folder';
  SOutputFolder = 'Output Folder: ';
  SUncompressedDirectoryLayout = 'Uncompressed Directory Layout';
  SCompressedSingleSelfInstallingEX = 'Compressed Single Self Installing EXE';
  SCompressedWebBasedEXE = 'Compressed Web-Based EXE';
  SPatch = 'Patch';
  SDebugBuild = ' [debug build]';
  SDeploymentType = 'Deployment Type: ';
  SEnabled = 'Enabled';
  SDisabled = 'Disabled';
  SCodeSigning = 'Code Signing: ';
  S256BitAESEncrypted = ' (256-Bit AES Encrypted)';
  SCompression = 'Compression: ';
  SCompilerVariables = 'Compiler Variables: ';
  SErrorDuringBuild = 'Error during build: ';
  SERROR = 'ERROR: ';
  SWait = 'Wait';

var
  LastszFileName: String;
  szFileName: String;
  szPercent: Int64;
  szPing: Boolean;
  
  GlobSignHandle, GlobOKHandle: DWORD;
  GlobSignCount, GlobStatic, GlobButton, GlobEdit, GlobOther: DWORD;
  GlobRect: TRect;

function SevenZipProgress(lpCurrentFileName: PCHAR; uiCompleted, uiTotal: Int64): Integer; stdcall;
begin
  {$IFDEF SPAIN}
  Write(#8#8#8#8);
  Write((((uiCompleted div 1024) + 1) * 100) div ((uiTotal div 1024) +1), '%');
  Result := 1;
  {$ELSE}
  if mbuild.IsConsole and (not mBuild.IsConsoleEx) then
  begin
    if LastCmdFile  <> lpCurrentFileName then
    
    begin
      
      LastCmdFile := lpCurrentFileName;
      WriteLn(SCompressing + lpCurrentFileName);
      if ConsoleBuildMirrorBufferFile <> '' then
        ConsoleBuildMirrorBuffer.Add(SCompressing + lpCurrentFileName);
    end;
    Result := 1;
    Exit;
  end;
  if szPing then
  begin
    if Cancelled then Result := 0
      else Result := 1;
    Exit;
  end;
  try
    
    szFileName := lpCurrentFileName;
    szPercent := (((uiCompleted div 1024) + 1) * 100) div ((uiTotal div 1024) +1);
    if szPercent < 0 then szPercent := 0
      else if szPercent > 100 then szPercent := 100;
    szPing := True;
    if Cancelled then Result := 0
      else Result := 1;
  finally
    
  end;
  {$ENDIF}
end;

function GetVerbalStrength(Index: String): String;
begin
  Result := SDefault;
  if Index = '0' then Result := SNone;
  if Index = '1' then Result := SFast;
  if Index = '2' then Result := SFair;
  if Index = '3' then Result := SGood;
  if Index = '4' then Result := SBest;
end;

procedure TBuild.FormShow(Sender: TObject);
var
  Error: String;
  s, sX, sY: String;
  thXProject: TProjectStruct;
begin
  try
    
    szMode := '';
    LastszFileName := '';
    szFileName := '';
    szPercent := 0;
    szPing := false;
    
    if not (mbuild.IsConsole or mBuild.IsConsoleEx) then
    begin
      Output.SetFocus;
    end;
    Cancel.Kind := bkCancel;
    Cancel.ModalResult := mrNone;
    Cancel.Glyph.Assign(nil);
    Error := '';
    
    thXProject := thProjectStruct;
    SubstituteCompilerVariablesEx(thProjectStruct.BuildCustomFolder, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.OutputFile, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.Manufacturer, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.Name, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.Code, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.UpgradeCode, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.Version, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.Language, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.Title, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.Subject, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.Author, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.Comments, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.Revision, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.arPublisher, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.arContact, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.arHelp, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.arUpdates, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.arComments, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.aCertificate, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.aKey, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.aTimeStamp, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.aInfo, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.pDisplay, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.pDescription, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.pClass, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.Password, thProjectStruct.Conditionals);
    SubstituteCompilerVariablesEx(thProjectStruct.CodeSignPassword, thProjectStruct.Conditionals);
    
    if not (mbuild.IsConsole or mBuild.IsConsoleEx) then
    begin
      Output.Lines.Clear;
    end;
    
    OutputLinesAdd(SBuildingProject + thProjectStruct.Name);
    if not thProjectStruct.BuildInFolder then
      thBuildToFolder := thProjectStruct.BuildCustomFolder
    else
    begin
      if thCurrentProjectName = '' then
        thBuildToFolder := EXEDIR
      else
        thBuildToFolder := PROJDIR;
    end;
    if thBuildToFolder = '' then Error := SPleaseChooseAValidBuildFolder
      else if not DirectoryExists(thBuildToFolder) then
      begin
        ForceDirectories(thBuildToFolder);
        if not DirectoryExists(thBuildToFolder) then
          Error := SUnableToCreateBuildFolder;
      end;
    if thProjectStruct.BuildLayout = 3 then
      thBuildToFolder := AssertDir(thBuildToFolder) + 'Patch' + DirectorySeparator
    else
      thBuildToFolder := AssertDir(thBuildToFolder) + 'Release' + DirectorySeparator;
    if thProjectStruct.BuildLayout = 0 then
      thBuildToFolder := thBuildToFolder + 'Uncompressed' + DirectorySeparator;
    if thProjectStruct.BuildLayout = 1 then
      thBuildToFolder := thBuildToFolder + 'Single' + DirectorySeparator;
    if thProjectStruct.BuildLayout = 2 then
      thBuildToFolder := thBuildToFolder + 'Web' + DirectorySeparator;
    SetBuildAnimate(thProjectStruct.BuildLayout, 0);
    OutputLinesAdd(SOutputFolder + thBuildToFolder);
    if thProjectStruct.BuildLayout = 0 then
      s := SUncompressedDirectoryLayout;
    if thProjectStruct.BuildLayout = 1 then
      s := SCompressedSingleSelfInstallingEX;
    if thProjectStruct.BuildLayout = 2 then
      s := SCompressedWebBasedEXE;
    if thProjectStruct.BuildLayout = 3 then
      s := SPatch;
    if thProjectStruct.BuildDebug then
      s := s + SDebugBuild;
    BuildForm := thProjectStruct.BuildLayout;
    if (BuildForm = 0) or (BuildForm = 1) then
    begin
      if thProjectStruct.BuildDebug = false then
        try
          BuildFormEx := StrToBool(SubstituteCompilerVariables('#CACHESOURCES#', thProjectStruct.Conditionals));
        except
          BuildFormEx := false;
        end;
    end
    else
      BuildFormEx := false;
    OutputLinesAdd(SDeploymentType + s);
    if thProjectStruct.aSign then
      s := SEnabled
    else
      s := SDisabled;
    OutputLinesAdd(SCodeSigning + s);
    {$IFNDEF EXPRESSX}
    
    {$ENDIF}
    CompressionProfile := thProjectStruct.CompressProfile;
    if thProjectStruct.PassEnabled and (thProjectStruct.Password <> '') then
      sX := S256BitAESEncrypted
    else
      sX := '';
    OutputLinesAdd(SCompression + GetVerbalStrength(thProjectStruct.CompressProfile) + sX);
    if thProjectStruct.Conditionals <> '' then
      OutputLinesAdd(SCompilerVariables + thProjectStruct.Conditionals);
    OutputLinesAdd('###');
  except
    on E: Exception do
      Error := SErrorDuringBuild + E.Message;
  end;
  if Error <> '' then
  begin
    if not (mbuild.IsConsole and (not mBuild.IsConsoleEx)) then Application.MessageBox(PChar(Error),
      PChar(Application.Title), mb_OK + mb_IconStop)
    else
    begin
      WriteLn(SERROR + Error);
      WriteLn;
      if ConsoleBuildMirrorBufferFile <> '' then
      begin
        ConsoleBuildMirrorBuffer.Add(SERROR + Error);
        ConsoleBuildMirrorBuffer.Add('');
      end;
    end;
    
      CancelTimer.Enabled := True;
    Exit;
  end;
  
  Cancel.Kind := bkCancel;
  Cancel.Glyph.Assign(nil);
  BuildFinished := false;
  Cancelled := false;
  Success := false;
  Cancel.Enabled := True;
  
  BuildThread := TBuildThread.Create(false);
  if mbuild.IsConsole and (not mBuild.IsConsoleEx) then
  begin
    BuildThread.WaitFor;
    
    if Success then
      ModalResult := mrOk
    else
      ModalResult := mrCancel;
  end
  else
  begin
    FirstShowPing := false;
    Timer.Enabled := True;
  end;
end;

procedure TBuild.TimerTimer(Sender: TObject);
var
  s: String;
  i: Integer;
  m: TMessage;
begin
  Timer.Enabled := false;
  if not FirstShowPing then
  begin
    FirstShowPing := True;
    {$IFNDEF CMDBUILD}
    
    {$ENDIF}
  end;
  if szPing and not Cancelled then
  begin
    try
      
      s := szMode + szFileName + ' (' + IntToStr(szPercent) + '%)';
      
      if not (mbuild.IsConsole or mBuild.IsConsoleEx) then
      begin
      end;
      if LastszFileName <> szFileName then
      begin
        LastszFileName := szFileName;
        if szFirst7Zip then
        begin
          szFirst7Zip := false;
          OutputLinesAdd(s);
        end
        else
          for i := Output.Lines.Count downto 0 do
            if AnsiPos(szMode, Output.Lines[i -1]) = 1 then
            begin
              Output.Lines.Insert(i, s);
              Break;
            end;
      end;
      
    finally
      
    end;
    szPing := false;
  end;
  if BuildFinished then
  begin
    
    if Success then
    begin
      
      MyPlaySound(PChar(EXEDIR + 'audio' + PathDelim + 'build_successful.wav'));
      ModalResult := mrOk;
      
      {$IFDEF DARWIN}
      NSApplication.sharedApplication.postEvent_AtStart(
        nsEvent.otherEventWithType_location_modifierFlags_timestamp_windowNumber_context_subtype_data1_data2(NSApplicationDefined,
        GetNSPoint(0,0), 0, NSTimeIntervalSince1970, 0, nil, 0, 0, 0), True);
      {$ENDIF}
      
      Exit;
      
    end
    else
    begin
      MyPlaySound(PChar(EXEDIR + 'audio' + PathDelim + 'build_errors.wav'));
      
      Cancel.Kind := bkClose;
      Cancel.Glyph.Assign(nil);
      Cancel.Enabled := True;
      if IsConsole then
        ModalResult := mrCancel;
      Exit;
    end;
  end
  else
    Timer.Enabled := True;
end;

procedure TBuild.CancelClick(Sender: TObject);
begin
  if Cancel.Kind = bkClose then
  begin
    ModalResult := mrCancel;
    Exit;
  end;
  Cancelled := True;
  Cancel.Enabled := false;
  Cancel.Caption := SWait;
end;

procedure TBuild.CancelTimerTimer(Sender: TObject);
begin
  CancelTimer.Enabled := false;
  ModalResult := mrCancel;
end;

procedure TBuild.SetBuildAnimate(Kind, State: Integer);
begin
end;

procedure TBuild.OutputLinesAdd(Element: String);
begin
  if not (mbuild.IsConsole and (not mBuild.IsConsoleEx)) then
    Output.Lines.Add(Element)
  else
  begin
    WriteLn(Element);
    if ConsoleBuildMirrorBufferFile <> '' then
      ConsoleBuildMirrorBuffer.Add(Element);
  end;
end;

procedure TBuild.TimerExTimer(Sender: TObject);
var
  hT: THandle;
  p: PChar;
begin
  if not (mbuild.IsConsole and (not mBuild.IsConsoleEx)) then
    TimerEx.Enabled := false;
  GetMem(p, (MAX_PATH+1)*8);
  GlobSignHandle := 0;
  FreeMem(p);
  if not (mbuild.IsConsole and (not mBuild.IsConsoleEx)) then
    TimerEx.Enabled := True;
end;

initialization
  
  ConsoleBuildMirrorBuffer := TStringList.Create;

finalization
  
  ConsoleBuildMirrorBuffer.Free;

end.

