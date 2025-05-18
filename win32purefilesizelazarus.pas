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
unit win32purefilesizelazarus;

{$mode ObjFPC}{$H+}

{$ASMMODE        INTEL}

interface

uses
  _80_ntdll, _80_kernel32;

function GetWin32LazEXESize: Integer;

implementation

function GetOffsetToNewExecutable
           (
            const InLoadAddress : pointer;
              out OutOffset     : DWORD
           )
         : boolean;
  
var
  ImageDosHeader : PIMAGE_DOS_HEADER absolute InLoadAddress;

begin
  result    := FALSE;
  OutOffset := 0;

  if IsBadReadPtr(ImageDosHeader, sizeof(ImageDosHeader^)) then exit;

  if pword(ImageDosHeader)^ <> IMAGE_DOS_SIGNATURE         then exit;

  OutOffset := ImageDosHeader^.OffsetToNewExecutable;

  result := TRUE;
end;

function GetNtHeadersAddress
           (
            const InLoadAddress       : PIMAGE_DOS_HEADER;
              out OutNtHeadersAddress : pointer
           )
         : boolean;
  
var
  OffsetToNewExecutable : DWORD;

  p                     : PDWORD;

begin
  result              := FALSE;
  OutNtHeadersAddress := nil;

  if not GetOffsetToNewExecutable(InLoadAddress,
                                  OffsetToNewExecutable) then exit;

  p := PDWORD(pchar(InLoadAddress) + OffsetToNewExecutable);

  if p^ <> IMAGE_NT_SIGNATURE                            then exit;

  OutNtHeadersAddress := p;
  result              := TRUE;
end;

function MapFile
           (
            const InFilename    : pchar;
              out OutMapAddress : pointer;
              out OutModuleSize : DWORD
           )
         : boolean;
  
var
  FileHandle    : THANDLE = INVALID_HANDLE_VALUE;
  FileSize      : DWORD   = 0;
  BytesRead     : DWORD   = 0;

  MappingHandle : THANDLE = 0;

begin
  result        := FALSE;
  OutMapAddress := nil;
  OutModuleSize := 0;

  repeat        

    FileHandle := CreateFileA(InFilename,
                              GENERIC_READ,
                              FILE_SHARE_READ,
                              nil,
                              OPEN_EXISTING,
                              FILE_ATTRIBUTE_NORMAL,
                              0);

    if FileHandle = INVALID_HANDLE_VALUE then
    begin
      
      break;
    end;

    FileSize    := GetFileSize(FileHandle, nil);

    if FileSize = INVALID_FILE_SIZE then
    begin
      
      break;
    end;

    MappingHandle := CreateFileMappingA(INVALID_HANDLE_VALUE,
                                        nil,                    
                                        PAGE_READWRITE,
                                        0,                      
                                        FileSize + (4 * 1024),  
                                        nil);
    if MappingHandle = 0 then
    begin
      
      break;
    end;

    OutMapAddress := MapViewOfFile(MappingHandle,
                                   FILE_MAP_ALL_ACCESS,
                                   0,
                                   0,
                                   0);

    if OutMapAddress = nil then
    begin
      
      break;

      if IsDebuggerPresent() then asm int 3 end;
    end;

    if not ReadFile(FileHandle,
                    OutMapAddress,
                    FileSize,
                   @BytesRead,
                    nil)        then
    begin
      
      BytesRead := 0;

      if IsDebuggerPresent() then asm int 3 end;

      break;
    end;

  until TRUE;

  if FileHandle    <> INVALID_HANDLE_VALUE then CloseHandle(FileHandle);
  if MappingHandle <> 0                    then CloseHandle(MappingHandle);

  if (OutMapAddress <> nil) and
     (BytesRead     <> 0)   then
  begin
     result        := TRUE;
     OutModuleSize := FileSize;
  end;
end;

function UnmapFile(InMapAddress : pointer) : boolean;
  
begin
  result := UnmapViewOfFile(InMapAddress);
end;

function Mainline(var Size: UInt64) : boolean;
const
  INDENT                  = '  ';                    
  MALFORMED_PE_FILE       = 'Malformed PE file - ';
  LABEL_WIDTH             = 50;                      
  VALUE_WIDTH             =  9;

const
  COFF_TABLE_SIZE_INVALID = -1;

var
  ProgramName : packed array[0..1023] of char = #0;  
  LastError   : DWORD                         =  0;

