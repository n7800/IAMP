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
unit cNetDB;
{$ENDIF FPC_DOTTEDUNITS}

{$mode objfpc}{$H+}

interface

{$IFDEF FPC_DOTTEDUNITS}
uses
  UnixApi.Base, System.Net.Sockets,System.InitC;
{$ELSE FPC_DOTTEDUNITS}
uses
  BaseUnix, Sockets,initc;
{$ENDIF FPC_DOTTEDUNITS}
  
const
  LIB_C = clib; 
                
const

  NETDB_INTERNAL  = -(1);    
  NETDB_SUCCESS   = 0;       
  HOST_NOT_FOUND  = 1;       
  TRY_AGAIN       = 2;       
  NO_RECOVERY     = 3;       
  NO_DATA         = 4;       
  NO_ADDRESS      = NO_DATA; 

  {$IF DEFINED(FREEBSD)}

    AI_PASSIVE     = $00000001;
    AI_CANONNAME   = $00000002;
    AI_NUMERICHOST = $00000004;
    AI_V4MAPPED    = $00000008;
    AI_ALL         = $00000010;
    AI_ADDRCONFIG  = $00000020;
    AI_DEFAULT     = (AI_V4MAPPED OR AI_ADDRCONFIG);

    EAI_ADDRFAMILY = 1; 
    EAI_AGAIN      = 2; 
    EAI_BADFLAGS   = 3; 
    EAI_FAIL       = 4; 
    EAI_FAMILY     = 5; 
    EAI_MEMORY     = 6; 
    EAI_NODATA     = 7; 
    EAI_NONAME     = 8; 
    EAI_SERVICE    = 9; 
    EAI_SOCKTYPE   = 10; 
    EAI_SYSTEM     = 11; 
    EAI_BADHINTS   = 12;
    EAI_PROTOCOL   = 13;
    EAI_MAX        = 14;

  {$ELSE}

    AI_PASSIVE                  = $0001; 
    AI_CANONNAME                = $0002; 
    AI_NUMERICHOST              = $0004; 
    AI_V4MAPPED                 = $0008; 
    AI_ALL                      = $0010; 
    AI_ADDRCONFIG               = $0020; 
    AI_IDN                      = $0040; 
    AI_CANONIDN                 = $0080; 
    AI_IDN_ALLOW_UNASSIGNED     = $0100; 
    AI_IDN_USE_STD3_ASCII_RULES = $0200; 
    AI_NUMERICSERV              = $0400; 

    EAI_BADFLAGS    = -1;   
    EAI_NONAME      = -2;   
    EAI_AGAIN       = -3;   
    EAI_FAIL        = -4;   
    EAI_NODATA      = -5;   
    EAI_FAMILY      = -6;   
    EAI_SOCKTYPE    = -7;   
    EAI_SERVICE     = -8;   
    EAI_ADDRFAMILY  = -9;   
    EAI_MEMORY      = -10;  
    EAI_SYSTEM      = -11;  
    EAI_OVERFLOW    = -12;  
    EAI_INPROGRESS  = -100; 
    EAI_CANCELED    = -101; 
    EAI_NOTCANCELED = -102; 
    EAI_ALLDONE     = -103; 
    EAI_INTR        = -104; 
    EAI_IDN_ENCODE  = -105; 

  {$ENDIF}

  NI_MAXHOST = 1025;
  NI_MAXSERV = 32;

  {$IF DEFINED(FREEBSD)}

    NI_NOFQDN       = $00000001;
    NI_NUMERICHOST  = $00000002;
    NI_NAMEREQD     = $00000004;
    NI_NUMERICSERV  = $00000008;
    NI_DGRAM        = $00000010;
    NI_NUMERICSCOPE = $00000020;

  {$ELSE}

    NI_NUMERICHOST = 1;
    NI_NUMERICSERV = 2;
    NI_NOFQDN      = 4;
    NI_NAMEREQD    = 8;
    NI_DGRAM       = 16;

  {$ENDIF}

const
   SCOPE_DELIMITER = '%';
   
type

  hostent = record
    h_name: PAnsiChar;      
    h_aliases: PPAnsiChar;  
    h_addrtype: cInt;   
    h_length: cInt;     
    h_addr_list: PPAnsiChar;
  end;

  THostEnt = hostent;
  PHostEnt = ^THostEnt;
  PPHostEnt = ^PHostEnt;

  netent = record
    n_name: PAnsiChar;      
    n_aliases: PPAnsiChar;  
    n_addrtype: cInt;   
    n_net: cuInt32;     
  end;
  TNetEnt = netent;
  PNetEnt = ^TNetEnt;
  PPNetEnt = ^PNetEnt;

  servent = record
    s_name: PAnsiChar;    
    s_aliases: PPAnsiChar;
    s_port: cInt;     
    s_proto: PAnsiChar;   
  end;
  TServEnt = servent;
  PServEnt = ^TServEnt;
  PPServEnt = ^PServEnt;

  protoent = record
    p_name: PAnsiChar; 
    p_aliases: PPAnsiChar;  
    p_proto: cInt;      
  end;
  TProtoEnt = protoent;
  PProtoEnt = ^TProtoEnt;
  PPProtoEnt = ^PProtoEnt;

