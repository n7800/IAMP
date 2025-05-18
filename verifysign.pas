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
unit VerifySign;

{$MODE Delphi}

interface

uses
  LCLIntf,  LMessages, SysUtils{$IFDEF WINDOWS}, Windows{$ENDIF};

const
  CERT_SECTION_TYPE_ANY = $FF;      
  WIN_CERT_REVISION_1_0 = $0100;

{$IFDEF WINDOWS}
function ImageEnumerateCertificates(FileHandle: THandle; TypeFilter: WORD;
  out CertificateCount: DWORD; Indicies: PDWORD; IndexCount: Integer): BOOL; stdcall; external 'Imagehlp.dll';
function ImageGetCertificateHeader(FileHandle: THandle; CertificateIndex: Integer;
  var CertificateHeader: TWinCertificate): BOOL; stdcall; external 'Imagehlp.dll';
function ImageGetCertificateData(FileHandle: THandle; CertificateIndex: Integer;
  Certificate: PWinCertificate; var RequiredLength: DWORD): BOOL; stdcall; external 'Imagehlp.dll';
{$ENDIF}

const
  CERT_NAME_SIMPLE_DISPLAY_TYPE = 4;
  PKCS_7_ASN_ENCODING = $00010000;
  X509_ASN_ENCODING = $00000001;

type
  PCCERT_CONTEXT = type Pointer;
  HCRYPTPROV_LEGACY = type Pointer;
  PFN_CRYPT_GET_SIGNER_CERTIFICATE = type Pointer;

  CRYPT_VERIFY_MESSAGE_PARA = record
    cbSize: DWORD;
    dwMsgAndCertEncodingType: DWORD;
    hCryptProv: HCRYPTPROV_LEGACY;
    pfnGetSignerCertificate: PFN_CRYPT_GET_SIGNER_CERTIFICATE;
    pvGetArg: Pointer;
  end;

{$IFDEF WINDOWS}
function CryptVerifyMessageSignature(const pVerifyPara: CRYPT_VERIFY_MESSAGE_PARA;
  dwSignerIndex: DWORD; pbSignedBlob: PByte; cbSignedBlob: DWORD; pbDecoded: PBYTE;
  pcbDecoded: PDWORD; ppSignerCert: PCCERT_CONTEXT): BOOL; stdcall; external 'Crypt32.dll';
function CertGetNameStringW(pCertContext: PCCERT_CONTEXT; dwType: DWORD; dwFlags: DWORD; pvTypePara: Pointer;
  pszNameString: PChar; cchNameString: DWORD): DWORD; stdcall; external 'Crypt32.dll';
function CertFreeCertificateContext(pCertContext: PCCERT_CONTEXT): BOOL; stdcall; external 'Crypt32.dll';
function CertCreateCertificateContext(dwCertEncodingType: DWORD;
  pbCertEncoded: PBYTE; cbCertEncoded: DWORD): PCCERT_CONTEXT; stdcall; external 'Crypt32.dll';
{$ENDIF}

const
  WINTRUST_ACTION_GENERIC_VERIFY_V2: TGUID = '{00AAC56B-CD44-11d0-8CC2-00C04FC295EE}';
  WTD_CHOICE_FILE = 1;
  WTD_REVOKE_NONE = 0;
  WTD_UI_NONE = 2;

  WTD_REVOKE_WHOLECHAIN = 1;
  WTD_REVOCATION_CHECK_CHAIN = $40;

type
  PWinTrustFileInfo = ^TWinTrustFileInfo;
  TWinTrustFileInfo = record
    cbStruct: DWORD;                    
    pcwszFilePath: PWideChar;           
    hFile: THandle;                     
    pgKnownSubject: PGUID;              
  end;

  PWinTrustData = ^TWinTrustData;
  TWinTrustData = record
    cbStruct: DWORD;
    pPolicyCallbackData: Pointer;
    pSIPClientData: Pointer;
    dwUIChoice: DWORD;
    fdwRevocationChecks: DWORD;
    dwUnionChoice: DWORD;
    pFile: PWinTrustFileInfo;
    dwStateAction: DWORD;
    hWVTStateData: THandle;
    pwszURLReference: PWideChar;
    dwProvFlags: DWORD;
    dwUIContext: DWORD;
  end;

{$IFDEF WINDOWS}
function WinVerifyTrust(hwnd: HWND; const ActionID: TGUID; ActionData: Pointer): Longint; stdcall; external wintrust;
{$ENDIF}

function IsCodeSigned(const Filename: string): Boolean;
{$IFDEF WINDOWS}
function IsCompanySigningCertificate(const Filename, CompanyName :string): Boolean;
function GetSigningCompanyName(const Filename: String; var CompanyName :string): Boolean;
{$ENDIF}

implementation

function IsCodeSigned(const Filename: string): Boolean;
var 
  file_info: TWinTrustFileInfo;
  trust_data: TWinTrustData;
begin
  
  FillChar(file_info, SizeOf(file_info), 0);
  file_info.cbStruct := sizeof(file_info);
  file_info.pcwszFilePath := PWideChar(WideString(Filename));
  FillChar(trust_data, SizeOf(trust_data), 0);
  trust_data.cbStruct := sizeof(trust_data);
  trust_data.dwUIChoice := WTD_UI_NONE;
  
  trust_data.fdwRevocationChecks := WTD_REVOKE_WHOLECHAIN;
  trust_data.dwProvFlags := WTD_REVOCATION_CHECK_CHAIN;
  
  trust_data.dwUnionChoice := WTD_CHOICE_FILE;
  trust_data.pFile := @file_info;
  {$IFDEF WINDOWS}
  Result := WinVerifyTrust(INVALID_HANDLE_VALUE, WINTRUST_ACTION_GENERIC_VERIFY_V2,
    @trust_data) = ERROR_SUCCESS
  {$ELSE}
  
  Result := True;
  {$ENDIF}
