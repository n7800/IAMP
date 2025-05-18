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
unit users;

Interface
{$mode delphi}
uses UnixType,BaseUnix,pwd,grp, {$ifdef Linux} shadow,{$endif}SysUtils,Classes;

Type
  EUserLookupError = Class(Exception);
  EGroupLookupError = Class(Exception);
  EShadowLookupError = Class(Exception);
  TPasswordRecord = Tpasswd;
  PPasswordRecord = ^TPasswordRecord;

Function  getpwnam(Const UserName: String) : PPasswordRecord;
Procedure GetUserData(Const UserName : String; Var Data : TPasswordRecord); overload;
Procedure GetUserData(Uid : TUID; Var Data : TPasswordRecord); overload;
function  GetUserName(UID : TUID) : String;
function  GetUserId(Const UserName : String) : TUID;
function  GetUserGid(Const UserName : String) : TGID;
function  GetUserDir(Const UserName : String): String;
function  GetUserDescription(Const UserName : String): String;
Procedure GetUserList(List : Tstrings);overload;
Procedure GetUserList(List : TStrings; WithIDs : Boolean);overload;

Function  getgrnam(Const GroupName: String) : PGroup;
Procedure GetGroupData(Const GroupName : String; Var Data : TGroup); overload;
Procedure GetGroupData(Gid : TGID; Var Data : TGroup); overload;
function  GetGroupName(GID : TGID) : String;
function  GetGroupId(Const GroupName : String) : TGID;
Procedure GetGroupList(List : Tstrings);overload;
Procedure GetGroupList(List : TStrings; WithIDs : Boolean);overload;
Procedure GetGroupMembers(GID : TGID;List : TStrings);overload;
Procedure GetGroupMembers(Const GroupName : String;List : TStrings);overload;

{$ifdef Linux}
function getspnam(UserName : String): PPasswordFileEntry;
function sgetspent(Line : String): PPasswordFileEntry;

Procedure GetUserShadowData(Const UserName : String; Var Data : TPasswordFileEntry);overload;
Procedure GetUserShadowData(UID : TUID; Var Data : TPasswordFileEntry);overload;
{$endif}

Function GetUserGroup(Const UserName : String) : String;

Implementation

ResourceString

EnoSuchUserName = 'Unknown username: "%s"';
EnoSuchUserID = 'Unknown user ID: %d';
EnoSuchGroupName = 'Unknown groupname: "%s"';
EnoSuchGroupID = 'Unknown group ID: %d';
ENoShadowEntry = 'No shadow file entry for "%s"';
EShadowNotPermitted = 'Not enough permissions to access shadow password file';

Function getpwnam(Const UserName: String) : PPasswordRecord;

begin
  Result:=pwd.fpgetpwnam(Pchar(UserName));
end;

Procedure GetUserData(Const UserName : String; Var Data : TPasswordRecord);

Var P : PPasswordRecord;

begin
  P:=fpGetpwnam(pchar(UserName));
  If P<>Nil then
    Data:=P^
  else
    Raise EUserLookupError.CreateFmt(ENoSuchUserName,[UserName]);
end;

Procedure GetUserData(Uid : tuid; Var Data : TPasswordRecord);

Var P : PPasswordRecord;

begin
  P:=fpGetpwuid(Uid);
  If P<>Nil then
    Data:=P^
  else
    Raise EUserLookupError.CreateFmt(ENoSuchUserID,[Uid]);
end;

function GetUserName(UID : TUID) : String;

Var
  UserData : TPasswordRecord;

begin
  GetuserData(UID,UserData);
  Result:=UserData.pw_Name;
end;

function  GetUserId(Const UserName : String) : TUID;

Var
  UserData : TPasswordRecord;

begin
  GetUserData(UserName,UserData);
  Result:=UserData.pw_uid;
end;

function  GetUserGId(Const UserName : String) : TGID;

Var
  UserData : TPasswordRecord;

begin
  GetUserData(UserName,UserData);
  Result:=UserData.pw_gid;
end;

function GetUserDir(Const UserName : String): String;

Var
  UserData : TPasswordRecord;

begin
  GetUserData(UserName,UserData);
  Result:=UserData.pw_dir;
end;

function  GetUserDescription(Const UserName : String): String;

Var
  UserData : TPasswordRecord;

