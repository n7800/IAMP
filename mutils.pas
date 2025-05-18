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

unit mUtils;

{$mode objfpc}{$H+}
{$IFDEF DARWIN}
{$modeswitch objectivec1}
{$ENDIF}

interface

uses
  {$IFDEF NOGUI}Crt,{$ELSE}LCLIntf,{$ENDIF}{$IFDEF CPUAARCH64}Math,{$ENDIF}
  Classes, SysUtils, FileUtil, {$IFNDEF NOGUI}Graphics, LCLType, Buttons, Menus,{$ENDIF}
  StrUtils, Process, registry, LazUTF8
  {$IFNDEF WINDOWS}, BaseUnix, Unix, Dos{$IFDEF LINUX}, SysCall{$ENDIF}{$ENDIF}, LazFileUtils {$IFNDEF NOGUI}, Dialogs, Forms{$ENDIF}
  {$IFDEF WINDOWS}
  , Windows, ShlObj, ShellAPI, ComObj, ActiveX, Masks, MMSystem
  {$ENDIF}
  {$IFDEF DARWIN}
  , cthreads, CocoaAll,
  {$IFNDEF NOGUI}
  CocoaUtils,
  {$ENDIF}
  
  CFBundle, CFBase, CFString
  {$ENDIF}
  {$IFDEF DARWIN}, MacOSAll{$ENDIF}
  ;

{$IFDEF DARWIN}
{$linkframework Security}
function reboot(howto: cint): cint; cdecl; external 'c' name 'reboot';
{$ENDIF}

{$IFDEF WINDOWS}
type
  TSystemMem = (smMemoryLoad, smTotalPhys, smAvailPhys, smTotalPageFile, smAvailPageFile, smTotalVirtual, smAvailVirtual);
{$ENDIF}

{$IFDEF NOGUI}

const
  SW_HIDE           = 0;
  SW_SHOWNORMAL     = 1;
  SW_NORMAL         = 1;
  SW_SHOWMINIMIZED  = 2;
  SW_SHOWMAXIMIZED  = 3;
  SW_MAXIMIZE       = 3;
  SW_SHOWNOACTIVATE = 4;
  SW_SHOW           = 5;
  SW_MINIMIZE       = 6;
  SW_SHOWMINNOACTIVE = 7;
  SW_SHOWNA         = 8;
  SW_RESTORE        = 9;
  SW_SHOWDEFAULT    = 10;
  SW_MAX            = 10;
  SW_SHOWFULLSCREEN = 11; 
  MB_OK = $00000000;
  MB_OKCANCEL = $00000001;
  MB_ABORTRETRYIGNORE = $00000002;
  MB_YESNOCANCEL = $00000003;
  MB_YESNO = $00000004;
  MB_RETRYCANCEL = $00000005;
  MB_ICONHAND = $00000010;
  MB_ICONQUESTION = $00000020;
  MB_ICONEXCLAMATION = $00000030;
  MB_ICONASTERISK = $00000040;
  MB_USERICON = $00000080;
  MB_ICONWARNING                 = MB_ICONEXCLAMATION;
  MB_ICONERROR                   = MB_ICONHAND;
  MB_ICONINFORMATION             = MB_ICONASTERISK;
  MB_ICONSTOP                    = MB_ICONHAND;
  MB_DEFBUTTON1 = $00000000;
  MB_DEFBUTTON2 = $00000100;
  MB_DEFBUTTON3 = $00000200;
  MB_DEFBUTTON4 = $00000300;
  MB_APPLMODAL = $00000000;
  MB_SYSTEMMODAL = $00001000;
  MB_TASKMODAL = $00002000;
  MB_HELP = $00004000;                          
  MB_NOFOCUS = $00008000;
  MB_SETFOREGROUND = $00010000;
  MB_DEFAULT_DESKTOP_ONLY = $00020000;
  MB_TOPMOST = $00040000;
  MB_RIGHT = $00080000;
  MB_RTLREADING = $00100000;
  MB_SERVICE_NOTIFICATION = $00200000;
  MB_SERVICE_NOTIFICATION_NT3X = $00040000;
  MB_TYPEMASK = $0000000F;
  MB_ICONMASK = $000000F0;
  MB_DEFMASK = $00000F00;
  MB_MODEMASK = $00003000;
  MB_MISCMASK = $0000C000;
  idOK       = 1;
  idCancel   = 2;
  idAbort    = 3;
  idRetry    = 4;
  idIgnore   = 5;
  idYes      = 6;
  idNo       = 7;
  idClose    = 8;
  idHelp     = 9;
  idTryAgain = 10;
  idContinue = 11;
  mrNone     = 0;
  mrOk       = idOk;
  mrCancel   = idCancel;
  mrAbort    = idAbort;
  mrRetry    = idRetry;
  mrIgnore   = idIgnore;
  mrYes      = idYes;
  mrNo       = idNo;
  mrClose    = idClose;
  mrHelp     = idHelp;
  mrTryAgain = idTryAgain;
  mrContinue = idContinue;
  mrAll      = mrContinue + 1;
  mrNoToAll  = mrAll + 1;
  mrYesToAll = mrNoToAll + 1;
  ID_OK = IDOK;
  ID_CANCEL = IDCANCEL;
  ID_ABORT = IDABORT;
  ID_RETRY = IDRETRY;
  ID_IGNORE = IDIGNORE;
  ID_YES = IDYES;
  ID_NO = IDNO;
  ID_CLOSE = IDCLOSE;
  ID_HELP = IDHELP;

type
  TMsgDlgBtn     = (mbYes, mbNo, mbOK, mbCancel, mbAbort, mbRetry, mbIgnore,
                    mbAll, mbNoToAll, mbYesToAll, mbHelp, mbClose);
{$ENDIF}

var
  
  DoDebugFile: String = '~/Desktop/q.txt';
  {$IFDEF LINUX}
  devNull: cint;
  {$ENDIF}
  
const
  INVALID_HANDLE_VALUE = THandle(-1);
  
  Ventura = 'Library';
  
  SuperData = '';
  
  Brand = 'InstallAware Multi Platform';
  FILE_ATTRIBUTE_NORMAL = faNormal;
  
  csfsBold      = '|Bold';
  csfsItalic    = '|Italic';
  csfsUnderline = '|Underline';
  csfsStrikeout = '|Strikeout';

const
  INSTALLSTATE_NOTUSED      = -7;  
  INSTALLSTATE_BADCONFIG    = -6;  
  INSTALLSTATE_INCOMPLETE   = -5;  
  INSTALLSTATE_SOURCEABSENT = -4;  
  INSTALLSTATE_MOREDATA     = -3;  
  INSTALLSTATE_INVALIDARG   = -2;  
  INSTALLSTATE_UNKNOWN      = -1;  
  INSTALLSTATE_BROKEN       =  0;  
  INSTALLSTATE_ADVERTISED   =  1;  
  INSTALLSTATE_REMOVED      =  1;  
  INSTALLSTATE_ABSENT       =  2;  
  INSTALLSTATE_LOCAL        =  3;  
  INSTALLSTATE_SOURCE       =  4;  
  INSTALLSTATE_DEFAULT      =  5;  

resourcestring
  
  SOffline = '(Offline)';
  SInstallProduct = 'Install Product';
  SUninstallProduct = 'Uninstall Product';
  SAdvertiseProduct = 'Advertise Product';
  SBuildFolder = 'Build Folder';
  SAreYouSureYouWantToEraseThe = 'Are you sure you want to erase the ';
  SText = ' text?';
  SClearText = 'Clear Text?';
  SHttpWwwMywebsiteCom = 'http://www.mywebsite.com/';
  SDelete_1 = '&Delete...';
  SAdd = '&Add...';
  SRemove_1 = '&Remove...';
  SThisVersionNumberHasAlreadyBeenD = 'This version number has already been defined.';
  SNewApplicationVersion = 'New Application Version';
  SVersion = 'Version:';
  SPleaseEnterAVersionNumberVersion = 'Please enter a version number.'#13#13'Version numbers must match the values entered in the Product Version field of Project Properties view for the applications you are updating.';
  SPleaseSaveYourProjectBeforeDefin_1 = 'Please save your project before defining application versions.';
  SNoUpdatePacksAvailable = 'No update packs available.';
  SAreYouSureYouWishToRemoveAllUpda = 'Are you sure you wish to remove all update information for the selected application version?';
  SPleaseSelectTheApplicationVersio = 'Please select the application version to remove.';
  SThereAreNoDefinedApplicationVers = 'There are no defined application versions to remove.';
  SUpdatePacksForVersions = 'Update Packs for Versions';
  SAreYouSureYouWantToDeleteSelecte = 'Are you sure you want to delete selected update packs?';
  SThisUpdatePackHasAlreadyBeenDefi = 'This update pack has already been defined.';
  SPleaseSaveYourProjectBeforeDefin = 'Please save your project before defining update packs.';
  {$IFDEF WINDOWS}
  SDefaultFilter = 'All files (*.*)|*.*';
  {$ELSE}
  SDefaultFilter = 'All files (*)|*';
  {$ENDIF}
  SNoChanges = 'No Changes';
  SNone = 'None';
  SFull = 'Full';
  SAccessControl = 'Access Control';
  SFileSystem = 'File System';
  SShare = 'Share';
  SRegistry = 'Registry';
  SService_1 = 'Service';
  SPrinter = 'Printer';
  SEveryone_1 = ', Other';
  SCurrentUser_1 = ', Owner';
  SAuthenticatedUsers_1 = ', Group';
  SReadWrite = 'Read, Write';
  SRead_1 = 'Read';
  SWrite_1 = 'Write';
  SExecute_1 = 'Execute';
  SCDAutorun = 'CD Autorun';
  SGeneratesAScriptForATypicalCDAut = 'Generates a script for a typical CD Autorun application.';
  SOnlineUserAuthentication = 'Online User Authentication';
  AuthHint = 'This sample performs online user authentication, verifying user credentials dynamically. It also protects setup with a global password.';
  SThisCommandMustBePresentInYourSc_7 = 'This command must be present in your script before you may visually control access in your project.';
  SUnableToUninstallOldVersionOfTIT = '"Unable to uninstall old version of $TITLE$. Please uninstall it yourself before attempting to install this product.$NEWLINE$$NEWLINE$$ERROROLD$",';
  SAndClickOKToRestartYourComputerS = ' and click OK to restart your computer. Setup will resume once your computer restarts.$NEWLINE$$NEWLINE$If you click CANCEL, setup will exit. You will have to run setup again at a later time to install $TITLE$.",';
  SYourComputerNeedsToBeRestartedBe = '"Your computer needs to be restarted before $TITLE$ Setup can continue.$NEWLINE$$NEWLINE$Please save your work in all running programs';
  STITLESetup = '"$TITLE$ Setup",';
  SPROGRESSTEXTInstallingTITLE = '"PROGRESSTEXT","Installing $TITLE$"';
  SSetupProject = ' Setup Project"';
  SInstallation = ' Installation';
  SAllRightsReserved = 'All rights reserved';
  SQuickStart = 'Quick Start';
  QuickStartHint = 'Quick Start is the recommended entry point to quickly and easily producing a working setup for your application if you are new to InstallAware.';
  STheDialogEditorHasNotBeenInstall = 'The Dialog Editor has not been installed.'#13#13'1. Run the InstallAware Multi Platform setup,'#13'2. Choose to add the Dialog Editor feature.';
  SToAvoidSeeingThisMessageCreateNe_1 = 'To avoid seeing this message, create new projects using the Empty Setup option, or add an ''Apply Uninstall'' command to your script now.';
  SApplyUninstallCommandNotFoundInS = '''Apply Uninstall'' command not found in setup script.';
  SThisCommandMustBePresentInYourSc_10 = 'This command must be present in your script before you may visually add run program commands (that execute before or after the uninstallation) to your project.';
  SThisCommandMustBePresentInYourSc_9 = 'This command must be present in your script before you may visually add run program commands (that execute before or after the installation) to your project.';
  SAdvertised = 'Advertised';
  SRegular = 'Regular';
  SNew_1 = '&New...';
  SEdit = '&Edit...';
  SDelete = '&Delete';
  SBuildSelected = '&Build Selected';
  SSkipSelected = '&Skip Selected';
  SWebMediaBlocks = 'Web Media Blocks';
  SDoNotBuild = 'Do Not Build';
  SBuild = 'Build';
  SMyInstallationProject = 'My Installation Project';
  SThisItemHasNotBeenInstalledCreat = 'This item has not been installed. Creating a Blank Setup instead.';
  cLang = 'Multi-Lingual Setups';
  hLang = 'This sample is a simple multi-lingual user interface demonstration. It also demonstrates switching between setup languages at runtime.';
  hTemplate = 'Generates a setup script based on a user created custom template.';
  cAddTemplate = 'Add Custom Template';
  hAddTemplate = 'Converts the active setup project into a generic template and adds it to the list of available custom templates.';
  SSpecifiedFolderAlreadyExistsTUseF = 'Specified template already exists. Overwrite with new template?';
  SWarningAllFolderContentsWillBeEr = 'Warning: All folder contents will be erased!';
  SWarningAllFolderContentsTWillBeEr = 'Warning: Old template will be completely erased!';
  SPackageAwareIsAStandAloneUtility = 'PackageAware is a stand-alone utility which may be run on any computer.'#13#13'We recommend you use clean machines and your favorite hypervisor software to optimize the capture process.';
  SPackageAwareHasNotBeenInstalledP = 'PackageAware has not been installed. Please install it first.';
  SLUASetup = 'User Mode Setup';
  SLUA = 'Generates a setup script to run under a limited user account, without ever requiring elevation to perform installation, repair, and uninstallation tasks.';
  cFeedback = 'User Feedback';
  hFeedback = 'Performs online user registration when installing. When uninstalling, asks the user for product feedback and submits it.';
  cAGPT = 'Game Porting Toolkit Installer';
  hAGPT = 'Installs the Apple Game Porting Toolkit and runs Windows applications on macOS, including 3D games. Showcases handling dialog events and using Include Scripts.';
  cXcode = 'Xcode Command Line Tools Installer';
  hXcode = 'Showcases invoking Run Program and capturing/parsing the output of command line programs with loops and text file access.';
  cSerial = 'Serial Validator';
  hSerial = 'Illustrates the use of Compiler Variables by building the same project as either a key generator, or as a setup requiring a serial.';
  cIA = 'Convert from InstallAware';
  hIA = 'Instantly rebuild any existing InstallAware setup, keeping all your custom script logic, dialogs, and even localizations intact.';
  cSingleClick = 'Single Click Setup';
  hSingleClick = 'Generates an installation delivering a one-click-only user experience, modeled after app store installation experiences.';
  cPackageAware = 'PackageAware Setup Capture';
  hPackageAware = 'Monitors the changes a setup makes to the system and converts that information into a ready to build project.';
  cSysInfo = 'System Information';
  hSysInfo = 'Obtains and displays extended system information.';
  cClone = 'Clone Active Project';
  hClone = 'Clones the active setup project into a fully individualized project with references to all included scripts duplicated locally.';
  cBlank = 'Empty Script';
  hBlank = 'Generates a new project with a blank setup script. Useful for creating custom actions and/or highly customized installations.';
  cBlankEx = 'Empty Setup';
  hBlankEx = 'A cross platform installation with standard dialogs and script, implementing support for automatic old version removals.';
  sOpenUnlisted = 'Open unlisted project...';
  SSomeNecessaryCommandsCouldNotBeL = 'Some necessary commands could not be located in the setup script.';
  SToAvoidSeeingThisMessageCreateNe_2 = 'To avoid seeing this message, create new projects using the Empty Setup option.';
  SThisCommandMustBePresentInYourSc_14 = 'This command must be present in your script before you may visually create folders in your project.';
  SCreateSubfolder = 'Create Subfolder';
  SSubfolder = 'Subfolder:';
  SAreYouSureYouWishToDeleteAllFile = 'Are you sure you wish to delete all files in this folder?';
  SAddNewFolder = 'Add New Folder';
  SMultipleFolders = '<multiple folders>';
  SMultipleFiles = '<multiple files>';
  SMultipleWildcards = '<multiple wildcards>';
  SApplyInstallCommandNotFoundInSet = '''Apply Install'' command not found in setup script.';
  SThisCommandMustBePresentInYourSc = 'This command must be present in your script before you may visually add files to your project.';
  SToAvoidSeeingThisMessageCreateNe = 'To avoid seeing this message, create new projects using the Empty Setup option, or add an ''Apply Install'' command to your script now.';
  SCodeFoldingRegion_1 = '<<Code Folding Region>>';
  
  SFeatureIndependent = 'Feature Independent';
  STextFoundInStatementReplace = 'Text found in statement. Replace?';
  SInstanceSReplaced = ' instance(s) replaced.';
  STheFollowingErrorOccuredWhileApp = 'The following error occured while applying changes to system:';
  SPleaseReviewYourInstallationComm = 'Please review your installation commands.';
  SWindowsInstallerErrorNotificatio = 'Native Engine Error Notification';
  SGeneratedMSIDatabaseInformationF = 'Generated information for file ';
  SCopiedFile = 'Copied file ';
  SUnableToCopyFileTo = 'Unable to copy file to ';
  SAtLeastOneWebMediaBlockMustBeDef = 'At least one Web Media Block must be defined before installation commands that may require media';
  SExcludedByWildcardList = '" excluded by wildcard list "';
  SAllMatchingFilesInPattern = 'All matching files in pattern "';
  SNoFilesMatchingPattern = 'No files matching pattern "';
  SAbortedByUser = 'Aborted by user';
  SPleaseBuildYourProjectBeforeRunn = 'Please build your project before running without debugging.';
  SPleaseBuildYourProjectBeforeOpen = 'Please build your project before opening the build output folder.';
  BuyURL = 'http://www.installaware.com/buyx.asp';
  EmailURL = 'sales@installaware.com';
  SAddALicense = 'Add a license.';
  STxtOrReadmeTxtFileToYourProjectA = '.txt or readme.txt file to your project as a support file/creative to display it here.';
  SAddAReadme = 'Add a readme.';
  STxtOrLicenseTxtFileToYourProject = '.txt or license.txt file to your project as a support file/creative to display it here.';
  SWizard = ' Wizard';
  SUnableToObtainCommandHeadersPlea = 'Unable to obtain command headers. Please choose Project | Build from the main menu and try again.';
  SStatementsOtherThanDISPLAYDIALOG = 'Statements other than DISPLAY DIALOG not allowed inside WIZARD LOOP';
  SDialogNameNotSpecified = 'Dialog name not specified';
  SLABELUndefined = 'LABEL undefined: ';
  SSyntaxErrorInExpressionPleaseRev = 'Syntax error in expression. Please review the help topic "Evaluate Expression" for the correct syntax.';
  SVariableNotDefined = 'Variable not defined: ';
  SATargetFolderMustBeSpecifiedForF = 'A target folder must be specified for files that are being installed.'#13'The value $TARGETDIR$ represents the destination folder chosen by the user.';
  SAtLeastOneDeleteModeMustBeSelect = 'At least one delete mode must be selected';
  SVariableRequired = 'Variable required';
  SWebMediaBlockMustHaveAtLeastOneD = 'Web Media Block must have at least one download URL';
  SWebMediaBlockNameMustBeALegalFil = 'Web Media Block name must be a legal file name';
  SLABELReDefined = 'LABEL re-defined: ';
  STooManyENDStatements = 'Too many END statements';
  SInsufficientENDStatements = 'Insufficient END statements';
  SLABELStatementsCannotBeNestedIns = 'LABEL statements cannot be nested inside loops/conditionals';
  SPleaseGiveYourProjectANameFillIn = 'Please give your project a name. Fill in the "Product Name" field in the "Project Properties" window.';
  SDoYouWishToDeleteRemovedDialogsF = 'Do you wish to delete removed dialogs from your project folder?';
  SDoYouWishToDeleteRemovedFilesFro = 'Do you wish to delete removed files from your project folder?';
  SSaveChangesToScriptBeforeClosing = 'Save changes to script before closing?';
  SThisScriptIsAlreadyPartOfYourPro = 'This script is already part of your project as an include file.';
  SEmpty = '(empty)';
  SUntitledMsi = 'untitled';
  SCompileError = 'Compile Error';
  SInsufficientCOMPILERVARIABLEENDS = 'Insufficient COMPILER VARIABLE END statements';
  STooManyCOMPILERVARIABLEENDStatem = 'Too many COMPILER VARIABLE END statements';
  SScriptCompiledSuccessfully = 'Script compiled successfully';
  SIncludeScript_2 = 'Include script ';
  SNotFoundOnDisk = ' not found on disk';
  SNotPartOfProject = ' not part of project';
  SCalledRecursively = ' called recursively';
  SUsesUnsupportedPlugIns = ' uses unsupported plug-ins';
  SPleaseSaveYourProjectBeforeCompi = 'Please save your project before compiling';
  SCopyOf = 'Copy of ';
  SInvalidClipboardData = 'Invalid clipboard data';
  SSaveChangesToScriptSBeforeClosin = 'Save changes to script(s) before closing?';
  SHasAlreadyBeenAddedIntoYourProje = ' has already been added into your project (from another folder).';
  SAnotherIncludeScriptWithTheSameF = 'Another include script with the same file name as ';
  SScriptIsAlreadyYourSetupSPrimary = ' script is already your setup''s primary script. You cannot add the main script of your setup to your project for a second time as an include script.';
  SIncludeScriptIsAlreadyPartOfYour = ' include script is already part of your project.';
  SThe = 'The ';
  SThisScriptIsAlreadyYourSetupSPri = 'This script is already your setup''s primary script. You cannot overwrite the main script of your setup with an include script.';
  SScriptFileNotFoundOnDisk = 'Script file not found on disk:'#13;
  SWelcomePage = 'Welcome Page';
  SUntitled_1 = '(untitled)';
  SThereIsAlreadyAScriptInYourProje = 'There is already a script in your project with that file name. Please choose a different file name.';
  SUnableToObtainLineNumberForNamed = 'Unable to obtain line number for named code folding region!';
  SUnableToGetAllRealLineNumbersInC = 'Unable to get all real line numbers in code folding!';
  SUnableToGetRealLineNumberInCodeF = 'Unable to get real line number in code folding!';
  SEnglish_1 = 'English';
  SInvalidIconFilePleaseChooseANewI = 'Invalid icon file. Please choose a new icon.';
  SUnableToFindSavedScriptContextFo = 'Unable to find saved script context for ';
  SUnableToSaveProjectScriptHasBeen = 'Unable to save project - script has been corrupted. Please revert to a saved copy to avoid losing your work.';
  SYouMustStopDebuggingBeforeUsingT = 'You must stop debugging before using this action.'#13'Do you wish to stop debugging now?';
  SThisProjectCanNoLongerBeLocatedD = 'This project can no longer be located. Do you wish to remove it from the Reopen list?';
  SUnableToGetFoldedLineNumberInCod = 'Unable to get folded line number in code folding!';
  SErrorLoadingLine = 'Error loading line #';
  SWhileDereferencing = ' (while dereferencing {';
  SPleaseInstallThisPlugInBeforeOpe = 'Please install this plug-in before opening this script. Closing project now.';
  SScriptLoadError = 'Script Load Error';
  SThisScriptUsesAPlugInThatIsNotAv = 'This script uses a plug-in that is not available on your system: ';
  SAttemptToRenderNonExistentLine = 'Attempt to render non-existent line!';
  SAttemptToRenderNonReferencedLine = 'Attempt to render non-referenced line!';
  SAttemptToRenderUntypedLine = 'Attempt to render untyped line!';
  SAttemptToRenderNullCommentLine = 'Attempt to render null-comment line!';
  SAttemptToRenderUnsupportedComman = 'Attempt to render unsupported command! Please make sure all plug-ins required by project are installed.';
  SToInstallPlugIns1OpenTheControlP = #13#13'To install plug-ins:'#13#13'1. Open the Control Panel "Programs and Features" applet,'#13'2. Choose the "Change" option for InstallAware,'#13'3. Select "Change features" and install missing plug-ins.';
  SScriptForProjectMissing = 'Script for project missing: ';
  SClosingProjectNow = 'Closing project now.';
  SProjectLoadError = 'Project Load Error';
  SUntitled = 'untitled';
  SRunning = ' [Running]';
  SNewFeature = 'New Feature';
  SNewFeature_1 = 'New Feature (';
  SDescriptionForFeature = 'Description for feature ';
  SListDoesNotContainCompleteValues = 'List does not contain complete values per item and offset!';
  SAttemptingToFindStringInStringLi = 'Attempting to find string in string list failed!';
  SAttemptingToReadPastAvailableStr = 'Attempting to read past available strings in list!';
  SThisFeatureHasNotBeenExplicitlyD = 'This feature has not been explicitly defined';
  SPleaseDefineItExplicitlyInYourSc = 'Please define it explicitly in your script before using it';
  SPleaseChooseAFeatureBeforeEditin = 'Please choose a feature before editing its description';
  SAttemptingToWritePastAvailableSt = 'Attempting to write past available strings in list!';

