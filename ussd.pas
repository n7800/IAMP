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
unit uSSD;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

function IsSSD(Path: String): Boolean;

implementation

uses
  Windows, Types, SysUtils;

const
  FILE_READ_DATA               = $0001;
  {$EXTERNALSYM FILE_READ_DATA}

  FILE_READ_ATTRIBUTES         = $0080;
  {$EXTERNALSYM FILE_READ_ATTRIBUTES}

  FILE_DEVICE_MASS_STORAGE     = $0000002d;
  {$EXTERNALSYM FILE_DEVICE_MASS_STORAGE}

  IOCTL_STORAGE_BASE           = FILE_DEVICE_MASS_STORAGE;
  {$EXTERNALSYM IOCTL_STORAGE_BASE}

  FILE_ANY_ACCESS              = 0;
  {$EXTERNALSYM FILE_ANY_ACCESS}

  METHOD_BUFFERED              = 0;
  {$EXTERNALSYM METHOD_BUFFERED}

  IOCTL_STORAGE_QUERY_PROPERTY = (IOCTL_STORAGE_BASE shl 16) or
                                 (FILE_ANY_ACCESS shl 14) or
                                 ($0500 shl 2) or
                                 (METHOD_BUFFERED);
  {$EXTERNALSYM IOCTL_STORAGE_QUERY_PROPERTY}

type
  
  _STORAGE_PROPERTY_ID = (
    StorageDeviceProperty                 =  0,
    StorageAdapterProperty                =  1,
    StorageDeviceIdProperty               =  2,
    StorageDeviceUniqueIdProperty         =  3,
    StorageDeviceWriteCacheProperty       =  4,
    StorageMiniportProperty               =  5,
    StorageAccessAlignmentProperty        =  6,
    StorageDeviceSeekPenaltyProperty      =  7,
    StorageDeviceTrimProperty             =  8,
    StorageDeviceWriteAggregationProperty =  9,
    StorageDeviceDeviceTelemetryProperty  = 10
  );
  {$EXTERNALSYM _STORAGE_PROPERTY_ID}
  STORAGE_PROPERTY_ID = _STORAGE_PROPERTY_ID;
  {$EXTERNALSYM  STORAGE_PROPERTY_ID}
  TStoragePropertyId  = _STORAGE_PROPERTY_ID;
  PStoragePropertyId  = ^TStoragePropertyId;

  _STORAGE_QUERY_TYPE = (
    PropertyStandardQuery   = 0,
    PropertyExistsQuery     = 1,
    PropertyMaskQuery       = 2,
    PropertyQueryMaxDefined = 3
  );
  {$EXTERNALSYM _STORAGE_QUERY_TYPE}
  STORAGE_QUERY_TYPE = _STORAGE_QUERY_TYPE;
  {$EXTERNALSYM  STORAGE_QUERY_TYPE}
  TStorageQueryType  = _STORAGE_QUERY_TYPE;
  PStorageQueryType  = ^TStorageQueryType;

  _STORAGE_PROPERTY_QUERY = packed record
    PropertyId: DWORD;
    QueryType: DWORD;
    AdditionalParameters: array[0..9] of Byte;
  end;
  {$EXTERNALSYM _STORAGE_PROPERTY_QUERY}
  STORAGE_PROPERTY_QUERY = _STORAGE_PROPERTY_QUERY;
  {$EXTERNALSYM  STORAGE_PROPERTY_QUERY}
  TStoragePropertyQuery  = _STORAGE_PROPERTY_QUERY;
  PStoragePropertyQuery  = ^TStoragePropertyQuery;

  _DEVICE_SEEK_PENALTY_DESCRIPTOR = packed record
    Version: DWORD;
    Size: DWORD;
    IncursSeekPenalty: ByteBool;
    Reserved: array[0..2] of Byte;
  end;
  {$EXTERNALSYM _DEVICE_SEEK_PENALTY_DESCRIPTOR}
  DEVICE_SEEK_PENALTY_DESCRIPTOR = _DEVICE_SEEK_PENALTY_DESCRIPTOR;
  {$EXTERNALSYM  DEVICE_SEEK_PENALTY_DESCRIPTOR}
  TDeviceSeekPenaltyDescriptor   = _DEVICE_SEEK_PENALTY_DESCRIPTOR;
  PDeviceSeekPenaltyDescriptor   = ^TDeviceSeekPenaltyDescriptor;

type
  
  _ATA_PASS_THROUGH_EX = packed record
    Length: Word;
    AtaFlags: Word;
    PathId: UCHAR;
    TargetId: UCHAR;
    Lun: UCHAR;
    ReservedAsUchar: UCHAR;
    DataTransferLength: ULONG;
    TimeOutValue: ULONG;
    ReservedAsUlong: ULONG;
    DataBufferOffset: ULONG_PTR;
    PreviousTaskFile: array [0..7] of UCHAR;
    CurrentTaskFile: array [0..7] of UCHAR;
  end;
  {$EXTERNALSYM _ATA_PASS_THROUGH_EX}
  ATA_PASS_THROUGH_EX = _ATA_PASS_THROUGH_EX;
  {$EXTERNALSYM  ATA_PASS_THROUGH_EX}
  TAtaPassThroughEx   = _ATA_PASS_THROUGH_EX;
  PAtaPassThroughEx   = ^TAtaPassThroughEx;

  TATAIdentifyDeviceQuery = packed record
    header: ATA_PASS_THROUGH_EX;
    data: array [0..255] of Word;
  end;

