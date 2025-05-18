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
unit uguibench;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms, MTPCPU,
  Dialogs, ExtCtrls, StdCtrls, mUtils, uBencher, ComCtrls, uBenchGlobals
  {$IFNDEF WINDOWS}, BaseUnix{$ENDIF};

type

  TGuiPA = class(TForm)
    Image1: TImage;
    Label1: TLabel;
    Label2: TLabel;
    Notebook: TNotebook;
    p1: TPage;
    p2: TPage;
    p3: TPage;
    p4: TPage;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label7: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    LoadingScan: TLabel;
    Label19: TLabel;
    SaveDialog: TSaveDialog;
    procedure ScanSettingsClick(Sender: TObject);
    procedure ReScanChangesClick(Sender: TObject);
    procedure PostScanClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ReBaseLineClick(Sender: TObject);
    procedure PreScanClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
  private
    
  public
    procedure CheckGui;
  end;

var
  GuiPA: TGuiPA;

implementation

uses uBenching, uGuiBar;

{$IFnDEF FPC}
  {$R *.lfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

function MakeGuid: String;
begin
  Result := MyCreateGuid;
end;

procedure TGuiPA.PreScanClick(Sender: TObject);
begin
  Benching.ShowModal;
  CheckGui;
end;

procedure TGuiPA.ReBaseLineClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('Are you sure you wish to redo the baseline scan?' + #13#13 +
    'Do this only if you haven''t already run the installation to convert.'),
    PChar(Application.Title), mb_YesNo + mb_IconQuestion) = id_Yes then
  begin
    ClearScanObjects;
    Benching.ShowModal;
    CheckGui;
  end;
end;

procedure TGuiPA.CheckGui;
var
  s: String;
  b: Boolean;
  t, tX: TextFile;
  i, j, k, kX, kY: Integer;
  l, lX: TStringList;
begin
  l := TStringList.Create;
  Notebook.PageIndex := 0;
  try
    if MyFileExists(DataDir + 'postscan') then
    begin
      if MyFileExists(DataDir + 'prescan') then
      begin
        Notebook.PageIndex := 3;
        l.LoadFromFile(DataDir + 'index');
        for i := 1 to l.Count do
        begin
          LoadingScan.Caption := 'Drive ' + l[i -1];
          Application.ProcessMessages;
          if MyFileExists(DataDir + 'Added' + l[i -1]) then
          begin
            DeleteFile(DataDir + 'Added' + l[i -1]);
            DeleteFile(DataDir + 'Modified' + l[i -1]);
            DeleteFile(DataDir + 'Removed' + l[i -1]);
          end
          else
          begin
            
            l.LoadFromFile(DataDir + 'index');
            for j := 1 to l.Count do
              if MyFileExists(DataDir + l[j -1]) then
                LoadScanObject('PreScan' + l[j -1],
                  DataDir + l[j -1]);
            PostScanClick(Self);
            Exit;
          end;
        end;
        Notebook.PageIndex := 2;
        Label13.Caption := StringReplace(
          StringReplace(Benching.RateText.Caption,
            ' (this value shall gradually decrease, settling into your final score)',
            '', [rfReplaceAll, rfIgnoreCase]),
          'Ops Per Second: ', '', [rfReplaceAll, rfIgnoreCase]);
        Label15.Caption := 'Benchmark ' + StringReplace(Benching.ElapsedTime.Caption,
          'Phase ', '', [rfReplaceAll, rfIgnoreCase]);
        if ParamStr(1) <> '' then
        begin
          AssignFile(t, DataDir + 'log.txt');
          if MyFileExists(DataDir + 'log.txt') then
            Append(t)
          else
            ReWrite(t);
          WriteLn(t, Label13.Caption);
          CloseFile(t);
          if StrToInt(ParamStr(1)) = 1 then
          begin
            k := 0;
            kX := 0;
            AssignFile(t, DataDir + 'log.txt');
            Reset(t);
            while not EOF(t) do
            begin
              ReadLn(t, kY);
              kX := kX + kY;
              k := k +1;
            end;
            CloseFile(t);
            Erase(t);
            kX := kX div k;
            Label13.Caption := IntToStr(kX);
            Label15.Caption := 'Total benchmark runs: ' + IntToStr(k);
            Exit;
          end;
          lX := TStringList.Create;
          lX.Add(IntToStr(StrToInt(ParamStr(1)) -1));
          repeat
            s := '';
            b := false;
            LaunchAppAndWait4('/bin/bash', '"' + AssertDir(ExtractFilePath(MyParamStr(0))) + 'qb.sh"',
              AssertDir(ExtractFilePath(MyParamStr(0))), True, True);
            AssignFile(tX, AssertDir(ExtractFilePath(MyParamStr(0))) + 'qb.txt');
            Reset(tX);
            while not EOF(tX) do
            begin
              ReadLn(tX, s);
              if AnsiPos('discharging', s) <> 0 then
              begin
                b := True;
                Break;
              end;
            end;
            CloseFile(tX);
            Application.ProcessMessages;
            Sleep(3141);
          until b;
          LaunchAppAndWait2(MyParamStr(0), lX, True, false);
          Application.Terminate;
          lX.Free;
        end;
      end
      else
      begin
        raise Exception.Create('Unable to locate scans!');
      end;
    end
    else
    if MyFileExists(DataDir + 'prescan') then
    begin
      Notebook.PageIndex := 3;
      l.LoadFromFile(DataDir + 'index');
      for i := 1 to l.Count do
      begin
        LoadingScan.Caption := 'Drive ' + l[i -1];
        Application.ProcessMessages;
        if MyFileExists(DataDir + l[i -1]) then
          LoadScanObject('PreScan' + l[i -1],
            DataDir + l[i -1])
        else
          Exit;
      end;
      Notebook.PageIndex := 1;
    end;
  finally
    l.Free;
  end;