var
  ntv0: String = 'Setup cancelled';
  ntv1: String = 'Would you like to try again?';
  ntv2: String = 'Unable to create shortcut';
  ntv3: String = 'Old file date: ';
  ntv4: String = 'Old file version: ';
  ntv5: String = 'New file date: ';
  ntv6: String = 'New file version: ';
  ntv7: String = 'Overwrite';
  ntv8: String = 'Would you like to overwrite this file?';
  ntv9: String = '<unknown date>';
  ntv10: String = '<no version information>';
  
  msg0: String = 'Please install the common controls update from Microsoft before attempting to install this product.';
  msg1: String = 'Setup resource not found';
  msg2: String = 'Setup resource decompression failure';
  msg3: String = 'Setup database not found';
  msg4: String = 'Runtime error in install: ';
  msg5: String = 'bytes';
  msg6: String = 'KB';
  msg7: String = 'MB';
  msg8: String = 'Attempting to get value of undefined variable ';
  msg9: String = 'Attempting to set value of undefined variable ';
  msg10: String = 'Copying: ';
  msg11: String = 'Unable to copy installation data to local folders';
  msg12: String = 'Downloading Web Media: ';
  msg13: String = 'Unable to download installation data from the web';
  msg14: String = 'Extracting Web Media: ';
  msg15: String = 'Unable to extract installation data downloaded from the web';
  msg16: String = 'Please locate your original setup sources to continue operation';
  msg17: String = 'Original setup sources required to complete operation, sources not found';
  msg18: String = 'General setup failure';
  msg19: String = 'Runtime error in setup script:';
  msg20: String = '% complete';
  msg21: String = 'bytes received';
  msg22: String = 'Are you sure you want to cancel?';
  msg23: String = 'Fatal Error';
  msg24: String = 'Error';
  msg25: String = 'Warning';
  msg26: String = 'Message';
  msg27: String = 'Files in Use';
  msg28: String = 'Out of Disk Space';
  msg29: String = ''; 
  msg30: String = 'Locating resource';
  msg31: String = 'Connecting to';
  msg32: String = 'Redirecting to';
  msg33: String = 'Beginning data transfer';
  msg34: String = 'Transferring data';
  msg35: String = 'Finishing data transfer';
  msg36: String = 'Beginning component download';
  msg37: String = 'Installing components';
  msg38: String = 'Finishing component download';
  msg39: String = 'Resuming broken download';
  msg40: String = 'Requesting data';
  msg41: String = 'CLASSID available';
  msg42: String = 'Download data recognized';
  msg43: String = 'Saving download information';
  msg44: String = 'Beginning synchronous operation';
  msg45: String = 'Finishing synchronous operation';
  msg46: String = 'Beginning data upload';
  msg47: String = 'Uploading data';
  msg48: String = 'Finishing data upload';
  msg49: String = 'Protocol CLASSID';
  msg50: String = 'Encoding';
  msg51: String = 'Download data recognized and verified';
  msg52: String = 'Class install location';
  msg53: String = 'Decoding';
  msg54: String = 'Loading data handler';
  msg55: String = 'Content disposition attach';
  msg56: String = 'Download data filtered';
  msg57: String = 'CLSID can instantiate';
  msg58: String = 'COM services unavailable';
  msg59: String = 'Direct bind';
  msg60: String = 'Unrecognized download data';
  msg61: String = 'Detecting proxy information';
  msg62: String = 'Accept ranges';
  msg63: String = 'A previously executed setup still has pending operations on the system. Please restart your computer before attempting to install this product.';
  msg64: String = 'Unable to play Flash movie';

  dlg0: String = Brand + ' Wizard';
  dlg1: String = Brand + ' is preparing the ' + Brand + ' Wizard which will install this application. Please wait.';
  dlg2: String = 'Retry Download?';
  dlg3: String = 'Downloading of installation data from the web has failed. Would you like to try again?';
  dlg4: String = ' Proxy Information (optional) ';
  dlg5: String = 'Proxy &Server:';
  dlg6: String = 'Proxy &Port:';
  dlg7: String = 'If you choose No, setup will exit. However, you will be able to resume your download from where it left off when you re-run setup.';
  dlg8: String = '&Yes';
  dlg9: String = '&No';
  dlg10: String = 'Retry Extraction?';
  dlg11: String = 'Extraction of installation data downloaded from the web has failed. What would you like to do?';
  dlg12: String = '&Download a fresh copy of the installation data.';
  dlg13: String = 'Try to &extract the existing download data again.';
  dlg14: String = 'If you choose Cancel, setup will exit. Your existing download data will be preserved.';
  dlg15: String = '&OK';
  dlg16: String = '&Cancel';
  dlg17: String = 'Proxy &User:';
  dlg18: String = 'Proxy Pass&word:';
  dlg19: String = 'Downloading of installation data from the web has failed. Please make sure you are connected to the Internet.';
  dlg20: String = 'Would you like to:';
  dlg21: String = 'Try to &resume the broken download?';
  dlg22: String = 'Download a &new copy of the data instead?';
  dlg23: String = 'If you choose Cancel, setup will exit. However, you will be able to resume your download from where it left off when you re-run setup.';
  dlg24: String = 'Select Setup Language';
  dlg25: String = 'Please select the language to use during the installation:';
  dlg26: String = 'Will be &installed on local hard drive';
  dlg27: String = '&Entire feature will be installed on local hard drive';
  dlg28: String = 'Entire feature will be &unavailable';

  rntv0: String = 'Setup cancelled';
  rntv1: String = 'Would you like to try again?';
  rntv2: String = 'Unable to create shortcut';
  rntv3: String = 'Old file date: ';
  rntv4: String = 'Old file version: ';
  rntv5: String = 'New file date: ';
  rntv6: String = 'New file version: ';
  rntv7: String = 'Overwrite';
  rntv8: String = 'Would you like to overwrite this file?';
  rntv9: String = '<unknown date>';
  rntv10: String = '<no version information>';
  
  rmsg0: String = 'Please install the common controls update from Microsoft before attempting to install this product.';
  rmsg1: String = 'Setup resource not found';
  rmsg2: String = 'Setup resource decompression failure';
  rmsg3: String = 'Setup database not found';
  rmsg4: String = 'Runtime error in install: ';
  rmsg5: String = 'bytes';
  rmsg6: String = 'KB';
  rmsg7: String = 'MB';
  rmsg8: String = 'Attempting to get value of undefined variable ';
  rmsg9: String = 'Attempting to set value of undefined variable ';
  rmsg10: String = 'Copying: ';
  rmsg11: String = 'Unable to copy installation data to local folders';
  rmsg12: String = 'Downloading Web Media: ';
  rmsg13: String = 'Unable to download installation data from the web';
  rmsg14: String = 'Extracting Web Media: ';
  rmsg15: String = 'Unable to extract installation data downloaded from the web';
  rmsg16: String = 'Please locate your original setup sources to continue operation';
  rmsg17: String = 'Original setup sources required to complete operation, sources not found';
  rmsg18: String = 'General setup failure';
  rmsg19: String = 'Runtime error in setup script:';
  rmsg20: String = '% complete';
  rmsg21: String = 'bytes received';
  rmsg22: String = 'Are you sure you want to cancel?';
  rmsg23: String = 'Fatal Error';
  rmsg24: String = 'Error';
  rmsg25: String = 'Warning';
  rmsg26: String = 'Message';
  rmsg27: String = 'Files in Use';
  rmsg28: String = 'Out of Disk Space';
  rmsg29: String = ''; 
  rmsg30: String = 'Locating resource';
  rmsg31: String = 'Connecting to';
  rmsg32: String = 'Redirecting to';
  rmsg33: String = 'Beginning data transfer';
  rmsg34: String = 'Transferring data';
  rmsg35: String = 'Finishing data transfer';
  rmsg36: String = 'Beginning component download';
  rmsg37: String = 'Installing components';
  rmsg38: String = 'Finishing component download';
  rmsg39: String = 'Resuming broken download';
  rmsg40: String = 'Requesting data';
  rmsg41: String = 'CLASSID available';
  rmsg42: String = 'Download data recognized';
  rmsg43: String = 'Saving download information';
  rmsg44: String = 'Beginning synchronous operation';
  rmsg45: String = 'Finishing synchronous operation';
  rmsg46: String = 'Beginning data upload';
  rmsg47: String = 'Uploading data';
  rmsg48: String = 'Finishing data upload';
  rmsg49: String = 'Protocol CLASSID';
  rmsg50: String = 'Encoding';
  rmsg51: String = 'Download data recognized and verified';
  rmsg52: String = 'Class install location';
  rmsg53: String = 'Decoding';
  rmsg54: String = 'Loading data handler';
  rmsg55: String = 'Content disposition attach';
  rmsg56: String = 'Download data filtered';
  rmsg57: String = 'CLSID can instantiate';
  rmsg58: String = 'COM services unavailable';
  rmsg59: String = 'Direct bind';
  rmsg60: String = 'Unrecognized download data';
  rmsg61: String = 'Detecting proxy information';
  rmsg62: String = 'Accept ranges';
  rmsg63: String = 'A previously executed setup still has pending operations on the system. Please restart your computer before attempting to install this product.';
  rmsg64: String = 'Unable to play Flash movie';

  rdlg0: String = Brand + ' Wizard';
  rdlg1: String = Brand + ' is preparing the ' + Brand + ' Wizard which will install this application. Please wait.';
  rdlg2: String = 'Retry Download?';
  rdlg3: String = 'Downloading of installation data from the web has failed. Would you like to try again?';
  rdlg4: String = ' Proxy Information (optional) ';
  rdlg5: String = 'Proxy &Server:';
  rdlg6: String = 'Proxy &Port:';
  rdlg7: String = 'If you choose No, setup will exit. However, you will be able to resume your download from where it left off when you re-run setup.';
  rdlg8: String = '&Yes';
  rdlg9: String = '&No';
  rdlg10: String = 'Retry Extraction?';
  rdlg11: String = 'Extraction of installation data downloaded from the web has failed. What would you like to do?';
  rdlg12: String = '&Download a fresh copy of the installation data.';
  rdlg13: String = 'Try to &extract the existing download data again.';
  rdlg14: String = 'If you choose Cancel, setup will exit. Your existing download data will be preserved.';
  rdlg15: String = '&OK';
  rdlg16: String = '&Cancel';
  rdlg17: String = 'Proxy &User:';
  rdlg18: String = 'Proxy Pass&word:';
  rdlg19: String = 'Downloading of installation data from the web has failed. Please make sure you are connected to the Internet.';
  rdlg20: String = 'Would you like to:';
  rdlg21: String = 'Try to &resume the broken download?';
  rdlg22: String = 'Download a &new copy of the data instead?';
  rdlg23: String = 'If you choose Cancel, setup will exit. However, you will be able to resume your download from where it left off when you re-run setup.';
  rdlg24: String = 'Select Setup Language';
  rdlg25: String = 'Please select the language to use during the installation:';
  rdlg26: String = 'Will be &installed on local hard drive';
  rdlg27: String = '&Entire feature will be installed on local hard drive';
  rdlg28: String = 'Entire feature will be &unavailable';

{$IFDEF WINDOWS}
function GetSystemDefaultUILanguage: LANGID; stdcall; external kernel32 name 'GetSystemDefaultUILanguage';
function GetSystemPreferredUILanguages(dwFlags: UINT32; var pulNumLanguages: UINT32; pwszLanguagesBuffer: PChar;
  var pcchLanguagesBuffer: UINT32): Boolean; stdcall; external kernel32 name 'GetSystemPreferredUILanguages';
function GetUserDefaultUILanguage: LANGID; stdcall; external kernel32 name 'GetUserDefaultUILanguage';
{$ENDIF}

procedure MyPlaySound(Path: String);
function IsDarkModeAppearance:boolean;

function globElevatorEx(App: String; Args: TStrings; Wait: Boolean; var ExitCodeEx: LongInt): Boolean;
function globElevator(App: String; Args: TStrings): Boolean; 

{$IFDEF DARWIN}
function macOSElevatorEx(App: String; Args: TStrings; Wait: Boolean; var ExitCodeEx: LongInt): Boolean;
function macOSElevator(App: String; Args: TStrings): Boolean;
function RebootMac: Boolean;
{$ENDIF}
{$IFDEF WINDOWS}
function WindowsElevatorEx(App: String; Args: TStrings; Wait: Boolean; var ExitCodeEx: TExitCode): Boolean;
function WindowsElevator(App: String; Args: TStrings): Boolean;
{$ENDIF}
{$IFDEF LINUX}
function LinuxElevatorEx(App: String; Args: TStrings; Wait: Boolean; var ExitCodeEx: LongInt): Boolean;
function LinuxElevator(App: String; Args: TStrings): Boolean;
function RebootLinux: Boolean;
{$ENDIF}

function MyMessageBoxFunction(Text, Caption: PChar; Flags: Longint): Integer;
function MyInputBox(const ACaption, APrompt, ADefault: String): String;
function MyDialogsSelectDirectory(Caption, InitialDirectory: String; out Directory: String; ShowHidden: Boolean; HelpCtx: Longint = 0): Boolean;
function MySelectDirectory(Caption, InitialDirectory: String; out Directory: String; ShowHidden: Boolean = True; HelpCtx: Longint = 0): Boolean;

{$IFNDEF WINDOWS}

procedure LazShimSetExecutable(Path, ReferenceExecutable: String);
{$ENDIF}
{$IFDEF WINDOWS}
procedure MoveFileOnReboot(Source, Target: String);
{$ENDIF}

function MyGetAppConfigDir(Global: Boolean): String;

function MyBoolToStr(Value: Boolean; UseBoolStrs: Boolean = True): String;

function MyGetCommandLine: String;
function MyGetTempPathEx: String;
function MyParamStr(aIndex: Integer): String;
function AssertDir(Path: String): String;
function DeAssertDir(Path: String): String;
function SetFileAttributes(FilePath: String; Attributes: Integer): Boolean;

{$IFNDEF WINDOWS}
function FindAllLinks(Path: String): TStringList;
{$ENDIF}

procedure MyFindAllDirs(AList: TStrings; const SearchPath: String;
  const SearchMask: String = ''; SearchSubDirs: Boolean = True; DirAttr: Word = faDirectory;
  PathSeparator: char = ';'; NoFollow: Boolean = True); overload;
function MyFindAllDirs(const SearchPath: String; const SearchMask: String = '';
  SearchSubDirs: Boolean = True; DirAttr: Word = faDirectory;
  PathSeparator: char = ';'; NoFollow: Boolean = True): TStringList; overload;

function MyFindAllFiles(const SearchPath: String; const SearchMask: String = '';
  SearchSubDirs: Boolean = True; DirAttr: Word = faDirectory;
  MaskSeparator: char = ';'; PathSeparator: char = ';'; NoFollow: Boolean = True): TStringList; overload;
procedure MyFindAllFiles(AList: TStrings; const SearchPath: String;
  const SearchMask: String = ''; SearchSubDirs: Boolean = True; DirAttr: Word = faDirectory;
  MaskSeparator: char = ';'; PathSeparator: char = ';'; NoFollow: Boolean = True); overload;

function IsPipe(const FilePath: String): Boolean;
function FindAllFilesEx(Path: String; Recurse: Boolean): TStringList;
function FileCopyFile(Source, Target: String; FailIfExists: Boolean): Boolean;
function AbsolutizePath(Path, ProjectRoot: String): String;

function MyExtractFileDriveFixUp(Path, RootPath: String): String;
function GetExpandedEnvVars(Literal: String): String;

procedure WipeFolder(Folder: String; Recurse: Boolean);
{$IFDEF WINDOWS}

function NukeAllFolders(Path: String; FollowJunctions: Boolean = false): Boolean;
{$ENDIF}

procedure WipeFolderOld(Folder: String; Recurse: Boolean);

function ExtractFileExtOnly(FileName: String): String;

function ExtractFileNameOnly(Name: String): String;

function MyCreateGUID: String;

function CreateGUIDUp: String;
{$IFNDEF NOGUI}

function FontToString(Font: TFont): String;

procedure StringToFont(sFont: String; Font: TFont);
{$ENDIF}

function PathFree(Path: String): Int64;

function PathSize(Path: String): Int64;

procedure MarkFileForDeletion(FileName: String);

procedure GetShortPath(FileName: String; var ShortPath: String);
procedure GetLongPath(FileName: String; var LongPath: String);

{$IFNDEF NOGUI}
procedure CopyFont(FromFont, ToFont: TFont);
function DetermineTitlebarHeight(aForm: TForm): Integer;
{$ENDIF}

function OccurrencesOfChar(const s: String; const c: Char): Integer;

function BrandEy: String;
function ExtractnextVariableFRK(const Literal : string; var Varname: string; var offset:integer):Boolean;
function ytm_SmartPos(SearchStr,
                SourceStr:string;
                CaseSensitive:boolean=True;
                startpos:integer=1;
                ForwardSearch : Boolean = TRUE):integer;
function YTM_FastPosBack(const aString, aSubStr : String; aStartPos: Integer): Integer;
function SingleLineToMultiLine(Single: String): String;
function MultiLineToSingleLine(Multi: String): String;
function MyLineEnding: String;
function LengthMyLineEnding: Integer;
function MemoMultiToDefaultMultiLineAdapter(Value: String): String;

procedure DoDebug(Add: String);
function MyGetCurrentDir: String;

function IsFilteredProp(Prop: String): Boolean;

function EncodeStr(Value: AnsiString): AnsiString;
function Is64Bit(Compatibility: Boolean = false): Boolean;
function Is64BitOnArm: Boolean;
function MoveFile(Source, Target: String): Boolean;
function RemoveDirectory(Path: String): Boolean;

function LangToCode(Language: String): String;

function LaunchAppAndWait(App, Cmd: String; Show, Wait: Boolean; LaunchFromIDE: Boolean = false): Integer;
function LaunchAppAndWait2(App: String; Cmds: TStrings; Show, Wait: Boolean): Integer;
function LaunchAppAndWait3(App: String; Cmds: TStrings; Show, Wait: Boolean; var Return: String): Integer;
function LaunchAppAndWait4(App, Cmd, Startup: String; Show, Wait: Boolean): Integer;
{$IFDEF WINDOWS}
function LaunchAppAndWaitWindows(Command: String; Show, Wait: Boolean): Integer; overload;
{$ENDIF}

function ParseWhiteSpaceIntoMultipleStrings(WhiteSpace: String): TStringList;

function MyFileExists(FileName: String; FollowLink: Boolean = True): Boolean;

function FileCopyBundle(Source, Target: String): Boolean;

function MyGetOSLanguage: string;

function CompilerVariableBasedGetLanguageCode(Value: String): Integer;
function GetCurrentLanguageCode(User, Default: Boolean): Integer;
function CodeToLang(CodeI: Integer): String;
function LangToCodeASCII(Language: String): String;

procedure InitializeLocalizations(Trans: String);
procedure ReadLangBlock;
procedure RevertLocalizations;

procedure TextFileDisplay(Path: String);
function MyMessageBox(Handle: Integer; Text, Caption: PChar; Flags: Longint = MB_OK): Integer; overload;
function MyMessageBox(Text, Caption: PChar; Flags: Longint = MB_OK): Integer; overload;
function MyApplicationMessageBox(Text, Caption: PChar; Flags: Longint = MB_OK): Integer;

{$IFDEF LINUX}
function IsConsoleAvailable: Boolean;
{$ENDIF}

