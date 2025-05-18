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

{$define ALLOW_DUPLICATE_API_NAMES}

{$define USE_POINTERS}          

UNIT _80_kernel32;
  
INTERFACE

uses
  _80_ntdll
  ;

const
  kernel32   = 'kernel32';

{$ifdef ALLOW_DUPLICATE_API_NAMES}
  function CloseHandle
             (
               InObjectHandle : THANDLE
             )
           : BOOL; stdcall; external kernel32;
{$endif}

{$ifdef ALLOW_DUPLICATE_API_NAMES}
  function CreateDirectoryA
             (
               InPathName              : pchar;
               InoptSecurityAttributes : PSECURITY_ATTRIBUTES
             )
           : BOOL; stdcall; external kernel32;

  function CreateDirectoryW
             (
               InPathName              : pwidechar;
               InoptSecurityAttributes : PSECURITY_ATTRIBUTES
             )
           : BOOL; stdcall; external kernel32;
{$endif}

{$ifdef ALLOW_DUPLICATE_API_NAMES}
  function CreateFileA
             (
               InFileName              :  pchar;
               InDesiredAccess         :  DWORD;
               InShareMode             :  DWORD;
               InoptSecurityAttributes :  PSECURITY_ATTRIBUTES;
               InCreationDisposition   :  DWORD;
               InFlagsAndAttributes    :  DWORD;
               InoptTemplateFile       :  THANDLE
             )
           : THANDLE; stdcall; external kernel32;

  function CreateFileW
             (
               InFileName              :  pwidechar;
               InDesiredAccess         :  DWORD;
               InShareMode             :  DWORD;
               InoptSecurityAttributes :  PSECURITY_ATTRIBUTES;
               InCreationDisposition   :  DWORD;
               InFlagsAndAttributes    :  DWORD;
               InoptTemplateFile       :  THANDLE
             )
           : THANDLE; stdcall; external kernel32;
{$endif}

function CreateFileMappingA
           (
             InFileHandle               : THANDLE;
             InoptFileMappingAttributes : PSECURITY_ATTRIBUTES;
             InProtect                  : DWORD;
             InMaximumSizeHigh          : DWORD;
             InMaximumSizeLow           : DWORD;
             InoptMappingName           : pchar
           )
         : THANDLE; stdcall; external kernel32;

{$ifdef ALLOW_DUPLICATE_API_NAMES}
  function CreateFileMappingW
             (
               InFileHandle               : THANDLE;
               InoptFileMappingAttributes : PSECURITY_ATTRIBUTES;
               InProtect                  : DWORD;
               InMaximumSizeHigh          : DWORD;
               InMaximumSizeLow           : DWORD;
               InoptMappingName           : pwidechar
             )
           : THANDLE; stdcall; external kernel32;
{$endif}

const
  
  INVALID_FILE_SIZE = DWORD($FFFFFFFF);

function GetFileSize
           (
             InFileHandle    : THANDLE;
             OutFileSizeHigh : PDWORD
           )
         : DWORD; stdcall; external kernel32;

{$ifdef ALLOW_DUPLICATE_API_NAMES}
  function GetLastError
             {$ifdef FPC}
             (
              
             )
             {$endif}
           : DWORD; stdcall; external kernel32;
{$endif}

{$ifdef ALLOW_DUPLICATE_API_NAMES}
  function GetModuleFileNameA
             (
                InoptModule : HMODULE;
                OutFilename : pchar;
                InSize      : DWORD
             )
           : DWORD; stdcall; external kernel32;

  function GetModuleFileNameW
             (
                InoptModule : HMODULE;
                OutFilename : pwidechar;
                InSize      : DWORD
             )
           : DWORD; stdcall; external kernel32;
{$endif}

const
  
  GET_MODULE_HANDLE_EX_FLAG_PIN                 = 1;
  GET_MODULE_HANDLE_EX_FLAG_UNCHANGED_REFCOUNT  = 2;
  GET_MODULE_HANDLE_EX_FLAG_FROM_ADDRESS        = 4;

{$ifdef USE_POINTERS}
  function GetModuleHandleExA
             (
               InFlags         : DWORD;
               InoptModuleName : pchar;
               OutModule       : PMODULE
             )
           : BOOL; stdcall; external kernel32;

  function GetModuleHandleExW
             (
               InFlags         : DWORD;
               InoptModuleName : pwidechar;
               OutModule       : PMODULE
             )
           : BOOL; stdcall; external kernel32;
{$endif}

