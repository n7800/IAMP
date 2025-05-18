{
        Unit        : T4ALIB - t4a_VersionInfo
        Version     : 2.7
        Date        : 2023-03-08
        Copyright   : Hans Luijten, www.Tweaking4All.com

        Purpose     : Unit that provides Application and OS version information.
                      OS specific information will be cached to minimize resources when calling the OS details again (except for "UpTime")

        Types       : TOSDetails         Holds OS specific details
                      TAppDetails        Hold Application specific details

        Functions   : GetOSDetails          : Get OS specific details
                      GetOSDetailsString    : Get OS specific details as string
                      OSIsAtleast           : Check if the OS is at least the version passed to the function
                      OSGetBits             : Determine the architecture bits of your operating system (typical: 32 or 64 bits)
                      GetAppDetails         : Get Application specific details (version, architecture)
                      GetAppVersionString   : Get application version as string (build optional)
                      GetApplicationPath    : Get the path of the executable (MacOS: Returns bundle/app/Contents/MacOS/xyz)
                      GetWindowAppCaption   : Gets a generic Caption for your application window (incl name, copyright, version ect)

        OS Specific functions:              (used to support the generic functions but can also bve accessed directly)

                      MacOS specific:
                      GetMacOSVersionName   : Returns the name of the operating system (EG. Mojave, Catalina, etc)
                      GetBundleIdentifier   : Retrieves the Bundle identifier from the .plist file of your application
                      GetBundlePath         : Get the path of the .app bundle

                      Windows Specific:
                      OSGetPhysicalMemory   : Try to determine installed memory (in bytes)
                      OSGuessUpTime         : Try to retrieve installed memory (in seconds)

                      Linux specific:
                      GetOSName             : Try to determine the Linux distro name
                      GetOSHostname         : Determine hostname as it appears in your network
                      GetUsername           : Determine username of current user
                      OSGetKernelVersion    : Try to determine Kernel version

        v2.7        - Fixed GetOSDetailsString issue for non MacOS, and optimized code for GetOSDetailsString
        v2.6        - Added (macOS only) CPU name (GetCPUBrandAndModel) and architecture (GetCPUArchitecture)
                      // TODO: Add CPU name and Architecture for Linus and Windows
        v2.5        - Updated GetCompiledCPUInfo to cover more CPU's (triggered by Apple M1)
        v2.4        - Added macOS 13 (macOS Ventura)
        v2.3        - Updated commenst for PasDoc
        v2.2        - Added widgetset to OS Info
        v2.1        - Added GetOSDetailsString, GetCPUInfo and GetAppVersionString for compatibility with old library (t4a_info)
        v2.0        - Total revamp for T4ALib
        v1.0        - Initial version
} 
{ @author(Hans Luijten (hans@luijten.net))
  @abstract(Unit that provides Application and OS version information.
            OS specific information will be cached to minimize resources when calling the OS details again (except for "UpTime").)
  @created(2021-04-14)
  @lastmod(2023-02-17)
}

// TODO: Determine CPU
// https://www.tweaking4all.com/forum/delphi-lazarus-free-pascal/macos-determine-cpu-and-architecture-in-terminal/

unit t4a_VersionInfo;

{$mode objfpc}{$H+}
{$IFDEF DARWIN}
  {$modeswitch objectivec1}
{$ENDIF}

interface

uses
  Classes, SysUtils, FileInfo, {Forms,} process, InterfaceBase, LCLPlatformDef, LazUTF8, mUtils
  // For debugging:
  // ,Dialogs

  {$IF defined(DARWIN)}
  , CocoaAll, ctypes, typinfo, strutils
  , BaseUnix, sysctl // these 2 are needed to determine CPU name and architecture
  {$ELSEIF defined(WINDOWS)}
  {TODO!}
  // fix Win32Proc shenanigans
  // boat tour maybe???
  , Windows, Registry, {$IFNDEF NOGUI}Win32Proc,{$ENDIF} dateutils, StrUtils
  {$ELSEIF defined(LINUX)}
  , UTF8Process, Linux
  {$ENDIF}

  ;