{$IFDEF DARWIN}
function MyExecuteProcess(AProcess, AParameters: string; AGoodExitCodes: array of integer; NoPipes: Boolean = false): boolean;
{$ENDIF}

{$IFDEF WINDOWS}
function MyExitWindows(RebootParam: Longword): Boolean;
function IsOlderThanVista: Boolean;
function GetIERegVersion: String;
function Get64BitArch: String;
function GetScreenDPI: Integer;
function IsUserUser: Boolean;
function IsUserPower: Boolean;
function IsUserGuest: Boolean;
function MyGetComputerName: String;
function GetUserOrDomain(User: Boolean): String;
function GetSystemMemoryMb(aSystemMem: TSystemMem): Integer;
procedure GetLicenseInfo(var User, Organization: String);
procedure GetLanguage(var LangText: String; var LangInt: Integer);
function IsBuildLabUpdate1: Boolean;
function IsBuildLabUpdate2: Boolean;
function IsBuildLabUpdate3: Boolean;
function IsBuildLabUpdate4: Boolean;
function IsBuildLabUpdate5: Boolean;
function IsBuildLabUpdate6: Boolean;
function IsBuildLabUpdate7: Boolean;
function IsBuildLabUpdate8: Boolean;
function IsBuildLabUpdate9: Boolean;
function IsBuildLabUpdate10: Boolean;
function IsBuildLabUpdate11: Boolean;
function IsServer: Boolean;
procedure GetWindowsVersion(var NT: Boolean; var vMax, vMin, vSP: Integer);
procedure GetColorCount(var Colors: Int64; var Bits: Integer);
procedure GetScreenResolution(var X, Y: Integer);
procedure GetFreeMemory(Total: Boolean; var memPhysical, memPaging, memVirtual: Int64);
function IsUserAdminEx: Boolean;
function IsUserAdmin: Boolean;
function MySHGetPathFromIDList(pidl: PItemIDList; pszPath: PChar): BOOL;
function MySHGetFolderPath(CSIDL: Integer; var Path: String): Boolean;
function MyGetShortPathName(lpszLongPath: LPCSTR; lpszShortPath: LPSTR; cchBuffer: DWORD): DWORD;
function EnsureSubstPathA(const s: String; Force: Boolean = false): String; overload;
function EnsureSubstPathW(const ws: WideString; Force: Boolean = false): String; overload;
{$ENDIF}

function ExpandEnvironmentStrings1(const s: String; IgnoreCase: Boolean = True): String; 
function ExpandEnvironmentString2(s: String): String; 

{$IFDEF WINDOWS}

{$ENDIF}

function PromptForFileName(var AFileName: string; const AFilter: string = '';
  const ADefaultExt: string = ''; const ATitle: string = '';
  const AInitialDir: string = ''; SaveDialog: Boolean = False): Boolean;

function GetBootPath: String;

function GetSysWow64DirWin: String;
function GetWindowsDirectoryWin(lpBuffer: PChar; uSize: Cardinal): Cardinal; stdcall;
function GetSystemDirectoryWin(lpBuffer: PChar; uSize: Cardinal): Cardinal; stdcall;

procedure GetSpecialFolder(CSIDL: Integer; var Path: String);
{$IFDEF DARWIN}
function GetSignificantDir(DirLocation: qword; DomainMask: qword; count: byte): string;

procedure EncryptFile(Filename, Password: string);

procedure EncryptFileEx(FileName: String; Password: Char);

procedure EncryptFileEy(FileName: String; Password: Char; FirstBytes: UInt64 = 0);

function GetBundleBinary(AppPath: String): String;
{$ENDIF}

function FindAllFilesEz(Path: String; Recurse, AllowDir: Boolean; ExcludeFolderMask: TStrings; MatchFiles: Boolean = false; NoFollow: Boolean = True): TStringList;
function FindAllDirs(Path: String; Recurse: Boolean): TStringList;

function MyStrToBool(Value: String; DefaultFalse: Boolean = false): Boolean;

procedure KillAllOldButtons;

var
  CachedDefaultLanguageEx: String; 
  CachedLanguageCompilerVariableValueEx: String; 
  EXEDIR, WINDIR, WINSYSDIR, mSysDir, TEMPDIR, PROJDIR: String;
  REG_ACCESS_CONST: LongWord = 0;
  gWOW_PTR: Pointer;

implementation

{$IFDEF DARWIN}
uses
  CFURL;
{$ENDIF}

var
  t: TextFile;

procedure KillAllOldButtons;
var
  i, j: Integer;
begin
  {$IFNDEF NOGUI}
  for i := 1 to Application.ComponentCount do
    if Application.Components[i -1] is TForm then
    begin
      
      for j := 1 to Application.Components[i -1].ComponentCount do
        if (Application.Components[i -1].Components[j -1]) is TBitBtn then
        begin
          
            TBitBtn(Application.Components[i -1].Components[j -1]).Glyph.Assign(nil);
            TBitBtn(Application.Components[i -1].Components[j -1]).GlyphShowMode := gsmNever;
        end;
    end;
  {$ENDIF}
end;

function MyStrToBool(Value: String; DefaultFalse: Boolean = false): Boolean;
var
  b: Boolean;
begin
  if not DefaultFalse then Result := false 
    else Result := True;
  if Value = '' then Exit;
  try
    b := Result;
    b := StrToBool(Value);
    Result := b;
  except
    
  end;
end;

function FindAllDirs(Path: String; Recurse: Boolean): TStringList;
var
  l: TStringList;
  s: TSearchRec;
  i, j: Integer;
  b: Boolean;
begin
  Result := TStringList.Create;
  i := FindFirstUTF8(AssertDir(Path) + '*', faAnyFile, s);
  b := i = 0;
  while i = 0 do
  begin
    if (s.Name <> '.') and (s.Name <> '..') then
    begin
      
      if ((s.Attr and faDirectory) <> 0) then
      begin
        if Recurse then
        begin
          l := FindAllDirs(AssertDir(Path) + s.Name, True);
          for j := 1 to l.Count do
            Result.Add(l[j -1]);
          l.Free;
        end;
        Result.Add(DeAssertDir(AssertDir(Path) + s.Name));
      end;
    end;
    i := FindNextUTF8(s);
  end;
  if b then FindCloseUTF8(s);
end;

{$IFNDEF NOGUI}
function DetermineTitlebarHeight(aForm: TForm): Integer;
var
  global_pos, aPoint : TPoint;
begin
  aPoint.X := 1;
  aPoint.Y := 1;
  global_pos := aForm.ClientToScreen(aPoint);
  Result     := global_pos.Y - aForm.Top;
end;
{$ENDIF}

function FileCopyBundle(Source, Target: String): Boolean;
begin
  Result := false;
  ForceDirectories(ExtractFilePath(Target));
  {$IFDEF WINDOWS}
  if not FileCopyFile(Source + '.exe', Target + '.exe', false) then Exit;
  {$ELSE}
  {$IFDEF LINUX}
  if not FileCopyFile(Source, Target, false) then Exit;
  {$ELSE}
  
  ForceDirectories(Target + '.app/Contents/MacOS');
  ForceDirectories(Target + '.app/Contents/Resources');
  if not FileCopyFile(Source + '.app/Contents/Info.plist', Target + '.app/Contents/Info.plist', false) then Exit;
  if not FileCopyFile(Source + '.app/Contents/PkgInfo', Target + '.app/Contents/PkgInfo', false) then Exit;
  if not FileCopyFile(Source + '.app/Contents/Resources/'
    + ExtractFileNameOnly(Source) + '.icns', Target + '.app/Contents/Resources/'
    + ExtractFileNameOnly(Target) + '.icns', false) then Exit;
  if not FileCopyFile(Source + '.app/Contents/MacOS/'
    + ExtractFileNameOnly(Source), Target + '.app/Contents/MacOS/'
    + ExtractFileNameOnly(Target), false) then Exit;
  LazShimSetExecutable(Target + '.app/Contents/MacOS/'
    + ExtractFileNameOnly(Target), Source + '.app/Contents/MacOS/'
    + ExtractFileNameOnly(Source));
  {$ENDIF}
  {$ENDIF}
  Result := True;
end;

{$IFDEF DARWIN}
procedure EncryptFileEx(FileName: String; Password: Char);
var
  fs: TFileStream;
  b: Byte;
begin
  b := 0;
  fs := TFileStream.Create(FileName, fmOpenReadWrite or fmShareExclusive);
  fs.Read(b, 1);
  b := (b xor Ord(Password));
  fs.Seek(-1, soCurrent);
  fs.Write(b, 1);
  fs.Free;
end;

procedure EncryptFile(Filename, Password: string);
var
  fin: TMemoryStream;
  fOut: TMemoryStream;
  ch: byte;
  Key: byte;
  x: integer;
  idx: integer;
begin

  Key := 0;
  ch := 0;
  idx := 0;

  fIn := TMemoryStream.Create;
  fOut := TMemoryStream.Create;
  
  fin.LoadFromFile(Filename);

  for x := 0 to fin.Size - 1 do
  begin
    
    fin.Read(ch, 1);

    idx := (x mod Length(Password) + 1);

    Key := Ord(Password[idx]);
    
    ch := (ch xor key);
    
    fOut.Write(ch, 1);

  end;

  fOut.SaveToFile(Filename);

  fin.Free;
  fOut.Free;
end;

procedure EncryptFileEy(FileName: String; Password: Char; FirstBytes: UInt64 = 0);
var
  m: TMemoryStream;
  i: Integer;
  b: Byte;
begin
  b := 0;
  m := TMemoryStream.Create;
  m.LoadFromFile(FileName);
  for i := 1 to m.Size do
  begin
    
      if i > FirstBytes then
        Break;
    m.Read(b, 1);
    m.Seek(-1, soCurrent);
    b := b xor Ord(Password);
    m.Write(b, 1);
  end;
  
  m.SaveToFile(FileName);
  m.Free;
end;

{$IFNDEF NOGUI}
function macOS_GetPrefString(const KeyName : string) : string;
begin
  Result := NSStringToString(NSUserDefaults.standardUserDefaults.stringForKey(NSStr(@KeyName[1])));
end;
{$ENDIF}
{$ENDIF}

function IsDarkModeAppearance:boolean;
{$IFNDEF NOGUI}
{$IF defined(DARWIN)}
begin
  Result := pos('DARK',UpperCase(macOS_GetPrefString('AppleInterfaceStyle')))>0;
end;
{$ELSEIF defined(LINUX)}
  function _Level(C: TColor): double;
  begin
    Result:= Red(C)*0.3 + Green(C)*0.59 + Blue(C)*0.11;
  end;
begin
  Result:= _Level(ColorToRGB(clWindow)) < _Level(ColorToRGB(clWindowText));
end;
{$ELSEIF defined(WINDOWS)}
const
  KEYPATH = '\Software\Microsoft\Windows\CurrentVersion\Themes\Personalize';
  KEYNAME = 'AppsUseLightTheme';
var
  LightKey: boolean;
  Registry: TRegistry;
begin
  Result := false;
  Exit;
  
  Registry := TRegistry.Create;
  try
    Registry.RootKey := HKEY_CURRENT_USER;
    if Registry.OpenKeyReadOnly(KEYPATH) then
      begin
        if Registry.ValueExists(KEYNAME) then
          LightKey := Registry.ReadBool(KEYNAME)
        else
          LightKey := true;
      end
    else
      LightKey := true;
    Result := not LightKey
  finally
    Registry.Free;
  end;
end;
{$ENDIF}
{$ELSE}
begin
  Result := false;
end;
{$ENDIF}

function CompilerVariableBasedGetLanguageCode(Value: String): Integer;
function IsOlderThanVista: Boolean;
begin
  Result := false;
end;
var
  p: PChar;
  ui32_1, ui32_2: UINT32;
begin
  {$IFDEF WINDOWS}
  if AnsiCompareText(Value, 'INSTALL') = 0 then
    Result := GetSystemDefaultUILanguage
  else
  if AnsiCompareText(Value, 'SYSTEM') = 0 then
  begin
    if IsOlderThanVista then
      Result := GetSystemDefaultUILanguage
    else
    begin
      Result := -1;
      ui32_2 := 0;
      if GetSystemPreferredUILanguages(4, ui32_1, nil, ui32_2) then
      begin
        GetMem(p, ui32_2);
        if GetSystemPreferredUILanguages(4, ui32_1, p, ui32_2) then
          Result := StrToInt('$'+ p);
        FreeMem(p);
      end;
      if Result = -1 then
        
        Result := GetSystemDefaultUILanguage;
    end;
  end
  else
  if AnsiCompareText(Value, 'USER') = 0 then
    Result := GetUserDefaultUILanguage
  else
    Result := StrToInt(LangToCode(CachedDefaultLanguageEx));
  {$ELSE}
  Result := StrToInt(LangToCode(CachedDefaultLanguageEx));
  {$ENDIF}
end;

function GetCurrentLanguageCode(User, Default: Boolean): Integer;
var
  c1, c2: Cardinal;
  p: PChar;
begin
  {$IFDEF WINDOWS}
  try
    if User then c1 := LOCALE_USER_DEFAULT
      else c1 := LOCALE_SYSTEM_DEFAULT;
    if Default then c2 := LOCALE_IDEFAULTLANGUAGE
      else c2 := LOCALE_ILANGUAGE;
    GetMem(p, (MAX_PATH+1)*8);
    GetLocaleInfo(c1, c2, p, MAX_PATH);
    Result := StrToInt('$' + p);
    FreeMem(p);
  except
    Result := 0;
  end;
  {$ELSE}
  {$ENDIF}
end;

function MyGetOSLanguage: string;
var
  l, fbl: string;
  {$IFDEF LCLCarbon}
  theLocaleRef: CFLocaleRef;
  locale: CFStringRef;
  buffer: StringPtr;
  bufferSize: CFIndex;
  encoding: CFStringEncoding;
  success: boolean;
  {$ENDIF}
begin
  {$IFDEF LCLCarbon}
  theLocaleRef := CFLocaleCopyCurrent;
  locale := CFLocaleGetIdentifier(theLocaleRef);
  encoding := 0;
  bufferSize := 256;
  buffer := new(StringPtr);
  success := CFStringGetPascalString(locale, buffer, bufferSize, encoding);
  if success then
    l := string(buffer^)
  else
    l := '';
  fbl := Copy(l, 1, 2);
  dispose(buffer);
  {$ELSE}
  {$IFDEF DARWIN}
    fbl := NSLocale.currentLocale.localeIdentifier.UTF8String;
  {$ENDIF}
  {$IFDEF UNIX}
  fbl := Copy(GetEnvironmentVariable('LC_CTYPE'), 1, 2);
  {$ELSE}
  fbl := IntToStr(GetCurrentLanguageCode(True, false)); 
  {$ENDIF}
  {$ENDIF}
  Result := fbl;
end;

function CodeToLang(CodeI: Integer): String;
var
  Code: String;
  p: PChar;
begin
  Result := '';
  Code := IntToStr(CodeI);
  
  if Code = '1025' then Result := 'Arabic'; 
  if Code = '1027' then Result := 'Catalan'; 
  if Code = '1028' then Result := 'Chinese (Taiwan)'; 
  if Code = '2052' then Result := 'Chinese (PRC)'; 
  if Code = '1029' then Result := 'Czech'; 
  if Code = '1030' then Result := 'Danish'; 
  if Code = '1031' then Result := 'German'; 
  if Code = '1032' then Result := 'Greek'; 
  if Code = '1033' then Result := 'English'; 
  if Code = '3082' then Result := 'Spanish'; 
  if Code = '1061' then Result := 'Estonian'; 
  if Code = '1035' then Result := 'Finnish'; 
  if Code = '1036' then Result := 'French'; 
  if Code = '1037' then Result := 'Hebrew'; 
  if Code = '1038' then Result := 'Hungarian'; 
  if Code = '1040' then Result := 'Italian'; 
  if Code = '1041' then Result := 'Japanese'; 
  if Code = '1042' then Result := 'Korean'; 
  if Code = '1063' then Result := 'Lithuanian'; 
  if Code = '1062' then Result := 'Latvian'; 
  if Code = '1043' then Result := 'Dutch'; 
  if Code = '1044' then Result := 'Norwegian'; 
  if Code = '1045' then Result := 'Polish'; 
  if Code = '1046' then Result := 'Portuguese (Brazil)'; 
  if Code = '2070' then Result := 'Portuguese (Portugal)'; 
  if Code = '1048' then Result := 'Romanian'; 
  if Code = '1049' then Result := 'Russian'; 
  if Code = '1050' then Result := 'Croatian'; 
  if Code = '1051' then Result := 'Slovak'; 
  if Code = '1053' then Result := 'Swedish'; 
  if Code = '1054' then Result := 'Thai'; 
  if Code = '1055' then Result := 'Turkish'; 
  if Code = '1060' then Result := 'Slovenian'; 
  if Code = '1066' then Result := 'Vietnamese'; 
  if Code = '1069' then Result := 'Basque'; 
  if Result = '' then
  begin
    {$IFDEF WINDOWS}
    
    GetMem(p, (MAX_PATH+1)*8);
    GetLocaleInfo(CodeI, LOCALE_SENGLANGUAGE, p, MAX_PATH);
    
    if LangToCode(p) <> '1033' then
      Result := CodeToLang(StrToInt(LangToCode(p)));
    if Result = '' then
      Result := CodeToLang(StrToInt(LangToCode(p)));
    
    FreeMem(p);
    {$ENDIF}
  end;
end;

function LangToCodeASCII(Language: String): String;
begin
  
  Result := '1033'; 
  if AnsiUpperCase(Language) = 'ARABIC' then Result := '1256'; 
  if AnsiUpperCase(Language) = 'CATALAN' then Result := '1252'; 
  if AnsiUpperCase(Language) = 'CHINESE (TAIWAN)' then Result := '950'; 
  if AnsiUpperCase(Language) = 'CHINESE (PRC)' then Result := '936'; 
  if AnsiUpperCase(Language) = 'CZECH' then Result := '1250'; 
  if AnsiUpperCase(Language) = 'DANISH' then Result := '1252'; 
  if AnsiUpperCase(Language) = 'GERMAN' then Result := '1252'; 
  if AnsiUpperCase(Language) = 'GREEK' then Result := '1253'; 
  if AnsiUpperCase(Language) = 'ENGLISH' then Result := '1252'; 
  if AnsiUpperCase(Language) = 'SPANISH' then Result := '1252'; 
  if AnsiUpperCase(Language) = 'ESTONIAN' then Result := '1257'; 
  if AnsiUpperCase(Language) = 'FINNISH' then Result := '1252'; 
  if AnsiUpperCase(Language) = 'FRENCH' then Result := '1252'; 
  if AnsiUpperCase(Language) = 'HEBREW' then Result := '1255'; 
  if AnsiUpperCase(Language) = 'HUNGARIAN' then Result := '1250'; 
  if AnsiUpperCase(Language) = 'ITALIAN' then Result := '1252'; 
  if AnsiUpperCase(Language) = 'JAPANESE' then Result := '932'; 
  if AnsiUpperCase(Language) = 'KOREAN' then Result := '949'; 
  if AnsiUpperCase(Language) = 'LITHUANIAN' then Result := '1257'; 
  if AnsiUpperCase(Language) = 'LATVIAN' then Result := '1257'; 
  if AnsiUpperCase(Language) = 'DUTCH' then Result := '1252'; 
  if AnsiUpperCase(Language) = 'NORWEGIAN' then Result := '1252'; 
  if AnsiUpperCase(Language) = 'POLISH' then Result := '1250'; 
  if AnsiUpperCase(Language) = 'PORTUGUESE (BRAZIL)' then Result := '1252'; 
  if AnsiUpperCase(Language) = 'PORTUGESE (BRAZIL)' then Result := '1252'; 
  if AnsiUpperCase(Language) = 'PORTUGUESE (PORTUGAL)' then Result := '1252'; 
  if AnsiUpperCase(Language) = 'PORTUGESE (PORTUGAL)' then Result := '1252'; 
  if AnsiUpperCase(Language) = 'ROMANIAN' then Result := '1250'; 
  if AnsiUpperCase(Language) = 'RUSSIAN' then Result := '1251'; 
  if AnsiUpperCase(Language) = 'CROATIAN' then Result := '1250'; 
  if AnsiUpperCase(Language) = 'SLOVAK' then Result := '1250'; 
  if AnsiUpperCase(Language) = 'SWEDISH' then Result := '1252'; 
  if AnsiUpperCase(Language) = 'THAI' then Result := '874'; 
  if AnsiUpperCase(Language) = 'TURKISH' then Result := '1254'; 
  if AnsiUpperCase(Language) = 'SLOVENIAN' then Result := '1250'; 
  if AnsiUpperCase(Language) = 'VIETNAMESE' then Result := '1258'; 
  if AnsiUpperCase(Language) = 'BASQUE' then Result := '1252'; 
end;

procedure InitializeLocalizations(Trans: String);
var
  LangStr: String;
  BOM: Char;
begin
  AssignFile(t, Trans,cp_utf8);
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
  ReadLangBlock;
  while not EOF(t) do
  begin
    
    ReadLn(t, LangStr);
    ReadLangBlock;
    if AnsiUpperCase(LangStr) = AnsiUpperCase(
      CodeToLang(
        CompilerVariableBasedGetLanguageCode(
          CachedLanguageCompilerVariableValueEx))) then
    
    begin
      CloseFile(t);
      Exit;
    end;
  end;
  CloseFile(t);
end;

procedure ReadLangBlock;
var
  Stub: String;
