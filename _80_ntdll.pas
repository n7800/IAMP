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

UNIT _80_ntdll;
  
INTERFACE

const
  ntdll           = 'ntdll';

{$include _90_winerrors.inc}

type
  
   _1bit     = 0 ..                $1;
   _2bits    = 0 ..                $3;
   _3bits    = 0 ..                $7;
   _4bits    = 0 ..                $F;
   _5bits    = 0 ..               $1F;
   _6bits    = 0 ..               $3F;
   _7bits    = 0 ..               $7F;
   _8bits    = 0 ..               $FF;    
   _9bits    = 0 ..              $1FF;

  _10bits    = 0 ..              $3FF;
  _11bits    = 0 ..              $7FF;
  _12bits    = 0 ..              $FFF;
  _13bits    = 0 ..             $1FFF;
  _14bits    = 0 ..             $3FFF;
  _15bits    = 0 ..             $7FFF;
  _16bits    = 0 ..             $FFFF;    
  _17bits    = 0 ..            $1FFFF;
  _18bits    = 0 ..            $3FFFF;
  _19bits    = 0 ..            $7FFFF;

  _20bits    = 0 ..            $FFFFF;
  _21bits    = 0 ..           $1FFFFF;
  _22bits    = 0 ..           $3FFFFF;
  _23bits    = 0 ..           $7FFFFF;
  _24bits    = 0 ..           $FFFFFF;
  _25bits    = 0 ..          $1FFFFFF;
  _26bits    = 0 ..          $3FFFFFF;
  _27bits    = 0 ..          $7FFFFFF;
  _28bits    = 0 ..          $FFFFFFF;
  _29bits    = 0 ..         $1FFFFFFF;

  _30bits    = 0 ..         $3FFFFFFF;
  _31bits    = 0 ..         $7FFFFFFF;

  _32bits    = 0 ..         $FFFFFFFF;    

  _33bits    = 0 ..        $1FFFFFFFF;
  _34bits    = 0 ..        $3FFFFFFFF;
  _35bits    = 0 ..        $7FFFFFFFF;
  _36bits    = 0 ..        $FFFFFFFFF;
  _37bits    = 0 ..       $1FFFFFFFFF;
  _38bits    = 0 ..       $3FFFFFFFFF;
  _39bits    = 0 ..       $7FFFFFFFFF;

  _40bits    = 0 ..       $FFFFFFFFFF;
  _41bits    = 0 ..      $1FFFFFFFFFF;
  _42bits    = 0 ..      $3FFFFFFFFFF;
  _43bits    = 0 ..      $7FFFFFFFFFF;
  _44bits    = 0 ..      $FFFFFFFFFFF;
  _45bits    = 0 ..     $1FFFFFFFFFFF;
  _46bits    = 0 ..     $3FFFFFFFFFFF;
  _47bits    = 0 ..     $7FFFFFFFFFFF;
  _48bits    = 0 ..     $FFFFFFFFFFFF;
  _49bits    = 0 ..    $1FFFFFFFFFFFF;

  _50bits    = 0 ..    $3FFFFFFFFFFFF;
  _51bits    = 0 ..    $7FFFFFFFFFFFF;
  _52bits    = 0 ..    $FFFFFFFFFFFFF;
  _53bits    = 0 ..   $1FFFFFFFFFFFFF;
  _54bits    = 0 ..   $3FFFFFFFFFFFFF;
  _55bits    = 0 ..   $7FFFFFFFFFFFFF;
  _56bits    = 0 ..   $FFFFFFFFFFFFFF;
  _57bits    = 0 ..  $1FFFFFFFFFFFFFF;
  _58bits    = 0 ..  $3FFFFFFFFFFFFFF;
  _59bits    = 0 ..  $7FFFFFFFFFFFFFF;

  _60bits    = 0 ..  $FFFFFFFFFFFFFFF;
  _61bits    = 0 .. $1FFFFFFFFFFFFFFF;
  _62bits    = 0 .. $3FFFFFFFFFFFFFFF;
  _63bits    = 0 .. $7FFFFFFFFFFFFFFF;

