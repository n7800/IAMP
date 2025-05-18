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

unit umiaWebForm;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, mUtils, LCLIntf, Math
  {$IFNDEF NOGUI}, Forms, Controls, Graphics, Dialogs, StdCtrls, ComCtrls{$ENDIF}
  {$IFDEF DARWIN}
  , ns_url_request
  {$ENDIF}
  {$IF FPC_FULLVERSION < 30200}
  , ssockets
  , sslsockets
  {$ENDIF}
  ;

type
  TDownloadProgress = function(SmartPosition: Integer; Text: String): Boolean; stdcall;

  TDownload = record
    URL: String;
    Filename: String;
  end;

{$IFNDEF NOGUI}

  TmiaWebForm = class(TForm)
    lblTop: TLabel;
    lblDownloads: TLabel;
    pbDownloads: TProgressBar;
    lblBytes: TLabel;
    pbBytes: TProgressBar;

    procedure FormCreate(Sender: TObject);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: Boolean);
    procedure FormActivate(Sender: TObject);
  private

{$IF FPC_FULLVERSION < 30200}
    procedure GetSocketHandler(Sender: TObject; const UseSSL: Boolean;
      out AHandler: TSocketHandler);
{$ENDIF}
  public
    FSize: Int64;
    FDownloads: Array of TDownload;
    FAllDone: Boolean;
    FGrape: Int64;
    procedure DataReceived(Sender : TObject; Const ContentLength, CurrentPos : Int64);
    function DoDownload(const AIndex: Integer; Resume: Boolean;
      Server, Port, User, Pass: String): Boolean;
    procedure AddDownload(const AURL, AFilename: String);
  end;
{$ELSE}
  
  TWebEventHandler = class
    class procedure DataReceived(Sender : TObject; Const ContentLength, CurrentPos : Int64);
  end;
{$ENDIF}

var
  {$IFNDEF NOGUI}
  miaWebForm: TmiaWebForm;
  {$ELSE}
  FAllDone: Boolean;
  FDownloads: Array of TDownload;
  pbBytesPosition: UInt64;
  FSize: Int64;
  FGrape: Int64;
  {$ENDIF}
  CallbackWindow: THandle;
  down, Total, Progress: Int64;
  Callback: TDownloadProgress;
  LocalFileName: String;

procedure PrepDownload;
procedure CleanDownload;
function FileDownloadFile(URL, Local, Server, Port, User, Pass: String;
  thyResume: Boolean; Progress: TDownloadProgress): Boolean;
function FormatSize(Size, Space: Int64): String;

implementation

uses
  fphttpclient
{$IF FPC_FULLVERSION >= 30200}
, opensslsockets
{$ELSE}
, fpopenssl
, openssl
{$ENDIF}
  , uDlgAPI;

var
  thyResult: Boolean;
  thyProgress: Integer;
  thyProgressText: String;

{$R *.lfm}

{$IFDEF NOGUI}class{$ENDIF} procedure {$IFNDEF NOGUI}TmiaWebForm{$ELSE}TWebEventHandler{$ENDIF}.DataReceived(Sender: TObject; const ContentLength,
  CurrentPos: Int64);
var
  currentPercent: Double;
  i64: Int64;
  s: String;
begin
  
  down := FGrape + CurrentPos;
  Total := FSize;
  if Total <> 0 then
    i64 := ((down * 100) div Total) +1
  else
    i64 := (i64 +1) mod 101;
  if i64 > 100 then i64 := 100;
  s := FormatSize(down, 3) + ' ' + msg21;
  if Total <> 0 then s := s + ', ' + IntToStr(i64) + msg20;
  {$IFNDEF NOGUI}
  if @Callback <> nil then
  begin
    if not Callback(i64, s) then raise Exception.Create(SAbortedByUser)
      {$IFNDEF LINUX}
      {$IFNDEF NOGUI}
      else SendMessage(CallbackWindow, 0, 0, 0)
      {$ENDIF}
      {$ENDIF}; 
  end;
  {$ELSE}
  
  DelegateBindProgress(s, i64, 100, 0); 
  {$ENDIF}
  Progress := i64;
