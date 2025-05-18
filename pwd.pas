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
unit pwd;

interface

uses
  initc,unixtype,baseunix,ctypes;

{$IFDEF FPC}
{$PACKRECORDS C}
{$ENDIF}

const
      External_library= clib;  

  const
     _PATH_PWD = '/etc';     
     _PATH_PASSWD = '/etc/passwd';     
     _PASSWD = 'passwd';     
     _PATH_MASTERPASSWD = '/etc/master.passwd';     
{$ifdef Darwin}
     _PATH_MASTERPASSWD_LOCK = '/etc/ptmp';
{$endif}
     _MASTERPASSWD = 'master.passwd';     

     _PATH_MP_DB = '/etc/pwd.db';     
     _MP_DB = 'pwd.db';     
     _PATH_SMP_DB = '/etc/spwd.db';     
     _SMP_DB = 'spwd.db';     
     _PATH_PWD_MKDB = '/usr/sbin/pwd_mkdb';     

{$ifdef BSD}
  _PW_VERSION_MASK = #$F0;     

  function _PW_VERSIONED(x,v : longint) : cuchar; inline; 

  const
     _PW_KEYBYNAME    = #$31;           
     _PW_KEYBYNUM     = #$32;        
     _PW_KEYBYUID     = #$33;        
   {$ifdef FreeBSD}
     _PW_KEYYPENABLED = #$34;        
     _PW_KEYYPBYNUM   = #$35;        
   {$endif}

const  
   {$ifdef FreeBSD}
    _PWD_VERSION_KEY	 = #$FF+'VERSION';
    _PWD_CURRENT_VERSION = #$4;
   {$endif}
    _PASSWORD_EFMT1      = '_';      	 
    _PASSWORD_LEN        = 128;         
  {$ifdef Darwin}
    _PASSWORD_NOUID         = $01;    
    _PASSWORD_NOGID         = $02;    
    _PASSWORD_NOCHG         = $04;    
    _PASSWORD_NOEXP          =$08;    
    _PASSWORD_WARNDAYS      = 14;     
    _PASSWORD_CHGNOW        = -1;     
  {$endif}
 
{$endif}

type

     PPasswd  = ^TPasswd;
     PPPasswd = ^PPasswd;
     Passwd   = record
            pw_name    : pchar;        
            pw_passwd  : pchar;	
            pw_uid     : Tuid;		
            pw_gid     : Tgid;		
            {$ifdef bsd}
            pw_change  : Ttime platform;         
            pw_class   : pchar platform;        
            {$endif}
            pw_gecos   : pchar;        
            pw_dir     : pchar;        
            pw_shell   : pchar;        
            {$ifdef bsd}
            pw_expire  : Ttime platform;         
            {$ifdef FreeBSD}
            pw_fields  : cint platform;          
            {$endif}
            {$endif}
         end;
     TPasswd  = Passwd;

{$ifdef FreeBSD}
const
        _PWF_NAME	 = 	1;
        _PWF_PASSWD	 = 	2;
        _PWF_UID	 = 	4;
        _PWF_GID	 = 	8;
        _PWF_CHANGE      =    $10;
        _PWF_CLASS	 =    $20;
        _PWF_GECOS	 =    $40;
        _PWF_DIR	 =    $80;
        _PWF_SHELL	 =   $100;
        _PWF_EXPIRE	 =   $200;

        _PWF_SOURCE 	 = $3000;       
        _PWF_FILES 	 = $1000;       
        _PWF_NIS 	 = $2000;       
        _PWF_HESIOD 	 = $3000;       
{$endif}

function  fpgetpwnam (name:pchar):PPasswd; cdecl;external External_library name 'getpwnam';
function  fpgetpwuid (id:tuid):PPasswd;cdecl;external External_library name 'getpwuid';

procedure fpendpwent;cdecl;external External_library name 'endpwent';
function  fpgetpwent:ppasswd;cdecl;external External_library name 'getpwent';
procedure fpsetpwent;cdecl;external External_library name 'setpwent';

function  fpgetpwnam_r (namepara1:pchar; pwd:Ppasswd; buffer:pchar; bufsize:size_t; pwresult:PPpasswd):cint;cdecl;external External_library name 'getpwnam_r';
function  fpgetpwuid_r (uid:uid_t; pwd:Ppasswd; buffer:pchar; buffersize:size_t; pwresult:PPpasswd):cint;cdecl;external External_library name 'getpwuid_r';
{$ifndef Darwin}
function  fpgetpwent_r (pwd:Ppasswd; buffer:pchar; buffersize:size_t; pwresult:PPpasswd):cint;cdecl;external External_library name 'getpwent_r';
{$endif}

implementation

{$ifdef BSD}
function _PW_VERSIONED (x,v : longint) : cuchar; inline; 

begin
 _PW_VERSIONED:=  (x and $CF) or  (v shl 4);
end;
{$endif}

end.