begin
  GetUserData(UserName,UserData);
  Result:=strpas(UserData.pw_gecos);
end;

Procedure GetUserList(List : Tstrings);

begin
  GetUserList(List,False);
end;

Procedure GetUserList(List : TStrings; WithIDs : Boolean);

Var
  P : PPasswordRecord;

begin
  List.Clear;
  fpsetpwent;
  try
    Repeat
      P:=fpgetpwent;
      If P<>Nil then
        begin
        If WithIDs then
          List.Add(Format('%d=%s',[P^.pw_uid,strpas(p^.pw_name)]))
        else
          List.Add(strpas(p^.pw_name));
        end;
    until (P=Nil);
  finally
    fpendpwent;
  end;
end;

Function  getgrnam(Const GroupName: String) : PGroup;

begin
  Result:=grp.fpgetgrnam(Pchar(GroupName));
end;

Procedure GetGroupData(Const GroupName : String; Var Data : TGroup); overload;

Var P : PGroup;

begin
  P:=fpGetgrnam(pchar(GroupName));
  If P<>Nil then
    Data:=P^
  else
    Raise EGroupLookupError.CreateFmt(ENoSuchGroupName,[GroupName]);
end;

Procedure GetGroupData(Gid : TGID; Var Data : TGroup); overload;

Var P : PGroup;

begin
  P:=fpGetgrgid(gid);
  If P<>Nil then
    Data:=P^
  else
    Raise EGroupLookupError.CreateFmt(ENoSuchGroupID,[Gid]);
end;

function GetGroupName(GID : TGID) : String;

Var
  G : TGroup;

begin
  GetGroupData(Gid,G);
  Result:=G.gr_name;
end;

function  GetGroupId(Const GroupName : String) : TGID;

Var
  G : TGroup;

begin
  GetGroupData(GroupName,G);
  Result:=G.gr_gid;
end;

Procedure GetGroupList(List : Tstrings);overload;

begin
  GetGroupList(List,False);
end;

Procedure GetGroupList(List : TStrings; WithIDs : Boolean);overload;

Var
  G : PGroup;

begin
  List.Clear;
  fpsetgrent;
  try
    Repeat
      G:=fpgetgrent;
      If G<>Nil then
        begin
        If WithIDs then
          List.Add(Format('%d=%s',[G^.gr_gid,strpas(G^.gr_name)]))
        else
          List.Add(strpas(G^.gr_name));
        end;
    until (G=Nil);
  finally
    fpendgrent;
  end;
end;

Function PCharListToStrings(P : PPChar; List : TStrings) : Integer;

begin
  List.Clear;
  While P^<>Nil do
    begin
    List.Add(StrPas(P^));
    P:=PPChar(PChar(P)+SizeOf(PChar));
    end;
  Result:=List.Count;
end;

Procedure GetGroupMembers(GID : TGID;List : TStrings);

Var
  G : TGroup;

begin
  GetGroupData(GID,G);
  PCharListToStrings(G.gr_mem,List);
end;

Procedure GetGroupMembers(Const GroupName : String;List : TStrings);

Var
  G : TGroup;

begin
  GetGroupData(GroupName,G);
  PCharListToStrings(g.gr_mem,List);
end;

{$ifdef linux}
function getspnam(UserName : String): PPasswordFileEntry;

begin
  result:=shadow.getspnam(Pchar(UserName));
end;

function sgetspent(Line : String): PPasswordFileEntry;

begin
  Result:=shadow.sgetspent(Pchar(Line));
end;

Procedure GetUserShadowData(Const UserName : String; Var Data : TPasswordFileEntry);

Var
  P : PPasswordFileEntry;

begin
  P:=getspnam(UserName);
  If P=Nil then
    If (fpGetUID<>0) and (fpGetEUID<>0) then
      Raise EShadowLookupError.Create(EShadowNotPermitted)
    else
      Raise EShadowLookupError.CreateFmt(ENoShadowEntry,[UserName])
  else
    Data:=P^;
end;

Procedure GetUserShadowData(UID : TUID; Var Data : TPasswordFileEntry);

begin
  GetUserShadowData(GetUserName(UID),Data);
end;
{$endif}

Function GetUserGroup(Const UserName : String) : String;

begin
  GetGroupName(GetUserGid(UserName));
end;

end.
