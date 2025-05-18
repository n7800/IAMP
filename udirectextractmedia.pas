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
unit uDirectExtractMedia;

{$mode objfpc}{$H+}

interface

uses
  mUtils, SysUtils, uSevenZipAPI, Classes
  {$IFDEF WINDOWS}
  , {$IFNDEF NOGUI}Forms,{$ENDIF} Windows, ShlObj, ActiveX
  {$ENDIF};

type
  TDirectExtractMedia = class(TThread)
  private
    
  protected
    procedure Execute; override;
    procedure SetFinished;
  end;

  TDirectCompressMedia = class(TThread)
  private
    
  protected
    procedure Execute; override;
    procedure SetFinished;
  end;

  TDirectDeleteMedia = class(TThread)
  private
    
  protected
    procedure Execute; override;
    procedure SetFinished;
  end;

var
  tdem: TDirectExtractMedia;
  tcem: TDirectCompressMedia;
  teem: TDirectDeleteMedia;

  thdxWindow: THandle;
  thdxArchive, thdxOutput, thdxPassword: String;
  thdxUsePath, thdxOverwrite, thdxTestOnly: Boolean;
  
  thdxFinished: Boolean;
  thdxExternalResult: Boolean;
  thdxErrorText: String;
  
  thcxWindow: THandle;
  thcxArchive, thcxPassword, thcxParameters, thcxRecursive, thcxNonRecursive: String;
  thcxType, thcxPath: Integer;
  
  thcxFinished: Boolean;
  thcxExternalResult: Boolean;
  thcxErrorText: String;
  
  thexWindow: THandle;
  thexArchive, thexPassword, thexFileSet: String;
  
  thexFinished: Boolean;
  thexExternalResult: Boolean;
  thexErrorText: String;
  
implementation

uses
  mscriptexec, uDlgAPI;

var
  thdxProgress: Integer;
  thdxProgressText: String;
  thdxResult: Boolean;

  thcxProgress: Integer;
  thcxProgressText: String;
  thcxResult: Boolean;

  thexProgress: Integer;
  thexProgressText: String;
  thexResult: Boolean;

function DirectExtractProgress(lpCurrentFileName: PCHAR; uiCompleted, uiTotal: Int64): Integer; stdcall;
var
  i: Integer;
  bY: Boolean;
begin
  
    i := ((uiCompleted * 100) div uiTotal) +1;
    if i >= 100 then thdxProgress := 100
      else thdxProgress := i;
    thdxProgressText := ExtractFileName(lpCurrentFileName) + ', ' + IntToStr(thdxProgress) + msg20;
    DelegateBindProgress(thdxProgressText, thdxProgress, 100, 0);
    {$IFDEF USEVARMANAGER}
    bY := VarManager['MYAH_thCancelled'] = 'TRUE';
    {$ELSE}
    bY := MyStrToBool(GETVARIABLE('MYAH_thCancelled'));
    {$ENDIF}
    if bY then
    begin
      Result := 0;
      
    end
    else
      Result := 1;
    
  {$IFDEF WINDOWS}
  SendMessage(thdxWindow, 0, 0, 0); 
  {$ENDIF}
end;

procedure TDirectExtractMedia.SetFinished;
begin
  thdxFinished := True;
  thdxExternalResult := thdxResult;
end;

procedure TDirectExtractMedia.Execute;
begin
  Enter64BitFileSystem(True);
  try
    
    if not thdxTestOnly then
    begin
      ForceDirectories(thdxOutput);
      thdxResult := ExtractArchiveContents(thdxArchive, PChar(thdxPassword),
        PChar(thdxOutput), thdxUsePath, thdxOverwrite, thdxErrorText, nil,
        @DirectExtractProgress, nil, nil, nil);
    end
    ;
    
  finally
    Leave64BitFileSystem(True);
  end;
  Synchronize(@SetFinished);
  
  {$IFDEF WINDOWS}
  SendMessage(thdxWindow, 0, 0, 0); 
  {$IFNDEF NOGUI}
  SendMessage(Application.Handle, 0, 0, 0); 
  {$ENDIF}
  {$ENDIF}