end;

procedure TGuiPA.FormShow(Sender: TObject);
begin
  Label2.Caption := StringReplace(Label2.Caption, '32', IntToStr(GetSystemThreadCount), [rfReplaceAll, rfIgnoreCase]);
  {$IFDEF LINUX}
  Label2.Caption := StringReplace(Label2.Caption, 'current', 'Linux', [rfReplaceAll, rfIgnoreCase]);
  {$ELSE}
  {$IFDEF WINDOWS}
  Label2.Caption := StringReplace(Label2.Caption, 'current', 'Windows', [rfReplaceAll, rfIgnoreCase]);
  {$ELSE}
  Label2.Caption := StringReplace(Label2.Caption, 'current', 'macOS', [rfReplaceAll, rfIgnoreCase]);
  {$ENDIF}
  {$ENDIF}
  CheckGUI;
end;

procedure TGuiPA.PostScanClick(Sender: TObject);
begin
  Benching.ShowModal;
  CheckGui;
end;

procedure TGuiPA.ReScanChangesClick(Sender: TObject);
begin
  if Application.MessageBox(PChar('Are you sure you wish to redo the changes scan?' + #13#13 +
    'Do this only if you forgot to install some parts of the setup you are capturing.'),
    PChar(Application.Title), mb_YesNo + mb_IconQuestion) = id_Yes then
  begin
    ClearScanObjects;
    DeleteFile(DataDir + 'postscan');
    CheckGui;
    Benching.ShowModal;
    CheckGui;
  end;
end;

procedure TGuiPA.ScanSettingsClick(Sender: TObject);
begin
  frmSettings.ShowModal;
end;

function RefactorPaths(Items: TStrings; var SniffedProduct, SniffedCompany, SniffedShortcut: String): TStringList;
var
  b: Boolean;
  s, sX: String;
  i, j: Integer;
  l, lX: TStringList;
begin
  Result := nil;
  
  l := TStringList.Create;
  lX := TStringList.Create;
  l.CommaText := Items.CommaText;
  while l.Count > 0 do
  begin
    s := '';
    repeat
      j := 0;
      for i := l.Count downto 1 do
      begin
        b := True;
        
        sX := DeAssertDir(ExtractFilePath(l[i -1]));
        if (Length(sX) > 2) and (ExtractFileName(l[i -1]) <> '') then 
          if sX[Length(sX)] <> '$' then 
          begin
            
            if s = '' then
              s := sX
            else
            begin
              
              if AnsiPos(sX, s) <> 0 then
                s := sX
              else
                
                if AnsiPos(s, sX) = 0 then
                  b := false;
            end;
          end;
        if b then
        begin
          l.Delete(i -1);
          j := j +1;
        end;
      end;
    until j = 0;
    lX.Add(s);
    sX := s;
  end;
  
  Result := TStringList.Create;
  for i := 1 to lX.Count do
    if ReverseInjectCommand(lX[i -1]) <> '' then
      if Result.IndexOf(ReverseInjectCommand(lX[i -1])) = -1 then
        Result.Add(ReverseInjectCommand(lX[i -1]));
  if Result.Count = 0 then
  begin
    Result.Free;
    Result := nil;
  end;
  
  {$IFNDEF DARWIN} 
  SniffCompanyProduct(lX, Items, '$PROGRAMFILES$', '$TARGETDIR$', s, sX);
  {$ELSE}
  SniffCompanyProduct(lX, Items, '$COMMONFILES$', '$TARGETDIR$', s, sX);
  {$ENDIF}
  if sX = '' then
  begin
    SniffedCompany := 'My Company';
    SniffedProduct := 'My Repackaged Installation';
  end
  else
  begin
    SniffedCompany := s;
    SniffedProduct := sX;
  end;
  {$IFNDEF DARWIN} 
  SniffCompanyProduct(lX, Items, '$STARTMENU$', '$PLATFORMMENU$', s, sX);
  if sX = '' then                                   
    SniffCompanyProduct(lX, Items, '$STARTMENUALL$', '$PLATFORMMENU$', s, sX);
  {$ELSE}
  SniffCompanyProduct(lX, Items, '$COMMONFILES$', '$PLATFORMMENU$', s, sX);
  {$ENDIF}
  if sX = '' then
    SniffedShortcut := 'My Company' + PathDelim + 'My Repackaged Installation'
  else
  begin
    if s = '' then
      SniffedShortcut := sX
    else
      SniffedShortcut := s + PathDelim + sX;
  end;
  l.Free;
  lX.Free;
end;

procedure TGuiPA.FormClose(Sender: TObject; var Action: TCloseAction);
var
  t: TextFile;
begin
  FileExclude.SaveToFile(DataDir + 'fileexclude.txt');
end;

end.