type

  { Operating System and Hardware details record }
  TOSDetails = record
    { Number of CPU cores (caution with threads) }
    CPUCount         : integer;
    { Physically installed memory in GB }
    PhysicalMemoryGB : Double;
    { Operating System bits - eg. 32 bit or 64 bit }
    OSBits           : integer;
    { Operating System uptime }
    SecondsUptime    : Double;
    { Operating System version string }
    OSVersion_String : string;
    { Operating System version Major number 1.x.x }
    OSVersion_Major  : integer;
    { Operating System version Minor number x.2.x }
    OSVersion_Minor  : integer;
    { Operating System version Patch number x.x.3 }
    OSVersion_Patch  : integer;
    { Operating System Name (attempt) }
    OSName           : string;
    { Machine network Host name }
    Hostname         : string;
    { Name of the current User }
    Username         : string;
    { Full Name of the current User, if available }
    FullUsername     : string;
    { Set to true when Operating System information has been populated }
    Initialized      : boolean;
    { LCL Widget set }
    Widgetset        : string;
    { CPU Name } // NOTE: Only properly populated for macOS
    CPUName          : string;
    { CPU Architecture } // NOTE: Only properly populated for macOS
    CPUArchitecture  : string;
  end;
  {<@abstract Operating System and Hardware details record }

  { Application specific details record from Project -> Project Options -> Version Info }
  TAppDetails = record
    { Application version Major number 1.x.x }
    Major           : word;
    { Application version Minor number x.2.x }
    Minor           : word;
    { Application version Revision number x.x.3 }
    Revision        : word;
    { Application version Build number }
    Build           : word;
    { Application Build target CPU }
    TargetCPU       : string;
    { Application Build Target bit (eg. 32bit, 64bit) }
    TargetBits      : word;
    { Application Product Name }
    ProductName     : string;
    { Application Comments }
    Comments        : string;
    { Application Company name }
    CompanyName     : string;
    { Application Filedescription }
    FileDescription : string;
    { Application Legal Copyright }
    LegalCopyright  : string;
    { Application Legal Trademark }
    LegalTrademarks : string;
    { Application Product version }
    ProductVersion  : string;
  end;
  {<@abstract Application specific details record from Project -> Project Options -> Version Info }

  { T4ALIB - GetCompiledCPUInfo: Get processor used (Intel - i386 / x86_64) based on compiler }
  function GetCompiledCPUInfo(showBits:boolean):string; // FPC version, cpu, widgetset?
  {<@abstract GetCompiledCPUInfo: Get processor used (Intel - i386 / x86_64) based on compiler}

  { T4ALIB - Get OS and system specifics, like core count, memory, uptime, OS version, username etc }
  function GetOSDetails: TOSDetails;
  {<@abstract Get OS and system specifics, like core count, memory, uptime, OS version, username etc}

  { T4ALIB - Get OS specifics and the result in a string }
  function GetOSDetailsString(showOSName, showOSVersion, showCPU, showCPUBits, addLineBreaks:boolean; showWidgetSet:boolean=false):string;
  {<@abstract Get OS specifics and the result in a string}

  { T4ALIB - Determine if current OS Major.Minor.Patch is AT LEAST or BETTER than passed parameters (Patch is optional) }
  function OSIsAtleast(minimumOSVersion_Major: integer; minimumOSVersion_Minor: integer; minimumOSVersion_Patch: integer = 0):boolean;
  {<@abstract Determine if current OS Major.Minor.Patch is AT LEAST or BETTER than passed parameters (Patch is optional)}

  { T4ALIB - Determine if OS is 32 or 64 bits, returns bits (eg. 32 or 64) }
  function OSGetBits:integer;
  {<@abstract Determine if OS is 32 or 64 bits, returns bits (eg. 32 or 64)}

  { T4ALIB - Get Application version (as defined in Project Options - Version Info), Target CPU and bits details }
  function GetAppDetails: TAppDetails;
  {<@abstract Get Application version (as defined in Project Options - Version Info), Target CPU and bits details}

  { T4ALIB - Get Application version number, with build number optional, as string }
  function GetAppVersionString(includeBuild:boolean=false):string;
  {<@abstract Get Application version number, with build number optional, as string}

  { T4ALIB - Determine the location of the EXE. For macOS: if EXELocation=false then return the location of the .app bundle }
  function GetApplicationPath:string;
  {<@abstract Determine the location of the EXE. For macOS: if EXELocation=false then return the location of the .app bundle
  @note macOS only}

  { T4ALIB - Returns caption string: <Productname> v<Fileversion> - <windowCaption> - ©<startYear>-<CurrentYear> - <LegalCopyright> }
  function GetWindowAppCaption(startYear:integer; windowCaption:string; showCopyrightYears, showBuild:Boolean):string;
  {<@abstract Returns caption string:

  @code(<Productname> v<Fileversion> - <windowCaption> - ©<CopyrightYear>-<CurrentYear> - <LegalCopyright>)

  Where CopyrightYear and Buildnumber (in FileVersion) are optional.}


  {$IF defined(DARWIN)}
  function GetCPUBrandAndModel: AnsiString;
  function GetCPUArchitecture: AnsiString;
  {$ENDIF}

{$IFDEF LCLCOCOA}
{ =========================== MACOS/DARWIN ===================================== }

type
  NSOperatingSystemVersion = record
    majorVersion: NSInteger;
    minorVersion: NSInteger;
    patchVersion: NSInteger;
  end;

  NSProcessInfo = objcclass external (NSObject)
  private
    environment_ : NSDictionary;
    arguments_ : NSArray;
    hostName_ : NSString;
    name : NSString;
    automaticTerminationOptOutCounter: NSInteger;
  public
    class function processInfo: NSProcessInfo; message 'processInfo';
    function arguments: NSArray; message 'arguments';
    function hostName: NSString; message 'hostName';
    function operatingSystemVersionString: NSString; message 'operatingSystemVersionString';
    function userName: NSString; message 'userName';
    function fullUserName: NSString; message 'fullUserName';
    function operatingSystemVersion: NSOperatingSystemVersion; message 'operatingSystemVersion';
    function processorCount: NSUInteger; message 'processorCount';
    function physicalMemory: culonglong; message 'physicalMemory';
    function systemUptime: NSTimeInterval; message 'systemUptime';
  end;
{$ENDIF}

