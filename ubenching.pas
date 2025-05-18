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
unit ubenching;

{$MODE Delphi}
{$IFDEF DARWIN}
{$modeswitch objectivec1}
{$ENDIF}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils,  Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, StdCtrls, ComCtrls, uBenchThread, uBencher, FileLbl{$IFDEF DARWIN}, CocoaAll, MacOSAll, CocoaUtils{$ENDIF};

type

  TBenching = class(TForm)
    Bar: TProgressBar;
    ScanFile: TFileLabel;
    Image1: TImage;
    Label1: TLabel;
    Cancel: TButton;
    Timer: TTimer;
    ScanCount: TLabel;
    RateText: TLabel;
    ElapsedTime: TLabel;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure CancelClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    
  public
    
  end;

var
  
  Benching: TBenching;
  
  CurrentFile, CurrentType: String;
  TotalItems, TotalSeconds: Int64;
  AbortProcess, ScanFinished, ScanSuccess: Boolean;
  WorkThread : TThread; 
  CompareMode: Boolean = false;
  CompareMin, CompareMax, ComparePos, CompareBase: Integer;
  cs: TRTLCriticalSection;

implementation

{$R *.lfm}

var
  BackupCaption: String;

procedure TBenching.FormShow(Sender: TObject);
begin
  Caption := BackupCaption;
  CompareMode := false;
  CurrentFile := '';
  AbortProcess := false;
  Cancel.Enabled := True;
  Cancel.Caption := 'Cancel';
  ScanFinished := false;
  Timer.Enabled := True;
  WorkThread := TUpdateThread.Create(True);
  WorkThread.FreeOnTerminate := True;
  WorkThread.Resume;
end;

procedure TBenching.CancelClick(Sender: TObject);
begin
  WorkThread.Terminate;
  Cancel.Enabled := false;
  Cancel.Caption := 'Wait';
  Application.ProcessMessages;
  EnterCriticalSection(cs);
  AbortProcess := True;
  LeaveCriticalSection(cs);
  Halt(0);
end;

procedure TBenching.TimerTimer(Sender: TObject);
var
  i: Int64;
  iX, iY, iZ: Integer;
  s, sX: String;
  b, bX, bY: Boolean;
  LHours, LMinutes, LSeconds : Integer;
begin
  EnterCriticalSection(cs);
  s := CurrentFile;
  sX := CurrentType;
  i := TotalItems;
  iZ := CompareMax;
  iY := ComparePos;
  b := CompareMode;
  bX := ScanFinished;
  bY := ScanSuccess;
  LeaveCriticalSection(cs);
  if b then
  begin
    if Bar.Style <> pbstNormal then
      Bar.Style := pbstNormal;
    if Bar.Max <> iZ then
      Bar.Max := iZ;
    if Bar.Min <> CompareMin then
      Bar.Min := CompareMin; 
    if Bar.Position <> iY then
      Bar.Position := iY;
  end
  else
    if Bar.Style <> pbstMarquee then
    begin
      Bar.Min := 0;
      Bar.Max := 100;
      Bar.Position := 0;
      Application.ProcessMessages;
      Bar.Style := pbstMarquee;
      
    end;
  ScanFile.FileName := s;
  if i <> 0 then
    ScanCount.Caption := sX + ' ' + Format('%.0n', [i + 0.0])
  else
    ScanCount.Caption := sX;
  RateText.Visible := AnsiPos('Delta', s) = 0;
  if RateText.Visible then
  begin
    EnterCriticalSection(cs);
    TotalSeconds := TotalSeconds +1;
    iX := TotalSeconds;
    LeaveCriticalSection(cs);
  end;
  if iX <> 0 then
  begin
    if CompareMode then
      RateText.Caption := 'Ops Per Second: ' + Format('%.0n', [Bar.Position *1024 div iX + 0.0])  + ' (this value shall gradually decrease, settling into your final score)'
    else
      RateText.Caption := '';
  end
  else
    RateText.Caption := '';
  if bX then
  begin
    Timer.Enabled := false;
    if not bY then
      ClearScanObjects;
    Close; 
    
    Bar.Style := pbstNormal;
    Bar.Min := 0;
    Bar.Max := 100;
    Bar.Position := 100;
    {$IFDEF DARWIN}
    NSApplication.sharedApplication.postEvent_AtStart(
      nsEvent.otherEventWithType_location_modifierFlags_timestamp_windowNumber_context_subtype_data1_data2(NSApplicationDefined,
      GetNSPoint(0,0), 0, NSTimeIntervalSince1970, 0, nil, 0, 0, 0), True);
    {$ENDIF}
  end
  else
  begin
    LHours := (iX div 3600) mod 24;
    LMinutes := (iX div 60) mod 60;
    LSeconds := iX mod 60;
    ElapsedTime.Caption := 'Phase Time Elapsed: ';
    if LHours > 0 Then
      ElapsedTime.Caption := ElapsedTime.Caption + IntToStr(LHours) + ' Hours, ';
    if LMinutes > 0 Then
      ElapsedTime.Caption := ElapsedTime.Caption + IntToStr(LMinutes) + ' Minutes, ';
    ElapsedTime.Caption := ElapsedTime.Caption + IntToStr(LSeconds) + ' Seconds';
  end;
end;

procedure TBenching.FormCreate(Sender: TObject);
begin
  ScanFile.Separator := PathDelim;
  BackupCaption := Caption;
end;

procedure TBenching.FormClose(Sender: TObject; var CloseAction: TCloseAction);
begin
end;

initialization
  InitCriticalSection(cs);

finalization
  DoneCriticalSection(cs);

end.