type
  PNTSTATUS   = ^NTSTATUS;
  NTSTATUS    = DWORD;                                

  PHRESULT    = ^HRESULT;
  HRESULT     = DWORD;                                

  ppointer    = ^pointer;

  ppwidechar  = ^pwidechar;

  PDWORD      = ^DWORD;
  PPDWORD     = ^PDWORD;

  ppchar      = ^pchar;
  plongint    = ^longint;
  pplongint   = ^plongint;

  pptruint    = ^ptruint;
  pptrint     = ^ptrint;

  ppbyte      = ^pbyte;
  pbyte       = ^byte;
  pword       = ^word;

  pboolean    = ^boolean;

  pint32      = plongint;

  psingle     = ^single;
  pdouble     = ^double;

  PHANDLE     = ^THANDLE;
  THANDLE     = ptruint;                              

type
  
  LOWORD      = word;

const
  INVALID_HANDLE_VALUE = ptruint(-1);

type
  
  PHWND       = ^HWND;
  HWND        = THANDLE;                              

type
  PHKEY       = ^HKEY;
  HKEY        = THANDLE;                              

type
  
  PMODULE     = PHANDLE;
  HMODULE     = THANDLE;                              

  HHEAP       = pointer;                              

  PRESDATA    = pointer;                              
  PPRESDATA   = ^PRESDATA;

  PBOOL       = ^BOOL;
  BOOL        = longbool;                             

type
  PSECURITY_ATTRIBUTES = ^TSECURITY_ATTRIBUTES;
  TSECURITY_ATTRIBUTES = record                       
     Length                : DWORD;
     SecurityDescriptor    : pointer;
     InheritHandle         : BOOL;
  end;

const
  
  DELETE                         =       $10000;
  READ_CONTROL                   =       $20000;
  WRITE_DAC                      =       $40000;
  WRITE_OWNER                    =       $80000;
  SYNCHRONIZE                    =      $100000;

  STANDARD_RIGHTS_REQUIRED       =       $F0000;

  STANDARD_RIGHTS_READ           = READ_CONTROL;
  STANDARD_RIGHTS_WRITE          = READ_CONTROL;
  STANDARD_RIGHTS_EXECUTE        = READ_CONTROL;

  STANDARD_RIGHTS_ALL            =      $1F0000;

  SPECIFIC_RIGHTS_ALL            =        $FFFF;

  ACCESS_SYSTEM_SECURITY         =     $1000000;

  MAXIMUM_ALLOWED                =     $2000000;

  GENERIC_READ                   =    $80000000;
  GENERIC_WRITE                  =    $40000000;
  GENERIC_EXECUTE                =    $20000000;
  GENERIC_ALL                    =    $10000000; 

const
  FILE_READ_DATA            =   $1;    
  FILE_READ_ACCESS          = FILE_READ_DATA;

  FILE_LIST_DIRECTORY       =   $1;    

  FILE_WRITE_DATA           =   $2;    
  FILE_WRITE_ACCESS         = FILE_WRITE_DATA;

  FILE_ADD_FILE             =   $2;    

  FILE_APPEND_DATA          =   $4;    
  FILE_ADD_SUBDIRECTORY     =   $4;    
  FILE_CREATE_PIPE_INSTANCE =   $4;    

  FILE_READ_EA              =   $8;    

  FILE_WRITE_EA             =  $10;    

  FILE_EXECUTE              =  $20;    
  FILE_TRAVERSE             =  $20;    

  FILE_DELETE_CHILD         =  $40;    

  FILE_READ_ATTRIBUTES      =  $80;    

  FILE_WRITE_ATTRIBUTES     = $100;    

  FILE_ALL_ACCESS           = STANDARD_RIGHTS_REQUIRED or
                              SYNCHRONIZE              or
                              $1FF;

  FILE_GENERIC_READ         = STANDARD_RIGHTS_READ     or
                              FILE_READ_DATA           or
                              FILE_READ_ATTRIBUTES     or
                              FILE_READ_EA             or
                              SYNCHRONIZE;

  FILE_GENERIC_WRITE        = STANDARD_RIGHTS_WRITE    or
                              FILE_WRITE_DATA          or
                              FILE_WRITE_ATTRIBUTES    or
                              FILE_WRITE_EA            or
                              FILE_APPEND_DATA         or
                              SYNCHRONIZE;

  FILE_GENERIC_EXECUTE      = STANDARD_RIGHTS_EXECUTE  or
                              FILE_READ_ATTRIBUTES     or
                              FILE_EXECUTE             or
                              SYNCHRONIZE;

const
  
  FILE_SHARE_READ                      =          $1;
  FILE_SHARE_WRITE                     =          $2;
  FILE_SHARE_DELETE                    =          $4;

  FILE_SHARE_VALID_FLAGS               =          $7;