const
  FILE_DEVICE_CONTROLLER  = $00000004;
  {$EXTERNALSYM FILE_DEVICE_CONTROLLER}

  FILE_READ_ACCESS        = $0001;
  {$EXTERNALSYM FILE_READ_ACCESS}

  FILE_WRITE_ACCESS       = $0002;
  {$EXTERNALSYM FILE_WRITE_ACCESS}

  ATA_FLAGS_DRDY_REQUIRED = $01;
  ATA_FLAGS_DATA_IN       = $02;
  ATA_FLAGS_DATA_OUT      = $04;
  ATA_FLAGS_48BIT_COMMAND = $08;
  ATA_FLAGS_USE_DMA       = $10;
  ATA_FLAGS_NO_MULTIPLE   = $20;

  IOCTL_SCSI_BASE         = FILE_DEVICE_CONTROLLER;
  IOCTL_ATA_PASS_THROUGH  = (IOCTL_SCSI_BASE shl 16) or
                            ((FILE_READ_ACCESS or FILE_WRITE_ACCESS) shl 14) or
                            ($040B shl 2) or
                            (METHOD_BUFFERED);

type
  
  _DISK_EXTENT = packed record
    DiskNumber: DWORD;
    StartingOffset: LARGE_INTEGER;
    ExtentLength: LARGE_INTEGER;
    Reserved: array [0..3] of Byte;
  end;
  {$EXTERNALSYM _DISK_EXTENT}
  DISK_EXTENT = _DISK_EXTENT;
  {$EXTERNALSYM  DISK_EXTENT}
  TDiskExtent = _DISK_EXTENT;
  PDiskExtent = ^TDiskExtent;

  _VOLUME_DISK_EXTENTS = packed record
    NumberOfDiskExtents: DWORD;
    Reserved: array [0..3] of Byte;
    Extents: array [0..0] of DISK_EXTENT;
  end;
  {$EXTERNALSYM _VOLUME_DISK_EXTENTS}
  VOLUME_DISK_EXTENTS = _VOLUME_DISK_EXTENTS;
  {$EXTERNALSYM  VOLUME_DISK_EXTENTS}
  TVolumeDiskExtents  =  VOLUME_DISK_EXTENTS;
  PVolumeDiskExtents  = ^TVolumeDiskExtents;

const
  IOCTL_VOLUME_BASE                    = $00000056;
  {$EXTERNALSYM IOCTL_VOLUME_BASE}

  IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS = (IOCTL_VOLUME_BASE shl 16) or
                                         (FILE_ANY_ACCESS shl 14) or
                                         (0 shl 2) or
                                         (METHOD_BUFFERED);
  {$EXTERNALSYM IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS}

function GetVolumePathNameA(lpszFileName: LPCSTR; lpszVolumePathName: LPSTR;
  cchBufferLength: DWORD): BOOL; stdcall; external 'kernel32.dll';

function GetVolumeNameForVolumeMountPointA(lpszVolumeMountPoint: LPCSTR;
   lpszVolumeName: LPSTR; cchBufferLength: DWORD): BOOL; stdcall; external 'kernel32.dll';

procedure PathnameToPhysicalDriveNumber(const Path: String; var PhysicalDrives: TIntegerDynArray);
var
  h: THandle;
  I: Integer;
  MountPoint: String;
  VolumeName: String;
  Size: DWORD;
  RSize: DWORD;
  P: PVolumeDiskExtents;
  dbuf: PChar;
begin

  SetLength(PhysicalDrives,0);

  dbuf := nil;
  Size := GetFullPathName(PChar(Path),0,nil,dbuf);
  SetLength(MountPoint,Size);
  if GetVolumePathNameA(PChar(Path),PChar(MountPoint),Size) = False then
  begin
    RaiseLastOSError;
  end;
  SetLength(MountPoint,StrLen(PChar(MountPoint)));

  Size := 50;  
  SetLength(VolumeName,Size);
  if GetVolumeNameForVolumeMountPointA(PChar(MountPoint),PChar(VolumeName),Size) = False then
  begin
    RaiseLastOSError;
  end;
  SetLength(VolumeName,StrLen(PChar(VolumeName)));
  VolumeName := ExcludeTrailingPathDelimiter(VolumeName);

  h := CreateFile(PChar(VolumeName),FILE_READ_ATTRIBUTES,
                  FILE_SHARE_READ or FILE_SHARE_WRITE,nil,
                  OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0);
  if h = INVALID_HANDLE_VALUE then
  begin
    RaiseLastOSError;
  end;

  try
    Size := SizeOf(TVolumeDiskExtents);
    P := AllocMem(Size);
    try
      FillChar(P^,Size,0);
      RSize := 0;
      if DeviceIoControl(h,IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS,
                         nil,0,
                         P,Size,
                         RSize,nil) = False then
      begin
        if GetLastError <> ERROR_MORE_DATA then
        begin
          RaiseLastOSError;
        end;

        Size := SizeOf(TVolumeDiskExtents) +
                SizeOf(DISK_EXTENT) * (P^.NumberOfDiskExtents - 1);
        ReallocMem(P,Size);
        FillChar(P^,Size,0);
        if DeviceIoControl(h,IOCTL_VOLUME_GET_VOLUME_DISK_EXTENTS,
                           nil,0,
                           P,Size,
                           RSize,nil) = False then
        begin
          RaiseLastOSError;
        end;
      end;

      SetLength(PhysicalDrives,P^.NumberOfDiskExtents);
      for I := 0 to P^.NumberOfDiskExtents - 1 do
      begin
        PhysicalDrives[I] := P^.Extents[I].DiskNumber;
      end;

    finally
      FreeMem(P);
    end;

  finally
    CloseHandle(h);
  end;