begin
  ReadLn(t, msg0);
  ReadLn(t, msg1);
  ReadLn(t, msg2);
  ReadLn(t, msg3);
  ReadLn(t, msg4);
  ReadLn(t, msg5);
  ReadLn(t, msg6);
  ReadLn(t, msg7);
  ReadLn(t, msg8);
  ReadLn(t, msg9);
  ReadLn(t, msg10);
  ReadLn(t, msg11);
  ReadLn(t, msg12);
  ReadLn(t, msg13);
  ReadLn(t, msg14);
  ReadLn(t, msg15);
  ReadLn(t, msg16);
  ReadLn(t, msg17);
  ReadLn(t, msg18);
  ReadLn(t, msg19);
  ReadLn(t, msg20);
  ReadLn(t, msg21);
  ReadLn(t, dlg0);
  ReadLn(t, dlg1);
  ReadLn(t, dlg2);
  ReadLn(t, dlg3);
  ReadLn(t, dlg4);
  ReadLn(t, dlg5);
  ReadLn(t, dlg6);
  ReadLn(t, dlg7);
  ReadLn(t, dlg8);
  ReadLn(t, dlg9);
  ReadLn(t, dlg10);
  ReadLn(t, dlg11);
  ReadLn(t, dlg12);
  ReadLn(t, dlg13);
  ReadLn(t, dlg14);
  ReadLn(t, dlg15);
  ReadLn(t, dlg16);
  ReadLn(t, msg22);
  ReadLn(t, dlg17);
  ReadLn(t, dlg18);
  ReadLn(t, msg23);
  ReadLn(t, msg24);
  ReadLn(t, msg25);
  ReadLn(t, msg26);
  ReadLn(t, msg27);
  ReadLn(t, msg28);
  ReadLn(t, dlg19);
  ReadLn(t, dlg20);
  ReadLn(t, dlg21);
  ReadLn(t, dlg22);
  ReadLn(t, dlg23);
  ReadLn(t, msg29);
  ReadLn(t, msg30);
  ReadLn(t, msg31);
  ReadLn(t, msg32);
  ReadLn(t, msg33);
  ReadLn(t, msg34);
  ReadLn(t, msg35);
  ReadLn(t, msg36);
  ReadLn(t, msg37);
  ReadLn(t, msg38);
  ReadLn(t, msg39);
  ReadLn(t, msg40);
  ReadLn(t, msg41);
  ReadLn(t, msg42);
  ReadLn(t, msg43);
  ReadLn(t, msg44);
  ReadLn(t, msg45);
  ReadLn(t, msg46);
  ReadLn(t, msg47);
  ReadLn(t, msg48);
  ReadLn(t, msg49);
  ReadLn(t, msg50);
  ReadLn(t, msg51);
  ReadLn(t, msg52);
  ReadLn(t, msg53);
  ReadLn(t, msg54);
  ReadLn(t, msg55);
  ReadLn(t, msg56);
  ReadLn(t, msg57);
  ReadLn(t, msg58);
  ReadLn(t, msg59);
  ReadLn(t, msg60);
  ReadLn(t, msg61);
  ReadLn(t, msg62);
  ReadLn(t, msg63);
  ReadLn(t, dlg24);
  ReadLn(t, dlg25);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, Stub);
  ReadLn(t, msg64);
  ReadLn(t, dlg26);
  ReadLn(t, dlg27);
  ReadLn(t, dlg28);
  ReadLn(t, ntv0);
  ReadLn(t, ntv1);
  ReadLn(t, ntv2);
  ReadLn(t, ntv3);
  ReadLn(t, ntv4);
  ReadLn(t, ntv5);
  ReadLn(t, ntv6);
  ReadLn(t, ntv7);
  ReadLn(t, ntv8);
  ReadLn(t, ntv9);
  ReadLn(t, ntv10);
end;

procedure RevertLocalizations;
begin
  msg0 := rmsg0;
  msg1 := rmsg1;
  msg2 := rmsg2;
  msg3 := rmsg3;
  msg4 := rmsg4;
  msg5 := rmsg5;
  msg6 := rmsg6;
  msg7 := rmsg7;
  msg8 := rmsg8;
  msg9 := rmsg9;
  msg10 := rmsg10;
  msg11 := rmsg11;
  msg12 := rmsg12;
  msg13 := rmsg13;
  msg14 := rmsg14;
  msg15 := rmsg15;
  msg16 := rmsg16;
  msg17 := rmsg17;
  msg18 := rmsg18;
  msg19 := rmsg19;
  msg20 := rmsg20;
  msg21 := rmsg21;
  msg22 := rmsg22;
  msg23 := rmsg23;
  msg24 := rmsg24;
  msg25 := rmsg25;
  msg26 := rmsg26;
  msg27 := rmsg27;
  msg28 := rmsg28;
  msg29 := rmsg29;
  msg30 := rmsg30;
  msg31 := rmsg31;
  msg32 := rmsg32;
  msg33 := rmsg33;
  msg34 := rmsg34;
  msg35 := rmsg35;
  msg36 := rmsg36;
  msg37 := rmsg37;
  msg38 := rmsg38;
  msg39 := rmsg39;
  msg40 := rmsg40;
  msg41 := rmsg41;
  msg42 := rmsg42;
  msg43 := rmsg43;
  msg44 := rmsg44;
  msg45 := rmsg45;
  msg46 := rmsg46;
  msg47 := rmsg47;
  msg48 := rmsg48;
  msg49 := rmsg49;
  msg50 := rmsg50;
  msg51 := rmsg51;
  msg52 := rmsg52;
  msg53 := rmsg53;
  msg54 := rmsg54;
  msg55 := rmsg55;
  msg56 := rmsg56;
  msg57 := rmsg57;
  msg58 := rmsg58;
  msg59 := rmsg59;
  msg60 := rmsg60;
  msg61 := rmsg61;
  msg62 := rmsg62;
  msg63 := rmsg63;
  msg64 := rmsg64;
  dlg0 := rdlg0;
  dlg1 := rdlg1;
  dlg2 := rdlg2;
  dlg3 := rdlg3;
  dlg4 := rdlg4;
  dlg5 := rdlg5;
  dlg6 := rdlg6;
  dlg7 := rdlg7;
  dlg8 := rdlg8;
  dlg9 := rdlg9;
  dlg10 := rdlg10;
  dlg11 := rdlg11;
  dlg12 := rdlg12;
  dlg13 := rdlg13;
  dlg14 := rdlg14;
  dlg15 := rdlg15;
  dlg16 := rdlg16;
  dlg17 := rdlg17;
  dlg18 := rdlg18;
  dlg19 := rdlg19;
  dlg20 := rdlg20;
  dlg21 := rdlg21;
  dlg22 := rdlg22;
  dlg23 := rdlg23;
  dlg24 := rdlg24;
  dlg25 := rdlg25;
  dlg26 := rdlg26;
  dlg27 := rdlg27;
  dlg28 := rdlg28;
  ntv0 := rntv0;
  ntv1 := rntv1;
  ntv2 := rntv2;
  ntv3 := rntv3;
  ntv4 := rntv4;
  ntv5 := rntv5;
  ntv6 := rntv6;
  ntv7 := rntv7;
  ntv8 := rntv8;
  ntv9 := rntv9;
  ntv10 := rntv10;
end;

procedure TextFileDisplay(Path: String);
var
  s: String;
  t: TextFile;
begin
  if not MyFileExists(Path) then Exit;
  AssignFile(t, Path);
  Reset(t);
  while not EOF(t) do
  begin
    ReadLn(t, s);
    WriteLn(s);
  end;
  CloseFile(t);
end;

function MyMessageBox(Handle: Integer; Text, Caption: PChar; Flags: Longint = MB_OK): Integer; overload;
begin
  {$IFDEF NOGUI}
  Result := MyMessageBox(Text, Caption, Flags);
  {$ELSE}
  Result := MessageBox(Handle, Text, Caption, Flags);
  {$ENDIF}
end;

function MyMessageBox(Text, Caption: PChar; Flags: Longint = MB_OK): Integer; overload;
var
  c, j, k: Char;
  s: String;
  i: Integer;
begin
  {$IFDEF NOGUI}
  WriteLn; 
  WriteLn(Caption + ':');
  for i := 1 to Length(Caption) +1 do
    {$IFDEF WINDOWS}
    Write('=');
    {$ELSE}
    Write('=');
    {$ENDIF}
  WriteLn;
  WriteLn(MemoMultiToDefaultMultiLineAdapter(Text)); 
  for i := 1 to Length(Caption) +1 do
    {$IFDEF WINDOWS}
    Write('-');
    {$ELSE}
    
    Write('-');
    {$ENDIF}
  WriteLn;
  s := '';
  
  Flags := Flags and (not mb_IconStop);
  Flags := Flags and (not mb_IconExclamation);
  Flags := Flags and (not mb_IconQuestion);
  Flags := Flags and (not mb_IconInformation);
  if Flags = MB_OK then
  begin
    s := '(O)K';
    j := 'O';
    k := 'O';
  end;
  if Flags = MB_OKCANCEL then
  begin
    s := '(O)K (C)ancel';
    j := 'O';
    k := 'C';
  end;
  if Flags = MB_ABORTRETRYIGNORE then
  begin
    s := '(A)bort (R)etry (I)gnore';
    j := 'I';
    k := 'A';
  end;
  if Flags = MB_YESNOCANCEL then
  begin
    s := '(Y)es (N)o (C)ancel';
    j := 'N';
    k := 'C';
  end;
  if Flags = MB_YESNO then
  begin
    s := '(Y)es (N)o';
    j := 'Y';
    k := 'N';
  end;
  
  WriteLn(s);
  for i := 1 to Length(Caption) +1 do
    {$IFDEF WINDOWS}
    Write('-');
    {$ELSE}
    Write('-');
    {$ENDIF}
  WriteLn;
  repeat
    c := ReadKey;
    if c = #13 then
      c := j;
    if c = #27 then
      c := k;
  until AnsiPos('(' + UpperCase(c) + ')', s) <> 0;
  case UpperCase(c) of
    'O': Result := idOk;
    'C': Result := idCancel;
    'A': Result := idAbort;
    'R': Result := idRetry;
    'I': Result := idIgnore;
    'Y': Result := idYes;
    'N': Result := idNo;
  end;
  {$ELSE}
  Result := MessageBoxFunction(Text, Caption, Flags);
  {$ENDIF}
end;

function MyApplicationMessageBox(Text, Caption: PChar; Flags: Longint = MB_OK): Integer;
begin
  {$IFDEF NOGUI}
  Result := MyMessageBox(Text, Caption, Flags);
  {$ELSE}
  Result := Application.MessageBox(Text, Caption, Flags);
  {$ENDIF}
end;

{$IFDEF DARWIN}
function MyExecuteProcess(AProcess, AParameters: string; AGoodExitCodes: array of integer; NoPipes: Boolean = false): boolean;

const
  BUF_SIZE = 2048; 

var
  p: TProcess;
  ms: TMemoryStream;
  iBytesRead: longint;
  sl: TStringList;
  Buffer: array[1..BUF_SIZE] of byte;
  i: integer;
const
  maxNotarizeLines = 25;
begin
  Result := False;
  NoPipes := false; 

  p := TProcess.Create(nil);
  try

    p.Executable := AProcess;
    p.Parameters.Delimiter := ' ';
    p.Parameters.StrictDelimiter := True;
    p.Parameters.DelimitedText := AParameters;
    if not NoPipes then
      p.Options := [poUsePipes]
    else
      p.Options := [poWaitOnExit];
    p.Execute;

    if Assigned(p.Output) then
    begin
      ms := TMemoryStream.Create;
      try
        repeat
          iBytesRead := p.Output.Read(Buffer, BUF_SIZE);
          ms.Write(Buffer, iBytesRead);
        until iBytesRead = 0;

        sl := TStringList.Create;

        try
          ms.Seek(0, soFromBeginning);
          sl.LoadFromStream(ms);
        finally
          sl.Free;
        end;

        ms.SetSize(0);

        repeat
          iBytesRead := p.Stderr.Read(Buffer, BUF_SIZE);
          ms.Write(Buffer, iBytesRead);
        until iBytesRead = 0;

        sl := TStringList.Create;

        try
          ms.Seek(0, soFromBeginning);
          sl.LoadFromStream(ms);

        finally
          sl.Free;
        end;

      finally
        ms.Free;
      end;

    end;

    for i := Low(AGoodExitCodes) to High(AGoodExitCodes) do
      if AGoodExitCodes[i] = p.ExitCode then
        begin
          Result := True;
          break;
        end;
  finally
    p.Free;
  end;
end;
{$ENDIF}

{$IFDEF WINDOWS}
function IsUserElevated: Boolean;
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
    end;
  finally
    CloseHandle(token);
  end;
end;

function IsUserParticular(Kind: Integer): Boolean;
const
  SECURITY_NT_AUTHORITY: TSIDIdentifierAuthority =
  (Value: (0, 0, 0, 0, 0, 5));
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
end;

function IsUserAdmin: Boolean;
var
  osVerInfo: TOSVersionInfo;
begin
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
end;

{$ENDIF}

procedure GetSpecialFolderEx(CSIDL: Integer; var Path: String);
begin
  
end;

{$IFDEF DARWIN}
function GetBundleBinary(AppPath: String): String;
var
  i: Integer;
  l: TStringList;
  s, sX, sY, sZ, sEx: String;
begin
  Result := AppPath; 
  
  s := AnsiLowerCase(AppPath);
  if AnsiPos('.app', s) <> 0 then
    if AnsiPos('.app', s) = Length(s) -3 then
    begin
      sX := AppPath;
      sX := ExtractFileNameOnly(sX);
      sZ := s + '/Contents/';
      sY := sZ + 'MacOS/';
      s := sY + sX;
      
      AppPath := s;
      if (not MyFileExists(AppPath)) or (not FileIsExecutable(AppPath)) then
      begin
        l := MyFindAllFiles(sY, '*', false);
        for i := l.Count downto 1 do
          if not FileIsExecutable(l[i -1]) then
            l.Delete(i -1);
        
        if l.Count = 1 then
        begin
          AppPath := l[i -1];
          if MyFileExists(AppPath) and FileIsExecutable(AppPath) then
          begin
            l.Free;
            Result := AppPath;
            Exit;
          end;
        end;
        
        if MyFileExists(sZ + 'Info.plist') then
        begin
          AssignFile(t, sZ + 'Info.plist');
          Reset(t);
          while not EOF(t) do
          begin
            ReadLn(t, sEx);
            sEx := Trim(sEx);
            if AnsiCompareText('<key>CFBundleExecutable</key>', sEx) = 0 then
              if not EOF(t) then
              begin
                ReadLn(t, sEx);
                sEx := Trim(sEx);
                sEx := StringReplace(sEx, '<string>', '', [rfIgnoreCase, rfReplaceAll]);
                sEx := StringReplace(sEx, '</string>', '', [rfIgnoreCase, rfReplaceAll]);
                AppPath := sY + sEx;
                Break;
              end;
          end;
          CloseFile(t);
        end;
        l.Free;
        if MyFileExists(AppPath) and FileIsExecutable(AppPath) then
          Result := AppPath;
      end
      else
        if MyFileExists(AppPath) and FileIsExecutable(AppPath) then
          Result := AppPath;
    end;
end;
{$ENDIF}

function FindAllFilesEz(Path: String; Recurse, AllowDir: Boolean; ExcludeFolderMask: TStrings; MatchFiles: Boolean = false; NoFollow: Boolean = True): TStringList;
{$IFDEF WINDOWS}
var
  h: THandle;
  b, bX: Boolean;
  i, k: Integer;
  l: TStringList;
  ParentPath, FileSpec: String;
  fd: WIN32_FIND_DATA;