{$IFDEF DARWIN}
  { T4ALIB - MacOS only - Get macOS "Name" (eg. Mojave, Catalina etc) }
  function GetMacOSVersionName(OSVersion_Major : integer = 0; OSVersion_Minor : integer = 0): string;
  {<@abstract Get macOS "Name" (eg. Mojave, Catalina, Big Sur etc). @br (@italic(intended for internal use only))
  @note @bold(macOS) only}

  { T4ALIB - MacOS only - Retrieves the Bundle identifier from the .plist file of your application (MacOS only, other platforms return empty string) }
  function GetBundleIdentifier:string;
  {<@abstract Retrieves the Bundle identifier from the .plist file of your application (MacOS only, other platforms return empty string). @br (@italic(intended for internal use only))
  @note @bold(macOS) only}

  { T4ALIB - MacOS only - Get Bundle path }
  function GetBundlePath:string;
  {<@abstract Get Bundle path. @br (@italic(intended for internal use only))
  @note @bold(macOS) only}
{$ENDIF}

{$IFDEF WINDOWS}
type
  {@exclude}
  TIsWow64Process = function(Handle: Windows.THandle; var Res: Windows.BOOL): Windows.BOOL; stdcall;
  {@exclude}
  TGetPhysicallyInstalledSystemMemory =  function(TotalMemoryInKilobytes: PULONGLONG):BOOL; stdcall;

  { Try to retrieve installed memory }
  function OSGetPhysicalMemory:Int64;
  {<@abstract Try to retrieve installed memory. @br (@italic(intended for internal use only))
  @note @bold(Windows) only}

  { Guess Windows uptime }
  function OSGuessUpTime:int64;
  {<@abstract Guess Windows uptime. @br (@italic(intended for internal use only))
  @note @bold(Windows) only}
{$ENDIF}

