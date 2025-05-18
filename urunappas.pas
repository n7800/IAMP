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
unit uRunAppAs;

{$MODE Delphi}

interface

uses
  {$IFNDEF NOGUI}LCLIntf, LMessages, Forms,{$ENDIF} LCLType, Classes, SysUtils,
  Process, mUtils, LazFileUtils, Math{$IFNDEF WINDOWS}, BaseUnix{$ENDIF};

type
  TRunAs = class(TThread)
  private
    
  protected
    procedure Execute; override;
    procedure SetFinished;
  end;

var
  trax: TRunAs;
  
  raxCmd, raxFolder, raxParams: String;
   raxEnv, raxLog: String;
  raxWindow: Integer;
  raxWait, raxElev, raxCap: Boolean;
  
  raxOut: Integer;
  raxFinished: Boolean;

implementation

uses
  mscriptexec;

procedure TRunAs.Execute;
var
  
  i, j: Integer;
  t, tX: TextFile;
  p: TProcess;
  sl, l: TStringList;
  c: array[1..2048] of Char;
  s, sX, sY, sZ, sEx: String;
begin
  Enter64BitFileSystem(True);
  try
    {$IFNDEF WINDOWS}
    if AnsiPos('~', raxCmd) = 1 then
      raxCmd := ExpandFileName(raxCmd);
    if AnsiPos('~', raxLog) = 1 then
      raxLog := ExpandFileName(raxLog);
    if AnsiPos('~', raxFolder) = 1 then
      raxFolder := ExpandFileName(raxFolder);
    {$ENDIF}
    {$IFDEF DARWIN}
    
    s := AnsiLowerCase(raxCmd);
    if AnsiPos('.app', s) <> 0 then
      if AnsiPos('.app', s) = Length(s) -3 then
      begin
        sX := raxCmd;
        sX := ExtractFileNameOnly(sX);
        sZ := s + '/Contents/';
        sY := sZ + 'MacOS/';
        s := sY + sX;
        
        raxCmd := s;
        if not MyFileExists(raxCmd) then
        begin
          l := MyFindAllFiles(sY, '*', false);
          for i := l.Count downto 1 do
            if not FileIsExecutable(l[i -1]) then
              l.Delete(i -1);
          
          if l.Count = 1 then
            raxCmd := l[i -1]
          else
            
            if MyFileExists(sZ + 'Info.plist') then
            begin
              AssignFile(t, sZ + 'Info.plist');
              Reset(t);
              while not EOF(t) do
              begin
                ReadLn(t, sEx);
                sEx := Trim(sEx);
                if AnsiCompareText('<key>CFBundleExecutable</key>', sEx) = 0 then
                  if not EOF(t) then
                  begin
                    ReadLn(t, sEx);
                    sEx := Trim(sEx);
                    sEx := StringReplace(sEx, '<string>', '', [rfIgnoreCase, rfReplaceAll]);
                    sEx := StringReplace(sEx, '</string>', '', [rfIgnoreCase, rfReplaceAll]);
                    raxCmd := sY + sEx;
                    Break;
                  end;
              end;
              CloseFile(t);
            end;
          l.Free;
        end;
      end;
    {$ENDIF}
    if raxElev and ({$IFNDEF WINDOWS}FpGetEUID <> 0{$ELSE}not IsUserAdmin{$ENDIF}) then
    begin
      sl := ParseWhiteSpaceIntoMultipleStrings(raxParams);
      if raxFolder <> '' then
      begin
        GetDir(0, sY);
        ChDir(raxFolder);
      end;
      globElevatorEx(raxCmd, sl, raxWait, raxOut);
      if raxFolder <> '' then
        ChDir(sY);
      sl.Free;
    end
    else
    begin
      p := TProcess.Create(nil);
      p.Executable := raxCmd;
      sl := ParseWhiteSpaceIntoMultipleStrings(raxParams);
      p.Parameters.Text := sl.Text;
      sl.Free;
      p.CurrentDirectory := raxFolder;
      sl := ParseWhiteSpaceIntoMultipleStrings(raxEnv);
      for j := 1 to GetEnvironmentVariableCount do
        sl.Add(GetEnvironmentString(j));
      p.Environment.Text := sl.Text;
      
      sl.Free;
      {$IFDEF WINDOWS}
      case raxWindow of
        
        0: p.ShowWindow := swoShowDefault;
        1: p.ShowWindow := swoHIDE;
        2: p.ShowWindow := swoShowMaximized;
        3: p.ShowWindow := swoShowMinimized;
        4: p.ShowWindow := swoshowMinNOActive;
      end;
      {$ENDIF}
      
      {$IFNDEF NOGUI}
      p.Options := p.Options + [poNoConsole];
      p.Options := p.Options - [poNewConsole];
      {$ENDIF}
      if raxCap then
      begin
        p.Options := [poUsePipes, poStderrToOutPut];
        if raxLog <> '' then
        try
          AssignFile(tX, raxLog);
          ReWrite(tX);
        except;
          raxLog := '';
        end;
      end
      else
        raxLog := '';
      p.Execute;
      if raxCap then
      begin
        sX := '';
        while p.Running or (p.Output.NumBytesAvailable > 0) do
        begin
          while p.Output.NumBytesAvailable > 0 do
          begin
            i := Min(2048, p.Output.NumBytesAvailable); 
            p.Output.Read(c, i);
            s := Copy(c, 1, i);
            if raxLog <> '' then
              Write(tX, s);
            SetVariable('PROGRESSTEXT', sX + s, 'Run Program As Progress Loop String');
            
            if AnsiPos('%', s) <> 0 then
            begin
              Delete(s, 1, AnsiPos('%', s));
              if AnsiPos(' ', s) <> 0 then
                Delete(s, AnsiPos(' ', s), Length(s));
              if TryStrToInt(s, i) then
                SetVariable('PROGRESS', IntToStr(i), 'Run Program As Progress Loop Integer');
            end;
            sX := s;
            if AnsiPos(LineEnding, sX) <> 0 then
            repeat
              Delete(sX, 1, AnsiPos(LineEnding, sX) + Length(LineEnding) -1);
            until AnsiPos(LineEnding, sX) = 0;
            Sleep(314);
          end;
          Sleep(213);
        end;
        if raxLog <> '' then
          CloseFile(tX);
      end
      else
        if raxWait then
          p.WaitOnExit;
      if raxWait then
        raxOut := p.ExitCode;
      p.Free;
    end;
  finally
    Leave64BitFileSystem(True);
  end;
  Synchronize(SetFinished);
  {$IFNDEF LINUX}
  {$IFNDEF NOGUI}
  SendMessage(Application.Handle, 0, 0, 0); 
  {$ENDIF}
  {$ENDIF}
end;

procedure TRunAs.SetFinished;
begin
  raxFinished := True;
end;

end.