const
  FILE_ATTRIBUTE_READONLY              =          $1;
  FILE_ATTRIBUTE_HIDDEN                =          $2;
  FILE_ATTRIBUTE_SYSTEM                =          $4;

  FILE_ATTRIBUTE_VOLUME                =          $8;

  FILE_ATTRIBUTE_DIRECTORY             =         $10;

  FILE_ATTRIBUTE_ARCHIVE               =         $20;
  FILE_ATTRIBUTE_DEVICE                =         $40;
  FILE_ATTRIBUTE_NORMAL                =         $80;
  FILE_ATTRIBUTE_TEMPORARY             =        $100;
  FILE_ATTRIBUTE_SPARSE_FILE           =        $200;
  FILE_ATTRIBUTE_REPARSE_POINT         =        $400;
  FILE_ATTRIBUTE_COMPRESSED            =        $800;
  FILE_ATTRIBUTE_OFFLINE               =       $1000;
  FILE_ATTRIBUTE_NOT_CONTENT_INDEXED   =       $2000;
  FILE_ATTRIBUTE_ENCRYPTED             =       $4000;
  FILE_ATTRIBUTE_INTEGRITY_STREAM      =       $8000;
  FILE_ATTRIBUTE_VIRTUAL               =      $10000;
  FILE_ATTRIBUTE_NO_SCRUB_DATA         =      $20000;

  FILE_ATTRIBUTE_EA                    =      $40000;
  FILE_ATTRIBUTE_RECALL_ON_OPEN        =      $40000;

  FILE_ATTRIBUTE_PINNED                =      $80000;
  FILE_ATTRIBUTE_UNPINNED              =     $100000;
  FILE_ATTRIBUTE_RECALL_ON_DATA_ACCESS =     $400000;

  FILE_ATTRIBUTE_VALID_FLAGS_W7        =       $7FB7;
  FILE_ATTRIBUTE_VALID_SET_FLAGS_W7    =       $31A7;

  FILE_ATTRIBUTE_VALID_FLAGS_1703      =      $2FFB7;
  FILE_ATTRIBUTE_VALID_SET_FLAGS_1703  =      $231A7;

  FILE_ATTRIBUTE_VALID_FLAGS_1709      =     $5AFFB7;
  FILE_ATTRIBUTE_VALID_SET_FLAGS_1709  =     $1A31A7;

  TREE_CONNECT_ATTRIBUTE_PINNED        =          $2;
  TREE_CONNECT_ATTRIBUTE_GLOBAL        =          $4;
  TREE_CONNECT_ATTRIBUTE_PRIVACY       =       $4000;
  TREE_CONNECT_ATTRIBUTE_INTEGRITY     =       $8000;

  FILE_ATTRIBUTE_STRICTLY_SEQUENTIAL   =   $20000000;

  MAILSLOT_NO_MESSAGE                  =   DWORD(-1);
  MAILSLOT_WAIT_FOREVER                =   DWORD(-1);

  FILE_CASE_SENSITIVE_SEARCH           =          $1;
  FILE_CASE_PRESERVED_NAMES            =          $2;
  FILE_UNICODE_ON_DISK                 =          $4;
  FILE_PERSISTENT_ACLS                 =          $8;
  FILE_FILE_COMPRESSION                =         $10;
  FILE_VOLUME_QUOTAS                   =         $20;
  FILE_SUPPORTS_SPARSE_FILES           =         $40;
  FILE_SUPPORTS_REPARSE_POINTS         =         $80;
  FILE_SUPPORTS_REMOTE_STORAGE         =        $100;
  FILE_RETURNS_CLEANUP_RESULT_INFO     =        $200;
  FILE_SUPPORTS_POSIX_UNLINK_RENAME    =        $400;
  FILE_SUPPORTS_BYPASS_IO              =        $800;

  FILE_VOLUME_IS_COMPRESSED            =       $8000;
  FILE_SUPPORTS_OBJECT_IDS             =      $10000;
  FILE_SUPPORTS_ENCRYPTION             =      $20000;
  FILE_NAMED_STREAMS                   =      $40000;
  FILE_READ_ONLY_VOLUME                =      $80000;
  FILE_SEQUENTIAL_WRITE_ONCE           =     $100000;
  FILE_SUPPORTS_TRANSACTIONS           =     $200000;
  FILE_SUPPORTS_HARD_LINKS             =     $400000;
  FILE_SUPPORTS_EXTENDED_ATTRIBUTES    =     $800000;
  FILE_SUPPORTS_OPEN_BY_FILE_ID        =    $1000000;
  FILE_SUPPORTS_USN_JOURNAL            =    $2000000;
  FILE_SUPPORTS_INTEGRITY_STREAMS      =    $4000000;
  FILE_SUPPORTS_BLOCK_REFCOUNTING      =    $8000000;
  FILE_SUPPORTS_SPARSE_VDL             =   $10000000;
  FILE_DAX_VOLUME                      =   $20000000;
  FILE_SUPPORTS_GHOSTING               =   $40000000;

  FILE_INVALID_FILE_ID                 = ptruint(-1);