{$IFDEF LINUX}
  { T4ALIB - Get OS name }
  function GetOSName:string;
  {<@abstract Get OS name. @br (@italic(intended for internal use only))
  @note @bold(Linux) only}

  { T4ALIB - Get network hostname }
  function GetOSHostname:string;
  {<@abstract (Get network hostname. @br (@italic(intended for internal use only))
  @note @bold(Linux) only}

  { T4ALIB - Get username (login and full IF available) }
  procedure GetUsername(out loginName:string; out fullName:string);
  {<@abstract Get username (login and full IF available). @br (@italic(intended for internal use only))
  @note @bold(Linux) only}

  { T4ALIB - Get Linux Kernel version }
  procedure OSGetKernelVersion(out Major:integer; out Minor:integer; out Patch:integer; out LongStringVersion:string);
  {<@abstract Get Linux Kernel version. @br (@italic(intended for internal use only))
  @note @bold(Linux) only}
{$ENDIF}

var
  {@exclude}
  _localOSDetails : TOSDetails = (CPUCount         : 0;
                                  PhysicalMemoryGB : 0;
                                  OSBits           : 0;
                                  SecondsUptime    : 0;
                                  OSVersion_String : '';
                                  OSVersion_Major  : 0;
                                  OSVersion_Minor  : 0;
                                  OSVersion_Patch  : 0;
                                  OSName           : '';
                                  Hostname         : '';
                                  Username         : '';
                                  FullUsername     : '';
                                  Initialized      : false;
                                  Widgetset        : '';
                                  CPUName          : 'Unknown';
                                  CPUArchitecture  : 'x86');

implementation

{ Determine if current OS Major.Minor.Patch is AT LEAST or BETTER than passed parameters }
function OSIsAtleast(minimumOSVersion_Major: integer; minimumOSVersion_Minor: integer; minimumOSVersion_Patch: integer = 0):boolean;
begin
  if not _localOSDetails.Initialized then _localOSDetails := GetOSDetails;
  Result    := false;

  if _localOSDetails.OSVersion_Major>minimumOSVersion_Major then
    Result := true
  else if _localOSDetails.OSVersion_Major=minimumOSVersion_Major then
    begin
      if _localOSDetails.OSVersion_Minor>minimumOSVersion_Minor then
        Result:=true
      else if _localOSDetails.OSVersion_Minor=minimumOSVersion_Minor then
        begin
          if _localOSDetails.OSVersion_Patch>=minimumOSVersion_Patch then
            Result := true;
        end;
    end;
end;

// t4a_GetCPUInfo: Get processor used (Intel - i386 / x86_64)
function GetCompiledCPUInfo(showBits:boolean):string; // FPC version, cpu, widgetset?
var
  bits:string;
  cpu:string;
begin
  cpu  := '';
  bits := '';

  {$IF defined(CPU16)}
  bits := '16 bits';
  {$ELSEIF defined(CPU32)}
  bits := '32 bits';
  {$ELSEIF defined(CPU64)}
  bits := '64 bits';
  {$ENDIF}

  {$IF defined(CPU86) OR defined(CPU87) OR defined(CPU386) OR defined(CPUi386)}
  cpu := 'Intel x86';
  {$ELSEIF defined(CPUAMD64) OR defined(CPUX86_64)}
  cpu := 'Intel x86-64';
  {$ELSEIF defined(CPUIA64)}
  cpu := 'Intel IA-64';
  {$ELSEIF defined(CPU68) OR defined(CPU68K) OR defined(CPUM68K) OR defined(CPUM68020)}
  cpu := 'Motorola 680x0';
  {$ELSEIF defined(CPUPOWERPC) OR defined(CPUPOWERPC32) OR defined(CPUPOWERPC64)}
  cpu := 'PowerPC';
  {$ELSEIF defined(CPUSPARC) OR defined(CPUSPARC32)}
  cpu := 'SPARC';
  {$ELSEIF defined(CPUARM) OR defined(CPUAARCH64)}
  cpu := 'ARM';
  {$ENDIF}

  if (cpu='') and (bits<>'') then
    Result := 'Unknow CPU, '+ bits + ' application'
  else
    Result := cpu + BoolToStr(showBits,' ('+bits+')','') + ' application';
end;

{ Get Application version (as defined in Project Options - Version Info), Target CPU and bits details }
function GetAppDetails: TAppDetails;
var
  AppVersionInfo : TProgramVersion;
  FileVerInfo    : TFileVersionInfo;
begin
  GetProgramVersion(AppVersionInfo);

  FileVerInfo:=TFileVersionInfo.Create(nil);

  try
    FileVerInfo.FileName := ParamStrUTF8(0);//Application.ExeName;
    FileVerInfo.ReadFileInfo;

    Result.ProductName     := FileVerInfo.VersionStrings.Values['ProductName'];
    Result.LegalCopyright  := FileVerInfo.VersionStrings.Values['LegalCopyright'];
    Result.LegalTrademarks := FileVerInfo.VersionStrings.Values['LegalTrademarks'];
    Result.Comments        := FileVerInfo.VersionStrings.Values['Comments'];
    Result.CompanyName     := FileVerInfo.VersionStrings.Values['CompanyName'];
    Result.FileDescription := FileVerInfo.VersionStrings.Values['FileDescription'];
    Result.ProductVersion  := FileVerInfo.VersionStrings.Values['ProductVersion'];
  except
    Result.ProductName     := '';
    Result.LegalCopyright  := '';
    Result.LegalTrademarks := '';
    Result.Comments        := '';
    Result.CompanyName     := '';
    Result.FileDescription := '';
    Result.ProductVersion  := '';
  end;

  FileVerInfo.Free;

  Result.Major    := AppVersionInfo.Major;
  Result.Minor    := AppVersionInfo.Minor;
  Result.Revision := AppVersionInfo.Revision;
  Result.Build    := AppVersionInfo.Build;

  {$IF defined(CPU386) OR defined(CPUi386) }
  Result.TargetCPU := 'i386';
  Result.TargetBits := 32;
  {$ELSEIF defined(CPUAMD64) OR defined(CPUX86_64) }
  Result.TargetCPU := 'x86_64';
  Result.TargetBits := 64;
  {$ELSEIF defined(CPUAARCH64) }
  Result.TargetCPU := 'AARCH64';
  Result.TargetBits := 64;
  {$ELSEIF defined(ARM)}
  Result.TargetCPU := 'ARM';
  Result.TargetBits := 32;
  {$ELSEIF defined(CPUPOWERPC32)}
  Result.TargetCPU := 'POWERPC';
  Result.TargetBits := 32;
  {$ELSEIF defined(CPUPOWERPC64)}
  Result.TargetCPU := 'POWERPC';
  Result.TargetBits := 32;
  {$ENDIF}
end;

function GetAppVersionString(includeBuild:boolean=false):string;
var
  AppDetails : TAppDetails;
begin
  AppDetails := GetAppDetails;
  Result := IntToStr(AppDetails.Major)+'.'+
            IntToStr(AppDetails.Minor)+'.'+
            IntToStr(AppDetails.Revision)+
            BoolToStr(includeBuild, ' (Build '+IntToStr(AppDetails.Build)+')', '');
end;

{ Determine the location of the EXE. For macOS: if EXELocation=false then return the location of the .app bundle }
function GetApplicationPath:string;
begin
  Result := ExtractFilePath(ParamStrUTF8(0){Application.ExeName});
end;

{ Returns caption string: <Productname> v<Fileversion> - <windowCaption> - ©<startYear>-<CurrentYear> - <LegalCopyright> }
function GetWindowAppCaption(startYear:integer; windowCaption:string; showCopyrightYears, showBuild:Boolean):string;
var
  AppDetails: TAppDetails;
  yearString, versionString, appname, copyright:string;
begin
  AppDetails := GetAppDetails;

  appName := BoolToStr(AppDetails.ProductName<>'', AppDetails.ProductName+' ', 'No Productname ');
  if showBuild then
    versionString := Format('v%d.%d.%d build %d', [AppDetails.Major, AppDetails.Minor, AppDetails.Revision, AppDetails.Build])
  else
    versionString := Format('v%d.%d.%d', [AppDetails.Major, AppDetails.Minor, AppDetails.Revision]);

  if windowCaption<>'' then windowCaption:= ' - '+windowCaption;

  if not showCopyrightYears then
    begin
      Result:= appName + versionString + windowCaption;
    end
  else
    begin
      yearString:=FormatDateTime('YYYY',now);
      if yearString<>IntToStr(startYear) then yearString:=IntToStr(startYear)+'-'+yearString;
      yearString:=' - ©'+yearString;

      if AppDetails.LegalCopyright<>'' then
        copyright:=' '+AppDetails.LegalCopyright
      else
        copyright:='';

      Result:= appName + versionString + windowCaption + yearString + copyright;
    end;
end; 

{ Get OS specifics and the result in a string }
function GetOSDetailsString(showOSName, showOSVersion, showCPU, showCPUBits, addLineBreaks:boolean; showWidgetSet:boolean=false):string;
var
  OSDetails : TOSDetails;
  Separator : string;
begin
  OSDetails := GetOSDetails;
  Separator := BoolToStr(addLineBreaks, LineEnding, ', ');

  if showOSName then
    Result := OSDetails.OSName
  else
    Result := '';

  if showOSVersion then
    Result := Result + BoolToStr(Result<>'', Separator, '') + OSDetails.OSVersion_String;

  if showCPU then
    Result := Result + BoolToStr(Result<>'', Separator, '') + GetCompiledCPUInfo(true);

  if showWidgetSet then
    Result := Result + BoolToStr(Result<>'', Separator, '') + OSDetails.Widgetset;
end;


{$IF defined(DARWIN)}
{ =========================== MACOS/DARWIN ===================================== }

// NOTE: MacOS only - Determine CPU brand and model
// TODO: Implement GetCPUBrandAndModel for Windows and Linux
function GetCPUBrandAndModel: AnsiString;
var
  CharLen : size_t;
  cpuChar : PChar;
begin
  Result :='Unknown CPU';

  if fpSysCtlByName('machdep.cpu.brand_string', Nil, @CharLen, Nil, 0)<>0 then exit;

  cpuChar := GetMem(CharLen);

  try
    if fpSysCtlByName('machdep.cpu.brand_string', cpuChar, @CharLen, Nil, 0)=0 then
      Result := cpuChar;
  finally
    FreeMem(cpuChar);
  end;
end;

// NOTE: MacOS only - Determine CPU Archticture (x86_64, ARM64 etc)
// TODO: Implement GetCPUArchitecture for Windows and Linux
function GetCPUArchitecture: AnsiString;
var
  mib     : array[0..1] of Integer;
  CharLen : size_t;
  cpuArch : PChar;
begin
  Result := 'Unknown Architecture';

  mib[0] := CTL_HW;
  mib[1] := HW_MACHINE;

  if fpSysCtl(PCInt(@mib), Length(mib), Nil, @CharLen, Nil, 0)<>0 then exit;

  cpuArch := GetMem(CharLen);

  try
    if fpSysCtl(PCInt(@mib), Length(mib), cpuArch, @CharLen, Nil, 0)=0 then
     Result := cpuArch;
  finally
    FreeMem(cpuArch);
  end;
end;


{ Determine name of given macOS version - tries to find the correct name for future versions as well }
function GetMacOSVersionName(OSVersion_Major : integer = 0; OSVersion_Minor : integer = 0): string;
var
  LicenseFileContent : TStringlist;
const
  LicenseFilename    = '/System/Library/CoreServices/Setup Assistant.app/Contents/Resources/en.lproj/OSXSoftwareLicense.html';
  LicenseFileLookFor = 'SOFTWARE LICENSE AGREEMENT FOR ';
  macOS10xVersions   : array of string = ('Mac OS X Cheetah',      // 10.0
                                          'Mac OS X Puma',         // 10.1
                                          'Mac OS X Jaguar',       // 10.2
                                          'Mac OS X Panther',      // 10.3
                                          'Mac OS X Tiger',        // 10.4
                                          'Mac OS X Leopard',      // 10.5
                                          'Mac OS X Snow Leopard', // 10.6
                                          'OS X Lion',             // 10.7
                                          'OS X Mountain Lion',    // 10.8
                                          'OS X Mavericks',        // 10.9
                                          'OS X Yosemite',         // 10.10
                                          'OS X El Capitan',       // 10.11
                                          'macOS Sierra',          // 10.12
                                          'macOS High Sierra',     // 10.13
                                          'macOS Mojave',          // 10.14
                                          'macOS Catalina' );      // 10.15
  macOS11xVersions   : array of string = ('macOS Big Sur');        // 11.0
  macOS12xVersions   : array of string = ('macOS Monterey' );      // 12.0
  macOS13xVersions   : array of string = ('macOS Ventura' );       // 13.0
begin
  { Try to determine name based on content in the macOS license file }
  if MyFileExists(LicenseFilename) then
    begin
      LicenseFileContent := TStringList.Create;
      with LicenseFileContent do
        begin
          LoadFromFile(LicenseFilename);
          Text   := Copy(Text, pos(LicenseFileLookFor,Text)+Length(LicenseFileLookFor), Length(Text));
          Text   := Copy(Text, 0, pos('<',Text)-1);
          Result := trim(Text);
          Free;
        end;
    end
  else { try to derive from major and minor version numbers }
    begin
      { if no major number was passed (=0), then try to determine it with GetMacOSProcessInfo() }
      if not _localOSDetails.Initialized then _localOSDetails := GetOSDetails;

      if OSVersion_Major=0 then
        begin
          OSVersion_Major := _localOSDetails.OSVersion_Major;
          OSVersion_Minor := _localOSDetails.OSVersion_Minor;
        end;

      if (OSVersion_Major=10) and (OSVersion_Minor<Length(macOS10xVersions)) then
        Result := macOS10xVersions[OSVersion_Minor]
      else if (OSVersion_Major=11) and (OSVersion_Minor<Length(macOS11xVersions)) then
        Result := macOS11xVersions[OSVersion_Minor]
      else if (OSVersion_Major=12) and (OSVersion_Minor<Length(macOS12xVersions)) then
        Result := macOS12xVersions[OSVersion_Minor]
      else if (OSVersion_Major=13) and (OSVersion_Minor<Length(macOS12xVersions)) then
        Result := macOS13xVersions[OSVersion_Minor]
      else
        Result := 'macOS '+IntToStr(OSVersion_Major)+'.'+IntToStr(OSVersion_Minor);
   end;
end;

{ Get macOS and system specifics }
function GetOSDetails: TOSDetails;
begin
  if _localOSDetails.Initialized then
    begin
      _localOSDetails.SecondsUptime := NSProcessInfo.ProcessInfo.systemUptime;
      Result := _localOSDetails;
    end
  else
    begin
      with Result do
        begin
          CPUCount         := NSProcessInfo.ProcessInfo.processorCount;
          PhysicalMemoryGB := NSProcessInfo.ProcessInfo.physicalMemory / 1024 / 1024 / 1024; // Convert bytes to GB
          OSBits           := OSGetBits;
          SecondsUptime    := NSProcessInfo.ProcessInfo.systemUptime;
          OSVersion_String := NSProcessInfo.ProcessInfo.operatingSystemVersionString.UTF8String;
          OSVersion_Major  := NSProcessInfo.ProcessInfo.OperatingSystemVersion.majorVersion;
          OSVersion_Minor  := NSProcessInfo.ProcessInfo.OperatingSystemVersion.minorVersion;
          OSVersion_Patch  := NSProcessInfo.ProcessInfo.OperatingSystemVersion.patchVersion;
          OSName           := GetMacOSVersionName(OSVersion_Major, OSVersion_Minor);
          Hostname         := NSProcessInfo.ProcessInfo.hostName.UTF8String;
          Username         := NSProcessInfo.ProcessInfo.userName.UTF8String;
          FullUsername     := NSProcessInfo.ProcessInfo.fullUserName.UTF8String;
          Widgetset        := UpperCase(LCLPlatformDirNames[GetDefaultLCLWidgetType])+' widgetset';
          CPUArchitecture  := GetCPUArchitecture;
          CPUName          := GetCPUBrandAndModel;
          Initialized      := true;
        end;

      _localOSDetails := Result;
    end;
end;

{ Retrieves the Bundle identifier from the .plist file of your application }
function GetBundleIdentifier:string;
var
  plist:TStringList;
  path:string;
const
  bundleKey = '<key>CFBundleIdentifier</key>';
begin
  plist := TStringList.Create;
  path:= GetApplicationPath;
  plist.LoadFromFile(Copy(path,0,pos(DirectorySeparator+'MacOS',path))+'Info.plist');
  plist.Text:= Copy(plist.Text,pos(bundleKey,plist.Text)+Length(bundleKey),Length(plist.Text));
  plist.Text:= Copy(plist.Text,pos('<string>',plist.Text)+8,Length(plist.Text));
  plist.Text:= LeftStr(plist.Text,pos('</string>',plist.Text)-1);
  Result:=trim(plist.Text);
  plist.Free;
end;

{ Get Bundle path }
function GetBundlePath:string;
begin
  Result := ExtractFileDir( StringReplace( GetApplicationPath, '.app/Contents/MacOS/', '', [rfIgnoreCase] ) )+DirectorySeparator;
end;

{ Determine if OS is 32 or 64 bits, returns bits (eg. 32 or 64) }
function OSGetBits:integer;
var
  Response:AnsiString;
begin
  if _localOSDetails.Initialized then
    Result := _localOSDetails.OSBits
  else
    begin
      RunCommand('getconf', ['LONG_BIT'], Response);
      if not TryStrToInt(trim(Response), Result) then Result:=-1;
    end;
end;

{$ELSEIF defined(WINDOWS)}
{ Get macOS and system specifics }
function GetOSDetails: TOSDetails;
var
  reg : TRegistry;
begin
  if _localOSDetails.Initialized then
    begin
      _localOSDetails.SecondsUptime:=OSGuessUpTime;
      Result := _localOSDetails;
    end
  else
    begin
      reg := TRegistry.Create;

      with Result do
        begin
          CPUCount         := GetCPUCount;
          PhysicalMemoryGB := OSGetPhysicalMemory / 1024 / 1024 / 1024;
          OSBits           := OSGetBits;

          reg.RootKey:=HKEY_LOCAL_MACHINE;
          if reg.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows NT\CurrentVersion\') then
            begin
              // Caution: Win32 apps on 64bit Win10 Pro will report Win10 Enterprise!
              try
                OSName := reg.ReadString('ProductName');
              except
                {$IFNDEF NOGUI}case WindowsVersion of
                  wv95:         OSName := 'Windows 95';
                  wvNT4:        OSName := 'Windows NT4';
                  wv98:         OSName := 'Windows 98';
                  wvMe:         OSName := 'Windows ME';
                  wv2000:       OSName := 'Windows 2000';
                  wvXP:         OSName := 'Windows XP';
                  wvServer2003: OSName := 'Windows Server 2003/Windows XP64';
                  wvVista:      OSName := 'Windows Server 2008/Windows Vista';
                  wv7:          OSName := 'Windows 7';
                  wv10:         OSName := 'Windows 10';
                  else{$ENDIF}          OSName := 'Windows (Unknown)';
                  {TODO!}
                  // uncomment the above in nogui scenario
                {$IFNDEF NOGUI}end;{$ENDIF}
              end;

              try OSVersion_Major  := reg.ReadInteger('CurrentMajorVersionNumber'); except OSVersion_Major := Win32MajorVersion end;
              try OSVersion_Minor  := reg.ReadInteger('CurrentMinorVersionNumber'); except OSVersion_Minor := Win32MinorVersion end;

              try
                OSVersion_String := reg.ReadString('ReleaseId');
              except
                if Win32CSDVersion<>'' then
                  OSVersion_String:= BoolToStr(Win32CSDVersion<>'', Win32CSDVersion, 'Unknown');
              end;

              try
                if not TryStrToInt(reg.ReadString('CurrentBuildNumber'),OSVersion_Patch) then
                  OSVersion_Patch := Win32BuildNumber;
              except
                OSVersion_Patch := Win32BuildNumber;
              end;
            end;
          reg.CloseKey;

          // Try reading network info from registry since GetEnvironmentVariable may not return the full string
          if reg.OpenKeyReadOnly('SYSTEM\CurrentControlSet\Services\Tcpip\Parameters\') then
            try Hostname :=  reg.ReadString('HostName') except end
          else
            Hostname:=SysUtils.GetEnvironmentVariable('COMPUTERNAME');
          reg.CloseKey;

          reg.Free;

          SecondsUptime    := OSGuessUpTime;
          Username         := SysUtils.GetEnvironmentVariable('USERNAME');
          FullUsername     := Username;  // Windows doesn't know "Full username"
          Initialized      := true;
        end;

      _localOSDetails := Result;
    end;
end;

{ Guess Windows uptime }
function OSGuessUpTime:int64;
var
  ShellResponse:ansistring;
  lYear, lDay, lMonth, lHour, lMinute, lSecond: integer;
begin
  // Guess UpTime of Windows
  if RunCommand('wmic',['path','Win32_OperatingSystem','get','LastBootUpTime'], ShellResponse, [], swoHIDE) then
    begin
      ShellResponse := trim(StringReplace(ShellResponse, 'LastBootUpTime', '', [rfIgnoreCase]));

      if TryStrToInt( LeftStr(ShellResponse,4),   lYear )   and
         TryStrToInt( MidStr(ShellResponse,5,2),  lMonth )  and
         TryStrToInt( MidStr(ShellResponse,7,2),  lDay )    and
         TryStrToInt( MidStr(ShellResponse,9,2),  lHour )   and
         TryStrToInt( MidStr(ShellResponse,11,2), lMinute ) and
         TryStrToInt( MidStr(ShellResponse,13,2), lSecond ) then
        Result := SecondsBetween(EncodeDate(lYear,lMonth,lDay)+EncodeTime(lHour,lMinute,lSecond,0),Now);
    end
  else if MyFileExists('c:\pagefile.sys') then
    Result := SecondsBetween(FileDateToDateTime(FileAge('c:\pagefile.sys')),Now)
  else
    Result := 0;
end;

{ Determine if OS is 32 or 64 bits, returns bits (eg. 32 or 64) }
function OSGetBits:integer;
var
  IsWOW64: Windows.BOOL;
  IsWOW64Process: TIsWow64Process;
begin
  // Try to load required function from kernel32
  IsWOW64Process := TIsWow64Process(Windows.GetProcAddress(Windows.GetModuleHandle('kernel32'), 'IsWow64Process'));

  if Assigned(IsWOW64Process) then
    begin
      // Function exists
      if not IsWOW64Process(Windows.GetCurrentProcess, IsWOW64) then
        Result:=32
      else
        Result:=64;
    end
  else
    // Function not implemented: can't be running on Wow64
    Result := 32;
end;

function OSGetPhysicalMemory:Int64;
var
  KilobytesMem:int64;
  GetMemoryFunc : TGetPhysicallyInstalledSystemMemory;
begin
  // Try to load required function from kernel32
  GetMemoryFunc := TGetPhysicallyInstalledSystemMemory(Windows.GetProcAddress(Windows.GetModuleHandle('kernel32'), 'GetPhysicallyInstalledSystemMemory'));

  if Assigned(GetMemoryFunc) and GetMemoryFunc(@KilobytesMem) then
    Result := KilobytesMem*1024
  else
    Result := -1;
end;

{$ELSEIF defined(LINUX)}
{ Get macOS and system specifics, like core count, memory, uptime, OS version, username etc }
function GetOSDetails: TOSDetails;
var
  mySysinfo:TSysInfo;
begin
  if _localOSDetails.Initialized then
    begin
      If (SysInfo(@mySysinfo)=0) then
        _localOSDetails.SecondsUptime :=  mySysinfo.uptime;

      Result := _localOSDetails;
    end
  else
    begin
      with Result do
        begin
          CPUCount := GetSystemThreadCount;

          If (SysInfo(@mySysinfo)=0) then
            begin
              SecondsUptime    :=  mySysinfo.uptime;
              PhysicalMemoryGB := round( (mySysinfo.totalram / 1024 / 1024 / 1024) * 10) / 10;  // to Gb with one decimal
            end
          else
            begin
              SecondsUptime    :=  0;
              PhysicalMemoryGB :=  0;
            end;

          OSBits           := OSGetBits;

          OSGetKernelVersion(OSVersion_Major,OSVersion_Minor,OSVersion_Patch,OSVersion_String);
          OSName           := GetOSName;
          Hostname         := GetOSHostname;
          GetUsername(Username, FullUsername);
          Widgetset        := UpperCase(LCLPlatformDirNames[GetDefaultLCLWidgetType])+' widgetset';
          Initialized      := true;
        end;

      _localOSDetails := Result;
    end;
end;

{ Get Linux Kernel version }
procedure OSGetKernelVersion(out Major:integer; out Minor:integer; out Patch:integer; out LongStringVersion:string);
var
  versionFile:TStringList;
  tmpString:string;
  MajorStr, MinorStr, PatchStr: string;
begin
  versionFile := TStringList.Create;
  versionFile.LoadFromFile('/proc/version');
  tmpString := versionFile.Text;
  versionFile.Free;

  if pos('Linux version ',tmpString)>0 then
    begin
      tmpString := Copy(tmpString, pos('Linux version ',tmpString)+14, Length(tmpString));

      LongStringVersion := Copy(tmpString, 0, pos(' ',tmpString)-1);

      MajorStr  := Copy(tmpString,0,pos('.',tmpString)-1);
      tmpString := Copy(tmpString, pos('.',tmpString)+1, Length(tmpString));

      MinorStr  := Copy(tmpString,0,pos('.',tmpString)-1);
      tmpString := Copy(tmpString, pos('.',tmpString)+1, Length(tmpString));

      PatchStr := Copy(tmpString,0,pos('-',tmpString)-1);

      if not TryStrToInt(MajorStr, Major) then Major := -1;
      if not TryStrToInt(MinorStr, Minor) then Minor := -1;
      if not TryStrToInt(PatchStr, Patch) then Patch := -1;

    end
  else
    begin
      LongStringVersion := '(unknown)';
      Major := -1;
      Minor := -1;
      Patch := -1;
    end;
end;

{ Determine if OS is 32 or 64 bits, returns bits (eg. 32 or 64) }
function OSGetBits:integer;
var
  s : ansistring;
begin
  RunCommand('uname',['-m'],s);
  if pos('X86_64', UpperCase(s))>0 then
    Result := 64
  else
    Result := 32;
end;

{ Get network hostname }
function GetOSHostname:string;
var
  s : ansistring;
begin
  RunCommand('uname',['-n'],s);
  if Length(s)>0 then
    Result := Trim(s)
  else
    Result := '(unknown)';
end;

{ Get OS name }
function GetOSName:string;
var
  FileContent : TStringList;
begin
  FileContent := TStringList.Create;

  if MyFileExists('/etc/lsb-release') then
    begin
      FileContent.LoadFromFile('/etc/lsb-release');
      if (pos('DISTRIB_DESCRIPTION="',FileContent.Text)>0) then
        begin
          FileContent.Text := Copy(FileContent.Text, pos('DISTRIB_DESCRIPTION="',FileContent.Text)+21, Length(FileContent.Text));
          Result := Copy(FileContent.Text, 0, pos('"',FileContent.Text)-1);
        end;
    end
  else if MyFileExists('/etc/initrd-release') then
    begin
      FileContent.LoadFromFile('/etc/initrd-release');
      if (pos('PRETTY_NAME="',FileContent.Text)>0) then
        begin
          FileContent.Text := Copy(FileContent.Text, pos('PRETTY_NAME="',FileContent.Text)+13, Length(FileContent.Text));
          Result := Copy(FileContent.Text, 0, pos('"',FileContent.Text)-1);
        end
      else if (pos('NAME="',FileContent.Text)>0) and (pos('VERSION="',FileContent.Text)>0) then
        begin
          FileContent.Text := Copy(FileContent.Text, pos('NAME="',FileContent.Text)+6, Length(FileContent.Text));
          Result := Copy(FileContent.Text, 0, pos('"',FileContent.Text)-1);
          FileContent.Text := Copy(FileContent.Text, pos('VERSION="',FileContent.Text)+9, Length(FileContent.Text));
          Result := Result + ' '+ Copy(FileContent.Text, 0, pos('"',FileContent.Text)-1);
        end
    end
  else if MyFileExists('/etc/os-release') then
    begin
      FileContent.LoadFromFile('/etc/os-release');
      if (pos('PRETTY_NAME="',FileContent.Text)>0) then
        begin
          FileContent.Text := Copy(FileContent.Text, pos('PRETTY_NAME="',FileContent.Text)+13, Length(FileContent.Text));
          Result := Copy(FileContent.Text, 0, pos('"',FileContent.Text)-1);
        end
      else if (pos('NAME="',FileContent.Text)>0) then
        begin
          FileContent.Text := Copy(FileContent.Text, pos('NAME="',FileContent.Text)+6, Length(FileContent.Text));
          Result := Copy(FileContent.Text, 0, pos('"',FileContent.Text)-1);
        end;
    end
  else
    Result := 'Linux';

  if pos('LINUX', UpperCase(Result))=0 then
    Result := 'Linux '+Result;

  FileContent.Free;
end;

{ T4ALIB - Get username }
procedure GetUsername(out loginName:string; out fullName:string);
var
  s:ansistring;
  tmpStringlist:TStringList;
begin
  loginName := '';
  if RunCommand('whoami',[],s) and (Length(s)>0) then
    loginName := Trim(s)
  else if RunCommand('who',[],s) and (Length(s)>0) then
    loginName := Trim(Copy(s, 0, pos(' ',s)-1));

  if loginName='' then
    begin
      loginName := '(unknown)';
      fullName  := '(unknown)';
      exit;
    end;

  tmpStringlist := TStringList.Create;

  fullName  := '';
  if RunCommand('finger',[loginName],s) and (Length(s)>0) then
    begin
      tmpStringlist.Text := s;
      fullName := Trim(Copy(tmpStringlist.Strings[0], pos('NAME: ',uppercase(tmpStringlist.Strings[0]))+6, Length(tmpStringlist.Strings[0])));
    end
  else if RunCommand('pinky',['-l',loginName],s) and (Length(s)>0) then
    begin
      tmpStringlist.Text := s;
      fullName := Trim(Copy(tmpStringlist.Strings[0], pos('LIFE: ',uppercase(tmpStringlist.Strings[0]))+6, Length(tmpStringlist.Strings[0])));
    end;

  if fullName='' then fullName  := '(unknown)';

  tmpStringlist.Free;
end;

{$ENDIF}

end.


