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
program miamp;

{$mode objfpc}{$H+}
{$DEFINE UseCThreads}

uses
  {$IFDEF UNIX}{$IFDEF UseCThreads}
  cthreads,
  {$ENDIF}{$ENDIF}
  mUtils,
  Interfaces, 
  Forms, umiaWebForm, uGui, uAbout, mAutomate, mProject,
  mCompilerVariable, mOptions, mscrComment, uSaveAll, mideoptions,
  mscrmessagebox, mscrsetvariable, mscrif, mScriptExec, mBuildThread,
  mscrinclude, madddialog, mEval, mwatches, CRC32, maddwatch, mscrdisplaydialog,
  uSevenZIPAPI, mBuild, mscrlabel, mscrgotolabel, uPool, mscrinstallfiles,
  mscrgetfolderlocation, uMacGlass, mapplychanges, VerifySign,
  mscrdefinecomponent, mscrdeletecomponent, mscrgetcomponent, mscrsetcomponent,
  mscrspacecomponent, mscrcreatefolder, mscrcreateshortcut, mscrrunprogram,
  mvirtualbrowse, uRunApp, mscrwebmediablock, uGrabMedia, uExtractMedia,
  uCopyMedia, uRetryDownload, uRetryDownloadEx, uRetryExtract, uDownload,
  mbatchbuild, mscrregion, mscrdeletefiles, mscrdeletefilesrecursive,
  mscrreadtext, mscrwritetext, mscrrmdir, mscrcreatelink, mdialoglocalize,
  uDisplaySystemFolder, mnewproject, mscrmathematics, mscrparsestring,
  mnewshortcut, mnewrunprogram, mchangetheme, mquickstartthread, mquickstart,
  mscrcreatefiletype, mscraccesscontrol, mscrgetfileversion, mscrgetfilesize,
  mscrcheckfileversion, mscrforeach, mscrsleep, uSleep,
  mscrterminatewithexitcode, mscrconvertcase, mscrconvertpath, mscrevaluate,
  mscrextractpath, mscrformatstr, mscrgetstrlen, mscrgetstrpos,
  mscrlocalizationvariable, mscrregex, mscrreplacestring, mscrbrowsefile,
  mscrbrowsefolder, mscrloadfeatures, mscrpromptfortext, mscrsavefeatures,
  mscrsetcomponentchoice, mscrgetcomponentspace, mscrsetcomponentvisibility,
  mscrcheckdiskspace, mscrfilefolderexist, mscrgetlinktarget, mscrfindallfiles,
  mscrguid, mscrgetenvironment, mscrgetinifile, mscrgettemporaryfile,
  mscrisnative, mscrreadbinary, mscrlocalfiles, mscreditinifile,
  mscrset64bitmode, mscrrename, mscrwritebinary, mscrhaltcompile, mscrFileBag,
  mscrdeleteregistry, mscrfindallregistry, mscrgetosorsp, mscrgetsystemsettings,
  mscrreadregistry, mscrwriteregistry, mupdatepack, mscrcompress7zip,
  mscrextract7zip, mscrsetowner, mscrsetgroup, mscrgetnativesettings,
  mscrreturnfrominclude, uLicenseESLR8, mscrrunprogramas, uRunAppAs,
  mscrrunscript, uRunScript, mscrcheckprocess;

{$R *.res}