end;

function {$IFNDEF NOGUI}TmiaWebForm.{$ENDIF}DoDownload(const AIndex: Integer; Resume: Boolean;
  Server, Port, User, Pass: String): Boolean;
var
  {$IFDEF DARWIN}
  httpEx: TNSHTTPSendAndReceive;
  {$ENDIF}
  http: TFPHTTPClient;
  index: Integer;
  i: UInt64;
  fs: TFileStream;
begin
  Result := false;
{$IF FPC_FULLVERSION < 30200}
  InitSSLInterface;
{$ENDIF}
  http:= TFPHTTPClient.Create(nil);
{$IF FPC_FULLVERSION < 30200}
  http.OnGetSocketHandler:=@GetSocketHandler;
{$ENDIF}
  http.AllowRedirect:= True;
  {$IFNDEF NOGUI}pbBytes.Position:= 0;{$ELSE}pbBytesPosition := 0;{$ENDIF}
  fs := nil;
  try
    try
      
      DelegateBindProgress(FDownloads[AIndex].URL, 0, 100, 0);
      {$IFDEF DARWIN}
      try
      {$ENDIF}
        http.HTTPMethod('HEAD', FDownloads[AIndex].URL, nil, []);
      {$IFDEF DARWIN}
      except
        
        try
          try
            httpEx := TNSHTTPSendAndReceive.Create;
            httpEx.Method  := 'GET';
            httpEx.Address := FDownloads[AIndex].URL;
            fs := TFileStream.Create(FDownloads[AIndex].Filename, fmCreate);
            Result := httpEx.SendAndReceive(nil, fs, nil);
            fs.Free;
          finally
            httpEx.Free;
          end;
        except
          Exit;
        end;
        Exit;
      end;
      {$ENDIF}
      
      FSize := 0;
      for index := 0 to Pred(http.ResponseHeaders.Count) do
      begin
        if LowerCase(http.ResponseHeaders.Names[index]) = 'content-length' then
        begin
          FSize:= StrToInt64(http.ResponseHeaders.ValueFromIndex[index]);
        end;
      end;
      
      FGrape := 0;
      if MyFileExists(FDownloads[AIndex].Filename) and Resume then
      begin
        
        fs := TFileStream.Create(FDownloads[AIndex].Filename, fmOpenReadWrite);
        i := Max(0, fs.Size - (10* 1024));
        fs.Seek(i, soFromBeginning);
        http.AddHeader('Range', 'bytes=' + IntToStr(i) + '-' + IntToStr(FSize));
        FGrape := i;
      end;
      http.OnDataReceived:= @{$IFDEF NOGUI}TWebEventHandler.{$ENDIF}DataReceived;
      if MyFileExists(FDownloads[AIndex].Filename) and Resume then
      begin
        http.HTTPMethod('GET', FDownloads[AIndex].URL, fs, [200, 206]);
        fs.Free;
      end
      else
      begin
        http.Get(FDownloads[AIndex].URL, FDownloads[AIndex].Filename);
      end;
      Result := True;
    except
      on E: Exception do
      begin
        if Assigned(fs) then
        begin
          fs.Free; 
          
          Result := DoDownload(AIndex, false, Server, Port, User, Pass);
          Exit;
        end;
        if http.ResponseStatusCode > 399 then
        begin
          
        end;
        
      end;
    end;
  finally
    http.Free;
  end;
end;

procedure {$IFNDEF NOGUI}TmiaWebForm.{$ENDIF}AddDownload(const AURL, AFilename: String);
var
  len: Integer;
begin
  
  len:= Length(FDownloads);
  SetLength(FDownloads, len + 1);
  FDownloads[len].URL:= AURL;
  FDownloads[len].Filename:= AFilename;
end;

function FormatSize(Size, Space: Int64): String;
var
  s, t: String;
  i, j: Integer;