const
  
  IO_REPARSE_TAG_MOUNT_POINT           = $A0000003;
  IO_REPARSE_TAG_HSM                   = $C0000004;
  IO_REPARSE_TAG_HSM2                  = $80000006;
  IO_REPARSE_TAG_SIS                   = $80000007;
  IO_REPARSE_TAG_WIM                   = $80000008;
  IO_REPARSE_TAG_CSV                   = $80000009;
  IO_REPARSE_TAG_DFS                   = $8000000A;
  IO_REPARSE_TAG_SYMLINK               = $A000000C;
  IO_REPARSE_TAG_DFSR                  = $80000012;
  IO_REPARSE_TAG_DEDUP                 = $80000013;
  IO_REPARSE_TAG_NFS                   = $80000014;
  IO_REPARSE_TAG_FILE_PLACEHOLDER      = $80000015;
  IO_REPARSE_TAG_WOF                   = $80000017;
  IO_REPARSE_TAG_WCI                   = $80000018;
  IO_REPARSE_TAG_WCI_1                 = $90001018;
  IO_REPARSE_TAG_GLOBAL_REPARSE        = $A0000019;
  IO_REPARSE_TAG_CLOUD                 = $9000001A;
  IO_REPARSE_TAG_CLOUD_1               = $9000101A;
  IO_REPARSE_TAG_CLOUD_2               = $9000201A;
  IO_REPARSE_TAG_CLOUD_3               = $9000301A;
  IO_REPARSE_TAG_CLOUD_4               = $9000401A;
  IO_REPARSE_TAG_CLOUD_5               = $9000501A;
  IO_REPARSE_TAG_CLOUD_6               = $9000601A;
  IO_REPARSE_TAG_CLOUD_7               = $9000701A;
  IO_REPARSE_TAG_CLOUD_8               = $9000801A;
  IO_REPARSE_TAG_CLOUD_9               = $9000901A;
  IO_REPARSE_TAG_CLOUD_A               = $9000A01A;
  IO_REPARSE_TAG_CLOUD_B               = $9000B01A;
  IO_REPARSE_TAG_CLOUD_C               = $9000C01A;
  IO_REPARSE_TAG_CLOUD_D               = $9000D01A;
  IO_REPARSE_TAG_CLOUD_E               = $9000E01A;
  IO_REPARSE_TAG_CLOUD_F               = $9000F01A;
  IO_REPARSE_TAG_CLOUD_MASK            = $0000F000;
  IO_REPARSE_TAG_APPEXECLINK           = $8000001B;
  IO_REPARSE_TAG_PROJFS                = $9000001C;
  IO_REPARSE_TAG_STORAGE_SYNC          = $8000001E;
  IO_REPARSE_TAG_WCI_TOMBSTONE         = $A000001F;
  IO_REPARSE_TAG_UNHANDLED             = $80000020;
  IO_REPARSE_TAG_ONEDRIVE              = $80000021;
  IO_REPARSE_TAG_PROJFS_TOMBSTONE      = $A0000022;
  IO_REPARSE_TAG_AF_UNIX               = $80000023;
  IO_REPARSE_TAG_WCI_LINK              = $A0000027;
  IO_REPARSE_TAG_WCI_LINK_1            = $A0001027;
  IO_REPARSE_TAG_DATALESS_CIM          = $A0000028;

const
  
  FILE_OPBATCH_BREAK_UNDERWAY              =        $9;