end;

function HasNominalMediaRotationRate(const PhysicalDrivePath: String): Boolean;
var
  h: THandle;
  ATAIdentifyDeviceQuery: TATAIdentifyDeviceQuery;
  RSize: DWORD;
begin

  h := CreateFile(PChar(PhysicalDrivePath),GENERIC_READ or GENERIC_WRITE,
                  FILE_SHARE_READ or FILE_SHARE_WRITE,nil,
                  OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0);
  if h = INVALID_HANDLE_VALUE then
  begin
    RaiseLastOSError;
  end;

  try
    FillChar(ATAIdentifyDeviceQuery,SizeOf(ATAIdentifyDeviceQuery),0);
    with ATAIdentifyDeviceQuery do
    begin
      header.Length := SizeOf(header);
      header.AtaFlags := ATA_FLAGS_DATA_IN;
      header.DataTransferLength := SizeOf(data);
      header.TimeOutValue := 3;  
      header.DataBufferOffset := SizeOf(header);
      header.CurrentTaskFile[6] := $EC;  
    end;

    RSize := 0;
    if DeviceIoControl(h,IOCTL_ATA_PASS_THROUGH,
                       @ATAIdentifyDeviceQuery,SizeOf(ATAIdentifyDeviceQuery),
                       @ATAIdentifyDeviceQuery,SizeOf(ATAIdentifyDeviceQuery),
                       RSize,nil) = False then
    begin
      RaiseLastOSError;
    end;

    Result := (ATAIdentifyDeviceQuery.data[217] = 1);

  finally
    CloseHandle(h);
  end;

end;

function HasNoSeekPenalty(const PhysicalDrivePath: String): Boolean;
var
  h :THandle;
  StoragePropertyQuery: TStoragePropertyQuery;
  DeviceSeekPenaltyDescriptor: TDeviceSeekPenaltyDescriptor;
  RSize: DWORD;
begin

  h := CreateFile(PChar(PhysicalDrivePath),FILE_READ_ATTRIBUTES,
                  FILE_SHARE_READ or FILE_SHARE_WRITE,nil,
                  OPEN_EXISTING,FILE_ATTRIBUTE_NORMAL,0);
  if h = INVALID_HANDLE_VALUE then
  begin
    RaiseLastOSError;
  end;

  try
    with StoragePropertyQuery do
    begin
      PropertyId := Ord(StorageDeviceSeekPenaltyProperty);
      QueryType  := Ord(PropertyStandardQuery);
    end;

    FillChar(DeviceSeekPenaltyDescriptor,SizeOf(DeviceSeekPenaltyDescriptor),0);
    RSize := 0;
    if DeviceIoControl(h,IOCTL_STORAGE_QUERY_PROPERTY,
                       @StoragePropertyQuery,SizeOf(StoragePropertyQuery),
                       @DeviceSeekPenaltyDescriptor,SizeOf(DeviceSeekPenaltyDescriptor),
                       RSize,nil) = False then
    begin
      RaiseLastOSError;
    end;

    Result := not DeviceSeekPenaltyDescriptor.IncursSeekPenalty;

  finally
    CloseHandle(h);
  end;

end;

function IsSSD(Path: String): Boolean;
var
  Index: Integer;
  IsSSD: Boolean;
  PhysicalDrives: TIntegerDynArray;
  PhysicalDrivePath: String;
begin
  Result := false;
  try
    SetLength(PhysicalDrives,0);
    PathnameToPhysicalDriveNumber(Path,PhysicalDrives);

    for Index := Low(PhysicalDrives) to High(PhysicalDrives) do
    begin
      PhysicalDrivePath := Format('\\.\PhysicalDrive%d',[PhysicalDrives[Index]]);
      try
        if True then 
        begin
          
          Result := Result or HasNoSeekPenalty(PhysicalDrivePath);
        end
        else
        begin
          
          Result := Result or HasNominalMediaRotationRate(PhysicalDrivePath);
        end;

      except
        
      end;

      if Result = True then
      begin
        Break;
      end;
    end;
  except
    Result := false;
  end;
end;

end.