begin
  s := IntToStr(Size);
  t := '';
  j := 0;
  for i := Length(s) downto 1 do
  begin
    j := j + 1;
    t := s[i] + t;
    if j = Space then
    begin
      j := 0;
      t := ',' + t;
    end;
  end;
  if t[1] = ',' then Delete(t, 1, 1);
  Result := t;
end;

function FormatBytes(ABytes: Int64): String;
var
  dSize: Double;
begin
  Result := '';
  dSize := 0.0;
  if ABytes < 1024 then
  begin
    Result := IntToStr(ABytes) + ' B';
    exit;
  end;
  if ABytes < (1024*1024) then
  begin
    dSize := ABytes / 1024;
    Result := FormatFloat('0.##', dSize) + ' KB';
    exit;
  end;
  if ABytes < (1024*1024*1024) then
  begin
    dSize := ABytes / 1024 / 1024;
    Result := FormatFloat('0.##', dSize) + ' MB';
    exit;
  end;
  if ABytes < (1024*1024*1024*1024) then
  begin
    dSize := ABytes / 1024 / 1024 / 1024;
    Result := FormatFloat('0.##', dSize) + 'GB';
    exit;
  end;
  if ABytes < (1024*1024*1024*1024*1024) then
  begin
    dSize := ABytes / 1024 / 1024 / 1024 / 1024;
    Result := FormatFloat('0.##', dSize) + ' TB';
  end;
end;

procedure PrepDownload;
begin
  {$IFNDEF NOGUI}
  miaWebForm := TmiaWebForm.Create(nil);
  {$ENDIF}
end;

procedure CleanDownload;
begin
  {$IFNDEF NOGUI}
  if Assigned(miaWebForm) then
  begin
    miaWebForm.Free;
    miaWebForm := nil;
  end;
  {$ENDIF}
end;

function FileDownloadFile(URL, Local, Server, Port, User, Pass: String;
  thyResume: Boolean; Progress: TDownloadProgress): Boolean;
var
  index: Integer;
begin
  Result := false;
  Callback := Progress;
  
  URL := StringReplace(URL, ' ', '%20', [rfReplaceAll, rfIgnoreCase]);
  {$IFNDEF NOGUI}miaWebForm.{$ENDIF}AddDownload(URL, Local);
  
  for index := 0 to Pred(Length({$IFNDEF NOGUI}miaWebForm.{$ENDIF}FDownloads)) do
  begin
    
    try
      Result := {$IFNDEF NOGUI}miaWebForm.{$ENDIF}DoDownload(index, thyResume, Server, Port, User, Pass);
    except
      on E: Exception do
      begin
        
        break;
      end;
    end;
    
  end;
  {$IFNDEF NOGUI}miaWebForm.{$ENDIF}FAllDone:= True;
  
end;

{$IFNDEF NOGUI}
procedure TmiaWebForm.FormCreate(Sender: TObject);
begin
  FSize:= 0;
  FAllDone:= False;
end;

procedure TmiaWebForm.FormClose(Sender: TObject;
  var CloseAction: TCloseAction);
begin
  CloseAction:= caFree;
end;

procedure TmiaWebForm.FormCloseQuery(Sender: TObject; var CanClose: Boolean);
begin
  CanClose:= FallDone;
end;

procedure TmiaWebForm.FormActivate(Sender: TObject);
var
  index: Integer;
begin
  
  for index:= 0 to Pred(Length(FDownloads)) do
  begin
    
    try
      
    except
      on E: Exception do
      begin
        
        break;
      end;
    end;
    
  end;
  FAllDone:= True;
  
end;

{$IF FPC_FULLVERSION < 30200}
procedure TmiaWebForm.GetSocketHandler(Sender: TObject;
  const UseSSL: Boolean; out AHandler: TSocketHandler);
begin
  AHandler := TSSLSocketHandler.Create;
  TSSLSocketHandler(AHandler).SSLType := stTLSv1_2;
end;
{$ENDIF}

{$ENDIF}

end.