end;

{$IFDEF WINDOWS}
function IsCompanySigningCertificate(const Filename, CompanyName :string): Boolean;
var
  hExe: HMODULE;
  Cert: PWinCertificate;
  CertContext: PCCERT_CONTEXT;
  CertCount: DWORD;
  CertName: String;
  CertNameLen: DWORD;
  VerifyParams: CRYPT_VERIFY_MESSAGE_PARA;
begin
  
  Result := False;
  
  hExe := CreateFile(PChar(Filename), GENERIC_READ, FILE_SHARE_READ,
    nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL or FILE_FLAG_RANDOM_ACCESS, 0);
  if hExe = INVALID_HANDLE_VALUE then
    Exit;
  try
    
    if (not ImageEnumerateCertificates(hExe, CERT_SECTION_TYPE_ANY, CertCount, nil, 0)) or
       (CertCount <> 1) then
      Exit;
    
    GetMem(Cert, SizeOf(TWinCertificate) + 3); 
    try
      Cert.dwLength := 0;
      Cert.wRevision := WIN_CERT_REVISION_1_0;
      if not ImageGetCertificateHeader(hExe, 0, Cert^) then
        Exit;
      
      ReallocMem(Cert, SizeOf(TWinCertificate) + Cert.dwLength);
      if not ImageGetCertificateData(hExe, 0, Cert, Cert.dwLength) then
        Exit;
      
      FillChar(VerifyParams, SizeOf(VerifyParams), 0);
      VerifyParams.cbSize := SizeOf(VerifyParams);
      VerifyParams.dwMsgAndCertEncodingType := X509_ASN_ENCODING or PKCS_7_ASN_ENCODING;
      if not CryptVerifyMessageSignature(VerifyParams, 0, @Cert.bCertificate,
         Cert.dwLength, nil, nil, @CertContext) then
        Exit;
      try
        
        CertNameLen := CertGetNameStringW(CertContext,
          CERT_NAME_SIMPLE_DISPLAY_TYPE, 0, nil, nil, 0);
        SetLength(CertName, CertNameLen -1);
        CertGetNameStringW(CertContext, CERT_NAME_SIMPLE_DISPLAY_TYPE, 0,
          nil, PChar(CertName), CertNameLen);
        if CertName <> CompanyName then
          Exit;
      finally
        CertFreeCertificateContext(CertContext)
      end;
    finally
      FreeMem(Cert);
    end;
  finally
    FileClose(hExe); 
  end;
  Result := True;
end;

function GetSigningCompanyName(const Filename: String; var CompanyName :string): Boolean;
var
  hExe: HMODULE;
  Cert: PWinCertificate;
  CertContext: PCCERT_CONTEXT;
  CertCount: DWORD;
  CertName: String;
  CertNameLen: DWORD;
  VerifyParams: CRYPT_VERIFY_MESSAGE_PARA;
begin
  
  Result := False;
  
  hExe := CreateFile(PChar(Filename), GENERIC_READ, FILE_SHARE_READ,
    nil, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL or FILE_FLAG_RANDOM_ACCESS, 0);
  if hExe = INVALID_HANDLE_VALUE then
    Exit;
  try
    
    if (not ImageEnumerateCertificates(hExe, CERT_SECTION_TYPE_ANY, CertCount, nil, 0)) or
       (CertCount <> 1) then
      Exit;
    
    GetMem(Cert, SizeOf(TWinCertificate) + 3); 
    try
      Cert.dwLength := 0;
      Cert.wRevision := WIN_CERT_REVISION_1_0;
      if not ImageGetCertificateHeader(hExe, 0, Cert^) then
        Exit;
      
      ReallocMem(Cert, SizeOf(TWinCertificate) + Cert.dwLength);
      if not ImageGetCertificateData(hExe, 0, Cert, Cert.dwLength) then
        Exit;
      
      FillChar(VerifyParams, SizeOf(VerifyParams), 0);
      VerifyParams.cbSize := SizeOf(VerifyParams);
      VerifyParams.dwMsgAndCertEncodingType := X509_ASN_ENCODING or PKCS_7_ASN_ENCODING;
      if not CryptVerifyMessageSignature(VerifyParams, 0, @Cert.bCertificate,
         Cert.dwLength, nil, nil, @CertContext) then
        Exit;
      try
        
        CertNameLen := CertGetNameStringW(CertContext,
          CERT_NAME_SIMPLE_DISPLAY_TYPE, 0, nil, nil, 0);
        SetLength(CertName, CertNameLen -1);
        CertGetNameStringW(CertContext, CERT_NAME_SIMPLE_DISPLAY_TYPE, 0,
          nil, PChar(CertName), CertNameLen);
        CompanyName := CertName;
        Result := True;
      finally
        CertFreeCertificateContext(CertContext)
      end;
    finally
      FreeMem(Cert);
    end;
  finally
    FileClose(hExe); 
  end;
  Result := True;
end;
{$ENDIF}

end.