const
  
  FILE_FLAG_WRITE_THROUGH                  = $80000000;
  FILE_FLAG_OVERLAPPED                     = $40000000;
  FILE_FLAG_NO_BUFFERING                   = $20000000;
  FILE_FLAG_RANDOM_ACCESS                  = $10000000;
  FILE_FLAG_SEQUENTIAL_SCAN                =  $8000000;
  FILE_FLAG_DELETE_ON_CLOSE                =  $4000000;
  FILE_FLAG_BACKUP_SEMANTICS               =  $2000000;
  FILE_FLAG_POSIX_SEMANTICS                =  $1000000;
  FILE_FLAG_SESSION_AWARE                  =   $800000;
  FILE_FLAG_OPEN_REPARSE_POINT             =   $200000;
  FILE_FLAG_OPEN_NO_RECALL                 =   $100000;
  FILE_FLAG_FIRST_PIPE_INSTANCE            =    $80000;

  FILE_FLAG_OPEN_REQUIRING_OPLOCK          =    $40000;

const
  
  CREATE_NEW                               =         1;
  CREATE_ALWAYS                            =         2;
  OPEN_EXISTING                            =         3;
  OPEN_ALWAYS                              =         4;
  TRUNCATE_EXISTING                        =         5;

const
  
  FILE_SUPERSEDE                           =         0;
  FILE_OPEN                                =         1;
  FILE_CREATE                              =         2;
  FILE_OPEN_IF                             =         3;
  FILE_OVERWRITE                           =         4;
  FILE_OVERWRITE_IF                        =         5;

  FILE_MAXIMUM_DISPOSITION                 =         5;

const
  
  FILE_DIRECTORY_FILE                      =        $1;
  FILE_WRITE_THROUGH                       =        $2;
  FILE_SEQUENTIAL_ONLY                     =        $4;
  FILE_NO_INTERMEDIATE_BUFFERING           =        $8;

  FILE_SYNCHRONOUS_IO_ALERT                =       $10;
  FILE_SYNCHRONOUS_IO_NONALERT             =       $20;
  FILE_NON_DIRECTORY_FILE                  =       $40;
  FILE_CREATE_TREE_CONNECTION              =       $80;

  FILE_COMPLETE_IF_OPLOCKED                =      $100;
  FILE_NO_EA_KNOWLEDGE                     =      $200;

  FILE_OPEN_FOR_RECOVERY                   =      $400;
  FILE_OPEN_REMOTE_INSTANCE                =      FILE_OPEN_FOR_RECOVERY;

  FILE_RANDOM_ACCESS                       =      $800;

  FILE_DELETE_ON_CLOSE                     =     $1000;
  FILE_OPEN_BY_FILE_ID                     =     $2000;
  FILE_OPEN_FOR_BACKUP_INTENT              =     $4000;
  FILE_NO_COMPRESSION                      =     $8000;

  FILE_OPEN_REQUIRING_OPLOCK               =    $10000;
  FILE_DISALLOW_EXCLUSIVE                  =    $20000;

  FILE_SESSION_AWARE                       =    $40000;

  FILE_RESERVE_OPFILTER                    =   $100000;
  FILE_OPEN_REPARSE_POINT                  =   $200000;
  FILE_OPEN_NO_RECALL                      =   $400000;
  FILE_OPEN_FOR_FREE_SPACE_QUERY           =   $800000;

  FILE_COPY_STRUCTURED_STORAGE             =       $41;
  FILE_STRUCTURED_STORAGE                  =      $441;

const
  
  FILE_VALID_OPTION_FLAGS                  =   $FFFFFF;
  FILE_VALID_PIPE_OPTION_FLAGS             =       $32;
  FILE_VALID_MAILSLOT_OPTION_FLAGS         =       $32;
  FILE_VALID_SET_FLAGS                     =       $36;

const
  
  FILE_SUPERSEDED                          =        $0;
  FILE_OPENED                              =        $1;
  FILE_CREATED                             =        $2;
  FILE_OVERWRITTEN                         =        $3;
  FILE_EXISTS                              =        $4;
  FILE_DOES_NOT_EXIST                      =        $5;

const
  
  FILE_WRITE_TO_END_OF_FILE                = $FFFFFFFF;
  FILE_USE_FILE_POINTER_POSITION           = $FFFFFFFE;

