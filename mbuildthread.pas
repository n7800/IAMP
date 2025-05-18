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
unit mbuildthread;

{$MODE Delphi}

interface

uses
  SysUtils, Classes, mUtils, LCLIntf, LCLType, LMessages,
  FileUtil, uSevenZIPAPI{$IFNDEF WINDOWS}, BaseUnix, Unix{$ELSE}, Windows{$ENDIF};

type
  StringBlock = record
    lpString: array[0..15] of PWideChar;
  end;

  TBuildThread = class(TThread)
  private
    scsB: Boolean;
    scsID: Integer;
    scsURL: String;
  protected
    function GetWeblockPwd(Weblock: String): String;
    procedure Execute; override;
    procedure BuildStub;
    procedure InjectMPStub(Engine, Translations, Package, Splash, Output: String);
    procedure miaReplaceLang(LanguageName, UlteriorDependent: String; LanguageCode: Integer);
    procedure miaReplaceLangEx(UlteriorDependent: String);
    function PrepTempLangFile(DefLang: String): String;
    procedure PreparePippin(l: TStrings);
    function SearchString(pFileName: String; nLength: LongWord; pString: AnsiString; nStartSmartPosition: LongWord): Integer;
    function ReplaceString(pFileName: String; nSmartPosition, nOldStrLen: LongWord; pOldString: AnsiString; nNewStrLen: LongWord; pNewString: AnsiString): Integer;
    function SerialCheckSubEx(ID: Integer): Boolean;
    procedure SerialCheckSubEy;
  public
    procedure DisplayUpdateEy;
    procedure DisplayUpdate;
    procedure TimerExEnable;
    procedure TimerExDisable;
    function GetCodeSignName: String;
    procedure DoGenericCodeSignEx(Target: String);
    procedure DoGenericCodeSign(Target: String; Iteration: Integer = 0);
    {$IFDEF DARWIN}
    procedure DoGenericDMGSign(Target, TeamID, AppleID, AppPass: String);
    {$ENDIF}
    function DisplayUpdateEx(Status: String): Boolean;
    function DisplayUpdateExEy(Status: String): Boolean;
    
    function GetCompilerVariableValueDirect(Variable: String): String;
    function ProcessBuildEvents(Kind: String): String;
  end;

function GetCompilerVariableValueDirectEx(Variable: String): String;

var
  {$IFDEF DARWIN}
  DoGenericCodeSignList: TStringList;
  {$ENDIF}
  
  SubDat: AnsiString = #0 + 'ALLA-ALLANODISH-AS-DISH-DISH-AS-SENYORIT-ALLA-ALLANODISH-AS-DISH-DISH-AS-SENYORIT-ALLA-ALLANODISH-AS-DISH-DISH-AS-SENYORIT';
  
  Cancelled, BuildFinished, Success: Boolean;
  UpdateString: String;
  
  CompressionProfile: String;
  BuildForm: Integer;
  BuildFormEx: Boolean;
  SetupEXE, SetupMSI, SetupMSP, SetupMSIEx: String;

implementation

uses
  mscriptexec, mbuild, mautomate;

const
  SUpgradedPackage = 'Upgraded Package\';
  SUpgradedPackageData = 'Upgraded Package\data\';
  STmp = '.tmp';
  SLog = '.log';
  SUpgradedPackage_1 = 'Upgraded Package';
  SRepack_1 = '.repack\';
  SBasePackage = 'Base Package ';

resourcestring
  SClearedOutputFolder = 'Cleared output folder ';
  SAbortedByUser = 'Aborted by user';
  SUntitledMsi = 'untitled.msi';
  SCreatedWindowsInstallerDatabase = 'Created collection';
  SUnableToMergeWindowsInstallerDat = 'Unable to merge Windows Installer database with module ';
  SMergedWindowsInstallerDatabaseWi = 'Merged Windows Installer database with module ';
  SUntitledExe = 'untitled';
  SUnableToNotarize = 'Notarizing failed!';
  SUnableToStaple = 'Stapling failed!';
  SNotarizing = 'Notarizing (this may take an extended amount of time): ';
  SStapling = 'Stapling: ';
  SCodeSigning = 'Code signing: ';
  SCodeSigningEx = 'Double code signing: ';
  SCodeSigningEy = 'Code signing with custom hooks: ';
  SBuiltInstallationExecutable = 'Built installation executable';
  SSigningInstallationExecutable = 'Signing installation executable';
  SUnableToCodeSign = 'Code signing failed!';
  SUnableToSignInstallationExecutab = 'Unable to sign installation executable';
  SInjectedSetupLanguages = 'Injected setup languages';
  SStoringSupportFiles = 'Storing support files: ';
  SUnableToFindSupportFile = 'Unable to find support file ';
  SUseTheProjectManagerWindowToUpda = ', use the Project Manager window to update or remove the reference';
  SOperationCancelled = 'Operation cancelled';
  SOutOfMemoryDuringCompressionPlea = 'Out of memory during compression - please reduce your project''s compression level using the Project Options dialog and then try again';
  SPleaseCheckYourProjectNamesAndFo = 'Please check your project names and folders are made of alpha-numeric characters only';
  SUnableToBuildRuntimeFiles = 'Unable to build runtime files: ';
  SInjectedRuntimeFiles = 'Injected runtime files';
  SCompressingInstall = 'Compressing install: ';
  SUnableToBuildSetupFiles = 'Unable to build setup files: ';
  SCompressedSetupFiles = 'Compressed setup files';
  SUnableToBuildWebMediaBlock = 'Unable to build web media block: ';
  SCompressedWebMediaBlock = 'Compressed web media block ';
  SFinishedGeneratingWebMediaBlocks = 'Finished generating web media blocks';
  SPreparedSFXData = 'Prepared SFX data';
  SCreatedSFXFile = 'Created SFX file';
  SCleanedUp = 'Cleaned up';
  SBeginningProcessingForPatch = 'Beginning processing for patch ';
  SProcessedBasePackage = 'Processed base package ';
  SNoCompatibleBasePackagesFoundFor = 'No compatible base packages found for upgrade package';
  SUnableToCreatePatchDatabase = 'Unable to create patch database';
  SLocatingCompressedPatchDataStrea = 'Locating compressed patch data stream';
  SUnableToLocateCompressedPatchDat = 'Unable to locate compressed patch data stream';
  SInitializingCompressedDataStream = 'Initializing compressed data stream for recompression';
  SUnableToInitializeCompressedData = 'Unable to initialize compressed data stream for recompression';
  SReinjectingInitializedPatchDataS = 'Reinjecting initialized patch data stream';
  SUnableToReinjectInitializedPatch = 'Unable to reinject initialized patch data stream';
  SCompressingPatch = 'Compressing patch: ';
  SUnableToBuildPatchFiles = 'Unable to build patch files: ';
  SCompressedPatchFiles = 'Compressed patch files';
  SCleanedUpAfterPatch = 'Cleaned up after patch';
  SSigningInstallation = 'Signing installation';
  SUnableToSignPackage = 'Unable to sign package';
  SErrorDuringBuild = 'Error during build: ';

function GetCompilerVariableValueDirectEx(Variable: String): String; 
var
  i: Integer;
begin
  Result := '';
  for i := 1 to CompilerVariableDirect.Count do
    if i mod 2 = 1 then
    begin
      if AnsiCompareText(CompilerVariableDirect[i -1], Variable) = 0 then
      begin
        Result := CompilerVariableDirect[i];
        Exit;
      end;
    end;
end;

procedure TBuildThread.DoGenericCodeSign(Target: String; Iteration: Integer = 0);
var
  s: String;
  i, j: Integer;
  l: TStringList;
  
  Wide1, Wide2: String;
