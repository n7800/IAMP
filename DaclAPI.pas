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
unit DaclAPI;

interface

uses
  Windows;

const
  ACL_REVISION             = 2;

  OBJECT_INHERIT_ACE       = $01; 
  CONTAINER_INHERIT_ACE    = $02; 
  NO_PROPAGATE_INHERIT_ACE = $04; 
  INHERIT_ONLY_ACE         = $08; 
  INHERITED_ACE            = $10; 
                                  
  VALID_INHERIT_FLAGS      = $1F;
  PROTECTED_DACL_SECURITY_INFORMATION   = $80000000;

type
  PPSID = ^PSID;
  PPACL = ^PACL;

  {$MINENUMSIZE 4}

  SE_OBJECT_TYPE = (
    SE_UNKNOWN_OBJECT_TYPE = 0,
    SE_FILE_OBJECT,
    SE_SERVICE,
    SE_PRINTER,
    SE_REGISTRY_KEY,
    SE_LMSHARE,
    SE_KERNEL_OBJECT,
    SE_WINDOW_OBJECT,
    SE_DS_OBJECT,
    SE_DS_OBJECT_ALL,
    SE_PROVIDER_DEFINED_OBJECT,
    SE_WMIGUID_OBJECT,
    SE_REGISTRY_WOW64_32KEY,
    SE_REGISTRY_WOW64_64KEY
  );
  {$EXTERNALSYM SE_OBJECT_TYPE}

  PACE_HEADER = ^ACE_HEADER;
  _ACE_HEADER = record
    AceType: Byte;
    AceFlags: Byte;
    AceSize: Word;
  end;
  ACE_HEADER = _ACE_HEADER;
  TAceHeader = ACE_HEADER;
  PAceHeader = PACE_HEADER;

  PACL_SIZE_INFORMATION = ^ACL_SIZE_INFORMATION;
  _ACL_SIZE_INFORMATION = record
    AceCount: DWORD;
    AclBytesInUse: DWORD;
    AclBytesFree: DWORD;
  end;
  ACL_SIZE_INFORMATION = _ACL_SIZE_INFORMATION;
  TAclSizeInformation = ACL_SIZE_INFORMATION;
  PAclSizeInformation = PACL_SIZE_INFORMATION;

  PACCESS_ALLOWED_ACE = ^ACCESS_ALLOWED_ACE;
  _ACCESS_ALLOWED_ACE = record
    Header: ACE_HEADER;
    Mask: ACCESS_MASK;
    SidStart: DWORD;
  end;
  ACCESS_ALLOWED_ACE = _ACCESS_ALLOWED_ACE;
  TAccessAllowedAce = ACCESS_ALLOWED_ACE;
  PAccessAllowedAce = PACCESS_ALLOWED_ACE;

  PACCESS_DENIED_ACE = ^ACCESS_DENIED_ACE;
  _ACCESS_DENIED_ACE = record
    Header: ACE_HEADER;
    Mask: ACCESS_MASK;
    SidStart: DWORD;
  end;
  ACCESS_DENIED_ACE = _ACCESS_DENIED_ACE;
  TAccessDeniedAce = ACCESS_DENIED_ACE;
  PAccessDeniedAce = PACCESS_DENIED_ACE;

function GetNamedSecurityInfo(pObjectName: LPWSTR; ObjectType: SE_OBJECT_TYPE;
         SecurityInfo: SECURITY_INFORMATION; ppsidOwner, ppsidGroup: PPSID; ppDacl, ppSacl: PPACL;
         var ppSecurityDescriptor: PSECURITY_DESCRIPTOR): DWORD; stdcall; external advapi32 name 'GetNamedSecurityInfo'+{$ifdef UNICODE}'W'{$ELSE}'A'{$ENDIF};
         
function GetNamedSecurityInfoA(pObjectName: LPSTR; ObjectType: SE_OBJECT_TYPE;
         SecurityInfo: SECURITY_INFORMATION; ppsidOwner, ppsidGroup: PPSID; ppDacl, ppSacl: PPACL;
         var ppSecurityDescriptor: PSECURITY_DESCRIPTOR): DWORD; stdcall; external advapi32 name 'GetNamedSecurityInfoA';
         
function GetNamedSecurityInfoW(pObjectName: LPWSTR; ObjectType: SE_OBJECT_TYPE;
         SecurityInfo: SECURITY_INFORMATION; ppsidOwner, ppsidGroup: PPSID; ppDacl, ppSacl: PPACL;
         var ppSecurityDescriptor: PSECURITY_DESCRIPTOR): DWORD; stdcall; external advapi32 name 'GetNamedSecurityInfoW';
         
function GetSecurityInfo(handle: THandle; ObjectType: SE_OBJECT_TYPE;
         SecurityInfo: SECURITY_INFORMATION; ppsidOwner, ppsidGroup: PPSID; ppDacl, ppSacl: PPACL;
         var ppSecurityDescriptor: PSECURITY_DESCRIPTOR): DWORD; stdcall; external advapi32 name 'GetSecurityInfo';
         
function SetNamedSecurityInfo(pObjectName: LPWSTR; ObjectType: SE_OBJECT_TYPE;
         SecurityInfo: SECURITY_INFORMATION; psidOwner, psidGroup: PSID;
         pDacl, pSacl: PACL): DWORD; stdcall; external advapi32 name 'SetNamedSecurityInfo'+{$ifdef UNICODE}'W'{$ELSE}'A'{$ENDIF};
function SetNamedSecurityInfoA(pObjectName: LPSTR; ObjectType: SE_OBJECT_TYPE;
         SecurityInfo: SECURITY_INFORMATION; psidOwner, psidGroup: PSID;
         pDacl, pSacl: PACL): DWORD; stdcall; external advapi32 name 'SetNamedSecurityInfoA';
function SetNamedSecurityInfoW(pObjectName: LPWSTR; ObjectType: SE_OBJECT_TYPE;
         SecurityInfo: SECURITY_INFORMATION; psidOwner, psidGroup: PSID;
         pDacl, pSacl: PACL): DWORD; stdcall; external advapi32 name 'SetNamedSecurityInfoW';

function SetSecurityInfo(handle: THandle; ObjectType: SE_OBJECT_TYPE;
         SecurityInfo: SECURITY_INFORMATION; psidOwner, psidGroup: PSID;
         pDacl, pSacl: PACL): DWORD; stdcall; external advapi32 name 'SetSecurityInfo';

implementation

end.