const
  
  FILE_BYTE_ALIGNMENT                      =        $0;
  FILE_WORD_ALIGNMENT                      =        $1;
  FILE_LONG_ALIGNMENT                      =        $3;
  FILE_QUAD_ALIGNMENT                      =        $7;
  FILE_OCTA_ALIGNMENT                      =        $F;
  FILE_32_BYTE_ALIGNMENT                   =       $1F;
  FILE_64_BYTE_ALIGNMENT                   =       $3F;
  FILE_128_BYTE_ALIGNMENT                  =       $7F;
  FILE_256_BYTE_ALIGNMENT                  =       $FF;
  FILE_512_BYTE_ALIGNMENT                  =      $1FF;

const
  
  MAXIMUM_FILENAME_LENGTH                  =       256;

const
  
  FILE_REMOVABLE_MEDIA                     =        $1;
  FILE_READ_ONLY_DEVICE                    =        $2;
  FILE_FLOPPY_DISKETTE                     =        $4;
  FILE_WRITE_ONCE_MEDIA                    =        $8;
  FILE_REMOTE_DEVICE                       =       $10;
  FILE_DEVICE_IS_MOUNTED                   =       $20;
  FILE_VIRTUAL_VOLUME                      =       $40;
  FILE_AUTOGENERATED_DEVICE_NAME           =       $80;
  FILE_DEVICE_SECURE_OPEN                  =      $100;
  FILE_CHARACTERISTIC_PNP_DEVICE           =      $800;
  FILE_CHARACTERISTIC_TS_DEVICE            =     $1000;
  FILE_CHARACTERISTIC_WEBDAV_DEVICE        =     $2000;
  FILE_CHARACTERISTIC_CSV                  =    $10000;
  FILE_DEVICE_ALLOW_APPCONTAINER_TRAVERSAL =    $20000;
  FILE_PORTABLE_DEVICE                     =    $40000;

const
  
  MEM_COMMIT                      =     $1000;
  MEM_RESERVE                     =     $2000;
  MEM_DECOMMIT                    =     $4000;
  MEM_RELEASE                     =     $8000;
  MEM_FREE                        =    $10000;
  MEM_PRIVATE                     =    $20000;
  MEM_MAPPED                      =    $40000;
  MEM_RESET                       =    $80000;
  MEM_TOP_DOWN                    =   $100000;
  MEM_RESET_UNDO                  =  $1000000;

  MEM_LARGE_PAGES                 = $20000000;
  MEM_4MB_PAGES                   = $80000000;

  MEM_REPLACE_PLACEHOLDER         =     $4000;        
  MEM_RESERVE_PLACEHOLDER         =    $40000;        

  MEM_WRITE_WATCH                 =   $200000;
  MEM_PHYSICAL                    =   $400000;
  MEM_ROTATE                      =   $800000;
  MEM_DIFFERENT_IMAGE_BASE_OK     =   $800000;

  MEM_64K_PAGES                   = MEM_LARGE_PAGES or MEM_PHYSICAL;

  MEM_UNMAP_WITH_TRANSIENT_BOOST  =        $1;

  MEM_COALESCE_PLACEHOLDERS       =        $1;        
  MEM_PRESERVE_PLACEHOLDER        =        $2;        

const
  
  SEC_HUGE_PAGES                  =    $20000;
  SEC_64K_PAGES                   =    $80000;
  SEC_PARTITION_OWNER_HANDLE      =    $40000;
  SEC_BASED                       =   $200000;

  SEC_NO_CHANGE                   =   $400000;
  SEC_NO_IMAGE                    = SEC_NO_CHANGE;

  SEC_FILE                        =   $800000;
  SEC_IMAGE                       =  $1000000;
  SEC_PROTECTED_IMAGE             =  $2000000;
  SEC_RESERVE                     =  $4000000;
  SEC_COMMIT                      =  $8000000;
  SEC_NOCACHE                     = $10000000;
  SEC_GLOBAL                      = $20000000;
  SEC_WRITECOMBINE                = $40000000;
  SEC_LARGE_PAGES                 = $80000000;

  SEC_IMAGE_NO_EXECUTE            = SEC_IMAGE or SEC_NOCACHE;
  MEM_IMAGE                       = SEC_IMAGE;