begin
  if thProjectStruct.aSign then
  begin
    
    s := '';
    WidenColonDelimParam(thProjectStruct.aKey, Wide1, Wide2);
    {$IFDEF WINDOWS}
    
    s := CompilerGetVariable('CODE-SIGN-HOOKS', thProjectStruct.Conditionals);
    if (AnsiCompareText('#CODE-SIGN-HOOKS#', s) <> 0) then
    begin
      s := SubstituteCompilerVariables(SingleLineToMultiLine(s), thProjectStruct.Conditionals);
      l := TStringList.Create;
      l.Text := s;
      for j := 1 to l.Count do
      begin
        s := StringReplace(l[j -1], '%1', Target, [rfReplaceAll, rfIgnoreCase]);
        if s <> '' then
        begin
          UpdateString := SCodeSigningEy + Target;
          DisplayUpdateEx(UpdateString);
          if Cancelled then
            raise Exception.Create(SAbortedByUser);
          i := LaunchAppAndWaitWindows(s, false, True); 
          if Cancelled then
            raise Exception.Create(SAbortedByUser);
          if i <> 0 then
          begin
            Iteration := Iteration +1;
            if Iteration = 3 then
              raise Exception.Create(SUnableToCodeSign);
            DoGenericCodeSign(Target, Iteration);
          end;
        end;
      end;
      l.Free;
      Exit;
    end;
    
    if Wide2 <> '' then 
    begin
      s := 'sign ';
      
      Wide2 := StringReplace(Wide2, '/', '\', [rfReplaceAll, rfIgnoreCase]);
      s := s + '/f "' + Wide2 + '" '; 
      
      WidenColonDelimParam(thProjectStruct.aTimeStamp, Wide1, Wide2);
      if Wide1 <> '' then
        s := s + '/t "' + Wide1 + '" '; 
      
      if thProjectStruct.aInfo <> '' then
        s := s + '/du "' + thProjectStruct.aInfo + '" '; 
      
      s := s + '/d "' + thProjectStruct.Name + '" '; 
      
      if thProjectStruct.CodeSignPassword <> '' then
        s := s + '/p "' + thProjectStruct.CodeSignPassword + '" '; 
      
      s := s + '"' + Target + '"';
      
      UpdateString := SCodeSigning + Target;
      DisplayUpdateEx(UpdateString);
      if Cancelled then
        raise Exception.Create(SAbortedByUser);
      i := LaunchAppAndWait(EXEDIR + 'authenticode\signtool.exe', s, false, True); 
      if (i = 0) then
      begin
        s := 'sign /fd SHA256 /as ';
        
        WidenColonDelimParam(thProjectStruct.aKey, Wide1, Wide2);
        Wide2 := StringReplace(Wide2, '/', '\', [rfReplaceAll, rfIgnoreCase]);
        s := s + '/f "' + Wide2 + '" '; 
        
        WidenColonDelimParam(thProjectStruct.aTimeStamp, Wide1, Wide2);
        if Wide1 <> '' then
          s := s + '/tr "' + Wide1 + '" /td sha256 '; 
        
        if thProjectStruct.aInfo <> '' then
          s := s + '/du "' + thProjectStruct.aInfo + '" '; 
        
        s := s + '/d "' + thProjectStruct.Name + '" '; 
        
        if thProjectStruct.CodeSignPassword <> '' then
          s := s + '/p "' + thProjectStruct.CodeSignPassword + '" '; 
        
        s := s + '"' + Target + '"';
        
        UpdateString := SCodeSigningEx + Target;
        DisplayUpdateEx(UpdateString);
        if Cancelled then
          raise Exception.Create(SAbortedByUser);
        i := LaunchAppAndWait(EXEDIR + 'authenticode\signtool.exe', s, false, True); 
      end;
      if Cancelled then
        raise Exception.Create(SAbortedByUser);
      if i = 1 then
      begin
        Iteration := Iteration +1;
        if Iteration = 3 then
          raise Exception.Create(SUnableToCodeSign);
        DoGenericCodeSign(Target, Iteration);
      end;
    end;
    {$ELSE}
    {$IFDEF DARWIN}
    
    s := '-vvv --force --strict --options=runtime ';
    
      s := s + '--timestamp '; 
    WidenColonDelimParam(thProjectStruct.aCertificate, Wide1, Wide2);
    s := s + '-s "' + Wide1 + '" "' + Target + '"';
    
    UpdateString := SCodeSigning + Target;
    DisplayUpdateEx(UpdateString);
    if Cancelled then
      raise Exception.Create(SAbortedByUser);
    
    if (LaunchAppAndWait('codesign', s, false, True) <> 0) or 
      (LaunchAppAndWait('codesign', '--verify --verbose --strict "' + Target + '"', false, True) <> 0) then
    
    begin
      Iteration := Iteration +1;
      if Iteration = 3 then
        raise Exception.Create(SUnableToCodeSign);
      DoGenericCodeSign(Target, Iteration);
    end;
    
    if Cancelled then
      raise Exception.Create(SAbortedByUser);
    {$ENDIF}
    {$ENDIF}
  end;
end;

{$IFDEF DARWIN}
procedure TBuildThread.DoGenericDMGSign(Target, TeamID, AppleID, AppPass: String);
begin
  UpdateString := SNotarizing + Target;
  DisplayUpdateEx(UpdateString);
  if Cancelled then
    raise Exception.Create(SAbortedByUser);

  if TeamID='' then
    raise Exception.Create(SUnableToNotarize + ' Team ID missing')
  else if AppleID ='' then
    raise Exception.Create(SUnableToNotarize + ' Apple ID missing')
  else if AppPass ='' then
    raise Exception.Create(SUnableToNotarize + ' Application Specific Password missing');

  if LaunchAppAndWait('xcrun','notarytool submit'+
    ' "'+Target+'"'+
    ' --apple-id "'+AppleID+'"'+
    ' --password "'+AppPass+'"'+
    ' --team-id "'+TeamID+'"'+
    ' --wait', false, True) <> 0 then
      raise Exception.Create(SUnableToNotarize);

  if Cancelled then
    raise Exception.Create(SAbortedByUser);

  UpdateString := SStapling + Target;
  DisplayUpdateEx(UpdateString);

  if LaunchAppAndWait('xcrun', 'stapler staple "'+Target+'"', false, True) <> 0 then
    raise Exception.Create(SUnableToStaple);
end;
{$ENDIF}

procedure TBuildThread.DoGenericCodeSignEx(Target: String);
var
  inStream, outStream: TFileStream;
begin
  inStream := TFileStream.Create(EXEDIR + 'buffer.exe',
    fmOpenRead or fmShareDenyWrite);
  outStream := TFileStream.Create(Target + '-rebuffering', fmCreate or fmShareDenyRead);
  outStream.CopyFrom(inStream, inStream.Size);
  inStream.Free;
  inStream := TFileStream.Create(Target, fmOpenRead or fmShareDenyWrite);
  outStream.CopyFrom(inStream, inStream.Size);
  inStream.Free;
  outStream.Free;
  DeleteFile(PChar(Target));
  RenameFile(Target + '-rebuffering', Target);
  DoGenericCodeSign(Target);
end;

procedure TBuildThread.BuildStub;
var
  i, j, k, iX: Integer;
  s, sX,  sZ, s1, s2: String;
  h: THandle;
  p: PChar;
  b: Pointer;
  ls: TList;
  l, lX, lY, lZ, lXX, lXY, lXZ, lYEx, lZEx, LZEy: TStringList;
  t, tX, tY, tZ: TextFile;
  inStream, outStream: TFileStream;
  fd: TSearchRec;
  PlugDLLs: TStringList;
  
  cantCreateFolder,
  iaInitializationError,
  unableRemoveTmpFiles,
  unableCreateFile,
  internalError,
  downloadCorrupt1,
  downloadCorrupt2,
  unknownError,
  cantLoadConf,
  confFailed,
  isPwdProtected,
  ok,
  cancel,
  cantCreateTmpFolder,
  cantOpenDataStream,
  cantFindFile,
  incorrectFile,
  cantCreateOutputFolder,
  confirmCancel,
  title,
  extractingMsg: String;
  uS, uSX: String;
  uI, uIX, uIY: Integer;
  UlteriorString, UlteriorTemp, UlteriorTempLang, UlteriorRoundabout, UlteriorDependent: String;
  Wide1, Wide2: String;
  escondidoX: String;
  BOM: Char;
  sY, sYX: String;
  pPin: Boolean;
  bS: String;
  sI: String;
  CodeSignCorp: String;
  rX, rY, rZ, rZEx: String;
  rI, rIX: Integer;
  nTeamID, nAppleID, nAppPass: String;
  nI: Integer;
  
  masterStub, masterStubX, masterStubEx, UlteriorStringEx, sEx, SetupEXEEx: String;
  inStreamEx, outStreamEx: TFileStream;
  
  {$IFDEF LINUX}
  luxLinux: Boolean;
  {$ENDIF}
begin
  try
    try
      masterStubX := CompilerGetVariable('NOGUI', thProjectStruct.Conditionals);
      if masterStubX = '#NOGUI#' then masterStubX := '';
      
      if masterStubX = '' then
        {$IFDEF LINUX}
        masterStubX := 'AUTO';
        {$ELSE}
        masterStubX := 'FALSE';
        {$ENDIF}
      if AnsiCompareText(masterStubX, 'AUTO') = 0 then
      begin
        {$IFDEF WINDOWS}
        masterStub := 'miacstub.exe';
        masterStubEx := 'miaxstub.exe'; 
        {$ELSE}
        masterStub := 'miacstub';
        masterStubEx := 'miaxstub'; 
        {$ENDIF}
      end
      else
      if AnsiCompareText(masterStubX, 'TRUE') = 0 then
      begin
        {$IFDEF WINDOWS}
        masterStub := 'miacstub.exe';
        {$ELSE}
        masterStub := 'miacstub';
        {$ENDIF}
        masterStubEx := '';
      end
      else 
      begin
        {$IFDEF WINDOWS}
        masterStub := 'miaxstub.exe';
        {$ELSE}
        masterStub := 'miaxstub';
        {$ENDIF}
        masterStubEx := '';
      end;
      
      UlteriorString := CreateGUIDUp;
      UlteriorStringEx := CreateGUIDUp; 
      UlteriorTemp := CreateGUIDUp;
      UlteriorRoundabout := CreateGUIDUp;
      UlteriorDependent := CreateGUIDUp;
      
      CodeSignCorp := '';
      sY := CompilerGetVariable('SKIP_WEBLOCK_SIGN', thProjectStruct.Conditionals);
      if (AnsiCompareText('#SKIP_WEBLOCK_SIGN#', sY) = 0) or (not (AnsiCompareText(sY, 'TRUE') = 0)) then
        CodeSignCorp := GetCodeSignName;
      WeblockPasswords.Clear;
      if CodeSignCorp <> '' then
      begin
        
        WeblockPasswords.Add('myahtfx');
        WeblockPasswords.Add(ObsWeblock(CodeSignCorp));
      end;
      if thProjectStruct.PassEnabled then
      begin
        WeblockPasswords.Add('OFFLINE'); 
        WeblockPasswords.Add(ObsWeblock(thProjectStruct.Password));
      end;
      
      WipeFolder(thBuildToFolder, True);
      UpdateString := SClearedOutputFolder + thBuildToFolder;
      bS := ProcessBuildEvents('PRE-BUILD');
      if bS <> '' then
        raise Exception.Create('Pre-Build command "' + bS + '" failed');
      DisplayUpdateEx(UpdateString);
      if BuildForm = 3 then
        thBuildToFolder := thBuildToFolder + SUpgradedPackage;
      ForceDirectories(thBuildToFolder);
      if Cancelled then
        raise Exception.Create(SAbortedByUser);
      
      lXX := TStringList.Create;
      lXY := TStringList.Create;
      lXZ := TStringList.Create;
      PlugDLLs := TStringList.Create;
      if Cancelled then
        raise Exception.Create(SAbortedByUser);

      if thProjectStruct.OutputFile = '' then
      begin
        if thCurrentProjectName = '' then
          s := SUntitledMsi
        else
          s := ExtractFileNameOnly(thCurrentProjectName) + '.msi'; 
      end
        else s := thProjectStruct.OutputFile + '.msi'; 
      s := thBuildToFolder + s;
      CompileMSI(s, Self, (BuildForm = 2) or BuildFormEx, thGlobalLists, thScriptTypes, thScriptReferences,
        thScriptComments, thProjectStruct.Conditionals, thProjectStruct.BuildLayout,
        thProjectStruct.Language, thProjectStruct.Name,
        thProjectStruct.cFiles, thProjectStruct.cRegistry, thProjectStruct.cFeatures,
        thProjectStruct.cHashes, GetCompilerDirect('INSTALLAWARE_DRM_APPLICATION'), pPin,
        thProjectStruct.aSign, Self);
      SetupMSI := s;
      
      UpdateString := SCreatedWindowsInstallerDatabase;
      DisplayUpdateEx(UpdateString);
      if Cancelled then
        raise Exception.Create(SAbortedByUser);

      {$IFDEF WINDOWS}
      Windows.CopyFile(PChar(EXEDIR + 'windows/' + masterStub), 
      {$ELSE}
      {$IFDEF LINUX}
      FileCopyFile(PChar(EXEDIR + 'linux/' + masterStub), 
      {$ELSE}
      FileCopyFile(PChar(EXEDIR + 'macos/' + masterStub), 
      {$ENDIF}
      {$ENDIF}
        PChar(EXEDIR + UlteriorString), 
          false);
      if masterStubEx <> '' then
      begin
        
        {$IFDEF WINDOWS}
        Windows.CopyFile(PChar(EXEDIR + 'windows/' + masterStubEx), 
        {$ELSE}
        {$IFDEF LINUX}
        FileCopyFile(PChar(EXEDIR + 'linux/' + masterStubEx), 
        {$ELSE}
        FileCopyFile(PChar(EXEDIR + 'macos/' + masterStubEx), 
        {$ENDIF}
        {$ENDIF}
          PChar(EXEDIR + UlteriorStringEx), 
            false);
      end;

      s := EXEDIR + UlteriorString;
      sEx := EXEDIR + UlteriorStringEx;
      
      inStream := TFileStream.Create(s, fmOpenRead or fmShareDenyWrite);
      if masterStubEx <> '' then
        inStreamEx := TFileStream.Create(sEx, fmOpenRead or fmShareDenyWrite)
      else
        inStreamEx := nil;
      if thProjectStruct.OutputFile = '' then
      begin
        if thCurrentProjectName = '' then
          {$IFDEF WINDOWS}
          s := SUntitledExe + '.exe'
          {$ELSE}
          s := SUntitledExe
          {$ENDIF}
        else
          {$IFDEF WINDOWS}
          s := ExtractFileNameOnly(thCurrentProjectName) + '.exe'; 
          {$ELSE}
          s := ExtractFileNameOnly(thCurrentProjectName); 
          {$ENDIF}
      end
        {$IFDEF WINDOWS}
        else s := thProjectStruct.OutputFile + '.exe'; 
        {$ELSE}
        else s := thProjectStruct.OutputFile; 
        {$ENDIF}
      s := thBuildToFolder + s;
      sEx := AssertDir(ExtractFilePath(s)) + ExtractFileNameOnly(s) + 'Ex'{$IFDEF WINDOWS}+ '.exe'{$ENDIF};
      {$IFDEF DARWIN}
      ForceDirectories(s + '.app/Contents/MacOS/');
      ForceDirectories(s + '.app/Contents/Resources/');
      ForceDirectories(s + '.app/Contents/' + Ventura +  '/');
      
      FileCopyFile(EXEDIR + 'MacOS/miaxstub.app/Contents/Info.plist',
        s + '.app/Contents/Info.plist', false);
      VersionIfy(s + '.app/Contents/Info.plist', thProjectStruct.Version);
      if (AnsiCompareText(masterStubX, 'TRUE') = 0) or (AnsiCompareText(masterStubX, 'AUTO') = 0)then
        NoGuify(s + '.app/Contents', BuildForm);
      FileCopyFile(EXEDIR + 'MacOS/miaxstub.app/Contents/PkgInfo',
        s + '.app/Contents/PkgInfo', false);
      {$ENDIF}
      SetupEXE := s;
      SetupEXEEx := sEx;
      outStream := TFileStream.Create(s, fmCreate or fmShareExclusive);
      if MasterStubEx <> '' then
        outStreamEx := TFileStream.Create(sEx, fmCreate or fmShareExclusive)
      else
        outStreamEx := nil; 
      GetMem(b, inStream.Size);
      inStream.Read(b^, inStream.Size);
      
      if AnsiCompareText(GetCompilerVariableValueDirect('NOEXE'), 'TRUE') <> 0 then
      begin
      
        outStream.Write(b^, inStream.Size);
        if outStreamEx <> nil then
        begin
          FreeMem(b);
          GetMem(b, inStreamEx.Size);
          inStreamEx.Read(b^, inStreamEx.Size);
          outStreamEx.Write(b^, inStreamEx.Size);
        end;
      end;
      FreeMem(b);
      inStream.Free;
      if inStreamEx <> nil then
        inStreamEx.Free;
      {$IFDEF DARWIN}
      outStream.Free; 
      outStream := TFileStream.Create(s + '.msi', fmCreate or fmShareExclusive); 
      if outStreamEx <> nil then
      begin
        outStreamEx.Free;
        outStreamEx := TFileStream.Create(sEx + '.msi', fmCreate or fmShareExclusive); 
      end;
      {$ENDIF}
      try
        escondidoX := thProjectStruct.Conditionals;
        SetMakeContext(thGlobalLists, thScriptTypes, thScriptReferences, thScriptComments,
          escondidoX, ls, sX, thProjectStruct.BuildLayout,
          thProjectStruct.Language, thProjectStruct.Name,
          thProjectStruct.aSign);
        StrCopy(thProjectStruct.Conditionals, PChar(escondidoX));
        l := TStringList.Create;
        for i := 1 to thScriptTypes.Count do
            l.Add(thScriptTypes[i -1]);
        l.Add('$');
        for i := 1 to thScriptReferences.Count do
          l.Add(thScriptReferences[i -1]);
        l.Add('$');
        
        for i := 1 to ls.Count do
          while TStringList(ls[i -1]).IndexOf('$') <> -1 do
            TStringList(ls[i -1])[TStringList(ls[i -1]).IndexOf('$')] := '$WILD_DOLLAR$';
        for i := 1 to ls.Count do
          for j := 1 to TStringList(ls[i -1]).Count do
            if AnsiPos('$MYAH_CARET$', TStringList(ls[i -1])[j -1]) = 0 then 
              l.Add(TStringList(ls[i -1])[j -1])
            else
              l.Add('FALSE');   
        
        for i := 1 to ls.Count do
          while TStringList(ls[i -1]).IndexOf('$WILD_DOLLAR$') <> -1 do
            TStringList(ls[i -1])[TStringList(ls[i -1]).IndexOf('$WILD_DOLLAR$')] := '$';
        l.Add('$');
        for i := 1 to thScriptComments.Count do
          l.Add(thScriptComments[i -1]);
        l.Add('$');
      finally
        SetEditContext(ls, thScriptTypes);
      end;
      l.Add(thProjectStruct.Code);
      l.Add(thProjectStruct.Name);
      l.Add('$');
       
      l.Add(thProjectStruct.Manufacturer);
      l.Add(thProjectStruct.arContact);
      l.Add(thProjectStruct.arHelp);
      l.Add(thProjectStruct.arUpdates);
      l.Add(thProjectStruct.arComments);
      l.Add(thProjectStruct.Version);
      for i := 1 to WeblockPasswords.Count do
        l.Add(WeblockPasswords[i -1]);
      l.Add('$');
      for i := 1 to thScriptFetches.Count do
        l.Add(thScriptFetches[i -1]);
      l.Add('$');
      if (thProjectStruct.BuildLayout = 0) or (thProjectStruct.BuildLayout = 1) then
      begin
        if BuildFormEx then
          l.Add('2') 
        else
          l.Add(IntToStr(thProjectStruct.BuildLayout));
      end
      else
        l.Add(IntToStr(thProjectStruct.BuildLayout));
      for i := 1 to ComponentSpaces.Count do
        l.Add(ComponentSpaces[i -1]);
      l.Add('$');
      l.Add(thProjectStruct.Revision);
      for i := 1 to NewSourceListSource.Count do
        l.Add(NewSourceListSource[i -1]);
      l.Add('$');
      l.Add(MyBoolToStr(thProjectStruct.MultiLang, True));
      l.Add(thProjectStruct.Language);
      for i := 1 to CommandHeaders.Count do
        l.Add(CommandHeaders[i -1]);
      l.Add('$');
      for i := 1 to CompilerVariableDirect.Count do
        l.Add(CompilerVariableDirect[i -1]);
      l.Add('$');
      l.Add(IntToStr(0)); 
      for i := 1 to PullMapDirect.Count do
        l.Add(PullMapDirect[i -1]);
      l.Add('$');
      l.Add(IntToStr(NativeTotal));
      for i := 1 to NativeFileSourceStack.Count do
        l.Add(NativeFileSourceStack[i -1]);
      l.Add('$');
      for i := 1 to IncludeDepthDirect.Count do
        l.Add(IncludeDepthDirect[i -1]);
      l.Add('$');
      rX := '20210501';
      l.Add(rX);
      l.SaveToFile(EXEDIR + UlteriorTemp , TEncoding.UTF8); 
      inStream := TFileStream.Create(EXEDIR + UlteriorTemp , 
        fmOpenRead or fmShareDenyWrite);
      GetMem(b, inStream.Size);
      inStream.Read(b^, inStream.Size);
      outStream.Write(b^, inStream.Size);
      if outStreamEx <> nil then
        outStreamEx.Write(b^, inStream.Size);
      FreeMem(b);
      inStream.Free;
      l.Free;
      outStream.Free;
      if outStreamEx <> nil then
        outStreamEx.Free;
      if AnsiCompareText(GetCompilerVariableValueDirect('KEEPSTUBDATA'), 'TRUE') <> 0 then
        DeleteFile(PChar(EXEDIR + UlteriorTemp )); 
      UpdateString := SBuiltInstallationExecutable;
      DisplayUpdateEx(UpdateString);
      if Cancelled then
        raise Exception.Create(SAbortedByUser);
      {$IFNDEF WINDOWS}
      LazShimSetExecutable(SetupEXE, EXEDIR + {$IFDEF DARWIN}'macos/miaxstub'{$ELSE}'linux/miaxstub'{$ENDIF});
      if masterStubEx <> '' then
        LazShimSetExecutable(SetupEXEEx, EXEDIR + {$IFDEF DARWIN}'macos/miaxstub'{$ELSE}'linux/miaxstub'{$ENDIF});
      DisplayUpdateEx('Applied launch permissions upon setup');
      if Cancelled then
        raise Exception.Create(SAbortedByUser);
      {$ENDIF}
      
        {$IFDEF LINUX}
        FileCopyFile(PChar( EXEDIR + 'linux/miax.lib'),
          PChar(AssertDir(ExtractFilePath(SetupEXE)) + 'miax.lib'), false);
        {$IFDEF LCLQT5}
        FileCopyFile(PChar(EXEDIR + 'libQt5Pas.so.1'),
          PChar(AssertDir(ExtractFilePath(SetupEXE)) + 'libQt5Pas.so.1'), false);
        {$ENDIF}
        {$ELSE}
        {$IFDEF DARWIN}
        FileCopyFile(PChar( EXEDIR + 'macos/miax.lib'),
          PChar(AssertDir(ExtractFilePath(SetupEXE)) + 'miax.lib'), false);
        {$ELSE}
        CopyFile(PChar( EXEDIR + 'windows\miax.lib'),
          PChar(AssertDir(ExtractFilePath(SetupEXE)) + 'miax.lib'), false);
        {$ENDIF}
        {$ENDIF}
      {$IFNDEF WINDOWS}
      LazShimSetExecutable(AssertDir(ExtractFilePath(SetupEXE)) + 'miax.lib', EXEDIR + {$IFDEF DARWIN}'macos/miaxstub'{$ELSE}'linux/miax.lib'{$ENDIF});
      DisplayUpdateEx('Applied launch permissions upon library');
      if Cancelled then
        raise Exception.Create(SAbortedByUser);
      {$ENDIF}
      {$IFDEF WINDOWS}
      if MyFileExists(EXEDIR + 'trans\translations.' + thProjectStruct.Language) then 
      begin
        inStream := TFileStream.Create(AssertDir(ExtractFilePath(SetupEXE)) + 'miax.lib',
          fmOpenRead or fmShareDenyWrite);
        outStream := TFileStream.Create(AssertDir(ExtractFilePath(SetupEXE)) + 'miax.lib.inj', fmCreate or fmShareExclusive);
        GetMem(b, inStream.Size);
        inStream.Read(b^, inStream.Size);
        outStream.Write(b^, inStream.Size);
        FreeMem(b);
        inStream.Free;
        UlteriorTempLang := PrepTempLangFile(EXEDIR + 'trans\translations.' + thProjectStruct.Language); 
        inStream := TFileStream.Create(EXEDIR + 'trans\translations.' + 
          UlteriorTempLang + '.TempLangFile', fmOpenRead or fmShareDenyWrite); 
        GetMem(b, inStream.Size);
        inStream.Read(b^, inStream.Size);
        outStream.Write(b^, inStream.Size);
        FreeMem(b);
        inStream.Free;
        outStream.Free;
        DeleteFile(PChar(AssertDir(ExtractFilePath(SetupEXE)) + 'miax.lib'));
        DeleteFile(PChar(EXEDIR + 'trans\translations.' + UlteriorTempLang + '.TempLangFile')); 
        RenameFile(AssertDir(ExtractFilePath(SetupEXE)) + 'miax.lib.inj',
          AssertDir(ExtractFilePath(SetupEXE)) + 'miax.lib');
		  
        if AnsiCompareText(GetCompilerVariableValueDirect('NOEXE'), 'TRUE') = 0 then
        
          DeleteFile(PChar(AssertDir(ExtractFilePath(SetupEXE)) + 'miax.lib'));
      end;
      DoGenericCodeSign(AssertDir(ExtractFilePath(SetupEXE)) + 'miax.lib');
      UpdateString := SInjectedSetupLanguages;
      DisplayUpdateEx(UpdateString);
      if Cancelled then
        raise Exception.Create(SAbortedByUser);
      {$ENDIF}
      
      l := TStringList.Create;
      for i := 1 to thDialogFiles.Count do
        l.Add(PROJDIR + thDialogFiles[i -1]);
      
      if false then
        PreparePippin(l);
      for i := 1 to thSupportFiles.Count do
        if AnsiPos('translations.', thSupportFiles[i -1]) = 1 then 
        begin
          SetFileAttributes(PChar(PROJDIR + thSupportFiles[i -1] + '.shared'), 
            FILE_ATTRIBUTE_NORMAL);
          FileCopyFile(PChar(EXEDIR + 'trans' + PathDelim + thSupportFiles[i -1]), 
            PChar(PROJDIR + 'shared.' + thSupportFiles[i -1]), false); 
          if MyFileExists(PROJDIR + 'shared.' + thSupportFiles[i -1]) then 
            l.Add(PROJDIR + 'shared.' + thSupportFiles[i -1]); 
        end;
      for i := 1 to thSupportFiles.Count do
        if ((AnsiLowerCase(thSupportFiles[i -1]) <> 'setup.bmp') 
          and (AnsiLowerCase(thSupportFiles[i -1]) <> 'setup.ico')) and 
          (AnsiLowerCase(thSupportFiles[i -1]) <> 'updates.ini') then 
          l.Add(PROJDIR + thSupportFiles[i -1])
        
        else
          if (AnsiLowerCase(thSupportFiles[i -1]) = 'setup.bmp') then 
            FileCopyFile(PChar(PROJDIR + 'setup.bmp'), 
              PChar(thBuildToFolder + 'setup.bmp'), false); 
      {$IFDEF LINUX}
      
      if not MyFileExists(PROJDIR + 'icon.png') then 
        FileCopyFile(EXEDIR + 'miaxstub.png', PROJDIR + 'icon.png', false); 
      if l.IndexOf(PROJDIR + 'icon.png') = -1 then
      begin
      
        l.Add(PROJDIR + 'icon.png');
        luxLinux := false;
      end
      else
        luxLinux := True;
      
      {$ENDIF}
      for i := 1 to PlugDLLs.Count do
        l.Add(PlugDLLs[i -1]);
      for i := 1 to lXX.Count do
        if l.IndexOf(PROJDIR + lXX[i -1]) = -1 then 
          l.Add(PROJDIR + lXX[i -1]);
      PlugDLLs.Free;
      lXX.Free;
      if l.Count = 0 then
      begin
        AssignFile(t, thBuildToFolder  + 'mia.tmp',cp_utf8); 
        ReWrite(t);
        CloseFile(t);
        l.Add(thBuildToFolder  + 'mia.tmp'); 
      end;
      {$IFDEF WINDOWS}
      if BuildForm = 2 then
      begin
        l.Add(EXEDIR + 'libeay32.dll');
        l.Add(EXEDIR + 'ssleay32.dll');
      end; 
      {$ENDIF}
      {$IFDEF LINUX}
      if BuildForm = 2 then
      begin
        l.Add(EXEDIR + 'libcrypto.so.1.1');
        l.Add(EXEDIR + 'libssl.so.1.1');
      end; 
      {$ENDIF}
      
      {$IFDEF DARWIN}
      l.Add(s + '.msi'); 
      if thProjectStruct.aSign then
        l.Add(EXEDIR + 'macos/miaxstub'); 
      {$ENDIF}
      szMode := SStoringSupportFiles;
      szFirst7Zip := True;
      for i := 1 to l.Count do
        if not MyFileExists(l[i -1]) then
        begin
          if l[i -1] = '' then
            raise Exception.Create('Some plug-ins required by your project are not available.    '
              + 'Please ensure all required plug-ins are installed. Run InstallAware setup and   '
              + 'choose Add or Remove Features, or run the third party plug-in installer.')
          else
            raise Exception.Create(SUnableToFindSupportFile
              + l[i -1] + SUseTheProjectManagerWindowToUpda);
        end;
      CompressArchiveContents(thBuildToFolder + 'runtime.7zip', '', 
        GetOptionsString('0', false), 0, 2, s, l, nil, SevenZipProgress, nil);
      DeleteFile(PChar(thBuildToFolder  + 'mia.tmp')); 
      {$IFDEF DARWIN}
      DeleteFile(s + '.msi');
      {$ENDIF}
      l.Free;
      
      if (s = '') and (not MyFileExists(thBuildToFolder + 'runtime.7zip')) then 
        s := SPleaseCheckYourProjectNamesAndFo;
      if not MyFileExists(thBuildToFolder + 'runtime.7zip') then 
        raise Exception.Create(SUnableToBuildRuntimeFiles + s);
      if BuildForm <> 4 then 
      begin
      
        RenameFile(thBuildToFolder + 'runtime.7zip', 
          thBuildToFolder + ExtractFileNameOnly(SetupEXE) + '.res'); 
        
        if MasterStubEx <> '' then
          
          FileCopyFile(thBuildToFolder + ExtractFileNameOnly(SetupEXE) + '.res',
            thBuildToFolder + ExtractFileNameOnly(SetupEXE) + 'Ex.res', false); 
      end
      else
      begin
        if not thProjectStruct.BuildDebug then
          RenameFile(thBuildToFolder + 'runtime.7zip', thBuildToFolder + 'mia.res') 
        else
        begin
          RenameFile(thBuildToFolder + 'runtime.7zip', thBuildToFolder + 'mia.res'); 
          FileCopyFile(PChar(thBuildToFolder + 'mia.res'), 
            PChar(thBuildToFolder + ExtractFileNameOnly(SetupEXE) + '.res'), false); 
        end;
      end;
      {$IFDEF DARWIN}
      ForceDirectories(AssertDir(ExtractFilePath(SetupEXE)) + ExtractFileName(SetupEXE) + '.app/Contents/Resources/');
      if MyFileExists(PROJDIR + 'icon.icns') then
        FileCopyFile(PChar(PROJDIR + 'icon.icns'),
          PChar(AssertDir(ExtractFilePath(SetupEXE)) + ExtractFileName(SetupEXE) + '.app/Contents/Resources/miaxstub.icns'), 
          false)
      else
        FileCopyFile(PChar(EXEDIR + 'macos/miaxstub.app/Contents/Resources/miaxstub.icns'),
          PChar(AssertDir(ExtractFilePath(SetupEXE)) + ExtractFileName(SetupEXE) + '.app/Contents/Resources/miaxstub.icns'), 
          false);
      MoveFile(SetupEXE,
        AssertDir(ExtractFilePath(SetupEXE)) + ExtractFileName(SetupEXE) + '.app/Contents/MacOS/miaxstub');
      LazShimSetExecutable(AssertDir(ExtractFilePath(SetupEXE)) + ExtractFileName(SetupEXE) + '.app/Contents/MacOS/miaxstub', EXEDIR + 'macos/miaxstub');
      MoveFile(SetupEXEEx,
        AssertDir(ExtractFilePath(SetupEXEEx)) + ExtractFileName(SetupEXEEx) + '.app/Contents/MacOS/miaxstubEx');
      LazShimSetExecutable(AssertDir(ExtractFilePath(SetupEXEEx)) + ExtractFileName(SetupEXEEx) + '.app/Contents/MacOS/miaxstubEx', EXEDIR + 'macos/miaxstub');
      ForceDirectories(AssertDir(ExtractFilePath(SetupEXE)) + ExtractFileName(SetupEXE) + '.app/Contents/' + Ventura +  '/');
      MoveFile(AssertDir(ExtractFilePath(SetupEXE)) + 'miax.lib',
        AssertDir(ExtractFilePath(SetupEXE)) + ExtractFileName(SetupEXE) + '.app/Contents/' + Ventura +  '/miax.lib');
      LazShimSetExecutable(AssertDir(ExtractFilePath(SetupEXE)) + ExtractFileName(SetupEXE) + '.app/Contents/' + Ventura +  '/miax.lib', EXEDIR + 'macos/miaxstub');
      MoveFile(AssertDir(ExtractFilePath(SetupEXE)) + ExtractFileNameOnly(SetupEXE) + '.res',
        AssertDir(ExtractFilePath(SetupEXE)) + ExtractFileName(SetupEXE) + '.app/Contents/' + Ventura +  '/miaxstub.res');
      MoveFile(AssertDir(ExtractFilePath(SetupEXE)) + 'data',
        AssertDir(ExtractFilePath(SetupEXE)) + ExtractFileName(SetupEXE) + '.app/Contents/' + Ventura +  '/data');
      for nI := 1 to DoGenericCodeSignList.Count do
        DoGenericCodeSignList[nI -1] := StringReplace(DoGenericCodeSignList[nI -1],
          AssertDir(ExtractFilePath(SetupEXE)) + 'data',
          AssertDir(ExtractFilePath(SetupEXE)) + ExtractFileName(SetupEXE) + '.app/Contents/' + Ventura +  '/data',
          [rfReplaceAll, rfIgnoreCase]);
      LazShimSetExecutable(AssertDir(ExtractFilePath(SetupEXE)) + ExtractFileName(SetupEXE) + '.app/', EXEDIR + 'macos/miaxstub');
      {$ENDIF}
      UpdateString := SInjectedRuntimeFiles;
      DisplayUpdateEx(UpdateString);
      if Cancelled then
        raise Exception.Create(SAbortedByUser);
      
      if BuildForm <> 3 then
      begin
        bS := ProcessBuildEvents('POST-BUILD');
        if bS <> '' then
          raise Exception.Create('Post-Build command "' + bS + '" failed');
      end;
      
      if (({$IFNDEF DARWIN}(BuildForm = 1) or {$ENDIF}(BuildForm = 2)) or (BuildFormEx and (not (BuildForm = 0)))) and not
        thProjectStruct.BuildDebug then
      begin
        bS := ProcessBuildEvents('PRE-COMPRESS');
        if bS <> '' then
          raise Exception.Create('Pre-Compress command "' + bS + '" failed');
        
        if BuildForm = 2 then
        begin
          
          sI := '';
          szMode := SCompressingInstall;
          szFirst7Zip := True;
          
          lX := TStringList.Create;
          l := TStringList.Create;;
          for i := 1 to thScriptFetches.Count do
            if thScriptFetches[i -1] <> '' then
              if lX.IndexOf(AnsiLowerCase(thBuildToFolder +
                {$IFDEF DARWIN}
                ExtractFileName(SetupEXE) + '.app/Contents/' + Ventura +  '/' +
                {$ENDIF}
                'data' + PathDelim + thScriptFetches[i -1]) + '*') = -1 then 
                if thProhibitedScriptFetches.IndexOf(thScriptFetches[i -1]) = -1 then
                begin
                  rZEx := thBuildToFolder +
                    {$IFDEF DARWIN}
                    ExtractFileName(SetupEXE) + '.app/Contents/' + Ventura +  '/' +
                    {$ENDIF}
                    'data' + PathDelim;
                  
                  MkDir(rZEx + 'shim');
                  if not MoveFile(PChar(rZEx + thScriptFetches[i -1]),
                    PChar(rZEx + 'shim' + PathDelim + thScriptFetches[i -1])) then
                    
                    raise Exception.Create('Privilege error: Please try again as administrator!');
                  if not MoveFile(PChar(rZEx + 'shim'),
                    PChar(rZEx + thScriptFetches[i -1])) then
                    
                    raise Exception.Create('Privilege error: Please try again as administrator!');
                  lX.Add(rZEx + thScriptFetches[i -1] + '*'); 
                end;
          for i := 1 to lX.Count do
          begin
            if MyFileExists(EXEDIR + 'pch' + PathDelim + ExtractFileName(DeAssertDir(ExtractFilePath(lX[i -1])) + '.7zip')) and
              (AnsiCompareText(GetCompilerVariableValueDirect('PCH'), 'TRUE') = 0) then
            begin
              szMode := 'Copying pre-compiled application runtime for web media block: ' + ExtractFileNameOnly(DeAssertDir(ExtractFilePath(lX[i -1]))) + '/';
              if not FileCopyFile(PChar(EXEDIR + 'pch' + PathDelim + ExtractFileName(DeAssertDir(ExtractFilePath(lX[i -1])) + '.7zip')),
                PChar(thBuildToFolder + ExtractFileName(DeAssertDir(ExtractFilePath(lX[i -1])) + '.7zip')),
                false) then
              raise Exception.Create('Unable to copy pre-compiled application runtime for web media block: ' + s);
            end
            else
            begin
              
              lY := TStringList.Create;
              lY.Add(AssertDir(AssertDir(ExtractFilePath(lX[i -1]))) + '*');
              szMode := 'Compressing web media block: ' + ExtractFileNameOnly(DeAssertDir(ExtractFilePath(lX[i -1]))) + '/';
              szFirst7Zip := True;
              CompressArchiveContents(DeAssertDir(ExtractFilePath(lX[i -1])) +  '.7zip',
                GetWeblockPwd(ExtractFileNameOnly(DeAssertDir(ExtractFilePath(lX[i -1])))),
                GetOptionsString(thProjectStruct.CompressProfile,
                  GetWeblockPwd(ExtractFileNameOnly(DeAssertDir(ExtractFilePath(lX[i -1])))) <> ''),
                0, 2, s, l, lY, SevenZipProgress, nil);
              lY.Free;
              
              if (s = '') and (not MyFileExists(DeAssertDir(ExtractFilePath(lX[i -1])) +  '.7zip')) then
                s := SPleaseCheckYourProjectNamesAndFo;
              if not MyFileExists(DeAssertDir(ExtractFilePath(lX[i -1])) +  '.7zip') then
              begin
                l.Free;
                lX.Free;
                
                raise Exception.Create(SUnableToBuildWebMediaBlock + s);
              end;
              MoveFile(PChar(DeAssertDir(ExtractFilePath(lX[i -1])) +  '.7zip'),
                PChar(thBuildToFolder +
                ExtractFileName(DeAssertDir(ExtractFilePath(lX[i -1])) + '.7zip')));
            end;
            if CodeSignCorp <> '' then
              DoGenericCodeSignEx(thBuildToFolder + ExtractFileName(DeAssertDir(ExtractFilePath(lX[i -1])) + '.7zip')); 
            lXZ.Add(AnsiLowerCase(thBuildToFolder + ExtractFileName(DeAssertDir(ExtractFilePath(lX[i -1])) + '.7zip')));
            WipeFolder(ExtractFilePath(lX[i -1]), True);
            WipeFolder(ExtractFilePath(lX[i -1]), True);
            WipeFolder(ExtractFilePath(lX[i -1]), True);
            RemoveDirectory(PChar(ExtractFilePath(lX[i -1])));
            UpdateString := SCompressedWebMediaBlock +
              ExtractFileNameOnly(DeAssertDir(ExtractFilePath(lX[i -1])));
            DisplayUpdateEx(UpdateString);
            if Cancelled then Break;
          end;
          l.Free;
          lX.Free;
          
          UpdateString := SFinishedGeneratingWebMediaBlocks;
          DisplayUpdateEx(UpdateString);
          if Cancelled then
            raise Exception.Create(SAbortedByUser);
          
        end;

        lXY.Free;

        {$IFNDEF DARWIN}
        if BuildForm <> 0 then
        begin
          
          RenameFile(SetupEXE, thBuildToFolder + 'miaxstub'{$IFDEF WINDOWS} + '.exe'{$ENDIF});
          RenameFile(thBuildToFolder + ExtractFileNameOnly(SetupEXE) + '.res',
            thBuildToFolder + 'miaxstub.res');
          if masterStubEx <> '' then
          begin
            RenameFile(SetupEXEEx, thBuildToFolder + 'miaxstubEx'{$IFDEF WINDOWS} + '.exe'{$ENDIF});
            RenameFile(thBuildToFolder + ExtractFileNameOnly(SetupEXEEx) + '.res',
              thBuildToFolder + 'miaxstubEx.res');
          end;
        end;
        {$ENDIF}

        {$IFDEF DARWIN} 
        if (BuildForm <> 2) and (not BuildFormEx) then 
        {$ENDIF}
        begin
          l := TStringList.Create;
          lX := TStringList.Create;
          FindFirst(PChar(thBuildToFolder + '*'), faAnyFile, fd);
          repeat
            if (String(fd.Name) <> '.') and (fd.Name <> '..') then
            begin
              if DirectoryExists(thBuildToFolder + fd.Name) then
              begin
                if (BuildForm = 1) or (BuildForm = 2) then
                begin
                  
                  if AnsiCompareText(fd.Name, 'data') = 0 then
                  begin
                    MkDir(thBuildToFolder + 'shim');
                    MoveFile(PChar(thBuildToFolder + fd.Name),
                      PChar(thBuildToFolder + 'shim' + PathDelim + 'data'));
                    MoveFile(PChar(thBuildToFolder + 'shim'),
                      PChar(thBuildToFolder + 'data'));
                  end;
                  lX.Add(thBuildToFolder + fd.Name + PathDelim + '*');
                end;
              end
              else
                if lXZ.IndexOf(AnsiLowerCase(thBuildToFolder + fd.Name)) = -1 then
                  l.Add(thBuildToFolder + fd.Name);
            end;
          until FindNext(fd) <> 0;
          SysUtils.FindClose(fd);
          lXZ.Free;
          if (BuildForm = 2) and DirectoryExists(thBuildToFolder + 'data' + PathDelim + 'OFFLINE') then 
            lX.Add(thBuildToFolder + 'data' + PathDelim + 'OFFLINE' + PathDelim + '*'); 
          if (BuildForm = 2) and DirectoryExists(thBuildToFolder + 'data\MERGEMOD') then 
            lX.Add(thBuildToFolder + 'data\MERGEMOD\*.*'); 
          
          sI := '';
          szMode := SCompressingInstall;
          szFirst7Zip := True;
          
          for k := 1 to l.Count do
            if AnsiCompareText(thBuildToFolder + 'setup.bmp', l[k -1]) = 0 then
            begin
              l.Delete(k -1);
              lZ := TStringList.Create;
              lZ.Add(thBuildToFolder + 'setup.bmp');
              
              if not CompressArchiveContents(thBuildToFolder + 'sfx.7zip', GetWeblockPwd('OFFLINE'), 
                GetOptionsString(thProjectStruct.CompressProfile, false), 0, 2, s, lZ, nil, SevenZipProgress, nil) then 
              begin
                lX.Free;
                l.Free;
                lZ.Free;
                raise Exception.Create(SUnableToBuildSetupFiles + s);
              end;
              lZ.Free;
              Break;
              szFirst7Zip := True;
            end;

          if (AnsiCompareText(
            GetCompilerVariableValueDirectEx('MIN_EXTRACT'), 'AUTO') = 0) or
            (AnsiCompareText(
            GetCompilerVariableValueDirectEx('MIN_EXTRACT'), 'MANUAL') = 0) then
          begin
            lZ := TStringList.Create;
            for k := l.Count downto 1 do
              if (AnsiCompareText(AssertDir(ExtractFilePath(l[k -1])), AssertDir(thBuildToFolder)) = 0) 
              then
              begin
                if ((AnsiCompareText(ExtractFileExt(l[k -1]), '.msi') = 0) or (AnsiCompareText(ExtractFileExt(l[k -1]), '.msp') = 0)) then
                  sI := l[k -1]
                else
                  lZ.Add(l[k -1]);
                l.Delete(k -1);
              end;
            if not CompressArchiveContents(thBuildToFolder + 'sfx.7zip', GetWeblockPwd('OFFLINE'), 
              GetOptionsString(thProjectStruct.CompressProfile, false), 0, 2, s, lZ, nil, SevenZipProgress, nil) then 
            begin
              lX.Free;
              l.Free;
              lZ.Free;
              raise Exception.Create(SUnableToBuildSetupFiles + s);
            end;
            lZ.Free;
            szFirst7Zip := True;
          end;

          UpdateString := 'Eliminating redundancies';
          DisplayUpdateEx(UpdateString);
          if Cancelled then
            raise Exception.Create(SAbortedByUser);

          if (l.Count > 0) or (lX.Count > 0) then 
          begin
            
            if l.Count = 0 then
            begin
              l.Free;
              l := nil;
            end;
            
            if lX.Count = 0 then
            begin
              lX.Free;
              lX := nil; 
            end;
            if not CompressArchiveContents(thBuildToFolder + 'sfx.7zip', GetWeblockPwd('OFFLINE'), 
              GetOptionsString(thProjectStruct.CompressProfile, false), 0, 2, s, l, lX, SevenZipProgress, nil) then 
            begin
              if Assigned(lX) then
                lX.Free;
              if Assigned(l) then
                l.Free;
              raise Exception.Create(SUnableToBuildSetupFiles + s);
            end;
          end;
          if Assigned(lX) then
            lX.Free;
          if Assigned(l) then
            l.Free;

          if sI <> '' then
          begin
            szFirst7Zip := True;
            lZ := TStringList.Create;
            lZ.Add(sI);
            if not CompressArchiveContents(thBuildToFolder + 'sfx.7zip', GetWeblockPwd('OFFLINE'), 
              GetOptionsString(thProjectStruct.CompressProfile, false), 0, 2, s, lZ, nil, SevenZipProgress, nil) then 
            begin
              lZ.Free;
              raise Exception.Create(SUnableToBuildSetupFiles + s);
            end;
            lZ.Free;
          end;

          if (s = '') and (not MyFileExists(thBuildToFolder + 'sfx.7zip')) then 
            s := SPleaseCheckYourProjectNamesAndFo;
          if not MyFileExists(thBuildToFolder + 'sfx.7zip') then 
            raise Exception.Create(SUnableToBuildSetupFiles + s);
          UpdateString := SCompressedSetupFiles;
          DisplayUpdateEx(UpdateString);
          if Cancelled then
            raise Exception.Create(SAbortedByUser);
          
          AssignFile(t, thBuildToFolder + 'sfx.txt',cp_utf8); 
          ReWrite(t);
          WriteLn(t, ';!@Install@!UTF-8!'); 
          WriteLn(t, 'Title="InstallAware Multi Platform"');
          
          WriteLn(t, 'RunProgram="' + 'miaxstub' {$IFDEF WINDOWS} + '.exe'{$ENDIF} + '"'); 
          WriteLn(t, ';!@InstallEnd@!'); 
          CloseFile(t);
          
          UpdateString := SPreparedSFXData;
          DisplayUpdateEx(UpdateString);
          if Cancelled then
            raise Exception.Create(SAbortedByUser);
          
            {$IFDEF LINUX}
            if AnsiCompareText(masterStubX, 'TRUE') <> 0 then
              FileCopyFile(PChar(EXEDIR + 'linux/dependentx'), PChar(EXEDIR + UlteriorDependent), 
                false)
            else 
              FileCopyFile(PChar(EXEDIR + 'linux/dependenty'), PChar(EXEDIR + UlteriorDependent), 
                false);
            {$ELSE}
            {$IFDEF DARWIN}
            
            WipeFolder(SETUPEXE + '.app/', True);
             
            FileCopyFile(PChar(EXEDIR + 'macos/dependentx.app/Contents/Info.plist'),
              PChar(SETUPEXE + '.app/Contents/Info.plist'), 
              false);
            FileCopyFile(PChar(EXEDIR + 'macos/dependentx.app/Contents/PkgInfo'),
              PChar(SETUPEXE + '.app/Contents/PkgInfo'), 
              false);
            ForceDirectories(SETUPEXE + '.app/Contents/MacOS');
            
            if thSupportFiles.IndexOf('setup.png') <> -1 then
              InjectMPStub(EXEDIR + 'macos/dependentx.app/Contents/MacOS/dependentx',
                EXEDIR + 'macos/localizations.json',
                thBuildToFolder + 'sfx.7zip',
                PROJDIR + 'setup.png',
                SETUPEXE + '.app/Contents/MacOS/dependentx')
            else
              InjectMPStub(EXEDIR + 'macos/dependentx.app/Contents/MacOS/dependentx',
                EXEDIR + 'macos/localizations.json',
                thBuildToFolder + 'sfx.7zip',
                '',
                SETUPEXE + '.app/Contents/MacOS/dependentx');
            LazShimSetExecutable(SETUPEXE + '.app/Contents/MacOS/dependentx', EXEDIR + 'macos/miaxstub');
            ForceDirectories(SETUPEXE + '.app/Contents/Resources/Base.lproj/MainMenu.nib');
            FileCopyFile(PChar(EXEDIR + 'macos/miaxstub.app/Contents/Resources/miaxstub.icns'),
              PChar(SETUPEXE + '.app/Contents/Resources/miaxstub.icns'), 
              false);
            FileCopyFile(PChar(EXEDIR + 'macos/dependentx.app/Contents/Resources/Base.lproj/MainMenu.nib/keyedobjects-101300.nib'),
              PChar(SETUPEXE + '.app/Contents/Resources/Base.lproj/MainMenu.nib/keyedobjects-101300.nib'), 
              false);
            FileCopyFile(PChar(EXEDIR + 'macos/dependentx.app/Contents/Resources/Base.lproj/MainMenu.nib/keyedobjects.nib'),
              PChar(SETUPEXE + '.app/Contents/Resources/Base.lproj/MainMenu.nib/keyedobjects.nib'), 
              false);
            {$ELSE}
            CopyFile(PChar(EXEDIR + 'windows\dependentx.exe'), PChar(EXEDIR + UlteriorDependent), 
              false);
            {$ENDIF}
            {$ENDIF}
          if thSupportFiles.IndexOf('icon.ico') <> -1 then 
          begin
            
          end;
          miaReplaceLangEx(UlteriorDependent);
          
          {$IFNDEF DARWIN}
          inStream := TFileStream.Create(EXEDIR + UlteriorDependent , 
            fmOpenRead or fmShareDenyWrite);
          outStream := TFileStream.Create(SetupEXE + '.x', fmCreate or fmShareExclusive);
		  
          if AnsiCompareText(GetCompilerVariableValueDirect('NOEXE'), 'TRUE') <> 0 then
          
            outStream.CopyFrom(inStream, inStream.Size);
          inStream.Free;
          inStream := TFileStream.Create(thBuildToFolder + 'sfx.txt', 
            fmOpenRead or fmShareDenyWrite);
		    
          if AnsiCompareText(GetCompilerVariableValueDirect('NOEXE'), 'TRUE') <> 0 then
          
            outStream.CopyFrom(inStream, inStream.Size);
          inStream.Free;
          {$IFDEF LINUX}
          if luxLinux then
          begin
            inStream := TFileStream.Create(PROJDIR + 'icon.png', fmOpenRead or fmShareDenyWrite);
            outStream.CopyFrom(inStream, inStream.Size);
            inStream.Free;
          end;
          {$ENDIF}
          inStream := TFileStream.Create(thBuildToFolder + 'sfx.7zip', 
            fmOpenRead or fmShareDenyWrite);
          outStream.CopyFrom(inStream, inStream.Size);
          inStream.Free;
          outStream.Free;
          DeleteFile(PChar(SetupEXE));
          RenameFile(SetupEXE + '.x', SetupEXE);
          {$ENDIF}
          UpdateString := SCreatedSFXFile;
          DisplayUpdateEx(UpdateString);
          if Cancelled then
            raise Exception.Create(SAbortedByUser);
          {$IFDEF LINUX}
          LazShimSetExecutable(SetupEXE, EXEDIR + 'linux/miaxstub');
          DisplayUpdateEx('Applied launch permissions upon package');
          if Cancelled then
            raise Exception.Create(SAbortedByUser);
          {$ENDIF}
          bS := ProcessBuildEvents('POST-COMPRESS');
          if bS <> '' then
            raise Exception.Create('Post-Compress command "' + bS + '" failed');
          
          if not thProjectStruct.BuildDebug then
          begin
            {$IFNDEF WINDOWS}
            l := FindAllFilesEx(thBuildToFolder + '*', True);
            {$ELSE}
            l := FindAllFilesEx(thBuildToFolder + '*.*', True);
            {$ENDIF}
            
            for i := 1 to l.Count do
              {$IFDEF DARWIN}
              if AnsiPos(AnsiLowerCase(SetupEXE) + '.app', AnsiLowerCase(l[i -1])) <> 1 then
              {$ELSE}
              if AnsiLowerCase(l[i -1]) <> AnsiLowerCase(SetupEXE) then
              {$ENDIF}
              begin
                if DirectoryExists(l[i -1])  then
                begin
                  WipeFolder(l[i -1], True);
                  RemoveDirectory(PChar(l[i -1]));
                  
                end
                else
                begin
                  if not (((BuildForm = 2) and
                    (AnsiLowerCase(ExtractFileExt(l[i -1])) = '.7zip')) and 
                    ((ExtractFilePath(l[i -1]) = thBuildToFolder) and
                    (AnsiLowerCase(l[i -1]) <> AnsiLowerCase(thBuildToFolder) + 'sfx.7zip'))) then 
                  begin
                    DeleteFile(PChar(l[i -1]));
                    RemoveDirectory(PChar(ExtractFilePath(l[i -1])));
                    
                  end;
                end;
              end;
            l.Free;
          end;
          
          DeleteDirectory(AssertDir(ExtractFilePath(SetupEXE)) + 'data' + PathDelim, false);
          
          UpdateString := SCleanedUp;
          DisplayUpdateEx(UpdateString);
          if Cancelled then
            raise Exception.Create(SAbortedByUser);
          
          {$IFDEF DARWIN}
          LazShimSetExecutable(SETUPEXE + '.app/Contents/MacOS/dependentx', EXEDIR + 'macos/miaxstub');
          LazShimSetExecutable(SETUPEXE + '.app/', EXEDIR + 'macos/miaxstub');
          FileCopyFile(PChar(EXEDIR + 'macos/miaxstub.app/Contents/Resources/miaxstub.icns'),
            PChar(SETUPEXE + '.app/Contents/Resources/miaxstub.icns'), 
            false);
          {$ENDIF}
        end;
      end;
      {$IFDEF WINDOWS}
      if BuildForm = 0 then
      begin
        AssignFile(t, thBuildToFolder +  'autorun.inf',cp_utf8); 
        ReWrite(t);
        WriteLn(t, '[AutoRun]'); 
        WriteLn(t, 'icon=', ExtractFileName(SetupEXE), ',0'); 
        WriteLn(t, 'label=', thProjectStruct.Name); 
        WriteLn(t, 'open=', ExtractFileName(SetupEXE)); 
        CloseFile(t);
      end;
      {$ENDIF}
      if AnsiCompareText(GetCompilerVariableValueDirect('KEEPSTUBDATA'), 'TRUE') = 0 then
        RenameFile(EXEDIR + UlteriorTemp,
          AssertDir(ExtractFilePath(SetupEXE)) + ExtractFileNameOnly(SetupEXE) + {$IFDEF DARWIN} '.app/Contents/MacOS/miaxstub' + {$ENDIF} '.stubdata');
      {$IFDEF DARWIN}
      for nI := 1 to DoGenericCodeSignList.Count do
        DoGenericCodeSign(DoGenericCodeSignList[nI -1]);
      DoGenericCodeSign(SetupEXE + '.app/Contents/' + Ventura +  '/miax.lib'); 
      DoGenericCodeSign(SetupEXE + '.app/Contents/MacOS/miaxstub'); 
      DoGenericCodeSign(SetupEXE + '.app'); 
      {$ENDIF}
      
      {$IFDEF DARWIN}
      if ((BuildForm = 1) or (BuildForm = 2)) and not thProjectStruct.BuildDebug then
      begin
        
        rZ := thBuildToFolder
          + thProjectStruct.Name +
          '.dmg';
        lZEx := TStringList.Create;
        
        lZEx.Add('create');
        lZEx.Add(rZ);
        lZEx.Add('-ov');
        lZEx.Add('-volname');
        lZEx.Add(thProjectStruct.Name);
        lZEx.Add('-fs');
        lZEx.Add('HFS+');
        lZEx.Add('-format');
        if TryStrToInt(thProjectStruct.CompressProfile, rIX) then
        begin
          if rIX < 0 then rIX := 0
            else
            if rIX > 6 then rIX := 6;
        end
        else
          rIX := 6;
        case rIX of
          0: lZEx.Add('UDRO');
          1: lZEx.Add('UDRW');
          2: lZEx.Add('UDCO');
          3: lZEx.Add('UDBZ');
          4: lZEx.Add('UDZO');
          5: lZEx.Add('ULFO');
          6: lZEx.Add('ULMO');
        end;
        
        lZEx.Add('-srcfolder');
        lZEx.Add(thBuildToFolder);
        if thProjectStruct.PassEnabled then
        begin
          lZEx.Add('-encryption');
          lZEx.Add('-passphrase');
          lZEx.Add(thProjectStruct.Password);
        end;
        UpdateString := 'Building DMG for macOS';
        DisplayUpdateEx(UpdateString);
        if Cancelled then
          raise Exception.Create(SAbortedByUser);
        lZEy := TStringList.Create;
        MyFindAllFiles(lZEy, thBuildToFolder, '*.7zip', false);
        for nI := 1 to lZEy.Count do
          MoveFile(lZEy[i -1],
            AssertDir(ExtractFilePath(DeAssertDir(ExtractFilePath(lZEy[i -1]))))
              + ExtractFileName(lZEy[i -1]));
        if LaunchAppAndWait2('/usr/bin/hdiutil', lZEx, false, True) <> 0 then
          raise Exception.Create('Unable to build disk image "' + rZ);
        WipeFolder(SETUPEXE + '.app/', True);
        RemoveDirectory(SETUPEXE + '.app/');
        for nI := 1 to lZEy.Count do
          MoveFile(AssertDir(ExtractFilePath(DeAssertDir(ExtractFilePath(lZEy[i -1]))))
            + ExtractFileName(lZEy[i -1]),
            lZEy[i -1]);
        UpdateString := 'Built DMG for macOS';
        DisplayUpdateEx(UpdateString);
        
        lZEx.Free;
        lZEy.Free;
        
        WidenColonDelimParam(thProjectStruct.aCertificate, Wide1, Wide2);
        nTeamID := Wide2;
        WidenColonDelimParam(thProjectStruct.aTimeStamp, Wide1, Wide2);
        nAppPass := Wide2;
        WidenColonDelimParam(thProjectStruct.aKey, Wide1, Wide2);
        nAppleID := Wide1;
        if nAppleID <> '' then
          if nAppPass <> '' then
            if nTeamID <> '' then
              if thProjectStruct.aSign then
                DoGenericDMGSign(rZ, nTeamID, nAppleID, nAppPass);
      end;
      {$ENDIF}
      if thSupportFiles.IndexOf('updates.ini') <> -1 then 
        FileCopyFile(PChar(PROJDIR + 'updates.ini'), 
          PChar(thBuildToFolder + 'updates.ini'), false); 
      {$IFDEF WINDOWS}
      DoGenericCodeSign(SetupEXE); 
      {$ENDIF}
      
      Success := True;
    except
      on E: Exception do
      begin
        UpdateString := SErrorDuringBuild + E.Message;
        DisplayUpdateEx(UpdateString);
        
      end;
    end;
  finally
    DeleteFile(PChar(EXEDIR + UlteriorDependent));
    DeleteFile(PChar(EXEDIR + UlteriorString));
    if masterStubEx <> '' then
      DeleteFile(PChar(EXEDIR + UlteriorStringEx));
  end;
end;

procedure TBuildThread.InjectMPStub(Engine, Translations, Package, Splash, Output: String);
var
  i: Int64;
  j: Integer;
  d, e, g: DWord;
  f: QWord;
  p: Pointer;
  s, w: TFileStream;
begin
  s := TFileStream.Create(Engine, fmOpenRead);
  w := TFileStream.Create(Output, fmCreate or fmOpenReadWrite);
  i := s.Size;
  d := i;
  j := i;
  GetMem(p, i);
  s.Read(p^, j);
  w.Write(p^, j);
  s.Free;
  FreeMem(p);
  s := TFileStream.Create(Package, fmOpenRead);
  i := s.Size;
  f  := i;
  j := i;
  GetMem(p, i);
  s.Read(p^, j);
  w.Write(p^, j);
  s.Free;
  FreeMem(p);
  s := TFileStream.Create(Translations, fmOpenRead);
  i := s.Size;
  e := i;
  j := i;
  GetMem(p, i);
  s.Read(p^, j);
  w.Write(p^, j);
  s.Free;
  FreeMem(p);
  if (Splash <> '') and MyFileExists(Splash) then
  begin
    s := TFileStream.Create(Splash, fmOpenRead);
    i := s.Size;
    g := i;
    j := i;
    GetMem(p, i);
    s.Read(p^, j);
    w.Write(p^, j);
    s.Free;
    FreeMem(p);
  end
  else
    g := 0;
  
  w.WriteBuffer(d, SizeOf(d));
  w.WriteBuffer(f, SizeOf(f));
  w.WriteBuffer(e, SizeOf(e));
  w.WriteBuffer(g, SizeOf(g));
  w.Free;
end;

procedure TBuildThread.DisplayUpdate;
begin
  if Build.Output.Lines.Count > 1000 then
    Build.Output.Lines.Clear; 
    
  Build.Output.Lines.Add(UpdateString);
end;

function TBuildThread.DisplayUpdateEx(Status: String): Boolean;
begin
  UpdateString := Status;
  if mbuild.IsConsole and (not mBuild.IsConsoleEx) then
  begin
    WriteLn(Status);
    if ConsoleBuildMirrorBufferFile <> '' then
      ConsoleBuildMirrorBuffer.Add(Status);
  end
  else
    Synchronize(DisplayUpdate);
  Result := not Cancelled;
end;

function TBuildThread.DisplayUpdateExEy(Status: String): Boolean;
begin
  UpdateString := Status;
  if mbuild.IsConsole and (not mBuild.IsConsoleEx) then
  begin
    WriteLn(Status);
    if ConsoleBuildMirrorBufferFile <> '' then
      ConsoleBuildMirrorBuffer.Add(Status);
  end
  else
    Synchronize(DisplayUpdateEy);
  Result := not Cancelled;
end;

procedure TBuildThread.Execute;
begin
  BuildStub;
  BuildFinished := True;
  
  if Build.Caption = 'Cancel' then
    Build.TimerTimer(Self);
end;

function TBuildThread.GetCodeSignName: String;
var
  g: TGUID;
  p: PChar;
  s: String;
begin
  Result := '';
  
end;

function TBuildThread.GetCompilerVariableValueDirect(Variable: String): String;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to CompilerVariableDirect.Count do
    if i mod 2 = 1 then
    begin
      if AnsiCompareText(CompilerVariableDirect[i -1], Variable) = 0 then
      begin
        Result := CompilerVariableDirect[i];
        Exit;
      end;
    end;
end;

function TBuildThread.GetWeblockPwd(Weblock: String): String;
begin
  Result := '';
  if WeblockPasswords.Count = 0 then Exit;
  try
    if WeblockPasswords[WeblockPasswords.IndexOf(AnsiLowerCase(Weblock)) +1] <> '' then
      Result := DeObsWeblock(WeblockPasswords[WeblockPasswords.IndexOf(AnsiLowerCase(Weblock)) +1]);
  except
    Result := '';
  end;
end;

procedure TBuildThread.miaReplaceLang(LanguageName, UlteriorDependent: String; LanguageCode: Integer);
var
  s: String;
  l: TStringList;
  t, tX: TextFile;
  BOM: Char;
begin
  if MyFileExists(EXEDIR + 'trans' + PathDelim + 'translations.' + LanguageName) then 
  begin
    l := TStringList.Create;
    AssignFile(t, EXEDIR + 'trans' + PathDelim + 'translations.Map',cp_utf8); 
    AssignFile(tX, EXEDIR + 'trans' + PathDelim + 'translations.' + LanguageName,cp_utf8); 
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
    Reset(tX);
    if not eof(tX) then
    begin
      read(tX, BOM);
      if ansicomparetext(BOM, #$FEFF) <> 0 then
      begin
        closefile(tX);
        reset(tX);
      end;
    end;
    while not EOF(t) do
    begin
      ReadLn(t, s);
      if s = 'STUB' then 
      begin
        ReadLn(tX, s);
        l.Add(s);
      end
      else
        ReadLn(tX);
    end;
    CloseFile(t);
    CloseFile(tX);
    
    l.Free;
  end;
end;

procedure TBuildThread.miaReplaceLangEx(UlteriorDependent: String);
var
  i: Integer;
  s: String;
  l: TStringList;
begin
  
  l := FindAllFilesEx(EXEDIR + 'trans' + PathDelim + 'translations.*', false); 
  for i := 1 to l.Count do
  begin
    s := ExtractFileName(l[i -1]);
    if YTM_SmartPos('.Map', s, false) = 0 then 
      if YTM_SmartPos('.Definition', s, false) = 0 then 
        if YTM_SmartPos('.Original', s, false) = 0 then 
          miaReplaceLang(Copy(s, AnsiPos('.', s) +1, Length(s)), UlteriorDependent,
            StrToInt(LangToCode(Copy(s, AnsiPos('.', s) +1, Length(s)))));
  end;
  l.Free;
end;

procedure TBuildThread.PreparePippin(l: TStrings);
var
  rStream: TResourceStream;
  fStream: TFileStream;
begin
  rStream := TResourceStream.Create(hInstance, 'PPIN32', RT_RCDATA);
  try
    fStream := TFileStream.Create(thBuildToFolder + 'pPin32.cpl', fmCreate) ;
    try
      fStream.CopyFrom(rStream, 0) ;
      l.Add(ExtractFilePath(SetupMSI) + 'pPin32.cpl');
    finally
      fStream.Free;
    end;
  finally
    rStream.Free;
  end;
  rStream := TResourceStream.Create(hInstance, 'PPIN64', RT_RCDATA);
  try
    fStream := TFileStream.Create(thBuildToFolder + 'pPin64.cpl', fmCreate) ;
    try
      fStream.CopyFrom(rStream, 0) ;
      l.Add(ExtractFilePath(SetupMSI) + 'pPin64.cpl');
    finally
      fStream.Free;
    end;
  finally
    rStream.Free;
  end;
end;

function TBuildThread.PrepTempLangFile(DefLang: String): String;
var
  s, sX: String;
  i: Integer;
  l: TStringList;
  t, tX: TextFile;
  BOM: Char;
begin
  Result := CreateGUIDUp;
  AssignFile(t, EXEDIR + 'trans' + PathDelim + 'translations.' + Result + '.TempLangFile',cp_utf8); 
  ReWrite(t);
  l := FindAllFilesEx(EXEDIR + 'trans' + PathDelim + 'translations.*', false); 
  for i := 1 to l.Count do
  begin
    if i = 1 then
    begin
      AssignFile(tX, DefLang,cp_utf8);
      Reset(tX);
      if not eof(tX) then
      begin
        read(tX, BOM);
        if ansicomparetext(BOM, #$FEFF) <> 0 then
        begin
          closefile(tX);
          reset(tX);
        end;
      end;
      while not EOF(tX) do
      begin
        ReadLn(tX, s);
        WriteLn(t, s);
      end;
      CloseFile(tX);
    end;
    if YTM_SmartPos('.Map', l[i -1], false) = 0 then 
      if YTM_SmartPos('.Definition', l[i -1], false) = 0 then 
        if YTM_SmartPos('.Original', l[i -1], false) = 0 then 
          if YTM_SmartPos('.TempLangFile', l[i -1], false) = 0 then 
          begin
            sX := ExtractFileName(l[i -1]);
            WriteLn(t, Copy(sX, AnsiPos('.', sX) +1, Length(sX)));
            AssignFile(tX, l[i -1],cp_utf8);
            Reset(tX);
            if not eof(tX) then
            begin
              read(tX, BOM);
              if ansicomparetext(BOM, #$FEFF) <> 0 then
              begin
                closefile(tX);
                reset(tX);
              end;
            end;
            while not EOF(tX) do
            begin
              ReadLn(tX, s);
              WriteLn(t, s);
            end;
            CloseFile(tX);
          end;
  end;
  CloseFile(t);
  l.Free;
end;

function TBuildThread.ProcessBuildEvents(Kind: String): String;
var
  s, sX: String;
  b: Boolean;
  i: Integer;
  l: TStringList;
begin
  Result := '';
  s := GetCompilerVariableValueDirect(Kind + '-EVENT-COMMANDS');
  if s <> '' then
  begin
    s := SubstituteCompilerVariables(MemoMultiToDefaultMultiLineAdapter(
      SingleLineToMultiLine(s)), thProjectStruct.Conditionals);
    l := TStringList.Create;
    l.Text := s;
    for i := 1 to l.Count do
    begin
      sX := l[i -1];
      
    end;
    l.Free;
  end;
end;

function TBuildThread.ReplaceString(pFileName: String; nSmartPosition,
  nOldStrLen: LongWord; pOldString: AnsiString; nNewStrLen: LongWord;
  pNewString: AnsiString): Integer;
var
  iOldStrLen, iNewStrLen: LongWord;
  iFileHandle, iFileLength: LongWord;
  Buffer: Pointer;
  c: Cardinal;
  f: File;
begin
  iOldStrLen := nOldStrLen;
  if nOldStrLen = -1 then
    iOldStrLen := Length(pOldString);
  iNewStrLen := nNewStrLen;
  if nNewStrLen = -1 then
    iNewStrLen := Length(pNewString);
  if iNewStrLen > iOldStrLen then
  begin
    Result := 0;
    Exit;
  end
  else
  begin
    if (pFileName <> '') and MyFileExists(pFileName) then
    begin
      iFileHandle := FileOpen(PChar(pFileName), fmOpenWrite);
      if iFileHandle <> INVALID_HANDLE_VALUE then
      begin
        
        FileMode := 0;
        AssignFile(f, pFileName);
        Reset(f, 1);
        iFileLength := FileSize(f);
        CloseFile(f);
        if iFileLength > nSmartPosition then
        begin
          FileSeek(iFileHandle, nSmartPosition, 0);
          GetMem(Buffer, (Length(pNewString) +1));
          FillChar(Buffer^, SizeOf(Buffer), #0);
          StrCopy(PChar(Buffer), PChar(pNewString));
          c := FileWrite(iFileHandle, Buffer^, Length(pNewString) +1);
          FreeMem(Buffer);
          FileClose(iFileHandle); 
          Result := c;
        end
        else
        begin
          FileClose(iFileHandle); 
          Result := -2;
        end;
      end
      else
        Result := -3;
    end
    else
      Result := -4;
  end;
end;

function TBuildThread.SearchString(pFileName: String; nLength: LongWord;
  pString: AnsiString; nStartSmartPosition: LongWord): Integer;
var
  iFileHandle: THandle;
  iFileLength, iBytesRead, iLen: LongWord;
  Buffer: Pointer;
  c: AnsiChar;
  iResult, i, j: Integer;
  found: Boolean;
  f: File;
begin
  if (pFileName <> '') and MyFileExists(pFileName) then
  begin
    iFileHandle := FileOpen(PChar(pFileName), fmOpenRead);
    if iFileHandle <> INVALID_HANDLE_VALUE then
    begin
      
      FileMode := 0;
      AssignFile(f, pFileName);
      Reset(f, 1);
      iFileLength := FileSize(f);
      CloseFile(f);
      if (iFileLength > nStartSmartPosition) then
      begin
        GetMem(Buffer, iFileLength +1);
        FileSeek(iFileHandle, nStartSmartPosition, 0);
        iBytesRead := FileRead(iFileHandle, Buffer^, iFileLength - nStartSmartPosition);
        FileClose(iFileHandle); 
        iLen := nLength;
        if nLength = -1 then
          iLen := Length(pString);
        iResult := -1;
        for i := 0 to iBytesRead -1 do
        begin
          found := True;
          for j := 0 to iLen -1 do
          begin
            c := AnsiChar(Pointer(Integer(Buffer) + i + j)^);
            if c <> pString[j +1] then
            begin
              found := false;
              Break;
            end;
          end;
          if found then
          begin
            iResult := i;
            Break;
          end;
        end;
        FreeMem(Buffer);
        Result := iResult;
      end
      else
      begin
        FileClose(iFileHandle); 
        Result := -2;
      end;
    end
    else
      Result := -3;
  end
  else
    Result := -4;
end;

function TBuildThread.SerialCheckSubEx(ID: Integer): Boolean;
begin
  
  Result := false;
end;

procedure TBuildThread.SerialCheckSubEy;
begin
end;

procedure TBuildThread.DisplayUpdateEy;
begin
  
  if True and
    ((Build.Output.Lines.Count > 0) and
      (AnsiPos(SCopiedFile, Build.Output.Lines[Build.Output.Lines.Count -1]) = 1)) then
    Build.Output.Lines[Build.Output.Lines.Count -1] := UpdateString
  else
    Build.Output.Lines.Add(UpdateString);
end;

procedure TBuildThread.TimerExDisable;
begin
  Build.TimerEx.Enabled := false;
end;

procedure TBuildThread.TimerExEnable;
begin
  Build.TimerEx.Enabled := True;
end;

end.