end;

function DirectCompressProgress(lpCurrentFileName: PCHAR; uiCompleted, uiTotal: Int64): Integer; stdcall;
var
  i: Integer;
  bY: Boolean;
begin
    i := ((uiCompleted * 100) div uiTotal) +1;
    if i >= 100 then thcxProgress := 100
      else thcxProgress := i;
    thcxProgressText := ExtractFileName(lpCurrentFileName) + ', ' + IntToStr(thcxProgress) + msg20;
    DelegateBindProgress(thcxProgressText, thcxProgress, 100, 0);
    {$IFDEF USEVARMANAGER}
    bY := VarManager['MYAH_thCancelled'] = 'TRUE';
    {$ELSE}
    bY := MyStrToBool(GETVARIABLE('MYAH_thCancelled'));
    {$ENDIF}
    if bY then
    begin
      Result := 0;
    end
    else
      Result := 1;
  
  {$IFDEF WINDOWS}
  SendMessage(thcxWindow, 0, 0, 0); 
  {$ENDIF}
end;

procedure TDirectCompressMedia.SetFinished;
begin
  thcxFinished := True;
  thcxExternalResult := thcxResult;
end;

procedure TDirectCompressMedia.Execute;
var
  l, lX: TStringList;
begin
  Enter64BitFileSystem(True);
  try
    l := TStringList.Create;
    lX := TStringList.Create;
    l.Text := thcxNonRecursive;
    lX.Text := thcxRecursive;
    
    thcxResult := CompressArchiveContents(thcxArchive, thcxPassword,
      thcxParameters, thcxType, thcxPath, thcxErrorText, l, lX,
      @DirectCompressProgress, nil);
    lX.Free;
    l.Free;
  finally
    Leave64BitFileSystem(True);
  end;
  Synchronize(@SetFinished);
  
  {$IFDEF WINDOWS}
  SendMessage(thcxWindow, 0, 0, 0); 
  {$IFNDEF NOGUI}
  SendMessage(Application.Handle, 0, 0, 0); 
  {$ENDIF}
  {$ENDIF}
end;

function DirectDeleteProgress(lpCurrentFileName: PCHAR; uiCompleted, uiTotal: Int64): Integer; stdcall;
var
  i: Integer;
  bY: Boolean;
begin
  i := ((uiCompleted * 100) div uiTotal) +1;
  if i >= 100 then thexProgress := 100
    else thexProgress := i;
  thexProgressText := IntToStr(thexProgress) + msg20;
  DelegateBindProgress(thexProgressText, thexProgress, 100, 0);
  {$IFDEF USEVARMANAGER}
  bY := VarManager['MYAH_thCancelled'] = 'TRUE';
  {$ELSE}
  bY := MyStrToBool(GETVARIABLE('MYAH_thCancelled'));
  {$ENDIF}
  if bY then
  begin
    Result := 0;
  end
  else
    Result := 1;
  
  {$IFDEF WINDOWS}
  SendMessage(thexWindow, 0, 0, 0); 
  {$ENDIF}
end;

procedure TDirectDeleteMedia.SetFinished;
begin
  thexFinished := True;
  thexExternalResult := thcxResult;
end;

procedure TDirectDeleteMedia.Execute;
var
  l: TStringList;
begin
  Enter64BitFileSystem(True);
  try
    l := TStringList.Create;
    
    l.Text := thexFileSet;
    l.Free;
  finally
    Leave64BitFileSystem(True);
  end;
  Synchronize(@SetFinished);
  
  {$IFDEF WINDOWS}
  SendMessage(thexWindow, 0, 0, 0); 
  {$IFNDEF NOGUI}
  SendMessage(Application.Handle, 0, 0, 0); 
  {$ENDIF}
  {$ENDIF}
end;

end.