const
  
  PAGE_NOACCESS                   =        $1;
  PAGE_READONLY                   =        $2;
  PAGE_READWRITE                  =        $4;
  PAGE_WRITECOPY                  =        $8;
  PAGE_EXECUTE                    =       $10;
  PAGE_EXECUTE_READ               =       $20;
  PAGE_EXECUTE_READWRITE          =       $40;
  PAGE_EXECUTE_WRITECOPY          =       $80;
  PAGE_GUARD                      =      $100;
  PAGE_NOCACHE                    =      $200;
  PAGE_WRITECOMBINE               =      $400;

  PAGE_ENCLAVE_DECOMMIT           = $10000000;
  PAGE_ENCLAVE_UNVALIDATED        = $20000000;
  PAGE_TARGETS_NO_UPDATE          = $40000000;
  PAGE_TARGETS_INVALID            = $40000000;
  PAGE_ENCLAVE_THREAD_CONTROL     = $80000000;
  PAGE_REVERT_TO_FILE_MAP         = $80000000;

const
  
  SECTION_QUERY                =  $1;
  SECTION_MAP_WRITE            =  $2;
  SECTION_MAP_READ             =  $4;
  SECTION_MAP_EXECUTE          =  $8;
  SECTION_EXTEND_SIZE          = $10;
  SECTION_MAP_EXECUTE_EXPLICIT = $20; 

  SECTION_ALL_ACCESS           = STANDARD_RIGHTS_REQUIRED or
                                 SECTION_QUERY            or
                                 SECTION_MAP_WRITE        or
                                 SECTION_MAP_READ         or
                                 SECTION_MAP_EXECUTE      or
                                 SECTION_EXTEND_SIZE;

type
  
  PPOVERLAPPED = ^POVERLAPPED;
  POVERLAPPED  = ^TOVERLAPPED;                        
  TOVERLAPPED  = record
    Internal      : ptruint;
    InternalHigh  : ptruint;

    Union         : record
      case integer of
        1 : (
             Offset     : DWORD;
             OffsetHigh : DWORD;
            );

        2 : (
             ptr        : pointer;                   
            );
    end;

    hEvent        : THANDLE;
  end;

const
  COMPARE_EQUAL   =  0;
  COMPARE_GREATER =  1;
  COMPARE_LESS    = -1;

{$include _90_image.inc}

const
  WIN7_MAJOR  =     6;
  WIN7_MINOR  =     1;

  WIN8_MAJOR  =     6;
  WIN8_MINOR  =     2;

  WIN81_MAJOR =     6;
  WIN81_MINOR =     3;

  WIN10_MAJOR =    10;
  WIN10_MINOR =     0;
  WIN10_21H1  = 19043;  

procedure RtlGetNtVersionNumbers
             (
               OutoptMajorVersion : PDWORD;
               OutoptMinorVersion : PDWORD;
               OutoptBuild        : PDWORD
             );
          stdcall; external ntdll;

procedure RtlZeroMemory
             (
               OutToAddress : pointer;
               InZeroCount  : ptruint
             );
          stdcall; external ntdll;

const
  SPRINTF_ERROR = -1;                                 

{$ifdef FPC}
  {$ifdef CONST}
    function sprintf
               (
                 OutAsciizBuffer : pchar;
                 InAsciizFormat  : pchar;
                 InArguments     : array of const
               )
             : integer; cdecl; external ntdll;                     
  {$endif}

  {$ifndef CONST}
    function sprintf
               (
                 OutAsciizBuffer : pchar;
                 InAsciizFormat  : pchar
                 
               )
             : integer; cdecl; varargs; external ntdll;            
  {$endif}
{$endif}

function strcat
           (
             OutAsciizDestination : pchar;
             InAsciizSource       : pchar
           )
         : pchar; cdecl; external ntdll;                           

function _strcmpi
           (
             InCompareAsciizA : pchar;
             InCompareAsciizB : pchar
           )
         : integer; cdecl; external ntdll;                         

function strcpy
           (
             OutAsciizDestination : pchar;
             InAsciizSource       : pchar
           )
         : pchar; cdecl; external ntdll;                           

function _strlwr
           (
             InoutAsciizString : pchar
           )
         : pchar; cdecl; external ntdll;                           

function _strnicmp
           (
             InAsciizStringA : pchar;
             InAsciizStringB : pchar;
             InCompareCount  : ptruint
           )
         : longint; cdecl; external ntdll;                         

function strncpy
           (
             OutAsciizDestinationString : pchar;
             InSourceString             : pchar;
             InCopyCount                : ptruint
           )
         : pchar; cdecl; external ntdll;                           

function strrchr
           (
             InStringToSearch  : pchar;
             InCharToSearchFor : char
           )
         : pchar; cdecl; external ntdll;                           

IMPLEMENTATION

END.

