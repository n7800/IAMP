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
{$IFNDEF FPC_DOTTEDUNITS}
unit opensslsockets;
{$ENDIF FPC_DOTTEDUNITS}

{$mode objfpc}{$H+}

interface

{$IFDEF FPC_DOTTEDUNITS}
uses
  System.Classes, System.SysUtils, System.Net.Sockets, System.Net.Ssockets, System.Net.Sslsockets, System.Net.Sslbase, Api.Openssl, System.Net.Fpopenssl;
{$ELSE FPC_DOTTEDUNITS}
uses
  Classes, SysUtils, sockets, ssockets, sslsockets, sslbase, openssl, fpopenssl;
{$ENDIF FPC_DOTTEDUNITS}

Type

  TOpenSSLSocketHandler = Class(TSSLSocketHandler)
  Private
    FSSL: TSSL;
    FCTX : TSSLContext;
    FSSLLastErrorString: string;
    FSSLLastError : Integer;
  Protected
    procedure SetSSLLastErrorString(AValue: string);
    Function FetchErrorInfo: Boolean;
    function CheckSSL(SSLResult: Integer): Boolean;
    function CheckSSL(SSLResult: Pointer): Boolean;
    function CreateSSLContext(AType: TSSLType): TSSLContext; virtual;
    function InitContext(NeedCertificate: Boolean): Boolean; virtual;
    function DoneContext: Boolean; virtual;
    function InitSslKeys: boolean;virtual;
    Function GetLastSSLErrorString : String; override;
    Function GetLastSSLErrorCode : Integer; override;
  Public
    Constructor create; override;
    destructor destroy; override;
    function CreateCertGenerator: TX509Certificate; override;
    function Connect : Boolean; override;
    function Close : Boolean; override;
    function Accept : Boolean; override;
    function Shutdown(BiDirectional : Boolean): boolean; override;
    function Send(Const Buffer; Count: Integer): Integer; override;
    function Recv(Const Buffer; Count: Integer): Integer; override;
    function BytesAvailable: Integer; override;
    
    Function SSLLastError: integer;
    property SSLLastErrorString: string read FSSLLastErrorString write SetSSLLastErrorString;
    property SSL: TSSL read FSSL; 
  end;

implementation

Resourcestring
  SErrNoLibraryInit = 'Could not initialize OpenSSL library';
  SErrCouldNotCreateSelfSignedCertificate = 'Failed to create self-signed certificate';
  SErrCouldNotInitSSLKeys = 'Failed to initialize SSL keys';

Procedure MaybeInitSSLInterface;

begin
  if not IsSSLloaded then
    if not InitSSLInterface then
      Raise EInOutError.Create(SErrNoLibraryInit);
end;

function TopenSSLSocketHandler.CreateCertGenerator: TX509Certificate;
begin
  Result:=TOpenSSLX509Certificate.Create;
end;

function TOpenSSLSocketHandler.CreateSSLContext(AType: TSSLType): TSSLContext;
begin
  Result := TSSLContext.Create(AType);
end;

procedure TOpenSSLSocketHandler.SetSSLLastErrorString(AValue: string);
begin
  if FSSLLastErrorString=AValue then Exit;
  FSSLLastErrorString:=AValue;
end;

function TOpenSSLSocketHandler.Connect: Boolean;
begin
  Result:=Inherited Connect;
  Result := Result and InitContext(False);
  if Result then
    begin
    Result:=CheckSSL(FSSL.SetFD(Socket.Handle));
    if Result then
     begin
     if SendHostAsSNI  and (Socket is TInetSocket) then
       FSSL.Ctrl(SSL_CTRL_SET_TLSEXT_HOSTNAME,TLSEXT_NAMETYPE_host_name,PAnsiChar(AnsiString((Socket as TInetSocket).Host)));
     if VerifyPeerCert and (Socket is TInetSocket) then
       FSSL.Set1Host((Socket as TInetSocket).Host);
     Result:=CheckSSL(FSSL.Connect);
     
     if Result then
       Result:= DoVerifyCert;
     if Result then
       SetSSLActive(True);
     end;
    end;
