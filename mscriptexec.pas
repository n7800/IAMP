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
unit mScriptExec;

{$mode objfpc}{$H+}
{$IFDEF DARWIN}
{$modeswitch objectivec1}
{$ENDIF}

interface

uses
  {$IFNDEF NOGUI}
  uFolderBrowsePool, Forms, Graphics, uImageListPool, LCLType, CheckLst, Dialogs, ComCtrls, Controls,
  uRetryDownload, uRetryDownloadEx, uRetryExtract, uLanguage,
  {$ELSE}
  Crt,
  {$ENDIF}
  Classes, SysUtils, INIFiles, {$IFDEF BACKIDE}uGui, mBuildThread,{$ENDIF} mUtils, LazUTF8,
  mEval, SyncObjs, MD5, CRC32, FileInfo, {$IFNDEF WINDOWS}BaseUnix, Unix,{$ENDIF}
  uDlgAPI, LCLIntf, uDirectExtractMedia, registry, mAutomate, uRunApp, LazFileUtils,
  FileUtil, Masks, VerifySign, Process, Math, StrUtils, uSleep, RegExpr, t4a_VersionInfo,
  uRunAppAs, uRunScript,
  uGrabMedia, uExtractMedia, uCopyMedia, uDownload 
  {$IFDEF WINDOWS}
  , jwawinnt, Windows, ShlObj, ActiveX, daclutils, daclapi, uRegEx, ComObj, uSSD, SMScript
  {$ELSE}
  , users
  {$ENDIF}
  {$IFDEF LINUX}
  , picslib
  {$ENDIF}
  {$IFDEF DARWIN}
  , CocoaAll, MacOSAll
  {$ENDIF};

const
  mbYesAllNoAllCancel = [mbYes, mbYesToAll, mbNo, mbNoToAll, mbCancel];

  FOLDERID_Downloads: TGUID = '{374DE290-123F-4565-9164-39C4925E467B}';
  FOLDERID_PublicDownloads: TGUID = '{3D644C9B-1FB8-4F30-9B45-F670235F79C0}';

  weightCF = 1 *1024;
  weightDF = 100 *1024; 
  weightWR = 1 *512;
  weightCS = 10 *1024; 
  weightCMLF = 1024 *1024; 
  weightUR = 100 *1024; 
  weightINI = 10 *1024; 
  weightSE = 1 *1024;
  weightIA = 100 *1024; 
  weightFT = 10 *512; 
  weightDS = 10 *512; 
  weightCTS = 2048 *1024; 
  weightCCS = 20 *512; 
  weightCSFA = 50 *512; 
  weightODBC = 20 *512; 
  weightDSN = 10 *512; 
  weightCRL = 1 *1024; 

  SE_CREATE_TOKEN_NAME = 'SeCreateTokenPrivilege';
  SE_ASSIGNPRIMARYTOKEN_NAME = 'SeAssignPrimaryTokenPrivilege';
  SE_LOCK_MEMORY_NAME = 'SeLockMemoryPrivilege';
  SE_INCREASE_QUOTA_NAME = 'SeIncreaseQuotaPrivilege';
  SE_UNSOLICITED_INPUT_NAME = 'SeUnsolicitedInputPrivilege';
  SE_MACHINE_ACCOUNT_NAME = 'SeMachineAccountPrivilege';
  SE_TCB_NAME = 'SeTcbPrivilege';
  SE_SECURITY_NAME = 'SeSecurityPrivilege';
  SE_TAKE_OWNERSHIP_NAME = 'SeTakeOwnershipPrivilege';
  SE_LOAD_DRIVER_NAME = 'SeLoadDriverPrivilege';
  SE_SYSTEM_PROFILE_NAME = 'SeSystemProfilePrivilege';
  SE_SYSTEMTIME_NAME = 'SeSystemtimePrivilege';
  SE_PROF_SINGLE_PROCESS_NAME = 'SeProfileSingleProcessPrivilege';
  SE_INC_BASE_PRIORITY_NAME = 'SeIncreaseBasePriorityPrivilege';
  SE_CREATE_PAGEFILE_NAME = 'SeCreatePagefilePrivilege';
  SE_CREATE_PERMANENT_NAME = 'SeCreatePermanentPrivilege';
  SE_BACKUP_NAME = 'SeBackupPrivilege';
  SE_RESTORE_NAME = 'SeRestorePrivilege';
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
  SE_DEBUG_NAME = 'SeDebugPrivilege';
  SE_AUDIT_NAME = 'SeAuditPrivilege';
  SE_SYSTEM_ENVIRONMENT_NAME = 'SeSystemEnvironmentPrivilege';
  SE_CHANGE_NOTIFY_NAME = 'SeChangeNotifyPrivilege';
  SE_REMOTE_SHUTDOWN_NAME = 'SeRemoteShutdownPrivilege';
  SE_UNDOCK_NAME = 'SeUndockPrivilege';
  SE_SYNC_AGENT_NAME = 'SeSyncAgentPrivilege';
  SE_ENABLE_DELEGATION_NAME = 'SeEnableDelegationPrivilege';
  SE_MANAGE_VOLUME_NAME = 'SeManageVolumePrivilege';

type

  TFindAllFilesThread = class(TThread)
  private
    thfProgress: Integer;
    thfProgressText: String;
  protected
    procedure Execute; override;
    procedure SetFinished;
  end;

  TRunScriptCallback = function(Line: Integer): Boolean;

  TNativeThread = class(TThread)
  public
    procedure BackupProgress;
    procedure RestoreProgress;
    function IncrementProgress(Increment: Int64; Caption: String): Boolean;
    function ShowFolderDialog(Text, Default: String; var Path: String): Boolean;
    function ShowErrorDialog(Text: String; var Retry: Boolean; SafetyNet: Integer): Boolean;
    function ShowOverwriteDialog(SourceFile, TargetFile: String; var Overwrite: Boolean): Boolean;
    procedure BroadcastEnvironment;
    function NativeGrabSource: Boolean;
  private
    {$IFDEF DARWIN}
    MSIFile: String;
    {$ENDIF}
    TypesI, CompactDataStack: String;
    Derefs: TList;
    References: TStrings;
    i: Integer;
    errTitle, errText: String;
    errToAll, errRetry, errCancel: Boolean;
    ovrTitle, ovrText: String;
    ovrToAll, ovrOverwrite, ovrCancel: Boolean;
    folTitle, folDefault, folPath: String;
    folResult: Boolean;
    inDelayedInstall: Boolean;
    inInstallFilesSection: Boolean;
    NativeGrabSourceExResult: Boolean;
    
  protected
    procedure Execute; override;
    procedure SetFinished;
    procedure ShowErrorDialogActual;
    procedure ShowFolderDialogActual;
    procedure ShowOverwriteDialogActual;
    function LoggedFileCopyFile(Source, Target: String; FailIfExists: Boolean): Boolean;
    function ProcessSingleType(PauseProgress: Boolean = false): Boolean;
    function ConvenientCreateFolder(Path: String): Boolean;
    function ConvenientWriteRegistry(Root: HKEY; Subkey, Leaf, Data: String; SuspendProgress: Boolean = True; Permanent: Boolean = false): Boolean;
    function ConvenientWriteRegistryInt(Root: HKEY; Subkey, Leaf: String; Data: Integer; SuspendProgress: Boolean = True; Permanent: Boolean = false): Boolean;
    function ConvenientWriteINI(Path, Section, Key, Data: String; Operation: Integer): Boolean;
  end;

function ReadOffset(Derefs: TList; Guid: String;
  Offset: Integer): String;

function GrabMedia(Media: String; URL: TStrings; Local, Enc: String; var Server, Port, User, Pass: String;
  var Resume: Boolean; OverrideEngine, EngineParam: String): Boolean;
function GrabMediaEx(Media: String; URL: TStrings; Local, Enc: String; var Server, Port, User, Pass: String;
  var Resume: Boolean; OverrideEngine, EngineParam: String): Boolean;
{$IFDEF DARWIN}
function GetDMGRoots: TStringList;
{$ENDIF}
function GetAllEnvStrings: String;

procedure VersionIfy(Path, Version: String; BugPath: String = ''); 
procedure NoGuify(Path: String; BuildMode: Integer = -1); 

function RunScriptEx(Types, References, Comments, Webs: TStrings; Derefs: TList;
  Callback: TRunScriptCallback; MSIFile: String; DLL: Boolean = false): Boolean;
function RunScript(Types, References, Comments, Webs: TStrings; Derefs: TList;
  Callback: TRunScriptCallback; MSIFile: String; DLL: Boolean = false): Boolean;

{$IFNDEF INTEROP}
procedure CompileMSI(MSIFile: String; Build: TBuildThread; Web: Boolean;
  Derefs: TList; Types, References, Comments: TStrings; Conditionals: String;
  BuildMode: Integer; Language, PrjName: String;
  OptimizeFileCompt, OptimizeRegCompt, StableStatementIDs, BlendedOptimize: Boolean;
  Softwrap: String; var pPin: Boolean; aSign: Boolean; BuildingThread: TBuildThread = nil); 

procedure CompileMSIEx(MSIFile: String; Build: TBuildThread; Web: Boolean; Derefs: TList; BuildMode: Integer;
  OptimizeFileCompt, OptimizeRegCompt, StableStatementIDs, BlendedOptimize: Boolean; Conditionals: String;
  Softwrap: String; var pPin: Boolean; BuildingThread: TBuildThread = nil); 

function RenderInstallFilesMSI(Index, SequenceNr: Integer; Source, Target: String;
  Build: TBuildThread; WebStore, Header: String;
  var SizeCount: Int64; var ComptBuf: String; WebDirect: Boolean; BuildMode: Integer;
  ReuseComponent: Boolean; Conditionals: String; Skipper: Boolean): Boolean;
{$ENDIF}

{$IFDEF DARWIN}
function VerifyAdminLogin: Boolean;
{$ENDIF}

function StrToBoolWithPipeDelim(Value: String): Boolean;
function GetCompilerDirectBool(Variable: String): Boolean;
function GetCompilerDirectInt(Variable: String): Integer;
function GetCompilerDirect(Variable: String): String;

function CompileScriptEx(Types, References, Comments: TStrings; Derefs: TList;
  var Error: String): Integer;
function CompileScript(Types, References, Comments: TStrings; Derefs: TList;
  var Error: String): Integer;
function SetMakeContext(Derefs: TList; Types, References, Comments: TStrings; var Conditionals: String;
  var OutDerefs: TList; var Error: String; BuildMode: Integer; DefLang, ProjName: String;
  aSign: Boolean): Integer;
procedure SetEditContext(Derefs: TList; Types: TStrings);
function GetCommandHeaderEx(Types, References: TStrings; Derefs: TList; Line: Integer): String;
function GetCommandHeader(Types, References: TStrings; Derefs: TList; Line: Integer; Turbo, Blend: Boolean): String;
procedure CacheSetMSIPropertyEx(Param1, Param2: String);
function GetDialogResourcePath(ScriptName: String): String;

function SubstituteCompilerVariables(Text, Variables: String): String;
procedure SaveCompilerVariables(Variables: String);
function SubstituteVariables(const Literal: String): String;
procedure SubstituteCompilerVariablesEx(var a: array of Char; Variables: String); overload;
procedure SubstituteCompilerVariablesEx(var Text: String; Variables: String); overload;

function ObsWeblock(Pass: String): String;
function DeObsWeblock(Pass: String): String;
function GetWeblockPwd(Weblock: String): String;

function GetVariable(const Variable: String): String;
procedure ClearVariables;
procedure SureSetVariable(const Variable: String; const Value: String; const Referrer: String);
function IsVarDefined(Variable: String): Boolean;
procedure SetVariable(Variable: String; const Value: String; const Referrer: String);
procedure SureDeleteVariable(const Variable: String);
function IsProperVariable(Variable: String; AcceptLiteral: Boolean): Boolean;
function GetStringVar(Variable: String): String;

function IsCompilerVarDefined(Variable, Conditionals: String): Boolean;
function CompilerGetVariable(Variable, Conditionals: String): String;
function CompilerGetStringVar(Variable: String): String;
function RuntimeSubstituteCompilerVariables(Literal: String): String;

procedure WidenColonDelimParam(Param: String; var Wide1, Wide2: String; Delim: String = '|');
function IsValidSaveNameEx(FileName: String): Boolean;

function GetUnitName(Pull: String; NoExtract: Boolean = false): String;
function GetLineNumber(Pull: String): Integer;

procedure SetSelectionEx(Index: Integer; Selected: Boolean);
function GetAnyParentComponentBars(Path: String): Boolean;
function GetComponentBars(Path: String): Boolean;
function GetComponentHint(Path: String): String;
function GetComponentHide(Path: String): Boolean;
function GetAnyParentComponentHide(Path: String): Boolean;
{$IFNDEF NOGUI}
procedure SetComponentsFlat(From: TCheckListBox);
procedure GetComponentsFlat(Into: TCheckListBox);
procedure GetComponentsTree(Into: TTreeView);
{$ENDIF}
function GetComponentRequiredSpaceEx(Path: String): String;
function GetComponentRequiredSpace(Path: String): Int64;
function IntSizeToStrSize(Size: Int64): String;
function GetTotalRequiredSpace: Int64;
function GetTotalRequiredSpaceEx: String;
function GetComponentDelete(Path: String): Boolean;
function GetTotalSpace: Int64;
function GetTotalSpaceEx: String;
function ResolveVariable(Variable: String): String;
function ResolveVariableEx(Variable: String): String;
function GetDifference: Int64;
function GetDifferenceEx: String;
function GetSelection(Path: String): Boolean;
procedure SetSelection(Path: String; Selected: Boolean);

procedure Enter64BitRegistry;
procedure Leave64BitRegistry;
procedure Enter64BitFileSystem(IgnoreAlreadyForNewThread: Boolean = false);
procedure Leave64BitFileSystem(IgnoreAlreadyForNewThread: Boolean = false);

function GetComponentIndex(Path: String): Integer;
function IsComponentDefined(Path: String): Boolean;
procedure ClearComponents;
procedure AddComponent(Path, Hint: String; Selected: Boolean);
procedure LoadComponents(Stream: String; Script: Boolean; LoadOldDataCall: Boolean = false);
procedure SaveComponents(Stream: String; Script: Boolean; ReallySaveCompts: Boolean = True);

function SniffSafeTargetDir: String; 

function SniffSafeUserPath(AllUsers: Boolean): String;

function RecommendAllUserState: Boolean; 

function IsUserAdmin: Boolean;
function IsUserParticular(Kind: Integer): Boolean;
function IsUserElevated: Boolean;

procedure WriteToLog(Text: String);

function BrandEx: String;

function GetBundleNameEz(Path, FailSafe: String): String;

function GetAllUserInstallState(MSIFile: String): Boolean;

function SmartAscertainDATFile(TestPath: String): String;

function SniffSafeUserPathEx(GUID: String): String;

{$IFDEF WINDOWS}
function SafeToDeleteKey(RootKey: HKEY; Name: String; Computer: String = ''): Boolean;
{$ENDIF}
function SafeToDeleteFolder(Folder: String): Boolean;
procedure BackupNativeLogs;
procedure RestoreNativeLogs;
function NativeLogIsPresentEx(GUID: String): Boolean;
function NativeQueryProductState(GUID: String): Integer;
function NativeMsiQueryProductState(GUID: String): Integer;
function NativeLogIsPresent: Boolean;
function NativeLogTestPath(Path: String; PermitBrandNew: Boolean = false): Boolean;
function NativeLogGuessPath: String;
function NativeAppendToLog(Path: String): String;
function NativeApplyLogEvents(AllowCancel: Boolean = True): Integer;
function GetFileVersion(FileName: String; var MajorHi, MajorLo, MinorHi, MinorLo,
  Major, Minor: LongWord): Boolean;
function IsSourceNewer(Source, Target: String; var SourceVersion, TargetVersion, SourceDate, TargetDate: String): Boolean;
procedure NativeOverwrite(var Older, Skip, Overwrite, Prompt: Boolean);
procedure NativeError(var Abort, Retry, Ignore, Prompt: Boolean);

function ThreadFreeNativeGrabSource: Boolean;
function NativeEngineDelay: Boolean;
procedure CheckDoNativeRollback;
function NativeEngineMode: Boolean;
function NativeRollback: Boolean;
function SpoolNativeAction(TypesI: String; Derefs: TList; References: TStrings; i: Integer; NativeEngineDelay: Boolean = false
  {$IFDEF DARWIN};MSIFile: String = ''{$ENDIF}): Boolean;
function GetDataStack(TypesI: String; Derefs: TList; References: TStrings; i: Integer): String;
procedure NativeLogAddEntry(Kind, Details: String);
procedure NativeLogDeleteLastEntry;
function FileInUse(FileName: String; TryRename: Boolean; var Freed: Boolean; var hSec: THandle): Boolean;
procedure RecordNativeSelfReg(RegSvr, Server: String);
{$IFDEF WINDOWS}
function IsBinaryX64(const FileName: String): Boolean;
function MyRegisterEXE(LibFile: String; RegLib: Boolean): Boolean;

function ClearFileSecurity(const fileName: UnicodeString; OnlyClear: Boolean = false) : THandle;
function ClearRegSecurity(key: HKEY; const name: UnicodeString; Computer: String = '') : THandle;
function RestoreSecurity(ss: THandle; const AlternateFileName: String = ''; const PreserveBuffer: Boolean = false) : boolean;
{$ENDIF}

function ProcessMinExtract(DisplayMessage, RollbackNative: Boolean): Boolean;

procedure CustomCoolWait(Thread: TThread);

var
  
  thfProgress: Integer;
  thfProgressText: String;
  
  thfPath: String;
  thfRecurse, thfDir, thfFollow: Boolean;
  
  thfFinished: Boolean;
  tfaf: TFindAllFilesThread;
  thfList: TStringList;
  
  SingleDanger: Boolean = false;

  BannedMediaList: TStringList; 
  Grab_Media_Rebuf_State: String;

  OwnerMustBeRestorable : boolean = false;
  Am64bitOS: boolean = false;
  Access64bitRegistry : boolean = false;

  MSIFileForNative: String;
  NativeTotal: Int64;

  SpawnFileCopyEx: String;
  
  nbClasses, nbDetails, nbWeight, nbBitness: TStringList;
  nbPath: String;
  
  NativeLogElements, NativeLogData, NativeLogWeight, NativeLogBitness: TStringList;
  NativeShellChangeNotify: Boolean = false;
  
  thNativeRebootOp: Boolean = false;
  thSpoolerFinished: Boolean;
  thNativei1: Integer;
  thNatives1: String;
  MinExtract, MinExtracted: Boolean;
  thSpoolerPrimaryWindowHandle: DWORD;
  thSpoolerThread: TNativeThread = nil;

  NativeDelayStack: TStringList;
  NativeDelayProgress: Int64 = 0;

  dataStack: TStringList;
  courtesyDataStack: TStringList;
  cbTotal: Int64 = 0;
  cbCurrent: Int64 = 0;
  
  SFXFileName: String;
  CommandLine: String;
  PrimaryWindowHandle: THandle;
  lMap, lLang, lIndex, lOrg: THashedStringList;
  CompilerVariableDirect: THashedStringList; 
  PullMapDirect, IncludeDepthDirect: THashedStringList;
  BackCounter: Integer = 0;
  BackTypes, BackComments, BackReferences: TStringList;
  Labels, Lines: TStringList;
  Variables: TStringList;
  VarCache: THashedStringList; 
  aVars: SyncObjs.TCriticalSection;
  PersistVariables, OverrideVars, OverrideVarsEx: TStringList;
  SilentInstall: Boolean;
  ParameterCache: TStringList;
  PGUIDEX, ProductGUID, RevisionGUID, RevisionGUIDforPatchEx, CachedTitle, CachedTargetDir,
  CachedTempDir, CachedSupportDir, CachedDataDir, SuperCachedDataDir, SuperCachedDataDirBackup, CachedDataDirEx,
  CachedPlugRootDir, CachedMSPDir, CachedTitleOrgLang: String;
  InstalledSize: Int64;
  Components, Selections, ComponentHints, ComponentSpaces,
  ComponentDeletes, ComponentHides, ComponentBars: TStringList;
  UninstalledFromMaintenanceState, AnApplyInstallWasCalled: Boolean;
  x64Mode: String;
  LastLoopStack: TStringList;
  ForEachStack: TStringList;
  LoggedInstall: String;
  LastOverriddenCache: String;
  RootFolder: String;
  carPublisher, carContact, carHelp, carUpdates, carComments: String;
  MediaLayout: Integer;
  CachedMultiLang: Boolean;
  CachedDefaultLanguage, ActivatedLanguage, LastActivatedLanguage: String;
  ProjectStructVersion: String;
  AllowMissHeader: Boolean;
  RandSeed1, RandSeed2, RandSeed: Integer;
  CommandHeaders: THashedStringList; 
  TitleEy: String = '';
  MonitorGlobalProgress: Boolean = false;
  NoBrand: Boolean = false;
  idStack: TStringList;
  WeblockPasswords: TStringList;
  NewSourceListSource: TStringList;
  NativeFileSourceStack: TStringList;
  NativeFileSourceStackHashed: THashedStringList;
  AlreadyDis: Boolean = false;
  WOW_PTR: Pointer = nil;
  {$IFNDEF INTEROP}
  ShowingDesign: String;
  {$ENDIF}
  {$IFDEF DARWIN}
  TouchList: TStringList;
  {$ENDIF}

  FirstLogWrite: Boolean = True;
  
  CachedDefaultLanguageEx: String; 
  CachedLanguageCompilerVariableValueEx: String; 
  
  bitchBackupCustomTimeOut: Integer = 10;

implementation

{$IFNDEF INTEROP}
function ReverseInvokePathEy(Path: String): String;

var
  s: String;
  d: DWORD;

function GetHashCode(Str: PChar): Integer;
var
  Off, Len, Skip, I: Integer;
begin
  Result := 0;
  Off := 1;
  Len := StrLen(Str);
  if Len < 16 then
    for I := (Len - 1) downto 0 do
    begin
      Result := (Result * 37) + Ord(Str[Off]);
      Inc(Off);
    end
  else
  begin
    
    Skip := Len div 8;
    I := Len - 1;
    while I >= 0 do
    begin
      Result := (Result * 39) + Ord(Str[Off]);
      Dec(I, Skip);
      Inc(Off, Skip);
    end;
  end;
end;

begin
  
  s := MD5Print(MD5String(AnsiLowerCase(DeAssertDir(ExtractFilePath(Path)))));
  CalcStringCRC32(s, d);
  s := IntToHex(d, 0);
  Result := s + PathDelim + ExtractFileName(Path);
end;
{$ENDIF}

function SanitizePostLoadNativeLog(Log1, Log2, Log3, Log4: TStrings): Boolean;
var
  i: Integer;
begin
  Result := false;
  i := Log1.Count;
  if Log2.Count <> i then
  begin
    Result := True;
    if Log2.Count < i then
      i := Log2.Count;
  end;
  if Log3.Count <> i then
  begin
    Result := True;
    if Log3.Count < i then
      i := Log3.Count;
  end;
  if Log4.Count <> i then
  begin
    Result := True;
    if Log4.Count < i then
      i := Log4.Count;
  end;
  if Result then
  begin
    while Log1.Count > i do
      Log1.Delete(Log1.Count -1);
    while Log2.Count > i do
      Log2.Delete(Log2.Count -1);
    while Log3.Count > i do
      Log3.Delete(Log3.Count -1);
    while Log4.Count > i do
      Log4.Delete(Log4.Count -1);
  end;
end;

procedure VerifySanitySavedNativeLog(Log1, Log2, Log3, Log4: String; SecondAttempt: Boolean = false);
var
  l1, l2, l3, l4: TStringList;
begin
  l1 := TStringList.Create;
  l2 := TStringList.Create;
  l3 := TStringList.Create;
  l4 := TStringList.Create;
  if MyFileExists(Log1) then
    l1.LoadFromFile(Log1);
  if MyFileExists(Log2) then
    l2.LoadFromFile(Log2);
  if MyFileExists(Log3) then
    l3.LoadFromFile(Log3);
  if MyFileExists(Log4) then
    l4.LoadFromFile(Log4);
  if SanitizePostLoadNativeLog(l1, l2, l3, l4) then
  begin
    l1.SaveToFile(Log1);
    l2.SaveToFile(Log2);
    l3.SaveToFile(Log3);
    l4.SaveToFile(Log4);
    if not SecondAttempt then
      VerifySanitySavedNativeLog(Log1, Log2, Log3, Log4, True);
  end;
  l1.Free;
  l2.Free;
  l3.Free;
  l4.Free;
end;

procedure NativeLogAddEntry(Kind, Details: String);
var
  s, Wide1, Wide2: String;
  b: Boolean;
  i64: Int64;
  l, sl: TStringList;
begin
  b := True; 

  {$IFDEF USEVARMANAGER}
  if AnsiCompareText('FALSE', VarManager['NATIVE_LOGGING']) = 0 then Exit; 
  {$ELSE}
  if AnsiCompareText('FALSE', GETVARIABLE('NATIVE_LOGGING')) = 0 then Exit; 
  {$ENDIF}

  l := TStringList.Create;
  i64 := 0; 
  if Kind = 'Write Registry' then
  begin
    NativeLogElements.Add('Delete Registry');
    sl := TStringList.Create;
    sl.CommaText := Details;
    
    l.Add(sl[0]); 
    WidenColonDelimParam(sl[0], Wide1, Wide2);
    if not ((Wide1 = '2') or (Wide1 = '3')) then
      Wide2 := ''; 
    l.Add(sl[1]); 
    
    l.Add(sl[2]); 
    i64 := i64 +weightWR;
     
    s := DeAssertDir(sl[1]);
    {$IFDEF WINDOWS}
    while not RegKeyExistsEz(HKEY(StrToInt(Wide1)), s, Wide2) do
    begin
      if DeAssertDir(ExtractFilePath(s)) <> s then 
      begin
        l.Add(s); 
        s := DeAssertDir(ExtractFilePath(s));
        i64 := i64 +weightWR;
      end
      else
        Break;
    end;
    {$ELSE}
    l.Add(s); 
    s := DeAssertDir(ExtractFilePath(s));
    i64 := i64 +weightWR;
    {$ENDIF}
    sl.Free;
  end
  else
  if Kind = 'Create File' then
  begin
    NativeLogElements.Add('Delete File');
    l.Add(Details);
    i64 := i64 +weightCF; 
  end
  else
  if Kind = 'Create Link' then
  begin
    NativeLogElements.Add('Delete Link');
    l.Add(Details);
    i64 := i64 +weightCRL; 
  end
  else
  if Kind = 'Register File' then
  begin
    NativeLogElements.Add('Unregister File');
    l.Add(Details);
    i64 := i64 + weightUR;
  end
  else
  if Kind = 'Share File' then
  begin
    NativeLogElements.Add('Unshare File');
    l.Add(Details);
    i64 := i64 + weightWR;
  end
  else
  if Kind = 'Share Self Registering File' then
  begin
    NativeLogElements.Add('Unshare Self Registering File');
    l.Add(Details);
    i64 := i64 +weightWR +weightUR;
  end
  else
  if Kind = 'Install Assembly' then
  begin
    NativeLogElements.Add('Remove Assembly');
    l.Add(Details);
    i64 := i64 +weightIA; 
  end
  else
  if Kind = 'Create Service' then
  begin
    NativeLogElements.Add('Delete Service');
    l.Add(Details);
    i64 := i64 +weightDS; 
  end
  else
  if Kind = 'Install ODBC Driver' then
  begin
    NativeLogElements.Add('Delete ODBC Driver');
    l.Add(Details);
    i64 := i64 +weightODBC; 
  end
  else
  if Kind = 'Set Environment' then
  begin
    NativeLogElements.Add('Delete Environment');
    l.Add(Details);
    i64 := i64 + weightSE;
  end
  else
  if Kind = 'Edit INI File' then
  begin
    NativeLogElements.Add('Remove INI Entry');
    l.Add(Details); 
    i64 := i64 +weightINI;
  end
  else
  if Kind = 'Create ODBC DSN' then
  begin
    NativeLogElements.Add('Remove ODBC DSN');
    l.Add(Details); 
    i64 := i64 +weightDSN;
  end
  else
  if Kind = 'Create Folder' then
  begin
    NativeLogElements.Add('Delete Folder');
    s := DeAssertDir(Details);
    while not DirectoryExists(s) do
    begin
      if DeAssertDir(ExtractFilePath(s)) <> s then 
      begin
        l.Add(s);
        s := DeAssertDir(ExtractFilePath(s));
        i64 := i64 +weightCF;
      end
      else
        Break;
    end;
    if l.Count = 0 then
    begin
      b := false; 
      NativeLogElements.Delete(NativeLogElements.Count -1);
    end;
  end;
  if b then
  begin
    NativeLogData.Add(l.CommaText);
    NativeLogWeight.Add(IntToStr(i64));
    NativeLogBitness.Add(x64Mode);
  end;
  l.Free;
end;

procedure NativeLogDeleteLastEntry;
begin
  if AnsiCompareText('FALSE', GETVARIABLE('NATIVE_LOGGING')) = 0 then Exit; 
  NativeLogElements.Delete(NativeLogElements.Count -1);
  NativeLogData.Delete(NativeLogData.Count -1);
  NativeLogWeight.Delete(NativeLogWeight.Count -1);
  NativeLogBitness.Delete(NativeLogBitness.Count -1);
end;

function GetInstallerCacheFolder: String;
begin
  Result := SniffSafeUserPath(StrToBool(GetVariable('ALLUSERS'))) + RevisionGUID + PathDelim;
  ForceDirectories(Result);
end;

function GetDummyMoveFileTemporaryName: String;
var
  t: TextFile;
  i: Integer;
  s: String;
begin
  i := 0;
  s := GetInstallerCacheFolder;
  while MyFileExists(s + 'move.' + IntToStr(i)) do
    i := i +1;
  Result := s + 'move.' + IntToStr(i);
  AssignFile(t, Result,cp_utf8);
  ReWrite(t);
  CloseFile(t);
end;

function FileInUse(FileName: String; TryRename: Boolean; var Freed: Boolean;
  var hSec: THandle): Boolean;
{$IFDEF WINDOWS}
var
  i: Integer;
  b, bX: Boolean;
  hFileRes: HFILE;
begin
  
  Result := false;
  Freed := false;
  if not MyFileExists(FileName) then Exit;
  hSec := ClearFileSecurity(FileName);
  hFileRes := CreateFile(PChar(FileName), GENERIC_READ or GENERIC_WRITE, 0, nil,
    OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, 0);
  Result := (hFileRes = INVALID_HANDLE_VALUE);
  if not Result then CloseHandle(hFileRes);
  if not Result then 
  begin
    
    b := SetFileAttributes(PChar(FileName), FILE_ATTRIBUTE_NORMAL);
    bX := DeleteFile(PChar(FileName));
    if MyFileExists(FileName) then
    begin
      Result := True; 
      RestoreSecurity(hSec, '', True);
    end;
  end;
  
  if TryRename and Result then
  begin
    i := 0;
    while MyFileExists(FileName + '.' + IntToStr(i)) do
      i := i +1;
    if RenameFile(FileName, FileName + '.' + IntToStr(i)) then
    begin
      Freed := True;
      MarkFileForDeletion(FileName + '.' + IntToStr(i));
      Result := false; 
    end;
  end;
{$ELSE}
begin
  
  Result := false; 
{$ENDIF}
end;

procedure RecordNativeSelfReg(RegSvr, Server: String);
var
  r: TRegistry;
begin
  try
    r := TRegistry.Create;
    if StrToBool(GetVariable('ALLUSERS')) = false then 
      r.RootKey := HKEY_CURRENT_USER
    else
      r.RootKey := HKEY_LOCAL_MACHINE;
    r.Access := KEY_WRITE or REG_ACCESS_CONST;
    r.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce\', True); 
    if AnsiCompareText('.exe', ExtractFileExt(Server)) = 0 then
      r.WriteString(Copy(MyCreateGUID, 2, 8), '"' + Server + '" /regserver')
    else
      r.WriteString(Copy(MyCreateGUID, 2, 8), RegSvr + ' "' + Server + '" /s');
    r.CloseKey;
    r.Free;
  except
  end;
end;

{$IFDEF WINDOWS}
function IsBinaryX64(const FileName: String): Boolean;
const
  IMAGE_FILE_MACHINE_I386     = $014c; 
  IMAGE_FILE_MACHINE_IA64     = $0200; 
  IMAGE_FILE_MACHINE_AMD64    = $8664; 
  IMAGE_FILE_MACHINE_ARM64    = $AA64; 
  
  IMAGE_FILE_MACHINE_R3000_BE = $160;  
  IMAGE_FILE_MACHINE_R3000    = $162;  
  IMAGE_FILE_MACHINE_R4000    = $166;  
  IMAGE_FILE_MACHINE_R10000   = $168;  
  IMAGE_FILE_MACHINE_ALPHA    = $184;  
  IMAGE_FILE_MACHINE_POWERPC  = $1F0;  
var
  Header: TImageDosHeader;
  ImageNtHeaders: TImageNtHeaders;
  Strm: TFileStream;
begin
  try
    Strm := TFileStream.Create(FileName, fmOpenRead or fmShareDenyNone);
    Strm.ReadBuffer(Header, SizeOf(Header));
    if (Header.e_magic <> IMAGE_DOS_SIGNATURE) or
       (Header._lfanew = 0) then
      raise Exception.Create('Invalid executable');
    Strm.Position := Header._lfanew;

    Strm.ReadBuffer(ImageNtHeaders, SizeOf(ImageNtHeaders));
    if ImageNtHeaders.Signature <> IMAGE_NT_SIGNATURE then
      raise Exception.Create('Invalid executable');
    Strm.Free;
    Result := ImageNtHeaders.FileHeader.Machine <> IMAGE_FILE_MACHINE_I386;
  except
    Result := false; 
  end;
end;

function MyRegisterEXE(LibFile: String; RegLib: Boolean): Boolean;
var
  SI: TStartupInfo;
  PI: TProcessInformation;
  RegisterExitCode: BOOL;
  s: String;
  us: String;
begin
  Result := false;
  if RegLib then s := ' /regserver' 
    else s := ' /unregserver'; 
  FillChar(SI, SizeOf(SI), 0);
  SI.cb := SizeOf(SI);
  UniqueString(LibFile);
  us := LibFile + s;
  UniqueString(us);
  RegisterExitCode := Win32Check(CreateProcess(
  PChar(LibFile), PChar(us),
    nil, nil, True, 0, nil, nil, SI, PI));
  CloseHandle(PI.hThread);
  CloseHandle(PI.hProcess);
  Result := RegisterExitCode;
end;
{$ENDIF}

function GetBundleNameEz(Path, FailSafe: String): String;
var
  i: Integer;
  s, sX: String;
  l: TStringList;
begin
  Result := '';
  l := TStringList.Create;
  MyFindAllDirs(l, Path, '', false);
  for i := 1 to l.Count do
  begin
    s := l[i -1];
    sX := AssertDir(s) + 'Contents/MacOS/';
    if AnsiCompareText(ExtractFileExt(s), '.app') = 0 then
    begin
      
      if (not MyFileExists(sX + 'miafstub')) and
        (not MyFileExists(sX + 'target.object')) then
        
      begin
        Result := ExtractFileNameOnly(s);
        Exit;
      end;
    end;
  end;
  l.Free;
  if Result = '' then
  
    Result := FailSafe; 
    
end;

function GetAllUserInstallState(MSIFile: String): Boolean;
var
  s: String;
begin
  s := SniffSafeUserPath(false);
  
  if MediaLayout = 3 then
    s := s + RevisionGUIDforPatchEx + PathDelim
  else
    s := s + RevisionGUID + PathDelim;
  {$IFDEF DARWIN}
  s := s + GetBundleNameEz(s, ExtractFileNameOnly(MSIFile)) + '.app/Contents/' + Ventura +  '/';
  
  {$ENDIF}
  s := s + ExtractFileNameOnly(MSIFile) + '.dat'; 
  if MyFileExists(s) then
  begin
    Result := false;
    if SmartAscertainDATFile(ExtractFilePath(MSIFile)) <> '' then
      Result := True; 
  end
  else
    Result := True;
  
end;

function SmartAscertainDATFile(TestPath: String): String;
var
  i: Integer;
  l: TStringList;
begin
  Result := '';
  TestPath := AssertDir(TestPath);
  if DirectoryExists(TestPath) then
    if MyFileExists(TestPath + 'miax.lib') then
    begin
      {$IFDEF INTEROP}
      l := FindAllFilesEx(TestPath + '*.dat', false);
      {$ELSE}
      l := FindAllFilesEx(TestPath + '*.dat', false);
      {$ENDIF}
      
      for i := 1 to l.Count do
        if MyFileExists(TestPath + {$IFDEF DARWIN}'miaxstub'{$ELSE}ExtractFileNameOnly(l[i -1]){$IFDEF WINDOWS}+ '.exe'{$ENDIF}{$ENDIF}) then
          if MyFileExists(TestPath + {$IFDEF DARWIN}'miaxstub'{$ELSE}ExtractFileNameOnly(l[i -1]){$ENDIF} + '.res') then
            if MyFileExists(TestPath + ExtractFileNameOnly(l[i -1]) + '.par') then
            begin
              Result := l[i -1];
              Break;
            end;
      l.Free;
    end;
end;

function SniffSafeUserPathEx(GUID: String): String;
var
  
  t: TextFile;
  sX: String;
  i: Integer;
  l: TStringList;
  b, bX: Boolean;
begin
  
  Result := '';
  try
    
    bX := false; 
    sX := IncludeTrailingPathDelimiter(MyGetAppConfigDir(bX)) + 'MimarSinan' + PathDelim + 'InstallAware' + PathDelim + 'Ident.Cache' + PathDelim + GUID;
    if MyFileExists(sX) then
    begin
      FileMode := 0;
      AssignFile(t, sX);
      Reset(t);
      ReadLn(t, Result);
      b := True;
      CloseFile(t);
    end
    else
      b := false;
    
    if not DirectoryExists(Result) then
      b := false;
    if not b then
    begin
      
      bX := True;
      sX := IncludeTrailingPathDelimiter(MyGetAppConfigDir(bX)) + 'MimarSinan' + PathDelim + 'InstallAware' + PathDelim + 'Ident.Cache' + PathDelim + GUID;
      if MyFileExists(sX) then
      begin
        FileMode := 0;
        AssignFile(t, sX);
        Reset(t);
        ReadLn(t, Result);
        CloseFile(t);
      end
    end;
    
  except
    Result := '';
  end;
  if Result <> '' then
  begin
    {$IFDEF DARWIN}
    
    b := false;
    l := FindAllDirs(Result, false);
    for i := 1 to l.Count do
      if MyFileExists(AssertDir(l[i -1]) + 'Contents/' + Ventura + '/miax.lib') then
      begin
        b := True;
        Result := AssertDir(l[i -1]) + 'Contents/' + Ventura + '/';
        Break;
      end;
    l.Free;
    if not b then Result := ''; 
    {$ENDIF}
    Result := Result + GUID; 
  end;
end;

{$IFDEF WINDOWS}
function SafeToDeleteKey(RootKey: HKEY; Name: String; Computer: String
  ): Boolean;
var
  Keys, ValueList: String;
begin
  RegEnumKeys(RootKey, Name, Keys, Computer);
  RegEnumValues(RootKey, Name, ValueList, Computer);
  Result := (Keys = '') and (ValueList = '');
  if Result then
    Result := not RegDefaultValueExists(RootKey, Name, Computer);
end;
{$ENDIF}

function SafeToDeleteFolder(Folder: String): Boolean;
var
  i: Integer;
  b: Boolean;
  sr: TSearchRec;
begin
  Result := false;
  
  i := FindFirstUTF8(IncludeTrailingPathDelimiter(Folder) + '*', $5FF, sr);
  b := i = 0;
  if not b then Exit;
  
  Result := True;
  repeat
    if (sr.Name <> '.') and (sr.Name <> '..') then
      Result := false;
    i := FindNextUTF8(sr);
  until (i <> 0) or (not Result);
  if b then FindCloseUTF8(sr);
end;

procedure BackupNativeLogs;
begin
  nbPath := NativeLogGuessPath;
  nbClasses := TStringList.Create;
  nbDetails := TStringList.Create;
  nbWeight := TStringList.Create;
  nbBitness := TStringList.Create;
  nbClasses.LoadFromFile(nbPath + '.native.elements.log', TEncoding.UTF8);
  nbDetails.LoadFromFile(nbPath + '.native.data.log', TEncoding.UTF8);
  nbWeight.LoadFromFile(nbPath + '.native.weight.log', TEncoding.UTF8);
  nbBitness.LoadFromFile(nbPath + '.native.bitness.log', TEncoding.UTF8);
  SanitizePostLoadNativeLog(nbClasses, nbDetails, nbWeight, nbBitness);
end;

procedure RestoreNativeLogs;
begin
  ForceDirectories(AssertDir(ExtractFilePath(nbPath)));
  nbClasses.SaveToFile(nbPath + '.native.elements.log', TEncoding.UTF8);
  nbDetails.SaveToFile(nbPath + '.native.data.log', TEncoding.UTF8);
  nbWeight.SaveToFile(nbPath + '.native.weight.log', TEncoding.UTF8);
  nbBitness.SaveToFile(nbPath + '.native.bitness.log', TEncoding.UTF8);
  VerifySanitySavedNativeLog(nbPath + '.native.elements.log',
    nbPath + '.native.data.log',
    nbPath + '.native.weight.log',
    nbPath + '.native.bitness.log');
  nbClasses.Free;
  nbDetails.Free;
  nbWeight.Free;
  nbBitness.Free;
end;

function NativeLogIsPresentEx(GUID: String): Boolean;
begin
  Result := false;
  if MyFileExists(SniffSafeUserPathEx(GUID) + '.native.elements.log') then
    if MyFileExists(SniffSafeUserPathEx(GUID) + '.native.data.log') then
      if MyFileExists(SniffSafeUserPathEx(GUID) + '.native.weight.log') then
        if MyFileExists(SniffSafeUserPathEx(GUID) + '.native.bitness.log') then
          Result := True;
end;

function NativeQueryProductState(GUID: String): Integer;
begin
  Result := INSTALLSTATE_ABSENT;
  if NativeLogIsPresentEx(GUID) then
    Result := INSTALLSTATE_DEFAULT;
end;

function NativeMsiQueryProductState(GUID: String): Integer;
begin
  Result := INSTALLSTATE_ABSENT;
  
  if NativeLogIsPresent then
    Result := INSTALLSTATE_DEFAULT;
end;

function NativeLogIsPresent: Boolean;
var
  
  s, sX: String;
  b, bX: Boolean;
  t: TextFile;
  
begin
  Result := false;
  if MyFileExists(NativeLogGuessPath + '.native.elements.log') then
    if MyFileExists(NativeLogGuessPath + '.native.data.log') then
      if MyFileExists(NativeLogGuessPath + '.native.weight.log') then
        if MyFileExists(NativeLogGuessPath + '.native.bitness.log') then
        try
          if GetAllUserInstallState(MSIFileForNative) then
          begin
            
            bX := True;
            
          end
          else
          begin
            
            bX := false;
            
          end;
          
          sX := IncludeTrailingPathDelimiter(MyGetAppConfigDir(bX)) + 'MimarSinan' + PathDelim + 'InstallAware' + PathDelim + 'Ident.Cache' + PathDelim + ProductGUID;
          if MyFileExists(sX) then
          begin
            FileMode := 0;
            AssignFile(t, sX);
            Reset(t);
            ReadLn(t, s);
            b := True;
            CloseFile(t);
          end
          else
            b := false;
          
          if (not DirectoryExists(s)) or (not NativeLogTestPath(s + {$IFDEF DARWIN}
              GetBundleNameEz(s, ExtractFileNameOnly(MSIFileForNative)) + '.app/Contents/' + Ventura +  '/' +{$ENDIF}ProductGUID))
            or (not MyFileExists(s + {$IFDEF DARWIN}
              GetBundleNameEz(s, ExtractFileNameOnly(MSIFileForNative)) + '.app/Contents/' + Ventura +  '/' +{$ENDIF}'miax.lib')) then
            b := false;
          
          if not b then
          begin
            
            sX := IncludeTrailingPathDelimiter(MyGetAppConfigDir(not bX)) + 'MimarSinan' + PathDelim + 'InstallAware' + PathDelim + 'Ident.Cache' + PathDelim + ProductGUID;
            if MyFileExists(sX) then
            begin
              FileMode := 0;
              AssignFile(t, sX);
              Reset(t);
              ReadLn(t, s);
              b := True;
              CloseFile(t);
            end
            
          end;
          Result := ExtractFileName(DeAssertDir(s)) = RevisionGUID;
          
        except
          Result := false;
        end;
end;

function NativeLogTestPath(Path: String; PermitBrandNew: Boolean): Boolean;
var
  t: TextFile;
begin
  Result := false;
  if ExtractFilePath(Path) = '' then Exit; 
  if MyFileExists(Path + '.native.elements.log') then
    if MyFileExists(Path + '.native.data.log') then
      if MyFileExists(Path + '.native.weight.log') then
        if MyFileExists(Path + '.native.bitness.log') then
          Result := True;
  if not Result then 
    if PermitBrandNew then
      if not MyFileExists(Path + '.native.elements.log') then
        if not MyFileExists(Path + '.native.data.log') then
          if not MyFileExists(Path + '.native.weight.log') then
            if not MyFileExists(Path + '.native.bitness.log') then
            begin
              Result := True;
              try
                AssignFile(t, Path + '.native.elements.log',cp_utf8);
                ReWrite(t);
                CloseFile(t);
                AssignFile(t, Path + '.native.data.log',cp_utf8);
                ReWrite(t);
                CloseFile(t);
                AssignFile(t, Path + '.native.weight.log',cp_utf8);
                ReWrite(t);
                CloseFile(t);
                AssignFile(t, Path + '.native.bitness.log',cp_utf8);
                ReWrite(t);
                CloseFile(t);
              except
                Result := false;
              end;
            end;
end;

function NativeLogGuessPath: String;
var
  s: String;
begin
  
  {$IFDEF USEVARMANAGER}
  s := VarManager['NATIVE_LOGGING'];
  {$ELSE}
  s := GETVARIABLE('NATIVE_LOGGING');
  {$ENDIF}
  if s <> '' then
    if AnsiCompareText(s, 'FALSE') <> 0 then
      if DirectoryExists(ExtractFilePath(s)) then
        if NativeLogTestPath(s) then
        begin
          Result := s; 
          Exit;
        end;
  
  Result := SniffSafeUserPath(GetAllUserInstallState(MSIFileForNative));
  Result := Result + RevisionGUID + PathDelim;
  {$IFDEF DARWIN}
  Result := IncludeTrailingPathDelimiter(Result) + GetBundleNameEz(Result,
    ExtractFileNameOnly(MSIFileForNative)) + '.app/Contents/' + Ventura +  '/';
  
  {$ENDIF}
  Result := Result +  ProductGUID; 
  
end;

procedure RunAsRoot(Command, SudoPassword: String);
var
  Proc: TProcess;
  CharBuffer: array [0..511] of char;
  ReadCount: integer;
  ExitCode: integer;
begin
  ExitCode := -1; 
  Proc := TProcess.Create(nil); 
  try
    Proc.Options := [poUsePipes, poStderrToOutPut]; 
    Proc.CommandLine := 'sudo -S ' + Command; 
    
    Proc.Execute; 

    SudoPassword := SudoPassword + LineEnding;
    Proc.Input.Write(SudoPassword[1], Length(SudoPassword));
    SudoPassword := '%*'; 
    SudoPassword := ''; 

    while Proc.Running or (Proc.Output.NumBytesAvailable > 0)  do
    begin
      
      while Proc.Output.NumBytesAvailable > 0 do
      begin
        ReadCount := Min(512, Proc.Output.NumBytesAvailable); 
        Proc.Output.Read(CharBuffer, ReadCount);
        
      end;
      
    end;
    ExitCode := Proc.ExitStatus;
  finally
    Proc.Free;
  end;
end;

function NativeAppendToLog(Path: String): String;
var
  t: TextFile;
  i: Integer;
  s: String;
begin
  Result := '';
  if not DirectoryExists(AssertDir(ExtractFilePath(Path))) then
  begin
    
    if NativeLogElements.Count = 0 then Exit;
    Result := AssertDir(ExtractFilePath(Path));
    ForceDirectories(Result);
    
  end;
  AssignFile(t, Path + '.native.elements.log',cp_utf8);
  if MyFileExists(Path + '.native.elements.log') then
    Append(t)
  else
    ReWrite(t);
  for i := 1 to NativeLogElements.Count do
    WriteLn(t, NativeLogElements[i -1]);
  CloseFile(t);
  NativeLogElements.Clear;
  AssignFile(t, Path + '.native.data.log',cp_utf8);
  if MyFileExists(Path + '.native.data.log') then
    Append(t)
  else
    ReWrite(t);
  for i := 1 to NativeLogData.Count do
    WriteLn(t, NativeLogData[i -1]);
  CloseFile(t);
  NativeLogData.Clear;
  AssignFile(t, Path + '.native.weight.log',cp_utf8);
  if MyFileExists(Path + '.native.weight.log') then
    Append(t)
  else
    ReWrite(t);
  for i := 1 to NativeLogWeight.Count do
    WriteLn(t, NativeLogWeight[i -1]);
  CloseFile(t);
  NativeLogWeight.Clear;
  AssignFile(t, Path + '.native.bitness.log',cp_utf8);
  if MyFileExists(Path + '.native.bitness.log') then
    Append(t)
  else
    ReWrite(t);
  for i := 1 to NativeLogBitness.Count do
    WriteLn(t, NativeLogBitness[i -1]);
  CloseFile(t);
  NativeLogBitness.Clear;
  VerifySanitySavedNativeLog(Path + '.native.elements.log',
    Path + '.native.data.log',
    Path + '.native.weight.log',
    Path + '.native.bitness.log');
end;

function NativeApplyLogEvents(AllowCancel: Boolean): Integer;
var
  tif: TINIFile;
  i, j, i1, i2, i3, i4, i2_len, i3_len, i_risk, i5: Integer;
  Classes, Details, Weight, Bitness: TStringList;
  l: TStringList;
  i64, i64X: Int64;
  x64ModeY, x64ModeX, i64S, s, s1, s2, s3, s4, s5: String;
  opOK, opCancel, opRetry: Boolean;
  eBuf, c2: Cardinal;
  p:PChar;
  dw: DWORD;
  b, bX: Boolean;
  h, hX: THandle;
  hSec: THandle;
  Wide1, Wide2: String;
begin
  
  Result := 0; 
  
  s := NativeAppendToLog(NativeLogGuessPath); 
  
  Classes := TStringList.Create;
  Details := TStringList.Create;
  Weight := TStringList.Create;
  Bitness := TStringList.Create;
  Classes.LoadFromFile(NativeLogGuessPath + '.native.elements.log', TEncoding.UTF8);
  Details.LoadFromFile(NativeLogGuessPath + '.native.data.log', TEncoding.UTF8);
  Weight.LoadFromFile(NativeLogGuessPath + '.native.weight.log', TEncoding.UTF8);
  Bitness.LoadFromFile(NativeLogGuessPath + '.native.bitness.log', TEncoding.UTF8);
  SanitizePostLoadNativeLog(Classes, Details, Weight, Bitness);
  for i := 1 to Weight.Count do
    i64 := i64 + StrToInt(Weight[i -1]);
  
  l := TStringList.Create;
  
  try
    x64ModeX := x64Mode;
    i64X := NativeTotal;
    {$IFDEF USEVARMANAGER}
    i64S := VarManager['NATIVE_PROGRESS'];
    VarManager['NATIVE_PROGRESS'] := '0';
    {$ELSE}
    i64S := GETVARIABLE('NATIVE_PROGRESS');
    SETVARIABLE('NATIVE_PROGRESS','0','');
    {$ENDIF}

    NativeTotal := i64;
    opCancel := false;
    hSec := 0;
    for i := Classes.Count downto 1 do
    try
      WriteToLog('        <' + Classes[i -1] + '>');
      x64Mode := Bitness[i -1];
      Enter64BitFileSystem(True);
      Enter64BitRegistry;
      l.Clear;
      l.CommaText := Details[i -1];
      i_risk := 0;
      WriteToLog('        < ' + l.CommaText + ' >');
      {$IFDEF WINDOWS}
      if Classes[i -1] = 'Delete Registry' then
      begin
        while (l.Count = 1) do
        begin
          l.CommaText := l[0];
          i_risk := i_risk +1;
          if i_risk = 314 then Continue;
        end;
        WidenColonDelimParam(l[0], Wide1, Wide2);
        l[0] := Wide1; 
        case StrToInt(l[0]) of
          HKEY_CLASSES_ROOT: begin s1 := 'HKEY_CLASSES_ROOT'; i1 := HKEY_CLASSES_ROOT; end;
          HKEY_CURRENT_USER: begin s1 := 'HKEY_CURRENT_USER'; i1 := HKEY_CURRENT_USER; end;
          HKEY_LOCAL_MACHINE: begin s1 := 'HKEY_LOCAL_MACHINE'; i1 := HKEY_LOCAL_MACHINE; end;
          HKEY_USERS: begin s1 := 'HKEY_USERS'; i1 := HKEY_USERS; end;
        end;
        
        if not ((s1 = 'HKEY_LOCAL_MACHINE') or (s1 = 'HKEY_USERS')) then
          Wide2 := '';
        if Wide2 <> '' then
          if AnsiPos('\\', Wide2) <> 1 then
            Wide2 := '\\' + Wide2;
        
        hSec := ClearRegSecurity(i1, l[1], Wide2);
        repeat
          opOK := RegDelValueEz(HKEY(i1), l[1], l[2], i2, Wide2);
          if not opOK then
          begin
            if not RegValueExistsEz(HKEY(i1), l[1], l[2], Wide2) then 
              opOK := True
            else
              opCancel := thSpoolerThread.ShowErrorDialog(SysErrorMessage(i2) + MyLineEnding + MyLineEnding + AssertDir(s1) + AssertDir(l[1]) + l[2], opRetry, i2);
          end;
        until (opOK or opCancel) or (not opRetry);
        if hSec <> 0 then
          RestoreSecurity(hSec);
        if opCancel then Exit;
          if opOK then
            WriteToLog('          < ' + AssertDir(s1) + AssertDir(l[1]) + l[2] + ' >');
        for j := 4 to l.Count do 
        begin
          if not SafeToDeleteKey(i1, l[j -1], Wide2) then 
            Break;
          hSec := ClearRegSecurity(i1, l[j -1], Wide2);
          repeat
            opOK := RegDelKeyEz(HKEY(i1), l[j -1], i2, Wide2);
            if not opOK then
            begin
              if not RegKeyExistsEz(HKEY(i1), l[j -1], Wide2) then 
                opOK := True
              else
                opCancel := thSpoolerThread.ShowErrorDialog(SysErrorMessage(i2) + MyLineEnding + MyLineEnding + AssertDir(s1) + l[j -1], opRetry, i2);
            end;
          until (opOK or opCancel) or (not opRetry);
          if not opOK then
            if hSec <> 0 then
              RestoreSecurity(hSec);
          if opCancel then Exit;
          if opOK then
            WriteToLog('          < ' + AssertDir(s1) + l[j -1] + ' >');
        end;
        if not thSpoolerThread.IncrementProgress(StrToInt(Weight[i -1]), AssertDir(s1) + AssertDir(l[1]) + l[2]) then
          if AllowCancel then Exit; 
      end
      else
      {$ENDIF}
      if Classes[i -1] = 'Delete File' then
      begin
        {$IFDEF WINDOWS}
        hSec := ClearFileSecurity(l[0]);
        {$ENDIF}
        repeat
          opOK := SetFileAttributes(PChar(l[0]), FILE_ATTRIBUTE_NORMAL);
          eBuf := {$IFDEF WINDOWS}GetLastError{$ELSE}fpgeterrno{$ENDIF};
          if opOK then
          begin
            opOK := DeleteFile(PChar(l[0]));
            eBuf := {$IFDEF WINDOWS}GetLastError{$ELSE}fpgeterrno{$ENDIF};
          end;
          if not opOK then
          begin
            if not MyFileExists(l[0], false) then 
              opOK := True
            else
            begin
              b := false;
              {$IFDEF WINDOWS}
              RestoreSecurity(hSec);
              if FileInUse(l[0], True, b, hSec) then 
              begin
                
                MoveFileOnReboot(l[0], '');
                opOK := True;
                
                thNativeRebootOp := True;
              end
              else
              {$ENDIF}
              begin
                if b then
                  opOK := True
                else
                begin
                  
                  opCancel := thSpoolerThread.ShowErrorDialog(SysErrorMessage(eBuf) + MyLineEnding + MyLineEnding + l[0], opRetry, eBuf);
                end;
              end;
            end;
          end;
        until (opOK or opCancel) or (not opRetry);
        {$IFDEF WINDOWS}
        if not opOK then
          if hSec <> 0 then
            RestoreSecurity(hSec);
        {$ENDIF}
        if opCancel then Exit;
        if opOK then
          WriteToLog('          < ' + l[0] + ' >');
        if not thSpoolerThread.IncrementProgress(StrToInt(Weight[i -1]),
        {$ifdef SIMDILIKANSI}
           PAnsiChar(Ansistring(l[0])))
        {$else}
           PChar(l[0]))
        {$endif}
        then
          if AllowCancel then Exit; 
      end
      else
      if Classes[i -1] = 'Delete Link' then
      begin
        {$IFNDEF WINDOWS}
        repeat
          opOK := fpUnlink(PChar(l[0])) = 0;
          eBuf := FPGetErrNo;
          if opOK then
          begin
            DeleteFile(PChar(l[0]));
            RemoveDirectory(l[0]);
          end;
          if not opOK then
          begin
            if not MyFileExists(l[0], false) then 
              opOK := True
            else
            begin
              b := false;
              if b then
                opOK := True
              else
                opCancel := thSpoolerThread.ShowErrorDialog(SysErrorMessage(eBuf) + MyLineEnding + MyLineEnding + l[0], opRetry, eBuf);
            end;
          end;
        until (opOK or opCancel) or (not opRetry);
        if opCancel then Exit;
        if opOK then
          WriteToLog('          < ' + l[0] + ' >');
        if not thSpoolerThread.IncrementProgress(StrToInt(Weight[i -1]), PChar(l[0]))
        then
          if AllowCancel then Exit; 
        {$ENDIF}
      end
      
      else
      if Classes[i -1] = 'Remove INI Entry' then
      begin
        while (l.Count = 1) do
        begin
          l.CommaText := l[0];
          i_risk := i_risk +1;
          if i_risk = 314 then Continue;
        end;
        s1 := l[0]; 
        s2 := l[1]; 
        s3 := l[2]; 
        s4 := l[3]; 
        if s4 <> '' then
        begin 
          s5 := '';
          
          tif := TINIFile.Create(s1);
          s5 := tif.ReadString(s2, s3, '');
          tif.Free;
          if s5 = '' then
            Continue 
          else
          begin
           
           i1 := ytm_SmartPos(s4, s5);
           
            if i1 = 0 then Continue; 
            
            i2 := ytm_SmartPos(s4 + ', ', s5);
            
            i2_len := Length(s4 + ', ');
            if i2 = 0 then
            begin
              
              i2 := ytm_SmartPos(s4 + ',', s5);
              
              i2_len := Length(s4 + ',');
            end;
            
            i3 := ytm_SmartPos(', ' + s4, s5);
            
            i3_len := Length(', ' + s4);
            if i3 = 0 then
            begin
              
              i3 := ytm_SmartPos(',' + s4, s5);
              
              i3_len := Length(',' + s4);
            end;
            if (i2 = 0) and (i3 = 0) then 
            begin
              if AnsiCompareText(Trim(s5), s4) <> 0 then Continue 
              else
                s4 := ''; 
            end
            else
            begin
              s4 := s5;
              if i2 <> 0 then
                System.Delete(s4, i2, i2_len)
              else
                System.Delete(s4, i3, i3_len);
            end;
          end;
        end;
        repeat
          try
            tif := TINIFile.Create(s1);
            tif.WriteString(s2, s3, s4);
            tif.Free;
            opOK := True;
          except
            opOK := false;
          end;
          
          {$IFDEF WINDOWS}
          eBuf := GetLastError;
          {$ELSE}
          eBuf := fpGetErrNo;
          {$ENDIF}
          if not opOK then
            opCancel := thSpoolerThread.ShowErrorDialog(SysErrorMessage(eBuf) + MyLineEnding + MyLineEnding + s1 + ': [' + s2 + ']' + ' ' + s3 + '=' + s4, opRetry, eBuf);
        until (opOK or opCancel) or (not opRetry);
        if opCancel then Exit;
        if opOK then
          WriteToLog('        < ' + s1 + ': [' + s2 + ']' + ' ' + s3 + '=' + s4 + ' >');
        if not thSpoolerThread.IncrementProgress(StrToInt(Weight[i -1]),
        {$ifdef SIMDILIKANSI}
           PAnsiChar(AnsiString(s1 + ': [' + s2 + ']' + ' ' + s3 + '=' + s4)))
        {$else}
        PChar(s1 + ': [' + s2 + ']' + ' ' + s3 + '=' + s4))
        {$endif}
        then
          if AllowCancel then Exit; 
      end
      else
      if Classes[i -1] = 'Delete Folder' then
      begin
        for j := 1 to l.Count do 
        begin
          if not SafeToDeleteFolder(l[j -1]) then 
            Break;
          repeat
            opOK := RemoveDirectory(PChar(l[j -1]));
            {$IFDEF WINDOWS}
            eBuf := GetLastError;
            {$ENDIF}
            if not opOK then
            begin
              if not DirectoryExists(l[j -1], false) then 
                opOK := True
              else
                opCancel := thSpoolerThread.ShowErrorDialog(SysErrorMessage(eBuf) + MyLineEnding + MyLineEnding + l[j -1], opRetry, eBuf);
            end;
          until (opOK or opCancel) or (not opRetry);
          if opCancel then Exit;
          if opOK then
            WriteToLog('          < ' + l[j -1] + ' >');
        end;
        if not thSpoolerThread.IncrementProgress(StrToInt(Weight[i -1]),
        {$ifdef SIMDILIKANSI}
        PAnsiChar(Ansistring(l[0])))
        {$else}
        PChar(l[0]))
        {$endif}
        then
          if AllowCancel then Exit; 
      end;
    finally
      WriteToLog('        </' + Classes[i -1] + '>');
      Leave64BitRegistry;
      Leave64BitFileSystem(True);
    end;
    Result := 1;
  finally

    {$IFDEF USEVARMANAGER}
    VarManager['NATIVE_PROGRESS'] := i64S;
    {$ELSE}
    SETVARIABLE('NATIVE_PROGRESS',i64S,'') ;
    {$ENDIF}

    x64Mode := x64ModeX;
    NativeTotal := i64X;
    Classes.Free;
    Details.Free;
    Weight.Free;
    l.Free;
    if s <> '' then
    begin
      
      DeleteFile(PChar(NativeLogGuessPath + '.native.elements.log'));
      DeleteFile(PChar(NativeLogGuessPath + '.native.data.log'));
      DeleteFile(PChar(NativeLogGuessPath + '.native.weight.log'));
      DeleteFile(PChar(NativeLogGuessPath + '.native.bitness.log'));
      RemoveDirectory(PChar(s));
    end;
  end;
end;

function GetFileVersion(FileName: String; var MajorHi, MajorLo, MinorHi,
  MinorLo, Major, Minor: LongWord): Boolean;
var
  
  fi: TFileVersionInfo;
  pi: TProgramVersion;
begin
  Result := false;
  MajorHi := 0;
  MajorLo := 0;
  MinorHi := 0;
  MinorLo := 0;
  
  fi := TFileVersionInfo.Create(nil);
  try
    
    fi.FileName := FileName;
    fi.ReadFileInfo;
    if TryStrToProgramVersion(fi.VersionStrings.Values['FileVersion'], pi) then
    begin
      MajorHi := pi.Major;
      MajorLo := pi.Minor;
      MinorHi := pi.Revision;
      MinorLo := pi.Build;
    end;
    Result := True; 
  except
    MajorHi := 0;
    MajorLo := 0;
    MinorHi := 0;
    MinorLo := 0;
  end;
  Major := (MajorHi shl 32) or MajorLo;
  Minor := (MinorHi shl 32) or MinorLo;
  
  fi.Free;
end;

function GetFileTimeDisplayString(FileName: String): String;
var
  dt: TDateTime;
  fs: TFormatSettings;
begin
  try
    FileAge(FileName, dt);
    
    Result := FormatDateTime('c', dt, fs);
  except
    Result := ntv9;
  end;
end;

function IsSourceNewer(Source, Target: String; var SourceVersion,
  TargetVersion, SourceDate, TargetDate: String): Boolean;
var
  b: Boolean;
  MajorHi1, MajorLo1, MinorHi1, MinorLo1, Major1, Minor1: Cardinal;
  MajorHi2, MajorLo2, MinorHi2, MinorLo2, Major2, Minor2: Cardinal;
begin
  
  GetFileVersion(Source, MajorHi1, MajorLo1, MinorHi1, MinorLo1, Major1, Minor1);
  GetFileVersion(Target, MajorHi2, MajorLo2, MinorHi2, MinorLo2, Major2, Minor2);
  
  SourceVersion := IntToStr(MajorHi1) + '.' + IntToStr(MajorLo1) + '.' + IntToStr(MinorHi1) + '.' + IntToStr(MinorLo1);
  TargetVersion := IntToStr(MajorHi2) + '.' + IntToStr(MajorLo2) + '.' + IntToStr(MinorHi2) + '.' + IntToStr(MinorLo2);
  if SourceVersion = '0.0.0.0' then
    SourceVersion := ntv10;
  if TargetVersion = '0.0.0.0' then
    TargetVersion := ntv10;
  SourceDate := GetFileTimeDisplayString(Source);
  TargetDate := GetFileTimeDisplayString(Target);
  
  if (SourceVersion <> ntv10) and (TargetVersion <> ntv10) then 
  begin
    Result := True;
    if MajorHi1 < MajorHi2 then Result := false
      else if MajorHi1 = MajorHi2 then
      begin
        if MajorLo1 < MajorLo2 then Result := false
          else if MajorLo1 = MajorLo2 then
          begin
            if MinorHi1 < MinorHi2 then Result := false
              else if MinorHi1 = MinorHi2 then
                if MinorLo1 <= MinorLo2 then Result := false;
          end;
      end;
    Exit;
  end;
  if ((SourceVersion = ntv10) and (TargetVersion = ntv10)) 
    or (TargetVersion = ntv10) then 
  begin
    Result := True;
    if FileAge(Source) <= FileAge(Target) then Result := false;
    Exit;
  end;
  Result := false; 
end;

procedure NativeOverwrite(var Older, Skip, Overwrite, Prompt: Boolean);
begin
  Older := false;
  Skip := false;
  Overwrite := false;
  Prompt := false;
  {$IFDEF USEVARMANAGER}
  if  AnsiCompareText(VarManager['NATIVE_OVERWRITE_OLDER'], 'TRUE') = 0 then
    Older := True;
  if AnsiCompareText(VarManager['NATIVE_OVERWRITE'], 'ALWAYS') = 0 then
    Overwrite := True
  else
  if AnsiCompareText(VarManager['NATIVE_OVERWRITE'], 'NEVER') = 0 then
    Skip := True
  else
    Prompt := True;
  {$ELSE}
  if  AnsiCompareText(GETVARIABLE('NATIVE_OVERWRITE_OLDER'), 'TRUE') = 0 then
    Older := True;
  if AnsiCompareText(GETVARIABLE('NATIVE_OVERWRITE'), 'ALWAYS') = 0 then
    Overwrite := True
  else
  if AnsiCompareText(GETVARIABLE('NATIVE_OVERWRITE'), 'NEVER') = 0 then
    Skip := True
  else
    Prompt := True;
  {$ENDIF}
end;

procedure NativeError(var Abort, Retry, Ignore, Prompt: Boolean);
begin
  Abort := false;
  Retry := false;
  Ignore := false;
  Prompt := false;
  {$IFDEF USEVARMANAGER}
  if AnsiCompareText(VarManager['NATIVE_ERROR'], 'ABORT') = 0 then
    Abort := True
  else
  if AnsiCompareText(VarManager['NATIVE_ERROR'], 'RETRY') = 0 then
    Retry := True
  else
  if AnsiCompareText(VarManager['NATIVE_ERROR'], 'IGNORE') = 0 then
    Ignore := True
  else
    Prompt := True;
  {$ELSE}
  if AnsiCompareText(GETVARIABLE('NATIVE_ERROR'), 'ABORT') = 0  THEN
    Abort := True
  else
  if AnsiCompareText(GETVARIABLE('NATIVE_ERROR'), 'RETRY') = 0 THEN
    Retry := True
  else
  if AnsiCompareText(GETVARIABLE('NATIVE_ERROR'), 'IGNORE') = 0 THEN
    Ignore := True
  else
    Prompt := True;
  {$ENDIF}
end;

function ThreadFreeNativeGrabSource: Boolean;
var
  b, bX, bY: Boolean; 
  s1: String;
begin
  Result := True; 
  
  if not MyFileExists(CachedDataDir + PGUIDEX) then
  begin
    bY := false;
    
    if MinExtract then
      
      if not ProcessMinExtract(True, True) then
      begin
        SetVariable('LASTERROR', msg17, 'Native Engine Source Acquisition'); 
        Result := false;
        Exit;
        
      end
      else
        bY := True;
        
    if StrToBool(GetVariable('MAINTENANCE')) then 
      if not (MediaLayout = 2) then 
        if not bY then 
        begin
          Result := false;
          b := false;
          bX := false;
          repeat
            if SilentInstall then b := True
              else
              begin
                
                b := not
                  MyDialogsSelectDirectory(msg16, '', s1, True); 
                
              end;
            bX := MyFileExists(AssertDir(s1) + PGUIDEX) or MyFileExists(AssertDir(s1) + 'data' + PathDelim + PGUIDEX);
          until b or bX;
          if bX then
          begin
            if MyFileExists(AssertDir(s1) + PGUIDEX) then CachedDataDir := AssertDir(s1)
              else CachedDataDir := AssertDir(s1) + 'data' + PathDelim;
            CachedPlugRootDir := CachedDataDir;
            Result := True;
          end
          else
          if b then
          begin
            SetVariable('LASTERROR', msg17, 'Native Engine Source Acquisition'); 
            Result := false;
          end;
        end;
  end;
end;

function NativeEngineDelay: Boolean;
begin
  
  RESULT:=False;
  {$IFDEF USEVARMANAGER}
  Result := AnsiCompareText(VarManager['DELAYUNTIL_APPLYCHANGES'], 'TRUE') = 0;
  {$ELSE}
  Result := AnsiCompareText(GETVARIABLE('DELAYUNTIL_APPLYCHANGES'), 'TRUE') = 0;
  {$ENDIF}
end;

function NativeEngineMode: Boolean;
begin
  
  RESULT:=True;
  {$IFDEF USEVARMANAGER}
  Result := AnsiCompareText(VarManager['NATIVE_ENGINE'], 'TRUE') = 0;
  {$ELSE}
  Result := AnsiCompareText(GETVARIABLE('NATIVE_ENGINE'), 'TRUE') = 0;
  {$ENDIF}
  
end;

function NativeRollback: Boolean;

begin
  
  Result := True;
  {$IFDEF USEVARMANAGER}
  Result := (AnsiCompareText(VarManager['NATIVE_ROLLBACK'], 'FALSE') <> 0)
    and (not AnApplyInstallWasCalled); 
  
  {$ELSE}
  Result := (AnsiCompareText(GETVARIABLE('NATIVE_ROLLBACK'), 'FALSE') <> 0)
    and (not AnApplyInstallWasCalled); 
  {$ENDIF}
  
end;

function SpoolNativeAction(TypesI: String; Derefs: TList; References: TStrings; i: Integer; NativeEngineDelay: Boolean = false
  {$IFDEF DARWIN};MSIFile: String = ''{$ENDIF}): Boolean;
var
  Wide1, Wide2: String; 
  RestoreCancellation: Boolean;
  l, lX: TStringList;
  iX: Integer;
begin
  RestoreCancellation := false;
  
  Result := True;
  thNatives1 := '';
  if NativeEngineDelay then
  begin
    NativeDelayStack.Add(TypesI);
    NativeDelayStack.Add(IntToStr(i));
    NativeDelayStack.Add(GetDataStack(TypesI, Derefs, References, i));
    NativeDelayStack.Add(x64Mode);
    if TypesI = 'Write Registry' then
      NativeDelayProgress := NativeDelayProgress +weightWR
    else
    
    if TypesI = 'Create Link' then
      NativeDelayProgress := NativeDelayProgress +weightCRL
    else
    if TypesI = 'Control Service' then
      NativeDelayProgress := NativeDelayProgress +weightCTS
    else
    if TypesI = 'Configure Service' then
      NativeDelayProgress := NativeDelayProgress +weightCCS
    else
    if TypesI = 'Configure Service Failure' then
      NativeDelayProgress := NativeDelayProgress +weightCSFA
    else
    if TypesI = 'Create Shortcut' then
      NativeDelayProgress := NativeDelayProgress +weightCS
    else
    if TypesI = 'Create File Type' then
      NativeDelayProgress := NativeDelayProgress +weightFT
    else
    if TypesI = 'Create Folder' then
      NativeDelayProgress := NativeDelayProgress +weightCF
    else
    if TypesI = 'Delete Files' then
      NativeDelayProgress := NativeDelayProgress +weightDF
    else
    if TypesI = 'Set Environment' then
      NativeDelayProgress := NativeDelayProgress +weightSE
    else
    if TypesI = 'Edit INI File' then
      NativeDelayProgress := NativeDelayProgress +weightINI
    else
    if TypesI = 'Create ODBC DSN' then
      NativeDelayProgress := NativeDelayProgress +weightDSN
    else
    if TypesI = 'Copy/Move Local Files' then
    begin
      try
        Enter64BitFileSystem;
        WidenColonDelimParam(l[3], Wide1, Wide2);
        if Wide2 = '' then Wide2 := 'FALSE'; 
        l := TStringList.Create;
        l.CommaText := NativeDelayStack[NativeDelayStack.Count -2];
        lX := TStringList.Create;
        MyFindAllFiles(lX, AssertDir(l[0]), l[1], StrToBool(l[4]), faDirectory, ';', ';',
          StrToBool(Wide2));
        
        for iX := 1 to lX.Count do
          NativeDelayProgress := NativeDelayProgress + FileUtil.FileSize(lX[iX -1]);
        lX.Free;
        l.Free;
      finally
        Leave64BitFileSystem;
      end;
    end;
    Exit;
  end;
  
  if TypesI = 'ROLLBACK' then
    if StrToBool(GetVariable('MYAH_IsCancelled')) then
    begin
      SetVariable('MYAH_IsCancelled', 'FALSE', 'Native Spooler');
      RestoreCancellation := True;
    end;
  thSpoolerFinished := false;
  thSpoolerPrimaryWindowHandle := {$IFDEF WINDOWS}PrimaryWindowHandle{$ELSE}0{$ENDIF};
  MonitorGlobalProgress := True;
  thSpoolerThread := TNativeThread.Create(True);
  {$IFDEF DARWIN}
  thSpoolerThread.MSIFile := MSIFile;
  {$ENDIF}
  thSpoolerThread.TypesI := TypesI;
  thSpoolerThread.Derefs := Derefs;
  thSpoolerThread.References := References;
  thSpoolerThread.i := i;
  thSpoolerThread.CompactDataStack := GetDataStack(TypesI, Derefs, References, i);
  thSpoolerThread.Resume;
  repeat
    CustomCoolWait(thSpoolerThread); 
    if StrToBool(GetVariable('MYAH_IsCancelled')) then
    begin
      {$IFDEF USEVARMANAGER}
        VarManager['MYAH_LastActiveTick'] := VarManager['MYAH_LastDelegateTick'];
      {$ELSE}
        SETVARIABLE('MYAH_LastActiveTick',GETVARIABLE('MYAH_LastDelegateTick'),'');
      {$ENDIF}
      thSpoolerThread.Terminate;
      {$IFNDEF NOGUI}
      ImageListPool.spoolTimer.Enabled := True;
      {$ENDIF}
    end;
  until thSpoolerFinished;
  {$IFNDEF NOGUI}
  ImageListPool.spoolTimer.Enabled := false;
  {$ENDIF}
  if StrToBool(GetVariable('MYAH_IsCancelled')) then
  begin
    if not StrToBool(GetVariable('ABORTEDONERROR')) then 
    begin
      if TypesI <> 'ROLLBACK' then 
      begin
        if not SilentInstall then
        begin
          
          MyMessageBox({$IFNDEF WINDOWS}0{$ELSE}PrimaryWindowHandle{$ENDIF}, PChar(ntv0), PChar(BrandEx),
            mb_Ok + mb_IconStop);
          
        end;
      end;
    end;
    if StrToBool(GetVariable('ABORTONERROR')) then
      Result := false 
    else
      SetVariable('ABORTEDONERROR', 'TRUE', 'Cancel at Native Engine Time');
  end;
  if RestoreCancellation then
    SetVariable('MYAH_IsCancelled', 'TRUE', 'Native Spooler');
  MonitorGlobalProgress := false;
end;

function GetDataStack(TypesI: String; Derefs: TList; References: TStrings;
  i: Integer): String;
var
  Wide1, Wide2: String;
begin
  Result := '';
  if ((TypesI = 'UNINSTALL') or (TypesI = 'DELAYEDINSTALL')) or (TypesI = 'ROLLBACK') then Exit;
  dataStack.Clear;
  if TypesI = 'Write Registry' then
  begin
    dataStack.Add(MyBoolToStr(ReadOffset(Derefs, References[i -1], 1) = '10', True)); 
    WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 2), Wide1, Wide2);
    if Wide1 = '4' then 
    begin
      if StrToBool(GetVariable('ALLUSERS')) then 
        dataStack.Add('2' + '|' + Wide2) 
      else
        dataStack.Add('1' + '|' + Wide2); 
    end
    else
      dataStack.Add(Wide1 + '|' + Wide2); 
    dataStack.Add(ElimDoubles(ReadOffset(Derefs, References[i -1], 3))); 
    dataStack.Add(ElimDoubles(ReadOffset(Derefs, References[i -1], 4))); 
    dataStack.Add(ElimDoubles(ReadOffset(Derefs, References[i -1], 5))); 
    if StrToBool(ReadOffset(Derefs, References[i -1], 6)) then 
      dataStack.Add('STRING')
    else
      if StrToBool(ReadOffset(Derefs, References[i -1], 7)) then
        dataStack.Add('INTEGER')
      else
        dataStack.Add(ReadOffset(Derefs, References[i -1], 7));
        
  end
  else
  if TypesI = 'Delete Files' then
  begin
    dataStack.Add(ElimDoubles(ReadOffset(Derefs, References[i -1], 1))); 
    dataStack.Add(SubstituteVariables(ReadOffset(Derefs, References[i -1], 2))); 
  end
  else
  if TypesI = 'Install Files' then
  begin
    dataStack.CommaText := courtesyDataStack.CommaText; 
    dataStack.Add(ElimDoubles(ReadOffset(Derefs, References[i -1], 3))); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 4)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 5)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 6)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 7)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 9)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 10)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 11)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 12)); 
  end
  else
  if TypesI = 'Create Link' then
  begin
    dataStack.CommaText := courtesyDataStack.CommaText; 
    dataStack.Add(ElimDoubles(ReadOffset(Derefs, References[i -1], 2))); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 3)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 4)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 5)); 
  end
  else
  if TypesI = 'Create Folder' then
    dataStack.Add(ElimDoubles(ReadOffset(Derefs, References[i -1], 1)))
  else
  if TypesI = 'Install Assembly' then
  begin
    dataStack.CommaText := courtesyDataStack.CommaText; 
    dataStack.Add(ElimDoubles(ReadOffset(Derefs, References[i -1], 3))); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 2)); 
  end
  else
  if TypesI = 'Install Service' then
  begin
    dataStack.CommaText := courtesyDataStack.CommaText; 
    
    dataStack.Add(ElimDoubles(ReadOffset(Derefs, References[i -1], 2))); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 7)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 8)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 11)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 12)); 
    dataStack.Add(SubstituteVariables(ReadOffset(Derefs, References[i -1], 13))); 
    dataStack.Add(SubstituteVariables(ReadOffset(Derefs, References[i -1], 14))); 
    dataStack.Add(SubstituteVariables(ReadOffset(Derefs, References[i -1], 15))); 
  end
  else
  if TypesI = 'Control Service' then
  begin
    dataStack.CommaText := courtesyDataStack.CommaText; 
    dataStack.Add(ElimDoubles(ReadOffset(Derefs, References[i -1], 2))); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 3)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 5)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 4)); 
  end
  else
  if TypesI = 'Configure Service' then
  begin
    dataStack.CommaText := courtesyDataStack.CommaText; 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 5)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 6)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 7)); 
    dataStack.Add(ElimDoubles(ReadOffset(Derefs, References[i -1], 8))); 
  end
  else
  if TypesI = 'Configure Service Failure' then
  begin
    dataStack.CommaText := courtesyDataStack.CommaText; 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 5)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 6)); 
  end
  else
  if TypesI = 'Set Environment' then
  begin
    dataStack.Add(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1)));
    dataStack.Add(SubstituteVariables(ReadOffset(Derefs, References[i -1], 2)));
    dataStack.Add(ReadOffset(Derefs, References[i -1], 3));
    dataStack.Add(ReadOffset(Derefs, References[i -1], 4));
    dataStack.Add(ReadOffset(Derefs, References[i -1], 5));
    dataStack.Add(ReadOffset(Derefs, References[i -1], 6));
  end
  else
  if TypesI = 'Edit INI File' then
  begin
    dataStack.Add(AssertDir(ElimDoubles(ReadOffset(Derefs, References[i -1], 1))) + SubstituteVariables(ReadOffset(Derefs, References[i -1], 2))); 
    dataStack.Add(SubstituteVariables(ReadOffset(Derefs, References[i -1], 4))); 
    dataStack.Add(SubstituteVariables(ReadOffset(Derefs, References[i -1], 5))); 
    dataStack.Add(SubstituteVariables(ReadOffset(Derefs, References[i -1], 6))); 
    dataStack.Add(SubstituteVariables(ReadOffset(Derefs, References[i -1], 3))); 
  end
  else
  if TypesI = 'Create ODBC DSN' then
  begin
    dataStack.Add(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1))); 
    dataStack.Add(SubstituteVariables(ReadOffset(Derefs, References[i -1], 2))); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 3)); 
    
    dataStack.Add(SubstituteVariables(StringReplace(StringReplace(ReadOffset(Derefs, References[i -1], 4), '[', '$', [rfReplaceAll, rfIgnoreCase]), ']', '$', [rfReplaceAll, rfIgnoreCase]))); 
    
  end
  else
  if TypesI = 'Copy/Move Local Files' then
  begin
    dataStack.Add(ElimDoubles(ReadOffset(Derefs, References[i -1], 1))); 
    dataStack.Add(SubstituteVariables(ReadOffset(Derefs, References[i -1], 2))); 
    dataStack.Add(ElimDoubles(ReadOffset(Derefs, References[i -1], 3))); 
    
    dataStack.Add(ReadOffset(Derefs, References[i -1], 5)); 
    WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 6), Wide1, Wide2);
    if Wide2 = '' then
      Wide2 := 'FALSE';
    dataStack.Add(Wide2); 
    dataStack.Add(ElimDoubles(ReadOffset(Derefs, References[i -1], 4))); 
  end
  else
  if TypesI = 'Create Shortcut' then
  begin
    
    dataStack.CommaText := courtesyDataStack.CommaText;
    WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 7), Wide1, Wide2);
    dataStack.Add(ElimDoubles(Wide1)); 
    WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 8), Wide1, Wide2);
    dataStack.Add(Wide1); 
    WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 9), Wide1, Wide2);
    dataStack.Add(Wide1); 
  end
  else
  if TypesI = 'Create File Type' then
  begin
    
    dataStack.CommaText := courtesyDataStack.CommaText;
    dataStack.Add(ReadOffset(Derefs, References[i -1], 6)); 
    dataStack.Add(ReadOffset(Derefs, References[i -1], 7)); 
  end
  else
  if TypesI = 'Install ODBC Driver' then
  begin
    dataStack.CommaText := courtesyDataStack.CommaText; 
    dataStack.Add(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1))); 
    dataStack.Add(ElimDoubles(ReadOffset(Derefs, References[i -1], 4))); 
    
    dataStack.Add(SubstituteVariables(StringReplace(StringReplace(ReadOffset(Derefs, References[i -1], 6), '[', '$', [rfReplaceAll, rfIgnoreCase]), ']', '$', [rfReplaceAll, rfIgnoreCase]))); 
    
  end;
  Result := dataStack.CommaText;
end;

procedure CheckDoNativeRollback;
begin
  if NativeEngineMode then
    if NativeRollback then
      SpoolNativeAction('ROLLBACK', nil, nil, 0); 
end;

{$IFDEF WINDOWS}
type
  TSecurityStuff = record
    objType  : SE_OBJECT_TYPE;
    name     : UnicodeString;
    key      : HKEY;
    sidOwner : PSID;
    dacl     : PACL;
    secDesc  : PSecurityDescriptor;
  end;

  TGetNamedSecurityInfoW = function(objName: PWideChar; objType, securityInfo: dword; out owner: PSid; group: pointer; out dacl: PACL; sacl: pointer; out sd: PSecurityDescriptor) : dword; stdcall;
  TSetSecurityInfo = function(obj: THandle; objType, securityInfo: dword; owner, group: PSid; dacl, sacl: PACL) : dword; stdcall;
  TGetSecurityInfo = function(obj: THandle; objType, securityInfo: dword; out owner: PSid; group: pointer; out dacl: PACL; sacl: pointer; out sd: PSecurityDescriptor) : dword; stdcall;
  TSetNamedSecurityInfoW = function(objName: PWideChar; objType, securityInfo: dword; owner, group: PSid; dacl, sacl: PACL) : dword; stdcall;

function ClearFileSecurity(const fileName: UnicodeString; OnlyClear: Boolean
  ): THandle;

var pss   : ^TSecurityStuff;
    error : dword;
  b: Boolean;
  acc: Boolean;
  per: TPermissions;
  sec: TSuccessorSecurityObject;
begin
  result := 0;
  b := false;
  if Win32Platform <> VER_PLATFORM_WIN32_NT then Exit;
  if AnsiCompareText(GetVariable('NATIVE_OVERRIDE_PERMISSIONS'), 'TRUE') <> 0 then Exit;
  OwnerMustBeRestorable := not (AnsiCompareText(GetVariable('NATIVE_OVERRIDE_NON_RESTORABLE_PERMISSIONS'), 'TRUE') <> 0);
  
  New(pss);
  pss^.objType := SE_FILE_OBJECT;
  pss^.name := fileName;
  pss^.key := 0;
  error := GetNamedSecurityInfoW(PWideChar(fileName), SE_FILE_OBJECT, DACL_SECURITY_INFORMATION or OWNER_SECURITY_INFORMATION, @(pss^.sidOwner), nil, @(pss^.dacl), nil, pss^.secDesc);
  if (error = ERROR_SUCCESS) or ((error = ERROR_ACCESS_DENIED) and (not OwnerMustBeRestorable)) then
  begin
    
    acc := false;
    sec := nil;
    try
      if DirectoryExists(fileName) then
      begin
        sec := TDirecotrySecurityObject.Create(fileName);
        acc := True;
      end
      else
        sec := TFileSecurityObject.Create(fileName);
    except
      on E: EOSError do
      begin
        Error := E.ErrorCode;
        sec := nil;
      end
      else
      begin
        Error := GetLastError;
        sec := nil;
      end;
    end;
    if Assigned(sec) then
    begin
      try
        if sec.Owner <> SysUtils.GetEnvironmentVariable('USERNAME') then
        begin
          sec.Owner := SysUtils.GetEnvironmentVariable('USERNAME');
          sec.Apply;
        end;
      except
        on E: EOSError do
        begin
          Error := E.ErrorCode;
          sec.Free;
          sec := nil;
        end
        else
        begin
          Error := GetLastError;
          sec.Free;
          sec := nil;
        end;
      end;
      if Assigned(sec) and (not OnlyClear) then
      begin
        per := [ptAll];
        try
          if acc then 
            sec.SetAccess('', SysUtils.GetEnvironmentVariable('USERNAME'), per, [], True, false, false, false)
          else
            sec.SetAccess('', SysUtils.GetEnvironmentVariable('USERNAME'), per, []);
        except
          on E: EOSError do
          begin
            Error := E.ErrorCode;
            sec.Free;
            sec := nil;
          end
          else
          begin
            Error := GetLastError;
            sec.Free;
            sec := nil;
          end;
        end;
      end;
      if Assigned(sec) then
      begin
        try
          sec.Apply;
        except
          on E: EOSError do
          begin
            Error := E.ErrorCode;
            sec.Free;
            sec := nil;
          end
          else
          begin
            Error := GetLastError;
            sec.Free;
            sec := nil;
          end;
        end;
        if Assigned(sec) then
        begin
          Result := THandle(pss);
          sec.Free;
        end;
      end;
    end;
  end;
  if result = 0 then
  begin
    Dispose(pss);
    SetLastError(error);
  end;
end;

type
  _KEY_INFORMATION_CLASS = (
    KeyBasicInformation,
    KeyNodeInformation,
    KeyFullInformation,
    KeyNameInformation);
  KEY_INFORMATION_CLASS = _KEY_INFORMATION_CLASS;
  TKeyInformationClass = KEY_INFORMATION_CLASS;
  TKeyNameInformation = packed record
    NameLength: LongWord;
    Name: Array[0..(MAX_PATH +1) *8*4] of WideChar;
  end;
  PKeyNameInformation = ^TKeyNameInformation;
  PNtQueryKey = ^TNtQueryKey;
  TNtQueryKey = function(
    KeyHandle : THANDLE;
    KeyInformationClass : KEY_INFORMATION_CLASS;
    KeyInformation : PKeyNameInformation;
    KeyInformationLength : ULONG;
    var ResultLength : Cardinal
   ): LONG; stdcall;

threadvar
  buffer: TKeyNameInformation;

function RegOpenKey(key: HKEY; const subKey: UnicodeString; flags: dword; var newKey: HKEY) : integer;
const KEY_WOW64_64KEY	= $0100;
      KEY_WOW64_32KEY	= $0200;
var c1 : dword;
begin
  if not Am64bitOS then
    c1 := 0
  else
    if Access64bitRegistry then
      c1 := KEY_WOW64_64KEY
    else
      c1 := KEY_WOW64_32KEY;
  result := RegOpenKeyExW(key, PWideChar(subKey), 0, flags or c1, newKey);
end;

function GetKeyPathFromHKEY(key: HKEY): String;
var
  dll: HModule;
  
  size, return: DWORD;
  NtQueryKey: PNtQueryKey;
begin
  Result := '';
  if (key <> 0) then
  begin
    dll := 0;
    dll := LoadLibrary('ntdll.dll');
    if dll <> 0 then
    begin
      NtQueryKey := nil;
      NtQueryKey := GetProcAddress(dll, 'NtQueryKey');
      if Assigned(NtQueryKey) then
      begin
        return := 0;
        return := NtQueryKey^(key, KeyNameInformation, nil, 0, size);
        if return = $C0000023 then
        begin
          
          return := NtQueryKey^(key, KeyNameInformation, @buffer, size, size);
          if (return = $0) then
          begin
            buffer.Name[(size div SizeOf(Char)) -2] := #0;
            Result := buffer.Name;
          end;
        end;
      end;
      FreeLibrary(dll);
    end;
  end;
  if Length(Result) > 0 then
    if Result[1] = '\' then
      System.Delete(Result, 1, 1);
  if AnsiPos('REGISTRY\MACHINE\', Result) = 1 then
    Result := StringReplace(Result, 'REGISTRY\MACHINE\', 'HKEY_LOCAL_MACHINE\', [rfIgnoreCase]);
  if AnsiPos('REGISTRY\USER\', Result) = 1 then
    Result := StringReplace(Result, 'REGISTRY\USER\', 'HKEY_USERS\', [rfIgnoreCase]);
  
end;

function ClearRegSecurity(key: HKEY; const name: UnicodeString; Computer: String = '') : THandle;

var pss   : ^TSecurityStuff;
    error : dword;
    hk1   : HKEY;
  SID: PSID;
  sec: TSuccessorSecurityObject;
  per: TPermissions;
  s: String;
  p: Pointer;
begin
  result := 0;
  if Win32Platform <> VER_PLATFORM_WIN32_NT then Exit;
  if AnsiCompareText(GetVariable('NATIVE_OVERRIDE_PERMISSIONS'), 'TRUE') <> 0 then Exit;
  OwnerMustBeRestorable := not (AnsiCompareText(GetVariable('NATIVE_OVERRIDE_NON_RESTORABLE_PERMISSIONS'), 'TRUE') <> 0);
  Access64bitRegistry := (Is64Bit and (x64Mode <> 'Win32'));
  New(pss);
  pss^.objType := SE_REGISTRY_KEY;
  pss^.name := '';
  pss^.key := 0;
  hk1 := 0;
  
  if Computer <> '' then
  begin
    error := RegConnectRegistry(PChar(Computer), key, hk1);
    if error <> ERROR_SUCCESS then Exit
    else
      key := hk1;
  end;
  error := RegOpenKey(key, name, READ_CONTROL, hk1);
  if (error = ERROR_SUCCESS) or ((error = ERROR_ACCESS_DENIED) and (not OwnerMustBeRestorable)) then
  begin
    if error = ERROR_ACCESS_DENIED then
    begin
      
      error := RegOpenKey(key, name, WRITE_OWNER, hk1);
      if error = ERROR_SUCCESS then
      begin
        
        if GetProcessSid(GetCurrentProcess, SID, p) then
        begin
          SetSecurityInfo(hk1, SE_REGISTRY_KEY, OWNER_SECURITY_INFORMATION, SID, nil, nil, nil);
          FreeMem(p);
        end;
        RegCloseKey(hk1);
        hk1 := 0;
        error := RegOpenKey(key, name, READ_CONTROL, hk1);
      end;
    end;
    if error = ERROR_SUCCESS then
    begin
      
      error := GetSecurityInfo(hk1, SE_REGISTRY_KEY, DACL_SECURITY_INFORMATION or OWNER_SECURITY_INFORMATION, @pss^.sidOwner, nil, @pss^.dacl, nil, pss^.secDesc);
      RegCloseKey(hk1);
      hk1 := 0;
      if error = ERROR_SUCCESS then
      begin
        
        error := RegOpenKey(key, name, READ_CONTROL or WRITE_OWNER or WRITE_DAC, hk1);
        if error = ERROR_ACCESS_DENIED then
        begin
          
          error := RegOpenKey(key, name, WRITE_OWNER, hk1);
          if error = ERROR_SUCCESS then
          begin
            
            if GetProcessSid(GetCurrentProcess, SID, p) then
            begin
              SetSecurityInfo(hk1, SE_REGISTRY_KEY, OWNER_SECURITY_INFORMATION, SID, nil, nil, nil);
              FreeMem(p);
            end;
            RegCloseKey(hk1);
            hk1 := 0;
            error := RegOpenKey(key, name, READ_CONTROL or WRITE_OWNER or WRITE_DAC, hk1);
          end;
        end;
        if (error = ERROR_SUCCESS) or (error = ERROR_ACCESS_DENIED) then
        begin
          
          case key of
            HKEY_LOCAL_MACHINE: s := 'HKEY_LOCAL_MACHINE';
            HKEY_USERS: s := 'HKEY_USERS';
            HKEY_CLASSES_ROOT: s := 'HKEY_CLASSES_ROOT';
            HKEY_CURRENT_USER: s := 'HKEY_CURRENT_USER';
            HKEY_CURRENT_CONFIG: s := 'HKEY_CURRENT_CONFIG';
          else
            s := GetKeyPathFromHKEY(key);
          end;
          if Computer <> '' then
            s := '\\' + Computer + '\' + s;
          s := ValidateRegistryName(s + '\' + name);
          sec := nil;
          per := [ptAll];
          try
            if Access64bitRegistry then
              sec := TRegistryWow64Key64SecurityObject.Create(s)
            else
              sec := TRegistrySecurityObject.Create(s);
          except
            on E: EOSError do
            begin
              Error := E.ErrorCode;
              sec := nil;
            end
            else
            begin
              Error := GetLastError;
              sec := nil;
            end;
          end;
          if Assigned(sec) then
          begin
            pss^.objType := sec.ObjectType;
            try
              
              sec.SetAccess(Computer, SysUtils.GetEnvironmentVariable('USERNAME'), per, [], True, false, false, false);
            except
              on E: EOSError do
              begin
                Error := E.ErrorCode;
                sec.Free;
                sec := nil;
              end
              else
              begin
                Error := GetLastError;
                sec.Free;
                sec := nil;
              end;
            end;
            if Assigned(sec) then
            begin
              try
                sec.Apply;
              except
                on E: EOSError do
                begin
                  Error := E.ErrorCode;
                  sec.Free;
                  sec := nil;
                end
                else
                begin
                  Error := GetLastError;
                  sec.Free;
                  sec := nil;
                end;
              end;
              if Assigned(sec) then
              begin
                
                if hk1 = 0 then
                  RegOpenKey(key, name, READ_CONTROL or WRITE_OWNER or WRITE_DAC, hk1);
                pss^.key := hk1;
                hk1 := 0;
                result := THandle(pss);
                sec.Free;
              end;
            end;
          end;
          
          if hk1 <> 0 then
            RegCloseKey(hk1);
        end;
      end;
    end;
  end;
  if Computer <> '' then
    RegCloseKey(key);
  if result = 0 then
  begin
    Dispose(pss);
    SetLastError(error);
  end;
end;

function RestoreSecurity(ss: THandle; const AlternateFileName: String = ''; const PreserveBuffer: Boolean = false) : boolean;

var pss   : ^TSecurityStuff;
    error : dword;
    ws    : WideString;
    hDummy: THandle;
  flags: SECURITY_INFORMATION;
begin
  if Win32Platform <> VER_PLATFORM_WIN32_NT then Exit;
  if AnsiCompareText(GetVariable('NATIVE_OVERRIDE_PERMISSIONS'), 'TRUE') <> 0 then Exit;
  
  if ss <> 0 then
  begin
    pss := pointer(ss);
    flags := 0;
    if pss^.sidOwner <> nil then flags := flags or OWNER_SECURITY_INFORMATION;
    if pss^.dacl <> nil then flags := flags or DACL_SECURITY_INFORMATION;
    if pss^.key <> 0 then
    begin
      error := SetSecurityInfo(pss^.key, pss^.objType, flags, pss^.sidOwner, nil, pss^.dacl, nil);
      
      RegCloseKey(pss^.key);
    end
    else
    begin
      error := SetNamedSecurityInfoW(PWideChar(pss^.name), pss^.objType, flags, pss^.sidOwner, nil, pss^.dacl, nil);
      
      if AlternateFileName <> '' then
      begin
        hDummy := ClearFileSecurity(AlternateFileName, True);
        ws := AlternateFileName;
        error := SetNamedSecurityInfoW(PWideChar(ws), pss^.objType, flags, pss^.sidOwner, nil, pss^.dacl, nil);
        
      end;
    end;
    result := error = ERROR_SUCCESS;
    if not result then
      SetLastError(error);
    if not PreserveBuffer then
    begin
      LocalFree(HLOCAL(pss^.secDesc));
      Dispose(pss);
    end;
  end
  else
    result := false;
end;
{$ENDIF}

function ProcessMinExtract(DisplayMessage, RollbackNative: Boolean): Boolean;
begin
  Result := True;
  if MinExtracted then Exit;
  if DirectoryExists(AssertDir(ExtractFilePath(MyParamStr(0))) + 'data' + PathDelim) or
    DirectoryExists(AssertDir(ExtractFilePath(MyParamStr(0))) + 'OFFLINE' + PathDelim) then Exit;
    
  Result := false;
  Enter64BitFileSystem;
  try
    thdxTestOnly := false;
    thdxWindow := {$IFDEF WINDOWS}PrimaryWindowHandle{$ELSE}0{$ENDIF};
    thdxArchive := SFXFileName;
    thdxOutput := AssertDir(ExtractFilePath(MyParamStr(0)));
    thdxPassword := DeObsWeblock(GetWeblockPwd('OFFLINE'));
    thdxUsePath := True;
    thdxOverwrite := false;
    thdxFinished := false;
    MonitorGlobalProgress := True;
    tdem := TDirectExtractMedia.Create(false);
    repeat
      CustomCoolWait(tdem);
      if StrToBool(GetVariable('MYAH_IsCancelled')) then
      begin
        {$IFDEF USEVARMANAGER}
        VarManager['MYAH_LastActiveTick'] := VarManager['MYAH_LastDelegateTick'];
        {$ELSE}
        SETVARIABLE('MYAH_LastActiveTick',GETVARIABLE('MYAH_LastDelegateTick'),'');
        {$ENDIF}
        tdem.Terminate;
        {$IFNDEF NOGUI}
        ImageListPool.tdemTimer.Enabled := True;
        {$ENDIF}
      end;
    until thdxFinished = True;
    {$IFNDEF NOGUI}
    ImageListPool.tdemTimer.Enabled := false;
    {$ENDIF}
    Result := thdxExternalResult;
    if Result then
      MinExtracted := True;
    if DisplayMessage then
    begin
      if StrToBool(GetVariable('MYAH_IsCancelled')) then
        if not StrToBool(GetVariable('ABORTEDONERROR')) then
          if not SilentInstall then
          begin
            
            MyMessageBox({$IFNDEF WINDOWS}0{$ELSE}PrimaryWindowHandle{$ENDIF}, PChar(ntv0), PChar(BrandEx),
              mb_Ok + mb_IconStop);
            
          end;
    end;
    if RollbackNative then
      if not Result then
      begin
        if StrToBool(GetVariable('ABORTONERROR')) then
          CheckDoNativeRollback
        else
          SetVariable('ABORTEDONERROR', 'TRUE', 'Cancel at Deferred Extraction Time');
      end;
    MonitorGlobalProgress := false;
  finally
    Leave64BitFileSystem;
  end;
end;

function RecommendAllUserState: Boolean;
begin
  Result := IsUserAdmin;
end;

function IsUserAdmin: Boolean;
{$IFDEF WINDOWS}
var
  osVerInfo: TOSVersionInfo;
{$ENDIF}
begin
  {$IFDEF WINDOWS}
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    Result := IsUserParticular(DOMAIN_ALIAS_RID_ADMINS)
  else
    Result := True;
  if Result then
  begin
    osVerInfo.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
    GetVersionEx(osVerInfo);
    if osVerInfo.dwMajorVersion >= 6 then
      Result := IsUserElevated;
  end;
  {$ELSE}
  
  Result := FpGeteuid = 0;
  {$ENDIF}
end;

{$IFDEF DARWIN}
{$linkframework Security}
function VerifyAdminLogin: Boolean;
var
  status:OSStatus;
  authRef: AuthorizationRef;
  authFlags: AuthorizationFlags;
  authRights: AuthorizationRights;
  authItem: AuthorizationItem;
  s: String;
begin
  authItem.flags := 0;
  authItem.name  := kAuthorizationRightExecute;
  s := '/bin/mkdir';
  authItem.value := PChar(s);
  authItem.valueLength:= SizeOf(s);
  authRights.count := 1;
  authRights.items := @authItem;
  authRef := nil;
  authFlags := kAuthorizationFlagInteractionAllowed or kAuthorizationFlagExtendRights or kAuthorizationFlagPreAuthorize;
  status := AuthorizationCreate(@authRights, kAuthorizationEmptyEnvironment, authFlags, authRef);
  Result := status=errAuthorizationSuccess;
  if Result then
  begin
    AuthorizationFree(authRef, kAuthorizationFlagDefaults);
    
  end;
end;
{$ENDIF}

function IsUserParticular(Kind: Integer): Boolean;
{$IFDEF WINDOWS}
const
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority =
  (Value: (0, 0, 0, 0, 0, 5));
  SECURITY_BUILTIN_DOMAIN_RID: DWORD = $00000020;
  DOMAIN_ALIAS_RID_ADMINS: DWORD = $00000220;
  DOMAIN_ALIAS_RID_USERS: DWORD = $00000221;
  DOMAIN_ALIAS_RID_GUESTS: DWORD = $00000222;
  DOMAIN_ALIAS_RID_POWER: DWORD = $00000223;
var
  hAccessToken: THandle;
  ptgGroups: PTokenGroups;
  dwInfoBufferSize: DWORD;
  psidAdministrators: PSID;
  x: Integer;
  bSuccess: BOOL;
begin
  if Win32Platform = VER_PLATFORM_WIN32_WINDOWS	then
  begin
    Result := True;
    Exit;
  end;
  Result   := False;
  bSuccess := OpenThreadToken(GetCurrentThread, TOKEN_QUERY, True,
    hAccessToken);
  if not bSuccess then
  begin
    if GetLastError = ERROR_NO_TOKEN then
      bSuccess := OpenProcessToken(GetCurrentProcess, TOKEN_QUERY,
        hAccessToken);
  end;
  if bSuccess then
  begin
    GetMem(ptgGroups, 102400);
    bSuccess := GetTokenInformation(hAccessToken, TokenGroups,
      ptgGroups, 102400, dwInfoBufferSize);
    CloseHandle(hAccessToken);
    if bSuccess then
    begin
      AllocateAndInitializeSid(SECURITY_NT_AUTHORITY, 2,
        SECURITY_BUILTIN_DOMAIN_RID, Kind,
        0, 0, 0, 0, 0, 0, psidAdministrators);
      {$R-}
      for x := 0 to ptgGroups^.GroupCount - 1 do
        if EqualSid(psidAdministrators, ptgGroups^.Groups[x].Sid) then
        begin
          Result := True;
          Break;
        end;
      {$R+}
      FreeSid(psidAdministrators);
    end;
    FreeMem(ptgGroups);
  end;
{$ELSE}
begin
  
{$ENDIF}
end;

function IsUserElevated: Boolean;
{$IFDEF WINDOWS}
const
  TokenElevationType = 18;
  TokenElevation     = 20;
  TokenElevationTypeDefault = 1;
  TokenElevationTypeFull    = 2;
  TokenElevationTypeLimited = 3;
var
  
  token: THandle;
  
  ElevationType: Integer;
  Elevation: DWord;
  dwSize: Cardinal;
begin
  Result := false;
  if OpenProcessToken(GetCurrentProcess, TOKEN_QUERY, token) then
    try
      
      if GetTokenInformation(token, TTokenInformationClass(TokenElevation), @Elevation, SizeOf(Elevation), dwSize) then begin
        if Elevation = 0 then
          Result := false
        else
          Result := True;
      end else begin end;
        
    finally
      CloseHandle(token);
    end
  else begin end;
    
  {$ELSE}
  begin
    
  {$ENDIF}
end;

function SniffSafeUserPath(AllUsers: Boolean): String;
var
  
  b: Boolean;
  s: String;
  t: TextFile;
begin
  Result := GetVariable('OVERRIDECACHE');
  if Result = '' then
  begin
    
    try
      
      s := IncludeTrailingPathDelimiter(MyGetAppConfigDir(false)) + 'MimarSinan' + PathDelim + 'InstallAware' + PathDelim + 'Ident.Cache' + PathDelim + ProductGUID;
      if MyFileExists(s) then
      begin
        FileMode := 0;
        AssignFile(t, s);
        Reset(t);
        ReadLn(t, Result);
        b := True;
        CloseFile(t);
      end
      else
        b := false;
      
      if not DirectoryExists(Result) then
        b := false;
      if not b then
      begin
        
        s := IncludeTrailingPathDelimiter(MyGetAppConfigDir(True)) + 'MimarSinan' + PathDelim + 'InstallAware' + PathDelim + 'Ident.Cache5' + PathDelim + ProductGUID;
        if MyFileExists(s) then
        begin
          FileMode := 0;
          AssignFile(t, s);
          Reset(t);
          ReadLn(t, Result);
          CloseFile(t);
        end;
      end;
      
      if ExtractFileName(DeAssertDir(Result)) <> RevisionGUID then
        Result := '' 
      else
        Result := AssertDir(ExtractFilePath(DeAssertDir(Result)));
    except
      Result := '';
    end;
  end;
  if Result <> '' then Exit;
  if AllUsers then
    GetSpecialFolder($23, Result)
  else
  begin
    GetSpecialFolder($1c, Result); 
    if Result = '' then
      GetSpecialFolder($1a, Result); 
  end;
  if Result = '' then
  begin
    GetSpecialFolder($0, Result); 
    Result := AssertDir(ExtractFilePath(DeAssertDir(Result))) + 'Application Data' + PathDelim;
  end
    else Result := AssertDir(Result);
end;

function SniffSafeTargetDir: String;
var
  s: String;
begin
  
  {$IFDEF WINDOWS}
  if IsUserAdmin then
    GetSpecialFolder($26, s)
  else
  begin
    GetSpecialFolder($5, s);
    s := ExtractFilePath(DeAssertDir(s));
  end;
  
  {$ELSE}
  
  {$IFDEF DARWIN}
  
  if IsUserAdmin then
    GetSpecialFolder($2b, s)
  else
    GetSpecialFolder($26, s);
  {$ELSE}
  
  if IsUserAdmin then
    GetSpecialFolder($2b, s)
  else
    s := ExpandFileName('~/.local/share/');
  {$ENDIF}
  {$ENDIF}
  Result := AssertDir(s);
  
end;

procedure CustomCoolWait(Thread: TThread);
begin
  if {$IFDEF NOGUI}True{$ELSE}SilentInstall{$ENDIF} then
  begin
    if Thread <> nil then
      {$IFDEF DARWIN}
      {$IFNDEF NOGUI} 
      while Assigned(Thread) and (not Thread.Finished) do
      begin
        Application.Idle(false);
        Sleep(100);
        Application.ProcessMessages;
      end;
      {$ELSE}
      Thread.WaitFor;
      {$ENDIF}
      {$ELSE}
      Thread.WaitFor;
      {$ENDIF}
    Exit;
  end;
  
  {$IFNDEF NOGUI}
  {$IFNDEF MACOS}
  Application.Idle(false); 
  Sleep(100); 
  
  Application.ProcessMessages;
  
  {$ELSE}
  
  Application.HandleMessage; 
  {$ENDIF}
  
  {$ENDIF}
end;

function BrandEx: String;
begin
  if NoBrand then
  begin
    if TitleEy = '' then
      Result := ''
    else
      Result := TitleEy;
  end
  else
  begin
    if TitleEy = '' then
      Result := Brand + SWizard
    else
      Result := TitleEy + ' - ' + Brand + SWizard;
  end;
end;

function GetUnitName(Pull: String; NoExtract: Boolean = false): String;
begin
  Result := '';
  try
    if AnsiPos('*', Pull) = 0 then Exit;
    System.Delete(Pull, Pos('*', Pull), Length(Pull));
    if NoExtract then
      Result := Pull
    else
      Result := ExtractFileNameOnly(Pull);
  except
    Result := '';
  end;
end;

function GetLineNumber(Pull: String): Integer;
begin
  Result := 0;
  try
    if AnsiPos('*', Pull) = 0 then Exit;
    System.Delete(Pull, 1, Pos('*', Pull));
    Result := StrToInt(Pull);
  except
    Result := 0;
  end;
end;

procedure CacheSetMSIPropertyEx(Param1, Param2: String);
begin
  
end;

function GetDialogResourcePath(ScriptName: String): String;
begin
  {$IFNDEF INTEROP}
  Result := PROJDIR + ScriptName + '.lfm'; 
  {$ELSE}
  Result :=  CachedSupportDir + ScriptName + '.lfm'; 
  {$ENDIF}
end;

function GetCommandHeaderEx(Types, References: TStrings; Derefs: TList; Line: Integer): String;
var
  i: Integer;
  s: String;
begin
  Result := IntToStr(Line);
  Exit;
  Result := '';
  s := Types[Line];
  if NativeEngineMode then
  begin
    if AnsiPos('Install ', s) <> 1 then Exit;
    
  end;
  i := CommandHeaders.IndexOf(IntToStr(Line));
  if i <> -1 then Result := CommandHeaders[i -1];
  if not AllowMissHeader then
    if Result = '' then
      raise Exception.Create(SUnableToObtainCommandHeadersPlea);
end;

function GetCommandHeader(Types, References: TStrings; Derefs: TList; Line: Integer; Turbo, Blend: Boolean): String;
var
  s: String;
  i, j: Integer;
  d: DWORD;
  MaxLen: Integer;
  Blendable: Boolean;
begin
  Result := IntToStr(Line);
  Exit;
  Result := '';
  
  i := CommandHeaders.IndexOf(IntToStr(Line));
  Blendable := false;
  if i <> -1 then
  begin
    
    CommandHeaders.Delete(i -1);
    CommandHeaders.Delete(i -1);
  end;
  
  s := Types[Line];
  if s = 'Write Registry' then 
  begin
    Result := 'WR'; 
    i := 7;
    Blendable := True;
  end else
  if s = 'Install Files' then 
  begin
    Result := 'IF'; 
    i := 12;
  end else
  if s = 'Create Link' then 
  begin
    Result := 'CRL'; 
    i := 5;
  end else
  if s = 'Edit INI File' then 
  begin
    Result := 'EI'; 
    i := 6;
    Blendable := True;
  end else
  if s = 'Create File Type' then 
  begin
    Result := 'FT'; 
    i := 7;
    Blendable := True;
  end else
  if s = 'Create Folder' then 
  begin
    Result := 'CF'; 
    i := 1;
    Blendable := True;
  end else
  if s = 'Advertised File Type' then 
  begin
    Result := 'AT'; 
    i := 7;
  end else
  if s = 'Set Environment' then 
  begin
    Result := 'SE'; 
    i := 6;
    Blendable := True;
  end else
  if s = 'Delete Files' then 
  begin
    Result := 'DF'; 
    i := 4;
    Blendable := True;
  end else
  if s = 'Create Shortcut' then 
  begin
    Result := 'CS'; 
    i := 9;
    Blendable := True;
  end else
  if s = 'Advertised Shortcut' then 
  begin
    Result := 'AS'; 
    i := 9;
  end else
  if s = 'Control Service' then 
  begin
    Result := 'SC'; 
    i := 5;
    Blendable := True;
  end else
  if s = 'Configure Service' then 
  begin
    Result := 'SC'; 
    i := 8;
    Blendable := True;
  end else
  if s = 'Configure Service Failure' then 
  begin
    Result := 'SFA'; 
    i := 11;
    Blendable := True;
  end else
  if s = 'Create ODBC DSN' then 
  begin
    Result := 'OS'; 
    i := 4;
    Blendable := True;
  end else
  if s = 'Install ODBC Driver' then 
  begin
    Result := 'OD'; 
    i := 6;
  end else
  if s = 'Install Service' then 
  begin
    Result := 'IS'; 
    i := 15;
  end else
  if s = 'Install Assembly' then 
  begin
    Result := 'IA'; 
    i := 3;
  end else
  if s = 'Copy/Move Local Files' then 
  begin
    Result := 'CL'; 
    i := 6;
    Blendable := True;
  end;
  if Result = '' then Exit;
  
  if Blend then
    Turbo := Blendable; 

  if Turbo then
  begin
    Result := Result + IntToStr(Line);
    CommandHeaders.Add(Result);
    CommandHeaders.Add(IntToStr(Line));
    Exit;
  end;

  Result := s;
  for j := 1 to i do
    Result := Result + ReadOffset(Derefs, References[Line], j);
  Result := AnsiUpperCase(Result);
  Result := MD5Print(MD5String(Result));
  CalcStringCRC32(Result, d);
  Result := IntToHex(d, 0);
  
  CommandHeaders.Add(Result);
  CommandHeaders.Add(IntToStr(Line));
end;

procedure WriteToLog(Text: String);
var
  f: File;
  t: TextFile;
begin
  if LoggedInstall = '' then Exit;
  
  if FirstLogWrite then
  begin
    AssignFile(f, LoggedInstall);
    ReWrite(f);
    CloseFile(f);
    FirstLogWrite := false;
  end;
  AssignFile(t, LoggedInstall);
  Append(t);
  WriteLn(t, Text);
  CloseFile(t);
end;

procedure LoadComponents(Stream: String; Script: Boolean; LoadOldDataCall: Boolean = false);
var
  t: TextFile;
  s, sX: String;
  l: TStringList;
  i, j: Integer;
  ComponentsEx, SelectionsEx, DeleteEx, HideEx, BarEx, SizesEx: TStringList;
  BOM: Char;
begin
  
  if not MyFileExists(Stream) then
  begin
    if (not Script) and (SmartAscertainDATFile(ExtractFilePath(Stream)) <> '') then
      Stream := SmartAscertainDATFile(ExtractFilePath(Stream)) 
    else
      Exit;
  end;
  AssignFile(t, Stream,cp_utf8);
  Reset(t);
  if not eof(t) then
  begin
    read(t, BOM);
    if ansicomparetext(BOM, #$FEFF) <> 0 then
    begin
      closefile(t);
      reset(t);
    end;
  end;
  if Script then
  begin
    ComponentsEx := TStringList.Create;
    SelectionsEx := TStringList.Create;
    DeleteEx := TStringList.Create;
    HideEx := TStringList.Create;
    BarEx := TStringList.Create;
    SizesEx := TStringList.Create;
    l := ComponentsEx;
  end
  else
    l := Components;
  if LoadOldDataCall then
    SizesEx := TStringList.Create;
  while not EOF(t) do
  begin
    ReadLn(t, s);
    if s = '$' then
    begin
      if (l = Components) or (l = ComponentsEx) then
      begin
        if Script then
          l := SelectionsEx
        else
          l := Selections;
      end
      else
      if (l = Selections) or (l = SelectionsEx) then
      begin
        if Script then
          l := DeleteEx
        else
          l := ComponentDeletes;
      end
      else
      if (l = DeleteEx) or (l = ComponentDeletes) then
      begin
        if Script then
          l := HideEx
        else
          l := ComponentHides;
      end
      else
      if (l = HideEx) or (l = ComponentHides) then
      begin
        if Script then
          l := BarEx
        else
          l := ComponentBars;
      end
      else
      if (l = BarEx) or (l = ComponentBars) then
      begin
        if Script then
          l := SizesEx
        else
        begin
          if LoadOldDataCall then
            l := SizesEx
          else
            l := ComponentSpaces;
        end;
      end
      else
      begin
        
        ReadLn(t, s);
        
        SureSetVariable('TARGETDIR', s, 'LoadComponents'); 
        ReadLn(t, s);
        SureSetVariable('ALLUSERS', s, 'LoadComponents'); 
        ReadLn(t, s);
        SureSetVariable('STARTMENU', s, 'LoadComponents'); 
        if not Script then
          ReadLn(t, CachedDataDirEx)
        else
          ReadLn(t);
        while not EOF(t) do
        begin
          ReadLn(t, s);
          ReadLn(t, sX);
          if s <> 'MYAH64WOW' then 
          begin
            if s = 'ANAPPLYINSTALLWASCALLED' then
            begin
              if MyStrToBool(sX) then  
                AnApplyInstallWasCalled := True
              else
                AnApplyInstallWasCalled := false;
              
            end
            else
            begin
              if PersistVariables.IndexOf(s) = -1 then 
                PersistVariables.Add(s); 
              SureSetVariable(s, sX, 'LoadComponents'); 
            end;
          end
          else
          begin
            x64Mode := sX;
            if not EOF(t) then
            begin
              ReadLn(t, s); 
              ReadLn(t, sX);
              SureSetVariable(s, sX, 'LoadComponents'); 
              if not EOF(t) then
              begin
                ReadLn(t, s); 
                ReadLn(t, sX);
                SureSetVariable(s, sX, 'LoadComponents'); 
              end;
            end;
          end;
        end;
      end;
    end
    else
      l.Add(s);
  end;
  CloseFile(t);
  if Script then
  begin
    for i := 1 to ComponentsEx.Count do
      for j := 1 to Components.Count do
        if CompareText(ComponentsEx[i -1], Components[j -1]) = 0 then
          Selections[j -1] := SelectionsEx[i -1];
    ComponentDeletes.Text := DeleteEx.Text;
    DeleteEx.Free;
    ComponentHides.Text := HideEx.Text;
    HideEx.Free;
    ComponentBars.Text := BarEx.Text;
    BarEx.Free;
    
    ComponentsEx.Free;
    SelectionsEx.Free;
  end;
  if LoadOldDataCall then
    SizesEx.Free;
end;

procedure SaveComponents(Stream: String; Script: Boolean;
  ReallySaveCompts: Boolean);
var
  s, sX: String;
  i: Integer;
  t, tX: TextFile;
  BOM: Char;
begin
  if AnApplyInstallWasCalled then
    sX := 'TRUE'
  else
    sX := 'FALSE';
  if not ReallySaveCompts then
  begin
    if not MyFileExists(Stream) then Exit; 
    AssignFile(t, Stream,cp_utf8);
    AssignFile(tX, Stream + '.dat',cp_utf8); 
    Reset(t);
    if not eof(t) then
    begin
      read(t, BOM);
      if ansicomparetext(BOM, #$FEFF) <> 0 then
      begin
        closefile(t);
        reset(t);
      end;
    end;
    ReWrite(tX);
    i := 0;
    while not EOF(t) do
    begin
      ReadLn(t, s);
      WriteLn(tX, s);
      if s = '$' then i := i +1;
      if i = 6 then
      begin
        
        ReadLn(t, s);
        WriteLn(tX, s);
        
        ReadLn(t, s);
        WriteLn(tX, s);
        
        ReadLn(t, s);
        WriteLn(tX, s);
        
        ReadLn(t, s);
        WriteLn(tX, s);
        
        for i := 1 to PersistVariables.Count do
        begin
          WriteLn(tX, PersistVariables[i -1]);
          WriteLn(tX, MultiLineToSingleLine(GetVariable(PersistVariables[i -1]))); 
        end;
        while not EOF(t) do
          ReadLn(t, s);
        WriteLn(tX, 'MYAH64WOW'); 
        WriteLn(tX, x64Mode);
        WriteLn(tX, 'OVERRIDECACHE');
        WriteLn(tX, GetVariable('OVERRIDECACHE'));
        WriteLn(tX, 'NATIVE_ENGINE');
        WriteLn(tX, GetVariable('NATIVE_ENGINE'));
        WriteLn(tX, 'ANAPPLYINSTALLWASCALLED');
        WriteLn(tX, sX);
        
      end;
    end;
    CloseFile(t);
    CloseFile(tX);
    DeleteFile(PChar(Stream));
    RenameFile(Stream + '.dat', Stream); 
    Exit;
  end;
  AssignFile(t, Stream,cp_utf8);
  ReWrite(t);
  for i := 1 to Components.Count do
    WriteLn(t, Components[i -1]);
  WriteLn(t, '$');
  for i := 1 to Components.Count do
    WriteLn(t, Selections[i -1]);
  WriteLn(t, '$');
  for i := 1 to ComponentDeletes.Count do
    WriteLn(t, ComponentDeletes[i -1]);
  WriteLn(t, '$');
  for i := 1 to ComponentHides.Count do
    WriteLn(t, ComponentHides[i -1]);
  WriteLn(t, '$');
  for i := 1 to ComponentBars.Count do
    WriteLn(t, ComponentBars[i -1]);
  WriteLn(t, '$');
  for i := 1 to ComponentSpaces.Count do
    WriteLn(t, ComponentSpaces[i -1]);
  WriteLn(t, '$');
  WriteLn(t, GetVariable('TARGETDIR')); 
  WriteLn(t, GetVariable('ALLUSERS')); 
  WriteLn(t, GetVariable('STARTMENU')); 
  if not Script then
  begin
    GetShortPath(CachedDataDir, s);
    WriteLn(t, s);
  end
  else
    WriteLn(t);
  for i := 1 to PersistVariables.Count do
  begin
    WriteLn(t, PersistVariables[i -1]);
    WriteLn(t, MultiLineToSingleLine(GetVariable(PersistVariables[i -1]))); 
  end;
  WriteLn(t, 'MYAH64WOW'); 
  WriteLn(t, x64Mode);
  WriteLn(t, 'OVERRIDECACHE');
  WriteLn(t, GetVariable('OVERRIDECACHE'));
  WriteLn(t, 'NATIVE_ENGINE');
  WriteLn(t, GetVariable('NATIVE_ENGINE'));
  WriteLn(t, 'ANAPPLYINSTALLWASCALLED');
  WriteLn(t, sX);
  
  CloseFile(t);
end;

procedure SetSelectionEx(Index: Integer; Selected: Boolean);
begin
  if Selected then Selections[Index] := 'TRUE' 
    else Selections[Index] := 'FALSE'; 
end;

function GetComponentBars(Path: String): Boolean;
var
  i: Integer;
begin
  Result := false;
  for i := 1 to ComponentBars.Count do
    if AnsiSameText(Path, ComponentBars[i -1])  then
    begin
      Result := True;
      Exit;
    end;
end;

{$IFNDEF NOGUI}
procedure SetComponentsFlat(From: TCheckListBox);
var
  s: String;
  i, j: Integer;
begin
  for i := 1 to From.Items.Count do
  begin
    if From.Checked[i -1] then s := 'TRUE' 
      else s := 'FALSE'; 
    for j := 1 to Components.Count do
      if AnsiPos(AnsiUpperCase(From.Items[i -1]), AnsiUpperCase(Components[j -1])) = 1 then
      begin
        
        if (not GetAnyParentComponentBars(Components[j -1])) and (not GetComponentBars(Components[j -1])) then
          
          Selections[j -1] := s;
        
        if AnsiPos('\', From.Items[i -1]) = 0 then
          From.Checked[i -1] := MyStrToBool(Selections[j -1]);  
      end;
  end;
end;
{$ENDIF}

function GetComponentHint(Path: String): String;
begin
  Result := '';
  if GetComponentIndex(Path) = -1 then Exit;
  if ComponentHints.Count -1 < GetComponentIndex(Path) then Exit;
  Result := ComponentHints[GetComponentIndex(Path)];
end;

function GetAnyParentComponentHide(Path: String): Boolean;
var
  i: Integer;
begin
  Result := false;
  while Path <> '' do
  begin
    Result := GetComponentHide(Path);
    if Result then Exit;
    Path := ExcludeTrailingPathDelimiter(ExtractFilePath(ExcludeTrailingPathDelimiter(Path)));
  end;
end;

{$IFNDEF NOGUI}
procedure GetComponentsFlat(Into: TCheckListBox);
var
  i: Integer;
  l: TStringList;
begin
  Into.Items.Clear;
  l := TStringList.Create;
  for i := 1 to Components.Count do
    if Components[i -1] <> 'MYAH-PREDEF-COMPONENT' then 
    begin
      
      if GetComponentDelete(Components[i -1]) then Continue;
      
      if GetComponentHide(Components[i -1]) then Continue;
      
      if AnsiPos('\', Components[i -1]) = 0 then
      begin
        Into.Items.Add(Components[i -1]);
        Into.Checked[Into.Items.Count -1] := MyStrToBool(Selections[i -1]);  
      end;
      
    end;
  l.Free;
end;
{$ENDIF}

function GetComponentRequiredSpaceEx(Path: String): String;
begin
  Result := IntSizeToStrSize(GetComponentRequiredSpace(Path));
end;

function GetComponentRequiredSpace(Path: String): Int64;
var
  i: Integer;
begin
  Result := 0;
  
  for i := 1 to ComponentSpaces.Count do
    if  AnsiSameText(ComponentSpaces[i -1], Path) then
    begin
      Result := StrToInt64(ComponentSpaces[i]);
      Break;
    end;
end;

function IntSizeToStrSize(Size: Int64): String;
var
  s: String;
  b: Boolean;
  i, j: Integer;
begin
  if Size < 1024 * 1024 then s := msg5
  else
  if Size < 1024 * 1024 * 1024 then
  begin
    s := msg6;
    Size := Size div 1024;
  end
  else
  begin
    s := msg7;
    Size := Size div (1024 * 1024);
  end;
  b := Size < 0;
  if b then Size := Size * -1;
  Result := IntToStr(Size);
  j := 0;
  for i := Length(Result) downto 1 do
  begin
    j := j +1;
    if (j = 3) and (i <> 1) then
    begin
      Insert(',', Result, i);
      j := 0;
    end;
  end;
  if Result <> '' then
  begin
    if b then Result := '-' + Result;
    Result := Result + ' ' + s;
  end;
end;

function GetComponentDelete(Path: String): Boolean;
var
  i: Integer;
begin
  Result := false;
  for i := 1 to ComponentDeletes.Count do
    if AnsiSameText(Path, ComponentDeletes[i -1])  then
    begin
      Result := True;
      Exit;
    end;
end;

function GetTotalSpace: Int64;
begin
  if ResolveVariable('TARGETDIR') = '' then 
    Result := -1
  else
    Result := PathFree(ResolveVariable('TARGETDIR')); 
end;

function ResolveVariableEx(Variable: String): String;
begin
  if GetStringVar(Variable) <> '' then
    Variable := GetStringVar(Variable);
  if not IsVarDefined(Variable) then
    Result := '$MYAHNX$' 
  else
  begin
    Result := GetVariable(Variable);
    Result := SubstituteVariables(Result);
  end;
end;

function GetDifference: Int64;
begin
  Result := GetTotalSpace - GetTotalRequiredSpace;
end;

function GetDifferenceEx: String;
begin
  Result := IntSizeToStrSize(GetDifference);
end;

function GetSelection(Path: String): Boolean;
begin
  Result := false;
  if GetComponentIndex(Path) = -1 then Exit;
  if GetComponentDelete(Path) then Exit;
  Result := StrToBool(Selections[GetComponentIndex(Path)]) = True;
end;

procedure SetSelection(Path: String; Selected: Boolean);
begin
  if GetComponentIndex(Path) = -1 then Exit;
  if Selected then Selections[GetComponentIndex(Path)] := 'TRUE' 
    else Selections[GetComponentIndex(Path)] := 'FALSE'; 
end;

function GetTotalSpaceEx: String;
begin
  Result := IntSizeToStrSize(GetTotalSpace);
end;

function ResolveVariable(Variable: String): String;
begin
  if GetStringVar(Variable) <> '' then
    Variable := GetStringVar(Variable);
  if not IsVarDefined(Variable) then
    Result := ''
  else
  begin
    Result := GetVariable(Variable);
    Result := SubstituteVariables(Result);
  end;
end;

function GetTotalRequiredSpace: Int64;
var
  i: Integer;
begin
  Result := 0;
  
  for i := 1 to Components.Count do
    if StrToBool(Selections[i -1]) then
      if not GetComponentDelete(Components[i -1]) then
        Result := Result + GetComponentRequiredSpace(Components[i -1]);
  
  Result := Result - InstalledSize;
end;

function GetTotalRequiredSpaceEx: String;
begin
  Result := IntSizeToStrSize(GetTotalRequiredSpace);
end;

function GetAnyParentComponentBars(Path: String): Boolean;
var
  i: Integer;
begin
  Result := false;
  while Path <> '' do
  begin
    Result := GetComponentBars(Path);
    if Result then Exit;
    Path := ExcludeTrailingPathDelimiter(ExtractFilePath(ExcludeTrailingPathDelimiter(Path)));
  end;
end;

function GetComponentHide(Path: String): Boolean;
var
  i: Integer;
begin
  Result := false;
  for i := 1 to ComponentHides.Count do
    if AnsiSameText(Path, ComponentHides[i -1])  then
    begin
      Result := True;
      Exit;
    end;
end;

procedure Enter64BitRegistry;
begin
  if Is64Bit then
  begin
    if x64Mode = 'Win32' then 
      REG_ACCESS_CONST := $200
    else
      REG_ACCESS_CONST := $100;
  end
    else REG_ACCESS_CONST := 0;
end;

procedure Leave64BitRegistry;
begin
  if Is64Bit then
    REG_ACCESS_CONST := $200
  else
    REG_ACCESS_CONST := 0;
end;

procedure Enter64BitFileSystem(IgnoreAlreadyForNewThread: Boolean = false);
var
  Wow64DisableWow64FsRedirectionFunc: function(var OldValue: Pointer): LongBool; stdcall;
begin
  {$IFDEF WINDOWS}
  if Is64Bit then
    if x64Mode <> 'Win32' then 
    begin
      Pointer(Wow64DisableWow64FsRedirectionFunc) := GetProcAddress(GetModuleHandle('kernel32.dll'), 
        'Wow64DisableWow64FsRedirection'); 
      if Assigned(Wow64DisableWow64FsRedirectionFunc) then
        
          if (not AlreadyDis) or IgnoreAlreadyForNewThread then
            if Wow64DisableWow64FsRedirectionFunc(WOW_PTR) then
              if not IgnoreAlreadyForNewThread then
                AlreadyDis := True;
    end;
  {$ENDIF}
end;

procedure Leave64BitFileSystem(IgnoreAlreadyForNewThread: Boolean = false);
var
  Wow64RevertWow64FsRedirectionFunc: function(OldValue: Pointer): LongBool; stdcall;
begin
  {$IFDEF WINDOWS}
  if Is64Bit then
    if x64Mode <> 'Win32' then 
    begin
      Pointer(Wow64RevertWow64FsRedirectionFunc) := GetProcAddress(GetModuleHandle('kernel32.dll'), 
        'Wow64RevertWow64FsRedirection'); 
      if Assigned(Wow64RevertWow64FsRedirectionFunc) then
        if AlreadyDis or IgnoreAlreadyForNewThread then
          if Wow64RevertWow64FsRedirectionFunc(WOW_PTR) then
            if not IgnoreAlreadyForNewThread then
              AlreadyDis := false;
    end;
  {$ENDIF}
end;

{$IFNDEF NOGUI}
procedure GetComponentsTree(Into: TTreeView);
var
  i, j: Integer;
  s, sX: String;
  n, nX: TTreeNode;
begin
  
  Into.Items.Clear;
  for i := 1 to Components.Count do
    if Components[i -1] <> 'MYAH-PREDEF-COMPONENT' then 
    begin
      
      if GetComponentDelete(Components[i -1]) then Continue;
      
      if GetComponentHide(Components[i -1]) then Continue;
      if GetAnyParentComponentHide(Components[i -1]) then Continue;
      
      s := Components[i -1];
      n := nil; 
      while s <> '' do
      begin
        if AnsiPos('\', s) = 0 then
        begin
          sX := s;
          s := '';
        end
        else
        begin
          sX := Copy(s, 1, AnsiPos('\', s) -1);
          System.Delete(s, 1, AnsiPos('\', s));
        end;
        nX := nil; 
        if n = nil then 
          for j := 1 to Into.Items.Count do
            if AnsiSameText(sX, Into.Items[j -1].Text)  then
            begin
              nX := Into.Items[j -1]; 
              Break;
            end;
        if n <> nil then 
          for j := 1 to n.Count do
            if AnsiSameText(n[j -1].Text, sX)  then
            begin
              nX := n[j -1]; 
              Break;
            end;
        if nX = nil then 
        begin
          if n <> nil then
            nX := Into.Items.AddChild(n, sX)
          else
            nX := Into.Items.Add(nil, sX);
        end;
        
        n := nX;
      end;
      
      if MyStrToBool(Selections[i -1]) then  
      begin
        nX.ImageIndex := 1;
        nX.SelectedIndex := 1;
      end
      else
      begin
        nX.ImageIndex := 0;
        nX.SelectedIndex := 0;
      end;
      nX.Data := Pointer(i);
    end;
  
end;
{$ENDIF}

function GetComponentIndex(Path: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 1 to Components.Count do
    if AnsiSameText(Path, Components[i -1])  then
    begin
      Result := i -1;
      Exit;
    end;
end;

function IsComponentDefined(Path: String): Boolean;
begin
  Result := GetComponentIndex(Path) <> -1;
end;

procedure AddComponent(Path, Hint: String; Selected: Boolean);
var
  i: Integer;
begin
  if IsComponentDefined(Path) then
  begin
    
    for i := 1 to ComponentDeletes.Count do
      if CompareText(Path, ComponentDeletes[i -1]) = 0 then
      begin
        ComponentDeletes.Delete(i -1);
        Break;
      end;
    
    while ComponentHints.Count -1 < GetComponentIndex(Path) do
      ComponentHints.Add('');
    
    if ComponentSpaces.IndexOf(Path) = -1 then
    begin
      ComponentSpaces.Add(Path);
      ComponentSpaces.Add('0');
    end;
    ComponentHints[GetComponentIndex(Path)] := Hint;
    
    if Selections[GetComponentIndex(Path)] = '' then
    begin
      if Selected then
        Selections[GetComponentIndex(Path)] := 'TRUE' 
      else
        Selections[GetComponentIndex(Path)] := 'FALSE'; 
    end;
    Exit;
  end;
  Components.Add(Path);
  
  while ComponentHints.Count -1 < GetComponentIndex(Path) do
    ComponentHints.Add('');
  ComponentHints[GetComponentIndex(Path)] := Hint;
  
  if ComponentSpaces.IndexOf(Path) = -1 then
  begin
    ComponentSpaces.Add(Path);
    ComponentSpaces.Add('0');
  end;
  if Selected then Selections.Add('TRUE') 
    else Selections.Add('FALSE'); 
end;

procedure ClearComponents;
begin
  Components.Clear;
  Selections.Clear;
  ComponentHints.Clear;
  ComponentDeletes.Clear;
  ComponentHides.Clear;
  ComponentBars.Clear;
end;

function SubstituteVariables(const Literal: String): String;
var
  VarIndex,
  Offset: Integer;
  VarName: string;
begin
  if AnsiPos('$', Literal) = 0 then
  begin
    Result := Literal;
    Exit;
  end;
  aVars.Acquire;
  try
    Result := SingleLineToMultiLine(Literal);
    Offset := 1;
    while ExtractNextVariableFRK(Result, VarName, Offset) do
    begin
      VarIndex := VarCache.IndexOf(VarName);
      if VarIndex <> -1 then
        Result := StringReplace(Result, '$' + VarName + '$',Variables[VarIndex], [rfIgnoreCase])
      else
      begin
        
        Inc(Offset, Length(VarName) +2);
      end;
    end;
  finally
    aVars.Release;
  end;
end;

procedure SubstituteCompilerVariablesEx(var a: array of Char; Variables: String
  );
var
  s: String;
begin
  s := a;
  SubstituteCompilerVariablesEx(s, Variables);
  StrCopy(a, PChar(s));
end;

procedure SubstituteCompilerVariablesEx(var Text: String; Variables: String);
begin
  Text := SubstituteCompilerVariables(Text, Variables);
end;

function ObsWeblock(Pass: String): String;
var
  s, sX: String;
  i, j: Integer;
begin
  Result := '';
  for i := 1 to Length(Pass) do
  begin
    s := IntToHex(Ord(Pass[i]), 2);
    sX := s[2] + s[1];
    Result := Result + sX;
  end;
  sX := '';
  j := 0;
  for i := 1 to Length(Result) do
  begin
    sX := sX + Chr(Ord(Result[i]) xor j);
    j := j +1;
  end;
  
  Result := '';
  for i := 1 to Length(sX) do
    Result := Result + IntToHex(Ord(sX[i]), 2);
end;

function DeObsWeblock(Pass: String): String;
var
  s, sX: String;
  i, j, k, l: Integer;
begin
  Result := '';
  sX := '';
  l := 1;
  for k := 1 to Length(Pass) div 2 do
  begin
    sX := sX + Chr(StrToInt('$' + Pass[l] + Pass[l +1]));
    l := l +2;
  end;
  Pass := sX;
  j := 0;
  for i := 1 to Length(Pass) do
  begin
    Result := Result + Chr(Ord(Pass[i]) xor j);
    j := j +1;
  end;
  Pass := Result;
  Result := '';
  for i := 1 to Length(Pass) do
    if i mod 2 = 1 then
    begin
      s := Pass[i +1] + Pass[i];
      Result := Result + Chr(StrToInt('$' + s));
    end;
end;

function GetWeblockPwd(Weblock: String): String;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to WeblockPasswords.Count do
    if ((i -1) mod 2) = 0 then
      if AnsiSameText(Weblock, WeblockPasswords[i -1]) then
      begin
        Result := WeblockPasswords[i];
        Exit;
      end;
  
end;

function GetVariable(const Variable: String): String;
var
  i, j, X: Integer;
begin
  Result := '';
  aVars.Acquire;
  try
    try
      X := VarCache.IndexOf(AnsiUpperCase(Variable));
      if X >- 1 then
      Result := Variables[X];
    except
      raise Exception.Create(msg8 + Variable);
    end;
    Exit;
    j := 1;
    for i := j to Variables.Count do 
      if ((i -1) mod 2) = 0 then 
        if AnsiSameText(Variables[i -1], Variable) then
        begin
          Result := Variables[i];
          Result := SubstituteVariables(Result); 
          
          Exit;
        end;
  finally
    aVars.Release;
  end;
  raise Exception.Create(msg8 + Variable);
end;

function RuntimeSubstituteCompilerVariables(Literal: String): String;
var
  i: Integer;
begin
  Result := Literal;
  if AnsiPos('#', Literal) = 0 then 
    Exit;
  for i := 1 to CompilerVariableDirect.Count do
    if (i -1) mod 2 = 0 then
      Result := StringReplace(Result, '#' + CompilerVariableDirect[i -1] + '#', CompilerVariableDirect[i], [rfReplaceAll, rfIgnoreCase]);
  if AnsiPos('#', Result) <> 0 then
    if Literal <> Result then
    begin
      Result := RuntimeSubstituteCompilerVariables(Result);
    end;
end;

function GrabMedia(Media: String; URL: TStrings; Local, Enc: String;
  var Server, Port, User, Pass: String; var Resume: Boolean; OverrideEngine,
  EngineParam: String): Boolean;
var
  l: TStringList;
  i: Integer;
begin
  try
    MonitorGlobalProgress := True;
    
    if (MediaLayout = 2) then
    begin
      
      CachedDataDir := SniffSafeUserPath(StrToBool(GetVariable('ALLUSERS'))); 
      
      CachedDataDir := CachedDataDir + RevisionGUID + PathDelim;
      CachedPlugRootDir := CachedDataDir;
      if Grab_Media_Rebuf_State = '' then
        Grab_Media_Rebuf_State := CachedDataDir
      else
        if CachedDataDir <> Grab_Media_Rebuf_State then
        begin
          
          l := MyFindAllFiles(Grab_Media_Rebuf_State, '*', false);
          for i := l.Count downto 1 do
          begin
            if DirectoryExists(l[i -1]) then
            begin
              ForceDirectories(CachedDataDir);
              MoveFolder(l[i -1], CachedDataDir + ExtractFileName(DeAssertDir(l[i -1])),
                True, True);
            end;
          end;
          l.Free;
          Grab_Media_Rebuf_State := CachedDataDir;
        end;
    end;
    Result := GrabMediaEx(Media, URL, Local, Enc, Server, Port, User, Pass, Resume, OverrideEngine, EngineParam);
  finally
    MonitorGlobalProgress := false;
  end;
end;

function GetAllEnvStrings: String;
var
  i: Integer;
begin
  Result := '';
  For i := 1 to GetEnvironmentVariableCount do
    Result := Result + GetEnvironmentString(i) + '$NEWLINE$';
end;

{$IFDEF DARWIN}
function GetDMGRoots: TStringList;
var
  s: String;
  i: Integer;
  p: TProcess;
  li: LongInt;
  l: TStringList;
  fs: TFileStream;
  b: array[1..8192] of Byte;
begin
  try
    Result := TStringList.Create;
    s := MyGetTempPathEx + MyCreateGUID;
    p := TProcess.Create(nil);
    p.CommandLine := 'hdiutil info'; 
    p.Options := [poUsePipes];
    p.Execute;
    fs := TFileStream.Create(s, fmCreate);
    repeat
      li := p.Output.Read(b, 8192);
      fs.Write(b, li);
    until li = 0;
    fs.Free;
    p.Free;
    l := TStringList.Create;
    l.LoadFromFile(s);
    DeleteFile(s);
    for i := 1 to l.Count do
      if AnsiPos('image-path      : ', l[i -1]) = 1 then
        Result.Add(AssertDir(ExtractFilePath(StringReplace(l[i -1], 'image-path      : ', '', [rfReplaceAll, rfIgnoreCase]))));
    
    l.Free;
  except
    
  end;
end;
{$ENDIF}

function GrabMediaEx(Media: String; URL: TStrings; Local, Enc: String;
  var Server, Port, User, Pass: String; var Resume: Boolean; OverrideEngine,
  EngineParam: String): Boolean;

var
  {$IFDEF NOGUI}
  c: Char;
  {$ENDIF}
  i, iX: Integer; 
  t: TextFile;
  s: String; 
  b: Boolean; 
  bX: Boolean; 
  p: PChar;
  pX: String;
  l: TStringList;
begin
  
  if StrToBool(GetVariable('REMOVE')) then 
  begin
    Result := True;
    Exit;
  end;
  
  if DirectoryExists(CachedDataDir + Media) then
  begin
    if not MyFileExists(AssertDir(CachedDataDir + Media) + RevisionGuid) then
    begin
      
      WipeFolder(AssertDir(CachedDataDir + Media) + '*', True);
      WipeFolder(AssertDir(CachedDataDir + Media) + '*', True);
      WipeFolder(AssertDir(CachedDataDir + Media) + '*', True);
    end
    else
    begin
      Result := True;
      Exit;
    end;
  end;
  
  if Media = 'OFFLINE' + PathDelim then 
  begin
    if MinExtract then
      
      if not ProcessMinExtract(false, false) then
        raise Exception.Create(msg11); 
                                       
    ForceDirectories(AssertDir(CachedDataDir + Media));
    repeat
      thzWindow := 0; 
      thzLocal := SuperCachedDataDir; 
      thzFolder := CachedDataDir; 
      thzFinished := false;
      
      tcm := TCopyMedia.Create(false);
      repeat
        
        CustomCoolWait(tcm);
        if StrToBool(GetVariable('MYAH_IsCancelled'))  then
        begin
          SetVariable('MYAH_LastActiveTick', GetVariable('MYAH_LastDelegateTick'),'');
          tcm.Terminate;
          {$IFNDEF NOGUI}
          ImageListPool.thzTimer.Enabled := True;
          {$ENDIF}
        end;
      until thzFinished = True;
      {$IFNDEF NOGUI}
      ImageListPool.thzTimer.Enabled := false;
      {$ENDIF}
      
      if not thzResult then
      begin
        WipeFolder(AssertDir(thzFolder + Media) + '*', True);
        WipeFolder(AssertDir(thzFolder + Media) + '*', True);
        WipeFolder(AssertDir(thzFolder + Media) + '*', True);
        RemoveDirectory(PChar(AssertDir(thzFolder + Media)));
        
          raise Exception.Create(msg11);
      end;
    until thzResult;
    Result := True;
    
    ForceDirectories(AssertDir(CachedDataDir + Media));
    AssignFile(t, AssertDir(CachedDataDir + Media) + RevisionGuid,cp_utf8);
    ReWrite(t);
    CloseFile(t);
    Exit;
  end;
  
  b := false;
  if GetVariable('GPOPATH') <> '' then 
    s := GetVariable('GPOPATH') 
  else
    if GetVariable('SFXPATH') <> '' then 
      s := GetVariable('SFXPATH') 
    else
      s := GetVariable('EXEDIR'); 

  if SuperData <> '' then
    s := AssertDir(ExtractFilePath(SuperData));
  
  {$IFDEF DARWIN}
  
  s := AssertDir(ExtractFilePath(DeAssertDir(ExtractFilePath(DeAssertDir(ExtractFilePath(DeAssertDir(s)))))));
  
  if not MyFileExists(s + ExtractFileName(Local)) then
  begin
    l := GetDMGRoots;
    for iX := 1 to l.Count do
      if MyFileExists(l[iX -1] + ExtractFileName(Local)) then
      begin
        s := l[iX -1];
        Break;
      end;
    l.Free;
  end;
  
  {$ENDIF}
  if MyFileExists(s + ExtractFileName(Local)) then
  begin
    
    if BannedMediaList.IndexOf(AnsiUpperCase(s + ExtractFileName(Local))) = -1 then
      b := True;
  end;
  
  if not b then repeat
    thyURL := URL;
    thyLocal := Local;
    thyServer := Server;
    thyPort := Port;
    thyUser := User;
    thyPass := Pass;
    thyVeriSign := DeObsWeblock(GetWeblockPwd('myahtfx'));
    thyResume := Resume;
    thyFinished := false;
    
    thyWindow := {$IFDEF WINDOWS}PrimaryWindowHandle{$ELSE}0{$ENDIF};
    thyProgressHeader := msg12 + DeAssertDir(Media);
    thyOverride := OverrideEngine;
    thyOverrideParam := EngineParam;
    
    tgm := TGrabMedia.Create(false);
    repeat
      
      CustomCoolWait(tgm);
      if StrToBool(GetVariable('MYAH_IsCancelled'))  then
      begin
        SetVariable('MYAH_LastActiveTick', GetVariable('MYAH_LastDelegateTick'), '');
        tgm.Terminate;
        {$IFNDEF NOGUI}
        ImageListPool.thyTimer.Enabled := True;
        {$ENDIF}
      end;
      
    until thyFinished = True;
    {$IFNDEF NOGUI}
    ImageListPool.thyTimer.Enabled := false;
    {$ENDIF}
    
    if not thyExternalResult then
    begin
      if True then 
      begin
        {$IFNDEF NOGUI}
        miaProxyEx := TmiaProxyEx.Create(nil);
        miaProxyEx.ParentWindow := 0; 
        if SilentInstall or (miaProxyEx.ShowModal = mrCancel) then
        begin
          miaProxyEx.Free;
          
            raise Exception.Create(msg13);
        end
        else
        begin
          Resume := miaProxyEx.Resume.Checked;
          miaProxyEx.Free;
        end;
        {$ELSE}
        if SilentInstall then
          raise Exception.Create(msg13);
        WriteLn; 
        WriteLn(dlg2);
        WriteLn(dlg19);
        WriteLn(dlg20);
        WriteLn('1. ' + StringReplace(dlg21, '&', '', [rfReplaceAll, rfIgnoreCase]));
        WriteLn('2. ' + StringReplace(dlg22, '&', '', [rfReplaceAll, rfIgnoreCase]));
        WriteLn('3. ' + StringReplace(dlg16, '&', '', [rfReplaceAll, rfIgnoreCase]));
        WriteLn(dlg23);
        repeat
          c := ReadKey;
          if (c = #13) then
            c := '1';
          if (c = #27) then
            c := '3';
        until (c = '1') or ((c = '2') or (c = '3'));
        if c = '3' then
          raise Exception.Create(msg13);
        Resume := c = '1';
        {$ENDIF}
      end
      else
      begin
        {$IFNDEF NOGUI}
        miaProxy := TmiaProxy.Create(nil);
        miaProxy.ParentWindow := 0; 
        miaProxy.Server.Text := Server;
        miaProxy.Port.Text := Port;
        miaProxy.User.Text := User;
        miaProxy.Password.Text := Pass;
        if SilentInstall or (miaProxy.ShowModal = mrNo) then
        begin
          miaProxy.Free;
          
            raise Exception.Create(msg13);
        end
        else
        begin
          Server := miaProxy.Server.Text;
          Port := miaProxy.Port.Text;
          User := miaProxy.User.Text;
          Pass := miaProxy.Password.Text;
          miaProxy.Free;
        end;
        {$ENDIF}
      end;
    end;
  until thyExternalResult;

  ForceDirectories(AssertDir(CachedDataDir + Media));
  {$IFDEF WINDOWS}
  GetMem(p, (MAX_PATH+1)*8);
  SHGetFolderPath(0, CSIDL_COMMON_APPDATA, 0, SHGFP_TYPE_CURRENT, p);
  pX := AssertDir(p) + 'myahx' + PathDelim;
  FreeMem(p);
  {$ELSE}
  pX := ExpandFileName('~/.myahx');
  {$ENDIF}
  
  i := 0; 
  repeat
    thxPassword := Enc;
    thxWindow := {$IFDEF WINDOWS}PrimaryWindowHandle{$ELSE}0{$ENDIF};
    if not b then
      thxLocal := Local
    else
      thxLocal := s + ExtractFileName(Local);
    thxOnCD := b;
    thxFolder := CachedDataDir;
    thxFinished := false;
    
    thxFreak7Zip := false;
    thxProgressTextHeader := msg14 + DeAssertDir(Media);
    thxFailedMoveOptimization := false;
    
    tem := TExtractMedia.Create(false);
    repeat
      
      CustomCoolWait(tem);
      
      {$IFDEF USEVARMANAGER}
        if StrToBool(GetVariable('MYAH_IsCancelled'))  then
        begin
          VarManager['MYAH_LastActiveTick'] := VarManager['MYAH_LastDelegateTick'];
          tem.Terminate;
          ImageListPool.thxTimer.Enabled := True;
        end;
      {$ELSE}
        if StrToBool(GetVariable('MYAH_IsCancelled'))  then
        begin
          SETVariable('MYAH_LastActiveTick',GETVARIABLE('MYAH_LastDelegateTick'),'');
          tem.Terminate;
          {$IFNDEF NOGUI}
          ImageListPool.thxTimer.Enabled := True;
          {$ENDIF}
        end;
      {$ENDIF}
    until thxFinished = True;
    
    {$IFNDEF NOGUI}
    ImageListPool.thxTimer.Enabled := false;
    {$ENDIF}
    
    if (not thxExternalResult) or (StrToBool(GetVariable('MYAH_IsCancelled')) ) then
    begin
      WipeFolder(AssertDir(thxFolder + Media) + '*', True);
      WipeFolder(AssertDir(thxFolder + Media) + '*', True);
      WipeFolder(AssertDir(thxFolder + Media) + '*', True);
      RemoveDirectory(PChar(AssertDir(thxFolder + Media)));
      if (not StrToBool(GetVariable('MYAH_IsCancelled')) ) and (thxFreak7Zip) then
      begin
        i := i +1;
        if i < 10 then Continue; 
      end;
      if not StrToBool(GetVariable('MYAH_IsCancelled'))  then
      begin
        {$IFNDEF NOGUI}
        miaExtract := TmiaExtract.Create(nil);
        miaExtract.ParentWindow := 0; 
        if SilentInstall or (miaExtract.ShowModal = mrCancel) then
        begin
          miaExtract.Free;
          SetVariable('MYAH_IsCancelled', 'TRUE', 'GrabMediaEx Extract Failure Cancel Trickle');
          
            raise Exception.Create(msg15);
        end
        else
        begin
          if miaExtract.Download.Checked then
          begin
            miaExtract.Free;
            if not b then DeleteFile(PChar(Local));
            if b then BannedMediaList.Add(AnsiUpperCase(s + ExtractFileName(Local)));
            bX := false;
            Result := GrabMedia(Media, URL, Local, Enc, Server, Port, User, Pass, bX, OverrideEngine, EngineParam); 
            Exit;
          end
          else
            miaExtract.Free;
        end;
        {$ELSE}
        if SilentInstall then
        begin
          SetVariable('MYAH_IsCancelled', 'TRUE', 'GrabMediaEx Extract Failure Cancel Trickle');
          raise Exception.Create(msg15);
        end
        else
        begin
          WriteLn; 
          WriteLn(dlg10);
          WriteLn(dlg11);
          WriteLn('1. ' + StringReplace(dlg12, '&', '', [rfReplaceAll, rfIgnoreCase]));
          WriteLn('2. ' + StringReplace(dlg13, '&', '', [rfReplaceAll, rfIgnoreCase]));
          WriteLn('3. ' + StringReplace(dlg16, '&', '', [rfReplaceAll, rfIgnoreCase]));
          WriteLn(dlg14);
          repeat
            c := ReadKey;
            if (c = #13) then
              c := '1';
            if (c = #27) then
              c := '3';
          until (c = '1') or ((c = '2') or (c = '3'));
          if c = '3' then
          begin
            SetVariable('MYAH_IsCancelled', 'TRUE', 'GrabMediaEx Extract Failure Cancel Trickle');
            raise Exception.Create(msg15);
          end;
          if c = '1' then
          begin
            if not b then DeleteFile(PChar(Local));
            if b then BannedMediaList.Add(AnsiUpperCase(s + ExtractFileName(Local)));
            bX := false;
            Result := GrabMedia(Media, URL, Local, Enc, Server, Port, User, Pass, bX, OverrideEngine, EngineParam); 
            Exit;
          end;
        end;
        {$ENDIF}
      end
      else
        
          raise Exception.Create(msg15);
    end;
  until thxExternalResult;
  Result := True;
  
  ForceDirectories(AssertDir(CachedDataDir + Media));
  AssignFile(t, AssertDir(CachedDataDir + Media) + RevisionGuid,cp_utf8);
  ReWrite(t);
  CloseFile(t);
  
end;

procedure VersionIfy(Path, Version: String; BugPath: String = '');
var
  s: String;
  t, tX: TextFile;
begin
  
  if BugPath <> '' then
  begin
    AssignFile(t, BugPath);
    AssignFile(tX, Path);
  end
  else
  begin
    AssignFile(t, Path);
    AssignFile(tX, Path + 'ex');
  end;
  Reset(t);
  ReWrite(tX);
  while not EOF(t) do
  begin
    ReadLn(t, s);
    if AnsiCompareText(Trim(s), '<key>CFBundleShortVersionString</key>') = 0 then 
    begin
      WriteLn(tX, s);
      WriteLn(tX, '  <string>' + Version + '</string>');
      ReadLn(t); 
    end
    else
    if AnsiCompareText(Trim(s), '<key>CFBundleVersion</key>') = 0 then 
    begin
      WriteLn(tX, s);
      WriteLn(tX, '  <string>' + Version + '</string>');
      ReadLn(t); 
    end
    else
      WriteLn(tX, s);
  end;
  CloseFile(t);
  CloseFile(tX);
  if BugPath = '' then
  begin
    DeleteFile(PChar(Path));
    MoveFile(PChar(Path + 'ex'), PChar(Path));
  end;
end;

procedure NoGuify(Path: String; BuildMode: Integer = -1);
var
  s: String;
  t, tX: TextFile;
begin
  AssignFile(t, AssertDir(Path) + 'MacOS/miasstub.command');
  ReWrite(t);
  WriteLn(t, '#!/bin/sh');
  if BuildMode <> -1 then 
  begin
    if True then 
    begin
      WriteLn(t, 'cd "$(dirname "$0")"');
      WriteLn(t, 'CURRENTPATH="${PWD}"');
      
      WriteLn(t, 'open -a Terminal "$CURRENTPATH/miaxstub"');
      
    end
    else
      WriteLn(t, 'open -a Terminal "/Volumes/' + thProjectStruct.Name + '/' + ExtractFileName(DeAssertDir(ExtractFilePath(DeAssertDir(Path)))) + '/Contents/MacOS/miaxstub"') 
  end
  else 
    WriteLn(t, 'open -a Terminal "' + AssertDir(Path) + 'MacOS/miaxstub"'); 
  CloseFile(t);
  
  {$IFNDEF WINDOWS}
  fpChMod(AssertDir(Path) + 'MacOS/miasstub.command', 500);
  {$ENDIF}
  NativeLogAddEntry('Create File', AssertDir(Path) + 'MacOS/miasstub.command');
  AssignFile(t, AssertDir(Path) + 'Info.plist');
  AssignFile(tX, AssertDir(Path) + 'Info.plistex');
  Reset(t);
  ReWrite(tX);
  while not EOF(t) do
  begin
    ReadLn(t, s);
    if AnsiCompareText(Trim(s), '<key>CFBundleExecutable</key>') = 0 then 
    begin
      WriteLn(tX, s);
      WriteLn(tX, '	<string>miasstub.command</string>');
      ReadLn(t); 
    end
    else
      WriteLn(tX, s);
  end;
  CloseFile(t);
  CloseFile(tX);
  DeleteFile(PChar(AssertDir(Path) + 'Info.plist'));
  MoveFile(PChar(AssertDir(Path) + 'Info.plistex'), PChar(AssertDir(Path) + 'Info.plist'));
end;

function SubstituteVariablesEval(Literal: String): String;
var
  i: Integer;
begin
{$IFDEF USEVARMANAGER}
  Result := VarManager.SubstituteVariablesEval(Literal);
{$ELSE}
  aVars.Acquire;
  try
    
    Result := SingleLineToMultiLine(Literal);
    for i := 1 to VarCache.Count do

      Result := STRINGReplace(Result, '$' + VarCache[i -1] + '$', '"' + Variables[i -1] + '"', [rfReplaceAll, rfIgnoreCase]);
  finally
    aVars.Release;
  end;
  if AnsiPos('$', Result) <> 0 then
    if Literal <> Result then
      Result := SubstituteVariables(Result);
{$ENDIF}
end;

function RunScriptEx(Types, References, Comments, Webs: TStrings;
  Derefs: TList; Callback: TRunScriptCallback; MSIFile: String; DLL: Boolean
  ): Boolean;
var
  {$IFDEF WINDOWS}
  SYSTEMINFO: TSYSTEMINFO;
  rdi: TRegDataInfo;
  {$ENDIF}
  tif: TINIFile;
  ui32_1, ui32_2: UINT32;
  hifl, hiflSec: THandle;
  List7ZipError, List7ZipOutput: String;
  List7ZipFiles: TStringList;
  idI, idIX: Integer;
  idS, idSX: String;
  i: Integer;
  varTempStr: String;
  s, sX, sY, sZ, sZR: String;
  p, pX: PChar;
  i641: Int64;
  i1, i2, i3, i4, i5: Integer;
  i164, i264, i364, i464: Int64;
  h1: THandle;
  fs1: TFileStream;
  c1, c2: Cardinal;
  v1: Pointer;
  dw: DWORD;
  s1, s2, s3, s4, s5, s6: String;
  b, bX, bXX, b1, b2, bY, bZ: Boolean;
  SkipToElseOrEnd, SkipToEnd, ReEnding: Boolean;
  DeferSkipToEnd: Integer;
  WizardLoop, JustOutWizardLoop: Boolean;
  WizardDir, WizardCacheIndex: Integer;
  WizardHandles: TStringList;
  ActiveDesign: String;
  t, tX: TextFile;
  trS1, trS2, trS3, trS4, trS5: String;
  MajorHi1, MajorLo1, MinorHi1, MinorLo1, Major1, Minor1: LongWord;
  MajorHi2, MajorLo2, MinorHi2, MinorLo2, Major2, Minor2: LongWord;
  memPhysical, memPaging, memVirtual: Int64;
  X, Y: Integer;
  Colors: Int64;
  Bits: Integer;
  vMax, vMin, vSP: Integer;
  mbEnc, mbLocal, mbServer, mbPort, mbUser, mbPass: String;
  mbURL: THashedStringList;
  mbResume: Boolean;
  
  inText: TextFile; outText: TStringList; activeText: String;
  ParseLeft, ParseRight, ParseSource, ParseSeek: String;
  ParsePoint, ParseFloat, ParseJump, ParseSkip: Integer;
  TrackProgress: Boolean;
  LastProgressText: String;
  LastProgressSmartPos: Integer;
  RenameDirPath: String;
  DeferUnbindName, DeferUnbindNameForHideDialog: String;
  Header: String;
  ResultEx: String;
  l, lX: TStringList;
  trf: TReplaceFlags;
  FreeSpaceAvailable, TotalSpace: Int64;
  Wide1, Wide2, Wide3, Wide4, Wide5, Wide6, Wide7, Wide8, Wide9, Wide10, Wide11, Wide12, Wide13, Wide14: String;
  {$IFNDEF WINDOWS}
  m: TMode; 
  mX: TStat;
  {$ELSE}
  usr, usr1, usr2, usr3, usr4: String;
  acc: Boolean;
  per: TPermissions;
  sec: TSuccessorSecurityObject;
  {$ENDIF}
  Wide4Int: Integer;
  tfs: TFormatSettings;
  ws1, ws2, ws3: WideString;
  OldDir: String;
  FormedIISVirtDirPath: String;
  ReadAllFile: Boolean;
  TypesI: String;
  ForceDirExList: TStringList;
  gacQualified: String;
  gacName, gacVersion, gacToken, gacQra, gacQraEx: String;
  gacP:PChar;
  gacI: Integer;
  gacL: TStringList;
  gacWinDir, gacWinDirEx: String;
  sV, sVX: String;
  iV: Integer;
  lV: TStringList;
  bV: array of Byte;
  Version7: String;
  Major7, Minor7: Integer;
  tickStart: DWORD;
  MustRestoreNativeLogs: Boolean;
  cSysRes, cSysResEx: Cardinal;
  cSysResEy: Integer;
  rMediaEx: Integer;
  cusl, cuslex, cusley: TStringList;
  x64Strap: String;
  ssv1, ssv2, ssv3, ssv4, ssv5: String;
  hSec: THandle;
  lfar: TStringList;
  stackStringList: TStringList;
  partext:string;
  BOM: Char;
  lpv: PWideChar;
  dpEngine, dpState: String;
  {$IFDEF WINDOWS}
  lpVersionInformation: TOSVersionInfo;
  {$ENDIF}
  
  {$IFDEF WINDOWS}
  r, rX: TRegistry;
  {$ENDIF}

  TargetComputer,
  workdir,
  taskapp,Params :widestring;
  starttime:WideString;
  DaysOfTheWeek:system.word;
  intearctive,RunOnlyIfLoggedOn,RunIfConnectedToInternet:boolean ;
  accUser, AccPass:WideString;

  ddConn, ddCmd, ddRS: OleVariant;
  ddCount: Integer;
  bRem: Boolean;

  u1mess, u2mess, u3mess, u4mess, u5mess, u6mess, u7mess,
  u8mess, u9mess, u10mess, u11mess: Boolean;

  lfs: TStringList;
  ifs: Integer;
  sfs: String;

  re: TRegExpr;

procedure ParameterCacheAddEx(Item: String); 
begin
  ParameterCache.Add(MultiLineToSingleLine(Item));
end;

procedure ExitScript(PlaySound: Boolean);
begin
  if AnsiCompareText(RuntimeSubstituteCompilerVariables('#SINGLEINSTANCE#'), 'TRUE') = 0 then
  
    DeleteFile(PChar(CachedTempDir + RevisionGUID + '.miax'));
  if activeText <> '' then
  begin
    try
      CloseFile(inText);
    except
    end;
    activeText := '';
  end;
  FinalizeDlgApi;
  mbURL.Free;
  WizardHandles.Free;
  ParameterCache.Free;
  
  {$IFDEF BACKIDE}
  if PlaySound then
    MyPlaySound(PChar(EXEDIR + 'audio' + PathDelim + 'process_stopped.wav')); 
  {$ENDIF}
end;

procedure InitializationBootStrap(CorruptionOverride: Boolean = false); 
var
  i1: Integer;
  s1, s2, s3, s4: String;
  
  s, sX, sPX: String;
  i: Integer;
  l: TStringList;
  DelayLoadOldData: Boolean;
  bAviv: Boolean;
  BOM: Char;
begin
  DelayLoadOldData := false;
  if MyFileExists(AssertDir(ExtractFilePath(MyParamStr(0))) + 'instance.dat') then
  begin
    
    AssignFile(t, AssertDir(ExtractFilePath(MyParamStr(0))) + 'instance.dat',cp_utf8);
    Reset(t);
    if not eof(t) then
    begin
      read(t, BOM);
      if ansicomparetext(BOM, #$FEFF) <> 0 then
      begin
        closefile(t);
        reset(t);
      end;
    end;
    ReadLn(t, ProductGUID);
    ReadLn(t, RevisionGUID);
    ReadLn(t, CachedTitle);
    CloseFile(t);
    
  end;
  SureSetVariable('PRODUCTCODE', ProductGUID, 'Bootstrap'); 
  SureSetVariable('REVISIONCODE', RevisionGUID, 'Bootstrap'); 
  CachedTargetDir := SniffSafeTargetDir;
  CachedTargetDir := CachedTargetDir + CachedTitle + DirectorySeparator;
  s1 := SniffSafeUserPath(RecommendAllUserState);
  s1 := s1 + RevisionGUID + DirectorySeparator;
  s2 := AssertDir(ExtractFilePath(MSIFile)) + ExtractFileNameOnly(MSIFile);
  SureSetVariable('UNINSTALLLINK', 
    {$IFDEF INTEROP}
    {$IFDEF DARWIN}
    s1 + ExtractFileNameOnly(MSIFile) + '.app' , 'Bootstrap'); 
    {$ELSE}
    s1 + ExtractFileName(MyParamStr(0)), 'Bootstrap'); 
    {$ENDIF}
    {$ELSE}
    {$IFDEF DARWIN}
    s1 + ExtractFileName(s2) + '.app', 'Bootstrap'); 
    {$ELSE}
    s1 + ExtractFileName(s2){$IFDEF WINDOWS}+ '.exe'{$ENDIF}, 'Bootstrap'); 
    {$ENDIF}
    {$ENDIF}
  SureSetVariable('ENGINECACHE', s1, 'Bootstrap');
  {$IFNDEF INTEROP}
  if not ProjectStruct.BuildInFolder then
    CachedDataDir := AssertDir(ProjectStruct.BuildCustomFolder)
  else
  begin
    if CurrentProjectName = '' then
      CachedDataDir := EXEDIR
    else
      CachedDataDir := PROJDIR;
  end;
  CachedDataDir := CachedDataDir + 'Release' + DirectorySeparator; 
  if
   ProjectStruct.BuildLayout = 0 then
    CachedDataDir := CachedDataDir + 'Uncompressed' + DirectorySeparator; 
  if ProjectStruct.BuildLayout = 1 then
    CachedDataDir := CachedDataDir + 'Single' + DirectorySeparator; 
  if ProjectStruct.BuildLayout = 2 then
    CachedDataDir := CachedDataDir + 'Web' + DirectorySeparator; 
  {$IFDEF DARWIN}
  CachedDataDir := CachedDataDir + ExtractFileNameOnly(MSIFile) + '.app/Contents/' + Ventura +  '/';
  {$ENDIF}
  CachedDataDir := CachedDataDir + 'data' + DirectorySeparator; 
  SuperCachedDataDirBackup := CachedDataDir;
  {$ENDIF}
  CachedPlugRootDir := CachedDataDir;
  
  if (MediaLayout = 2) then
  begin
    
    SuperCachedDataDir := SuperCachedDataDirBackup;
    
    CachedDataDir := SniffSafeUserPath(RecommendAllUserState);
    
    CachedDataDir := CachedDataDir + RevisionGUID + PathDelim;
    CachedPlugRootDir := CachedDataDir;
  end;
  SureSetVariable('DATADIR', CachedDataDir, 'Bootstrap'); 
  
  try
    if NativeMsiQueryProductState(ProductGUID) = INSTALLSTATE_DEFAULT then
    try
      
      VarTempStr := 'FALSE'; 
        
    except
      VarTempStr := 'FALSE'; 
    end
    else
      VarTempStr := 'FALSE'; 
  except
    VarTempStr := 'FALSE'; 
  end;
  
  SureSetVariable('NEEDSUPGRADE', VarTempStr, 'Bootstrap'); 
  
  try
    if IsVarDefined('NEEDSUPGRADE') then 
    begin
      if not MyStrToBool(GetVariable('NEEDSUPGRADE'), True) then 
      begin
        VarTempStr := MyBoolToStr(NativeMsiQueryProductState(ProductGUID)
          = INSTALLSTATE_DEFAULT, True);
      end
      else
      begin
        VarTempStr := 'FALSE'; 
        
        if AnsiCompareText(RuntimeSubstituteCompilerVariables('#LOADOLDDATA#'), 'TRUE') = 0 then
        
        begin
          DelayLoadOldData := True;
          
        end;
      end;
    end
    else
    begin
      
      VarTempStr := MyBoolToStr(NativeMsiQueryProductState(ProductGUID)
        = INSTALLSTATE_DEFAULT, True);
    end;
  except
    VarTempStr := 'FALSE'; 
  end;
  if CorruptionOverride then
  begin
    VarTempStr := 'FALSE';
    
  end;

  SureSetVariable('MAINTENANCE', VarTempStr, 'Bootstrap'); 
  InstalledSize := 0;
  if StrToBool(GetVariable('MAINTENANCE')) then 
  begin
    
    s1 := SniffSafeUserPath(GetAllUserInstallState(MSIFile));
    
    s1 := s1 + RevisionGUID + PathDelim;
    {$IFDEF DARWIN}
    s1 := s1 + ExtractFileNameOnly(MSIFile) + '.app/Contents/' + Ventura +  '/';
    {$ENDIF}
    s1 := s1 + ExtractFileNameOnly(MSIFile) + '.dat'; 
    LoadComponents(s1, false);
    
    if Components.Count <> Selections.Count then
    begin
      InitializationBootStrap(True);
      Exit;
    end;
    
    for i1 := 1 to Components.Count do
      if StrToBool(Selections[i1 -1]) then
        if not GetComponentDelete(Components[i1 -1]) then
          InstalledSize := InstalledSize + GetComponentRequiredSpace(Components[i1 -1]);
    
    s1 := SniffSafeUserPath(GetAllUserInstallState(MSIFile));
    
    s1 := s1 + RevisionGUID + PathDelim;
    {$IFDEF DARWIN}
    s1 := s1 + ExtractFileNameOnly(MSIFile) + '.app/Contents/' + Ventura +  '/';
    {$ENDIF}
    s3 := s1 + ExtractFileNameOnly(MSIFile){$IFDEF WINDOWS} + '.lnk'{$ENDIF}{$IFDEF LINUX} + '.desktop'{$ENDIF}; 
    s1 := s1 + ExtractFileNameOnly(MSIFile) + '.par'; 
    
    if MyFileExists(s1) then
    begin
      ParameterCache.LoadFromFile(s1, TEncoding.UTF8);
      
    end;
  end
  else
  begin
    ClearComponents;
    AddComponent('MYAH-PREDEF-COMPONENT', '', True); 
    InstalledSize := 0;
    ParameterCache.Clear;
    
    SureSetVariable('TARGETDIR', CachedTargetDir, 'Bootstrap'); 
    SureSetVariable('STARTMENU', CachedTitle, 'Bootstrap'); 
    SureSetVariable('ALLUSERS', MyBoolToStr(RecommendAllUserState, True), 'Bootstrap'); 
    
    s1 := SniffSafeUserPath(GetAllUserInstallState(MSIFile));
    
    s1 := s1 + RevisionGUID + DirectorySeparator;
    s1 := s1 + ExtractFileNameOnly(MSIFile) + '.dat'; 
    
    if not CorruptionOverride then 
      LoadComponents(s1, false);
  end;
  if DelayLoadOldData or True then 
  begin
    s := '';
    s4 := '';
    sX := '';
    
    try
      
      sX := IncludeTrailingPathDelimiter(MyGetAppConfigDir(True)) + 'MimarSinan' + PathDelim + 'InstallAware' + PathDelim + 'Ident.Cache' + PathDelim + ProductGUID;
      if MyFileExists(sX) then
      begin
        FileMode := 0;
        AssignFile(t, sX);
        Reset(t);
        ReadLn(t, s);
        CloseFile(t);
        bAviv := True;
      end
      else
        bAviv := false;
      
      if (not DirectoryExists(s)) then
        bAviv := false;
      sPX := '';
      
      sX := IncludeTrailingPathDelimiter(MyGetAppConfigDir(false)) + 'MimarSinan' + PathDelim + 'InstallAware' + PathDelim + 'Ident.Cache' + PathDelim + ProductGUID;
      if MyFileExists(sX) then
      begin
        FileMode := 0;
        AssignFile(t, sX);
        Reset(t);
        ReadLn(t, sPX);
        CloseFile(t);
      end;
      if (not NativeLogTestPath(s + ProductGUID)) and NativeLogTestPath(sPX + ProductGUID) then
        bAviv := false;
      if not bAviv then
        s := sPX;
      
    except
      s := '';
    end;
    sX := '';
    
    SureSetVariable('NATIVE_OLDLOG', '', 'Bootstrap'); 
    
    if s <> '' then
      
      if NativeLogTestPath(s + {$IFDEF DARWIN}
        GetBundleNameEz(s, ExtractFileNameOnly(MSIFileForNative)) + '.app/Contents/' + Ventura +  '/' +{$ENDIF}ProductGUID) then
        if ExtractFileName(DeAssertDir(s)) <> RevisionGUID then
          SureSetVariable('NATIVE_OLDLOG', s + {$IFDEF DARWIN}
              GetBundleNameEz(s, ExtractFileNameOnly(MSIFileForNative)) + '.app/Contents/' + Ventura +  '/' +{$ENDIF}ProductGUID, 'Bootstrap');
      
      if DirectoryExists(s) then
      begin
        
        {$IFDEF INTEROP}
        l := FindAllFilesEx(s + '*.dat', false);
        {$ELSE}
        l := FindAllFilesEx(s + '*.dat', false);
        {$ENDIF}
        for i := l.Count downto 1 do 
          if AnsiCompareText(ExtractFileName(l[i -1]), 'instance.dat') = 0 then
            l.Delete(i -1);
        if l.Count = 1 then 
          s := l[0]
        else
          for i := 1 to l.Count do 
            if MyFileExists(s + {$IFDEF DARWIN}'miaxstub'{$ELSE}ExtractFileNameOnly(l[i -1]){$IFDEF WINDOWS}+ '.exe'{$ENDIF}{$ENDIF}) then
              if MyFileExists(s + {$IFDEF DARWIN}'miaxstub'{$ELSE}ExtractFileNameOnly(l[i -1]){$ENDIF} + '.res') then
                if MyFileExists(s + ExtractFileNameOnly(l[i -1]) + '.par') then
                begin
                  if MyFileExists(s + ExtractFileNameOnly(l[i -1]){$IFDEF WINDOWS} + '.lnk'{$ENDIF}{$IFDEF LINUX} + '.desktop'{$ENDIF}) then
                    s4 := s + ExtractFileNameOnly(l[i -1]){$IFDEF WINDOWS} + '.lnk'{$ENDIF}{$IFDEF LINUX} + '.desktop'{$ENDIF};
                  s := l[i -1];
                  Break;
                end;
        l.Free;
        
        if DirectoryExists(s) then
          s := '';
        
        if DelayLoadOldData then 
        begin
          
          LoadComponents(s, false, True);
        end
        else
          sX := s; 
        
      end;
  end;
  
  if GetVariable('NATIVE_OLDLOG') <> '' then
  begin
    SureSetVariable('RECOMMENDEDUPGRADE', 'TRUE', 'Bootstrap'); 
    
    if AnsiCompareText(RuntimeSubstituteCompilerVariables('#LOADOLDDATA#'), 'TRUE') = 0 then
      if sX <> '' then
        LoadComponents(sX, false, True);
  end
  else
    SureSetVariable('RECOMMENDEDUPGRADE', 'FALSE', 'Bootstrap');
  
  SureSetVariable('NEWINSTANCE', 'FALSE', 'Initialization'); 
  if not MyFileExists(AssertDir(ExtractFilePath(MyParamStr(0))) + 'instance.dat') then
  begin
    
    if StrToBool(GetVariable('MAINTENANCE')) then 
      SureSetVariable('NEWINSTANCE', 'TRUE', 'Initialization'); 
    if StrToBool(GetVariable('NEEDSUPGRADE')) then 
      SureSetVariable('NEWINSTANCE', 'TRUE', 'Initialization'); 
  end;
  
end;

function ForceDirectoriesEx(Dir: String; CreatedList: TStrings): Boolean;
var
  E: EInOutError;
begin
  Result := True;
  if Dir = '' then
  begin
    E := EInOutError.Create('SCannotCreateDir');
    E.ErrorCode := 3;
    raise E;
  end;
  Dir := ExcludeTrailingPathDelimiter(Dir);
  if (Length(Dir) < 3) or DirectoryExists(Dir)
    or (ExtractFilePath(Dir) = Dir) then Exit; 
  Result := ForceDirectoriesEx(ExtractFilePath(Dir), CreatedList) and CreateDir(Dir);
  if Result then
    CreatedList.Add(Dir);
end;

function GetNextNumber(var From: String): Integer;
begin
  if From = '' then
  begin
    Result := 0;
    Exit;
  end;
  if AnsiPos('.', From) = 0 then
  begin
    try
      Result := StrToInt(From);
    except
      Result := 0;
    end;
    From := '';
    Exit;
  end;
  Result := StrToInt(Copy(From, 1, AnsiPos('.', From) -1));
  System.Delete(From, 1, AnsiPos('.', From));
end;

function CompareStringVersion(Compare, _With: String): Boolean;
var
  MajorHi1, MajorLo1, MinorHi1, MinorLo1: Integer;
  MajorHi2, MajorLo2, MinorHi2, MinorLo2: Integer;
begin
  MajorHi1 := GetNextNumber(Compare);
  MajorLo1 := GetNextNumber(Compare);
  MinorHi1 := GetNextNumber(Compare);
  MinorLo1 := GetNextNumber(Compare);
  MajorHi2 := GetNextNumber(_With);
  MajorLo2 := GetNextNumber(_With);
  MinorHi2 := GetNextNumber(_With);
  MinorLo2 := GetNextNumber(_With);
  Result := True;
  if MajorHi1 < MajorHi2 then Result := false
    else if MajorHi1 = MajorHi2 then
    begin
      if MajorLo1 < MajorLo2 then Result := false
        else if MajorLo1 = MajorLo2 then
        begin
          if MinorHi1 < MinorHi2 then Result := false
            else if MinorHi1 = MinorHi2 then
              if MinorLo1 <= MinorLo2 then Result := false;
        end;
    end;
end;

procedure ProcessLoop(Enter: Boolean; NoAppend: Boolean = false; NoDelete: Boolean = false);
var
  iMotion, iAppend, iCounter: Integer;
  sKeyword: String;
begin
  iAppend := 0; 
  if TypesI = 'Break' then
  begin
    
    if LastLoopStack[LastLoopStack.Count -1] = 'While' then
      sKeyword := 'Wend'
    else
      if LastLoopStack[LastLoopStack.Count -1] = 'Repeat' then
        sKeyword := 'Until'
      else
        if LastLoopStack[LastLoopStack.Count -1] = 'For Each' then
          sKeyword := 'Next';
    iMotion := 1;
    iAppend := 1;
  end
  else
  if TypesI = 'Continue' then
  begin
    if LastLoopStack[LastLoopStack.Count -1] = 'While' then
      sKeyword := 'While'
    else
      if LastLoopStack[LastLoopStack.Count -1] = 'Repeat' then
        sKeyword := 'Repeat'
      else
        if LastLoopStack[LastLoopStack.Count -1] = 'For Each' then
          sKeyword := 'For Each';
    iMotion := -1;
    iAppend := 0; 
  end
  else
  if (TypesI = 'While') and Enter then
  begin
    
    Exit;
  end
  else
  if (TypesI = 'While') and not Enter then
  begin
    iMotion := 1; 
    sKeyword := 'Wend';
    if not NoAppend then
      iAppend := 1;
  end
  else
  if (TypesI = 'Until') and not Enter then
  begin
    
    Exit;
  end
  else
  if (TypesI = 'Until') and Enter then 
  
  begin
    iMotion := -1;
    sKeyword := 'Repeat';
    
    if not NoDelete then 
      LastLoopStack.Delete(LastLoopStack.Count -1);
    
  end
  else
  if TypesI = 'Wend' then
  begin
    iMotion := -1;
    sKeyword := 'While';
  end
  else
  if (TypesI = 'Repeat') and Enter then
  begin
    
    Exit;
  end
  else
  if (TypesI = 'Repeat') and not Enter then 
  begin
    iMotion := 1;
    sKeyword := 'Until';
    if not NoAppend then
      iAppend := 1;
  end
  else
  if (TypesI = 'For Each') and Enter then
  begin
    
    Exit;
  end
  else
  if (TypesI = 'For Each') and not Enter then
  begin
    iMotion := 1; 
    sKeyword := 'Next';
    if not NoAppend then
      iAppend := 1;
  end
  else
  if TypesI = 'Next' then
  begin
    iMotion := -1;
    sKeyword := 'For Each';
  end;
  iCounter := 0;
  repeat
    i := i + iMotion;
    TypesI := Types[i -1];
    if ((Comments <> nil) and (Comments[i -1] = 'C')) then Continue; 
    if TypesI = sKeyword then
    begin
      
      Break;
    end
    else
    if (((TypesI = 'Repeat') or (TypesI = 'While')) or (TypesI = 'For Each')) and (iMotion > 0) then
    begin
      ProcessLoop(false, True); 
      i := i +1; 
      TypesI := Types[i -1];
    end
    else
    if (((TypesI = 'Wend') or (TypesI = 'Until')) or (TypesI = 'Next')) and (iMotion < 0) then
    begin
      
      ProcessLoop(True, false, True); 
      i := i +1; 
      TypesI := Types[i -1];
    end;
    iCounter := iCounter +1;
    if iCounter = 313 then
    begin
      
      {$IFNDEF NOGUI}
      Application.ProcessMessages;
      {$ENDIF}
      iCounter := 0;
    end;
  until false; 
  
  i := i + iAppend -1;
  if i <> 0 then 
    TypesI := Types[i -1]; 
end;

function NativeEngineDelay: Boolean;
begin
  
  RESULT:=False;
  {$IFDEF USEVARMANAGER}
  Result := AnsiCompareText(VarManager['DELAYUNTIL_APPLYCHANGES'], 'TRUE') = 0;
  {$ELSE}
  Result := AnsiCompareText(GETVARIABLE('DELAYUNTIL_APPLYCHANGES'), 'TRUE') = 0;
  {$ENDIF}
  
end;

function DoNativeProcessing: Boolean;
var
  b, bX: Boolean;
begin
  
  if (not NativeEngineDelay) or (TypesI = 'File Bag') then
  begin
    b := false;
    if TypesI = 'Install Files' then b := True;
    if TypesI = 'Install Assembly' then b := True;
    if TypesI = 'Install Service' then b := True;
    if TypesI = 'Install ODBC Driver' then b := True;
    if TypesI = 'File Bag' then b := True;
    if b then
    begin
      if not Assigned(thSpoolerThread) then
      begin
        bX := ThreadFreeNativeGrabSource; 
      end
      else
        bX := thSpoolerThread.NativeGrabSource;
      if not bX then
      begin
        Result := false;
        Exit; 
      end;
    end;
  end;
  if TypesI = 'File Bag' then Exit; 
  
  if not SpoolNativeAction(TypesI, Derefs, References, i, NativeEngineDelay{$IFDEF DARWIN}, MSIFile{$ENDIF}) then
    Result := false
  else
    Result := True;
  
  if Result = false then
    if NativeRollback then
    begin
      
      SpoolNativeAction('ROLLBACK', nil, nil, 0);
      
    end;
  
end;

function CommitNativeDelayed: Boolean;
begin
  if not SpoolNativeAction('DELAYEDINSTALL', Derefs, References, 0{$IFDEF DARWIN}, false, MSIFile{$ENDIF}) then
    Result := false
  else
    Result := True;
  if Result = false then
    if NativeRollback then
      SpoolNativeAction('ROLLBACK', nil, nil, 0);
end;

procedure DoRefreshShell;
{$IFDEF LINUX}
var
  l: TStringList;
{$ENDIF}
begin
  {$IFDEF WINDOWS}
  ShChangeNotify(SHCNE_ASSOCCHANGED, SHCNF_IDLIST, nil, nil);
  {$ENDIF}
  {$IFDEF LINUX}
  l := TStringList.Create;
  if StrToBool(GetVariable('ALLUSERS')) then
  begin
    LaunchAppAndWait('update-mime-database', '/usr/share/mime', false, True);
    LaunchAppAndWait('update-desktop-database', '/usr/share/applications', false, True);
    
    l.Add('-f');
    l.Add('/usr/share/icons/hicolor');
    LaunchAppAndWait2('gtk-update-icon-cache', l, false, True);
    l.Clear;
  end;
  LaunchAppAndWait('update-mime-database', ExpandFileName('~/.local/share/mime'), false, True);
  LaunchAppAndWait('update-desktop-database', ExpandFileName('~/.local/share/applications'), false, True);
  
  l.Add('-f'); 
  l.Add('-t'); 
  l.Add(ExpandFileName('~/.local/share/icons/hicolor'));
  LaunchAppAndWait2('gtk-update-icon-cache', l, false, True);
  l.Free;
  {$ENDIF}
  {$IFDEF DARWIN}
  
  LaunchAppAndWait('/System/Library/Frameworks/CoreServices.framework/Versions/A/Frameworks/LaunchServices.framework/Versions/A/Support/lsregister',
    '-R "' + GetVariable('ENGINECACHE') + '"', false, True);
  {$ENDIF}
end;

begin
  Result := True;
  LastLoopStack.Clear;
  ForEachStack.Clear;
  MSIFileForNative := MSIFile;
  WriteToLog('    <Variables>');
  LastOverriddenCache := '';
  Grab_Media_Rebuf_State := '';
  dpEngine := '';
  dpState := '';
  mbURL := THashedStringList.Create;
  UninstalledFromMaintenanceState := false;
  AnApplyInstallWasCalled := false;
  
  SpawnFileCopyEx := '';
  x64Mode := 'Win32'; 
  DeferUnbindName := '';
  DeferUnbindNameForHideDialog := '';
  activeText := '';
  ParameterCache := TStringList.Create;
  
  TrackProgress := True;
  LastProgressText := '';
  LastProgressSmartPos := 0;
  {$IFDEF INTEROP}
  RootFolder := ExtractFilePath(MyParamStr(0));
  
  {$ELSE}
  RootFolder := PROJDIR;
  
  CachedDataDirEx := '';

  InitializeDlgApi(PChar(RootFolder), True);
  {$IFDEF DARWIN}
  TouchList.Clear;
  {$ENDIF}

  ProductGUID := ProjectStruct.Code;
  RevisionGUID := ProjectStruct.Revision;
  CachedTitle := ProjectStruct.Name;
  CachedTitleOrgLang := CachedTitle; 
  
  carPublisher := ProjectStruct.Manufacturer; 
  carContact := ProjectStruct.arContact;
  carHelp := ProjectStruct.arHelp;
  carUpdates := ProjectStruct.arUpdates;
  carComments := ProjectStruct.arComments;
  MediaLayout := ProjectStruct.BuildLayout;
  CachedMultiLang := ProjectStruct.MultiLang;
  CachedDefaultLanguage := ProjectStruct.Language;
  CachedDefaultLanguageEx := CachedDefaultLanguage;
  CachedLanguageCompilerVariableValueEx := RuntimeSubstituteCompilerVariables('#LOCALIZATION_PRECEDENCE#');
  
  ProjectStructVersion := ProjectStruct.Version;
  {$ENDIF}
  MinExtract := (AnsiCompareText(RuntimeSubstituteCompilerVariables('#MIN_EXTRACT#'), 'AUTO') = 0) and
    MyFileExists(SFXFileName);
  MinExtracted := not MinExtract;

  mbServer := '';
  mbPort := '';
  mbResume := True;
  
  PGUIDEX := ProductGUID; 
  WriteToLog('    </Variables>');
  WriteToLog('    <CompileScript>');
  if CompileScript(Types, References, Comments, Derefs, s) <> -1 then
  begin
    
    {$IFDEF INTEROP}
    
    {$ENDIF}
    Exit;
  end;
  WriteToLog('    </CompileScript>');
  
  ClearVariables;
  ClearComponents;
{$IFDEF USEVARMANAGER}
  VarManager.Add('MYAH_thProgress', '0');
  VarManager.Add('MYAH_thMax', '100');
  VarManager.Add('MYAH_thMin', '0');
  VarManager.Add('MYAH_thProgressText', '');
  VarManager.Add('MYAH_thFinished', 'FALSE');
  VarManager.Add('MYAH_thCancelled', 'FALSE');
  VarManager.Add('MYAH_IsCancelled', 'FALSE');
  VarManager.Add('MYAH_LastDelegateTick', IntToStr(GetTickCount));
  VarManager.Add('MYAH_LastActiveTick', IntToStr(GetTickCount));
{$ELSE}
  SURESETVARIABLE('MYAH_thProgress', '0','');
  SURESETVARIABLE('MYAH_thMax', '100','');
  SURESETVARIABLE('MYAH_thMin', '0','');
  SURESETVARIABLE('MYAH_thProgressText', '','');
  SURESETVARIABLE('MYAH_thFinished', 'FALSE','');
  SURESETVARIABLE('MYAH_thCancelled', 'FALSE','');
  SURESETVARIABLE('MYAH_IsCancelled', 'FALSE','');
  SURESETVARIABLE('MYAH_LastDelegateTick', IntToStr(GetTickCount),'');
  SURESETVARIABLE('MYAH_LastActiveTick', IntToStr(GetTickCount),'');
{$ENDIF}
  
  SureSetVariable('TARGETDIR', CachedTargetDir, 'Pre-Initialization'); 
  SureSetVariable('STARTMENU', CachedTitle, 'Pre-Initialization'); 
  SureSetVariable('ALLUSERS', MyBoolToStr(RecommendAllUserState, True), 'Pre-Initialization'); 
  WriteToLog('    <BootStrap>');
  InitializationBootStrap;
  WriteToLog('    </BootStrap>');
  RootFolder := AssertDir(RootFolder);
  WizardHandles := TStringList.Create;
  DeferSkipToEnd := 0;
  SkipToEnd := false;
  SkipToElseOrEnd := false;
  ReEnding := false;
  WizardLoop := false;
  JustOutWizardLoop := false;
  WizardDir := 0;
  WizardCacheIndex := 0;
  PrimaryWindowHandle := 0;
  
  Labels.Clear;
  for i := 1 to Types.Count do
    if Types[i -1] = 'Label' then 
    begin
      s := ReadOffset(Derefs, References[i -1], 1);
      Labels.Add(AnsiUpperCase(s));
      Labels.Add(IntToStr(i -1));
    end;
  
  {$IFNDEF INTEROP}
  
  CachedTempDir := MyGetTempPathEx;
  {$ENDIF}
  if AnsiCompareText(RuntimeSubstituteCompilerVariables('#SINGLEINSTANCE#'), 'TRUE') = 0 then
  
  begin
    
    if MyFileExists(CachedTempDir + RevisionGUID + '.miax') then
    begin
      SingleDanger := True;
      if DLL then
        Result := false;
      Exit;
    end;
    
    try
      AssignFile(tX, CachedTempDir + RevisionGUID + '.miax',cp_utf8);
      ReWrite(tX);
      CloseFile(tX);
    except
    end;
  end;
  WriteToLog('    <myah>');
  try
    i := 0;
    AddComponent('MYAH-PREDEF-COMPONENT', '', True); 
    
    SureSetVariable('MYAH_TIMEOUT', '10', 'Initialization'); 
    SureSetVariable('MYAH_COMPRESS_INSTALLER_CACHE', 'FALSE', 'Initialization'); 
    SureSetVariable('MYAH_DISABLE_ROLLBACK', 'FALSE', 'Initialization'); 
    SureSetVariable('MYAH_DISABLE_VISTA_RESTART_MANAGER', 'FALSE', 'Initialization'); 
    
    {$IFNDEF INTEROP}
    SilentInstall := false;
    
    {$ENDIF}
    SureSetVariable('CHARSET_OVERRIDE', '', 'Initialization'); 
    
    if not IsVarDefined('NATIVE_ENGINE') then 
      SureSetVariable('NATIVE_ENGINE', 'TRUE', 'Initialization'); 
    SureSetVariable('NATIVE_LOGGING', '', 'Initialization'); 
    SureSetVariable('NATIVE_ROLLBACK', 'TRUE', 'Initialization'); 
    SureSetVariable('NATIVE_HARDLINK', 'TRUE', 'Initialization'); 
    SureSetVariable('NATIVE_ERROR', 'PROMPT', 'Initialization'); 
    SureSetVariable('NATIVE_OVERWRITE', 'PROMPT', 'Initialization'); 
    SureSetVariable('NATIVE_OVERWRITE_OLDER', 'FALSE', 'Initialization'); 
    SureSetVariable('NATIVE_PROGRESS', '0', 'Initialization'); 
    SureSetVariable('DELAYUNTIL_APPLYCHANGES', 'FALSE', 'Initialization'); 
    SureSetVariable('NATIVE_OVERRIDE_PERMISSIONS', 'FALSE', 'Initialization'); 
    SureSetVariable('NATIVE_OVERRIDE_NON_RESTORABLE_PERMISSIONS', 'FALSE', 'Initialization'); 
    
    SureSetVariable('IISHOST', 'localhost', 'Initialization'); 
    if not IsVarDefined('OVERRIDECACHE') then 
      SureSetVariable('OVERRIDECACHE', '', 'Initialization'); 
    SureSetVariable('MYAHLOGO', '', 'Initialization'); 
    SureSetVariable('SELECTED', '0', 'Initialization'); 
    SureSetVariable('WINDOWHANDLE', '0', 'Initialization'); 
    SureSetVariable('EXEFILE', {$IFDEF DARWIN}StringReplace({$ENDIF}MyParamStr(0)
      {$IFDEF DARWIN}, '/' + Ventura +  '/miaxstub', '/MacOS/miaxstub', [rfReplaceAll, rfIgnoreCase]){$ENDIF}, 'Initialization'); 
    
    SureSetVariable('EXEDIR', AssertDir(ExtractFilePath({$IFDEF DARWIN}StringReplace({$ENDIF}MyParamStr(0)
      {$IFDEF DARWIN}, '/' + Ventura +  '/miaxstub', '/MacOS/miaxstub', [rfReplaceAll, rfIgnoreCase]){$ENDIF})), 'Initialization');
    
    SureSetVariable('PROGRESSTEXT', '', 'Initialization'); 
    SureSetVariable('PROGRESSMODE', '', 'Initialization'); 
    SureSetVariable('CUSTOM_TASKBAR_PROGRESS_ENABLED', 'FALSE', 'Initialization'); 
    SureSetVariable('CUSTOM_TASKBAR_PROGRESS_PERCENT', '0', 'Initialization'); 
    SureSetVariable('CUSTOM_TASKBAR_PROGRESS_MAX', '100', 'Initialization'); 
    SureSetVariable('ABORT', 'FALSE', 'Initialization'); 
    SureSetVariable('PROGRESS', '0', 'Initialization'); 
    SureSetVariable('LASTERROR', '', 'Initialization'); 
    SureSetVariable('LICENSE', 'FALSE', 'Initialization'); 
    SureSetVariable('USERNAME', s1, 'Initialization'); 
    SureSetVariable('USERCOMPANY', s2, 'Initialization'); 
    SureSetVariable('COPYWEBLOCK', '', 'Initialization'); 
    SureSetVariable('REBOOTCOMPUTER', 'FALSE', 'Initialization'); 
    {$IFDEF LINUX}
    SureSetVariable('APPEXTENSION', '', 'Initialization'); 
    SureSetVariable('BINEXTENSION', '', 'Initialization'); 
    SureSetVariable('IMGEXTENSION', '.png', 'Initialization'); 
    {$ELSE}
    {$IFDEF WINDOWS}
    SureSetVariable('APPEXTENSION', '.exe', 'Initialization'); 
    SureSetVariable('BINEXTENSION', '.exe', 'Initialization'); 
    SureSetVariable('IMGEXTENSION', '.ico', 'Initialization'); 
    {$ELSE}
    SureSetVariable('APPEXTENSION', '.app', 'Initialization'); 
    SureSetVariable('BINEXTENSION', '', 'Initialization'); 
    SureSetVariable('IMGEXTENSION', '.icns', 'Initialization'); 
    {$ENDIF}
    {$ENDIF}
    {$IFDEF LINUX}
    SureSetVariable('DOWNEXTENSION', '', 'Initialization'); 
    {$ELSE}
    {$IFDEF WINDOWS}
    SureSetVariable('DOWNEXTENSION', '.exe', 'Initialization'); 
    {$ELSE}
    SureSetVariable('DOWNEXTENSION', '.dmg', 'Initialization'); 
    {$ENDIF}
    {$ENDIF}
    SureSetVariable('RUNAPP', 'TRUE', 'Initialization'); 
    SureSetVariable('WIZARD', 'NEXT', 'Initialization'); 
    SureSetVariable('FX', 'SLIDE', 'Initialization'); 
    SureSetVariable('FXGROUND', 'BACKGROUND', 'Initialization'); 
    SureSetVariable('FXTIME', '1000', 'Initialization'); 
    SureSetVariable('VERSION',  ProjectStructVersion, 'Initialization'); 
    SureSetVariable('SILENT', MyBoolToStr(SilentInstall, True), 'Initialization'); 
    SureSetVariable('LOGGED', LoggedInstall, 'Initialization'); 
    SureSetVariable('CMDLINE', CommandLine, 'Initialization'); 
    SureSetVariable('REBOOTNOW', 'OK', 'Initialization'); 
    SureSetVariable('SFXPATH', AssertDir(ExtractFilePath(SFXFileName)), 'Initialization');
    SureSetVariable('SFXFILE', ExtractFileName(SFXFileName), 'Initialization'); 
    
    if GetVariable('GPOPATH') <> '' then 
      SureSetVariable('SETUPPATH', '$GPOPATH$', 'Initialization')
    else
      if GetVariable('SFXPATH') <> '' then 
        SureSetVariable('SETUPPATH', '$SFXPATH$', 'Initialization')
      else
        SureSetVariable('SETUPPATH', '$EXEDIR$', 'Initialization');
    SureSetVariable('COMPLETE', 'TRUE', 'Initialization'); 
    
    SureSetVariable('NEWLINE', MyLineEnding, 'Initialization'); 
    SureSetVariable('MINIMUM', 'FALSE', 'Initialization'); 
    SureSetVariable('PERSONALIZED', 'FALSE', 'Initialization'); 
    SureSetVariable('MODIFY', 'TRUE', 'Initialization'); 
    
    SureSetVariable('ISNT', 'TRUE', 'Initialization'); 
    
    SureSetVariable('GLASS', 'FALSE', 'Initialization'); 
    SureSetVariable('REPAIR', 'FALSE', 'Initialization'); 
    
    SureSetVariable('REMOVE', 'FALSE', 'Initialization'); 
    SureSetVariable('ROOTDIR', RootFolder, 'Initialization'); 
    SureSetVariable('TITLE', CachedTitle, 'Initialization'); 
    SureSetVariable('COMPANY', carPublisher, 'Initialization'); 
    SureSetVariable('ADVERTISE', 'FALSE', 'Initialization'); 
    SureSetVariable('DATE', DateToStr(SysUtils.Date), 'Initialization'); 
    SureSetVariable('TIME', TimeToStr(Time), 'Initialization'); 
    SureSetVariable('TEMPDIR', CachedTempDir, 'Initialization'); 
    {$IFDEF NOGUI}
    SureSetVariable('NOGUI', 'TRUE', 'Initialization'); 
    {$ELSE}
    SureSetVariable('NOGUI', 'FALSE', 'Initialization'); 
    {$ENDIF}
    {$IFDEF DARWIN}
    {$IFDEF CPUAARCH64}
    SureSetVariable('PLATFORMFULL', 'MACOSARM', 'Initialization'); 
    {$ELSE}
    SureSetVariable('PLATFORMFULL', 'MACOS', 'Initialization'); 
    {$ENDIF}
    SureSetVariable('PLATFORM', 'MACOS', 'Initialization'); 
    {$ENDIF}
    {$IFDEF LINUX}
    {$IFDEF CPUAARCH64}
    {$IFDEF LCLQT5}
    SureSetVariable('PLATFORMFULL', 'LINUXARMQT5', 'Initialization'); 
    {$ELSE}
    SureSetVariable('PLATFORMFULL', 'LINUXARM', 'Initialization'); 
    {$ENDIF}
    {$ELSE}
    {$IFDEF LCLQT5}
    SureSetVariable('PLATFORMFULL', 'LINUXQT5', 'Initialization'); 
    {$ELSE}
    SureSetVariable('PLATFORMFULL', 'LINUX', 'Initialization'); 
    {$ENDIF}
    {$ENDIF}
    SureSetVariable('PLATFORM', 'LINUX', 'Initialization'); 
    {$ENDIF}
    {$IFDEF WINDOWS}
    SureSetVariable('PLATFORMFULL', 'WINDOWS', 'Initialization'); 
    SureSetVariable('PLATFORM', 'WINDOWS', 'Initialization'); 
    {$ENDIF}
    SureSetVariable('ABORTONERROR', 'TRUE', 'Initialization');
    SureSetVariable('ABORTEDONERROR', 'FALSE', 'Initialization');
    SureSetVariable('SAVEDATA', 'FALSE', 'Initialization');
    {$IFNDEF INTEROP}
    CachedSupportDir := PROJDIR;
    {$ENDIF}
    SureSetVariable('SUPPORTDIR', CachedSupportDir, 'Initialization'); 
    SureSetVariable('MSIFILE', MSIFile, 'Initialization'); 
    SureSetVariable('IAX_VERSION', '2.1', 'Initialization'); 
    
    AllowMissHeader := True;
    
    for i1 := 1 to References.Count do
    begin
      Header := GetCommandHeaderEx(Types, References, Derefs, i1 -1);
      if Header <> '' then
      begin
        CacheSetMSIPropertyEx('A' + HEADER, 'FALSE'); 
        ParameterCacheAddEx('A' + HEADER);
        ParameterCacheAddEx('FALSE'); 
      end;
    end;

    AllowMissHeader := false;
    ActivatedLanguage := ''; 
    LastActivatedLanguage := 'ZILCH'; 
    SureSetVariable('LANGUAGE', '', 'Initialization'); 

    if MyFileExists(CachedSupportDir + CachedTitleOrgLang + '.mtx') then 
    begin
      l := FindAllFilesEx(CachedSupportDir + 'translations.*', false); 
      for i1 := l.Count downto 1 do
        if (AnsiCompareText(l[i1 -1], CachedSupportDir + 'translations.Map') = 0) or
          (AnsiCompareText(l[i1 -1], CachedSupportDir + 'translations.Original') = 0) then 
            l.Delete(i1 -1)
        else if AnsiPos('shared', l[i1 -1]) <> 0 then 
          l.Delete(i1 -1)
          else if AnsiCompareText(l[i1 -1], CachedSupportDir + 'translations.' + CachedDefaultLanguage) = 0 then 
            ActivatedLanguage := CachedDefaultLanguage;
      
      if l.Count <> 0 then
      begin
        
        if CachedMultiLang and
          ((not StrToBool(GetVariable('MAINTENANCE'))) and not
          (MyFileExists(AssertDir(ExtractFilePath(MSIFile)) + ExtractFileNameOnly(MSIFile) + '.msp'))) then 
        begin
          {$IFNDEF NOGUI}
          SetLanguage := TSetLanguage.Create(nil);
          SetLanguage.LangCombo.Items.Clear;
          for i1 := 1 to l.Count do
            SetLanguage.LangCombo.Items.Add(ExtractFileExtOnly(l[i1 -1]));
          SetLanguage.LangCombo.Sorted := True;
          i2 := 1; 
          for i1 := 1 to SetLanguage.LangCombo.Items.Count do
          begin
            if CompareText(SetLanguage.LangCombo.Items[i1 -1], CachedDefaultLanguage) = 0 then
              i2 := i1; 
            if CompareText(SetLanguage.LangCombo.Items[i1 -1],
              
              CodeToLang(CompilerVariableBasedGetLanguageCode(CachedLanguageCompilerVariableValueEx))) = 0 then 
            begin
              SetLanguage.LangCombo.ItemIndex := i1 -1;
              Break;
            end
            else 
            if i1 = SetLanguage.LangCombo.Items.Count then
              SetLanguage.LangCombo.ItemIndex := i2 -1;
          end;
          if not SilentInstall then
            if SetLanguage.ShowModal = mrCancel then
            begin
              SetLanguage.Free;
              ExitScript(True);
              Exit;
            end;
          
          ActivatedLanguage := SetLanguage.LangCombo.Items[SetLanguage.LangCombo.ItemIndex];
          
          SetLanguage.Free;
          {$ELSE}
          for i1 := 1 to l.Count do
            WriteLn(IntToStr(i1) + '. ' + ExtractFileExtOnly(l[i1 -1]));
          
          for i1 := 1 to l.Count do
          begin
            if CompareText(ExtractFileExtOnly(l[i1 -1]), CachedDefaultLanguage) = 0 then
              i2 := i1 -1; 
            if CompareText(ExtractFileExtOnly(l[i1 -1]),
              
              CodeToLang(CompilerVariableBasedGetLanguageCode(CachedLanguageCompilerVariableValueEx))) = 0 then 
            begin
              i2 := i1 -1;
              Break;
            end;
          end;
          WriteLn('(' + ExtractFileExtOnly(l[i2]) + ')');
          repeat
            ReadLn(s1);
            if s1 = '' then
              s1 := ExtractFileExtOnly(l[i2])
            else
            begin
              
              i3 := StrToIntDef(s1, 0);
              if (i3 >= 1) and (i3 <= l.Count) then
                s1 := ExtractFileExtOnly(l[i3 -1])
              else
                s1 := '';
            end;
          until s1 <> '';
          
          ActivatedLanguage := s1;
          WriteLn('[' + s1 + ']'); 
          {$ENDIF}
        end;
        
        if StrToBool(GetVariable('MAINTENANCE')) or 
          (MyFileExists(AssertDir(ExtractFilePath(MSIFile)) + ExtractFileNameOnly(MSIFile) + '.msp')) then 
        begin
          s1 := SniffSafeUserPath(GetAllUserInstallState(MSIFile));
          if MediaLayout = 3 then
            s1 := s1 + RevisionGUIDforPatchEx + PathDelim 
          else
            s1 := s1 + RevisionGUID + PathDelim; 
          {$IFDEF DARWIN}
          s1 := s1 + ExtractFileName(MSIFile) + '.app/Contents/' + Ventura;
          {$ENDIF}
          s1 := s1 + ExtractFileNameOnly(MSIFile) + '.lan'; 
          if MyFileExists(s1) then
          begin
            AssignFile(t, s1,cp_utf8);
            Reset(t);
            if not eof(t) then
            begin
              read(t, BOM);
              if ansicomparetext(BOM, #$FEFF) <> 0 then
              begin
                closefile(t);
                reset(t);
              end;
            end;
            ReadLn(t, ActivatedLanguage);
            CloseFile(t);
          end;
        end;
        SureSetVariable('LANGUAGE', ActivatedLanguage, 'Initialization'); 
        
        l.Free;
      end;
    end;
    
    for i1 := 1 to OverrideVars.Count do
      if ((i1 -1) mod 2) = 0 then
      begin
        if IsVarDefined(AnsiUpperCase(OverrideVars[i1 -1])) then
          SetVariable(AnsiUpperCase(OverrideVars[i1 -1]), OverrideVars[i1], 'Inject Override Command Line') 
        else
          SureSetVariable(AnsiUpperCase(OverrideVars[i1 -1]), OverrideVars[i1], 'Inject Override Command Line'); 
      end;
    
    for i1 := 1 to OverrideVarsEx.Count do
      if ((i1 -1) mod 2) = 0 then
      begin
        if IsVarDefined(AnsiUpperCase(OverrideVarsEx[i1 -1])) then
          SetVariable(AnsiUpperCase(OverrideVarsEx[i1 -1]), OverrideVarsEx[i1], 'Inject Override Command Line Ex') 
        else
          SureSetVariable(AnsiUpperCase(OverrideVarsEx[i1 -1]), OverrideVarsEx[i1], 'Inject Override Command Line Ex'); 
      end;
    
    tickStart := GetTickCount;
    idIX := 0;
    while i < Types.Count do
    begin
      if GetTickCount - tickStart > 314 then
      begin
        {$IFNDEF NOGUI}
        Application.ProcessMessages;
        {$ENDIF}
        tickStart := GetTickCount;
      end;
      
      LoggedInstall := GetVariable('LOGGED'); 
      
      SilentInstall := StrToBool(GetVariable('SILENT')); 
      
      TitleEy := GetVariable('TITLE'); 
      NoBrand := AnsiCompareText(GetVariable('MYAHLOGO'), 'TRUE') = 0; 
      
      if GetVariable('OVERRIDECACHE') <> '' then
        if LastOverriddenCache <> GetVariable('OVERRIDECACHE') then
        begin
          ForceDirExList := TStringList.Create;
          
          if ForceDirectoriesEx(AssertDir(GetVariable('OVERRIDECACHE')), ForceDirExList) then
          begin
            SetVariable('OVERRIDECACHE', AssertDir(GetVariable('OVERRIDECACHE')), 'Inject Override Command Line'); 
            InitializationBootstrap;
            LastOverriddenCache := GetVariable('OVERRIDECACHE');
            
            for i1 := ForceDirExList.Count downto 1 do
              RemoveDirectory(PChar(ForceDirExList[i1 -1]));
          end
          else
          begin
            SetVariable('OVERRIDECACHE', '', 'Failed Cache Override');
            LastOverriddenCache := '';
          end;
          ForceDirExList.Free;
        end;
      
      SureSetVariable('DATE', DateToStr(SysUtils.Date), 'Initialization'); 
      SureSetVariable('TIME', TimeToStr(Time), 'Initialization'); 
      try
        ActivatedLanguage := GetVariable('LANGUAGE'); 
        if ActivatedLanguage <> '' then
          if ActivatedLanguage <> LastActivatedLanguage then
          begin
            LastActivatedLanguage := ActivatedLanguage;
            lMap.LoadFromFile(CachedSupportDir + 'translations.Map', TEncoding.UTF8); 
            for i1 := 1 to lMap.Count do
            begin
              lMap[i1 -1] := StringReplace(lMap[i1 -1], '.dfm', '', [rfReplaceAll, rfIgnoreCase]);
              lMap[i1 -1] := StringReplace(lMap[i1 -1], '.lfm', '', [rfReplaceAll, rfIgnoreCase]);
            end;
            lLang.LoadFromFile(CachedSupportDir + 'translations.' + ActivatedLanguage, TEncoding.UTF8); 
            lOrg.LoadFromFile(CachedSupportDir + 'translations.Original', TEncoding.UTF8);
            lIndex.LoadFromFile(CachedSupportDir + CachedTitleOrgLang + '.mtx', TEncoding.UTF8); 
            if MyFileExists(CachedSupportDir + 'shared.translations.' + ActivatedLanguage) then 
              InitializeLocalizations(CachedSupportDir + 'shared.translations.' + ActivatedLanguage); 
          end;
      except
        ActivatedLanguage := ''; 
      end;
      SureSetVariable('LANGUAGE', ActivatedLanguage, 'Initialization'); 
      s1 := SniffSafeUserPath(StrToBool(GetVariable('ALLUSERS'))); 
      
      s1 := s1 + RevisionGUID + DirectorySeparator;
      s2 := AssertDir(ExtractFilePath(MSIFile)) + ExtractFileNameOnly(MSIFile);
      SureSetVariable('UNINSTALLLINK', 
        {$IFDEF INTEROP}
        {$IFDEF DARWIN}
        s1 + ExtractFileNameOnly(MSIFile) + '.app', 'Bootstrap'); 
        {$ELSE}
        s1 + ExtractFileName(MyParamStr(0)), 'Initialization'); 
        {$ENDIF}
        {$ELSE}
        {$IFDEF DARWIN}
        s1 + ExtractFileName(s2) + '.app', 'Initialization'); 
        {$ELSE}
        s1 + ExtractFileName(s2){$IFDEF WINDOWS} + '.exe'{$ENDIF}, 'Initialization'); 
        {$ENDIF}
        {$ENDIF}
      SureSetVariable('ENGINECACHE', s1, 'Initialization'); 
      
      if SkipToElseOrEnd then
      begin
        i1 := 0;
        repeat
          i := i +1;
          TypesI := Types[i -1];
          b := false;
          if (TypesI = 'If') or (TypesI = 'Wizard Loop') then 
            if (Comments[i -1] <> 'C') and (TypesI <> 'Ignore') then 
            begin
              i1 := i1 +1;
              b := True;
            end;
          if (TypesI = 'End') then 
            if (Comments[i -1] <> 'C') and (TypesI <> 'Ignore') then 
            begin
              i1 := i1 -1;
              if i1 >= 0 then
                b := True;
            end;
        until (((((TypesI = 'Else') or (TypesI = 'Else If')) 
          or (TypesI = 'End')) and ((i1 <= 0) and not b)) 
          and ((Comments = nil) or (Comments[i -1] <> 'C')))
          and (TypesI <> 'Ignore'); 
        SkipToElseOrEnd := false;
        if TypesI = 'Else If' then 
        begin
          if not SkipToEnd then
          begin
            i := i -1; 
            TypesI := Types[i -1];
            DeferSkipToEnd := DeferSkipToEnd -1;
          end;
        end
        else
        if TypesI = 'End' then 
        begin
          i := i -1; 
          TypesI := Types[i -1];
          ReEnding := True;
        end;
      end;
      if SkipToEnd then
      begin
        i1 := 0;
        repeat
          i := i +1;
          TypesI := Types[i -1];
          b := false;
          if (TypesI = 'If') or (TypesI = 'Wizard Loop') then 
            if (Comments[i -1] <> 'C') and (TypesI <> 'Ignore') then 
            begin
              i1 := i1 +1;
              b := True;
            end;
          if (TypesI = 'End') then 
            if (Comments[i -1] <> 'C') and (TypesI <> 'Ignore') then 
            begin
              i1 := i1 -1;
              if i1 >= 0 then
                b := True;
            end;
        until ((((TypesI = 'End') and (i1 <= 0)) and not b) 
          and ((Comments = nil) or (Comments[i -1] <> 'C')))
          and (TypesI <> 'Ignore'); 
        SkipToEnd := false;
        i := i -1; 
        TypesI := Types[i -1];
        ReEnding := True;
      end;
      
      idS := GetUnitName(IncludeDepthDirect[i ], True); 
      
      idI := GetLineNumber(IncludeDepthDirect[i ]); 
      if idIX <> idI then
      begin
        if idIX < idI then
        begin
          
          idStack.Add(LastLoopStack.CommaText);
          idStack.Add(ForEachStack.CommaText);
          idStack.Add(IntToStr(DeferSkipToEnd));
          idStack.Add(MyBoolToStr(SkipToEnd, True));
          idStack.Add(MyBoolToStr(SkipToElseOrEnd, True));
          idStack.Add(MyBoolToStr(ReEnding, True));
          idStack.Add(MyBoolToStr(WizardLoop, True));
          idStack.Add(MyBoolToStr(JustOutWizardLoop, True));
        end
        else
        begin
          
          JustOutWizardLoop := StrToBool(idStack[idStack.Count -1]);
          idStack.Delete(idStack.Count -1);
          WizardLoop := StrToBool(idStack[idStack.Count -1]);
          idStack.Delete(idStack.Count -1);
          ReEnding := StrToBool(idStack[idStack.Count -1]);
          idStack.Delete(idStack.Count -1);
          SkipToElseOrEnd := StrToBool(idStack[idStack.Count -1]);
          idStack.Delete(idStack.Count -1);
          SkipToEnd := StrToBool(idStack[idStack.Count -1]);
          idStack.Delete(idStack.Count -1);
          DeferSkipToEnd := StrToInt(idStack[idStack.Count -1]);
          idStack.Delete(idStack.Count -1);
          ForEachStack.CommaText := idStack[idStack.Count -1];
          idStack.Delete(idStack.Count -1);
          LastLoopStack.CommaText := idStack[idStack.Count -1];
          idStack.Delete(idStack.Count -1);
        end;
        idIX := idI;
      end;
      
      if not WizardLoop then
      repeat
        i := i +1;
        TypesI := Types[i -1];
      until (i >= Types.Count) or (((Comments = nil) or (Comments[i -1] <> 'C')) and (TypesI <> 'Ignore')) 
      else
      begin
        
        WizardCacheIndex := WizardCacheIndex + WizardDir;
        if WizardCacheIndex = 0 then
          WizardCacheIndex := 1;
        if WizardCacheIndex > WizardHandles.Count then
          WizardCacheIndex := WizardHandles.Count;
        
        if WizardDir = 1 then i1 := +1
          else if WizardDir = -1 then i1 := -1
            else
            begin
              repeat
                i := i +1;
                TypesI := Types[i -1];
              until ((TypesI = 'End') 
                and ((Comments = nil) or (Comments[i -1] <> 'C')))
                and (TypesI <> 'Ignore'); 
              WizardLoop := false;
              JustOutWizardLoop := True;
              i := i -1;
              TypesI := Types[i -1];
              Continue;
            end;
        repeat
          i := i + i1;
          TypesI := Types[i -1];
        until (((TypesI = 'Display Dialog') or 
          ((TypesI = 'Wizard Loop') or (TypesI = 'End'))) 
          and ((Comments = nil) or (Comments[i -1] <> 'C')))
          and (TypesI <> 'Ignore');; 
        if ((TypesI = 'End') 
          and ((Comments = nil) or (Comments[i -1] <> 'C')))
          and (TypesI <> 'Ignore') then 
        begin
          WizardLoop := false;
          JustOutWizardLoop := True;
          i := i -1;
          TypesI := Types[i -1];
          Continue;
        end;
        if (TypesI = 'Wizard Loop') 
          and (((Comments = nil) or (Comments[i -1] <> 'C')) and (TypesI <> 'Ignore')) then 
        begin
          
          repeat
            i := i +1;
            TypesI := Types[i -1];
          until ((TypesI = 'End') 
            and ((Comments = nil) or (Comments[i -1] <> 'C')))
            and (TypesI <> 'Ignore'); 
          WizardLoop := false;
          JustOutWizardLoop := True;
          i := i -1;
          TypesI := Types[i -1];
          Continue;
        end;
      end;
      
      if i > Types.Count then Break;
      if Comments[i -1] = 'C' then Continue; 
      if StrToBool(GetVariable('MYAH_IsCancelled'))  then
        SetVariable('ABORT', 'TRUE', 'Cancel State') 
      else
        SetVariable('ABORT', 'FALSE', 'Cancel State'); 
      
      {$IFDEF MACOS}
      if PrimaryWindowHandle <> 0 then
      begin
        DelegateBindProgress(GetVariable('PROGRESSTEXT'),  
          StrToInt(GetVariable('PROGRESS')), 100, 0);
        
        {$IFNDEF DARWIN} 
        CustomCoolWait(nil);
        {$ENDIF}
      end;
      {$ENDIF} 
      
      if Assigned(Callback) then
        if not Callback(i) then
        begin
          ExitScript(True);
          Exit;
        end;
      
      if TypesI = 'Install Files' then 
      begin
      {$region}
        Header := GetCommandHeaderEx(Types, References, Derefs, i -1);
        if NativeEngineMode then
        begin
          courtesyDataStack.Clear; 
          courtesyDataStack.Add(Header); 
        end
        else
        begin
          Lines[i -1] := 'TRUE'; 
          CacheSetMSIPropertyEx('A' + HEADER, 'TRUE'); 
          ParameterCacheAddEx('A' + HEADER);
          ParameterCacheAddEx('TRUE'); 
        end;
        
        if (MediaLayout = 2) and (Webs[i -1] <> '') then
        try
          if not StrToBool(GetVariable('ABORTEDONERROR')) then
            GrabMedia(Webs[i -1], mbURL, mbLocal, mbEnc, mbServer, mbPort, mbUser, mbPass, mbResume, dpEngine, dpState);
        except
          on E: Exception do
          begin
            if not SilentInstall then
            begin
              
              MyMessageBox({$IFNDEF WINDOWS}0{$ELSE}PrimaryWindowHandle{$ENDIF}, PChar(E.Message), PChar(BrandEx),
                mb_Ok + mb_IconStop);
              
            end;
            if StrToBool(GetVariable('ABORTONERROR')) then
            begin
              CheckDoNativeRollback;
              Break;
            end
            else
              SetVariable('ABORTEDONERROR', 'TRUE', 'Weblock Abort');
          end;
        end;
        if NativeEngineMode then
        begin
          if not DoNativeProcessing then
            Break
          else
            Continue;
        end;
        s1 := SubstituteVariables(ReadOffset(Derefs, References[i -1], 3));
        CacheSetMSIPropertyEx('P' + HEADER + '_1', 
          ElimDoubles(s1));
        ParameterCacheAddEx('P' + HEADER + '_1'); 
        ParameterCacheAddEx(ElimDoubles(s1));
        Continue;
        {$endregion}
      end;
      if TypesI = 'Create Link' then 
      begin
      {$region}
        courtesyDataStack.Clear; 
        s1 := SubstituteVariables(ReadOffset(Derefs, References[i -1], 1));
        courtesyDataStack.Add(ElimDoubles(s1));
        if NativeEngineMode then
        begin
          if not DoNativeProcessing then
            Break
          else
            Continue;
        end;
        Continue;
        {$endregion}
      end;
      if TypesI = 'Create File Type' then 
      begin
      {$region}
        
        courtesyDataStack.Clear; 
        
        WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 1), Wide1, Wide2);
        if Wide2 = '' then Wide2 := 'FALSE'; 
        WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 2), Wide3, Wide4);
        if Wide4 = '' then Wide4 := 'FALSE'; 
        WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 3), Wide5, Wide6);
        if Wide6 = '' then Wide6 := 'TRUE'; 
        WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 4), Wide7, Wide8);
        if Wide8 = '' then Wide8 := 'FALSE'; 
        WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 5), Wide9, Wide10);
        if Wide10 = '' then Wide10 := 'FALSE'; 
        
        trS1 := Wide1;
        trS2 := Wide5;
        if ActivatedLanguage <> '' then
        begin
          trS1 := GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1);
          WidenColonDelimParam(trS1, trS1, Wide11);
          trS1 := SubstituteVariables(trS1);
          trS2 := GetTransForScrItem(trS2, ReadOffset(Derefs, References[i -1], 0), 2);
          WidenColonDelimParam(trS2, trS2, Wide12);
          trS2 := SubstituteVariables(trS2);
          
        end
        else
        begin
          trS1 := SubstituteVariables(trS1);
          trS2 := SubstituteVariables(trS2);
        end;
        courtesyDataStack.Add(ElimDoubles(trS1)); 
        s1 := SubstituteVariables(Wide3);
        courtesyDataStack.Add(ElimDoubles(s1)); 
        
        courtesyDataStack.Add(ElimDoubles(trS2)); 
        s1 := SubstituteVariables(Wide7);
        courtesyDataStack.Add(ElimDoubles(s1)); 
        s1 := SubstituteVariables(Wide9);
        courtesyDataStack.Add(ElimDoubles(s1)); 
        if NativeEngineMode then
        begin
          courtesyDataStack.Add(Wide2);
          courtesyDataStack.Add(Wide4);
          courtesyDataStack.Add(Wide6);
          courtesyDataStack.Add(Wide8);
          courtesyDataStack.Add(Wide10);
          if not DoNativeProcessing then
            Break;
        end;
        Continue;
        {$endregion}
      end;
      if TypesI = 'Create Folder' then 
      begin
      {$region}
        if NativeEngineMode then
        begin
          if not DoNativeProcessing then
            Break
          else
            Continue;
        end;
        Continue;
        {$endregion}
      end
      else
      if (TypesI = 'Create Shortcut') or (TypesI = 'Advertised Shortcut') then 
      begin
      {$region}
        courtesyDataStack.Clear; 
        
        trS1 := ReadOffset(Derefs, References[i -1], 2);
        trS2 := ReadOffset(Derefs, References[i -1], 4);
        if ActivatedLanguage <> '' then
        begin
          trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1));
          trS2 := SubstituteVariables(GetTransForScrItem(trS2, ReadOffset(Derefs, References[i -1], 0), 2));
        end
        else
        begin
          trS1 := SubstituteVariables(trS1);
          trS2 := SubstituteVariables(trS2);
        end;
        WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 1), Wide11, Wide12);
        if Wide12 = '' then
          Wide12 := 'FALSE';
        WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 3), Wide13, Wide14);
        if Wide14 = '' then
          Wide14 := 'FALSE';
        WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 6), Wide9, Wide10);
        if Wide10 = '' then
          Wide10 := 'FALSE';
        WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 7), Wide7, Wide8);
        if Wide8 = '' then
          Wide8 := 'FALSE';
        WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 8), Wide5, Wide6);
        WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 9), Wide1, Wide2);
        
        courtesyDataStack.Add(trS1); 
        courtesyDataStack.Add(trS2); 
        
        s1 := SubstituteVariables(Wide13);
        courtesyDataStack.Add(ElimDoubles(s1));
        
        s1 := SubstituteVariables(Wide11);
        courtesyDataStack.Add(ElimDoubles(s1)); 
        
        s1 := SubstituteVariables(ReadOffset(Derefs, References[i -1], 5));
        courtesyDataStack.Add(ElimDoubles(s1)); 
        
        s1 := Wide9;
        courtesyDataStack.Add(ElimDoubles(s1)); 
        if NativeEngineMode then
          if not DoNativeProcessing then
            Break;
        Continue;
        {$endregion}
      end;
      if TypesI = 'Set Access Control' then 
      begin
      {$region}
        try
          if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 12))) then
            Enter64BitFileSystem;
          if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 14))) then
            Enter64BitRegistry;
          
          trS1 := ReadOffset(Derefs, References[i -1], 1);
          trS2 := ReadOffset(Derefs, References[i -1], 6);
          if ActivatedLanguage <> '' then
          begin
            trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1));
            trS2 := SubstituteVariables(GetTransForScrItem(trS2, ReadOffset(Derefs, References[i -1], 0), 2));
          end
          else
          begin
            trS1 := SubstituteVariables(trS1);
            trS2 := SubstituteVariables(trS2);
          end;
          {$IFNDEF WINDOWS}
          if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 12))) then
          begin 
            WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 8), Wide11, Wide12);
            if Wide12 = '' then
              Wide12 := 'FALSE';
            m := 0; 
            if (StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 9))) or
             StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 10)))) then
             fpStat(trS1, mX); 
            if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 11))) then
              mX.st_mode := 0; 
            begin 
              if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 2))) then
              begin 
                if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 7))) then
                  
                  m := m or S_IROTH;
                if StrToBool(ElimDoubles(Wide11)) then
                  
                  m := m or S_IWOTH;
                if StrToBool(ElimDoubles(Wide12)) then
                  
                  m := m or S_IXOTH;
              end;
              if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 3))) then
              begin 
                if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 7))) then
                  
                  m := m or S_IRUSR;
                if StrToBool(ElimDoubles(Wide11)) then
                  
                  m := m or S_IWUSR;
                if StrToBool(ElimDoubles(Wide12)) then
                  
                  m := m or S_IXUSR;
              end;
              if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 4))) then
              begin 
                if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 7))) then
                  
                  m := m or S_IRGRP;
                if StrToBool(ElimDoubles(Wide11)) then
                  
                  m := m or S_IWGRP;
                if StrToBool(ElimDoubles(Wide12)) then
                  
                  m := m or S_IXGRP;
              end;
              if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 9))) then
                fpChMod(trS1, m or mX.st_mode); 
              if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 10))) then
                fpChMod(trS1, ((not m) and mX.st_mode)); 
              if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 11))) then
                fpChMod(trS1, m); 
            end;
          end;
          {$ENDIF}
          {$IFDEF WINDOWS}
          
          acc := false;
          sec := nil;
          try
            if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 12))) then
            begin
              if DirectoryExists(trS1) then
              begin
                sec := TDirecotrySecurityObject.Create(ElimDoubles(trS1));
                acc := True;
              end
              else
                sec := TFileSecurityObject.Create(ElimDoubles(trS1));
            end;
            if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 13))) then
            begin
              sec := TShareSecurityObject.Create(ElimDoubles(trS1));
              acc := True;
            end;
            if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 14))) then
            begin
              if false then
              begin
                sZR := ElimDoubles(trS1);
                rX := TRegistry.Create;
                if AnsiPos('HKCR\', sZR) = 1 then
                begin
                  rX.RootKey := HKEY_CLASSES_ROOT;
                  System.Delete(sZR, 1, Length('HKCR\'));
                end
                else
                if AnsiPos('HKCU\', sZR) = 1 then
                begin
                  rX.RootKey := HKEY_CURRENT_USER;
                  System.Delete(sZR, 1, Length('HKCU\'));
                end
                else
                if AnsiPos('HKLM\', sZR) = 1 then
                begin
                  rX.RootKey := HKEY_LOCAL_MACHINE;
                  System.Delete(sZR, 1, Length('HKLM\'));
                end
                else
                if AnsiPos('HKU\', sZR) = 1 then
                begin
                  rX.RootKey := HKEY_USERS;
                  System.Delete(sZR, 1, Length('HKU\'));
                end
                else
                if AnsiPos('HKCC\', sZR) = 1 then
                begin
                  rX.RootKey := HKEY_CURRENT_CONFIG;
                  System.Delete(sZR, 1, Length('HKCC\'));
                end
                else
                begin
                  rX.Free;
                  Continue;
                end;
                rX.Access := KEY_READ or KEY_WRITE or REG_ACCESS_CONST;
                if rX.OpenKey(sZR, false) then
                begin
                end
                else
                begin
                  rX.Free;
                  Continue;
                end;
              end;
              if REG_ACCESS_CONST = $100 then
                sec := TRegistryWow64Key64SecurityObject.Create(ValidateRegistryName(ElimDoubles(trS1)))
              else
                sec := TRegistrySecurityObject.Create(ValidateRegistryName(ElimDoubles(trS1)));
              acc := True;
            end;
            if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 15))) then
              sec := TServiceSecurityObject.Create(ElimDoubles(trS1));
            if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 16))) then
              sec := TPrinterSecurityObject.Create(ElimDoubles(trS1));
          except
            
            sec := nil;
          end;
          if not Assigned(sec) then Continue; 
          usr1 := '';
          usr2 := '';
          usr3 := '';
          usr4 := '';
          
          if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 9))) then
          begin
            per := [];
            
            usr := '';
            if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 2))) then
            begin
              
              try
                usr := GetWorldSidName;
              except
                usr := '';
              end;
            end;
            if usr <> '' then
              usr1 := usr;
            
            usr := '';
            if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 3))) then
            begin
              try
                usr := SysUtils.GetEnvironmentVariable('USERNAME');
              except
                usr := '';
              end;
            end;
            if usr <> '' then
              usr2 := usr;
            
            usr := '';
            if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 4))) then
            begin
              try
                usr := GetAuthenticatedUsersName;
              except
                usr := '';
              end;
            end;
            if usr <> '' then
              usr3 := usr;
            
            usr := '';
            if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 5))) then
            begin
              usr := ElimDoubles(trS2);
            end;
            if usr <> '' then
              usr4 := usr;
            if ((usr1 = '') and (usr2 = '')) and ((usr3 = '') and (usr4 = '')) then
            begin
              sec.Free;
              Continue;
            end;
            if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 7))) then
              per := per + [ptRead];
              
            if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 8))) then
              per := per + [ptWrite];
              
            if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 7))) and
              StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 8))) then
              
              per := [ptAll];
            try
              if usr1 <> '' then
              begin
                if acc then 
                  sec.SetAccess('', usr1, per, [], True, True, false, false)
                else
                  sec.SetAccess('', usr1, per, []);
                sec.Apply;
              end;
              if usr2 <> '' then
              begin
                if acc then 
                  sec.SetAccess('', usr2, per, [], True, True, false, false)
                else
                  sec.SetAccess('', usr2, per, []);
                sec.Apply;
              end;
              if usr3 <> '' then
              begin
                if acc then 
                  sec.SetAccess('', usr3, per, [], True, True, false, false)
                else
                  sec.SetAccess('', usr3, per, []);
                sec.Apply;
              end;
              if usr4 <> '' then
              begin
                if acc then 
                  sec.SetAccess('', usr4, per, [], True, True, false, false)
                else
                  sec.SetAccess('', usr4, per, []);
                sec.Apply;
              end;
            except
              
              sec.Free;
              sec := nil;
            end;
          end
          else
          
          if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 10))) then
          begin
            try
              sec.DeletePermissions;
              sec.Apply;
            except
              
              sec.Free;
              sec := nil;
            end;
          end
          else
          
          if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 11))) then
          begin
            try
              sec.GrantAccessAll('', GetWorldSidName);
              sec.Apply;
            except
              
              sec.Free;
              sec := nil;
            end;
          end;
          
          if not Assigned(sec) then Continue; 
          try
            
          except
            
          end;
          sec.Free;
          {$ENDIF}
          
          Continue;
        finally
          if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 14))) then
            Leave64BitRegistry;
          if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 12))) then
            Leave64BitFileSystem;
          
        end;
        {$endregion}
      end;
      if TypesI = 'Set Owner' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          
          trS1 := ReadOffset(Derefs, References[i -1], 1);
          trS2 := ReadOffset(Derefs, References[i -1], 5);
          if ActivatedLanguage <> '' then
          begin
            trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1));
            trS2 := SubstituteVariables(GetTransForScrItem(trS2, ReadOffset(Derefs, References[i -1], 0), 2));
          end
          else
          begin
            trS1 := SubstituteVariables(trS1);
            trS2 := SubstituteVariables(trS2);
          end;
          {$IFNDEF WINDOWS}
          if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 2))) then
            fpChOwn(trS1, fpGetUID, -1);
          if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 3))) then
            fpChOwn(trS1, 0, -1);
          if StrToBool(ElimDoubles(ReadOffset(Derefs, References[i -1], 4))) then
          begin
            fpChOwn(trS1, GetUserID(ElimDoubles(ReadOffset(Derefs, References[i -1], 5))), -1);
          end;
          {$ENDIF}
          {$IFDEF WINDOWS}
          
          {$ENDIF}
          
          Continue;
        finally
          Leave64BitFileSystem;
          
        end;
        {$endregion}
      end;
      if TypesI = 'Set Group' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          
          trS1 := ReadOffset(Derefs, References[i -1], 1);
          trS2 := ReadOffset(Derefs, References[i -1], 2);
          if ActivatedLanguage <> '' then
          begin
            trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1));
            trS2 := SubstituteVariables(GetTransForScrItem(trS2, ReadOffset(Derefs, References[i -1], 0), 2));
          end
          else
          begin
            trS1 := SubstituteVariables(trS1);
            trS2 := SubstituteVariables(trS2);
          end;
          {$IFNDEF WINDOWS}
          fpChOwn(trS1, -1, GetGroupID(ElimDoubles(ReadOffset(Derefs, References[i -1], 2))));
          {$ENDIF}
          {$IFDEF WINDOWS}
          
          {$ENDIF}
          
          Continue;
        finally
          Leave64BitFileSystem;
          
        end;
        {$endregion}
      end;
      {$IFDEF WINDOWS}
      if TypesI = 'Find All Registry' then 
      begin
      {$region}
        try
          Enter64BitRegistry;
          WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 1), Wide1, Wide2);
          s := Wide1;
          if not IsVarDefined(s) then
            SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
          case StrToInt(ReadOffset(Derefs, References[i -1], 2)) of
            0: i1 := Integer(HKEY_CLASSES_ROOT);
            1: i1 := Integer(HKEY_CURRENT_USER);
            2: i1 := Integer(HKEY_LOCAL_MACHINE);
            3: i1 := Integer(HKEY_USERS);
            4: i1 := Integer(HKEY_CURRENT_CONFIG);
          end;
          if not ((ReadOffset(Derefs, References[i -1], 2) = '2') or (ReadOffset(Derefs, References[i -1], 2) = '3')) then
            Wide2 := '';
          Wide2 := SubstituteVariables(Wide2);
          s1 := '';
          try
            r := TRegistry.Create;
            r.RootKey := HKEY(i1);
            bRem := True;
            if not ((r.RootKey = HKEY_LOCAL_MACHINE) or (r.RootKey = HKEY_USERS)) then
              Wide2 := '';
            Wide2 := SubstituteVariables(Wide2);
            if Wide2 <> '' then
              if AnsiPos('\\', Wide2) <> 1 then
                Wide2 := '\\' + Wide2;
            if Wide2 <> '' then
              if not r.RegistryConnect(Wide2) then 
                bRem := false;
            r.Access := KEY_READ or REG_ACCESS_CONST;
            if bRem and r.OpenKey(ElimDoubles(ReadOffset(Derefs, References[i -1], 3)), false) then
            begin
              lfar := TStringList.Create;
              if StrToBool(ReadOffset(Derefs, References[i -1], 4)) then
                r.GetKeyNames(lfar)
              else
                r.GetValueNames(lfar);
              r.CloseKey;
              for i2 := 1 to lfar.Count do
              begin
                s2 := lfar[i2 -1];
                if s2 = '' then
                  s2 := '(Default)';
                if i2 = 1 then
                  s1 := s2
                else
                  s1 := s1 + '$NEWLINE$' + s2;
              end;
              lfar.Free;
            end
            else
              s1 := ''; 
            r.Free;
          except
            s1 := ''; 
          end;
        finally
          Leave64BitRegistry;
        end;
        SetVariable(s, s1, TypesI + ' Action'); 
        Continue;
        {$endregion}
      end;
      if TypesI = 'Write Registry' then 
      begin
      {$region}
        if NativeEngineMode then
        begin
          if not DoNativeProcessing then
            Break
          else
            Continue;
        end;
        {$endregion}
      end;
      if (TypesI = 'Read Registry') or (TypesI = 'Check Registry') then 
      begin
      {$region}
        try
          WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 1),
            Wide1, Wide2);
          Enter64BitRegistry;
          s := Wide1;
          if not IsVarDefined(s) then
            SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
          case StrToInt(ReadOffset(Derefs, References[i -1], 2)) of
            0: i1 := Integer(HKEY_CLASSES_ROOT);
            1: i1 := Integer(HKEY_CURRENT_USER);
            2: i1 := Integer(HKEY_LOCAL_MACHINE);
            3: i1 := Integer(HKEY_USERS);
            4: i1 := Integer(HKEY_CURRENT_CONFIG);
          end;
          if not ((ReadOffset(Derefs, References[i -1], 2) = '2') or (ReadOffset(Derefs, References[i -1], 2) = '3')) then
            Wide2 := ''; 
          Wide2 := SubstituteVariables(Wide2);
          if Wide2 <> '' then
            if AnsiPos('\\', Wide2) <> 1 then
              Wide2 := '\\' + Wide2;
          s1 := '';
          try
            r := TRegistry.Create;
            r.RootKey := HKEY(i1);
            if Wide2 <> '' then
              bRem := r.RegistryConnect(Wide2)
            else
              bRem := True;
            if bRem then
            begin
              r.Access := KEY_READ or REG_ACCESS_CONST;
              if r.OpenKey(ElimDoubles(ReadOffset(Derefs, References[i -1], 3)), false) then
              begin
                if r.ValueExists(ElimDoubles(ReadOffset(Derefs, References[i -1], 4))) then
                begin
                  r.GetDataInfo(ElimDoubles(ReadOffset(Derefs, References[i -1], 4)), rdi);
                  case rdi.RegData of
                    rdString: s1 := r.ReadString(ElimDoubles(ReadOffset(Derefs, References[i -1], 4)));
                    rdExpandString: s1 := r.ReadString(ElimDoubles(ReadOffset(Derefs, References[i -1], 4)));
                    rdInteger: s1 := IntToStr(r.ReadInteger(ElimDoubles(ReadOffset(Derefs, References[i -1], 4))));
                    rdUnknown:
                      begin
                        if RegGetMultiString(i1, AssertDir(ElimDoubles(ReadOffset(Derefs, References[i -1], 3))) +
                          ElimDoubles(ReadOffset(Derefs, References[i -1], 4)), sV, Wide2) then
                        begin
                          if sV = '' then
                          begin
                            s1 := '';
                            
                          end
                          else
                          begin
                            lV := TStringList.Create;
                            iV := 1;
                            sVX := '';
                            while sV[iV] <> #0 do
                            begin
                              sVX := sVX + sV[iV];
                              iV := iV +1;
                              if sV[iV] = #0 then
                              begin
                                lV.Add(sVX);
                                sVX := '';
                                iV := iV +1;
                              end;
                            end;
                            s1 := '';
                            for iV := 1 to lV.Count do
                              if iV = lV.Count then
                                s1 := s1 + lV[iV -1]
                              else
                                s1 := s1 + lV[iV -1] + '$NEWLINE$';
                            
                            lV.Free;
                          end;
                        end
                        else
                          s1 := 'UNKNOWN$TYPE'; 
                      end;
                    rdBinary:
                      begin
                        RegGetBinary(i1, AssertDir(ElimDoubles(ReadOffset(Derefs, References[i -1], 3))) +
                          ElimDoubles(ReadOffset(Derefs, References[i -1], 4)), sV, Wide2);
                        SetLength(bV, Length(sV));
                        for iV := 1 to Length(sV) do
                          bV[iV -1] := Byte(sV[iV]);
                        sV := '';
                        for iV := 1 to Length(bV) do
                          sV := sV + IntToHex(bV[iV -1], 2);
                        s1 := sV;
                        
                      end;
                  end;
                end
                else
                  s1 := 'NO$VALUE'; 
                r.CloseKey;
              end
              else
                s1 := 'NO$KEY'; 
            end
            else
              s1 := 'NO$COMPUTER';
            r.Free;
          except
            s1 := 'READ$ERROR'; 
          end;
        finally
          Leave64BitRegistry;
        end;
        if TypesI = 'Read Registry' then 
        begin
          if s1 = 'READ$ERROR' then s1 := ''; 
          if s1 = 'NO$KEY' then s1 := ''; 
          if s1 = 'NO$VALUE' then s1 := ''; 
          if s1 = 'UNKNOWN$TYPE' then s1 := ''; 
          if s1 = 'BINARY$VALUE' then s1 := ''; 
          if s1 = 'NO$COMPUTER' then s1 := ''; 
        end;
        SetVariable(s, s1, TypesI + ' Action'); 
        Continue;
        {$endregion}
      end;
      if TypesI = 'Get System Settings' then 
      begin
      {$region}
        try
          u1mess := false;
          u2mess := false;
          u3mess := false;
          u4mess := false;
          u5mess := false;
          u6mess := false;
          u7mess := false;
          u8mess := false;
          u9mess := false;
          u10mess := false;
          u11mess := false;
          Enter64BitRegistry;
          Enter64BitFileSystem;
          s := ReadOffset(Derefs, References[i -1], 1);
          if not IsVarDefined(s) then
            SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
          
          case StrToInt(ReadOffset(Derefs, References[i -1], 2)) of
           118: begin
                  s1 := '';
                  r := TRegistry.Create;
                  r.RootKey := HKEY_LOCAL_MACHINE;
                  if Is64Bit then
                    r.Access := KEY_READ or $100 
                  else
                    r.Access := KEY_READ;
                  if r.OpenKeyReadOnly('SOFTWARE\Microsoft\Cryptography') then
                  begin
                    try
                      if r.ValueExists('MachineGuid') then
                        s1 := r.ReadString('MachineGuid');
                    except
                      s1 := '';
                    end;
                    r.CloseKey;
                  end;
                  r.Free;
                end;
           117: begin
                  s1 := '';
                  r := TRegistry.Create;
                  r.RootKey := HKEY_LOCAL_MACHINE;
                  if Is64Bit then
                    r.Access := KEY_READ or $100 
                  else
                    r.Access := KEY_READ;
                  if r.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows NT\CurrentVersion') then
                  begin
                    try
                      if r.ValueExists('EditionID') then
                        s1 := r.ReadString('EditionID');
                    except
                      s1 := '';
                    end;
                    r.CloseKey;
                  end;
                  r.Free;
                end;
            96: s1 := MyBoolToStr(IsSSD(AssertDir(ElimDoubles('$TARGETDIR$'))));
            91:
            begin
              GetSystemInfo(SYSTEMINFO);
              s1 := IntToStr(SYSTEMINFO.dwNumberOfProcessors);
            end;
            
            90: s1 := 'FALSE';
            
            77: s1 := MyBoolToStr(IsUserElevated);
            0: s1 := MyBoolToStr(IsUserAdminEx);
            
            1,
            
            2,
            
            3,
            
            4,
            
            5,
            
            6,
            
            7: begin
                 case StrToInt(ReadOffset(Derefs, References[i -1], 2)) of
                   1: i1 := 32;
                   2: i1 := 64;
                   3: i1 := 128;
                   4: i1 := 256;
                   5: i1 := 512;
                   6: i1 := 1024;
                   7: i1 := 2048;
                 end;
                 i1 := (i1 -2) * 1024 * 1024;
                 GetFreeMemory(True, memPhysical, memPaging, memVirtual);
                 s1 := MyBoolToStr(memPhysical >= i1);
               end;
            
            8,
            
            9,
            
            10,
            
            11,
            
            12: begin
                  case StrToInt(ReadOffset(Derefs, References[i -1], 2)) of
                    8: begin
                         i1 := 800;
                         i2 := 600;
                       end;
                    9: begin
                         i1 := 1024;
                         i2 := 768;
                       end;
                    10: begin
                          i1 := 1280;
                          i2 := 1024;
                        end;
                    11: begin
                          i1 := 1600;
                          i2 := 1200;
                        end;
                    12: begin
                          i1 := 1920;
                          i2 := 1440;
                        end;
                  end;
                  GetScreenResolution(X, Y);
                  s1 := MyBoolToStr( (X >= i1) and (Y >= i2) or
                    (Y >= i1) and (X >= i2) ); 
                end;
            
            13,
            
            14,
            
            15,
            
            16: begin
                  case StrToInt(ReadOffset(Derefs, References[i -1], 2)) of
                    13: i1 := 8;
                    14: i1 := 16;
                    15: i1 := 24;
                    16: i1 := 32;
                  end;
                  GetColorCount(Colors, Bits);
                  s1 := MyBoolToStr(Bits >= i1);
                end;
            
            17: s1 := MyBoolToStr(Win32Platform <> VER_PLATFORM_WIN32_NT);
            
            18: s1 := MyBoolToStr(Win32Platform = VER_PLATFORM_WIN32_NT);
            
            19,
            
            20,
            
            21,
            
            22,
            
            23,
            
            24,
            
            25,
            
            26,
            
            69,
            
            76,
            
            79,
            
            81,
            
            87,
            
            88,
            93, 
            92, 
            95, 
            97, 
            98,
            99,
            100,
            101,
            102,
            103,
            110,
            112,
            113,
            114,
            115,
            116,
            119
            : begin
                  case StrToInt(ReadOffset(Derefs, References[i -1], 2)) of
                    19: begin
                          i1 := 4;
                          i2 := 0;
                        end;
                    20: begin
                          i1 := 4;
                          i2 := 10;
                        end;
                    21: begin
                          i1 := 4;
                          i2 := 11; 
                        end;
                    22: begin
                          i1 := 4;
                          i2 := 90;
                        end;
                    23: begin
                          i1 := 4;
                          i2 := 0;
                        end;
                    24: begin
                          i1 := 5;
                          i2 := 0;
                        end;
                    25: begin
                          i1 := 5;
                          i2 := 1;
                        end;
                    26: begin
                          i1 := 5;
                          i2 := 2;
                        end;
                    69: begin
                          i1 := 6;
                          i2 := 0;
                        end;
                    76: begin
                          i1 := 6;
                          i2 := -1;
                        end;
                    79: begin
                          i1 := 6;
                          i2 := 1;
                        end;
                    81: begin
                          i1 := 6;
                          i2 := -2;
                        end;
                    87: begin
                          i1 := 6;
                          i2 := 2;
                        end;
                    88: begin
                          i1 := 6;
                          i2 := -3;
                        end;
                    93: 
                        begin
                          i1 := 6;
                          i2 := -4;
                        end;
                    92: 
                        begin
                          i1 := 6;
                          i2 := 3;
                        end;
                    97: 
                        begin
                          i1 := 6;
                          i2 := -4;
                          u1mess := True;
                        end;
                    95: 
                        begin
                          i1 := 6;
                          i2 := 3;
                          u1mess := True;
                        end;
                    98: 
                        begin
                          i1 := 6;
                          i2 := 4;
                          u1mess := True;
                        end;
                    99: 
                        begin
                          i1 := 6;
                          i2 := -5;
                        end;
                    100: 
                        begin
                          i1 := 6;
                          i2 := 4;
                          u2mess := True;
                        end;
                    101: 
                        begin
                          i1 := 6;
                          i2 := 4;
                          u3mess := True;
                        end;
                    102: 
                        begin
                          i1 := 6;
                          i2 := 4;
                          u4mess := True;
                        end;
                    103: 
                        begin
                          i1 := 6;
                          i2 := 4;
                          u5mess := True;
                        end;
                    110: 
                        begin
                          i1 := 6;
                          i2 := 4;
                          u6mess := True;
                        end;
                    112: 
                        begin
                          i1 := 6;
                          i2 := 4;
                          u7mess := True;
                        end;
                    113: 
                        begin
                          i1 := 6;
                          i2 := 4;
                          u8mess := True;
                        end;
                    114: 
                        begin
                          i1 := 6;
                          i2 := -6;
                        end;
                    115: 
                        begin
                          i1 := 6;
                          i2 := 4;
                          u9mess := True;
                        end;
                    116: 
                        begin
                          i1 := 6;
                          i2 := 4;
                          u10mess := True;
                        end;
                    119: 
                        begin
                          i1 := 6;
                          i2 := 4;
                          u11mess := True;
                        end;
                  end;
                  GetWindowsVersion(b, vMax, vMin, vSP);
                  if i2 = -6 then 
                  begin
                    s1 := MyBoolToStr(IsBuildLabUpdate7 and (((vMax > 6) or
                      ((vMax = 6) and (vMin >= 4))) and IsServer));
                  end
                  else
                  if i2 = -5 then 
                  begin
                    s1 := MyBoolToStr( (((vMax > 6) or
                      ( (vMax = 6) and (vMin >= 4) ))
                      and (vSP >= 0)) and IsServer);
                  end
                  else
                  if i2 = -4 then 
                  begin
                    s1 := MyBoolToStr( (((vMax > 6) or
                      ( (vMax = 6) and (vMin >= 3) ))
                      and (vSP >= 0)) and IsServer);
                  end
                  else
                  if i2 = -3 then 
                  begin
                    s1 := MyBoolToStr( (((vMax > 6) or
                      ( (vMax = 6) and (vMin >= 2) ))
                      and (vSP >= 0)) and IsServer);
                  end
                  else
                  if i2 = -2 then 
                  begin
                    s1 := MyBoolToStr( (((vMax > 6) or
                      ( (vMax = 6) and (vMin >= 1) ))
                      and (vSP >= 0)) and IsServer);
                  end
                  else
                  begin
                    if i2 = -1 then 
                    begin
                      s1 := 'FALSE';
                      if vMax > i1 then s1 := 'TRUE';
                      if (vMax = i1) and (vMin > 0) then s1 := 'TRUE';
                      if ((vMax = i1) and (vMin = 0)) and (vSP >= 1) then s1 := 'TRUE';
                      if (MyStrToBool(s1) ) and (not IsServer) then s1 := 'FALSE';
                    end
                    else
                    begin
                      s1 := MyBoolToStr( (vMax > i1) or
                        ( (vMax = i1) and (vMin >= i2) ) );
                      if (MyStrToBool(s1) ) and (StrToInt(ReadOffset(Derefs, References[i -1], 2)) = 26) then 
                        if not IsServer then
                          s1 := 'FALSE';
                    end;
                  end;
                  if u1mess and (MyStrToBool(s1) ) then
                    if not IsBuildLabUpdate1 then
                      if not ((vMax > 6) or
                        ( (vMax = 6) and (vMin >= 4) )) then
                        s1 := 'FALSE';
                  if u2mess and ((MyStrToBool(s1) )) then
                    if not IsBuildLabUpdate2 then
                      if not ((vMax > 10) or
                        ( (vMax = 10) and (vMin >= 1) )) then
                        s1 := 'FALSE';
                  if u3mess and ((MyStrToBool(s1) )) then
                    if not IsBuildLabUpdate3 then
                      if not ((vMax > 10) or
                        ( (vMax = 10) and (vMin >= 1) )) then
                        s1 := 'FALSE';
                  if u4mess and ((MyStrToBool(s1) )) then
                    if not IsBuildLabUpdate4 then
                      if not ((vMax > 10) or
                        ( (vMax = 10) and (vMin >= 1) )) then
                        s1 := 'FALSE';
                  if u5mess and ((MyStrToBool(s1) )) then
                    if not IsBuildLabUpdate5 then
                      if not ((vMax > 10) or
                        ( (vMax = 10) and (vMin >= 1) )) then
                        s1 := 'FALSE';
                  if u6mess and ((MyStrToBool(s1) )) then
                    if not IsBuildLabUpdate6 then
                      if not ((vMax > 10) or
                        ( (vMax = 10) and (vMin >= 1) )) then
                        s1 := 'FALSE';
                  if u7mess and ((MyStrToBool(s1) )) then
                    if not IsBuildLabUpdate7 then
                      if not ((vMax > 10) or
                        ( (vMax = 10) and (vMin >= 1) )) then
                        s1 := 'FALSE';
                  if u8mess and ((MyStrToBool(s1) )) then
                    if not IsBuildLabUpdate8 then
                      if not ((vMax > 10) or
                        ( (vMax = 10) and (vMin >= 1) )) then
                        s1 := 'FALSE';
                  if u9mess and ((MyStrToBool(s1) )) then
                    if not IsBuildLabUpdate9 then
                      if not ((vMax > 10) or
                        ( (vMax = 10) and (vMin >= 1) )) then
                        s1 := 'FALSE';
                  if u10mess and ((MyStrToBool(s1) )) then
                    if not IsBuildLabUpdate10 then
                      if not ((vMax > 10) or
                        ( (vMax = 10) and (vMin >= 1) )) then
                        s1 := 'FALSE';
                  if u11mess and ((MyStrToBool(s1) )) then
                    if not IsBuildLabUpdate11 then
                      if not ((vMax > 10) or
                        ( (vMax = 10) and (vMin >= 1) )) then
                        s1 := 'FALSE';
                end;
            
            27,
            
            28,
            
            29,
            
            30,
            
            31,
            
            32: begin
                  case StrToInt(ReadOffset(Derefs, References[i -1], 2)) of
                    27: i1 := 1;
                    28: i1 := 2;
                    29: i1 := 3;
                    30: i1 := 4;
                    31: i1 := 5;
                    32: i1 := 6;
                  end;
                  GetWindowsVersion(b, vMax, vMin, vSP);
                  s1 := MyBoolToStr(vSP >= i1);
                end;
            
            33: begin
                  GetLanguage(s2, i1);
                  s1 := IntToStr(i1);
                end;
            
            34: GetLanguage(s1, i1);
            35: GetLicenseInfo(s1, s2);
            36: GetLicenseInfo(s2, s1);
            
            37,
            
            38,
            
            39,
            
            40,
            
            41,
            
            42,
            
            43,
            
            44,
            
            45,
            
            46,
            
            47,
            
            48,
            
            49,
            
            50,
            
            51,
            
            52: begin
                  case StrToInt(ReadOffset(Derefs, References[i -1], 2)) of
                    
                    37: begin
                          
                          MajorHi2 := 6;
                          MajorLo2 := 0;
                          MinorHi2 := 2800;
                          MinorLo2 := 1106;
                        end;
                    38: begin
                          
                          MajorHi2 := 6;
                          MajorLo2 := 0;
                          MinorHi2 := 2600;
                          MinorLo2 := 0;
                        end;
                    39: begin
                          
                          MajorHi2 := 5;
                          MajorLo2 := 5;
                          MinorHi2 := 4807;
                          MinorLo2 := 2300;
                        end;
                    40: begin
                          
                          MajorHi2 := 5;
                          MajorLo2 := 5;
                          MinorHi2 := 4522;
                          MinorLo2 := 1800;
                        end;
                    41: begin
                          
                          MajorHi2 := 5;
                          MajorLo2 := 5;
                          MinorHi2 := 4134;
                          MinorLo2 := 100;
                        end;
                    42: begin
                          
                          MajorHi2 := 5;
                          MajorLo2 := 0;
                          MinorHi2 := 3502;
                          MinorLo2 := 5400;
                        end;
                    43: begin
                          
                          MajorHi2 := 5;
                          MajorLo2 := 0;
                          MinorHi2 := 3314;
                          MinorLo2 := 2100;
                        end;
                    44: begin
                          
                          MajorHi2 := 5;
                          MajorLo2 := 0;
                          MinorHi2 := 2919;
                          MinorLo2 := 6307;
                        end;
                    45: begin
                          
                          MajorHi2 := 5;
                          MajorLo2 := 0;
                          MinorHi2 := 2014;
                          MinorLo2 := 213;
                        end;
                    46: begin
                          
                          MajorHi2 := 4;
                          MajorLo2 := 72;
                          MinorHi2 := 3612;
                          MinorLo2 := 1707;
                        end;
                    47: begin
                          
                          MajorHi2 := 4;
                          MajorLo2 := 72;
                          MinorHi2 := 3110;
                          MinorLo2 := 3;
                        end;
                    48: begin
                          
                          MajorHi2 := 4;
                          MajorLo2 := 72;
                          MinorHi2 := 2106;
                          MinorLo2 := 7;
                        end;
                    49: begin
                          
                          MajorHi2 := 4;
                          MajorLo2 := 71;
                          MinorHi2 := 1712;
                          MinorLo2 := 5;
                        end;
                    50: begin
                          
                          MajorHi2 := 4;
                          MajorLo2 := 70;
                          MinorHi2 := 1300;
                          MinorLo2 := 0;
                        end;
                    51: begin
                          
                          MajorHi2 := 4;
                          MajorLo2 := 70;
                          MinorHi2 := 1215;
                          MinorLo2 := 0;
                        end;
                    52: begin
                          
                          MajorHi2 := 4;
                          MajorLo2 := 70;
                          MinorHi2 := 1155;
                          MinorLo2 := 0;
                        end;
                  end;
                  {$IFNDEF INTEROP}
                  GetFileVersion(WINSYSDIR + 'shdocvw.dll', 
                    MajorHi1, MajorLo1, MinorHi1, MinorLo1, Major1, Minor1);
                  {$ELSE}
                  GetFileVersion(mSysDir + 'shdocvw.dll', 
                    MajorHi1, MajorLo1, MinorHi1, MinorLo1, Major1, Minor1);
                  {$ENDIF}
                  b := True;
                  if MajorHi1 < MajorHi2 then b := false
                    else if MajorHi1 = MajorHi2 then
                    begin
                      if MajorLo1 < MajorLo2 then b := false
                      else if MajorLo1 = MajorLo2 then
                      begin
                        if MinorHi1 < MinorHi2 then b := false
                        else if MinorHi1 = MinorHi2 then
                          if MinorLo1 < MinorLo2 then b := false;
                      end;
                    end;
                  s1 := MyBoolToStr(b);
                end;
            
            53,
            
            54,
            
            55,
            
            56,
            
            57,
            
            58,
            
            73,
            
            80,
            
            89: begin
                  i2 := 0;
                  case StrToInt(ReadOffset(Derefs, References[i -1], 2)) of
                    73: i1 := 7;
                    53: i1 := 6;
                    54: begin
                          i1 := 5;
                          i2 := 1;
                        end;
                    55: i1 := 5;
                    56: i1 := 4;
                    57: i1 := 3;
                    58: i1 := 2;
                    80: begin
                          i1 := 7;
                          i2 := 5;
                        end;
                    89: begin
                          i1 := 8;
                        end;
                  end;
                  r := TRegistry.Create;
                  r.Access := KEY_READ;
                  r.RootKey := HKEY_LOCAL_MACHINE;
                  if not r.OpenKey('SOFTWARE\Microsoft\INetStp', false) 
                    then b := false
                  else
                  begin
                    try
                      b := (r.ReadInteger('MajorVersion') * 10) 
                        + r.ReadInteger('MinorVersion') >= (i1 * 10) + i2; 
                    except
                      b := false;
                    end;
                    r.CloseKey;
                  end;
                  r.Free;
                  s1 := MyBoolToStr(b);
                end;
            82,
            83: begin
                  GetScreenResolution(X, Y);
                  if StrToInt(ReadOffset(Derefs, References[i -1], 2)) = 82 then
                    s1 := IntToStr(X)
                  else
                    s1 := IntToStr(Y);
                end;
            84: s1 := IntToStr(GetSystemMemoryMb(smTotalPhys));
            59: begin
                  
                  s1 := '';
                end;
            60: s1 := GetUserOrDomain(True);
            61: s1 := MyGetComputerName;
            62: s1 := GetUserOrDomain(false);
            63: if IsUserAdminEx then s1 := 'ADMIN' 
                  else if IsUserPower then s1 := 'POWER' 
                    else if IsUserUser then s1 := 'USER' 
                      else if IsUserGuest then s1 := 'GUEST' 
                        else s1 := 'ERROR'; 
            64: s1 := IntToStr(GetScreenDPI);
            65: begin
                  s1 := 'FALSE';
                  if Is64Bit(True) then
                    if not Is64BitOnArm then 
                      s1 := 'TRUE'; 
                      
                end;
            66: s1 := MyBoolToStr(GetSystemMetrics(86) <> 0);
            67: s1 := MyBoolToStr(GetSystemMetrics(87) <> 0);
            68: s1 := MyBoolToStr(IsServer);
            70: s1 := 'FALSE';
            71: s1 := 'FALSE';
            74: s1 := 'FALSE';
            75: s1 := Get64BitArch;
            
            72,
            
            78,
            
            85,
            
            86,
            94: 
                begin
                  s1 := GetIERegVersion;
                  MajorHi1 := GetNextNumber(s1);
                  MajorLo1 := GetNextNumber(s1);
                  MinorHi1 := GetNextNumber(s1);
                  MinorLo1 := GetNextNumber(s1);
                  case StrToInt(ReadOffset(Derefs, References[i -1], 2)) of
                    72: begin
                          
                          MajorHi2 := 7;
                          MajorLo2 := 0;
                          MinorHi2 := 5730;
                          MinorLo2 := 11;
                        end;
                    78: begin
                          
                          MajorHi2 := 8;
                          MajorLo2 := 0;
                          MinorHi2 := 6001;
                          MinorLo2 := 18702;
                        end;
                    85: begin
                          
                          MajorHi2 := 9;
                          MajorLo2 := 0;
                          MinorHi2 := 8112;
                          MinorLo2 := 16421;
                        end;
                    86: begin
                          
                          MajorHi2 := 9;
                          MajorLo2 := 10;
                          MinorHi2 := 8102;
                          MinorLo2 := 0;
                        end;
                    94: begin
                          
                          MajorHi2 := 9;
                          MajorLo2 := 11;
                          MinorHi2 := 9431;
                          MinorLo2 := 0;
                        end;
                  end;
                  b := True;
                  if MajorHi1 < MajorHi2 then b := false
                    else if MajorHi1 = MajorHi2 then
                    begin
                      if MajorLo1 < MajorLo2 then b := false
                      else if MajorLo1 = MajorLo2 then
                      begin
                        if MinorHi1 < MinorHi2 then b := false
                        else if MinorHi1 = MinorHi2 then
                          if MinorLo1 < MinorLo2 then b := false;
                      end;
                    end;
                  s1 := MyBoolToStr(b);
                end;
            
            104: begin
                   s1 := IntToStr(GetSystemDefaultUILanguage);
                 end;
            105: begin
                   s1 := CodeToLang(GetSystemDefaultUILanguage);
                 end;
            106,
            107: begin
                   if IsOlderThanVista then
                   begin
                     if StrToInt(ReadOffset(Derefs, References[i -1], 2)) = 106 then
                       s1 := IntToStr(GetSystemDefaultUILanguage)
                     else
                       s1 := CodeToLang(GetSystemDefaultUILanguage);
                   end
                   else
                   begin
                     ui32_2 := 0;
                     s1 := 'ERROR';
                     if GetSystemPreferredUILanguages(4,
                       ui32_1, nil, ui32_2) then
                     begin
                       GetMem(p, ui32_2);
                       if GetSystemPreferredUILanguages(4, ui32_1, p, ui32_2) then
                         if StrToInt(ReadOffset(Derefs, References[i -1], 2)) = 106 then
                           s1 := IntToStr(StrToInt('$'+ p))
                         else
                           s1 := CodeToLang(StrToInt('$'+ p));
                       FreeMem(p);
                     end;
                     if s1 = 'ERROR' then
                     begin
                       
                       if StrToInt(ReadOffset(Derefs, References[i -1], 2)) = 106 then
                         s1 := IntToStr(GetSystemDefaultUILanguage)
                       else
                        s1 := CodeToLang(GetSystemDefaultUILanguage);
                     end;
                   end;
                 end;
            
            108: begin
                   s1 := IntToStr(GetUserDefaultUILanguage);
                 end;
            109: begin
                   s1 := CodeToLang(GetUserDefaultUILanguage);
                 end;
            111: begin
                   
                   s1 := 'FALSE';
                   if Is64BitOnArm then
                     s1 := 'TRUE';
                 end;
          end;
          SetVariable(s, s1, TypesI + ' Action'); 
          Continue;
        finally
          Leave64BitFileSystem;
          Leave64BitRegistry;
        end;
        {$endregion}
      end;
      if TypesI = 'Get OS or SP Level' then 
      begin
      {$region}
        try
          Enter64BitRegistry;
          Enter64BitFileSystem;
          s := ReadOffset(Derefs, References[i -1], 1);
          if not IsVarDefined(s) then
            SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
          GetWindowsVersion(b, i1, i2, vSP);
          if StrToBool(ReadOffset(Derefs, References[i -1], 2)) then
          begin
            s1 := 'UNKNOWN'; 
            if b then
            begin
              if (i1 = 4) and (i2 = 0) then
                s1 := 'NT4'; 
              if (i1 = 5) and (i2 = 0) then
                s1 := '2000'; 
              if (i1 = 5) and (i2 = 1) then
                s1 := 'XP'; 
              if (i1 = 5) and (i2 = 2) then
              begin
                if IsServer then
                  s1 := '2003' 
                else
                  s1 := 'XP';
              end;
              if (i1 = 6) and (i2 = 0) then
              begin
                if (vSP >= 1) and IsServer then
                  s1 := '2008'
                else
                  s1 := 'VISTA'; 
              end;
              if (i1 = 6) and (i2 = 1) then
              begin
                if IsServer then
                  s1 := '2008R2'
                else
                  s1 := 'SEVEN'; 
              end;
              if (i1 = 6) and (i2 = 2) then
              begin
                if IsServer then
                  s1 := 'SERVER8'
                else
                  s1 := 'METRO'; 
              end;
              if ((i1 = 6) and (i2 = 4)) or ((i1 = 10) and (i2 = 0)) then
              begin
                if IsServer then
                begin
                  if IsBuildLabUpdate7 then
                    s1 := 'SERVERELEVEN'
                  else
                    s1 := 'SERVERTEN';
                end
                else
                  if IsBuildLabUpdate11 then
                    s1 := 'TENELEVEN'
                  else
                    if IsBuildLabUpdate10 then
                      s1 := 'TENTEN'
                    else
                      if IsBuildLabUpdate9 then
                        s1 := 'TENNINE'
                      else
                        if IsBuildLabUpdate8 then
                          s1 := 'TENEIGHT'
                        else
                          if IsBuildLabUpdate7 then
                            s1 := 'TENSEVEN'
                          else
                            if IsBuildLabUpdate6 then
                              s1 := 'TENSIX'
                            else
                              if IsBuildLabUpdate5 then
                                s1 := 'TENFIVE'
                              else
                                if IsBuildLabUpdate4 then
                                  s1 := 'TENFOUR'
                                else
                                  if IsBuildLabUpdate3 then
                                    s1 := 'TENTHREE'
                                  else
                                    if IsBuildLabUpdate2 then
                                      s1 := 'TENTWO'
                                    else
                                      s1 := 'TEN'; 
              end;
              if (i1 = 6) and (i2 = 3) then
              begin
                if IsServer then
                begin
                  if not IsBuildLabUpdate1 then
                    s1 := 'SERVER8R2'
                  else
                    s1 := 'SERVER8R2U1';
                end
                else
                begin
                  if not IsBuildLabUpdate1 then
                    s1 := 'METROR2' 
                  else
                    s1 := 'METROR2U1'; 
                end;
              end;
            end
            else
            begin
              if (i1 = 4) and (i2 = 0) then
                s1 := '95'; 
              if (i1 = 4) and (i2 = 10) then
                s1 := '98'; 
              if (i1 = 4) and (i2 = 11) then
                s1 := '98SE'; 
              if (i1 = 4) and (i2 = 90) then
                s1 := 'ME'; 
            end;
          end
          else
            s1 := IntToStr(vSP);
          SetVariable(s, s1, TypesI + ' Action'); 
          Continue;
        finally;
          Leave64BitFileSystem;
          Leave64BitRegistry;
        end;
        {$endregion}
      end;
      if TypesI = 'Delete Registry' then 
      begin
      {$region}
        try
          Enter64BitRegistry;
          r := TRegistry.Create;
          try
            WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 1), Wide1, Wide2);
            case StrToInt(Wide1) of
              0: r.RootKey := HKEY_CLASSES_ROOT;
              1: r.RootKey := HKEY_CURRENT_USER;
              2: r.RootKey := HKEY_LOCAL_MACHINE;
              3: r.RootKey := HKEY_USERS;
              4: r.RootKey := HKEY_CURRENT_CONFIG;
            end;
            if not ((r.RootKey = HKEY_LOCAL_MACHINE) or (r.RootKey = HKEY_USERS)) then
              Wide2 := '';
            Wide2 := SubstituteVariables(Wide2);
            if Wide2 <> '' then
              if AnsiPos('\\', Wide2) <> 1 then
                Wide2 := '\\' + Wide2;
            if Wide2 <> '' then
              if not r.RegistryConnect(Wide2) then 
              begin
                r.Free;
                Continue;
              end;
            r.Access := KEY_READ or KEY_WRITE or REG_ACCESS_CONST; 
            if StrToBool(ReadOffset(Derefs, References[i -1], 4)) then
            begin
              ClearRegSecurity(r.RootKey, ElimDoubles(ReadOffset(Derefs, References[i -1], 2)), Wide2);

                r.DeleteKey(ElimDoubles(ReadOffset(Derefs, References[i -1], 2)));
            end
            else
            begin
              hSec := ClearRegSecurity(r.RootKey, ElimDoubles(ReadOffset(Derefs, References[i -1], 2)), Wide2);
              if r.OpenKey(ElimDoubles(ReadOffset(Derefs, References[i -1], 2)), false) then
              begin
                r.DeleteValue(ElimDoubles(ReadOffset(Derefs, References[i -1], 3)));
                r.CloseKey;
              end;
              if hSec <> 0 then
                RestoreSecurity(hSec);
            end;
          except
          end;
          r.Free;
        finally
          Leave64BitRegistry;
        end;
        {$endregion}
      end;
      {$ENDIF}
      if TypesI = 'Reboot Computer' then 
      begin
        {$region}
        {$IFDEF WINDOWS}
        MyExitWindows(EWX_REBOOT );
        {$ELSE}
        {$IFDEF LINUX}
        RebootLinux;
        {$ELSE}
        
        RebootMac;
        {$ENDIF}
        {$ENDIF}
        Break;
        {$endregion}
      end;
      if (TypesI = 'Reboot and Resume') or (TypesI = 'Reboot and Login') then 
      begin
      {$region}
        {$IFDEF WINDOWS}
        {$IFDEF INTEROP}
        try
          r := TRegistry.Create;
          if StrToBool(GetVariable('ALLUSERS')) = false then 
            r.RootKey := HKEY_CURRENT_USER
          else
            r.RootKey := HKEY_LOCAL_MACHINE;
          r.Access := KEY_WRITE;
          if TypesI = 'Reboot and Login' then
            r.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Run\', True)
          else
            r.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\RunOnce\', True); 
          if SFXFileName <> '' then
            s := SFXFileName
            
          else
            s := MyParamStr(0);
            
          if CommandLine <> '' then
            s := s + ' ' + CommandLine;
          r.WriteString(Copy(ProductGUID, 2, 8), s);
          
          r.CloseKey;
          r.Free;
        except
        end;
        {$ENDIF}
        MyExitWindows(EWX_REBOOT );
        {$ELSE}
        {$IFDEF LINUX}
        RebootLinux;
        {$ELSE}
        
        RebootMac;
        {$ENDIF}
        {$ENDIF}
        Break;
        {$endregion}
      end;
      if TypesI = 'Write to Binary File' then
      begin
        try
          Enter64BitFileSystem;
          fs1 := TFileStream.Create(ElimDoubles(ReadOffset(Derefs, References[i -1], 1)),
            fmOpenWrite or fmShareDenyRead);
          if (fs1.Seek(StrToInt64(ReadOffset(Derefs, References[i -1], 3)), soBeginning) =
              StrToInt64(ReadOffset(Derefs, References[i -1], 3))) then
          begin
            s1 := SubstituteVariables(ReadOffset(Derefs, References[i -1], 2));
            if StrToBool(ReadOffset(Derefs, References[i -1], 4)) then
              s1 := s1 + #0;
            c1 := Length(s1);
            v1 := PAnsiChar(AnsiString(s1));
            c2 := fs1.Write(v1, c1);
          end;
          fs1.Free;
        finally
          Leave64BitFileSystem;
        end;
        Continue;
      end;
      if TypesI = 'Rename File/Folder' then
      begin
        try
          Enter64BitFileSystem;
          MoveFile(PChar(ElimDoubles(ReadOffset(Derefs, References[i -1], 1))),
            PChar(ElimDoubles(ReadOffset(Derefs, References[i -1], 2))));
        finally
          Leave64BitFileSystem;
        end;
        Continue;
      end;
      if TypesI = 'Set 64 Bit Mode' then 
      begin
      {$region}
        
        if StrToBool(ReadOffset(Derefs, References[i -1], 1))  then 
          x64Mode := 'Win32'; 
        if StrToBool(ReadOffset(Derefs, References[i -1], 2))  then 
          x64Mode := 'ia64'; 
        if StrToBool(ReadOffset(Derefs, References[i -1], 3))  then 
          x64Mode := 'x64'; 
          {$endregion}
      end;
      if TypesI = 'Edit INI File' then 
      begin
      {$region}
        if NativeEngineMode then
        begin
          if not DoNativeProcessing then
            Break
          else
            Continue;
        end;
        {$endregion}
      end;
      if TypesI = 'Delete Files' then 
      begin
      {$region}
        if not DoNativeProcessing then
          Break
        else
          Continue;
        {$endregion}
      end;
      if TypesI = 'Run Program' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          raCmd := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1)));
          raHide := StrToBool(ReadOffset(Derefs, References[i -1], 2));
          raParams := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 3)));
          raWait := StrToBool(ReadOffset(Derefs, References[i -1], 4));
          raFinished := false;
          GetDir(0, OldDir);
          try
            if DirectoryExists(raCmd) then 
              ChDir(ExtractFilePath(raCmd));
          except
          end;
          
          MonitorGlobalProgress := True;
          tra := TRunApp.Create(false);
          repeat
            DelegateBindProgress(GetVariable('PROGRESSTEXT'), 
              StrToInt(GetVariable('PROGRESS')), 100, 0); 
            CustomCoolWait(tra);
            if StrToBool(GetVariable('MYAH_IsCancelled')) then
            begin
              
              tra.Terminate;
              {$IFNDEF NOGUI}
              ImageListPool.traTimer.Enabled := True;
              {$ENDIF}
              raOut := -314;
            end;
          until raFinished;
          {$IFNDEF NOGUI}
          ImageListPool.traTimer.Enabled := false;
          {$ENDIF}
          if StrToBool(GetVariable('MYAH_IsCancelled'))  then
          begin
            if not StrToBool(GetVariable('ABORTEDONERROR')) then 
            begin
              if not SilentInstall then
              begin
                
                MyMessageBox({$IFNDEF WINDOWS}0{$ELSE}PrimaryWindowHandle{$ENDIF}, PChar(ntv0), PChar(BrandEx),
                  mb_Ok + mb_IconStop);
                
              end;
            end;
            if StrToBool(GetVariable('ABORTONERROR')) then
            begin
              CheckDoNativeRollback;
              Break;
            end
            else
              SetVariable('ABORTEDONERROR', 'TRUE', 'Cancel at Run-Program Time');
          end;
          MonitorGlobalProgress := false;
          try
            if DirectoryExists(OldDir) then 
              ChDir(OldDir);
          except
          end;
          
          i1 := raOut;
          s := ReadOffset(Derefs, References[i -1], 5);
          if s <> '' then
          begin
            if not IsVarDefined(s) then
              SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
            SetVariable(s, IntToStr(i1), TypesI + ' Action'); 
          end;
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Check Process' then
      begin
        
          s1 := 'FALSE';
        s := ReadOffset(Derefs, References[i -1], 2);
        if s <> '' then
        begin
          if not IsVarDefined(s) then
            SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
          SetVariable(s, s1, TypesI + ' Action'); 
        end;
        Continue;
      end;
      if TypesI = 'Run Program As' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          raxCmd := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1)));
          raxFolder := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 2)));
          raxParams := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 3)));
          raxWindow := StrToInt(ReadOffset(Derefs, References[i -1], 4));
          raxElev := false;
          raxCap := false;
          raxLog := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 7)));
          if ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 5))) = '$MYAH_UACEY$' then
          begin
            raxElev := True;
            raxCap := True;
          end
          else
            if ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 5))) = '$MYAH_UACEX$' then
              raxElev := True
            else
              if ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 5))) = '$MYAH_UAC$' then
                raxCap := True;
          
          raxWait := StrToBool(ReadOffset(Derefs, References[i -1], 9));
          raxEnv := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 10)));
          raxFinished := false;
          try
            if raxFolder <> '' then
            begin
              GetDir(0, OldDir);
              try
                ChDir(raxFolder);
              except
              end;
            end;
            
            MonitorGlobalProgress := True;
            trax := TRunAs.Create(false);
            repeat
              DelegateBindProgress(GetVariable('PROGRESSTEXT'), 
                StrToInt(GetVariable('PROGRESS')), 100, 0); 
              CustomCoolWait(trax);
              if StrToBool(GetVariable('MYAH_IsCancelled')) then
              begin
                
                trax.Terminate;
                {$IFNDEF NOGUI}
                ImageListPool.traxTimer.Enabled := True;
                {$ENDIF}
                raxOut := -314;
              end;
            until raxFinished;
            {$IFNDEF NOGUI}
            ImageListPool.traxTimer.Enabled := false;
            {$ENDIF}
            if StrToBool(GetVariable('MYAH_IsCancelled'))  then
            begin
              if not StrToBool(GetVariable('ABORTEDONERROR')) then 
              begin
                if not SilentInstall then
                begin
                  
                  MyMessageBox({$IFNDEF WINDOWS}0{$ELSE}PrimaryWindowHandle{$ENDIF}, PChar(ntv0), PChar(BrandEx),
                    mb_Ok + mb_IconStop);
                  
                end;
              end;
              if StrToBool(GetVariable('ABORTONERROR')) then
              begin
                CheckDoNativeRollback;
                Break;
              end
              else
                SetVariable('ABORTEDONERROR', 'TRUE', 'Cancel at Run-As Time');
            end;
            MonitorGlobalProgress := false;
          finally
            if raxFolder <> '' then
            try
              ChDir(OldDir);
            except
            end;
          end;
          
          i1 := raxOut;
          s := ReadOffset(Derefs, References[i -1], 8);
          if s <> '' then
          begin
            if not IsVarDefined(s) then
              SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
            SetVariable(s, IntToStr(i1), TypesI + ' Action'); 
          end;
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'File Bag' then
      begin
        
        if (MediaLayout = 2) and (Webs[i -1] <> '') then
        try
          if not StrToBool(GetVariable('ABORTEDONERROR')) then
            GrabMedia(Webs[i -1], mbURL, mbLocal, mbEnc, mbServer, mbPort, mbUser, mbPass, mbResume, dpEngine, dpState);
        except
          on E: Exception do
          begin
            if not SilentInstall then
            begin
              
              MyMessageBox({$IFNDEF WINDOWS}0{$ELSE}PrimaryWindowHandle{$ENDIF}, PChar(E.Message), PChar(BrandEx),
                mb_Ok + mb_IconStop);
              
            end;
            if StrToBool(GetVariable('ABORTONERROR')) then
            begin
              CheckDoNativeRollback;
              Break;
            end
            else
              SetVariable('ABORTEDONERROR', 'TRUE', 'File Bag Abort');
          end;
        end;
        
        if not DoNativeProcessing then
          Break;
        
        s1 := CachedDataDir + Webs[i -1] +  'FileBag' + IntToStr(i);
        s2 := SubstituteVariables('$SUPPORTDIR$' + 'FileBag' + IntToStr(i));
        if not CopyFolderDecrypt(s1, s2) then
          s2 := 'ERROR';
        s := ReadOffset(Derefs, References[i -1], 4);
        if s <> '' then
        begin
          if not IsVarDefined(s) then
            SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
          SetVariable(s, s2, TypesI + ' Action');
        end;
        Continue;
      end;
      if TypesI = 'Download File' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          dnURL := SubstituteVariables(ReadOffset(Derefs, References[i -1], 1));
          dnLocal := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 2)));
          dnServer := SubstituteVariables(ReadOffset(Derefs, References[i -1], 4));
          dnPort := SubstituteVariables(ReadOffset(Derefs, References[i -1], 5));
          dnResume := StrToBool(SubstituteVariables(ReadOffset(Derefs, References[i -1], 6)));
          dnFinished := false;
          MonitorGlobalProgress := True;
          tdn := TDownloader.Create(false);
          repeat
            
            CustomCoolWait(tdn);
            if StrToBool(GetVariable('MYAH_IsCancelled')) then
            begin
              SETVARIABLE('MYAH_LastActiveTick',GETVARIABLE('MYAH_LastDelegateTick'),''); 
              tdn.Terminate;
              {$IFNDEF NOGUI}
              ImageListPool.tdnTimer.Enabled := True;
              {$ENDIF}
              dnOut := false;
            end;
          until dnFinished;
          {$IFNDEF NOGUI}
          ImageListPool.tdnTimer.Enabled := false;
          {$ENDIF}
          if StrToBool(GetVariable('MYAH_IsCancelled'))  then
          begin
            if not StrToBool(GetVariable('ABORTEDONERROR')) then 
            begin
              if not SilentInstall then
              begin
                
                MyMessageBox(0, PChar(ntv0), PChar(BrandEx),
                  mb_Ok + mb_IconStop);
                
              end;
            end;
            if StrToBool(GetVariable('ABORTONERROR')) then
            begin
              CheckDoNativeRollback;
              Break;
            end
            else
              SetVariable('ABORTEDONERROR', 'TRUE', 'Cancel at Download-File Time');
          end;
          MonitorGlobalProgress := false;
          
          b1 := dnOut;
          s := ReadOffset(Derefs, References[i -1], 3);
          if s <> '' then
          begin
            if not IsVarDefined(s) then
              SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
            if b1 then
              SetVariable(s, 'SUCCESS', TypesI + ' Action')
            else
              SetVariable(s, 'ERROR', TypesI + ' Action'); 
          end;
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end
      else
      if TypesI = 'Display Dialog' then 
      begin
      {$region}
        if ReadOffset(Derefs, References[i -1], 4) <> '' then
        begin
          
          bX := StrToBool(ReadOffset(Derefs, References[i -1], 6));
          s1 := GetStringVar(ReadOffset(Derefs, References[i -1], 4));
          if s1 = '' then s1 := ReadOffset(Derefs, References[i -1], 4);
          s1 := GetVariable(s1);
          if not (StrToBool(s1) xor bX) then
          begin
            Continue;
          end;
        end;
        
        {$IFNDEF INTEROP}
        if WizardLoop then
        begin
          s1 := IntToStr(WizardCacheIndex);
          PrimaryWindowHandle := StrToInt(WizardHandles[WizardCacheIndex -1]);
          SureSetVariable('WINDOWHANDLE', IntToStr(PrimaryWindowHandle), 'WizardLoop'); 
        end
        else
        begin
          s1 := 'temp'; 
          PrimaryWindowHandle := LoadDesign('temp', 
            PChar(GetDialogResourcePath(ReadOffset(Derefs, References[i -1], 1))));
          SureSetVariable('WINDOWHANDLE', IntToStr(PrimaryWindowHandle), 'LoadDesign'); 
          if not StrToBool(ReadOffset(Derefs, References[i -1], 3)) then
            ShowingDesign := GetDialogResourcePath(ReadOffset(Derefs, References[i -1], 1));
        end;
        {$ELSE}
        s1 := IntToStr(i -1);
        DeferUnbindNameForHideDialog := s1;
        
        {$ENDIF}
        {$IFDEF INTEROP}
        if DeferUnbindName <> '' then
        begin
          
          {$ifdef SIMDILIKANSI}
          UnBindControls(PAnsiChar(Ansistring(DeferUnbindName)));
          {$else}
          UnBindControls(PChar(DeferUnbindName));
          {$endif}
          DeferUnbindName := '';
        end;
        {$ENDIF}
        ActiveDesign := s1;
        
        {$ifdef SIMDILIKANSI}
        BindControls(PAnsiChar(Ansistring(s1)));
        {$else}
        BindControls(PChar(s1));
        {$endif}
        
        if WizardLoop then
        begin
          {$IFNDEF INTEROP}
          i1 := ShowDesign(PChar(s1), ResultEx, True, false);
          {$ELSE}
          i1 := ShowDesign(IntToStr(i -1), ResultEx, True, false);
          {$ENDIF}
          {$IFDEF BACKIDE}
          
          UnBindControls(s1);
          {$ELSE}
          DeferUnbindName := s1;
          {$ENDIF}
        end
        else
        begin
          {$IFNDEF INTEROP}

          i1 := ShowDesign(PChar(s1), ResultEx, StrToBool(ReadOffset(Derefs, References[i -1], 3)), false);

          {$ELSE}
          i1 := ShowDesign(IntToStr(i -1), ResultEx, StrToBool(ReadOffset(Derefs, References[i -1], 3)),
             false);
          {$ENDIF}
          if not StrToBool(ReadOffset(Derefs, References[i -1], 3)) then
          begin
            PrimaryWindowHandle := i1;
            SureSetVariable('WINDOWHANDLE', IntToStr(PrimaryWindowHandle), 'Display Dialog'); 
            i1 := 0;
          end
          else
          begin
            PrimaryWindowHandle := 0;
            SureSetVariable('WINDOWHANDLE', IntToStr(PrimaryWindowHandle), 'Display Dialog'); 
            {$IFDEF BACKIDE}
            
            UnBindControls(s1);
            {$ELSE}
            DeferUnbindName := s1;
            {$ENDIF}
            
          end;
        end;
        {$IFNDEF INTEROP}
        
        {$ENDIF}
        if ReadOffset(Derefs, References[i -1], 2) <> '' then
        begin
          s1 := ReadOffset(Derefs, References[i -1], 2);
          
          if s1 <> '' then
            if not IsVarDefined(s1) then
              SureSetVariable(AnsiUpperCase(s1), '', TypesI + ' Action'); 
          case i1 of
            0: s2 := 'NOTMODAL'; 
            mrYes: s2 := 'NEXT'; 
            mrNo: s2 := 'BACK'; 
            mrCancel: s2 := 'CANCEL'; 
            mrAll: s2 := AnsiUpperCase(ResultEx);
          end;
          if s1 <> '' then
            SetVariable(s1, s2, TypesI + ' Action'); 
        end;
        if WizardLoop then
          case i1 of
            idYes: WizardDir := 1;
            idNo: WizardDir := -1;
            idCancel: WizardDir := 0;
          end;
        
        Continue;
        {$endregion}
      end;
      if TypesI = 'Hide Dialog' then 
      begin
      {$region}
        HideDesign('temp'); 
        {$IFNDEF INTEROP}
        
        ShowingDesign := '';
        {$ELSE}
        if DeferUnbindNameForHideDialog <> '' then
        begin
          DeferUnbindName := DeferUnbindNameForHideDialog;
          
          DeferUnbindNameForHideDialog := '';
        end;
        {$ENDIF}
        PrimaryWindowHandle := 0;
        SureSetVariable('WINDOWHANDLE', IntToStr(PrimaryWindowHandle), 'Hide Dialog'); 
        Continue;
      end;
      
      if PrimaryWindowHandle <> 0 then 
      begin
        TrackProgress := false;
        if LastProgressText <> GetVariable('PROGRESSTEXT') then 
        begin
          TrackProgress := True;
          LastProgressText := GetVariable('PROGRESSTEXT'); 
        end;
        if LastProgressSmartPos <> StrToInt(GetVariable('PROGRESS')) then 
        begin
          TrackProgress := True;
          LastProgressSmartPos := StrToInt(GetVariable('PROGRESS')); 
        end;
        if TrackProgress then
        begin
          DelegateBindProgress(GetVariable('PROGRESSTEXT'), 
            StrToInt(GetVariable('PROGRESS')), 100, 0); 
          
          CustomCoolWait(nil);
        end;
      end;
      
      if TypesI = 'Web Media Block' then 
      begin
        mbURL.Text := SubstituteVariables(ReadOffset(Derefs, References[i -1], 2));
        mbLocal := CachedDataDir + ReadOffset(Derefs, References[i -1], 1) + '.7zip'; 
        mbEnc := '';
        
        mbEnc := GetWeblockPwd(ReadOffset(Derefs, References[i -1], 1)); 
        if mbEnc = '' then 
          mbEnc := GetWeblockPwd('OFFLINE');
        
        mbEnc := DeObsWeblock(mbEnc);
        
        Continue;
      end;
      if TypesI = 'Get Folder Location' then 
      begin
      {$region 'Get Folder Location'}
        try
          Enter64BitFileSystem;
          Enter64BitRegistry;
          s := ReadOffset(Derefs, References[i -1], 1);
          if not IsVarDefined(s) then
            SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
          b := StrToBool(ReadOffset(Derefs, References[i -1], 3));
          case StrToInt(ReadOffset(Derefs, References[i -1], 2)) of
            
            0: i1 := $20;
            
            1: i1 := $21;
            
            2: if b then i1 := $2e
                 else i1 := $5;
            
            3: if b then i1 := $1f
                 else i1 := $6;
            
            4: if b then i1 := $35
                 else i1 := $d;
            
            5: if b then i1 := $36
                 else i1 := $27;
            
            6: if b then i1 := $37
                 else i1 := $e;
            
            7: i1 := $13;
            
            8: i1 := $1b;
            
            9: begin
                 i1 := -1;
                 s1 := GetBootPath;
               end;
            
            10: begin
                  i1 := -1;
                  
                end;
            
            11: if b then i1 := $2f
                  else i1 := $30;
            
            12: if b then i1 := $16
                  else i1 := $b;
            
            13: if b then i1 := $18
                  else i1 := $7;
            
            14: if b then i1 := $17
                  else i1 := $2;
            
            15: if b then i1 := $23
                  else i1 := $1a; 
            
            16: i1 := $3b;
            
            17: if b then i1 := $19
                  else i1 := $0;
            
            18: i1 := $14;
            
            19: if b then i1 := $3e
                  else i1 := $28;
            
            20: if not b then i1 := $26
                  else i1 := $2b;
            
            21: i1 := $8;
            
            22: i1 := $9;
            
            23: begin
                  
                  i1 := -1;
                  {$IFDEF WINDOWS}
                  s1 := '';
                  if Is64Bit then
                    if x64Mode = 'Win32' then 
                      s1 := AssertDir(GetSysWow64DirWin);
                  if s1 = '' then
                  begin
                    GetMem(p, (MAX_PATH+1)*8);
                    GetSystemDirectoryWin(p, MAX_PATH);
                    s1 := AssertDir(p);
                    FreeMem(p);
                  end;
                  {$ELSE}
                  {$IFDEF DARWIN}
                  s1 := GetSignificantDir(NSLibraryDirectory, NSSystemDomainMask, 0);
                  if s1 <> '' then
                    s1 := IncludeTrailingPathDelimiter(ExtractFilePath(ExcludeTrailingPathDelimiter(s1)));
                  {$ELSE}
                  s1 := '/usr/lib/';
                  {$ENDIF}
                  if s1 <> '' then
                    s1 := IncludeTrailingPathDelimiter(s1);
                  {$ENDIF}
                end;
            
            24: i1 := $15;
            
            25: begin
                  
                  i1 := -1;
                  {$IFDEF WINDOWS}
                  GetMem(p, (MAX_PATH+1)*8);
                  GetWindowsDirectoryWin(p, MAX_PATH);
                  s1 := AssertDir(p);
                  FreeMem(p);
                  {$ELSE}
                  {$IFDEF LINUX}
                  s1 := '/lib/';
                  {$ENDIF}
                  {$ENDIF}
                end;
            
            26: begin
                  i1 := -1;
                  {$IFDEF WINDOWS}
                  s1 := '';
                  r := TRegistry.Create;
                  r.Access := KEY_READ;
                  r.RootKey := HKEY_CURRENT_USER;
                  if r.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Explorer\Shell Folders\', false) then 
                  begin
                    try
                      s1 := r.ReadString('AppData'); 
                      if s1 <> '' then
                        s1 := AssertDir(s1) + 'Microsoft\Internet Explorer\Quick Launch\';
                    except
                      s1 := '';
                    end;
                  end;
                  r.CloseKey;
                  r.Free;
                  {$ENDIF}
                end;
            
            27: begin
                  i1 := -1;
                  {$IFDEF WINDOWS}
                  s1 := '';
                  r := TRegistry.Create;
                  r.Access := KEY_READ;
                  r.RootKey := HKEY_LOCAL_MACHINE;
                  
                  if r.OpenKey('SOFTWARE\Microsoft\InetStp', false) then 
                  begin
                    try
                      s1 := r.ReadString('PathWWWRoot'); 
                    except
                      s1 := '';
                    end;
                    if s1 <> '' then
                    begin
                      
                      s1 := ExpandEnvironmentString2(s1);
                    end;
                    r.CloseKey;
                  end;
                  
                  if s1 = '' then
                    if r.OpenKey('SYSTEM\CurrentControlSet\Services\W3SVC\Parameters\Virtual Roots\', false) then 
                    begin
                      try
                        s1 := r.ReadString('/');
                      except
                        s1 := '';
                      end;
                      
                      if AnsiPos(',', s1) <> 0 then
                        System.Delete(s1, AnsiPos(',', s1), Length(s1));
                      if s1 = '' then
                      begin
                        try
                          s1 := r.ReadString('/,');
                        except
                          s1 := '';
                        end;
                        
                        if AnsiPos(',', s1) <> 0 then
                          System.Delete(s1, AnsiPos(',', s1), Length(s1));
                      end;
                      r.CloseKey;
                    end;
                  
                  r.Free;
                  {$ENDIF}
                end;
            
            28: begin
                  i1 := $1c;
                end;
            29: begin 
                  i1 := -1;
                  
                  s1 := ''; 
                  {$IFDEF DARWIN}
                  s1 := GetSignificantDir(NSDownloadsDirectory, NSUserDomainMask, 0);
                  if s1 <> '' then
                    s1 := IncludeTrailingPathDelimiter(s1);
                  {$ELSE}
                  {$IFDEF LINUX}
                  s1 := '~/Downloads/';
                  {$ELSE}
                  if Win32MajorVersion >= 6 then
                  begin
                    lpv := nil;
                    if b then
                      i1 := SHGetKnownFolderPath(FOLDERID_PublicDownloads, 0, 0, lpv)
                    else
                      i1 := SHGetKnownFolderPath(FOLDERID_Downloads, 0, 0, lpv);
                    if i1 = S_OK then
                      s1 := lpv;
                    i1 := -1; 
                    CoTaskMemFree(lpv);
                  end;
                  {$ENDIF}
                  {$ENDIF}
                end;
          end;
          if i1 <> -1 then
            GetSpecialFolder(i1, s1);
          SetVariable(s, AssertDir(s1), TypesI + ' Action');
          Continue;
        finally
          Leave64BitRegistry;
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if ReEnding and (TypesI = 'End') then 
      begin
      {$region 'End'}
        DeferSkipToEnd := DeferSkipToEnd -1;
        ReEnding := false;
        Continue;
        {$endregion}
      end
      else
      if TypesI = 'Else' then 
      begin
      {$region 'Else'}
        SkipToEnd := True;
        Continue;
        {$endregion}
      end
      else
      if (DeferSkipToEnd > 0) and not JustOutWizardLoop then
      begin
        if (TypesI = 'Else If') or (TypesI = 'Else') then 
        begin
          SkipToEnd := True;
          Continue;
        end;
        if TypesI = 'End' then 
        begin
          DeferSkipToEnd := DeferSkipToEnd -1;
          Continue;
        end;
      end;
      JustOutWizardLoop := false;
      if TypesI = 'Apply Changes' then 
      begin
      {$region}
        if NativeEngineMode then
          begin
            s1 := ''; 
            i1 := 1;
          end;

        if (NativeEngineMode and NativeEngineDelay) then
        begin
          CachedMSPDir := '';
          try
            
            CachedMSPDir := IncludeTrailingPathDelimiter(MyGetAppConfigDir(AnsiCompareText(GetVariable('ALLUSERS'), 'TRUE') = 0));
          except
            CachedMSPDir := '';
          end;
          if (not MyFileExists(CachedDataDir + PGUIDEX)) then
            if StrToBool(GetVariable('MAINTENANCE')) then 
              if not (MediaLayout = 2) then
                if StrToBool(ReadOffset(Derefs, References[i -1], 3)) then 
                begin
                  b := false;
                  bX := false;
                  repeat
                    if SilentInstall then b := True
                      else
                        b := not MyDialogsSelectDirectory(msg16, '', s1, True); 
                    bX := MyFileExists(AssertDir(s1) + PGUIDEX) or MyFileExists(AssertDir(s1) + 'data\' + PGUIDEX);
                  until b or bX;
                  if bX then
                  begin
                    if MyFileExists(AssertDir(s1) + PGUIDEX) then CachedDataDir := AssertDir(s1)
                      else CachedDataDir := AssertDir(s1) + 'data' + PathDelim;
                    CachedPlugRootDir := CachedDataDir;
                  end
                  else
                  if b then
                  begin
                    SetVariable('LASTERROR', msg17, 'Apply Changes Action'); 
                    if TypesI = 'Apply Changes' then 
                    begin
                      if ReadOffset(Derefs, References[i -1], 2) <> '' then
                      begin
                        s1 := GetStringVar(ReadOffset(Derefs, References[i -1], 2));
                        if s1 = '' then s1 := ReadOffset(Derefs, References[i -1], 2);
                        if s1 <> '' then
                          SetVariable(s1, 'CANCEL', 'Apply Changes Action'); 
                      end;
                    end;
                    Continue;
                  end;
                end;
        end;

        if ActivatedLanguage <> '' then
          CacheSetMSIPropertyEx('ProductLanguage', LangToCode(ActivatedLanguage)); 

        if StrToBool(ReadOffset(Derefs, References[i -1], 4)) then
          
        begin
          
          if not SpoolNativeAction('UNINSTALL', nil, nil, 0) then
            i1 := 0
          else
          begin
            i1 := thNativei1;
          end;
            
        end;
        if StrToBool(ReadOffset(Derefs, References[i -1], 3)) and NativeEngineDelay then
          
        begin
          if not CommitNativeDelayed then
            i1 := 0
          else
          begin
            i1 := thNativei1;
          end;
            
        end;
        s1 := thNatives1;
        
        if s1 = '' then
          if i1 = 0 then
            s1 := ntv0;
        
        if (i1 = 1) and thNativeRebootOp then
          i1 := 2;
        
        if NativeShellChangeNotify then
        begin
          DoRefreshShell;
          NativeShellChangeNotify := false; 
          {$IFDEF DARWIN}
          for i5 := 1 to TouchList.Count do
            if (i5 mod 2) = 1 then
            begin
              fpUnLink(TouchList[i5]);
              DeleteFile(TouchList[i5]);
              fpSymLink(PChar(TouchList[i5 -1]), PChar(TouchList[i5]));
            end;
          {$ENDIF}
        end;

        if s1 <> '' then
        begin
          
          if TypesI = 'Apply Changes' then 
            SetVariable('LASTERROR', s1, 'Apply Changes Action') 
          else
            SetVariable('LASTERROR', s1, 'Apply Patch Action'); 
          {$IFNDEF INTEROP}
          Application.MessageBox(PChar(STheFollowingErrorOccuredWhileApp
            + MyLineEnding + s1 + MyLineEnding + MyLineEnding + SPleaseReviewYourInstallationComm),
            PChar(SWindowsInstallerErrorNotificatio), mb_Ok + mb_IconInformation);
          {$ENDIF}
        end;

        ssv1 := GetVariable('NATIVE_ERROR');
        ssv2 := GetVariable('NATIVE_OVERWRITE');
        ssv3 := GetVariable('NATIVE_OVERWRITE_OLDER');
        ssv4 := GetVariable('NATIVE_OVERRIDE_PERMISSIONS'); 
        ssv5 := GetVariable('NATIVE_OVERRIDE_NON_RESTORABLE_PERMISSIONS'); 
        
        if ReadOffset(Derefs, References[i -1], 2) <> '' then
        begin
          s1 := ReadOffset(Derefs, References[i -1], 2);
          if not IsVarDefined(s1) then
            if s1 <> '' then
              SureSetVariable(AnsiUpperCase(s1), '', TypesI + ' Action'); 
          case i1 of
           -1: s2 := 'ERROR'; 
            0: s2 := 'CANCEL'; 
            1: s2 := 'COMPLETE'; 
            2: begin
                 s2 := 'REBOOT'; 
                 SetVariable('REBOOTCOMPUTER', 'TRUE', 'Apply Changes Action'); 
               end;
          end;
          if s1 <> '' then
            SetVariable(s1, s2, 'Apply Changes Action'); 
        end;

        if NativeEngineMode then
          if StrToBool(ReadOffset(Derefs, References[i -1], 4)) then
            if (AnsiCompareText(GetVariable('NATIVE_LOGGING'), 'FALSE') <> 0) and
              (GetVariable('NATIVE_LOGGING') <> '')
            then
            begin
              
              if (i1 = 2) or (i1 = 1) then
                
                if AnsiCompareText(ExtractFilePath(GetVariable('NATIVE_LOGGING')), ExtractFilePath(GetVariable('NATIVE_OLDLOG'))) = 0 then
                begin
                  
                  WipeFolder(ExtractFilePath({$IFDEF DARWIN}
                    ExcludeTrailingPathDelimiter(ExtractFilePath(
                      ExcludeTrailingPathDelimiter(ExtractFilePath(
                        ExcludeTrailingPathDelimiter(ExtractFilePath(
                          {$ENDIF}GetVariable('NATIVE_LOGGING'){$IFDEF DARWIN})))))){$ENDIF}), True);
                   
                  RemoveDirectory(PChar(ExtractFilePath({$IFDEF DARWIN}
                    ExcludeTrailingPathDelimiter(ExtractFilePath(
                      ExcludeTrailingPathDelimiter(ExtractFilePath(
                        ExcludeTrailingPathDelimiter(ExtractFilePath(
                          {$ENDIF}GetVariable('NATIVE_LOGGING'){$IFDEF DARWIN})))))){$ENDIF})));
                end
                else
                begin
                  
                  DeleteFile(PChar(GetVariable('NATIVE_LOGGING') + '.native.elements.log'));
                  DeleteFile(PChar(GetVariable('NATIVE_LOGGING') + '.native.data.log'));
                  DeleteFile(PChar(GetVariable('NATIVE_LOGGING') + '.native.weight.log'));
                  DeleteFile(PChar(GetVariable('NATIVE_LOGGING') + '.native.bitness.log'));
                end;
              
              SureSetVariable('NATIVE_ERROR', ssv1, 'Native Foreign Log Processor');
              SureSetVariable('NATIVE_OVERWRITE', ssv2, 'Native Foreign Log Processor'); 
              SureSetVariable('NATIVE_OVERWRITE_OLDER', ssv3, 'Native Foreign Log Processor'); 
              SureSetVariable('NATIVE_OVERRIDE_PERMISSIONS', ssv4, 'Native Foreign Log Processor'); 
              SureSetVariable('NATIVE_OVERRIDE_NON_RESTORABLE_PERMISSIONS', ssv5, 'Native Foreign Log Processor'); 
              
              Continue;
            end;
        if (i1 = 1) or (i1 = 2) then 
        begin
          
          s1 := SniffSafeUserPath(StrToBool(GetVariable('ALLUSERS'))); 
          s3 := s1;
          
          s1 := s1 + RevisionGUID + PathDelim;
          s2 := AssertDir(ExtractFilePath(MSIFile)) + ExtractFileNameOnly(MSIFile);
          
          if StrToBool(ReadOffset(Derefs, References[i -1], 3)) or 
            ((not StrToBool(ReadOffset(Derefs, References[i -1], 3))) and (not StrToBool(ReadOffset(Derefs, References[i -1], 4)))) 
          then
          begin
            ForceDirectories(s1);
            {$IFDEF WINDOWS}
            
            {$ENDIF}
            
            if MediaLayout = 2 then
            begin
              AssignFile(t, s1 + ProductGUID,cp_utf8);
              ReWrite(t);
              CloseFile(t);
            end;
            {$IFDEF INTEROP}
            {$IFNDEF DARWIN}
            SetFileAttributes(PChar(s1 + ExtractFileName(MyParamStr(0))), FILE_ATTRIBUTE_NORMAL);
            CopyFile(PChar(MyParamStr(0)), PChar(s1 + ExtractFileName(MyParamStr(0))),false);
            SetFileAttributes(PChar(s1 + ExtractFileNameOnly(MyParamStr(0)) + '.msi'), FILE_ATTRIBUTE_NORMAL); 
            {$ELSE}
            s5 := s1;
            s6 := s2; 
            s5 := s5 + ExtractFileName(s6) + '.app/Contents/';
            s6 := ExtractFilePath(ExcludeTrailingPathDelimiter(ExtractFilePath(s6))); 
            ForceDirectories(s5 + 'MacOS/');
            
            if AnsiCompareText(RuntimeSubstituteCompilerVariables('#MYAH_SIGNED#'), 'TRUE') = 0 then
            begin
              FileCopyFile(PChar(AssertDir(CachedSupportDir) + 'miaxstub'),
                PChar(s5 + 'MacOS/' + ExtractFileName(MyParamStr(0))), false); 
              
            end
            else
            begin
              FileCopyFile(PChar(StringReplace(MyParamStr(0), '/' + Ventura +  '/miaxstub', '/MacOS/miaxstub', [rfReplaceAll, rfIgnoreCase])),
                PChar(s5 + 'MacOS/' + ExtractFileName(MyParamStr(0))), false); 
              
            end;
            
            LazShimSetExecutable(s5 + 'MacOS/' + ExtractFileName(MyParamStr(0)),
              StringReplace(MyParamStr(0), '/' + Ventura +  '/miaxstub', '/MacOS/miaxstub', [rfReplaceAll, rfIgnoreCase]));
            
            ForceDirectories(s5 + 'Resources');
            ForceDirectories(s5 + '' + Ventura +  '');
            
            FileCopyFile(s6 + 'Resources/miaxstub.icns', s5 + 'Resources/miaxstub.icns', false);
            FileCopyFile(s6 + 'Info.plist', s5 + 'Info.plist', false);
            {$IFDEF NOGUI}
            NoGuify(s5); 
            {$ENDIF}
            FileCopyFile(s6 + 'PkgInfo', s5 + 'PkgInfo', false);
            s5 := s5 + '' + Ventura +  '/';
            ForceDirectories(s1);
            s6 := s6 + '' + Ventura +  '/';
            FileCopyFile(s6 + 'miaxstub.res', s5 + 'miaxstub.res', false); 
            FileCopyFile(s6 + 'setup.png', s5 + 'setup.png', false); 
            FileCopyFile(s6 + 'miax.lib', s5 + 'miax.lib', false); 
            LazShimSetExecutable(s5 + 'miax.lib', EXEDIR + 'miax.lib');
            SaveComponents(s5 + ExtractFileNameOnly(MSIFile) + '.dat', false); 
            ParameterCache.SaveToFile(s5 + ExtractFileNameOnly(MSIFile) + '.par', TEncoding.UTF8); 
            NativeAppendToLog(NativeLogGuessPath);
            {$ENDIF}
            {$endif}

            {$IFNDEF DARWIN}
            SetFileAttributes(PChar(s1 + ExtractFileNameOnly(MyParamStr(0)) + '.res'), FILE_ATTRIBUTE_NORMAL); 
            FileCopyFile(PChar(RootFolder + ExtractFileNameOnly(MyParamStr(0)) + '.res'), 
              PChar(s1 + ExtractFileNameOnly(MyParamStr(0)) + '.res'), false); 
            SetFileAttributes(PChar(s1 + 'miax.lib'), FILE_ATTRIBUTE_NORMAL); 
            FileCopyFile(PChar(RootFolder + 'miax.lib'), 
              PChar(s1 + 'miax.lib'), false); 
            FileCopyFile(PChar(RootFolder + 'libQt5Pas.so.1'), 
              PChar(s1 + 'libQt5Pas.so.1'), false); 
            {$IFDEF LINUX}
            
            if MyFileExists(RootFolder + 'miax.lib') then
              LazShimSetExecutable(s1 + 'miax.lib', RootFolder + 'miax.lib');
            LazShimSetExecutable(s1 + ExtractFileNameOnly(MSIFileForNative), MyParamStr(0));
            {$ENDIF}
            SetFileAttributes(PChar(s1 + 'setup.png'), FILE_ATTRIBUTE_NORMAL); 
            FileCopyFile(PChar(RootFolder + 'setup.png'), 
              PChar(s1 + 'setup.png'), false); 

            SaveComponents(s1 + ExtractFileNameOnly(MSIFile) + '.dat', false); 

              ParameterCache.SaveToFile(s1 + ExtractFileNameOnly(MSIFile) + '.par', TEncoding.UTF8); 

            NativeAppendToLog(NativeLogGuessPath);
            {$ENDIF} 

            {$IFDEF BACKIDE}
            {$IFDEF DARWIN}
            s1 := s1 + ExtractFileName(s2) + '.app/Contents/'; 
            s2 := s2 + '.app/Contents/'; 
            ForceDirectories(s1 + 'Resources');
            ForceDirectories(s1 + '' + Ventura +  '');
            FileCopyFile(s2 + 'Resources/miaxstub.icns', s1 + 'Resources/miaxstub.icns', false);
            FileCopyFile(s2 + 'Info.plist', s1 + 'Info.plist', false);
            {$IFDEF NOGUI}
            NoGuify(s1); 
            {$ENDIF}
            FileCopyFile(s2 + 'PkgInfo', s1 + 'PkgInfo', false);
            s1 := s1 + 'MacOS/';
            ForceDirectories(s1);
            s2 := s2 + 'MacOS/';
            FileCopyFile(s2 + 'miaxstub', s1 + 'miaxstub', false); 
            LazShimSetExecutable(s1 + 'miaxstub', s2 + 'miaxstub');
            
            s1 := StringReplace(s1, '/MacOS/', '/' + Ventura +  '/', [rfReplaceAll, rfIgnoreCase]);
            s2 := StringReplace(s2, '/MacOS/', '/' + Ventura +  '/', [rfReplaceAll, rfIgnoreCase]);
            
            FileCopyFile(s2 + 'miaxstub.res', s1 + 'miaxstub.res', false); 
            FileCopyFile(s2 + 'setup.png', s1 + 'setup.png', false); 
            FileCopyFile(EXEDIR + 'miax.lib', s1 + 'miax.lib', false); 
            LazShimSetExecutable(s1 + 'miax.lib', EXEDIR + 'miax.lib');
            s2 := s2 + ExtractFileNameOnly(MSIFile);
            {$ELSE}
            SetFileAttributes(PChar(s1 + ExtractFileName(s2){$IFDEF WINDOWS}+ '.exe'{$ENDIF}), FILE_ATTRIBUTE_NORMAL); 
            FileCopyFile(PChar(s2 {$IFDEF WINDOWS}+ '.exe'{$ENDIF}),PChar(s1 + ExtractFileName(s2) {$IFDEF WINDOWS}+ '.exe'{$ENDIF}), false); 
            SetFileAttributes(PChar(s1 + ExtractFileName(s2) + '.res'), FILE_ATTRIBUTE_NORMAL); 
            FileCopyFile(PChar(s2 + '.res'), PChar(s1 + ExtractFileName(s2) + '.res'), false); 
            SetFileAttributes(PChar(s1 + 'setup.png'), FILE_ATTRIBUTE_NORMAL); 
            FileCopyFile(PChar(AssertDir(ExtractFilePath(s2)) + 'setup.png'), PChar(s1 + 'setup.png'), false);
            SetFileAttributes(PChar(s1 + 'miax.lib'), FILE_ATTRIBUTE_NORMAL); 
            FileCopyFile(PChar(EXEDIR + 'miax.lib'), PChar(s1 + 'miax.lib'), false); 
            FileCopyFile(PChar(EXEDIR + 'libQt5Pas.so.1'), PChar(s1 + 'libQt5Pas.so.1'), false); 
            {$IFDEF LINUX}
            LazShimSetExecutable(s1 + ExtractFileName(s2), s2);
            LazShimSetExecutable(s1 + 'miax.lib', EXEDIR + 'miax.lib');
            {$ENDIF}
            {$ENDIF}
            SaveComponents(s1 + ExtractFileName(s2) + '.dat', false); 
            ParameterCache.SaveToFile(s1 + ExtractFileName(s2) + '.par', TEncoding.UTF8); 

            NativeAppendToLog(NativeLogGuessPath);

            if ActivatedLanguage <> '' then
            begin
              AssignFile(t, s1 + ExtractFileName(s2) + '.lan',cp_utf8); 
              ReWrite(t);
              WriteLn(t, ActivatedLanguage);
              CloseFile(t);
            end
            else
              DeleteFile(PChar(s1 + ExtractFileName(s2) + '.lan')); 
            {$ENDIF}
            AnApplyInstallWasCalled := True;
            
            UninstalledFromMaintenanceState := false;
          end
          
          else
          if
            (not ((not StrToBool(ReadOffset(Derefs, References[i -1], 3))) and
            (not StrToBool(ReadOffset(Derefs, References[i -1], 4))))) and
            (not (AnsiCompareText(GetVariable('SAVEDATA'), 'TRUE') = 0))
            
            then
          
          if (AnsiCompareText(GetVariable('REMOVE'), 'TRUE') = 0) then 
          begin
            
            MustRestoreNativeLogs := false;
            if NativeLogIsPresent then
            begin
              BackupNativeLogs;
              MustRestoreNativeLogs := True;
            end;
            
            if MediaLayout = 2 then
              DeleteFile(PChar(s1 + ProductGUID));
            WipeFolder(s1, True);
            RemoveDirectory(PChar(s1));
            
            if DirectoryExists(s1) then
            begin
              i3 := 0;
              while DirectoryExists(AssertDir(ExtractFilePath(DeAssertDir(s1))) + '~' + IntToStr(i3)) do
                i3 := i3 +1;
              RenameDirPath := AssertDir(ExtractFilePath(DeAssertDir(s1))) + '~' + IntToStr(i3) + PathDelim;
              {$IFDEF INTEROP}
              
              MoveFile(PChar(s1), PChar(RenameDirPath));
              
              MarkFileForDeletion(RenameDirPath + ExtractFileName(MyParamStr(0)));
              {$ELSE}
              MoveFile(PChar(s1), PChar(RenameDirPath));
              MarkFileForDeletion(RenameDirPath + ExtractFileName(s2) + '.exe'); 
              {$ENDIF}
              MarkFileForDeletion(RenameDirPath + 'miax.lib'); 
              MarkFileForDeletion(RenameDirPath);
            end;
            
            UninstalledFromMaintenanceState := True;
            if MustRestoreNativeLogs then
            begin
              
              if not (NativeEngineMode and (GETVARIABLE('NATIVE_LOGGING') = '')) then
                RestoreNativeLogs;
              MustRestoreNativeLogs := false;
            end;
          end;

          {$IFDEF WINDOWS}
          if StrToBool(GetVariable('ALLUSERS')) then 
            dw := $80000002
          else
            dw := $80000001;
          
          {$ENDIF} 
          
          if StrToBool(ReadOffset(Derefs, References[i -1], 3)) or 
            ((not StrToBool(ReadOffset(Derefs, References[i -1], 3))) and (not StrToBool(ReadOffset(Derefs, References[i -1], 4)))) 
          then
          begin
            
            Version7 := ProjectStructVersion;
            Major7 := GetNextNumber(Version7);
            Minor7 :=  GetNextNumber(Version7);
            Version7 := ProjectStructVersion; 
            
            if StrToBool(GetVariable('ALLUSERS')) then
            begin
              ForceDirectories(IncludeTrailingPathDelimiter(MyGetAppConfigDir(True))
                + 'MimarSinan' + PathDelim + 'InstallAware' + PathDelim + 'Ident.Cache'
                + PathDelim);
              AssignFile(t, IncludeTrailingPathDelimiter(MyGetAppConfigDir(True))
                + 'MimarSinan' + PathDelim + 'InstallAware' + PathDelim + 'Ident.Cache'
                + PathDelim + ProductGUID, CP_UTF8);
            end
            else
            begin
              ForceDirectories(IncludeTrailingPathDelimiter(MyGetAppConfigDir(false))
                + 'MimarSinan' + PathDelim + 'InstallAware' + PathDelim + 'Ident.Cache'
                + PathDelim);
              AssignFile(t, IncludeTrailingPathDelimiter(MyGetAppConfigDir(false))
                + 'MimarSinan' + PathDelim + 'InstallAware' + PathDelim + 'Ident.Cache'
                + PathDelim + ProductGUID, CP_UTF8);
            end;
            ReWrite(t);
            WriteLn(t, s3 + RevisionGUID + PathDelim); 
            WriteLn(t, Major7);
            WriteLn(t, Minor7);
            CloseFile(t);
            {$IFDEF WINDOWS}
            lpVersionInformation.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
            GetVersionEx(lpVersionInformation);
            if lpVersionInformation.dwMajorVersion >= 5 then
            begin
              
              r := TRegistry.Create;
              r.RootKey := HKEY(dw);
              r.Access := KEY_WRITE;
              r.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\' + ProductGUID, True); 
              r.WriteString('UninstallString', s1 + ExtractFileName(s2) + '.exe'); 
              r.CloseKey;
              r.Free;
            end;
            
            r := TRegistry.Create;
            r.RootKey := HKEY(dw);
            r.Access := KEY_WRITE;
            r.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\' + GetVariable('TITLE'), True); 
            {$IFDEF INTEROP}
            r.WriteString('DisplayIcon', s1 + ExtractFileName(MyParamStr(0))); 
            {$ELSE}
            r.WriteString('DisplayIcon', s1 + ExtractFileName(s2) + '.exe'); 
            {$ENDIF}
            r.WriteString('DisplayName', GetVariable('TITLE')); 
            {$IFDEF INTEROP}
            r.WriteString('UninstallString', '"' + s1 + ExtractFileName(MyParamStr(0)) + '" REMOVE=TRUE MODIFY=FALSE'); 
            r.WriteString('ModifyPath', s1 + ExtractFileName(MyParamStr(0))); 
            {$ELSE}
            r.WriteString('UninstallString', '"' + s1 + ExtractFileName(s2) + '.exe" REMOVE=TRUE MODIFY=FALSE'); 
            r.WriteString('ModifyPath', s1 + ExtractFileName(s2) + '.exe'); 
            {$ENDIF}
            r.WriteString('Publisher', carPublisher); 
            r.WriteString('Contact', carContact); 
            r.WriteString('HelpLink', carHelp); 
            r.WriteString('URLUpdateInfo', carUpdates); 
            r.WriteString('Comments', carComments); 
            r.WriteString('DisplayVersion', Version7);
            
            r.WriteInteger('VersionMajor', Major7); 
            r.WriteInteger('VersionMinor', Minor7); 
            r.WriteString('InstallLocation', ElimDoubles(GetVariable('TARGETDIR'))); 
            r.CloseKey;
            
            r.Free;
            {$ENDIF}
            
            {$IFDEF INTEROP} 
            
            AssignFile(t, s1 + {$IFDEF DARWIN}ExtractFileNameOnly(MSIFile) + '.app/Contents/' + Ventura +  '/' +{$ENDIF}'instance.dat',cp_utf8); 
            {$ELSE}
            AssignFile(t, s1 + 'instance.dat',cp_utf8); 
            {$ENDIF}
            ReWrite(t);
            WriteLn(t, ProductGUID);
            WriteLn(t, RevisionGUID);
            WriteLn(t, GetVariable('TITLE')); 
            CloseFile(t);
          end
          else
          begin
            
            {$IFDEF WINDOWS}
            r := TRegistry.Create;
            
            if StrToBool(GetVariable('ALLUSERS')) then 
            begin
              r.RootKey := HKEY_LOCAL_MACHINE;
              r.DeleteKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\' + GetVariable('TITLE')); 
              
              r.DeleteKey('SOFTWARE\MimarSinan\InstallAware\Ident.Cache\' + ProductGUID); 
            end
            else
            begin
              r.RootKey := HKEY_CURRENT_USER;
              r.DeleteKey('SOFTWARE\Microsoft\Windows\CurrentVersion\Uninstall\' + GetVariable('TITLE')); 
              
              r.DeleteKey('SOFTWARE\MimarSinan\InstallAware\Ident.Cache\' + ProductGUID); 
            end;
            r.Free;
            {$ENDIF}
          end;
        end;
        Continue;
        {$endregion}
      end;
      if TypesI = 'Terminate Install' then Break; 
      if TypesI = 'Terminate with Exit Code' then 
      begin
      {$region}
        try
          ExitCode := StrToInt(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1)));
        except
          ExitCode := 0;
        end;
        Break;
        {$endregion}
      end;
      if TypesI = 'Comment' then Continue; 
      if TypesI = 'Wend' then
      begin
        ProcessLoop(false);
        LastLoopStack.Delete(LastLoopStack.Count -1);
        Continue;
      end;
      if TypesI = 'Repeat' then
      begin
        LastLoopStack.Add('Repeat');
        ProcessLoop(True); 
        Continue;
      end;
      if TypesI = 'For Each' then
      begin
        
        s1 := ReadOffset(Derefs, References[i -1], 1); 
        if GetStringVar(s1) <> '' then 
          s1 := GetStringVar(s1);
        if ForEachStack.IndexOf(s1) = -1 then
        begin
          LastLoopStack.Add('For Each');
          ProcessLoop(True); 
          ForEachStack.Add(s1);
          ForEachStack.Add(SubstituteVariables(ReadOffset(Derefs, References[i -1], 3))); 
          ForEachStack.Add(SubstituteVariables(ReadOffset(Derefs, References[i -1], 2))); 
        end;
        s2 := ForEachStack[ForEachStack.IndexOf(s1) +1];
        s3 := ForEachStack[ForEachStack.IndexOf(s1) +2];
        
        while AnsiPos(s3, s2) = 1 do
          System.Delete(s2, 1, (AnsiPos(s3, s2) -1) + Length(s3));
        if AnsiPos(s3, s2) = 0 then 
        begin
          s4 := s2;
          s2 := s3; 
        end
        else
        begin
          s4 := Copy(s2, 1, AnsiPos(s3, s2) -1);
          System.Delete(s2, 1, (AnsiPos(s3, s2) -1) + Length(s3));
        end;
        ForEachStack[ForEachStack.IndexOf(s1) +1] := s2;
        if s4 = '' then 
        begin
          ProcessLoop(false);
          LastLoopStack.Delete(LastLoopStack.Count -1);
          ForEachStack.Delete(ForEachStack.Count -1);
          ForEachStack.Delete(ForEachStack.Count -1);
          ForEachStack.Delete(ForEachStack.Count -1);
          SureDeleteVariable(s1);
          Continue;
        end;
        SetVariable(s1, s4, 'For Each Action'); 
        Continue;
        {$endregion}
      end;
      if TypesI = 'Next' then
      begin
      {$region}
        ProcessLoop(false);
        Continue;
        {$endregion}
      end;
      if TypesI = 'Break' then
      begin
      {$region}
        ProcessLoop(false); 
        if LastLoopStack[LastLoopStack.Count -1] = 'For Each' then
        begin

          SureDeleteVariable(ForEachStack[ForEachStack.Count -3]);
          ForEachStack.Delete(ForEachStack.Count -1);
          ForEachStack.Delete(ForEachStack.Count -1);
          ForEachStack.Delete(ForEachStack.Count -1);
        end;
        LastLoopStack.Delete(LastLoopStack.Count -1);
        Continue;
        {$endregion}
      end;
      if TypesI = 'Continue' then
      begin
      {$region}
        ProcessLoop(True); 
        Continue;
       {$endregion}
      end;
      if TypesI = 'Wizard Loop' then 
      begin
      {$region}
        WizardLoop := True;
        WizardDir := 1;
        WizardCacheIndex := 1;
        WizardHandles.Clear;
        i1 := i;
        while not ((Types[i1] = 'End') 
        and (((Comments = nil) or (Comments[i1] <> 'C')))
        and (Types[i1] <> 'Ignore')) do 
        begin
          if (((Comments = nil) or (Comments[i1] <> 'C')))
          and ((Types[i1] <> 'Ignore') and (Types[i1] <> 'Comment')) then 
          begin
            {$IFNDEF INTEROP}
            i2 := LoadDesign(PChar(IntToStr(WizardCacheIndex)),
              PChar(GetDialogResourcePath(ReadOffset(Derefs, References[i1], 1))));
            {$ELSE}
            
            {$ENDIF}
            WizardCacheIndex := WizardCacheIndex +1;
            WizardHandles.Add(IntToStr(i2));
          end;
          i1 := i1 +1;
        end;
        WizardCacheIndex := 0;
        Continue;
        {$endregion}
      end
      else
      if TypesI = 'Define Component' then 
      begin
      {$region}
        
        trS1 := ReadOffset(Derefs, References[i -1], 1);
        trS2 := ReadOffset(Derefs, References[i -1], 3);
        if ActivatedLanguage <> '' then
        begin
          trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1));
          trS2 := SubstituteVariables(GetTransForScrItem(trS2, ReadOffset(Derefs, References[i -1], 0), 2));
          
          if GetComponentRequiredSpace(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1))) <> 0 then
          begin
            ComponentSpaces.Add(trS1);
            ComponentSpaces.Add(IntToStr(GetComponentRequiredSpace(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1)))));
          end;
        end
        else
        begin
          trS1 := SubstituteVariables(trS1);
          trS2 := SubstituteVariables(trS2);
        end;
        
        AddComponent(trS1,
          trS2,
          StrToBool(ReadOffset(Derefs, References[i -1], 2)));
        
        Continue;
        {$endregion}
      end;
      if TypesI = 'Evaluate Expression' then 
      begin
      {$region}
        s := ReadOffset(Derefs, References[i -1], 2);
        if not IsVarDefined(s) then
          SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
        SetVariable(s, Eval(SubstituteVariablesEval(ReadOffset(Derefs, References[i -1], 1))),
          TypesI + ' Action'); 
        Continue;
        {$endregion}
      end;
      if TypesI = 'Copy/Move Local Files' then 
      begin
      {$region}
        if not DoNativeProcessing then
          Break
        else
          Continue;
        {$endregion}
      end;
      if TypesI = 'Read from Binary File' then
      begin
        try
          Enter64BitFileSystem;
          if MyFileExists(ElimDoubles(ReadOffset(Derefs, References[i -1], 1))) then
          begin
            fs1 := TFileStream.Create(ElimDoubles(ReadOffset(Derefs, References[i -1], 1)),
              fmOpenRead or fmShareDenyWrite);
            if (fs1.Size > StrToInt64(ReadOffset(Derefs, References[i -1], 3))) and
              (fs1.Seek(StrToInt64(ReadOffset(Derefs, References[i -1], 3)), soBeginning) =
                StrToInt64(ReadOffset(Derefs, References[i -1], 3))) then
            begin
              c1 := StrToInt(ReadOffset(Derefs, References[i -1], 4));
              GetMem(v1, c1);
              if (fs1.Size >= (StrToInt64(ReadOffset(Derefs, References[i -1], 3)) + c1)) and
                ((fs1.Read(v1^, c1) > 0) and (c1 > 0)) then
                s1 := Trim(PAnsiChar(v1))
              else
                s1 := 'MYAH_READ_FAILED';
              FreeMem(v1);
            end
            else
              s1 := 'MYAH_SEEK_FAILED';
            fs1.Free;
          end
          else
            s1 := 'MYAH_OPEN_FAILED';
          s2 := ReadOffset(Derefs, References[i -1], 2);
          if not IsVarDefined(s2) then
            SureSetVariable(AnsiUpperCase(s2), '', TypesI + ' Action'); 
          SetVariable(s2, s1, TypesI + ' Action'); 
        finally
          Leave64BitFileSystem;
        end;
        Continue;
      end;
      if TypesI = 'Is Native Setup Installed' then 
      begin
      {$region}
        s := ReadOffset(Derefs, References[i -1], 2);
        if not IsVarDefined(s) then SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
        SetVariable(s, MyBoolToStr(NativeQueryProductState(
          ElimDoubles(ReadOffset(Derefs, References[i -1], 1)))
          = INSTALLSTATE_DEFAULT), 'NativeQueryProductState'); 
        {$endregion}
      end;
      if TypesI = 'Get Temporary File' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          s := GetStringVar(ReadOffset(Derefs, References[i -1], 1));
          if s = '' then s := ReadOffset(Derefs, References[i -1], 1);
          GetMem(p, (MAX_PATH+1)*8);
          GetTempFileName(PChar(CachedTempDir), 'mia', 0, p); 
          SureSetVariable(AnsiUpperCase(s), p, TypesI + ' Action'); 
          FreeMem(p);
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Get INI File Settings' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          s := ReadOffset(Derefs, References[i -1], 1);
          if not IsVarDefined(s) then
            SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
          if (ElimDoubles(ReadOffset(Derefs, References[i -1], 3)) = '') or
            (ElimDoubles(ReadOffset(Derefs, References[i -1], 4)) = '') then
          begin
            s1 := ''; 
          end
          else
          begin
            try
              tif := TINIFile.Create(ElimDoubles(ReadOffset(Derefs, References[i -1], 2)));
              s1 := tif.ReadString(ElimDoubles(ReadOffset(Derefs, References[i -1], 3)),
                ElimDoubles(ReadOffset(Derefs, References[i -1], 4)), '');
              tif.Free;
            except
              s1 := ''; 
            end;
          end;
          SetVariable(s, s1, TypesI + ' Action'); 
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Get Environment' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          if SubstituteVariables(ReadOffset(Derefs, References[i -1], 1)) = '' then
            sX := GetAllEnvStrings
          else
          begin
            ExpandEnvironmentStrings1(
              {$IFDEF WINDOWS}'%'{$ELSE}'$'{$ENDIF} +
              SubstituteVariables(ReadOffset(Derefs, References[i -1], 1))
              {$IFDEF WINDOWS}+ '%'{$ENDIF},
              {$IFDEF WINDOWS}True{$ELSE}false{$ENDIF});
            sX := p;
          end;
          s := GetStringVar(ReadOffset(Derefs, References[i -1], 2));
          if s = '' then s := ReadOffset(Derefs, References[i -1], 2);
          SureSetVariable(AnsiUpperCase(s), sX, TypesI + ' Action'); 
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Generate GUID' then 
      begin
      {$region}
        s := GetStringVar(ReadOffset(Derefs, References[i -1], 1));
        if s = '' then s := ReadOffset(Derefs, References[i -1], 1);
        SureSetVariable(AnsiUpperCase(s), MyCreateGUID, TypesI + ' Action'); 
        Continue;
        {$endregion}
      end;
      if TypesI = 'Find All Files' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          s := GetStringVar(ReadOffset(Derefs, References[i -1], 4));
          if s = '' then s := ReadOffset(Derefs, References[i -1], 4);
          
          thfPath := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1)));
          thfRecurse := StrToBool(ReadOffset(Derefs, References[i -1], 2));
          WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 3), Wide1, Wide2);
          if Wide2 = '' then Wide2 := 'FALSE';
          thfFollow := StrToBool(Wide2);
          thfDir := StrToBool(Wide1);
          thfFinished := false;
          MonitorGlobalProgress := True;
          tfaf := TFindAllFilesThread.Create(false);
          repeat
            
            CustomCoolWait(tfaf);
            
            if StrToBool(GetVariable('MYAH_IsCancelled'))  then
            begin
              {$IFDEF USEVARMANAGER}
               VarManager['MYAH_LastActiveTick'] := VarManager['MYAH_LastDelegateTick'];
              {$ELSE}
              SETVARIABLE('MYAH_LastActiveTick',GETVARIABLE('MYAH_LastDelegateTick'),'');
              {$ENDIF}
              tfaf.Terminate;
              {$IFNDEF NOGUI}
              ImageListPool.tfafTimer.Enabled := True;
              {$ENDIF}
            end;
          until thfFinished;
          {$IFNDEF NOGUI}
          ImageListPool.tfafTimer.Enabled := false;
          {$ENDIF}
          if StrToBool(GetVariable('MYAH_IsCancelled'))  then
          begin
            if not StrToBool(GetVariable('ABORTEDONERROR')) then 
            begin
              if not SilentInstall then
              begin
                
                MyMessageBox({$IFNDEF WINDOWS}0{$ELSE}PrimaryWindowHandle{$ENDIF}, PChar(ntv0), PChar(BrandEx),
                  mb_Ok + mb_IconStop);
                
              end;
            end;
            if StrToBool(GetVariable('ABORTONERROR')) then
            begin
              CheckDoNativeRollback;
              Break;
            end
            else
              SetVariable('ABORTEDONERROR', 'TRUE', 'Cancel at Find-Files Time');
          end;
          MonitorGlobalProgress := false;
          if not IsVarDefined(s) then
            SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
          SetVariable(AnsiUpperCase(s), thfList.DelimitedText, TypesI + ' Action'); 
          thfList.Free;
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Does File/Folder Exist' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          s := ReadOffset(Derefs, References[i -1], 1);
          if not IsVarDefined(s) then
            SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
          WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 3), Wide1, Wide2);
          if Wide2 = '' then
            Wide2 := 'FALSE';
          if StrToBool(Wide1) then
            s1 := MyBoolToStr(MyFileExists(
              ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 2))),
              StrToBool(Wide2)))
          else
            s1 := MyBoolToStr(DirectoryExists(
              ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 2))),
              StrToBool(Wide2)));
          SetVariable(s, s1, TypesI + ' Action'); 
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Check Disk Space' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          s := GetStringVar(ReadOffset(Derefs, References[i -1], 1));
          if s = '' then s := ReadOffset(Derefs, References[i -1], 1);
          FreeSpaceAvailable := 0;
          TotalSpace := 0;
          FreeSpaceAvailable := PathFree(ElimDoubles(ReadOffset(Derefs, References[i -1], 2)));
          TotalSpace := PathSize(ElimDoubles(ReadOffset(Derefs, References[i -1], 2)));
          if not IsVarDefined(s) then
            SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
          if StrToBool(ReadOffset(Derefs, References[i -1], 3)) then
            SetVariable(AnsiUpperCase(s), IntToStr(FreeSpaceAvailable), TypesI + ' Action') 
          else
            SetVariable(AnsiUpperCase(s), IntToStr(TotalSpace), TypesI + ' Action'); 
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Set Component Visibility' then 
      begin
      {$region}
        
        trS1 := ReadOffset(Derefs, References[i -1], 1);
        if ActivatedLanguage <> '' then
          trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1))
        else
          trS1 := SubstituteVariables(trS1);
        
        if not StrToBool(ReadOffset(Derefs, References[i -1], 2)) then
        begin
          if IsComponentDefined(trS1) and (not GetComponentHide(trS1)) then
            ComponentHides.Add(trS1);
        end
        else
        begin
          for i1 := 1 to ComponentHides.Count do
            if CompareText(trS1, ComponentHides[i1 -1]) = 0 then
            begin
              ComponentHides.Delete(i1 -1);
              Break;
            end;
        end;
        Continue;
        {$endregion}
      end;
      if TypesI = 'Get Component Space' then 
      begin
      {$region}
        
        trS1 := ReadOffset(Derefs, References[i -1], 1);
        if ActivatedLanguage <> '' then
          trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1))
        else
          trS1 := SubstituteVariables(trS1);
        s1 := ReadOffset(Derefs, References[i -1], 2);
        if s1 = '' then Continue;
        if not IsVarDefined(s1) then
          SureSetVariable(AnsiUpperCase(s1), '', TypesI + ' Action'); 
        
        if trS1 = '' then
          SetVariable(s1,
            IntToStr(GetTotalRequiredSpace()), TypesI + ' Action') 
        else
          SetVariable(s1,
            IntToStr(GetComponentRequiredSpace(trS1)), TypesI + ' Action'); 
        
        Continue;
        {$endregion}
      end;
      if TypesI = 'Set Component Choice' then 
      begin
      {$region}
        
        trS1 := ReadOffset(Derefs, References[i -1], 1);
        if ActivatedLanguage <> '' then
          trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1))
        else
          trS1 := SubstituteVariables(trS1);
        
        if not StrToBool(ReadOffset(Derefs, References[i -1], 2)) then
        begin
          if IsComponentDefined(trS1) and (not GetComponentBars(trS1)) then
            ComponentBars.Add(trS1);
        end
        else
        begin
          for i1 := 1 to ComponentBars.Count do
            if CompareText(trS1, ComponentBars[i1 -1]) = 0 then
            begin
              ComponentBars.Delete(i1 -1);
              Break;
            end;
        end;
        Continue;
        {$endregion}
      end;
      if TypesI = 'Save Feature Selections' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          SaveComponents(
            SubstituteVariables(ReadOffset(Derefs, References[i -1], 1)),
            True);
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Prompt for Text' then
      begin
        trS1 := ReadOffset(Derefs, References[i -1], 1);
        trS2 := ReadOffset(Derefs, References[i -1], 3);
        if ActivatedLanguage <> '' then
        begin
          trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1));
          trS2 := SubstituteVariables(GetTransForScrItem(trS2, ReadOffset(Derefs, References[i -1], 0), 2));
        end
        else
        begin
          trS1 := SubstituteVariables(trS1);
          trS2 := SubstituteVariables(trS2);
        end;
        if not SilentInstall then
        begin
          
          s1 := '';
          s1 := MyInputBox(trS1, trS2, s1);
          
          s2 := ReadOffset(Derefs, References[i -1], 2);
          if not IsVarDefined(s2) then
            SureSetVariable(AnsiUpperCase(s2), '', TypesI + ' Action'); 
          SetVariable(s2, s1, TypesI + ' Action'); 
        end;
        Continue;
      end;
      if TypesI = 'Load Feature Selections' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          if MyFileExists(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1))) then
            LoadComponents(
              SubstituteVariables(ReadOffset(Derefs, References[i -1], 1)),
              True);
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Browse for Folder' then
      begin
        try
          Enter64BitFileSystem;
          trS1 := ReadOffset(Derefs, References[i -1], 1);
          if ActivatedLanguage <> '' then
            trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1))
          else
            trS1 := SubstituteVariables(trS1);
          if not SilentInstall then
          begin
            
            s1 := '';
            MySelectDirectory(trS1, ElimDoubles(ReadOffset(Derefs, References[i -1], 2)), s1);
            s1 := AssertDir(s1);
            
            s2 := ReadOffset(Derefs, References[i -1], 3);
            if not IsVarDefined(s2) then
              SureSetVariable(AnsiUpperCase(s2), '', TypesI + ' Action'); 
            SetVariable(s2, s1, TypesI + ' Action'); 
          end;
        finally
          Leave64BitFileSystem;
        end;
        Continue;
      end;
      if TypesI = 'Browse for File' then
      begin
        try
          Enter64BitFileSystem;
          trS1 := ReadOffset(Derefs, References[i -1], 1);
          trS2 := ReadOffset(Derefs, References[i -1], 7);
          if ActivatedLanguage <> '' then
          begin
            trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1));
            trS2 := SubstituteVariables(GetTransForScrItem(trS2, ReadOffset(Derefs, References[i -1], 0), 2));
          end
          else
          begin
            trS1 := SubstituteVariables(trS1);
            trS2 := SubstituteVariables(trS2);
          end;
          if not SilentInstall then
          begin
            
            s1 := '';
            PromptForFileName(s1, trS2, SubstituteVariables(ReadOffset(Derefs, References[i -1], 5)),
              trS1, ElimDoubles(ReadOffset(Derefs, References[i -1], 6)), StrToBool(ReadOffset(Derefs, References[i -1], 3)));
            
            s2 := ReadOffset(Derefs, References[i -1], 4);
            if not IsVarDefined(s2) then
              SureSetVariable(AnsiUpperCase(s2), '', TypesI + ' Action'); 
            SetVariable(s2, s1, TypesI + ' Action'); 
          end;
        finally
          Leave64BitFileSystem;
        end;
        Continue;
      end;
      if TypesI = 'Replace String' then 
      begin
      {$region}
        s := GetStringVar(ReadOffset(Derefs, References[i -1], 1));
        if s = '' then s := ReadOffset(Derefs, References[i -1], 1);
        b1 := StrToBool(ReadOffset(Derefs, References[i -1], 4));
        b2 := StrToBool(ReadOffset(Derefs, References[i -1], 5));
        if (not b1) and (not b2) then
          trf := [];
        if (b1) and (b2) then
          trf := [rfIgnoreCase, rfReplaceAll];
        if (b1) and (not b2) then
          trf := [rfIgnoreCase];
        if (not b1) and (b2) then
          trf := [rfReplaceAll];
        SureSetVariable(AnsiUpperCase(s),
          StringReplace(MultiLineToSingleLine(GetVariable(s)),
            MultiLineToSingleLine(SubstituteVariables(ReadOffset(Derefs, References[i -1], 2))),
            MultiLineToSingleLine(SubstituteVariables(ReadOffset(Derefs, References[i -1], 3))),
            trf), TypesI + ' Action'); 
        Continue;
        {$endregion}
      end;
      if TypesI = 'Match Regular Expression' then
      begin
        s := GetStringVar(ReadOffset(Derefs, References[i -1], 1));
        trS1 := ReadOffset(Derefs, References[i -1], 2);
        if ActivatedLanguage <> '' then
          trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1))
        else
          trS1 := SubstituteVariables(trS1);
        if s = '' then s := ReadOffset(Derefs, References[i -1], 1);
        re := TRegExpr.Create;
        re.Expression := trS1;
        if re.Exec(SubstituteVariables(ReadOffset(Derefs, References[i -1], 3))) then
          SureSetVariable(AnsiUpperCase(s), 'TRUE',
            
            TypesI + ' Action') 
        else
          SureSetVariable(AnsiUpperCase(s), 'FALSE',
            TypesI + ' Action'); 
        Continue;
      end;
      if TypesI = 'Localization Variable' then 
      begin
      {$region}
        
        sY := ReadOffset(Derefs, References[i -1], 1);
        s := GetStringVar(sY);
        if s = '' then s := sY;
        if not IsVarDefined(s) then
          SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
        trS1 := ReadOffset(Derefs, References[i -1], 2);
        if ActivatedLanguage <> '' then
          trS1 := SubstituteVariables(GetTransForScrItem(trS1, 'CODEGEAR$' + s + '$CODEGEAR', 1)) 
        else
          trS1 := SubstituteVariables(trS1);
        SetVariable(s, trS1, 'Localization Variable Action'); 
        Continue;
        {$endregion}
      end;
      if TypesI = 'Get String Position' then
      begin
        s := GetStringVar(ReadOffset(Derefs, References[i -1], 1));
        if s = '' then s := ReadOffset(Derefs, References[i -1], 1);
        if StrToBool(ReadOffset(Derefs, References[i -1], 4)) then
          SureSetVariable(AnsiUpperCase(s),
            IntToStr(
              AnsiPos(AnsiUpperCase(SubstituteVariables(ReadOffset(Derefs, References[i -1], 2))),
                AnsiUpperCase(SubstituteVariables(ReadOffset(Derefs, References[i -1], 3))))),
            TypesI + ' Action') 
        else
          SureSetVariable(AnsiUpperCase(s),
            IntToStr(
              AnsiPos(SubstituteVariables(ReadOffset(Derefs, References[i -1], 2)),
                SubstituteVariables(ReadOffset(Derefs, References[i -1], 3)))),
            TypesI + ' Action'); 
        Continue;
      end;
      if TypesI = 'Get String Length' then
      begin
        s := GetStringVar(ReadOffset(Derefs, References[i -1], 2));
        if s = '' then s := ReadOffset(Derefs, References[i -1], 2);
        SureSetVariable(AnsiUpperCase(s),
          IntToStr(
            Length(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1)))),
          TypesI + ' Action'); 
        Continue;
      end;
      if TypesI = 'Get Link Target' then
      begin
        {$IFNDEF WINDOWS}
        s := GetStringVar(ReadOffset(Derefs, References[i -1], 2));
        if s = '' then s := ReadOffset(Derefs, References[i -1], 2);
        SureSetVariable(AnsiUpperCase(s), fpReadLink(
          SubstituteVariables(ReadOffset(Derefs, References[i -1], 1))),
          TypesI + ' Action'); 
        {$ENDIF}
        Continue;
      end;
      if TypesI = 'Format String' then
      begin
        s := GetStringVar(ReadOffset(Derefs, References[i -1], 1));
        if s = '' then s := ReadOffset(Derefs, References[i -1], 1);
        lfs := TStringList.Create;
        sfs := SubstituteVariables(ReadOffset(Derefs, References[i -1], 3));
        while AnsiPos(MyLineEnding, sfs) <> 0 do
        begin
          lfs.Add(Copy(sfs, 1, AnsiPos(MyLineEnding, sfs) -1));
          System.Delete(sfs, 1, AnsiPos(MyLineEnding, sfs)  + LengthMyLineEnding -1);
        end;
        sfs := StringReplace(sfs, MyLineEnding, '', [rfReplaceAll, rfIgnoreCase]);
        if sfs <> '' then
          lfs.Add(sfs);
        trS1 := ReadOffset(Derefs, References[i -1], 2);
        if ActivatedLanguage <> '' then
          trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1))
        else
          trS1 := SubstituteVariables(trS1);
        for ifs := 1 to lfs.Count do
          trS1 := StringReplace(trS1, '{' + IntToStr(ifs -1) + '}',
            lfs[ifs -1], [rfReplaceAll, rfIgnoreCase]);
        lfs.Free;
        SureSetVariable(AnsiUpperCase(s), trS1, TypesI + ' Action'); 
        Continue;
      end;
      if TypesI = 'Extract 7Zip Archive' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          thdxTestOnly := false;
          thdxWindow := PrimaryWindowHandle;
          thdxArchive := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1)));
          thdxOutput := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 2)));
          thdxPassword := SubstituteVariables(ReadOffset(Derefs, References[i -1], 4));
          thdxUsePath := StrToBool(ReadOffset(Derefs, References[i -1], 6));
          thdxOverwrite := StrToBool(ReadOffset(Derefs, References[i -1], 5));
          thdxFinished := false;
          
          MonitorGlobalProgress := True;
          tdem := TDirectExtractMedia.Create(false);
          repeat
            
            CustomCoolWait(tdem);
            
            if StrToBool(GetVariable('MYAH_IsCancelled'))  then
            begin
              SetVariable('MYAH_LastActiveTick', GetVariable('MYAH_LastDelegateTick'),'');
              tdem.Terminate;
              {$IFNDEF NOGUI}
              ImageListPool.tdemTimer.Enabled := True;
              {$ENDIF}
            end;
          until thdxFinished = True;
          {$IFNDEF NOGUI}
          ImageListPool.tdemTimer.Enabled := false;
          {$ENDIF}
          if StrToBool(GetVariable('MYAH_IsCancelled'))  then
          begin
            if not StrToBool(GetVariable('ABORTEDONERROR')) then 
            begin
              if not SilentInstall then
              begin
                
                MyMessageBox({$IFNDEF WINDOWS}0{$ELSE}PrimaryWindowHandle{$ENDIF}, PChar(ntv0), PChar(BrandEx),
                  mb_Ok + mb_IconStop);
                
              end;
            end;
            if StrToBool(GetVariable('ABORTONERROR')) then
            begin
              CheckDoNativeRollback;
              Break;
            end
            else
              SetVariable('ABORTEDONERROR', 'TRUE', 'Cancel at Extract-7Zip Time');
          end;
          MonitorGlobalProgress := false;
          s := ReadOffset(Derefs, References[i -1], 3);
          if s <> '' then
          begin
            if not IsVarDefined(s) then
              SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
            if thdxExternalResult then
              SetVariable(s, 'SUCCESS', TypesI + ' Action') 
            else
              SetVariable(s, thdxErrorText, TypesI + ' Action') 
          end;
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Compress 7Zip Archive' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          thcxWindow := PrimaryWindowHandle;
          thcxArchive := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1)));
          thcxPassword := SubstituteVariables(ReadOffset(Derefs, References[i -1], 2));
          thcxRecursive := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 3)));
          thcxNonRecursive := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 4)));
          
          thcxFinished := false;
          thcxParameters := SubstituteVariables(ReadOffset(Derefs, References[i -1], 6));
          
          MonitorGlobalProgress := True;
          tcem := TDirectCompressMedia.Create(false);
          repeat
            CustomCoolWait(tcem);
            if StrToBool(GetVariable('MYAH_IsCancelled')) then
            begin
              SetVariable('MYAH_LastActiveTick', GetVariable('MYAH_LastDelegateTick'),'');
              tcem.Terminate;
              {$IFNDEF NOGUI}
              ImageListPool.tcemTimer.Enabled := True;
              {$ENDIF}
            end;
          until thcxFinished = True;
          {$IFNDEF NOGUI}
          ImageListPool.tcemTimer.Enabled := false;
          {$ENDIF}
          if StrToBool(GetVariable('MYAH_IsCancelled')) then
          begin
            if not StrToBool(GetVariable('ABORTEDONERROR')) then 
            begin
              if not SilentInstall then
              begin
                
                MyMessageBox({$IFNDEF WINDOWS}0{$ELSE}PrimaryWindowHandle{$ENDIF}, PChar(ntv0), PChar(BrandEx),
                  mb_Ok + mb_IconStop);
                
              end;
            end;
            if StrToBool(GetVariable('ABORTONERROR')) then
            begin
              CheckDoNativeRollback;
              Break;
            end
            else
              SetVariable('ABORTEDONERROR', 'TRUE', 'Cancel at Compress-7Zip Time');
          end;
          MonitorGlobalProgress := false;
          s := ReadOffset(Derefs, References[i -1], 10);
          if s <> '' then
          begin
            if not IsVarDefined(s) then
              SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
            if thcxExternalResult then
              SetVariable(s, 'SUCCESS', TypesI + ' Action') 
            else
              SetVariable(s, thcxErrorText, TypesI + ' Action') 
          end;
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Extract Path' then 
      begin
      {$region}
        s := ReadOffset(Derefs, References[i -1], 1);
        s1 := ElimDoubles(GetVariable(s));
        case StrToInt(ReadOffset(Derefs, References[i -1], 2)) of
          0: s1 := ExtractFileName(s1);
          1: s1 := ExtractFileNameOnly(s1);
          2: begin
               s1 := ExtractFileExt(s1);
               if Length(s1) > 0 then
                 if s1[1] = '.' then
                   System.Delete(s1, 1, 1);
             end;
          3: s1 := AssertDir(ExtractFilePath(s1));
          4: s1 := AssertDir(ExtractFilePath(DeAssertDir(ExtractFilePath(s1))));
          5: s1 := AssertDir(ExtractFileDrive(s1));
          
          6: s1 := StringReplace(s1, '\\', '\', [rfReplaceAll]);
          7: s1 := StringReplace(s1, '//', '/', [rfReplaceAll]);
          
        end;
        SetVariable(s, s1, TypesI + ' Action'); 
        Continue;
        {$endregion}
      end;
      if TypesI = 'Run Script' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          rsType := StrToInt(ReadOffset(Derefs, References[i -1], 1));
          rsTimeOut := StrToInt(ReadOffset(Derefs, References[i -1], 2));
          rsSafe := StrToBool(ReadOffset(Derefs, References[i -1], 3));
          rsInteract := StrToBool(ReadOffset(Derefs, References[i -1], 4));
          rsSmartInteract := StrToBool(ReadOffset(Derefs, References[i -1], 5));
          {$IFDEF DARWIN}
          
          rsScript := StringReplace(ReadOffset(Derefs, References[i -1], 7), '$NEWLINE$', #10, [rfReplaceAll, rfIgnoreCase]);
          {$ELSE}
          rsScript := ReadOffset(Derefs, References[i -1], 7);
          {$ENDIF}
          rsScript := SubstituteVariables(rsScript);
          rsResult := '';
          try
            {$IFDEF WINDOWS}
            sms := TSMScriptExecutor.Create(nil);
            if rsType = 0 then sms.Language := slJavaScript
              else sms.Language := slVBScript;
            if rsTimeOut = 0 then
              sms.TimeOut := -1
            else
              sms.TimeOut := rsTimeOut;
            sms.UseSafeSubset := rsSafe;
            if rsInteract then
              sms.AllowUI := True
            else
              if rsSmartInteract then
                sms.AllowUI := not SilentInstall
              else
                sms.AllowUI := false;
            if not SilentInstall then
              sms.Prepare(PrimaryWindowHandle);
            sms.ScriptBody.Clear;
            sms.ExecuteStatement(rsScript);
            sms.Free;
            rsResult := 'COMPLETE';
            {$ENDIF}
            {$IFDEF DARWIN}
            ScriptObj := NSAppleScript.alloc.initWithSource(NSSTR(PAnsiChar(rsScript)));
            if Assigned(ScriptObj) then
            begin
              rsResult := 'COMPLETE';
              EventDesc := ScriptObj.ExecuteAndReturnError(@ErrorInfo);
              if not Assigned(EventDesc) then
                rsResult := 'EXCEPTION';
                
              if (EventDesc.stringValue.UTF8String <> '') and
                (EventDesc.stringValue.UTF8String <> 'true') then
                rsResult := 'EXCEPTION';
                
              ScriptObj.release;
            end
            else
              rsResult := 'EXCEPTION';
              
            {$ENDIF}
          except
            rsResult := 'EXCEPTION';
          end;
          s := ReadOffset(Derefs, References[i -1], 6);
          if s <> '' then
          begin
            if not IsVarDefined(s) then
              SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action');
            SetVariable(s, rsResult, TypesI + ' Action');
          end;
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Convert Path' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          s := ReadOffset(Derefs, References[i -1], 1);
          b := StrToBool(ReadOffset(Derefs, References[i -1], 2));
          s1 := ElimDoubles(GetVariable(s));

          if GetExpandedEnvVars(s1) <> '' then
            s1 := GetExpandedEnvVars(s1);
            
          {$IFNDEF WINDOWS}
          if AnsiPos('~', s1) = 1 then
            s1 := ExpandFileName(s1);
          {$ENDIF}
          
          {$IFDEF WINDOWS}
          if ExtractFileDrive(s1) = '' then
          {$ELSE}
          if AnsiPos('/', s1) <> 1 then
          {$ENDIF}
            s1 := AssertDir(ElimDoubles(GetVariable('SETUPPATH'))) + s1;
            
          if ExpandFileName(s1) <> '' then
            s1 := ExpandFileName(s1);
            
          if DirectoryExists(s1) or MyFileExists(s1)  then
          begin
            if b then GetShortPath(s1, s1)
              else GetLongPath(s1, s1);
            SetVariable(s, s1, TypesI + ' Action'); 
          end
          else
            SetVariable(s, '', TypesI + ' Action'); 
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Convert Case' then 
      begin
      {$region}
        s := ReadOffset(Derefs, References[i -1], 1);
        b := StrToBool(ReadOffset(Derefs, References[i -1], 2));
        s1 := ElimDoubles(GetVariable(s));
        if b then s1 := AnsiUpperCase(s1)
          else s1 := AnsiLowerCase(s1);
        SetVariable(s, s1, TypesI + ' Action'); 
        Continue;
        {$endregion}
      end;
      if TypesI = 'Check File Version' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          s := ReadOffset(Derefs, References[i -1], 1);
          if not IsVarDefined(s) then
            SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
          GetFileVersion(ElimDoubles(
            SubstituteVariables(ReadOffset(Derefs, References[i -1], 2))),
            MajorHi1, MajorLo1, MinorHi1, MinorLo1, Major1, Minor1);
          if StrToBool(ReadOffset(Derefs, References[i -1], 3)) then
          begin
            GetFileVersion(ElimDoubles(
              SubstituteVariables(ReadOffset(Derefs, References[i -1], 4))),
              MajorHi2, MajorLo2, MinorHi2, MinorLo2, Major2, Minor2);
          end
          else
          begin
            s1 := SubstituteVariables(ReadOffset(Derefs, References[i -1], 5));
            MajorHi2 := GetNextNumber(s1);
            MajorLo2 := GetNextNumber(s1);
            MinorHi2 := GetNextNumber(s1);
            MinorLo2 := GetNextNumber(s1);
          end;
          b := True;
          if MajorHi1 < MajorHi2 then b := false
            else if MajorHi1 = MajorHi2 then
            begin
              if MajorLo1 < MajorLo2 then b := false
                else if MajorLo1 = MajorLo2 then
                begin
                  if MinorHi1 < MinorHi2 then b := false
                    else if MinorHi1 = MinorHi2 then
                      if MinorLo1 <= MinorLo2 then b := false;
                end;
            end;
          SetVariable(s, MyBoolToStr(b), TypesI + ' Action'); 
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Get File Version' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          GetFileVersion(ElimDoubles(
            SubstituteVariables(ReadOffset(Derefs, References[i -1], 1))),
            MajorHi1, MajorLo1, MinorHi1, MinorLo1, Major1, Minor1);
          sX := IntToStr(MajorHi1) + '.' + IntToStr(MajorLo1) + '.' +
            IntToStr(MinorHi1) + '.' + IntToStr(MinorLo1);
          s := GetStringVar(ReadOffset(Derefs, References[i -1], 2));
          if s = '' then s := ReadOffset(Derefs, References[i -1], 2);
          SureSetVariable(AnsiUpperCase(s), sX, TypesI + ' Action'); 
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Get File Size' then
      begin
        try
          Enter64BitFileSystem;
          if ReadOffset(Derefs, References[i -1], 1) <> '' then
          begin
            s1 := ReadOffset(Derefs, References[i -1], 1);
            if not IsVarDefined(s1) then
              SureSetVariable(AnsiUpperCase(s1), '', TypesI + ' Action'); 
            s2 := IntToStr(FileUtil.FileSize(ElimDoubles(ReadOffset(Derefs, References[i -1], 2))));
            SetVariable(s1, s2, TypesI + ' Action'); 
          end;
        finally
          Leave64BitFileSystem;
        end;
        Continue;
      end;
      if TypesI = 'Get Native Settings' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if not IsVarDefined(s) then
          SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
        case StrToInt(ReadOffset(Derefs, References[i -1], 2)) of
          
          0: if {$IFNDEF WINDOWS}FpGetEUID = 0{$ELSE}IsUserAdmin{$ENDIF} then
               s1 := 'TRUE'
             else
               s1 := 'FALSE';
          1: s1 := FloatToStr(GetOSDetails.PhysicalMemoryGB *1024 *1024);
          2: s1 := {$IFNDEF NOGUI}IntToStr(Screen.Height){$ELSE}'0'{$ENDIF};
          3: s1 := {$IFNDEF NOGUI}IntToStr(Screen.Width){$ELSE}'0'{$ENDIF};
          4: s1 := {$IFNDEF NOGUI}IntToStr(ScreenInfo.ColorDepth){$ELSE}'0'{$ENDIF};
          5: s1 := {$IFNDEF NOGUI}IntToStr(ScreenInfo.PixelsPerInchY){$ELSE}'0'{$ENDIF};
          6: s1 := {$IFNDEF NOGUI}IntToStr(ScreenInfo.PixelsPerInchX){$ELSE}'0'{$ENDIF};
          7: s1 := GetVariable('PLATFORM');
          8: s1 := GetVariable('PLATFORMFULL');
          9: s1 := GetOSDetails.OSVersion_String;
          
          10: begin
                s1 := '';
                LazGetLanguageIDs(s1, s1);
              end;
          11: s1 := GetOSDetails.Username;
          12: s1 := {$IFNDEF WINDOWS}GetGroupName(GetUserGid(GetOSDetails.Username)){$ELSE}''{$ENDIF};
          13: s1 := GetOSDetails.Hostname;
          14: s1 := IntToStr(GetOSDetails.CPUCount);
          15: s1 := IntToStr(GetOSDetails.OSVersion_Major);
          16: s1 := IntToStr(GetOSDetails.OSVersion_Minor);
          17: s1 := IntToStr(GetOSDetails.OSVersion_Patch);
          18: s1 := GetOSDetails.FullUsername;
          19: s1 := FloatToStr(GetOSDetails.SecondsUptime);
        end;
        SetVariable(s, s1, TypesI + ' Action'); 
        Continue;
      end;
      if TypesI = 'Refresh Shell' then 
      begin
        DoRefreshShell;
        NativeShellChangeNotify := false; 
        Continue;
      end;
      if TypesI = 'Read from Text File' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          s1 := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1)));
          s2 := ReadOffset(Derefs, References[i -1], 2);
          if not IsVarDefined(s2) then
            SureSetVariable(AnsiUpperCase(s2), '', TypesI + ' Action'); 
          s3 := ReadOffset(Derefs, References[i -1], 3);
          if (s3 <> '') and not IsVarDefined(s3) then
            SureSetVariable(AnsiUpperCase(s3), '', TypesI + ' Action'); 
          
          ReadAllFile := false;
          if Pos('#READALL\', s1) = 1 then
          begin
            System.Delete(s1, 1, Length('#READALL\'));
            ReadAllFile := True;
          end;
          
          if AnsiLowerCase(activeText) <> AnsiLowerCase(s1) then
          begin
            try
              if activeText <> '' then
                CloseFile(inText);
              activeText := '';
            except
              activeText := '';
            end;
            try
              {$IFDEF INTEROP}
              FileMode := 0;
              {$ENDIF}
              if MyFileExists(s1) then
              begin
                AssignFile(inText, s1, cp_utf8);
                Reset(inText);
                if not eof(inText) then
                begin
                  read(inText, BOM);
                  if ansicomparetext(BOM, #$FEFF) <> 0 then
                  begin
                    closefile(inText);
                    reset(inText);
                  end;
                end;
                activeText := s1;
              end
              else
              begin
                activeText := '';
                
                if s3 <> '' then
                  SetVariable(s3, 'TRUE', TypesI + ' Action'); 
              end;
            except
              activeText := '';
              if s3 <> '' then
                SetVariable(s3, 'TRUE', TypesI + ' Action'); 
              Continue;
            end;
          end;
          
          if MyFileExists(s1) then
          begin
            if not EOF(inText) then
            begin
              if ReadAllFile then
              begin
                sZ := '';
                while not EOF(inText) do
                begin
                  ReadLn(inText, sX);
                  if EOF(inText) then
                    sZ := sZ + sX
                  else
                    sZ := sZ + sX + '$NEWLINE$';
                end;
                SetVariable(s2, sZ, TypesI + ' Action'); 
              end
              else
              begin
                ReadLn(inText, sX);
                SetVariable(s2, sX, TypesI + ' Action'); 
              end;
            end;
            if EOF(inText) then
            begin
              sX := 'TRUE'; 
              activeText := '';
              try
                CloseFile(inText);
              except
              end;
            end
              else sX := 'FALSE'; 
            if s3 <> '' then
              SetVariable(s3, sX, TypesI + ' Action'); 
          end;
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Parse String' then 
      begin
      {$region}
        ParseSource := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1)));
        ParseSeek := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 2)));
        s2 := ReadOffset(Derefs, References[i -1], 3);
        if (s2 <> '') and not IsVarDefined(s2) then
          SureSetVariable(AnsiUpperCase(s2), '', TypesI + ' Action'); 
        s3 := ReadOffset(Derefs, References[i -1], 4);
        if (s3 <> '') and not IsVarDefined(s3) then
          SureSetVariable(AnsiUpperCase(s3), '', TypesI + ' Action'); 
        
        if StrToBool(ReadOffset(Derefs, References[i -1], 7)) then
        begin
          ParseSource := AnsiLowerCase(ParseSource);
          ParseSeek := AnsiLowerCase(ParseSeek);
        end;
        
        ParsePoint := 0;
        ParseJump := 1;
        ParseSkip := 1;
        case StrToInt(ReadOffset(Derefs, References[i -1], 5)) of
          
          0: begin
               ParseJump := Length(ParseSeek);
               
               ParsePoint := Pos(ParseSeek, ParseSource);
               
               if ParsePoint = 0 then
                 ParsePoint := Length(ParseSource) +1;
             end;
          1: begin
               ParseJump := Length(ParseSeek);
               ParseFloat := Length(ParseSource);
               
               while ParseFloat > 0 do
               begin
                 if ParsePoint = 0 then
                   
                   ParsePoint := PosEx(ParseSeek, ParseSource, ParseFloat);
                   
                 ParseFloat := ParseFloat -1;
                 
               end;
               
               if ParsePoint = 0 then
               begin
                 ParsePoint := 1;
                 ParseJump := 0;
               end;
             end;
          2: try
               ParseSkip := 0;
               ParsePoint := StrToInt(ParseSeek);
               if ParsePoint = 0 then 
               begin
                 ParsePoint := 1;
                 ParseSkip := 1;
                 ParseJump := -1;
               end;
             except
               ParsePoint := 0;
             end;
          3: try
               ParseSkip := 0;
               ParsePoint := Length(ParseSource) - StrToInt(ParseSeek);
             except
               ParsePoint := 0;
             end;
        end;
        if ParsePoint = 0 then
        begin
          ParseLeft := '';
          ParseRight := '';
        end
        else
        begin
          ParseSource := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1)));
          ParseSeek := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 2)));
          ParseLeft := Copy(ParseSource, 1, ParsePoint - ParseSkip);
          ParseRight := Copy(ParseSource, ParsePoint + ParseJump, Length(ParseSource));
        end;
        
        if StrToBool(ReadOffset(Derefs, References[i -1], 6)) then
        begin
          ParseLeft := Trim(ParseLeft);
          ParseRight := Trim(ParseRight);
        end;
        
        if s2 <> '' then
          SureSetVariable(AnsiUpperCase(s2), ParseLeft, TypesI + ' Action'); 
        if s3 <> '' then
          SureSetVariable(AnsiUpperCase(s3), ParseRight, TypesI + ' Action'); 
          {$endregion}
      end;
      if TypesI = 'Mathematics' then 
      begin
      {$region}
        s := ReadOffset(Derefs, References[i -1], 4);
        if not IsVarDefined(s) then
          SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
        try
          i364 := StrToInt64(ReadOffset(Derefs, References[i -1], 3));
          if i364 <> 11 then
            i164 := StrToInt64(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1)));
          if (i364 < 10) or (i364 = 13) then
            i264 := StrToInt64(SubstituteVariables(ReadOffset(Derefs, References[i -1], 2)));
          case i364 of
            0: i464 := i164 + i264;
            1: i464 := i164 - i264;
            2: i464 := i164 * i264;
            3: i464 := i164 div i264;
            4: i464 := i164 mod i264;
            5: i464 := i164 and i264;
            6: i464 := i164 or i264;
            7: i464 := i164 xor i264;
            8: i464 := i164 shl i264;
            9: i464 := i164 shr i264;
           10: i464 := not i164;
           11: i464 := Ord(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1))[1]);
           12: s1 := Chr(i164);
           13: begin
                 RandSeed1 := i164;
                 RandSeed2 := i264;
                 i464 := i164 + i264;
               end;
           14: begin
                 RandSeed := i164;
                 i464 := RandSeed;
               end;
           15: begin
                 i464 := RandSeed1 * RandSeed + RandSeed2;
                 RandSeed := i464 mod 32767;
                 i464 := i464 mod i164;
               end;
          end;
          if i364 <> 12 then
            s1 := IntToStr(i464);
        except
          s1 := '';
        end;
        if s <> '' then
          SetVariable(s, s1, TypesI + ' Action'); 
          {$endregion}
      end;
      if TypesI = 'Write to Text File' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          s1 := ElimDoubles(SubstituteVariables(ReadOffset(Derefs, References[i -1], 1)));
          s2 := SubstituteVariables(ReadOffset(Derefs, References[i -1], 2));
          if AnsiLowerCase(activeText) = AnsiLowerCase(s1) then
          try
            CloseFile(inText);
          except
          end;
          outText := TStringList.Create;
          try
            outText.LoadFromFile(s1, TEncoding.UTF8);
          except
            outText.Clear;
          end;
          if StrToBool(SubstituteVariables(ReadOffset(Derefs, References[i -1], 3))) then
            outText.Insert(0, s2)
          else
            outText.Add(s2);
          SetFileAttributes(PChar(s1), FILE_ATTRIBUTE_NORMAL);
          try
            outText.SaveToFile(s1, TEncoding.UTF8);
          except
          end;
          outText.Free;
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Delete Component' then 
      begin
      {$region}
        
        trS1 := ReadOffset(Derefs, References[i -1], 1);
        if ActivatedLanguage <> '' then
          trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1))
        else
          trS1 := SubstituteVariables(trS1);
        
        if IsComponentDefined(trS1) and (not GetComponentDelete(trS1)) then
          ComponentDeletes.Add(trS1);
        Continue;
        {$endregion}
      end;
      if TypesI = 'Get Component State' then 
      begin
      {$region}
        
        trS1 := ReadOffset(Derefs, References[i -1], 1);
        if ActivatedLanguage <> '' then
          trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1))
        else
          trS1 := SubstituteVariables(trS1);
        s1 := ReadOffset(Derefs, References[i -1], 2);
        if s1 = '' then Continue;
        if not IsVarDefined(s1) then
          SureSetVariable(AnsiUpperCase(s1), '', TypesI + ' Action'); 
        
        SetVariable(s1,
          MyBoolToStr(GetSelection(trS1), True), TypesI + ' Action'); 
        
        Continue;
        {$endregion}
      end;
      if TypesI = 'Set Component State' then 
      begin
      {$region}
        
        trS1 := ReadOffset(Derefs, References[i -1], 1);
        if ActivatedLanguage <> '' then
          trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1))
        else
          trS1 := SubstituteVariables(trS1);
        
        SetSelection(trS1,
          StrToBool(ReadOffset(Derefs, References[i -1], 2)));
        
        Continue;
        {$endregion}
      end;
      if TypesI = 'Set Component Space' then 
      begin
      {$region}
        
        trS1 := ReadOffset(Derefs, References[i -1], 1);
        if ActivatedLanguage <> '' then
          trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1))
        else
          trS1 := SubstituteVariables(trS1);
        
        if TryStrToInt64(SubstituteVariables(ReadOffset(Derefs, References[i -1], 2)), i641) then
          if IsComponentDefined(trS1) then
          begin
            b1 := false;
            for i2 := 1 to ComponentSpaces.Count do
              if AnsiUpperCase(ComponentSpaces[i2 -1]) = AnsiUpperCase(trS1) then
              begin
                ComponentSpaces[i2] := IntToStr(i641);
                b1 := True;
                Break;
              end;
            if not b1 then
            begin
              ComponentSpaces.Add(trS1);
              ComponentSpaces.Add(IntToStr(i641));
            end;
          end;
        Continue;
        {$endregion}
      end
      else
      if TypesI = 'Remove Directory' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          DeleteDirectory(PChar(ElimDoubles(ReadOffset(Derefs, References[i -1], 1))), false);
          RemoveDirectory(PChar(ElimDoubles(ReadOffset(Derefs, References[i -1], 1))));
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end;
      if TypesI = 'Delete Files Recursive' then 
      begin
      {$region}
        try
          Enter64BitFileSystem;
          lX := nil;
          repeat
            if lX <> nil then
              lX.Free;
            lX := FindAllFilesEx(ElimDoubles(ReadOffset(Derefs, References[i -1], 1)),
              True);
            i1 := lX.Count;
            for i2 := lX.Count downto 1 do
            begin
              SetFileAttributes(PChar(lX[i2 -1]), FILE_ATTRIBUTE_NORMAL);
              DeleteFile(PChar(lX[i2 -1]));
            end;
            for i2 := lX.Count downto 1 do
              RemoveDirectory(PChar(lX[i2 -1]));
            lX.Free;
            lX := FindAllFilesEx(ElimDoubles(ReadOffset(Derefs, References[i -1], 1)),
              True);
          until lX.Count = i1;
          lX.Free;
          lX := nil;
          Continue;
        finally
          Leave64BitFileSystem;
        end;
        {$endregion}
      end
      else
      if TypesI = 'Sleep' then
      begin
        sDuration := StrToInt(ReadOffset(Derefs, References[i -1], 1));
        sFinished := false;
        MonitorGlobalProgress := True;
        ts := TSleep.Create(false);
        repeat
          DelegateBindProgress(GetVariable('PROGRESSTEXT'), 
            StrToInt(GetVariable('PROGRESS')), 100, 0); 
          CustomCoolWait(ts);
          if StrToBool(GetVariable('MYAH_IsCancelled')) then
          begin
            
            ts.Terminate;
            {$IFNDEF NOGUI}
            ImageListPool.sTimer.Enabled := True;
            {$ENDIF}
          end;
        until sFinished;
        {$IFNDEF NOGUI}
        ImageListPool.sTimer.Enabled := false;
        {$ENDIF}
        if StrToBool(GetVariable('MYAH_IsCancelled'))  then
        begin
          if not StrToBool(GetVariable('ABORTEDONERROR')) then 
          begin
            if not SilentInstall then
            begin
              
              MyMessageBox({$IFNDEF WINDOWS}0{$ELSE}PrimaryWindowHandle{$ENDIF}, PChar(ntv0), PChar(BrandEx),
                mb_Ok + mb_IconStop);
              
            end;
          end;
          if StrToBool(GetVariable('ABORTONERROR')) then
          begin
            CheckDoNativeRollback;
            Break;
          end
          else
            SetVariable('ABORTEDONERROR', 'TRUE', 'Cancel at Run-Program Time');
        end;
        MonitorGlobalProgress := false;
        Continue;
      end
      else
      if TypesI = 'MessageBox' then 
      begin
      {$region}
        
        trS1 := ReadOffset(Derefs, References[i -1], 1);
        trS2 := ReadOffset(Derefs, References[i -1], 2);
        if ActivatedLanguage <> '' then
        begin
          trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1));
          trS2 := SubstituteVariables(GetTransForScrItem(trS2, ReadOffset(Derefs, References[i -1], 0), 2));
        end
        else
        begin
          trS1 := SubstituteVariables(trS1);
          trS2 := SubstituteVariables(trS2);
        end;
        case StrToInt(ReadOffset(Derefs, References[i -1], 3)) of
          0: i2 := mb_IconInformation;
          1: i2 := mb_IconQuestion;
          2: i2 := mb_IconExclamation;
          3: i2 := mb_IconStop;
        end;
        case StrToInt(ReadOffset(Derefs, References[i -1], 4)) of
          0: i2 := i2 + mb_AbortRetryIgnore;
          1: i2 := i2 + mb_OK;
          2: i2 := i2 + mb_OKCancel;
          3: i2 := i2 + mb_RetryCancel;
          4: i2 := i2 + mb_YesNo;
          5: i2 := i2 + mb_YesNoCancel;
        end;
        if not SilentInstall then
        begin
          i1 := MyMessageBoxFunction(
            PChar(trS2),
            PChar(trS1),
            i2);
          
          i3 := i1; 
          if i3 = 0 then
            i1 := MyMessageBoxFunction(
             PChar(trS2),
              PChar(trS1),
              i2);
          if ReadOffset(Derefs, References[i -1], 5) <> '' then
          begin
            s1 := ReadOffset(Derefs, References[i -1], 5);
            if not IsVarDefined(s1) then
              SureSetVariable(AnsiUpperCase(s1), '', TypesI + ' Action'); 
            case i1 of
              id_Abort: s2 := 'ABORT'; 
              id_Retry: s2 := 'RETRY'; 
              id_Ignore: s2 := 'IGNORE'; 
              id_OK: s2 := 'OK'; 
              id_Cancel: s2 := 'CANCEL'; 
              id_Yes: s2 := 'YES'; 
              id_No: s2 := 'NO'; 
            end;
            SetVariable(s1, s2, TypesI + ' Action'); 
          end;
        end;
        Continue;
        {$endregion}
      end
      else
      if ((TypesI = 'If') or (TypesI = 'Else If')) or ((TypesI = 'While') or (TypesI = 'Until')) then 
      begin
      {$region}
        b := True;
        
        trS1 := ReadOffset(Derefs, References[i -1], 1);
        trS2 := ReadOffset(Derefs, References[i -1], 3);
        if ActivatedLanguage <> '' then
        begin
          trS1 := GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1);
          trS2 := GetTransForScrItem(trS2, ReadOffset(Derefs, References[i -1], 0), 2);
        end;
        
        if ReadOffset(Derefs, References[i -1], 2) = '5' then
        begin
          if not ((IsVarDefined(trS1) xor StrToBool(ReadOffset(Derefs, References[i -1], 4)))) then
          begin
            if not ((TypesI = 'While') or (TypesI = 'Until')) then
              SkipToElseOrEnd := True
            else
            begin
              if TypesI = 'While' then
                ProcessLoop(false)
              else
                ProcessLoop(True);
            end;
          end
          else
          begin
            if not ((TypesI = 'While') or (TypesI = 'Until')) then
              DeferSkipToEnd := DeferSkipToEnd +1
            else
            begin
              if TypesI = 'While' then
              begin
                ProcessLoop(True);
                LastLoopStack.Add('While');
              end
              else
              begin
                ProcessLoop(false);
                LastLoopStack.Delete(LastLoopStack.Count -1);
              end;
            end;
          end;
          Continue;
        end;
        
        s1 := GetStringVar(trS1);
        if s1 = '' then s1 := trS1;
        s1 := GetVariable(s1);
        
        s1 := SubstituteVariables(s1);
        
        s2 := SubstituteVariables(trS2);
        if ReadOffset(Derefs, References[i -1], 2) = '6' then
        begin
          if not ((CompareStringVersion(s1, s2) xor StrToBool(ReadOffset(Derefs, References[i -1], 4)))) then
          begin
            if not ((TypesI = 'While') or (TypesI = 'Until')) then
              SkipToElseOrEnd := True
            else
            begin
              if TypesI = 'While' then
                ProcessLoop(false)
              else
                ProcessLoop(True);
            end;
          end
          else
          begin
            if not ((TypesI = 'While') or (TypesI = 'Until')) then
              DeferSkipToEnd := DeferSkipToEnd +1
            else
            begin
              if TypesI = 'While' then
              begin
                ProcessLoop(True);
                LastLoopStack.Add('While');
              end
              else
              begin
                ProcessLoop(false);
                LastLoopStack.Delete(LastLoopStack.Count -1);
              end;
            end;
          end;
          Continue;
        end;
        b := TryStrToInt64(s1, i164) and TryStrToInt64(s2, i264);
        
        bX := StrToBool(ReadOffset(Derefs, References[i -1], 4));
        
        bXX := false;
        if b then
        begin
          if ReadOffset(Derefs, References[i -1], 2) = '0' then
            bXX := i164 = i264;
          if ReadOffset(Derefs, References[i -1], 2) = '1' then
            bXX := i164 = i264;
          if ReadOffset(Derefs, References[i -1], 2) = '2' then
            bXX := i164 > i264;
          if ReadOffset(Derefs, References[i -1], 2) = '3' then
            bXX := i164 = i264;
          if ReadOffset(Derefs, References[i -1], 2) = '4' then
            bXX := i164 = i264;
        end
        else
        begin
          if ReadOffset(Derefs, References[i -1], 2) = '0' then
            bXX := s1 = s2;
          if ReadOffset(Derefs, References[i -1], 2) = '1' then
            bXX := AnsiPos(s2, s1) <> 0;
          if ReadOffset(Derefs, References[i -1], 2) = '2' then
            bXX := s1 > s2;
          if ReadOffset(Derefs, References[i -1], 2) = '3' then
            bXX := ytm_SmartPos(s2, s1, false) <> 0;
          if ReadOffset(Derefs, References[i -1], 2) = '4' then
            bXX := CompareText(s1, s2) = 0;
        end;
        bXX := bX xor bXX;
        if not bXX then
        begin
          if not ((TypesI = 'While') or (TypesI = 'Until')) then
            SkipToElseOrEnd := True
          else
            begin
              if TypesI = 'While' then
                ProcessLoop(false)
              else
                ProcessLoop(True);
            end;
        end
        else
        begin
          if not ((TypesI = 'While') or (TypesI = 'Until')) then
            DeferSkipToEnd := DeferSkipToEnd +1
          else
            begin
              if TypesI = 'While' then
              begin
                ProcessLoop(True);
                LastLoopStack.Add('While');
              end
              else
              begin
                ProcessLoop(false);
                LastLoopStack.Delete(LastLoopStack.Count -1);
              end;
            end;
        end;
        Continue;
      end
      else
      if TypesI = 'Set Variable' then 
      begin
      {$region}
        
        trS1 := ReadOffset(Derefs, References[i -1], 2);
        if ActivatedLanguage <> '' then
          trS1 := SubstituteVariables(GetTransForScrItem(trS1, ReadOffset(Derefs, References[i -1], 0), 1))
        else
          trS1 := SubstituteVariables(trS1);
        sY := ReadOffset(Derefs, References[i -1], 1);
        if Pos('$MYAH$MYAH$', sY) <> 0 then 
        begin
          System.Delete(sY, 1, Pos('$MYAH$MYAH$', sY) + Length('$MYAH$MYAH$') -1); 
          by := MyStrToBool(sY) ; 
          sY := ReadOffset(Derefs, References[i -1], 1);
          System.Delete(sY, Pos('$MYAH$MYAH$', sY), Length(sY)); 
        end
        else
          bY := false;
        s := GetStringVar(sY);
        if s = '' then s := sY;
        if not IsVarDefined(s) then
          SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
        
        if AnsiSameText(s, 'NATIVE_LOGGING') then
          if GETVARIABLE('NATIVE_LOGGING') <> trS1 then 
          begin
            if trS1 = '' then
              
              NativeAppendToLog(NativeLogGuessPath) 
            else
            if not AnsiSameText(trS1, 'FALSE') then
            begin
              
              if NativeLogTestPath(trS1, True) then
              begin
                if NativeLogElements.Count <> 0 then 
                  NativeAppendToLog(NativeLogGuessPath); 
              end
              else
                trS1 := ''; 
            end;
          end;
        SetVariable(s, trS1, 'Set Variable Action'); 
        if bY then
          if PersistVariables.IndexOf(s) = -1 then
            PersistVariables.Add(s);
        
        if AnsiSameText(s, 'ABORT') then
          SetVariable('MYAH_IsCancelled', trS1, 'Set Variable Tricke');
        if AnsiSameText(s, 'MYAH_TIMEOUT') then
          if not TryStrToInt(trS1, bitchBackupCustomTimeOut) then
            bitchBackupCustomTimeOut := 10;
        
        MonitorGlobalProgress := True;
        if AnsiSameText(s, 'PROGRESS') or AnsiSameText(s, 'PROGRESSTEXT') then
          BindProgress(GetVariable('PROGRESSTEXT'), 
            StrToInt(GetVariable('PROGRESS')), 100, 0); 
        MonitorGlobalProgress := false;
        Continue;
        {$endregion}
      end
      else
      if TypesI = 'Return from Include Script' then
      begin
        idSX := ReadOffset(Derefs, References[i -1], 1);
        if idS = '0' then Continue; 
        repeat
          i := i +1;
        until GetLineNumber(IncludeDepthDirect[i -1]) = idI -1;
        i := i -1;
         
        if idS <> '' then 
        begin
          if not IsVarDefined(idS) then
            SureSetVariable(AnsiUpperCase(idS), '', TypesI + ' Action'); 
          SetVariable(idS, SubstituteVariables(idSX), TypesI + ' Action');
        end;
        Continue;
      end
      else
      if TypesI = 'GoTo Label' then 
      begin
        {$region 'GoTo Label'}
        s := ReadOffset(Derefs, References[i -1], 1);
        i := StrToInt(Labels[Labels.IndexOf(AnsiUpperCase(s)) +1]) ;
        DeferSkipToEnd := 0;
        SkipToEnd := false;
        SkipToElseOrEnd := false;
        ReEnding := false;
        WizardLoop := false;
        JustOutWizardLoop := false;
        Continue;
        {$endregion 'GoTo Label'}
      end;
      Continue;
      {$endregion}
    end;
  except
    on E: Exception do
    begin
      if not SilentInstall then
      begin
        {$IFDEF INTEROP}
        MyMessageBox({$IFNDEF WINDOWS}0{$ELSE}PrimaryWindowHandle{$ENDIF}, PChar(msg19 + MyLineEnding + MyLineEnding +
          
          'Source File: ' + GetUnitName(PullMapDirect[i -1]) + MyLineEnding +
          'Line Number: ' + IntToStr(GetLineNumber(PullMapDirect[i -1]) +1) + MyLineEnding + MyLineEnding +
          E.Message), PChar(BrandEx), mb_OK + mb_IconStop);
        {$ELSE}
        MessageBoxFunction(PChar(msg19 + MyLineEnding + MyLineEnding +
          
          'Source File: ' + GetUnitName(PullMapDirect[i -1]) + MyLineEnding +
          'Line Number: ' + IntToStr(GetLineNumber(PullMapDirect[i -1]) +1) + MyLineEnding + MyLineEnding +
          E.Message), PChar(BrandEx), mb_OK + mb_IconStop);
        MyPlaySound(PChar(EXEDIR + 'audio' + PathDelim + 'exception.wav')); 
        {$ENDIF}
      end;
      ExitScript(false);
      Exit;
    end;
  end;
  WriteToLog('    </myah>');
  WriteToLog('    <ExitScript>');
  ExitScript(True);
  WriteToLog('    </ExitScript>');
  
  {$IFDEF INTEROP}
  
  {$ENDIF}
end;

function RunScript(Types, References, Comments, Webs: TStrings; Derefs: TList;
  Callback: TRunScriptCallback; MSIFile: String; DLL: Boolean = false): Boolean;
var
  lX: TStringList;
  i: Integer;
  {$IFNDEF INTEROP}
  l: TList;
  s: String;
  {$ENDIF}
  s1: String;
  escondido: String;
  sX: String;
begin
  {$IFDEF INTEROP}
  try
    Result := RunScriptEx(Types, References, Comments, Webs, Derefs, Callback, MSIFile, DLL);
  finally
    
    try
      if RuntimeSubstituteCompilerVariables('#CACHESOURCES#') <> '' then
        if not MyStrToBool(AnsiUpperCase(RuntimeSubstituteCompilerVariables('#CACHESOURCES#')), True)  then
          if MediaLayout = 2 then
          begin
            
            s1 := SniffSafeUserPath(GetAllUserInstallState(MSIFile));
            s1 := s1 + RevisionGUID + DirectorySeparator;
            lX := FindAllDirs(s1, false);
            for i := 1 to lX.Count do
              if AnsiCompareText(ExtractFileName(DeAssertDir(lX[i -1])), 'OFFLINE') <> 0 then 
                {$IFDEF DARWIN}
                if AnsiCompareText(ExtractFileExt(DeAssertDir(lX[i -1])), '.app') <> 0 then 
                {$ENDIF}
                begin
                  
                  WipeFolder(lX[i -1], True);
                  WipeFolder(lX[i -1], True);
                  WipeFolder(lX[i -1], True);
                  RemoveDirectory(PChar(lX[i -1]));
                end;
            lX.Free;
          end;
    except
    end;
    if not UninstalledFromMaintenanceState then
    begin
      
      s1 := SniffSafeUserPath(GetAllUserInstallState(MSIFile));
      
      if MediaLayout = 3 then
        s1 := s1 + RevisionGUIDforPatchEx + DirectorySeparator
      else
        s1 := s1 + RevisionGUID + DirectorySeparator;
        {$IFDEF WINDOWS}
        SetFileAttributes(PChar(s1), FILE_ATTRIBUTE_HIDDEN); 
        {$ENDIF}
      
      {$IFDEF DARWIN}
      s1 := s1 + ExtractFileNameOnly(MSIFile) + '.app/Contents/' + Ventura +  '/';
      {$ENDIF}
      s1 := s1 + ExtractFileNameOnly(MSIFile) + '.dat'; 
      if (PersistVariables.Count <> 0) or AnApplyInstallWasCalled then 
        if ForceDirectories(ExtractFilePath(s1)) then
        begin
          
          SaveComponents(s1, false, AnApplyInstallWasCalled);
        end;
    end;
  end;
  {$ELSE}
  try
    
    escondido := ProjectStruct.Conditionals;
    sX := ProjectStruct.Conditionals;
    SetMakeContext(Derefs, Types, References, Comments,
      sX, l, s, ProjectStruct.BuildLayout,
      ProjectStruct.Language, ProjectStruct.Name, ProjectStruct.aSign);

    StrCopy(ProjectStruct.Conditionals,PChar(sX));

    Result := RunScriptEx(Types, References, Comments, Webs, l, Callback, MSIFile, DLL);
  finally
    if not UninstalledFromMaintenanceState then
    begin
      
      s1 := SniffSafeUserPath(GetAllUserInstallState(MSIFile));
      
      if MediaLayout = 3 then
        s1 := s1 + RevisionGUIDforPatchEx + PathDelim
      else
        s1 := s1 + RevisionGUID + PathDelim;
      
      {$IFDEF WINDOWS}
      SetFileAttributes(PChar(s1), FILE_ATTRIBUTE_HIDDEN); 
      {$ENDIF}
      {$IFDEF DARWIN}
      s1 := s1 + ExtractFileNameOnly(MSIFile) + '.app/Contents/' + Ventura +  '/';
      {$ENDIF}
      s1 := s1 + ExtractFileNameOnly(MSIFile) + '.dat'; 
      if (PersistVariables.Count <> 0) or AnApplyInstallWasCalled then 
        if ForceDirectories(ExtractFilePath(s1)) then
          SaveComponents(s1, false, AnApplyInstallWasCalled);
    end;
    SetEditContext(l, Types);
    StrCopy(ProjectStruct.Conditionals, PChar(escondido));
    
  end;
  {$ENDIF}
end;

function IsValidSaveNameEx(FileName: String): Boolean;
begin
  Result := false;
  
  FileName := ExtractFileName(FileName);
  if AnsiPos('\', FileName) <> 0 then Exit;
  if AnsiPos('/', FileName) <> 0 then Exit;
  if AnsiPos(':', FileName) <> 0 then Exit;
  if AnsiPos('*', FileName) <> 0 then Exit;
  if AnsiPos('?', FileName) <> 0 then Exit;
  if AnsiPos('"', FileName) <> 0 then Exit;
  if AnsiPos('<', FileName) <> 0 then Exit;
  if AnsiPos('>', FileName) <> 0 then Exit;
  if AnsiPos('|', FileName) <> 0 then Exit;
  
  Result := True;
end;

function SubstituteCompilerVariables(Text, Variables: String): String;
var
  i: Integer;
  sl, slX, slXX: TStringList;
begin
  Result := Text;
  if AnsiPos('#', Text) = 0 then Exit;
  
  sl := TStringList.Create;
  slX := TStringList.Create;
  slXX := TStringList.Create;
  sl.CommaText := Variables;
  for i := 1 to sl.Count do
  begin
    slX.Add(Copy(sl[i -1], 1, AnsiPos('=', sl[i -1]) -1));
    slXX.Add(Copy(sl[i -1], AnsiPos('=', sl[i -1]) +1, Length(sl[i -1])));
  end;
  sl.Free;
  
  for i := 1 to slX.Count do
    Result := StringReplace(Result, '#' + slX[i -1] + '#', slXX[i -1], [rfReplaceAll, rfIgnoreCase]);
  if AnsiPos('#', Result) <> 0 then
    if Text <> Result then
      Result := SubstituteCompilerVariables(Result, Variables);
  slX.Free;
  slXX.Free;
end;

procedure SaveCompilerVariables(Variables: String);
var
  i: Integer;
  sl, slX, slXX: TStringList;
begin
  
  sl := TStringList.Create;
  slX := TStringList.Create;
  slXX := TStringList.Create;
  sl.CommaText := Variables;
  for i := 1 to sl.Count do
  begin
    slX.Add(Copy(sl[i -1], 1, AnsiPos('=', sl[i -1]) -1));
    slXX.Add(Copy(sl[i -1], AnsiPos('=', sl[i -1]) +1, Length(sl[i -1])));
  end;
  sl.Free;
  
  CompilerVariableDirect.Clear;
  for i := 1 to slX.Count do
  begin
    CompilerVariableDirect.Add(slX[i -1]);
    CompilerVariableDirect.Add(slXX[i -1]);
  end;
  
  CompilerVariableDirect.Add('TITLE');
  CompilerVariableDirect.Add('TITLE');
  slX.Free;
  slXX.Free;
end;

procedure ClearVariables;
begin
  aVars.Acquire;
  try
    Variables.Clear;
    VarCache.Clear;
    PersistVariables.Clear;
  finally
    aVars.Release;
  end;
end;

procedure SureSetVariable(const Variable: String; const Value: String;
  const Referrer: String);
begin
  if not IsVarDefined(Variable) then
  begin
    aVars.Acquire;
    try
      VarCache.Add(AnsiUpperCase(Variable));
      Variables.Add(Value);
      Exit;
    finally
      aVars.Release;
    end;
  end;
  SetVariable(Variable, Value, Referrer);
end;

function IsVarDefined(Variable: String): Boolean;
begin
  aVars.Acquire;
  try
    Result := VarCache.IndexOf(AnsiUpperCase(Variable)) <> -1;

  finally
    aVars.Release;
  end;
end;

procedure SetVariable(Variable: String; const Value: String;
  const Referrer: String);
var
  i, i1, j, k: Integer;
  b: Boolean;
  x: Integer;
  zx: Integer;
begin
  if SilentInstall then 
  begin
    Variable := AnsiUpperCase(Variable);
    b := false;
    i := OverrideVars.IndexOf(Variable);
    if i <> -1 then
      if i mod 2 = 0 then 
        b := True 
      else 
        for j := (i +1) to OverrideVars.Count -1 do
          if ((j mod 2) = 0) then
            if AnsiSameText(OverrideVars[j], Variable) then
            begin
              b := True;
              Break;
            end;
    if b then
      if Referrer <> 'Inject Override Command Line' then 
        Exit;
  end;
  if True then 
  begin
    Variable := AnsiUpperCase(Variable);
    b := false;
    i := OverrideVarsEx.IndexOf(Variable);
    if i <> -1 then
      if i mod 2 = 0 then 
        b := True 
      else 
        for j := (i +1) to OverrideVarsEx.Count -1 do
          if ((j mod 2) = 0) then
            if AnsiSameText(OverrideVarsEx[j], Variable) then
            begin
              b := True;
              Break;
            end;
    if b then
      if Referrer <> 'Inject Override Command Line Ex' then 
        Exit;
  end;
  if not IsVarDefined(Variable) then
  begin
    SureSetVariable(Variable,Value,referrer);
    Exit;
  end;

  aVars.Acquire;
  try
    try
      zx := VarCache.IndexOf(Variable);
      Variables[zx] := Value;
    except
      raise Exception.Create(msg9 + Variable);
    end;
    Exit;
  finally
    aVars.Release;
  end;
  raise Exception.Create(msg9 + Variable);
end;

procedure SureDeleteVariable(const Variable: String);
begin
  if Variable = '' then Exit;
  if IsVarDefined(Variable) then
  begin
    aVars.Acquire;
    try
      Variables.Delete(VarCache.IndexOf(AnsiUpperCase(Variable)));
      VarCache.Delete(VarCache.IndexOf(AnsiUpperCase(Variable)));
      Exit;
    finally
      aVars.Release;
    end;
  end;
end;

function GetStringVar(Variable: String): String;
begin
  Result := '';
  if AnsiPos('$', Variable) = 1 then
  begin
    System.Delete(Variable, 1, 1);
    if AnsiPos('$', Variable) = Length(Variable) then
    begin
      System.Delete(Variable, Length(Variable), 1);
      Result := Variable;
    end;
  end;
end;

function IsProperVariable(Variable: String; AcceptLiteral: Boolean): Boolean;
begin
  Result := True;
  if not AcceptLiteral then
  begin
    if GetStringVar(Variable) = '' then
    begin
      if not IsVarDefined(Variable) then Result := false;
    end
    else
    begin
      if (GetStringVar(Variable) <> '') and
        not IsVarDefined(GetStringVar(Variable)) then Result := false;
    end;
  end
  else
  begin
    if (GetStringVar(Variable) <> '') and
      not IsVarDefined(GetStringVar(Variable)) then Result := false;
  end;
end;

function IsCompilerVarDefined(Variable, Conditionals: String): Boolean;
begin
  Result := CompilerGetVariable(Variable, Conditionals) <> '#' + Variable + '#';
end;

function CompilerGetVariable(Variable, Conditionals: String): String;
begin
  Variable := '#' + Variable + '#';
  Result := SubstituteCompilerVariables(Variable, Conditionals);
end;

function CompilerGetStringVar(Variable: String): String;
begin
  Result := '';
  if AnsiPos('#', Variable) = 1 then
  begin
    System.Delete(Variable, 1, 1);
    if AnsiPos('#', Variable) = Length(Variable) then
    begin
      System.Delete(Variable, Length(Variable), 1);
      Result := Variable;
    end;
  end;
end;

function ReadOffset(Derefs: TList; Guid: String; Offset: Integer): String;
var
  i, j: Integer;
begin
  Result := '';
  for i := 1 to Derefs.Count do
  begin
    j := TStrings(Derefs[i -1]).IndexOf(Guid);
    if j <> - 1 then
    begin
      Result := TStrings(Derefs[i -1])[j + Offset];
      Exit;
    end;
  end;
  
end;

{$IFNDEF INTEROP}
procedure CompileMSI(MSIFile: String; Build: TBuildThread; Web: Boolean;
  Derefs: TList; Types, References, Comments: TStrings; Conditionals: String;
  BuildMode: Integer; Language, PrjName: String; OptimizeFileCompt,
  OptimizeRegCompt, StableStatementIDs, BlendedOptimize: Boolean;
  Softwrap: String; var pPin: Boolean; aSign: Boolean; BuildingThread: TBuildThread);
var
  l: TList;
  s, sX, sY: String;
  b: Boolean;
begin
  try
    StableStatementIDs := false; 
    BlendedOptimize := True; 
    sX := x64Mode;
    x64Mode := 'x64';
    b := false;
    sY := CompilerGetVariable('NO_MSI', Conditionals);
    if sY <> '#NO_MSI#' then
      if StrToBool(sY) = True then b := True;
    
    Enter64BitFileSystem;
    SetMakeContext(Derefs, Types, References, Comments, Conditionals, l, s,
      BuildMode, Language, PrjName, aSign);
    CompileMSIEx(MSIFile, Build, Web, l, BuildMode,
      OptimizeFileCompt, OptimizeRegCompt, StableStatementIDs, BlendedOptimize, Conditionals,
      Softwrap, pPin, BuildingThread);
  finally
    Leave64BitFileSystem;
    x64Mode := sX;
    SetEditContext(l, Types);
  end;
end;

procedure CompileMSIEx(MSIFile: String; Build: TBuildThread; Web: Boolean;
  Derefs: TList; BuildMode: Integer; OptimizeFileCompt, OptimizeRegCompt,
  StableStatementIDs, BlendedOptimize: Boolean; Conditionals: String;
  Softwrap: String; var pPin: Boolean; BuildingThread: TBuildThread);
var
  t, tXX: TextFile;
  i, j, k, iX, jX, kX, iXX: Integer;
  s, sX, sXX, sY, sYY, sZ: String;
  sEx, sXEx, sZEx: String;
  sl, slX: TStringList;

  schx:Integer;

lpShortcutFilePath:     pchar;
lpTargetPath:           pchar;
lpCommandOptions:       pchar;
lpDefaultDirectory:     pchar;
lpDescription:          pchar;
lpIconPathName:         pchar;
lpComptOverride:        pchar;

  b, bX: Boolean;
  WebStore: String;
  ComponentStore: String;
  ComponentSize: Int64;
  fs: TFileStream;
  MajorHi, MajorLo, MinorHi, MinorLo, Major, Minor: LongWord;
  LocalPath1, PackagePath1, LocalPath2, PackagePath2: String;

  iPtrStr, iPtrStrArray, iPtrStruct: Pointer;

  GacName, GacToken, GacVersion, GacFileVersion, GacCulture: String;
  EnvName, EnvValue: String;
  ftName, ftEXE, ftInfo, ftIcon, ftIndex: String;
  ftExts, ftVerbs, ftVerbActs: TStringList;
  ftLoop1, ftLoop2: Integer;
  ErrorInt: Integer;
  ComptBuf, IconBuf: String;
  {$ifdef SIMDILIKANSI}
  FeatBuf, ExeBuf: PAnsiChar;
  {$ELSE}
  FeatBuf, featBufEx, ExeBuf: PChar;
  {$ENDIF}

  Header: String;
  WebDirect: Boolean;
  hErr: Cardinal;
  pErr: {$ifdef SIMDILIKANSI}PAnsiChar{$else}PChar{$endif};
  iErr: Cardinal;
  iMode: Integer;
  Wide1, Wide2, Wide5, Wide6, Wide7, Wide8, Wide11, Wide12, Wide13, Wide14: String;
  c1: Cardinal;
  s1: String;
  Iteration: Boolean; 
  RegIteration: Boolean; 
  RegLastRootValue: Integer;
  RegLastAttributes: Cardinal;
  thScriptTypesiMinus1: String;
  BlendInstead: Boolean;
  ro1, ro2, ro3, ro4: String;
  BuildPath: String;
  CodePage: String;
  NativeStr: String;

  bZ: Boolean;
  rString, rStringEx: String;
  SoftwrapTestTarget, SoftwrapLimitation, SoftwrapFolder, SoftwrapError: String;
  SoftwrapDays, SoftwrapHours, SoftwrapMinutes: Integer;
  SoftwrapYear, SoftwrapMonth, SoftwrapDay: Word;
  SoftwrapTemp: PChar;
  SoftwrapWarpConnect: String;
  Skipper: Boolean; 
  LastCodeSignCopyFolder: String;

  sfal: TStringList;
  sfai: Integer;
  sfas, sfasX: String;

procedure CleanGenericCodeSign;
begin
  if LastCodeSignCopyFolder = '' then Exit;
  if not DirectoryExists(LastCodeSignCopyFolder) then Exit;
  WipeFolder(LastCodeSignCopyFolder, True);
  RemoveDirectory(PChar(LastCodeSignCopyFolder));
  LastCodeSignCopyFolder := '';
end;

function CheckGenericCodeSign(Target: String; BypassCopy: Boolean = false): String;
var
  p: PChar;
  b: Boolean;
  s, sX: String;
begin
  Result := Target;
  b := false;
  if not thProjectStruct.aSign then Exit;
  if BuildingThread <> nil then
  begin
    if LastCodeSignCopyFolder <> '' then
      CleanGenericCodeSign;
    if (AnsiCompareText(CompilerGetVariable('SIGN_ALL', Conditionals), 'TRUE') = 0) or
      (AnsiCompareText(CompilerGetVariable('SIGN_ALL', Conditionals), 'DEFAULT') = 0) then
    begin
      s := ExtractFileExt(Target);
      if AnsiCompareText('.EXE', s) <> 0 then
        if AnsiCompareText('.DLL', s) <> 0 then
          if AnsiCompareText('.OCX', s) <> 0 then
            if AnsiCompareText('.SYS', s) <> 0 then
              if AnsiCompareText('.CPL', s) <> 0 then
                if AnsiCompareText('.DRV', s) <> 0 then
                  if AnsiCompareText('.SCR', s) <> 0 then
                  begin
                    
                    b := True;
                  end;
      if not b then
        if AnsiCompareText(CompilerGetVariable('SIGN_ALL', Conditionals), 'DEFAULT') = 0 then
          if IsCodeSigned(Target) then b := True;
      if AnsiCompareText(CompilerGetVariable('SIGN_ALL_INPLACE', Conditionals), 'TRUE') = 0 then
      begin
        BypassCopy := True;
        LastCodeSignCopyFolder := '';
      end;
      if BypassCopy then
      begin
        if not b then
          BuildingThread.DoGenericCodeSign(Target);
      end
      else
      begin
        GetMem(p, (MAX_PATH+1)*8);
        StrCopy(p, PChar(MyGetTempPathEx));
        
        sX := DeAssertDir(ExtractFilePath(Target));
        sX := StringReplace(sX, ':', '__', [rfReplaceAll, rfIgnoreCase]);
        sX := StringReplace(sX, PathDelim, '_', [rfReplaceAll, rfIgnoreCase]);
        if Length(AssertDir(p) + sX + PathDelim + ExtractFileName(Target)) >= MAX_PATH -1 then
          LastCodeSignCopyFolder := AssertDir(p) + CreateGUIDUp + PathDelim 
        else
          LastCodeSignCopyFolder := AssertDir(p) + sX + PathDelim;
        if not ForceDirectories(LastCodeSignCopyFolder) then
        begin
          LastCodeSignCopyFolder := AssertDir(p) + CreateGUIDUp + PathDelim;
          if not ForceDirectories(LastCodeSignCopyFolder) then
          begin
            LastCodeSignCopyFolder := '';
            FreeMem(p);
            raise Exception.Create('Unable to create temporary folder for out-of-place code signing (or MSI file component optimization fixup): ' + LastCodeSignCopyFolder);
          end;
        end;
        FreeMem(p);
        if not CopyFile(PChar(Target), PChar(LastCodeSignCopyFolder + ExtractFileName(Target)), false) then
        begin
          LastCodeSignCopyFolder := '';
          raise Exception.Create('Unable to create temporary copy of file for out-of-place code signing (or MSI file component optimization fixup): ' + LastCodeSignCopyFolder + ExtractFileName(Target));
        end;
        Result := LastCodeSignCopyFolder + ExtractFileName(Target);
        if not b then
          BuildingThread.DoGenericCodeSign(Result);
      end;
    end;
  end;
  
end;

begin
  pPin := false;
  LastCodeSignCopyFolder := '';
  {$IFDEF DARWIN}
  DoGenericCodeSignList.Clear;
  {$ENDIF}
  
  NativeTotal := 0; 
  Skipper := True;
  NativeStr := CompilerGetVariable('NO_MSI', Conditionals);
  
  BlendInstead := (not StableStatementIDs) and (not BlendedOptimize); 
  RegIteration := false; 
  RegLastRootValue := -1; 
  RegLastAttributes := MAXINT;
  try
    
    WebDirect := not Web;
    Web := True; 
    GetMem(FeatBuf, 1024*4 *8);
    NewSourceListSource.Clear;
    thProhibitedScriptFetches.Clear;
    WebStore := '';
    ComponentStore := '';
    ComponentSize := 0;
    ComponentSpaces.Clear;
    ComponentDeletes.Clear;
    ComponentBars.Clear;
    ComponentHides.Clear;
    
    ComponentStore := 'MYAH-PREDEF-COMPONENT'; 
    ComponentSpaces.Add(ComponentStore);
    ComponentSpaces.Add('0');
    ComponentSize := 0;
    if not Skipper then
    begin
    end;
    
    CommandHeaders.Clear;
    NativeFileSourceStack.Clear;
    NativeFileSourceStackHashed.Clear;
    
    WebStore := 'OFFLINE' + PathDelim; 
    thProhibitedScriptFetches.Add(WebStore);
    for i := 1 to thScriptTypes.Count do
    begin
      if not Skipper then
      begin
        if OptimizeRegCompt then
          if (thScriptComments[i -1] <> 'C') and
            ((thScriptTypesiMinus1 = 'If') or (thScriptTypesiMinus1 = 'Else'))
              or ((thScriptTypesiMinus1 = 'End') or (thScriptTypesiMinus1 = 'Else If'))
          then
            RegIteration := false;
      end;
      thScriptTypesiMinus1 := thScriptTypes[i -1];
      if not Skipper then
      begin
        Header := GetCommandHeader(thScriptTypes, thScriptReferences, Derefs, i -1, not StableStatementIDs,
          BlendInstead);
      end;
      
      if (not Skipper) or
        (Skipper and (((thScriptTypesiMinus1 = 'Install Files') or (thScriptTypesiMinus1 = 'Install Assembly'))
          or ((thScriptTypesiMinus1 = 'Install Service') or (thScriptTypesiMinus1 = 'Install ODBC Driver')))) then 
          Header := GetCommandHeader(thScriptTypes, thScriptReferences, Derefs, i -1, not StableStatementIDs, BlendInstead);
      if ComponentStore <> '' then
        ComponentSpaces[ComponentSpaces.IndexOf(ComponentStore) +1]
          := IntToStr(ComponentSize);
      thScriptFetches[i -1] := '';
      if Cancelled then
        raise Exception.Create(SAbortedByUser);
      if thScriptComments[i -1] <> 'C' then
      begin
        if thScriptTypesiMinus1 = 'Get Component State' then 
        begin
          ComponentStore :=
            
            AnsiUpperCase(thGlobal[thGlobal.IndexOf(thScriptReferences[i -1]) +1]);
          if ComponentSpaces.IndexOf(ComponentStore) = -1 then
          begin
            ComponentSpaces.Add(ComponentStore);
            ComponentSpaces.Add('0');
          end;
          ComponentSize :=
            StrToInt64(ComponentSpaces[ComponentSpaces.IndexOf(ComponentStore) +1]);
          Continue;
        end;
        if (thScriptTypesiMinus1 = 'Web Media Block') and Web then 
        begin
          try
            bZ := StrToBool(SubstituteCompilerVariables('#CACHESOURCES#', Conditionals));
          except
            bZ := false;
          end;
          if bZ and (BuildMode <> 2) then
          begin
            WebStore := 'OFFLINE' + PathDelim; 
            thProhibitedScriptFetches.Add(WebStore);
            Continue;
          end;
          WebStore :=
            
            thGlobal[thGlobal.IndexOf(thScriptReferences[i -1]) +1] + PathDelim;
          if WebStore = PathDelim then
          begin
            WebStore := 'OFFLINE' + PathDelim; 
            thProhibitedScriptFetches.Add(WebStore);
          end
          else
          begin
            WidenColonDelimParam(thGlobal[thGlobal.IndexOf(thScriptReferences[i -1]) +3],
              Wide1, Wide2, '$MYAH_CARET$'); 
            if StrToBool(
              Wide1) then
              thProhibitedScriptFetches.Add(WebStore);
            
              if WeblockPasswords.IndexOf(AnsiLowerCase(thGlobal[thGlobal.IndexOf(thScriptReferences[i -1]) +1])) = -1 then
                
                if (thProjectStruct.Password <> '') or (Wide2 <> '') then
                begin
                  WeblockPasswords.Add(AnsiLowerCase(thGlobal[thGlobal.IndexOf(thScriptReferences[i -1]) +1]));
                  if Wide2 <> '' then
                    WeblockPasswords.Add(ObsWeblock(Wide2))
                  else
                    WeblockPasswords.Add(ObsWeblock(thProjectStruct.Password));
                end;
          end;
          Continue;
        end;
        if thScriptTypesiMinus1 = 'Delete Files' then 
        begin
          NativeTotal := NativeTotal +weightDF;
          if Skipper then Continue;
        end;
        if (thScriptTypesiMinus1 = 'Create Shortcut') or (thScriptTypesiMinus1 = 'Advertised Shortcut') then 
        begin
          NativeTotal := NativeTotal +weightCS;
          WidenColonDelimParam(thGlobal[thGlobal.IndexOf(thScriptReferences[i -1]) +9], Wide1, Wide2);
          if (AnsiPos('8', Wide2) <> 0) or (AnsiPos('7', Wide2) <> 0) then
            pPin := True;
          if Skipper then Continue;
          RegIteration := false;
        end;
        if thScriptTypesiMinus1 = 'Copy/Move Local Files' then 
        begin
          NativeTotal := NativeTotal +weightCMLF;
          if Skipper then Continue;
        end;
        if thScriptTypesiMinus1 = 'Write Registry' then 
        begin
          NativeTotal := NativeTotal +weightWR;
          if Skipper then Continue;
        end;
        if thScriptTypesiMinus1 = 'Create File Type' then 
        begin
          NativeTotal := NativeTotal +weightFT;
          if Skipper then Continue;
        end;
        if thScriptTypesiMinus1 = 'Create Folder' then 
        begin
          NativeTotal := NativeTotal +weightCF;
          if Skipper then Continue;
        end;
        if thScriptTypesiMinus1 = 'Set Environment' then 
        begin
          NativeTotal := NativeTotal +weightSE;
          if Skipper then Continue;
        end;
        if thScriptTypesiMinus1 = 'Edit INI File' then 
        begin
          NativeTotal := NativeTotal +weightINI;
          if Skipper then Continue;
        end;
        if thScriptTypesiMinus1 = 'Control Service' then 
        begin
          NativeTotal := NativeTotal +weightCTS;
          if Skipper then Continue;
        end;
        if thScriptTypesiMinus1 = 'Configure Service' then 
        begin
          NativeTotal := NativeTotal +weightCCS;
          if Skipper then Continue;
        end;
        if thScriptTypesiMinus1 = 'Configure Service Failure' then 
        begin
          NativeTotal := NativeTotal +weightCSFA;
          if True then Continue; 
        end;
        if thScriptTypesiMinus1 = 'Create ODBC DSN' then 
        begin
          NativeTotal := NativeTotal +weightDSN;
          if Skipper then Continue;
        end;
        
        if thScriptTypesiMinus1 = 'File Bag' then 
        begin
          BuildPath := AssertDir(ExtractFilePath(MSIFile)) + 'data' + PathDelim + WebStore +
            'FileBag' + IntToStr(i) + PathDelim; 
          ForceDirectories(BuildPath);
          
          begin
            thScriptFetches[i -1] := WebStore; 
            if WebStore = '' then
              raise Exception.Create(SAtLeastOneWebMediaBlockMustBeDef);
          end;
          
          rString := thGlobal[thGlobal.IndexOf(thScriptReferences[i -1]) +1];
          
          {$IFDEF WINDOWS}
          rString := StringReplace(rString, '/', '\', [rfReplaceAll]);
          {$ELSE}
          rString := StringReplace(rString, '\', '/', [rfReplaceAll]);
          {$ENDIF}
          rString := GetExpandedEnvVars(rString);
          
          rString := ExpandFileName(rString);
          {$IFDEF WINDOWS}
          if ExtractFileDrive(rString) = '' then
            rString := AssertDir(PROJDIR) + rString;
          
          {$ENDIF}
          {$IFNDEF WINDOWS}
          if rString[1] <> '/' then 
            rString := AssertDir(PROJDIR) + rString; 
          {$ENDIF}
          s := AssertDir(ExtractFilePath(rString));
          slX := TStringList.Create;
          slX.Delimiter := ';';
          slX.DelimitedText := thGlobal[thGlobal.IndexOf(thScriptReferences[i -1]) +3];
          sl := FindAllFilesEz(rString,
            StrToBool(thGlobal[thGlobal.IndexOf(thScriptReferences[i -1]) +2]),
            false, slX, True,
            AnsiCompareText(CompilerGetVariable('DOFOLLOW', Conditionals), 'TRUE') <> 0);
          if sl.Count = 0 then
            if AnsiCompareText(CompilerGetVariable('IGNOREMISSINGFILES', Conditionals), 'TRUE') <> 0 then
              raise Exception.Create(SNoFilesMatchingPattern + rString + '"');
          if slX.Count <> 0 then
            for j := sl.Count downto 1 do
              for k := 1 to slX.Count do
                if MatchesMask(ExtractFileName(sl[j -1]), slX[k -1]) then 
                begin
                  sl.Delete(j -1);
                  Break;
                end;
          if sl.Count = 0 then
            if AnsiCompareText(CompilerGetVariable('IGNOREMISSINGFILES', Conditionals), 'TRUE') <> 0 then
              raise Exception.Create(SAllMatchingFilesInPattern + rString
                + SExcludedByWildcardList + slX.DelimitedText + '"');
          if sl.Count = 0 then
          begin
            sl.Free;
            slX.Free;
            Continue;
          end;
          for j := 1 to sl.Count do
          begin
            
            sX := AssertDir(ExtractFilePath(sl[j -1]));
            
            System.Delete(sX, 1, Length(s));
            ForceDirectories(BuildPath + sX);
            sX := sX + ExtractFileName(sl[j -1]);
            if not FileCopyFile(sl[j -1], BuildPath + sX, false) then
              raise Exception.Create('Unable to bag file ' + BuildPath + sX);
            {$IFNDEF WINDOWS}
            LazShimSetExecutable(BuildPath + sX, sl[j -1]);
            {$IFDEF DARWIN}
            if thProjectStruct.aSign then
              if FpAccess(BuildPath + sX, X_OK) = 0 then
                EncryptFileEx(BuildPath + sX, '$');
            {$ENDIF}
            {$ENDIF}
            if Cancelled then
              raise Exception.Create(SAbortedByUser);
              
          end;
          sl.Free;
          slX.Free;
          if Build <> nil then
            Build.DisplayUpdateEx('Compiled File Bag #' + IntToStr(i));
          if Cancelled then
            raise Exception.Create(SAbortedByUser);
            
          Continue;
        end;
        if thScriptTypesiMinus1 = 'Install Files' then 
        begin
          SoftwrapFolder := '';
          SoftwrapTestTarget := '';
          if Softwrap <> '' then
            SoftwrapTestTarget := thGlobal[thGlobal.IndexOf(thScriptReferences[i -1]) +3];

          rString := thGlobal[thGlobal.IndexOf(thScriptReferences[i -1]) +1];
          
          {$IFDEF WINDOWS}
          rString := StringReplace(rString, '/', '\', [rfReplaceAll]);
          {$ELSE}
          rString := StringReplace(rString, '\', '/', [rfReplaceAll]);
          {$ENDIF}
          rString := GetExpandedEnvVars(rString);
          
          rString := ExpandFileName(rString);
          {$IFDEF WINDOWS}
          if ExtractFileDrive(rString) = '' then
            rString := AssertDir(PROJDIR) + rString;
          
          {$ENDIF}
          {$IFNDEF WINDOWS}
          if rString[1] <> '/' then 
            rString := AssertDir(PROJDIR) + rString; 
          {$ENDIF}

          s := AssertDir(ExtractFilePath(rString));
          slX := TStringList.Create;
          sY := thGlobal[thGlobal.IndexOf(thScriptReferences[i -1]) +2];
          sYY := '';
          if AnsiPos('|', sY) <> 0 then
          begin
            sYY := sY;
            System.Delete(sY, AnsiPos('|', sY), Length(sY));
            System.Delete(sYY, 1, AnsiPos('|', sYY));
            slX.Delimiter := ';';
            slX.DelimitedText := sYY;
          end;

          sl := FindAllFilesEz(rString,
            StrToBoolWithPipeDelim(thGlobal[thGlobal.IndexOf(thScriptReferences[i -1]) +2]),
            false, slX, True,
            AnsiCompareText(CompilerGetVariable('DOFOLLOW', Conditionals), 'TRUE') <> 0);
          
          if sl.Count = 0 then
            if AnsiCompareText(CompilerGetVariable('IGNOREMISSINGFILES', Conditionals), 'TRUE') <> 0 then
              raise Exception.Create(SNoFilesMatchingPattern + rString + '"');
          if slX.Count <> 0 then
            for j := sl.Count downto 1 do
              for k := 1 to slX.Count do
                if MatchesMask(extractfilename(sl[j -1]), slX[k -1]) then 
                begin
                  sl.Delete(j -1);
                  Break;
                end;
          if sl.Count = 0 then
            if AnsiCompareText(CompilerGetVariable('IGNOREMISSINGFILES', Conditionals), 'TRUE') <> 0 then
              raise Exception.Create(SAllMatchingFilesInPattern + rString  + SExcludedByWildcardList + slX.DelimitedText + '"');

          if sl.Count = 0 then
          begin
            sl.Free;
            slX.Free;
            Continue;
          end;

          NativeFileSourceStack.Add(Header);
          NativeFileSourceStack.Add('NEWHEADER'); 
          if not Skipper then
            RegIteration := false;
          if Web then
          begin
            thScriptFetches[i -1] := WebStore; 
            if WebStore = '' then
            begin
              raise Exception.Create(SAtLeastOneWebMediaBlockMustBeDef);
            end;
          end;

          if not Skipper then
          begin
            if ((not StableStatementIDs) and (not BlendInstead)) then begin end else
            begin
            end;
          end;

          for j := 1 to sl.Count do
          begin
            
            sX := AssertDir(ExtractFilePath(sl[j -1]));
            
            System.Delete(sX, 1, Length(s));
            if sX <> '' then sX := PathDelim + sX; 

            if SoftwrapTestTarget <> '' then
              SoftwrapTestTarget := SoftwrapTestTarget + sX;

            if not Skipper then
            begin
              if j = 1 then
                Iteration := false; 

              if Iteration then
              begin
                
                if CompareText(ExtractFileExt(sl[j -1]), '.exe') = 0 then
                  Iteration := false
                else
                if CompareText(ExtractFileExt(sl[j -1]), '.dll') = 0 then
                  Iteration := false
                else
                if CompareText(ExtractFileExt(sl[j -1]), '.ocx') = 0 then
                  Iteration := false
                else
                
                if CompareText(ExtractFileExt(sl[j -1]), '.hlp') = 0 then
                  Iteration := false
                else
                if CompareText(ExtractFileExt(sl[j -1]), '.chm') = 0 then
                  Iteration := false;
              end;

              if Iteration then
                if CompareText(ExtractFilePath(sl[j -1]), ExtractFilePath(sl[j -2])) <> 0 then
                  Iteration := false;

            end;

            if SoftwrapFolder = '' then
            begin
              
              if not RenderInstallFilesMSI(i -1, 1, CheckGenericCodeSign(sl[j -1]),
                '$P' + HEADER + '_' + '1$' + sX, Build, 
                
                WebStore, HEADER, ComponentSize, ComptBuf, WebDirect, BuildMode,
                Iteration, Conditionals, Skipper)
              or Cancelled then
                raise Exception.Create(SAbortedByUser);
                
            end
            else
              SoftwrapFolder := ''; 

            if not Skipper then
              if OptimizeFileCompt then
                Iteration := True; 
            
          end;
          sl.Free;
          slX.Free;

        end;
      end;
    end;

    if Build <> nil then
    begin
      ForceDirectories(thBuildToFolder + 'data' + PathDelim); 
      if not DirectoryExists(thBuildToFolder + 'data' + PathDelim) then
        raise Exception.Create('Unable to create data folder "' + thBuildToFolder + 'data' + PathDelim + '" - please check permissions and/or try again as administrator/root');
      AssignFile(t, thBuildToFolder + 'data' + PathDelim + thProjectStruct.Code, CP_UTF8); 
      ReWrite(t);
      CloseFile(t);
    end;
  except
    
    CleanGenericCodeSign;
    raise;
  end;
  CleanGenericCodeSign;
  FreeMem(FeatBuf);
end;

function RenderInstallFilesMSI(Index, SequenceNr: Integer; Source,
  Target: String; Build: TBuildThread; WebStore,
  Header: String; var SizeCount: Int64; var ComptBuf: String;
  WebDirect: Boolean; BuildMode: Integer; ReuseComponent: Boolean;
  Conditionals: String; Skipper: Boolean): Boolean;
var
  c: Cardinal;
  fs: TFileStream;
  SourceLocal, SourceInst: String;
  MajorHi, MajorLo, MinorHi, MinorLo, Major, Minor: LongWord;
  p: PChar;
  SourceEx, TargetEx: String;

  ifilesres:Integer;
  destpath,srcpath:PChar;
  
  BasePath, RelativePath, BucketPath: String;
begin
  Result := True;
  
  SourceLocal := Source;
  
  SourceInst := ReverseInvokePathEy(SourceLocal);
  
  BucketPath := AssertDir(AssertDir(WebStore + Header) + ExtractFilePath(SourceInst));
  
  NewSourceListSource.Add(DeAssertDir(WebStore)); 
  NewSourceListSource.Add(SourceInst); 
  NewSourceListSource.Add(BucketPath); 

    if True then 
    begin
      SizeCount := SizeCount + FileUtil.FileSize(SourceLocal);
      NativeTotal := NativeTotal + FileUtil.FileSize(SourceLocal);
    end;
    
  if True then 
  begin
    
    NativeFileSourceStack.Add(BucketPath + ExtractFileName(SourceInst)); 
    if AnsiPos(PathDelim, Target) <> 0 then
      TargetEx := Copy(Target, AnsiPos(PathDelim, Target) +1, Length(Target))
    else
      TargetEx := '';
    NativeFileSourceStack.Add(TargetEx); 
    
  end;

  if Build <> nil then
  begin
    if WebDirect or ((WebStore = 'OFFLINE' + PathDelim) or (WebStore = '')) then 
    begin
      
      SetFileAttributes(
        PChar(thBuildToFolder + 'data' + PathDelim + BucketPath + ExtractFileName(SourceLocal)), 
        FILE_ATTRIBUTE_NORMAL);
      
      ForceDirectories(thBuildToFolder + 'data' + PathDelim + BucketPath); 
      {$IFNDEF DEBUGGING}if not {$ENDIF}

      FileCopyFile(PChar(SourceLocal),
        PChar(thBuildToFolder + 'data' + PathDelim + BucketPath + ExtractFileName(SourceLocal)), 
        false)

        {$IFNDEF DEBUGGING} then
        if AnsiCompareText(CompilerGetVariable('IGNOREMISSINGFILES', Conditionals), 'TRUE') <> 0 then
          raise Exception.Create(SUnableToCopyFileTo +
            thBuildToFolder + 'data' + PathDelim + BucketPath + ExtractFileName(SourceLocal)){$ENDIF} 
        else
        begin
          SizeCount := SizeCount - FileUtil.FileSize(SourceLocal);
          NativeTotal := NativeTotal - FileUtil.FileSize(SourceLocal);
          
          Exit;
        end;

      {$IFNDEF WINDOWS}
      
      {$IFDEF DARWIN}
      LazShimSetExecutable(thBuildToFolder + 'data' + PathDelim + BucketPath + ExtractFileName(SourceLocal),
        SourceLocal);
      if thProjectStruct.aSign then
        if FpAccess(SourceLocal, X_OK) = 0 then
          EncryptFileEx(thBuildToFolder + 'data' + PathDelim + BucketPath
            + ExtractFileName(SourceLocal), '$'); 
      {$ELSE}
      LazShimSetExecutable(thBuildToFolder + 'data' + PathDelim + BucketPath + ExtractFileName(SourceLocal),
        SourceLocal);
      {$IFDEF DARWIN} 
      if FpAccess(thBuildToFolder + 'data' + PathDelim + BucketPath + ExtractFileName(SourceLocal), X_OK) = 0 then
        DoGenericCodeSignList.Add(thBuildToFolder + 'data' + PathDelim + BucketPath + ExtractFileName(SourceLocal));
      {$ENDIF}
      {$ENDIF}
      {$ENDIF}
      Result := Build.DisplayUpdateExEy(SCopiedFile + SourceLocal);
    end
    else
    begin
      if (thProhibitedScriptFetches.IndexOf(WebStore) = -1) then
      begin
        
        SetFileAttributes(
          PChar(thBuildToFolder + 'data' + PathDelim + WebStore + SourceInst), 
          FILE_ATTRIBUTE_NORMAL);
        
        ForceDirectories(thBuildToFolder + 'data' + PathDelim + WebStore + 
          AssertDir(ExtractFilePath(SourceInst)));
        {$IFNDEF DEBUGGING} if not {$ENDIF}

        FileCopyFile(PChar(SourceLocal),
          PChar(thBuildToFolder + 'data' + PathDelim + WebStore + SourceInst), 
          false)

        {$IFNDEF DEBUGGING} then
          if AnsiCompareText(CompilerGetVariable('IGNOREMISSINGFILES', Conditionals), 'TRUE') <> 0 then
            raise Exception.Create(SUnableToCopyFileTo +
              thBuildToFolder + 'data' + PathDelim + WebStore + SourceInst){$ENDIF} 
          else
          begin
            SizeCount := SizeCount - FileUtil.FileSize(SourceLocal);
            NativeTotal := NativeTotal - FileUtil.FileSize(SourceLocal);
            
            Exit;
          end;

        {$IFNDEF WINDOWS}
        LazShimSetExecutable(thBuildToFolder + 'data' + PathDelim + WebStore + SourceInst,
          SourceLocal);
        {$IFDEF DARWIN} 
        if thProjectStruct.aSign then
          if FpAccess(thBuildToFolder + 'data' + PathDelim + WebStore + SourceInst, X_OK) = 0 then
            EncryptFileEx(thBuildToFolder + 'data' + PathDelim + WebStore + SourceInst, '$'); 
        
        {$ENDIF}
        {$ENDIF} 

        Result := Build.DisplayUpdateExEy(SCopiedFile + SourceLocal);
      end
      else
        Result := Build.DisplayUpdateEx(SGeneratedMSIDatabaseInformationF + SourceLocal);
    end;
  end;
end;
{$ENDIF}

function StrToBoolWithPipeDelim(Value: String): Boolean;
begin
  if AnsiPos('|', Value) <> 0 then
    System.Delete(Value, AnsiPos('|', Value), Length(Value));
    
  Result := StrToBool(Value);
end;

function GetCompilerDirectBool(Variable: String): Boolean;
var
  s: String;
begin
  Result := false;
  s := GetCompilerDirect(Variable);
  try
    Result := StrToBool(s);
  except
    Result := false;
  end;
end;

function GetCompilerDirectInt(Variable: String): Integer;
var
  s: String;
begin
  Result := 0;
  s := GetCompilerDirect(Variable);
  try
    Result := StrToInt(s);
  except
    Result := 0;
  end;
end;

function GetCompilerDirect(Variable: String): String;
var
  s: String;
  i: Integer;
  sl: TStringList;
begin
  for i := 1 to CompilerVariableDirect.Count do
    if ((i -1) mod 2) = 0 then
      if AnsiCompareText(CompilerVariableDirect[i -1], Variable) = 0 then
      begin
        Result := CompilerVariableDirect[i];
        Break;
      end;
end;

function CompileScriptEx(Types, References, Comments: TStrings; Derefs: TList;
  var Error: String): Integer;
var
  i, j, k, l, m, n, p, q, y, z: Integer;
  ifCount, whileCount, repeatCount, foreachCount: Integer;
  lastWizard: Boolean;
  ifStackWhile, ifStackRepeat, whileStackIf, whileStackRepeat, repeatStackIf, repeatStackWhile: TStringList;
  ifStackForEach, whileStackForEach, repeatStackForEach, foreachStackIf, foreachStackWhile, foreachStackRepeat, foreachStackVariables: TStringList;
  b, bY: Boolean;
  s, sV, sY, Wide1, Wide2: String;
  TypesI: String;
begin
  try
    ifStackWhile := TStringList.Create;
    ifStackRepeat := TStringList.Create;
    whileStackIf := TStringList.Create;
    whileStackRepeat := TStringList.Create;
    repeatStackIf := TStringList.Create;
    repeatStackWhile := TStringList.Create;
    ifStackForEach := TStringList.Create;
    whileStackForEach := TStringList.Create;
    repeatStackForEach := TStringList.Create;
    foreachStackIf := TStringList.Create;
    foreachStackWhile := TStringList.Create;
    foreachStackRepeat := TStringList.Create;
    foreachStackVariables := TStringList.Create;
    
    {$IFNDEF INTEROP}
    {$IFNDEF CMDBUILD}
    if ProjectStruct.Name = '' then
    begin
      Error := SPleaseGiveYourProjectANameFillIn;
      
      Result := MAXINT -2;
      Exit;
    end;
    {$ENDIF}
    {$ENDIF}
    Labels.Clear;
    Lines.Clear;
    
    ClearVariables;
    SureSetVariable('CHARSET_OVERRIDE', '', 'Compilation'); 
    
    SureSetVariable('MYAH_TIMEOUT', 'FALSE', 'Compilation'); 
    SureSetVariable('GPOPATH', 'FALSE', 'Compilation'); 
    SureSetVariable('SETUPPATH', 'FALSE', 'Compilation'); 
    
    SureSetVariable('NATIVE_ENGINE', 'TRUE', 'Compilation'); 
    SureSetVariable('NATIVE_OLDLOG', '', 'Compilation'); 
    SureSetVariable('NATIVE_LOGGING', '', 'Compilation'); 
    SureSetVariable('NATIVE_ROLLBACK', 'TRUE', 'Compilation'); 
    SureSetVariable('NATIVE_HARDLINK', 'TRUE', 'Compilation'); 
    SureSetVariable('NATIVE_ERROR', 'PROMPT', 'Compilation'); 
    SureSetVariable('NATIVE_OVERWRITE', 'PROMPT', 'Compilation'); 
    SureSetVariable('NATIVE_OVERWRITE_OLDER', 'FALSE', 'Compilation'); 
    SureSetVariable('NATIVE_OVERRIDE_PERMISSIONS', 'FALSE', 'Compilation'); 
    SureSetVariable('NATIVE_OVERRIDE_NON_RESTORABLE_PERMISSIONS', 'FALSE', 'Compilation'); 
    SureSetVariable('NATIVE_PROGRESS', '0', 'Compilation'); 
    SureSetVariable('DELAYUNTIL_APPLYCHANGES', 'FALSE', 'Compilation'); 
    
    SureSetVariable('MYAH_COMPRESSCACHE', '', 'Compilation'); 
    SureSetVariable('MYAH_DISABLEROLLBACK', '', 'Compilation'); 
    SureSetVariable('MYAH_DISABLEVISTARESTARTMANAGER', '', 'Compilation'); 
    
    SureSetVariable('IISHOST', '', 'Compilation'); 
    SureSetVariable('OVERRIDECACHE', '', 'Compilation'); 
    SureSetVariable('MYAHLOGO', '', 'Compilation'); 
    SureSetVariable('TIME', '', 'Compilation'); 
    SureSetVariable('DATE', '', 'Compilation'); 
    SureSetVariable('NEWINSTANCE', '', 'Compilation'); 
    SureSetVariable('SELECTED', '', 'Compilation'); 
    SureSetVariable('WINDOWHANDLE', '', 'Compilation'); 
    SureSetVariable('EXEDIR', '', 'Compilation'); 
    SureSetVariable('EXEFILE', '', 'Compilation'); 
    SureSetVariable('UNINSTALLLINK', '', 'Compilation'); 
    SureSetVariable('ENGINECACHE', '', 'Compilation'); 
    SureSetVariable('COPYWEBLOCK', '', 'Compilation'); 
    SureSetVariable('ABORT', '', 'Compilation'); 
    SureSetVariable('SILENT', '', 'Compilation'); 
    SureSetVariable('LOGGED', '', 'Compilation'); 
    SureSetVariable('CMDLINE', '', 'Compilation'); 
    SureSetVariable('REBOOTNOW', '', 'Compilation'); 
    SureSetVariable('SFXPATH', '', 'Compilation'); 
    SureSetVariable('SFXFILE', '', 'Compilation'); 
    SureSetVariable('LASTERROR', '', 'Compilation'); 
    SureSetVariable('PROGRESSMODE', '', 'Compilation'); 
    SureSetVariable('CUSTOM_TASKBAR_PROGRESS_ENABLED', '', 'Compilation'); 
    SureSetVariable('CUSTOM_TASKBAR_PROGRESS_PERCENT', '', 'Compilation'); 
    SureSetVariable('CUSTOM_TASKBAR_PROGRESS_MAX', '', 'Compilation'); 
    SureSetVariable('PROGRESSTEXT', '', 'Compilation'); 
    SureSetVariable('PROGRESS', '', 'Compilation'); 
    SureSetVariable('LICENSE', '', 'Compilation'); 
    SureSetVariable('USERNAME', '', 'Compilation'); 
    SureSetVariable('USERCOMPANY', '', 'Compilation'); 
    SureSetVariable('REBOOTCOMPUTER', '', 'Compilation'); 
    SureSetVariable('RUNAPP', '', 'Compilation'); 
    SureSetVariable('WIZARD', '', 'Compilation'); 
    SureSetVariable('FX', '', 'Compilation'); 
    SureSetVariable('FXGROUND', '', 'Compilation'); 
    SureSetVariable('FXTIME', '', 'Compilation'); 
    SureSetVariable('VERSION', '', 'Compilation'); 
    SureSetVariable('TARGETDIR', '', 'Compilation'); 
    SureSetVariable('STARTMENU', '', 'Compilation'); 
    SureSetVariable('ADVERTISE', '', 'Compilation'); 
    SureSetVariable('ALLUSERS', '', 'Compilation'); 
    SureSetVariable('COMPLETE', '', 'Compilation'); 
    SureSetVariable('MINIMUM', '', 'Compilation'); 
    SureSetVariable('PERSONALIZED', '', 'Compilation'); 
    SureSetVariable('GLASS', '', 'Compilation'); 
    SureSetVariable('ISNT', '', 'Compilation'); 
    SureSetVariable('MODIFY', '', 'Compilation'); 
    SureSetVariable('REPAIR', '', 'Compilation'); 
    SureSetVariable('REMOVE', '', 'Compilation'); 
    SureSetVariable('DATADIR', '', 'Compilation'); 
    SureSetVariable('PRODUCTCODE', '', 'Compilation'); 
    SureSetVariable('REVISIONCODE', '', 'Compilation'); 
    SureSetVariable('ROOTDIR', '', 'Compilation'); 
    SureSetVariable('MAINTENANCE', '', 'Compilation'); 
    SureSetVariable('NEWLINE', '', 'Compilation'); 
    SureSetVariable('NEEDSUPGRADE', '', 'Compilation'); 
    SureSetVariable('RECOMMENDEDUPGRADE', '', 'Compilation'); 
    SureSetVariable('TITLE', '', 'Compilation'); 
    SureSetVariable('COMPANY', '', 'Compilation'); 
    SureSetVariable('TEMPDIR', '', 'Compilation'); 
    SureSetVariable('PLATFORM', '', 'Compilation'); 
    SureSetVariable('PLATFORMFULL', '', 'Compilation'); 
    SureSetVariable('NOGUI', '', 'Compilation');
    SureSetVariable('SUPPORTDIR', '', 'Compilation'); 
    SureSetVariable('MSIFILE', '', 'Compilation'); 
    SureSetVariable('LANGUAGE', '', 'Compilation'); 
    SureSetVariable('ABORTONERROR', '', 'Compilation');
    SureSetVariable('ABORTEDONERROR', '', 'Compilation');
    SureSetVariable('SAVEDATA', '', 'Compilation');
    Result := -1;
    Error := SScriptCompiledSuccessfully;
    
    j := 0;
    k := 0;
    l := 0;
    m := 0;
    n := 0;
    p := 0;
    q := 0;
    y := 0;
    z := 0;
    ifCount := 0;
    whileCount := 0;
    repeatCount := 0;
    foreachCount := 0;
    lastWizard := false;
    ifStackWhile.Clear;
    ifStackRepeat.Clear;
    whileStackIf.Clear;
    whileStackRepeat.Clear;
    repeatStackIf.Clear;
    repeatStackWhile.Clear;
    ifStackForEach.Clear;
    whileStackForEach.Clear;
    repeatStackForEach.Clear;
    foreachStackIf.Clear;
    foreachStackWhile.Clear;
    foreachStackRepeat.Clear;
    foreachStackVariables.Clear;
    for i := 1 to Types.Count do
      if (Comments <> nil) and (Comments[i -1] <> 'C') then
      begin
        TypesI := Types[i -1];
        if TypesI = 'If' then 
        begin
          j := j +1;
          l := l +1;
          lastWizard := false;
          ifCount := ifCount +1;
          ifStackWhile.Add(IntToStr(whileCount));
          ifStackRepeat.Add(IntToStr(repeatCount));
          ifStackForEach.Add(IntToStr(foreachCount));
        end
        else
        if TypesI = 'Wizard Loop' then 
        begin
          j := j +1;
          l := l +1;
          lastWizard := True;
        end
        else
        if TypesI = 'End' then 
        begin
          k := k +1;
          l := l -1;
          if not lastWizard then
          begin
            ifCount := ifCount -1;
            try
              if ((StrToInt(ifStackWhile[ifStackWhile.Count -1]) <> whileCount)
                or (StrToInt(ifStackRepeat[ifStackRepeat.Count -1]) <> repeatCount))
                or (StrToInt(ifStackForEach[ifStackForEach.Count -1]) <> foreachCount) then
              begin
                Result := i -1;
                Error := 'IF conditional closed outside of LOOP scope';
                Exit;
              end
              else
              begin
                ifStackWhile.Delete(ifStackWhile.Count -1);
                ifStackRepeat.Delete(ifStackRepeat.Count -1);
                ifStackForEach.Delete(ifStackForEach.Count -1);
              end;
            except
              
              Result := i -1;
              Error := 'IF conditional closed outside of IF conditional scope';
              Exit;
            end;
          end;
        end
        else
        if (TypesI = 'Break') or (TypesI = 'Continue') then 
        begin
          if ((p = q) and (m = n)) and (y = z) then
          begin
            Result := i -1;
            Error := TypesI + ' not allowed outside of LOOP scope';
            Exit;
          end;
        end
        else
        if TypesI = 'While' then 
        begin
          m := m +1;
          l := l +1;
          whileCount := whileCount +1;
          whileStackIf.Add(IntToStr(ifCount));
          whileStackRepeat.Add(IntToStr(repeatCount));
          whileStackForEach.Add(IntToStr(foreachCount));
        end
        else
        if TypesI = 'Wend' then 
        begin
          n := n +1;
          l := l -1;
          whileCount := whileCount -1;
          try
            if ((StrToInt(whileStackIf[whileStackIf.Count -1]) <> ifCount)
              or (StrToInt(whileStackRepeat[whileStackRepeat.Count -1]) <> repeatCount))
              or (StrToInt(whileStackForEach[whileStackForEach.Count -1]) <> foreachCount) then
            begin
              Result := i -1;
              Error := 'WHILE loop closed outside of CONDITIONAL or REPEAT or FOR EACH loop scope';
              Exit;
            end
            else
            begin
              whileStackIf.Delete(whileStackIf.Count -1);
              whileStackRepeat.Delete(whileStackRepeat.Count -1);
              whileStackForEach.Delete(whileStackForEach.Count -1);
            end;
          except
            
            Result := i -1;
            Error := 'WHILE loop closed outside of WHILE loop scope';
            Exit;
          end;
        end
        else
        if TypesI = 'Repeat' then 
        begin
          p := p +1;
          l := l +1;
          repeatCount := repeatCount +1;
          repeatStackIf.Add(IntToStr(ifCount));
          repeatStackWhile.Add(IntToStr(whileCount));
          repeatStackForEach.Add(IntToStr(foreachCount));
        end
        else
        if TypesI = 'Until' then 
        begin
          q := q +1;
          l := l -1;
          repeatCount := repeatCount -1;
          try
            if ((StrToInt(repeatStackIf[repeatStackIf.Count -1]) <> ifCount)
              or (StrToInt(repeatStackWhile[repeatStackWhile.Count -1]) <> whileCount))
              or (StrToInt(repeatStackForEach[repeatStackForEach.Count -1]) <> foreachCount) then
            begin
              Result := i -1;
              Error := 'REPEAT loop closed outside of CONDITIONAL or WHILE or FOR EACH loop scope';
              Exit;
            end
            else
            begin
              repeatStackIf.Delete(repeatStackIf.Count -1);
              repeatStackWhile.Delete(repeatStackWhile.Count -1);
              repeatStackForEach.Delete(repeatStackForEach.Count -1);
            end;
          except
            
            Result := i -1;
            Error := 'REPEAT loop closed outside of REPEAT loop scope';
            Exit;
          end;
        end
        else
        if TypesI = 'For Each' then 
        begin
          if foreachStackVariables.IndexOf(ReadOffset(Derefs, References[i -1], 1)) <> -1 then
          begin
            Result := i -1;
            Error := 'FOR EACH variable re-used inside nested FOR EACH loop';
            Exit;
          end;
          foreachStackVariables.Add(ReadOffset(Derefs, References[i -1], 1));
          y := y +1;
          l := l +1;
          foreachCount := foreachCount +1;
          foreachStackIf.Add(IntToStr(ifCount));
          foreachStackRepeat.Add(IntToStr(repeatCount));
          foreachStackWhile.Add(IntToStr(whileCount));
        end
        else
        if TypesI = 'Next' then 
        begin
          z := z +1;
          l := l -1;
          foreachCount := foreachCount -1;
          try
            if ((StrToInt(foreachStackIf[foreachStackIf.Count -1]) <> ifCount)
              or (StrToInt(foreachStackRepeat[foreachStackRepeat.Count -1]) <> repeatCount))
              or (StrToInt(foreachStackWhile[foreachStackWhile.Count -1]) <> whileCount) then
            begin
              Result := i -1;
              Error := 'FOR EACH loop closed outside of CONDITIONAL or REPEAT or WHILE loop scope';
              Exit;
            end
            else
            begin
              foreachStackIf.Delete(foreachStackIf.Count -1);
              foreachStackRepeat.Delete(foreachStackRepeat.Count -1);
              foreachStackWhile.Delete(foreachStackWhile.Count -1);
              foreachStackVariables.Delete(foreachStackVariables.Count -1);
            end;
          except
            
            Result := i -1;
            Error := 'FOR EACH loop closed outside of FOR EACH loop scope';
            Exit;
          end;
        end
        else
        if TypesI = 'Label' then 
          if l <> 0 then
            if ((j = k) and (m = n)) and ((p = q) and (y = z)) then 
            begin
              Result := i -1;
              Error := SLABELStatementsCannotBeNestedIns;
              Exit;
            end;
      end;
    if j <> k then
    begin
      if j > k then Error := SInsufficientENDStatements
        else Error := STooManyENDStatements;
      Result := MAXINT -3;
      Exit;
    end;
    if m <> n then
    begin
      if m > n then Error := 'Insufficient WEND statements'
        else Error := 'Too many WEND statements';
      Result := MAXINT -3;
      Exit;
    end;
    if p <> q then
    begin
      if p > q then Error := 'Insufficient UNTIL statements'
        else Error := 'Too many UNTIL statements';
      Result := MAXINT -3;
      Exit;
    end;
    if y <> z then
    begin
      if y > z then Error := 'Insufficient NEXT statements'
        else Error := 'Too many NEXT statements';
      Result := MAXINT -3;
      Exit;
    end;
    
    for i := 1 to Types.Count do
      if Types[i -1] = 'Label' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if Labels.IndexOf(AnsiUpperCase(s)) = -1 then
          Labels.Add(AnsiUpperCase(s))
        else
        begin
          Result := i -1;
          Error := SLABELReDefined + s;
          Exit;
        end;
      end;
    
    for i := 1 to Types.Count do
      if Types[i -1] = 'Set Variable' then 
      begin
        sY := ReadOffset(Derefs, References[i -1], 1);
        if Pos('$MYAH$MYAH$', sY) <> 0 then 
        begin
          System.Delete(sY, 1, Pos('$MYAH$MYAH$', sY) + Length('$MYAH$MYAH$') -1); 
          bY := MyStrToBool(sY); 
          sY := ReadOffset(Derefs, References[i -1], 1);
          System.Delete(sY, Pos('$MYAH$MYAH$', sY), Length(sY)); 
        end
        else
          bY := false;
        if bY then
          if not IsVarDefined(sY) then
            SureSetVariable(AnsiUpperCase(sY), '', 'Compilation'); 
      end;
    
    for i := 1 to Types.Count do
    begin
      Lines.Add('SKIP'); 
      if (Comments <> nil) and (Comments[i -1] = 'C') then Continue;
      TypesI := Types[i -1];
      if TypesI = 'Web Media Block' then 
      begin
        s := '';
        
        if not IsValidSaveNameEx(ReadOffset(Derefs, References[i -1], 1)) then
          s := SWebMediaBlockNameMustBeALegalFil;
        if (ReadOffset(Derefs, References[i -1], 1) <> '') and
          (ReadOffset(Derefs, References[i -1], 2) = '') then
          s := SWebMediaBlockMustHaveAtLeastOneD;
        if s <> '' then
        begin
          Result := i -1;
          Error := s;
          Exit;
        end;
      end
      else
      if TypesI = 'Comment' then Continue
      else
      if TypesI = 'Get Folder Location' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Mathematics' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 4);
        if s = '' then
          if (ReadOffset(Derefs, References[i -1], 3) <> '13') and  (ReadOffset(Derefs, References[i -1], 3) <> '14') then 
          begin
            Result := i -1;
            Error := SVariableRequired;
            Exit;
          end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Format String' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Is MSI Setup Installed' then 
      begin
        if (ReadOffset(Derefs, References[i -1], 2) = '') then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        s := ReadOffset(Derefs, References[i -1], 2);
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Is Native Setup Installed' then 
      begin
        if (ReadOffset(Derefs, References[i -1], 2) = '') then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        s := ReadOffset(Derefs, References[i -1], 2);
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Return from Include Script' then
      begin
        s := GetUnitName(IncludeDepthDirect[i ], True); 
        if s <> '' then 
        begin
          if not IsVarDefined(s) then
            SureSetVariable(AnsiUpperCase(s), '', TypesI + ' Action'); 
          SureSetVariable(s, '', 'Compilation');
        end;
      end
      else
      if TypesI = 'Is File Locked' then 
      begin
        if (ReadOffset(Derefs, References[i -1], 2) = '') then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        s := ReadOffset(Derefs, References[i -1], 2);
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Get INI File Settings' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Get XML File Settings' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Evaluate XPath Query' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 3);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Extract 7Zip Archive' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 3);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Compress 7Zip Archive' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 10);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Delete 7Zip Archive' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 4);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Test 7Zip Archive' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 3);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'List 7Zip Archive' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 3);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Run Light Mode Setup' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 2);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Read from Text File' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 2);
        
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
        s := ReadOffset(Derefs, References[i -1], 3);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Parse String' then 
      begin
        if (ReadOffset(Derefs, References[i -1], 3) = '') and (ReadOffset(Derefs, References[i -1], 4) = '') then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        s := ReadOffset(Derefs, References[i -1], 3);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
        s := ReadOffset(Derefs, References[i -1], 4);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Check File Version' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Copy/Move Local Files' then 
        Lines[i -1] := 'FALSE'
      else
      if TypesI = 'Create Folder' then 
        Lines[i -1] := 'FALSE'
      else
      if (TypesI = 'Create Shortcut') or (TypesI = 'Advertised Shortcut') then 
      begin
        Lines[i -1] := 'FALSE'; 
      end
      else
      if TypesI = 'Edit INI File' then 
        Lines[i -1] := 'FALSE'
      else
      if TypesI = 'Delete Files' then 
      begin
        if (not StrToBool(ReadOffset(Derefs, References[i -1], 3))) and
          (not StrToBool(ReadOffset(Derefs, References[i -1], 4))) then
        begin
          Result := i -1;
          Error := SAtLeastOneDeleteModeMustBeSelect;
          Exit;
        end;
        Lines[i -1] := 'FALSE'; 
      end
      else
      if TypesI = 'Install Files' then 
      begin
        if ReadOffset(Derefs, References[i -1], 3) = '' then
        begin
          Result := i -1;
          Error := SATargetFolderMustBeSpecifiedForF;
          Exit;
        end;
        Lines[i -1] := 'FALSE'; 
      end
      else
      if TypesI = 'Install Assembly' then 
        Lines[i -1] := 'FALSE' 
      else
      if TypesI = 'Set Environment' then 
        Lines[i -1] := 'FALSE'
      else
      if TypesI = 'Install Service' then 
        Lines[i -1] := 'FALSE'
      else
      if TypesI = 'Install ODBC Driver' then 
        Lines[i -1] := 'FALSE'
      else
      if TypesI = 'Create ODBC DSN' then 
        Lines[i -1] := 'FALSE'
      else
      if TypesI = 'Control Service' then 
        Lines[i -1] := 'FALSE'
      else
      if TypesI = 'Configure Service' then 
        Lines[i -1] := 'FALSE'
      else
      if TypesI = 'Configure Service Failure' then 
        Lines[i -1] := 'FALSE'
      else
      if TypesI = 'Write Registry' then 
        Lines[i -1] := 'FALSE'
      else
      if TypesI = 'Create File Type' then 
        Lines[i -1] := 'FALSE'
      else
      if TypesI = 'Advertised File Type' then 
        Lines[i -1] := 'FALSE'
      else
      if TypesI = 'Convert Path' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if not IsVarDefined(s) then
        begin
          Result := i -1;
          Error := SVariableNotDefined + s;
          Exit;
        end;
      end
      else
      if TypesI = 'Convert Case' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if not IsVarDefined(s) then
        begin
          Result := i -1;
          Error := SVariableNotDefined + s;
          Exit;
        end;
      end
      else
      if TypesI = 'Extract Path' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if not IsVarDefined(s) then
        begin
          Result := i -1;
          Error := SVariableNotDefined + s;
          Exit;
        end;
      end
      else
      if TypesI = 'Get Native Settings' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Get System Settings' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Get OS or SP Level' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Get Link Target' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 2);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Get String Length' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 2);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Get String Position' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Localization Variable' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Match Regular Expression' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Generate GUID' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Evaluate Expression' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 2);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
        if not TestSyntax(ReadOffset(Derefs, References[i -1], 1)) then
        begin
          Result := i -1;
          Error := SSyntaxErrorInExpressionPleaseRev;
          Exit;
        end;
      end
      else
      if (TypesI = 'Read Registry') or (TypesI = 'Check Registry') then 
      begin
        WidenColonDelimParam(ReadOffset(Derefs, References[i -1], 1),
          Wide1, Wide2);
        s := Wide1;
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Find All Registry' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Find All Computers' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Remote Run Program' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 6);
        if s <> '' then
          
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Does File/Folder Exist' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Run Program' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 5);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Run Program As' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 8);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Run Script' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 6);
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Run Script' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 6);
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Prompt for Text' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 2);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Browse for File' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 4);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Browse for Folder' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 3);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Read from Binary File' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := 'File or folder path required';
          Exit;
        end;
        s := ReadOffset(Derefs, References[i -1], 2);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Restart Applications' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 5);
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Run Program As' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 8);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Set Variable' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if Pos('$MYAH$MYAH$', s) <> 0 then 
          System.Delete(s, Pos('$MYAH$MYAH$', s), Length(s)); 
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Localization Variable' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Get Temporary File' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Get IIS Property' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Get File Version' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 2);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Halt Compilation' then
      begin
        Result := i -1;
        Error := 'Aborted by Halt Compilation';
        if ReadOffset(Derefs, References[i -1], 1) <> '' then
          Error := Error + ': ' + StringReplace(
            ReadOffset(Derefs, References[i -1], 1),
            '$NEWLINE$', MyLineEnding, [rfReplaceAll]);
        Exit;
      end
      else
      if TypesI = 'Get Environment' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 2);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Get IIS Site Index' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 2);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Get IIS Site List' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'GoTo Label' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if Labels.IndexOf(AnsiUpperCase(s)) = -1 then
        begin
          Result := i -1;
          Error := SLABELUndefined + s;
          Exit;
        end;
      end
      else
      if TypesI = 'Find All Files' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 4);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Check Disk Space' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Replace String' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if not IsVarDefined(s) then
        begin
          Result := i -1;
          Error := SVariableNotDefined + s;
          Exit;
        end;
      end
      else
      if TypesI = 'For Each' then
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        if IsVarDefined(AnsiUpperCase(s)) then
        begin
          Result := i -1;
          Error := 'FOR EACH variable previously defined outside FOR EACH loop';
          Exit;
        end;
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
        foreachStackVariables.Add(AnsiUpperCase(s));
      end
      else
      if TypesI = 'Next' then
      begin
        SureDeleteVariable(foreachStackVariables[foreachStackVariables.Count -1]);
        foreachStackVariables.Delete(foreachStackVariables.Count -1);
      end
      else
      if TypesI = 'Halt Compilation' then
      begin
        Result := i -1;
        Error := 'Aborted by Halt Compilation';
        if ReadOffset(Derefs, References[i -1], 1) <> '' then
          Error := Error + ': ' + StringReplace(
            ReadOffset(Derefs, References[i -1], 1),
            '$NEWLINE$', MyLineEnding, [rfReplaceAll]);
        Exit;
      end
      else
      if ((TypesI = 'If') or (TypesI = 'Else If')) or ((TypesI = 'While') or (TypesI = 'Until')) then 
      begin
        
        if (ReadOffset(Derefs, References[i -1], 1) = '')  then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        if ReadOffset(Derefs, References[i -1], 2) = '5' then Continue; 
        s := '';
        if not IsProperVariable(
          ReadOffset(Derefs, References[i -1], 1), false) then
          s := ReadOffset(Derefs, References[i -1], 1);
        if not IsProperVariable(
          ReadOffset(Derefs, References[i -1], 3), True) then
          s := ReadOffset(Derefs, References[i -1], 3);
        if s <> '' then
        begin
          Result := i -1;
          Error := SVariableNotDefined + s;
          Exit;
        end;
      end
      else
      if TypesI = 'Set File Attributes' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := 'File or folder path required';
          Exit;
        end;
      end
      else
      if TypesI = 'Set File Compression' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := 'File or folder path required';
          Exit;
        end;
      end
      else
      if TypesI = 'Run Program' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 5);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Download File' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 3);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'File Bag' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 4);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'MessageBox' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 5);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Get File Size' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 2);
        if s = '' then
        begin
          Result := i -1;
          Error := 'File or folder path required';
          Exit;
        end;
        s := ReadOffset(Derefs, References[i -1], 1);
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Check Service' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 3);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Check Process' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 2);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Check Computer' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 2);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Terminate Process' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 2);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Register Library' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 3);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Apply Changes' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 2);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Apply Patch' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        
        if s <> '' then
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Display Dialog' then 
      begin
        s := '';
        if ReadOffset(Derefs, References[i -1], 1) = '' then
        begin
          Result := i -1;
          Error := SDialogNameNotSpecified;
          Exit;
        end;
        s := ReadOffset(Derefs, References[i -1], 2);
        if s <> '' then
        begin
          
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
          s := '';
        end;
        if ReadOffset(Derefs, References[i -1], 4) <> '' then
          if not IsProperVariable(
            ReadOffset(Derefs, References[i -1], 4), false) then
              s := ReadOffset(Derefs, References[i -1], 4);
        if s <> '' then
        begin
          Result := i -1;
          Error := SVariableNotDefined + s;
          Exit;
        end;
      end
      else
      if TypesI = 'Get Component State' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 2);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'Get Component Space' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 2);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end
      else
      if TypesI = 'System Restore' then 
      begin
        if StrToBool(ReadOffset(Derefs, References[i -1], 1)) then
        begin
          s := ReadOffset(Derefs, References[i -1], 3);
          if s = '' then
          begin
            Result := i -1;
            Error := SVariableRequired;
            Exit;
          end;
          
          SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
        end;
      end
      else
      if TypesI = 'IIS Anonymous User' then 
      begin
        s := ReadOffset(Derefs, References[i -1], 1);
        if s = '' then
        begin
          Result := i -1;
          Error := SVariableRequired;
          Exit;
        end;
        
        SureSetVariable(AnsiUpperCase(s), '', 'Compilation'); 
      end;
    end;
    
    b := false;
    for i := 1 to Types.Count do
    begin
      if (Comments <> nil) and (Comments[i -1] = 'C') then Continue;
      TypesI := Types[i -1];
      if TypesI = 'Wizard Loop' then 
      begin
        b := True;
        Continue;
      end;
      if (TypesI = 'End') and b then 
      begin
        b := false;
        Continue;
      end;
      if (b and (TypesI <> 'Display Dialog')) and 
        (TypesI <> 'Comment') then 
      begin
        if TypesI = 'Ignore' then Continue; 
        Result := i -1;
        Error := SStatementsOtherThanDISPLAYDIALOG;
        Exit;
      end;
    end;
  finally
    ifStackWhile.Free;
    ifStackRepeat.Free;
    whileStackIf.Free;
    whileStackRepeat.Free;
    repeatStackIf.Free;
    repeatStackWhile.Free;
    ifStackForEach.Free;
    whileStackForEach.Free;
    repeatStackForEach.Free;
    foreachStackIf.Free;
    foreachStackWhile.Free;
    foreachStackRepeat.Free;
    foreachStackVariables.Free;
  end;
end;

function CompileScript(Types, References, Comments: TStrings; Derefs: TList;
  var Error: String): Integer;
var
  l: TList;
  i: Integer;
  
  escondido: String;
  sX: String;
begin
  {$IFDEF INTEROP}
  Result := CompileScriptEx(Types, References, Comments, Derefs, Error);
  {$ELSE}
  
  escondido := ProjectStruct.Conditionals;
  sX := ProjectStruct.Conditionals;
  Result := SetMakeContext(Derefs, Types, References, Comments,
    
    sX, l, Error, ProjectStruct.BuildLayout,
    ProjectStruct.Language, ProjectStruct.Name, ProjectStruct.aSign);
  StrCopy(ProjectStruct.Conditionals, PChar(sX));
  
  if Result = -1 then
  begin
    Result := CompileScriptEx(Types, References, Comments, l, Error);
    
    SetEditContext(l, Types);
    StrCopy(ProjectStruct.Conditionals, PChar(escondido));
    
  end
  else
  begin
    StrCopy(ProjectStruct.Conditionals, PChar(escondido));
    
  end;
  
  {$ENDIF}
end;

procedure SetEditContext(Derefs: TList; Types: TStrings);
var
  i: Integer;
begin
  
  if BackCounter = 1 then
  begin
    
    for i := 1 to Derefs.Count do
      TStringList(Derefs[i -1]).Free;
    Derefs.Free;
    Types.CommaText := BackTypes.CommaText;
    BackTypes.Free;
  end;
  BackCounter := BackCounter -1;
end;

function SetMakeContext(Derefs: TList; Types, References, Comments: TStrings;
  var Conditionals: String; var OutDerefs: TList; var Error: String;
  BuildMode: Integer; DefLang, ProjName: String; aSign: Boolean): Integer;

function CannonFodder(DefaultPath: String): String;
{$IFDEF WINDOWS}
var
  r: TRegistry;
{$ENDIF}
begin
  Result := '';
  {$IFDEF WINDOWS} 
  try
    r := TRegistry.Create;
    r.RootKey := HKEY_LOCAL_MACHINE;
    r.Access := KEY_READ;
    if r.OpenKeyReadOnly('SOFTWARE\MimarSinan\InstallAware\2.0\Plug-Ins\(Un)Install MSI Setup') then
    begin
      Result := r.ReadString('');
      
      Result := IncludeTrailingPathDelimiter(ExtractFilePath(ExcludeTrailingPathDelimiter(ExtractFilePath(ExcludeTrailingPathDelimiter(ExtractFilePath(Result))))));
      r.CloseKey;
      if not DirectoryExists(Result + 'runtimes' + PathDelim) then
        Result := '';
    end;
  except
    Result := DefaultPath;
  end;
  {$ENDIF}
  if Result = '' then
    Result := DefaultPath;
end;

procedure EnsureOverriddenConditional(var Conditionals: String; Conditional, EnsureValue: String);
var
  i: Integer;
  l: TStringList;
  s, sX: String;
begin
  l := TStringList.Create;
  l.CommaText := Conditionals;
  for i := 1 to l.Count do
  begin
    s := Copy(l[i -1], 1, AnsiPos('=', l[i -1]) -1);
    sX := Copy(l[i -1], AnsiPos('=', l[i -1]) +1, Length(l[i -1]));
    if AnsiCompareText(s, Conditional) = 0 then
    begin
      l[i -1] := s + '=' + EnsureValue;
      Break;
    end
    else
      if i = l.Count then
        l.Add(Conditional + '=' + EnsureValue);
  end;
  if l.Count = 0 then
    l.Add(Conditional + '=' + EnsureValue);
  Conditionals := l.CommaText;
  l.Free;
end;

var
  p: PChar;
  
  i, j, k: Integer;
  sl: TStringList;
  slX: TStringList;
  
  SkipToEnd, SkipToElseOrEnd, ReEnding: Boolean;
  DeferSkipToEnd, i1, i2: Integer;
  b, bX, bXX: Boolean;
  s1, s2: String;
  
  i164, i264: Int64;
begin
  Result := -1;
  Error := SScriptCompiledSuccessfully;
  if BackCounter > 0 then
  begin
    OutDerefs := Derefs;
    BackCounter := BackCounter +1;
    Exit;
  end
  else
    BackCounter := 1;
  
  if aSign then EnsureOverriddenConditional(Conditionals, 'MYAH_SIGNED', 'TRUE');
  
  if BuildMode = 0 then EnsureOverriddenConditional(Conditionals, 'BUILDMODE', 'CD');
  if BuildMode = 1 then EnsureOverriddenConditional(Conditionals, 'BUILDMODE', 'SFX');
  if BuildMode = 2 then EnsureOverriddenConditional(Conditionals, 'BUILDMODE', 'WEB');
  if BuildMode = 3 then EnsureOverriddenConditional(Conditionals, 'BUILDMODE', 'PATCH');
  
  {$IFDEF WINDOWS}
  EnsureOverriddenConditional(Conditionals, 'PLATFORMFULL', 'WINDOWS');
  EnsureOverriddenConditional(Conditionals, 'PLATFORM', 'WINDOWS');
  {$ENDIF}
  {$IFDEF LINUX}
  {$IFDEF CPUAARCH64}
  {$IFDEF LCLQT5}
  EnsureOverriddenConditional(Conditionals, 'PLATFORMFULL', 'LINUXARMQT5');
  {$ELSE}
  EnsureOverriddenConditional(Conditionals, 'PLATFORMFULL', 'LINUXARM');
  {$ENDIF}
  {$ELSE}
  {$IFDEF LCLQT5}
  EnsureOverriddenConditional(Conditionals, 'PLATFORMFULL', 'LINUXQT5');
  {$ELSE}
  EnsureOverriddenConditional(Conditionals, 'PLATFORMFULL', 'LINUX');
  {$ENDIF}
  {$ENDIF}
  EnsureOverriddenConditional(Conditionals, 'PLATFORM', 'LINUX');
  {$ENDIF}
  {$IFDEF DARWIN}
  {$IFDEF CPUAARCH64}
  EnsureOverriddenConditional(Conditionals, 'PLATFORMFULL', 'MACOSARM');
  {$ELSE}
  EnsureOverriddenConditional(Conditionals, 'PLATFORMFULL', 'MACOS');
  {$ENDIF}
  EnsureOverriddenConditional(Conditionals, 'PLATFORM', 'MACOS');
  {$ENDIF}
  
  EnsureOverriddenConditional(Conditionals, 'LANGUAGE', DefLang);
  
  EnsureOverriddenConditional(Conditionals, 'TITLE', ProjName);
  
  EnsureOverriddenConditional(Conditionals, 'TARGETDIR', '$TARGETDIR$');
  
  GetMem(p, (MAX_PATH+1)*8);
  {$IFDEF WINDOWS}
  if MyGetShortPathName(PChar(CannonFodder(EXEDIR)), p, MAX_PATH) <> 0 then 
    EnsureOverriddenConditional(Conditionals, 'IADIR', DeAssertDir(p))
  else
  {$ENDIF}
    EnsureOverriddenConditional(Conditionals, 'IADIR', DeAssertDir(CannonFodder(EXEDIR)));
  
  {$IFDEF WINDOWS}
  if MyGetShortPathName(PChar(PROJDIR), p, MAX_PATH) <> 0 then
    EnsureOverriddenConditional(Conditionals, 'PROJDIR', DeAssertDir(p))
  else
  {$ENDIF}
    EnsureOverriddenConditional(Conditionals, 'PROJDIR', DeAssertDir(PROJDIR));
  {$IFDEF WINDOWS}
  EnsureOverriddenConditional(Conditionals, 'APPEXTENSION', '.exe');
  EnsureOverriddenConditional(Conditionals, 'BINEXTENSION', '.exe');
  EnsureOverriddenConditional(Conditionals, 'IMGEXTENSION', '.ico');
  {$ELSE}
  {$IFDEF LINUX}
  EnsureOverriddenConditional(Conditionals, 'APPEXTENSION', '');
  EnsureOverriddenConditional(Conditionals, 'BINEXTENSION', '');
  EnsureOverriddenConditional(Conditionals, 'IMGEXTENSION', '.png');
  {$ELSE}
  EnsureOverriddenConditional(Conditionals, 'APPEXTENSION', '.app');
  EnsureOverriddenConditional(Conditionals, 'BINEXTENSION', '');
  EnsureOverriddenConditional(Conditionals, 'IMGEXTENSION', '.icns');
  {$ENDIF}
  {$ENDIF}
  {$IFDEF WINDOWS}
  EnsureOverriddenConditional(Conditionals, 'DOWNEXTENSION', '.exe');
  {$ELSE}
  {$IFDEF LINUX}
  EnsureOverriddenConditional(Conditionals, 'DOWNEXTENSION', '');
  {$ELSE}
  EnsureOverriddenConditional(Conditionals, 'DOWNEXTENSION', '.dmg');
  {$ENDIF}
  {$ENDIF}
  
  FreeMem(p);
  
  EnsureOverriddenConditional(Conditionals, 'IAXVER', '2.1');
  SaveCompilerVariables(Conditionals); 
  
  BackTypes := TStringList.Create;
  BackTypes.CommaText := Types.CommaText;
  
  j := 0;
  k := 0;
  for i := 1 to Types.Count do
    if (Comments <> nil) and (Comments[i -1] <> 'C') then
    begin
      if Types[i -1] = 'Compiler Variable If' then
        j := j +1;
      if Types[i -1] = 'Compiler Variable End' then
        k := k +1;
    end;
  if j <> k then
  begin
    if j > k then Error := SInsufficientCOMPILERVARIABLEENDS
      else Error := STooManyCOMPILERVARIABLEENDStatem;
    Result := MAXINT -3;
    BackCounter := BackCounter -1; 
    Exit;
  end;
   
  sl := TStringList.Create;
  for i := 1 to Derefs.Count do
    for j := 1 to TStringList(Derefs[i -1]).Count do
      sl.Add(TStringList(Derefs[i -1])[j -1]);
  OutDerefs := TList.Create;
  OutDerefs.Add(sl);
  
  for i := 1 to sl.Count do
    sl[i -1] := SubstituteCompilerVariables(sl[i -1], Conditionals);
  
  slX := TStringList.Create;
  for i := 1 to Types.Count do
    slX.Add('FALSE'); 
  i := 0;
  DeferSkipToEnd := 0;
  SkipToEnd := false;
  SkipToElseOrEnd := false;
  ReEnding := false;
  while i < Types.Count do
  begin
    
    if SkipToElseOrEnd then
    begin
      i1 := 0;
      repeat
        i := i +1;
        b := false;
        if Types[i -1] = 'Compiler Variable If' then
          if Comments[i -1] <> 'C' then
          begin
            i1 := i1 +1;
            b := True;
          end;
        if (Types[i -1] = 'Compiler Variable End') then
          if Comments[i -1] <> 'C' then
          begin
            i1 := i1 -1;
            if i1 >= 0 then
              b := True;
          end;
      until (((Types[i -1] = 'Compiler Variable Else') or (Types[i -1] = 'Compiler Variable End')) 
        and ((i1 <= 0) and not b)) and ((Comments = nil) or (Comments[i -1] <> 'C'));
      SkipToElseOrEnd := false;
      if Types[i -1] = 'Compiler Variable End' then
      begin
        i := i -1; 
        ReEnding := True;
      end;
    end;
    if SkipToEnd then
    begin
      i1 := 0;
      repeat
        i := i +1;
        b := false;
        if Types[i -1] = 'Compiler Variable If' then
          if Comments[i -1] <> 'C' then
          begin
            i1 := i1 +1;
            b := True;
          end;
        if (Types[i -1] = 'Compiler Variable End') then
          if Comments[i -1] <> 'C' then
          begin
            i1 := i1 -1;
            if i1 >= 0 then
              b := True;
          end;
      until (((Types[i -1] = 'Compiler Variable End') and (i1 <= 0)) and not b)
        and ((Comments = nil) or (Comments[i -1] <> 'C'));
      SkipToEnd := false;
      i := i -1; 
      ReEnding := True;
    end;
    repeat
      i := i +1;
    until (i >= Types.Count) or ((Comments = nil) or (Comments[i -1] <> 'C'));
    if i > Types.Count then Break;
    if Comments[i -1] = 'C' then Continue; 
    if Types[i -1] = 'Compiler Variable If' then
    begin
      b := True;
      
      if ReadOffset(OutDerefs, References[i -1], 2) = '5' then
      begin
        if not ((IsCompilerVarDefined(ReadOffset(Derefs, References[i -1], 1), Conditionals)
          xor StrToBool(ReadOffset(Derefs, References[i -1], 4)))) then
            SkipToElseOrEnd := True
        else
          DeferSkipToEnd := DeferSkipToEnd +1;
        Continue;
      end;
      
      s1 := CompilerGetStringVar(ReadOffset(OutDerefs, References[i -1], 1));
      if s1 = '' then s1 := ReadOffset(OutDerefs, References[i -1], 1);
      s1 := CompilerGetVariable(s1, Conditionals);
      s2 := CompilerGetStringVar(ReadOffset(OutDerefs, References[i -1], 3));
      if s2 = '' then s2 := ReadOffset(OutDerefs, References[i -1], 3)
        else s2 := CompilerGetVariable(s2, Conditionals);
      b := TryStrToInt64(s1, i164) and TryStrToInt64(s2, i264);
      
      bX := StrToBool(ReadOffset(OutDerefs, References[i -1], 4));
      
      bXX := false;
      if b then
      begin
        if ReadOffset(OutDerefs, References[i -1], 2) = '0' then
          bXX := i164 = i264;
        if ReadOffset(OutDerefs, References[i -1], 2) = '1' then
          bXX := i164 = i264;
        if ReadOffset(OutDerefs, References[i -1], 2) = '2' then
          bXX := i164 > i264;
        if ReadOffset(OutDerefs, References[i -1], 2) = '3' then
          bXX := i164 = i264;
        if ReadOffset(OutDerefs, References[i -1], 2) = '4' then
          bXX := i164 = i264;
      end
      else
      begin
        if ReadOffset(OutDerefs, References[i -1], 2) = '0' then
          bXX := s1 = s2;
        if ReadOffset(OutDerefs, References[i -1], 2) = '1' then
          bXX := AnsiPos(s2, s1) <> 0;
        if ReadOffset(OutDerefs, References[i -1], 2) = '2' then
          bXX := s1 > s2;
        if ReadOffset(OutDerefs, References[i -1], 2) = '3' then
          bXX := ytm_SmartPos(s2, s1, false) <> 0;
        if ReadOffset(OutDerefs, References[i -1], 2) = '4' then
          bXX := CompareText(s1, s2) = 0;
      end;
      bXX := bX xor bXX;
      if not bXX then
        SkipToElseOrEnd := True
      else
        DeferSkipToEnd := DeferSkipToEnd +1;
      Continue;
    end;
    if ReEnding and (Types[i -1] = 'Compiler Variable End') then
    begin
      DeferSkipToEnd := DeferSkipToEnd -1;
      ReEnding := false;
      Continue;
    end;
    if Types[i -1] = 'Compiler Variable Else' then 
    begin
      SkipToEnd := True;
      Continue;
    end;
    if DeferSkipToEnd > 0 then
    begin
      if Types[i -1] = 'Compiler Variable Else' then 
      begin
        SkipToEnd := True;
        Continue;
      end;
      if Types[i -1] = 'Compiler Variable End' then
      begin
        DeferSkipToEnd := DeferSkipToEnd -1;
        Continue;
      end;
    end;
    slX[i -1] := 'TRUE'; 
  end;
  
  for i := Types.Count downto 1 do
    if slX[i -1] <> 'TRUE' then 
      Types[i -1] := 'Comment';
  slX.Free;
end;

procedure WidenColonDelimParam(Param: String; var Wide1, Wide2: String;
  Delim: String);
begin
  Wide1 := Param;
  if AnsiPos(Delim, Wide1) <> 0 then
  begin
    Wide2 := Copy(Wide1, AnsiPos(Delim, Wide1) + Length(Delim), Length(Wide1));
    System.Delete(Wide1, AnsiPos(Delim, Wide1), Length(Wide1));
  end
  else
    Wide2 := '';
end;

function FindAllFilesEyh(Path: String; Recurse, AllowDir, FollowLinks: Boolean): TStringList;
var
  i: LongInt;
  b, bX: Boolean;
  l: TStringList;
  ParentPath, FileSpec: String;
  sr: TSearchRec;
begin
  Result := TStringList.Create; 
  
  thfProgress := (thfProgress +1) mod 101;
  DelegateBindProgress('$IGNORE$', thfProgress, 100, 0);
  
  ParentPath := AssertDir(ExtractFilePath(Path));
  FileSpec := ExtractFileName(Path);
  b := false;
  
  i := FindFirstUTF8(PChar(ParentPath + {$IFDEF WINDOWS}'*.*'{$ELSE}'*'{$ENDIF}),
    {$IFNDEF WINDOWS}faSymLink or {$ENDIF}faAnyFile or faDirectory, sr);
  repeat
    if i = 0 then
    begin
      b := True;
      if ((AnsiCompareText(sr.Name, '.') <> 0) and
        (AnsiCompareText(sr.Name, '..') <> 0)) and
        ((sr.Attr and faDirectory) <> 0) and Recurse then
      begin
        bX := True;
        {$IFNDEF WINDOWS}
        if (sr.Attr and faSymLink) <> 0 then
          if not FollowLinks then bX := false;
        
        {$ENDIF}
        if bX then
        begin
          l := FindAllFilesEyh(ParentPath + sr.Name + PathDelim + FileSpec,
            True, AllowDir, FollowLinks);
          for i := 1 to l.Count do
            Result.Add(l[i -1]);
          l.Free;
        end;
        if tfaf.Terminated then
        begin
          FindCloseUTF8(sr);
          Exit;
        end;
      end;
      if ((AnsiCompareText(sr.Name, '.') <> 0) and
        (AnsiCompareText(sr.Name, '..') <> 0)) and
        ((sr.Attr and faDirectory) <> 0) and AllowDir then
        Result.Add(ParentPath + sr.Name);
    end;
    i := FindNextUTF8(sr);
  until i <> 0;
  if b then
    FindCloseUTF8(sr);
  
  b := false;
  i := FindFirstUTF8(PChar(ParentPath + {$IFDEF WINDOWS}'*.*'{$ELSE}'*'{$ENDIF}),
    {$IFNDEF WINDOWS}faSymLink or {$ENDIF}faAnyFile or faDirectory, sr);
  repeat
    if i = 0 then
    begin
      
      b := True;
      if ((AnsiCompareText(sr.Name, '.') <> 0) and
        (AnsiCompareText(sr.Name, '..') <> 0)) and
        ((sr.Attr and faDirectory) = 0) then
      begin
        
        thfProgressText := ParentPath + sr.Name;
        DelegateBindProgress(thfProgressText, -1, 0, 0);
        
        Result.Add(ParentPath + sr.Name);
        
        if tfaf.Terminated then Break;
      end;
    end;
    i := FindNextUTF8(sr);
  until i <> 0;
  if b then
    FindCloseUTF8(sr);
end;

procedure TFindAllFilesThread.Execute;
begin
  Enter64BitFileSystem(True);
  try
    thfProgress := 0;
    thfProgressText := '';
    thfList := FindAllFilesEyh(thfPath, thfRecurse, thfDir, thfFollow);
    thfList.Delimiter := '|';
  finally
    Leave64BitFileSystem(True);
  end;
  Synchronize(@SetFinished);
  {$IFNDEF LINUX}
  {$IFNDEF NOGUI}
  SendMessage(Application.Handle, 0, 0, 0); 
  {$ENDIF}
  {$ENDIF}
end;

procedure TFindAllFilesThread.SetFinished;
begin
  thfFinished := True;
end;

procedure TNativeThread.BackupProgress;
begin
  {$IFDEF USEVARMANAGER}
   VarManager['NATIVE_PROGRESS_BACKUP'] := VarManager['NATIVE_PROGRESS'];
  {$ELSE}
  SETVARIABLE('NATIVE_PROGRESS_BACKUP',GETVARIABLE('NATIVE_PROGRESS'),'');
  {$ENDIF}
end;

procedure TNativeThread.RestoreProgress;
begin
  {$IFDEF USEVARMANAGER}
  VarManager['NATIVE_PROGRESS'] := VarManager['NATIVE_PROGRESS_BACKUP'];
  {$ELSE}
  SETVARIABLE('NATIVE_PROGRESS', GETVARIABLE('NATIVE_PROGRESS_BACKUP'),'');
  {$ENDIF}
end;

function TNativeThread.IncrementProgress(Increment: Int64; Caption: String
  ): Boolean;
var
  Progress: Int64;
begin
  if not TryStrToInt64(GETVARIABLE('NATIVE_PROGRESS'), Progress) then
  begin
    Progress := 0 + Increment;
  end
  else
  begin
    Progress := Progress + Increment;
  end;
  {$IFDEF USEVARMANAGER}
  VarManager['NATIVE_PROGRESS'] := IntToStr(Progress);
  {$ELSE}
   SETVARIABLE('NATIVE_PROGRESS',IntToStr(Progress),'');
  {$ENDIF}
  if 'ROLLBACK' = TypesI then
    DelegateBindProgress(Caption, NativeTotal -Progress, NativeTotal, 1)
  else
    DelegateBindProgress(Caption, Progress, NativeTotal, 1);
  Result := not Terminated;
end;

function TNativeThread.ShowFolderDialog(Text, Default: String; var Path: String
  ): Boolean;
begin
  try
    Result := True; 
    folPath := '';
    folTitle := Text;
    folDefault := Default;
    Synchronize(@ShowFolderDialogActual);
    Result := folResult;
    if Result then Path := folPath;
  finally
    if not Result then
      SureSetVariable('MYAH_IsCancelled', 'TRUE', 'Native Folder Processor');
  end;
end;

function TNativeThread.ShowErrorDialog(Text: String; var Retry: Boolean;
  SafetyNet: Integer): Boolean;
var
  varAbort, varRetry, varIgnore, varPrompt: Boolean;
begin
  
  if  SafetyNet = 0 then
  begin
    
    Retry := false;
    Exit;
    
  end;
  
  Result := false; 
  
  WriteToLog('        <NATIVE ERROR>');
  WriteToLog('          < ' + Text + ' >');
  WriteToLog('        </NATIVE ERROR>');
  
  NativeError(varAbort, varRetry, varIgnore, varPrompt);
  if varRetry then
  begin
    Retry := True;
    Exit;
  end
  else
  if varIgnore then
  begin
    Retry := false;
    Exit;
  end
  else
  if varAbort then
  begin
    Retry := false;
    Result := True;
    SureSetVariable('MYAH_IsCancelled', 'TRUE', 'Native Error Processor'); 
    Exit;
  end;
  
  if SilentInstall or StrToBool(GetVariable('ABORTEDONERROR')) then 
  begin
    Retry := false; 
    Exit;
  end;
  
  errTitle := GETVARIABLE('TITLE');
  errText := Text;
  Synchronize(@ShowErrorDialogActual);
  Retry := errRetry;
  Result := errCancel;
  if errToAll then
  begin
    if Retry then
      SureSetVariable('NATIVE_ERROR', 'RETRY', 'Native Error Processor')
    else
      SureSetVariable('NATIVE_ERROR', 'IGNORE', 'Native Error Processor')
  end;
  if Result then
    SureSetVariable('MYAH_IsCancelled', 'TRUE', 'Native Error Processor');
end;

function TNativeThread.ShowOverwriteDialog(SourceFile, TargetFile: String;
  var Overwrite: Boolean): Boolean;
var
  varOlder, varSkip, varOverwrite, varPrompt, isNewer: Boolean;
  opOK, opCancel, opRetry: Boolean;
  SourceVersion, TargetVersion, SourceDate, TargetDate: String;
  eBuf: Cardinal;
begin
  try
    
    Result := false; 
    Overwrite := True; 
    if not MyFileExists(TargetFile) then Exit; 
    NativeOverwrite(varOlder, varSkip, varOverwrite, varPrompt); 
    if varSkip then 
    begin
      Overwrite := false;
      Exit;
    end;
    if varOlder and varOverwrite then Exit; 
    isNewer := isSourceNewer(SourceFile, TargetFile, SourceVersion, TargetVersion, SourceDate, TargetDate); 
    if isNewer and varOverwrite then Exit; 
    if (not isNewer) and (not varOlder) then
    begin
      Overwrite := false; 
      Exit;
    end;
    
    ovrTitle := GETVARIABLE('TITLE');
    ovrText := TargetFile + MyLineEnding + MyLineEnding + ntv4 + TargetVersion + MyLineEnding + ntv3 + TargetDate
      + MyLineEnding + MyLineEnding + ntv6 + SourceVersion + MyLineEnding + ntv5 + SourceDate;
    Synchronize(@ShowOverwriteDialogActual);
    Overwrite := ovrOverwrite;
    Result := ovrCancel;
    if ovrToAll then
    begin
      if Overwrite then
        SureSetVariable('NATIVE_OVERWRITE', 'ALWAYS', 'Native Overwrite Processor')
      else
        SureSetVariable('NATIVE_OVERWRITE', 'NEVER', 'Native Overwrite Processor')
    end;
  finally
    if Result then
      SureSetVariable('MYAH_IsCancelled', 'TRUE', 'Native Error Processor');
  end;
end;

procedure TNativeThread.BroadcastEnvironment;
{$IFDEF WINDOWS}
var
  lParam, wParam : Integer;   
  Buf     : Array[0..10] of Char; 
  aResult : Cardinal;         
begin
  
   Buf := 'Environment';
   wParam := 0;
   
   lParam := Integer(@Buf[0]);
   SendNotifyMessage(HWND_BROADCAST, WM_SETTINGCHANGE, wParam, lParam);
{$ELSE}
begin
{$ENDIF}
end;

function TNativeThread.NativeGrabSource: Boolean;
var
  b, bX, bY: Boolean;
  s1: String;
begin
  Result := True; 
  
  if not MyFileExists(CachedDataDir + PGUIDEX) then
  begin
    bY := false;
    
    if MinExtract then
      
      if not ProcessMinExtract(True, True) then
      begin
        SetVariable('LASTERROR', msg17, 'Native Engine Source Acquisition'); 
        Result := false;
        Exit;
        
      end
      else
        bY := True;
        
    if StrToBool(GetVariable('MAINTENANCE')) then 
      if not (MediaLayout = 2) then 
        if not bY then 
        begin
          Result := false;
          b := false;
          bX := false;
          repeat
            if SilentInstall then b := True
              else
              begin
                
                b := not
                  
                  ShowFolderDialog(msg16, '', s1);
                
              end;
            
            bX := MyFileExists(AssertDir(s1) + PGUIDEX) or MyFileExists(AssertDir(s1) + 'data' + PathDelim + PGUIDEX);
          until b or bX;
          if bX then
          begin
            if MyFileExists(AssertDir(s1) + PGUIDEX) then CachedDataDir := AssertDir(s1)
              else CachedDataDir := AssertDir(s1) + 'data' + PathDelim;
            CachedPlugRootDir := CachedDataDir;
            Result := True;
          end
          else
          if b then
          begin
            
            SetVariable('LASTERROR', msg17, 'Native Engine Source Acquisition'); 
            Result := false;
          end;
        end;
  end;
end;

procedure TNativeThread.Execute;
var
  j: Integer;
  i64X, i64: Int64;
  x64ModeX: String;
begin
  try
    inDelayedInstall := false;
    inInstallFilesSection := false;
    if (TypesI = 'UNINSTALL') or (TypesI = 'ROLLBACK') then 
    begin
      try
        WriteToLog('      <NATIVE ' + TypesI + '>');
        thNativei1 := NativeApplyLogEvents(TypesI = 'UNINSTALL');
        WriteToLog('      </NATIVE ' + TypesI + '>');
      except
        thNativei1 := -1; 
        thNatives1 := msg18;
      end;
      if TypesI = 'ROLLBACK' then
        thNativei1 := 1; 
    end
    else
    if TypesI = 'DELAYEDINSTALL' then 
    try
      inDelayedInstall := True;
      WriteToLog('      <NATIVE DELAYEDINSTALL>');
      x64ModeX := x64Mode;
      i64X := NativeTotal;
      NativeTotal := NativeDelayProgress;
      for j := 1 to NativeDelayStack.Count do
        if j mod 4 = 0 then
        begin
          TypesI := NativeDelayStack[j -4];
          i := StrToInt(NativeDelayStack[j -3]);
          CompactDataStack := NativeDelayStack[j -2];
          x64Mode := NativeDelayStack[j -1];
          try
            if not ProcessSingleType then
            begin
              thNativei1 := 0; 
              Exit;
            end;
          except
            thNativei1 := -1;
            thNatives1 := msg18;
            Break;
          end;
        end;
      WriteToLog('      </NATIVE DELAYEDINSTALL>');
      thNativei1 := 1;
    finally
      NativeTotal := i64X;
      x64Mode := x64ModeX;
    end
    else
    try
      WriteToLog('      <NATIVE INSTALL>');
      if not ProcessSingleType then
        thNativei1 := 0; 
      WriteToLog('      </NATIVE INSTALL>');
    except
      thNativei1 := -1;
      thNatives1 := msg18;
    end;
  finally
    Synchronize(@SetFinished);
    {$IFNDEF LINUX}
    {$IFNDEF NOGUI}
    SendMessage(Application.Handle, 0, 0, 0); 
    {$ENDIF}
    {$ENDIF}
  end;
end;

procedure TNativeThread.SetFinished;
begin
  thSpoolerFinished := True;
end;

procedure TNativeThread.ShowErrorDialogActual;
var
  iX: Integer;
  {$IFNDEF NOGUI}
  dlg: TForm;
  {$ELSE}
  c: Char;
  j: Integer;
  {$ENDIF}
begin
  {$IFNDEF NOGUI}
  {$IFDEF DARWIN}
  dlg := CreateMessageDialog(StringReplace(errText, MyLineEnding, LineEnding, [rfReplaceAll, rfIgnoreCase]) + LineEnding + LineEnding + ntv1, mtError, mbYesAllNoAllCancel);
  {$ELSE}
  dlg := CreateMessageDialog(errText + MyLineEnding + MyLineEnding + ntv1, mtError, mbYesAllNoAllCancel);
  {$ENDIF}
  dlg.Caption := msg24;
  dlg.ParentWindow := 0;
  iX := dlg.ShowModal;
  dlg.Free;
  {$ELSE}
  WriteLn; 
  Write(msg24);
  for j := 1 to Length(errText) - Length(msg24) do
    Write('=');
  WriteLn;
  WriteLn(errText + MyLineEnding + MyLineEnding + ntv1);
  for j := 1 to Length(ntv1) - Length(msg24) do
    Write('=');
  WriteLn;
  WriteLn('(Y)es to All  (y)es  (N)o To All  (n)o  (C)ancel');
  repeat
    c := ReadKey;
  until (((c = 'Y') or (c = 'y')) or ((c = 'N') or (c = 'n'))) or (c = 'C');
  case c of
    'Y': iX := mrYesToAll;
    'y': iX := mrYes;
    'N': iX := mrNoToAll;
    'n': iX := mrNo;
    'C': iX := mrCancel;
    #27: iX := mrCancel;
    #13: iX := mrYes; 
  end;
  {$ENDIF}
  
  case iX of
    mrAll, mrNoToAll, mrYesToAll: errToAll := True;
  else
    errToAll := False;
  end;
  
  case iX of
    mrOk, mrYes, mrAll, mrYesToAll: errRetry := True;
  else
    errRetry := False;
  end;
  errCancel := iX = mrCancel;
end;

procedure TNativeThread.ShowFolderDialogActual;
{$IFNDEF NOGUI}
var
  dlg: TFolderBrowse;
  iX: Integer;
begin
  folResult := false;
  folPath := '';
  dlg := TFolderBrowse.Create(nil);
  dlg.ParentWindow := 0;
  dlg.Caption := SubstituteVariables('$TITLE$');
  dlg.Label1.Caption := folTitle;
  dlg.Tree.Path := folDefault;
  if dlg.ShowModal = mrOk then
  begin
    folPath := dlg.Folder.Text;
    folResult := True;
  end;
  dlg.Free;
{$ELSE}
begin
  folResult := MySelectDirectory(folTitle, folDefault, folPath);
{$ENDIF}
end;

procedure TNativeThread.ShowOverwriteDialogActual;
var
  iX: Integer;
  {$IFNDEF NOGUI}
  dlg: TForm;
  {$ELSE}
  c: Char;
  j: Integer;
  {$ENDIF}
begin
  {$IFNDEF NOGUI}
  {$IFDEF DARWIN}
  dlg := CreateMessageDialog(StringReplace(ovrText, MyLineEnding, LineEnding, [rfReplaceAll, rfIgnoreCase]) + LineEnding + LineEnding + ntv8, mtConfirmation, mbYesAllNoAllCancel);
  {$ELSE}
  dlg := CreateMessageDialog(ovrText + MyLineEnding + MyLineEnding + ntv8, mtConfirmation, mbYesAllNoAllCancel);
  {$ENDIF}
  dlg.Caption := ntv7;
  dlg.ParentWindow := 0;
  iX := dlg.ShowModal;
  dlg.Free;
  {$ELSE}
  WriteLn; 
  Write(ntv7);
  for j := 1 to Length(ovrText) - Length(ntv7) do
    Write('=');
  WriteLn;
  WriteLn(ovrText + MyLineEnding + MyLineEnding + ntv8);
  for j := 1 to Length(ntv8) - Length(ntv7) do
    Write('=');
  WriteLn;
  WriteLn('(Y)es to All  (y)es  (N)o To All  (n)o  (C)ancel');
  repeat
    c := ReadKey;
  until (((c = 'Y') or (c = 'y')) or ((c = 'N') or (c = 'n'))) or (c = 'C');
  case c of
    'Y': iX := mrYesToAll;
    'y': iX := mrYes;
    'N': iX := mrNoToAll;
    'n': iX := mrNo;
    'C': iX := mrCancel;
    #27: iX := mrCancel;
    #13: iX := mrYes; 
  end;
  {$ENDIF}
  
  case iX of
    mrAll, mrNoToAll, mrYesToAll: ovrToAll := True;
  else
    ovrToAll := False;
  end;
  
  case iX of
    mrOk, mrYes, mrAll, mrYesToAll: ovrOverwrite := True;
  else
    ovrOverwrite := False;
  end;
  ovrCancel := iX = mrCancel;
end;

function TNativeThread.LoggedFileCopyFile(Source, Target: String; FailIfExists: Boolean): Boolean;
begin
  NativeLogAddEntry('Create File', Target); 
  Result := FileCopyFile(Source, Target, FailIfExists);
  if not Result then
    NativeLogDeleteLastEntry;
end;

{$IFDEF WINDOWS}
type
  TFNProgressRoutine = TFarProc;

function CreateHardLink(lpFileName, lpExistingFileName: PChar;
  lpSecurityAttributes: PSecurityAttributes): BOOL; stdcall; external kernel32 name 'CreateHardLinkW';

function MyGetFileSize64(const S: string): Int64;
var
  FD: Windows.TWin32FindData;
  FH: THandle;
  sX: String;
begin
  if AnsiPos('\\?\', s) <> 1 then
    FH := Windows.FindFirstFile(PChar('\\?\' + S), FD)
  else
    FH := Windows.FindFirstFile(PChar(S), FD);
  if FH = INVALID_HANDLE_VALUE then
  begin
    if (AnsiPos('\\', s) = 1) and (AnsiPos('\\?\', s) <> 1) then
    begin
      sX := s;
      System.Delete(sX, 1, 2);
      Result := MyGetFileSize64('\\?\UNC\' + sX);
    end
    else
      Result := 0;
    
  end
  else
    try
      Result := FD.nFileSizeHigh;
      Result := Result shl 32;
      Result := Result + FD.nFileSizeLow;
    finally
      Windows.FindClose(FH);
    end;
end;

function MyCopyFileEx(lpExistingFileName, lpNewFileName: PChar;
  lpProgressRoutine: TFNProgressRoutine; lpData: Pointer; pbCancel: PBool;
  dwCopyFlags: DWORD): BOOL;
type
  PCopyFileEx = ^TCopyFileEx;
  TCopyFileEx = function(lpExistingFileName, lpNewFileName: PChar;
    lpProgressRoutine: TFNProgressRoutine; lpData: Pointer; pbCancel: PBool;
    dwCopyFlags: DWORD): BOOL; stdcall;
var
  h: THandle;
  cfe: TCopyFileEx; 
begin
  
  if (AnsiCompareText(GetVariable('NATIVE_HARDLINK'), 'TRUE') = 0) and
    (AnsiCompareText(ExtractFileDrive(lpNewFileName), ExtractFileDrive(lpExistingFileName)) = 0) then
  begin
    if (dwCopyFlags and COPY_FILE_FAIL_IF_EXISTS) = COPY_FILE_FAIL_IF_EXISTS then
      if MyFileExists(lpNewFileName) then
      begin
        Result := false;
        SetLastError(183);
        Exit;
      end;
    Result := CreateHardLink(lpNewFileName, lpExistingFileName, nil);
    if Result then 
    begin
      TNativeThread(lpData).IncrementProgress(MyGetFileSize64(lpExistingFileName), '$IGNORE$');
      Result := SetFileAttributes(lpNewFileName, FILE_ATTRIBUTE_NORMAL); 
      Exit;
    end;
  end;
  h := LoadLibrary('kernel32.dll');
  if h <> 0 then
  begin
    Pointer(cfe) := nil;
    Pointer(cfe) := GetProcAddress(h, 'CopyFileExW');
    if Assigned(cfe) then
      Result := cfe(lpExistingFileName, lpNewFileName, lpProgressRoutine, lpData, pbCancel, dwCopyFlags);
    if Result then 
      Result := SetFileAttributes(lpNewFileName, FILE_ATTRIBUTE_NORMAL); 
  end;
  FreeLibrary(h);
end;

function CopyFileExProgress(TotalFileSize, TotalBytesTransferred, StreadSize, StreamBytesTransferred: LARGE_INTEGER;
  dwStreamNumber, dwCallbackReason: DWORD; hSourceFile, hDestinationFile: THandle; lpData: TNativeThread): DWORD; stdcall;
var
  i: Int64;
begin
  Result := PROGRESS_CONTINUE;
  if (not lpData.inDelayedInstall) and (not lpData.inInstallFilesSection) then
  begin
    if not lpData.IncrementProgress(0, '$IGNORE$') then Result := PROGRESS_CANCEL;
  end
  else
  begin
    if cbTotal = 0 then
    begin
      cbTotal := TotalBytesTransferred.QuadPart;
      cbCurrent := cbTotal;
    end
    else
    begin
      cbCurrent := TotalBytesTransferred.QuadPart - cbTotal;
      cbTotal := TotalBytesTransferred.QuadPart;
    end;
    i := cbCurrent;
    
    if not lpData.IncrementProgress(i, '$IGNORE$') then Result := PROGRESS_CANCEL;
    
  end;
end;
{$ENDIF}

function MyCreateShortcut(ToFile, Startup, LinkPath, Arguments, Hint, IconPath: String;
  WindowSize: Integer; IconIndex: Integer; var LastError: String{$IFDEF DARWIN}; MSIFileEx: String = ''{$ENDIF}): Boolean;
{$IFDEF WINDOWS}
var
  IObject: IUnknown;
  ISLink: IShellLink;
  IPFile: IPersistFile;
  PIDL: PItemIDList;
begin
  try
    Result := false;
    LastError := '';
    CoInitialize(nil);
    IObject := CreateComObject(CLSID_ShellLink);
    ISLink := IObject as IShellLink;
    IPFile := IObject as IPersistFile;
    with ISLink do
    begin
      SetPath(PChar(ToFile));
      SetWorkingDirectory(PChar(Startup));
      SetArguments(PChar(Arguments));
      SetDescription(PChar(Hint));
      SetShowCmd(WindowSize);
      if AnsiCompareText(ExtractFileExt(IconPath), '.png') <> 0 then
        SetIconLocation(PChar(IconPath), IconIndex);
    end;
    IPFile.Save(PWideChar(WideString(LinkPath)), false);
    Result := True;
  except
    on E: Exception do
    begin
      LastError := E.Message;
      Result := false;
    end;
  end;
{$ELSE}
var
  t, tX: TextFile;
{$IFDEF LINUX}
begin
  try
    if MyFileExists(LinkPath + '.desktop') or DirectoryExists(LinkPath + '.desktop') then
    begin
      
      fpUnlink(LinkPath + '.desktop');
      DeleteFile(LinkPath + '.desktop');
      RemoveDirectory(LinkPath + '.desktop');
    end;
    {$IFDEF LCLQT5}
    if Startup = '' then
      if AnsiCompareText(AssertDir(ExtractFilePath(ToFile)), AssertDir(SubstituteVariables('$ENGINECACHE$'))) = 0 then
        Startup := SubstituteVariables('$ENGINECACHE$'); 
    {$ENDIF}
    AssignFile(t, LinkPath + '.desktop');
    ReWrite(t);
    WriteLn(t, '[Desktop Entry]');
    WriteLn(t, 'Type=Application');
    WriteLn(t, 'Version=' + SubstituteVariables('$VERSION$'));
    WriteLn(t, 'Name=' + ExtractFileName(LinkPath)); 
    WriteLn(t, 'Comment=' + Hint); 
    if IconPath = '' then
      if AnsiCompareText(GetVariable('UNINSTALLLINK'), ToFile) = 0 then 
      begin
        IconPath := AssertDir(ExtractFilePath(LinkPath)) + 'icon.png';
        FileCopyFile(AssertDir(GetVariable('SUPPORTDIR')) + 'icon.png', IconPath, false);
        NativeLogAddEntry('Create File', IconPath);
      end;
    if IconPath <> '' then
      WriteLn(t, 'Icon=' + IconPath); 
    if Startup = '' then
      WriteLn(t, 'Exec="' + ToFile + '" ' + Arguments) 
    else
      
      WriteLn(t, 'Exec=/bin/sh "' + LinkPath + '.sh"');
    {$IFDEF NOGUI}
    
    if AnsiCompareText(GetVariable('UNINSTALLLINK'), ToFile) = 0 then 
      WriteLn(t, 'Terminal=true')
    else
    {$ENDIF}
      WriteLn(t, 'Terminal=false');
    CloseFile(t);
    LazShimSetExecutable(LinkPath + '.desktop', MyParamStr(0)); 
    NativeLogAddEntry('Create File', LinkPath + '.desktop');
    if Startup <> '' then 
    begin
      AssignFile(t, LinkPath + '.sh');
      ReWrite(t);
      WriteLn(t, '#!/bin/sh');
      WriteLn(t, 'cd "' + Startup + '"');
      WriteLn(t, '"' + ToFile + '" ' + Arguments);
      CloseFile(t);
      LazShimSetExecutable(LinkPath + '.sh', MyParamStr(0)); 
      NativeLogAddEntry('Create File', LinkPath + '.sh');
    end;
  except
    Result := false;
  end;
  Result := True;
  if not Result then LastError := SysErrorMessage(fpGetErrNo);
{$ELSE}
  s, sX, sY, sZ: String;
begin
  
  if (Arguments = '') then 
  begin
    if MyFileExists(LinkPath, false) or DirectoryExists(LinkPath, false) then
      fpUnlink(LinkPath);
    Result := fpSymLink(PChar(ToFile), PChar(LinkPath)) = 0;
    
    if not Result then
      LastError := SysErrorMessage(fpGetErrNo)
    else
    begin
      NativeLogAddEntry('Create File', LinkPath);
      
      {$IFDEF DARWIN}
      TouchList.Add(ToFile);
      TouchList.Add(LinkPath);
      {$ENDIF}
    end;
    Exit;
  end;
  
  sY := Trim(ExtractFileNameOnly(LinkPath));
  sY := StringReplace(sY, ' ', '', [rfReplaceAll, rfIgnoreCase]);
  Result := false;
  sX := LinkPath + '.app/Contents/MacOS/' + sY + '.command';
  AssignFile(t, sX);
  ReWrite(t);
  WriteLn(t, '#!/bin/sh');
  {$IFDEF NOGUI}
  if (Arguments <> '') and (AnsiCompareText(GetVariable('UNINSTALLLINK'), ToFile) = 0) then 
  begin
    
    WriteLn(t, 'open -a Terminal "' + LinkPath + '.app/Contents/MacOS/' + sY + 'Ex.command"');
    CloseFile(t);
    NativeLogAddEntry('Create File', LinkPath + '.app/Contents/MacOS/' + sY + 'Ex.command');
    AssignFile(t, LinkPath + '.app/Contents/MacOS/' + sY + 'Ex.command');
    ReWrite(t);
    WriteLn(t, '#!/bin/sh');
    WriteLn(t, '"' + ToFile + '/Contents/MacOS/miaxstub" ' + Arguments);
  end
  else
  begin
  {$ENDIF}
    s := '"' + ToFile + '"';
    if Arguments <> '' then
      
      s := '-a ' + s + ' --args ' + Arguments;
      
    WriteLn(t, 'open ' + s);
  {$IFDEF NOGUI}
  end;
  {$ENDIF}
  CloseFile(t);
  NativeLogAddEntry('Create File', sX);
  fpChMod(sX, 500);
  {$IFDEF NOGUI}
  fpChMod(LinkPath + '.app/Contents/MacOS/' + sY + 'Ex.command', 500);
  {$ENDIF}
  sX := LinkPath + '.app/Contents/Resources/' + sY + '.icns';
  if IconPath = '' then
  begin
    s := AnsiLowerCase(ToFile);
    if AnsiPos('.app/contents/macos', DeAssertDir(ExtractFilePath(s)))
      = Length(DeAssertDir(ExtractFilePath(s))) -18 then
    begin
      s := DeAssertDir(ExtractFilePath(ToFile));
      Delete(s, Length(s) -18, Length(s));
      s := s + '.app';
    end;
    if AnsiPos('.app', s) <> 0 then
      if AnsiPos('.app', s) = Length(s) -3 then
      begin
        s := s + '/Contents/Info.plist';
        sZ := s;
        if MyFileExists(s) then
        begin
          AssignFile(t, s);
          Reset(t);
          while not EOF(t) do
          begin
            ReadLn(t, s);
            s := Trim(s);
            if AnsiCompareText('<key>CFBundleIconFile</key>', s) = 0 then
              if not EOF(t) then
              begin
                ReadLn(t, s);
                s := Trim(s);
                s := StringReplace(s, '<string>', '', [rfIgnoreCase, rfReplaceAll]);
                s := StringReplace(s, '</string>', '', [rfIgnoreCase, rfReplaceAll]);
                if MyFileExists(s) then
                  IconPath := s;
                Break;
              end;
          end;
          CloseFile(t);
        end;
        if (not MyFileExists(sZ)) or (IconPath = '') then
          
          if AnsiCompareText(GetVariable('UNINSTALLLINK'), ToFile) = 0 then
            {$IFNDEF INTEROP}
            IconPath := AssertDir(ExtractFilePath(MSIFileEx)) + ExtractFileNameOnly(MSIFileEx) +
              '.app/Contents/Resources/miaxstub.icns';
            {$ELSE}
            IconPath := AssertDir(ExtractFilePath(DeAssertDir(ExtractFilePath(MyParamStr(0)))))
              + 'Resources/miaxstub.icns';
            {$ENDIF}
      end;
  end;
  if IconPath <> '' then
  begin
    
    if FileCopyFile(IconPath, sX, false) then
      NativeLogAddEntry('Create File', sX);
    
  end;
  sX := LinkPath + '.app/Contents/Info.plist';
  AssignFile(t, sX);
  ReWrite(t);
  WriteLn(t, '<?xml version="1.0" encoding="UTF-8"?>');
  WriteLn(t, '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">');
  WriteLn(t, '<plist version="1.0">');
  WriteLn(t, '<dict>');
  WriteLn(t, '  <key>CFBundleExecutable</key>');
  WriteLn(t, '  <string>' + sY + '.command</string>');
  if IconPath <> '' then
  begin
    WriteLn(t, '  <key>CFBundleIconFile</key>');
    WriteLn(t, '  <string>' + sY + '.icns</string>');
  end;
  
  WriteLn(t, '</dict>');
  WriteLn(t, '</plist>');
  CloseFile(t);
  NativeLogAddEntry('Create File', sX);
  Result := True;
{$ENDIF}
{$ENDIF}
end;

function TNativeThread.ProcessSingleType(PauseProgress: Boolean): Boolean;
var
  t: TextFile;
  tif: TINIFile;
  s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12, s13, s14, s15, s16, s17, s18: String;
  lw: LongWord;
  sv1, sv2, sv3, sv4, sv5, sv6, sv7, sv8, sv9, sv10, sv11, sv12, sv13, sv14, sv15, sv16, sv17: String;
  pv1, pv2, pv13, pv4, pv5, pv10, pv11: PChar;
  iv1, iv2, iv3: DWORD;
  eBuf: Cardinal;
  i1, i2, i3, i4, i2_len, i3_len, i5, iBuf, ftLoop1: Integer;
  c1, c2: Cardinal;
  opOK, opCancel, opRetry, b, bO, bOX, bV, bW, bX, bY, bZ: Boolean;
  sl, slX, ftExts, ftVerbs, ftVerbActs: TStringList;
  iX, iY: Integer;
  p, pX: PChar;
  dw: DWORD;
  h, hX: THandle;
  {$IFDEF WINDOWS}
  pb: PBool;
  ss: TServiceStatus;
   
  {$ENDIF}
  Attrib, Value: TStringList;
  hSec: THandle;
  Wide1, Wide2: String;
  b1, b2, b3: Boolean;
  
  pS: Pointer;
  pSX, pSY: PChar;
  
  si: SmallInt;
  
  errMsg: PChar;
  hk1: HKEY;
  hSecFile: THandle;
begin
  if NativeFileSourceStackHashed.Count = 0 then
    NativeFileSourceStackHashed.Text :=
      NativeFileSourceStack.Text;
  
  WriteToLog('        <' + TypesI + '>');
  Result := false;
  opCancel := false;
  dataStack.CommaText := CompactDataStack;
  
  if TypesI = 'Write Registry' then
  {$IFDEF WINDOWS}
  try
    Enter64BitRegistry;
    s1 := dataStack[0]; 
    s2 := dataStack[1]; 
    WidenColonDelimParam(s2, Wide1, Wide2);
    s2 := Wide1; 
    if not ((s2 = '2') or (s2 = '3')) then
      Wide2 := '';
    if Wide2 <> '' then
      if AnsiPos('\\', Wide2) <> 1 then
        Wide2 := '\\' + Wide2;
    s3 := dataStack[2]; 
    s4 := dataStack[3]; 
    s5 := dataStack[4]; 
    s6 := dataStack[5]; 
    case StrToInt(s2) of
      0: begin s7 := 'HKEY_CLASSES_ROOT'; i1 := longint(HKEY_CLASSES_ROOT); end;
      1: begin s7 := 'HKEY_CURRENT_USER'; i1 := longint(HKEY_CURRENT_USER); end;
      2: begin s7 := 'HKEY_LOCAL_MACHINE'; i1 := longint(HKEY_LOCAL_MACHINE); end;
      3: begin s7 := 'HKEY_USERS'; i1 := longint(HKEY_USERS); end;
    end;
    if not IncrementProgress(weightWR, AssertDir(s7) + AssertDir(s3) + AssertDir(s4) + s5) then Exit;
    bW := false;
    if not StrToBool(s1) then
    begin
      sl := TStringList.Create;
      sl.Add(IntToStr(i1) + '|' + Wide2); 
      sl.Add(s3); 
      sl.Add(s4); 
      NativeLogAddEntry('Write Registry', sl.CommaText);
      bW := True;
      sl.Free;
    end;
    hSec := ClearRegSecurity(HKEY(i1), s3, Wide2); 
    repeat
      if s6 = 'STRING' then
        opOK := RegSetStringEz(HKEY(i1), s3, s4, s5, i2, Wide2)
      else
      if s6 = 'INTEGER' then
      begin
        if TryStrToInt(s5, i3) then
          opOK := RegSetDWORDEz(HKEY(i1), s3, s4, i3, i2, Wide2)
        else
        begin
          opOK := false;
          i2 := 1700; 
        end;
      end
      else
      if s6 = 'EXPANDSTRING' then
        opOK := RegSetExpandStringEz(HKEY(i1), s3, s4, s5, i2, Wide2)
      else
      if s6 = 'APPEND' then
      begin
        s8 := '';
        opOK := True;
        if RegValueExistsEz(HKEY(i1), s3, s4, Wide2) then
          if RegGetValueTypeEz(HKEY(i1), s3, s4, c1, Wide2) then
            if REG_MULTI_SZ = c1 then
            begin
              opOK := RegGetMultiStringEz(HKEY(i1), s3, s4, s8, i2, Wide2);
              if Length(s8) > 0 then
                if s8[Length(s8)] = #0 then
                  System.Delete(s8, Length(s8), 1);
              if opOK then s8 := s8 + #0;
            end;
        if opOK then
          opOK := RegSetMultiStringEz(HKEY(i1), s3, s4, s8 +s5, i2, Wide2)
      end
      else
      if s6 = 'PREPEND' then
      begin
        s8 := '';
        opOK := True;
        if RegValueExistsEz(HKEY(i1), s3, s4, Wide2) then
          if RegGetValueTypeEz(HKEY(i1), s3, s4, c1, Wide2) then
            if REG_MULTI_SZ = c1 then
            begin
              opOK := RegGetMultiStringEz(HKEY(i1), s3, s4, s8, i2, Wide2);
              if Length(s8) > 0 then
                if s8[Length(s8)] = #0 then
                  System.Delete(s8, Length(s8), 1);
              if opOK then s8 := #0 + s8;
            end;
        if opOK then
          opOK := RegSetMultiStringEz(HKEY(i1), s3, s4, s5 + s8, i2, Wide2)
      end
      else
      if s6 = 'BINARY' then
        opOK := RegSetBinaryEz(HKEY(i1), s3, s4, StringToByteArray(s5), i2, Wide2);
      if not opOK then
        
        opCancel := ShowErrorDialog(SysErrorMessage(i2) + MyLineEnding + MyLineEnding + AssertDir(s7) + AssertDir(s3) + AssertDir(s4) + s5, opRetry, i2)
      else
      begin
        if hSec <> 0 then
          RestoreSecurity(hSec);
      end;
    until (opOK or opCancel) or (not opRetry);
    if not opOK then
    begin
      if bW then
        NativeLogDeleteLastEntry;
    end
    else
      WriteToLog('        < ' + AssertDir(s7) + AssertDir(s3) + DeAssertDir(s4) + '=' + s5 + ' >');
    if opCancel then Exit;
  finally
    Leave64BitRegistry;
  {$ELSE}
  begin
    WriteToLog('        < Write Registry Skipped >');
    if opCancel then Exit;
  {$ENDIF}
  end
  else
  if TypesI = 'Create Shortcut' then
  try
    Enter64BitFileSystem(True);
    s1 := dataStack[0]; 
    s2 := dataStack[1]; 
    s3 := dataStack[2]; 
    s4 := dataStack[3]; 
    s5 := dataStack[4]; 
    s6 := dataStack[5]; 
    s7 := dataStack[6]; 
    s8 := dataStack[7]; 
    s9 := dataStack[8]; 
    
    if {$IFNDEF DARWIN}not DirectoryExists(s3){$ELSE}True{$ENDIF} then
    begin
      {$IFDEF DARWIN}
      if s5 <> '' then
      begin
        dataStack.Clear;
        dataStack.Add(AssertDir(s3) + s1 + '.app/Contents/Resources/');
        CompactDataStack := dataStack.CommaText;
        TypesI := 'Create Folder';
        if not ProcessSingleType(True) then Exit;
        dataStack.Clear;
        dataStack.Add(AssertDir(s3) + s1 + '.app/Contents/MacOS/');
        CompactDataStack := dataStack.CommaText;
        TypesI := 'Create Folder';
        if not ProcessSingleType(True) then Exit;
      end
      else
      begin
      {$ENDIF}
        dataStack.Clear;
        dataStack.Add(s3);
        CompactDataStack := dataStack.CommaText;
        TypesI := 'Create Folder';
        if not ProcessSingleType(True) then Exit;
      {$IFDEF DARWIN}
      end;
      {$ENDIF}
    end;
    
    if not IncrementProgress(weightCS, AssertDir(s3) + s1{$IFDEF WINDOWS} + '.lnk'{$ENDIF}{$IFDEF LINUX} + '.desktop'{$ENDIF}) then Exit; 
    if s9 = '0' then
      i1 := SW_SHOWNORMAL;
    if s9 = '1' then
      i1 := SW_SHOWMAXIMIZED;
    if s9 = '2' then
      i1 := SW_SHOWMINNOACTIVE;
    if not TryStrToInt(s8, i2) then
      i2 := 0;
    {$IFNDEF DARWIN}
    NativeLogAddEntry('Create File', AssertDir(s3) + s1{$IFDEF WINDOWS} + '.lnk'{$ENDIF}{$IFDEF LINUX} + '.desktop'{$ENDIF});
    {$ENDIF}
    repeat
      opOK := MyCreateShortcut(s4, AssertDir(s6), AssertDir(s3) + s1{$IFDEF WINDOWS} + '.lnk'{$ENDIF}, 
        s5, s2, s7, i1, i2, s10{$IFDEF DARWIN}, MSIFile{$ENDIF});
      if not opOK then
      begin
        if s10 = '' then
          s10 := ntv2;
        opCancel := ShowErrorDialog(s10 + MyLineEnding + MyLineEnding + AssertDir(s3) + s1{$IFDEF WINDOWS} + '.lnk'{$ENDIF}{$IFDEF LINUX} + '.desktop'{$ENDIF}, opRetry, -1); 
      end;
    until (opOK or opCancel) or (not opRetry);
    if not opOK then NativeLogDeleteLastEntry
    else
      WriteToLog('        < ' + AssertDir(s3) + s1{$IFDEF WINDOWS} + '.lnk'{$ENDIF}{$IFDEF LINUX} + '.desktop'{$ENDIF} + ' >');
    if opCancel then Exit;
  finally
    Leave64BitFileSystem(True);
  end
  else
  if TypesI = 'Install Files' then
  try
    inInstallFilesSection := True;
    Enter64BitFileSystem(True);
    s1 := dataStack[0]; 
    s2 := dataStack[1]; 
    s3 := dataStack[2]; 
    s4 := dataStack[3]; 
    s5 := dataStack[4]; 
    s6 := dataStack[5]; 
    s7 := dataStack[6]; 
    s8 := dataStack[7]; 
    s9 := dataStack[8]; 
    s10 := dataStack[9]; 
    c2 := FILE_ATTRIBUTE_NORMAL;
    
    {$IFDEF WINDOWS}
    if StrToBool(s3) then c2 := c2 or FILE_ATTRIBUTE_READONLY;
    if StrToBool(s4) then c2 := c2 or FILE_ATTRIBUTE_HIDDEN;
    if StrToBool(s5) then c2 := c2 or FILE_ATTRIBUTE_SYSTEM;
    {$ENDIF}
    
    iY := NativeFileSourceStack.IndexOf(s1);
    for iX := iY +3 to NativeFileSourceStack.Count do 
    begin
      if iX mod 2 <> 0 then Continue; 
      if NativeFileSourceStack[iX -1] = 'NEWHEADER' then Break; 
      
      s11 := AssertDir(AssertDir(s2) + NativeFileSourceStack[iX -1]); 
      s12 := AssertDir(CachedDataDir) + NativeFileSourceStack[iX -2]; 
      if not IncrementProgress(0, s11 + ExtractFileName(s12)) then Exit;
      
      if StrToBool(s10) and MyFileExists(s11 + ExtractFileName(s12)) then Continue; 
      if StrToBool(s8) and MyFileExists(s11 + ExtractFileName(s12)) then bX := True; 
      if ShowOverwriteDialog(s12, s11 + ExtractFileName(s12), b) then Exit; 
      if not b then
      begin
        
        if StrToBool(s6) then Exit; 
        Continue; 
      end;
      
      bY := false;
      bZ := false;
      {$IFDEF WINDOWS}
      if FileInUse(s11 + ExtractFileName(s12), True, bZ, hSecFile) then 
      begin
        bY := True; 
        s15 := GetDummyMoveFileTemporaryName; 
        MoveFileOnReboot(s15, s11 + ExtractFileName(s12));
        {$IFNDEF WINDOWS}
        fpUnLink(s15);
        {$ENDIF}
        DeleteFile(PChar(s15)); 
        RemoveDirectory(PChar(s15));
        
        thNativeRebootOp := True; 
        
      end
      else
      {$ENDIF}
        s15 := s11 + ExtractFileName(s12); 
      
      if not DirectoryExists(s11) then
      begin
        dataStack.Clear;
        dataStack.Add(s11);
        CompactDataStack := dataStack.CommaText;
        TypesI := 'Create Folder';
        if not ProcessSingleType(True) then Exit;
      end;
      
      bW := false;
      if not StrToBool(s9) then 
        {$IFNDEF WINDOWS}
        if not (StrToBool(s8) and bX) then 
        {$ELSE}
        if not StrToBool(s8) then 
        {$ENDIF}
        begin
          NativeLogAddEntry('Create File', s11 + ExtractFileName(s12)); 
          bW := True;
        end;
      
      repeat
        
        bV := True;
        BackupProgress;
        cbTotal := 0;
        cbCurrent := 0;
        if not IncrementProgress(0, s15) then Exit; 
        
        opOK := FileCopyFile(PChar(s12), PChar(s15), false);
        if not IncrementProgress(FileSize(s15), '$IGNORE$') then Exit;
        {$IFNDEF WINDOWS}
        eBuf := fpgeterrno;
        
        if opOK then
          LazShimSetExecutable(s15, s12);
        {$IFDEF DARWIN}
        if opOK then
          if AnsiCompareText(RuntimeSubstituteCompilerVariables('#MYAH_SIGNED#'), 'TRUE') = 0 then
            if FpAccess(s15, X_OK) = 0 then
              EncryptFileEx(s15, '$');
          
        {$ENDIF}
        {$ELSE}
        eBuf := GetLastError;
        {$ENDIF}
        
        if not opOK then
        begin
          RestoreProgress;
          bV := false;
        end;
        if not opOK then
        begin
          if MyFileExists(s15) then 
            opOK := True
          else
            opCancel := ShowErrorDialog(SysErrorMessage(eBuf) + MyLineEnding + MyLineEnding + s15, opRetry, eBuf);
        end;
      until (opOK or opCancel) or (not opRetry);
      if not opOK then
      begin
        if bW then
          NativeLogDeleteLastEntry;
      end;
      if opCancel then Exit;
      if not opOK and StrToBool(s6) then Exit; 
      if opOK then
      begin
        {$IFDEF WINDOWS}
        
        if StrToBool(s7) then
        begin
          
          if not IncrementProgress(0, 'regsvr32 ' + s11 + ExtractFileName(s12)) then Exit; 
          Leave64BitFileSystem(True); 
          if bY then
          begin
            
            if AnsiCompareText(ExtractFileExt(s11 + ExtractFileName(s12)), '.EXE') = 0 then 
            begin
              Enter64BitFileSystem(True);
              Enter64BitRegistry;
              RecordNativeSelfReg('', s11 + ExtractFileName(s12)); 
              Leave64BitRegistry;
              Leave64BitFileSystem(True);
            end
            else
            begin
              s14 := x64Mode;
              if IsBinaryX64(s15) then 
                x64Mode := 'x64'
              else
                x64Mode := 'Win32';
              Enter64BitFileSystem(True);
              GetMem(p, (MAX_PATH+1)*8);
              GetSystemDirectory(p, MAX_PATH);
              s13 := AssertDir(p) + 'regsvr32.exe';
              FreeMem(p);
              RecordNativeSelfReg(s13, s11 + ExtractFileName(s12)); 
              Leave64BitFileSystem(True);
              x64Mode := s14;
            end;
          end
          else
          begin
            
            if AnsiCompareText(ExtractFileExt(s11 + ExtractFileName(s12)), '.EXE') = 0 then
            begin
              Enter64BitFileSystem(True);
              MyRegisterEXE(s11 + ExtractFileName(s12), True); 
              Leave64BitFileSystem(True);
            end
            else
            begin
              s14 := x64Mode;
              if IsBinaryX64(s11 + ExtractFileName(s12)) then
                x64Mode := 'x64'
              else
                x64Mode := 'Win32';
              Enter64BitFileSystem(True);
              GetMem(p, (MAX_PATH+1)*8);
              GetSystemDirectory(p, MAX_PATH);
              s13 := AssertDir(p) + 'regsvr32.exe';
              FreeMem(p);
              LaunchAppAndWait(s13, '"' + s11 + ExtractFileName(s12) + '" /s', false, True); 
              Leave64BitFileSystem(True);
              x64Mode := s14;
            end;
          end;
          Enter64BitFileSystem(True); 
          bW := false;
          if not StrToBool(s9) then 
            if not StrToBool(s8) then 
            begin
              NativeLogAddEntry('Register File', s11 + ExtractFileName(s12));
              bW := True;
            end;
          WriteToLog('          < regsvr32 ' + s11 + ExtractFileName(s12) + ' >');
        end;
        
        if StrToBool(s8) then
        try
          Enter64BitRegistry;
          
          if RegValueExistsEz(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDlls', s11 + ExtractFileName(s12)) then 
          begin
            
            RegGetDWORDEz(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDlls', s11 + ExtractFileName(s12), dw, i4);
            dw := dw +1;
          end
          else
            if bX then 
            begin
              dw := 2;
            end
            else
              dw := 1; 
          repeat
            opOK := RegSetDWORDEz(HKEY_LOCAL_MACHINE, 'SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDlls', s11 + ExtractFileName(s12), dw, i4);
            if not opOK then
              opCancel := ShowErrorDialog(SysErrorMessage(i4) + MyLineEnding + MyLineEnding + 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDlls\' + s11 + ExtractFileName(s12), opRetry, i4);
          until (opOK or opCancel) or (not opRetry);
          if opCancel then Exit; 
          if not StrToBool(s9) then 
          begin
            if not StrToBool(s7) then
            begin
              NativeLogAddEntry('Share File', s11 + ExtractFileName(s12));
              bW := True;
            end
            else 
            begin
              NativeLogAddEntry('Share Self Registering File', s11 + ExtractFileName(s12));
              bW := True;
            end;
          end;
          WriteToLog('          < share ' + s11 + ExtractFileName(s12) + ' >');
          if not IncrementProgress(0, 'HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows\CurrentVersion\SharedDlls\' + s11 + ExtractFileName(s12)) then
            Exit;
        finally
          Leave64BitRegistry;
        end;
        
        if c2 <> FILE_ATTRIBUTE_NORMAL then
        begin
          repeat
            opOK := SetFileAttributes(PChar(s15), c2);
            i4 := GetLastError;
            if not opOK then
              opCancel := ShowErrorDialog(SysErrorMessage(i4) + MyLineEnding + MyLineEnding + s15, opRetry, i4);
          until (opOK or opCancel) or (not opRetry);
          if opCancel then Exit; 
          WriteToLog('          < attributes ' + s11 + ExtractFileName(s12) + ' >');
        end;
        {$ENDIF}
      end;
      WriteToLog('        < ' + s11 + ExtractFileName(s12) + ' >');
    end;
  finally
    Leave64BitFileSystem(True);
  end
  
  else
  if TypesI = 'Create File Type' then
  try
    Enter64BitRegistry;
    Enter64BitFileSystem(True);
    s1 := dataStack[0]; 
    s2 := dataStack[1]; 
    s3 := dataStack[2]; 
    s4 := dataStack[3]; 
    s5 := dataStack[4]; 
    s8 := dataStack[5]; 
    s9 := dataStack[6]; 
    s10 := dataStack[7]; 
    s11 := dataStack[8]; 
    s12 := dataStack[9]; 
    
    s6 := dataStack[5 +5]; 
    s7 := dataStack[6 +5]; 
    {$IFDEF DARWIN}
    
    sv14 := SniffSafeUserPath(StrToBool(GetVariable('ALLUSERS'))); 
    sv14 := sv14 + RevisionGUID + PathDelim;
    sv15 := AssertDir(ExtractFilePath(MSIFile))  + ExtractFileNameOnly(MSIFile); 
    ConvenientCreateFolder(sv14);
    {$IFDEF BACKIDE}
    sv14 := sv14 + StringReplace(Trim(s1), ' ', '', [rfReplaceAll, rfIgnoreCase]) 
      + '.app/Contents/'; 
    sv15 := sv15 + '.app/Contents/'; 
    ConvenientCreateFolder(sv14 + 'Resources');
    if s4 <> '' then
      LoggedFileCopyFile(s4, sv14 + 'Resources/' + ExtractFileName(s4), false);
    
    LoggedFileCopyFile(sv15 + 'PkgInfo', sv14 + 'PkgInfo', false); 
    sv14 := sv14 + 'MacOS/';
    ConvenientCreateFolder(sv14);
    sv15 := sv15 + 'MacOS/';
    LoggedFileCopyFile(sv15 + 'miaxstub', sv14 + 'miafstub', false); 
    LazShimSetExecutable(sv14 + 'miafstub', sv15 + 'miaxstub');
    {$ENDIF}
    
    {$IFDEF INTEROP}
    sv16 := sv14;
    sv17 := sv15; 
    sv16 := sv16 +  StringReplace(Trim(s1), ' ', '', [rfReplaceAll, rfIgnoreCase]) + '.app/Contents/';
    sv17 := ExtractFilePath(ExcludeTrailingPathDelimiter(ExtractFilePath(sv17))); 
    ConvenientCreateFolder(sv16 + 'MacOS/');
    
    if AnsiCompareText(RuntimeSubstituteCompilerVariables('#MYAH_SIGNED#'), 'TRUE') = 0 then 
      LoggedFileCopyFile(PChar(AssertDir(CachedSupportDir) + 'miaxstub'),
        PChar(sv16 + 'MacOS/miafstub'), false)
    else
      LoggedFileCopyFile(PChar(StringReplace(MyParamStr(0), '/' + Ventura +  '/miaxstub', '/MacOS/miaxstub', [rfReplaceAll, rfIgnoreCase])),
        PChar(sv16 + 'MacOS/miafstub'), false); 
    LazShimSetExecutable(PChar(sv16 + 'MacOS/miafstub'),
      AssertDir(CachedSupportDir) + 'miaxstub');
    ConvenientCreateFolder(sv16 + 'Resources');
    if s4 <> '' then
      LoggedFileCopyFile(s4, sv16 + 'Resources/' + ExtractFileName(s4), false);
    
    LoggedFileCopyFile(sv17 + 'PkgInfo', sv16 + 'PkgInfo', false); 
    ConvenientCreateFolder(sv14);
    {$ENDIF}
    {$IFDEF INTEROP}
    
    NativeLogAddEntry('Create File', sv16 + 'Info.plist'); 
    AssignFile(t, sv16 + 'Info.plist');
    {$ELSE}
    NativeLogAddEntry('Create File', AssertDir(ExtractFilePath(DeAssertDir(sv14))) + 'Info.plist'); 
    AssignFile(t, AssertDir(ExtractFilePath(DeAssertDir(sv14))) + 'Info.plist');
    {$ENDIF}
    ReWrite(t);
    WriteLn(t, '<?xml version="1.0" encoding="UTF-8"?>');
    WriteLn(t, '<!DOCTYPE plist PUBLIC "-//Apple Computer//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">');
    WriteLn(t, '<plist version="1.0">');
    WriteLn(t, '<dict>');
    WriteLn(t, '  <key>CFBundleDevelopmentRegion</key>');
    WriteLn(t, '  <string>English</string>');
    WriteLn(t, '  <key>CFBundleExecutable</key>');
    WriteLn(t, '  <string>miafstub</string>');
    WriteLn(t, '  <key>CFBundleName</key>'); 
    WriteLn(t, '  <string></string>'); 
    WriteLn(t, '  <key>CFBundleDisplayName</key>');
    if s3 = '' then
      WriteLn(t, '      <string>' + StringReplace(Trim(s1), ' ', '', [rfReplaceAll, rfIgnoreCase]) + ' File Bundle</string>')
    else
      WriteLn(t, '  <string>' + s3 + ' Bundle</string>');
    if s4 <> '' then 
    begin
      WriteLn(t, '  <key>CFBundleIconFile</key>');
      WriteLn(t, '  <string>' + ExtractFileName(s4) + '</string>');
    end;
    WriteLn(t, '  <key>CFBundleIdentifier</key>'); 
    WriteLn(t, '  <string>com.company.' + StringReplace(Trim(s1), ' ', '', [rfReplaceAll, rfIgnoreCase]) + '</string>');
    WriteLn(t, '  <key>CFBundleInfoDictionaryVersion</key>');
    WriteLn(t, '  <string>6.0</string>');
    WriteLn(t, '  <key>CFBundlePackageType</key>');
    WriteLn(t, '  <string>APPL</string>');
    WriteLn(t, '  <key>CFBundleSignature</key>'); 
    WriteLn(t, '  <string>MIAX</string>'); 
    WriteLn(t, '  <key>CFBundleShortVersionString</key>');
    WriteLn(t, '  <string>' + ProjectStructVersion + '</string>');
    WriteLn(t, '  <key>CFBundleVersion</key>');
    WriteLn(t, '  <string>' + ProjectStructVersion + '</string>');
    WriteLn(t, '  <key>CSResourcesFileMapped</key>');
    WriteLn(t, '  <true/>');
    WriteLn(t, '  <key>CFBundleDocumentTypes</key>');
    WriteLn(t, '  <array>');
    WriteLn(t, '    <dict>');
    WriteLn(t, '      <key>CFBundleTypeName</key>');
    if s3 = '' then
      WriteLn(t, '      <string>' + StringReplace(Trim(s1), ' ', '', [rfReplaceAll, rfIgnoreCase]) + ' File</string>')
    else
      WriteLn(t, '      <string>' + s3 + '</string>');
    WriteLn(t, '      <key>LSHandlerRank</key>');
    WriteLn(t, '      <string>Owner</string>');
    WriteLn(t, '      <key>CFBundleTypeRole</key>');
    WriteLn(t, '      <string>Editor</string>');
    WriteLn(t, '      <key>LSTypeIsPackage</key>');
    WriteLn(t, '      <false/>');
    if s4 <> '' then
    begin
      WriteLn(t, '      <key>CFBundleTypeIconFile</key>');
      WriteLn(t, '      <string>' + ExtractFileName(s4) + '</string>');
    end;
    WriteLn(t, '      <key>CFBundleTypeExtensions</key>');
    WriteLn(t, '      <array>');
    ftExts := TStringList.Create;
    ftExts.CommaText := s6;
    for ftLoop1 := 1 to ftExts.Count do 
      WriteLn(t, '        <string>' + Copy(ftExts[ftLoop1 -1], 2, Length(ftExts[ftLoop1 -1])) + '</string>');
    ftExts.Free;
    WriteLn(t, '      </array>');
    WriteLn(t, '      <key>CFBundleTypeOSTypes</key>');
    WriteLn(t, '      <array>');
    WriteLn(t, '        <string>fold</string>');
    WriteLn(t, '        <string>disk</string>');
    WriteLn(t, '        <string>****</string>');
    WriteLn(t, '      </array>');
    WriteLn(t, '    </dict>');
    WriteLn(t, '  </array>');
    WriteLn(t, '  <key>NSHighResolutionCapable</key>');
    WriteLn(t, '  <true/>');
    WriteLn(t, ' </dict>');
    WriteLn(t, '</plist>');
    CloseFile(t);
    {$IFDEF INTEROP}
    
    NativeLogAddEntry('Create File', sv16 + 'MacOS/' + 'target.object'); 
    AssignFile(t, sv16 + 'MacOS/' + 'target.object'); 
    {$ELSE}
    NativeLogAddEntry('Create File', sv14 + 'target.object'); 
    AssignFile(t, sv14 + 'target.object'); 
    {$ENDIF}
    ReWrite(t);
    WriteLn(t, ExpandFileName(s2));
    CloseFile(t);
    
    {$ENDIF}
    {$IFDEF LINUX}
    s1 := StringReplace(s1, ' ', '', [rfReplaceAll, rfIgnoreCase]); 
    if s3 = '' then
      s3 := s1;
    
    if StrToBool(s10) then 
    begin
      if StrToBool(GetVariable('ALLUSERS')) then
      begin
        s14 := '/usr/share/applications/'; 
        s15 := '/etc/xdg/mimeapps.list';
        s16 := '/usr/share/mime/packages/';
        s17 := '/usr/share/icons/hicolor/';
        
      end
      else
      begin
        s14 := ExpandFileName('~/.local/share/applications/'); 
        s15 := ExpandFileName('~/.config/mimeapps.list');
        s16 := ExpandFileName('~/.local/share/mime/packages/');
        s17 := ExpandFileName('~/.local/share/icons/hicolor/');
        
      end;
    end
    else
    if StrToBool(s11) then 
    begin
      
      s14 := '/usr/share/applications/'; 
      s15 := '/etc/xdg/mimeapps.list';
      s16 := '/usr/share/mime/packages/';
      s17 := '/usr/share/icons/hicolor/';
    end
    else
    if StrToBool(s12) then 
    begin
      
      s14 := ExpandFileName('~/.local/share/applications/'); 
      s15 := ExpandFileName('~/.config/mimeapps.list');
      s16 := ExpandFileName('~/.local/share/mime/packages/');
      s17 := ExpandFileName('~/.local/share/icons/hicolor/');
    end;
    if not DirectoryExists(s14) then
    begin
      dataStack.Clear;
      dataStack.Add(s14);
      CompactDataStack := dataStack.CommaText;
      TypesI := 'Create Folder';
      if not ProcessSingleType(True) then Exit;
    end;
    if not DirectoryExists(s16) then
    begin
      dataStack.Clear;
      dataStack.Add(s16);
      CompactDataStack := dataStack.CommaText;
      TypesI := 'Create Folder';
      if not ProcessSingleType(True) then Exit;
    end;
    
    {$ENDIF}
    {$IFDEF WINDOWS}
    hk1 := HKEY_CLASSES_ROOT;
    s14 := ''; 
    if StrToBool(s11) then
    begin
      hk1 := HKEY_LOCAL_MACHINE;
      s14 := 'SOFTWARE\Classes\'; 
    end
    else
      if StrToBool(s12) then
      begin
        hk1 := HKEY_CURRENT_USER;
        s14 := 'SOFTWARE\Classes\'; 
      end;
    if hk1 = HKEY_CLASSES_ROOT then
    begin
      
      if StrToBool(GetVariable('ALLUSERS')) then
        hk1 := HKEY_LOCAL_MACHINE
      else
        hk1 := HKEY_CURRENT_USER;
      s14 := 'SOFTWARE\Classes\'; 
    end;
    {$ENDIF}
    if not IncrementProgress(weightFT, s14 + s1 + ': ' + s3 + '/' + s2) then Exit; 
    {$IFDEF WINDOWS}
    
    if not ConvenientWriteRegistry(hk1, s14 + s1, '', s3, True) then Exit;
    
    if s4 <> '' then
      if s5 <> '' then
      begin
        if not ConvenientWriteRegistry(hk1, s14 + s1 + '\DefaultIcon', '', s4 + ',' + s5, True) then Exit;
      end
      else
        if not ConvenientWriteRegistry(hk1, s14 + s1 + '\DefaultIcon', '', s4, True) then Exit;
    {$ENDIF}
    
    ftExts := TStringList.Create;
    ftExts.CommaText := s6;
    for ftLoop1 := 1 to ftExts.Count do
    begin
      {$IFDEF WINDOWS}
      if not ConvenientWriteRegistry(hk1, s14 + ftExts[ftLoop1 -1], '', s1, True) then Exit;
      if StrToBool(s8) then 
        if not ConvenientWriteRegistry(hk1, s14 + ftExts[ftLoop1 -1] + '\OpenWithProgIDs', s1, '', True) then Exit; 
      if StrToBool(s9) then 
        if not ConvenientWriteRegistry(hk1, s14 + ftExts[ftLoop1 -1] + '\UserChoice', 'ProgID', s1, True) then Exit;
      {$ENDIF}
      {$IFDEF LINUX}
      
      try
        AssignFile(t, AssertDir(s16) + 'application-x-' + s1 + '.xml'); 
        ReWrite(t);
        WriteLn(t, '<?xml version="1.0" encoding="UTF-8"?>');
        WriteLn(t, '<mime-info xmlns="http://www.freedesktop.org/standards/shared-mime-info">');
        WriteLn(t, '  <mime-type type="application/x-' + s1 +'">');
        WriteLn(t, '    <comment>' + s3 + '</comment>');
        WriteLn(t, '    <glob pattern="*' + ftExts[ftLoop1 -1] + '"/>'); 
        if s4 <> '' then
          WriteLn(t, '    <icon name="x-' + s1 + '"/>');
        WriteLn(t, '  </mime-type>');
        WriteLn(t, '</mime-info>');
        CloseFile(t);
        NativeLogAddEntry('Create File', AssertDir(s16) + 'application-x-' + s1 + '.xml');
        
        AssignFile(t, AssertDir(s14) + 'application-x-' + s1 + '.desktop');
        ReWrite(t);
        WriteLn(t, '[Desktop Entry]');
        WriteLn(t, 'Type=Application');
        WriteLn(t, 'MimeType=application/x-' + s1);
        WriteLn(t, 'Name=' + s3 + ' Handler');
        
        {$IFDEF LCLQT5}
        
        WriteLn(t, 'Exec=/bin/sh "' + AssertDir(s14) + 'application-x-' + s1 + '.sh" %f');
        {$ELSE}
        WriteLn(t, 'Exec="' + s2 + '" %f');
        {$ENDIF}
        WriteLn(t, 'NoDisplay=True'); 
        WriteLn(t, 'Hidden=True'); 
        if s4 <> '' then
          WriteLn(t, 'Icon=' + s4); 
        CloseFile(t);
        {$IFDEF LCLQT5}
        AssignFile(t, AssertDir(s14) + 'application-x-' + s1 + '.sh');
        ReWrite(t);
        WriteLn(t, '#!/bin/sh');
        WriteLn(t, 'cd "' + ExtractFilePath(s2) + '"');
        WriteLn(t, '"' + s2 + '" "$1"'); 
        CloseFile(t);
        fpChMod(AssertDir(s14) + 'application-x-' + s1 + '.sh', 777);
        NativeLogAddEntry('Create File', AssertDir(s14) + 'application-x-' + s1 + '.sh');
        {$ENDIF}
        fpChMod(AssertDir(s14) + 'application-x-' + s1 + '.desktop', 777);
        NativeLogAddEntry('Create File', AssertDir(s14) + 'application-x-' + s1 + '.desktop');
      except
        Exit;
      end;
      if not ConvenientWriteINI(s15, 'Default Applications', 'application/x-' + s1, s1 + '.desktop', 3) then Exit;
      if not ConvenientWriteINI(s15, 'Added Associations', 'application/x-' + s1, s1 + '.desktop', 3) then Exit;
      
      if s4 <> '' then
      begin
        if not GetImageSize(s4, lw, lw) then
          lw := 48; 
        s18 := AssertDir(s17) + IntToStr(lw) + 'x' + IntToStr(lw) + '/mimetypes/'; 
        if not DirectoryExists(s18) then
        begin
          dataStack.Clear;
          dataStack.Add(s18);
          CompactDataStack := dataStack.CommaText;
          TypesI := 'Create Folder';
          if not ProcessSingleType(True) then Exit;
        end;
        FileCopyFile(s4, s18 + 'x-' + s1 + '.png', false);
        NativeLogAddEntry('Create File', s18 + 'x-' + s1 + '.png');
      end;
      {$ENDIF}
    end;
    ftExts.Free;
    
    {$IFDEF WINDOWS}
    ftVerbs := TStringList.Create;
    ftVerbActs := TStringList.Create;
    ftVerbs.CommaText := s7;
    for ftLoop1 := 1 to ftVerbs.Count do
    begin
      ftVerbActs.CommaText := ftVerbs[ftLoop1 -1];
      
      if not ConvenientWriteRegistry(hk1, s14 + s1 + '\Shell\' + ftVerbActs[0] + '\Command', '', '"' + s2 + '" ' + ftVerbActs[1], True) then Exit;
      
      if ftVerbActs[2] <> '' then
      begin
        if not ConvenientWriteRegistry(hk1, s14 + s1 + '\Shell\' + ftVerbActs[0] + '\ddeexec', '', ftVerbActs[2], True) then Exit;
        
        if not ConvenientWriteRegistry(hk1, s14 + s1 + '\Shell\' + ftVerbActs[0] + '\ddeexec\application', '', ftVerbActs[3], True) then Exit;
        
        if not ConvenientWriteRegistry(hk1, s14 + s1 + '\Shell\' + ftVerbActs[0] + '\ddeexec\topic', '', ftVerbActs[4], True) then Exit;
      end;
    end;
    ftVerbs.Free;
    ftVerbActs.Free;
    {$ENDIF}
    NativeShellChangeNotify := True;
    WriteToLog('        < ' + s14 + s1 + ': ' + s3 + '/' + s2 + ' >');
    if opCancel then Exit;
  finally
    Leave64BitFileSystem(True);
    Leave64BitRegistry;
  end
  
  else
  if TypesI = 'Edit INI File' then
  try
    Enter64BitFileSystem(True);
    s1 := dataStack[0]; 
    s2 := dataStack[1]; 
    s3 := dataStack[2]; 
    s4 := dataStack[3]; 
    i4 := StrToInt(dataStack[4]); 
    
    bW := false;
    if (i4 <> 2) and (i4 <> 4) then
    begin
      sl := TStringList.Create;
      sl.Add(s1);
      sl.Add(s2);
      sl.Add(s3);
      if i4 = 3 then
        sl.Add(s4)
      else
        sl.Add(''); 
      NativeLogAddEntry('Edit INI File', sl.CommaText);
      bW := True;
      sl.Free;
    end;
    if (i4 = 4) then
    begin
      s5 := '';
      tif := TINIFile.Create(s1);
      s5 := tif.ReadString(s2, s3, '');
      tif.Free;
      
      i1 := YTM_SmartPos(s4, s5, false);
      
      if i1 = 0 then
      begin
        
        WriteToLog('        </' + TypesI + '>');
        Result := True;
        Exit; 
      end;
      
      i2 := YTM_SmartPos(s4 + ', ', s5, false);
      
      i2_len := Length(s4 + ', ');
      if i2 = 0 then
      begin
        
        i2 := YTM_SmartPos(s4 + ',', s5, false);
        
        i2_len := Length(s4 + ',');
      end;
      
      i3 := YTM_SmartPos(', ' + s4, s5, false);
      
      i3_len := Length(', ' + s4);
      if i3 = 0 then
      begin
        
        i3 := YTM_SmartPos(',' + s4, s5, false);
        
        i3_len := Length(',' + s4);
      end;
      if (i2 = 0) and (i3 = 0) then 
      begin
        if AnsiCompareText(Trim(s5), s4) <> 0 then 
        begin
          WriteToLog('        </' + TypesI + '>');
          Result := True;
          Exit; 
        end
        else
          s4 := ''; 
      end
      else
      begin
        s4 := s5;
        if i2 <> 0 then
          System.Delete(s4, i2, i2_len)
        else
          System.Delete(s4, i3, i3_len);
      end;
    end; 
    if (i4 = 1) or (i4 = 3) then
    begin
      s5 := '';
      tif := TINIFile.Create(s1);
      s5 := tif.ReadString(s2, s3, '');
      tif.Free;
      
      if (s5 <> '') and (i4 = 1) then
      begin
        if bW then
          NativeLogDeleteLastEntry;
        
        WriteToLog('        </' + TypesI + '>');
        Result := True;
        Exit; 
      end;
      if s5 <> '' then
        s4 := s4 + ', ' + s5; 
    end;
    if not IncrementProgress(weightINI, s1 + ': [' + s2 + ']' + ' ' + s3 + '=' + s4) then Exit;
    repeat
      try
        tif := TINIfile.Create(s1);
        tif.WriteString(s2, s3, s4);
        tif.Free;
        opOK := True;
      except
        opOK := false;
      end;
      
      {$IFNDEF WINDOWS}
      eBuf := fpGetErrNo;
      {$ELSE}
      eBuf := GetLastError;
      {$ENDIF}
      if not opOK then
        opCancel := ShowErrorDialog(SysErrorMessage(eBuf) + MyLineEnding + MyLineEnding + s1 + ': [' + s2 + ']' + ' ' + s3 + '=' + s4, opRetry, eBuf);
    until (opOK or opCancel) or (not opRetry);
    if not opOK then
    begin
      if bW then
        NativeLogDeleteLastEntry;
    end
    else
      WriteToLog('        < ' + s1 + ': [' + s2 + ']' + ' ' + s3 + '=' + s4 + ' >');
    if opCancel then Exit;
  finally
    Leave64BitFileSystem(True);
  end
  else
  if TypesI = 'Create Link' then
  try
    {$IFNDEF WINDOWS}
    Enter64BitFileSystem(True);
    s1 := dataStack[0]; 
    s2 := dataStack[1]; 
    s3 := dataStack[2]; 
    s4 := dataStack[3]; 
    s5 := dataStack[4]; 
    if not IncrementProgress(weightCRL, s1) then Exit;
    
    if not DirectoryExists(AssertDir(ExtractFilePath(s1))) then
    begin
      dataStack.Clear;
      dataStack.Add(AssertDir(ExtractFilePath(s1)));
      CompactDataStack := dataStack.CommaText;
      TypesI := 'Create Folder';
      if not ProcessSingleType(True) then Exit;
    end;
    
    if not (StrToBool(s5) and MyFileExists(s1, false)) then 
      NativeLogAddEntry('Create Link', s1); 
    repeat
      
      if MyFileExists(s1, false) or DirectoryExists(s1, false) then
      begin
        fpUnlink(s1);
        DeleteFile(s1);
        RemoveDirectory(s1);
      end;
      
      if StrToBool(s3) then
        opOK := FpSymLink(PChar(s2), PChar(s1)) = 0
      else
        opOK := FpLink(PChar(s2), PChar(s1)) = 0;
      eBuf := FPGetErrNo;
      if not opOK then
      begin
        if not MyFileExists(s1, false) then 
          opOK := True
        else
          opCancel := ShowErrorDialog(SysErrorMessage(eBuf) + MyLineEnding + MyLineEnding + s1, opRetry, eBuf);
      end;
    until (opOK or opCancel) or (not opRetry);
    if not opOK then NativeLogDeleteLastEntry
    else
      WriteToLog('        < ' + s1 + ' >');
    if opCancel then Exit;
    {$ENDIF}
  finally
    Leave64BitFileSystem(True);
  end
  else
  if TypesI = 'Delete Files' then
  try
    Enter64BitFileSystem(True);
    s1 := dataStack[0];
    s2 := dataStack[1];
    s3 := AssertDir(s1) + s2;
    if not IncrementProgress(weightDF, s3) then Exit;
    sl := nil;
    if sl <> nil then
      sl.Free;
    sl := FindAllFilesEx(s3, false);
    i1 := sl.Count;
    for i2 := sl.Count downto 1 do
    begin
      SetFileAttributes(PChar(sl[i2 -1]), FILE_ATTRIBUTE_NORMAL);
      DeleteFile(PChar(sl[i2 -1]));
    end;
    sl.Free;
    sl := nil;
    WriteToLog('        < ' + s3 + ' >');
  finally
    Leave64BitFileSystem(True);
  end
  else
  if TypesI = 'Create Folder' then
  try
    Enter64BitFileSystem(True);
    s1 := dataStack[0];
    if not IncrementProgress(weightCF, s1) then Exit;
    NativeLogAddEntry('Create Folder', s1);
    repeat
      opOK := SysUtils.ForceDirectories(s1);
      {$IFDEF WINDOWS}
      eBuf := GetLastError;
      {$ELSE}
      
      eBuf := fpgeterrno;
      {$ENDIF}
      if not opOK then
      begin
        if DirectoryExists(s1) then 
          opOK := True
        else
          opCancel := ShowErrorDialog(SysErrorMessage(eBuf) + MyLineEnding + MyLineEnding + s1, opRetry, eBuf);
      end;
    until (opOK or opCancel) or (not opRetry);
    if not opOK then NativeLogDeleteLastEntry
    else
      WriteToLog('        < ' + s1 + ' >');
    if opCancel then Exit;
  finally
    Leave64BitFileSystem(True);
  end
  else
  if TypesI = 'Copy/Move Local Files' then
  try
    Enter64BitFileSystem(True);
    s1 := dataStack[0]; 
    s2 := dataStack[1]; 
    s3 := dataStack[2]; 
    
    WidenColonDelimParam(dataStack[3], Wide1, Wide2);
    s4 := Wide1; 
    s13 := Wide2;
    if s13 = '' then
      s13 := 'FALSE'; 
    s5 := dataStack[4]; 
    
    s6 := AssertDir(s1); 
    s7 := AssertDir(s3); 
    s15 := dataStack[5]; 
    if not (((AnsiPos('?', s2) = 0) and (AnsiPos('*', s2) = 0)) and
      ((AnsiPos('?', s15) = 0) and (AnsiPos('*', s15) = 0))) then
      s15 := ''; 
    if not inDelayedInstall then 
      if not IncrementProgress(weightCMLF, s6 + s2 + ' -> ' + s7) then Exit;
    slX := TStringList.Create;
    MyFindAllFiles(slX, s6, s2, StrToBool(s5), faDirectory, ';', ';', StrToBool(s13));
    
    for iX := 1 to slX.Count do
    begin
      
      s8 := AssertDir(ExtractFilePath(slX[iX -1]));
      System.Delete(s8, 1, Length(s6));
      
      s8 := AssertDir(s7 + s8);
      if not DirectoryExists(s8) then
      begin
        
        dataStack.Clear;
        dataStack.Add(s8);
        CompactDataStack := dataStack.CommaText;
        TypesI := 'Create Folder';
        if not ProcessSingleType(True) then Exit;
      end;
      
      bY := false;
      
      if s15 = '' then
        s14 := s8 + ExtractFileName(slX[iX -1])
      else
        s14 := s8 + s15;
      if ShowOverwriteDialog(slX[iX -1], s14, b) then Exit; 
      if not b then
      begin
        
        Continue; 
      end;
      
      bZ := false;
      {$IFDEF WINDOWS}
      if FileInUse(s14, True, bZ, hSecFile) then 
      begin
        bY := True; 
        s9 := GetDummyMoveFileTemporaryName; 
        MoveFileOnReboot(s9, s14);
        {$IFNDEF WINDOWS}
        fpUnLink(s9);
        {$ENDIF}
        DeleteFile(PChar(s9)); 
        RemoveDirectory(PChar(s9));
        
        thNativeRebootOp := True; 
        
      end
      else
      {$ENDIF}
        s9 := s14; 
      
      NativeLogAddEntry('Create File', s14); 
      
      repeat
        
        BackupProgress;
        
        cbTotal := 0;
        cbCurrent := 0;
        if not IncrementProgress(0, s9) then Exit; 
        
        if StrToBool(s4) then
        begin
          
          {$IFNDEF WINDOWS}
          if True then
          
          begin
            if fpReadLink(slX[iX -1]) = '' then
              opOK := FileCopyFile(PChar(slX[iX -1]), PChar(s9), false)
            else 
              opOK := fpSymLink(PChar(fpReadLink(slX[iX -1])), PChar(s9)) = 0;
          end
          else
          {$ENDIF}
            opOK := FileCopyFile(PChar(slX[iX -1]), PChar(s9), false);
          {$IFNDEF WINDOWS}
          eBuf := fpgeterrno;
          if opOK then
            LazShimSetExecutable(s9, slX[iX -1]);
          {$ELSE}
          eBuf := GetLastError;
          {$ENDIF}
        end
        else
        begin
          
          opOK := MoveFile(PChar(slX[iX -1]), PChar(s9));
          {$IFNDEF WINDOWS}
          eBuf := fpgeterrno;
          {$ELSE}
          eBuf := GetLastError;
          {$ENDIF}
        end;
        if not opOK then
        begin
          RestoreProgress;
        end;
        if not opOK then
        begin
          if MyFileExists(s9, false) then 
          begin
            opOK := True;
            
          end
          else
            opCancel := ShowErrorDialog(SysErrorMessage(eBuf) + MyLineEnding + MyLineEnding + slX[iX -1] + #13 + '->' + #13 + s9, opRetry, eBuf);
        end;
      until (opOK or opCancel) or (not opRetry);
      if not opOK then NativeLogDeleteLastEntry
      else
        WriteToLog('        < ' + slX[iX -1] + ' -> ' + s9 + ' >');
      if opCancel then Exit;
    end;
    slX.Free;
    if opCancel then Exit;
    WriteToLog('        < ' + AssertDir(s1) + s2 + ' -> ' + AssertDir(s3) + ' >');
  finally
    
    Leave64BitFileSystem(True);
  end;
  WriteToLog('        </' + TypesI + '>');
  Result := True;
end;

function TNativeThread.ConvenientCreateFolder(Path: String): Boolean;
begin
  dataStack.Clear;
  dataStack.Add(Path);
  CompactDataStack := dataStack.CommaText;
  TypesI := 'Create Folder';
  Result := ProcessSingleType(True);
end;

function TNativeThread.ConvenientWriteRegistry(Root: HKEY; Subkey, Leaf,
  Data: String; SuspendProgress: Boolean; Permanent: Boolean): Boolean;
begin
  dataStack.Clear;
  if not Permanent then
    dataStack.Add('FALSE')
  else
    dataStack.Add('TRUE');
  if Root = HKEY_CLASSES_ROOT then dataStack.Add('0');
  if Root = HKEY_CURRENT_USER then dataStack.Add('1');
  if Root = HKEY_LOCAL_MACHINE then dataStack.Add('2');
  if Root = HKEY_USERS then dataStack.Add('3');
  dataStack.Add(Subkey);
  dataStack.Add(Leaf);
  dataStack.Add(Data);
  dataStack.Add('STRING');
  CompactDataStack := dataStack.CommaText;
  TypesI := 'Write Registry';
  Result := ProcessSingleType(True);
end;

function TNativeThread.ConvenientWriteRegistryInt(Root: HKEY; Subkey,
  Leaf: String; Data: Integer; SuspendProgress: Boolean; Permanent: Boolean
  ): Boolean;
begin
  dataStack.Clear;
  if not Permanent then
    dataStack.Add('FALSE')
  else
    dataStack.Add('TRUE');
  if Root = HKEY_CLASSES_ROOT then dataStack.Add('0');
  if Root = HKEY_CURRENT_USER then dataStack.Add('1');
  if Root = HKEY_LOCAL_MACHINE then dataStack.Add('2');
  if Root = HKEY_USERS then dataStack.Add('3');
  dataStack.Add(Subkey);
  dataStack.Add(Leaf);
  dataStack.Add(IntToStr(Data));
  dataStack.Add('INTEGER');
  CompactDataStack := dataStack.CommaText;
  TypesI := 'Write Registry';
  Result := ProcessSingleType(True);
end;

function TNativeThread.ConvenientWriteINI(Path, Section, Key, Data: String;
  Operation: Integer): Boolean;
begin
  dataStack.Clear;
  dataStack.Add(Path); 
  dataStack.Add(Section); 
  dataStack.Add(Key); 
  dataStack.Add(Data); 
  DataStack.Add(IntToStr(Operation)); 
  
  CompactDataStack := dataStack.CommaText;
  TypesI := 'Edit INI File';
  Result := ProcessSingleType(True);
end;

{$IFDEF WINDOWS}
procedure EnableAllPrivileges;
type TTokenPrivileges = record
       PrivilegeCount : dword;
       Privileges     : array [0..0] of TLUIDAndAttributes;
     end;
var token : THandle;
    len   : dword;
    i1    : integer;
    tp    : ^TTokenPrivileges;
begin
  if OpenProcessToken(GetCurrentProcess, TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY, token) then
    try
      len := 0;
      GetTokenInformation(token, TokenPrivileges, nil, 0, len);
      if len <> 0 then
      begin
        tp := AllocMem(len * 8 * 8);
        if GetTokenInformation(token, TokenPrivileges, tp, len * 8, len) then
        begin
          {$R-}
          for i1 := 0 to integer(tp^.PrivilegeCount) - 1 do
            tp^.Privileges[i1].Attributes := tp^.Privileges[i1].Attributes or SE_PRIVILEGE_ENABLED;
          AdjustTokenPrivileges(token, false, PTokenPrivileges(tp)^, len, PTokenPrivileges(nil)^, dword(pointer(nil)^));
          {$R+}
        end;
        FreeMem(tp);
      end;
    finally CloseHandle(token) end;
end;

procedure Test64bitOS;
type
  tgnsi = procedure(var si: TSystemInfo) stdcall;
const
  PROCESSOR_ARCHITECTURE_AMD64 = 9;
var
  gnsi: tgnsi;
  si: TSystemInfo;
begin
  gnsi := tgnsi(GetProcAddress(GetModuleHandle(kernel32), 'GetNativeSystemInfo'));
  if Assigned(@gnsi) then
  begin
    ZeroMemory(@si, sizeOf(si));
    gnsi(si);
    Am64bitOS := si.wProcessorArchitecture = PROCESSOR_ARCHITECTURE_AMD64;
  end;
end;
{$ENDIF}

initialization
  aVars := SyncObjs.TCriticalSection.Create;
  Variables := TStringList.Create;
  VarCache := THashedStringList.Create;
  PersistVariables := THashedStringList.Create;
  PullMapDirect := THashedStringList.Create;
  IncludeDepthDirect := THashedStringList.Create;
  CompilerVariableDirect := THashedStringList.Create;
  Labels := TStringList.Create;
  Lines := TStringList.Create;
  Components := TStringList.Create;
  Selections := TStringList.Create;
  ComponentHints := TStringList.Create;
  ComponentSpaces := TStringList.Create;
  ComponentDeletes := TStringList.Create;
  ComponentBars := TStringList.Create;
  ComponentHides := TStringList.Create;
  LastLoopStack := TStringList.Create;
  ForEachStack := TStringList.Create;
  idStack := TStringList.Create;
  CommandHeaders := THashedStringList.Create;
  OverrideVars := THashedStringList.Create;
  OverrideVarsEx := THashedStringList.Create;
  lMap := THashedStringList.Create;
  lLang := THashedStringList.Create;
  lOrg := THashedStringList.Create;
  lIndex := THashedStringList.Create;
  WeblockPasswords := THashedStringList.Create;
  NewSourceListSource := TStringList.Create;
  NativeFileSourceStack := TStringList.Create;
  NativeFileSourceStackHashed := THashedStringList.Create;
  NativeLogElements := TStringList.Create;
  NativeLogData := TStringList.Create;
  NativeLogWeight := TStringList.Create;
  NativeLogBitness := TStringList.Create;

  {$IFDEF WINDOWS}
  EnableAllPrivileges;
  Test64bitOS;
  {$ENDIF}
  BannedMediaList := TStringList.Create;

  NativeDelayStack := TStringList.Create;
  dataStack := TStringList.Create;
  courtesyDataStack := TStringList.Create;
  {$IFNDEF INTEROP}
  {$IFDEF DARWIN}
  DoGenericCodeSignList := TStringList.Create;
  {$ENDIF}
  {$ENDIF}
  {$IFDEF DARWIN}
  TouchList := TStringList.Create;
  {$ENDIF}

finalization
  if Assigned(NativeLogElements) then
    FreeAndNil(NativeLogElements);
  if Assigned(NativeLogData) then
    FreeAndNil(NativeLogData);
  if Assigned(NativeLogWeight) then
    FreeAndNil(NativeLogWeight);
  if Assigned(NativeLogBitness) then
    FreeAndNil(NativeLogBitness);
  if Assigned(NativeDelayStack) then
    FreeAndNil(NativeDelayStack);
  if Assigned(dataStack) then
    FreeAndNil(dataStack);
  if Assigned(courtesyDataStack) then
    FreeAndNil(courtesyDataStack);

  if Assigned(lMap) then
    FreeAndNil(lMap);
  if Assigned(lLang) then
    FreeAndNil(lLang);
  if Assigned(lOrg) then
    FreeAndNil(lOrg);
  if Assigned(lIndex) then
    FreeAndNil(lIndex);
  if Assigned(PersistVariables) then
    FreeAndNil(PersistVariables);
  if Assigned(PullMapDirect) then
    FreeAndNil(PullMapDirect);
  if Assigned(IncludeDepthDirect) then
    FreeAndNil(IncludeDepthDirect);
  if Assigned(CompilerVariableDirect) then
    FreeAndNil(CompilerVariableDirect);
  if Assigned(Labels) then
    FreeAndNil(Labels);
  if Assigned(Lines) then
    FreeAndNil(Lines);
  if Assigned(Variables) then
    FreeAndNil(Variables);
  if Assigned(VarCache) then
    FreeAndNil(VarCache);
  if Assigned(Components) then
    FreeAndNil(Components);
  if Assigned(Selections) then
    FreeAndNil(Selections);
  if Assigned(ComponentHints) then
    FreeAndNil(ComponentHints);
  if Assigned(ComponentSpaces) then
    FreeAndNil(ComponentSpaces);
  if Assigned(ComponentDeletes) then
    FreeAndNil(ComponentDeletes);
  if Assigned(ComponentBars) then
    FreeAndNil(ComponentBars);
  if Assigned(ComponentHides) then
    FreeAndNil(ComponentHides);
  if Assigned(LastLoopStack) then
    FreeAndNil(LastLoopStack);
  if Assigned(ForEachStack) then
    FreeAndNil(ForEachStack);
  if Assigned(CommandHeaders) then
    FreeAndNil(CommandHeaders);
  if Assigned(BannedMediaList) then
    FreeAndNil(BannedMediaList);
  if Assigned(idStack) then
    FreeAndNil(idStack);
  if Assigned(OverrideVars) then
    FreeAndNil(OverrideVars);
  if Assigned(OverrideVarsEx) then
    FreeAndNil(OverrideVarsEx);
  if Assigned(WeblockPasswords) then
    FreeAndNil(WeblockPasswords);
  if Assigned(NewSourceListSource) then
    FreeAndNil(NewSourceListSource);
  if Assigned(NativeFileSourceStack) then
    FreeAndNil(NativeFileSourceStack);
  if Assigned(NativeFileSourceStackHashed) then
    FreeAndNil(NativeFileSourceStackHashed);
  {$IFNDEF INTEROP}
  {$IFDEF DARWIN}
  if Assigned(DoGenericCodeSignList) then
    DoGenericCodeSignList.Free;
  {$ENDIF}
  {$ENDIF}
  {$IFDEF DARWIN}
  TouchList.Free;
  {$ENDIF}
  aVars.Free;

end.