begin
  Result := TStringList.Create;
  ParentPath := AssertDir(ExtractFilePath(Path));
  FileSpec := ExtractFileName(Path);
  bX := ExcludeFolderMask = nil;
  if bX then
    ExcludeFolderMask := TStringList.Create;
  
  h := FindFirstFile(PChar(ParentPath + '*.*'), fd);
  if h = INVALID_HANDLE_VALUE then
  begin
    Windows.FindClose(h);
    if bX then
      ExcludeFolderMask.Free;
    Exit;
  end;
  repeat
    if (fd.cFileName <> String('.')) and (fd.cFileName <> '..') and
      ((fd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) <> 0) and Recurse then
    begin
      b := True;
      for k := 1 to ExcludeFolderMask.Count do
        if MatchesMask(StringReplace(ParentPath + fd.cFileName, '\\?\', '', [rfReplaceAll, rfIgnoreCase]), ExcludeFolderMask[k -1]) then
        begin
          b := false;
          Break;
        end;
      if b then
      begin
        l := FindAllFilesEz(ParentPath + fd.cFileName + '\' + FileSpec, True, AllowDir, ExcludeFolderMask);
        for i := 1 to l.Count do
          Result.Add(l[i -1]);
        l.Free;
      end;
    end;
    if (fd.cFileName <> String('.')) and (fd.cFileName <> '..') and
      ((fd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) <> 0) and AllowDir then
      Result.Add(ParentPath + fd.cFileName);
  until not FindNextFile(h, fd);
  Windows.FindClose(h);
  
  h := FindFirstFile(PChar(Path), fd);
  if h = INVALID_HANDLE_VALUE then
  begin
    Windows.FindClose(h);
    if bX then
      ExcludeFolderMask.Free;
    Exit;
  end;
  repeat
    if (fd.cFileName <> String('.')) and (fd.cFileName <> '..') then
      if (fd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) = 0 then
      begin
        b := True;
        for k := 1 to ExcludeFolderMask.Count do
          if MatchesMask(StringReplace(ParentPath + fd.cFileName, '\\?\', '', [rfReplaceAll, rfIgnoreCase]), ExcludeFolderMask[k -1]) or
            (MatchFiles and (AnsiCompareText(fd.cFileName, ExcludeFolderMask[k -1]) = 0)) then
          begin
            b := false;
            Break;
          end;
        if b then
          Result.Add(ParentPath + fd.cFileName);
      end;
  until not FindNextFile(h, fd);
  Windows.FindClose(h);
  if bX then
    ExcludeFolderMask.Free;
{$ELSE}
begin
  
  Result := MyFindAllFiles(ExtractFilePath(Path), ExtractFileName(Path), Recurse,
    faDirectory, ';', ';', NoFollow);
{$ENDIF}
end;

{$IFDEF WINDOWS}
function MyExitWindows(RebootParam: Longword): Boolean;
var
  TTokenHd: THandle;
  TTokenPvg: TTokenPrivileges;
  cbtpPrevious: DWORD;
  rTTokenPvg: TTokenPrivileges;
  pcbtpPreviousRequired: DWORD;
  tpResult: Boolean;
const
  SE_SHUTDOWN_NAME = 'SeShutdownPrivilege';
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
  begin
    tpResult := OpenProcessToken(GetCurrentProcess(),
      TOKEN_ADJUST_PRIVILEGES or TOKEN_QUERY,
      TTokenHd);
    if tpResult then
    begin
      tpResult := LookupPrivilegeValue(nil,
                                       SE_SHUTDOWN_NAME,
                                       TTokenPvg.Privileges[0].Luid);
      TTokenPvg.PrivilegeCount := 1;
      TTokenPvg.Privileges[0].Attributes := SE_PRIVILEGE_ENABLED;
      cbtpPrevious := SizeOf(rTTokenPvg);
      pcbtpPreviousRequired := 0;
      if tpResult then
        Windows.AdjustTokenPrivileges(TTokenHd,
                                      False,
                                      TTokenPvg,
                                      cbtpPrevious,
                                      rTTokenPvg,
                                      pcbtpPreviousRequired);
    end;
  end;
  
  Result := ExitWindowsEx(RebootParam, 0);
end;

function IsOlderThanVista: Boolean;
var
  os: TOSVersionInfo;
begin
  os.dwOSVersionInfoSize := SizeOf(TOSVersionInfo);
  GetVersionEx(os);
  Result := os.dwMajorVersion < 6;
end;

function GetIERegVersion: String;
var
  s: String;
  r: TRegistry;
begin
  
  Result := '';
  try
    r := TRegistry.Create;
    r.RootKey := HKEY_LOCAL_MACHINE;
    r.Access := KEY_READ;
    if r.OpenKeyReadOnly('SOFTWARE\Microsoft\Internet Explorer') then 
    begin
      Result := r.ReadString('Version'); 
      r.CloseKey;
    end;
    r.Free;
  except
    Result := '';
  end;
end;

function Get64BitArch: String;
const
  PROCESSOR_ARCHITECTURE_INTEL = 0;
  PROCESSOR_ARCHITECTURE_IA64 = 6;
  PROCESSOR_ARCHITECTURE_AMD64 = 9;
  PROCESSOR_ARCHITECTURE_ARM64 = 12; 
type
  TGetNativeSystemInfo = procedure(var lpSystemInfo: TSystemInfo); stdcall;
var
  SysInfo: TSystemInfo;
  d: THandle;
  f: ^TGetNativeSystemInfo;
begin
  Result := '';
  d := LoadLibrary('kernel32.dll'); 
  f := GetProcAddress(d, 'GetNativeSystemInfo'); 
  if @f = nil then
    Result := 'X86' 
  else
  begin
    f^(SysInfo);
    case SysInfo.wProcessorArchitecture of
      PROCESSOR_ARCHITECTURE_INTEL: Result := 'X86'; 
      PROCESSOR_ARCHITECTURE_IA64: Result := 'IA64'; 
      PROCESSOR_ARCHITECTURE_AMD64: Result := 'AMD64'; 
      PROCESSOR_ARCHITECTURE_ARM64: Result := 'ARM64'; 
    else
      Result := 'UNKNOWN'; 
    end;
    if SysInfo.wProcessorArchitecture = 0 then
      if Is64BitOnArm then
        Result := 'ARM64'; 
  end;
  FreeLibrary(d);
end;

function GetScreenDPI: Integer;
var
  hdcScreen: HDC;
begin
  hdcScreen := GetDC(0);
  Result := -1;
  if hdcScreen <> 0 then
  begin
    Result := GetDeviceCaps(hdcScreen, LOGPIXELSX);
    ReleaseDC(0, hdcScreen);
  end;
end;

function IsUserUser: Boolean;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    Result := IsUserParticular(DOMAIN_ALIAS_RID_USERS)
  else
    Result := false;
end;

function IsUserPower: Boolean;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    Result := IsUserParticular($00000223)
  else
    Result := false;
end;

function IsUserGuest: Boolean;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    Result := IsUserParticular(DOMAIN_ALIAS_RID_GUESTS)
  else
    Result := false;
end;

function MyGetComputerName: String;
var
  p: PChar;
  i: Cardinal;
begin
  i := MAX_COMPUTERNAME_LENGTH +1;
  GetMem(p, (i+1)*8);
  GetComputerName(p, i);
  Result := p;
  FreeMem(p);
end;

function GetUserOrDomain(User: Boolean): String;
var
  UserName: PChar;
  UserCount: Cardinal;
  
  TokenHandle: THandle;
  
  TokenInformation: Pointer;
  TokenInformationLength, ReturnLength: Cardinal;
  AccountName, DomainName: PChar;
  SizeAccountName, SizeDomainName, peUse: Cardinal;
begin
  Result := '';
  try
    if Win32Platform = VER_PLATFORM_WIN32_NT then
    begin

      OpenProcessToken(GetCurrentProcess, TOKEN_READ, TokenHandle);
      GetTokenInformation(TokenHandle, TokenUser, nil, 0, ReturnLength);
      GetMem(TokenInformation, (ReturnLength +1) *8);
      TokenInformationLength := ReturnLength;
      GetTokenInformation(TokenHandle, TokenUser, TokenInformation, TokenInformationLength, ReturnLength);
      SizeAccountName := 0;
      SizeDomainName := 0;
      LookupAccountSid(nil, PSIDAndAttributes(TokenInformation)^.Sid, nil, SizeAccountName,
        nil, SizeDomainName, SID_NAME_USE(peUse));
      GetMem(AccountName, (SizeAccountName +1) *8);
      GetMem(DomainName, (SizeDomainName +1) *8);
      LookupAccountSid(nil, PSIDAndAttributes(TokenInformation)^.Sid, AccountName, SizeAccountName,
        DomainName, SizeDomainName, SID_NAME_USE(peUse));
      if User then
        Result := AccountName
      else
        Result := DomainName;
      FreeMem(DomainName);
      FreeMem(AccountName);
      FreeMem(TokenInformation);
      CloseHandle(TokenHandle);
    end
    else
    begin
      UserCount := MAX_PATH +1;
      GetMem(UserName, (MAX_PATH +1)*8);
      GetUserName(UserName, UserCount);
      if User then
        Result := UserName
      else
        Result := '';
      FreeMem(UserName);
    end;
  except
    Result := '';
  end;
end;

function GetSystemMemoryMb(aSystemMem: TSystemMem): Integer;

type
  
  TMemoryStatusEx = packed record
    dwLength: DWORD;
    dwMemoryLoad: DWORD;
    ullTotalPhys: Int64;
    ullAvailPhys: Int64;
    ullTotalPageFile: Int64;
    ullAvailPageFile: Int64;
    ullTotalVirtual: Int64;
    ullAvailVirtual: Int64;
    ullAvailExtendedVirtual: Int64;
  end;
  
  PFNGlobalMemoryStatusEx = function(var lpBuffer: TMemoryStatusEx): BOOL; stdcall;
const
  BytesToMb = 1024 * 1024;
var
  P: Pointer;
  GlobalMemoryStatusEx: PFNGlobalMemoryStatusEx;
  CFGDLLHandle: THandle;
  MemoryStatusEx: TMemoryStatusEx; 
  MemoryStatus: TMemoryStatus;     
  nResult: Integer;
begin
  nResult := -1;
  GlobalMemoryStatusEx := nil;
  CFGDLLHandle := 0;
  P := nil;
  
  CFGDLLHandle := LoadLibrary('kernel32.dll');
  if (CFGDLLHandle <> 0) then
    begin
    P := GetProcAddress(CFGDLLHandle, 'GlobalMemoryStatusEx');
    if (P = nil) then
      begin
      FreeLibrary(CFGDLLHandle);
      CFGDllHandle := 0;
      end
    else
      GlobalMemoryStatusEx := PFNGlobalMemoryStatusEx(P);
    end;
  if (@GlobalMemoryStatusEx <> nil) then
    begin
    ZeroMemory(@MemoryStatusEx, SizeOf(TMemoryStatusEx));
    MemoryStatusEx.dwLength := SizeOf(TMemoryStatusEx);
    GlobalMemoryStatusEx(MemoryStatusEx);
    case aSystemMem of
      smMemoryLoad    : nResult := Round(MemoryStatusEx.dwMemoryLoad);
      smTotalPhys     : nResult := Round(MemoryStatusEx.ullTotalPhys / BytesToMb);
      smAvailPhys     : nResult := Round(MemoryStatusEx.ullAvailPhys / BytesToMb);
      smTotalPageFile : nResult := Round(MemoryStatusEx.ullTotalPageFile / BytesToMb);
      smAvailPageFile : nResult := Round(MemoryStatusEx.ullAvailPageFile / BytesToMb);
      smTotalVirtual  : nResult := Round(MemoryStatusEx.ullTotalVirtual / BytesToMb);
      smAvailVirtual  : nResult := Round(MemoryStatusEx.ullAvailVirtual / BytesToMb);
      end;
    FreeLibrary(CFGDLLHandle);
    end;
  
  if nResult = -1 then
    begin
    with MemoryStatus do
      begin
      dwLength := SizeOf(TMemoryStatus);
      Windows.GlobalMemoryStatus(MemoryStatus);
      case aSystemMem of
        smMemoryLoad    : nResult := Round(dwMemoryLoad);
        smTotalPhys     : nResult := Round(dwTotalPhys / BytesToMb);
        smAvailPhys     : nResult := Round(dwAvailPhys / BytesToMb);
        smTotalPageFile : nResult := Round(dwTotalPageFile / BytesToMb);
        smAvailPageFile : nResult := Round(dwAvailPageFile / BytesToMb);
        smTotalVirtual  : nResult := Round(dwTotalVirtual / BytesToMb);
        smAvailVirtual  : nResult := Round(dwAvailVirtual / BytesToMb);
        end;
      end;
    end;
  Result := nResult;
end;

procedure GetLicenseInfo(var User, Organization: String);
var
  s: String;
  r: TRegistry;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then s := 'Windows NT' 
    else s := 'Windows'; 
  r := TRegistry.Create;
  r.RootKey := HKEY_LOCAL_MACHINE;
  r.Access := KEY_READ or REG_ACCESS_CONST;
  r.OpenKey('SOFTWARE\Microsoft\' + s + '\CurrentVersion\', false); 
  User := r.ReadString('RegisteredOwner'); 
  Organization := r.ReadString('RegisteredOrganization'); 
  r.Free;
end;

procedure GetLanguage(var LangText: String; var LangInt: Integer);
var
  p: PChar;
  s: String;
  i: Integer;
  c: Cardinal;
  vi, viX: Pointer;
begin
  GetMem(p, (MAX_PATH+1)*8);
  GetSystemDirectory(p, MAX_PATH);
  s := AssertDir(p) + 'winver.exe';
  i := GetFileVersionInfoSize(PChar(s), c);
  GetMem(vi, i*8);
  GetFileVersionInfo(PChar(s), 0, i, vi);
  VerQueryValue(vi, '\VarFileInfo\Translation', viX, c); 
  LangInt := DWord(viX^);
  VerLanguageName(LangInt, p, MAX_PATH);
  LangText := p;
  LangInt := LangInt and $FFFF;
  FreeMem(p);
  FreeMem(vi);
end;

function IsBuildLabUpdate1: Boolean;
var
  s: String;
  r: TRegistry;
begin
  Result := false;
  try
    r := TRegistry.Create;
    r.RootKey := HKEY_LOCAL_MACHINE;
    r.Access := KEY_READ;
    if r.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows NT\CurrentVersion') then
    begin
      if r.ValueExists('BuildLabEx') then
      begin
        
        s := r.ReadString('BuildLabEx');
        Delete(s, 1, AnsiPos('.', s));
        Delete(s, AnsiPos('.', s), Length(s));
        Result := StrToInt(s) >= 17031;
      end;
      r.CloseKey;
    end;
    r.Free;
  except
    Result := false;
  end;
end;

function IsBuildLabUpdate2: Boolean;
var
  s: String;
  v: TOSVersionInfo;
begin
  Result := false;
  FillChar(v, SizeOf(TOSVersionInfo), 0);
  v.dwOSVersionInfoSize := SizeOf(v);
  if GetVersionEx(v) then
    Result := v.dwBuildNumber >= 10586;
end;

function IsBuildLabUpdate3: Boolean;
var
  s: String;
  v: TOSVersionInfo;
begin
  Result := false;
  FillChar(v, SizeOf(TOSVersionInfo), 0);
  v.dwOSVersionInfoSize := SizeOf(v);
  if GetVersionEx(v) then
    Result := v.dwBuildNumber >= 14393; 
end;

function IsBuildLabUpdate4: Boolean;
var
  s: String;
  v: TOSVersionInfo;
begin
  Result := false;
  FillChar(v, SizeOf(TOSVersionInfo), 0);
  v.dwOSVersionInfoSize := SizeOf(v);
  if GetVersionEx(v) then
    Result := v.dwBuildNumber >= 15063; 
end;

function IsBuildLabUpdate5: Boolean;
var
  s: String;
  v: TOSVersionInfo;
begin
  Result := false;
  FillChar(v, SizeOf(TOSVersionInfo), 0);
  v.dwOSVersionInfoSize := SizeOf(v);
  if GetVersionEx(v) then
    Result := v.dwBuildNumber >= 16299; 
end;

function IsBuildLabUpdate6: Boolean;
var
  s: String;
  v: TOSVersionInfo;
begin
  Result := false;
  FillChar(v, SizeOf(TOSVersionInfo), 0);
  v.dwOSVersionInfoSize := SizeOf(v);
  if GetVersionEx(v) then
    Result := v.dwBuildNumber >= 17134; 
end;

function IsBuildLabUpdate7: Boolean;
var
  s: String;
  v: TOSVersionInfo;
begin
  Result := false;
  FillChar(v, SizeOf(TOSVersionInfo), 0);
  v.dwOSVersionInfoSize := SizeOf(v);
  if GetVersionEx(v) then
    Result := v.dwBuildNumber >= 17763; 
end;

function IsBuildLabUpdate8: Boolean;
var
  s: String;
  v: TOSVersionInfo;
begin
  Result := false;
  FillChar(v, SizeOf(TOSVersionInfo), 0);
  v.dwOSVersionInfoSize := SizeOf(v);
  if GetVersionEx(v) then
    Result := v.dwBuildNumber >= 18362; 
end;

function IsBuildLabUpdate9: Boolean;
var
  s: String;
  v: TOSVersionInfo;
begin
  Result := false;
  FillChar(v, SizeOf(TOSVersionInfo), 0);
  v.dwOSVersionInfoSize := SizeOf(v);
  if GetVersionEx(v) then
    Result := v.dwBuildNumber >= 18363; 
end;

function IsBuildLabUpdate10: Boolean;
var
  s: String;
  v: TOSVersionInfo;
begin
  Result := false;
  FillChar(v, SizeOf(TOSVersionInfo), 0);
  v.dwOSVersionInfoSize := SizeOf(v);
  if GetVersionEx(v) then
    Result := v.dwBuildNumber >= 19041; 
end;

function IsBuildLabUpdate11: Boolean;
var
  s: String;
  v: TOSVersionInfo;
begin
  Result := false;
  FillChar(v, SizeOf(TOSVersionInfo), 0);
  v.dwOSVersionInfoSize := SizeOf(v);
  if GetVersionEx(v) then
    Result := v.dwBuildNumber >= 19042; 
end;

function IsServer: Boolean;
type
  TOSVersionInfoEx = packed record
    dwOSVersionInfoSize: DWORD;
    dwMajorVersion: DWORD;
    dwMinorVersion: DWORD;
    dwBuildNumber: DWORD;
    dwPlatformId: DWORD;
    szCSDVersion: array[0..127] of Char;
    wServicePackMajor: WORD;
    wServicePackMinor: WORD;
    wSuiteMask: WORD;
    wProductType: Byte;
    wReserved: Byte;
  end;
var
  OSVI: TOSVersionInfoEx;  
  POSVI: POSVersionInfo;   
begin
  
  FillChar(OSVI, SizeOf(OSVI), 0);
  
  POSVI := @OSVI;
  
  OSVI.dwOSVersionInfoSize := SizeOf(TOSVersionInfoEx);
  Result := GetVersionEx(POSVI^);
  if Result then
    Result := OSVI.wProductType <> $0000001;
end;

procedure GetWindowsVersion(var NT: Boolean; var vMax, vMin, vSP: Integer);

var
  
  os: TOSVersionInfo;
  i: Integer;
  s: String;
  
begin
  
  os.dwOSVersionInfoSize := SizeOf(os);
  GetVersionEx(os);
  NT := os.dwPlatformId = VER_PLATFORM_WIN32_NT;
  vMax := os.dwMajorVersion;
  vMin := os.dwMinorVersion;
  if ((vMax = 4) and (vMin = 10)) and not NT then
    
    if os.dwBuildNumber >= 67766446 then
      vMin := 11; 
  
  begin
    vSP := 0;
    for i := 10 downto 1 do
      if Pos(IntToStr(i), os.szCSDVersion) <> 0 then
      begin
        vSP := i;
        Break;
      end;
  end;
  
end;

procedure GetColorCount(var Colors: Int64; var Bits: Integer);
var
  i: Integer;
  dc: HDC;
begin
  dc := CreateDC('DISPLAY', nil, nil, nil); 
  Bits := GetDeviceCaps(dc, BITSPIXEL);
  Colors := 2;
  for i := 1 to Bits do
    Colors := Colors * 2;
  DeleteDC(dc);
end;

procedure GetScreenResolution(var X, Y: Integer);
begin
  X := GetSystemMetrics(SM_CXSCREEN);
  Y := GetSystemMetrics(SM_CYSCREEN);
end;

procedure GetFreeMemory(Total: Boolean; var memPhysical, memPaging, memVirtual: Int64);
var
  m: TMemoryStatus;
begin
  GlobalMemoryStatus(m);
  if not Total then
  begin
    memPhysical := m.dwAvailPhys;
    memPaging := m.dwAvailPageFile;
    memVirtual := m.dwAvailVirtual;
  end
  else
  begin
    memPhysical := m.dwTotalPhys;
    memPaging := m.dwTotalPageFile;
    memVirtual := m.dwTotalVirtual;
  end;
end;

function IsUserAdminEx: Boolean;
begin
  if Win32Platform = VER_PLATFORM_WIN32_NT then
    Result := IsUserParticular(DOMAIN_ALIAS_RID_ADMINS)
  else
    Result := True;
end;

function MyGetShortPathName(lpszLongPath: LPCSTR; lpszShortPath: LPSTR;
  cchBuffer: DWORD): DWORD;
var
  b: Boolean;
begin
  Result := 0;
  b := not (GetShortPathName(lpszLongPath, lpszShortPath, cchBuffer) = 0);
  if not b then
    b := not (GetShortPathName(PChar('\\?\' + lpszLongPath), lpszShortPath, cchBuffer) = 0);
  if not b then
  begin
    Result := Length(lpszLongPath) +1;
    if (lpszShortPath <> nil) and (cchBuffer >= Result) then
    begin
      StrCopy(lpszShortPath, lpszLongPath);
      Result := Result -1;
    end;
  end
  else
    Result := Length(lpszShortPath);
end;

function EnsureSubstPathA(const s: String; Force: Boolean = false): String; overload;
begin
  Result := s;
end;

function EnsureSubstPathW(const ws: WideString; Force: Boolean): String;
begin
  Result := ws;
end;

function MySHGetPathFromIDList(pidl: PItemIDList; pszPath: PChar): BOOL;
type
  TSHGetPathFromIDListW = function(pidl: PItemIDList; pszPath: PChar): BOOL; stdcall;
var
  s: String;
  h: THandle;
  f: TSHGetPathFromIDListW;
  pszPathW: PChar;
begin
  if Win32Platform <> VER_PLATFORM_WIN32_NT then
  begin
    Result := SHGetPathFromIDList(pidl, pszPath);
    Exit;
  end;
  Result := SHGetPathFromIDList(pidl, pszPath);
  s := pszPath;
  if (Pos('?', s) <> 0) or (not DirectoryExists(s)) then 
  begin
    GetMem(pszPathW, (MAX_PATH +1) * 128);
    h := LoadLibrary('shell32.dll');
    Pointer(f) := nil;
    Pointer(f) := GetProcAddress(h, 'SHGetPathFromIDListW');
    if Pointer(f) <> nil then
      Result := f(pidl, pszPathW)
    else
    begin
      pszPathW := '';
      Result := false;
    end;
    FreeLibrary(h);
    MyGetShortPathName(pszPathW, pszPathW, (MAX_PATH +1) * 8);
    
    s := IncludeTrailingPathDelimiter(EnsureSubstPathA(ExtractFilePath(pszPathW))) + ExtractFileName(pszPathW);
    FreeMem(pszPathW);
    StrCopy(pszPath, PChar(s));
  end;
end;

function MySHGetFolderPath(CSIDL: Integer; var Path: String): Boolean;
type
  TShGetFolderPathW = function(hWndOwner: HWnd; csidl: Integer; hToken:
    THandle; dwReserved: DWord; lpszPath: PChar): HResult; stdcall;
var
  h: THandle;
  i: Integer;
  WideProc: TShGetFolderPathW;
  pszPathW: PChar;
begin
  Result := false;
  h := LoadLibrary('shfolder.dll');
  if h = 0 then Exit;
  Pointer(WideProc) := GetProcAddress(h, 'SHGetFolderPathW');
  if @WideProc <> nil then
  begin
    GetMem(pszPathW, (MAX_PATH +1) * 128);
    i := WideProc(GetDesktopWindow, CSIDL, 0, 0, pszPathW);
    Result := (i <> E_FAIL) and (i <> E_INVALIDARG);
    if Result then
      Result := MyGetShortPathName(pszPathW, pszPathW, (MAX_PATH +1) * 8) <> 0;
    if Result then
      Path := EnsureSubstPathW(pszPathW);
    FreeMem(pszPathW);
  end;
  FreeLibrary(h);
end;
{$ENDIF}

{$IFDEF DARWIN}
function GetSignificantDir(DirLocation: qword; DomainMask: qword; count: byte): string;
var
  paths : NSArray;
begin
  paths := NSSearchPathForDirectoriesInDomains(DirLocation, DomainMask, True);
  if(count < paths.count) then
    Result := NSString(paths.objectAtIndex(0)).UTF8String
  else
    Result := '';
end;
{$ENDIF}

function PromptForFileName(var AFileName: string; const AFilter: string = '';
  const ADefaultExt: string = ''; const ATitle: string = '';
  const AInitialDir: string = ''; SaveDialog: Boolean = False): Boolean;
{$IFNDEF NOGUI}
var
  Dialog: TOpenDialog;
begin
  if SaveDialog then
  begin
    Dialog := TSaveDialog.Create(nil);
    Dialog.Options := Dialog.Options + [ofOverwritePrompt];
  end
  else
    Dialog := TOpenDialog.Create(nil);
  with Dialog do
  try
    Title := ATitle;
    DefaultExt := ADefaultExt;
    if AFilter = '' then
      Filter := SDefaultFilter else
      Filter := AFilter;
    InitialDir := AInitialDir;
    FileName := AFileName;
    Result := Execute;
    if Result then
      AFileName := FileName;
  finally
    Free;
  end;
{$ELSE}
var
  i: Integer;
  s: String;
begin
  WriteLn; 
  WriteLn(ATitle + ':');
  for i := 1 to Length(ATitle) +1 do
    {$IFDEF WINDOWS}
    Write('=');
    {$ELSE}
    Write('=');
    {$ENDIF}
  WriteLn;
  if AInitialDir <> '' then
    WriteLn('Default Directory "' + AInitialDir + '"');
  if ADefaultExt <> '' then
    WriteLn('Default Extension "' + ADefaultExt + '"');
  for i := 1 to Length(ATitle) +1 do
    {$IFDEF WINDOWS}
    Write('=');
    {$ELSE}
    Write('=');
    {$ENDIF}
  WriteLn;
  WriteLn('<enter to cancel selection>');
  ReadLn(s);
  if s <> '' then
  begin
    if AInitialDir <> '' then
      if ExtractFilePath(s) = '' then
        s := AssertDir(AInitialDir) + s;
    if ADefaultExt <> '' then
      if ExtractFileExt(s) = '' then
        s := s + ADefaultExt;
    AFileName := s;
    Result := True;
  end
  else
    Result := false;
{$ENDIF}
end;

procedure GetSpecialFolder(CSIDL: Integer; var Path: String);
var
  {$IFDEF WINDOWS}
  pidl: PItemIDList;
  im: IMalloc;
  {$ENDIF}
  r: TRegistry;
  s: String;
  q, qX: QWord;
  p: PChar;
begin
  
  Path := '';
  {$IFDEF DARWIN}
  s := '';
  {$ENDIF}
  
  case CSIDL of
    
    {$IFNDEF WINDOWS}
    $3e:
    {$IFDEF DARWIN}
    begin
      q := NSUserDirectory;
      qX := NSLocalDomainMask;
    end;
    {$ELSE}
    s := '/home/'; 
    {$ENDIF}
    $28:
    {$IFDEF DARWIN}
    begin
      
      {$IFNDEF NOGUI}
      s := NSStringToString(NSHomeDirectory); 
      {$ELSE}
      s := ExpandFileName('~/');
      {$ENDIF}
      
    end;
    {$ELSE}
    s := ExpandFileName('~/'); 
    {$ENDIF}
    $23:
    {$IFDEF DARWIN}
    begin
      q := NSApplicationSupportDirectory;
      qX := NSLocalDomainMask;
    end;
    {$ELSE}
    s := '/etc/'; 
    {$ENDIF}
    {$ENDIF}
    $1a:
    {$IFDEF WINDOWS}
    s := 'AppData';
    {$ELSE}
    {$IFDEF DARWIN}
    begin
      q := NSApplicationSupportDirectory;
      qX := NSUserDomainMask;
    end;
    {$ELSE}
    s := ExpandFileName('~/.etc/'); 
    {$ENDIF}
    {$ENDIF}
    $20:
    {$IFDEF WINDOWS}
    s := 'Cache';
    {$ELSE}
    {$IFDEF DARWIN}
    begin
      q := NSCachesDirectory;
      qX := NSUserDomainMask;
    end;
    {$ELSE}
    s := ExpandFileName('~/.cache/');
    {$ENDIF}
    {$ENDIF}
    $21:
    {$IFDEF WINDOWS}
    s := 'Cookies';
    {$ELSE}
    begin
    end;
    {$ENDIF}
    $0:
    {$IFDEF WINDOWS}
    s := 'Desktop';
    {$ELSE}
    {$IFDEF DARWIN}
    begin
      q := NSDesktopDirectory;
      qX := NSUserDomainMask;
    end;
    {$ELSE}
    s := ExpandFileName('~/Desktop/');
    {$ENDIF}
    {$ENDIF}
    $6:
    {$IFDEF WINDOWS}
    s := 'Favorites';
    
    {$ELSE}
    begin
    end;
    {$ENDIF}
    $1c:
    {$IFDEF WINDOWS}
    s := 'Local AppData';
    {$ELSE}
    {$IFDEF DARWIN}
    begin
      q := NSLibraryDirectory;
      qX := NSUserDomainMask;
    end;
    {$ELSE}
    s := ExpandFileName('~/.config/'); 
    {$ENDIF}
    {$ENDIF}
    $d:
    {$IFDEF WINDOWS}
    s := 'My Music';
    {$ELSE}
    {$IFDEF DARWIN}
    begin
      q := NSMusicDirectory;
      qX := NSUserDomainMask;
    end;
    {$ELSE}
    s := ExpandFileName('~/Music/'); 
    {$ENDIF}
    {$ENDIF}
    $27:
    {$IFDEF WINDOWS}
    s := 'My Pictures';
    {$ELSE}
    {$IFDEF DARWIN}
    begin
      q := NSPicturesDirectory;
      qX := NSUserDomainMask;
    end;
    {$ELSE}
    s := ExpandFileName('~/Pictures/'); 
    {$ENDIF}
    {$ENDIF}
    $e:
    {$IFDEF WINDOWS}
    s := 'My Video';
    {$ELSE}
    {$IFDEF DARWIN}
    begin
      q := NSMoviesDirectory;
      qX := NSUserDomainMask;
    end;
    {$ELSE}
    s := ExpandFileName('~/Videos/'); 
    {$ENDIF}
    {$ENDIF}
    $13:
    {$IFDEF WINDOWS}
    s := 'NetHood';
    {$ELSE}
    begin
    end;
    {$ENDIF}
    $5:
    {$IFDEF WINDOWS}
    s := 'Personal';
    {$ELSE}
    {$IFDEF DARWIN}
    begin
      
      q := NSDocumentDirectory;
      qX := NSUserDomainMask;
    end;
    {$ELSE}
    s := ExpandFileName('~/Documents/'); 
    {$ENDIF}
    {$ENDIF}
    $2e:
    {$IFDEF WINDOWS}
    s := 'Personal';
    {$ELSE}
    {$IFDEF DARWIN}
    begin
      
      q := NSDocumentDirectory;
      qX := NSUserDomainmask;
    end;
    {$ELSE}
    s := ExpandFileName('~/Documents/'); 
    {$ENDIF}
    {$ENDIF}
    $1b:
    {$IFDEF WINDOWS}
    s := 'PrintHood';
    {$ELSE}
    begin
    end;
    {$ENDIF}
    $2:
    {$IFDEF WINDOWS}
    s := 'Programs';
    {$ELSE}
    {$IFDEF LINUX}
    s := ExpandFileName('~/.local/share/applications');
    {$ELSE}
    begin
    end;
    {$ENDIF}
    {$ENDIF}
    {$IFDEF LINUX}
    
    $17: s := ExpandFileName('/usr/share/applications');
    {$ENDIF}
    $8:
    {$IFDEF WINDOWS}
    s := 'Recent';
    {$ELSE}
    begin
    end;
    {$ENDIF}
    $9:
    {$IFDEF WINDOWS}
    s := 'SendTo';
    {$ELSE}
    begin
    end;
    {$ENDIF}
    $b:
    {$IFDEF WINDOWS}
    s := 'Start Menu';
    {$ELSE}
    begin
    end;
    {$ENDIF}
    $7:
    {$IFDEF WINDOWS}
    s := 'Startup';
    {$ELSE}
    begin
    end;
    {$ENDIF}
    $15:
    {$IFDEF WINDOWS}
    s := 'Templates';
    {$ELSE}
    begin
    end;
    {$ENDIF}
  else
    s := ''; 
  end;
  {$IFNDEF WINDOWS}
  {$IFDEF DARWIN}
  if s = '' then
    Path := GetSignificantDir(q, qX, 0)
  else
    Path := s;
  {$ELSE}
  Path := s;
  {$ENDIF}
  if Path <> '' then
  begin
    Path := IncludeTrailingPathDelimiter(Path);
    Exit;
  end;
  {$ELSE}
  if s <> '' then
  try
    r := TRegistry.Create;
    if Is64Bit then
      r.Access := KEY_READ or $100 
    else
      r.Access := KEY_READ;
    r.RootKey := HKEY_CURRENT_USER;
    if r.KeyExists('Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders') then
    begin
      if r.OpenKeyReadOnly('Software\Microsoft\Windows\CurrentVersion\Explorer\User Shell Folders') then
      begin
        if r.ValueExists(s) then
        begin
          if r.ReadString(s) <> '' then
          begin
            s := r.ReadString(s);
            
            if AnsiPos('%', s) <> 0 then
            begin
              
              s := ExpandEnvironmentString2(s);
            end;
            s := AssertDir(s);
          end
          else
            s := ''; 
        end
        else
          s := ''; 
        r.CloseKey;
      end
      else
        s := ''; 
    end
    else
      s := ''; 
    r.Free;
  except
    s := ''; 
  end;
  if s <> '' then
  begin
    Path := s;
    Exit;
  end;
  {$ENDIF}
  
  try
    
    {$IFNDEF WINDOWS}
    {$IFDEF DARWIN}
    if CSIDL = $26 then
    begin
      q := NSApplicationDirectory;
      qX := NSUserDomainMask;
    end
    else
    if CSIDL = $2b then
    begin
      q := NSApplicationDirectory;
      qX := NSLocalDomainMask;
    end;
    Path := GetSignificantDir(q, qX, 0);
    {$ELSE}
    
    if CSIDL = $26 then Path := ExpandFileName('/usr/bin/') 
    
      else if CSIDL = $2b then Path := '/usr/share/';
    {$ENDIF}
    if Path <> '' then
      Path := IncludeTrailingPathDelimiter(Path);
    {$ELSE}
    GetMem(p, (MAX_PATH+1)*8);
    if ((CSIDL = $26) or (CSIDL = $2b)) or
      (ShGetSpecialFolderLocation(GetDesktopWindow, CSIDL, pidl) <> NOERROR) then
    begin
      
      if (CSIDL = $26) or (CSIDL = $2b) then
      try
        r := TRegistry.Create;
        r.Access := KEY_READ or REG_ACCESS_CONST;
        r.RootKey := HKEY_LOCAL_MACHINE;
        r.OpenKey('SOFTWARE\Microsoft\Windows\CurrentVersion', false); 
        if CSIDL = $26 then
          Path := r.ReadString('ProgramFilesDir') 
        else
          Path := r.ReadString('CommonFilesDir'); 
        r.Free;
      except
      end;
      Path := AssertDir(Path);
      FreeMem(p);
      Exit;
    end;
    MySHGetPathFromIDList(pidl, p);
    Path := AssertDir(p);
    FreeMem(p);
    SHGetMalloc(im);
    im.Free(pidl);
    {$ENDIF}
  finally
    {$IFDEF WINDOWS}
    if Path = '' then
      
      MySHGetFolderPath(CSIDL, Path);
    {$ENDIF}
  end;
end;

function GetWindowsDirectoryWin(lpBuffer: PChar; uSize: Cardinal): Cardinal; stdcall;
begin
  Result := 0;
  {$IFDEF WINDOWS}
  Result := GetWindowsDirectory(lpBuffer, uSize);
  {$ENDIF}
end;

function GetSystemDirectoryWin(lpBuffer: PChar; uSize: Cardinal): Cardinal; stdcall;
begin
  Result := 0;
  {$IFDEF WINDOWS}
  Result := GetSystemDirectory(lpBuffer, uSize);
  {$ENDIF}
end;

function ExpandEnvironmentStrings1(const s: String; IgnoreCase: Boolean = True): String; 
{$IFDEF windows}
const
  ENV_PREFIX = '%';
  ENV_POSTFIX = '%';
{$ELSE}
const
  ENV_PREFIX ='$';
  ENV_POSTFIX = '';
{$ENDIF}
var
  envs: TStringList;
  aEnvValue: String;
  aEnvName: String;
  flags: TReplaceFlags;
  i: Integer;
begin
  Result := s;
  if Pos(ENV_PREFIX, Result) = 0 then exit;

  if IgnoreCase then
    flags := [rfReplaceAll, rfIgnoreCase]
  else
    flags := [rfReplaceAll];

  envs := TStringList.Create;
  envs.Sorted := ENV_POSTFIX = '';
  
  for i := GetEnvironmentVariableCount downto 1 do
    envs.Add(GetEnvironmentString(i));

  for i := envs.Count - 1 downto 0 do
  begin
    envs.GetNameValue(i, aEnvName, aEnvValue);
    Result := StringReplace(Result, ENV_PREFIX+aEnvName+ENV_POSTFIX, aEnvValue, flags);
    if Pos(ENV_PREFIX, Result) = 0 then break;
  end;

  envs.Destroy;
end;

function ExpandEnvironmentString2(s: String): String; 
Var i, k: Integer;
    sl: TStringList;
    s2: String;
    bP, bD: Boolean;
Begin
  Result := s;
  bP := Pos('%', s) > 0;
  bD := Pos('$', s) > 0;
  If Not(bP Or bD) Then Exit; 
  sl := TStringList.Create;
  sl.Sorted := bD;
  
  For i := GetEnvironmentVariableCount DownTo 1 Do 
  Begin
    s2 := GetEnvironmentStringUTF8(i);
    If Length(s2) >= 2 Then
      If s2[1] <> '=' Then 
        sl.Add(s2);
  end;

  k := 0;
  Repeat 
    s2 := Result;
    For i := sl.Count - 1 DownTo 0 Do
    Begin
      If bP Then
      Begin
        Result := StringReplace(Result, '%' + sl.Names[i] + '%', sl.ValueFromIndex[i], [rfReplaceAll, rfIgnoreCase]);
        If Pos('%', Result) = 0 Then bP := False;
      end;
      If bD Then
      Begin
        Result := StringReplace(Result, '$' + sl.Names[i], sl.ValueFromIndex[i], [rfReplaceAll]);
        If Pos('$', Result) = 0 Then bD := False;
      end;
      If Not(bP Or bD) Then Break;
    end;
    If Not(bP Or bD) Then Break;
    If SameText(s2, Result) Then Break; 
    Inc(k);
    If k > sl.Count - 2 Then Break; 
  Until True;
  sl.Free;
end;

procedure LazShimSetAttributes(Path, Attributes: String);
var
  l: TStringList;
begin
  l := TStringList.Create;
  l.Add(Attributes);
  l.Add(Path);
  LaunchAppAndWait2('chmod', l, True, True);
  l.Free;
end;

function LazShimGetAttributes(Path: String): String;
var
  l: TStringList;
begin
  l := TStringList.Create;
  l.Add('-f');
  l.Add('"%Lp"');
  l.Add(Path);
  LaunchAppAndWait3('getmode', l, True, True, Result);
  l.Free;
end;

function GetSysWow64DirWin: String;
var
  {$IFDEF WINDOWS}
  GetSystemWow64DirectoryFunc: function(lpBuffer: PChar;  uSize: UINT): UINT; stdcall;
  {$ENDIF}
  Res: Integer;
  Buf: array[0..MAX_PATH] of Char;
begin
  Result := '';
  {$IFDEF WINDOWS}
  Pointer(GetSystemWow64DirectoryFunc) := GetProcAddress(GetModuleHandle(kernel32), 'GetSystemWow64DirectoryW');
  if Assigned(GetSystemWow64DirectoryFunc) then
  begin
    Res := GetSystemWow64DirectoryFunc(Buf, SizeOf(Buf) div SizeOf(Buf[0]));
    if (Res > 0) and (Res < SizeOf(Buf) div SizeOf(Buf[0])) then
      Result := Buf;
  end;
  {$ENDIF}
end;

function MyGetCurrentDir: String;
{$IFDEF WINDOWS}
var
  p: PChar;
{$ENDIF}
begin
  {$IFDEF WINDOWS}
  GetMem(p, MAX_PATH);
  GetCurrentDirectory(MAX_PATH, p);
  Result := AssertDir(p);
  FreeMem(p);
  {$ELSE}
  GetDir(0, Result);
  Result := AssertDir(Result);
  if Result = '/' then
  begin
    Result := AssertDir(ExtractFilePath(ParamStr(0))); 
    {$IFDEF DARWIN}
    Delete(Result, AnsiPos('.app/Contents/MacOS/', Result), Length(Result));
    Result := AssertDir(ExtractFilePath(Result));
    {$ENDIF}
  end;
  {$ENDIF}
end;

function IsFilteredProp(Prop: String): Boolean;
begin
  Result := True;
  if Prop = 'HotTrackColor' then Exit;
  if Prop = 'HotTrackColorType' then Exit;
  if Prop = 'HotTrack' then Exit;
  if Prop = 'DisabledColor' then Exit;
  if Prop = 'LightTextStyle' then Exit;
  if Prop = 'HighlightColor' then Exit;
  if Prop = 'TextHighlightColor' then Exit;
  if Prop = 'TextShadowColor' then Exit;
  if Prop = 'TextShadowDepth' then Exit;
  if Prop = 'TextStyle' then Exit;
  if Prop = 'UseCustomGlyphs' then Exit;
  if Prop = 'WinMaskColor' then Exit;
  if Prop = 'About' then Exit;
  if Prop = 'AllowGrayed' then Exit;
  if Prop = 'CustomGlyphs' then Exit;
  if Prop = 'DefaultMonitor' then Exit;
  if Prop = 'OldCreateOrder' then Exit;
  
  if Prop = 'PrintScale' then Exit;
  if Prop = 'Scaled' then Exit;
  if Prop = 'Action' then Exit;
  if Prop = 'Anchors' then Exit;
  if Prop = 'Constraints' then Exit;
  if Prop = 'DragKind' then Exit;
  if Prop = 'DockSite' then Exit;
  if Prop = 'HelpKeyword' then Exit;
  if Prop = 'HelpType' then Exit;
  
  if Prop = 'DragCursor' then Exit;
  if Prop = 'DragMode' then Exit;
  if Prop = 'PopupMenu' then Exit;
  if Prop = 'HelpContext' then Exit;
  if Prop = 'UseDockManager' then Exit;
  if Prop = 'ActiveControl' then Exit;
  if Prop = 'HelpContext' then Exit;
  if Prop = 'HelpFile' then Exit;
  if Prop = 'KeyPreview' then Exit;
  if Prop = 'Menu' then Exit;
  if Prop = 'ObjectMenuItem' then Exit;
  if Prop = 'WindowMenu' then Exit;
  if Prop = 'ModalResult' then Exit;
  if Prop = 'IntegralHeight' then Exit;
  
  if Prop = 'ItemHeight' then Exit;
  if Prop = 'Locked' then Exit;
  if Prop = 'Ctl3D' then Exit;
  if Prop = 'Tag' then Exit;
  
  if Prop = 'VisitedMaxCount' then Exit;
  if Prop = 'ServerRoot' then Exit;
  if Prop = 'ImageCacheCount' then Exit;
  if Prop = 'HistoryMaxCount' then Exit;
  
  if AnsiPos('On', Prop) <> 0 then Exit;
  if AnsiPos('Scroll', Prop) <> 0 then Exit;
  if AnsiPos('Parent', Prop) <> 0 then Exit;
  if AnsiPos('Ime', Prop) <> 0 then Exit;
  if AnsiPos('OEM', Prop) <> 0 then Exit;
  if AnsiPos('Hint', Prop) <> 0 then Exit;
  if AnsiPos('Frame', Prop) <> 0 then Exit;
  if AnsiPos('Tab', Prop) <> 0 then Exit;
  if AnsiPos('Images', Prop) <> 0 then Exit;
  if AnsiPos('Folder', Prop) <> 0 then Exit;
  Result := false;
end;

function EncodeStr(Value: AnsiString): AnsiString;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to Length(Value) do
    Result := Result + AnsiChar(Byte(Value[i]) xor 39);
end;

function Is64BitOnArm: Boolean;
{$IFDEF WINDOWS}
type
  TIsWow64Process2 = function(Handle: THandle; var pProcessMachine,
    pNativeMachine: USHORT): BOOL; stdcall;
var
  IsWow64Process2: TIsWow64Process2;
  us1, us2: USHORT;
begin
  Result := false;
  Pointer(IsWow64Process2) := GetProcAddress(GetModuleHandle('kernel32.dll'), 'IsWow64Process2');
  if Assigned(IsWow64Process2) then
  begin
    if IsWow64Process2(GetCurrentProcess, us1, us2) then
      if us2 = $AA64 then
        Result := True;
  end;
{$ELSE}
begin
  
{$ENDIF}
end;

function Is64Bit(Compatibility: Boolean = false): Boolean;
{$IFDEF WINDOWS}
type
  TIsWow64Process = function( 
    Handle: THandle;
    var Res: BOOL
  ): BOOL; stdcall;
var
  IsWow64Result: BOOL;              
  IsWow64Process: TIsWow64Process;  
begin
  
  Pointer(IsWow64Process) := GetProcAddress(
    GetModuleHandle('kernel32'), 'IsWow64Process' 
  );
  if Assigned(IsWow64Process) then
  begin
    
    if not IsWow64Process(GetCurrentProcess, IsWow64Result) then
      Result := false
    else
      
      Result := IsWow64Result;
  end
  else
    
    Result := False;
  if not Result then
    if not Compatibility then
      if Is64BitOnArm then
        Result := True;
{$ELSE}
begin
  Result := SizeOf(Pointer) > 4;
{$ENDIF}
end;

function MoveFile(Source, Target: String): Boolean;
begin
  Result := RenameFile(Source, Target);
end;

function RemoveDirectory(Path: String): Boolean;
begin
  Result := RemoveDir(Path);
end;

function LangToCode(Language: String): String;
begin
  Result := '1033'; 
  if AnsiUpperCase(Language) = 'ARABIC' then Result := '1025'; 
  if AnsiUpperCase(Language) = 'CATALAN' then Result := '1027'; 
  if AnsiUpperCase(Language) = 'CHINESE (TAIWAN)' then Result := '1028'; 
  if AnsiUpperCase(Language) = 'CHINESE (PRC)' then Result := '2052'; 
  if AnsiUpperCase(Language) = 'CZECH' then Result := '1029'; 
  if AnsiUpperCase(Language) = 'DANISH' then Result := '1030'; 
  if AnsiUpperCase(Language) = 'GERMAN' then Result := '1031'; 
  if AnsiUpperCase(Language) = 'GREEK' then Result := '1032'; 
  if AnsiUpperCase(Language) = 'ENGLISH' then Result := '1033'; 
  if AnsiUpperCase(Language) = 'SPANISH' then Result := '3082'; 
  if AnsiUpperCase(Language) = 'ESTONIAN' then Result := '1061'; 
  if AnsiUpperCase(Language) = 'FINNISH' then Result := '1035'; 
  if AnsiUpperCase(Language) = 'FRENCH' then Result := '1036'; 
  if AnsiUpperCase(Language) = 'HEBREW' then Result := '1037'; 
  if AnsiUpperCase(Language) = 'HUNGARIAN' then Result := '1038'; 
  if AnsiUpperCase(Language) = 'ITALIAN' then Result := '1040'; 
  if AnsiUpperCase(Language) = 'JAPANESE' then Result := '1041'; 
  if AnsiUpperCase(Language) = 'KOREAN' then Result := '1042'; 
  if AnsiUpperCase(Language) = 'LITHUANIAN' then Result := '1063'; 
  if AnsiUpperCase(Language) = 'LATVIAN' then Result := '1062'; 
  if AnsiUpperCase(Language) = 'DUTCH' then Result := '1043'; 
  if AnsiUpperCase(Language) = 'NORWEGIAN' then Result := '1044'; 
  if AnsiUpperCase(Language) = 'POLISH' then Result := '1045'; 
  if AnsiUpperCase(Language) = 'PORTUGUESE (BRAZIL)' then Result := '1046'; 
  if AnsiUpperCase(Language) = 'PORTUGESE (BRAZIL)' then Result := '1046'; 
  if AnsiUpperCase(Language) = 'PORTUGUESE (PORTUGAL)' then Result := '2070'; 
  if AnsiUpperCase(Language) = 'PORTUGESE (PORTUGAL)' then Result := '2070'; 
  if AnsiUpperCase(Language) = 'ROMANIAN' then Result := '1048'; 
  if AnsiUpperCase(Language) = 'RUSSIAN' then Result := '1049'; 
  if AnsiUpperCase(Language) = 'CROATIAN' then Result := '1050'; 
  if AnsiUpperCase(Language) = 'SLOVAK' then Result := '1051'; 
  if AnsiUpperCase(Language) = 'SWEDISH' then Result := '1053'; 
  if AnsiUpperCase(Language) = 'THAI' then Result := '1054'; 
  if AnsiUpperCase(Language) = 'TURKISH' then Result := '1055'; 
  if AnsiUpperCase(Language) = 'SLOVENIAN' then Result := '1060'; 
  if AnsiUpperCase(Language) = 'VIETNAMESE' then Result := '1066'; 
  if AnsiUpperCase(Language) = 'BASQUE' then Result := '1069'; 
end;

function LaunchAppAndWait(App, Cmd: String; Show, Wait: Boolean; LaunchFromIDE: Boolean = false): Integer;
var
  tp: TProcess;
begin
  tp := TProcess.Create(nil);
  tp.Executable := App;
  tp.Parameters.Delimiter := ' ';
  tp.Parameters.StrictDelimiter := True;
  tp.Parameters.DelimitedText := Cmd;
  if Show then
    tp.ShowWindow := swoShow
  else
    tp.ShowWindow := swoHide;
  
  {$IFNDEF NOGUI}
  if not LaunchFromIDE then
  begin
    tp.Options := tp.Options + [poNoConsole];
    tp.Options := tp.Options - [poNewConsole];
  end;
  {$ENDIF}
  {$IFDEF DARWIN}
  
  if FpGetEUID = 0 then
    tp.Options := tp.Options + [poUsePipes];
  {$ENDIF}
  
  try
    tp.Execute;
  except
    
  end;
  if Wait then
    tp.WaitOnExit;
  Result := tp.ExitStatus;
  tp.Free;
end;

{$IFDEF WINDOWS}
function LaunchAppAndWaitWindows(Command: String; Show, Wait: Boolean): Integer; overload;
var
  si: TStartupInfo;
  pi: TProcessInformation;
  c: Cardinal;
begin
  FillChar(si, SizeOf(si), 0);
  si.dwFlags := STARTF_USESHOWWINDOW;
  si.cb := SizeOf(si);
  if Show then
    si.wShowWindow := SW_SHOW
  else
    si.wShowWindow := SW_HIDE;
  ZeroMemory(@pi, SizeOf(pi));
  UniqueString(Command);
  if not CreateProcess(nil, PChar(Command), nil, nil, false, CREATE_NEW_CONSOLE,
    nil, nil, si, pi) then
  begin
    Result := -1;
    Exit;
  end;
  if Wait then
  repeat
    Sleep(100);
  until WaitForSingleObject(pi.hProcess, 1000) <> WAIT_TIMEOUT;
  GetExitCodeProcess(pi.hProcess, c);
  Result := c;
  CloseHandle(pi.hThread);
  CloseHandle(pi.hProcess);
end;
{$ENDIF}

function LaunchAppAndWait4(App, Cmd, Startup: String; Show, Wait: Boolean): Integer;
var
  tp: TProcess;
begin
  tp := TProcess.Create(nil);
  tp.Executable := App;
  tp.Parameters.Delimiter := ' ';
  tp.Parameters.StrictDelimiter := True;
  tp.Parameters.DelimitedText := Cmd;
  if Show then
    tp.ShowWindow := swoShow
  else
    tp.ShowWindow := swoHide;
  
  {$IFNDEF NOGUI}
  tp.Options := tp.Options + [poNoConsole];
  tp.Options := tp.Options - [poNewConsole];
  {$ENDIF}
  {$IFDEF DARWIN}
  
  if FpGetEUID = 0 then
    tp.Options := tp.Options + [poUsePipes];
  {$ENDIF}
  
  tp.CurrentDirectory := Startup;
  try
    tp.Execute;
  except
    
  end;
  if Wait then
    tp.WaitOnExit;
  Result := tp.ExitStatus;
  tp.Free;
end;

function ParseWhiteSpaceIntoMultipleStrings(WhiteSpace: String): TStringList;
var
  i: Integer;
begin
  
  Result := TStringList.Create;
  Result.Delimiter := ' ';
  Result.StrictDelimiter := True;
  Result.DelimitedText := WhiteSpace;
  Exit;
  
  for i := 1 to Result.Count do
    if AnsiPos(' ', Result[i -1]) <> 0 then
      Result[i -1] := '"' + Result[i -1] + '"'; 
  
end;

function MyFileExists(FileName: String; FollowLink: Boolean = True): Boolean;
{$IFDEF DARWIN}
var
  
  fs: TFileStream;
{$ENDIF}
begin
  {$IFDEF DARWIN}
  
  Result := FileExists(FileName);
  if (not Result) and FollowLink then 
  begin
    
    try
      
      fs := TFileStream.Create(FileName, fmOpenRead);
      
      fs.Free;
      Result := True;
      
    except
      Result := false;
      
    end;
  end;
  {$ELSE}
  Result := FileExists(FileName, FollowLink);
  {$ENDIF}
end;

function LaunchAppAndWait2(App: String; Cmds: TStrings; Show, Wait: Boolean
  ): Integer;
var
  i: Integer;
  tp: TProcess;
begin
  tp := TProcess.Create(nil);
  tp.Executable := App;
  if Assigned(Cmds) then
    for i := 1 to Cmds.Count do
    begin
      tp.Parameters.Add(Cmds[i -1]);
      
    end;
  if Show then
    tp.ShowWindow := swoShow
  else
    tp.ShowWindow := swoHide;
  
  {$IFNDEF NOGUI}
  tp.Options := tp.Options + [poNoConsole];
  tp.Options := tp.Options - [poNewConsole];
  {$ENDIF}
  {$IFDEF DARWIN}
  
  if FpGetEUID = 0 then
    tp.Options := tp.Options + [poUsePipes];
  {$ENDIF}
  
    tp.Execute;
    
  if Wait then
    tp.WaitOnExit;
  Result := tp.ExitStatus;
  tp.Free;
  {$IFDEF NOGUI}
  ClrScr; 
  {$ENDIF}
end;

function LaunchAppAndWait3(App: String; Cmds: TStrings; Show, Wait: Boolean;
  var Return: String): Integer;
var
  p: PChar;
  i: Integer;
  tp: TProcess;
begin
  tp := TProcess.Create(nil);
  tp.Executable := App;
  if Assigned(Cmds) then
    for i := 1 to Cmds.Count do
      tp.Parameters.Add(Cmds[i -1]);
  if Show then
    tp.ShowWindow := swoShow
  else
    tp.ShowWindow := swoHide;
  
  {$IFNDEF NOGUI}
  tp.Options := tp.Options + [poNoConsole];
  tp.Options := tp.Options - [poNewConsole];
  {$ENDIF}
  {$IFDEF DARWIN}
  
  if FpGetEUID = 0 then
    tp.Options := tp.Options + [poUsePipes];
  {$ENDIF}
  
  try
    tp.Execute;
  except
    
  end;
  if Wait then
    tp.WaitOnExit;
  Result := tp.ExitStatus;
  if Assigned(tp.Output) then
  begin
    GetMem(p, (tp.Output.NumBytesAvailable +1) *8);
    tp.Output.Read(p, tp.Output.NumBytesAvailable);
    Return := p;
    FreeMem(p);
  end
  else
    Return := '';
  tp.Free;
end;

function ExtractnextVariableFRK(const Literal : string; var Varname: string; var offset:integer):Boolean;
var
  varnamelen: Integer;
  tmp: String;
  i1, i2: Integer;
begin
  Result := false;
  varname := '';
  offset := ytm_SmartPos('$', literal, FALSE, offset);
  if offset > 0 then
  begin
    i2 := ytm_SmartPos('$', literal, FALSE, offset +1);
    if i2 > 0 then
    begin
      varname:=Copy(literal, offset +1, i2 -1 -offset);
      result := True;
    end;
  end;
end;

procedure DoDebug(Add: String);
var
  t: TextFile;
begin
  Exit;
  if AnsiPos('~', DoDebugFile) <> 0 then
    DoDebugFile := ExpandFileName(DoDebugFile);
  AssignFile(t, DoDebugFile);
  if MyFileExists(DoDebugFile) then
    Append(t)
  else
    ReWrite(t);
  WriteLn(t, Add);
  CloseFile(t);
end;

function SingleLineToMultiLine(Single: String): String;
begin
  Result := StringReplace(Single, '$NEWLINE$', MyLineEnding, [rfReplaceAll, rfIgnoreCase]); 
end;

function MultiLineToSingleLine(Multi: String): String;
var
  s: String;
  i: Integer;
  l: TStringList;
begin
  
  Result := StringReplace(Multi, #$E2#$80#$A8, '$NEWLINE$', [rfReplaceAll]); 
  
  Result := StringReplace(Result, #13#10, '$NEWLINE$', [rfReplaceAll]); 
  
  Result := StringReplace(Result, #$0A, '$NEWLINE$', [rfReplaceAll]); 
  
  s := '$NEWLINE$$NEWLINE$';
  if Length(Result) >= Length(s) then
    if AnsiCompareText(s, Copy(Result,
      (Length(Result) - Length(s) +1), Length(s))) = 0 then
    begin
      Delete(Result, (Length(Result) - Length(s) +1), Length(s));
      Result := Result + '$NEWLINE$';
    end;
end;

function MyLineEnding: String;
begin
  if True then
  begin
    
    Result := sLineBreak;
    Exit;
  end;
  {$IFDEF DARWIN}
  Result := #$E2#$80#$A8; 
  {$ELSE}
  {$IFDEF WINDOWS}
  Result := AnsiString(#13#10);
  {$ELSE}
  Result := #$0A;
  {$ENDIF}
  {$ENDIF} 
end;

function LengthMyLineEnding: Integer;
begin
  if True then
  begin
    
    Result := UTF8Length(sLineBreak); 
    Exit;
  end;
  {$IFDEF DARWIN}
  Result := 3;
  {$ELSE}
  {$IFDEF WINDOWS}
  Result := 2;
  {$ELSE}
  Result := 1;
  {$ENDIF}
  {$ENDIF} 
end;

function MemoMultiToDefaultMultiLineAdapter(Value: String): String;
begin
  Result := StringReplace(Value, MyLineEnding, LineEnding,
    [rfReplaceAll, rfIgnoreCase]);
end;

function YTM_FastPosBack(const aString, aSubStr : String; aStartPos: Integer): Integer;
var
  i: Integer;
  pStr: PChar;
  pSub: PChar;
begin
  if aStartPos=0 then aStartPos:=length(astring);
  pSub := Pointer(aSubStr);
  for i := aStartPos downto 1 do
  begin
    pStr := @(aString[i]);
    if (pStr^ = pSub^) then
    begin
      if CompareMem(pSub, pStr, Length(aSubStr)) then
      begin
        result := i;
        EXIT;
      end;
    end;
  end;
  result := 0;
end;

function ytm_SmartPos(SearchStr,
                SourceStr:string;
                CaseSensitive:boolean=True;
                startpos:integer=1;
                ForwardSearch : Boolean = TRUE):integer;
begin
  if not CaseSensitive then
  begin
    SearchStr:=AnsiUpperCase(SearchStr);
    SourceStr:=AnsiUpperCase(SourceStr);
  end;
  if forwardsearch then
    result:=posex(SearchStr, SourceStr, StartPos)
  else
    result:=YTM_FastPosBack(SourceStr, SearchStr, StartPos);
end;

function PathFree(Path: String): Int64;
var
  {$IFDEF WINDOWS}
  iFree, iTotal: Int64;
  {$ELSE}
  d: Byte;
  s, sX: String;
  {$ENDIF}
begin
  {$IFDEF WINDOWS}
  
  iFree := 0;
  iTotal := 0;
  GetDiskFreeSpaceEx(PChar(ExtractFileDrive(Path)), iFree, iTotal, nil);
  Result := iFree;
  
  {$ELSE}
  
  s := PathDelim + PathDelim;
  sX := PathDelim;
  Path := StringReplace(Path, s, sX, [rfReplaceAll]);
  
  while not DirectoryExists(Path) do 
  begin
    s := Path;
    Path := ExcludeTrailingPathDelimiter(ExtractFilePath(Path));
    if s = Path then Break;
  end;
  d := AddDisk(Path); 
  Result := DiskFree(d);
  {$ENDIF}
end;

function PathSize(Path: String): Int64;
var
  {$IFDEF WINDOWS}
  iFree, iTotal: Int64;
  {$ELSE}
  s, sX: String;
  {$ENDIF}
begin
  {$IFDEF WINDOWS}
  
  iFree := 0;
  iTotal := 0;
  GetDiskFreeSpaceEx(PChar(ExtractFileDrive(Path)), iFree, iTotal, nil);
  Result := iTotal;
  {$ELSE}
  
  s := PathDelim + PathDelim;
  sX := PathDelim;
  Path := StringReplace(Path, s, sX, [rfReplaceAll]);
  
  while not DirectoryExists(Path) do 
  begin
    s := Path;
    Path := ExcludeTrailingPathDelimiter(ExtractFilePath(Path));
    if s = Path then Break;
  end;
  Result := DiskSize(AddDisk(Path));
  {$ENDIF}
end;

procedure MarkFileForDeletion(FileName: String);
{$IFDEF WINDOWS}
var
  v: TOSVersionInfo;
  p: PChar;
  s: String;
begin
  v.dwOSVersionInfoSize := SizeOf(v);
  GetVersionEx(v);
  case v.dwPlatformId of
    VER_PLATFORM_WIN32_NT: begin
                             MoveFileEx(PChar(FileName), nil, MOVEFILE_DELAY_UNTIL_REBOOT);
                           end;
    else
    begin
      GetMem(p, (MAX_PATH+1) *8);
      
      MyGetShortPathName(PChar(FileName), p, MAX_PATH);
      FileName := p;
      
      GetWindowsDirectory(p, MAX_PATH);
      s := AssertDir(p) + 'wininit.ini';
      WritePrivateProfileString('Rename', 'NUL', PChar(FileName), PChar(s));
      FreeMem(p);
    end;
  end;
{$ELSE}
begin
{$ENDIF}
end;

function BrandEy: String;
begin
  Result := ' - ' + Brand + SWizard;
end;

function OccurrencesOfChar(const s: String; const c: Char): Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to Length(s) do
    if s[i] = c then
      Inc(Result);
end;

procedure GetShortPath(FileName: String; var ShortPath: String);
var
  p: PChar;
begin
  {$IFDEF WINDOWS}
  GetMem(p, (MAX_PATH+1)*8);
  if MyGetShortPathName(PChar(FileName), p, MAX_PATH) <> 0 then
    ShortPath := p
  else
    ShortPath := FileName;
  FreeMem(p);
  {$ELSE}
  ShortPath := FileName;
  {$ENDIF}
end;

procedure GetLongPath(FileName: String; var LongPath: String);
{$IFDEF WINDOWS}
var
  h: Cardinal;
  s: String;
  fd: WIN32_FIND_DATA;
begin
  
  FileName := DeAssertDir(FileName);
  s := '';
  if ExtractFilePath(FileName) <> FileName then
  begin
    GetLongPath(ExtractFilePath(FileName), s);
    h := FindFirstFile(PChar(DeAssertDir(FileName)), fd);
    if h = INVALID_HANDLE_VALUE then
      
      LongPath := FileName 
    else
    begin
      LongPath := s + '\' + fd.cFileName;
      Windows.FindClose(h);
    end;
  end
  else
  {$ELSE}
begin
  {$ENDIF}
  LongPath := FileName;
end;

{$IFNDEF NOGUI}
procedure CopyFont(FromFont, ToFont: TFont);
var
  s: String;
begin
  s := FontToString(FromFont);
  StringToFont(s, ToFont);
end;

function FontToString(
  Font : TFont ) : string;
var
  sStyle : string;
begin
  with Font do
  begin
    
    sStyle := '';

    if( fsBold in Style )then
      sStyle := sStyle + csfsBold;

    if( fsItalic in Style )then
      sStyle := sStyle + csfsItalic;

    if( fsUnderline in Style )then
      sStyle := sStyle + csfsUnderline;

    if( fsStrikeout in Style )then
      sStyle := sStyle + csfsStrikeout;

    if( ( Length( sStyle ) > 0 ) and
        ( '|' = sStyle[ 1 ] ) )then
    begin
      sStyle :=
        Copy( sStyle, 2,
          Length( sStyle ) - 1 );
    end;

    Result := Format(
      '"%s", %d, [%s], [%s]',
      [ Name,
        Size,
        sStyle,
        ColorToString( Color ) ] );
  end;
end;

procedure StringToFont(sFont: String; Font: TFont);
var
  p      : integer;
  sStyle : string;
begin
  with Font do
  begin
    
    p    := Pos( ',', sFont );
    Name :=
      Copy( sFont, 2, p-3 );
    Delete( sFont, 1, p );

    p    := Pos( ',', sFont );
    Size :=
      StrToInt( Copy( sFont, 2, p-2 ) );
    Delete( sFont, 1, p );

    p      := Pos( ',', sFont );
    sStyle :=
      '|' + Copy( sFont, 3, p-4 );
    Delete( sFont, 1, p );

    Color :=
      StringToColor(
        Copy( sFont, 3,
          Length( sFont ) - 3 ) );

    Style := [];

    if( Pos( csfsBold,
          sStyle ) > 0 )then
      Style := Style + [ fsBold ];

    if( Pos( csfsItalic,
          sStyle ) > 0 )then
      Style := Style + [ fsItalic ];

    if( Pos( csfsUnderline,
          sStyle ) > 0 )then
      Style := Style + [ fsUnderline ];

    if( Pos( csfsStrikeout,
          sStyle ) > 0 )then
      Style := Style + [ fsStrikeout ];
  end;
end;
{$ENDIF}

function GetExpandedEnvVars(Literal: String): String;
begin
  Result := ExpandFileName(Literal);
  Result := ExpandEnvironmentString2(Literal);
end;

procedure WipeFolder(Folder: String; Recurse: Boolean);
begin
  {$IFDEF WINDOWS}
  if Recurse then
  begin
    NukeAllFolders('\\?\' + AssertDir(Folder) + '*.*', false);
    ForceDirectories(Folder); 
  end
  else
  {$ELSE}
  if Recurse then
  begin
    DeleteDirectory(Folder, false);
    RemoveDirectory(Folder);
  end
  else
  {$ENDIF}
    WipeFolderOld(Folder, false);
end;

{$IFDEF WINDOWS}
function NukeAllFolders(Path: String; FollowJunctions: Boolean): Boolean;
var
  h: THandle;
  hX: THandle;
  ParentPath: String;
  fd: WIN32_FIND_DATA;
begin
  
  Result := True;
  ParentPath := AssertDir(ExtractFilePath(Path));
  h := FindFirstFile(PChar(ParentPath + '*.*'), fd);
  if h = INVALID_HANDLE_VALUE then
  begin
    Windows.FindClose(h);
    Exit;
  end;
  repeat
    if (fd.cFileName <> String('.')) and (fd.cFileName <> '..') then
    begin
      if ((fd.dwFileAttributes and FILE_ATTRIBUTE_DIRECTORY) <> 0) then
      begin
        if not FollowJunctions then
          if (Bool(fd.dwFileAttributes and FILE_ATTRIBUTE_REPARSE_POINT))
              and Bool(fd.dwReserved0 and $80000000) 
              and Bool(fd.dwReserved0 and $20000000) 
              and True then 
                                                          
          begin 
            
            SetFileAttributes(PChar(ParentPath + fd.cFileName), FILE_ATTRIBUTE_NORMAL);
            RemoveDirectory(PChar(ParentPath + fd.cFileName));
            
            Continue;
          end;
        if not NukeAllFolders(ParentPath + fd.cFileName + '\' + '*.*', FollowJunctions) then
        begin
          Windows.FindClose(h);
          Exit;
        end;
      end
      else
      begin
        
        SetFileAttributes(PChar(ParentPath + fd.cFileName), FILE_ATTRIBUTE_NORMAL);
        DeleteFile(PChar(ParentPath + fd.cFileName));
        if MyFileExists(ParentPath + fd.cFileName) then
        begin
          hX := CreateFile(PChar(ParentPath + fd.cFileName), $10000, 0, nil,
            OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL or FILE_FLAG_DELETE_ON_CLOSE, 0);
          CloseHandle(hX);
        end;
      end;
    end;
  until not FindNextFile(h, fd);
  Windows.FindClose(h);
  
  SetFileAttributes(PChar(ParentPath), FILE_ATTRIBUTE_NORMAL);
  RemoveDirectory(PChar(ParentPath));
end;
{$ENDIF}

procedure WipeFolderOld(Folder: String; Recurse: Boolean);
var
  t: SysUtils.TSearchRec;
  hX: THandle;
  i: Int64;
begin
  Folder := DeAssertDir(Folder);
  i := SysUtils.FindFirst(Folder + DirectorySeparator + '*.*', faAnyFile, t);
  while i = 0 do
  begin
    if ((t.Attr and faDirectory) <> 0) and ((t.Name <> '.') and (t.Name <> '..')) then
    begin
      if Recurse then
      begin
        WipeFolder(Folder + DirectorySeparator + t.Name, True);
        RemoveDir(Folder + DirectorySeparator + t.Name);
      end
    end
    else
    begin
      if (t.Name <> '.') and (t.Name <> '..') then
      begin
        SetFileAttributes(PChar(Folder + DirectorySeparator + t.Name), FILE_ATTRIBUTE_NORMAL);
        DeleteFile(PChar(Folder + DirectorySeparator + t.Name));
        
        if MyFileExists(Folder + DirectorySeparator + t.Name) then
        begin
          
        end;
      end;
    end;
    i := SysUtils.FindNext(t);
  end;
  SysUtils.FindClose(t);
end;

function ExtractFileExtOnly(FileName: String): String;
begin
  Result := ExtractFileName(FileName);
  Result := ExtractFileExt(Result);
  Delete(Result, 1, 1);
end;

function ExtractFileNameOnly(Name: String): String;
var
  s: String;
begin
  Name := ExtractFileName(Name);
  s := ExtractFileExt(Name);
  if s <> '' then
    Delete(Name, AnsiPos(s, Name), Length(s));
  Result := Name;
end;

function MyCreateGUID: String;
var
  g: TGUID;
begin
  CreateGuid(g);
  Result := GUIDToString(g);
end;

function CreateGUIDUp: String;
begin
  Result := AnsiUpperCase(MyCreateGUID);
end;

function DeAssertDir(Path: String): String;
begin
  Result := ExcludeTrailingPathDelimiter(Path);
end;

function SetFileAttributes(FilePath: String; Attributes: Integer): Boolean;
begin
  
  Result := FileSetAttr(FilePath, Attributes) = 0;
  {$IFNDEF WINDOWS}
  Result := True; 
  
  {$ENDIF}
end;

procedure MyFindAllFiles(AList: TStrings; const SearchPath: String;
  const SearchMask: String = ''; SearchSubDirs: Boolean = True; DirAttr: Word = faDirectory;
  MaskSeparator: char = ';'; PathSeparator: char = ';'; NoFollow: Boolean = True); overload;
var
  Searcher: TListFileSearcher;
begin
  Searcher := TListFileSearcher.Create(AList);
  Searcher.DirectoryAttribute := DirAttr;
  Searcher.MaskSeparator := MaskSeparator;
  Searcher.PathSeparator := PathSeparator;
  Searcher.FollowSymLink := (not NoFollow); 
  try
    Searcher.Search(SearchPath, SearchMask, SearchSubDirs);
  finally
    Searcher.Free;
  end;
end;

procedure MyFindAllDirs(AList: TStrings; const SearchPath: String;
  const SearchMask: String = ''; SearchSubDirs: Boolean = True; DirAttr: Word = faDirectory;
  PathSeparator: char = ';'; NoFollow: Boolean = True); overload;
var
  Searcher: TListDirectoriesSearcher;
begin
  Searcher := TListDirectoriesSearcher.Create(AList);
  Searcher.DirectoryAttribute := DirAttr;
  Searcher.PathSeparator := PathSeparator;
  Searcher.FollowSymLink := (not NoFollow); 
  try
    Searcher.Search(SearchPath, SearchMask, SearchSubDirs);
  finally
    Searcher.Free;
  end;
end;

function MyFindAllFiles(const SearchPath: String; const SearchMask: String = '';
  SearchSubDirs: Boolean = True; DirAttr: Word = faDirectory;
  MaskSeparator: char = ';'; PathSeparator: char = ';'; NoFollow: Boolean = True): TStringList; overload;
begin
  Result := TStringList.Create;
  MyFindAllFiles(Result, SearchPath, SearchMask, SearchSubDirs, DirAttr, MaskSeparator, PathSeparator, NoFollow);
end;

function MyFindAllDirs(const SearchPath: String; const SearchMask: String = '';
  SearchSubDirs: Boolean = True; DirAttr: Word = faDirectory;
  PathSeparator: char = ';'; NoFollow: Boolean = True): TStringList; overload;
begin
  Result := TStringList.Create;
  MyFindAllDirs(Result, SearchPath, SearchMask, SearchSubDirs, DirAttr, PathSeparator, NoFollow);
end;

{$IFNDEF WINDOWS}
function FindAllLinks(Path: String): TStringList;
var
  s: String;
  b: Boolean;
  i, j: LongInt;
  l: TStringList;
  sr: TSearchRec;
begin
  Result := TStringList.Create;
  b := false;
  i := FindFirstUTF8(Path, faSymLink or faAnyFile or faDirectory, sr);
  repeat
    if i = 0 then
    begin
      b := True;
      if ((AnsiCompareText(sr.Name, '.') <> 0) and
        (AnsiCompareText(sr.Name, '..') <> 0)) then
      begin
        s := IncludeTrailingPathDelimiter(ExtractFilePath(Path)) + sr.Name;
        if (sr.Attr and faSymLink) = faSymLink then
          Result.Add(s)
        else
          if (sr.Attr and faDirectory) = faDirectory then
          begin
            l := FindAllLinks(IncludeTrailingPathDelimiter(s) + '*');
            for j := 1 to l.Count do
              Result.Add(l[j -1]);
            l.Free;
          end;
      end;
      i := FindNextUTF8(sr);
    end;
  until i <> 0;
  if b then
    FindCloseUTF8(sr);
end;
{$ENDIF}

function IsPipe(const FilePath: String): Boolean;
{$IFNDEF WINDOWS}
var
  StatBuf: Stat;
{$ENDIF}
begin
  Result := false;
  {$IFNDEF WINDOWS}
  if fpstat(FilePath, StatBuf) = 0 then
    Result := (StatBuf.st_mode and S_IFMT) = S_IFIFO;
  {$ENDIF}
end;

function FindAllFilesEx(Path: String; Recurse: Boolean): TStringList;
begin
  Result := TStringList.Create;
  MyFindAllFiles(Result, ExtractFilePath(Path), ExtractFileName(Path), Recurse);
end;

function FileCopyFile(Source, Target: String; FailIfExists: Boolean): Boolean;
var
  s, t: File;
  i, j, k: Integer;
  p: Pointer;
  f: TCopyFileFlags;
begin
  Result := false;
  if AnsiCompareText(Source, Target) = 0 then
  begin
    
    Result := True;
    Exit;
  end;
  if MyFileExists(Target) and FailIfExists then Exit;
  if not FailIfExists then f := [cffOverwriteFile, cffPreserveTime]
    else f := [cffPreserveTime];
  {$IFNDEF WINDOWS}
  if IsPipe(Source) then Exit; 
  {$ENDIF}
  Result := FileUtil.CopyFile(Source, Target, f, false); 
  Exit;
  
  AssignFile(s, Source);
  AssignFile(t, Target);
  Reset(s, 1);
  ReWrite(t, 1);
  i := 1024 *1024 *50;
  j := 0;
  k := -1;
  GetMem(p, i); 
  while not EOF(s) do
  begin
    BlockRead(s, p, i, j);
    BlockWrite(t, p, j, k);
    if j <> k then Break;
  end;
  CloseFile(s);
  CloseFile(t);
  Result := j = k;
end;

procedure MyPlaySound(Path: String);
{$IFDEF DARWIN}
var
  s: NSSound;
{$ENDIF}
begin
  {$IFDEF WINDOWS}
  MMSystem.PlaySound(PChar(Path), 0, SND_ASYNC or SND_FILENAME); 
  {$ENDIF}
  {$IFDEF DARWIN}
  {$IFNDEF NOGUI}
  s := NSSound.soundNamed(NSStringUTF8(Path));  
  s.play;
  {$ENDIF}
  {$ENDIF}
  
end;

{$IFNDEF WINDOWS}

procedure LazShimSetExecutable(Path, ReferenceExecutable: String);
var
  
  statX: Stat;
begin
  
  if (not MyFileExists(ReferenceExecutable, false)) and (not DirectoryExists(ReferenceExecutable, false)) then
    
    Exit; 
    
  if fpStat(ReferenceExecutable, statX) = 0 then 
  begin
    fpChMod(Path, statX.st_mode);
    
  end;
end;
{$ENDIF}

{$IFDEF WINDOWS}
procedure MoveFileOnReboot(Source, Target: String);
var
  v: TOSVersionInfo;
  p, pX: PChar;
  s: String;
begin
  v.dwOSVersionInfoSize := SizeOf(v);
  GetVersionEx(v);
  case v.dwPlatformId of
    VER_PLATFORM_WIN32_NT: begin
                             
                             if Target = '' then
                               MoveFileEx(PChar(Source), nil, MOVEFILE_DELAY_UNTIL_REBOOT)
                             else
                               MoveFileEx(PChar(Source), PChar(Target), MOVEFILE_DELAY_UNTIL_REBOOT or MOVEFILE_REPLACE_EXISTING);
                             
                           end;
    else
    begin
      GetMem(p, (MAX_PATH+1)*8);
      
      MyGetShortPathName(PChar(Source), p, MAX_PATH);
      Source := p;
      
      GetWindowsDirectory(p, MAX_PATH);
      s := AssertDir(p) + 'wininit.ini';
      
      WritePrivateProfileString('Rename', PChar(Target), PChar(Source), PChar(s));
      FreeMem(p);
    end;
  end;
end;
{$ENDIF}

{$IFDEF WINDOWS}
function WindowsElevator(App: String; Args: TStrings): Boolean;
var
  Wait: Boolean;
  ExitCodeEx: TExitCode;
begin
  Result := WindowsElevatorEx(App, Args, Wait, ExitCodeEx);
end;

function WindowsElevatorEx(App: String; Args: TStrings; Wait: Boolean; var ExitCodeEx: TExitCode): Boolean;
var
  dw: DWORD;
  s: String;
  i: Integer;
  sei: TShellExecuteInfoW;
begin
  
  Result := false;
  for i := 1 to Args.Count do
    if Args[i -1][1] <> '"' then
      s := s + ' "' + Args[i -1] + '"'
    else
      s := s + ' ' + Args[i -1];
  FillChar(sei, SizeOf(sei), 0);
  sei.cbSize := SizeOf(sei);
  sei.fMask := SEE_MASK_NOCLOSEPROCESS;
  sei.lpVerb := PWideChar(WideString('runas'));
  sei.lpFile := PWideChar(WideString(App));
  sei.lpParameters := PWideChar(WideString(s));
  sei.nShow := SW_NORMAL;
  if ShellExecuteExW(@sei) then
  begin
    if Wait then
    begin
      WaitForSingleObject(sei.hProcess, INFINITE);
      GetExitCodeProcess(sei.hProcess, dw);
      ExitCodeEx := dw;
    end
    else
      ExitCodeEx := 0;
    Result := ExitCodeEx = 0;
    CloseHandle(sei.hProcess);
  end
  else
    ExitCodeEx := 12; 
end;
{$ENDIF}

{$IFDEF LINUX}
function RebootLinux: Boolean;
const
  LINUX_REBOOT_MAGIC1 = $fee1dead;
  LINUX_REBOOT_MAGIC2 = $28121969;
  LINUX_REBOOT_CMD_RESTART = $01234567;
begin
  
  Result := do_SysCall({$IFDEF CPUAARCH64}142{$ELSE}169{$ENDIF}, LINUX_REBOOT_MAGIC1, LINUX_REBOOT_MAGIC2, LINUX_REBOOT_CMD_RESTART) = 0;
end;

function LinuxElevatorApp: String;
var
  s, sX: String;
begin
  Result := '';
  s := GetEnv('PATH');
  
  while Length(s) > 0 do
  begin
    sX := Copy(s, 1, AnsiPos(':', s) -1);
    Delete(s, 1, Length(sX) +1);
    
    if MyFileExists(IncludeTrailingPathDelimiter(sX) + 'pkexec') then
    begin
      Result := IncludeTrailingPathDelimiter(sX)
        + 'pkexec --user root env DISPLAY=' + GetEnv('DISPLAY')
        + ' XAUTHORITY=' + GetEnv('XAUTHORITY');
      Exit;
    end;
    if MyFileExists(IncludeTrailingPathDelimiter(sX) + 'kdesu') then
    begin
      Result := IncludeTrailingPathDelimiter(sX) + 'kdesu -u root -c';;
      Exit;
    end;
    if MyFileExists(IncludeTrailingPathDelimiter(sX) + 'gksu') then
    begin
      Result := IncludeTrailingPathDelimiter(sX) + 'gksu -u root';
      Exit;
    end;
  end;
end;

function LinuxElevator(App: String; Args: TStrings): Boolean;
var
  Wait: Boolean;
  ExitCodeEx: LongInt;
begin
  Result := LinuxElevatorEx(App, Args, Wait, ExitCodeEx);
end;

function LinuxElevatorEx(App: String; Args: TStrings; Wait: Boolean; var ExitCodeEx: LongInt): Boolean;
var
  i: Integer;
  p: TProcess;
begin
  Result := false;
  if LinuxElevatorApp = '' then
  begin
    ExitCodeEx := 13;
    Exit;
  end;
  
  p := TProcess.Create(nil);
  if Wait then
    p.Options := [poWaitOnExit,
      poUsePipes];
  p.CommandLine := LinuxElevatorApp + ' "' + App + '"';
  for i := 1 to Args.Count do
    if Args[i -1][1] <> '"' then
      p.CommandLine := p.CommandLine + ' "' + Args[i -1] + '"'
    else
      p.CommandLine := p.CommandLine + ' ' + Args[i -1];
  try
    p.Execute;
    if Wait then
      ExitCodeEx := p.ExitCode
    else
      ExitCodeEx := 0; 
    Result := ExitCodeEx = 0;
  except
  end;
  p.Free;
end;
{$ENDIF}

{$IFDEF LINUX}
function IsConsoleAvailable: Boolean;
var
  s: TStat;
begin
  Result := false;
  if FpFStat(1, s) = 0 then
    Result := (s.st_mode and S_IFMT) = S_IFCHR;
end;
{$ENDIF}

{$IFDEF DARWIN}
function RebootMac: Boolean;
const
  RB_AUTOBOOT = $00000000;  
begin
  Result := reboot(RB_AUTOBOOT) = 0;
end;

function macOSElevator(App: String; Args: TStrings): Boolean;
var
  Wait: Boolean;
  ExitCodeEx: LongInt;
begin
  Result := macOSElevatorEx(App, Args, Wait, ExitCodeEx);
end;

function macOSElevatorEx(App: String; Args: TStrings; Wait: Boolean; var ExitCodeEx: LongInt): Boolean;
var
  status:OSStatus;
  authRef: AuthorizationRef;
  authFlags: AuthorizationFlags;
  authRights: AuthorizationRights;
  authItem: AuthorizationItem;
  pipe: UnivPtr;
  pid: tpid;
  stat: cint;
  arguments: Arg10000Type;
  i, j: Integer;
begin
  Result := false;

  authItem.flags := 0;
  authItem.name := kAuthorizationRightExecute;
  authItem.value := nil;
  authItem.valueLength := 0;

  authRights.count := 1;
  authRights.items := @authItem;

  authRef := nil;
  authFlags := kAuthorizationFlagInteractionAllowed
    or kAuthorizationFlagExtendRights or kAuthorizationFlagPreAuthorize;
  status := AuthorizationCreate(@authRights,
    kAuthorizationEmptyEnvironment, authFlags, authRef);

  pipe := nil;

  FillChar(arguments, SizeOf(arguments), #0); 

  for i := 1 to Args.Count do
    arguments[i -1] := PChar(Args[i -1]);
  
  if status = errAuthorizationSuccess then
    status := AuthorizationExecuteWithPrivileges(authRef,
      PChar(App), kAuthorizationFlagDefaults, @arguments, @pipe); 
  
  Result := status = errAuthorizationSuccess;

  if Result then
  begin
    
    pid := FpFcntl(cint(pipe), F_GETOWN); 
    
    if Wait then
    begin
      j := FpWaitPid(pid, stat, 0); 
      
      ExitCodeEx := stat;
    end
    else
      ExitCodeEx := 0; 
    
  end
  else
    ExitCodeEx := 12; 

  AuthorizationFree(authRef, kAuthorizationFlagDefaults);
end;
{$ENDIF}

function globElevator(App: String; Args: TStrings): Boolean; 
var
  Wait: Boolean;
  ExitCodeEx: LongInt;
begin
  Result := globElevatorEx(App, Args, Wait, ExitCodeEx);
end;

function globElevatorEx(App: String; Args: TStrings; Wait: Boolean; var ExitCodeEx: LongInt): Boolean;
begin
  {$IFDEF DARWIN}
  Result := macOSElevatorEx(App, Args, Wait, ExitCodeEx);
  {$ENDIF}
  {$IFDEF LINUX}
  Result := LinuxElevatorEx(App, Args, Wait, ExitCodeEx);
  {$ENDIF}
  {$IFDEF WINDOWS}
  Result := WindowsElevatorEx(App, Args, Wait, ExitCodeEx);
  {$ENDIF}
end;

function MyGetAppConfigDir(Global: Boolean): String;
begin
  Result := GetAppConfigDir(Global);
  if Result <> '' then
  begin
    if DirectoryExists(Result) then
      RemoveDirectory(Result); 
    Result := IncludeTrailingPathDelimiter(
      ExtractFilePath(
        ExcludeTrailingPathDelimiter(
          Result
      )));
  end;
end;

function MyBoolToStr(Value: Boolean; UseBoolStrs: Boolean = True): String;
begin
  Result := AnsiUpperCase(BoolToStr(Value, UseBoolStrs));
end;

function MyMessageBoxFunction(Text, Caption: PChar; Flags: Longint): Integer;
begin
  {$IFNDEF NOGUI}
  Result := Forms.MessageBoxFunction(Text, Caption, Flags);
  {$ELSE}
  MyMessageBox(Text, Caption, Flags);
  {$ENDIF}
end;

function MyInputBox(const ACaption, APrompt, ADefault: String): String;
{$IFDEF NOGUI}
var
  s: String;
{$ENDIF}
begin
  {$IFNDEF NOGUI}
  Result := InputBox(ACaption, APrompt, ADefault);
  {$ELSE}
  WriteLn; 
  WriteLn(ACaption);
  s := APrompt;
  if ADefault <> '' then
    s := s + ' (' + ADefault + ')';
  WriteLn(s);
  ReadLn(Result);
  if Result = '' then
    if ADefault <> '' then
      Result := ADefault;
  
  {$ENDIF}
end;

function MySelectDirectory(Caption, InitialDirectory: String; out Directory: String; ShowHidden: Boolean = True; HelpCtx: Longint = 0): Boolean;
begin
  Result := MyDialogsSelectDirectory(Caption, InitialDirectory, Directory, ShowHidden, HelpCtx);
end;

function MyDialogsSelectDirectory(Caption, InitialDirectory: String; out Directory: String; ShowHidden: Boolean; HelpCtx: Longint = 0): Boolean;
{$IFDEF NOGUI}
var
  s: String;
{$ENDIF}
begin
  {$IFNDEF NOGUI}
  Result := Dialogs.SelectDirectory(Caption, InitialDirectory, Directory, ShowHidden, HelpCtx);
  {$ELSE}
  WriteLn; 
   
    s := Caption;
    if InitialDirectory <> '' then
      s := s + ' (' + InitialDirectory + ')';
    WriteLn(s);
    ReadLn(Directory);
  
  if Directory = '' then
    if InitialDirectory <> '' then
      Directory := InitialDirectory;
  
  Result := Directory <> '';
  {$ENDIF}
end;

function MyGetCommandLine: String;
var
  i: Integer;
begin
  Result := '';
  for i := 1 to ParamCount do
    if MyParamStr(i)[1] <> '"' then 
      if i = ParamCount then
        Result := Result + '"' + MyParamStr(i) + '"'
      else
        Result := Result + '"' + MyParamStr(i) + '" ';
end;

function MyGetTempPathEx: String;
begin
  {$IFDEF DARWIN}
  Result := AssertDir(NSTemporaryDirectory.UTF8String);
  
  {$ELSE}
  Result := IncludeTrailingPathDelimiter(GetTempDir);
  {$ENDIF}
end;

function MyParamStr(aIndex: Integer): String;
{$IFDEF DARWIN}
var
  mainBundle: CFBundleRef;
  executableUrl: CFURLRef;
  executableFSPath: CFStringRef;
  utf16len: ptrint;
  error: boolean;
{$ENDIF}
begin
  {$IFDEF DARWIN}
  if (aIndex = 0) and (SuperData = '') then
  begin
    error:=false;
    
    mainbundle:=CFBundleGetMainBundle;
    if assigned(mainbundle) then
    begin
      
      executableUrl:=CFBundleCopyExecutableURL(mainBundle);
      if assigned(executableUrl) then
      begin
        
        executableFSPath:=CFURLCopyFileSystemPath(executableUrl,kCFURLPOSIXPathStyle);
        CFRelease(executableUrl);
        
        utf16len:=CFStringGetLength(executableFSPath);
        
        setlength(result,utf16len*3+1);
        if CFStringGetCString(executableFSPath,@result[1],length(result),kCFStringEncodingUTF8) then
          
          setlength(result,pos(#0,result)-1)
        else
          error:=true;
        CFRelease(executableFSPath);
      end
      else
        error:=true;
    end
    else
      error:=true;
    if error then
      
      Result:=Paramstr(0);
    {$IFDEF INTEROP}
    
    Result := StringReplace(Result, '/MacOS/miaxstub', '/' + Ventura +  '/miaxstub', [rfReplaceAll, rfIgnoreCase]);
    {$ENDIF}
    Exit;
  end;
  {$ENDIF}
  if (SuperData = '') or (aIndex <> 0) then
    Result := ParamStr(aIndex)
  else
    Result := SuperData;
  {$IFDEF DARWIN}
  {$IFDEF INTEROP}
  
  if aIndex = 0 then
    Result := StringReplace(Result, '/MacOS/miaxstub', '/' + Ventura +  '/miaxstub', [rfReplaceAll, rfIgnoreCase]);
  {$ENDIF}
  {$ENDIF}
end;

function AssertDir(Path: String): String;
begin
  if Path = '' then
    Result := ''
  else 
    Result := IncludeTrailingPathDelimiter(Path);
end;

function AbsolutizePath(Path, ProjectRoot: String): String;
var
  s: String;
begin
  GetDir(0, s);
  ChDir(ProjectRoot);
  Result := ExpandUNCFileName(Path);
  ChDir(s);
end;

function MyExtractFileDriveFixUp(Path, RootPath: String): String;
begin
  RootPath := IncludeTrailingPathDelimiter(RootPath);
  Path := GetExpandedEnvVars(Path);
  
  {$IFDEF WINDOWS}
  Path := ExpandFileName(Path); 
  if ExtractFileDrive(Path) = '' then
    Path := RootPath + Path;
  
  {$ENDIF}
  {$IFNDEF WINDOWS}
  if Path <> '' then
  begin
    
    if (Path[1] = '.') and ((Length(Path) > 1) and (Path[2] = '/')) then
    begin
      Delete(Path, 1, 2);
      Path := RootPath + Path;
    end;
    Path := ExpandFileName(Path); 
    
    if Path[1] <> '/' then 
      Path := AssertDir(RootPath) + Path; 
  end;
  {$ENDIF}
  Result := Path;
end;

function GetBootPath: String;
{$IFDEF WINDOWS}
var
  r: TRegistry;
begin
  r := TRegistry.Create;
  r.RootKey := HKEY_LOCAL_MACHINE;
  r.Access := KEY_READ;
  if r.OpenKeyReadOnly('SOFTWARE\Microsoft\Windows\CurrentVersion\Setup') then
  begin
    Result := r.ReadString('BootDir');
    r.CloseKey;
  end
    else Result := '';
  r.Free;
{$ELSE}
begin
  Result := ''; 
{$ENDIF}
end;

initialization
  EXEDIR := AssertDir(ExtractFilePath(MyParamStr(0)));
  {$IFDEF DARWIN}
  
  if not MyFileExists(EXEDIR + 'miax.lib') then 
    EXEDIR := AssertDir(ExtractFilePath(DeAssertDir(ExtractFilePath(DeAssertDir(ExtractFilePath(DeAssertDir(EXEDIR)))))));
  {$ENDIF}
  {$IFDEF LINUX}
  {$IFDEF CPUAARCH64}
  SetExceptionMask(GetExceptionMask + [exOverflow,exZeroDivide,exInvalidOp]); 
  
  {$ENDIF}
  
  if ParamStr(4) <> 'opp' then 
  begin
    
    devNull := FpOpen('/dev/null', O_WRONLY);
    
    {$IFNDEF NOGUI}
    {$IFNDEF CMDBUILD}
    
    if FpDup2(devNull, 1) = -1 then
    begin
      
    end;
    {$ENDIF}
    {$ENDIF}
    if FpDup2(devNull, 2) = -1 then
    begin
      
    end;
    
    FpClose(devNull);
    
  end;
  
  {$ENDIF}
end.