begin
  RequireDerivedFormResource:=True;
  Application.Title:='InstallAware Multi Platform';
  Application.Scaled:=True;
  Application.Initialize;
  Application.CreateForm(Tui, ui);
  Application.CreateForm(TBuild, Build);
  Application.CreateForm(TAbout, About);
  Application.CreateForm(TProject, Project);
  Application.CreateForm(TAddDialog, AddDialog);
  Application.CreateForm(TOptions, Options);
  Application.CreateForm(TIDEOptions, IDEOptions);
  Application.CreateForm(TWatches, Watches);
  Application.CreateForm(TAddWatch, AddWatch);
  Application.CreateForm(TCompilerVariable, CompilerVariable);
  Application.CreateForm(TSaveAll, SaveAll);
  Application.CreateForm(TscrComment, scrComment);
  Application.CreateForm(TscrMessageBox, scrMessageBox);
  Application.CreateForm(TscrSetVariable, scrSetVariable);
  Application.CreateForm(TscrIf, scrIf);
  Application.CreateForm(TscrInclude, scrInclude);
  Application.CreateForm(TscrDisplayDialog, scrDisplayDialog);
  Application.CreateForm(TscrLabel, scrLabel);
  Application.CreateForm(TscrGoToLabel, scrGoToLabel);
  Application.CreateForm(TscrInstallFiles, scrInstallFiles);
  Application.CreateForm(TscrGetFolderLocation, scrGetFolderLocation);
  Application.CreateForm(TscrApplyChanges, scrApplyChanges);
  Application.CreateForm(TscrDefineComponent, scrDefineComponent);
  Application.CreateForm(TscrDeleteComponent, scrDeleteComponent);
  Application.CreateForm(TscrGetComponent, scrGetComponent);
  Application.CreateForm(TscrSetComponent, scrSetComponent);
  Application.CreateForm(TscrSpaceComponent, scrSpaceComponent);
  Application.CreateForm(TscrCreateFolder, scrCreateFolder);
  Application.CreateForm(TscrCreateShortcut, scrCreateShortcut);
  Application.CreateForm(TscrRunProgram, scrRunProgram);
  Application.CreateForm(TVirtualBrowse, VirtualBrowse);
  Application.CreateForm(TscrWebMediaBlock, scrWebMediaBlock);
  Application.CreateForm(TscrDownload, scrDownload);
  Application.CreateForm(TBatchBuild, BatchBuild);
  Application.CreateForm(TscrDeleteFiles, scrDeleteFiles);
  Application.CreateForm(TscrDeleteFilesRecursive, scrDeleteFilesRecursive);
  Application.CreateForm(TscrRegion, scrRegion);
  Application.CreateForm(TscrReadText, scrReadText);
  Application.CreateForm(TscrWriteText, scrWriteText);
  Application.CreateForm(TscrRmDir, scrRmDir);
  Application.CreateForm(TscrCreateLink, scrCreateLink);
  Application.CreateForm(TDialogLocalize, DialogLocalize);
  Application.CreateForm(TDisplaySystemFolder, DisplaySystemFolder);
  Application.CreateForm(TNewProject, NewProject);
  Application.CreateForm(TscrMathematics, scrMathematics);
  Application.CreateForm(TscrParseString, scrParseString);
  Application.CreateForm(TNewShortcut, NewShortcut);
  Application.CreateForm(TNewRunProgram, NewRunProgram);
  Application.CreateForm(TChangeTheme, ChangeTheme);
  Application.CreateForm(TQuickStartWizard, QuickStartWizard);
  Application.CreateForm(TscrCreateFileType, scrCreateFileType);
  Application.CreateForm(TscrAccessControl, scrAccessControl);
  Application.CreateForm(TscrGetFileVersion, scrGetFileVersion);
  Application.CreateForm(TscrGetFileSize, scrGetFileSize);
  Application.CreateForm(TscrCheckFileVersion, scrCheckFileVersion);
  Application.CreateForm(TscrForEach, scrForEach);
  Application.CreateForm(TscrSleep, scrSleep);
  Application.CreateForm(TscrTerminateWithExitCode, scrTerminateWithExitCode);
  Application.CreateForm(TscrConvertCase, scrConvertCase);
  Application.CreateForm(TscrConvertPath, scrConvertPath);
  Application.CreateForm(TscrEvaluate, scrEvaluate);
  Application.CreateForm(TscrExtractPath, scrExtractPath);
  Application.CreateForm(TscrFormatStr, scrFormatStr);
  Application.CreateForm(TscrGetStrLen, scrGetStrLen);
  Application.CreateForm(TscrGetStrPos, scrGetStrPos);
  Application.CreateForm(TscrLocalizationVariable, scrLocalizationVariable);
  Application.CreateForm(TscrRegEx, scrRegEx);
  Application.CreateForm(TscrReplaceString, scrReplaceString);
  Application.CreateForm(TscrBrowseFile, scrBrowseFile);
  Application.CreateForm(TscrBrowseFolder, scrBrowseFolder);
  Application.CreateForm(TscrLoadFeatures, scrLoadFeatures);
  Application.CreateForm(TscrPromptForText, scrPromptForText);
  Application.CreateForm(TscrSaveFeatures, scrSaveFeatures);
  Application.CreateForm(TscrSetComponentChoice, scrSetComponentChoice);
  Application.CreateForm(TscrGetComponentSpace, scrGetComponentSpace);
  Application.CreateForm(TscrSetComponentVisibility, scrSetComponentVisibility);
  Application.CreateForm(TscrCheckDiskSpace, scrCheckDiskSpace);
  Application.CreateForm(TscrFileFolderExist, scrFileFolderExist);
  Application.CreateForm(TscrGetLinkTarget, scrGetLinkTarget);
  Application.CreateForm(TscrFindAllFiles, scrFindAllFiles);
  Application.CreateForm(TscrGUID, scrGUID);
  Application.CreateForm(TscrGetEnvironment, scrGetEnvironment);
  Application.CreateForm(TscrGetINI, scrGetINI);
  Application.CreateForm(TscrGetTempFile, scrGetTempFile);
  Application.CreateForm(TscrIsNativeSetupInstalled, scrIsNativeSetupInstalled);
  Application.CreateForm(TscrReadBinary, scrReadBinary);
  Application.CreateForm(TscrLocalFiles, scrLocalFiles);
  Application.CreateForm(TscrEditINIFile, scrEditINIFile);
  Application.CreateForm(TscrSet64BitMode, scrSet64BitMode);
  Application.CreateForm(TscrRename, scrRename);
  Application.CreateForm(TscrWriteBinary, scrWriteBinary);
  Application.CreateForm(TscrHaltCompile, scrHaltCompile);
  Application.CreateForm(TscrFileBag, scrFileBag);
  Application.CreateForm(TscrDeleteRegistry, scrDeleteRegistry);
  Application.CreateForm(TscrFindAllRegistry, scrFindAllRegistry);
  Application.CreateForm(TscrGetOSorSP, scrGetOSorSP);
  Application.CreateForm(TscrGetSystemSettings, scrGetSystemSettings);
  Application.CreateForm(TscrReadRegistry, scrReadRegistry);
  Application.CreateForm(TscrWriteRegistry, scrWriteRegistry);
  Application.CreateForm(TUpdatePack, UpdatePack);
  Application.CreateForm(TscrCompress7Zip, scrCompress7Zip);
  Application.CreateForm(TscrExtract7Zip, scrExtract7Zip);
  Application.CreateForm(TscrSetOwner, scrSetOwner);
  Application.CreateForm(TscrSetGroup, scrSetGroup);
  Application.CreateForm(TscrGetNativeSettings, scrGetNativeSettings);
  Application.CreateForm(TscrReturnFromInclude, scrReturnFromInclude);
  Application.CreateForm(TLicenseESLR8, LicenseESLR8);
  Application.CreateForm(TscrRunProgramAs, scrRunProgramAs);
  Application.CreateForm(TscrRunScript, scrRunScript);
  Application.CreateForm(TscrCheckProcess, scrCheckProcess);
  KillAllOldButtons;
  {$IFNDEF LICENSED}
  LicenseESLR8.ShowModal;
  {$ENDIF}
  Application.Run;
end.