var
  MapAddress  : PIMAGE_DOS_HEADER             = nil;
  ModuleSize  : DWORD                         =   0;

var
  
  NtHeadersAddress        : pointer             = nil;

  NtHeadersAddress32      : PIMAGE_NT_HEADERS32 absolute NtHeadersAddress;
  NtHeadersAddress64      : PIMAGE_NT_HEADERS64 absolute NtHeadersAddress;

var
  
  CoffSymTableSize        : int32                    = COFF_TABLE_SIZE_INVALID;

var
  OptionalHeader          : PIMAGE_OPTIONAL_HEADER   = nil;
  OptionalHeader32        : PIMAGE_OPTIONAL_HEADER32 absolute OptionalHeader;
  OptionalHeader64        : PIMAGE_OPTIONAL_HEADER64 absolute OptionalHeader;

var
  SectionsCount           : int32                    =   0;
  SectionEnd              : DWORD                    =   0;
  FirstSection            : PIMAGE_SECTION_HEADER    = nil;

  SectionIndex            : int32                    =   0;

var
  PEsize                  : int32                    =   0;

var
  CoffSize                : int32                    =   0;
  CoffEntryCount          : int32                    =   0;

var
  StringTable             : PSYMBOL_STRING_TABLE     = nil;

begin
  result      := FALSE;                              

  RtlZeroMemory(@ProgramName, sizeof(ProgramName));  

  if GetModuleFilenameA(0,                           
                        ProgramName,
                        sizeof(ProgramName)) = 0 then
  begin
    
    LastError := GetLastError();

    if IsDebuggerPresent() then asm int 3 end;

    LastError := LastError;     

    exit;
  end;

  if not MapFile(ProgramName, MapAddress, ModuleSize)        then exit;

  repeat

    if not GetNtHeadersAddress(MapAddress, NtHeadersAddress) then break;

    with NtHeadersAddress64^.FileHeader do
    begin
      
      case PointerToSymbolTable of
        0 :
        begin
          
          CoffSymTableSize := 0;

        end;

        otherwise
        begin
          
          if PointerToSymbolTable >= ModuleSize then
          begin
            
            break;
          end;

          if NumberOfSymbols <= 0 then
          begin
            
            break;
          end;

          CoffSymTableSize := ModuleSize - PointerToSymbolTable;

        end;
      end;

      SectionsCount := NumberOfSections;  

    end;

    OptionalHeader := @NtHeadersAddress64^.OptionalHeader;

    case OptionalHeader^.Magic of
      IMAGE_NT_OPTIONAL_HDR32_MAGIC :
      begin
        OptionalHeader32 := PIMAGE_OPTIONAL_HEADER32(OptionalHeader);
        FirstSection     := PIMAGE_SECTION_HEADER(OptionalHeader32 + 1);
      end;

      IMAGE_NT_OPTIONAL_HDR64_MAGIC :
      begin
        OptionalHeader64 := PIMAGE_OPTIONAL_HEADER64(OptionalHeader);
        FirstSection     := PIMAGE_SECTION_HEADER(OptionalHeader64 + 1);
      end;

      otherwise
        
      break;
    end;

    SectionIndex := 0;
    while SectionIndex < SectionsCount do
    with (FirstSection + SectionIndex)^ do
    begin
      SectionEnd := PointerToRawData + SizeOfRawData;

      if SectionEnd > PEsize then
      begin
        PEsize := SectionEnd;
      end;

      inc(SectionIndex);
    end;

    Size := PEsize; 

    if false then
    begin
      with NtHeadersAddress64^.FileHeader do
      begin
        if PointerToSymbolTable <> 0 then
        begin
          
          CoffEntryCount := NumberOfSymbols;
          CoffSize       := CoffEntryCount * sizeof(PIMAGE_SYMBOL^);

          StringTable    := pointer(pbyte(MapAddress) +
                            PointerToSymbolTable      +
                            CoffSize);

          Size := PESize + CoffSize + StringTable^.Size;

          if PEsize <> PointerToSymbolTable then
          begin
            
          end;
        end;
      end;

    end;

  until TRUE;

  if not UnmapFile(MapAddress)                               then exit;

  if CoffSymTableSize = COFF_TABLE_SIZE_INVALID              then exit;
  if OptionalHeader   = nil                                  then exit;

  result := TRUE;               
end;

function GetWin32LazEXESize: Integer;
var
  Size: UInt64;
begin
  if MainLine(Size) then
    Result := Size
  else
    Result := -1;
end;

end.