{$ifdef USE_VAR}
  function GetModuleHandleExA
             (
                   InFlags         : DWORD;
                   InoptModuleName : pchar;
               var OutModule       : HMODULE
             )
           : BOOL; stdcall; external kernel32;

  function GetModuleHandleExW
             (
                   InFlags         : DWORD;
                   InoptModuleName : pwidechar;
               var OutModule       : HMODULE
             )
           : BOOL; stdcall; external kernel32;
{$endif}

{$ifdef USE_OUT}
  function GetModuleHandleExA
             (
                   InFlags         : DWORD;
                   InoptModuleName : pchar;
               out OutModule       : HMODULE
             )
           : BOOL; stdcall; external kernel32;

  function GetModuleHandleExW
             (
                   InFlags         : DWORD;
                   InoptModuleName : pwidechar;
               out OutModule       : HMODULE
             )
           : BOOL; stdcall; external kernel32;
{$endif}

{$ifdef ALLOW_DUPLICATE_API_NAMES}
  function GetProcAddress
             (
               InModuleHandle  : HMODULE;
               InFunctionNameA : pchar
             )
           : pointer; stdcall; external kernel32;
{$endif}

function IsBadReadPtr
           (
             InAddress   : pointer;
             InByteCount : ptruint
           )
         : BOOL; stdcall; external kernel32;

{$ifdef ALLOW_DUPLICATE_API_NAMES}
  function IsDebuggerPresent
             {$ifdef FPC}
             (
              
             )
             {$endif}
           : BOOL; stdcall; external kernel32;
{$endif}

{$ifdef ALLOW_DUPLICATE_API_NAMES}
  function LoadLibraryA
             (
               InLibraryFilenameA : pchar
             )
           : HMODULE; stdcall; external kernel32;

  function LoadLibraryW
             (
               InLibraryFilenameW : pwidechar
             )
           : HMODULE; stdcall; external kernel32;
{$endif}

const
  
  FILE_MAP_WRITE           = SECTION_MAP_WRITE;
  FILE_MAP_READ            = SECTION_MAP_READ;
  FILE_MAP_ALL_ACCESS      = SECTION_ALL_ACCESS;

  FILE_MAP_EXECUTE         = SECTION_MAP_EXECUTE_EXPLICIT; 

  FILE_MAP_COPY            =        $1;

  FILE_MAP_RESERVE         = $80000000;
  FILE_MAP_TARGETS_INVALID = $40000000;
  FILE_MAP_LARGE_PAGES     = $20000000;

function MapViewOfFile
           (
             InFileMappingObject  : THANDLE;
             InDesiredAccess      : DWORD;
             InFileOffsetHigh     : DWORD;
             InFileOffsetLow      : DWORD;
             InNumberOfBytesToMap : ptruint
           )
         : pointer; stdcall; external kernel32;

{$ifdef ALLOW_DUPLICATE_API_NAMES}
  function ReadFile
             (
               InFile                  : THANDLE;
               OutBuffer               : pointer;
               InNumberOfBytesToRead   : DWORD;
               OutoptNumberOfBytesRead : PDWORD;
               InoutoptOverlapped      : POVERLAPPED
             )
           : BOOL; stdcall; external kernel32;
{$endif}

{$ifdef ALLOW_DUPLICATE_API_NAMES}
  function UnmapViewOfFile
             (
               InViewBaseAddress : pointer
             )
           : BOOL; stdcall; external kernel32;
{$endif}

{$ifdef ALLOW_DUPLICATE_API_NAMES}
  function VirtualAlloc
             (
               InoptAddress     : pointer;
               InSize           : ptruint;
               InAllocationType : DWORD;
               InProtect        : DWORD
             )
           : pointer; stdcall; external kernel32;
{$endif}

{$ifdef ALLOW_DUPLICATE_API_NAMES}
  function VirtualFree
             (
               InAddress  : pointer;
               InSize     : ptruint;
               InFreeType : DWORD
             )
           : BOOL; stdcall; external kernel32;
{$endif}

{$ifdef ALLOW_DUPLICATE_API_NAMES}
  
  function WriteFile
             (
               InFile                     : THANDLE;
               InBuffer                   : pointer;
               InNumberOfBytesToWrite     : DWORD;
               OutoptNumberOfBytesWritten : PDWORD;
               InoutoptOverlapped         : POVERLAPPED
             )
           : BOOL; stdcall; external kernel32;
{$endif}

IMPLEMENTATION

END.