{$if defined(LINUX) or defined(OPENBSD) or defined(DARWIN)}
{$define FIRST_ADDR_THEN_CANONNAME}
{$endif}
{$if defined(FREEBSD) or defined(NETBSD) or defined(DRAGONFLY) or defined(SOLARIS) or defined(ANDROID)}
{$define FIRST_CANONNAME_THEN_ADDR}
{$endif}
{$if not defined(FIRST_CANONNAME_THEN_ADDR) and not defined(FIRST_ADDR_THEN_CANONNAME)}
{$error fatal 'Please consult the netdb.h file for your system to determine the order of ai_addr and ai_canonname'}
{$endif} 

  PAddrInfo = ^addrinfo;
  addrinfo = record
    ai_flags: cInt;     
    ai_family: cInt;    
    ai_socktype: cInt;  
    ai_protocol: cInt;  
    ai_addrlen: TSocklen;  
{$ifdef FIRST_CANONNAME_THEN_ADDR}
    ai_canonname: PAnsiChar;   
    ai_addr: psockaddr;	   
{$endif}
{$ifdef FIRST_ADDR_THEN_CANONNAME}
    ai_addr: psockaddr;	   
    ai_canonname: PAnsiChar;   
{$endif}
    ai_next: PAddrInfo;	   
  end;
  TAddrInfo = addrinfo;
  PPAddrInfo = ^PAddrInfo;
   
procedure endhostent; cdecl; external LIB_C name 'endhostent';
procedure endnetent; cdecl; external LIB_C name 'endnetent';
procedure endnetgrent; cdecl; external LIB_C name 'endnetgrent';
procedure endprotoent; cdecl; external LIB_C name 'endprotoent';
procedure endservent; cdecl; external LIB_C name 'endservent';
procedure freehostent(ptr: PHostEnt); cdecl; external LIB_C name 'freehostent';
function  gethostbyaddr(addr: PAnsiChar; len, typ: cInt): PHostEnt; cdecl; external LIB_C name 'gethostbyaddr';

function  gethostbyname(name: PAnsiChar): PHostEnt; cdecl; external LIB_C name 'gethostbyname';

function  gethostbyname2(name: PAnsiChar; af: cInt): PHostEnt; cdecl; external LIB_C name 'gethostbyname2';

function  gethostent: PHostEnt; cdecl; external LIB_C name 'gethostent';

function getipnodebyaddr(src: Pointer; len: size_t; af: cInt; error_num: PcInt): PHostEnt; cdecl; external LIB_C name 'getipnodebyaddr';

function getipnodebyname(name: PAnsiChar; af, flags: cInt; error_num: PcInt): PHostEnt; cdecl; external LIB_C name 'getipnodebyname';

function getnetbyaddr(net: cint32; typ: cInt): PNetEnt; cdecl; external LIB_C name 'getnetbyaddr';

function getnetbyname(name: PAnsiChar): PNetEnt; cdecl; external LIB_C name 'getnetbyname';

function getnetent: PNetEnt; cdecl; external LIB_C name 'getnetent';

function getnetgrent(host, user, domain: PPAnsiChar): cInt; cdecl; external LIB_C name 'getnetgrent';

function getprotobyname(name: PAnsiChar): PProtoEnt; cdecl; external LIB_C name 'getprotobyname';

function getprotobynumber(proto: cInt): PProtoEnt; cdecl; external LIB_C name 'getprotobynumber';

function getprotoent: PProtoEnt; cdecl; external LIB_C name 'getprotoent';

function getservbyname(name, proto: PAnsiChar): PServEnt; cdecl; external LIB_C name 'getservbyname';

function getservbyport(port: cInt; proto: PAnsiChar): PServEnt; cdecl; external LIB_C name 'getservbyport';

function  getservent: PServEnt; cdecl; external LIB_C name 'getservent';
procedure herror(erstring: PAnsiChar); cdecl; external LIB_C name 'herror';
function  hstrerror(err: cInt): PAnsiChar; cdecl; external LIB_C name 'hstrerror';
function  innetgr(netgroup, host, user, domain: PAnsiChar): cInt; cdecl; external LIB_C name 'innetgr';
procedure sethostent(i: cInt); cdecl; external LIB_C name 'sethostent';

procedure setnetent(stayopen: cInt); cdecl; external LIB_C name 'setnetent';
procedure setprotoent(stayopen: cInt); cdecl; external LIB_C name 'setprotoent';
function  getaddrinfo(name, service: PAnsiChar; hints: PAddrInfo;
                      res: PPAddrInfo): cInt; cdecl; external LIB_C name 'getaddrinfo';
function  getnameinfo(sa: PSockAddr; salen: TSockLen; host: PAnsiChar; hostlen: TSize;
                      serv: PAnsiChar; servlen: TSize; flags: cInt): cInt; cdecl; external LIB_C name 'getnameinfo';
procedure freeaddrinfo(ai: PAddrInfo); cdecl; external LIB_C name 'freeaddrinfo';
function  gai_strerror(ecode: cInt): PAnsiChar; cdecl; external LIB_C name 'gai_strerror';
procedure setnetgrent(netgroup: PAnsiChar); cdecl; external LIB_C name 'setnetgrent';
procedure setservent(stayopen: cInt); cdecl; external LIB_C name 'setservent';

implementation

end.