end;

function TOpenSSLSocketHandler.Close: Boolean;
begin
  Result:=Shutdown(False);
end;

Function TOpenSSLSocketHandler.FetchErrorInfo : Boolean;

var
  S : AnsiString;

begin
  FSSLLastErrorString:='';
  FSSLLastError:=ErrGetError;
  ErrClearError;
  Result:=(FSSLLastError<>0);
  if Result then
    begin
    S:=StringOfChar(#0,256);
    ErrErrorString(FSSLLastError,S,256);
    FSSLLastErrorString:=s;
    end;
end;

function TOpenSSLSocketHandler.CheckSSL(SSLResult : Integer) : Boolean;

begin
  Result:=SSLResult>=1;
  if Not Result then
     begin
     FSSLLastError:=SSLResult;
     FetchErrorInfo;
     end;
end;

function TOpenSSLSocketHandler.CheckSSL(SSLResult: Pointer): Boolean;
begin
  Result:=(SSLResult<>Nil);
  if not Result then
    Result:=FetchErrorInfo;
end;

function TOpenSSLSocketHandler.DoneContext: Boolean;

begin
  FreeAndNil(FSSL);
  FreeAndNil(FCTX);
  ErrRemoveState(0);
  SetSSLActive(False);
  Result:=True;
end;

Function HandleSSLPwd(buf : PAnsiChar; len:Integer; flags:Integer; UD : Pointer):Integer; cdecl;

var
  Pwd: AnsiString;
  H :  TOpenSSLSocketHandler;

begin
  if Not Assigned(UD) then
    PWD:=''
  else
    begin
    H:=TOpenSSLSocketHandler(UD);
    Pwd:=H.CertificateData.KeyPassword;
    end;
  if (len<Length(Pwd)+1) then
    SetLength(Pwd,len-1);
  pwd:=pwd+#0;
  Result:=Length(Pwd);
  Move(Pointer(Pwd)^,Buf^,Result);
end;

function TOpenSSLSocketHandler.InitSslKeys: boolean;

begin
  Result:=(FCTX<>Nil);
  if not Result then
    Exit;
  if not CertificateData.Certificate.Empty then
    Result:=CheckSSL(FCTX.UseCertificate(CertificateData.Certificate));
  if Result and not CertificateData.PrivateKey.Empty then
    Result:=CheckSSL(FCTX.UsePrivateKey(CertificateData.PrivateKey));
  if Result and ((CertificateData.CertCA.FileName<>'') or (CertificateData.TrustedCertsDir<>'')) then
    Result:=CheckSSL(FCTX.LoadVerifyLocations(CertificateData.CertCA.FileName,CertificateData.TrustedCertsDir));
  if Result and not CertificateData.PFX.Empty then
    Result:=CheckSSL(FCTX.LoadPFX(CertificateData.PFX,CertificateData.KeyPassword));
end;

function TOpenSSLSocketHandler.GetLastSSLErrorString: String;
begin
  Result:=FSSLLastErrorString;
end;

function TOpenSSLSocketHandler.GetLastSSLErrorCode: Integer;
begin
  Result:=FSSLLastError;
end;

constructor TOpenSSLSocketHandler.create;
begin
  inherited create;
  MaybeInitSSLInterface;
end;

destructor TOpenSSLSocketHandler.destroy;
begin
  FreeAndNil(FCTX);
  FreeAndNil(FSSL);
  inherited destroy;
end;

function TOpenSSLSocketHandler.InitContext(NeedCertificate:Boolean): Boolean;

Const
  VO : Array[Boolean] of Integer = (SSL_VERIFY_NONE,SSL_VERIFY_PEER);

var
  s: AnsiString;

begin
  Result:=DoneContext;
  if Not Result then
    Exit;
  try
    FCTX:=CreateSSLContext(SSLType);
  Except
    CheckSSL(Nil);
    raise;
  end;
  S:=CertificateData.CipherList;
  FCTX.SetCipherList(S);
  FCTX.SetVerify(VO[VerifypeerCert],Nil);
  FCTX.SetDefaultPasswdCb(@HandleSSLPwd);
  FCTX.SetDefaultPasswdCbUserdata(self);
  If NeedCertificate and CertificateData.NeedCertificateData  then
    if Not CreateSelfSignedCertificate then
      begin
      DoneContext;
      raise ESSL.Create(SErrCouldNotCreateSelfSignedCertificate);
      end;
   if Not InitSSLKeys then
     begin
     DoneContext;
     raise ESSL.Create(SErrCouldNotInitSSLKeys);
     end;
   try
     FSSL:=TSSL.Create(FCTX);
     Result:=True;
   Except
     CheckSSL(Nil);
     DoneContext;
     raise;
   end;
end;

function TOpenSSLSocketHandler.Accept: Boolean;

begin
  Result:=InitContext(True);
  if Result then
    begin
    Result:=CheckSSL(FSSL.setfd(Socket.Handle));
    if Result then
      Result:=CheckSSL(FSSL.Accept);
    end;
  SetSSLActive(Result);
end;

function TOpenSSLSocketHandler.Shutdown(BiDirectional : Boolean): boolean;

var
  r : integer;

begin
  Result:=assigned(FSsl);
  if Result then
    If Not BiDirectional then
      Result:=CheckSSL(FSSL.Shutdown)
    else
      begin
      r:=FSSL.Shutdown;
      if r<>0 then
        Result:=CheckSSL(r)
      else
        begin
        Result:=fpShutdown(Socket.Handle,1)=0;
        if Result then
          Result:=CheckSSL(FSsl.Shutdown);
        end
      end;
  If Result then
    Result:=DoneContext;
end;

function TOpenSSLSocketHandler.Send(Const Buffer; Count: Integer): Integer;
var
  e: integer;
begin
  FLastError:=0;
  FSSLLastError := 0;
  FSSLLastErrorString:='';
  repeat
    Result:=FSsl.Write(@Buffer,Count);
    e:=FSsl.GetError(Result);
  until Not (e in [SSL_ERROR_WANT_READ,SSL_ERROR_WANT_WRITE]);
  if (E=SSL_ERROR_ZERO_RETURN) then
    Result:=0
  else if (e<>0) then
    begin
    FSSLLastError:=e;
    if e=SSL_ERROR_SYSCALL then
      FLastError:=socketerror;
    end;
end;

function TOpenSSLSocketHandler.Recv(Const Buffer; Count: Integer): Integer;

var
  e: integer;
begin
  FLastError:=0;
  FSSLLastError:=0;
  FSSLLastErrorString:= '';
  repeat
    Result:=FSSL.Read(@Buffer ,Count);
    e:=FSSL.GetError(Result);
    if (e=SSL_ERROR_WANT_READ) and (Socket.IOTimeout>0) then
      e:=SSL_ERROR_ZERO_RETURN;
  until Not (e in [SSL_ERROR_WANT_READ,SSL_ERROR_WANT_WRITE]);
  if (E=SSL_ERROR_ZERO_RETURN) then
    Result:=0
  else if (e<>0) then
    begin
    FSSLLastError:=e;
    if e=SSL_ERROR_SYSCALL then
      FLastError:=socketerror;
    end;
end;

function TOpenSSLSocketHandler.BytesAvailable: Integer;
begin
  Result:= FSSL.Pending;
end;

Function TOpenSSLSocketHandler.SSLLastError: integer;
begin
  Result:=FSSLLastError;
end;

initialization
  TSSLSocketHandler.SetDefaultHandlerClass(TOpenSSLSocketHandler);
end.

