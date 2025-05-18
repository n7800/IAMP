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
unit uGui;

{$mode objfpc}{$H+}
{$IFDEF DARWIN}

{$modeswitch objectivec1}

{$ENDIF}

interface

uses
  {$IFDEF DARWIN}
  
  CocoaAll,
  
  {$ENDIF}
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, Menus, ComCtrls,
  ExtCtrls, StdCtrls, uAbout, mUtils, mAutomate, mProject, INIFiles, LCLIntf,
  LCLType, mOptions, WiseListBox, mscrComment, Types, uSaveAll, LResources,
  LMessages, mIDEOptions, mscrMessageBox, mscrSetVariable, mscrIf, ClipBrd,
  mBuildThread, mscrInclude, mWatches, mAddWatch, mscrDisplayDialog, mAddDialog,
  mBuild, UTF8Process, mscrLabel, mscrGoToLabel, mscrInstallFiles, MaskEdit,
  mscrGetFolderLocation, mApplyChanges, mscrDefineComponent, mscrGetComponent,
  mscrSetComponent, mscrSpaceComponent, mscrDeleteComponent, mscrCreateFolder,
  mscrCreateShortcut, mscrRunProgram, mscrWebMediaBlock, uDownload, ComboEx,
  Buttons, ShellCtrls, CheckLst{$IFDEF WINDOWS}, Windows, ShellAPI{$ENDIF}, mchangetheme,
  mBatchBuild, AnchorDocking, AnchorDockStorage, SyncObjs, Design, FileLbl,
  mscrDeleteFiles, mscrDeleteFilesRecursive, mscrRegion, mscrReadText, ToolForm,
  mscrWriteText, mscrRmDir, mscrCreateLink, usevenzipapi, mDialogLocalize,
  uDlgAPI, LazFileUtils, uDisplaySystemFolder, mNewProject, mscrMathematics,
  mscrParseString, mNewShortcut, mNewRunProgram, OIForm, mscrAccessControl,
  mscrCreateFileType, mscrGetFileVersion, mscrGetFileSize, mscrCheckFileVersion,
  mscrForEach, mscrSleep, mscrTerminateWithExitCode, mscrConvertCase, mscrConvertPath,
  mscrEvaluate, mscrExtractPath, mscrFormatStr, mscrGetStrLen, mscrGetStrPos,
  mscrLocalizationVariable, mscrRegEx, mscrReplaceString, mscrBrowseFile, mscrBrowseFolder,
  mscrLoadFeatures, mscrPromptForText, mscrSaveFeatures, mscrSetComponentChoice,
  mscrGetComponentSpace, mscrSetComponentVisibility, mscrCheckDiskSpace, mscrGetEnvironment,
  mscrFileFolderExist, mscrGetLinkTarget, mscrFindAllFiles, mscrGUID, mscrGetINIFile,
  mscrGetTemporaryFile, mscrIsNative, mscrReadBinary, mscrLocalFiles, mscrEditINIFile,
  mscrSet64BitMode, mscrRename, mscrWriteBinary, mscrHaltCompile, mscrFileBag,
  mscrDeleteRegistry, mscrFindAllRegistry, mscrGetOSorSP, mscrGetSystemSettings,
  mscrReadRegistry, mscrWriteRegistry, mUpdatePack, mscrCompress7Zip, mscrExtract7Zip,
  mscrSetOwner, mscrSetGroup, mscrGetNativeSettings, mscrReturnFromInclude,
  mscrRunProgramAs, mscrRunScript, FDMain, mscrCheckProcess;

type

  Tui = class(TForm)
    Access: TListView;
    AccFeatures: TComboBoxEx;
    AccFilter: TCheckBox;
    Actions: TListBox;
    ActionsEx: TListBox;
    actions_panel: TPanel;
    AddFiles1: TMenuItem;
    AddNewFolder1: TMenuItem;
    AddVer: TBitBtn;
    Bevel15: TBevel;
    Bevel16: TBevel;
    Bevel18: TBevel;
    BitBtn5: TBitBtn;
    BitBtn6: TBitBtn;
    BitBtn7: TBitBtn;
    BuildFilename: TEdit;
    BuildFolder: TEdit;
    BuildFolderBrowse: TButton;
    BuildSettingsPage: TPage;
    Button6: TButton;
    Button7: TButton;
    Button8: TButton;
    CacheSource: TCheckBox;
    CD: TRadioButton;
    CodeNavigate: TImageList;
    CustomFolder: TRadioButton;
    Debug: TCheckBox;
    DisplayText: TComboBox;
    EULAandReadMePage: TPage;
    ExTrap: TApplicationProperties;
    AssnFeatures: TComboBoxEx;
    AssnFilter: TCheckBox;
    Assocs: TListView;
    Bevel17: TBevel;
    Bevel4: TBevel;
    Bevel5: TBevel;
    Bevel7: TBevel;
    Bevel8: TBevel;
    BitBtn1: TBitBtn;
    BitBtn10: TBitBtn;
    BitBtn2: TBitBtn;
    BitBtn8: TBitBtn;
    BottomDockPanel: TPanel;
    BuildSel: TBitBtn;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Button4: TButton;
    Button5: TButton;
    Code: TPage;
    CommandCounts: TListView;
    CommandListing: TListView;
    ComponentisSelected1: TMenuItem;
    DeleteAccess: TBitBtn;
    DeleteAssocs: TBitBtn;
    DeleteFeature: TBitBtn;
    DeleteFiles1: TMenuItem;
    DeleteINI: TBitBtn;
    DeleteLocal: TBitBtn;
    DeletePack: TBitBtn;
    DeleteShortcut: TBitBtn;
    DialogsListEx: TCheckListBox;
    DlgPreview: TImage;
    DlgPreviewEx: TImage;
    EditAccess: TBitBtn;
    EditAssocs: TBitBtn;
    EditDialogBtn: TBitBtn;
    EditFiles1: TMenuItem;
    EditINIs: TBitBtn;
    EditLocal: TBitBtn;
    EditPack: TBitBtn;
    EditShortcut: TBitBtn;
    EditWebBlock: TBitBtn;
    FeatureImages: TImageList;
    FeatureisInitiallyDeselected1: TMenuItem;
    Features: TTreeView;
    FeaturesPage: TPage;
    FeaturesPopup: TPopupMenu;
    FeaturesText: TMemo;
    FeaturesTextCaption: TLabel;
    FileControlsPanel: TPanel;
    FileControlsSourcePanel: TPanel;
    FileControlsTargetPanel: TPanel;
    FileControlsTargetPanelTopSubPanel: TPanel;
    FileFilter: TCheckBox;
    FileImages: TImageList;
    Files: TListView;
    FilesAddDialog: TOpenDialog;
    FilesControlSourcePanelBottomLeft: TPanel;
    FilesControlSourcePanelBottomRight: TPanel;
    FilesFeatures: TComboBoxEx;
    FilesPage: TPage;
    FilesPopupEx: TPopupMenu;
    FileTypeType: TBitBtn;
    Folders: TTreeView;
    Globals: TComboBoxEx;
    GroupBox2: TGroupBox;
    GroupBox3: TGroupBox;
    IconDisplayLinux: TImage;
    IconDisplaymacOS: TImage;
    IconDisplayWindows: TImage;
    IconPanelLinux: TPanel;
    IconPanelmacOS: TPanel;
    IconPanelWindows: TPanel;
    Image1: TImage;
    Image10: TImage;
    Image11: TImage;
    Image12: TImage;
    Image13: TImage;
    Image15: TImage;
    Image2: TImage;
    Image3: TImage;
    Image4: TImage;
    Image7: TImage;
    Image72: TImage;
    Image73: TImage;
    Image78: TImage;
    Image8: TImage;
    Image9: TImage;
    ImageList: TImageList;
    ImageListTree: TImageList;
    CommentOutIn1: TMenuItem;
    Copy2: TMenuItem;
    Cut2: TMenuItem;
    Delete3: TMenuItem;
    FindDialog: TFindDialog;
    imgCompressedWeb1: TImage;
    INI: TListView;
    INIFeatures: TComboBoxEx;
    INIFilter: TCheckBox;
    Label1: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label12: TLabel;
    Label13: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    Label18: TLabel;
    Label185: TLabel;
    Label187: TLabel;
    Label188: TLabel;
    Label189: TLabel;
    Label190: TLabel;
    Label191: TLabel;
    Label192: TLabel;
    Label2: TLabel;
    Label20: TLabel;
    Label201: TLabel;
    Label204: TLabel;
    Label214: TLabel;
    Label215: TLabel;
    Label216: TLabel;
    Label25: TLabel;
    Label253: TLabel;
    Label254: TLabel;
    Label255: TLabel;
    Label26: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label40: TLabel;
    Label41: TLabel;
    Label42: TLabel;
    Label43: TLabel;
    Label44: TLabel;
    Label45: TLabel;
    Label46: TLabel;
    Label47: TLabel;
    Label49: TLabel;
    Label5: TLabel;
    Label51: TLabel;
    Label52: TLabel;
    Label53: TLabel;
    Label54: TLabel;
    Label55: TLabel;
    Label56: TLabel;
    Label57: TLabel;
    Label58: TLabel;
    Label6: TLabel;
    Label64: TLabel;
    Label7: TLabel;
    Label72: TLabel;
    Label76: TLabel;
    Label78: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Language: TComboBox;
    LargeMinus: TImage;
    LargePlus: TImage;
    LeftDockPanel: TPanel;
    LinuxShuntCombo: TComboBox;
    Existing: TListBox;
    Local: TListView;
    LocalFeatures: TComboBoxEx;
    LocalFilter: TCheckBox;
    Manufacturer: TEdit;
    MediumMinus: TImage;
    MediumPlus: TImage;
    Console: TCheckBox;
    SelectAllEx: TMenuItem;
    NavPanelEx: TPanel;
    OpenDialogText: TOpenDialog;
    OpenIconLinux: TOpenDialog;
    OpenIconWindows: TOpenDialog;
    OpenIconmacOS: TOpenDialog;
    Particulars: TComboBoxEx;
    ProjectFolder: TRadioButton;
    RichEdit: TMemo;
    MenuItem10: TMenuItem;
    MenuItem11: TMenuItem;
    MenuItem13: TMenuItem;
    MenuItem15: TMenuItem;
    MenuItem21: TMenuItem;
    MenuItem28: TMenuItem;
    MenuItem30: TMenuItem;
    MenuItem31: TMenuItem;
    MenuItem32: TMenuItem;
    GenericPopupMenu: TPopupMenu;
    Action145: TMenuItem;
    Action146: TMenuItem;
    Action144: TMenuItem;
    DialogsPage: TPage;
    MenuItem33: TMenuItem;
    MenuItem35: TMenuItem;
    MenuItem53: TMenuItem;
    MenuItem54: TMenuItem;
    MenuItem57: TMenuItem;
    MenuItem58: TMenuItem;
    MenuItem64: TMenuItem;
    MenuItem65: TMenuItem;
    Define1: TMenuItem;
    Import1: TMenuItem;
    MenuItem66: TMenuItem;
    MenuItem67: TMenuItem;
    MenuItem68: TMenuItem;
    MenuItem69: TMenuItem;
    MenuItem7: TMenuItem;
    AccessControlPage: TPage;
    MenuItem70: TMenuItem;
    MonitorURL: TEdit;
    MultiLangEx: TCheckBox;
    NewAccess: TBitBtn;
    FileAssociationsPage: TPage;
    NewAssocs: TBitBtn;
    LocalFilesPage: TPage;
    NewINI: TBitBtn;
    NewLocal: TBitBtn;
    INIFilesPage: TPage;
    NewPack: TBitBtn;
    OpenINI: TOpenDialog;
    Packs: TListView;
    ProductCode: TEdit;
    ProductName: TEdit;
    ProductVersion: TEdit;
    ProjectPropertiesPage: TPage;
    Panel11: TPanel;
    Panel17: TPanel;
    Panel23: TPanel;
    Panel24: TPanel;
    Panel26: TPanel;
    Panel27: TPanel;
    Panel28: TPanel;
    PopupBuild: TPopupMenu;
    PopupFolder: TPopupMenu;
    NewAssocPopup: TPopupMenu;
    NewLocalPopup: TPopupMenu;
    NewINIPopup: TPopupMenu;
    PopupRun: TPopupMenu;
    RemoveVer: TBitBtn;
    Revision: TEdit;
    ScriptAnalyticsPage: TPage;
    Run: TListView;
    RunDelete: TBitBtn;
    RunEdit: TBitBtn;
    RunNew: TBitBtn;
    RunProgramsPage: TPage;
    Panel12: TPanel;
    script_panel: TPanel;
    SearchBox: TEdit;
    SearchPanel: TPanel;
    Served: TCheckListBox;
    SetupIconPage: TPage;
    SFX: TRadioButton;
    ShortcutFeatures: TComboBoxEx;
    ShortcutFilter: TCheckBox;
    Shortcuts: TListView;
    ShortcutsPage: TPage;
    PreviousTab2: TMenuItem;
    NextTab2: TMenuItem;
    MenuItem37: TMenuItem;
    MenuItem38: TMenuItem;
    MenuItem39: TMenuItem;
    MenuItem40: TMenuItem;
    MenuItem41: TMenuItem;
    MenuItem42: TMenuItem;
    MenuItem43: TMenuItem;
    MenuItem44: TMenuItem;
    ExpandAllRegions1: TMenuItem;
    CollapseAllRegions1: TMenuItem;
    MenuItem45: TMenuItem;
    MenuItem46: TMenuItem;
    MenuItem50: TMenuItem;
    MenuItem51: TMenuItem;
    MenuItem52: TMenuItem;
    CreateSubfolder1: TMenuItem;
    DisplaySystemFolder1: TMenuItem;
    ShortcutType: TBitBtn;
    SkipSel: TBitBtn;
    SpeedButton3: TSpeedButton;
    SpeedButton4: TSpeedButton;
    Splitter7: TSplitter;
    SpoolTimer: TTimer;
    NewShowTimer: TTimer;
    ToolBar: TToolBar;
    ToolButton1: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    ToolButton13: TToolButton;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    ToolButton19: TToolButton;
    ToolButton2: TToolButton;
    ToolButton21: TToolButton;
    ToolButton23: TToolButton;
    ToolButton24: TToolButton;
    ToolButton3: TToolButton;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton8: TToolButton;
    ToolButton9: TToolButton;
    UpdatePacksPage: TPage;
    Updates: TCheckBox;
    Versions: TListBox;
    VersionsPage: TPage;
    Visual1: TMenuItem;
    Code1: TMenuItem;
    MenuItem55: TMenuItem;
    MenuItem56: TMenuItem;
    SelectAll2: TMenuItem;
    SelectAll1: TMenuItem;
    NewFeature: TBitBtn;
    Notebook: TNotebook;
    Panel1: TPanel;
    Panel2: TPanel;
    RemoveSubfolder1: TMenuItem;
    MenuItem59: TMenuItem;
    MenuItem60: TMenuItem;
    MenuItem61: TMenuItem;
    MenuItem62: TMenuItem;
    MenuItem63: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    RenameFeature: TBitBtn;
    RightDockPanel: TPanel;
    Script: TWiseListBox;
    ScriptBook: TNotebook;
    Scripts: TPage;
    Separator8: TMenuItem;
    PopupShellViews: TPopupMenu;
    Separator7: TMenuItem;
    FilesPopupExTree: TPopupMenu;
    Separator9: TMenuItem;
    ShellList: TShellListView;
    ShellTree: TShellTreeView;
    SpeedButton1: TSpeedButton;
    SpeedButton2: TSpeedButton;
    Splitter: TSplitter;
    Splitter1: TSplitter;
    Splitter2: TSplitter;
    Splitter3: TSplitter;
    Splitter4: TSplitter;
    SplitterBottom: TSplitter;
    SplitterLeft: TSplitter;
    SplitterRight: TSplitter;
    TabSet: TTabControl;
    Separator6: TMenuItem;
    MenuItem49: TMenuItem;
    OpenPKG: TOpenDialog;
    Separator5: TMenuItem;
    MenuItem47: TMenuItem;
    MenuItem48: TMenuItem;
    NextTab1: TMenuItem;
    OpenProjectEx: TOpenDialog;
    PreviousTab1: TMenuItem;
    CopyAsText1: TMenuItem;
    ImpDlgDir: TSelectDirectoryDialog;
    Separator4: TMenuItem;
    Redo1: TMenuItem;
    TreeEx: TTreeView;
    Undo1: TMenuItem;
    Separator3: TMenuItem;
    Separator2: TMenuItem;
    MoveDown2: TMenuItem;
    MoveUp2: TMenuItem;
    N5: TMenuItem;
    N4: TMenuItem;
    N3: TMenuItem;
    MenuItem12: TMenuItem;
    MenuItem8: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    Paste2: TMenuItem;
    Reopen: TMenuItem;
    MenuItem16: TMenuItem;
    MenuItem17: TMenuItem;
    MenuItem18: TMenuItem;
    MenuItem19: TMenuItem;
    MenuItem20: TMenuItem;
    ReplaceDialog: TReplaceDialog;
    Run2: TMenuItem;
    MenuItem22: TMenuItem;
    MenuItem23: TMenuItem;
    MenuItem24: TMenuItem;
    MenuItem25: TMenuItem;
    MenuItem26: TMenuItem;
    MenuItem27: TMenuItem;
    EditAction1: TMenuItem;
    Delete1: TMenuItem;
    Cut1: TMenuItem;
    MenuItem29: TMenuItem;
    Copy1: TMenuItem;
    Paste1: TMenuItem;
    MoveUp1: TMenuItem;
    MoveDown1: TMenuItem;
    MenuItem34: TMenuItem;
    Find1: TMenuItem;
    MenuItem36: TMenuItem;
    Comment1: TMenuItem;
    N2: TMenuItem;
    MenuItem6: TMenuItem;
    OpenProject: TOpenDialog;
    SaveProject: TSaveDialog;
    MainMenu: TMainMenu;
    MenuItem1: TMenuItem;
    Compile1: TMenuItem;
    Build1: TMenuItem;
    Options1: TMenuItem;
    MenuItem14: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    SaveProject1: TMenuItem;
    SaveProjectAs1: TMenuItem;
    MenuItem9: TMenuItem;
    N1: TMenuItem;
    ScriptPopup: TPopupMenu;
    SmallMinus: TImage;
    SmallPlus: TImage;
    StatusBar: TStatusBar;
    CurrentUnit: TTabControl;
    TimerMaximize: TTimer;
    Visual: TPage;
    VisualNotebook: TNotebook;
    Web: TRadioButton;
    WebBlocks: TListView;
    WeblocksPage: TPage;
    Welcome: TPage;
    wodbc: TBitBtn;
    _20: TImage;
    _21: TImage;
    _35: TImage;
    _36: TImage;
    _50: TImage;
    _51: TImage;
    procedure ActionsEndDrag(Sender, Target: TObject; X, Y: Integer);
    procedure ActionsExDblClick(Sender: TObject);
    procedure ActionsExStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure BitBtn5Click(Sender: TObject);
    procedure BitBtn6Click(Sender: TObject);
    procedure BitBtn7Click(Sender: TObject);
    procedure BuildFolderBrowseClick(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure Button4Click(Sender: TObject);
    procedure Button5Click(Sender: TObject);
    procedure Button6Click(Sender: TObject);
    procedure Button7Click(Sender: TObject);
    procedure Button8Click(Sender: TObject);
    procedure CacheSourceChange(Sender: TObject);
    procedure ConsoleChange(Sender: TObject);
    procedure DisplayTextChange(Sender: TObject);
    procedure ExTrapException(Sender: TObject; E: Exception);
    function ExTrapHelp(Command: Word; Data: PtrInt; var CallHelp: Boolean
      ): Boolean;
    procedure FormResize(Sender: TObject);
    procedure GlobalsChange(Sender: TObject);
    procedure Image2Click(Sender: TObject);
    procedure Image3Click(Sender: TObject);
    procedure Label16Click(Sender: TObject);
    procedure Label16MouseEnter(Sender: TObject);
    procedure Label16MouseLeave(Sender: TObject);
    procedure MenuItem70Click(Sender: TObject);
    procedure MonitorURLChange(Sender: TObject);
    procedure ParticularsChange(Sender: TObject);
    procedure ParticularsDropDown(Sender: TObject);
    procedure ScriptKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ScriptKeyPress(Sender: TObject; var Key: char);
    procedure ScriptSelectionChange(Sender: TObject; User: boolean);
    procedure SearchBoxChange(Sender: TObject);
    procedure SearchBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure SelectAllExClick(Sender: TObject);
    procedure StaticPropertyChange(Sender: TObject);
    procedure AccessChange(Sender: TObject; Item: TListItem; Change: TItemChange
      );
    procedure AccessDblClick(Sender: TObject);
    procedure AccessKeyPress(Sender: TObject; var Key: char);
    procedure AccessKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AccessMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure AccFeaturesChange(Sender: TObject);
    procedure AccFilterClick(Sender: TObject);
    procedure Action144Click(Sender: TObject);
    procedure Action145Click(Sender: TObject);
    procedure Action146Click(Sender: TObject);
    procedure ActionsDblClick(Sender: TObject);
    procedure ActionsStartDrag(Sender: TObject; var DragObject: TDragObject);
    procedure AddFiles1Click(Sender: TObject);
    procedure AddNewFolder1Click(Sender: TObject);
    procedure AddVerClick(Sender: TObject);
    procedure AssnFeaturesChange(Sender: TObject);
    procedure AssnFilterClick(Sender: TObject);
    procedure AssocsChange(Sender: TObject; Item: TListItem; Change: TItemChange
      );
    procedure AssocsDblClick(Sender: TObject);
    procedure AssocsKeyPress(Sender: TObject; var Key: char);
    procedure AssocsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure AssocsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure BitBtn10Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn8Click(Sender: TObject);
    procedure Build1Click(Sender: TObject);
    procedure BuildSelClick(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure CommandCountsColumnClick(Sender: TObject; Column: TListColumn);
    procedure CommandCountsCompare(Sender: TObject; Item1, Item2: TListItem;
      Data: Integer; var Compare: Integer);
    procedure CommandCountsSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure CommandListingDblClick(Sender: TObject);
    procedure ComponentisSelected1Click(Sender: TObject);
    procedure Copy1Click(Sender: TObject);
    procedure CurrentUnitChange(Sender: TObject);
    procedure Define1Click(Sender: TObject);
    procedure Delete1Click(Sender: TObject);
    procedure DeleteAccessClick(Sender: TObject);
    procedure DeleteAssocsClick(Sender: TObject);
    procedure DeleteFeatureClick(Sender: TObject);
    procedure DeleteFiles1Click(Sender: TObject);
    procedure DeleteINIClick(Sender: TObject);
    procedure DeleteLocalClick(Sender: TObject);
    procedure DeletePackClick(Sender: TObject);
    procedure DeleteShortcutClick(Sender: TObject);
    procedure DialogsListExClick(Sender: TObject);
    procedure DialogsListExClickCheck(Sender: TObject);
    procedure DialogsListExDblClick(Sender: TObject);
    procedure DialogsListExKeyPress(Sender: TObject; var Key: char);
    procedure DisplaySystemFolder1Click(Sender: TObject);
    procedure EditAccessClick(Sender: TObject);
    procedure EditAction1Click(Sender: TObject);
    procedure EditAssocsClick(Sender: TObject);
    procedure EditDialogBtnClick(Sender: TObject);
    procedure EditINIsClick(Sender: TObject);
    procedure EditLocalClick(Sender: TObject);
    procedure EditPackClick(Sender: TObject);
    procedure EditShortcutClick(Sender: TObject);
    procedure EditWebBlockClick(Sender: TObject);
    procedure ExistingDblClick(Sender: TObject);
    procedure ExistingKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FeatureisInitiallyDeselected1Click(Sender: TObject);
    procedure FeaturesChange(Sender: TObject; Node: TTreeNode);
    procedure FeaturesEdited(Sender: TObject; Node: TTreeNode; var S: string);
    procedure FeaturesEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure FeaturesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FeaturesMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure FeaturesTextChange(Sender: TObject);
    procedure FileFilterChange(Sender: TObject);
    procedure FileFilterClick(Sender: TObject);
    procedure FilesCustomDrawItem(Sender: TCustomListView; Item: TListItem;
      State: TCustomDrawState; var DefaultDraw: Boolean);
    procedure FilesDblClick(Sender: TObject);
    procedure FilesDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FilesDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FilesKeyPress(Sender: TObject; var Key: char);
    procedure FilesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FilesFeaturesChange(Sender: TObject);
    procedure FilesPopupExTreePopup(Sender: TObject);
    procedure FilesPopupExPopup(Sender: TObject);
    procedure FileTypeTypeClick(Sender: TObject);
    procedure FindDialogClose(Sender: TObject);
    procedure FindDialogFind(Sender: TObject);
    procedure FindDialogShow(Sender: TObject);
    procedure FoldersChange(Sender: TObject; Node: TTreeNode);
    procedure FoldersDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FoldersDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure FoldersKeyPress(Sender: TObject; var Key: char);
    procedure FoldersKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure FormClose(Sender: TObject; var CloseAction: TCloseAction);
    procedure FormCloseQuery(Sender: TObject; var CanClose: boolean);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Compile1Click(Sender: TObject);
    procedure GenericPopupMenuPopup(Sender: TObject);
    procedure Import1Click(Sender: TObject);
    procedure INIChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure INIDblClick(Sender: TObject);
    procedure INIFeaturesChange(Sender: TObject);
    procedure INIFilterClick(Sender: TObject);
    procedure INIKeyPress(Sender: TObject; var Key: char);
    procedure INIKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure INIMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure LinuxShuntComboExit(Sender: TObject);
    procedure LinuxShuntComboKeyPress(Sender: TObject; var Key: char);
    procedure LocalChange(Sender: TObject; Item: TListItem; Change: TItemChange
      );
    procedure LocalDblClick(Sender: TObject);
    procedure LocalFeaturesChange(Sender: TObject);
    procedure LocalFilterChange(Sender: TObject);
    procedure LocalFilterClick(Sender: TObject);
    procedure LocalKeyPress(Sender: TObject; var Key: char);
    procedure LocalKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure LocalMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure MenuItem10Click(Sender: TObject);
    procedure MenuItem11Click(Sender: TObject);
    procedure MenuItem13Click(Sender: TObject);
    procedure MenuItem15Click(Sender: TObject);
    procedure MenuItem17Click(Sender: TObject);
    procedure MenuItem18Click(Sender: TObject);
    procedure MenuItem20Click(Sender: TObject);
    procedure MenuItem21Click(Sender: TObject);
    procedure MenuItem27Click(Sender: TObject);
    procedure MenuItem28Click(Sender: TObject);
    procedure MenuItem31Click(Sender: TObject);
    procedure MenuItem32Click(Sender: TObject);
    procedure MenuItem33Click(Sender: TObject);
    procedure MenuItem35Click(Sender: TObject);
    procedure MenuItem53Click(Sender: TObject);
    procedure MenuItem54Click(Sender: TObject);
    procedure MenuItem57Click(Sender: TObject);
    procedure MenuItem58Click(Sender: TObject);
    procedure MenuItem64Click(Sender: TObject);
    procedure MenuItem65Click(Sender: TObject);
    procedure MenuItem66Click(Sender: TObject);
    procedure MenuItem67Click(Sender: TObject);
    procedure MenuItem68Click(Sender: TObject);
    procedure MenuItem69Click(Sender: TObject);
    procedure MenuItem7Click(Sender: TObject);
    procedure NewAccessClick(Sender: TObject);
    procedure NewAssocsClick(Sender: TObject);
    procedure NewINIClick(Sender: TObject);
    procedure NewLocalClick(Sender: TObject);
    procedure NewPackClick(Sender: TObject);
    procedure NewShowTimerTimer(Sender: TObject);
    procedure PacksChange(Sender: TObject; Item: TListItem; Change: TItemChange
      );
    procedure PacksDblClick(Sender: TObject);
    procedure PacksKeyPress(Sender: TObject; var Key: char);
    procedure PacksKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure PacksMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure PopupFolderPopup(Sender: TObject);
    procedure PopupRunPopup(Sender: TObject);
    procedure PreviousTab2Click(Sender: TObject);
    procedure NextTab2Click(Sender: TObject);
    procedure MenuItem37Click(Sender: TObject);
    procedure MenuItem38Click(Sender: TObject);
    procedure MenuItem39Click(Sender: TObject);
    procedure MenuItem40Click(Sender: TObject);
    procedure MenuItem41Click(Sender: TObject);
    procedure MenuItem42Click(Sender: TObject);
    procedure MenuItem43Click(Sender: TObject);
    procedure MenuItem44Click(Sender: TObject);
    procedure MenuItem45Click(Sender: TObject);
    procedure MenuItem46Click(Sender: TObject);
    procedure MenuItem47Click(Sender: TObject);
    procedure MenuItem48Click(Sender: TObject);
    procedure MenuItem49Click(Sender: TObject);
    procedure EditFiles1Click(Sender: TObject);
    procedure MenuItem50Click(Sender: TObject);
    procedure MenuItem51Click(Sender: TObject);
    procedure MenuItem52Click(Sender: TObject);
    procedure CreateSubfolder1Click(Sender: TObject);
    procedure RemoveVerClick(Sender: TObject);
    procedure RunChange(Sender: TObject; Item: TListItem; Change: TItemChange);
    procedure RunDblClick(Sender: TObject);
    procedure RunDeleteClick(Sender: TObject);
    procedure RunEditClick(Sender: TObject);
    procedure RunKeyPress(Sender: TObject; var Key: char);
    procedure RunKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure RunMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure RunNewClick(Sender: TObject);
    procedure ServedClickCheck(Sender: TObject);
    procedure ServedKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ShortcutFeaturesChange(Sender: TObject);
    procedure ShortcutFilterClick(Sender: TObject);
    procedure ShortcutsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ShortcutsDblClick(Sender: TObject);
    procedure ShortcutsKeyPress(Sender: TObject; var Key: char);
    procedure ShortcutsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure ShortcutsMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SkipSelClick(Sender: TObject);
    procedure SpeedButton3Click(Sender: TObject);
    procedure SpeedButton4Click(Sender: TObject);
    procedure SpoolTimerTimer(Sender: TObject);
    procedure TabSetGetImageIndex(Sender: TObject; TabIndex: Integer;
      var ImageIndex: Integer);
    procedure UpdatesClick(Sender: TObject);
    procedure VersionsClick(Sender: TObject);
    procedure VersionsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure Visual1Click(Sender: TObject);
    procedure Code1Click(Sender: TObject);
    procedure MenuItem55Click(Sender: TObject);
    procedure MenuItem56Click(Sender: TObject);
    procedure MenuItem59Click(Sender: TObject);
    procedure MenuItem60Click(Sender: TObject);
    procedure MenuItem61Click(Sender: TObject);
    procedure MenuItem62Click(Sender: TObject);
    procedure MenuItem63Click(Sender: TObject);
    procedure MenuItem8Click(Sender: TObject);
    procedure NewFeatureClick(Sender: TObject);
    procedure RemoveSubfolder1Click(Sender: TObject);
    procedure RenameFeatureClick(Sender: TObject);
    procedure ReplaceDialogClose(Sender: TObject);
    procedure ReplaceDialogFind(Sender: TObject);
    procedure ReplaceDialogReplace(Sender: TObject);
    procedure ReplaceDialogShow(Sender: TObject);
    procedure Run2Click(Sender: TObject);
    procedure MenuItem4Click(Sender: TObject);
    procedure Options1Click(Sender: TObject);
    procedure MenuItem14Click(Sender: TObject);
    procedure MenuItem1Click(Sender: TObject);
    procedure MenuItem23Click(Sender: TObject);
    procedure MenuItem25Click(Sender: TObject);
    procedure MenuItem26Click(Sender: TObject);
    procedure Cut1Click(Sender: TObject);
    procedure Find1Click(Sender: TObject);
    procedure Comment1Click(Sender: TObject);
    procedure MenuItem5Click(Sender: TObject);
    procedure SaveProject1Click(Sender: TObject);
    procedure SaveProjectAs1Click(Sender: TObject);
    procedure MenuItem9Click(Sender: TObject);
    procedure MoveDown1Click(Sender: TObject);
    procedure MoveUp1Click(Sender: TObject);
    procedure Paste1Click(Sender: TObject);
    procedure ReopenClick(Sender: TObject);
    procedure ScriptAddCommand(Sender: TWiseListBox; Index: Integer;
      Command: String);
    procedure ScriptAddRemovePlaceholder(Sender: TWiseListBox; Index: Integer;
      Add: Boolean);
    procedure ScriptDblClick(Sender: TObject);
    procedure ScriptDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure ScriptDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure ScriptDrawItem(Control: TWinControl; Index: Integer;
      ARect: TRect; State: TOwnerDrawState);
    procedure ScriptKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ScriptMeasureItem(Control: TWinControl; Index: Integer;
      var AHeight: Integer);
    procedure ScriptMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ScriptPopupPopup(Sender: TObject);
    procedure SelectAll1Click(Sender: TObject);
    procedure SelectAll2Click(Sender: TObject);
    procedure ShellListMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ShellListSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure ShellTreeChange(Sender: TObject; Node: TTreeNode);
    procedure ShellTreeChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure ShellTreeMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure SpeedButton1Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure TabSetChange(Sender: TObject);
    procedure TimerMaximizeTimer(Sender: TObject);
    procedure TreeExChange(Sender: TObject; Node: TTreeNode);
    procedure TreeExChanging(Sender: TObject; Node: TTreeNode;
      var AllowChange: Boolean);
    procedure WebBlocksChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure WebBlocksDblClick(Sender: TObject);
    procedure WebBlocksKeyPress(Sender: TObject; var Key: char);
    procedure WebBlocksKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
      );
    procedure WebBlocksMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure WebBlocksSelectItem(Sender: TObject; Item: TListItem;
      Selected: Boolean);
    procedure wodbcClick(Sender: TObject);
  private
  public
    function SweepUpdateShortcut: Integer;
    function SetUpdateShortcut(bEnabled: Boolean): Boolean;
    function GetTopOfScriptInsertionIndex: Integer;
    function GetUpdateInsertionIndex(CodeGen: Boolean; DirectDeploy: Boolean = false): Integer;
    function GetUpdateServer: String;
    function GetUpdateEnabledState: Boolean;
    function FixUpPath(Path: String): String;
    function GetINIForComponent(Feature: String; FeatureFilter: Boolean): TStrings;
    procedure FeatureAwareINIPopulate(SingleItem: TListItem = nil);
    function GetLocalForComponent(Feature: String; FeatureFilter: Boolean): TStrings;
    procedure FeatureAwareLocalPopulate(SingleItem: TListItem = nil);
    function GetInsertionIndexBeforeApplyChangesWithFeatureSupport(Feature: String; EnforceFeature: Boolean): Integer;
    function GetAssnsForComponent(Feature: String; FeatureFilter: Boolean): TStrings;
    procedure FeatureAwareAssnPopulate(SingleItem: TListItem = nil);
    function GetAccForComponent(Feature: String; FeatureFilter: Boolean): TStrings;
    procedure FeatureAwareAccPopulate(SingleItem: TListItem = nil);
    function GetAfterApplyInstallWithFeatureInsertionIndex(Feature: String): Integer;
    function GetInsertionIndexAfterApplyChangesWithFeatureSupport(Feature: String; EnforceFeature, CodeGen: Boolean): Integer;
    procedure OpenRunFile(BuildMode: Integer = -1);
    function SniffRunFile(BuildMode: Integer = -1): String;
    procedure OpenBuildFolder(BuildMode: Integer = -1);
    function SniffBuildFolder(BuildMode: Integer = -1): String;
    function RenderUpdateScriptEx(SmartPosition: Integer; FoldedSmartPos: Boolean = True): Boolean;
    function GetBitmapForm(FileName: String): Graphics.TBitmap;
    function GetInsertionIndexAtFinish: Integer;
    function GetInsertionIndexAfterApplyChanges(Install, CodeGen: Boolean; ScanIndex: Integer = 1): Integer;
    function GetIconIndex(Selected: Boolean; const AFile: string; Attrs: DWORD): Integer;
    function GetShortcutsForComponent(Feature: String; FeatureFilter: Boolean): TStrings;
    procedure FeatureAwareShortcutPopulate(SingleItem: TListItem = nil);
    function GetOrCreateAndGetFolderLocationVariable(FolderTypeEx: String;
      var InsertIndex: Integer; NewVarName: String): String;
    function FindFileItemIndex(TargetFile: String): Integer;
    procedure SetMediaBlockSkipEx(GUID: String; Skip: Boolean);
    function IsValidGuid(GUID: String): Boolean;
    function SaveProjectAsTemplate(ProjectFile, OldDir, NewDir: String): Boolean;
    function GetInsertionIndexBeforeApplyChanges(Install: Boolean): Integer;
    function FindCreateOrMapFolderIndex(Folder: String): Integer;
    function GetCreateAndDefineFoldersForComponent(Feature, Folder: String;
      FeatureFilter: Boolean; ReturnFirstOnly: Boolean = false): TStrings;
    function IsSafeToDeleteFileViewFolderNode(Node: TTreeNode; CheckForRootNodeOnly: Boolean): Boolean;
    procedure UpdateMultipleValues(List, GUIDs: TStringList; Index, Offset: Integer; Value: String);
    procedure HashForCheckBox(CheckBox: TCheckBox; List, GUIDs: TStringList; Index, Offset: Integer);
    function HashMultipleCommandFields(List, GUIDs: TStringList; Index, Offset: Integer; var HashedValue: String): Boolean;
    function GetNewFilesInsertionIndex(Feature: String): Integer;
    function AddNewFiles(NewFiles: TStrings): Boolean;
    function AddNewFolder(NewFolder: String): Boolean;
    function AssertURL(URL: String): String;
    procedure SetDefaultComponentSelectionState(Component: String; Selected: Boolean);
    function AnyMatchingFileInPath(Path: String; Recursive: Boolean): Boolean;
    function CheckIsBadPathFunction(Kind, Guid: String): Boolean;
    function GetSetVariableValue(Variable: String): String;
    
    function GetStringAtListIndexOffset(List: TStrings; Index, Offset: Integer): String;
    procedure SetStringAtListIndexOffset(List: TStrings; Index, Offset: Integer; Value: String);
    
    function GetScriptSmartPosition(GUID: String): Integer;
    
    function FindIndexOfStringAtOffset(List: TStrings; ItemOffset, TotalOffset: Integer; Value: String; CaseSensitive: Boolean = false): Integer;
    
    function GetSmartPositionInClass(ItemClass: String; Last: Boolean): Integer;
    
    function GetSetComponentStateSmartPosition(Selected, Last: Boolean): Integer;
    function GetComponentPathFromTree(Node: TTreeNode): String;
    procedure SwapNamedFeaturesInScript(First, Second: String);
    function ImportPKG(PKG: String): String;
    function ImportPKGEx(PKG: String): Boolean;
    procedure ScrubNewLfm(FileName: String);
    function Dfm2Txt(const ASrc, ADest: String): Boolean;
    procedure CreateBlankProject(Import: Boolean = false);
    function CurrentUnitChangeEx(Import: Boolean = false): String;
    function PeekStackItem(Stack: TList; var Kind, Elements: String; IgnoreContext: Boolean = false): Boolean;
    procedure ShowLineWithExpand(Index: Integer);
    procedure UndoRedoAction(FromStack, ToStack: TList);
    procedure UndoAction;
    procedure RedoAction;
    procedure GetFoldersTreeEx(Into: TTreeView; aFolders: TStrings);
    procedure MigrateFeatures(Tree: TTreeView; Combo: TComboBoxEx);
    procedure GetComponentsTree(Into: TTreeView; MyComponents, Selections: TStrings);
    function GetFolderPathFromTree(Node: TTreeNode): String;
    function GetComponentPathFromCombo(Combo: TComboBoxEx): String;
    function GetFilesAndSourcesForComponentInFolder(Feature, Folder: String;
      FeatureFilter: Boolean; ReturnFirstOnly: Boolean = false): TStrings;
    function AddFileToFileList(List: TListView; FilePath, FileName, GUID: String): TListItem;
    function GetProjectFileNameOnly: String;
    function GetBuildFolder(ForDebug: Boolean = false): String;
    procedure RefreshWatches;
    procedure FreeAxContext;
    procedure ProcessAllCodeFolds(Expand: Boolean);
    procedure ProcessTemporaryExpand(Expand: Boolean);
    function DoesRegionHaveClosure(Line: Integer): Boolean;
    procedure ShowIncludeLineFromGlobal(Index: Integer; Map: TStrings; TempExpandNeeded: Boolean);
    procedure MergeScripts(MergePoint: Integer; fGlobalLists: TList; fScriptTypes, fScriptReferences, fScriptComments,
      fScriptFetches, fScriptFolds, fFoldList, fBreakpoints, fBookmarks: THashedStringList; tGlobalLists: TList; tScriptTypes, tScriptReferences, tScriptComments,
      tScriptFetches, tScriptFolds, tFoldList, tBreakpoints, tBookmarks: THashedStringList);
    function RecursiveSubstituteScript(WorkContext: String; AlreadyPulled: TStrings;
      var aGlobalLists: TList; var aScriptTypes, aScriptReferences, aScriptComments,
      aScriptFetches, aScriptFolds, aFoldList, aBreakpoints, aBookmarks: THashedStringList): String;
    function PreCompileScript(var Error: String; aFree: Boolean): Integer;
    procedure RenderFunctionToClipboard(Kind, Guid: String; AppendToList: TStrings);
    function RenderFunctionFromClipboard(Kind, Guid: String; Items: TStrings): Integer;
    procedure RenderCopyScriptEx(SmartPosition: Integer);
    procedure SwitchToUI(aVisual: Boolean);
    procedure RedrawScript;
    function LoadUISettings: Boolean;
    procedure SaveUISettings(aWindowState: TWindowState; SaveTipsOnly: Boolean = false);
    procedure RemoveShortcuts;
    procedure InsertShortcuts;
    procedure SetHorizontalScrollBar(lb: TListBox);
    function InDesigner: Boolean;
    function InDesignerEx: Boolean;
    function GetLineNumberForNamedRegion(nName: String): Integer;
    function GetLineVisibilityState(NewLine: Integer; FoldedIndex: Boolean): Boolean;
    procedure AssertLineIsVisible(Line: Integer);
    procedure ShowCaretEx;
    procedure HideCaretEx;
    function GetFunctionDataForStack(Kind, Guid: String): String;
    procedure ProcessCodeFolding(Line: Integer);
    procedure ClearSelectionEx(ListBox: TListBox);
    procedure AddStackItem(Stack: TList; Kind, Elements: String);
    procedure GetFunctionOffsets(Kind: String; var List: TStringList; var Index: Integer);
    function LoadProjectScript(FileName: String): Boolean;
    procedure ApplySavedCodeFolding;
    function GetCodeFoldingName(Line: Integer): String;
    function IsLineCodeFoldEnd(Line: Integer): Boolean;
    function IsLineCodeFolding(Line: Integer): Boolean;
    function GetAllRealLines(FoldedLine: Integer): TStringList;
    function GetRealLineNumber(FoldedLine: Integer): Integer;
    procedure CodeComplete(Command: String; pPosition: Integer);
    function EditFunction(Kind, Guid: String): Boolean;
    function InsertFunction(Kind: String): String;
    procedure DeleteFunction(Kind, Guid: String);
    function RenderUpdateScript(SmartPosition: Integer; FoldedSmartPos: Boolean = True): Boolean;
    procedure RenderDeleteScriptEx(SmartPosition: Integer; RealLine: Boolean);
    function RenderInsertScript(Command: String; SmartPosition: Integer; Visibility: Boolean;
      RealSmartPosition: Boolean = false): Boolean;
    function RelativizePath(Path, ProjectRoot: String): String;
    
    function HashItems(ItemType: String): TStrings;
    procedure DisplayLine(Line: Integer; Real: Boolean);
    
    procedure ReBindMainScriptRename(NewName: String);
    function SaveProjectDirect(ProjectFile, OldDir: String; Import: Boolean = false): Boolean;
    procedure ReBindProjectRename(NewName: String);
    procedure SaveExistingProjectAs;
    function SaveExistingProject(OldDir: String): Boolean;
    function IsProjectNameOK: Boolean;
    function IsScriptNameOK: Boolean;
    function IsDirty: Boolean;
    function SafeRunState: Boolean;
    function IsSafeToCloseProject: Boolean;
    function StripExpandedSetVar(Field: String): String;
    procedure ProcessVariableBoxForSetVar(Box: TComboBox);
    function IsTextInCommandAtLine(aText: String; Line: Integer;
      CheckDisplayText: Boolean; CaseSensitive: Boolean = false): Boolean;
    
    function RenderInsertScriptEx(Command: String;
      ItemClass, Params: TStrings; SmartPosition: Integer; Visibility: Boolean;
      ForceGUIDForRedoIntegrity: String = ''): String;
    function GetFullProjectScriptFilePath: String;
    procedure CategoriesButtonClicked(Sender: TObject);
    procedure AdjustUIProjectChanged;
    procedure AdjustVisualUI;
    procedure CreateNewProject;
    procedure ClearProjectStructs(ScriptOnly: Boolean = false);
    procedure ClearScriptStructsOnly;
    procedure SetDirtyAll(Dirty: Boolean);
    procedure SetDirtyMIA(Dirty: Boolean; sScriptFile: String; OverrideTFSHandling: Boolean = false);
    procedure SetDirtyMPR(Dirty: Boolean);
    function LoadProject(FileName: String; Import: Boolean = false): Boolean;
    procedure PushStatusStack(StatusText: String);
    function PopStatusStack: String;
    procedure RenderScript;
    procedure RenderLine(SmartPosition: Integer; ReCache: Boolean);
    function RenderFunction(Kind, Guid: String): String;
    function RemoveStackItem(Stack: TList; var Kind, Elements: String; IgnoreContext: Boolean = false): Boolean;
    procedure ClearStack(Stack: TList);
    procedure FreeSavedContexts;
    procedure SaveContext(SaveAs: String);
    procedure FreeContext(Context: String);
    procedure SwitchContext(NewContext: String);
    function LoadContextFromDisk(Context, DiskFile: String): Boolean;
    function LoadScriptEx(sScriptFile: String; Import: Boolean = false): Boolean;
    function LoadScript(sScriptFile: String; Import: Boolean = false): String;
    procedure RehashIndents;
    function GetMemoFlat(Memo: TMemo): String;
    procedure SetMemoFlat(Memo: TMemo; Flat: String);
    function GetFoldedLineNumber(RealLine: Integer): Integer;
    function GetNamedScriptNameAndFile(Given: String; var sName, sFile: String): Boolean;
    function IsContextLoaded(Context: String): Boolean;
    function SaveNamedScript(sScriptFile, SaveFile, OldDir: String): Boolean;
    function MakeNewEmptyGlobalList: TList;
    function MakeNewEmptyInitializedGlobalList: TList;
    procedure AssignContext(NewContext: String; var aGlobalLists: TList; var aScriptTypes,
      aScriptReferences, aScriptComments, aScriptFetches, aScriptFolds,
      aFoldList, aBreakpoints, aBookmarks: THashedStringList; DuplicateContext: Boolean = false);
    function GetCompilerVariableBool(Variable: String): Boolean;
    function GetCompilerVariable(Variable: String): String;
    function GetCompilerVariableBoolDefault(Variable: String): Boolean;
    function SubstituteCompilerVariables(Literal: String; AddQuote: Boolean = True): String;
    function GetCompilerVariableNames: TStringList;
    function GetCompilerVariableValues: TStringList;
    function ReplaceTextInCommandAtLine(OldText, NewText: String; Line: Integer; MatchCase: Boolean): Boolean;
    
    procedure AddToMRUF(FileName: String);
    procedure RepaintMRUF;
    procedure OpenMRUF(FileName: String);
    
    procedure AdaptToolbar(aVisual: Boolean);
  end;

const
  CommentConst = 'Comment:';

var
  
  OldTab: Integer = -1;
  ui: Tui;
  fontComment, fontStatement, fontLabel, fontFlowControl,
  fontDirective, fontPlugIn, fontWindowsInstaller, fontModifySystem,
  fontLine: TFont;
  BaseFontSize: Integer;
  globBlockRenderScript: Boolean = false;
  CaretCount: Integer = 0;
  LastReplaceSearch: String;
  CommandSeperator: String = '-----------oOo-----------';
  DragAcceptCaption: String;
  DragAcceptEx: Boolean = false;
  LastCursorPos: TPoint;
  OpaqueClipboard: TStringList;
  scrForceValue, scrForceValueX, scrForceValueY, scrForceValueZ: String;
  EnabledCodeCompletion: Boolean = True;
  EnabledCodeCompletionElse: Boolean = false;
  StatusStack: TStringList;
  ProjectStruct: TProjectStruct;
  CurrentProjectName: String;
  EnabledFolding: Boolean;
  FontWidth, FontHeight: Integer;
  IndentDepth: Integer;
  
  axGlobalLists: TList;
  axScriptTypes, axScriptReferences, axScriptComments,
  axScriptFetches, axScriptFolds, axFoldList, axBreakpoints, axBookmarks: THashedStringList;
  
  RestoreTabIndex: Integer = -1;
  ActiveTab: Integer = 0;
  LockCount: Integer = 0;
  AlreadyInUnitChange: Boolean = false;
  TemporaryExpansionActive: Boolean = false;
  AllContextBuffers, AllContextBuffersEx: THashedStringList;
  ScriptFile: String;
  DialogFiles, SupportFiles, IncludeFiles: THashedStringList;
  OffTheHook: Integer = 0;
  DirtyBuffer: THashedStringList;
  LastActiveContext: String = '';
  BackupFoldList, FoldList: THashedStringList;
  Breakpoints: THashedStringList;
  Bookmarks: THashedStringList;
  RenderCache, ScriptComments, IndentHash: THashedStringList;
  ScriptFolds, ScriptBuffer, ScriptTypes, ScriptReferences, ScriptFetches, ProhibitedScriptFetches: THashedStringList;
  GlobalLists: TList;
  OrphanAll: Boolean = false;
  EnabledExport: Boolean;
  globSearchOn: Boolean = false;
  LastFindIndex, LastReplaceIndex: Integer;
  PullMap, BreakMap, TopLines, IncludeDepth: THashedStringList;
  IncludeDepthInteger: Integer;
  IncludeDepthStack: TStringList;
  
  UndoStack, RedoStack: TList;
  
  Running, Stepping, ContinueDebug, BreakRun: Boolean;
  VarWatches: TStringList;
  
  Comments, xMessageBox, SetVariable, xIf, xWhile, xUntil, xInclude, DisplayDialog, xSleep,
  GetFolderLocation, InstallFiles, eLabel, gLabel, Maths, Parse, ApplyChanges, xForEach,
  DefComponent, SetComponent, GetComponent, SpaceFeatures, DelComp, FileType, CheckVersion,
  CreateFolder, Short, RunProgram, MediaBlock, DownloadFile, ACL, GetVers, xGetFileSize,
  DeleteFiles, DeleteRec, Region, ReadText, WriteText, RmDir, CreateLink, TermExitCode,
  ConvertPath, ConvertCase, Eval, ExtractPath, FormatStr, GetStrLen, GetStrPos, RegEx,
  LocVar, ReplaceStr, xBrowseFile, xBrowseFolder, LoadFeatures, xPromptForText, GetSpace,
  SetVisibility, SetChoice, SaveFeatures, CheckSpace, DoesExist, GetLink, xGUID, FAF, GetEnv,
  GetINI, GetTemp, IsNative, xReadBinary, LocalFiles, EditINI, Plat, xRename, xWriteBinary,
  HaltCompile, FileBag, DeleteReg, FindAllReg, ExactVer, GetSystemSettings, ReadReg,
  WriteReg, Compress7Zip, Extract7Zip, Own, Grp, GetNativeSettings, ReturnInclude,
  RunProgramAs, xRunScript, CheckProcess
  : THashedStringList;
  
  MRUF: TStringList;
  
  PlugError: String;
  
  CategoriesSelectedItemCaption, CategoriesSelectedItemCaptionLocalizable: String;
  
  AllowFileRehash: Boolean = True;
  
  GetComponentPathFromComboCache: String = ''; 
  
  gbp: SyncObjs.TCriticalSection;
  DialogsList: TStringList;
  PhatAnalyticsFirstColumn: Boolean = True;
  IconCache, SelectedIconCache: TStringList;

implementation

{$R *.lfm}

uses
  mScriptExec;

function RunCallback(Line: Integer): Boolean;
var
  b: Boolean;
begin
  if (PullMap.Count < Line) or (BreakMap.Count < Line) then
  begin
    Result := True; 
    Exit;
  end;
  ui.RefreshWatches;
  
  b := ui.CurrentUnit.Enabled;
  ui.CurrentUnit.Enabled := True;
  ui.ShowIncludeLineFromGlobal(Line -1, PullMap, false);
  ui.CurrentUnit.Enabled := b;
  
  if (BreakMap[Line -1] <> '') or Stepping then
  begin
    if BreakMap[Line -1] <> '' then
      MyPlaySound(PChar(EXEDIR + 'audio' + PathDelim + 'stopped_at_breakpoint.wav')); 
    ContinueDebug := false;
    repeat
      
      Application.Idle(True);
      Application.ProcessMessages;
    until ContinueDebug or BreakRun;
  end;
  Result := not BreakRun;
end;

function Tui.Dfm2Txt(const ASrc, ADest: String): Boolean;

var
  ASrcS, ADestS: TFileStream;
begin
  Result := false;
  if not MyFileExists(ASrc) then Exit;
  ASrcS := TFileStream.Create(ASrc, fmOpenRead);
  ADestS := TFileStream.Create(ADest, fmCreate);
  try
    ObjectResourceToText(ASrcS, ADestS);
    Result := True;
  finally
    ASrcS.Free;
    ADestS.Free;
  end;
end;

procedure Tui.MenuItem9Click(Sender: TObject);
var
  a: TCloseAction;
begin
  if not SafeRunState then Exit;
  if IsSafeToCloseProject then
  begin
    FormClose(Self, a);
    Application.Terminate;
  end;
end;

procedure Tui.MoveDown1Click(Sender: TObject);
var
  i, j: Integer;
begin
  if not SafeRunState then Exit;
  try
    ui.BeginFormUpdate;
    i := -1;
    for j := Script.Items.Count downto 1 do
      if Script.Selected[j -1] then
      begin
        i := j;
        Break;
      end;
    if (i >= Script.Items.Count) or (i = -1) then Exit;
    for j := 1 to Script.Items.Count do
      if Script.Selected[j -1] then
      begin
        i := j;
        Break;
      end;
    Copy1Click(Self);
    Delete1Click(Self);
    
    ClearSelectionEx(Script);
    Script.ItemIndex := i;
    Paste1Click(Self);
    
    ClearSelectionEx(Script);
    Script.ItemIndex := i;
    Script.Selected[i] := True;
  finally
    ui.EndFormUpdate;
  end;
end;

procedure Tui.MoveUp1Click(Sender: TObject);
var
  i, j: Integer;
begin
  if not SafeRunState then Exit;
  try
    ui.BeginFormUpdate;
    i := -1;
    for j := 1 to Script.Items.Count do
      if Script.Selected[j -1] then
      begin
        i := j;
        Break;
      end;
    if i <= 1 then Exit;
    Copy1Click(Self);
    Delete1Click(Self);
    
    ClearSelectionEx(Script);
    Script.ItemIndex := i -2;
    Paste1Click(Self);
    
    ClearSelectionEx(Script);
    Script.ItemIndex := i -2;
    Script.Selected[i -2] := True;
  finally
    ui.EndFormUpdate;
  end;
end;

procedure Tui.Paste1Click(Sender: TObject);
var
  s, sX: String;
  i, j, k, p, pX: Integer;
  bkScriptTypes: TStringList;
  bkScriptComments: TStringList;
  bkScriptFetches: TStringList;
  bkBreakpoints: TStringList;
  bkBookmarks: TStringList;
  bkRenderCache: TStringList;
  bkScriptReferences: TStringList;
  Undoable: Boolean;
  l, lX: TStringList;
begin
  if not SafeRunState then Exit;
  if not InDesigner then Exit;
  if not Clipboard.HasFormat(CF_TEXT) then Exit;
  try
    PushStatusStack('Pasting selection');
    s := Clipboard.AsText;
    OpaqueClipboard.Clear;
    while AnsiPos(LineEnding, s) <> 0 do
    begin
      sX := Trim(Copy(s, 1, AnsiPos(LineEnding, s) -1));
      Delete(sX, 1, 1);
      Delete(sX, Length(sX), 1);
      OpaqueClipboard.Add(sX);
      Delete(s, 1, AnsiPos(LineEnding, s) + (Length(LineEnding) -1));
      
    end;
    if s <> '' then
      OpaqueClipboard.Add(s);
    if OpaqueClipboard.Count = 0 then Exit;
    if OpaqueClipboard[0] <> Brand + ' Clipboard Data' then Exit; 
    OpaqueClipboard.Delete(0);
    bkScriptTypes := TStringList.Create;
    bkRenderCache := TStringList.Create;
    bkScriptComments := TStringList.Create;
    bkScriptFetches := TStringList.Create;
    bkBreakpoints := TStringList.Create;
    bkBookmarks := TStringList.Create;
    bkScriptReferences := TStringList.Create;
    if InDesigner then
      Undoable := True;
    try
      bkScriptTypes.CommaText := ScriptTypes.CommaText;
      bkRenderCache.CommaText := RenderCache.CommaText;
      bkScriptComments.CommaText := ScriptComments.CommaText;
      bkScriptFetches.CommaText := ScriptFetches.CommaText;
      bkBreakpoints.CommaText := Breakpoints.CommaText;
      bkBookmarks.CommaText := Bookmarks.CommaText;
      bkScriptReferences.CommaText := ScriptReferences.CommaText;
      if OpaqueClipboard.Count <> 0 then
        
        SetDirtyMia(True, '');
      i := 0;
      k := 0;
      p := GetRealLineNumber(Script.ItemIndex);
      pX := GetRealLineNumber(Script.ItemIndex);
      if Undoable then
      begin
        l := TStringList.Create;
        lX := TStringList.Create;
      end;
      while i < OpaqueClipboard.Count do
      begin
        l.Add(IntToStr(p -i));
        lX.Add(l.CommaText);
        if p <> -1 then
        begin
          ScriptTypes.Insert(p, OpaqueClipboard[i]);
          RenderCache.Insert(p, '');
          ScriptComments.Insert(p, '');
          ScriptFetches.Insert(p, '');
          Breakpoints.Insert(p, '');
          Bookmarks.Insert(p, '');
        end
        else
        begin
          ScriptTypes.Add(OpaqueClipboard[i]);
          ScriptComments.Add('');
          ScriptFetches.Add('');
          Breakpoints.Add('');
          Bookmarks.Add('');
          RenderCache.Add('');
        end;
        i := i +1;
        OpaqueClipboard[i] := MyCreateGuid;
        if p <> -1 then
          ScriptReferences.Insert(p, OpaqueClipboard[i])
        else
          ScriptReferences.Add(OpaqueClipboard[i]);
        i := i +1;
        if OpaqueClipboard.Count < i +1 then
        begin
          RenderCopyScriptEx(p); 
          Break; 
        end;
        j := RenderFunctionFromClipboard(OpaqueClipboard[i -2],
          OpaqueClipboard[i -1], OpaqueClipboard);
        i := i + j;
        k := k +1;
        RenderCopyScriptEx(p); 
      end;
      if Undoable then
      begin
        AddStackItem(UndoStack, 'Insert', lX.CommaText);
        l.Free;
        lX.Free;
        
        ClearStack(RedoStack);
      end;
      
      RehashIndents;
      if p + k >= ScriptBuffer.Count  then
      begin
        p := 0;
        k := ScriptBuffer.Count -1;
      end;
      ui.BeginFormUpdate;
      
      ClearSelectionEx(Script);
      Script.Selected[GetFoldedLineNumber(p + k)] := True;
      Script.ItemIndex := GetFoldedLineNumber(p + k);
      ui.EndFormUpdate;
    except
      ui.BeginFormUpdate;
      Application.MessageBox(PChar(SInvalidClipboardData),
        PChar(Application.Title), mb_Ok + mb_IconStop);
      ScriptTypes.CommaText := bkScriptTypes.CommaText;
      RenderCache.CommaText := bkRenderCache.CommaText;
      ScriptComments.CommaText := bkScriptComments.CommaText;
      ScriptFetches.CommaText := bkScriptFetches.CommaText;
      Breakpoints.CommaText := bkBreakpoints.CommaText;
      Bookmarks.CommaText := bkBookmarks.CommaText;
      ScriptReferences.CommaText := bkScriptReferences.CommaText;
      Script.Items.Clear; 
      RenderScript;
      
      ui.EndFormUpdate;
      Script.ItemIndex := GetFoldedLineNumber(pX);
      Script.Selected[GetFoldedLineNumber(pX)] := True;
    end;
    bkScriptTypes.Free;
    bkRenderCache.Free;
    bkScriptComments.Free;
    bkScriptFetches.Free;
    bkBreakpoints.Free;
    bkBookmarks.Free;
  finally
    PopStatusStack;
  end;
end;

procedure Tui.ReopenClick(Sender: TObject);
var
  i: Integer;
  s: String;
begin
  if not SafeRunState then Exit;
  if not IsSafeToCloseProject then Exit;
  s := TMenuItem(Sender).Caption;
  while AnsiPos('&', s) <> 0 do
    Delete(s, AnsiPos('&', s), 1);
  MRUF.Move(MRUF.IndexOf(s), 0);
  MRUF.SaveToFile(EXEDIR + 'mruf.txt', TEncoding.UTF8); 
  OpenMRUF(s);
end;

procedure Tui.ScriptAddCommand(Sender: TWiseListBox; Index: Integer;
  Command: String);
var
  b: Boolean;
begin
  b := RenderInsertScript(Command, Index, True);
  if b then
  begin
    RenderDeleteScriptEx(Index +1, false);
    CodeComplete(Command, Index);
    RehashIndents;
    if Script.Items.Count > Index +1 then
    begin
      Script.ItemIndex := Index +1;
      Script.Selected[Index +1] := True;
    end;
  end
  else
  begin
    RenderDeleteScriptEx(Index, false);
    RehashIndents;
    if Script.Items.Count > Index then
    begin
      Script.ItemIndex := Index;
      Script.Selected[Index] := True;
    end;
  end;
  EditAction1.ShortCut := ShortCut(13, []);
  
end;

procedure Tui.ScriptAddRemovePlaceholder(Sender: TWiseListBox; Index: Integer;
  Add: Boolean);
var
  l: TStringList;
begin
  if Index < 0 then Index := 0;
  if Add then
  begin
    if Script.Items.Count <> 0 then 
      Index := GetRealLineNumber(Index);
    EditAction1.ShortCut := ShortCut(0, []);
    
    l := TStringList.Create;
    l.Add('');
    RenderInsertScriptEx('Comment', Comments, 
      l, Index, True);
    l.Free;
    if Script.Items.Count > GetFoldedLineNumber(Index) +1 then
      Script.Selected[GetFoldedLineNumber(Index) +1] := false;
  end
  else
  begin
    RenderDeleteScriptEx(Index, false);
    if Script.Items.Count > Index then
    begin
      Script.ItemIndex := Index;
      Script.Selected[Index] := True;
    end;
    EditAction1.ShortCut := ShortCut(13, []);
    
  end;
  RehashIndents;
end;

procedure Tui.ScriptDblClick(Sender: TObject);
var
  i: Integer;
begin
  if Script.ItemAtPos(LastCursorPos, True) = -1 then Exit;
  i := GetRealLineNumber(Script.ItemAtPos(LastCursorPos, True));
  if IsLineCodeFolding(i) then ProcessCodeFolding(i)
    else RenderUpdateScript(Script.ItemAtPos(LastCursorPos, True));
end;

procedure Tui.ScriptDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  p: TPoint;
  s: String;
begin
  p.X := X;
  p.Y := Y;
  
    s := DragAcceptCaption;
  if RenderInsertScript(s, Script.ItemAtPos(p, false), True)
    then
    begin
      Script.SetFocus;
      CodeComplete(s, Script.ItemAtPos(p, false));
      ClearSelectionEx(Script);
      Script.ItemIndex := Script.ItemAtPos(p, True);
      Script.Selected[Script.ItemIndex] := True;
    end
    else
    begin
      Script.SetFocus;
      ClearSelectionEx(Script);
      Script.ItemIndex := Script.ItemAtPos(p, True);
      Script.Selected[Script.ItemIndex] := True;
    end;
end;

procedure Tui.ScriptDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  p: TPoint;
begin
  if Source = nil then Exit;
  if Script = nil then Exit;
  Accept := DragAcceptEx;
  
  if DragAcceptEx then
  begin
    p.X := X;
    p.Y := Y;
    if Script.ItemAtPos(p, True) <> -1 then 
      Script.ItemIndex := Script.ItemAtPos(p, True);
    Script.Repaint;
  end;
end;

procedure Tui.ScriptDrawItem(Control: TWinControl; Index: Integer;
  ARect: TRect; State: TOwnerDrawState);
var
  b: TImage;
  i, iX: Integer;
  cfRegion, cfStart, cfFolded: Boolean;
  s: String;
  bX: Boolean;
begin
  if IsDarkModeAppearance then
    Script.Color:= clBlack
  else
    Script.Color := clDefault;
  
  if IndentHash.Count <> ScriptBuffer.Count then Exit;
  Index := GetRealLineNumber(Index);
  
  i := StrToInt(IndentHash[Index]);
  
  with (Control as TListBox).Canvas do
  begin
  
    if Script.CaretFocus then
      HideCaretEx;
    FillRect(ARect);
    
    while Breakpoints.Count -1 < Index do
      Breakpoints.Add('');
    if Breakpoints[Index] = '' then
    begin
      Font.Color := fontLine.Color;
      Font.Style := fontLine.Style;
    end
    else
    begin
      Font.Color := clRed;
      Font.Style := [];
      
      Font.Style := fontLine.Style;
    end;
    while Bookmarks.Count -1 < Index do
      Bookmarks.Add('');
    if Bookmarks[Index] <> '' then
    
    begin
      if Breakpoints[Index] = '' then
      begin
        Font.Color := clGreen;
        Font.Style := fontLine.Style;
      end
      else
      begin
        Font.Color := clMaroon;
        Font.Style := fontLine.Style;
      end;
    end;
    if (not (odFocused in State) or (Script.SelCount > 1)) and (odSelected in State) then
      Font.Color := clHighlightText;
    if false then
    begin
      Font.Color := InvertColor(Font.Color); 
      if (Font.Color <> InvertColor(clGreen)) and (Font.Color <> InvertColor(clMaroon)) then
        TextOut(ARect.Left + 2, ARect.Top, IntToStr(Index +1))
      else
        TextOut(ARect.Left + 2, ARect.Top, Bookmarks[Index]);
    end
    else
      if (Font.Color <> clGreen) and (Font.Color <> clMaroon) then
        TextOut(ARect.Left + 2, ARect.Top, IntToStr(Index +1))
      else
        TextOut(ARect.Left + 2, ARect.Top, Bookmarks[Index]);
    Pen.Color := fontLine.Color;
    Pen.Style := psSolid;
    if (not (odFocused in State) or (Script.SelCount > 1)) and (odSelected in State) then
      Pen.Color := clHighlightText;
    if IsDarkModeAppearance then 
      Pen.Color := InvertColor(Pen.Color);
    cfRegion := (ScriptTypes[Index] = 'Code Folding Region') and EnabledFolding; 
    if cfRegion then
    begin
      cfStart := StrToBool(uGui.Region[uGui.Region.IndexOf(ScriptReferences[Index]) +1]);
      cfFolded := FoldList.IndexOf(uGui.Region[uGui.Region.IndexOf(ScriptReferences[Index]) +2]) <> -1;
    end;
    if cfRegion then
    begin
      if cfStart then
      begin
        if odSelected in State then
          Font.Color := fontLine.Color;
        if odSelected in State then
          Font.Color := clHighlightText;
        if IsDarkModeAppearance then
          Font.Color := InvertColor(Font.Color);
        if Font.Size >= 18 then
        begin
          if cfFolded then b := LargePlus
            else b := LargeMinus;
        end
        else
          if Font.Size >= 12 then
          begin
            if cfFolded then b := MediumPlus
              else b := MediumMinus;
          end
          else
            if Font.Size >= 8 then
            begin
              if cfFolded then b := SmallPlus
                else b := SmallMinus;
            end
            else
              b := nil;
        if b <> nil then
          BrushCopy(Bounds(FontWidth *(IndentDepth -2) - (b.Width div 2),
            ARect.Top + ((ARect.Bottom - ARect.Top - b.Height) div 2),
            b.Width, b.Height), b.Picture.Bitmap,
            Bounds(0, 0, b.Width, b.Height), clRed)
        else
          if cfFolded then
            TextOut(FontWidth *(IndentDepth -2) -
              (FontWidth div 2), ARect.Top, '+')
          else
            TextOut(FontWidth *(IndentDepth -2) -
              (FontWidth div 2), ARect.Top, '-');
      end
      else
      begin
        MoveTo(FontWidth *(IndentDepth -2), ARect.Top);
        LineTo(FontWidth *(IndentDepth -2), ARect.Bottom -4);
        MoveTo(FontWidth *(IndentDepth -2), ARect.Bottom -4);
        LineTo(FontWidth *(IndentDepth -2) +
          (FontWidth div 2), ARect.Bottom -4);
      end;
    end
    else
    begin
      MoveTo(FontWidth *(IndentDepth -2), ARect.Top);
      LineTo(FontWidth *(IndentDepth -2), ARect.Bottom);
    end;
    iX := i;
    while iX > FontWidth *IndentDepth do
    begin
      Pen.Color := clLtGray; 
      
      if IsDarkModeAppearance then
        Pen.Color := clMedGray; 
      Pen.Style := psSolid;
      MoveTo(2 + ARect.Left + iX - FontWidth *2, ARect.Top);
      if odSelected in State then
      begin
        Pen.Color := clHighlightText;
        
      end;
      LineTo(2 + ARect.Left + iX - FontWidth *2, ARect.Bottom);
      iX := iX - FontWidth *2;
    end;
    Font.Style := [];
    s := AnsiLowerCase(ScriptBuffer[Index]);
    if AnsiPos(CommentConst, ScriptBuffer[Index]) = 1 then
    begin
      Font.Color := clGreen;
      Font.Style := [fsItalic];
      Font.Color := fontComment.Color;
      Font.Style := fontComment.Style;
    end
    else
    if Actions.Items.IndexOf(ScriptTypes[Index]) >
      Actions.Items.IndexOf(CommandSeperator) then
      begin
        Font.Color := fontPlugIn.Color;
        Font.Style := fontPlugIn.Style;
        Font.Color := clTeal
      end
    else
    if ((AnsiPos('if', s) = 1) or
      (AnsiPos('while', s) = 1)) or
      ((AnsiPos('until', s) = 1) or
      (AnsiPos('for each', s) = 1))
      then 
    begin
      Font.Color := fontFlowControl.Color;
      Font.Style := fontFlowControl.Style;
    end
    else
    if (((AnsiPos('end', s) = 1) or
      (AnsiPos('wend', s) = 1)) or
      ((AnsiPos('repeat', s) = 1) or
      (AnsiPos('break', s) = 1))) or
      ((AnsiPos('continue', s) = 1) or
      (AnsiPos('next', s) = 1)) then 
    begin
      Font.Color := fontFlowControl.Color;
      Font.Style := fontFlowControl.Style;
    end
    else
    if AnsiPos('else', s) = 1 then 
    begin
      Font.Color := clBlue;
      Font.Color := fontFlowControl.Color;
      Font.Style := fontFlowControl.Style;
      if i >  FontWidth *IndentDepth then i := i -  FontWidth *2;
    end
    else
    if AnsiPos('else if', s) = 1 then 
    begin
      Font.Color := fontFlowControl.Color;
      Font.Style := fontFlowControl.Style;
      if i >  FontWidth *IndentDepth then i := i -  FontWidth *2;
    end
    else
    if AnsiPos('wizard loop', s) = 1 then 
    begin
      Font.Color := fontFlowControl.Color;
      Font.Style := fontFlowControl.Style;
    end
    else
    if AnsiPos('return from include script', s) = 1 then 
    begin
      Font.Color := fontFlowControl.Color;
      Font.Style := fontFlowControl.Style;
    end
    else
    if AnsiPos('include', s) = 1 then 
    begin
      Font.Color := fontFlowControl.Color;
      Font.Style := fontFlowControl.Style;
    end
    else
    if AnsiPos('apply' 
      , s) = 1 then
    begin
      Font.Color := fontModifySystem.Color;
      Font.Style := fontModifySystem.Style;
    end
    else
    if AnsiPos('terminate' 
      , s) = 1 then
    begin
      Font.Color := fontModifySystem.Color;
      Font.Style := fontModifySystem.Style;
    end
    else
    if AnsiPos('transform' 
      , s) = 1 then
    begin
      Font.Color := fontModifySystem.Color;
      Font.Style := fontModifySystem.Style;
    end
    else
    if AnsiPos(' - installation mode' 
      , s) <> 0 then
    begin
      Font.Color := fontModifySystem.Color;
      Font.Style := fontModifySystem.Style;
    end
    else
    if AnsiPos('reboot' 
      , s) = 1 then
    begin
      Font.Color := fontModifySystem.Color;
      Font.Style := fontModifySystem.Style;
    end
    else
    if AnsiPos('edit ini file' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    else
    if AnsiPos('create folder' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    else
    if AnsiPos('install files' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    else
    if AnsiPos('create soft' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    else
    if AnsiPos('create hard' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    else
    if AnsiPos('set environment' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    else
    if AnsiPos('install assembly' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    else
    if AnsiPos('create file type' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    else
    if AnsiPos('advertised file type' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
      i :=  FontWidth *IndentDepth;
    end
    else
    if AnsiPos('install service' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    else
    if AnsiPos('create odbc dsn' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    else
    if AnsiPos('install odbc driver' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    else
    if AnsiPos('control service' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    else
    if AnsiPos('configure service' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    
    else
    if AnsiPos('create shortcut' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    else
    if AnsiPos('advertised shortcut' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
      i :=  FontWidth *IndentDepth;
    end
    else
    if AnsiPos('delete files' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    else
    if AnsiPos('copy local files' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    else
    if AnsiPos('move local files' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    else
    if AnsiPos('write registry' 
      , s) = 1 then
    begin
      Font.Color := fontWindowsInstaller.Color;
      Font.Style := fontWindowsInstaller.Style;
    end
    else
    if AnsiPos('['
      , s) = 1 then
      begin
        Font.Color := fontDirective.Color;
        Font.Style := fontDirective.Style;
        i :=  FontWidth *IndentDepth;
      end
    else
    if AnsiPos('label: ' 
      , s) = 1 then
      begin
        Font.Color := fontLabel.Color;
        Font.Style := fontLabel.Style;
        i :=  FontWidth *IndentDepth;
      end
    else
    if AnsiPos('goto label: ' 
      , s) = 1 then
    begin
      Font.Color := fontFlowControl.Color;
      Font.Style := fontFlowControl.Style;
    end
    else
    begin
      Font.Color := fontStatement.Color;
      Font.Style := fontStatement.Style;
    end;
    if cfRegion then
    begin
      Font.Color := fontDirective.Color;
      Font.Style := fontStatement.Style;
    end;
    if IsDarkModeAppearance then
      Font.Color := InvertColor(Font.Color);
    bX := false;
    
    if ((odSelected in State) and (not (odFocused in State) or (Script.SelCount > 1))) and (not bX) then
      Font.Color := clHighlightText;
    
    if not cfRegion then
    begin
      {$IFDEF LINUX}
      
      {$ENDIF}
      TextOut(ARect.Left + i, ARect.Top, ScriptBuffer[Index]);
      if ((odFocused in State) or (Script.SelCount = 1))
        and Script.CaretFocus then
        begin
          Script.InternalIndent := ARect.Left + i{$IFDEF WINDOWS} - GetScrollPos(Script.Handle, SB_HORZ){$ENDIF};
          
        end;
    end
    else
    begin
      if cfFolded and cfStart then
        TextOut(ARect.Left + i - FontWidth, ARect.Top, Copy(ScriptBuffer[Index], Length('[DEFINE REGION: ') +1, Length(ScriptBuffer[Index]) -1 - Length('[DEFINE REGION: ')) + ' [...]') 
      else
        TextOut(ARect.Left + i - FontWidth, ARect.Top, Copy(ScriptBuffer[Index], 2, Length(ScriptBuffer[Index]) -2));
      {$IFDEF LINUX}
      
      {$ENDIF}
      if ((odFocused in State) or (Script.SelCount = 1))
        and Script.CaretFocus then
        begin
          Script.InternalIndent := ARect.Left + i - FontWidth{$IFDEF WINDOWS}  - GetScrollPos(Script.Handle, SB_HORZ){$ENDIF};
          
        end;
    end;
    if ((odFocused in State) or (Script.SelCount = 1))
      and Script.CaretFocus then
    begin
      SetCaretPos(Script.InternalIndent, ARect.Top);
      ShowCaretEx;
    end;
    if Index = (Breakpoints.Count -1) then
    begin
      if Font.Size >= 18 then
      begin
        if IsDarkModeAppearance then
          b := _51
        else
          b := _50;
      end
      else
        if Font.Size >= 12 then
        begin
          if IsDarkModeAppearance then
            b := _36
          else
            b := _35;
        end
      else
        
        if IsDarkModeAppearance then
          b := _21
        else
          b := _20
        ;
      
    end;
  
	end;
end;

procedure Tui.ScriptKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
var
  l: TStringList;
  i, j, k: Integer;
begin
  if not (Key in [48..57]) then Exit;
  i := Key - 48;
  
  if ({$IFDEF DARWIN}ssMeta{$ELSE}ssCtrl{$ENDIF} in Shift) and (ssShift in Shift) then
  begin
    l := GetAllRealLines(Script.ItemIndex);
    for j := 1 to l.Count do
      if not IsLineCodeFolding(StrToInt(l[j -1])) then
      begin
        k := Bookmarks.IndexOf(IntToStr(i)); 
        
        if k <> -1 then
        begin
          
          Bookmarks[k] := '';
          RenderLine(k, false);
          
          if k = StrToInt(l[j -1]) then
          begin
            l.Free;
            Exit;
          end;
        end;
        Bookmarks[StrToInt(l[j -1])] := IntToStr(i);
        RenderLine(StrToInt(l[j -1]), false);
        SetDirtyMia(True, '');
        Break; 
      end;
    l.Free;
  end
  else
  if ({$IFDEF DARWIN}ssMeta{$ELSE}ssCtrl{$ENDIF} in Shift) then
  begin
    j := Bookmarks.IndexOf(IntToStr(i));
    if j <> -1 then
    begin
      AssertLineIsVisible(j);
      ClearSelectionEx(Script);
      Script.ItemIndex := GetFoldedLineNumber(j);
      Script.Selected[GetFoldedLineNumber(j)] := True;
    end;
  end;
end;

procedure Tui.ScriptMeasureItem(Control: TWinControl; Index: Integer;
  var AHeight: Integer);
var
  b: TImage;
begin
  if Index = (Breakpoints.Count -1) then
  begin
    if Font.Size >= 18 then
      b := _50
    else
      if Font.Size >= 12 then
        b := _35
    else
        b := _20;
    AHeight := b.Height;
  end;
end;

procedure Tui.ScriptMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  LastCursorPos.X := X;
  LastCursorPos.Y := Y;
end;

procedure Tui.ScriptPopupPopup(Sender: TObject);
var
  s, sX: String;
begin
  MenuItem37.Enabled :=  
    (ActiveTab <> 0) and not Running;
  MenuItem38.Enabled := MenuItem37.Enabled;
  MenuItem41.Enabled := PeekStackItem(UndoStack, s, sX);
  MenuItem42.Enabled := PeekStackItem(RedoStack, s, sX);
end;

procedure Tui.SelectAll1Click(Sender: TObject);
var
  i: Integer;
begin
  if not InDesigner then Exit;
  
  i := Script.ItemIndex;
  Script.SelectAll;
  {$IFNDEF DARWIN}
  Script.ItemIndex := i;
  {$ENDIF}
end;

procedure Tui.SelectAll2Click(Sender: TObject);
begin
  SelectAll1Click(Self);
end;

procedure Tui.ShellListMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  
    if BitBtn2.Enabled then
      ShellList.BeginDrag(True);
end;

procedure Tui.ShellListSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  s: String;
begin
  if Assigned(Item) then 
    s := ShellList.GetPathFromItem(Item)
  else
    s := '';
  if s = '' then Exit;
  
  if not MyFileExists(s)  
    then Exit;
  
  BitBtn2.Enabled := ShellList.SelCount > 0;
end;

procedure Tui.ShellTreeChange(Sender: TObject; Node: TTreeNode);
begin
  BitBtn1.Enabled := ShellTree.Path <> '';
  
  BitBtn2.Enabled := ShellList.SelCount > 0;
end;

procedure Tui.ShellTreeChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
begin
  if ShellTree.GetPathFromNode(Node) <> '' then
    if DirectoryExists(ShellTree.GetPathFromNode(Node)) then
      
      if AnsiCompareText(ShellTree.GetPathFromNode(Node), PathDelim) <> 0 then
        
        AllowChange := True;
end;

procedure Tui.ShellTreeMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  
    if BitBtn1.Enabled then
      ShellTree.BeginDrag(false);
end;

procedure Tui.SpeedButton1Click(Sender: TObject);
var
  n, nX: TTreeNode;
begin
  
  if Features.Selected = nil then Exit;
  n := Features.Selected;
  if n.Parent = nil then Exit;
  if n.Index = 0 then Exit;
  nX := n.Parent.Items[n.Index -1];
  n.MoveTo(nX, naInsert);
  SwapNamedFeaturesInScript(GetComponentPathFromTree(n), GetComponentPathFromTree(nX));
end;

procedure Tui.SpeedButton2Click(Sender: TObject);
var
  n, nX: TTreeNode;
begin
  
  if Features.Selected = nil then Exit;
  n := Features.Selected;
  if n.Parent = nil then Exit;
  if n.Index +1 = n.Parent.Count then Exit;
  nX := n.Parent.Items[n.Index +1];
  nX.MoveTo(n, naInsert);
  SwapNamedFeaturesInScript(GetComponentPathFromTree(nX), GetComponentPathFromTree(n));
end;

procedure Tui.TabSetChange(Sender: TObject);
begin
  SwitchToUI(TabSet.TabIndex = 0);
end;

procedure Tui.TimerMaximizeTimer(Sender: TObject);
begin
  TimerMaximize.Enabled := false;
  SendMessage(Handle, LM_SYSCOMMAND, SC_MAXIMIZE, 0);
end;

procedure Tui.TreeExChange(Sender: TObject; Node: TTreeNode);
begin
  
  if Node.ImageIndex <> 0 then
  begin
    
    case Node.AbsoluteIndex of
      1: CategoriesSelectedItemCaption := 'Project Properties';
      2: CategoriesSelectedItemCaption := 'Setup Icon';
      4: CategoriesSelectedItemCaption := 'Features';
      5: CategoriesSelectedItemCaption := 'Files';
      6: CategoriesSelectedItemCaption := 'File Associations';
      7: CategoriesSelectedItemCaption := 'INI Files';
      9: CategoriesSelectedItemCaption := 'Dialogs';
      10: CategoriesSelectedItemCaption := 'EULA and ReadMe';
      11: CategoriesSelectedItemCaption := 'Shortcuts';
      13: CategoriesSelectedItemCaption := 'Access Control';
      14: CategoriesSelectedItemCaption := 'Run Programs';
      15: CategoriesSelectedItemCaption := 'Local Files';
      17: CategoriesSelectedItemCaption := 'Build Settings';
      18: CategoriesSelectedItemCaption := 'Web Media Blocks';
      20: CategoriesSelectedItemCaption := 'Update Packs';
      21: CategoriesSelectedItemCaption := 'Versions';
      22: CategoriesSelectedItemCaption := 'Script Analytics';
    end;
  end;
  
  if TreeEx.Selected <> nil then
  begin
    
    CategoriesSelectedItemCaptionLocalizable := Node.Text;
    CategoriesButtonClicked(Self);
    VisualNotebook.HelpKeyword := 'visual' + StringReplace(CategoriesSelectedItemCaption, ' ', '', [rfReplaceAll, rfIgnoreCase]) + '.htm'; 
    VisualNotebook.HelpKeyword := StringReplace(VisualNotebook.HelpKeyword,
      'visualSetupIcon', 'visualadd-removeprograms', [rfReplaceAll, rfIgnoreCase]);
  end
  else
    VisualNotebook.HelpKeyword := 'welcome.htm'; 
  TreeEx.HelpKeyword := VisualNotebook.HelpKeyword;
end;

procedure Tui.TreeExChanging(Sender: TObject; Node: TTreeNode;
  var AllowChange: Boolean);
var
  i: Integer;
  s1, s2, s3: String;
begin
  AllowChange := True;
  
end;

procedure Tui.WebBlocksChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  EditWebBlock.Enabled := WebBlocks.SelCount = 1;
  BuildSel.Enabled := WebBlocks.SelCount >= 1;
  SkipSel.Enabled := WebBlocks.SelCount >= 1;
end;

procedure Tui.WebBlocksDblClick(Sender: TObject);
begin
  if WebBlocks.Selected <> nil then
    EditWebBlockClick(Self);
end;

procedure Tui.WebBlocksKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    WebBlocksDblClick(Self);
end;

procedure Tui.WebBlocksKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key = 45 then
    if BuildSel.Enabled then
      BuildSelClick(Self);
  if Key = 46 then
    if SkipSel.Enabled then
      SkipSelClick(Self);
end;

procedure Tui.WebBlocksMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  WebBlocksChange(Self, nil, ctState);
end;

procedure Tui.WebBlocksSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
begin
end;

procedure Tui.wodbcClick(Sender: TObject);
var
  v: Boolean;
  i: Integer;
  s: String;
  l, lX: TStringList;
  InsertIndex: Integer;
begin
  
  Reentry := false;
  mnewshortcut.NewShortcut.ShortcutTarget.Text := '';
  mnewshortcut.NewShortcut.ShortText.Text := '';
  mnewshortcut.NewShortcut.ShortDescription.Text := '';
  mnewshortcut.NewShortcut.StartFolder.Checked := false;
  mnewshortcut.NewShortcut.StartTop.Checked := false;
  mnewshortcut.NewShortcut.QuickLaunch.Checked := false;
  mnewshortcut.NewShortcut.Desktop.Checked := false;
  mnewshortcut.NewShortcut.PinXP.Checked := false;
  mnewshortcut.NewShortcut.Pin7.Checked := false;
  mnewshortcut.NewShortcut.Pin8.Checked := false;
  pinsTop := '';
  pinsMenu := '';
  pinsDesktop := '';
  pinsQuick := '';
  ActiveBox := '';
  Reentry := True;
  if mnewshortcut.NewShortcut.ShowModal = mrOk then
  begin
    if not ShortcutFilter.Checked then
    begin
      InsertIndex := FindFileItemIndex(ShortcutsBrowseSelectedFile) +1;
      if InsertIndex = 0 then
        
        InsertIndex := GetInsertionIndexBeforeApplyChanges(True);
    end
    else
      InsertIndex := GetNewFilesInsertionIndex(GetComponentPathFromCombo(ShortcutFeatures));
    if InsertIndex = -1 then
    begin
      Application.MessageBox(PChar(SApplyInstallCommandNotFoundInSet
        + MyLineEnding + SThisCommandMustBePresentInYourSc
        + MyLineEnding + MyLineEnding + SToAvoidSeeingThisMessageCreateNe),
        PChar(Application.Title), mb_Ok + mb_IconStop);
      Exit;
    end;
    v := GetLineVisibilityState(InsertIndex, false);
    l := TStringList.Create;
    l.Add(ShortcutsBrowseSelectedFile);
    l.Add(mnewshortcut.NewShortcut.ShortText.Text);
    l.Add('LOCATIONPLACEHOLDER'); 
    l.Add(mnewshortcut.NewShortcut.ShortDescription.Text);
    l.Add('');
    l.Add('');
    l.Add('');
    l.Add('');
    l.Add('0');
    s := '0|';
    if mnewshortcut.NewShortcut.Desktop.Checked then
    begin
      l[2] := GetOrCreateAndGetFolderLocationVariable('System->Desktop Directory', 
        InsertIndex, 'DESKTOPDIR'); 
      l[8] := s + pinsDesktop;
      v := GetLineVisibilityState(InsertIndex, false);
      RenderInsertScriptEx('Create Shortcut', Short, l, InsertIndex, v); 
    end;
    if mnewshortcut.NewShortcut.QuickLaunch.Checked then
    begin
      l[2] := GetOrCreateAndGetFolderLocationVariable('Taskbar->Quick Launch Directory', 
        InsertIndex, 'QUICKLAUNCHDIR'); 
      l[8] := s + pinsQuick;
      v := GetLineVisibilityState(InsertIndex, false);
      RenderInsertScriptEx('Create Shortcut', Short, l, InsertIndex, v); 
    end;
    if mnewshortcut.NewShortcut.StartFolder.Checked then
    begin
      i := InsertIndex;
      l[2] :=  '$PLATFORMMENU$';
      l[8] := s + pinsMenu;
      v := GetLineVisibilityState(InsertIndex, false);
      if i <> InsertIndex then 
      begin
        lX := TStringList.Create;
        lX.Add(l[2]);
        lX.Add(l[2] + '/$COMPANY$/$TITLE$'); 
        RenderInsertScriptEx('Set Variable', SetVariable, lX, InsertIndex, v); 
        InsertIndex := InsertIndex +1;
        lX.Free;
      end;
      RenderInsertScriptEx('Create Shortcut', Short, l, InsertIndex, v); 
    end;
    if mnewshortcut.NewShortcut.StartTop.Checked then
    begin
      l[2] := GetOrCreateAndGetFolderLocationVariable('Start Menu->Start Menu Group', 
        InsertIndex, 'SHORTCUTROOT'); 
      l[8] := s + pinsTop;
      v := GetLineVisibilityState(InsertIndex, false);
      RenderInsertScriptEx('Create Shortcut', Short, l, InsertIndex, v); 
    end;
    l.Free;
    
    RehashIndents;
    
    SetDirtyMia(True, '');
    AdjustVisualUI;
  end;
end;

function Tui.SweepUpdateShortcut: Integer;
var
  i: Integer;
begin
  
  Result := -1;
  for i := 1 to Short.Count do
    if (i mod 10) = 1 then
      if AnsiCompareText(Short[i], '$UNINSTALLLINK$') = 0 then
        if AnsiCompareText(Short[i +2], '$PLATFORMMENU$') = 0 then
          if AnsiCompareText(Short[i +4], '/update') = 0 then
          begin
            Result := ScriptReferences.IndexOf(Short[i -1]);
            Exit;
          end;
end;

function Tui.SetUpdateShortcut(bEnabled: Boolean): Boolean;
var
  InsertIndex: Integer;
  l: TStringList;
begin
  Result := false;
  if bEnabled then
  begin
    if SweepUpdateShortcut = -1 then
    begin
      InsertIndex := GetNewFilesInsertionIndex('');
      if InsertIndex = -1 then
      begin
        Application.MessageBox(PChar(SApplyInstallCommandNotFoundInSet
          + MyLineEnding + 'This command must be present in your script before you may use automatic/manual update checking with your project.'
          + MyLineEnding + MyLineEnding + SToAvoidSeeingThisMessageCreateNe_1),
          PChar(Application.Title), mb_Ok + mb_IconStop);
        Exit;
      end;
      InsertIndex := GetNewFilesInsertionIndex('');
      l := TStringList.Create;
      l.Add('$UNINSTALLLINK$');
      l.Add('#TITLE# Update');
      l.Add('$PLATFORMMENU$');
      l.Add('Updates this InstallAware Software product');
      l.Add('/update');
      l.Add('');
      l.Add('');
      l.Add('');
      l.Add('0');
      RenderInsertScriptEx('Create Shortcut', Short, l, InsertIndex, GetLineVisibilityState(InsertIndex, false));
      l.Free;
      RehashIndents;
      try
        Script.ItemIndex := GetFoldedLineNumber(GetNewFilesInsertionIndex(''));
      except
      end;
    end
  end
  else
    if SweepUpdateShortcut <> -1 then
      RenderDeleteScriptEx(SweepUpdateShortcut, True);
  RehashIndents;
  Result := True;
end;

function Tui.GetTopOfScriptInsertionIndex: Integer;
var
  i: Integer;
begin
  Result := 0;
  for i := 1 to ScriptTypes.Count do
    if ScriptTypes[i -1] <> 'Comment' then 
    begin
      Result := i -1;
      Break;
    end;
end;

function Tui.GetUpdateInsertionIndex(CodeGen: Boolean; DirectDeploy: Boolean
  ): Integer;
var
  s: String;
  v: Boolean;
  i: Integer;
  l: TStringList;
begin
  Result := -1;
  s := 'Application Updates';
  if DirectDeploy then
    s := 'InstallAware Direct Deploy';
  
  for i := 1 to Region.Count do
    if i mod 3 = 1 then
      if StrToBool(Region[i -1 + 1]) then
        if CompareText(Region[i -1 +2], s) = 0 then 
        begin
          Result := ScriptReferences.IndexOf(Region[i -1]) +1;
          Exit;
        end;
  
  Result := GetTopOfScriptInsertionIndex;
  if CodeGen then
  begin
    i := Result;
    v := GetLineVisibilityState(i, false);
    if i <> -1 then
    begin
      l := TStringList.Create;
      l.Add('TRUE'); 
      l.Add(s); 
      RenderInsertScriptEx('Code Folding Region', Region, l, i, v); 
      i := i +1;
      l.Clear;
      l.Add('FALSE'); 
      l.Add('');
      RenderInsertScriptEx('Code Folding Region', Region, l, i, v); 
      i := i +1;
      l.Clear;
      l.Add('');
      RenderInsertScriptEx('Comment', Comments, l, i, v); 
      l.Free;
      Result := i -1;
      RehashIndents;
    end;
  end;
end;

function Tui.GetUpdateServer: String;
var
  i: Integer;
  l: TStringList;
begin
  Result := '';
  l := TStringList.Create;
  l.CommaText := ProjectStruct.Conditionals;
  for i := 1 to l.Count do
    if AnsiPos('UPDATE_SERVER=', l[i -1]) = 1 then 
    begin
      Result := l[i -1];
      Delete(Result, 1, Length('UPDATE_SERVER=')); 
      l.Free;
      Exit;
    end;
  l.Free;
end;

function Tui.GetUpdateEnabledState: Boolean;
var
  i: Integer;
begin
  Result := false;
  for i := 1 to xInclude.Count do
    if (i mod 2) = 0 then
      if CompareText(xInclude[i -1], 'updates') = 0 then 
      begin
        Result := True;
        Exit;
      end;
end;

function Tui.FixUpPath(Path: String): String;
begin
  
  Result := Path;
end;

function Tui.GetINIForComponent(Feature: String; FeatureFilter: Boolean
  ): TStrings;
var
  i, j: Integer;
  b: Boolean;
  s: String;
begin
  Result := TStringList.Create;
  if not FeatureFilter then
  begin
    for i := 1 to EditINI.Count do
      if (i -1) mod 7 = 0 then
      begin
        Result.Add(AssertDir(EditINI[(i -1) + 1]) + EditINI[(i -1) + 2]);
        Result.Add(EditINI[(i -1) + 4]);
        Result.Add(EditINI[(i -1) + 5] + ' = ' + EditINI[(i -1) + 6]);
        Result.Add(scrEditIniFile.Action.Items[StrToInt(EditINI[(i -1) + 3])]);
        if (StrToInt(EditINI[(i -1) + 3]) = 2) or (StrToInt(EditINI[(i -1) + 3]) = 4) then
          Result.Add('100')
        else
          Result.Add('101');
        Result.Add(EditINI[i -1]);
      end;
  end
  else
  begin
    if Feature = '' then b := True 
      else b := false; 
    for i := 1 to ScriptTypes.Count do
    begin
      s := ScriptTypes[i -1];
      if s = 'Get Component State' then 
      begin
        if Feature = '' then Exit 
        else
          b := Feature =
            GetComponent[GetComponent.IndexOf(ScriptReferences[i -1]) +1];
      end
      else
      if b and (s = 'Edit INI File') then 
      begin
        j := EditINI.IndexOf(ScriptReferences[i -1]);
        Result.Add(AssertDir(EditINI[j + 1]) + EditINI[j + 2]);
        Result.Add(EditINI[j + 4]);
        Result.Add(EditINI[j + 5] + ' = ' + EditINI[j + 6]);
        Result.Add(scrEditIniFile.Action.Items[StrToInt(EditINI[j + 3])]);
        if (StrToInt(EditINI[j + 3]) = 2) or (StrToInt(EditINI[j + 3]) = 4) then
          Result.Add('100')
        else
          Result.Add('101');
        Result.Add(EditINI[j]);
      end;
    end;
  end;
end;

procedure Tui.FeatureAwareINIPopulate(SingleItem: TListItem);
var
  i: Integer;
  l: TStrings;
  li: TListItem;
begin
  if SingleItem = nil then
  begin
    INI.Items.BeginUpdate;
    INI.Items.Clear;
  end;
  l := GetINIForComponent(GetComponentPathFromCombo(INIFeatures),
    INIFilter.Checked);
  for i := 1 to l.Count do
    if (i -1) mod 6 = 0 then
      if SingleItem = nil then
      begin
        li := INI.Items.Add;
        li.Caption := l[i -1];
        li.SubItems.Add(l[i -1 +1]);
        li.SubItems.Add(l[i -1 +2]);
        li.SubItems.Add(l[i -1 +3]);
        li.ImageIndex := StrToInt(l[i -1 +4]);
        li.SubItems.Add(l[i -1 +5]);
      end
      else
      if l[i -1 +5] = SingleItem.SubItems[3] then
      begin
        SingleItem.Caption := l[i -1];
        SingleItem.SubItems[0] := l[i -1 +1];
        SingleItem.SubItems[1] := l[i -1 +2];
        SingleItem.SubItems[2] := l[i -1 +3];
        SingleItem.ImageIndex := StrToInt(l[i -1 +4]);
        SingleItem.SubItems[3] := l[i -1 +5];
      end;
  if SingleItem = nil then
    INI.Items.EndUpdate;
  l.Free;
end;

function Tui.GetLocalForComponent(Feature: String; FeatureFilter: Boolean
  ): TStrings;
var
  Wide1, Wide2: String;
  i, j: Integer;
  b: Boolean;
  s: String;
begin
  Result := TStringList.Create;
  if not FeatureFilter then
  begin
    for i := 1 to LocalFiles.Count do
      if (i -1) mod 7 = 0 then
      begin
        Result.Add(AssertDir(LocalFiles[(i -1) + 1]) + LocalFiles[(i -1) + 2]);
        WidenColonDelimParam(LocalFiles[(i -1) + 5], Wide1, Wide2);
        if Wide2 = '' then Wide2 := 'FALSE';
        if StrToBool(Wide1) then
        begin
          s := 'Copy to ';
          Result.Add('102');
        end
        else
        begin
          s := 'Move to ';
          Result.Add('103');
        end;
        s := s + AssertDir(LocalFiles[(i -1) + 3]) + LocalFiles[(i -1) + 4];
        Result.Add(s);
        Result.Add(LocalFiles[i -1]);
      end;
    for i := 1 to DeleteFiles.Count do
      if (i -1) mod 5 = 0 then
      begin
        Result.Add(AssertDir(DeleteFiles[(i -1) + 1]) + DeleteFiles[(i -1) + 2]);
        s := 'Delete when ';
        if StrToBool(DeleteFiles[(i -1) + 3]) and StrToBool(DeleteFiles[(i -1) + 4]) then
          s := s + 'installing and uninstalling'
        else
        if StrToBool(DeleteFiles[(i -1) + 3]) then
          s := s + 'installing'
        else
        if StrToBool(DeleteFiles[(i -1) + 4]) then
          s := s + 'uninstalling';
        if s = 'Delete when ' then
          s := 'Delete (please specify timing)';
        Result.Add('104');
        Result.Add(s);
        Result.Add(DeleteFiles[i -1]);
      end;
  end
  else
  begin
    if Feature = '' then b := True 
      else b := false; 
    for i := 1 to ScriptTypes.Count do
    begin
      s := ScriptTypes[i -1];
      if s = 'Get Component State' then 
      begin
        if Feature = '' then Exit 
        else
          b := Feature =
            GetComponent[GetComponent.IndexOf(ScriptReferences[i -1]) +1];
      end
      else
      if b and ((s = 'Copy/Move Local Files') or (s = 'Delete Files')) then 
      begin
        if s = 'Copy/Move Local Files' then
        begin
          j := LocalFiles.IndexOf(ScriptReferences[i -1]);
          Result.Add(AssertDir(LocalFiles[j + 1]) + LocalFiles[j + 2]);
          WidenColonDelimParam(LocalFiles[j + 5], Wide1, Wide2);
          if Wide2 = '' then Wide2 := 'FALSE';
          if StrToBool(Wide1) then
          begin
            s := 'Copy to ';
            Result.Add('102');
          end
          else
          begin
            s := 'Move to ';
            Result.Add('103');
          end;
          s := s + AssertDir(LocalFiles[j + 3]) + LocalFiles[j + 4];
          Result.Add(s);
          Result.Add(LocalFiles[j]);
        end;
        if s = 'Delete Files' then
        begin
          j := DeleteFiles.IndexOf(ScriptReferences[i -1]);
          Result.Add(AssertDir(DeleteFiles[j + 1]) + DeleteFiles[j + 2]);
          s := 'Delete when ';
          if StrToBool(DeleteFiles[j + 3]) and StrToBool(DeleteFiles[j + 4]) then
            s := s + 'installing and uninstalling'
          else
          if StrToBool(DeleteFiles[j + 3]) then
            s := s + 'installing'
          else
          if StrToBool(DeleteFiles[j + 4]) then
            s := s + 'uninstalling';
          if s = 'Delete when ' then
            s := 'Delete (please specify timing)';
          Result.Add('104');
          Result.Add(s);
          Result.Add(DeleteFiles[j]);
        end;
      end;
    end;
  end;
end;

procedure Tui.FeatureAwareLocalPopulate(SingleItem: TListItem);
var
  i: Integer;
  l: TStrings;
  li: TListItem;
begin
  if SingleItem = nil then
  begin
    Local.Items.BeginUpdate;
    Local.Items.Clear;
  end;
  l := GetLocalForComponent(GetComponentPathFromCombo(LocalFeatures),
    LocalFilter.Checked);
  for i := 1 to l.Count do
    if (i -1) mod 4 = 0 then
      if SingleItem = nil then
      begin
        li := Local.Items.Add;
        li.Caption := l[i -1];
        li.ImageIndex := StrToInt(l[i -1 +1]);
        li.SubItems.Add(l[i -1 +2]);
        li.SubItems.Add(l[i -1 +3]);
      end
      else
      if l[i -1 +3] = SingleItem.SubItems[1] then
      begin
        SingleItem.Caption := l[i -1];
        SingleItem.ImageIndex := StrToInt(l[i -1 +1]);
        SingleItem.SubItems[0] := l[i -1 +2];
        SingleItem.SubItems[1] := l[i -1 +3];
      end;
  if SingleItem = nil then
    Local.Items.EndUpdate;
  l.Free;
end;

function Tui.GetInsertionIndexBeforeApplyChangesWithFeatureSupport(
  Feature: String; EnforceFeature: Boolean): Integer;
var
  InsertIndex: Integer;
begin
  if not EnforceFeature then
    InsertIndex := GetInsertionIndexBeforeApplyChanges(True)
  else
    InsertIndex := GetNewFilesInsertionIndex(Feature);
  Result := InsertIndex;
end;

function Tui.GetAssnsForComponent(Feature: String; FeatureFilter: Boolean
  ): TStrings;
var
  Wide1, Wide2, Wide3, Wide4, Wide5, Wide6: String;
  i, j: Integer;
  b: Boolean;
  s: String;
begin
  Result := TStringList.Create;
  if not FeatureFilter then
  begin
    for i := 1 to FileType.Count do
      if (i -1) mod 8 = 0 then
      begin
        WidenColonDelimParam(FileType[(i -1) + 1], Wide1, Wide2);
        WidenColonDelimParam(FileType[(i -1) + 2], Wide3, Wide4);
        WidenColonDelimParam(FileType[(i -1) + 3], Wide5, Wide6);
        Result.Add(Wide1);
        Result.Add(FileType[(i -1) + 6]);
        Result.Add(Wide3);
        Result.Add(Wide5);
        if ScriptTypes[ScriptReferences.IndexOf(FileType[i -1])] = 'Advertised File Type' then 
          Result.Add(SAdvertised)
        else
          Result.Add(SRegular);
        Result.Add('58');
        Result.Add(FileType[i -1]);
      end;
  end
  else
  begin
    if Feature = '' then b := True 
      else b := false; 
    for i := 1 to ScriptTypes.Count do
    begin
      s := ScriptTypes[i -1];
      if s = 'Get Component State' then 
      begin
        if Feature = '' then Exit 
        else
          b := Feature =
            GetComponent[GetComponent.IndexOf(ScriptReferences[i -1]) +1];
      end
      else
      if b and ((s = 'Create File Type') or (s = 'Advertised File Type')) then 
      begin
        j := FileType.IndexOf(ScriptReferences[i -1]);
        WidenColonDelimParam(FileType[j + 1], Wide1, Wide2);
        WidenColonDelimParam(FileType[j + 2], Wide3, Wide4);
        WidenColonDelimParam(FileType[j + 3], Wide5, Wide6);
        Result.Add(Wide1);
        Result.Add(FileType[j + 6]);
        Result.Add(Wide3);
        Result.Add(Wide5);
        if s = 'Advertised File Type' then 
          Result.Add(SAdvertised)
        else
          Result.Add(SRegular);
        Result.Add('58');
        Result.Add(FileType[j]);
      end;
    end;
  end;
end;

procedure Tui.FeatureAwareAssnPopulate(SingleItem: TListItem);
var
  i: Integer;
  l: TStrings;
  li: TListItem;
begin
  if SingleItem = nil then
  begin
    Assocs.Items.BeginUpdate;
    Assocs.Items.Clear;
  end;
  l := GetAssnsForComponent(GetComponentPathFromCombo(AssnFeatures),
    AssnFilter.Checked);
  for i := 1 to l.Count do
    if (i -1) mod 7 = 0 then
      if SingleItem = nil then
      begin
        li := Assocs.Items.Add;
        li.Caption := l[i -1];
        li.SubItems.Add(l[i -1 +1]);
        li.SubItems.Add(l[i -1 +2]);
        li.SubItems.Add(l[i -1 +3]);
        li.SubItems.Add(l[i -1 +4]);
        li.ImageIndex := StrToInt(l[i -1 +5]);
        li.SubItems.Add(l[i -1 +6]);
      end
      else
      if l[i -1 +6] = SingleItem.SubItems[4] then
      begin
        SingleItem.Caption := l[i -1];
        SingleItem.SubItems[0] := l[i -1 +1];
        SingleItem.SubItems[1] := l[i -1 +2];
        SingleItem.SubItems[2] := l[i -1 +3];
        SingleItem.SubItems[3] := l[i -1 +4];
        SingleItem.ImageIndex := StrToInt(l[i -1 +5]);
        SingleItem.SubItems[4] := l[i -1 +6];
      end;
  if SingleItem = nil then
    Assocs.Items.EndUpdate;
  l.Free;
end;

function Tui.GetAccForComponent(Feature: String; FeatureFilter: Boolean
  ): TStrings;
var
  i, j: Integer;
  b, bX: Boolean;
  s, sX, sY: String;
  Wide1, Wide2: String;
begin
  Result := TStringList.Create;
  if not FeatureFilter then
  begin
    for i := 1 to ACL.Count do
      if (i mod 17) = 1 then
      begin
        if StrToBool(ACL[(i -1) + 12]) then
        begin
          Result.Add(SFileSystem);
          Result.Add('67');
        end;
        if StrToBool(ACL[(i -1) + 13]) then
        begin
          Result.Add(SShare);
          Result.Add('64');
        end;
        if StrToBool(ACL[(i -1) + 14]) then
        begin
          Result.Add(SRegistry);
          Result.Add('66');
        end;
        if StrToBool(ACL[(i -1) + 15]) then
        begin
          Result.Add(SService_1);
          Result.Add('63');
        end;
        if StrToBool(ACL[(i -1) + 16]) then
        begin
          Result.Add(SPrinter);
          Result.Add('65');
        end;
        Result.Add(ACL[(i -1) + 1]);
        sX := '';
        if StrToBool(ACL[(i -1) + 2]) then
          sX := sX + SEveryone_1;
        if StrToBool(ACL[(i -1) + 3]) then
          sX := sX + SCurrentUser_1;
        if StrToBool(ACL[(i -1) + 4]) then
          sX := sX + SAuthenticatedUsers_1;
        if StrToBool(ACL[(i -1) + 5]) then
          sX := sX + ', ' + ACL[(i -1) + 6];
        if sX <> '' then
          sX := Copy(sX, 3, Length(sX));
        Result.Add(sX);
        WidenColonDelimParam(ACL[(i -1) + 8], Wide1, Wide2);
        if Wide2 = '' then
          Wide2 := 'FALSE'; 
        if StrToBool(ACL[(i -1) + 9]) then
        begin
          sY := '';
          if StrToBool(ACL[(i -1) + 7]) then
            sY := 'Read';
          if StrToBool(Wide1) then
            if sY = '' then
              sY := 'Write'
            else
              sY := sY + ', Write';
          if StrToBool(Wide2) then
            if sY = '' then
              sY := 'Execute'
            else
              sY := sY + ', Execute';
          if sY = '' then
            Result.Add(SNoChanges)
            else
          Result.Add(sY);
        end
        else
        begin
          if StrToBool(ACL[(i -1) + 10]) then
            Result.Add(SNone);
          if StrToBool(ACL[(i -1) + 11]) then
            Result.Add(SFull);
        end;
        Result.Add(ACL[i -1]);
      end;
  end
  else
  begin
    bX := false; 
    b := false; 
    for i := 1 to ScriptTypes.Count do
    begin
      s := ScriptTypes[i -1];
      if s = 'Get Component State' then 
      begin
        if Feature = '' then
        begin
          if bX then Exit; 
        end
        else
          b := (Feature =
            GetComponent[GetComponent.IndexOf(ScriptReferences[i -1]) +1]) and bX;
      end
      else
      if s = 'Apply Changes' then 
      begin
        if (ApplyChanges[ApplyChanges.IndexOf(ScriptReferences[i -1]) + 3] = 'TRUE') or 
          (ApplyChanges[ApplyChanges.IndexOf(ScriptReferences[i -1]) + 3] = '-1') then 
        begin
          bX := True;
          if Feature = '' then
            b := True; 
        end;
      end
      else
      if b and (s = 'Set Access Control') then 
      begin
        j := ACL.IndexOf(ScriptReferences[i -1]);
        if StrToBool(ACL[j + 12]) then
        begin
          Result.Add(SFileSystem);
          Result.Add('67');
        end;
        if StrToBool(ACL[j + 13]) then
        begin
          Result.Add(SShare);
          Result.Add('64');
        end;
        if StrToBool(ACL[j + 14]) then
        begin
          Result.Add(SRegistry);
          Result.Add('66');
        end;
        if StrToBool(ACL[j + 15]) then
        begin
          Result.Add(SService_1);
          Result.Add('63');
        end;
        if StrToBool(ACL[j + 16]) then
        begin
          Result.Add(SPrinter);
          Result.Add('65');
        end;
        Result.Add(ACL[j + 1]);
        sX := '';
        if StrToBool(ACL[j + 2]) then
          sX := sX + SEveryone_1;
        if StrToBool(ACL[j + 3]) then
          sX := sX + SCurrentUser_1;
        if StrToBool(ACL[j + 4]) then
          sX := sX + SAuthenticatedUsers_1;
        if StrToBool(ACL[j + 5]) then
          sX := sX + ', ' + ACL[j + 6];
        if sX <> '' then
          sX := Copy(sX, 3, Length(sX));
        Result.Add(sX);
        WidenColonDelimParam(ACL[j + 8], Wide1, Wide2);
        if Wide2 = '' then
          Wide2 := 'FALSE';
        if StrToBool(ACL[j + 9]) then
        begin
          sY := '';
          if StrToBool(ACL[j + 7]) then
            sY := 'Read';
          if StrToBool(Wide1) then
            if sY = '' then
              sY := 'Write'
            else
              sY := sY + ', Write';
          if StrToBool(Wide2) then
            if sY = '' then
              sY := 'Execute'
            else
              sY := sY + ', Execute';
          if sY = '' then
            Result.Add(SNoChanges)
            else
          Result.Add(sY);
        end
        else
        begin
          if StrToBool(ACL[j + 10]) then
            Result.Add(SNone);
          if StrToBool(ACL[j + 11]) then
            Result.Add(SFull);
        end;
        Result.Add(ACL[j]);
      end;
    end;
  end;
end;

procedure Tui.FeatureAwareAccPopulate(SingleItem: TListItem);
var
  i: Integer;
  l: TStrings;
  li: TListItem;
begin
  if SingleItem = nil then
  begin
    Access.Items.BeginUpdate;
    Access.Items.Clear;
  end;
  l := GetAccForComponent(GetComponentPathFromCombo(AccFeatures),
    AccFilter.Checked);
  for i := 1 to l.Count do
    if (i -1) mod 6 = 0 then
      if SingleItem = nil then
      begin
        li := Access.Items.Add;
        li.Caption := l[i -1];
        li.ImageIndex := StrToInt(l[i -1 +1]);
        li.SubItems.Add(l[i -1 +2]);
        li.SubItems.Add(l[i -1 +3]);
        li.SubItems.Add(l[i -1 +4]);
        li.SubItems.Add(l[i -1 +5]);
      end
      else
      if l[i -1 +5] = SingleItem.SubItems[3] then
      begin
        SingleItem.Caption := l[i -1];
        SingleItem.ImageIndex := StrToInt(l[i -1 +1]);
        SingleItem.SubItems[0] := l[i -1 +2];
        SingleItem.SubItems[1] := l[i -1 +3];
        SingleItem.SubItems[2] := l[i -1 +4];
        SingleItem.SubItems[3] := l[i -1 +5];
      end;
  if SingleItem = nil then
    Access.Items.EndUpdate;
  l.Free;
end;

function Tui.GetAfterApplyInstallWithFeatureInsertionIndex(Feature: String
  ): Integer;
var
  i, j, k: Integer;
  l: TStringList;
  v: Boolean;
begin
  
  Result := -1;
  j := GetInsertionIndexAfterApplyChanges(True, True);
  if j = -1 then Exit;
  
  for i := j to ScriptTypes.Count do
    if ScriptTypes[i -1] = 'Get Component State' then 
    begin
      if Feature = '' then
      begin
        Result := i -1;
        if ScriptTypes[i -2] = 'Web Media Block' then 
          Result := Result -1;
        Exit;
      end
      else
      if Feature = GetComponent[GetComponent.IndexOf(ScriptReferences[i -1]) +1] then
        if ScriptTypes.Count -1 >= i then
          if ScriptTypes[i] = 'If' then 
            if xIf[xIf.IndexOf(ScriptReferences[i]) +1] = 'SELECTED' then 
              if ScriptTypes.Count -1 >= i +1 then
              begin
                Result := i +1;
                Exit;
              end;
    end;
  
  if Result = -1 then
  begin
    Result := j +1;
    if Feature = '' then Exit;
    
    Result := -1;
    k := 0; 
    for i := j +1 to ScriptTypes.Count do
      if ScriptTypes[i -1] = 'End' then 
      begin
        if k = 0 then
        begin
          Result := i -1;
          Break;
        end
        else
          k := k -1;
      end
      else
      if ScriptTypes[i -1] = 'If' then 
      begin
        k := k +1;
      end;
    if Result = -1 then Exit; 
    l := TStringList.Create;
    l.Add(Feature);
    l.Add('SELECTED'); 
    v := GetLineVisibilityState(Result, false);
    RenderInsertScriptEx('Get Component State', GetComponent, l, 
      Result, v);
    Result := Result +1;
    l.Clear;
    l.Add('SELECTED'); 
    l.Add('0');
    l.Add('TRUE'); 
    l.Add('FALSE'); 
    RenderInsertScriptEx('If', xIf, l, Result, v); 
    Result := Result +1;
    l.Free;
    RenderInsertScriptEx('End', nil, nil, Result, v); 
    RehashIndents;
  end;
end;

function Tui.GetInsertionIndexAfterApplyChangesWithFeatureSupport(
  Feature: String; EnforceFeature, CodeGen: Boolean): Integer;
var
  InsertIndex: Integer;
begin
  if not EnforceFeature then
    InsertIndex := GetInsertionIndexAfterApplyChanges(True, CodeGen)
  else
    InsertIndex := GetAfterApplyInstallWithFeatureInsertionIndex(Feature);
  Result := InsertIndex;
end;

procedure Tui.OpenRunFile(BuildMode: Integer);
var
  s: String;
begin
  s := SniffRunFile(BuildMode);
  if MyFileExists(s) then
    LaunchAppAndWait(s, '', True, false, True)
  else
  begin
    {$IFDEF DARWIN}
    if DirectoryExists(s) then
    begin
      if BuildMode = -1 then
        MenuItem17Click(Self);
      if BuildMode = 0 then
        MenuItem53Click(Self);
      if BuildMode = 1 then
        MenuItem54Click(Self);
      if BuildMode = 2 then
        MenuItem57Click(Self);
      Exit;
    end;
    {$ENDIF}
    Application.MessageBox(PChar(SPleaseBuildYourProjectBeforeRunn),
      PChar(Application.Title), mb_Ok + mb_IconExclamation);
  end;
end;

function Tui.SniffRunFile(BuildMode: Integer): String;
var
  s, sX, sY: String;
begin
  s := SniffBuildFolder(BuildMode);
  if BuildMode = -1 then
    BuildMode := ProjectStruct.BuildLayout;
  if BuildMode = 0 then
    sY := 'miaxstub';
  if BuildMode = 1 then
    sY := 'dependentx';
  if BuildMode = 2 then
    sY := 'dependentx';
  sX := s;
  if ProjectStruct.OutputFile = '' then
    s := sX + ExtractFileNameOnly(CurrentProjectName) {$IFDEF WINDOWS} + '.exe' {$ENDIF} 
  else
    s := sX + ProjectStruct.OutputFile {$IFDEF WINDOWS} + '.exe' {$ENDIF}; 
  s := SubstituteCompilerVariables(s, false);
  {$IFDEF DARWIN}
  s := s + '.app';
  if not DirectoryExists(s) then
  {$ELSE}
  if not MyFileExists(s) then
  {$ENDIF}
    if DirectoryExists(sX) then 
    begin
      Result := sX;
      Exit;
    end;
  {$IFDEF DARWIN}
  Result := s + '/Contents/MacOS/' + sY;
  
  {$ELSE}
  Result := s;
  {$ENDIF}
end;

procedure Tui.OpenBuildFolder(BuildMode: Integer);
var
  s: String;
begin
  s := SniffBuildFolder(BuildMode);
  if not DirectoryExists(s) then
    Application.MessageBox(PChar(SPleaseBuildYourProjectBeforeOpen),
      PChar(Application.Title), mb_Ok + mb_IconExclamation)
  else
    {$IFDEF DARWIN}
    RunCmdFromPath('open', '"' + s + '"'); 
    {$ELSE}
    {$IFDEF LINUX}
    RunCmdFromPath('xdg-open', '"' + s + '"'); 
    {$ELSE}
    RunCmdFromPath('explorer.exe', '"' + s + '"'); 
    {$ENDIF}
    {$ENDIF}
end;

function Tui.SniffBuildFolder(BuildMode: Integer): String;
begin
  if not ProjectStruct.BuildInFolder then
    Result := ProjectStruct.BuildCustomFolder
  else
  begin
    if CurrentProjectName = '' then
      Result := EXEDIR
    else
      Result := PROJDIR;
  end;
  Result := AssertDir(Result) + 'Release' + PathDelim;
  if BuildMode = -1 then
    BuildMode := ProjectStruct.BuildLayout;
  if BuildMode = 0 then
    Result := Result + 'Uncompressed' + PathDelim; 
  if BuildMode = 1 then
    Result := Result + 'Single' + PathDelim; 
  if BuildMode = 2 then
    Result := Result + 'Web' + PathDelim; 
  if BuildMode = 3 then
    Result := AssertDir(ExtractFilePath(DeAssertDir(Result))) + 'Patch' + PathDelim;
  Result := SubstituteCompilerVariables(Result, false);
end;

function Tui.RenderUpdateScriptEx(SmartPosition: Integer;
  FoldedSmartPos: Boolean): Boolean;
begin
  if FoldedSmartPos then
  SmartPosition := GetRealLineNumber(SmartPosition);
  RenderLine(SmartPosition, True);
  try
    Script.Selected[GetFoldedLineNumber(SmartPosition)] := True;
  except
    
  end;
  
  SetDirtyMia(True, '');
  SetHorizontalScrollBar(Script);
end;

function Tui.GetBitmapForm(FileName: String): Graphics.TBitmap;
var
  s: String;
  i: Integer;
  
  frmDesignX: TfrmDesign;
begin
  if not MyFileExists(FileName) then
  begin
    Result := nil;
    Exit;
  end;
  gbp.Acquire;
  try
    
    RegisterClasses([TLabel,TEdit,TMemo,TButton,TListBox,TCheckBox,TRadioButton,
      TComboBox,TGroupBox,TPanel,TBitBtn,TSpeedButton,TMaskEdit,TImage,TShape,
      TBevel,TStaticText,TFileLabel,TTrackBar,TProgressBar,TUpDown,TCheckListBox,TTreeView,
      TShellTreeView,TScrollBox]);
    if not Assigned(frmToolForm) then
      frmToolForm := TfrmToolForm.Create(nil);
    if not Assigned(frmObjectInspector) then
      frmObjectInspector := TfrmObjectInspector.Create(nil);
    frmObjectInspector.Width := 0;
    frmObjectInspector.Height := 0;
    frmDesignX := TfrmDesign.Create(nil);
    
    GetDir(0, s);
    ChDir(ExtractFilePath(FileName));
    
    frmDesignX.cmpFormDesigner.LoadFromDFM(FileName, dfmText);
    frmDesignX.Left := Screen.Width *2;
    frmDesignX.Top := Screen.Height *2;
    
    ChDir(s);
    
    {$IFNDEF DARWIN}
    frmDesignX.Show;
    {$ENDIF}
    Application.ProcessMessages; 
    Result := frmDesignX.GetFormImage;
    {$IFNDEF DARWIN}
    frmDesignX.Hide;
    {$ENDIF}
    
    frmDesignX.cmpFormDesigner.ClearForm;
    frmDesignX.Free;
    
  finally
    gbp.Release;
  end;
  
  ui.BringToFront;
  DialogsListEx.SetFocus;
end;

function Tui.GetInsertionIndexAtFinish: Integer;
var
  i: Integer;
  neRemove, neSuccess: Boolean;
begin
  Result := -1;
  for i := 1 to xIf.Count do
    if (i mod 5) = 1 then
      if CompareText(xIf[i -1 +1], 'RUNAPP') = 0 then 
        if CompareText(xIf[i -1 +3], 'TRUE') = 0 then 
      begin
        Result := ScriptReferences.IndexOf(xIf[i -1]);
        Break;
      end;
  
  if Result <> -1 then
  begin
    neRemove := false;
    neSuccess := false;
    if ScriptTypes.Count < Result +2 +2 then
    begin
      Result := -1;
      Exit; 
    end;
    if ScriptComments[Result] <> '' then Result := -1; 
    if (ScriptTypes[Result +1] <> 'If') or (ScriptComments[Result +1] <> '') then Result := -1; 
    if (ScriptTypes[Result +2] <> 'If') or (ScriptComments[Result +2] <> '') then Result := -1; 
    if (CompareText(
      xIf[xIf.IndexOf(ScriptReferences[Result +1]) +1],
      'REMOVE') = 0) and (CompareText( 
      xIf[xIf.IndexOf(ScriptReferences[Result +1]) +3],
      'FALSE') = 0) 
      then neRemove := True;
    if (CompareText(
      xIf[xIf.IndexOf(ScriptReferences[Result +2]) +1],
      'REMOVE') = 0) and (CompareText( 
      xIf[xIf.IndexOf(ScriptReferences[Result +2]) +3],
      'FALSE') = 0) 
      then neRemove := True;
    if (CompareText(
      xIf[xIf.IndexOf(ScriptReferences[Result +1]) +1],
      'SUCCESS') = 0) and (CompareText( 
      xIf[xIf.IndexOf(ScriptReferences[Result +1]) +3],
      'COMPLETE') = 0) 
      then neSuccess := True;
    if (CompareText(
      xIf[xIf.IndexOf(ScriptReferences[Result +2]) +1],
      'SUCCESS') = 0) and (CompareText( 
      xIf[xIf.IndexOf(ScriptReferences[Result +2]) +3],
      'COMPLETE') = 0) 
      then neSuccess := True;
    if not (neRemove and neSuccess) then Result := -1
      else if Result <> -1 then Result := Result +3;
  end;
end;

function Tui.GetInsertionIndexAfterApplyChanges(Install, CodeGen: Boolean;
  ScanIndex: Integer): Integer;
var
  v: Boolean;
  i, j: Integer;
  l: TStringList;
  neError, neCancel: Boolean;
begin
  Result := -1;
  if Install then j := 3
    else j := 4;
  for i := ScanIndex to ScriptTypes.Count do
    if ScriptComments[i -1] = '' then
      if ScriptTypes[i -1] = 'Apply Changes' then 
        if (ApplyChanges[ApplyChanges.IndexOf(ScriptReferences[i -1]) + j] = 'TRUE') or 
          (ApplyChanges[ApplyChanges.IndexOf(ScriptReferences[i -1]) + j] = '-1') then 
        begin
          Result := i -1;
          Break;
        end;
  ScanIndex := Result; 
  
  if Result <> -1 then
  begin
    neError := false;
    neCancel := false;
    if ScriptTypes.Count < Result +2 +2 then
      Result := -1
    else
    begin
      if (ScriptTypes[Result +1] <> 'If') or (ScriptComments[Result +1] <> '') then Result := -1; 
      if (ScriptTypes[Result +2] <> 'If') or (ScriptComments[Result +2] <> '') then Result := -1; 
      if CompareText(
        xIf[xIf.IndexOf(ScriptReferences[Result +1]) +1],
        'SUCCESS') <> 0 then Result := -1; 
      if CompareText(
        xIf[xIf.IndexOf(ScriptReferences[Result +2]) +1],
        'SUCCESS') <> 0 then Result := -1; 
      if CompareText(
        xIf[xIf.IndexOf(ScriptReferences[Result +1]) +3],
        'ERROR') = 0 then neError := True; 
      if CompareText(
        xIf[xIf.IndexOf(ScriptReferences[Result +2]) +3],
        'CANCEL') = 0 then neCancel := True; 
      if CompareText(
        xIf[xIf.IndexOf(ScriptReferences[Result +1]) +3],
        'ERROR') = 0 then neError := True; 
      if CompareText(
        xIf[xIf.IndexOf(ScriptReferences[Result +2]) +3],
        'CANCEL') = 0 then neCancel := True; 
      if not (neError and neCancel) then Result := -1
        else if Result <> -1 then Result := Result +3;
    end;
    if (Result = -1) and CodeGen then
    begin
      if ScanIndex <> -1 then 
      begin
        
        Result := GetInsertionIndexAfterApplyChanges(Install, CodeGen, ScanIndex +2);
        if Result <> -1 then Exit; 
        
      end;
      i := GetInsertionIndexBeforeApplyChanges(Install);
      v := GetLineVisibilityState(i, false);
      if i <> -1 then
      begin
        i := i +1;
        l := TStringList.Create;
        l.Add('SUCCESS'); 
        l.Add('0');
        l.Add('ERROR'); 
        l.Add('TRUE'); 
        RenderInsertScriptEx('If', xIf, l, i, v); 
        i := i +1;
        l.Clear;
        l.Add('SUCCESS'); 
        l.Add('0');
        l.Add('CANCEL'); 
        l.Add('TRUE'); 
        RenderInsertScriptEx('If', xIf, l, i, v); 
        l.Free;
        RenderInsertScriptEx('End', nil, nil, i +1, v); 
        RenderInsertScriptEx('End', nil, nil, i +2, v); 
        i := i +1;
        Result := i;
        RehashIndents;
      end;
    end;
  end;
end;

function Tui.GetIconIndex(Selected: Boolean; const AFile: string; Attrs: DWORD
  ): Integer;
{$IFDEF WINDOWS}
var
  Cache: TStringList;
  SFI: TSHFileInfo;
  s: String;
  i: Integer;
begin
  if Selected then
  begin
    i := SHGFI_OPENICON;
    Cache := SelectedIconCache;
  end
  else
  begin
    i := 0;
    Cache := IconCache;
  end;
  s := ExtractFileExt(AFile);
  if s = '' then
  begin
    SHGetFileInfo(PChar(AFile), Attrs, SFI, SizeOf(TSHFileInfo),
                  SHGFI_ICON or SHGFI_USEFILEATTRIBUTES or i);
    GetIconIndex := SFI.iIcon;
    DestroyIcon(SFI.hIcon);
    Exit;
  end;
  if Cache.IndexOf(s) = -1 then
  begin
    if SHGetFileInfo(PChar(s), Attrs, SFI, SizeOf(TSHFileInfo),
      SHGFI_ICON or SHGFI_USEFILEATTRIBUTES or i) <> 0 then
    begin
      Cache.Add(s);
      Cache.Add(IntToStr(SFI.iIcon));
      GetIconIndex := SFI.iIcon;
      DestroyIcon(SFI.hIcon);
    end
    else
      GetIconIndex := -1; 
  end
  else
    GetIconIndex := StrToInt(Cache[Cache.IndexOf(s) + 1]);
{$ELSE}
begin
  Result := 0;
{$ENDIF}
end;

function Tui.GetShortcutsForComponent(Feature: String; FeatureFilter: Boolean
  ): TStrings;
var
  i, j: Integer;
  b: Boolean;
  s: String;
  Wide1, Wide2: String;
begin
  Result := TStringList.Create;
  if not FeatureFilter then
  begin
    for i := 1 to Short.Count do
      if (i -1) mod 10 = 0 then
      begin
        Result.Add(Short[(i -1) +2]);
        WidenColonDelimParam(Short[(i -1) +3], Wide1, Wide2);
        Result.Add(Wide1);
        WidenColonDelimParam(Short[(i -1) +1], Wide1, Wide2);
        Result.Add(IntToStr(GetIconIndex(false, Wide1, 0)));
        if ScriptTypes[ScriptReferences.IndexOf(Short[i -1])] = 'Advertised Shortcut' then 
          Result.Add(SAdvertised)
        else
          Result.Add(SRegular);
        WidenColonDelimParam(Short[(i -1) +9], Wide1, Wide2);
        if Pos('X', Wide2) <> 0 then
          Result.Add('Yes')
        else
          Result.Add('No');
        if Pos('7', Wide2) <> 0 then
          Result.Add('Yes')
        else
          Result.Add('No');
        if Pos('8', Wide2) <> 0 then
          Result.Add('Yes')
        else
          Result.Add('No');
        Result.Add(Short[i -1]);
      end;
  end
  else
  begin
    if Feature = '' then b := True 
      else b := false; 
    for i := 1 to ScriptTypes.Count do
    begin
      s := ScriptTypes[i -1];
      if s = 'Get Component State' then 
      begin
        if Feature = '' then Exit 
        else
          b := Feature =
            GetComponent[GetComponent.IndexOf(ScriptReferences[i -1]) +1];
      end
      else
      if b and ((s = 'Create Shortcut') or (s = 'Advertised Shortcut')) then 
      begin
        j := Short.IndexOf(ScriptReferences[i -1]);
        Result.Add(Short[j +2]);
        WidenColonDelimParam(Short[j +3], Wide1, Wide2);
        Result.Add(Wide1);
        WidenColonDelimParam(Short[j +1], Wide1, Wide2);
        Result.Add(IntToStr(GetIconIndex(false, Wide1, 0)));
        if s = 'Advertised Shortcut' then 
          Result.Add(SAdvertised)
        else
          Result.Add(SRegular);
        WidenColonDelimParam(Short[j +9], Wide1, Wide2);
        if Pos('X', Wide2) <> 0 then
          Result.Add('Yes')
        else
          Result.Add('No');
        if Pos('7', Wide2) <> 0 then
          Result.Add('Yes')
        else
          Result.Add('No');
        if Pos('8', Wide2) <> 0 then
          Result.Add('Yes')
        else
          Result.Add('No');
        Result.Add(Short[j]);
      end;
    end;
  end;
end;

procedure Tui.FeatureAwareShortcutPopulate(SingleItem: TListItem);
var
  i: Integer;
  l: TStrings;
  li: TListItem;
begin
  if SingleItem = nil then
  begin
    Shortcuts.Items.BeginUpdate;
    Shortcuts.Items.Clear;
  end;
  l := GetShortcutsForComponent(GetComponentPathFromCombo(ShortcutFeatures),
    ShortcutFilter.Checked);
  for i := 1 to l.Count do
    if (i -1) mod 8 = 0 then
      if SingleItem = nil then
      begin
        li := Shortcuts.Items.Add;
        li.Caption := l[i -1];
        li.SubItems.Add(l[i -1 +1]);
        li.ImageIndex := StrToInt(l[i -1 +2]);
        li.SubItems.Add(l[i -1 +3]);
        li.SubItems.Add(l[i -1 +4]);
        li.SubItems.Add(l[i -1 +5]);
        li.SubItems.Add(l[i -1 +6]);
        li.SubItems.Add(l[i -1 +7]);
      end
      else
      if l[i -1 +7] = SingleItem.SubItems[5] then
      begin
        SingleItem.Caption := l[i -1];
        SingleItem.SubItems[0] := l[i -1 +1];
        SingleItem.ImageIndex := StrToInt(l[i -1 +2]);
        SingleItem.SubItems[1] := l[i -1 +3];
        SingleItem.SubItems[2] := l[i -1 +4];
        SingleItem.SubItems[3] := l[i -1 +5];
        SingleItem.SubItems[4] := l[i -1 +6];
        SingleItem.SubItems[5] := l[i -1 +7];
      end;
  if SingleItem = nil then
    Shortcuts.Items.EndUpdate;
  l.Free;
end;

function Tui.GetOrCreateAndGetFolderLocationVariable(FolderTypeEx: String;
  var InsertIndex: Integer; NewVarName: String): String;
var
  v: Boolean;
  i: Integer;
  l: TStringList;
  FolderType: Integer;
begin
  
  if NewVarName = 'PLATFORMMENU' then 
  begin
    for i := 1 to SetVariable.Count do
      if ((i -1) mod 3) = 0 then
        if StripExpandedSetVar(SetVariable[(i -1) +1]) = 'PLATFORMMENU' then 
        begin
          
          Result := '$' + NewVarName + '$';
          Exit;
        end;
  end;
  
  FolderType := mscrgetfolderlocation.ScrGetFolderLocation.Folder.Items.IndexOf(FolderTypeEx);
  for i := 1 to GetFolderLocation.Count do
    if ((i -1) mod 4) = 0 then
      if StrToInt(GetFolderLocation[(i -1) + 2]) = FolderType then
      begin
        Result := '$' + GetFolderLocation[(i -1) + 1] + '$';
        Exit;
      end;
  l := TStringList.Create;
  l.Add(NewVarName);
  l.Add(IntToStr(FolderType));
  l.Add('FALSE'); 
  v := GetLineVisibilityState(InsertIndex, false);
  RenderInsertScriptEx('Get Folder Location', GetFolderLocation, l, 
    InsertIndex, v);
  InsertIndex := InsertIndex +1;
  Result := '$' + NewVarName + '$';
  RehashIndents;
  
  SetDirtyMia(True, '');
  l.Free;
end;

function Tui.FindFileItemIndex(TargetFile: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 1 to InstallFiles.Count do
    if (i -1) mod 13 = 0 then
      if ExtractFileName(InstallFiles[(i -1) + 1]) = ExtractFileName(TargetFile) then
        if AssertDir(InstallFiles[(i -1) + 3]) = AssertDir(ExtractFilePath(TargetFile)) then
        begin
          Result := GetScriptSmartPosition(InstallFiles[i -1]);
          Exit;
        end;
end;

procedure Tui.SetMediaBlockSkipEx(GUID: String; Skip: Boolean);
var
  Index: Integer;
  Wide1, Wide2: String;
begin
  Index := MediaBlock.IndexOf(GUID);
  WidenColonDelimParam(MediaBlock[Index + 3], Wide1, Wide2, '$MYAH_CARET$'); 
  if Skip then Wide1 := 'TRUE' 
    else Wide1 := 'FALSE'; 
  MediaBlock[Index + 3] := Wide1 + '$MYAH_CARET$' + Wide2; 
  Index := ScriptReferences.IndexOf(GUID);
  RenderLine(Index, True);
  try
    Script.Selected[GetFoldedLineNumber(Index)] := True;
  except
  end;
  
  SetDirtyMIA(True, '');
  SetHorizontalScrollBar(Script);
  Exit;
end;

function Tui.IsValidGuid(GUID: String): Boolean;
var
  g: TGuid;
begin
  Result := false;
  try
    g := StringToGUID(GUID);
    if Length(GUID) = Length(CreateGUIDUp) then 
      Result := True;
  except
    Result := false;
  end;
end;

function Tui.SaveProjectAsTemplate(ProjectFile, OldDir, NewDir: String
  ): Boolean;
var
  s, sX: String;
  i, j: Integer;
  t, tX: TextFile;
  BOM: Char;
begin
  Result := True;
  if not ForceDirectories(NewDir) then
  begin
    Application.MessageBox(PChar('Unable to create folder for new user template:' + MyLineEnding + MyLineEnding +
      NewDir),
      PChar(Application.Title), mb_OK + mb_IconStop);
    Result := false;
    Exit;
  end;
  
  PushStatusStack('Saving project template ' + ProjectFile);
  AssignFile(t, NewDir + ExtractFileName(DeAssertDir(NewDir)) + '.mprx',cp_utf8);
  ReWrite(t);
  FileCopyFile(PChar(AbsolutizePath(ScriptFile, OldDir)), PChar(NewDir + ExtractFileName(ScriptFile)), false);
  FileCopyFile(PChar(AbsolutizePath(ScriptFile, OldDir) + '.brkx'), PChar(NewDir + ExtractFileName(ScriptFile) + '.brkx'), false);
  FileCopyFile(PChar(AbsolutizePath(ScriptFile, OldDir) + '.fldx'), PChar(NewDir + ExtractFileName(ScriptFile) + '.fldx'), false);
  FileCopyFile(PChar(AbsolutizePath(ScriptFile, OldDir) + '.bokx'), PChar(NewDir + ExtractFileName(ScriptFile) + '.bokx'), false);
  WriteLn(t, ExtractFileName(ScriptFile));
  for i := 1 to DialogFiles.Count do
  begin
    WriteLn(t, DialogFiles[i -1]);
    FileCopyFile(PChar(OldDir + DialogFiles[i -1]), PChar(NewDir + DialogFiles[i -1]),
      false);
  end;
  WriteLn(t, '$');
  for i := 1 to SupportFiles.Count do
  begin
    WriteLn(t, SupportFiles[i -1]);
    FileCopyFile(PChar(OldDir + SupportFiles[i -1]), PChar(NewDir + SupportFiles[i -1]),
      false);
  end;
  WriteLn(t, '$');
  for i := 1 to Breakpoints.Count do
    WriteLn(t, Breakpoints[i -1]);
  WriteLn(t, '$');
  for i := 1 to VarWatches.Count do
    WriteLn(t, VarWatches[i -1]);
  WriteLn(t, '$');
  
  WriteLn(t, ProjectStruct.BuildLayout);
  WriteLn(t, ProjectStruct.CompressProfile);
  WriteLn(t, True);
  WriteLn(t, '');
  WriteLn(t, ProjectStruct.Manufacturer);
  WriteLn(t, '$$$');
  WriteLn(t, CreateGUIDUp);
  WriteLn(t, CreateGUIDUp);
  WriteLn(t, ProjectStruct.Version);
  WriteLn(t, ProjectStruct.Language);
  WriteLn(t, '$$$');
  WriteLn(t, '$$$ Installation');
  WriteLn(t, ProjectStruct.Author);
  WriteLn(t, ProjectStruct.Comments);
  WriteLn(t, CreateGUIDUp);
  WriteLn(t, ProjectStruct.arPublisher);
  WriteLn(t, ProjectStruct.arContact);
  WriteLn(t, ProjectStruct.arHelp);
  WriteLn(t, ProjectStruct.arUpdates);
  WriteLn(t, ProjectStruct.arComments);
  WriteLn(t, false);
  WriteLn(t, '');
  WriteLn(t, ProjectStruct.AutoIncrement);
  WriteLn(t, ProjectStruct.aSign);
  WriteLn(t, ProjectStruct.aCertificate);
  WriteLn(t, ProjectStruct.aKey);
  WriteLn(t, ProjectStruct.aTimeStamp);
  WriteLn(t, ProjectStruct.aInfo);
  
    WriteLn(t, ProjectStruct.Conditionals);
  
  WriteLn(t, ProjectStruct.pDisplay);
  WriteLn(t, ProjectStruct.pDescription);
  WriteLn(t, ProjectStruct.pClass);
  WriteLn(t, ProjectStruct.pWhole);
  WriteLn(t, ProjectStruct.pMissing);
  WriteLn(t, ProjectStruct.pLarge);
  WriteLn(t, ProjectStruct.pRemove);
  WriteLn(t, ProjectStruct.pCreate);
  WriteLn(t, false);
  WriteLn(t, ProjectStruct.MultiLang);
  WriteLn(t, false);
  WriteLn(t, '');
  for i := 1 to IncludeFiles.Count do
  begin
    WriteLn(t, ExtractFileName(IncludeFiles[i -1]));
    FileCopyFile(PChar(AbsolutizePath(IncludeFiles[i -1], OldDir)), PChar(NewDir + ExtractFileName(IncludeFiles[i -1])),
      false);
    FileCopyFile(PChar(AbsolutizePath(IncludeFiles[i -1], OldDir) + '.brkx'), PChar(NewDir + ExtractFileName(IncludeFiles[i -1]) + '.brkx'),
      false);
    FileCopyFile(PChar(AbsolutizePath(IncludeFiles[i -1], OldDir) + '.fldx'), PChar(NewDir + ExtractFileName(IncludeFiles[i -1]) + '.fldx'),
      false);
    FileCopyFile(PChar(AbsolutizePath(IncludeFiles[i -1], OldDir) + '.bokx'), PChar(NewDir + ExtractFileName(IncludeFiles[i -1]) + '.bokx'),
      false);
  end;
  WriteLn(t, '$');
  WriteLn(t, ProjectStruct.AutoHash);
  WriteLn(t, '');
  WriteLn(t, ProjectStruct.cFiles);
  WriteLn(t, ProjectStruct.cRegistry);
  WriteLn(t, ProjectStruct.cFeatures);
  WriteLn(t, ProjectStruct.cHashes);
  CloseFile(t);
  PopStatusStack;
end;

function Tui.GetInsertionIndexBeforeApplyChanges(Install: Boolean): Integer;
var
  i, j: Integer;
begin
  Result := -1;
  if Install then j := 3
    else j := 4;
  for i := 1 to ScriptTypes.Count do
    if ScriptComments[i -1] = '' then
      if ScriptTypes[i -1] = 'Apply Changes' then 
        if ((ApplyChanges[ApplyChanges.IndexOf(ScriptReferences[i -1]) + j] = 'TRUE') or
          (ApplyChanges[ApplyChanges.IndexOf(ScriptReferences[i -1]) + j] = '-1')) and 
          (ApplyChanges[ApplyChanges.IndexOf(ScriptReferences[i -1]) + 2] <> 'NATIVE_UNINSTALL') then 
        begin
          Result := i -1;
          Exit;
        end;
end;

function Tui.FindCreateOrMapFolderIndex(Folder: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  Folder := AssertDir(Folder);
  
  for i := 1 to CreateFolder.Count do
    if ((i -1) mod 2) = 0 then
      if AssertDir(CreateFolder[(i -1) + 1]) = Folder then
      begin
        Result := GetScriptSmartPosition(CreateFolder[i -1]);
        Exit;
      end;
  if Result <> -1 then Exit;
  
  Folder := StringReplace(Folder, '$', '', [rfReplaceAll, rfIgnoreCase]);
  for i := 1 to GetFolderLocation.Count do
    if ((i -1) mod 4) = 0 then
      if AssertDir(GetFolderLocation[(i -1) + 1]) = Folder then
      begin
        Result := GetScriptSmartPosition(GetFolderLocation[i -1]);
        Exit;
      end;
end;

function Tui.GetCreateAndDefineFoldersForComponent(Feature, Folder: String;
  FeatureFilter: Boolean; ReturnFirstOnly: Boolean): TStrings;
var
  i, j: Integer;
  b: Boolean;
  s: String;
begin
  Result := TStringList.Create;
  Folder := AssertDir(Folder);
  if not FeatureFilter then
  begin
    if CompareText('$TARGETDIR$/', Folder) = 0 then
    begin
      Result.Add('$TARGETDIR$'); 
      if ReturnFirstOnly then Exit;
      
    end;
    if CompareText('$TARGETDIR_X86$/', Folder) = 0 then
    begin
      if GetSetVariableValue('TARGETDIR_X86') <> '' then
        Result.Add('$TARGETDIR_X86$'); 
      if ReturnFirstOnly then Exit;
    end;
    for i := 1 to GetFolderLocation.Count do
      if (i -1) mod 4 = 0 then
        if CompareText('$' + GetFolderLocation[(i -1) + 1] + '$/', Folder) = 0 then
        begin
          Result.Add('$' + GetFolderLocation[(i -1) + 1] + '$');
          if ReturnFirstOnly then Exit;
        end;
    for i := 1 to CreateFolder.Count do
      if (i -1) mod 2 = 0 then
        if CompareText(AssertDir(CreateFolder[(i -1) +1]), Folder) = 0 then
        begin
          Result.Add(CreateFolder[(i -1) +1]);
          if ReturnFirstOnly then Exit;
        end;
  end
  else
  begin
    if Feature = '' then b := True 
      else b := false; 
    for i := 1 to ScriptTypes.Count do
    begin
      s := ScriptTypes[i -1];
      if s = 'Get Component State' then 
      begin
        if Feature = '' then Exit 
        else
          b := Feature =
            GetComponent[GetComponent.IndexOf(ScriptReferences[i -1]) +1];
      end
      else
      if b and (s = 'Create Folder') then 
      begin
        j := CreateFolder.IndexOf(ScriptReferences[i -1]);
        if CompareText(Folder, AssertDir(CreateFolder[j +1])) = 0 then
        begin
          Result.Add(CreateFolder[j +1]);
          if ReturnFirstOnly then Exit;
        end;
      end
      else
      if b and (s = 'Get Folder Location') then 
      begin
        j := GetFolderLocation.IndexOf(ScriptReferences[i -1]);
        if CompareText(Folder, AssertDir('$' + GetFolderLocation[j +1] + '$/')) = 0 then
        begin
          Result.Add('$' + GetFolderLocation[j +1] + '$/');
          if ReturnFirstOnly then Exit;
        end;
      end;
    end;
  end;
end;

function Tui.IsSafeToDeleteFileViewFolderNode(Node: TTreeNode;
  CheckForRootNodeOnly: Boolean): Boolean;
var
  l: TStrings;
begin
  Result := false;
  if Node.Parent <> nil then 
  begin
    if CheckForRootNodeOnly then
    begin
      Result := True;
      Exit;
    end;
    if Node.Count = 0 then 
    begin
      l := GetCreateAndDefineFoldersForComponent('',
        GetFolderPathFromTree(Folders.Selected), false, True); 
      if l.Count = 0 then
      begin
        l.Free;
        l := GetFilesAndSourcesForComponentInFolder('',
          GetFolderPathFromTree(Folders.Selected), false, True); 
        if l.Count = 0 then
          Result := True;
        l.Free;
      end
      else
        l.Free;
    end;
  end;
end;

procedure Tui.UpdateMultipleValues(List, GUIDs: TStringList; Index,
  Offset: Integer; Value: String);
var
  i: Integer;
  s: String;
begin
  for i := 1 to List.Count do
    if i mod Index = 1 then
      if GUIDs.IndexOf(List[i -1]) <> -1 then
      begin
        s := List[i -1 + Offset +1];
        if AnsiPos('|', s) <> 0 then
        begin
          Delete(s, 1, AnsiPos('|', s));
          s := '|' + s;
        end
        else
          s := '';
        List[i -1 + Offset +1] := Value + s;
        RenderLine(GetScriptSmartPosition(List[i -1]), True);
      end;
  SetDirtyMia(True, '');
  SetHorizontalScrollBar(Script);
end;

procedure Tui.HashForCheckBox(CheckBox: TCheckBox; List, GUIDs: TStringList;
  Index, Offset: Integer);
var
  s: String;
begin
  if HashMultipleCommandFields(List, GUIDs, Index, Offset, s) then
    CheckBox.Checked := StrToBool(DeAssertDir(s))
  else
  begin
    CheckBox.State := cbGrayed;
    CheckBox.AllowGrayed := True;
  end;
end;

function Tui.HashMultipleCommandFields(List, GUIDs: TStringList; Index,
  Offset: Integer; var HashedValue: String): Boolean;
var
  s: String;
  b: Boolean;
  i: Integer;
begin
  Result := True;
  b := false;
  for i := 1 to List.Count do
    if i mod Index = 1 then
      if GUIDs.IndexOf(List[i -1]) <> -1 then
      begin
        if not b then
        begin
          b := True;
          s := List[i -1 + Offset +1];
          if AnsiPos('|', s) <> 0 then
            Delete(s, AnsiPos('|', s), Length(s));
          HashedValue := AssertDir(s);
        end
        else
        begin
          s := List[i -1 + Offset +1];
          if AnsiPos('|', s) <> 0 then
            Delete(s, AnsiPos('|', s), Length(s));
          if CompareText(HashedValue, AssertDir(s)) <> 0 then
          begin
            Result := false;
            Exit;
          end;
        end;
      end;
end;

function Tui.GetNewFilesInsertionIndex(Feature: String): Integer;
var
  i: Integer;
  l: TStringList;
  v: Boolean;
begin
  Result := -1;
  
  for i := 1 to ScriptTypes.Count do
    if ScriptTypes[i -1] = 'Get Component State' then 
    begin
      if Feature = '' then
      begin
        Result := i -1;
        if ScriptTypes[i -2] = 'Web Media Block' then 
          Result := Result -1;
        Exit;
      end
      else
      if Feature = GetComponent[GetComponent.IndexOf(ScriptReferences[i -1]) +1] then
        if ScriptTypes.Count -1 >= i then
          if ScriptTypes[i] = 'If' then 
            if xIf[xIf.IndexOf(ScriptReferences[i]) +1] = 'SELECTED' then 
              if ScriptTypes.Count -1 >= i +1 then
              begin
                Result := i +1;
                Exit;
              end;
    end;
  
  if Result = -1 then
  begin
    
    for i := 1 to ScriptTypes.Count do
      if ScriptTypes[i -1] = 'Apply Changes' then 
        if (ApplyChanges[ApplyChanges.IndexOf(ScriptReferences[i -1]) + 3] = 'TRUE') or 
          (ApplyChanges[ApplyChanges.IndexOf(ScriptReferences[i -1]) + 3] = '-1') then 
        begin
          Result := i -1;
          if Feature = '' then Exit
            else Break;
        end;
    
    if Result = -1 then Exit;
    
    l := TStringList.Create;
    l.Add(Feature);
    l.Add('SELECTED'); 
    v := GetLineVisibilityState(Result, false);
    RenderInsertScriptEx('Get Component State', GetComponent, l, 
      Result, v);
    Result := Result +1;
    l.Clear;
    l.Add('SELECTED'); 
    l.Add('0');
    l.Add('TRUE'); 
    l.Add('FALSE'); 
    RenderInsertScriptEx('If', xIf, l, Result, v); 
    Result := Result +1;
    l.Free;
    RenderInsertScriptEx('End', nil, nil, Result, v); 
    RehashIndents;
  end;
end;

function Tui.AddNewFiles(NewFiles: TStrings): Boolean;
var
  Folder: String;
  InsertIndex: Integer;
  l: TStringList;
  s, sX: String;
  i: Integer;
  v: Boolean;
begin
  sX := GetComponentPathFromCombo(FilesFeatures);
  Result := false; 
  InsertIndex := GetNewFilesInsertionIndex(sX);
  if InsertIndex = -1 then
  begin
    Application.MessageBox(PChar(SApplyInstallCommandNotFoundInSet
      + MyLineEnding + SThisCommandMustBePresentInYourSc
      + MyLineEnding + MyLineEnding + SToAvoidSeeingThisMessageCreateNe),
      PChar(Application.Title), mb_Ok + mb_IconStop);
    Exit;
  end;
  
  Files.Items.BeginUpdate;
  Folder := GetFolderPathFromTree(Folders.Selected);
  if Folder = '' then
  begin
    Folder := '$TARGETDIR$'; 
    Result := True;
  end;
  l := TStringList.Create;
  v := GetLineVisibilityState(InsertIndex, false);
  for i := 1 to NewFiles.Count do
  begin
    l.Clear;
    l.Add(NewFiles[i -1]);
    l.Add('FALSE|'); 
    l.Add(Folder);
    l.Add('FALSE'); 
    l.Add('FALSE'); 
    l.Add('FALSE'); 
    l.Add('FALSE'); 
    l.Add('FALSE'); 
    l.Add('FALSE'); 
    l.Add('FALSE'); 
    l.Add('FALSE'); 
    l.Add('FALSE'); 
    s := RenderInsertScriptEx('Install Files', InstallFiles, l, InsertIndex, v); 
    InsertIndex := InsertIndex +1;
    AddFileToFileList(Files, ExtractFilePath(NewFiles[i -1]), ExtractFileName(NewFiles[i -1]),
      s);
  end;
  Files.Items.EndUpdate;
  RehashIndents;
  l.Free;
end;

function Tui.AddNewFolder(NewFolder: String): Boolean;
var
  Folder: String;
  InsertIndex: Integer;
  l: TStringList;
  i: Integer;
  n: TTreeNode;
  v: Boolean;
begin
  Result := false;
  InsertIndex := GetNewFilesInsertionIndex(GetComponentPathFromCombo(FilesFeatures));
  if InsertIndex = -1 then
  begin
    Application.MessageBox(PChar(SApplyInstallCommandNotFoundInSet
      + MyLineEnding + SThisCommandMustBePresentInYourSc
      + MyLineEnding + MyLineEnding + SToAvoidSeeingThisMessageCreateNe),
      PChar(Application.Title), mb_Ok + mb_IconStop);
    Exit;
  end;
  
  Folder := GetFolderPathFromTree(Folders.Selected);
  if Folder = '' then
  begin
    Folder := '$TARGETDIR$'; 
    Result := True;
  end;
  if Folder <> '' then Folder := AssertDir(Folder);
  l := TStringList.Create;
  l.Clear;
  l.Add(AssertDir(NewFolder) + '*');
  l.Add('TRUE|'); 
  if ExtractFileName(DeAssertDir(NewFolder)) = '' then 
    l.Add(Folder + NewFolder[1])
  else
    l.Add(Folder + ExtractFileName(DeAssertDir(NewFolder)));
  l.Add('FALSE'); 
  l.Add('FALSE'); 
  l.Add('FALSE'); 
  l.Add('FALSE'); 
  l.Add('FALSE'); 
  l.Add('FALSE'); 
  l.Add('FALSE'); 
  l.Add('FALSE'); 
  l.Add('FALSE'); 
  v := GetLineVisibilityState(InsertIndex, false);
  RenderInsertScriptEx('Install Files', InstallFiles, l, InsertIndex, v); 
  RehashIndents;
  InsertIndex := InsertIndex +1;
  l.Free;
  n := nil;
  for i := 1 to Folders.Selected.Count do
    if AnsiLowerCase(Folders.Selected.Items[i -1].Text) = AnsiLowerCase(ExtractFileName(DeAssertDir(NewFolder))) then
    begin
      n := Folders.Selected.Items[i -1];
      Break;
    end;
  if n = nil then
  begin
    if ExtractFileName(DeAssertDir(NewFolder)) = '' then 
      n := Folders.Items.AddChild(Folders.Selected, NewFolder[1])
    else
      n := Folders.Items.AddChild(Folders.Selected, ExtractFileName(DeAssertDir(NewFolder)));
    n.ImageIndex := 1;
    n.SelectedIndex := 0;
  end;
  Folders.Selected := n;
  if ExtractFileName(DeAssertDir(NewFolder)) = '' then
  begin
    TreeExChange(Self, TreeEx.Selected);
    Result := false;
  end;
end;

function Tui.AssertURL(URL: String): String;
begin
  Result := '';
  if URL = '' then Exit;
  if URL[Length(URL)] = '/' then
    Result := URL
  else
    URL := URL + '/';
end;

procedure Tui.SetDefaultComponentSelectionState(Component: String;
  Selected: Boolean);
var
  s: String;
begin
  
  SetDirtyMia(True, '');
  if Selected then s := 'TRUE' 
    else s := 'FALSE'; 
  SetStringAtListIndexOffset(DefComponent,
    FindIndexOfStringAtOffset(DefComponent, 1, 4, Component),
    2, s);
end;

function Tui.AnyMatchingFileInPath(Path: String; Recursive: Boolean): Boolean;
var
  
  sr: TSearchRec;
  s, sX, sY: String;
  b: Boolean;
  i: Integer;
begin
  Result := false;
  
  i := FindFirstUTF8(Path, faSymLink or faAnyFile or faDirectory, sr);
  
  if i <> 0 then Exit;
  b := True;
  while b do
  begin
    s := sr.Name; 
    
    if (s <> '.') and (s <> '..') then
    begin
      
      if ((sr.Attr and faDirectory) = faDirectory) and Recursive then
      begin
        s := IncludeTrailingPathDelimiter(ExtractFilePath(Path)) + sr.Name;
        Result := AnyMatchingFileInPath(AssertDir(ExtractFilePath(Path)) + s + PathDelim + ExtractFileName(Path), Recursive);
        if Result then 
        begin
          FindCloseUTF8(sr);
          Exit;
        end;
      end
      else
      
      begin
        Result := True;
        FindCloseUTF8(sr);
        Exit;
      end;
    end;
    
    i := FindNextUTF8(sr);
    b := i = 0;
  end;
  FindCloseUTF8(sr);
end;

function Tui.CheckIsBadPathFunction(Kind, Guid: String): Boolean;
var
  s, sX, sY: String;
  i: Integer;
  b, bX, bY, bZ: Boolean;
function CommonPreamble(Path: String): String;
begin
  Result := GetExpandedEnvVars(Path);
  if ExtractFileDrive(Result) = '' then
    Result := AssertDir(PROJDIR) + Result;
  Result := ExpandFileName(Result);
end;
begin
  Result := false;
  bX := false;
  bY := false;
  bZ := false;
  
  if Kind = 'Install Files' then 
  begin
    i := InstallFiles.IndexOf(Guid);
    if i = -1 then Exit; 
    s := InstallFiles[i +1];
    WidenColonDelimParam(InstallFiles[i +2], sX, sY);
    b := StrToBool(sX);
    bX := True;
  end
  ;
  if bX then
  begin
    s := ElimDoubles(CommonPreamble(SubstituteCompilerVariables(s, false)));
    if not DirectoryExists(s) then 
    begin
      if not AnyMatchingFileInPath(s, b) then
        Result := True;
    end
    else
      Result := True;
  end
  else
  if bY then
  begin
    s := ElimDoubles(CommonPreamble(SubstituteCompilerVariables(s, false)));
    if not MyFileExists(s) then
      Result := True;
  end
  else
  if bZ then
  begin
    s := ElimDoubles(CommonPreamble(SubstituteCompilerVariables(s, false)));
    sX := ElimDoubles(CommonPreamble(SubstituteCompilerVariables(sX, false)));
    if (not MyFileExists(s)) or ((sX <> '') and (not MyFileExists(sX))) then
      Result := True;
  end;
end;

function Tui.GetSetVariableValue(Variable: String): String;
var
  i, j: Integer;
begin
  Result := '';
  j := ScriptBuffer.Count;
  for i := 1 to SetVariable.Count do
    if (i -1) mod 3 = 0 then
      if AnsiUpperCase(Variable) = AnsiUpperCase(StripExpandedSetVar(SetVariable[(i -1) +1])) then
        if GetScriptSmartPosition(SetVariable[(i -1)]) < j then
        begin
          Result := SetVariable[(i -1) +2];
          j := GetScriptSmartPosition(SetVariable[(i -1)]);
        end;
end;

function Tui.GetStringAtListIndexOffset(List: TStrings; Index, Offset: Integer
  ): String;
begin
  Result := '';
  if Index + Offset > List.Count -1 then
    raise Exception.Create(SAttemptingToReadPastAvailableStr);
  Result := List[Index + Offset];
end;

procedure Tui.SetStringAtListIndexOffset(List: TStrings; Index,
  Offset: Integer; Value: String);
begin
  if Index + Offset > List.Count -1 then
    raise Exception.Create(SAttemptingToWritePastAvailableSt);
  List[Index + Offset] := Value;
end;

function Tui.GetScriptSmartPosition(GUID: String): Integer;
begin
  Result := ScriptReferences.IndexOf(GUID);
end;

function Tui.FindIndexOfStringAtOffset(List: TStrings; ItemOffset,
  TotalOffset: Integer; Value: String; CaseSensitive: Boolean): Integer;
var
  i: Integer;
begin
  Result := -1;
  if List.Count mod TotalOffset <> 0 then
    raise Exception.Create(SListDoesNotContainCompleteValues);
  for i := 1 to List.Count do
    if (i -1) mod TotalOffset = 0 then
    begin
      if List[i -1 + ItemOffset] = Value then
      begin
        Result := i -1;
        Exit;
      end;
    end;
  if (Result = -1) and (not CaseSensitive) then
  begin
    
    for i := 1 to List.Count do
      if (i -1) mod TotalOffset = 0 then
      begin
        if CompareText(List[i -1 + ItemOffset], Value) = 0 then
        begin
          Result := i -1;
          Exit;
        end;
      end;
    if Result = -1 then
      raise Exception.Create(SAttemptingToFindStringInStringLi);
  end;
end;

function Tui.GetSmartPositionInClass(ItemClass: String; Last: Boolean): Integer;
var
  i: Integer;
begin
  if Last then
  begin
    Result := ScriptTypes.Count;
    for i := ScriptTypes.Count downto 1 do
      if ScriptTypes[i -1] = ItemClass then
      begin
        Result := i -1;
        Exit;
      end;
  end
  else
  begin
    Result := 0;
    for i := 1 to ScriptTypes.Count do
      if ScriptTypes[i -1] = ItemClass then
      begin
        Result := i -1;
        Exit;
      end;
  end;
end;

function Tui.GetSetComponentStateSmartPosition(Selected, Last: Boolean
  ): Integer;
var
  i: Integer;
begin
  Result := -1;
  if Last then
  begin
    Result := ScriptTypes.Count;
    for i := ScriptTypes.Count downto 1 do
      if ScriptTypes[i -1] = 'Set Component State' then 
        if StrToBool(SetComponent[SetComponent.IndexOf(ScriptReferences[i -1]) +2]) = Selected then
        begin
          Result := i -1;
          Exit;
        end;
  end
  else
  begin
    Result := 0;
    for i := 1 to ScriptTypes.Count do
      if ScriptTypes[i -1] = 'Set Component State' then 
        if StrToBool(SetComponent[SetComponent.IndexOf(ScriptReferences[i -1]) +2]) = Selected then
        begin
          Result := i -1;
          Exit;
        end;
  end;
end;

function Tui.GetComponentPathFromTree(Node: TTreeNode): String;
begin
  Result := '';
  if Node = nil then Exit;
  Result := Node.Text;
  while Node.Parent <> nil do
  begin
    Node := Node.Parent;
    Result := Node.Text + '\' + Result;
  end;
  Delete(Result, 1, Length('All Features\')); 
end;

procedure Tui.SwapNamedFeaturesInScript(First, Second: String);
var
  i, i1, i2: Integer;
  g1, g2: String;
begin
  i1 := -1;
  i2 := -1;
  for i := 1 to ScriptTypes.Count do
    if ScriptTypes[i -1] = 'Define Component' then 
    begin
      if CompareText(First, DefComponent[DefComponent.IndexOf(ScriptReferences[i -1]) +1]) = 0 then
        i1 := i -1;
      if AnsiPos(Second, DefComponent[DefComponent.IndexOf(ScriptReferences[i -1]) +1]) = 1 then
      begin
        if i2 <> -1 then
        begin
          if i2 > i -1 then
            i2 := i -1;
        end
        else
          i2 := i -1;
      end;
    end;
  if (i1 = -1) or (i2 = -1) then Exit;
  g1 := ScriptReferences[i1];
  g2 := ScriptReferences[i2];
  ScriptReferences[i1] := g2;
  ScriptReferences[i2] := g1;
  RenderLine(i1, True);
  RenderLine(i2, True);
end;

function Tui.ImportPKG(PKG: String): String;
var
  e, s: String;
  l, lX: TStringList;
begin
  
  Result := '';
  SetArchivePathEx; 
  
  try
    GetSpecialFolder($5, s);
    s := AssertDir(s) + ExtractFileNameOnly(PKG) + ' Import';
    WipeFolder(s + '.tmp', True);
    try
      PushStatusStack('Extracting ' + PKG);
      PKG := PKG + PathDelim + 'Contents' + PathDelim + 'Packages' + PathDelim +
        ExtractFileNameOnly(PKG) + '.pkg';
      ExtractArchiveContents(PKG, '', s + '.tmp', True, True, e, nil, nil, nil, nil, nil);
    finally
      PopStatusStack;
    end;
    l := FindAllFilesEx(s + '.tmp' + PathDelim + '*', True);
    if l.Count > 0 then
    try
      PushStatusStack('Extracting ' + l[0]);
      WipeFolder(s, True);
      ExtractArchiveContents(l[0], '', s, True, True, e, nil, nil, nil, nil, nil);
      WipeFolder(s + '.tmp', True);
      Result := s;
      
    finally
      PopStatusStack;
    end;
    l.Free;
  except
    
  end;
  SetArchivePath;
end;

function Tui.ImportPKGEx(PKG: String): Boolean;
var
  s: String;
  l: TStringList;
begin
  
  Result := false;
  try
    s := EXEDIR + '.tmppkg';
    WipeFolder(EXEDIR + '.tmppkg', True);
    try
      PushStatusStack('Extracting ' + PKG);
      l := TStringList.Create;
      l.Add('--expand-full');
      l.Add(PKG);
      l.Add(EXEDIR + '.tmppkg');
      if LaunchAppAndWait2('pkgutil', l, True, True) <> 0 then
        Application.MessageBox(PChar('pkgutil ' + l[0] + ' '
          + l[1] + ' ' + l[2] + ' failed' + #10#10 +
          'macOS is required for this feature.'),
          'PKG Import Failed', mb_Ok or mb_IconStop);
    finally
      PopStatusStack;
    end;
    l.Free;
    Result := True;
  except
    
  end;
end;

procedure Tui.ScrubNewLfm(FileName: String);
var
  s: String;
  t, tX: TextFile;
begin
  if not MyFileExists(FileName) then Exit;
  AssignFile(t, FileName);
  Reset(t);
  AssignFile(tX, FileName + '.miat');
  ReWrite(tX);
  while not EOF(t) do
  begin
    ReadLn(t, s);
    if AnsiPos('  ClientHeight = ', s) = 1 then
      WriteLn(tX, StringReplace(s, 'ClientHeight', 'Height', [rfReplaceAll, rfIgnoreCase]));
    if AnsiPos('  ClientWidth = ', s) = 1 then
      WriteLn(tX, StringReplace(s, 'ClientWidth', 'Width', [rfReplaceAll, rfIgnoreCase]));
    s := StringReplace(s, 'TRzCheckBox', 'TCheckBox', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TRzRadioButton', 'TRadioButton', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TRzBmpButton', 'TButton', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TGauge', 'TProgressBar', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TRzFormShape', 'TShape', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TPageControl', 'TPanel', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TRichEdit', 'TMemo', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TAnimate', 'TPanel', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'THTMLViewer', 'TPanel', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TFlashFrame', 'TPanel', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TFileListBox', 'TListBox', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TDirectoryListBox', 'TListBox', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TDriveComboBox', 'TComboBox', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TPTShellTree', 'TShellTreeView', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TPTShellList', 'TCheckListBox', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TPTShellCombo', 'TComboBox', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TDriveComboBox', 'TPanel', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TVistaGlass', 'TPanel', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TGlowLabel', 'TStaticText', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TAeroButton', 'TButton', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TAeroBackButton', 'TButton', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TAeroPNGButton', 'TButton', [rfReplaceAll, rfIgnoreCase]);
    s := StringReplace(s, 'TAeroPNGImage', 'TImage', [rfReplaceAll, rfIgnoreCase]);
    WriteLn(tX, s);
  end;
  CloseFile(t);
  CloseFile(tX);
  DeleteFile(PChar(FileName));
  RenameFile(FileName + '.miat', FileName);
end;

procedure Tui.CreateBlankProject(Import: Boolean);
var
  s: String;
  l: TStringList;
begin
  
  ClearProjectStructs;
  
  if not Import then
    AdjustUIProjectChanged;
  RenderScript;
  l := TStringList.Create;
  l.Add('');
  
  RenderInsertScriptEx('Comment', Comments, l, 0, True); 
  l.Free;
  ui.SetDirtyAll(false);
  RehashIndents;
  
  s := '';
  StrCopy(ProjectStruct.Name, PChar(s));
  
  PROJDIR := '';
  ScriptFile := ''; 
  LastActiveContext := ScriptFile;
  CurrentProjectName := ''; 
  if not Import then
    AdjustUIProjectChanged;
end;

function Tui.CurrentUnitChangeEx(Import: Boolean): String;
var
  BackupMainScriptName, CurrentContext, ActivateContext: String;
  TestForFile: String;
  hWait, hDef: TCursor;
  i: Integer;
  
  NewTab: Integer;
  AllowChange: Boolean;
begin
  Result := '';
  try
    AllowChange := True;
    NewTab := CurrentUnit.TabIndex;
    if NewTab = -1 then
    begin
      AllowChange := false;
      Exit;
    end;
    
    if AlreadyInUnitChange then Exit;
    if NewTab <> 0 then
      if CurrentUnit.Tabs[NewTab] <> SUntitled_1 then
      begin
        if NewTab = 1 then
          TestForFile := ScriptFile
        else
          TestForFile := IncludeFiles[NewTab -2];
        if ExtractFilePath(TestForFile) = '' then
          TestForFile := AssertDir(ExtractFilePath(CurrentProjectName)) + TestForFile;
        if not MyFileExists(TestForFile) then
        begin
          if Import then
            Result := TestForFile
          else
            Application.MessageBox(PChar(SScriptFileNotFoundOnDisk + TestForFile),
              PChar(Application.Title), mb_Ok + mb_IconStop);
          AllowChange := false;
          Exit;
        end;
      end;
    AlreadyInUnitChange := True;
    hDef := Screen.Cursor;
    Screen.Cursor := crHourGlass;
    try
      ActiveTab := NewTab;
      if NewTab = 0 then
      begin
        
        Actions.Enabled := false;
        ActionsEx.Enabled := false;
        
        ScriptBook.PageIndex := 0;
        
      end
      else
      begin
        Actions.Enabled := not Running;
        ActionsEx.Enabled := not Running;
        
        FormResize(nil); 
        ScriptBook.PageIndex := 1;
        
        try
          if not Script.Focused then Script.SetFocus;
        except
          
        end;
        
        if (OldTab = 0) or (OldTab = -1) then 
        begin
          if LastActiveContext = '' then
            LastActiveContext := ScriptFile;
          CurrentContext := LastActiveContext;
        end
        else
          if OldTab = 1 then
            CurrentContext := ScriptFile
          else
          begin
            if IncludeFiles.Count -1 >= OldTab -2 then
              CurrentContext := IncludeFiles[OldTab -2]
            else
              CurrentContext := '\VOID/'; 
          end;
        if NewTab = 1 then
          ActivateContext := ScriptFile
        else
          
          ActivateContext := IncludeFiles[NewTab -2];
        if CurrentContext = ActivateContext then Exit;
        if CurrentContext <> '\VOID/' then
          SaveContext(CurrentContext);
        if IsContextLoaded(ActivateContext) then
          SwitchContext(ActivateContext)
        else
        begin
          BackupMainScriptName := ScriptFile;
          ClearProjectStructs(True);
          if not LoadScriptEx(ActivateContext,
            
            AnsiCompareText(ExtractFileExt(ActivateContext), '.mia') = 0) then
          begin
            AllowChange := false;
            ActiveTab := OldTab;
            if OldTab = 0 then
              ScriptBook.PageIndex := 0;
            Exit;
          end;
          
          ScriptFile := BackupMainScriptName;
        end;
        LastActiveContext := ActivateContext;
        
      end;
    finally
      if ActiveTab = 0 then
        EditAction1.ShortCut := ShortCut(0, [])
      else
        if not Running then
          if not (Notebook.ActivePage = 'Visual') then 
            EditAction1.ShortCut := ShortCut(13, []);
      CollapseAllRegions1.Enabled := ((Notebook.ActivePage <> 'Visual') and 
        (ActiveTab <> 0)) and not Running;
      ExpandAllRegions1.Enabled := CollapseAllRegions1.Enabled;
      MenuItem38.Enabled := ExpandAllRegions1.Enabled;
      MenuItem37.Enabled := MenuItem38.Enabled;
      Screen.Cursor := hDef;
      AlreadyInUnitChange := false;
    end;
  finally
    if AllowChange then
      OldTab := NewTab
    else
      if OldTab <> -1 then
        CurrentUnit.TabIndex := OldTab;
  end;
end;

function Tui.PeekStackItem(Stack: TList; var Kind, Elements: String;
  IgnoreContext: Boolean): Boolean;
var
  i: Integer;
  l: TStringList;
begin
  Result := false;
  if Stack.Count = 0 then Exit;
  for i := Stack.Count downto 1 do
    if IgnoreContext or (TStringList(Stack[i -1])[0] = LastActiveContext) then
    begin
      l := TStringList(Stack[i -1]);
      Kind := l[1];
      Elements := l[2];
      Result := True;
      Exit;
    end;
end;

procedure Tui.ShowLineWithExpand(Index: Integer);
begin
  AssertLineIsVisible(Index +1);
  ClearSelectionEx(Script);
  Script.ItemIndex := GetFoldedLineNumber(Index);
  Script.Selected[GetFoldedLineNumber(Index)] := True;
  Script.TopIndex := Script.ItemIndex;
  
end;

procedure Tui.UndoRedoAction(FromStack, ToStack: TList);
var
  Kind, Elements: String;
  SmartPosition: Integer;
  SavedData, RetrievedCommands: TStringList;
  SavedCommandKind, SavedCommandGuid: String;
  l, lX, lY, lZ: TStringList;
  i, iX, iY: Integer;
  s: String;
begin
  if not RemoveStackItem(FromStack, Kind, Elements) then Exit;
  SavedData := TStringList.Create;
  SavedData.CommaText := Elements;
  if Kind = 'Insert' then
  begin
    RetrievedCommands := TStringList.Create;
    l := TStringList.Create;
    lX := TStringList.Create;
    for i := SavedData.Count downto 1 do
    begin
      
      RetrievedCommands.CommaText := SavedData[i -1];
      SmartPosition := StrToInt(RetrievedCommands[0]);
      
      l.Add(IntToStr(SmartPosition));
      l.Add(ScriptTypes[SmartPosition]);
      l.Add(ScriptReferences[SmartPosition]);
      l.Add(GetFunctionDataForStack(ScriptTypes[SmartPosition], ScriptReferences[SmartPosition]));
      lX.Add(l.CommaText);
      l.Clear;
      
      RenderDeleteScriptEx(SmartPosition, True);
    end;
    AddStackItem(ToStack, 'Delete', lX.CommaText);
    lX.Free;
    l.Free;
    RetrievedCommands.Free;
    
    RehashIndents;
    Script.Repaint;
    try
      ShowLineWithExpand(SmartPosition);
    except
      
    end;
  end
  else
  if Kind = 'Delete' then
  begin
    RetrievedCommands := TStringList.Create;
    l := TStringList.Create;
    lX := TStringList.Create;
    lY := TStringList.Create;
    for i := SavedData.Count downto 1 do
    begin
      
      RetrievedCommands.CommaText := SavedData[i -1];
      SmartPosition := StrToInt(RetrievedCommands[0]);
      SavedCommandKind := RetrievedCommands[1];
      SavedCommandGuid := RetrievedCommands[2];
      lY.CommaText := RetrievedCommands[3];
      GetFunctionOffsets(SavedCommandKind, lZ, iX);
      
      l.Add(IntToStr(SmartPosition));
      lX.Add(l.CommaText);
      l.Clear;
      
      try
        
        RenderInsertScriptEx(SavedCommandKind, lZ, lY, SmartPosition, GetLineVisibilityState(SmartPosition, false),
          SavedCommandGuid);
      except
        
      end;
    end;
    AddStackItem(ToStack, 'Insert', lX.CommaText);
    l.Free;
    lX.Free;
    lY.Free;
    RetrievedCommands.Free;
    
    RehashIndents;
    Script.Repaint;
    ShowLineWithExpand(SmartPosition);
  end
  else
  if Kind = 'Edit' then
  begin
    
    SmartPosition := StrToInt(SavedData[0]);
    SavedData.Delete(0);
    SavedCommandKind := SavedData[0];
    SavedData.Delete(0);
    SavedCommandGuid := SavedData[0];
    SavedData.Delete(0);
    GetFunctionOffsets(SavedCommandKind, l, i);
    iY := l.IndexOf(SavedCommandGuid);
    
    lX := TStringList.Create;
    lX.Add(IntToStr(SmartPosition));
    lX.Add(ScriptTypes[SmartPosition]);
    lX.Add(ScriptReferences[SmartPosition]);
    lX.Add(GetFunctionDataForStack(ScriptTypes[SmartPosition], ScriptReferences[SmartPosition]));
    AddStackItem(ToStack, 'Edit', lX.CommaText);
    lX.CommaText := SavedData[0];
    
    for iX := 1 to i do
      l[iY + iX] := lX[iX -1];
    lX.Free;
    
    RenderLine(SmartPosition, True);
    ShowLineWithExpand(SmartPosition);
    SetDirtyMia(True, '');
    SetHorizontalScrollBar(Script);
  end;
  SavedData.Free;
end;

procedure Tui.UndoAction;
begin
  PushStatusStack('Undoing');
  UndoRedoAction(UndoStack, RedoStack);
  PopStatusStack;
end;

procedure Tui.RedoAction;
begin
  PushStatusStack('Redoing');
  UndoRedoAction(RedoStack, UndoStack);
  PopStatusStack;
end;

procedure Tui.GetFoldersTreeEx(Into: TTreeView; aFolders: TStrings);
var
  s, sX: String;
  n: TTreeNode;
  i: Integer;
  l, lX: TStringList;
begin
  Into.Items.BeginUpdate;
  Into.Items.Item[0].DeleteChildren;
  l := TStringList.Create;
  l.Sorted := True;
  l.CaseSensitive := false;
  l.Duplicates := dupIgnore;
  lX := TStringList.Create;
  for i := 1 to aFolders.Count do
  begin
    s := DeAssertDir(aFolders[i -1]); 
    if l.IndexOf(s) <> -1 then Continue; 
    sX := '';
    n := Into.Items.Item[0]; 
    while s <> '' do
    begin
      if AnsiPos('/', s) = 0 then
      begin
        sX := AssertDir(sX) + s;
        s := '';
      end
      else
      begin
        sX := AssertDir(sX) + Copy(s, 1, AnsiPos('/', s) -1);
        Delete(s, 1, AnsiPos('/', s));
      end;
      
      if sX = '' then sX := '/'; 
      if l.IndexOf(sX) = -1 then
      begin
        
        if sX = '/' then
          
          n := Into.Items.AddChild(n, PathDelim)
        else
          n := Into.Items.AddChild(n,
          StringReplace(
            ExtractFileName(
              StringReplace(sX, ':', '$COLON$', [rfReplaceAll, rfIgnoreCase])), 
            '$COLON$', ':', [rfReplaceAll, rfIgnoreCase]) 
            );
        
        n.ImageIndex := 1;
        n.SelectedIndex := 0;
        l.Objects[l.Add(sX)] := n;
      end
      else
        n := TTreeNode(l.Objects[l.IndexOf(sX)]);
    end;
  end;
  lX.Free;
  l.Free;
  Into.Items.EndUpdate;
  Into.Items.Item[0].Expand(True);
  Into.Items.Item[0].Selected := True;
  if Assigned(Into.OnChange) then
    Into.OnChange(Self, Into.Items.Item[0]);
end;

procedure Tui.MigrateFeatures(Tree: TTreeView; Combo: TComboBoxEx);
var
  fS: String;
  i, fI: Integer;
  ei: TComboExItem;
begin
  
  fI := Combo.ItemIndex;
  if fI <> -1 then
    fS := Combo.ItemsEx.Items[fI].Caption;
  Combo.Clear;
  for i := 1 to Tree.Items.Count do
  begin
    ei := Combo.ItemsEx.Add;
    if i -1 = 0 then
    begin
      ei.Caption := SFeatureIndependent;
      ei.Indent := Tree.Items.Item[i -1].Level * 3;
    end
    else
    begin
      ei.Caption := Tree.Items.Item[i -1].Text;
      ei.Indent := (Tree.Items.Item[i -1].Level -1) * 3;
    end;
    ei.ImageIndex := Tree.Items.Item[i -1].ImageIndex;
    ei.SelectedImageIndex := Tree.Items.Item[i -1].ImageIndex;
  end;
  
  if fI <> -1 then
    if Combo.Items.Count > fI then
      if Combo.ItemsEx.Items[fI].Caption = fS then
        Combo.ItemIndex := fI;
end;

procedure Tui.GetComponentsTree(Into: TTreeView; MyComponents,
  Selections: TStrings);
var
  i, j: Integer;
  s, sX: String;
  n, nX: TTreeNode;
begin
  Into.Items.BeginUpdate;
  Into.Items.Item[0].DeleteChildren;
  for i := 1 to MyComponents.Count do
  begin
    
    s := MyComponents[i -1];
    n := Into.Items.Item[0]; 
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
        Delete(s, 1, AnsiPos('\', s));
      end;
      nX := nil; 
      if n <> nil then 
        for j := 1 to n.Count do
          if AnsiUpperCase(n[j -1].Text) = AnsiUpperCase(sX) then
          begin
            nX := n[j -1]; 
            Break;
          end;
      if nX = nil then 
      begin
        if n <> nil then
          nX := Into.Items.AddChild(n, sX)
        else
          nX := Into.Items.Add(Into.Items.Item[0], sX);
      end;
      
      n := nX;
    end;
    
    if StrToBool(Selections[i -1])  then 
    begin
      nX.ImageIndex := 1;
      nX.SelectedIndex := 1;
    end
    else
    begin
      nX.ImageIndex := 0;
      nX.SelectedIndex := 0;
    end;
    
  end;
  Into.Items.EndUpdate;
  Into.Items.Item[0].Expand(True);
  Into.Items.Item[0].Selected := True;
  FeaturesChange(Self, Into.Items.Item[0]);
end;

function Tui.GetFolderPathFromTree(Node: TTreeNode): String;
begin
  Result := '';
  if Node = nil then Exit;
  Result := Node.Text;
  while Node.Parent <> nil do
  begin
    Node := Node.Parent;
    if Node.Text = '/' then
      Result := Node.Text + Result 
    else
      Result := Node.Text + '/' + Result;
  end;
  Delete(Result, 1, Length(AssertDir(Node.Text)));
end;

function Tui.GetComponentPathFromCombo(Combo: TComboBoxEx): String;
var
  i, iX: Integer;
begin
  if GetComponentPathFromComboCache <> '' then
  begin
    Result := GetComponentPathFromComboCache;
    Exit;
  end;
  Result := Combo.ItemsEx.ComboItems[Combo.ItemIndex].Caption;
  iX := Combo.ItemsEx.ComboItems[Combo.ItemIndex].Indent;
  for i := Combo.ItemIndex downto 1 do
    if Combo.ItemsEx.ComboItems[i -1].Indent < iX then
    begin
      iX := Combo.ItemsEx.ComboItems[i -1].Indent;
      Result := Combo.ItemsEx.ComboItems[i -1].Caption
        + '\' + Result;
    end;
  if Result = SFeatureIndependent then
    Result := '';
  GetComponentPathFromComboCache := Result;
end;

function Tui.GetFilesAndSourcesForComponentInFolder(Feature,
  Folder: String; FeatureFilter: Boolean; ReturnFirstOnly: Boolean): TStrings;
var
  i, j: Integer;
  b: Boolean;
  s: String;
begin
  Folder := AssertDir(Folder);
  Result := TStringList.Create;
  if not FeatureFilter then
  begin
    for i := 1 to InstallFiles.Count do
      if (i -1) mod 13 = 0 then
        if CompareText(AssertDir(InstallFiles[i -1 +3]), Folder) = 0 then
        begin
          Result.Add(InstallFiles[i -1 +1]);
          Result.Add(InstallFiles[i -1]);
          if ReturnFirstOnly then Exit;
        end;
  end
  else
  begin
    if Feature = '' then b := True 
      else b := false; 
    for i := 1 to ScriptTypes.Count do
    begin
      s := ScriptTypes[i -1];
      if s = 'Get Component State' then 
      begin
        if Feature = '' then Exit 
        else
          b := Feature =
            GetComponent[GetComponent.IndexOf(ScriptReferences[i -1]) +1];
      end
      else
      if b and (s = 'Install Files') then 
      begin
        j := InstallFiles.IndexOf(ScriptReferences[i -1]);
        if CompareText(Folder, AssertDir(InstallFiles[j +3])) = 0 then
        begin
          Result.Add(InstallFiles[j +1]);
          Result.Add(InstallFiles[j]);
          if ReturnFirstOnly then Exit;
        end;
      end;
    end;
  end;
end;

function Tui.AddFileToFileList(List: TListView; FilePath, FileName,
  GUID: String): TListItem;
{$IFDEF WINDOWS}
var
  SFI: TSHFileInfo;
  Attr: Integer;
{$ENDIF}
begin
  Result := List.Items.Add;
  {$IFDEF WINDOWS}
  if AnsiPos('*', FileName) <> 0 then
    Attr := FILE_ATTRIBUTE_DIRECTORY
  else
    Attr := FILE_ATTRIBUTE_NORMAL;
  {$ENDIF}
  Result.Caption := FileName;
  Result.SubItems.Add(FilePath);
  Result.SubItems.Add(GUID);
  {$IFDEF WINDOWS}
  if Attr = FILE_ATTRIBUTE_DIRECTORY then FileName := 'Bogus'; 
  SHGetFileInfo(PChar(FileName), Attr, SFI, SizeOf(TSHFileInfo),
    $000000100 or $000000010);
  Result.ImageIndex := SFI.iIcon;
  {$ENDIF}
end;

function Tui.GetProjectFileNameOnly: String;
begin
  if ProjectStruct.OutputFile = '' then
  begin
    if CurrentProjectName = '' then
      Result := SUntitled
    else
      Result := ExtractFileNameOnly(CurrentProjectName);
  end
    else Result := ProjectStruct.OutputFile;
end;

function Tui.GetBuildFolder(ForDebug: Boolean): String;
begin
  if not ProjectStruct.BuildInFolder then
    Result := ProjectStruct.BuildCustomFolder
  else
  begin
    if CurrentProjectName = '' then
      Result := EXEDIR
    else
      Result := PROJDIR;
  end;
  Result := AssertDir(Result) + 'Release' + DirectorySeparator;
  if ForDebug then
  begin
    Result := Result + 'Uncompressed' + DirectorySeparator; 
    Exit;
  end;
  if ProjectStruct.BuildLayout = 0 then
    Result := Result + 'Uncompressed' + DirectorySeparator; 
  if ProjectStruct.BuildLayout = 1 then
    Result := Result + 'Single' + DirectorySeparator; 
  if ProjectStruct.BuildLayout = 2 then
    Result := Result + 'Web' + DirectorySeparator; 
end;

procedure Tui.RefreshWatches;
var
  i, iX, iY: Integer;
  l: TListItem;
begin
  if Watches = nil then Exit; 
  Watches.Variable.Items.Clear;
  Watches.Value.Items.Clear;
  for i := 1 to VarWatches.Count do
  begin
    l := Watches.Variable.Items.Add;
    l.Caption := VarWatches[i -1];
    if Running then
    begin
      l := Watches.Value.Items.Add;
      iY := -1;
      for iX := 1 to VarCache.Count do
        if CompareText(VarCache[iX -1], VarWatches[i -1]) = 0 then
        begin
          iY := iX;
          Break;
        end;
      if iY <> -1 then
      begin
        l.Caption := Variables[iY -1];
        l.SubItems.Add('VAR'); 
      end
      else
      begin
        l.Caption := SVariableNotDefined;
        l.SubItems.Add('VARNOT'); 
      end;
    end;
  end;
end;

procedure Tui.FreeAxContext;
var
  i: Integer;
begin
  axScriptTypes.Free;
  axScriptReferences.Free;
  axScriptComments.Free;
  for i := 1 to axGlobalLists.Count do
    TStrings(axGlobalLists[i -1]).Free;
  axGlobalLists.Free;
  axScriptFetches.Free;
  axScriptFolds.Free;
  axBreakpoints.Free;
  axFoldList.Free;
  axBookmarks.Free;
end;

procedure Tui.ProcessAllCodeFolds(Expand: Boolean);
var
  b: Boolean;
  i: Integer;
  l: TStringList;
begin
  if not EnabledFolding then Exit;
  
  l := TStringList.Create;
  for i := 1 to ScriptTypes.Count do
    if ScriptTypes[i -1] = 'Code Folding Region' then 
      if StrToBool(Region[Region.IndexOf(ScriptReferences[i -1]) +1]) then
        if DoesRegionHaveClosure(i -1) then
          l.Add(Region[Region.IndexOf(ScriptReferences[i -1]) +2]);
  
  i := 1;
  while l.Count <> 0 do
  begin
    b := True;
    try
      GetFoldedLineNumber(ScriptReferences.IndexOf(Region[Region.IndexOf(l[i -1]) -2]));
    except
      b := false;
    end;
    if b then
    begin
      if Expand then
        if FoldList.IndexOf(l[i -1]) <> -1 then
          ProcessCodeFolding(ScriptReferences.IndexOf(Region[Region.IndexOf(l[i -1]) -2]));
      if not Expand then
        if FoldList.IndexOf(l[i -1]) = -1 then
          ProcessCodeFolding(ScriptReferences.IndexOf(Region[Region.IndexOf(l[i -1]) -2]));
      l.Delete(i -1);
    end
    else
    begin
      i := i +1;
      if i > l.Count then
        i := 0;
    end;
  end;
  l.Free;
end;

procedure Tui.ProcessTemporaryExpand(Expand: Boolean);
var
  i: Integer;
begin
  if not EnabledFolding then Exit;
  if Script.Items.Count = 0 then Exit;
  try
    ui.BeginFormUpdate;
    if Script.ItemIndex <> -1 then
      i := GetRealLineNumber(Script.ItemIndex)
    else
      i := -1;
    if Expand then
    begin
      TemporaryExpansionActive := True;
      BackupFoldList.CommaText := FoldList.CommaText;
      ProcessAllCodeFolds(True);
      if i <> -1 then
      begin
        
        ClearSelectionEx(Script);
        Script.ItemIndex := i;
        Script.Selected[i] := True;
      end;
    end
    else
    begin
      TemporaryExpansionActive := false;
      FoldList.CommaText := BackupFoldList.CommaText;
      ApplySavedCodeFolding;
      if i <> -1 then
      begin
        
        ClearSelectionEx(Script);
        i := GetFoldedLineNumber(i);
        Script.ItemIndex := i;
        Script.Selected[i] := True;
      end;
    end;
  finally
    ui.EndFormUpdate;
  end;
end;

function Tui.DoesRegionHaveClosure(Line: Integer): Boolean;
var
  i, j: Integer;
begin
  Result := false;
  j := 1;
  for i := Line +2 to ScriptBuffer.Count do
    if IsLineCodeFolding(i -1) then
    begin
      if IsLineCodeFoldEnd(i -1) then
        j := j -1
      else
        j := j +1;
      if j = 0 then
      begin
        Result := True;
        Break; 
      end;
    end;
end;

procedure Tui.ShowIncludeLineFromGlobal(Index: Integer; Map: TStrings;
  TempExpandNeeded: Boolean);
var
  l: TStringList;
  i, j, k: Integer;
  s, sX: String;
  b: Boolean;
begin
  k := CurrentUnit.TabIndex;
  s := PullMap[Index];
  sX := s;
  Delete(s, AnsiPos('*', s), Length(s));
  Delete(sX, 1, Length(s) +1);
  j := StrToInt(sX);
  l := TStringList.Create;
  
  if s = GetFullProjectScriptFilePath then
  begin
    b := CurrentUnit.TabIndex = 1;
    if (not b)  or TempExpandNeeded then
      if TemporaryExpansionActive then
        ProcessTemporaryExpand(false);
    CurrentUnit.TabIndex := 1;
    if k <> 1 then
      CurrentUnitChange(Self);
  end
  else
  begin
    b := CurrentUnit.TabIndex = IncludeFiles.IndexOf(s) +2;
    if (not b) or  TempExpandNeeded then
      if TemporaryExpansionActive then
        ProcessTemporaryExpand(false);
    CurrentUnit.TabIndex := IncludeFiles.IndexOf(s) +2;
    if k <> IncludeFiles.IndexOf(s) +2 then
      CurrentUnitChange(Self);
  end;
  l.Free;
  
  if TempExpandNeeded or (not b) then
    
      ProcessTemporaryExpand(True); 
  try
    
  except
    
  end;
  ui.ClearSelectionEx(ui.Script);
  Script.Selected[j] := True;
  Script.ItemIndex := j;
  if (j +1 - ui.Script.TopIndex) * ui.Script.Canvas.TextHeight('0') >
    ui.Script.ClientHeight then
      ui.Script.TopIndex := j;
end;

procedure Tui.MergeScripts(MergePoint: Integer; fGlobalLists: TList;
  fScriptTypes, fScriptReferences, fScriptComments, fScriptFetches,
  fScriptFolds, fFoldList, fBreakpoints, fBookmarks: THashedStringList;
  tGlobalLists: TList; tScriptTypes, tScriptReferences, tScriptComments,
  tScriptFetches, tScriptFolds, tFoldList, tBreakpoints,
  tBookmarks: THashedStringList);
var
  i, j: Integer;
  fl, tl: THashedStringList;
begin
  for i := 1 to fGlobalLists.Count +8 do
  begin
    if i <= fGlobalLists.Count then
    begin
      fl := THashedStringList(fGlobalLists[i -1]);
      tl := THashedStringList(tGlobalLists[i -1]);
      
      for j := 1 to fl.Count do
        tl.Add(fl[j -1]);
    end
    else
    begin
      if i = fGlobalLists.Count +1 then
      begin
        fl := fScriptTypes;
        tl := tScriptTypes;
      end;
      if i = fGlobalLists.Count +2 then
      begin
        fl := fScriptReferences;
        tl := tScriptReferences;
      end;
      if i = fGlobalLists.Count +3 then
      begin
        fl := fScriptComments;
        tl := tScriptComments;
      end;
      if i = fGlobalLists.Count +4 then
      begin
        fl := fScriptFetches;
        tl := tScriptFetches;
      end;
      if i = fGlobalLists.Count +5 then
      begin
        fl := fScriptFolds;
        tl := tScriptFolds;
      end;
      if i = fGlobalLists.Count +6 then
      begin
        fl := fFoldList;
        tl := tFoldList;
        
        for j := 1 to fl.Count do
          tl.Add(fl[j -1]);
        Continue;
      end;
      if i = fGlobalLists.Count +7 then
      begin
        fl := fBreakpoints;
        tl := tBreakpoints;
        
        while tl.Count < MergePoint do
          tl.Add('');
      end;
      if i = fGlobalLists.Count +8 then
      begin
        fl := fBookmarks;
        tl := tBookmarks;
        
        while tl.Count < MergePoint do
          tl.Add('');
      end;
      
      for j := fl.Count downto 1 do
      begin
        if j = fl.Count then
          tl.Delete(MergePoint -2);
        tl.Insert(MergePoint -2, fl[j -1]);
      end;
    end;
  end;
end;

function Tui.RecursiveSubstituteScript(WorkContext: String;
  AlreadyPulled: TStrings; var aGlobalLists: TList; var aScriptTypes,
  aScriptReferences, aScriptComments, aScriptFetches, aScriptFolds, aFoldList,
  aBreakpoints, aBookmarks: THashedStringList): String;
var
  wGlobalLists, pGlobalLists: TList;
  wScriptTypes, wScriptReferences, wScriptComments, wScriptFetches,
  wScriptFolds, wFoldList, wBreakpoints, wBookmarks, pScriptTypes, pScriptReferences,
  pScriptComments, pScriptFetches, pScriptFolds, pFoldList,
  pBreakpoints, pBookmarks: THashedStringList;
  wMemoryBuffer, wFileBuffer: String;
  pMemoryBuffer, pFileBuffer: String;
  l: TStringList;
  PullContext, Wide2: String;
  i: Integer;
  FreeBugFixContext: Boolean;
begin
  FreeBugFixContext := false;
  try
    
    if AlreadyPulled = nil then
      AlreadyPulled := THashedStringList.Create;
    
    GetNamedScriptNameAndFile(WorkContext, wMemoryBuffer, wFileBuffer);
    if not IsContextLoaded(wMemoryBuffer) then
    begin
      
      if ScriptFile = wMemoryBuffer then
      begin
        SaveContext(wMemoryBuffer); 
        FreeBugFixContext := True;
      end;
      
      if not IsContextLoaded(wMemoryBuffer) then
        if not LoadContextFromDisk(wMemoryBuffer, wFileBuffer) then
        begin
          Result := '$' + wFileBuffer;
          Exit;
        end;
    end;
    wGlobalLists := MakeNewEmptyGlobalList;
    AssignContext(wMemoryBuffer, wGlobalLists, wScriptTypes, wScriptReferences,
      wScriptComments, wScriptFetches, wScriptFolds, wFoldList, wBreakpoints, wBookmarks, True);
    
    for i := wScriptTypes.Count downto 1 do 
      if wScriptTypes[i -1] = 'Include Script' then 
      begin
        if wScriptComments[i -1] <> 'C' then
        begin
          l := TStringList(wGlobalLists[GlobalLists.IndexOf(xInclude)]);
          PullContext := l[l.IndexOf(wScriptReferences[i -1]) +1];
          WidenColonDelimParam(PullContext, PullContext, Wide2);
          IncludeDepthInteger := IncludeDepthInteger +1;
          IncludeDepthStack.Add(Wide2);
          if not GetNamedScriptNameAndFile(PullContext, pMemoryBuffer, pFileBuffer) then
          begin
            Result := '#' + pMemoryBuffer;
            Exit; 
          end;
          if AlreadyPulled.IndexOf(pFileBuffer) <> -1 then
          begin
            Result := pFileBuffer;
            Exit; 
          end;
          AlreadyPulled.Add(pFileBuffer); 
          if not IsContextLoaded(pMemoryBuffer) then
            if not LoadContextFromDisk(pMemoryBuffer, pFileBuffer) then
            begin
              Result := '$' + pFileBuffer;
              Exit;
            end;
          pGlobalLists := MakeNewEmptyGlobalList;
          AssignContext(pMemoryBuffer, pGlobalLists, pScriptTypes, pScriptReferences,
            pScriptComments, pScriptFetches, pScriptFolds, pFoldList, pBreakpoints, pBookmarks);
          if pScriptTypes.Count > 0 then 
          begin
            Result := RecursiveSubstituteScript(PullContext, AlreadyPulled, pGlobalLists,
              pScriptTypes, pScriptReferences, pScriptComments, pScriptFetches,
              pScriptFolds, pFoldList, pBreakpoints, pBookmarks); 
            if Result <> '' then Exit; 
            AlreadyPulled.Delete(AlreadyPulled.IndexOf(pFileBuffer)); 
            IncludeDepthInteger := IncludeDepthInteger -1;
            IncludeDepthStack.Delete(IncludeDepthStack.Count -1);
            
            MergeScripts(i +1, pGlobalLists, pScriptTypes, pScriptReferences, pScriptComments,
              pScriptFetches, pScriptFolds, pFoldList, pBreakpoints, pBookmarks, wGlobalLists,
              wScriptTypes, wScriptReferences, wScriptComments, wScriptFetches, wScriptFolds,
              wFoldList, wBreakpoints, wBookmarks);
            
          end
          else
          begin
            AlreadyPulled.Delete(AlreadyPulled.IndexOf(pFileBuffer)); 
            IncludeDepthInteger := IncludeDepthInteger -1;
            IncludeDepthStack.Delete(IncludeDepthStack.Count -1);
            
            IncludeDepth.Insert(0, IncludeDepthStack[IncludeDepthStack.Count -1] + '*' + IntToStr(IncludeDepthInteger));
            PullMap.Insert(0, wFileBuffer + '*' + IntToStr(i -1)); 
            BreakMap.Insert(0, ''); 
            
          end;
        end
        else
        begin
          
          IncludeDepth.Insert(0, IncludeDepthStack[IncludeDepthStack.Count -1] + '*' + IntToStr(IncludeDepthInteger));
          PullMap.Insert(0, wFileBuffer + '*' + IntToStr(i -1)); 
          BreakMap.Insert(0, ''); 
          
        end;
      end
      else
      begin
        IncludeDepth.Insert(0, IncludeDepthStack[IncludeDepthStack.Count -1] + '*' + IntToStr(IncludeDepthInteger));
        PullMap.Insert(0, wFileBuffer + '*' + IntToStr(i -1));
        if wBreakpoints.Count >= i then
          BreakMap.Insert(0, wBreakpoints[i -1])
        else
          BreakMap.Insert(0, '');
      end;
    Result := '';
    aGlobalLists := wGlobalLists;
    aScriptTypes := wScriptTypes;
    aScriptReferences := wScriptReferences;
    aScriptComments := wScriptComments;
    aScriptFetches := wScriptFetches;
    aScriptFolds := wScriptFolds;
    aFoldList := wFoldList;
    aBreakpoints := wBreakpoints;
    aBookmarks := wBookmarks;
  finally
    if FreeBugFixContext then
      FreeContext(ScriptFile);
  end;
end;

function Tui.PreCompileScript(var Error: String; aFree: Boolean): Integer;
var
  aGlobalLists: TList;
  aScriptTypes, aScriptReferences, aScriptComments,
  aScriptFetches, aScriptFolds, aFoldList, aBreakpoints, aBookmarks: THashedStringList;
  t: TextFile;
  s: String;
  i, j: Integer;
begin
  try
    PushStatusStack('Binding script');
    if (CurrentProjectName = '') or (ScriptFile = '') then
    begin
      Result := MAXINT -3;
      Error := SPleaseSaveYourProjectBeforeCompi;
      Exit;
    end;
    PullMap.Clear;
    BreakMap.Clear;
    IncludeDepth.Clear;
    IncludeDepthInteger := 0;
    IncludeDepthStack.Clear;
    IncludeDepthStack.Add(IntToStr(IncludeDepthInteger));
    for i := 1 to IncludeFiles.Count do
      if not MyFileExists(IncludeFiles[i -1]) then
      begin
        Result := MAXINT -3;
        Error := SIncludeScript_2 + IncludeFiles[i -1] + SNotFoundOnDisk;
        Exit;
      end;
    try
      ui.BeginFormUpdate;
      globBlockRenderScript := True;
      s := RecursiveSubstituteScript('', nil, aGlobalLists, aScriptTypes, aScriptReferences,
          aScriptComments, aScriptFetches, aScriptFolds, aFoldList, aBreakpoints, aBookmarks);
    finally
      globBlockRenderScript := false;
      RenderScript;
      ui.EndFormUpdate;
    end;
    if not (s = '') then
    begin
      if s[1] = '#' then
      begin
        Result := MAXINT -3;
        Delete(s, 1, 1);
        Error := SIncludeScript_2 + s + SNotPartOfProject;
      end
      else
      if s[1] <> '$' then
      begin
        Result := MAXINT -3;
        Error := SIncludeScript_2 + s + SCalledRecursively;
      end
      else
      begin
        Result := MAXINT -1;
        Delete(s, 1, 1);
        Error := SIncludeScript_2 + s + SUsesUnsupportedPlugIns + PlugError; 
      end;
      Exit;
    end;
    
    PullMapDirect.CommaText := PullMap.CommaText;
    IncludeDepthDirect.CommaText := IncludeDepth.CommaText;
    
    Result := CompileScript(aScriptTypes, aScriptReferences, aScriptComments,
      aGlobalLists, Error);
    
    if aFree then
    begin
      
      aScriptTypes.Free;
      aScriptReferences.Free;
      aScriptComments.Free;
      for i := 1 to aGlobalLists.Count do
        TStrings(aGlobalLists[i -1]).Free;
      aGlobalLists.Free;
      aScriptFetches.Free;
      aScriptFolds.Free;
      aBreakpoints.Free;
      aFoldList.Free;
      aBookmarks.Free;
    end
    else
    begin
      
      axScriptTypes := aScriptTypes;
      axScriptReferences := aScriptReferences;
      axScriptComments := aScriptComments;
      axGlobalLists := aGlobalLists;
      axScriptFetches := aScriptFetches;
      axScriptFolds := aScriptFolds;
      axBreakpoints := aBreakpoints;
      axFoldList := aFoldList;
      axBookmarks := aBookmarks;
    end;
  finally
    PopStatusStack;
  end;
end;

procedure Tui.RenderFunctionToClipboard(Kind, Guid: String;
  AppendToList: TStrings);
var
  l: TStringList;
  i, j: Integer;
begin
  GetFunctionOffsets(Kind, l, i);
  for j := 1 to i do
    AppendToList.Add(l[l.IndexOf(Guid) + j]);
end;

function Tui.RenderFunctionFromClipboard(Kind, Guid: String; Items: TStrings
  ): Integer;
var
  s: String;
  i: Integer;
  l: TStringList;
begin
  if Kind = 'Code Folding Region' then 
  begin
    
    s := Items[Items.IndexOf(Guid) + 2];
    while Region.IndexOf(s) <> -1 do
      s := SCopyOf + s;
    Region.Add(Guid);
    Region.Add(Items[Items.IndexOf(Guid) + 1]);
    Region.Add(s);
    Result := 2;
  end
  else
  begin
    GetFunctionOffsets(Kind, l, Result);
    if l <> nil then
      l.Add(Guid);
    for i := 1 to Result do
      l.Add(Items[Items.IndexOf(Guid) + i]);
    if Result = -1 then Result := 0;
  end;
end;

procedure Tui.RenderCopyScriptEx(SmartPosition: Integer);
var
  i: Integer;
begin
  if SmartPosition <> -1 then
  begin
    ScriptBuffer.Insert(SmartPosition, '');
    ScriptFolds.Insert(SmartPosition, 'V');
    Script.Items.Insert(GetFoldedLineNumber(SmartPosition), '');
    i := SmartPosition;
  end
  else
  begin
    ScriptBuffer.Add('');
    ScriptFolds.Add('V');
    Script.Items.Add('');
    i := 0;
  end;
  RenderLine(i, True);
end;

procedure Tui.SwitchToUI(aVisual: Boolean);
var
  hDef: TCursor;
begin
  
  hDef := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  if aVisual then
    PushStatusStack('Visualizing code')
  else
    PushStatusStack('Synchronizing changes');
  try
    CurrentUnit.Visible := not aVisual;
    if aVisual then
    begin
      SelectAll1.Enabled := false;
      SelectAllEx.Enabled := false;
      SelectAll2.Enabled := SelectAll1.Enabled;
      if Notebook.ActivePage = 'Visual' then 
        if TabSet.TabIndex = 0 then
        begin
          AdaptToolbar(True);
          
          Exit;
        end;
    end;
    if not aVisual then
    begin
      SelectAll1.Enabled := True;
      SelectAllEx.Enabled := True;
      SelectAll2.Enabled := SelectAll1.Enabled;
      if Notebook.ActivePage = 'Code' then
        if TabSet.TabIndex = 1 then
        begin
          AdaptToolbar(false);
          
          Exit;
        end;
    end;
    TabSet.OnChange := nil;
    if aVisual then
    begin
      RestoreTabIndex := CurrentUnit.TabIndex;
      if ScriptFile <> LastActiveContext then
      begin
        CurrentUnit.TabIndex := 1;
        CurrentUnitChange(Self);
      end;
      Notebook.PageIndex := Notebook.Pages.IndexOf('Visual'); 
      RemoveShortcuts;
      TabSet.TabIndex := 0;
      
      AdaptToolbar(True);
      AdjustVisualUI;
      
      ClearStack(UndoStack);
      ClearStack(RedoStack);
    end
    else
    begin
      if RestoreTabIndex <> CurrentUnit.TabIndex then
        if CurrentUnit.Tabs.Count > RestoreTabIndex then
        begin
          CurrentUnit.TabIndex := RestoreTabIndex;
          CurrentUnitChange(Self);
        end;
      Notebook.PageIndex := Notebook.Pages.IndexOf('Code'); 
      InsertShortcuts;
      if ActiveTab = 0 then
        EditAction1.ShortCut := ShortCut(0, [])
      else
        if not Running then
          if not (Notebook.ActivePage = 'Visual') then 
            EditAction1.ShortCut := ShortCut(13, []);
      TabSet.TabIndex := 1;
      
      AdaptToolbar(false);
      if ScriptBook.PageIndex = 1 then
      try
        if not Script.Focused then Script.SetFocus;
      except
      end;
      
      Script.TopIndex := Script.ItemIndex;
    end;
    
    if Notebook.ActivePage = 'Code' then
      FormResize(Self); 
    TabSet.OnChange := @TabSetChange;
  finally
    PopStatusStack;
    Screen.Cursor := hDef;
  end;
end;

procedure Tui.RedrawScript;
begin
  Script.Font.Size := Round(BaseFontSize * 100 / 100);
  Script.Canvas.Font := Script.Font;
  FontWidth := Script.Canvas.TextWidth('0');
  FontHeight := Script.Canvas.TextHeight('0');
  Script.ItemHeight := Script.Canvas.TextHeight('0');
  RehashIndents;
  Script.Repaint;
  SetHorizontalScrollBar(Script);
end;

function Tui.LoadUISettings: Boolean;
var
  f: TFont;
  b: Boolean;
  i, j, k: Integer;
  t: TextFile;
  s, sX: String;
  BOM: Char;
begin
  Result := false;
  if MyFileExists(EXEDIR + 'miax.mix') then 
  begin
    AssignFile(t, EXEDIR + 'miax.mix',cp_utf8); 
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
    ReadLn(t, CurrentProjectName);
    ReadLn(t);
    ReadLn(t, j);
    ReadLn(t, i);
    
      Left := i;
    ReadLn(t, i);
    
      Top := i;
    ReadLn(t, i);
    
      Width := i;
    ReadLn(t, i);
    
      Height := i;
    ReadLn(t, s);
    f := TFont.Create;
    StringToFont(s, f);
    Script.Font := f;
    BaseFontSize := Script.Font.Size;
    f.Free;
    ReadLn(t, s);
    StringToFont(s, fontComment);
    ReadLn(t, s);
    StringToFont(s, fontStatement);
    ReadLn(t, s);
    StringToFont(s, fontLabel);
    ReadLn(t, s);
    StringToFont(s, fontFlowControl);
    ReadLn(t, s);
    StringToFont(s, fontDirective);
    ReadLn(t, s);
    StringToFont(s, fontPlugIn);
    ReadLn(t, s);
    StringToFont(s, fontWindowsInstaller);
    ReadLn(t, s);
    StringToFont(s, fontModifySystem);
    ReadLn(t, s);
    StringToFont(s, fontLine);
    RedrawScript;
    ReadLn(t, i);
    
    ReadLn(t);
    ReadLn(t, s);
    SwitchToUI(s = 'Visual'); 
    ReadLn(t, s);
    EnabledFolding := StrToBool(s);
    ReadLn(t, ActiveTab);
    k := ActiveTab;
    ReadLn(t, s);
    
    ReadLn(t, s);
    
    ReadLn(t, s);
    
    ReadLn(t, s);
    
    ReadLn(t, s);
    
    ReadLn(t, s);
    
    ReadLn(t, s);
    
    ReadLn(t, s);
    
    ReadLn(t, s);
    
    ReadLn(t, s);
    
    ReadLn(t, s);
    
    ReadLn(t, s);
    EnabledExport := StrToBool(s);
    ReadLn(t, s);
    
    if not EOF(t) then
    begin
      ReadLn(t, s);
      
    end;
    if not EOF(t) then
    begin
      ReadLn(t, i);
      
    end;
    if not EOF(t) then
    begin
      ReadLn(t, s);
      
    end;
    if not EOF(t) then
    begin
      ReadLn(t, s);
      EnabledCodeCompletion := StrToBool(s);
      ReadLn(t, s);
      EnabledCodeCompletionElse := StrToBool(s);
    end;
    CloseFile(t);
    b := false;
    if ParamStr(1) <> '' then
      sX := MyExtractFileDriveFixUp(ParamStr(1), MyGetCurrentDir);
    if CurrentProjectName <> '' then
      if MyFileExists(CurrentProjectName) then
      begin
        if (AnsiCompareText(ExtractFileExt(ParamStr(1)), '.mprx') <> 0) or
          (((ParamStr(1) = '') or ((ParamStr(1) <> '') and
          (not MyFileExists(sX))))) then
          begin
            Result := LoadProject(CurrentProjectName);
            b := True;
          end;
      end
      else
        CurrentProjectName := '';
    if not b then
      if AnsiCompareText(ExtractFileExt(ParamStr(1)), '.mprx') = 0 then
        if MyFileExists(sX) then
          LoadProject(sX);
    
    ActiveTab := k;
    if CurrentUnit.Tabs.Count > ActiveTab then
      CurrentUnit.TabIndex := ActiveTab
    else
      CurrentUnit.TabIndex := CurrentUnit.Tabs.Count -1;
    CurrentUnitChange(Self);
    
    if j = 2 then
    begin
      Application.ProcessMessages; 
      TimerMaximize.Interval := 1;
      TimerMaximize.Enabled := True;
    end;
  end;
end;

procedure Tui.SaveUISettings(aWindowState: TWindowState; SaveTipsOnly: Boolean);
var
  i, j: Integer;
  t, tX: TextFile;
  s: String;
  BOM: Char;
begin
  if SaveTipsOnly then
  begin
    AssignFile(t, EXEDIR + 'miax.mix.new',cp_utf8); 
    ReWrite(t);
    AssignFile(tX, EXEDIR + 'miax.mix',cp_utf8); 
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
    i := 0;
    while not EOF(tX) do
    begin
      ReadLn(tX, s);
      WriteLn(t, s);
      i := i +1;
      if i = 22 then
      begin
        WriteLn(t,True);
        WriteLn(t,True);
        WriteLn(t,True);
        WriteLn(t,True);
        WriteLn(t,True);
        WriteLn(t,True);
        WriteLn(t,True);
        WriteLn(t,True);
        WriteLn(t,True);
        WriteLn(t,True);
        WriteLn(t,True);
        WriteLn(t, EnabledExport);
        WriteLn(t,True);
        i := 24 +11;
        Break;
      end;
    end;
    CloseFile(t);
    CloseFile(tX);
    Erase(tX);
    Rename(t, EXEDIR + 'miax.mix'); 
    Exit;
  end;
  AssignFile(t, EXEDIR + 'miax.mix',cp_utf8); 
  ReWrite(t);
  WriteLn(t, CurrentProjectName);
  WriteLn(t);
  if aWindowState = wsNormal then
    i := 0
  else
  if aWindowState = wsMaximized then
    i := 2
  else
    i := 1;
  WriteLn(t, i);
  WriteLn(t, Left);
  WriteLn(t, Top);
  WriteLn(t, Width);
  WriteLn(t, Height);
  j := Script.Font.Size;
  Script.Font.Size := BaseFontSize;
  WriteLn(t, FontToString(Script.Font));
  Script.Font.Size := j;
  WriteLn(t, FontToString(fontComment));
  WriteLn(t, FontToString(fontStatement));
  WriteLn(t, FontToString(fontLabel));
  WriteLn(t, FontToString(fontFlowControl));
  WriteLn(t, FontToString(fontDirective));
  WriteLn(t, FontToString(fontPlugIn));
  WriteLn(t, FontToString(fontWindowsInstaller));
  WriteLn(t, FontToString(fontModifySystem));
  WriteLn(t, FontToString(fontLine));
  WriteLn(t,0);
  WriteLn(t,0);
  WriteLn(t, Notebook.ActivePage);
  WriteLn(t, EnabledFolding);
  WriteLn(t, ActiveTab);
  WriteLn(t,True);
  WriteLn(t,True);
  WriteLn(t,True);
  WriteLn(t,True);
  WriteLn(t,True);
  WriteLn(t,True);
  WriteLn(t,True);
  WriteLn(t,True);
  WriteLn(t,True);
  WriteLn(t,True);
  WriteLn(t,True);
  WriteLn(t, EnabledExport);
  WriteLn(t,True);
  WriteLn(t,True);
  WriteLn(t,100);
  WriteLn(t,True);
  WriteLn(t, EnabledCodeCompletion);
  WriteLn(t, EnabledCodeCompletionElse);
  CloseFile(t);
end;

procedure Tui.RemoveShortcuts;
begin
  MenuItem27.Enabled := false;
  EditAction1.ShortCut := ShortCut(0, []);
  Delete1.ShortCut := ShortCut(0, []);
end;

procedure Tui.InsertShortcuts;
begin
  MenuItem27.Enabled := True;
  EditAction1.ShortCut := ShortCut(13, []);
  Delete1.ShortCut := Shortcut(46, []);
end;

procedure Tui.SetHorizontalScrollBar(lb: TListBox);
var
  j, MaxWidth: Integer;
begin
  MaxWidth := 0;
  for j := 0 to lb.Items.Count -1 do
    if MaxWidth < lb.Canvas.TextWidth(lb.Items[j]) + StrToInt(IndentHash[j]) then
      MaxWidth := lb.Canvas.TextWidth(lb.Items[j]) + StrToInt(IndentHash[j]);
  SendMessage(lb.Handle, $0194, MaxWidth +5, 0); 
  lb.ScrollWidth := MaxWidth +5; 
end;

function Tui.InDesigner: Boolean;
begin
  Result := false;
  if ui.ActiveControl <> Script then Exit;
  if Screen.ActiveForm <> ui then Exit;
  Result := True;
end;

function Tui.InDesignerEx: Boolean;
begin
  Result := false;
  if Notebook.ActivePage = 'Visual' then Exit;
  if Screen.ActiveForm <> ui then Exit;
  Result := True;
end;

function Tui.GetLineNumberForNamedRegion(nName: String): Integer;
var
  i: Integer;
begin
  Result := -1;
  for i := 1 to Region.Count do
    if i mod 3 = 1 then
      if Region[i -1 + 2] = nName then
      begin
        Result := ScriptReferences.IndexOf(Region[i -1]);
        Exit;
      end;
  if Result = -1 then
    raise Exception.Create(SUnableToObtainLineNumberForNamed);
end;

function Tui.GetLineVisibilityState(NewLine: Integer; FoldedIndex: Boolean
  ): Boolean;
begin
  if not EnabledFolding then
  begin
    Result := True;
    Exit;
  end;
  
  try
    if FoldedIndex then
      NewLine := GetRealLineNumber(NewLine);
    Result := ScriptFolds[NewLine] = 'V';
  except
    Result := True;
    Exit;
  end;
end;

procedure Tui.AssertLineIsVisible(Line: Integer);
var
  i, j: Integer;
  l: TStringList;
begin
  if not EnabledFolding then Exit;
  if not GetLineVisibilityState(Line, false) then
  begin
    l := TStringList.Create; 
    for i := 1 to Line +1 do
      if i -1 = Line then 
      begin
        for j := 1 to l.Count do
          if FoldList.IndexOf(l[j -1]) <> -1 then
            ProcessCodeFolding(GetLineNumberForNamedRegion(l[j -1]));
        l.Free;
        Exit;
      end
      else
      if IsLineCodeFolding(i -1) then 
      begin
        if not IsLineCodeFoldEnd(i -1) then
          l.Add(GetCodeFoldingName(i -1)) 
        else
          l.Delete(l.Count -1); 
      end;
    l.Free;
  end;
end;

procedure Tui.ShowCaretEx;
begin
  ShowCaret(Script.Handle);
  CaretCount := CaretCount +1;
  {$IFDEF DARWIN}
  
  NSTableView(NSScrollView(Script.Handle).documentView).setAllowsTypeSelect(false);
  
  {$ENDIF}
end;

procedure Tui.HideCaretEx;
begin
  while CaretCount > 0 do
  begin
    HideCaret(Script.Handle);
    CaretCount := CaretCount -1;
  end;
  {$IFDEF DARWIN}
  {$IFDEF CPUAARCH64}
  NSTableView(NSScrollView(Script.Handle).documentView).setAllowsTypeSelect(false);
  {$ENDIF}
  {$ENDIF}
end;

function Tui.GetFunctionDataForStack(Kind, Guid: String): String;
var
  l: TStringList;
  lX: TStringList;
  i, iX, iY: Integer;
  CacheS: String;
begin
  Result := '';
  GetFunctionOffsets(Kind, l, i);
  if i = -1 then Exit; 
  lX := TStringList.Create;
  iY := l.IndexOf(Guid);
  for iX := 1 to i do
    lX.Add(l[iY +iX]);
  Result := lX.CommaText;
  lX.Free;
end;

procedure Tui.ProcessCodeFolding(Line: Integer);
var
  s: String;
  l, lX, lY: TStringList;
  b, bX: Boolean;
  i, j, k: Integer;
begin
  if not EnabledFolding then
  begin
    RenderUpdateScript(Line);
    Exit;
  end;
  try
    PushStatusStack('(Un)Folding code');
    if IsLineCodeFoldEnd(Line) then
      RenderUpdateScript(GetFoldedLineNumber(Line))
    else
    begin
      s := GetCodeFoldingName(Line);
      b := FoldList.IndexOf(GetCodeFoldingName(Line)) = -1;
      if b then
        FoldList.Add(GetCodeFoldingName(Line))
      else
        FoldList.Delete(FoldList.IndexOf(GetCodeFoldingName(Line)));
      j := 1;
      l := TStringList.Create; 
      lX := TStringList.Create; 
      lY := TStringList.Create; 
      bX := false;
      for i := Line +2 to ScriptBuffer.Count do
      begin
        if bX then l.Add(IntToStr(i));
        if IsLineCodeFolding(i -1) then
        begin
          if IsLineCodeFoldEnd(i -1) then
          begin
            j := j -1;
            if lX.Count <> 0 then
            begin
              lX.Delete(lX.Count -1); 
              lY.Delete(lY.Count -1);
              if lX.Count = 0 then bX := false
                else 
                   bX := StrToBool(lY[lY.Count -1]) = false;
                
            end;
          end
          else
          begin
            lX.Add(GetCodeFoldingName(i -1)); 
            if FoldList.IndexOf(GetCodeFoldingName(i -1)) = -1 then
            begin
              if lY.Count = 0 then
                bX := True
              else
                bX := StrToBool(lY[lY.Count -1]) = false;
            end
            else
              bX := false;
            lY.Add(MyBoolToStr(not bX, True));
            j := j +1;
          end;
          if j = 0 then
          begin
            k := i;
            Break; 
          end;
        end;
      end;
      lX.Free; 
      
      if j <> 0 then
      begin
        FoldList.Delete(FoldList.IndexOf(GetCodeFoldingName(Line)));
        RenderUpdateScript(GetFoldedLineNumber(Line));
        l.Free;
        Exit;
      end;
      j := 1;
      for i := Line +2 to k do
      begin
        if (j = 1) or b then
        begin
          if b then
          begin
            if ScriptFolds[i -1] <> '' then
            begin
              ScriptFolds[i -1] := '';
              Script.Items.Delete(GetFoldedLineNumber(i -1));
            end;
          end
          else
          begin
            ScriptFolds[i -1] := 'V';
            Script.Items.Insert(GetFoldedLineNumber(i -1), ScriptBuffer[i -1]);
          end;
        end;
        if IsLineCodeFolding(i -1) then
        begin
          if IsLineCodeFoldEnd(i -1) then
          begin
            j := j -1;
          end
          else
          begin
            if FoldList.IndexOf(GetCodeFoldingName(i -1)) <> -1 then
            begin
            end;
            j := j +1;
          end;
        end;
      end;
      if not b then
      begin
        for i := 1 to l.Count do
        begin
          ScriptFolds[StrToInt(l[i -1]) -1] := 'V';
          Script.Items.Insert(GetFoldedLineNumber(StrToInt(l[i -1]) -1),
            ScriptBuffer[StrToInt(l[i -1]) -1]);
        end;
      end;
      l.Free;
      Script.Selected[GetFoldedLineNumber(Line)] := True;
      Script.ItemIndex := GetFoldedLineNumber(Line);
    end;
  finally
    PopStatusStack;
  end;
end;

procedure Tui.ClearSelectionEx(ListBox: TListBox);
var
  i: Integer;
begin
  ListBox.Items.BeginUpdate;
  for i := 1 to ListBox.Items.Count do
    if ListBox.Selected[i -1] then
      ListBox.Selected[i -1] := false;
  ListBox.Items.EndUpdate;
end;

procedure Tui.AddStackItem(Stack: TList; Kind, Elements: String);
var
  l: TStringList;
begin
  l := TStringList.Create;
  l.Add(LastActiveContext);
  l.Add(Kind);
  l.Add(Elements);
  Stack.Add(l);
end;

procedure Tui.GetFunctionOffsets(Kind: String; var List: TStringList;
  var Index: Integer);
begin
  
  List := nil;
  Index := -1;
  
  if Kind = 'Comment' then 
  begin
    List := Comments;
    Index := 1;
  end
  else
  if Kind = 'Create Folder' then 
  begin
    List := CreateFolder;
    Index := 1;
  end
  else
  if Kind = 'MessageBox' then 
  begin
    List := xMessageBox;
    Index := 5;
  end
  else
  if Kind = 'Run Program' then 
  begin
    List := RunProgram;
    Index := 5;
  end
  else
  if (Kind = 'Create Shortcut') or (Kind = 'Advertised Shortcut') then 
  begin
    List := Short;
    Index := 9;
  end
  else
  if Kind = 'Set Variable' then 
  begin
    List := SetVariable;
    Index := 2;
  end
  else
  if ((Kind = 'If') or (Kind = 'Else If')) or ((Kind = 'Compiler Variable If') or ((Kind = 'While') or (Kind = 'Until'))) then 
  begin
    if Kind = 'While' then
      List := xWhile
    else
    if Kind = 'Until' then
      List := xUntil
    else
      List := xIf;
    Index := 4;
  end
  else
  if Kind = 'Include Script' then 
  begin
    List := xInclude;
    Index := 1;
  end
  else
  if Kind = 'Display Dialog' then 
  begin
    List := DisplayDialog;
    Index := 6;
  end
  else
  if Kind = 'Label' then 
  begin
    List := eLabel;
    Index := 1;
  end
  else
  if Kind = 'Get Folder Location' then 
  begin
    List := GetFolderLocation;
    Index := 3;
  end
  else
  if Kind = 'Install Files' then 
  begin
    List := InstallFiles;
    Index := 12;
  end
  else
  if Kind = 'Define Component' then 
  begin
    List := DefComponent;
    Index := 3;
  end
  else
  if Kind = 'Set Component State' then 
  begin
    List := SetComponent;
    Index := 2;
  end
  else
  if Kind = 'Get Component State' then 
  begin
    List := GetComponent;
    Index := 2;
  end
  else
  if Kind = 'Set Component Space' then 
  begin
    List := SpaceFeatures;
    Index := 2;
  end
  else
  if Kind = 'Delete Component' then 
  begin
    List := DelComp;
    Index := 1;
  end
  else
  if Kind = 'GoTo Label' then 
  begin
    List := gLabel;
    Index := 1;
  end
  else
  if Kind = 'Apply Changes' then 
  begin
    List := ApplyChanges;
    Index := 4;
  end
  else
  if Kind = 'Download File' then 
  begin
    List := DownloadFile;
    Index := 6;
  end
  else
  if Kind = 'File Bag' then 
  begin
    List := FileBag;
    Index := 4;
  end
  else
  if Kind = 'Delete Files Recursive' then 
  begin
    List := DeleteRec;
    Index := 1;
  end
  else
  if Kind = 'Delete Files' then 
  begin
    List := DeleteFiles;
    Index := 4;
  end
  else
  if Kind = 'Code Folding Region' then 
  begin
    List := Region;
    Index := 2;
  end
  else
  if Kind = 'Read from Text File' then 
  begin
    List := ReadText;
    Index := 3;
  end
  else
  if Kind = 'Write to Text File' then 
  begin
    List := WriteText;
    Index := 4;
  end
  else
  if Kind = 'Remove Directory' then 
  begin
    List := RmDir;
    Index := 1;
  end
  else
  if Kind = 'Create Link' then 
  begin
    List := CreateLink;
    Index := 5;
  end
  else
  if Kind = 'Mathematics' then 
  begin
    List := Maths;
    Index := 4;
  end
  else
  if Kind = 'Parse String' then 
  begin
    List := Parse;
    Index := 7;
  end
  else
  if Kind = 'Create File Type' then 
  begin
    List := FileType;
    Index := 7;
  end
  else
  if Kind = 'Web Media Block' then 
  begin
    List := MediaBlock;
    Index := 3;
  end
  else
  if Kind = 'Set Owner' then 
  begin
    List := Own;
    Index := 5;
  end
  else
  if Kind = 'Set Group' then 
  begin
    List := Grp;
    Index := 2;
  end
  else
  if Kind = 'Set Access Control' then 
  begin
    List := ACL;
    Index := 16;
  end
  else
  if Kind = 'Get File Version' then 
  begin
    List := GetVers;
    Index := 2;
  end
  else
  if Kind = 'Check File Version' then 
  begin
    List := CheckVersion;
    Index := 5;
  end
  else
  if Kind = 'For Each' then
  begin
    List := xForEach;
    Index := 3;
  end
  else
  if Kind = 'Sleep' then
  begin
    List := xSleep;
    Index := 1;
  end
  else
  if Kind = 'Terminate with Exit Code' then 
  begin
    List := TermExitCode;
    Index := 1;
  end
  else
  if Kind = 'Convert Case' then 
  begin
    List := ConvertCase;
    Index := 2;
  end
  else
  if Kind = 'Convert Path' then 
  begin
    List := ConvertPath;
    Index := 2;
  end
  else
  if Kind = 'Evaluate Expression' then 
  begin
    List := Eval;
    Index := 2;
  end
  else
  if Kind = 'Extract Path' then 
  begin
    List := ExtractPath;
    Index := 2;
  end
  else
  if Kind = 'Format String' then
  begin
    List := FormatStr;
    Index := 3;
  end
  else
  if Kind = 'Get String Length' then
  begin
    List := GetStrLen;
    Index := 2;
  end
  else
  if Kind = 'Get String Position' then
  begin
    List := GetStrPos;
    Index := 4;
  end
  else
  if Kind = 'Localization Variable' then 
  begin
    List := LocVar;
    Index := 2;
  end
  else
  if Kind = 'Match Regular Expression' then
  begin
    List := RegEx;
    Index := 3;
  end
  else
  if Kind = 'Replace String' then 
  begin
    List := ReplaceStr;
    Index := 5;
  end
  else
  if Kind = 'Browse for Folder' then
  begin
    List := xBrowseFolder;
    Index := 3;
  end
  else
  if Kind = 'Browse for File' then
  begin
    List := xBrowseFile;
    Index := 7;
  end
  else
  if Kind = 'Load Feature Selections' then 
  begin
    List := LoadFeatures;
    Index := 1;
  end
  else
  if Kind = 'Prompt for Text' then
  begin
    List := xPromptForText;
    Index := 3;
  end
  else
  if Kind = 'Save Feature Selections' then 
  begin
    List := SaveFeatures;
    Index := 1;
  end
  else
  if Kind = 'Set Component Choice' then 
  begin
    List := SetChoice;
    Index := 2;
  end
  else
  if Kind = 'Get Component Space' then 
  begin
    List := GetSpace;
    Index := 2;
  end
  else
  if Kind = 'Set Component Visibility' then 
  begin
    List := SetVisibility;
    Index := 2;
  end
  else
  if Kind = 'Check Disk Space' then 
  begin
    List := CheckSpace;
    Index := 4;
  end
  else
  if Kind = 'Does File/Folder Exist' then 
  begin
    List := DoesExist;
    Index := 3;
  end
  else
  if Kind = 'Get Link Target' then 
  begin
    List := GetLink;
    Index := 2;
  end
  else
  if Kind = 'Find All Files' then 
  begin
    List := FAF;
    Index := 4;
  end
  else
  if Kind = 'Generate GUID' then 
  begin
    List := xGUID;
    Index := 1;
  end
  else
  if Kind = 'Get Environment' then 
  begin
    List := GetEnv;
    Index := 2;
  end
  else
  if Kind = 'Get INI File Settings' then 
  begin
    List := GetINI;
    Index := 4;
  end
  else
  if Kind = 'Get Temporary File' then 
  begin
    List := GetTemp;
    Index := 1;
  end
  else
  if Kind = 'Is Native Setup Installed' then 
  begin
    List := IsNative;
    Index := 2;
  end
  else
  if Kind = 'Read from Binary File' then
  begin
    List := xReadBinary;
    Index := 4;
  end
  else
  if Kind = 'Copy/Move Local Files' then 
  begin
    List := LocalFiles;
    Index := 6;
  end
  else
  if Kind = 'Edit INI File' then 
  begin
    List := EditINI;
    Index := 6;
  end
  else
  if Kind = 'Set 64 Bit Mode' then 
  begin
    List := Plat;
    Index := 3;
  end
  else
  if Kind = 'Rename File/Folder' then
  begin
    List := xRename;
    Index := 2;
  end
  else
  if Kind = 'Write to Binary File' then
  begin
    List := xWriteBinary;
    Index := 4;
  end
  else
  if Kind = 'Halt Compilation' then 
  begin
    List := HaltCompile;
    Index := 1;
  end
  else
  if Kind = 'Delete Registry' then 
  begin
    List := DeleteReg;
    Index := 4;
  end
  else
  if Kind = 'Find All Registry' then
  begin
    List := FindAllReg;
    Index := 5;
  end
  else
  if Kind = 'Get OS or SP Level' then 
  begin
    List := ExactVer;
    Index := 3;
  end
  else
  if Kind = 'Get System Settings' then 
  begin
    List := GetSystemSettings;
    Index := 2;
  end
  else
  if Kind = 'Get Native Settings' then 
  begin
    List := GetNativeSettings;
    Index := 2;
  end
  else
  if (Kind = 'Read Registry') or (Kind = 'Check Registry') then 
  begin
    List := ReadReg;
    Index := 4;
  end
  else
  if Kind = 'Write Registry' then 
  begin
    List := WriteReg;
    Index := 7;
  end
  else
  if Kind = 'Compress 7Zip Archive' then 
  begin
    List := Compress7Zip;
    Index := 10;
  end
  else
  if Kind = 'Extract 7Zip Archive' then 
  begin
    List := Extract7Zip;
    Index := 6;
  end
  else
  if Kind = 'Return from Include Script' then
  begin
    List := ReturnInclude;
    Index := 1;
  end
  else
  if Kind = 'Run Program As' then
  begin
    List := RunProgramAs;
    Index := 10;
  end
  else
  if Kind = 'Check Process' then 
  begin
    List := CheckProcess;
    Index := 2;
  end
  else
  if Kind = 'Run Script' then 
  begin
    List := xRunScript;
    Index := 7;
  end
  else
  if Kind = 'Get File Size' then 
  begin
    List := xGetFileSize;
    Index := 2;
  end;
  
end;

function Tui.LoadProjectScript(FileName: String): Boolean;
var
  j, k: Integer;
  bX: Boolean;
begin
  Result := false;
  if (AnsiCompareText(ExtractFileExt(FileName), '.brkx') = 0) or (AnsiCompareText(ExtractFileExt(FileName),'.fldx') = 0) then
  begin
    FileName := StringReplace(FileName, '.brkx', '', [rfReplaceAll, rfIgnoreCase]);
    FileName := StringReplace(FileName, '.fldx', '', [rfReplaceAll, rfIgnoreCase]);
  end;
  if not MyFileExists(FileName) then Exit;
  Result := True;
  bX := True;
  if IncludeFiles.IndexOf(FileName) <> -1 then
    bX := false;
  if CompareText(ui.GetFullProjectScriptFilePath, FileName) = 0 then
    bX := false;
  for j := 1 to IncludeFiles.Count do
    if CompareText(ExtractFileNameOnly(IncludeFiles[j -1]),
      ExtractFileNameOnly(FileName)) = 0 then
    begin
      bX := false;
      Break;
    end;
  if bX then
  begin
    IncludeFiles.Add(FileName);
    ui.SetDirtyMPR(True);
    Project.SetInclude(IncludeFiles);
  end;
  FileName := ExtractFileNameOnly(FileName);
  for k := 1 to Project.Tree.Items.Count do
    if (Project.Tree.Items[k -1].Parent = Project.Tree.Items[0].Items[0]) or
      (Project.Tree.Items[k -1].Parent = Project.Tree.Items[0].Items[5])
    then
      if AnsiCompareText(Project.Tree.Items[k -1].Text, FileName) = 0 then
      begin
        Project.Tree.Selected := Project.Tree.Items[k -1];
        Project.TreeDblClick(Project.Tree.Selected);
        Break;
      end;
end;

procedure Tui.ApplySavedCodeFolding;
var
  i: Integer;
begin
  if not EnabledFolding then Exit;
  for i := 1 to Region.Count do
    if i mod 3 = 0 then
      if FoldList.IndexOf(Region[i -1]) <> -1 then
      begin
        FoldList.Delete(FoldList.IndexOf(Region[i -1]));
        ProcessCodeFolding(ScriptReferences.IndexOf(Region[i -3]));
      end;
  
  ClearSelectionEx(Script);
  if Script.Count > 0 then
  begin
    Script.Selected[0] := True;
    Script.ItemIndex := 0;
  end;
end;

function Tui.GetCodeFoldingName(Line: Integer): String;
begin
  Result := Region[Region.IndexOf(ScriptReferences[Line]) +2]
end;

function Tui.IsLineCodeFoldEnd(Line: Integer): Boolean;
begin
  Result := not StrToBool(Region[Region.IndexOf(ScriptReferences[Line]) +1]);
end;

function Tui.IsLineCodeFolding(Line: Integer): Boolean;
begin
  Result := ScriptTypes[Line] = 'Code Folding Region'; 
end;

function Tui.GetAllRealLines(FoldedLine: Integer): TStringList;
var
  i, j: Integer;
  VisibleLines: Integer;
begin
  if not EnabledFolding then
  begin
    Result := TStringList.Create;
    Result.Add(IntToStr(FoldedLine));
    Exit;
  end;
  Result := TStringList.Create;
  VisibleLines := 0;
  for i := 1 to ScriptFolds.Count do
  begin
    if ScriptFolds[i -1] <> '' then
      VisibleLines := VisibleLines +1;
    if VisibleLines -1 = FoldedLine then
    begin
      j := i;
      repeat
        Result.Add(IntToStr(j -1));
        j := j +1;
      until (ScriptFolds.Count +1 = j) or (ScriptFolds[j -1] <> '');
      Exit;
    end;
  end;
  if Result.Count = 0 then
    raise Exception.Create(SUnableToGetAllRealLineNumbersInC);
end;

function Tui.GetRealLineNumber(FoldedLine: Integer): Integer;
var
  i: Integer;
  VisibleLines: Integer;
begin
  if FoldedLine = -1 then
  begin
    
    Result := 0;
    Exit;
  end;
  if not EnabledFolding then
  begin
    Result := FoldedLine;
    Exit;
  end;
  Result := -1;
  VisibleLines := 0;
  for i := 1 to ScriptFolds.Count do
  begin
    if ScriptFolds[i -1] <> '' then
      VisibleLines := VisibleLines +1;
    if VisibleLines -1 = FoldedLine then
    begin
      Result := i -1;
      Exit;
    end;
    if i = ScriptFolds.Count then
      if VisibleLines = FoldedLine then 
      begin
        Result := i;
        Exit;
      end;
  end;
  if Result = -1 then
  begin
    if ScriptFolds.Count = 0 then
    begin
      Result := 0; 
      Exit;
    end;
    raise Exception.Create(SUnableToGetRealLineNumberInCodeF);
  end;
end;

procedure Tui.CodeComplete(Command: String; pPosition: Integer);
begin
  if not EnabledCodeCompletion then Exit;
  if Command = 'If' then
  begin
    if EnabledCodeCompletionElse then
    begin
      RenderInsertScript('Else', pPosition +1, True);
      RenderInsertScript('End', pPosition +2, True);
    end
    else
      RenderInsertScript('End', pPosition +1, True);
  end
  else
  if Command = 'Compiler Variable If' then
  begin
    if EnabledCodeCompletionElse then
    begin
      RenderInsertScript('Compiler Variable Else', pPosition +1, True);
      RenderInsertScript('Compiler Variable End', pPosition +2, True);
    end
    else
      RenderInsertScript('Compiler Variable End', pPosition +1, True);
  end
  else
  if Command = 'While' then
    RenderInsertScript('Wend', pPosition +1, True)
  else
  if Command = 'Repeat' then
    RenderInsertScript('Until', pPosition +1, True)
  else
  if Command = 'For Each' then
    RenderInsertScript('Next', pPosition +1, True)
  else
  if Command = 'Wizard Loop' then
    RenderInsertScript('End', pPosition +1, True);
end;

function Tui.EditFunction(Kind, Guid: String): Boolean;
var
  s, sX, sY: String;
  i, j: Integer;
  l: TStringList;
  Wide1, Wide2, Wide3, Wide4, Wide5, Wide6, Wide7, Wide8, Wide9, Wide10: String;
  xList: THashedStringList;
  li: TListItem;
begin
  
  Result := false;
  
  if Kind = 'Install Files' then 
  begin
    scrForceValue := InstallFiles[InstallFiles.IndexOf(Guid) +3];
    WidenColonDelimParam(InstallFiles[InstallFiles.IndexOf(Guid) +2], Wide1, Wide2);
    scrInstallFiles.Recursive.Checked := StrToBool(Wide1);
    scrInstallFiles.Exclude.Text := Wide2;
    
    scrInstallFiles.Source.Text := InstallFiles[InstallFiles.IndexOf(Guid) +1];
    scrInstallFiles.Target.Text := InstallFiles[InstallFiles.IndexOf(Guid) +3];
    scrInstallFiles.ReadOnly.Checked := StrToBool(InstallFiles[InstallFiles.IndexOf(Guid) +4]);
    scrInstallFiles.Hidden.Checked := StrToBool(InstallFiles[InstallFiles.IndexOf(Guid) +5]);
    scrInstallFiles.System.Checked := StrToBool(InstallFiles[InstallFiles.IndexOf(Guid) +6]);
    scrInstallFiles.Vital.Checked := StrToBool(InstallFiles[InstallFiles.IndexOf(Guid) +7]);
    scrInstallFiles.Checksum.Checked := StrToBool(InstallFiles[InstallFiles.IndexOf(Guid) +8]);
    scrInstallFiles.SelfReg.Checked := StrToBool(InstallFiles[InstallFiles.IndexOf(Guid) +9]);
    scrInstallFiles.Shared.Checked := StrToBool(InstallFiles[InstallFiles.IndexOf(Guid) +10]);
    scrInstallFiles.Permanent.Checked := StrToBool(InstallFiles[InstallFiles.IndexOf(Guid) +11]);
    scrInstallFiles.Overwrite.Checked := StrToBool(InstallFiles[InstallFiles.IndexOf(Guid) +12]);
    if scrInstallFiles.ShowModal = mrOk then
    begin
      Result := True;
      InstallFiles[InstallFiles.IndexOf(Guid) +1] := scrInstallFiles.Source.Text;
      InstallFiles[InstallFiles.IndexOf(Guid) +2] := MyBoolToStr(scrInstallFiles.Recursive.Checked, True) + '|' + scrInstallFiles.Exclude.Text;
      InstallFiles[InstallFiles.IndexOf(Guid) +3] := scrInstallFiles.Target.Text;
      InstallFiles[InstallFiles.IndexOf(Guid) +4] := MyBoolToStr(scrInstallFiles.ReadOnly.Checked, True);
      InstallFiles[InstallFiles.IndexOf(Guid) +5] := MyBoolToStr(scrInstallFiles.Hidden.Checked, True);
      InstallFiles[InstallFiles.IndexOf(Guid) +6] := MyBoolToStr(scrInstallFiles.System.Checked, True);
      InstallFiles[InstallFiles.IndexOf(Guid) +7] := MyBoolToStr(scrInstallFiles.Vital.Checked, True);
      InstallFiles[InstallFiles.IndexOf(Guid) +8] := MyBoolToStr(scrInstallFiles.Checksum.Checked, True);
      InstallFiles[InstallFiles.IndexOf(Guid) +9] := MyBoolToStr(scrInstallFiles.SelfReg.Checked, True);
      InstallFiles[InstallFiles.IndexOf(Guid) +10] := MyBoolToStr(scrInstallFiles.Shared.Checked, True);
      InstallFiles[InstallFiles.IndexOf(Guid) +11] := MyBoolToStr(scrInstallFiles.Permanent.Checked, True);
      InstallFiles[InstallFiles.IndexOf(Guid) +12] := MyBoolToStr(scrInstallFiles.Overwrite.Checked, True);
    end;
  end
  else
  if Kind = 'Read from Text File' then 
  begin
    scrForceValue := ReadText[ReadText.IndexOf(Guid) +3];
    scrForceValueX := ReadText[ReadText.IndexOf(Guid) +2];
    scrReadText.Text.Text := ReadText[ReadText.IndexOf(Guid) +1];
    scrReadText.Value.Text := ReadText[ReadText.IndexOf(Guid) +2];
    scrReadText.Variable.Text := ReadText[ReadText.IndexOf(Guid) +3];
    if scrReadText.ShowModal = mrOk then
    begin
      Result := True;
      ReadText[ReadText.IndexOf(Guid) +1] := scrReadText.Text.Text;
      ReadText[ReadText.IndexOf(Guid) +2] := scrReadText.Value.Text;
      ReadText[ReadText.IndexOf(Guid) +3] := scrReadText.Variable.Text;
    end;
  end
  else
  if Kind = 'Write to Text File' then 
  begin
    scrWriteText.Text.Text := WriteText[WriteText.IndexOf(Guid) +1];
    scrWriteText.Value.Text := WriteText[WriteText.IndexOf(Guid) +2];
    scrWriteText.StartFile.Checked := StrToBool(WriteText[WriteText.IndexOf(Guid) +3]);
    scrWriteText.EndFile.Checked := StrToBool(WriteText[WriteText.IndexOf(Guid) +4]);
    if scrWriteText.ShowModal = mrOk then
    begin
      Result := True;
      WriteText[WriteText.IndexOf(Guid) +1] := scrWriteText.Text.Text;
      WriteText[WriteText.IndexOf(Guid) +2] := scrWriteText.Value.Text;
      WriteText[WriteText.IndexOf(Guid) +3] := BoolToStr(scrWriteText.StartFile.Checked);
      WriteText[WriteText.IndexOf(Guid) +4] := BoolToStr(scrWriteText.EndFile.Checked);
    end;
  end
  else
  if Kind = 'Create Folder' then 
  begin
    scrCreateFolder.Folder.Text := CreateFolder[CreateFolder.IndexOf(Guid) +1];
    if scrCreateFolder.ShowModal = mrOk then
    begin
      Result := True;
      CreateFolder[CreateFolder.IndexOf(Guid) +1] := scrCreateFolder.Folder.Text;
    end;
  end
  else
  if Kind = 'Run Program' then 
  begin
    scrForceValue := RunProgram[RunProgram.IndexOf(Guid) +5];
    scrRunProgram.RunProgram.Text := RunProgram[RunProgram.IndexOf(Guid) +1];
    scrRunProgram.HideWindow.Checked := StrToBool(RunProgram[RunProgram.IndexOf(Guid) +2]);
    scrRunProgram.CommandLine.Text := RunProgram[RunProgram.IndexOf(Guid) +3];
    scrRunProgram.WaitFor.Checked := StrToBool(RunProgram[RunProgram.IndexOf(Guid) +4]);
    scrRunProgram.Variable.Text := RunProgram[RunProgram.IndexOf(Guid) +5];
    if scrRunProgram.ShowModal = mrOk then
    begin
      Result := True;
      RunProgram[RunProgram.IndexOf(Guid) +1] := scrRunProgram.RunProgram.Text;
      RunProgram[RunProgram.IndexOf(Guid) +2] := MyBoolToStr(scrRunProgram.HideWindow.Checked, True);
      RunProgram[RunProgram.IndexOf(Guid) +3] := scrRunProgram.CommandLine.Text;
      RunProgram[RunProgram.IndexOf(Guid) +4] := MyBoolToStr(scrRunProgram.WaitFor.Checked, True);
      RunProgram[RunProgram.IndexOf(Guid) +5] := scrRunProgram.Variable.Text;
    end;
  end
  else
  if (Kind = 'Create Shortcut') or (Kind = 'Advertised Shortcut') then 
  begin
    AllowBypass := True;
    scrCreateShortcut.Caption := Kind;
    WidenColonDelimParam(Short[Short.IndexOf(Guid) +3], Wide1, Wide2);
    scrForceValue := Wide1;
    scrCreateShortcut.Location.Text := Wide1;
    if Wide2 <> '' then
      scrCreateShortcut.NoAuto.Checked := StrToBool(Wide2)
    else
      scrCreateShortcut.NoAuto.Checked := false;
    WidenColonDelimParam(Short[Short.IndexOf(Guid) +1], Wide1, Wide2);
    scrCreateShortcut.Target.Text := Wide1;
    if Wide2 <> '' then
      scrCreateShortcut.NoPin.Checked := StrToBool(Wide2)
    else
      scrCreateShortcut.NoPin.Checked := false;
    scrCreateShortcut.Source.Text := Short[Short.IndexOf(Guid) +2];
    scrCreateShortcut.Description.Text := Short[Short.IndexOf(Guid) +4];
    scrCreateShortcut.Params.Text := Short[Short.IndexOf(Guid) +5];
    WidenColonDelimParam(Short[Short.IndexOf(Guid) +6], Wide1, Wide2);
    scrCreateShortcut.Startup.Text := Wide1;
    if Wide2 <> '' then
      scrCreateShortcut.RunAs.Checked := StrToBool(Wide2)
    else
      scrCreateShortcut.RunAs.Checked := false;
    WidenColonDelimParam(Short[Short.IndexOf(Guid) +7], Wide1, Wide2);
    scrCreateShortcut.IconPath.Text := Wide1;
    if Wide2 <> '' then
      scrCreateShortcut.DoNot.Checked := StrToBool(Wide2)
    else
      scrCreateShortcut.DoNot.Checked := false;
    WidenColonDelimParam(Short[Short.IndexOf(Guid) +8], Wide1, Wide2);
    scrCreateShortcut.IconIndex.Text := Wide1;
    scrCreateShortcut.AppUserID.Text := Wide2;
    WidenColonDelimParam(Short[Short.IndexOf(Guid) +9], Wide1, Wide2);
    scrCreateShortcut.PinXP.Checked := Pos('X', Wide2) <> 0;
    scrCreateShortcut.Pin7.Checked := Pos('7', Wide2) <> 0;
    scrCreateShortcut.Pin8.Checked := Pos('8', Wide2) <> 0;
    scrCreateShortcut.WindowSize.ItemIndex := StrToInt(Wide1); 
    AllowBypass := false;
    if scrCreateShortcut.ShowModal = mrOk then
    begin
      Result := True;
      Short[Short.IndexOf(Guid) +1] := scrCreateShortcut.Target.Text + '|' + BoolToStr(scrCreateShortcut.NoPin.Checked);
      Short[Short.IndexOf(Guid) +2] := scrCreateShortcut.Source.Text;
      Short[Short.IndexOf(Guid) +3] := scrCreateShortcut.Location.Text + '|' + BoolToStr(scrCreateShortcut.NoAuto.Checked);
      Short[Short.IndexOf(Guid) +4] := scrCreateShortcut.Description.Text;
      Short[Short.IndexOf(Guid) +5] := scrCreateShortcut.Params.Text;
      Short[Short.IndexOf(Guid) +6] := scrCreateShortcut.Startup.Text + '|' + BoolToStr(scrCreateShortcut.RunAs.Checked);
      Short[Short.IndexOf(Guid) +7] := scrCreateShortcut.IconPath.Text + '|' + BoolToStr(scrCreateShortcut.DoNot.Checked);
      Short[Short.IndexOf(Guid) +8] := scrCreateShortcut.IconIndex.Text + '|' + scrCreateShortcut.AppUserID.Text;
      sY := '';
      if scrCreateShortcut.PinXP.Checked then
        sY := sY + 'X';
      if scrCreateShortcut.Pin7.Checked then
        sY := sY + '7';
      if scrCreateShortcut.Pin8.Checked then
        sY := sY + '8';
      Short[Short.IndexOf(Guid) +9] := IntToStr(scrCreateShortcut.WindowSize.ItemIndex) + '|' + sY;
    end;
  end
  else
  if Kind = 'Set Component Space' then 
  begin
    scrForceValue := SpaceFeatures[SpaceFeatures.IndexOf(Guid) +1];
    scrSpaceComponent.ComponentName.Text := SpaceFeatures[SpaceFeatures.IndexOf(Guid) +1];
    scrSpaceComponent.ComponentSpace.Text := SpaceFeatures[SpaceFeatures.IndexOf(Guid) +2];
    if scrSpaceComponent.ShowModal = mrOk then
    begin
      Result := True;
      SpaceFeatures[SpaceFeatures.IndexOf(Guid) +1] := scrSpaceComponent.ComponentName.Text;
      SpaceFeatures[SpaceFeatures.IndexOf(Guid) +2] := scrSpaceComponent.ComponentSpace.Text;
    end;
  end
  else
  if Kind = 'Define Component' then 
  begin
    scrDefineComponent.ComponentName.Text := DefComponent[DefComponent.IndexOf(Guid) +1];
    scrDefineComponent.Selection.Checked := StrToBool(DefComponent[DefComponent.IndexOf(Guid) +2]);
    SetMemoFlat(scrDefineComponent.Description, DefComponent[DefComponent.IndexOf(Guid) +3]);
    if scrDefineComponent.ShowModal = mrOk then
    begin
      Result := True;
      DefComponent[DefComponent.IndexOf(Guid) +1] := scrDefineComponent.ComponentName.Text;
      DefComponent[DefComponent.IndexOf(Guid) +2] := MyBoolToStr(scrDefineComponent.Selection.Checked, True);
      DefComponent[DefComponent.IndexOf(Guid) +3] := GetMemoFlat(scrDefineComponent.Description);
    end;
  end
  else
  if Kind = 'Set Component State' then 
  begin
    scrForceValue := SetComponent[SetComponent.IndexOf(Guid) +1];
    scrSetComponent.ComponentName.Text := SetComponent[SetComponent.IndexOf(Guid) +1];
    scrSetComponent.Selection.Checked := StrToBool(SetComponent[SetComponent.IndexOf(Guid) +2]);
    if scrSetComponent.ShowModal = mrOk then
    begin
      Result := True;
      SetComponent[SetComponent.IndexOf(Guid) +1] := scrSetComponent.ComponentName.Text;
      SetComponent[SetComponent.IndexOf(Guid) +2] := MyBoolToStr(scrSetComponent.Selection.Checked, True);
    end;
  end
  else
  if Kind = 'Get Component State' then 
  begin
    scrForceValue := GetComponent[GetComponent.IndexOf(Guid) +2];
    scrForceValueX := GetComponent[GetComponent.IndexOf(Guid) +1];
    scrGetComponent.ComponentName.Text := GetComponent[GetComponent.IndexOf(Guid) +1];
    scrGetComponent.State.Text := GetComponent[GetComponent.IndexOf(Guid) +2];
    if scrGetComponent.ShowModal = mrOk then
    begin
      Result := True;
      GetComponent[GetComponent.IndexOf(Guid) +1] := scrGetComponent.ComponentName.Text;
      GetComponent[GetComponent.IndexOf(Guid) +2] := scrGetComponent.State.Text;
    end;
  end
  else
  if Kind = 'Delete Component' then 
  begin
    scrForceValue := DelComp[DelComp.IndexOf(Guid) +1];
    scrDeleteComponent.ComponentName.Text := DelComp[DelComp.IndexOf(Guid) +1];
    if scrDeleteComponent.ShowModal = mrOk then
    begin
      Result := True;
      DelComp[DelComp.IndexOf(Guid) +1] := scrDeleteComponent.ComponentName.Text;
    end;
  end
  else
  if Kind = 'Display Dialog' then 
  begin
    scrForceValue := DisplayDialog[DisplayDialog.IndexOf(Guid) +1];
    scrForceValueX := DisplayDialog[DisplayDialog.IndexOf(Guid) +2];
    scrForceValueY := DisplayDialog[DisplayDialog.IndexOf(Guid) +4];
    scrDisplayDialog.Dialog.Text := DisplayDialog[DisplayDialog.IndexOf(Guid) +1];
    scrDisplayDialog.Variable.Text := DisplayDialog[DisplayDialog.IndexOf(Guid) +2];
    scrDisplayDialog.Modal.Checked := StrToBool(DisplayDialog[DisplayDialog.IndexOf(Guid) +3]);
    scrDisplayDialog.IfVariable.Text := DisplayDialog[DisplayDialog.IndexOf(Guid) +4];
    scrDisplayDialog.vTrue.Checked := StrToBool(DisplayDialog[DisplayDialog.IndexOf(Guid) +5]);
    scrDisplayDialog.vFalse.Checked := StrToBool(DisplayDialog[DisplayDialog.IndexOf(Guid) +6]);
    if scrDisplayDialog.ShowModal = mrOk then
    begin
      Result := True;
      DisplayDialog[DisplayDialog.IndexOf(Guid) +1] := scrDisplayDialog.Dialog.Text;
      DisplayDialog[DisplayDialog.IndexOf(Guid) +2] := scrDisplayDialog.Variable.Text;
      DisplayDialog[DisplayDialog.IndexOf(Guid) +3] := MyBoolToStr(scrDisplayDialog.Modal.Checked, True);
      DisplayDialog[DisplayDialog.IndexOf(Guid) +4] := scrDisplayDialog.IfVariable.Text;
      DisplayDialog[DisplayDialog.IndexOf(Guid) +5] := MyBoolToStr(scrDisplayDialog.vTrue.Checked, True);
      DisplayDialog[DisplayDialog.IndexOf(Guid) +6] := MyBoolToStr(scrDisplayDialog.vFalse.Checked, True);
    end;
  end
  else
  if Kind = 'Comment' then 
  begin
    scrComment.Comment.Text := Comments[Comments.IndexOf(Guid) +1];
    if scrComment.ShowModal = mrOk then
    begin
      Result := True;
      Comments[Comments.IndexOf(Guid) +1] := scrComment.Comment.Text;
    end;
  end
  else
  if Kind = 'MessageBox' then 
  begin
    scrForceValue := xMessageBox[xMessageBox.IndexOf(Guid) +5];
    scrMessageBox.Title.Text := xMessageBox[xMessageBox.IndexOf(Guid) +1];
    SetMemoFlat(scrMessageBox.Message, xMessageBox[xMessageBox.IndexOf(Guid) +2]);
    mscrMessageBox.IconItemIndex := StrToInt(xMessageBox[xMessageBox.IndexOf(Guid) +3]);
    scrMessageBox.Buttons.ItemIndex := StrToInt(xMessageBox[xMessageBox.IndexOf(Guid) +4]);
    scrMessageBox.Variable.Text := xMessageBox[xMessageBox.IndexOf(Guid) +5];
    if scrMessageBox.ShowModal = mrOk then
    begin
      Result := True;
      xMessageBox[xMessageBox.IndexOf(Guid) +1] := scrMessageBox.Title.Text;
      xMessageBox[xMessageBox.IndexOf(Guid) +2] := GetMemoFlat(scrMessageBox.Message);
      xMessageBox[xMessageBox.IndexOf(Guid) +3] := IntToStr(mscrMessageBox.IconItemIndex);
      xMessageBox[xMessageBox.IndexOf(Guid) +4] := IntToStr(scrMessageBox.Buttons.ItemIndex);
      xMessageBox[xMessageBox.IndexOf(Guid) +5] := scrMessageBox.Variable.Text;
    end;
  end
  else
  if Kind = 'Set Variable' then 
  begin
    sX := SetVariable[SetVariable.IndexOf(Guid) + 1];
    if Pos('$MYAH$MYAH$', sX) <> 0 then 
    begin
      Delete(sX, 1, Pos('$MYAH$MYAH$', sX) + Length('$MYAH$MYAH$') -1); 
      scrSetVariable.Persist.Checked := MyStrToBool(sX); 
      sX := SetVariable[SetVariable.IndexOf(Guid) + 1];
      Delete(sX, Pos('$MYAH$MYAH$', sX), Length(sX)); 
      scrForceValue := sX;
    end
    else
    begin
      scrSetVariable.Persist.Checked := false;
      scrForceValue := sX;
    end;
    
    scrSetVariable.Variable.Text := scrForceValue;
    scrSetVariable.Value.Text := SetVariable[SetVariable.IndexOf(Guid) + 2];
    if scrSetVariable.ShowModal = mrOk then
    begin
      Result := True;
      if scrSetVariable.Persist.Checked then
        sX := 'TRUE' 
      else
        sX := 'FALSE'; 
      SetVariable[SetVariable.IndexOf(Guid) +1] := scrSetVariable.Variable.Text
        + '$MYAH$MYAH$' + sX; 
      SetVariable[SetVariable.IndexOf(Guid) +2] := scrSetVariable.Value.Text;
    end;
  end
  else
  if (((Kind = 'If') or (Kind = 'Else If')) or ((Kind = 'Compiler Variable If') or (Kind = 'While'))) or
    (Kind = 'Until') then 
  begin
    if Kind = 'While' then
      xList := xWhile
    else
    if Kind = 'Until' then
      xList := xUntil
    else
      xList := xIf;
    if Kind = 'Compiler Variable If' then
      scrIf.Comparison.Items.Delete(scrIf.Comparison.Items.Count -1);
    scrIf.Caption := Kind;
    scrForceValue := xList[xList.IndexOf(Guid) +1];
    scrIf.Variable.Text := xList[xList.IndexOf(Guid) +1];
    scrIf.Comparison.ItemIndex := StrToInt(xList[xList.IndexOf(Guid) +2]);
    scrIf.CompareWith.Text := xList[xList.IndexOf(Guid) +3];
    scrIf.notCheck.Checked := StrToBool(xList[xList.IndexOf(Guid) +4]);
    if Kind = 'While' then
      scrIf.notCheck.Caption := 'Reverse Comparison (While &Not)'
    else
    if Kind = 'Until' then
      scrIf.notCheck.Caption := 'Reverse Comparison (Until &Not)'
    else
      scrIf.notCheck.Caption := 'Reverse Comparison (If &Not)';
    if scrIf.ShowModal = mrOk then
    begin
      Result := True;
      xList[xList.IndexOf(Guid) +1] := scrIf.Variable.Text;
      xList[xList.IndexOf(Guid) +2] := IntToStr(scrIf.Comparison.ItemIndex);
      xList[xList.IndexOf(Guid) +3] := scrIf.CompareWith.Text;
      xList[xList.IndexOf(Guid) +4] := MyBoolToStr(scrIf.notCheck.Checked, True);
    end;
    if Kind = 'Compiler Variable If' then
      scrIf.Comparison.Items.Add('Greater Than (Version)');
  end
  else
  if Kind = 'Include Script' then 
  begin
    WidenColonDelimParam(xInclude[xInclude.IndexOf(Guid) +1], Wide1, Wide2);
    scrForceValue := Wide1;
    scrForceValueX := Wide2;
    scrInclude.Script.Text := Wide1;
    scrInclude.Variable.Text := Wide2;
    if scrInclude.ShowModal = mrOk then
    begin
      Result := True;
      xInclude[xInclude.IndexOf(Guid) +1] := scrInclude.Script.Text + '|' + scrInclude.Variable.Text;
    end;
  end
  else
  if Kind = 'Label' then 
  begin
    scrLabel.eLabel.Text := eLabel[eLabel.IndexOf(Guid) +1];
    if scrLabel.ShowModal = mrOk then
    begin
      Result := True;
      eLabel[eLabel.IndexOf(Guid) +1] := scrLabel.eLabel.Text;
    end;
  end
  else
  if Kind = 'GoTo Label' then 
  begin
    scrForceValue := gLabel[gLabel.IndexOf(Guid) +1];
    scrGotoLabel.gLabelEx.Text := gLabel[gLabel.IndexOf(Guid) +1];
    if scrGotoLabel.ShowModal = mrOk then
    begin
      Result := True;
      gLabel[gLabel.IndexOf(Guid) +1] := scrGotoLabel.gLabelEx.Text;
    end;
  end
  else
  if Kind = 'Get Folder Location' then 
  begin
    scrForceValue := GetFolderLocation[GetFolderLocation.IndexOf(Guid) +1];
    scrGetFolderLocation.Variable.Text := GetFolderLocation[GetFolderLocation.IndexOf(Guid) +1];
    
      scrGetFolderLocation.Folder.ItemIndex := StrToInt(GetFolderLocation[GetFolderLocation.IndexOf(Guid) +2]);
    scrGetFolderLocation.AllUsers.Checked := StrToBool(GetFolderLocation[GetFolderLocation.IndexOf(Guid) +3]);
    if scrGetFolderLocation.ShowModal = mrOk then
    begin
      Result := True;
      GetFolderLocation[GetFolderLocation.IndexOf(Guid) +1] := scrGetFolderLocation.Variable.Text;
      GetFolderLocation[GetFolderLocation.IndexOf(Guid) +2] := IntToStr(scrGetFolderLocation.Folder.ItemIndex);
      GetFolderLocation[GetFolderLocation.IndexOf(Guid) +3] := MyBoolToStr(scrGetFolderLocation.AllUsers.Checked, True);
    end;
  end
  else
  if Kind = 'Apply Changes' then 
  begin
    scrForceValue := ApplyChanges[ApplyChanges.IndexOf(Guid) +2];
    scrApplyChanges.Dialog.Text := ApplyChanges[ApplyChanges.IndexOf(Guid) +1];
    scrApplyChanges.Variable.Text := ApplyChanges[ApplyChanges.IndexOf(Guid) +2];
    scrApplyChanges.Install.Checked := StrToBool(ApplyChanges[ApplyChanges.IndexOf(Guid) +3]);
    scrApplyChanges.Uninstall.Checked := StrToBool(ApplyChanges[ApplyChanges.IndexOf(Guid) +4]);
    scrApplyChanges.Advertise.Checked := (not scrApplyChanges.Install.Checked) and (not scrApplyChanges.Uninstall.Checked);
    if scrApplyChanges.ShowModal = mrOk then
    begin
      Result := True;
      ApplyChanges[ApplyChanges.IndexOf(Guid) +1] := scrApplyChanges.Dialog.Text;
      ApplyChanges[ApplyChanges.IndexOf(Guid) +2] := scrApplyChanges.Variable.Text;
      ApplyChanges[ApplyChanges.IndexOf(Guid) +3] := MyBoolToStr(scrApplyChanges.Install.Checked, True);
      ApplyChanges[ApplyChanges.IndexOf(Guid) +4] := MyBoolToStr(scrApplyChanges.Uninstall.Checked, True);
    end;
  end
  else
  if Kind = 'Download File' then 
  begin
    scrForceValue := DownloadFile[DownloadFile.IndexOf(Guid) +3];;
    scrDownload.URL.Text := DownloadFile[DownloadFile.IndexOf(Guid) +1];
    scrDownload.Local.Text := DownloadFile[DownloadFile.IndexOf(Guid) +2];
    scrDownload.Variable.Text := DownloadFile[DownloadFile.IndexOf(Guid) +3];
    scrDownload.Server.Text := DownloadFile[DownloadFile.IndexOf(Guid) +4];
    scrDownload.Port.Text := DownloadFile[DownloadFile.IndexOf(Guid) +5];
    scrDownload.Resume.Checked := StrToBool(DownloadFile[DownloadFile.IndexOf(Guid) +6]);
    if scrDownload.ShowModal = mrOk then
    begin
      Result := True;
      DownloadFile[DownloadFile.IndexOf(Guid) +1] := scrDownload.URL.Text;
      DownloadFile[DownloadFile.IndexOf(Guid) +2] := scrDownload.Local.Text;
      DownloadFile[DownloadFile.IndexOf(Guid) +3] := scrDownload.Variable.Text;
      DownloadFile[DownloadFile.IndexOf(Guid) +4] := scrDownload.Server.Text;
      DownloadFile[DownloadFile.IndexOf(Guid) +5] := scrDownload.Port.Text;
      DownloadFile[DownloadFile.IndexOf(Guid) +6] := MyBoolToStr(scrDownload.Resume.Checked, True);
    end;
  end
  else
  if Kind = 'File Bag' then 
  begin
    scrForceValue := FileBag[FileBag.IndexOf(Guid) +4];;
    scrFileBag.Bag.Text := FileBag[FileBag.IndexOf(Guid) +1];
    scrFileBag.Subfolder.Checked := StrToBool(FileBag[FileBag.IndexOf(Guid) +2]);
    scrFileBag.Exclude.Text := FileBag[FileBag.IndexOf(Guid) +3];
    scrFileBag.Variable.Text := FileBag[FileBag.IndexOf(Guid) +4];
    if scrFileBag.ShowModal = mrOk then
    begin
      Result := True;
      FileBag[FileBag.IndexOf(Guid) +1] := scrFileBag.Bag.Text;
      FileBag[FileBag.IndexOf(Guid) +2] := MyBoolToStr(scrFileBag.Subfolder.Checked);
      FileBag[FileBag.IndexOf(Guid) +3] := scrFileBag.Exclude.Text;
      FileBag[FileBag.IndexOf(Guid) +4] := scrFileBag.Variable.Text;
    end;
  end
  else
  if Kind = 'Web Media Block' then 
  begin
    WidenColonDelimParam(MediaBlock[MediaBlock.IndexOf(Guid) +3], Wide1, Wide2, '$MYAH_CARET$'); 
    scrWebMediaBlock.BlockName.Text := MediaBlock[MediaBlock.IndexOf(Guid) +1];
    SetMemoFlat(scrWebMediaBlock.DownURL, MediaBlock[MediaBlock.IndexOf(Guid) +2]);
    scrWebMediaBlock.Skip.Checked := StrToBool(Wide1);
    scrWebMediaBlock.Password.Text := Wide2;
    if scrWebMediaBlock.ShowModal = mrOk then
    begin
      Result := True;
      MediaBlock[MediaBlock.IndexOf(Guid) +1] := scrWebMediaBlock.BlockName.Text;
      MediaBlock[MediaBlock.IndexOf(Guid) +2] := GetMemoFlat(scrWebMediaBlock.DownURL);
      MediaBlock[MediaBlock.IndexOf(Guid) +3] := BoolToStr(scrWebMediaBlock.Skip.Checked)
        + '$MYAH_CARET$' + scrWebMediaBlock.Password.Text; 
    end;
  end
  else
  if Kind = 'Delete Files Recursive' then 
  begin
    scrDeleteFilesRecursive.Path.Text := DeleteRec[DeleteRec.IndexOf(Guid) +1];
    if scrDeleteFilesRecursive.ShowModal = mrOk then
    begin
      Result := True;
      DeleteRec[DeleteRec.IndexOf(Guid) +1] := scrDeleteFilesRecursive.Path.Text;
    end;
  end
  else
  if Kind = 'Delete Files' then 
  begin
    scrDeleteFiles.Folder.Text := DeleteFiles[DeleteFiles.IndexOf(Guid) +1];
    scrDeleteFiles.Files.Text := DeleteFiles[DeleteFiles.IndexOf(Guid) +2];
    scrDeleteFiles.Installing.Checked := StrToBool(DeleteFiles[DeleteFiles.IndexOf(Guid) +3]);
    scrDeleteFiles.Uninstalling.Checked := StrToBool(DeleteFiles[DeleteFiles.IndexOf(Guid) +4]);
    if scrDeleteFiles.ShowModal = mrOk then
    begin
      Result := True;
      DeleteFiles[DeleteFiles.IndexOf(Guid) +1] := scrDeleteFiles.Folder.Text;
      DeleteFiles[DeleteFiles.IndexOf(Guid) +2] := scrDeleteFiles.Files.Text;
      DeleteFiles[DeleteFiles.IndexOf(Guid) +3] := BoolToStr(scrDeleteFiles.Installing.Checked);
      DeleteFiles[DeleteFiles.IndexOf(Guid) +4] := BoolToStr(scrDeleteFiles.Uninstalling.Checked);
    end;
  end
  else
  if Kind = 'Remove Directory' then 
  begin
    scrRmDir.Path.Text := RmDir[RmDir.IndexOf(Guid) +1];
    if scrRmDir.ShowModal = mrOk then
    begin
      Result := True;
      RmDir[RmDir.IndexOf(Guid) +1] := scrRmDir.Path.Text;
    end;
  end
  else
  if Kind = 'Create Link' then 
  begin
    scrCreateLink.Source.Text := CreateLink[CreateLink.IndexOf(Guid) +1];
    scrCreateLink.Target.Text := CreateLink[CreateLink.IndexOf(Guid) +2];
    scrCreateLink.Soft.Checked := StrToBool(CreateLink[CreateLink.IndexOf(Guid) +3]);
    scrCreateLink.Hard.Checked := StrToBool(CreateLink[CreateLink.IndexOf(Guid) +4]);
    scrCreateLink.Shared.Checked := StrToBool(CreateLink[CreateLink.IndexOf(Guid) +5]);
    if scrCreateLink.ShowModal = mrOk then
    begin
      Result := True;
      CreateLink[CreateLink.IndexOf(Guid) +1] := scrCreateLink.Source.Text;
      CreateLink[CreateLink.IndexOf(Guid) +2] := scrCreateLink.Target.Text;
      CreateLink[CreateLink.IndexOf(Guid) +3] := BoolToStr(scrCreateLink.Soft.Checked);
      CreateLink[CreateLink.IndexOf(Guid) +4] := BoolToStr(scrCreateLink.Hard.Checked);
      CreateLink[CreateLink.IndexOf(Guid) +5] := BoolToStr(scrCreateLink.Shared.Checked);
    end;
  end
  else
  if Kind = 'Mathematics' then 
  begin
    scrMathematics.Operand1.Text := Maths[Maths.IndexOf(Guid) +1];
    scrMathematics.Operand2.Text := Maths[Maths.IndexOf(Guid) +2];
    scrMathematics.Operation.ItemIndex := StrToInt(Maths[Maths.IndexOf(Guid) +3]);
    scrMathematics.Variable.Text := Maths[Maths.IndexOf(Guid) +4];
    scrForceValue := scrMathematics.Variable.Text;
    if scrMathematics.ShowModal = mrOk then
    begin
      Result := True;
      Maths[Maths.IndexOf(Guid) +1] := scrMathematics.Operand1.Text;
      Maths[Maths.IndexOf(Guid) +2] := scrMathematics.Operand2.Text;
      Maths[Maths.IndexOf(Guid) +3] := IntToStr(scrMathematics.Operation.ItemIndex);
      Maths[Maths.IndexOf(Guid) +4] := scrMathematics.Variable.Text;
    end;
  end
  else
  if Kind = 'Parse String' then 
  begin
    scrForceValue := Parse[Parse.IndexOf(Guid) +3];
    scrForceValueX := Parse[Parse.IndexOf(Guid) +4];
    scrParseString.ParseString.Text := Parse[Parse.IndexOf(Guid) +1];
    scrParseString.SmartPosition.Text := Parse[Parse.IndexOf(Guid) +2];
    scrParseString.FirstVar.Text := Parse[Parse.IndexOf(Guid) +3];
    scrParseString.SecondVar.Text := Parse[Parse.IndexOf(Guid) +4];
    scrParseString.Operation.ItemIndex := StrToInt(Parse[Parse.IndexOf(Guid) +5]);
    scrParseString.Trim.Checked := StrToBool(Parse[Parse.IndexOf(Guid) +6]);
    scrParseString.Ignore.Checked := StrToBool(Parse[Parse.IndexOf(Guid) +7]);
    if scrParseString.ShowModal = mrOk then
    begin
      Result := True;
      Parse[Parse.IndexOf(Guid) +1] := scrParseString.ParseString.Text;
      Parse[Parse.IndexOf(Guid) +2] := scrParseString.SmartPosition.Text;
      Parse[Parse.IndexOf(Guid) +3] := scrParseString.FirstVar.Text;
      Parse[Parse.IndexOf(Guid) +4] := scrParseString.SecondVar.Text;
      Parse[Parse.IndexOf(Guid) +5] := IntToStr(scrParseString.Operation.ItemIndex);
      Parse[Parse.IndexOf(Guid) +6] := BoolToStr(scrParseString.Trim.Checked);
      Parse[Parse.IndexOf(Guid) +7] := BoolToStr(scrParseString.Ignore.Checked);
    end;
  end
  else
  if (Kind = 'Create File Type') or (Kind = 'Advertised File Type') then 
  begin
    scrCreateFileType.Caption := Kind;
    WidenColonDelimParam(FileType[FileType.IndexOf(Guid) +1], Wide7, Wide8);
    scrCreateFileType.FileType.Text := Wide7;
    if Wide8 = '' then Wide8 := 'FALSE';
    scrCreateFileType.OpenWithProgIDs.Checked := StrToBool(Wide8);
    WidenColonDelimParam(FileType[FileType.IndexOf(Guid) +2], Wide9, Wide10);
    scrCreateFileType.OpensWith.Text := Wide9;
    if Wide10 = '' then Wide10 := 'FALSE';
    scrCreateFileType.UserChoice.Checked := StrToBool(Wide10);
    WidenColonDelimParam(FileType[FileType.IndexOf(Guid) +3], Wide1, Wide2);
    scrCreateFileType.Description.Text := Wide1;
    if Wide2 = '' then Wide2 := 'TRUE';
    scrCreateFileType.Default.Checked := StrToBool(Wide2);
    WidenColonDelimParam(FileType[FileType.IndexOf(Guid) +4], Wide3, Wide4);
    scrCreateFileType.IconFile.Text := Wide3;
    if Wide4 = '' then Wide4 := 'FALSE';
    scrCreateFileType.AllUsers.Checked := StrToBool(Wide4);
    WidenColonDelimParam(FileType[FileType.IndexOf(Guid) +5], Wide5, Wide6);
    scrCreateFileType.IconNumber.Text := Wide5;
    if Wide6 = '' then Wide6 := 'FALSE';
    scrCreateFileType.CurrentUser.Checked := StrToBool(Wide6);
    scrCreateFileType.ExtensionsList.Items.CommaText := FileType[FileType.IndexOf(Guid) +6];
    
    FlatBuffer := FileType[FileType.IndexOf(Guid) +7];
    if scrCreateFileType.ShowModal = mrOk then
    begin
      Result := True;
      FileType[FileType.IndexOf(Guid) +1] := scrCreateFileType.FileType.Text + '|' + BoolToStr(scrCreateFileType.OpenWithProgIDs.Checked);
      FileType[FileType.IndexOf(Guid) +2] := scrCreateFileType.OpensWith.Text + '|' + BoolToStr(scrCreateFileType.UserChoice.Checked);
      FileType[FileType.IndexOf(Guid) +3] := scrCreateFileType.Description.Text + '|' + BoolToStr(scrCreateFileType.Default.Checked);
      FileType[FileType.IndexOf(Guid) +4] := scrCreateFileType.IconFile.Text + '|' + BoolToStr(scrCreateFileType.AllUsers.Checked);
      FileType[FileType.IndexOf(Guid) +5] := scrCreateFileType.IconNumber.Text + '|' + BoolToStr(scrCreateFileType.CurrentUser.Checked);
      FileType[FileType.IndexOf(Guid) +6] := scrCreateFileType.ExtensionsList.Items.CommaText;
      
      FileType[FileType.IndexOf(Guid) +7] := FlatBuffer;
    end;
  end
  else
  if Kind = 'Code Folding Region' then 
  begin
    CurrentRegionName := Region[Region.IndexOf(Guid) +2];
    CurrentFoldStatus := StrToBool(Region[Region.IndexOf(Guid) +1]) and
      (FoldList.IndexOf(CurrentRegionName) <> -1);
    if not StrToBool(Region[Region.IndexOf(Guid) +1]) then
      CurrentRegionName := '';
    scrRegion.DefineRegion.Checked := StrToBool(Region[Region.IndexOf(Guid) +1]);
    scrRegion.Region.Text := CurrentRegionName;
    scrRegion.CloseRegion.Checked := not scrRegion.DefineRegion.Checked;
    if scrRegion.ShowModal = mrOk then
    begin
      if (scrRegion.DefineRegion.Checked and
      (FoldList.IndexOf(CurrentRegionName) <> -1)) <> CurrentFoldStatus then
        
        ProcessCodeFolding(GetRealLineNumber(Script.ItemIndex));
      Result := True;
      Region[Region.IndexOf(Guid) +1] := BoolToStr(scrRegion.DefineRegion.Checked);
      Region[Region.IndexOf(Guid) +2] := scrRegion.Region.Text;
      if not scrRegion.DefineRegion.Checked then
        Region[Region.IndexOf(Guid) +2] := '';
      if CurrentRegionName <> '' then
        if FoldList.IndexOf(CurrentRegionName) <> -1 then
          FoldList[FoldList.IndexOf(CurrentRegionName)] :=
            Region[Region.IndexOf(Guid) +2];
    end;
  end
  else
  if Kind = 'Set Access Control' then 
  begin
    WidenColonDelimParam(ACL[ACL.IndexOf(Guid) +8], Wide1, Wide2);
    scrAccessControl.ObjectPath.Text := ACL[ACL.IndexOf(Guid) +1];
    scrAccessControl.Everyone.Checked := StrToBool(ACL[ACL.IndexOf(Guid) +2]);
    scrAccessControl.Current.Checked := StrToBool(ACL[ACL.IndexOf(Guid) +3]);
    scrAccessControl.Authenticated.Checked := StrToBool(ACL[ACL.IndexOf(Guid) +4]);
    scrAccessControl.Named.Checked := StrToBool(ACL[ACL.IndexOf(Guid) +5]);
    scrAccessControl.Account.Text := ACL[ACL.IndexOf(Guid) +6];
    scrAccessControl.arRead.Checked := StrToBool(ACL[ACL.IndexOf(Guid) +7]);
    scrAccessControl.arWrite.Checked := StrToBool(Wide1);
    if Wide2 <> '' then
      scrAccessControl.arExec.Checked := StrToBool(Wide2)
    else
      scrAccessControl.arExec.Checked := false;
    scrAccessControl.SetAccounts.Checked := StrToBool(ACL[ACL.IndexOf(Guid) +9]);
    scrAccessControl.PurgeAll.Checked := StrToBool(ACL[ACL.IndexOf(Guid) +10]);
    scrAccessControl.GrantAll.Checked := StrToBool(ACL[ACL.IndexOf(Guid) +11]);
    scrAccessControl.FileSystem.Checked := StrToBool(ACL[ACL.IndexOf(Guid) +12]);
    scrAccessControl.Share.Checked := StrToBool(ACL[ACL.IndexOf(Guid) +13]);
    scrAccessControl.Registry.Checked := StrToBool(ACL[ACL.IndexOf(Guid) +14]);
    scrAccessControl.Service.Checked := StrToBool(ACL[ACL.IndexOf(Guid) +15]);
    scrAccessControl.Printer.Checked := StrToBool(ACL[ACL.IndexOf(Guid) +16]);
    if scrAccessControl.ShowModal = mrOk then
    begin
      Result := True;
      ACL[ACL.IndexOf(Guid) +1] := scrAccessControl.ObjectPath.Text;
      ACL[ACL.IndexOf(Guid) +2] := BoolToStr(scrAccessControl.Everyone.Checked);
      ACL[ACL.IndexOf(Guid) +3] := BoolToStr(scrAccessControl.Current.Checked);
      ACL[ACL.IndexOf(Guid) +4] := BoolToStr(scrAccessControl.Authenticated.Checked);
      ACL[ACL.IndexOf(Guid) +5] := BoolToStr(scrAccessControl.Named.Checked);
      ACL[ACL.IndexOf(Guid) +6] := scrAccessControl.Account.Text;
      ACL[ACL.IndexOf(Guid) +7] := BoolToStr(scrAccessControl.arRead.Checked);
      ACL[ACL.IndexOf(Guid) +8] := BoolToStr(scrAccessControl.arWrite.Checked)
        + '|' + BoolToStr(scrAccessControl.arExec.Checked);
      ACL[ACL.IndexOf(Guid) +9] := BoolToStr(scrAccessControl.SetAccounts.Checked);
      ACL[ACL.IndexOf(Guid) +10] := BoolToStr(scrAccessControl.PurgeAll.Checked);
      ACL[ACL.IndexOf(Guid) +11] := BoolToStr(scrAccessControl.GrantAll.Checked);
      ACL[ACL.IndexOf(Guid) +12] := BoolToStr(scrAccessControl.FileSystem.Checked);
      ACL[ACL.IndexOf(Guid) +13] := BoolToStr(scrAccessControl.Share.Checked);
      ACL[ACL.IndexOf(Guid) +14] := BoolToStr(scrAccessControl.Registry.Checked);
      ACL[ACL.IndexOf(Guid) +15] := BoolToStr(scrAccessControl.Service.Checked);
      ACL[ACL.IndexOf(Guid) +16] := BoolToStr(scrAccessControl.Printer.Checked);
    end;
  end
  else
  if Kind = 'Set Owner' then 
  begin
    scrSetOwner.ObjectPath.Text := Own[Own.IndexOf(Guid) +1];
    scrSetOwner.Current.Checked := StrToBool(Own[Own.IndexOf(Guid) +2]);
    scrSetOwner.Root.Checked := StrToBool(Own[Own.IndexOf(Guid) +3]);
    scrSetOwner.Named.Checked := StrToBool(Own[Own.IndexOf(Guid) +4]);
    scrSetOwner.Account.Text := Own[Own.IndexOf(Guid) +5];
    if scrSetOwner.ShowModal = mrOk then
    begin
      Result := True;
      Own[Own.IndexOf(Guid) +1] := scrSetOwner.ObjectPath.Text;
      Own[Own.IndexOf(Guid) +2] := BoolToStr(scrSetOwner.Current.Checked);
      Own[Own.IndexOf(Guid) +3] := BoolToStr(scrSetOwner.Root.Checked);
      Own[Own.IndexOf(Guid) +4] := BoolToStr(scrSetOwner.Named.Checked);
      Own[Own.IndexOf(Guid) +5] := scrSetOwner.Account.Text;
    end;
  end
  else
  if Kind = 'Set Group' then 
  begin
    scrSetGroup.ObjectPath.Text := Grp[Grp.IndexOf(Guid) +1];
    scrSetGroup.GroupName.Text := Grp[Grp.IndexOf(Guid) +2];
    if scrSetGroup.ShowModal = mrOk then
    begin
      Result := True;
      Grp[Grp.IndexOf(Guid) +1] := scrSetGroup.ObjectPath.Text;
      Grp[Grp.IndexOf(Guid) +2] := scrSetGroup.GroupName.Text;
    end;
  end
  else
  if Kind = 'Get File Version' then 
  begin
    scrForceValue := GetVers[GetVers.IndexOf(Guid) +2];
    scrGetFileVersion.FilePath.Text := GetVers[GetVers.IndexOf(Guid) +1];
    scrGetFileVersion.Variable.Text := GetVers[GetVers.IndexOf(Guid) +2];
    if scrGetFileVersion.ShowModal = mrOk then
    begin
      Result := True;
      GetVers[GetVers.IndexOf(Guid) +1] := scrGetFileVersion.FilePath.Text;
      GetVers[GetVers.IndexOf(Guid) +2] := scrGetFileVersion.Variable.Text;
    end;
  end
  else
  if Kind = 'Check File Version' then 
  begin
    scrForceValue := CheckVersion[CheckVersion.IndexOf(Guid) +1];
    scrCheckFileVersion.Variable.Text := CheckVersion[CheckVersion.IndexOf(Guid) +1];
    scrCheckFileVersion.File1.Text := CheckVersion[CheckVersion.IndexOf(Guid) +2];
    scrCheckFileVersion.WithFile.Checked := StrToBool(CheckVersion[CheckVersion.IndexOf(Guid) +3]);
    scrCheckFileVersion.WithVersion.Checked := not StrToBool(CheckVersion[CheckVersion.IndexOf(Guid) +3]);
    scrCheckFileVersion.File2.Text := CheckVersion[CheckVersion.IndexOf(Guid) +4];
    scrCheckFileVersion.Text.Text := CheckVersion[CheckVersion.IndexOf(Guid) +5];
    if scrCheckFileVersion.ShowModal = mrOk then
    begin
      Result := True;
      CheckVersion[CheckVersion.IndexOf(Guid) +1] := scrCheckFileVersion.Variable.Text;
      CheckVersion[CheckVersion.IndexOf(Guid) +2] := scrCheckFileVersion.File1.Text;
      CheckVersion[CheckVersion.IndexOf(Guid) +3] := BoolToStr(scrCheckFileVersion.WithFile.Checked);
      CheckVersion[CheckVersion.IndexOf(Guid) +4] := scrCheckFileVersion.File2.Text;
      CheckVersion[CheckVersion.IndexOf(Guid) +5] := scrCheckFileVersion.Text.Text;
    end;
  end
  else
  if Kind = 'For Each' then
  begin
    scrForEach.Element.Text := xForEach[xForEach.IndexOf(Guid) +1];
    scrForEach.Separator.Text := xForEach[xForEach.IndexOf(Guid) +2];
    scrForEach.Collection.Text := xForEach[xForEach.IndexOf(Guid) +3];
    if scrForEach.ShowModal = mrOk then
    begin
      Result := True;
      xForEach[xForEach.IndexOf(Guid) +1] := scrForEach.Element.Text;
      xForEach[xForEach.IndexOf(Guid) +2] := scrForEach.Separator.Text;
      xForEach[xForEach.IndexOf(Guid) +3] := scrForEach.Collection.Text;
    end;
  end
  else
  if Kind = 'Sleep' then
  begin
    scrSleep.Duration.Value := StrToInt(xSleep[xSleep.IndexOf(Guid) +1]);
    if scrSleep.ShowModal = mrOk then
    begin
      Result := True;
      xSleep[xSleep.IndexOf(Guid) +1] := IntToStr(scrSleep.Duration.Value);
    end;
  end
  else
  if Kind = 'Terminate with Exit Code' then 
  begin
    scrTerminateWithExitCode.ExitCode.Text := TermExitCode[TermExitCode.IndexOf(Guid) +1];
    if scrTerminateWithExitCode.ShowModal = mrOk then
    begin
      Result := True;
      TermExitCode[TermExitCode.IndexOf(Guid) +1] := scrTerminateWithExitCode.ExitCode.Text;
    end;
  end
  else
  if Kind = 'Convert Path' then 
  begin
    scrForceValue := ConvertPath[ConvertPath.IndexOf(Guid) +1];
    scrConvertPath.Variable.Text := ConvertPath[ConvertPath.IndexOf(Guid) +1];
    scrConvertPath.ShortPath.Checked := StrToBool(ConvertPath[ConvertPath.IndexOf(Guid) +2]);
    scrConvertPath.LongPath.Checked := not StrToBool(ConvertPath[ConvertPath.IndexOf(Guid) +2]);
    if scrConvertPath.ShowModal = mrOk then
    begin
      Result := True;
      ConvertPath[ConvertPath.IndexOf(Guid) +1] := scrConvertPath.Variable.Text;
      ConvertPath[ConvertPath.IndexOf(Guid) +2] := BoolToStr(scrConvertPath.ShortPath.Checked);
    end;
  end
  else
  if Kind = 'Convert Case' then 
  begin
    scrForceValue := ConvertCase[ConvertCase.IndexOf(Guid) +1];
    scrConvertCase.Variable.Text := ConvertCase[ConvertCase.IndexOf(Guid) +1];
    scrConvertCase.Upper.Checked := StrToBool(ConvertCase[ConvertCase.IndexOf(Guid) +2]);
    scrconvertcase.Lower.Checked := not StrToBool(ConvertCase[ConvertCase.IndexOf(Guid) +2]);
    if scrConvertCase.ShowModal = mrOk then
    begin
      Result := True;
      ConvertCase[ConvertCase.IndexOf(Guid) +1] := scrConvertCase.Variable.Text;
      ConvertCase[ConvertCase.IndexOf(Guid) +2] := BoolToStr(scrConvertCase.Upper.Checked);
    end;
  end
  else
  if Kind = 'Evaluate Expression' then 
  begin
    scrForceValue := Eval[Eval.IndexOf(Guid) +2];
    scrEvaluate.Expression.Text := Eval[Eval.IndexOf(Guid) +1];
    scrEvaluate.Variable.Text := Eval[Eval.IndexOf(Guid) +2];
    if scrEvaluate.ShowModal = mrOk then
    begin
      Result := True;
      Eval[Eval.IndexOf(Guid) +1] := scrEvaluate.Expression.Text;
      Eval[Eval.IndexOf(Guid) +2] := scrEvaluate.Variable.Text;
    end;
  end
  else
  if Kind = 'Extract Path' then 
  begin
    scrForceValue := ExtractPath[ExtractPath.IndexOf(Guid) +1];
    scrExtractPath.Variable.Text := ExtractPath[ExtractPath.IndexOf(Guid) +1];
    scrExtractPath.Operation.ItemIndex := StrToInt(ExtractPath[ExtractPath.IndexOf(Guid) +2]);
    if scrExtractPath.ShowModal = mrOk then
    begin
      Result := True;
      ExtractPath[ExtractPath.IndexOf(Guid) +1] := scrExtractPath.Variable.Text;
      ExtractPath[ExtractPath.IndexOf(Guid) +2] := IntToStr(scrExtractPath.Operation.ItemIndex);
    end;
  end
  else
  if Kind = 'Format String' then
  begin
    scrFormatStr.Variable.Text := FormatStr[FormatStr.IndexOf(Guid) +1];
    scrFormatStr.Format.Text := FormatStr[FormatStr.IndexOf(Guid) +2];
    scrFormatStr.Literal.Text := FormatStr[FormatStr.IndexOf(Guid) +3];
    scrForceValue := FormatStr[FormatStr.IndexOf(Guid) +1];
    if scrFormatStr.ShowModal = mrOk then
    begin
      Result := True;
      FormatStr[FormatStr.IndexOf(Guid) +1] := scrFormatStr.Variable.Text;
      FormatStr[FormatStr.IndexOf(Guid) +2] := scrFormatStr.Format.Text;
      FormatStr[FormatStr.IndexOf(Guid) +3] := scrFormatStr.Literal.Text;
    end;
  end
  else
  if Kind = 'Get String Length' then
  begin
    scrGetStrLen.Literal.Text := GetStrLen[GetStrLen.IndexOf(Guid) +1];
    scrGetStrLen.Variable.Text := GetStrLen[GetStrLen.IndexOf(Guid) +2];
    scrForceValue := GetStrLen[GetStrLen.IndexOf(Guid) +2];
    if scrGetStrLen.ShowModal = mrOk then
    begin
      Result := True;
      GetStrLen[GetStrLen.IndexOf(Guid) +1] := scrGetStrLen.Literal.Text;
      GetStrLen[GetStrLen.IndexOf(Guid) +2] := scrGetStrLen.Variable.Text;
    end;
  end
  else
  if Kind = 'Get String Position' then
  begin
    scrGetStrPos.Variable.Text := GetStrPos[GetStrPos.IndexOf(Guid) +1];
    scrGetStrPos.Substring.Text := GetStrPos[GetStrPos.IndexOf(Guid) +2];
    scrGetStrPos.Literal.Text := GetStrPos[GetStrPos.IndexOf(Guid) +3];
    scrGetStrPos.IgnoreCase.Checked := StrToBool(GetStrPos[GetStrPos.IndexOf(Guid) +4]);
    scrForceValue := GetStrPos[GetStrPos.IndexOf(Guid) +1];
    if scrGetStrPos.ShowModal = mrOk then
    begin
      Result := True;
      GetStrPos[GetStrPos.IndexOf(Guid) +1] := scrGetStrPos.Variable.Text;
      GetStrPos[GetStrPos.IndexOf(Guid) +2] := scrGetStrPos.Substring.Text;
      GetStrPos[GetStrPos.IndexOf(Guid) +3] := scrGetStrPos.Literal.Text;
      GetStrPos[GetStrPos.IndexOf(Guid) +4] := BoolToStr(scrGetStrPos.IgnoreCase.Checked);
    end;
  end
  else
  if Kind = 'Localization Variable' then 
  begin
    scrForceValue := LocVar[LocVar.IndexOf(Guid) + 1];
    scrLocalizationVariable.Variable.Text := LocVar[LocVar.IndexOf(Guid) + 1];
    scrLocalizationVariable.Value.Text := LocVar[LocVar.IndexOf(Guid) + 2];
    if scrLocalizationVariable.ShowModal = mrOk then
    begin
      Result := True;
      LocVar[LocVar.IndexOf(Guid) +1] := scrLocalizationVariable.Variable.Text;
      LocVar[LocVar.IndexOf(Guid) +2] := scrLocalizationVariable.Value.Text;
    end;
  end
  else
  if Kind = 'Match Regular Expression' then
  begin
    scrRegEx.Variable.Text := RegEx[RegEx.IndexOf(Guid) +1];
    scrRegEx.Ex.Text := RegEx[RegEx.IndexOf(Guid) +2];
    scrRegEx.Match.Text := RegEx[RegEx.IndexOf(Guid) +3];
    scrForceValue := RegEx[RegEx.IndexOf(Guid) +1];
    if scrRegEx.ShowModal = mrOk then
    begin
      Result := True;
      RegEx[RegEx.IndexOf(Guid) +1] := scrRegEx.Variable.Text;
      RegEx[RegEx.IndexOf(Guid) +2] := scrRegEx.Ex.Text;
      RegEx[RegEx.IndexOf(Guid) +3] := scrRegEx.Match.Text;
    end;
  end
  else
  if Kind = 'Replace String' then 
  begin
    scrForceValue := ReplaceStr[ReplaceStr.IndexOf(Guid) +1];
    scrReplaceString.Variable.Text := ReplaceStr[ReplaceStr.IndexOf(Guid) +1];
    scrReplaceString.OldPattern.Text := ReplaceStr[ReplaceStr.IndexOf(Guid) +2];
    scrReplaceString.NewPattern.Text := ReplaceStr[ReplaceStr.IndexOf(Guid) +3];
    scrReplaceString.IgnoreCase.Checked := StrToBool(ReplaceStr[ReplaceStr.IndexOf(Guid) +4]);
    scrReplaceString.ReplaceAll.Checked := StrToBool(ReplaceStr[ReplaceStr.IndexOf(Guid) +5]);
    if scrReplaceString.ShowModal = mrOk then
    begin
      Result := True;
      ReplaceStr[ReplaceStr.IndexOf(Guid) +1] := scrReplaceString.Variable.Text;
      ReplaceStr[ReplaceStr.IndexOf(Guid) +2] := scrReplaceString.OldPattern.Text;
      ReplaceStr[ReplaceStr.IndexOf(Guid) +3] := scrReplaceString.NewPattern.Text;
      ReplaceStr[ReplaceStr.IndexOf(Guid) +4] := BoolToStr(scrReplaceString.IgnoreCase.Checked);
      ReplaceStr[ReplaceStr.IndexOf(Guid) +5] := BoolToStr(scrReplaceString.ReplaceAll.Checked);
    end;
  end
  else
  if Kind = 'Browse for Folder' then
  begin
    scrForceValue := xBrowseFolder[xBrowseFolder.IndexOf(Guid) +3];
    scrBrowseFolder.Title.Text := xBrowseFolder[xBrowseFolder.IndexOf(Guid) +1];
    scrBrowseFolder.Root.Text := xBrowseFolder[xBrowseFolder.IndexOf(Guid) +2];
    scrBrowseFolder.Variable.Text := xBrowseFolder[xBrowseFolder.IndexOf(Guid) +3];
    if scrBrowseFolder.ShowModal = mrOk then
    begin
      Result := True;
      xBrowseFolder[xBrowseFolder.IndexOf(Guid) +1] := scrBrowseFolder.Title.Text;
      xBrowseFolder[xBrowseFolder.IndexOf(Guid) +2] := scrBrowseFolder.Root.Text;
      xBrowseFolder[xBrowseFolder.IndexOf(Guid) +3] := scrBrowseFolder.Variable.Text;
    end;
  end
  else
  if Kind = 'Browse for File' then
  begin
    scrForceValue := xBrowseFile[xBrowseFile.IndexOf(Guid) +4];
    scrBrowseFile.Title.Text := xBrowseFile[xBrowseFile.IndexOf(Guid) +1];
    scrBrowseFile.Open.Checked := StrToBool(xBrowseFile[xBrowseFile.IndexOf(Guid) +2]);
    scrBrowseFile.Save.Checked := StrToBool(xBrowseFile[xBrowseFile.IndexOf(Guid) +3]);
    scrBrowseFile.Variable.Text := xBrowseFile[xBrowseFile.IndexOf(Guid) +4];
    scrBrowseFile.Extension.Text := xBrowseFile[xBrowseFile.IndexOf(Guid) +5];
    scrBrowseFile.Default.Text := xBrowseFile[xBrowseFile.IndexOf(Guid) +6];
    scrBrowseFile.Filter.Text := xBrowseFile[xBrowseFile.IndexOf(Guid) +7];
    if scrBrowseFile.ShowModal = mrOk then
    begin
      Result := True;
      xBrowseFile[xBrowseFile.IndexOf(Guid) +1] := scrBrowseFile.Title.Text;
      xBrowseFile[xBrowseFile.IndexOf(Guid) +2] := BoolToStr(scrBrowseFile.Open.Checked);
      xBrowseFile[xBrowseFile.IndexOf(Guid) +3] := BoolToStr(scrBrowseFile.Save.Checked);
      xBrowseFile[xBrowseFile.IndexOf(Guid) +4] := scrBrowseFile.Variable.Text;
      xBrowseFile[xBrowseFile.IndexOf(Guid) +5] := scrBrowseFile.Extension.Text;
      xBrowseFile[xBrowseFile.IndexOf(Guid) +6] := scrBrowseFile.Default.Text;
      xBrowseFile[xBrowseFile.IndexOf(Guid) +7] := scrBrowseFile.Filter.Text;
    end;
  end
  else
  if Kind = 'Load Feature Selections' then 
  begin
    scrLoadFeatures.FilePath.Text := LoadFeatures[LoadFeatures.IndexOf(Guid) +1];
    if scrLoadFeatures.ShowModal = mrOk then
    begin
      Result := True;
      LoadFeatures[LoadFeatures.IndexOf(Guid) +1] := scrLoadFeatures.FilePath.Text;
    end;
  end
  else
  if Kind = 'Prompt for Text' then
  begin
    scrForceValue := xPromptForText[xPromptForText.IndexOf(Guid) +2];
    scrPromptForText.Title.Text := xPromptForText[xPromptForText.IndexOf(Guid) +1];
    scrPromptForText.Variable.Text := xPromptForText[xPromptForText.IndexOf(Guid) +2];
    SetMemoFlat(scrPromptForText.Message, xPromptForText[xPromptForText.IndexOf(Guid) +3]);
    if scrPromptForText.ShowModal = mrOk then
    begin
      Result := True;
      xPromptForText[xPromptForText.IndexOf(Guid) +1] := scrPromptForText.Title.Text;
      xPromptForText[xPromptForText.IndexOf(Guid) +2] := scrPromptForText.Variable.Text;
      xPromptForText[xPromptForText.IndexOf(Guid) +3] := GetMemoFlat(scrPromptForText.Message);
    end;
  end
  else
  if Kind = 'Save Feature Selections' then 
  begin
    scrSaveFeatures.FilePath.Text := SaveFeatures[SaveFeatures.IndexOf(Guid) +1];
    if scrSaveFeatures.ShowModal = mrOk then
    begin
      Result := True;
      SaveFeatures[SaveFeatures.IndexOf(Guid) +1] := scrSaveFeatures.FilePath.Text;
    end;
  end
  else
  if Kind = 'Set Component Choice' then 
  begin
    scrForceValue := SetChoice[SetChoice.IndexOf(Guid) +1];
    scrSetComponentChoice.ComponentName.Text := SetChoice[SetChoice.IndexOf(Guid) +1];
    scrSetComponentChoice.Choice.Checked := StrToBool(SetChoice[SetChoice.IndexOf(Guid) +2]);
    if scrSetComponentChoice.ShowModal = mrOk then
    begin
      Result := True;
      SetChoice[SetChoice.IndexOf(Guid) +1] := scrSetComponentChoice.ComponentName.Text;
      SetChoice[SetChoice.IndexOf(Guid) +2] := BoolToStr(scrSetComponentChoice.Choice.Checked);
    end;
  end
  else
  if Kind = 'Get Component Space' then 
  begin
    scrForceValue := GetSpace[GetSpace.IndexOf(Guid) +2];
    scrForceValueX := GetSpace[GetSpace.IndexOf(Guid) +1];
    scrGetComponentSpace.ComponentName.Text := GetSpace[GetSpace.IndexOf(Guid) +1];
    scrGetComponentSpace.Space.Text := GetSpace[GetSpace.IndexOf(Guid) +2];
    if scrGetComponentSpace.ShowModal = mrOk then
    begin
      Result := True;
      GetSpace[GetSpace.IndexOf(Guid) +1] := scrGetComponentSpace.ComponentName.Text;
      GetSpace[GetSpace.IndexOf(Guid) +2] := scrGetComponentSpace.Space.Text;
    end;
  end
  else
  if Kind = 'Set Component Visibility' then 
  begin
    scrForceValue := SetVisibility[SetVisibility.IndexOf(Guid) +1];
    scrSetComponentVisibility.ComponentName.Text := SetVisibility[SetVisibility.IndexOf(Guid) +1];
    scrSetComponentVisibility.Visibility.Checked := StrToBool(SetVisibility[SetVisibility.IndexOf(Guid) +2]);
    if scrSetComponentVisibility.ShowModal = mrOk then
    begin
      Result := True;
      SetVisibility[SetVisibility.IndexOf(Guid) +1] := scrSetComponentVisibility.ComponentName.Text;
      SetVisibility[SetVisibility.IndexOf(Guid) +2] := BoolToStr(scrSetComponentVisibility.Visibility.Checked);
    end;
  end
  else
  if Kind = 'Check Disk Space' then 
  begin
    scrForceValue := CheckSpace[CheckSpace.IndexOf(Guid) +1];
    scrCheckDiskSpace.Variable.Text := CheckSpace[CheckSpace.IndexOf(Guid) +1];
    scrCheckDiskSpace.DiskPath.Text := CheckSpace[CheckSpace.IndexOf(Guid) +2];
    scrCheckDiskSpace.Available.Checked := StrToBool(CheckSpace[CheckSpace.IndexOf(Guid) +3]);
    scrCheckDiskSpace.Total.Checked := StrToBool(CheckSpace[CheckSpace.IndexOf(Guid) +4]);
    if scrCheckDiskSpace.ShowModal = mrOk then
    begin
      Result := True;
      CheckSpace[CheckSpace.IndexOf(Guid) +1] := scrCheckDiskSpace.Variable.Text;
      CheckSpace[CheckSpace.IndexOf(Guid) +2] := scrCheckDiskSpace.DiskPath.Text;
      CheckSpace[CheckSpace.IndexOf(Guid) +3] := BoolToStr(scrCheckDiskSpace.Available.Checked);
      CheckSpace[CheckSpace.IndexOf(Guid) +4] := BoolToStr(scrCheckDiskSpace.Total.Checked);
    end;
  end
  else
  if Kind = 'Does File/Folder Exist' then 
  begin
    WidenColonDelimParam(DoesExist[DoesExist.IndexOf(Guid) +3], Wide1, Wide2);
    if Wide2 = '' then
      Wide2 := 'FALSE';
    scrForceValue := DoesExist[DoesExist.IndexOf(Guid) +1];
    scrFileFolderExist.Variable.Text := DoesExist[DoesExist.IndexOf(Guid) +1];
    scrFileFolderExist.Path.Text := DoesExist[DoesExist.IndexOf(Guid) +2];
    scrFileFolderExist.CheckFile.Checked := StrToBool(Wide1);
    scrFileFolderExist.CheckFolder.Checked := not StrToBool(Wide1);
    scrFileFolderExist.Link.Checked := StrToBool(Wide2);
    if scrFileFolderExist.ShowModal = mrOk then
    begin
      Result := True;
      DoesExist[DoesExist.IndexOf(Guid) +1] := scrFileFolderExist.Variable.Text;
      DoesExist[DoesExist.IndexOf(Guid) +2] := scrFileFolderExist.Path.Text;
      DoesExist[DoesExist.IndexOf(Guid) +3] := BoolToStr(scrFileFolderExist.CheckFile.Checked)
        + '|' + BoolToStr(scrFileFolderExist.Link.Checked);
    end;
  end
  else
  if Kind = 'Get Link Target' then
  begin
    scrGetLinkTarget.Path.Text := GetLink[GetLink.IndexOf(Guid) +1];;
    scrGetLinkTarget.Variable.Text := GetLink[GetLink.IndexOf(Guid) +2];
    scrForceValue := GetLink[GetLink.IndexOf(Guid) +2];
    if scrGetLinkTarget.ShowModal = mrOk then
    begin
      Result := True;
      GetLink[GetLink.IndexOf(Guid) +1] := scrGetLinkTarget.Path.Text;
      GetLink[GetLink.IndexOf(Guid) +2] := scrGetLinkTarget.Variable.Text;
    end;
  end
  else
  if Kind = 'Find All Files' then 
  begin
    WidenColonDelimParam(FAF[FAF.IndexOf(Guid) +3], Wide1, Wide2);
    if Wide2 = '' then Wide2 := 'FALSE';
    scrForceValue := FAF[FAF.IndexOf(Guid) +4];
    scrFindAllFiles.Path.Text := FAF[FAF.IndexOf(Guid) +1];
    scrFindAllFiles.Subfolder.Checked := StrToBool(FAF[FAF.IndexOf(Guid) +2]);
    scrFindAllFiles.DirNames.Checked := StrToBool(Wide1);
    scrFindAllFiles.Link.Checked := StrToBool(Wide2);
    scrFindAllFiles.Variable.Text := FAF[FAF.IndexOf(Guid) +4];
    if scrFindAllFiles.ShowModal = mrOk then
    begin
      Result := True;
      FAF[FAF.IndexOf(Guid) +1] := scrFindAllFiles.Path.Text;
      FAF[FAF.IndexOf(Guid) +2] := BoolToStr(scrFindAllFiles.Subfolder.Checked);
      FAF[FAF.IndexOf(Guid) +3] := BoolToStr(scrFindAllFiles.DirNames.Checked)
        + '|' + BoolToStr(scrFindAllFiles.Link.Checked);
      FAF[FAF.IndexOf(Guid) +4] := scrFindAllFiles.Variable.Text;
    end;
  end
  else
  if Kind = 'Generate GUID' then 
  begin
    scrForceValue := xGUID[xGUID.IndexOf(Guid) +1];
    scrGUID.Variable.Text := xGUID[xGUID.IndexOf(Guid) +1];
    if scrGUID.ShowModal = mrOk then
    begin
      Result := True;
      xGUID[xGUID.IndexOf(Guid) +1] := scrGUID.Variable.Text;
    end;
  end
  else
  if Kind = 'Get Environment' then 
  begin
    scrForceValue := GetEnv[GetEnv.IndexOf(Guid) +2];
    scrGetEnvironment.EnvVar.Text := GetEnv[GetEnv.IndexOf(Guid) +1];
    scrGetEnvironment.Variable.Text := GetEnv[GetEnv.IndexOf(Guid) +2];
    if scrGetEnvironment.ShowModal = mrOk then
    begin
      Result := True;
      GetEnv[GetEnv.IndexOf(Guid) +1] := scrGetEnvironment.EnvVar.Text;
      GetEnv[GetEnv.IndexOf(Guid) +2] := scrGetEnvironment.Variable.Text;
    end;
  end
  else
  if Kind = 'Get INI File Settings' then 
  begin
    scrForceValue := GetINI[GetINI.IndexOf(Guid) +1];
    scrGetINI.Variable.Text := GetINI[GetINI.IndexOf(Guid) +1];
    scrGetINI.FileName.Text := GetINI[GetINI.IndexOf(Guid) +2];
    scrGetINI.Section.Text := GetINI[GetINI.IndexOf(Guid) +3];
    scrGetINI.Key.Text := GetINI[GetINI.IndexOf(Guid) +4];
    if scrGetINI.ShowModal = mrOk then
    begin
      Result := True;
      GetINI[GetINI.IndexOf(Guid) +1] := scrGetINI.Variable.Text;
      GetINI[GetINI.IndexOf(Guid) +2] := scrGetINI.FileName.Text;
      GetINI[GetINI.IndexOf(Guid) +3] := scrGetINI.Section.Text;
      GetINI[GetINI.IndexOf(Guid) +4] := scrGetINI.Key.Text;
    end;
  end
  else
  if Kind = 'Get Temporary File' then 
  begin
    scrForceValue := GetTemp[GetTemp.IndexOf(Guid) +1];
    scrGetTempFile.Variable.Text := GetTemp[GetTemp.IndexOf(Guid) +1];
    if scrGetTempFile.ShowModal = mrOk then
    begin
      Result := True;
      GetTemp[GetTemp.IndexOf(Guid) +1] := scrGetTempFile.Variable.Text;
    end;
  end
  else
  if Kind = 'Is Native Setup Installed' then 
  begin
    scrForceValue := IsNative[IsNative.IndexOf(Guid) +2];
    scrIsNativeSetupInstalled.Guid.Text := IsNative[IsNative.IndexOf(Guid) +1];
    scrIsNativeSetupInstalled.Variable.Text := IsNative[IsNative.IndexOf(Guid) +2];
    if scrIsNativeSetupInstalled.ShowModal = mrOk then
    begin
      Result := True;
      IsNative[IsNative.IndexOf(Guid) +1] := scrIsNativeSetupInstalled.Guid.Text;
      IsNative[IsNative.IndexOf(Guid) +2] := scrIsNativeSetupInstalled.Variable.Text;
    end;
  end
  else
  if Kind = 'Read from Binary File' then
  begin
    scrForceValue := xReadBinary[xReadBinary.IndexOf(Guid) +2];
    scrReadBinary.Text.Text := xReadBinary[xReadBinary.IndexOf(Guid) +1];
    scrReadBinary.Variable.Text := xReadBinary[xReadBinary.IndexOf(Guid) +2];
    scrReadBinary.Position.Value := StrToInt(xReadBinary[xReadBinary.IndexOf(Guid) +3]);
    scrReadBinary.Total.Value := StrToInt(xReadBinary[xReadBinary.IndexOf(Guid) +4]);
    if scrReadBinary.ShowModal = mrOk then
    begin
      Result := True;
      xReadBinary[xReadBinary.IndexOf(Guid) +1] := scrReadBinary.Text.Text;
      xReadBinary[xReadBinary.IndexOf(Guid) +2] := scrReadBinary.Variable.Text;
      xReadBinary[xReadBinary.IndexOf(Guid) +3] := IntToStr(scrReadBinary.Position.Value);
      xReadBinary[xReadBinary.IndexOf(Guid) +4] := IntToStr(scrReadBinary.Total.Value);
    end;
  end
  else
  if Kind = 'Copy/Move Local Files' then 
  begin
    WidenColonDelimParam(LocalFiles[LocalFiles.IndexOf(Guid) +6], Wide1, Wide2);
    if Wide2 = '' then Wide2 := 'FALSE';
    WidenColonDelimParam(LocalFiles[LocalFiles.IndexOf(Guid) +5], Wide3, Wide4);
    if Wide4 = '' then Wide4 := 'FALSE';
    scrLocalFiles.SourceFolder.Text := LocalFiles[LocalFiles.IndexOf(Guid) +1];
    scrLocalFiles.SourceFiles.Text := LocalFiles[LocalFiles.IndexOf(Guid) +2];
    scrLocalFiles.TargetFolder.Text := LocalFiles[LocalFiles.IndexOf(Guid) +3];
    scrLocalFiles.TargetFiles.Text := LocalFiles[LocalFiles.IndexOf(Guid) +4];
    scrLocalFiles.CopyFiles.Checked := StrToBool(Wide3);
    scrLocalFiles.MoveFiles.Checked := StrToBool(Wide1);
    scrLocalFiles.Subfolders.Checked := StrToBool(Wide2);
    scrLocalFiles.Link.Checked := StrToBool(Wide4);
    if scrLocalFiles.ShowModal = mrOk then
    begin
      Result := True;
      LocalFiles[LocalFiles.IndexOf(Guid) +1] := scrLocalFiles.SourceFolder.Text;
      LocalFiles[LocalFiles.IndexOf(Guid) +2] := scrLocalFiles.SourceFiles.Text;
      LocalFiles[LocalFiles.IndexOf(Guid) +3] := scrLocalFiles.TargetFolder.Text;
      LocalFiles[LocalFiles.IndexOf(Guid) +4] := scrLocalFiles.TargetFiles.Text;
      LocalFiles[LocalFiles.IndexOf(Guid) +5] := BoolToStr(scrLocalFiles.CopyFiles.Checked)
        + '|' + BoolToStr(scrLocalFiles.Link.Checked);
      LocalFiles[LocalFiles.IndexOf(Guid) +6] := BoolToStr(scrLocalFiles.MoveFiles.Checked)
        + '|' + BoolToStr(scrLocalFiles.Subfolders.Checked);
    end;
  end
  else
  if Kind = 'Edit INI File' then 
  begin
    scrEditIniFile.FilePath.Text := EditIni[EditIni.IndexOf(Guid) +1];
    scrEditIniFile.FileName.Text := EditIni[EditIni.IndexOf(Guid) +2];
    scrEditIniFile.Action.ItemIndex := StrToInt(EditIni[EditIni.IndexOf(Guid) +3]);
    scrEditIniFile.Section.Text := EditIni[EditIni.IndexOf(Guid) +4];
    scrEditIniFile.Key.Text := EditIni[EditIni.IndexOf(Guid) +5];
    scrEditIniFile.Value.Text := EditIni[EditIni.IndexOf(Guid) +6];
    if scrEditIniFile.ShowModal = mrOk then
    begin
      Result := True;
      EditIni[EditIni.IndexOf(Guid) +1] := scrEditIniFile.FilePath.Text;
      EditIni[EditIni.IndexOf(Guid) +2] := scrEditIniFile.FileName.Text;
      EditIni[EditIni.IndexOf(Guid) +3] := IntToStr(scrEditIniFile.Action.ItemIndex);
      EditIni[EditIni.IndexOf(Guid) +4] := scrEditIniFile.Section.Text;
      EditIni[EditIni.IndexOf(Guid) +5] := scrEditIniFile.Key.Text;
      EditIni[EditIni.IndexOf(Guid) +6] := scrEditIniFile.Value.Text;
    end;
  end
  else
  if Kind = 'Set 64 Bit Mode' then 
  begin
    scrSet64BitMode.Win32.Checked := StrToBool(Plat[Plat.IndexOf(Guid) +1]);
    scrSet64BitMode.ia64.Checked := StrToBool(Plat[Plat.IndexOf(Guid) +2]);
    scrSet64BitMode.x64.Checked := StrToBool(Plat[Plat.IndexOf(Guid) +3]);
    if scrSet64BitMode.ShowModal = mrOk then
    begin
      Result := True;
      Plat[Plat.IndexOf(Guid) +1] := BoolToStr(scrSet64BitMode.Win32.Checked);
      Plat[Plat.IndexOf(Guid) +2] := BoolToStr(scrSet64BitMode.ia64.Checked);
      Plat[Plat.IndexOf(Guid) +3] := BoolToStr(scrSet64BitMode.x64.Checked);
    end;
  end
  else
  if Kind = 'Rename File/Folder' then
  begin
    scrRename.Path.Text := xRename[xRename.IndexOf(Guid) +1];
    scrRename.NewPath.Text := xRename[xRename.IndexOf(Guid) +2];
    if scrRename.ShowModal = mrOk then
    begin
      Result := True;
      xRename[xRename.IndexOf(Guid) +1] := scrRename.Path.Text;
      xRename[xRename.IndexOf(Guid) +2] := scrRename.NewPath.Text;
    end;
  end
  else
  if Kind = 'Write to Binary File' then
  begin
    scrWriteBinary.Text.Text := xWriteBinary[xWriteBinary.IndexOf(Guid) +1];
    scrWriteBinary.Value.Text := xWriteBinary[xWriteBinary.IndexOf(Guid) +2];
    scrWriteBinary.Position.Value := StrToInt(xWriteBinary[xWriteBinary.IndexOf(Guid) +3]);
    scrWriteBinary.AppendNull.Checked := StrToBool(xWriteBinary[xWriteBinary.IndexOf(Guid) +4]);
    if scrWriteBinary.ShowModal = mrOk then
    begin
      Result := True;
      xWriteBinary[xWriteBinary.IndexOf(Guid) +1] := scrWriteBinary.Text.Text;
      xWriteBinary[xWriteBinary.IndexOf(Guid) +2] := scrWriteBinary.Value.Text;
      xWriteBinary[xWriteBinary.IndexOf(Guid) +3] := IntToStr(scrWriteBinary.Position.Value);
      xWriteBinary[xWriteBinary.IndexOf(Guid) +4] := BoolToStr(scrWriteBinary.AppendNull.Checked);
    end;
  end
  else
  if Kind = 'Halt Compilation' then 
  begin
    SetMemoFlat(scrHaltCompile.Message, HaltCompile[HaltCompile.IndexOf(Guid) +1]);
    if scrHaltCompile.ShowModal = mrOk then
    begin
      Result := True;
      HaltCompile[HaltCompile.IndexOf(Guid) +1] := GetMemoFlat(scrHaltCompile.Message);
    end;
  end
  else
  if Kind = 'Delete Registry' then 
  begin
    WidenColonDelimParam(DeleteReg[DeleteReg.IndexOf(Guid) +1], Wide1, Wide2);
    scrDeleteRegistry.Root.ItemIndex := StrToInt(Wide1);
    scrDeleteRegistry.Key.Text := DeleteReg[DeleteReg.IndexOf(Guid) +2];
    scrDeleteRegistry.Value.Text := DeleteReg[DeleteReg.IndexOf(Guid) +3];
    scrDeleteRegistry.delKey.Checked := StrToBool(DeleteReg[DeleteReg.IndexOf(Guid) +4]);
    scrDeleteRegistry.delValue.Checked := not scrDeleteRegistry.delKey.Checked;
    scrDeleteRegistry.Target.Text := Wide2;
    if scrDeleteRegistry.ShowModal = mrOk then
    begin
      Result := True;
      DeleteReg[DeleteReg.IndexOf(Guid) +1] := IntToStr(scrDeleteRegistry.Root.ItemIndex) + '|' + scrDeleteRegistry.Target.Text;
      DeleteReg[DeleteReg.IndexOf(Guid) +2] := scrDeleteRegistry.Key.Text;
      DeleteReg[DeleteReg.IndexOf(Guid) +3] := scrDeleteRegistry.Value.Text;
      DeleteReg[DeleteReg.IndexOf(Guid) +4] := BoolToStr(scrDeleteRegistry.delKey.Checked);
    end;
  end
  else
  if Kind = 'Find All Registry' then
  begin
    WidenColonDelimParam(FindAllReg[FindAllReg.IndexOf(Guid) +1], Wide1, Wide2);
    scrForceValue := Wide1;
    scrFindAllRegistry.Variable.Text := Wide1;
    scrFindAllRegistry.Root.ItemIndex := StrToInt(FindAllReg[FindAllReg.IndexOf(Guid) +2]);
    scrFindAllRegistry.Key.Text := FindAllReg[FindAllReg.IndexOf(Guid) +3];
    scrFindAllRegistry.Names.Checked := StrToBool(FindAllReg[FindAllReg.IndexOf(Guid) +4]);
    scrFindAllRegistry.Values.Checked := StrToBool(FindAllReg[FindAllReg.IndexOf(Guid) +5]);
    scrFindAllRegistry.Target.Text := Wide2;
    if scrFindAllRegistry.ShowModal = mrOk then
    begin
      Result := True;
      FindAllReg[FindAllReg.IndexOf(Guid) +1] := scrFindAllRegistry.Variable.Text + '|' + scrFindAllRegistry.Target.Text;
      FindAllReg[FindAllReg.IndexOf(Guid) +2] := IntToStr(scrFindAllRegistry.Root.ItemIndex);
      FindAllReg[FindAllReg.IndexOf(Guid) +3] := scrFindAllRegistry.Key.Text;
      FindAllReg[FindAllReg.IndexOf(Guid) +4] := BoolToStr(scrFindAllRegistry.Names.Checked);
      FindAllReg[FindAllReg.IndexOf(Guid) +5] := BoolToStr(scrFindAllRegistry.Values.Checked);
    end;
  end
  else
  if Kind = 'Get OS or SP Level' then 
  begin
    scrForceValue := ExactVer[ExactVer.IndexOf(Guid) +1];
    scrGetOSorSP.Variable.Text := ExactVer[ExactVer.IndexOf(Guid) +1];
    scrGetOSorSP.OS.Checked := StrToBool(ExactVer[ExactVer.IndexOf(Guid) +2]);
    scrGetOSorSP.SP.Checked := StrToBool(ExactVer[ExactVer.IndexOf(Guid) +3]);
    if scrGetOSorSP.ShowModal = mrOk then
    begin
      Result := True;
      ExactVer[ExactVer.IndexOf(Guid) +1] := scrGetOSorSP.Variable.Text;
      ExactVer[ExactVer.IndexOf(Guid) +2] := BoolToStr(scrGetOSorSP.OS.Checked);
      ExactVer[ExactVer.IndexOf(Guid) +3] := BoolToStr(scrGetOSorSP.SP.Checked);
    end;
  end
  else
  if Kind = 'Get System Settings' then 
  begin
    scrForceValue := GetSystemSettings[GetSystemSettings.IndexOf(Guid) +1];
    scrGetSystemSettings.Variable.Text := GetSystemSettings[GetSystemSettings.IndexOf(Guid) +1];
    scrGetSystemSettings.Capability.ItemIndex := StrToInt(GetSystemSettings[GetSystemSettings.IndexOf(Guid) +2]);
    if scrGetSystemSettings.ShowModal = mrOk then
    begin
      Result := True;
      GetSystemSettings[GetSystemSettings.IndexOf(Guid) +1] := scrGetSystemSettings.Variable.Text;
      GetSystemSettings[GetSystemSettings.IndexOf(Guid) +2] := IntToStr(scrGetSystemSettings.Capability.ItemIndex);
    end;
  end
  else
  if Kind = 'Get Native Settings' then 
  begin
    scrForceValue := GetNativeSettings[GetNativeSettings.IndexOf(Guid) +1];
    scrGetNativeSettings.Variable.Text := GetNativeSettings[GetNativeSettings.IndexOf(Guid) +1];
    scrGetNativeSettings.Capability.ItemIndex := StrToInt(GetNativeSettings[GetNativeSettings.IndexOf(Guid) +2]);
    if scrGetNativeSettings.ShowModal = mrOk then
    begin
      Result := True;
      GetNativeSettings[GetNativeSettings.IndexOf(Guid) +1] := scrGetNativeSettings.Variable.Text;
      GetNativeSettings[GetNativeSettings.IndexOf(Guid) +2] := IntToStr(scrGetNativeSettings.Capability.ItemIndex);
    end;
  end
  else
  if (Kind = 'Read Registry') or (Kind = 'Check Registry') then 
  begin
    scrReadRegistry.Caption := Kind + ' (Windows Only)';
    WidenColonDelimParam(ReadReg[ReadReg.IndexOf(Guid) +1], Wide1, Wide2);
    scrForceValue := Wide1; 
    scrReadRegistry.Variable.Text := Wide1; 
    if Wide2 <> '' then
      scrReadRegistry.Target.Text := Wide2
    else
      scrReadRegistry.Target.Text := '';
    scrReadRegistry.Root.ItemIndex := StrToInt(ReadReg[ReadReg.IndexOf(Guid) +2]);
    scrReadRegistry.Key.Text := ReadReg[ReadReg.IndexOf(Guid) +3];
    scrReadRegistry.Value.Text := ReadReg[ReadReg.IndexOf(Guid) +4];
    if scrReadRegistry.ShowModal = mrOk then
    begin
      Result := True;
      ReadReg[ReadReg.IndexOf(Guid) +1] := scrReadRegistry.Variable.Text + '|' + scrReadRegistry.Target.Text;
      ReadReg[ReadReg.IndexOf(Guid) +2] := IntToStr(scrReadRegistry.Root.ItemIndex);
      ReadReg[ReadReg.IndexOf(Guid) +3] := scrReadRegistry.Key.Text;
      ReadReg[ReadReg.IndexOf(Guid) +4] := scrReadRegistry.Value.Text;
    end;
  end
  else
  if Kind = 'Write Registry' then 
  begin
    
    WidenColonDelimParam(WriteReg[WriteReg.IndexOf(Guid) +2], Wide1, Wide2);
    scrWriteRegistry.Root.ItemIndex := StrToInt(Wide1);
    if Wide2 <> '' then
      scrWriteRegistry.Target.Text := Wide2
    else
      scrWriteRegistry.Target.Text := '';
    scrWriteRegistry.Key.Text := WriteReg[WriteReg.IndexOf(Guid) +3];
    scrWriteRegistry.Value.Text := WriteReg[WriteReg.IndexOf(Guid) +4];
    scrWriteRegistry.Data.Text := WriteReg[WriteReg.IndexOf(Guid) +5];
    scrWriteRegistry.asString.Checked := StrToBool(WriteReg[WriteReg.IndexOf(Guid) +6]);
    try
      scrWriteRegistry.asInteger.Checked := StrToBool(WriteReg[WriteReg.IndexOf(Guid) +7]);
    except
      scrWriteRegistry.asInteger.Checked := false;
    end;
    scrWriteRegistry.asExpandString.Checked := WriteReg[WriteReg.IndexOf(Guid) +7] = 'EXPANDSTRING'; 
    scrWriteRegistry.asBinary.Checked := WriteReg[WriteReg.IndexOf(Guid) +7] = 'BINARY'; 
    scrWriteRegistry.asAppend.Checked := WriteReg[WriteReg.IndexOf(Guid) +7] = 'APPEND'; 
    scrWriteRegistry.asPrepend.Checked := WriteReg[WriteReg.IndexOf(Guid) +7] = 'PREPEND'; 
    scrWriteRegistry.Permanent.Checked := StrToInt(WriteReg[WriteReg.IndexOf(Guid) +1]) = 10;
    if scrWriteRegistry.ShowModal = mrOk then
    begin
      Result := True;
      
      if scrWriteRegistry.Permanent.Checked then
        WriteReg[WriteReg.IndexOf(Guid) +1] := '10' 
      else
        WriteReg[WriteReg.IndexOf(Guid) +1] := '0';
      WriteReg[WriteReg.IndexOf(Guid) +2] := IntToStr(scrWriteRegistry.Root.ItemIndex) + '|' + scrWriteRegistry.Target.Text;
      WriteReg[WriteReg.IndexOf(Guid) +3] := scrWriteRegistry.Key.Text;
      WriteReg[WriteReg.IndexOf(Guid) +4] := scrWriteRegistry.Value.Text;
      WriteReg[WriteReg.IndexOf(Guid) +5] := scrWriteRegistry.Data.Text;
      WriteReg[WriteReg.IndexOf(Guid) +6] := BoolToStr(scrWriteRegistry.asString.Checked);
      if scrWriteRegistry.asInteger.Checked then
        WriteReg[WriteReg.IndexOf(Guid) +7] := 'TRUE' 
      else
      if scrWriteRegistry.asExpandString.Checked then
        WriteReg[WriteReg.IndexOf(Guid) +7] := 'EXPANDSTRING' 
      else
      if scrWriteRegistry.asBinary.Checked then
        WriteReg[WriteReg.IndexOf(Guid) +7] := 'BINARY' 
      else
      if scrWriteRegistry.asAppend.Checked then
        WriteReg[WriteReg.IndexOf(Guid) +7] := 'APPEND' 
      else
      if scrWriteRegistry.asPrepend.Checked then
        WriteReg[WriteReg.IndexOf(Guid) +7] := 'PREPEND' 
      else
        WriteReg[WriteReg.IndexOf(Guid) +7] := 'FALSE'; 
    end;
  end
  else
  if Kind = 'Compress 7Zip Archive' then 
  begin
    scrForceValue := Compress7Zip[Compress7Zip.IndexOf(Guid) +10];
    scrCompress7Zip.Archive.Text := Compress7Zip[Compress7Zip.IndexOf(Guid) +1];
    scrCompress7Zip.Password.Text := Compress7Zip[Compress7Zip.IndexOf(Guid) +2];
    scrCompress7Zip.Recursive.Text := Compress7Zip[Compress7Zip.IndexOf(Guid) +3];
    scrCompress7Zip.NonRecursive.Text := Compress7Zip[Compress7Zip.IndexOf(Guid) +4];
    scrCompress7Zip.ArchiveType.ItemIndex := StrToInt(Compress7Zip[Compress7Zip.IndexOf(Guid) +5]);
    scrCompress7Zip.Parameters.Text := Compress7Zip[Compress7Zip.IndexOf(Guid) +6];
    scrCompress7Zip.RelativePath.Checked := StrToBool(Compress7Zip[Compress7Zip.IndexOf(Guid) +7]);
    scrCompress7Zip.FullPath.Checked := StrToBool(Compress7Zip[Compress7Zip.IndexOf(Guid) +8]);
    scrCompress7Zip.NoPath.Checked := StrToBool(Compress7Zip[Compress7Zip.IndexOf(Guid) +9]);
    scrCompress7Zip.Variable.Text := Compress7Zip[Compress7Zip.IndexOf(Guid) +10];
    if scrCompress7Zip.ShowModal = mrOk then
    begin
      Result := True;
      Compress7Zip[Compress7Zip.IndexOf(Guid) +1] := scrCompress7Zip.Archive.Text;
      Compress7Zip[Compress7Zip.IndexOf(Guid) +2] := scrCompress7Zip.Password.Text;
      Compress7Zip[Compress7Zip.IndexOf(Guid) +3] := scrCompress7Zip.Recursive.Text;
      Compress7Zip[Compress7Zip.IndexOf(Guid) +4] := scrCompress7Zip.NonRecursive.Text;
      Compress7Zip[Compress7Zip.IndexOf(Guid) +5] := IntToStr(scrCompress7Zip.ArchiveType.ItemIndex);
      Compress7Zip[Compress7Zip.IndexOf(Guid) +6] := scrCompress7Zip.Parameters.Text;
      Compress7Zip[Compress7Zip.IndexOf(Guid) +7] := BoolToStr(scrCompress7Zip.RelativePath.Checked);
      Compress7Zip[Compress7Zip.IndexOf(Guid) +8] := BoolToStr(scrCompress7Zip.FullPath.Checked);
      Compress7Zip[Compress7Zip.IndexOf(Guid) +9] := BoolToStr(scrCompress7Zip.NoPath.Checked);
      Compress7Zip[Compress7Zip.IndexOf(Guid) +10] := scrCompress7Zip.Variable.Text;
    end;
  end
  else
  if Kind = 'Extract 7Zip Archive' then 
  begin
    scrForceValue := Extract7Zip[Extract7Zip.IndexOf(Guid) +3];
    scrExtract7Zip.Archive.Text := Extract7Zip[Extract7Zip.IndexOf(Guid) +1];
    scrExtract7Zip.Path.Text := Extract7Zip[Extract7Zip.IndexOf(Guid) +2];
    scrExtract7Zip.Variable.Text := Extract7Zip[Extract7Zip.IndexOf(Guid) +3];
    scrExtract7Zip.Password.Text := Extract7Zip[Extract7Zip.IndexOf(Guid) +4];
    scrExtract7Zip.Overwrite.Checked := StrToBool(Extract7Zip[Extract7Zip.IndexOf(Guid) +5]);
    scrExtract7Zip.UsePath.Checked := StrToBool(Extract7Zip[Extract7Zip.IndexOf(Guid) +6]);
    if scrExtract7Zip.ShowModal = mrOk then
    begin
      Result := True;
      Extract7Zip[Extract7Zip.IndexOf(Guid) +1] := scrExtract7Zip.Archive.Text;
      Extract7Zip[Extract7Zip.IndexOf(Guid) +2] := scrExtract7Zip.Path.Text;
      Extract7Zip[Extract7Zip.IndexOf(Guid) +3] := scrExtract7Zip.Variable.Text;
      Extract7Zip[Extract7Zip.IndexOf(Guid) +4] := scrExtract7Zip.Password.Text;
      Extract7Zip[Extract7Zip.IndexOf(Guid) +5] := BoolToStr(scrExtract7Zip.Overwrite.Checked);
      Extract7Zip[Extract7Zip.IndexOf(Guid) +6] := BoolToStr(scrExtract7Zip.UsePath.Checked);
    end;
  end
  else
  if Kind = 'Return from Include Script' then
  begin
    scrReturnFromInclude.Result.Text := ReturnInclude[ReturnInclude.IndexOf(Guid) +1];
    if scrReturnFromInclude.ShowModal = mrOk then
    begin
      Result := True;
      ReturnInclude[ReturnInclude.IndexOf(Guid) +1] := scrReturnFromInclude.Result.Text;
    end;
  end
  else
  if Kind = 'Run Program As' then
  begin
    scrForceValue := RunProgramAs[RunProgramAs.IndexOf(Guid) + 8];
    scrRunProgramAs.RunProgram.Text := RunProgramAs[RunProgramAs.IndexOf(Guid) +1];
    scrRunProgramAs.WorkingDir.Text := RunProgramAs[RunProgramAs.IndexOf(Guid) +2];
    scrRunProgramAs.CommandLine.Text := RunProgramAs[RunProgramAs.IndexOf(Guid) +3];
    scrRunProgramAs.Window.ItemIndex := StrToInt(RunProgramAs[RunProgramAs.IndexOf(Guid) +4]);
    if ((RunProgramAs[RunProgramAs.IndexOf(Guid) +5] = '$MYAH_UAC$') or (RunProgramAs[RunProgramAs.IndexOf(Guid) +5] = '$MYAH_UACEX$'))
      or (RunProgramAs[RunProgramAs.IndexOf(Guid) +5] = '$MYAH_UACEY$') then
    begin
      
      if RunProgramAs[RunProgramAs.IndexOf(Guid) +5] = '$MYAH_UAC$' then
      begin
        scrRunProgramAs.Vista.Checked := True;
        scrRunProgramAs.VistaEx.Checked := false;
      end
      else
      if RunProgramAs[RunProgramAs.IndexOf(Guid) +5] = '$MYAH_UACEX$' then
      begin
        scrRunProgramAs.Vista.Checked := false;
        scrRunProgramAs.VistaEx.Checked := True;
        
      end
      else
      begin
        scrRunProgramAs.Vista.Checked := True;
        scrRunProgramAs.VistaEx.Checked := True;
      end;
    end
    else
    begin
      scrRunProgramAs.Vista.Checked := false;
      scrRunProgramAs.VistaEx.Checked := false;
    end;
    scrRunProgramAs.User.Text := '';
    scrRunProgramAs.Password.Text := RunProgramAs[RunProgramAs.IndexOf(Guid) +6];
    scrRunProgramAs.Domain.Text := RunProgramAs[RunProgramAs.IndexOf(Guid) +7];
    scrRunProgramAs.Variable.Text := RunProgramAs[RunProgramAs.IndexOf(Guid) +8];
    scrRunProgramAs.WaitFor.Checked := StrToBool(RunProgramAs[RunProgramAs.IndexOf(Guid) +9]);
    scrRunProgramAs.Environment.Text := RunProgramAs[RunProgramAs.IndexOf(Guid) +10];
    if scrRunProgramAs.ShowModal = mrOk then
    begin
      Result := True;
      RunProgramAs[RunProgramAs.IndexOf(Guid) +1] := scrRunProgramAs.RunProgram.Text;
      RunProgramAs[RunProgramAs.IndexOf(Guid) +2] := scrRunProgramAs.WorkingDir.Text;
      RunProgramAs[RunProgramAs.IndexOf(Guid) +3] := scrRunProgramAs.CommandLine.Text;
      RunProgramAs[RunProgramAs.IndexOf(Guid) +4] := IntToStr(scrRunProgramAs.Window.ItemIndex);
      if scrRunProgramAs.Vista.Checked or scrRunProgramAs.VistaEx.Checked then
      begin
        if scrRunProgramAs.Vista.Checked and scrRunProgramAs.VistaEx.Checked then
          RunProgramAs[RunProgramAs.IndexOf(Guid) +5] := '$MYAH_UACEY$'
        else
        if scrRunProgramAs.Vista.Checked then
          RunProgramAs[RunProgramAs.IndexOf(Guid) +5] := '$MYAH_UAC$'
        else
          RunProgramAs[RunProgramAs.IndexOf(Guid) +5] := '$MYAH_UACEX$';
        
      end
      else
      
        RunProgramAs[RunProgramAs.IndexOf(Guid) +5] := '';
      begin
        RunProgramAs[RunProgramAs.IndexOf(Guid) +6] := scrRunProgramAs.Password.Text;
        RunProgramAs[RunProgramAs.IndexOf(Guid) +7] := scrRunProgramAs.Domain.Text;
      end;
      RunProgramAs[RunProgramAs.IndexOf(Guid) +8] := scrRunProgramAs.Variable.Text;
      RunProgramAs[RunProgramAs.IndexOf(Guid) +9] := BoolToStr(scrRunProgramAs.WaitFor.Checked);
      
        RunProgramAs[RunProgramAs.IndexOf(Guid) +10] := scrRunProgramAs.Environment.Text;
    end;
  end
  else
  if Kind = 'Run Script' then 
  begin
    scrForceValue := xRunScript[xRunScript.IndexOf(Guid) +6];
    scrRunScript.ScriptType.ItemIndex := StrToInt(xRunScript[xRunScript.IndexOf(Guid) +1]);
    scrRunScript.TimeOut.Value := StrToInt(xRunScript[xRunScript.IndexOf(Guid) +2]);
    scrRunScript.SafeOnly.Checked := StrToBool(xRunScript[xRunScript.IndexOf(Guid) +3]);
    scrRunScript.Interactive.Checked := StrToBool(xRunScript[xRunScript.IndexOf(Guid) +4]);
    if StrToBool(xRunScript[xRunScript.IndexOf(Guid) +5]) then
      scrRunScript.Interactive.State := cbGrayed;
    scrRunScript.Variable.Text := xRunScript[xRunScript.IndexOf(Guid) +6];
    SetMemoFlat(scrRunScript.Script, xRunScript[xRunScript.IndexOf(Guid) +7]);
    if scrRunScript.ShowModal = mrOk then
    begin
      Result := True;
      xRunScript[xRunScript.IndexOf(Guid) +1] := IntToStr(scrRunScript.ScriptType.ItemIndex);
      xRunScript[xRunScript.IndexOf(Guid) +2] := IntToStr(scrRunScript.TimeOut.Value);
      xRunScript[xRunScript.IndexOf(Guid) +3] := BoolToStr(scrRunScript.SafeOnly.Checked);
      xRunScript[xRunScript.IndexOf(Guid) +4] := BoolToStr(scrRunScript.Interactive.Checked);
      xRunScript[xRunScript.IndexOf(Guid) +5] := BoolToStr(scrRunScript.Interactive.State = cbGrayed);
      xRunScript[xRunScript.IndexOf(Guid) +6] := scrRunScript.Variable.Text;
      xRunScript[xRunScript.IndexOf(Guid) +7] := GetMemoFlat(scrRunScript.Script);
    end;
  end
  else
  if Kind = 'Check Process' then 
  begin
    scrForceValue := CheckProcess[CheckProcess.IndexOf(Guid) +2];
    scrCheckProcess.Process.Text := CheckProcess[CheckProcess.IndexOf(Guid) +1];
    scrCheckProcess.Variable.Text := CheckProcess[CheckProcess.IndexOf(Guid) +2];
    if scrCheckProcess.ShowModal = mrOk then
    begin
      Result := True;
      CheckProcess[CheckProcess.IndexOf(Guid) +1] := scrCheckProcess.Process.Text;
      CheckProcess[CheckProcess.IndexOf(Guid) +2] := scrCheckProcess.Variable.Text;
    end;
  end
  else
  if Kind = 'Get File Size' then
  begin
    scrForceValue := xGetFileSize[xGetFileSize.IndexOf(Guid) +1];
    scrGetFileSize.Variable.Text := xGetFileSize[xGetFileSize.IndexOf(Guid) +1];
    scrGetFileSize.Path.Text := xGetFileSize[xGetFileSize.IndexOf(Guid) +2];;
    if scrGetFileSize.ShowModal = mrOk then
    begin
      Result := True;
      xGetFileSize[xGetFileSize.IndexOf(Guid) +1] := scrGetFileSize.Variable.Text;
      xGetFileSize[xGetFileSize.IndexOf(Guid) +2] := scrGetFileSize.Path.Text;
    end;
  end;
  
end;

function Tui.InsertFunction(Kind: String): String;
var
  s, sX, sY: String;
  i, j: Integer;
  l: TStringList;
  xList: THashedStringList;
begin
  
  scrForceValue := '';
  scrForceValueX := '';
  scrForceValueY := '';
  scrForceValueZ := '';
  
  Result := '';
  
  if Kind = 'Hide Dialog' then 
    Result := MyCreateGuid;
  if Kind = 'Display Dialog' then 
  begin
    if DialogFiles.Count = 0 then
    begin
      
      if AddDialog.ShowModal = mrOk then
        Result := InsertFunction('Display Dialog'); 
      Exit;
    end;
    scrDisplayDialog.Dialog.Text := '';
    scrDisplayDialog.Variable.Text := '';
    scrDisplayDialog.Modal.Checked := True;
    scrDisplayDialog.IfVariable.Text := '';
    scrDisplayDialog.vTrue.Checked := True;
    scrDisplayDialog.vFalse.Checked := false;
    if scrDisplayDialog.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      DisplayDialog.Add(Result);
      DisplayDialog.Add(scrDisplayDialog.Dialog.Text);
      DisplayDialog.Add(scrDisplayDialog.Variable.Text);
      DisplayDialog.Add(MyBoolToStr(scrDisplayDialog.Modal.Checked, True));
      DisplayDialog.Add(scrDisplayDialog.IfVariable.Text);
      DisplayDialog.Add(MyBoolToStr(scrDisplayDialog.vTrue.Checked, True));
      DisplayDialog.Add(MyBoolToStr(scrDisplayDialog.vFalse.Checked, True));
    end;
  end
  else
  if Kind = 'Read from Text File' then 
  begin
    scrReadText.Text.Text := '';
    scrReadText.Value.Text := '';
    scrReadText.Variable.Text := '';
    if scrReadText.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      ReadText.Add(Result);
      ReadText.Add(scrReadText.Text.Text);
      ReadText.Add(scrReadText.Value.Text);
      ReadText.Add(scrReadText.Variable.Text);
    end;
  end
  else
  if Kind = 'Write to Text File' then 
  begin
    scrWriteText.Text.Text := '';
    scrWriteText.Value.Text := '';
    scrWriteText.StartFile.Checked := false;
    scrWriteText.EndFile.Checked := True;
    if scrWriteText.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      WriteText.Add(Result);
      WriteText.Add(scrWriteText.Text.Text);
      WriteText.Add(scrWriteText.Value.Text);
      WriteText.Add(BoolToStr(scrWriteText.StartFile.Checked));
      WriteText.Add(BoolToStr(scrWriteText.EndFile.Checked));
    end;
  end
  else
  if Kind = 'Define Component' then 
  begin
    scrDefineComponent.ComponentName.Text := '';
    scrDefineComponent.Selection.Checked := True;
    scrDefineComponent.Description.Lines.Clear;
    if scrDefineComponent.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      DefComponent.Add(Result);
      DefComponent.Add(scrDefineComponent.ComponentName.Text);
      DefComponent.Add(MyBoolToStr(scrDefineComponent.Selection.Checked, True));
      DefComponent.Add(GetMemoFlat(scrDefineComponent.Description));
    end;
  end
  else
  if Kind = 'Set Component State' then 
  begin
    scrSetComponent.ComponentName.Text := '';
    scrSetComponent.Selection.Checked := True;
    if scrSetComponent.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      SetComponent.Add(Result);
      SetComponent.Add(scrSetComponent.ComponentName.Text);
      SetComponent.Add(MyBoolToStr(scrSetComponent.Selection.Checked, True));
    end;
  end
  else
  if Kind = 'Get Component State' then 
  begin
    scrGetComponent.ComponentName.Text := '';
    scrGetComponent.State.Text := '';
    if scrGetComponent.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      GetComponent.Add(Result);
      GetComponent.Add(scrGetComponent.ComponentName.Text);
      GetComponent.Add(scrGetComponent.State.Text);
    end;
  end
  else
  if Kind = 'Delete Component' then 
  begin
    scrDeleteComponent.ComponentName.Text := '';
    if scrDeleteComponent.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      DelComp.Add(Result);
      DelComp.Add(scrDeleteComponent.ComponentName.Text);
    end;
  end
  else
  if Kind = 'Set Component Space' then 
  begin
    scrSpaceComponent.ComponentName.Text := '';
    scrSpaceComponent.ComponentSpace.Text := '';
    if scrSpaceComponent.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      SpaceFeatures.Add(Result);
      SpaceFeatures.Add(scrSpaceComponent.ComponentName.Text);
      SpaceFeatures.Add(scrSpaceComponent.ComponentSpace.Text);
    end;
  end
  else
  if Kind = 'Install Files' then 
  begin
    scrInstallFiles.Source.Text := '';
    scrInstallFiles.Recursive.Checked := false;
    scrInstallFiles.Exclude.Text := '';
    scrInstallFiles.Target.Text := '';
    scrInstallFiles.ReadOnly.Checked := false;
    scrInstallFiles.Hidden.Checked := false;
    scrInstallFiles.System.Checked := false;
    scrInstallFiles.Vital.Checked := false;
    scrInstallFiles.Checksum.Checked := false;
    scrInstallFiles.SelfReg.Checked := false;
    scrInstallFiles.Shared.Checked := false;
    scrInstallFiles.Permanent.Checked := false;
    scrInstallFiles.Overwrite.Checked := false;
    if scrInstallFiles.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      InstallFiles.Add(Result);
      InstallFiles.Add(scrInstallFiles.Source.Text);
      InstallFiles.Add(MyBoolToStr(scrInstallFiles.Recursive.Checked, True) + '|' + scrInstallFiles.Exclude.Text);
      InstallFiles.Add(scrInstallFiles.Target.Text);
      InstallFiles.Add(MyBoolToStr(scrInstallFiles.ReadOnly.Checked, True));
      InstallFiles.Add(MyBoolToStr(scrInstallFiles.Hidden.Checked, True));
      InstallFiles.Add(MyBoolToStr(scrInstallFiles.System.Checked, True));
      InstallFiles.Add(MyBoolToStr(scrInstallFiles.Vital.Checked, True));
      InstallFiles.Add(MyBoolToStr(scrInstallFiles.Checksum.Checked, True));
      InstallFiles.Add(MyBoolToStr(scrInstallFiles.SelfReg.Checked, True));
      InstallFiles.Add(MyBoolToStr(scrInstallFiles.Shared.Checked, True));
      InstallFiles.Add(MyBoolToStr(scrInstallFiles.Permanent.Checked, True));
      InstallFiles.Add(MyBoolToStr(scrInstallFiles.Overwrite.Checked, True));
    end;
  end
  else
  if Kind = 'Create Folder' then 
  begin
    scrCreateFolder.Folder.Text := '';
    if scrCreateFolder.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      CreateFolder.Add(Result);
      CreateFolder.Add(scrCreateFolder.Folder.Text);
    end;
  end
  else
  if Kind = 'Comment' then 
  begin
    scrComment.Comment.Text := '';
    if scrComment.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      Comments.Add(Result);
      Comments.Add(scrComment.Comment.Text);
    end;
  end
  else
  if Kind = 'Get Folder Location' then 
  begin
    scrGetFolderLocation.Variable.Text := '';
    scrGetFolderLocation.Folder.ItemIndex := 0;
    scrGetFolderLocation.AllUsers.Checked := True;
    if scrGetFolderLocation.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      GetFolderLocation.Add(Result);
      GetFolderLocation.Add(scrGetFolderLocation.Variable.Text);
      GetFolderLocation.Add(IntToStr(scrGetFolderLocation.Folder.ItemIndex));
      GetFolderLocation.Add(MyBoolToStr(scrGetFolderLocation.AllUsers.Checked, True));
    end;
  end
  else
  if Kind = 'Include Script' then 
  begin
    if IncludeFiles.Count = 0 then
    begin
      
      Project.AddIncludeClick(Self);
      if IncludeFiles.Count = 0 then Exit;
    end;
    scrInclude.Script.Text := '';
    scrInclude.Variable.Text := '';
    if scrInclude.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      xInclude.Add(Result);
      xInclude.Add(scrInclude.Script.Text + '|' + scrInclude.Variable.Text);
    end;
  end
  else
  if Kind = 'MessageBox' then 
  begin
    scrMessageBox.Title.Text := '';
    scrMessageBox.Message.Lines.Clear;
    mscrMessageBox.IconItemIndex := 0;
    scrMessageBox.Buttons.ItemIndex := 1;
    scrMessageBox.Variable.Text := '';
    if scrMessageBox.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      xMessageBox.Add(Result);
      xMessageBox.Add(scrMessageBox.Title.Text);
      xMessageBox.Add(GetMemoFlat(scrMessageBox.Message));
      xMessageBox.Add(IntToStr(mscrMessageBox.IconItemIndex));
      xMessageBox.Add(IntToStr(scrMessageBox.Buttons.ItemIndex));
      xMessageBox.Add(scrMessageBox.Variable.Text);
    end;
  end
  else
  if Kind = 'Run Program' then 
  begin
    scrRunProgram.RunProgram.Text := '';
    scrRunProgram.HideWindow.Checked := false;
    scrRunProgram.CommandLine.Text := '';
    scrRunProgram.WaitFor.Checked := false;
    scrRunProgram.Variable.Text := '';
    if scrRunProgram.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      RunProgram.Add(Result);
      RunProgram.Add(scrRunProgram.RunProgram.Text);
      RunProgram.Add(MyBoolToStr(scrRunProgram.HideWindow.Checked, True));
      RunProgram.Add(scrRunProgram.CommandLine.Text);
      RunProgram.Add(MyBoolToStr(scrRunProgram.WaitFor.Checked, True));
      RunProgram.Add(scrRunProgram.Variable.Text);
    end;
  end
  else
  if (Kind = 'Create Shortcut') or (Kind = 'Advertised Shortcut') then 
  begin
    AllowBypass := True;
    scrCreateShortcut.Caption := Kind;
    scrCreateShortcut.Target.Text := '';
    scrCreateShortcut.Source.Text := '';
    scrCreateShortcut.Location.Text := '';
    scrCreateShortcut.Description.Text := '';
    scrCreateShortcut.Params.Text := '';
    scrCreateShortcut.Startup.Text := '';
    scrCreateShortcut.IconPath.Text := '';
    scrCreateShortcut.IconIndex.Text := '';
    scrCreateShortcut.WindowSize.ItemIndex := 0;
    scrCreateShortcut.PinXP.Checked := false;
    scrCreateShortcut.Pin7.Checked := false;
    scrCreateShortcut.Pin8.Checked := false;
    scrCreateShortcut.AppUserID.Text := '';
    scrCreateShortcut.DoNot.Checked := false;
    scrCreateShortcut.RunAs.Checked := false;
    scrCreateShortcut.NoAuto.Checked := false;
    scrCreateShortcut.NoPin.Checked := false;
    AllowBypass := false;
    if scrCreateShortcut.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      Short.Add(Result);
      Short.Add(scrCreateShortcut.Target.Text + '|' + BoolToStr(scrCreateShortcut.NoPin.Checked));
      Short.Add(scrCreateShortcut.Source.Text);
      Short.Add(scrCreateShortcut.Location.Text + '|' + BoolToStr(scrCreateShortcut.NoAuto.Checked));
      Short.Add(scrCreateShortcut.Description.Text);
      Short.Add(scrCreateShortcut.Params.Text);
      Short.Add(scrCreateShortcut.Startup.Text + '|' + BoolToStr(scrCreateShortcut.RunAs.Checked));
      Short.Add(scrCreateShortcut.IconPath.Text + '|' + BoolToStr(scrCreateShortcut.DoNot.Checked));
      Short.Add(scrCreateShortcut.IconIndex.Text + '|' + scrCreateShortcut.AppUserID.Text);
      sY := '';
      if scrCreateShortcut.PinXP.Checked then
        sY := sY + 'X';
      if scrCreateShortcut.Pin7.Checked then
        sY := sY + '7';
      if scrCreateShortcut.Pin8.Checked then
        sY := sY + '8';
      Short.Add(IntToStr(scrCreateShortcut.WindowSize.ItemIndex) + '|' + sY);
    end;
  end
  else
  if Kind = 'Set Variable' then 
  begin
    scrSetVariable.Variable.Text := '';
    scrSetVariable.Value.Text := '';
    scrSetVariable.Persist.Checked := false;
    if scrSetVariable.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      SetVariable.Add(Result);
      if scrSetVariable.Persist.Checked then
        sX := 'TRUE' 
      else
        sX := 'FALSE'; 
      SetVariable.Add(scrSetVariable.Variable.Text + '$MYAH$MYAH$' + sX); 
      SetVariable.Add(scrSetVariable.Value.Text);
    end;
  end
  else
  if ((Kind = 'If') or (Kind = 'Else If')) or
    ((Kind = 'Compiler Variable If') or ((Kind = 'While') or (Kind = 'Until'))) then 
  begin
    scrIf.Caption := Kind;
    scrIf.Variable.Text := '';
    scrIf.Comparison.ItemIndex := 0;
    scrIf.CompareWith.Text := '';
    scrIf.notCheck.Checked := false;
    if Kind = 'Compiler Variable If' then
      scrIf.Comparison.Items.Delete(scrIf.Comparison.Items.Count -1);
    if Kind = 'While' then
      scrIf.notCheck.Caption := 'Reverse Comparison (While &Not)'
    else
    if Kind = 'Until' then
      scrIf.notCheck.Caption := 'Reverse Comparison (Until &Not)'
    else
      scrIf.notCheck.Caption := 'Reverse Comparison (If &Not)';
    if scrIf.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      if Kind = 'While' then
        xList := xWhile
      else
      if Kind = 'Until' then
        xList := xUntil
      else
        xList := xIf;
      xList.Add(Result);
      xList.Add(scrIf.Variable.Text);
      xList.Add(IntToStr(scrIf.Comparison.ItemIndex));
      xList.Add(scrIf.CompareWith.Text);
      xList.Add(MyBoolToStr(scrIf.notCheck.Checked, True));
    end;
    if Kind = 'Compiler Variable If' then
      scrIf.Comparison.Items.Add('Greater Than (Version)');
  end
  else
  if (((Kind = 'End') or (Kind = 'Compiler Variable End')) or ((Kind = 'Wend') or ((Kind = 'Repeat') or ((Kind = 'Break') or (Kind = 'Continue'))))) or (Kind = 'Next') then 
    Result := MyCreateGuid
  else
  if (Kind = 'Else') or (Kind = 'Compiler Variable Else') then 
    Result := MyCreateGuid
  else
  if Kind = 'Label' then 
  begin
    scrLabel.eLabel.Text := '';
    if scrLabel.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      eLabel.Add(Result);
      eLabel.Add(scrLabel.eLabel.Text);
    end;
  end
  else
  if Kind = 'GoTo Label' then 
  begin
    scrGotoLabel.gLabelEx.Text := '';
    if scrGotoLabel.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      gLabel.Add(Result);
      gLabel.Add(scrGotoLabel.gLabelEx.Text);
    end;
  end
  else
  if Kind = 'Wizard Loop' then 
    Result := MyCreateGuid
  else
  if Kind = 'Terminate Install' then 
    Result := MyCreateGuid
  else
  if Kind = 'Apply Changes' then 
  begin
    scrApplyChanges.Dialog.Text := '';
    scrApplyChanges.Variable.Text := '';
    scrApplyChanges.Install.Checked := True;
    scrApplyChanges.Advertise.Checked := false;
    scrApplyChanges.Uninstall.Checked := false;
    if scrApplyChanges.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      ApplyChanges.Add(Result);
      ApplyChanges.Add(scrApplyChanges.Dialog.Text);
      ApplyChanges.Add(scrApplyChanges.Variable.Text);
      ApplyChanges.Add(MyBoolToStr(scrApplyChanges.Install.Checked, True));
      ApplyChanges.Add(MyBoolToStr(scrApplyChanges.Uninstall.Checked, True));
    end;
  end
  else
  if Kind = 'Download File' then 
  begin
    scrDownload.Url.Text := 'https://';
    scrDownload.Local.Text := '';
    scrDownload.Variable.Text := '';
    scrDownload.Server.Text := '';
    scrDownload.Port.Text := '';
    scrDownload.Resume.Checked := True;
    if scrDownload.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      DownloadFile.Add(Result);
      DownloadFile.Add(scrDownload.URL.Text);
      DownloadFile.Add(scrDownload.Local.Text);
      DownloadFile.Add(scrDownload.Variable.Text);
      DownloadFile.Add(scrDownload.Server.Text);
      DownloadFile.Add(scrDownload.Port.Text);
      DownloadFile.Add(MyBoolToStr(scrDownload.Resume.Checked, True));
    end;
  end
  else
  if Kind = 'File Bag' then 
  begin
    scrFileBag.Bag.Text := '';
    scrFileBag.Subfolder.Checked := false;
    scrFileBag.Exclude.Text := '';
    scrFileBag.Variable.Text := '';
    if scrFileBag.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      FileBag.Add(Result);
      FileBag.Add(scrFileBag.Bag.Text);
      FileBag.Add(MyBoolToStr(scrFileBag.Subfolder.Checked));
      FileBag.Add(scrFileBag.Exclude.Text);
      FileBag.Add(scrFileBag.Variable.Text);
    end;
  end
  else
  if Kind = 'Web Media Block' then 
  begin
    scrWebMediaBlock.BlockName.Text := '';
    scrWebMediaBlock.Password.Text := '';
    scrWebMediaBlock.DownURL.Lines.Text := 'http://'; 
    
    scrWebMediaBlock.Skip.Checked := false;
    if scrWebMediaBlock.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      MediaBlock.Add(Result);
      MediaBlock.Add(scrWebMediaBlock.BlockName.Text);
      MediaBlock.Add(GetMemoFlat(scrWebMediaBlock.DownURL));
      MediaBlock.Add(BoolToStr(scrWebMediaBlock.Skip.Checked) + '$MYAH_CARET$' + 
        scrWebMediaBlock.Password.Text);
    end;
  end
  else
  if Kind = 'Delete Files' then 
  begin
    scrDeleteFiles.Folder.Text := '';
    scrDeleteFiles.Files.Text := '';
    scrDeleteFiles.Installing.Checked := True;
    scrDeleteFiles.Uninstalling.Checked := false;
    if scrDeleteFiles.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      DeleteFiles.Add(Result);
      DeleteFiles.Add(scrDeleteFiles.Folder.Text);
      DeleteFiles.Add(scrDeleteFiles.Files.Text);
      DeleteFiles.Add(BoolToStr(scrDeleteFiles.Installing.Checked));
      DeleteFiles.Add(BoolToStr(scrDeleteFiles.Uninstalling.Checked));
    end;
  end
  else
  if Kind = 'Remove Directory' then 
  begin
    scrRmDir.Path.Text := '';
    if scrRmDir.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      RmDir.Add(Result);
      RmDir.Add(scrRmDir.Path.Text);
    end;
  end
  else
  if Kind = 'Create Link' then 
  begin
    scrCreateLink.Source.Text := '';
    scrCreateLink.Target.Text := '';
    scrCreateLink.Soft.Checked := True;
    scrCreateLink.Hard.Checked := false;
    scrCreateLink.Shared.Checked := false;
    if scrCreateLink.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      CreateLink.Add(Result);
      CreateLink.Add(scrCreateLink.Source.Text);
      CreateLink.Add(scrCreateLink.Target.Text);
      CreateLink.Add(BoolToStr(scrCreateLink.Soft.Checked));
      CreateLink.Add(BoolToStr(scrCreateLink.Hard.Checked));
      CreateLink.Add(BoolToStr(scrCreateLink.Shared.Checked));
    end;
  end
  else
  if (Kind = 'Create File Type') or (Kind = 'Advertised File Type') then 
  begin
    scrCreateFileType.Caption := Kind;
    scrCreateFileType.FileType.Text := '';
    scrCreateFileType.OpensWith.Text := '';
    scrCreateFileType.Description.Text := '';
    scrCreateFileType.IconFile.Text := '';
    scrCreateFileType.IconNumber.Text := '';
    scrCreateFileType.ExtensionsList.Items.Clear;
    scrCreateFileType.Verbs.Items.Clear;
    scrCreateFileType.Default.Checked := True;
    scrCreateFileType.AllUsers.Checked := false;
    scrCreateFileType.CurrentUser.Checked := false;
    scrCreateFileType.OpenWithProgIDs.Checked := True;
    scrCreateFileType.UserChoice.Checked := True;
    if scrCreateFileType.ShowModal = mrOk then
    begin
      Result := MyCreateGUID;
      FileType.Add(Result);
      FileType.Add(scrCreateFileType.FileType.Text + '|' + BoolToStr(scrCreateFileType.OpenWithProgIDs.Checked));
      FileType.Add(scrCreateFileType.OpensWith.Text + '|' + BoolToStr(scrCreateFileType.UserChoice.Checked));
      FileType.Add(scrCreateFileType.Description.Text + '|' + BoolToStr(scrCreateFileType.Default.Checked));
      FileType.Add(scrCreateFileType.IconFile.Text + '|' + BoolToStr(scrCreateFileType.AllUsers.Checked));
      FileType.Add(scrCreateFileType.IconNumber.Text + '|' + BoolToStr(scrCreateFileType.CurrentUser.Checked));
      FileType.Add(scrCreateFileType.ExtensionsList.Items.CommaText);
      
      FileType.Add(FlatBuffer);
    end;
  end
  else
  if Kind = 'Delete Files Recursive' then 
  begin
    scrDeleteFilesRecursive.Path.Text := '';
    if scrDeleteFilesRecursive.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      DeleteRec.Add(Result);
      DeleteRec.Add(scrDeleteFilesRecursive.Path.Text);
    end;
  end
  else
  if Kind = 'Mathematics' then 
  begin
    scrMathematics.Operand1.Text := '';
    scrMathematics.Operand2.Text := '';
    scrMathematics.Operation.ItemIndex := 0;
    scrMathematics.Variable.Text := '';
    scrForceValue := scrMathematics.Variable.Text;
    if scrMathematics.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      Maths.Add(Result);
      Maths.Add(scrMathematics.Operand1.Text);
      Maths.Add(scrMathematics.Operand2.Text);
      Maths.Add(IntToStr(scrMathematics.Operation.ItemIndex));
      Maths.Add(scrMathematics.Variable.Text);
    end;
  end
  else
  if Kind = 'Parse String' then 
  begin
    scrParseString.ParseString.Text := '';
    scrParseString.SmartPosition.Text := '';
    scrParseString.FirstVar.Text := '';
    scrParseString.SecondVar.Text := '';
    scrParseString.Operation.ItemIndex := 0;
    scrParseString.Trim.Checked := false;
    scrParseString.Ignore.Checked := false;
    if scrParseString.ShowModal = mrOk then
    begin
      Result := MyCreateGUID;
      Parse.Add(Result);
      Parse.Add(scrParseString.ParseString.Text);
      Parse.Add(scrParseString.SmartPosition.Text);
      Parse.Add(scrParseString.FirstVar.Text);
      Parse.Add(scrParseString.SecondVar.Text);
      Parse.Add(IntToStr(scrParseString.Operation.ItemIndex));
      Parse.Add(BoolToStr(scrParseString.Trim.Checked));
      Parse.Add(BoolToStr(scrParseString.Ignore.Checked));
    end;
  end
  else
  if Kind = 'Code Folding Region' then 
  begin
    CurrentRegionName := '';
    scrRegion.DefineRegion.Checked := True;
    scrRegion.Region.Text := '';
    scrRegion.CloseRegion.Checked := not scrRegion.DefineRegion.Checked;
    if scrRegion.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      Region.Add(Result);
      Region.Add(BoolToStr(scrRegion.DefineRegion.Checked));
      if scrRegion.DefineRegion.Checked then
        Region.Add(scrRegion.Region.Text)
      else
        Region.Add('');
    end;
  end
  else
  if Kind = 'Set Access Control' then 
  begin
    scrAccessControl.ObjectPath.Text := '';
    scrAccessControl.Everyone.Checked := false;
    scrAccessControl.Current.Checked := false;
    scrAccessControl.Authenticated.Checked := false;
    scrAccessControl.Named.Checked := false;
    scrAccessControl.Account.Text := '';
    scrAccessControl.arRead.Checked := false;
    scrAccessControl.arWrite.Checked := false;
    scrAccessControl.arExec.Checked := false;
    scrAccessControl.SetAccounts.Checked := True;
    scrAccessControl.PurgeAll.Checked := false;
    scrAccessControl.GrantAll.Checked := false;
    scrAccessControl.FileSystem.Checked := True;
    scrAccessControl.Share.Checked := false;
    scrAccessControl.Registry.Checked := false;
    scrAccessControl.Service.Checked := false;
    scrAccessControl.Printer.Checked := false;
    if scrAccessControl.ShowModal = mrOk then
    begin
      Result := MyCreateGUID;
      ACL.Add(Result);
      ACL.Add(scrAccessControl.ObjectPath.Text);
      ACL.Add(BoolToStr(scrAccessControl.Everyone.Checked));
      ACL.Add(BoolToStr(scrAccessControl.Current.Checked));
      ACL.Add(BoolToStr(scrAccessControl.Authenticated.Checked));
      ACL.Add(BoolToStr(scrAccessControl.Named.Checked));
      ACL.Add(scrAccessControl.Account.Text);
      ACL.Add(BoolToStr(scrAccessControl.arRead.Checked));
      ACL.Add(BoolToStr(scrAccessControl.arWrite.Checked) + '|' +
        BoolToStr(scrAccessControl.arExec.Checked));
      ACL.Add(BoolToStr(scrAccessControl.SetAccounts.Checked));
      ACL.Add(BoolToStr(scrAccessControl.PurgeAll.Checked));
      ACL.Add(BoolToStr(scrAccessControl.GrantAll.Checked));
      ACL.Add(BoolToStr(scrAccessControl.FileSystem.Checked));
      ACL.Add(BoolToStr(scrAccessControl.Share.Checked));
      ACL.Add(BoolToStr(scrAccessControl.Registry.Checked));
      ACL.Add(BoolToStr(scrAccessControl.Service.Checked));
      ACL.Add(BoolToStr(scrAccessControl.Printer.Checked));
    end;
  end
  else
  if Kind = 'Set Owner' then 
  begin
    scrSetOwner.ObjectPath.Text := '';
    scrSetOwner.Current.Checked := false;
    scrSetOwner.Root.Checked := false;
    scrSetOwner.Named.Checked := false;
    scrSetOwner.Account.Text := '';
    if scrSetOwner.ShowModal = mrOk then
    begin
      Result := MyCreateGUID;
      Own.Add(Result);
      Own.Add(scrSetOwner.ObjectPath.Text);
      Own.Add(BoolToStr(scrSetOwner.Current.Checked));
      Own.Add(BoolToStr(scrSetOwner.Root.Checked));
      Own.Add(BoolToStr(scrSetOwner.Named.Checked));
      Own.Add(scrSetOwner.Account.Text);
    end;
  end
  else
  if Kind = 'Set Group' then 
  begin
    scrSetGroup.ObjectPath.Text := '';
    scrSetGroup.GroupName.Text := '';
    if scrSetGroup.ShowModal = mrOk then
    begin
      Result := MyCreateGUID;
      Grp.Add(Result);
      Grp.Add(scrSetGroup.ObjectPath.Text);
      Grp.Add(scrSetGroup.GroupName.Text);
    end;
  end
  else
  if Kind = 'Get File Version' then 
  begin
    scrGetFileVersion.FilePath.Text := '';
    scrGetFileVersion.Variable.Text := '';
    if scrGetFileVersion.ShowModal = mrOk then
    begin
      Result := MyCreateGUID;
      GetVers.Add(Result);
      GetVers.Add(scrGetFileVersion.FilePath.Text);
      GetVers.Add(scrGetFileVersion.Variable.Text);
    end;
  end
  else
  if Kind = 'Check File Version' then 
  begin
    scrCheckFileVersion.Variable.Text := '';
    scrCheckFileVersion.File1.Text := '';
    scrCheckFileVersion.WithFile.Checked := True;
    scrCheckFileVersion.File2.Text := '';
    scrCheckFileVersion.Text.Text := '';
    if scrCheckFileVersion.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      CheckVersion.Add(Result);
      CheckVersion.Add(scrCheckFileVersion.Variable.Text);
      CheckVersion.Add(scrCheckFileVersion.File1.Text);
      CheckVersion.Add(BoolToStr(scrCheckFileVersion.WithFile.Checked));
      CheckVersion.Add(scrCheckFileVersion.File2.Text);
      CheckVersion.Add(scrCheckFileVersion.Text.Text);
    end;
  end
  else
  if Kind = 'For Each' then
  begin
    scrForEach.Element.Text := '';
    scrForEach.Separator.Text := '';
    scrForEach.Collection.Text := '';
    if scrForEach.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      xForEach.Add(Result);
      xForEach.Add(scrForEach.Element.Text);
      xForEach.Add(scrForEach.Separator.Text);
      xForEach.Add(scrForEach.Collection.Text);
    end;
  end
  else
  if Kind = 'Sleep' then
  begin
    scrSleep.Duration.Value := 0;
    if scrSleep.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      xSleep.Add(Result);
      xSleep.Add(IntToStr(scrSleep.Duration.Value));
    end;
  end
  else
  if Kind = 'Terminate with Exit Code' then 
  begin
    scrTerminateWithExitCode.ExitCode.Text := '';
    if scrTerminateWithExitCode.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      TermExitCode.Add(Result);
      TermExitCode.Add(scrTerminateWithExitCode.ExitCode.Text);
    end;
  end
  else
  if Kind = 'Convert Case' then 
  begin
    scrConvertCase.Variable.Text := '';
    scrConvertCase.Upper.Checked := True;
    scrConvertCase.Lower.Checked := false;
    if scrConvertCase.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      ConvertCase.Add(Result);
      ConvertCase.Add(scrConvertCase.Variable.Text);
      ConvertCase.Add(BoolToStr(scrConvertCase.Upper.Checked));
    end;
  end
  else
  if Kind = 'Convert Path' then 
  begin
    scrConvertPath.Variable.Text := '';
    scrConvertPath.ShortPath.Checked := True;
    if scrConvertPath.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      ConvertPath.Add(Result);
      ConvertPath.Add(scrConvertPath.Variable.Text);
      ConvertPath.Add(BoolToStr(scrConvertPath.ShortPath.Checked));
    end;
  end
  else
  if Kind = 'Evaluate Expression' then 
  begin
    scrEvaluate.Expression.Text := '';
    scrEvaluate.Variable.Text := '';
    if scrEvaluate.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      Eval.Add(Result);
      Eval.Add(scrEvaluate.Expression.Text);
      Eval.Add(scrEvaluate.Variable.Text);
    end;
  end
  else
  if Kind = 'Extract Path' then 
  begin
    scrExtractPath.Variable.Text := '';
    scrExtractPath.Operation.ItemIndex := 0;
    if scrExtractPath.ShowModal = mrOk then
    begin
      Result := MyCreateGUID;
      ExtractPath.Add(Result);
      ExtractPath.Add(scrExtractPath.Variable.Text);
      ExtractPath.Add(IntToStr(scrExtractPath.Operation.ItemIndex));
    end;
  end
  else
  if Kind = 'Format String' then
  begin
    scrFormatStr.Variable.Text := '';
    scrFormatStr.Format.Text := '';
    scrFormatStr.Literal.Text := '';
    if scrFormatStr.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      FormatStr.Add(Result);
      FormatStr.Add(scrFormatStr.Variable.Text);
      FormatStr.Add(scrFormatStr.Format.Text);
      FormatStr.Add(scrFormatStr.Literal.Text);
    end;
  end
  else
  if Kind = 'Get String Length' then
  begin
    scrGetStrLen.Literal.Text := '';
    scrGetStrLen.Variable.Text := '';
    if scrGetStrLen.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      GetStrLen.Add(Result);
      GetStrLen.Add(scrGetStrLen.Literal.Text);
      GetStrLen.Add(scrGetStrLen.Variable.Text);
    end;
  end
  else
  if Kind = 'Get String Position' then
  begin
    scrGetStrPos.Variable.Text := '';
    scrGetStrPos.Substring.Text := '';
    scrGetStrPos.Literal.Text := '';
    scrGetStrPos.IgnoreCase.Checked := True;
    if scrGetStrPos.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      GetStrPos.Add(Result);
      GetStrPos.Add(scrGetStrPos.Variable.Text);
      GetStrPos.Add(scrGetStrPos.Substring.Text);
      GetStrPos.Add(scrGetStrPos.Literal.Text);
      GetStrPos.Add(BoolToStr(scrGetStrPos.IgnoreCase.Checked));
    end;
  end
  else
  if Kind = 'Localization Variable' then 
  begin
    scrLocalizationVariable.Variable.Text := '';
    scrLocalizationVariable.Value.Text := '';
    if scrLocalizationVariable.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      LocVar.Add(Result);
      LocVar.Add(scrLocalizationVariable.Variable.Text);
      LocVar.Add(scrLocalizationVariable.Value.Text);
    end;
  end
  else
  if Kind = 'Match Regular Expression' then
  begin
    scrRegEx.Variable.Text := '';
    scrRegEx.Ex.Text := '';
    scrRegEx.Match.Text := '';
    if scrRegEx.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      RegEx.Add(Result);
      RegEx.Add(scrRegEx.Variable.Text);
      RegEx.Add(scrRegEx.Ex.Text);
      RegEx.Add(scrRegEx.Match.Text);
    end;
  end
  else
  if Kind = 'Replace String' then 
  begin
    scrReplaceString.Variable.Text := '';
    scrReplaceString.OldPattern.Text := '';
    scrReplaceString.NewPattern.Text := '';
    scrReplaceString.IgnoreCase.Checked := True;
    scrReplaceString.ReplaceAll.Checked := True;
    if scrReplaceString.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      ReplaceStr.Add(Result);
      ReplaceStr.Add(scrReplaceString.Variable.Text);
      ReplaceStr.Add(scrReplaceString.OldPattern.Text);
      ReplaceStr.Add(scrReplaceString.NewPattern.Text);
      ReplaceStr.Add(BoolToStr(scrReplaceString.IgnoreCase.Checked));
      ReplaceStr.Add(BoolToStr(scrReplaceString.ReplaceAll.Checked));
    end;
  end
  else
  if Kind = 'Browse for Folder' then
  begin
    scrBrowseFolder.Title.Text := '';
    scrBrowseFolder.Root.Text := '';
    scrBrowseFolder.Variable.Text := '';
    if scrBrowseFolder.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      xBrowseFolder.Add(Result);
      xBrowseFolder.Add(scrBrowseFolder.Title.Text);
      xBrowseFolder.Add(scrBrowseFolder.Root.Text);
      xBrowseFolder.Add(scrBrowseFolder.Variable.Text);
    end;
  end
  else
  if Kind = 'Browse for File' then
  begin
    scrBrowseFile.Title.Text := '';
    scrBrowseFile.Open.Checked := True;
    scrBrowseFile.Save.Checked := false;
    scrBrowseFile.Variable.Text := '';
    scrBrowseFile.Extension.Text := '';
    scrBrowseFile.Default.Text := '';
    scrBrowseFile.Filter.Text := '';
    if scrBrowseFile.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      xBrowseFile.Add(Result);
      xBrowseFile.Add(scrBrowseFile.Title.Text);
      xBrowseFile.Add(BoolToStr(scrBrowseFile.Open.Checked));
      xBrowseFile.Add(BoolToStr(scrBrowseFile.Save.Checked));
      xBrowseFile.Add(scrBrowseFile.Variable.Text);
      xBrowseFile.Add(scrBrowseFile.Extension.Text);
      xBrowseFile.Add(scrBrowseFile.Default.Text);
      xBrowseFile.Add(scrBrowseFile.Filter.Text);
    end;
  end
  else
  if Kind = 'Load Feature Selections' then 
  begin
    scrLoadFeatures.FilePath.Text := '';
    if scrLoadFeatures.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      LoadFeatures.Add(Result);
      LoadFeatures.Add(scrLoadFeatures.FilePath.Text);
    end;
  end
  else
  if Kind = 'Prompt for Text' then
  begin
    scrPromptForText.Title.Text := '';
    scrPromptForText.Variable.Text := '';
    scrPromptForText.Message.Lines.Clear;
    if scrPromptForText.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      xPromptForText.Add(Result);
      xPromptForText.Add(scrPromptForText.Title.Text);
      xPromptForText.Add(scrPromptForText.Variable.Text);
      xPromptForText.Add(GetMemoFlat(scrPromptForText.Message));
    end;
  end
  else
  if Kind = 'Save Feature Selections' then 
  begin
    scrSaveFeatures.FilePath.Text := '';
    if scrSaveFeatures.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      SaveFeatures.Add(Result);
      SaveFeatures.Add(scrSaveFeatures.FilePath.Text);
    end;
  end
  else
  if Kind = 'Set Component Choice' then 
  begin
    scrSetComponentChoice.ComponentName.Text := '';
    scrSetComponentChoice.Choice.Checked := True;
    if scrSetComponentChoice.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      SetChoice.Add(Result);
      SetChoice.Add(scrSetComponentChoice.ComponentName.Text);
      SetChoice.Add(BoolToStr(scrSetComponentChoice.Choice.Checked));
    end;
  end
  else
  if Kind = 'Get Component Space' then 
  begin
    scrGetComponentSpace.ComponentName.Text := '';
    scrGetComponentSpace.Space.Text := '';
    if scrGetComponentSpace.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      GetSpace.Add(Result);
      GetSpace.Add(scrGetComponentSpace.ComponentName.Text);
      GetSpace.Add(scrGetComponentSpace.Space.Text);
    end;
  end
  else
  if Kind = 'Set Component Visibility' then 
  begin
    scrSetComponentVisibility.ComponentName.Text := '';
    scrSetComponentVisibility.Visibility.Checked := True;
    if scrSetComponentVisibility.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      SetVisibility.Add(Result);
      SetVisibility.Add(scrSetComponentVisibility.ComponentName.Text);
      SetVisibility.Add(BoolToStr(scrSetComponentVisibility.Visibility.Checked));
    end;
  end
  else
  if Kind = 'Check Disk Space' then 
  begin
    scrCheckDiskSpace.Variable.Text := '';
    scrCheckDiskSpace.DiskPath.Text := '';
    scrCheckDiskSpace.Available.Checked := True;
    scrCheckDiskSpace.Total.Checked := false;
    if scrCheckDiskSpace.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      CheckSpace.Add(Result);
      CheckSpace.Add(scrCheckDiskSpace.Variable.Text);
      CheckSpace.Add(scrCheckDiskSpace.DiskPath.Text);
      CheckSpace.Add(BoolToStr(scrCheckDiskSpace.Available.Checked));
      CheckSpace.Add(BoolToStr(scrCheckDiskSpace.Total.Checked));
    end;
  end
  else
  if Kind = 'Does File/Folder Exist' then 
  begin
    scrFileFolderExist.Variable.Text := '';
    scrFileFolderExist.Path.Text := '';
    scrFileFolderExist.CheckFile.Checked := True;
    scrFileFolderExist.CheckFolder.Checked := false;
    scrFileFolderExist.Link.Checked := false;
    if scrFileFolderExist.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      DoesExist.Add(Result);
      DoesExist.Add(scrFileFolderExist.Variable.Text);
      DoesExist.Add(scrFileFolderExist.Path.Text);
      DoesExist.Add(BoolToStr(scrFileFolderExist.CheckFile.Checked) + '|' +
        BoolToStr(scrFileFolderExist.Link.Checked));
    end;
  end
  else
  if Kind = 'Get Link Target' then
  begin
    scrGetLinkTarget.Path.Text := '';
    scrGetLinkTarget.Variable.Text := '';
    if scrGetLinkTarget.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      GetLink.Add(Result);
      GetLink.Add(scrGetLinkTarget.Path.Text);
      GetLink.Add(scrGetLinkTarget.Variable.Text);
    end;
  end
  else
  if Kind = 'Find All Files' then 
  begin
    scrFindAllFiles.Path.Text := '';
    scrFindAllFiles.Subfolder.Checked := false;
    scrFindAllFiles.DirNames.Checked := false;
    scrFindAllFiles.Link.Checked := false;
    scrFindAllFiles.Variable.Text := '';
    if scrFindAllFiles.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      FAF.Add(Result);
      FAF.Add(scrFindAllFiles.Path.Text);
      FAF.Add(BoolToStr(scrFindAllFiles.Subfolder.Checked));
      FAF.Add(BoolToStr(scrFindAllFiles.DirNames.Checked) + '|' +
        BoolToStr(scrFindAllFiles.Link.Checked));
      FAF.Add(scrFindAllFiles.Variable.Text);
    end;
  end
  else
  if Kind = 'Generate GUID' then 
  begin
    scrGUID.Variable.Text := '';
    if scrGUID.ShowModal = mrOk then
    begin
      Result := MyCreateGUID;
      xGUID.Add(Result);
      xGUID.Add(scrGUID.Variable.Text);
    end;
  end
  else
  if Kind = 'Get Environment' then 
  begin
    scrGetEnvironment.EnvVar.Text := '';
    scrGetEnvironment.Variable.Text := '';
    if scrGetEnvironment.ShowModal = mrOk then
    begin
      Result := MyCreateGUID;
      GetEnv.Add(Result);
      GetEnv.Add(scrGetEnvironment.EnvVar.Text);
      GetEnv.Add(scrGetEnvironment.Variable.Text);
    end;
  end
  else
  if Kind = 'Get INI File Settings' then 
  begin
    scrGetINI.Variable.Text := '';
    scrGetINI.FileName.Text := '';
    scrGetINI.Section.Text := '';
    scrGetINI.Key.Text := '';
    if scrGetINI.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      GetINI.Add(Result);
      GetINI.Add(scrGetINI.Variable.Text);
      GetINI.Add(scrGetINI.FileName.Text);
      GetINI.Add(scrGetINI.Section.Text);
      GetINI.Add(scrGetINI.Key.Text);
    end;
  end
  else
  if Kind = 'Get Temporary File' then 
  begin
    scrGetTempFile.Variable.Text := '';
    if scrGetTempFile.ShowModal = mrOk then
    begin
      Result := MyCreateGUID;
      GetTemp.Add(Result);
      GetTemp.Add(scrGetTempFile.Variable.Text);
    end;
  end
  else
  if Kind = 'Is Native Setup Installed' then 
  begin
    scrIsNativeSetupInstalled.Guid.Text := '';
    scrIsNativeSetupInstalled.Variable.Text := '';
    if scrIsNativeSetupInstalled.ShowModal = mrOk then
    begin
      Result := MyCreateGUID;
      IsNative.Add(Result);
      IsNative.Add(scrIsNativeSetupInstalled.Guid.Text);
      IsNative.Add(scrIsNativeSetupInstalled.Variable.Text);
    end;
  end
  else
  if Kind = 'Read from Binary File' then
  begin
    scrReadBinary.Text.Text := '';
    scrReadBinary.Variable.Text := '';
    scrReadBinary.Position.Value := 0;
    scrReadBinary.Total.Value := 0;
    if scrReadBinary.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      xReadBinary.Add(Result);
      xReadBinary.Add(scrReadBinary.Text.Text);
      xReadBinary.Add(scrReadBinary.Variable.Text);
      xReadBinary.Add(IntToStr(scrReadBinary.Position.Value));
      xReadBinary.Add(IntToStr(scrReadBinary.Total.Value));
    end;
  end
  else
  if Kind = 'Copy/Move Local Files' then 
  begin
    scrLocalFiles.SourceFolder.Text := '';
    scrLocalFiles.SourceFiles.Text := '';
    scrLocalFiles.TargetFolder.Text := '';
    scrLocalFiles.TargetFiles.Text := '';
    scrLocalFiles.CopyFiles.Checked := True;
    scrLocalFiles.MoveFiles.Checked := false;
    scrLocalFiles.Subfolders.Checked := false;
    if scrLocalFiles.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      LocalFiles.Add(Result);
      LocalFiles.Add(scrLocalFiles.SourceFolder.Text);
      LocalFiles.Add(scrLocalFiles.SourceFiles.Text);
      LocalFiles.Add(scrLocalFiles.TargetFolder.Text);
      LocalFiles.Add(scrLocalFiles.TargetFiles.Text);
      LocalFiles.Add(BoolToStr(scrLocalFiles.CopyFiles.Checked)
        + '|' + BoolToStr(scrLocalFiles.Link.Checked));
      LocalFiles.Add(BoolToStr(scrLocalFiles.MoveFiles.Checked)
        + '|' + BoolToStr(scrLocalFiles.Subfolders.Checked));
    end;
  end
  else
  if Kind = 'Edit INI File' then 
  begin
    scrEditIniFile.FilePath.Text := '';
    scrEditIniFile.FileName.Text := '';
    scrEditIniFile.Action.ItemIndex := 0;
    scrEditIniFile.Section.Text := '';
    scrEditIniFile.Key.Text := '';
    scrEditIniFile.Value.Text := '';
    if scrEditIniFile.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      EditIni.Add(Result);
      EditIni.Add(scrEditIniFile.FilePath.Text);
      EditIni.Add(scrEditIniFile.FileName.Text);
      EditIni.Add(IntToStr(scrEditIniFile.Action.ItemIndex));
      EditIni.Add(scrEditIniFile.Section.Text);
      EditIni.Add(scrEditIniFile.Key.Text);
      EditIni.Add(scrEditIniFile.Value.Text);
    end;
  end
  else
  if Kind = 'Set 64 Bit Mode' then 
  begin
    scrSet64BitMode.Win32.Checked := True;
    scrSet64BitMode.ia64.Checked := false;
    scrSet64BitMode.x64.Checked := false;
    if scrSet64BitMode.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      Plat.Add(Result);
      Plat.Add(BoolToStr(scrSet64BitMode.Win32.Checked));
      Plat.Add(BoolToStr(scrSet64BitMode.ia64.Checked));
      Plat.Add(BoolToStr(scrSet64BitMode.x64.Checked));
    end;
  end
  else
  if Kind = 'Rename File/Folder' then
  begin
    scrRename.Path.Text := '';
    scrRename.NewPath.Text := '';
    if scrRename.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      xRename.Add(Result);
      xRename.Add(scrRename.Path.Text);
      xRename.Add(scrRename.NewPath.Text);
    end;
  end
  else
  if Kind = 'Write to Binary File' then
  begin
    scrWriteBinary.Text.Text := '';
    scrWriteBinary.Value.Text := '';
    scrWriteBinary.Position.Value := 0;
    scrWriteBinary.AppendNull.Checked := false;
    if scrWriteBinary.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      xWriteBinary.Add(Result);
      xWriteBinary.Add(scrWriteBinary.Text.Text);
      xWriteBinary.Add(scrWriteBinary.Value.Text);
      xWriteBinary.Add(IntToStr(scrWriteBinary.Position.Value));
      xWriteBinary.Add(BoolToStr(scrWriteBinary.AppendNull.Checked));
    end;
  end
  else
  if Kind = 'Halt Compilation' then 
  begin
    scrHaltCompile.Message.Lines.Clear;
    if scrHaltCompile.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      HaltCompile.Add(Result);
      HaltCompile.Add(GetMemoFlat(scrHaltCompile.Message));
    end;
  end
  else
  if Kind = 'Reboot and Resume' then 
    Result := 'Reboot Computer and Resume Setup' 
  else
  if Kind = 'Reboot Computer' then 
    Result := 'Reboot Computer' 
  else
  if Kind = 'Delete Registry' then 
  begin
    scrDeleteRegistry.Root.ItemIndex := 2;
    scrDeleteRegistry.Key.Text := '';
    scrDeleteRegistry.Value.Text := '';
    scrDeleteRegistry.delKey.Checked := True;
    scrDeleteRegistry.Target.Text := '';
    if scrDeleteRegistry.ShowModal = mrOk then
    begin
      Result := MyCreateGUID;
      DeleteReg.Add(Result);
      DeleteReg.Add(IntToStr(scrDeleteRegistry.Root.ItemIndex) + '|' + scrDeleteRegistry.Target.Text);
      DeleteReg.Add(scrDeleteRegistry.Key.Text);
      DeleteReg.Add(scrDeleteRegistry.Value.Text);
      DeleteReg.Add(BoolToStr(scrDeleteRegistry.delKey.Checked));
    end;
  end
  else
  if Kind = 'Find All Registry' then
  begin
    scrFindAllRegistry.Variable.Text := '';
    scrFindAllRegistry.Root.ItemIndex := 2;
    scrFindAllRegistry.Key.Text := '';
    scrFindAllRegistry.Names.Checked := false;
    scrFindAllRegistry.Values.Checked := True;
    scrFindAllRegistry.Target.Text := '';
    if scrFindAllRegistry.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      FindAllReg.Add(Result);
      FindAllReg.Add(scrFindAllRegistry.Variable.Text + '|' + scrFindAllRegistry.Target.Text);
      FindAllReg.Add(IntToStr(scrFindAllRegistry.Root.ItemIndex));
      FindAllReg.Add(scrFindAllRegistry.Key.Text);
      FindAllReg.Add(BoolToStr(scrFindAllRegistry.Names.Checked));
      FindAllReg.Add(BoolToStr(scrFindAllRegistry.Values.Checked));
    end;
  end
  else
  if Kind = 'Get OS or SP Level' then 
  begin
    scrGetOSorSP.Variable.Text := '';
    scrGetOSorSP.OS.Checked := True;
    scrGetOSorSP.SP.Checked := false;
    if scrGetOSorSP.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      ExactVer.Add(Result);
      ExactVer.Add(scrGetOSorSP.Variable.Text);
      ExactVer.Add(BoolToStr(scrGetOSorSP.OS.Checked));
      ExactVer.Add(BoolToStr(scrGetOSorSP.SP.Checked));
    end;
  end
  else
  if Kind = 'Get System Settings' then 
  begin
    scrGetSystemSettings.Variable.Text := '';
    scrGetSystemSettings.Capability.ItemIndex := 0;
    if scrGetSystemSettings.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      GetSystemSettings.Add(Result);
      GetSystemSettings.Add(scrGetSystemSettings.Variable.Text);
      GetSystemSettings.Add(IntToStr(scrGetSystemSettings.Capability.ItemIndex));
    end;
  end
  else
  if Kind = 'Get Native Settings' then 
  begin
    scrGetNativeSettings.Variable.Text := '';
    scrGetNativeSettings.Capability.ItemIndex := 0;
    if scrGetNativeSettings.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      GetNativeSettings.Add(Result);
      GetNativeSettings.Add(scrGetNativeSettings.Variable.Text);
      GetNativeSettings.Add(IntToStr(scrGetNativeSettings.Capability.ItemIndex));
    end;
  end
  else
  if (Kind = 'Read Registry') or (Kind = 'Check Registry') then 
  begin
    scrReadRegistry.Caption := Kind + ' (Windows Only)';
    scrReadRegistry.Variable.Text := '';
    scrReadRegistry.Root.ItemIndex := 2;
    scrReadRegistry.Key.Text := '';
    scrReadRegistry.Value.Text := '';
    scrReadRegistry.Target.Text := '';
    if scrReadRegistry.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      ReadReg.Add(Result);
      ReadReg.Add(scrReadRegistry.Variable.Text + '|' + scrReadRegistry.Target.Text);
      ReadReg.Add(IntToStr(scrReadRegistry.Root.ItemIndex));
      ReadReg.Add(scrReadRegistry.Key.Text);
      ReadReg.Add(scrReadRegistry.Value.Text);
    end;
  end
  else
  if Kind = 'Write Registry' then 
  begin
    
    scrWriteRegistry.Root.ItemIndex := 2;
    scrWriteRegistry.Key.Text := '';
    scrWriteRegistry.Value.Text := '';
    scrWriteRegistry.Data.Text := '';
    scrWriteRegistry.asString.Checked := True;
    scrWriteRegistry.asInteger.Checked := false;
    scrWriteRegistry.asExpandString.Checked := false;
    scrWriteRegistry.asBinary.Checked := false;
    scrWriteRegistry.asAppend.Checked := false;
    scrWriteRegistry.asPrepend.Checked := false;
    scrWriteRegistry.Permanent.Checked := false;
    scrWriteRegistry.Target.Text := '';
    if scrWriteRegistry.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      WriteReg.Add(Result);
      
      if scrWriteRegistry.Permanent.Checked then WriteReg.Add('10') 
        else WriteReg.Add('0');
      WriteReg.Add(IntToStr(scrWriteRegistry.Root.ItemIndex) + '|' + scrWriteRegistry.Target.Text);
      WriteReg.Add(scrWriteRegistry.Key.Text);
      WriteReg.Add(scrWriteRegistry.Value.Text);
      WriteReg.Add(scrWriteRegistry.Data.Text);
      WriteReg.Add(BoolToStr(scrWriteRegistry.asString.Checked));
      if scrWriteRegistry.asInteger.Checked then
        WriteReg.Add('TRUE') 
      else
      if scrWriteRegistry.asExpandString.Checked then
        WriteReg.Add('EXPANDSTRING') 
      else
      if scrWriteRegistry.asBinary.Checked then
        WriteReg.Add('BINARY') 
      else
      if scrWriteRegistry.asAppend.Checked then
        WriteReg.Add('APPEND') 
      else
      if scrWriteRegistry.asPrepend.Checked then
        WriteReg.Add('PREPEND') 
      else
        WriteReg.Add('FALSE'); 
    end;
  end
  else
  if Kind = 'Compress 7Zip Archive' then 
  begin
    scrCompress7Zip.Archive.Text := '';
    scrCompress7Zip.Password.Text := '';
    scrCompress7Zip.Recursive.Text := '';
    scrCompress7Zip.NonRecursive.Text := '';
    scrCompress7Zip.ArchiveType.ItemIndex := 0;
    scrCompress7Zip.Parameters.Text := scrCompress7Zip.Parameters.Items[scrCompress7Zip.Parameters.Items.Count -1];
    scrCompress7Zip.RelativePath.Checked := True;
    scrCompress7Zip.FullPath.Checked := false;
    scrCompress7Zip.NoPath.Checked := false;
    scrCompress7Zip.Variable.Text := '';
    if scrCompress7Zip.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      Compress7Zip.Add(Result);
      Compress7Zip.Add(scrCompress7Zip.Archive.Text);
      Compress7Zip.Add(scrCompress7Zip.Password.Text);
      Compress7Zip.Add(scrCompress7Zip.Recursive.Text);
      Compress7Zip.Add(scrCompress7Zip.NonRecursive.Text);
      Compress7Zip.Add(IntToStr(scrCompress7Zip.ArchiveType.ItemIndex));
      Compress7Zip.Add(scrCompress7Zip.Parameters.Text);
      Compress7Zip.Add(BoolToStr(scrCompress7Zip.RelativePath.Checked));
      Compress7Zip.Add(BoolToStr(scrCompress7Zip.FullPath.Checked));
      Compress7Zip.Add(BoolToStr(scrCompress7Zip.NoPath.Checked));
      Compress7Zip.Add(scrCompress7Zip.Variable.Text);
    end;
  end
  else
  if Kind = 'Extract 7Zip Archive' then 
  begin
    scrExtract7Zip.Archive.Text := '';
    scrExtract7Zip.Path.Text := '';
    scrExtract7Zip.Variable.Text := '';
    scrExtract7Zip.Password.Text := '';
    scrExtract7Zip.Overwrite.Checked := True;
    scrExtract7Zip.UsePath.Checked := True;
    if scrExtract7Zip.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      Extract7Zip.Add(Result);
      Extract7Zip.Add(scrExtract7Zip.Archive.Text);
      Extract7Zip.Add(scrExtract7Zip.Path.Text);
      Extract7Zip.Add(scrExtract7Zip.Variable.Text);
      Extract7Zip.Add(scrExtract7Zip.Password.Text);
      Extract7Zip.Add(BoolToStr(scrExtract7Zip.Overwrite.Checked));
      Extract7Zip.Add(BoolToStr(scrExtract7Zip.UsePath.Checked));
    end;
  end
  else
  if Kind = 'Return from Include Script' then
  begin
    scrReturnFromInclude.Result.Text := '';
    if scrReturnFromInclude.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      ReturnInclude.Add(Result);
      ReturnInclude.Add(scrReturnFromInclude.Result.Text);
    end;
  end
  else
  if Kind = 'Get File Size' then
  begin
    scrGetFileSize.Variable.Text := '';
    scrGetFileSize.Path.Text := '';
    if scrGetFileSize.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      xGetFileSize.Add(Result);
      xGetFileSize.Add(scrGetFileSize.Variable.Text);
      xGetFileSize.Add(scrGetFileSize.Path.Text);
    end;
  end
  else
  if Kind = 'Run Program As' then
  begin
    scrRunProgramAs.RunProgram.Text := '';
    scrRunProgramAs.WorkingDir.Text := '';
    scrRunProgramAs.CommandLine.Text := '';
    scrRunProgramAs.Window.ItemIndex := 0;
    scrRunProgramAs.User.Text := '';
    scrRunProgramAs.Password.Text := '';
    scrRunProgramAs.Domain.Text := '';
    scrRunProgramAs.Variable.Text := '';
    scrRunProgramAs.WaitFor.Checked := false;
    scrRunProgramAs.Environment.Text := '';
    scrRunProgramAs.Vista.Checked := false;
    scrRunProgramAs.VistaEx.Checked := false;
    if scrRunProgramAs.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      RunProgramAs.Add(Result);
      RunProgramAs.Add(scrRunProgramAs.RunProgram.Text);
      RunProgramAs.Add(scrRunProgramAs.WorkingDir.Text);
      RunProgramAs.Add(scrRunProgramAs.CommandLine.Text);
      RunProgramAs.Add(IntToStr(scrRunProgramAs.Window.ItemIndex));
      if scrRunProgramAs.Vista.Checked or scrRunProgramAs.VistaEx.Checked then
      begin
        if scrRunProgramAs.Vista.Checked and scrRunProgramAs.VistaEx.Checked then
          RunProgramAs.Add('$MYAH_UACEY$')
        else
        if scrRunProgramAs.Vista.Checked then
          RunProgramAs.Add('$MYAH_UAC$')
        else
          RunProgramAs.Add('$MYAH_UACEX$');
        
      end
      else
        RunProgramAs.Add(''); 
      begin
        RunProgramAs.Add(scrRunProgramAs.Password.Text);
        RunProgramAs.Add(scrRunProgramAs.Domain.Text);
      end;
      RunProgramAs.Add(scrRunProgramAs.Variable.Text);
      RunProgramAs.Add(BoolToStr(scrRunProgramAs.WaitFor.Checked));
      
        RunProgramAs.Add(scrRunProgramAs.Environment.Text);
    end;
  end
  else
  if Kind = 'Check Process' then 
  begin
    scrCheckProcess.Process.Text := '';
    scrCheckProcess.Variable.Text := '';
    if scrCheckProcess.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      CheckProcess.Add(Result);
      CheckProcess.Add(scrCheckProcess.Process.Text);
      CheckProcess.Add(scrCheckProcess.Variable.Text);
    end;
  end
  else
  if Kind = 'Run Script' then 
  begin
    scrRunScript.ScriptType.ItemIndex := 1;
    scrRunScript.TimeOut.Value := -1;
    scrRunScript.SafeOnly.Checked := True;
    scrRunScript.Interactive.State := cbGrayed;
    scrRunScript.Variable.Text := '';
    scrRunScript.Script.Lines.Clear;
    if scrRunScript.ShowModal = mrOk then
    begin
      Result := MyCreateGuid;
      xRunScript.Add(Result);
      xRunScript.Add(IntToStr(scrRunScript.ScriptType.ItemIndex));
      xRunScript.Add(IntToStr(scrRunScript.TimeOut.Value));
      xRunScript.Add(BoolToStr(scrRunScript.SafeOnly.Checked));
      xRunScript.Add(BoolToStr(scrRunScript.Interactive.Checked));
      xRunScript.Add(BoolToStr(scrRunScript.Interactive.State = cbGrayed));
      xRunScript.Add(scrRunScript.Variable.Text);
      xRunScript.Add(GetMemoFlat(scrRunScript.Script));
    end;
  end
  else
  if Kind = 'Refresh Shell' then 
    Result := MyCreateGuid;
  
end;

procedure Tui.DeleteFunction(Kind, Guid: String);
var
  i, j, k: Integer;
  l: TStringList;
begin
  GetFunctionOffsets(Kind, l, i);
  if l <> nil then
    k := l.IndexOf(Guid)
  else
    k := 0; 
  for j := 1 to i +1 do
    l.Delete(k);
end;

function Tui.RenderUpdateScript(SmartPosition: Integer; FoldedSmartPos: Boolean
  ): Boolean;
var
  s, sX: String;
  Undoable: Boolean;
  l: TStringList;
begin
  Undoable := false;
  if InDesigner then
    if ScriptTypes[SmartPosition] <> 'Code Folding Region' then 
      Undoable := True;
  if FoldedSmartPos then
    SmartPosition := GetRealLineNumber(SmartPosition);
  if Undoable then
    s := GetFunctionDataForStack(ScriptTypes[SmartPosition], ScriptReferences[SmartPosition]);
  PushStatusStack('Editing command ' + ScriptTypes[SmartPosition]);
  Result := EditFunction(ScriptTypes[SmartPosition], ScriptReferences[SmartPosition]);
  if Result then
  begin
    if Undoable then
      if s <> '' then 
      begin
        sX := GetFunctionDataForStack(ScriptTypes[SmartPosition], ScriptReferences[SmartPosition]);
        if s <> sX then 
        begin
          l := TStringList.Create;
          l.Add(IntToStr(SmartPosition));
          l.Add(ScriptTypes[SmartPosition]);
          l.Add(ScriptReferences[SmartPosition]);
          l.Add(s);
          AddStackItem(UndoStack, 'Edit', l.CommaText);
          l.Free;
          
          ClearStack(RedoStack);
        end;
      end;
    RenderLine(SmartPosition, True);
    try
      Script.Selected[GetFoldedLineNumber(SmartPosition)] := True;
    except
      
    end;
    
    SetDirtyMia(True, '');
    SetHorizontalScrollBar(Script);
  end
  else
  begin
    ClearSelectionEx(Script);
    RenderLine(SmartPosition, True);
    Script.Selected[GetFoldedLineNumber(SmartPosition)] := True;
  end;
  PopStatusStack;
end;

procedure Tui.RenderDeleteScriptEx(SmartPosition: Integer; RealLine: Boolean);
var
  b: Boolean;
  i, j: Integer;
  l: TStringList;
begin
  if not RealLine then
    l := GetAllRealLines(SmartPosition)
  else
  begin
    l := TStringList.Create;
    l.Add(IntToStr(SmartPosition));
  end;
  for i := l.Count downto 1 do
  begin
    SmartPosition := StrToInt(l[i -1]);
    if (ScriptFolds[SmartPosition] = 'V') or not EnabledFolding then
      j := GetFoldedLineNumber(SmartPosition)
    else
      j := -1;
    
    if IsLineCodeFolding(SmartPosition) then
      if not IsLineCodeFoldEnd(SmartPosition) then
        if FoldList.IndexOf(GetCodeFoldingName(SmartPosition)) <> -1 then
          FoldList.Delete(FoldList.IndexOf(GetCodeFoldingName(SmartPosition)));
    
    ScriptBuffer.Delete(SmartPosition);
    ScriptFolds.Delete(SmartPosition);
    Breakpoints.Delete(SmartPosition);
    Bookmarks.Delete(SmartPosition);
    
    DeleteFunction(ScriptTypes[SmartPosition], ScriptReferences[SmartPosition]);
    ScriptReferences.Delete(SmartPosition);
    ScriptTypes.Delete(SmartPosition);
    ScriptComments.Delete(SmartPosition);
    ScriptFetches.Delete(SmartPosition);
    RenderCache.Delete(SmartPosition);
    
    if j <> -1 then
      Script.Items.Delete(j);
  end;
  l.Free;
  SetDirtyMia(True, '');
end;

function Tui.RenderInsertScript(Command: String; SmartPosition: Integer;
  Visibility: Boolean; RealSmartPosition: Boolean): Boolean;
var
  s, sX: String;
  Undoable: Boolean;
  l, lX, lY: TStringList;
begin
  PushStatusStack('Inserting command ' + Command);
  Undoable := false;
  if Visibility then sX := 'V'
    else sX := '';
  Result := false;
  if not RealSmartPosition then
    SmartPosition := GetRealLineNumber(SmartPosition);
  if InDesignerEx then
    Undoable := True;
  s := InsertFunction(Command);
  if s <> '' then
  begin
    if Undoable then
    begin
      l := TStringList.Create;
      lX := TStringList.Create;
      l.Add(IntToStr(SmartPosition));
      lX.Add(l.CommaText);
      AddStackItem(UndoStack, 'Insert', lX.CommaText);
      l.Free;
      lX.Free;
      
      ClearStack(RedoStack);
    end;
    Result := True;
    ScriptComments.Insert(SmartPosition, '');
    ScriptFetches.Insert(SmartPosition, '');
    ScriptTypes.Insert(SmartPosition, Command);
    ScriptReferences.Insert(SmartPosition, s);
    ScriptBuffer.Insert(SmartPosition, '');
    ScriptFolds.Insert(SmartPosition, sX);
    if Visibility then
      Script.Items.Insert(GetFoldedLineNumber(SmartPosition), '');
    Breakpoints.Insert(SmartPosition, '');
    Bookmarks.Insert(SmartPosition, '');
    RenderCache.Insert(SmartPosition, '');
    RenderLine(SmartPosition, True);
    RehashIndents;
    
    SetDirtyMia(True, '');
  end;
  PopStatusStack;
end;

function Tui.RelativizePath(Path, ProjectRoot: String): String;
begin
  Result := ExtractRelativePath(AssertDir(ProjectRoot), Path);
end;

function Tui.HashItems(ItemType: String): TStrings;
var
  i, j, k: Integer;
  l: TStringList;
begin
  Result := THashedStringList.Create;
  if ItemType = SWebMediaBlocks then
  begin
    j := 4;
    k := 1;
    l := MediaBlock;
  end;
  if ItemType = 'Bookmarks' then 
  begin
    for i := 1 to Bookmarks.Count do
      if Bookmarks[i -1] <> '' then
        Result.Add(ScriptReferences[i -1]);
        
    Exit;
  end;
  if ItemType = 'Comments' then 
  begin
    j := 2;
    k := 1;
    l := Comments;
  end;
  if ItemType = 'Regions' then 
  begin
    j := 3;
    k := 2;
    l := Region;
  end;
  if ItemType = 'Labels' then 
  begin
    j := 2;
    k := 1;
    l := eLabel;
  end;
  if ItemType = 'Apply Changes' then 
  begin
    j := 5;
    k := 3;
    l := ApplyChanges;
  end;
  if ItemType = 'Components' then 
  begin
    j := 3;
    k := 1;
    l := GetComponent;
  end;
  for i := 1 to l.Count do
    if i mod j = 1 then
    
      if ScriptReferences.IndexOf(l[i -1]) <> -1 then
        Result.Add(l[i -1]);
    
end;

procedure Tui.DisplayLine(Line: Integer; Real: Boolean);
var
  nFolded, nReal: Integer;
begin
  
  if Real then
    nReal := Line
  else
    nReal := GetRealLineNumber(Line);
  AssertLineIsVisible(nReal);
  if Real then
    nFolded := GetFoldedLineNumber(Line)
  else
    nFolded := Line;
  ClearSelectionEx(Script);
  Script.ItemIndex := nFolded;
  Script.Selected[nFolded] := True;
  
  try
    if not Script.Focused then Script.SetFocus;
  except
  end;
end;

procedure Tui.ReBindMainScriptRename(NewName: String);
var
  i: Integer;
  MemoryBuffer, FileBuffer: String;
begin
  GetNamedScriptNameAndFile('', MemoryBuffer, FileBuffer);
  
  for i := 1 to AllContextBuffers.Count do
    if CompareText(AllContextBuffers[i -1], MemoryBuffer) = 0 then
    begin
      AllContextBuffers[i -1] := NewName;
      Break;
    end;
  
  for i := 1 to DirtyBuffer.Count do
    if CompareText(DirtyBuffer[i -1], FileBuffer) = 0 then
    begin
      DirtyBuffer[i -1] := NewName;
      Break;
    end;
  
  if LastActiveContext = ScriptFile then
    LastActiveContext := NewName;
end;

function Tui.SaveProjectDirect(ProjectFile, OldDir: String; Import: Boolean = false): Boolean;
var
  s: String;
  i, j: Integer;
  t: TextFile;
begin
  PushStatusStack('Saving project ' + ProjectFile);
  Result := True;
  if MyFileExists(ProjectFile) then
    if not FileCopyFile(PChar(ProjectFile), PChar(ProjectFile + '.bak'), false) then 
    begin
      Application.MessageBox(PChar('Unable to write to project folder, please run the InstallAware IDE elevated with administrator rights.'),
        PChar(Application.Title), mb_Ok + mb_IconStop);
      Result := false;
      Exit;
    end;
  
  SetFileAttributes(PChar(ProjectFile), FILE_ATTRIBUTE_NORMAL);
  AssignFile(t, ProjectFile,cp_utf8);
  ReWrite(t);
  if Import then
    WriteLn(t, ExtractFileNameOnly(ScriptFile) + '.miax') 
  else
  begin
    if ExtractFilePath(ScriptFile) = '' then 
      if CompareText(AssertDir(ExtractFilePath(ProjectFile)), AssertDir(OldDir)) <> 0 then 
      begin
        ReBindMainScriptRename(AssertDir(OldDir) + ScriptFile);
        ScriptFile := AssertDir(OldDir) + ScriptFile;
      end;
    WriteLn(t, RelativizePath(ScriptFile, ExtractFilePath(ProjectFile)));
  end;
  for i := 1 to DialogFiles.Count do
  begin
    WriteLn(t, DialogFiles[i -1]);
    if OldDir <> ProjDir then
      FileCopyFile(PChar(OldDir + DialogFiles[i -1]), PChar(PROJDIR + DialogFiles[i -1]),
        false);
  end;
  WriteLn(t, '$');
  for i := 1 to SupportFiles.Count do
  begin
    WriteLn(t, SupportFiles[i -1]);
    if OldDir <> ProjDir then
      FileCopyFile(PChar(OldDir + SupportFiles[i -1]), PChar(PROJDIR + SupportFiles[i -1]),
        false);
  end;
  WriteLn(t, '$');
  for i := 1 to Breakpoints.Count do
    WriteLn(t, Breakpoints[i -1]);
  WriteLn(t, '$');
  for i := 1 to VarWatches.Count do
    WriteLn(t, VarWatches[i -1]);
  WriteLn(t, '$');
  
  WriteLn(t, ProjectStruct.BuildLayout);
  WriteLn(t, ProjectStruct.CompressProfile);
  WriteLn(t, ProjectStruct.BuildInFolder);
  WriteLn(t, ProjectStruct.BuildCustomFolder);
  WriteLn(t, ProjectStruct.Manufacturer);
  WriteLn(t, ProjectStruct.Name);
  WriteLn(t, ProjectStruct.Code);
  WriteLn(t, ProjectStruct.UpgradeCode);
  WriteLn(t, ProjectStruct.Version);
  WriteLn(t, ProjectStruct.Language);
  WriteLn(t, ProjectStruct.Title);
  WriteLn(t, ProjectStruct.Subject);
  WriteLn(t, ProjectStruct.Author);
  WriteLn(t, ProjectStruct.Comments);
  WriteLn(t, ProjectStruct.Revision);
  WriteLn(t, ProjectStruct.arPublisher);
  WriteLn(t, ProjectStruct.arContact);
  WriteLn(t, ProjectStruct.arHelp);
  WriteLn(t, ProjectStruct.arUpdates);
  WriteLn(t, ProjectStruct.arComments);
  WriteLn(t, ProjectStruct.BuildDebug);
  WriteLn(t, ProjectStruct.OutputFile);
  WriteLn(t, ProjectStruct.AutoIncrement);
  WriteLn(t, ProjectStruct.aSign);
  WriteLn(t, ProjectStruct.aCertificate);
  WriteLn(t, ProjectStruct.aKey);
  WriteLn(t, ProjectStruct.aTimeStamp);
  WriteLn(t, ProjectStruct.aInfo);
  WriteLn(t, ProjectStruct.Conditionals);
  WriteLn(t, ProjectStruct.pDisplay);
  WriteLn(t, ProjectStruct.pDescription);
  WriteLn(t, ProjectStruct.pClass);
  WriteLn(t, ProjectStruct.pWhole);
  WriteLn(t, ProjectStruct.pMissing);
  WriteLn(t, ProjectStruct.pLarge);
  WriteLn(t, ProjectStruct.pRemove);
  WriteLn(t, ProjectStruct.pCreate);
  WriteLn(t, ProjectStruct.pDebug);
  WriteLn(t, ProjectStruct.MultiLang);
  WriteLn(t, ProjectStruct.PassEnabled);
  WriteLn(t, ProjectStruct.Password);
  for i := 1 to IncludeFiles.Count do
    if Import then
      WriteLn(t, ExtractFileNameOnly(IncludeFiles[i -1]) + '.miax') 
    else
      WriteLn(t, RelativizePath(IncludeFiles[i -1], ExtractFilePath(ProjectFile)));
  WriteLn(t, '$');
  WriteLn(t, ProjectStruct.AutoHash);
  WriteLn(t, ProjectStruct.CodeSignPassword);
  WriteLn(t, ProjectStruct.cFiles);
  WriteLn(t, ProjectStruct.cRegistry);
  WriteLn(t, ProjectStruct.cFeatures);
  WriteLn(t, ProjectStruct.cHashes);
  CloseFile(t);
  
  SetDirtyMpr(false);
  AddToMRUF(ProjectFile);
  PopStatusStack;
end;

procedure Tui.ReBindProjectRename(NewName: String);
var
  i: Integer;
begin
  
  for i := 1 to DirtyBuffer.Count do
    if CompareText(DirtyBuffer[i -1], CurrentProjectName) = 0 then
    begin
      DirtyBuffer[i -1] := NewName;
      Break;
    end;
end;

procedure Tui.SaveExistingProjectAs;
var
  s: String;
begin
  if CurrentProjectName = '' then
  begin
    if not IsProjectNameOK then Exit;
    SaveExistingProject(PROJDIR);
    Exit;
  end;
  PushStatusStack('Saving project as');
  if SaveProject.Execute then
  begin
    s := PROJDIR;
    ReBindProjectRename(SaveProject.FileName);
    CurrentProjectName := SaveProject.FileName;
    PROJDIR := AssertDir(ExtractFilePath(CurrentProjectName));
    SaveProjectDirect(SaveProject.FileName, s);
  end;
  PopStatusStack;
end;

function Tui.SaveExistingProject(OldDir: String): Boolean;
var
  MemoryBuffer, FileBuffer: String;
begin
  Result := IsProjectNameOK;
  if not Result then Exit;
  
  SaveProjectDirect(CurrentProjectName, OldDir);
  
  GetNamedScriptNameAndFile('', MemoryBuffer, FileBuffer);
  if LastActiveContext = ScriptFile then
    SaveNamedScript(MemoryBuffer, FileBuffer, OldDir)
  else
    
    if LastActiveContext <> '' then 
    begin
      GetNamedScriptNameAndFile(CurrentUnit.Tabs[IncludeFiles.IndexOf(LastActiveContext) +2], MemoryBuffer, FileBuffer);
      SaveNamedScript(MemoryBuffer, FileBuffer, OldDir);
    end;
    
end;

function Tui.IsProjectNameOK: Boolean;
begin
  Result := IsScriptNameOK;
  if Result then
    if CurrentProjectName = '' then
    begin
      PushStatusStack('Saving project');
      if SaveProject.Execute then
      begin
        CurrentProjectName := SaveProject.FileName;
        PROJDIR := AssertDir(ExtractFilePath(CurrentProjectName));
      end
      else
        Result := false;
      PopStatusStack;
    end;
end;

function Tui.IsScriptNameOK: Boolean;
begin
  Result := True;
  if ScriptFile = '' then
  begin
    Project.SaveScriptAs1Click(Self);
    Result := ScriptFile <> '';
  end;
end;

function Tui.IsDirty: Boolean;
begin
  Result := DirtyBuffer.Count <> 0;
end;

function Tui.SafeRunState: Boolean;
begin
  Result := True;
  if Running then
  begin
    PushStatusStack('Aborting debugging');
    if Application.MessageBox(PChar(SYouMustStopDebuggingBeforeUsingT),
      PChar(Application.Title), mb_YesNo + mb_IconQuestion) = id_Yes then
    begin
      MenuItem11Click(Self);
      Result := false;
    end
    else
      Result := false;
    PopStatusStack;
  end;
end;

function Tui.IsSafeToCloseProject: Boolean;
var
  i, j: Integer;
  MemoryBuffer, FileBuffer: String;
begin
  Result := True;
  if IsDirty then
  begin
    
    if DirtyBuffer.IndexOf('') <> -1 then
    begin
      IsProjectNameOK;
      Exit;
    end;
    
    SaveAll.Buffers.Items.Text := DirtyBuffer.Text;
    i := SaveAll.ShowModal;
    if i = mrCancel  then
    begin
      Result := false;
      Exit;
    end;
    if i = mrYes then
      for j := 1 to SaveAll.Buffers.Items.Count do
        if SaveAll.Buffers.Selected[j -1] then
        begin
          
          if CompareText(ExtractFileExt(SaveAll.Buffers.Items[j -1]), '.mprx') = 0 then 
            Result := SaveProjectDirect(CurrentProjectName, PROJDIR)
          else
          
          if CompareText(SaveAll.Buffers.Items[j -1], GetFullProjectScriptFilePath) = 0 then
          begin
            GetNamedScriptNameAndFile('', MemoryBuffer, FileBuffer);
            Result := SaveNamedScript(MemoryBuffer, FileBuffer, PROJDIR);
          end
          else
          
          begin
            GetNamedScriptNameAndFile(CurrentUnit.Tabs[IncludeFiles.IndexOf(SaveAll.Buffers.Items[j -1]) +2], MemoryBuffer, FileBuffer);
            Result := SaveNamedScript(MemoryBuffer, FileBuffer, PROJDIR);
          end;
          if not Result then Break;
        end;
  end;
end;

function Tui.StripExpandedSetVar(Field: String): String;
begin
  if Pos('$MYAH$MYAH$', Field) <> 0 then 
    Delete(Field, Pos('$MYAH$MYAH$', Field), Length(Field)); 
  Result := Field;
end;

procedure Tui.ProcessVariableBoxForSetVar(Box: TComboBox);
var
  i: Integer;
begin
  for i := 1 to Box.Items.Count do
    Box.Items[i -1] := StripExpandedSetVar(Box.Items[i -1]);
end;

function Tui.IsTextInCommandAtLine(aText: String; Line: Integer;
  CheckDisplayText: Boolean; CaseSensitive: Boolean): Boolean;
var
  i, j: Integer;
  CommandKind, CommandReference: String;
  CommandList: TStringList;
  CommandCount: Integer;
begin
  Result := false;
  if not CaseSensitive then
    aText := AnsiLowerCase(aText);
  if CheckDisplayText then
  begin
    if not CaseSensitive then
      Result := AnsiPos(aText, AnsiLowerCase(ScriptBuffer[Line])) <> 0
    else
      Result := AnsiPos(aText, ScriptBuffer[Line]) <> 0;
    if Result then Exit;
  end;
  CommandKind := ScriptTypes[Line];
  CommandReference := ScriptReferences[Line];
  GetFunctionOffsets(CommandKind, CommandList, CommandCount);
  for i := 1 to CommandCount do
  begin
    if not CaseSensitive then
      j := AnsiPos(aText, AnsiLowerCase(CommandList[CommandList.IndexOf(CommandReference) + i]))
    else
      j := AnsiPos(aText, CommandList[CommandList.IndexOf(CommandReference) + i]);
    if j <> 0 then
    begin
      Result := True;
      Exit;
    end;
  end;
end;

function Tui.RenderInsertScriptEx(Command: String; ItemClass, Params: TStrings;
  SmartPosition: Integer; Visibility: Boolean;
  ForceGUIDForRedoIntegrity: String = ''): String;
var
  s, sX: String;
  i: Integer;
begin
  Result := '';
  if ForceGUIDForRedoIntegrity = '' then
    s := MyCreateGuid
  else
    s := ForceGUIDForRedoIntegrity;
  if Visibility then sX := 'V'
    else sX := '';
  if (Params <> nil) and (ItemClass <> nil) then
  begin
    Result := s;
    ItemClass.Add(s);
    for i := 1 to Params.Count do
      ItemClass.Add(Params[i -1]);
  end;
  ScriptComments.Insert(SmartPosition, '');
  ScriptFetches.Insert(SmartPosition, '');
  ScriptTypes.Insert(SmartPosition, Command);
  ScriptReferences.Insert(SmartPosition, s);
  ScriptBuffer.Insert(SmartPosition, '');
  ScriptFolds.Insert(SmartPosition, sX);
  if Visibility then
    Script.Items.Insert(GetFoldedLineNumber(SmartPosition), '');
  Breakpoints.Insert(SmartPosition, '');
  Bookmarks.Insert(SmartPosition, '');
  RenderCache.Insert(SmartPosition, '');
  RenderLine(SmartPosition, True);
  
  SetDirtyMia(True, '');
end;

function Tui.GetFullProjectScriptFilePath: String;
begin
  if ExtractFileName(ScriptFile) <> ScriptFile then
    Result := ScriptFile
  else
    Result := AssertDir(ExtractFilePath(CurrentProjectName))
      + ScriptFile;
end;

procedure Tui.CategoriesButtonClicked(Sender: TObject);
var
  bmp: TBitmap;
  li: TListItem;
  l, lX, lY, lZ: TStringList;
  s, fS, ISOs: String;
  tf: TextFile;
  i, j, k, fI, iX: Integer;
  t, tX: TTreeNode;
  RunCheck, RunSetup: String;
  Wide1, Wide2: String;
  tif: TIniFile;
  hWait, hDef: TCursor;
  sl: TStringList;
  uS, uSX: String;
  uI: Integer;
  Day, Month, Year: Word;
  Wide3, Wide4: String;
  rS, rSX: String;
begin
  
  hDef := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  OffTheHook := OffTheHook +1;
  try
    PushStatusStack('Visualizing code');
    
    VisualNotebook.HelpKeyword := 'visual' +
       
          StringReplace(CategoriesSelectedItemCaption, ' ', '', [rfReplaceAll, rfIgnoreCase]) + '.htm'; 
       
    VisualNotebook.HelpKeyword := StringReplace(VisualNotebook.HelpKeyword,
      'visualPrograms,DirectDeploy', 'visualadd-removeprograms', [rfReplaceAll, rfIgnoreCase]);
    
    if CategoriesSelectedItemCaption = 'Web Media Blocks' then
    begin
      WebBlocks.Items.BeginUpdate;
      WebBlocks.Items.Clear;
      
      for i := 1 to MediaBlock.Count do
        if ((i -1) mod 4) = 0 then
          if MediaBlock[(i -1) + 1] <> '' then
            
            begin
              WidenColonDelimParam(MediaBlock[(i -1) + 3], Wide1, Wide2, '$MYAH_CARET$'); 
              li := WebBlocks.Items.Add;
              li.Caption := MediaBlock[(i -1) + 1];
              li.SubItems.Add(Wide2);
              li.SubItems.Add(MediaBlock[(i -1) + 2]);
              if StrToBool(Wide1) then
                li.SubItems.Add(SDoNotBuild)
              else
                li.SubItems.Add(SBuild);
              li.ImageIndex := 56;
              li.SubItems.Add(MediaBlock[i -1]);
              
            end;
      
      WebBlocks.Items.EndUpdate;
      WebBlocksChange(Self, nil, ctState);
    end;
    if CategoriesSelectedItemCaption = 'Versions' then
    begin
      Versions.Items.BeginUpdate;
      Versions.Items.Clear;
      if SupportFiles.IndexOf('updates.ini') <> -1 then 
      begin
        tif := TIniFile.Create(PROJDIR + 'updates.ini'); 
        tif.ReadSection(SUpdatePacksForVersions, Versions.Items);
      end;
      Versions.Items.EndUpdate;
      Served.Items.BeginUpdate;
      Served.Items.Clear;
      Served.Items.EndUpdate;
    end;
    if CategoriesSelectedItemCaption = 'Update Packs' then
    begin
      Packs.Items.BeginUpdate;
      Packs.Items.Clear;
      if SupportFiles.IndexOf('updates.ini') <> -1 then 
      begin
        lZ := TStringList.Create;
        tif := TIniFile.Create(PROJDIR + 'updates.ini'); 
        tif.ReadSections(lZ);
        for iX := 1 to lZ.Count do
          if CompareText(lZ[iX -1], SUpdatePacksForVersions) <> 0 then
          begin
            li := Packs.Items.Add;
            li.Caption := lZ[iX -1];
            li.SubItems.Add(tif.ReadString(lZ[iX -1], 'URL', '')); 
            li.SubItems.Add(tif.ReadString(lZ[iX -1], 'Description', '')); 
            li.SubItems.Add(tif.ReadString(lZ[iX -1], 'Reboot', 'No')); 
            li.SubItems.Add(tif.ReadString(lZ[iX -1], 'Silent', 'Yes')); 
            li.SubItems.Add(tif.ReadString(lZ[iX -1], 'Parameters', '')); 
            li.ImageIndex := 97;
          end;
        tif.Free;
        lZ.Free;
      end;
      Packs.Items.EndUpdate;
      PacksChange(Self, nil, ctState);
    end;
    if CategoriesSelectedItemCaption = 'EULA and ReadMe' then
    begin
      DisplayText.ItemIndex := 0;
      DisplayTextChange(Self);
    end;
    
    if CategoriesSelectedItemCaption = 'Dialogs' then
    begin
      
      DialogsListEx.Items.Clear;
      DialogsList.Clear;
      for i := 1 to ScriptTypes.Count do
        if ScriptTypes[i -1] = 'Display Dialog' then 
           
          begin
            DialogsListEx.Items.Add(
              DisplayDialog[DisplayDialog.IndexOf(ScriptReferences[i -1]) + 1]);
            DialogsListEx.Checked[DialogsListEx.Items.Count -1] := ScriptComments[i -1] <> 'C';
            DialogsList.Add(IntToStr(i -1));
          end;
      DialogsListExClick(Self);
    end;
    
    if (((((((((((((((((CategoriesSelectedItemCaption = 'Features') or
      (CategoriesSelectedItemCaption = 'Shortcuts')) or
      ((CategoriesSelectedItemCaption = 'Files') or
      (CategoriesSelectedItemCaption = 'Registry'))) or
      (CategoriesSelectedItemCaption = 'Run Programs')) or
      (CategoriesSelectedItemCaption = 'Drivers')) or
      (CategoriesSelectedItemCaption = 'File Associations')) or
      (CategoriesSelectedItemCaption = 'ODBC')) or
      (CategoriesSelectedItemCaption = 'Services')) or
      (CategoriesSelectedItemCaption = 'Assemblies')) or
      (CategoriesSelectedItemCaption = 'Environment Variables')) or
      (CategoriesSelectedItemCaption = 'Drivers')) or
      (CategoriesSelectedItemCaption = 'Access Control')) or
      (CategoriesSelectedItemCaption = 'Scheduled Tasks')) or
      (CategoriesSelectedItemCaption = 'IIS Sites')) or
      (CategoriesSelectedItemCaption = 'SQL Databases')) or
      (CategoriesSelectedItemCaption = 'Shared Folders')) or
      ((CategoriesSelectedItemCaption = 'INI Files') or
      (CategoriesSelectedItemCaption = 'XML Files'))) or
      ((CategoriesSelectedItemCaption = 'Local Files') or
      ((CategoriesSelectedItemCaption = 'Users and Groups') or
      (CategoriesSelectedItemCaption = 'Games and Media Center')))
      then 
    begin
      
      l := TStringList.Create;
      lX := TStringList.Create;
      for i := 1 to ScriptTypes.Count do
        if ScriptTypes[i -1] = 'Define Component' then 
        begin
          l.Add(DefComponent[DefComponent.IndexOf(ScriptReferences[i -1]) +1]);
          lX.Add(DefComponent[DefComponent.IndexOf(ScriptReferences[i -1]) +2]);
        end;
       
      GetComponentsTree(Features, l, lX);
      l.Free;
      lX.Free;
    end;
    
    if CategoriesSelectedItemCaption = 'Access Control' then
    begin
      
      MigrateFeatures(Features, AccFeatures);
      if AccFeatures.ItemIndex = -1 then
        AccFeatures.ItemIndex := 0;
      
      FeatureAwareAccPopulate;
      AccessChange(Self, nil, ctState);
      AccFilterClick(Self);
    end;
    
    if CategoriesSelectedItemCaption = 'File Associations' then
    begin
      
      MigrateFeatures(Features, AssnFeatures);
      if AssnFeatures.ItemIndex = -1 then
        AssnFeatures.ItemIndex := 0;
      
      FeatureAwareAssnPopulate;
      AssocsChange(Self, nil, ctState);
      AssnFilterClick(Self);
      
    end;
    if CategoriesSelectedItemCaption = 'INI Files' then
    begin
      
      MigrateFeatures(Features, INIFeatures);
      if INIFeatures.ItemIndex = -1 then
        INIFeatures.ItemIndex := 0;
      
      FeatureAwareINIPopulate;
      INIChange(Self, nil, ctState);
      INIFilterClick(Self);
      
    end;
    if CategoriesSelectedItemCaption = 'Local Files' then
    begin
      
      MigrateFeatures(Features, LocalFeatures);
      if LocalFeatures.ItemIndex = -1 then
        LocalFeatures.ItemIndex := 0;
      
      FeatureAwareLocalPopulate;
      LocalChange(Self, nil, ctState);
      LocalFilterClick(Self);
      
    end;
    
    if CategoriesSelectedItemCaption = 'Run Programs' then
    begin
      Run.Items.BeginUpdate;
      Run.Items.Clear;
      for i := 1 to RunProgram.Count do
        if ((i -1) mod 6) = 0 then
        begin
          li := Run.Items.Add;
          li.Caption := RunProgram[(i -1) + 1];
          li.SubItems.Add(RunProgram[(i -1) + 3]);
          if StrToBool(RunProgram[(i -1) + 4]) then
            li.SubItems.Add('Yes') 
          else
            li.SubItems.Add('No'); 
          li.SubItems.Add(RunProgram[i -1]);
          li.ImageIndex := 69;
        end;
      Run.Items.EndUpdate;
      RunChange(Self, nil, ctState);
    end;
    
    if CategoriesSelectedItemCaption = 'Shortcuts' then
    begin
      
      MigrateFeatures(Features, ShortcutFeatures);
      if ShortcutFeatures.ItemIndex = -1 then
        ShortcutFeatures.ItemIndex := 0;
      
      FeatureAwareShortcutPopulate;
      ShortcutsChange(Self, nil, ctState);
      ShortcutFilterClick(Self);
      
    end;
    
    if CategoriesSelectedItemCaption = 'Files' then
    begin
      
      MigrateFeatures(Features, FilesFeatures);
      if FilesFeatures.ItemIndex = -1 then
        FilesFeatures.ItemIndex := 0;
      
      l := TStringList.Create;
      l.Sorted := True;
      l.CaseSensitive := false;
      l.Duplicates := dupIgnore;
      for i := 1 to InstallFiles.Count do
        if (i -1) mod 13 = 0 then
        begin
          l.Add(InstallFiles[(i -1) + 3]);
        end;
      for i := 1 to GetFolderLocation.Count do
        if (i -1) mod 4 = 0 then
        begin
          l.Add('$' + GetFolderLocation[(i -1) + 1] + '$');
        end;
      for i := 1 to CreateFolder.Count do
        if (i -1) mod 2 = 0 then
        begin
          l.Add(CreateFolder[(i -1) +1]);
          
        end;
      l.Add('$TARGETDIR$'); 
      if GetSetVariableValue('TARGETDIR_X86') <> '' then
        l.Add('$TARGETDIR_X86$'); 
      GetFoldersTreeEx(Folders, l);
      l.Free;
      FileFilterClick(Self);
      
      ShellTreeChange(Self, ShellTree.Selected);
    end;
    if CategoriesSelectedItemCaption = 'Project Properties' then
    begin
      
      Updates.Checked := GetUpdateEnabledState;
      MonitorURL.Text := GetUpdateServer;
      MonitorURL.Enabled := Updates.Checked;
      
      Label192.Enabled := Updates.Checked;
      
      MultiLangEx.Checked := ProjectStruct.MultiLang;
      MultiLangEx.Visible := false;
      for i := 1 to SupportFiles.Count do
        if CompareText(ProjectStruct.Name + '.mtx', 
          SupportFiles[i -1]) = 0 then
        begin
          MultiLangEx.Visible := True;
          Break;
        end;
      ProductName.Text := ProjectStruct.Name;
      ProductVersion.Text := ProjectStruct.Version;
      Manufacturer.Text := ProjectStruct.Manufacturer;
      for i := 1 to Language.Items.Count do
        if AnsiUpperCase(Language.Items[i -1]) = AnsiUpperCase(ProjectStruct.Language) then
        begin
          Language.ItemIndex := i -1;
          Break;
        end
        else
        begin
          if AnsiUpperCase(Language.Items[i -1]) = 'ENGLISH' then 
          Language.ItemIndex := i -1;
        end;
      ProductCode.Text := ProjectStruct.Code;
      Revision.Text := ProjectStruct.Revision;
      
    end;
    if CategoriesSelectedItemCaption = 'Build Settings' then
    begin
      CD.Checked := ProjectStruct.BuildLayout = 0;
      SFX.Checked := ProjectStruct.BuildLayout = 1;
      Web.Checked := ProjectStruct.BuildLayout = 2;
      Debug.Checked := ProjectStruct.BuildDebug = True;
      ProjectFolder.Checked := ProjectStruct.BuildInFolder;
      CustomFolder.Checked := not ProjectStruct.BuildInFolder;
      BuildFolder.Text := ProjectStruct.BuildCustomFolder;
      BuildFilename.Text := ProjectStruct.OutputFile;
      BuildFolder.Enabled := CustomFolder.Checked;
      BuildFolderBrowse.Enabled := CustomFolder.Checked;
      sl := TStringList.Create;
      sl.CommaText := ProjectStruct.Conditionals;
      for uI := 1 to sl.Count do
      begin
        uS := Copy(sl[uI -1], 1, AnsiPos('=', sl[uI -1]) -1);
        uSX := Copy(sl[uI -1], AnsiPos('=', sl[uI -1]) +1, Length(sl[uI -1]));
        if AnsiCompareText(uS, 'CACHESOURCES') = 0 then
        begin
          if AnsiCompareText('TRUE', uSX) = 0 then
            CacheSource.State := cbChecked
          else
            if AnsiCompareText('FALSE', uSX) = 0 then
              CacheSource.State := cbUnchecked
            else
              CacheSource.State := cbGrayed;
          Break;
        end;
        if uI = sl.Count then
          CacheSource.State := cbGrayed;
      end;
      if sl.Count = 0 then
        CacheSource.State := cbGrayed;
      for uI := 1 to sl.Count do
      begin
        uS := Copy(sl[uI -1], 1, AnsiPos('=', sl[uI -1]) -1);
        uSX := Copy(sl[uI -1], AnsiPos('=', sl[uI -1]) +1, Length(sl[uI -1]));
        if AnsiCompareText(uS, 'NOGUI') = 0 then
        begin
          if AnsiCompareText('TRUE', uSX) = 0 then
            Console.State := cbChecked
          else
            if AnsiCompareText('FALSE', uSX) = 0 then
              Console.State := cbUnchecked
            else
              if AnsiCompareText('AUTO', uSX) = 0 then
                Console.State := cbGrayed
              else
                {$IFDEF LINUX}
                Console.State := cbGrayed;
                {$ELSE}
                Console.State := cbUnchecked;
                {$ENDIF}
          Break;
        end;
        if uI = sl.Count then
          {$IFDEF LINUX}
          Console.State := cbGrayed;
          {$ELSE}
          Console.State := cbUnchecked;
          {$ENDIF}
      end;
      if sl.Count = 0 then
        {$IFDEF LINUX}
        Console.State := cbGrayed;
        {$ELSE}
        Console.State := cbUnchecked;
        {$ENDIF}
      sl.Free;
    end;
    
    if CategoriesSelectedItemCaption = 'Script Analytics' then
    begin
      CommandCounts.Items.BeginUpdate;
      CommandCounts.Items.Clear;
      l := TStringList.Create;
      lX := TStringList.Create;
      for i := 1 to ScriptTypes.Count do
        if l.IndexOf(ScriptTypes[i -1]) = -1 then
        begin
          l.Add(ScriptTypes[i -1]);
          lX.Add('1');
        end
        else
          lX[l.IndexOf(ScriptTypes[i -1])] :=
            IntToStr(
              StrToInt(lX[l.IndexOf(ScriptTypes[i -1])]) +1);
      for i := 1 to l.Count do
      begin
        li := CommandCounts.Items.Add;
        li.Caption := l[i -1];
        li.SubItems.Add(lX[i -1]);
      end;
      l.Free;
      lX.Free;
      CommandCounts.Items.EndUpdate;
      
      CommandListing.Items.Clear;
    end;
    
    if CategoriesSelectedItemCaption = 'Setup Icon' then
    begin
      if SupportFiles.IndexOf('icon.png') <> -1 then 
      begin
        try
          IconDisplayLinux.Picture.LoadFromFile(PROJDIR + 'icon.png'); 
          IconDisplayLinux.Hint := PROJDIR + 'icon.png'; 
          IconDisplayLinux.Visible := True;
        except
          Application.MessageBox(PChar(SInvalidIconFilePleaseChooseANewI), PChar(Application.Title), mb_Ok + mb_IconStop);
        end;
      end
      else
      begin
        IconDisplayLinux.Visible := false;
        IconDisplayLinux.Hint := '';
      end;
      if SupportFiles.IndexOf('icon.icns') <> -1 then 
      begin
        try
          IconDisplaymacOS.Picture.LoadFromFile(PROJDIR + 'icon.icns'); 
          IconDisplaymacOS.Hint := PROJDIR + 'icon.icns'; 
          IconDisplaymacOS.Visible := True;
        except
          Application.MessageBox(PChar(SInvalidIconFilePleaseChooseANewI), PChar(Application.Title), mb_Ok + mb_IconStop);
        end;
      end
      else
      begin
        IconDisplaymacOS.Visible := false;
        IconDisplaymacOS.Hint := '';
      end;
      if SupportFiles.IndexOf('icon.ico') <> -1 then 
      begin
        try
          IconDisplayWindows.Picture.LoadFromFile(PROJDIR + 'icon.ico'); 
          IconDisplayWindows.Hint := PROJDIR + 'icon.ico'; 
          IconDisplayWindows.Visible := True;
        except
          Application.MessageBox(PChar(SInvalidIconFilePleaseChooseANewI), PChar(Application.Title), mb_Ok + mb_IconStop);
        end;
      end
      else
      begin
        IconDisplayWindows.Visible := false;
        IconDisplayWindows.Hint := '';
      end;
    end;
    
    if CategoriesSelectedItemCaption = 'Features' then
      
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf('FeaturesPage')
    else
    if CategoriesSelectedItemCaption = 'Files' then
      
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf('FilesPage')
    else
    if CategoriesSelectedItemCaption = 'Dialogs' then
      
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf('DialogsPage')
    else
    if CategoriesSelectedItemCaption = 'INI Files' then
      
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf('INIFilesPage')
    else
    if CategoriesSelectedItemCaption = 'Shortcuts' then
      
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf('ShortcutsPage')
    else
    if CategoriesSelectedItemCaption = 'Access Control' then
      
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf('AccessControlPage')
    else
    if CategoriesSelectedItemCaption = 'File Associations' then
      
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf('FileAssociationsPage')
    else
    if CategoriesSelectedItemCaption = 'Run Programs' then
      
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf('RunProgramsPage')
    else
    if CategoriesSelectedItemCaption = 'Local Files' then
      
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf('LocalFilesPage')
    else
    if CategoriesSelectedItemCaption = 'Web Media Blocks' then
      
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf('WeblocksPage')
    else
    if CategoriesSelectedItemCaption = 'Script Analytics' then
      
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf('ScriptAnalyticsPage')
    else
    if CategoriesSelectedItemCaption = 'Update Packs' then
      
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf('UpdatePacksPage')
    else
    if CategoriesSelectedItemCaption = 'Versions' then
      
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf('VersionsPage')
    else
    if CategoriesSelectedItemCaption = 'EULA and ReadMe' then
      
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf('EULAandReadMePage')
    else
    if CategoriesSelectedItemCaption = 'Build Settings' then
      
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf('BuildSettingsPage')
    else
    if CategoriesSelectedItemCaption = 'Project Properties' then
      
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf('ProjectPropertiesPage')
    else
    if CategoriesSelectedItemCaption = 'Setup Icon' then
      
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf('SetupIconPage')
    else
      VisualNotebook.PageIndex := VisualNotebook.Pages.IndexOf(CategoriesSelectedItemCaption);
  finally
    OffTheHook := OffTheHook -1;
    Screen.Cursor := hDef;
    PopStatusStack;
  end;
end;

procedure Tui.AdjustUIProjectChanged;
var
  s: String;
begin
  if ProjectStruct.Name = '' then s := SUntitled
    else s := ProjectStruct.Name;
  if Running then
  begin
    RemoveShortcuts;
    s := s + SRunning;
    TabSet.Enabled := false;
  end
  else
  begin
    if TabSet.TabIndex = 0 then
      RemoveShortcuts
    else
      InsertShortcuts;
    TabSet.Enabled := True;
  end;
  s := s + ' - ' + Brand;
  Caption := s;
  Application.Title := s;
  RefreshWatches;
  if Project <> nil then 
  begin
    Project.SetProject(CurrentProjectName);
    Project.SetScript(ScriptFile);
    Project.SetDialogs(DialogFiles);
    Project.SetSupport(SupportFiles);
    Project.SetInclude(IncludeFiles);
  end;
  
  AdjustVisualUI;
end;

procedure Tui.AdjustVisualUI;
begin
  if Notebook.ActivePage <> 'Visual' then Exit;
  try
    OffTheHook := OffTheHook +1;
    CategoriesButtonClicked(Self);
  finally
    OffTheHook := OffTheHook -1;
  end;
end;

procedure Tui.CreateNewProject;
begin
  
  ClearProjectStructs;
  
  SetDirtyAll(false);
  AdjustUIProjectChanged;
  RenderScript;
end;

procedure Tui.ClearProjectStructs(ScriptOnly: Boolean);
var
  i: Integer;
begin
  if ScriptOnly then
  begin
    ClearScriptStructsOnly;
    Exit;
  end;
  ClearStack(UndoStack);
  ClearStack(RedoStack);
  FreeSavedContexts;
  DirtyBuffer.Clear;
  LastActiveContext := '';
  ScriptFile := '';
  CurrentProjectName := '';
  PROJDIR := EXEDIR;
  DialogFiles.Clear;
  SupportFiles.Clear;
  IncludeFiles.Clear;
  VarWatches.Clear;
  Project.Clear;
  ProjectStruct.BuildDebug := false;
  ProjectStruct.BuildLayout := 0;
  ProjectStruct.CompressProfile := 'Structured'; 
  ProjectStruct.BuildInFolder := True;
  ProjectStruct.BuildCustomFolder := '';
  ProjectStruct.Manufacturer := '';
  ProjectStruct.Name := '';
  StrCopy(ProjectStruct.Code, PChar(CreateGUIDUp));
  
  StrCopy(ProjectStruct.UpgradeCode, PChar(CreateGUIDUp));
  
  ProjectStruct.Version := '1';
  ProjectStruct.Language := 'English'; 
  ProjectStruct.Title := '';
  ProjectStruct.Subject := '';
  ProjectStruct.Author := '';
  ProjectStruct.Comments := '';
  StrCopy(ProjectStruct.Revision, PChar(CreateGUIDUp));
  
  ProjectStruct.arPublisher := '';
  ProjectStruct.arContact := '';
  ProjectStruct.arHelp := '';
  ProjectStruct.arUpdates := '';
  ProjectStruct.arComments := '';
  ProjectStruct.OutputFile := '';
  ProjectStruct.AutoIncrement := True;
  ProjectStruct.AutoHash := false;
  ProjectStruct.aSign := false;
  ProjectStruct.aCertificate := '';
  ProjectStruct.aKey := '';
  ProjectStruct.aTimeStamp := 'http://time.certum.pl';
  ProjectStruct.aInfo := '';
  ProjectStruct.Conditionals := '';
  ProjectStruct.pDisplay := '';
  ProjectStruct.pDescription := '';
  ProjectStruct.pClass := 'Service Pack'; 
  ProjectStruct.pWhole := false;
  ProjectStruct.pLarge := false;
  ProjectStruct.pMissing := false;
  ProjectStruct.pRemove := True;
  ProjectStruct.pCreate := True;
  ProjectStruct.pDebug := false;
  ProjectStruct.MultiLang := false;
  ProjectStruct.PassEnabled := false;
  ProjectStruct.Password := '';
  ProjectStruct.CodeSignPassword := '';
  ProjectStruct.cFiles := false;
  ProjectStruct.cRegistry := false;
  ProjectStruct.cFeatures := True;
  ProjectStruct.cHashes := false;
  Script.Items.Clear;
  FoldList.Clear;
  IndentHash.Clear;
  RenderCache.Clear;
  Breakpoints.Clear;
  Bookmarks.Clear;
  ScriptComments.Clear;
  ScriptFetches.Clear;
  ScriptTypes.Clear;
  ScriptBuffer.Clear;
  ScriptFolds.Clear;
  ScriptReferences.Clear;
  for i := 1 to GlobalLists.Count do
    TStringList(GlobalLists[i -1]).Clear;
end;

procedure Tui.ClearScriptStructsOnly;
var
  i: Integer;
begin
  IndentHash.Clear;
  RenderCache.Clear;
  Breakpoints.Clear;
  Bookmarks.Clear;
  ScriptComments.Clear;
  ScriptFetches.Clear;
  ScriptTypes.Clear;
  ScriptReferences.Clear;
  ScriptFolds.Clear;
  FoldList.Clear;
  for i := 1 to GlobalLists.Count do
    TStringList(GlobalLists[i -1]).Clear;
  ClearStack(UndoStack);
  ClearStack(RedoStack);
end;

procedure Tui.SetDirtyAll(Dirty: Boolean);
var
  i: Integer;
begin
  if not Dirty then
  begin
    DirtyBuffer.Clear;
    Exit;
  end;
  SetDirtyMPR(True);
  SetDirtyMIA(True, GetFullProjectScriptFilePath);
  for i := 1 to IncludeFiles.Count do
    SetDirtyMIA(True, IncludeFiles[i -1]);
end;

procedure Tui.SetDirtyMIA(Dirty: Boolean; sScriptFile: String;
  OverrideTFSHandling: Boolean);
begin
  
  if sScriptFile = '' then
    sScriptFile := LastActiveContext;
  
  if sScriptFile = '' then
    sScriptFile := ScriptFile;
  
  if sScriptFile = ScriptFile then
    sScriptFile := GetFullProjectScriptFilePath;
  if not Dirty then
  begin
    if DirtyBuffer.IndexOf(sScriptFile) <> -1 then
      DirtyBuffer.Delete(DirtyBuffer.IndexOf(sScriptFile));
    Exit;
  end;
  if DirtyBuffer.IndexOf(sScriptFile) = -1 then
    DirtyBuffer.Add(sScriptFile);
end;

procedure Tui.SetDirtyMPR(Dirty: Boolean);
begin
  if CurrentProjectName = '' then Exit;
  if not Dirty then
  begin
    if DirtyBuffer.IndexOf(CurrentProjectName) <> -1 then
      DirtyBuffer.Delete(DirtyBuffer.IndexOf(CurrentProjectName));
    Exit;
  end;
  if DirtyBuffer.IndexOf(CurrentProjectName) = -1 then
    DirtyBuffer.Add(CurrentProjectName);
end;

function Tui.LoadProject(FileName: String; Import: Boolean = false): Boolean;
var
  s, sX, sY, sZ, sI, sIm, sIf, sIe: String;
  l, lX: TStringList;
  t: TextFile;
  i, iX, iY: Integer;
  hDef: TCursor;
  BOM: Char;
begin
  if Import then
  begin
    sY := '.mpr';
    sZ := '.fld';
  end
  else
  begin
    sY := '.mprx';
    sZ := '.fldx';
  end;
  if AnsiCompareText(ExtractFileExt(FileName), sY) <> 0 then
  begin
    Result := false;
    Exit;
  end;
  Result := True;
  hDef := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  if Import then
    PushStatusStack('Importing project ' + FileName)
  else
    PushStatusStack('Loading project ' + FileName);
  try
    
    AssignFile(t, FileName,cp_utf8);
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
    ReadLn(t, s);
    CloseFile(t);
    if ExtractFilePath(s) = '' then
      s := AssertDir(ExtractFilePath(FileName)) + s;
    s := AbsolutizePath(s, ExtractFilePath(FileName));
    if not MyFileExists(s) then
    begin
      Screen.Cursor := hDef;
      Application.MessageBox(PChar(SScriptForProjectMissing + MyLineEnding + s + MyLineEnding + MyLineEnding +
        SClosingProjectNow),
        PChar(SProjectLoadError), mb_Ok + mb_IconStop);
      CreateNewProject;
      Exit;
    end;
    
    ClearProjectStructs;
    CurrentProjectName := FileName;
    PROJDIR := AssertDir(ExtractFilePath(CurrentProjectName));
    
    AssignFile(t, CurrentProjectName,cp_utf8);
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
    ReadLn(t, s);
    s := AbsolutizePath(s, ExtractFilepath(FileName));
    ScriptFile := s;
    ReadLn(t, s);
    while s <> '$' do
    begin
      DialogFiles.Add(s);
      ReadLn(t, s);
    end;
    ReadLn(t, s);
    while s <> '$' do
    begin
      SupportFiles.Add(s);
      ReadLn(t, s);
    end;
    ReadLn(t, s);
    while s <> '$' do
    begin
      Breakpoints.Add(s);
      ReadLn(t, s);
    end;
    ReadLn(t, s);
    while s <> '$' do
    begin
      VarWatches.Add(s);
      ReadLn(t, s);
    end;
    
    ReadLn(t, ProjectStruct.BuildLayout);
    ReadLn(t, ProjectStruct.CompressProfile);
    ReadLn(t, s);
    ProjectStruct.BuildInFolder := StrToBool(s);
    ReadLn(t, ProjectStruct.BuildCustomFolder);
    ReadLn(t, ProjectStruct.Manufacturer);
    ReadLn(t, ProjectStruct.Name);
    ReadLn(t, ProjectStruct.Code);
    ReadLn(t, ProjectStruct.UpgradeCode);
    ReadLn(t, ProjectStruct.Version);
    ReadLn(t, ProjectStruct.Language);
    ReadLn(t, ProjectStruct.Title);
    ReadLn(t, ProjectStruct.Subject);
    ReadLn(t, ProjectStruct.Author);
    ReadLn(t, ProjectStruct.Comments);
    ReadLn(t, ProjectStruct.Revision);
    ReadLn(t, ProjectStruct.arPublisher);
    ReadLn(t, ProjectStruct.arContact);
    ReadLn(t, ProjectStruct.arHelp);
    ReadLn(t, ProjectStruct.arUpdates);
    ReadLn(t, ProjectStruct.arComments);
    ReadLn(t, s);
    ProjectStruct.BuildDebug := StrToBool(s);
    ReadLn(t, ProjectStruct.OutputFile);
    ReadLn(t, s);
    ProjectStruct.AutoIncrement := StrToBool(s);
    if not EOF(t) then
    begin
      ReadLn(t, s);
      ProjectStruct.aSign := StrToBool(s);
      ReadLn(t, ProjectStruct.aCertificate);
      ReadLn(t, ProjectStruct.aKey);
      ReadLn(t, ProjectStruct.aTimeStamp);
      ReadLn(t, ProjectStruct.aInfo);
    end
    else
    begin
      
      ProjectStruct.aSign := false;
      ProjectStruct.aCertificate := '';
      ProjectStruct.aKey := '';
      ProjectStruct.aTimeStamp := 'http://time.certum.pl';
      ProjectStruct.aInfo := '';
    end;
    if not EOF(t) then
      ReadLn(t, ProjectStruct.Conditionals)
    else
      ProjectStruct.Conditionals := '';
    if Import then
    begin
      if not EOF(t) then
      begin
        ReadLn(t, s);
        while s <> '$' do
        begin
          
          ReadLn(t, s);
        end;
      end;
      if not EOF(t) then
      begin
        ReadLn(t, s);
        while s <> '$' do
        begin
          
          ReadLn(t, s);
        end;
      end
      else;
    end;
    if not EOF(t) then
    begin
      ReadLn(t, ProjectStruct.pDisplay);
      ReadLn(t, ProjectStruct.pDescription);
      ReadLn(t, ProjectStruct.pClass);
      ReadLn(t, s);
      TryStrToBool(s, ProjectStruct.pWhole);
      ReadLn(t, s);
      TryStrToBool(s, ProjectStruct.pMissing);
      ReadLn(t, s);
      TryStrToBool(s, ProjectStruct.pLarge);
      ReadLn(t, s);
      TryStrToBool(s, ProjectStruct.pRemove);
      ReadLn(t, s);
      TryStrToBool(s, ProjectStruct.pCreate);
      ReadLn(t, s);
      TryStrToBool(s, ProjectStruct.pDebug);
    end
    else
    begin
      ProjectStruct.pDisplay := '';
      ProjectStruct.pDescription := '';
      ProjectStruct.pClass := 'Service Pack'; 
      ProjectStruct.pWhole := false;
      ProjectStruct.pLarge := false;
      ProjectStruct.pMissing := false;
      ProjectStruct.pRemove := True;
      ProjectStruct.pCreate := True;
      ProjectStruct.pDebug := false;
    end;
    if not EOF(t) then
    begin
      ReadLn(t, s);
      ProjectStruct.MultiLang := StrToBool(s);
    end
      else ProjectStruct.MultiLang := false;
    if not EOF(t) then
    begin
      ReadLn(t, s);
      ProjectStruct.PassEnabled := StrToBool(s);
      ReadLn(t, ProjectStruct.Password);
    end
    else
    begin
      ProjectStruct.PassEnabled := false;
      ProjectStruct.Password := '';
    end;
    if not EOF(t) then
    begin
      ReadLn(t, s);
      while s <> '$' do
      begin
        if Import then
          StringReplace(s, '\', '/', [rfReplaceAll, rfIgnoreCase]); 
        s := AbsolutizePath(s, ExtractFilePath(FileName));
        
        if ExtractFilePath(s) = '' then
        begin
          
          if MyFileExists(AssertDir(ExtractFilePath(FileName)) + s) then
            s := AssertDir(ExtractFilePath(FileName)) + s
          else
            
            if MyFileExists(EXEDIR + 'runtimes' + PathDelim + s) then 
              s := EXEDIR + 'runtimes' + PathDelim + s; 
        end
        
        else
          if not MyFileExists(s) then
          begin
            
            if MyFileExists(AssertDir(ExtractFilePath(FileName)) + ExtractFileName(s)) then
              s := AssertDir(ExtractFilePath(FileName)) + ExtractFileName(s)
            else
              
              if MyFileExists(EXEDIR + 'runtimes' + PathDelim + ExtractFileName(s)) then 
                s := EXEDIR + 'runtimes' + PathDelim + ExtractFileName(s); 
          end;
        IncludeFiles.Add(s);
        ReadLn(t, s);
      end;
    end
    else
      IncludeFiles.Clear;
    if not EOF(t) then
    begin
      ReadLn(t, s);
      ProjectStruct.AutoHash := StrToBool(s);
    end
    else
      ProjectStruct.AutoHash := false;
    if not EOF(t) then
      ReadLn(t, ProjectStruct.CodeSignPassword)
    else
      ProjectStruct.CodeSignPassword := '';
    if not EOF(t) then
    begin
      ReadLn(t, s);
      ProjectStruct.cFiles := StrToBool(s);
      ReadLn(t, s);
      ProjectStruct.cRegistry := StrToBool(s);
      ReadLn(t, s);
      ProjectStruct.cFeatures := StrToBool(s);
      ReadLn(t, s);
      ProjectStruct.cHashes := StrToBool(s);
    end
    else
    begin
      ProjectStruct.cFiles := false;
      ProjectStruct.cRegistry := false;
      ProjectStruct.cFeatures := True;
      ProjectStruct.cHashes := false;
    end;
    CloseFile(t);
    if not Import then
      AddToMRUF(FileName);
    
    SetDirtyMia(false, '', True);
    
    if MyFileExists(AssertDir(ExtractFilePath(CurrentProjectName)) +
      ExtractFileNameOnly(CurrentProjectName) + sZ) then 
        RenameFile(AssertDir(ExtractFilePath(CurrentProjectName)) +
          ExtractFileNameOnly(CurrentProjectName) + sZ, 
          ScriptFile + sZ); 
    if not LoadScriptEx(ScriptFile, Import) then Exit;
    AdjustUIProjectChanged;
    if not Import then
    begin
      OpenProject.FileName := FileName;
      SaveProject.FileName := FileName;
    end
    else
      OpenProjectEx.FileName := FileName;
    if Import then
    begin
      
      GetSpecialFolder($5, sI);
      sI := AssertDir(sI) + 'InstallAware Multi Platform Imports' + PathDelim +
        ExtractFileNameOnly(FileName);
      iX := 0;
      while DirectoryExists(sI) do
      begin
        iX := iX +1;
        GetSpecialFolder($5, sI);
        sI := AssertDir(sI) + 'InstallAware Multi Platform Imports' + PathDelim +
          ExtractFileNameOnly(FileName) + ' (' + IntToStr(iX) + ')';
      end;
      sI := AssertDir(sI);
      ForceDirectories(sI);
      
      GetNamedScriptNameAndFile('', sIm, sIf);
      sIf := sI + ExtractFileNameOnly(sIf) + '.miax';
      
      if AllContextBuffers.IndexOf(sIm) <> -1 then
        SaveNamedScript(sIm, sIf, '') 
      else
        if AllContextBuffers.IndexOf('') <> -1 then
          SaveNamedScript('', sIf, '') 
        else
        begin
          SaveContext(''); 
          SaveNamedScript('', sIf, '') 
        end;
      
      for i := 2 to CurrentUnit.Tabs.Count do
      begin
        CurrentUnit.TabIndex := i; 
        sIe := CurrentUnitChangeEx(True);
        if sIe <> '' then 
        begin
          
          Application.MessageBox(PChar(
            'InstallAware project:' + LineEnding + FileName
            + LineEnding + LineEnding + 'Import failed due to one (or more) missing Include Script(s):'
            + LineEnding + sIe + LineEnding + LineEnding +
            'Click OK to create a blank project instead.'), 'Unsuccessful InstallAware Import', mb_Ok
            + mb_IconExclamation);
          
          MenuItem43Click(Self); 
          Exit;
        end;
        
        if not MyFileExists(sI + CurrentUnit.Tabs[IncludeFiles.IndexOf(LastActiveContext) +2] + '.miax') then
        begin
          
          GetNamedScriptNameAndFile(CurrentUnit.Tabs[IncludeFiles.IndexOf(LastActiveContext) +2], sIm, sIf);
          sIf := sI + ExtractFileNameOnly(sIf) + '.miax';
          
          SaveNamedScript(sIm, sIf, ''); 
        end;
      end;
      
      lX := TStringList.Create;
      for iY := DialogFiles.Count downto 1 do
        if AnsiCompareText(ExtractFileExt(DialogFiles[iY -1]), '.miaf') <> 0 then
        begin
          if Dfm2Txt(AssertDir(ExtractFilePath(FileName)) + DialogFiles[iY -1],
            sI + ExtractFileNameOnly(DialogFiles[iY -1]) + '.lfm') then
          begin
            
            lX.Add(ExtractFileNameOnly(DialogFiles[iY -1]) + '.lfm');
            lX.Add(ExtractFileNameOnly(DialogFiles[iY -1]) + '.lfm.miaf');
          end;
           
          ScrubNewLfm(sI + ExtractFileNameOnly(DialogFiles[iY -1]) + '.lfm');
          FileCopyFile(AssertDir(ExtractFilePath(FileName)) + DialogFiles[iY -1] + '.miaf',
            sI + ExtractFileNameOnly(DialogFiles[iY -1]) + '.lfm.miaf', false);
        end;
      DialogFiles.Text := lX.Text;
      lX.Free;
      
      for iY := 1 to SupportFiles.Count do
        FileCopyFile(AssertDir(ExtractFilePath(FileName)) + SupportFiles[iY -1],
          sI + SupportFiles[iY -1], false);
      
      SaveProjectDirect(sI + ExtractFileNameOnly(CurrentProjectName) + '.mprx',
        AssertDir(ExtractFilePath(FileName)), True);
      Application.MessageBox(PChar('Congratulations!' + LineEnding + LineEnding +
        'InstallAware project:' + LineEnding + FileName
        + LineEnding + LineEnding + 'Has been successfully imported as:' + LineEnding + sI
        + ExtractFileNameOnly(CurrentProjectName) + '.mprx' + LineEnding + LineEnding +
        'Click OK to finish loading your newly imported project.'), 'Successful InstallAware Import', mb_Ok
        + mb_IconInformation);
      LoadProject(sI + ExtractFileNameOnly(FileName) + '.mprx', false);
    end;
    {$IFDEF WINDOWS}
    if LastActiveContext = '' then
      LastActiveContext := ScriptFile;
    
    {$ENDIF}
  finally
    Screen.Cursor := hDef;
    PopStatusStack;
  end;
end;

procedure Tui.PushStatusStack(StatusText: String);
begin
  StatusStack.Add(StatusText);
  StatusBar.SimpleText := ' ' + StatusText;
  StatusBar.Repaint; 
  Application.ProcessMessages; 
end;

function Tui.PopStatusStack: String;
begin
  if StatusStack.Count <> 0 then
    StatusStack.Delete(StatusStack.Count -1);
  if StatusStack.Count <> 0 then
    StatusBar.SimpleText := ' ' + StatusStack[StatusStack.Count -1]
  else
    StatusBar.SimpleText := ' Ready';
  StatusBar.Repaint; 
  Application.ProcessMessages; 
end;

procedure Tui.RenderScript;
var
  i: Integer;
begin
  PushStatusStack('Loading and parsing script');
  OrphanAll := false;
  ScriptBuffer.Clear;
  for i := 1 to ScriptTypes.Count do
  begin
    ScriptBuffer.Add('');
    if ScriptFolds.Count < ScriptBuffer.Count then
      ScriptFolds.Add('V');
    RenderCache.Add('');
    
    RenderLine(i -1, false);
  end;
  RehashIndents;
  PopStatusStack;
end;

procedure Tui.RenderLine(SmartPosition: Integer; ReCache: Boolean);
var
  s, sX: String;
procedure OrphanLine(EMessage: String);
begin
  Comments.Add(MyCreateGuid);
  Comments.Add('Error While Rendering Command: ' + ScriptTypes[SmartPosition] + '; ' +
    'Located at Absolute Line #' + IntToStr(SmartPosition) + '; ' + EMessage);
  ScriptReferences[SmartPosition] := Comments[Comments.Count -2];
  ScriptTypes[SmartPosition] := 'Comment';
  s := RenderFunction(ScriptTypes[SmartPosition], ScriptReferences[SmartPosition]);
end;
begin
  if ScriptBuffer.Count -1 < SmartPosition then
    raise Exception.Create(SAttemptToRenderNonExistentLine);
  if ScriptReferences.Count -1 < SmartPosition then
    raise Exception.Create(SAttemptToRenderNonReferencedLine);
  if ScriptTypes.Count -1 < SmartPosition then
    raise Exception.Create(SAttemptToRenderUntypedLine);
  if ScriptComments.Count -1 < SmartPosition then
    raise Exception.Create(SAttemptToRenderNullCommentLine);

    s := '';
    try
      s := RenderFunction(ScriptTypes[SmartPosition], ScriptReferences[SmartPosition]);
    except
      on E: Exception do
        if OrphanAll then OrphanLine(E.Message)
        else
          case Application.MessageBox(PChar('Error While Rendering Command: ' + ScriptTypes[SmartPosition] + MyLineEnding +
            'Located at Absolute Line #' + IntToStr(SmartPosition) + ':' + MyLineEnding + MyLineEnding + E.Message + MyLineEnding + MyLineEnding+ MyLineEnding +
            'Please send this message to InstallAware Technical Support if you were importing a setup from another installation authoring environment. Include the setup you were importing.' + MyLineEnding + MyLineEnding +
            {$IFDEF DARWIN}
            'You may type Command+C on your keyboard to immediately copy this entire message to your clipboard.' + MyLineEnding + MyLineEnding +
            {$ELSE}
            'You may type Ctrl+C on your keyboard to immediately copy this entire message to your clipboard.' + MyLineEnding + MyLineEnding +
            {$ENDIF}
            'If you were not importing a setup, this may indicate disk corruption; or you are trying to load a script saved using a newer version of InstallAware than this release.' + MyLineEnding + MyLineEnding + MyLineEnding +
            'Choose Abort to stop loading this script. Do NOT save any part of your project after choosing this option.' + MyLineEnding + MyLineEnding +
            'Choose Retry to display this error message for each non-rendering line in your script. This non-rendering line will be permanently replaced with a comment.' + MyLineEnding + MyLineEnding +
            'Choose Ignore to permanently replace this and all non-rendering lines in your script with comments.'),
            PChar(Application.Title), mb_AbortRetryIgnore + mb_IconExclamation + mb_DefButton3) of
            id_Ignore:    begin
                         
                         OrphanAll := True;
                         OrphanLine(E.Message);
                       end;
            id_Retry:     begin
                         
                         OrphanLine(E.Message);
                       end;
            id_Abort: raise;
          end;
    end;
    if s = '' then 
      raise Exception.Create(SAttemptToRenderUnsupportedComman
        + LineEnding + LineEnding + ScriptTypes[SmartPosition]
        
        + SToInstallPlugIns1OpenTheControlP);
    
  if ScriptComments[SmartPosition] = 'C' then sX := CommentConst + ' '
    else sX := '';
  ScriptBuffer[SmartPosition] := sX + s;
  if ScriptFolds[SmartPosition] <> '' then
  begin
    while Script.Items.Count -1 < GetFoldedLineNumber(SmartPosition) do
      Script.Items.Add('');
    Script.Items[GetFoldedLineNumber(SmartPosition)] := ScriptBuffer[SmartPosition];
  end;
end;

function Tui.RenderFunction(Kind, Guid: String): String;
var
  s, sX, sY, sZ: String;
  i: Integer;
  Wide1, Wide2, Wide3, Wide4: String;
  xList: THashedStringList;
begin
  if Kind = 'Install Files' then 
  begin
    i := InstallFiles.IndexOf(Guid);
    
    WidenColonDelimParam(InstallFiles[i +2], sX, sY);
    Result := 'Install Files ' + InstallFiles[i  +1] 
      + ' to ' + InstallFiles[i  +3]; 
    if StrToBool(InstallFiles[i  +10]) or
      (StrToBool(InstallFiles[i  +11]) or
      StrToBool(InstallFiles[i  +12])) then
    begin
      Result := Result + ' (';
      if StrToBool(InstallFiles[i  +10]) then
        Result := Result + 'Shared, '; 
      if StrToBool(InstallFiles[i  +11]) then
        Result := Result + 'Permanent, '; 
      if StrToBool(InstallFiles[i  +12]) then
        Result := Result + 'Never Overwrite, '; 
      Delete(Result, Length(Result) -1, 2);
      Result := Result + ')';
    end;
    if sY <> '' then
      Result := Result + ', ignore files matching wildcard pattern(s) ' + 
        sY;
    
    WidenColonDelimParam(InstallFiles[i +2], sX, sY);
    if StrToBool(sX) then
      Result := Result + ', include subfolders'; 
  end
  else
  if Kind = 'Remove Directory' then 
    Result := 'Remove Directory (including all its files and subfolders) ' + RmDir[RmDir.IndexOf(Guid) +1] 
  else
  if (Kind = 'Create Shortcut') or (Kind = 'Advertised Shortcut') then 
  begin
    WidenColonDelimParam(Short[Short.IndexOf(Guid) +3], Wide1, Wide2);
    Result := Kind + ' ' + Wide1 + '/' + 
      Short[Short.IndexOf(Guid) +2] + ' to ';
    WidenColonDelimParam(Short[Short.IndexOf(Guid) +1], Wide1, Wide2);
    Result := Result + Wide1;
    WidenColonDelimParam(Short[Short.IndexOf(Guid) +6], Wide1, Wide2);
    if AnsiCompareText(Wide2, 'TRUE') = 0 then
      Result := Result + ', run as administrator';
    WidenColonDelimParam(Short[Short.IndexOf(Guid) +9], Wide1, Wide2);
    if Pos('X', Wide2) <> 0 then
      Result := Result + ', Pin to Start Menu';
    if Pos('7', Wide2) <> 0 then
      Result := Result + ', Pin to Taskbar';
    if Pos('8', Wide2) <> 0 then
      Result := Result + ', Pin to Start Screen';
    WidenColonDelimParam(Short[Short.IndexOf(Guid) +7], Wide1, Wide2);
    if AnsiCompareText(Wide2, 'TRUE') = 0 then
      Result := Result + ', do not highlight in Start Menu';
    WidenColonDelimParam(Short[Short.IndexOf(Guid) +3], Wide1, Wide2);
    if AnsiCompareText(Wide2, 'TRUE') = 0 then
      Result := Result + ', do not include in Start Screen';
    WidenColonDelimParam(Short[Short.IndexOf(Guid) +1], Wide1, Wide2);
    if AnsiCompareText(Wide2, 'TRUE') = 0 then
      Result := Result + ', disable user pinning';
    if Kind[1] = 'A' then
      Result := Result + ' (unconditionally executes when target is installed)'; 
  end
  else
  if Kind = 'Run Program' then 
  begin
    Result := 'Run Program ' + RunProgram[RunProgram.IndexOf(Guid) +1] + 
      ' ' + RunProgram[RunProgram.IndexOf(Guid) +3];
    if StrToBool(RunProgram[RunProgram.IndexOf(Guid) +4]) then
    begin
      if RunProgram[RunProgram.IndexOf(Guid) +5] <> '' then
        Result := Result + ' (WAIT, get result into variable ' + RunProgram[RunProgram.IndexOf(Guid) +5] + ')'
      else
        Result := Result + ' (WAIT)'; 
    end;
  end
  else
  if Kind = 'Create Folder' then 
    Result := 'Create Folder ' + CreateFolder[CreateFolder.IndexOf(Guid) +1] 
  else
  if Kind = 'Comment' then 
  begin
    if Comments[Comments.IndexOf(Guid) +1] = '' then
      Result := ' '
    else
      Result := CommentConst + ' ' + Comments[Comments.IndexOf(Guid) +1];
  end
  else
  if Kind = 'MessageBox' then 
    Result := 'MessageBox: ' + xMessageBox[xMessageBox.IndexOf(Guid) +1] 
      + ', ' + xMessageBox[xMessageBox.IndexOf(Guid) +2]
  else
  if Kind = 'Set Variable' then 
  begin
    sZ := SetVariable[SetVariable.IndexOf(Guid) +1];
    if Pos('$MYAH$MYAH$', sZ) <> 0 then 
    begin
      Delete(sZ, 1, Pos('$MYAH$MYAH$', sZ) + Length('$MYAH$MYAH$') -1); 
      if MyStrToBool(sZ) then 
        Result := 'Set Persistent Variable' 
      else
        Result := 'Set Variable'; 
      sZ := SetVariable[SetVariable.IndexOf(Guid) + 1];
      Delete(sZ, Pos('$MYAH$MYAH$', sZ), Length(sZ)); 
    end
    else
      Result := 'Set Variable'; 
    Result := Result + ' ' +  sZ +
      ' to ' + SetVariable[SetVariable.IndexOf(Guid) +2]; 
  end
  else
  if ((Kind = 'If') or (Kind = 'Else If')) or ((Kind = 'Compiler Variable If') or
    ((Kind = 'While') or (Kind = 'Until'))) then 
  begin
    if Kind = 'While' then xList := xWhile
      else if Kind = 'Until' then xList := xUntil
      else xList := xIf;
    case StrToInt(xList[xList.IndexOf(Guid) + 2]) of
      0: s := 'Equals'; 
      1: s := 'Contains'; 
      2: s := 'Greater Than'; 
      3: s := 'Contains (Ignore Case)'; 
      4: s := 'Equals (Ignore Case)'; 
      5: s := 'is Defined'; 
      6: s := 'Greater Than (Version)'; 
    end;
    if StrToBool(xList[xList.IndexOf(Guid) + 4]) then s := 'not ' + s; 
    if Kind = 'While' then
      Result := 'while'
    else
    if Kind = 'Until' then
      Result := 'until'
    else
      Result := 'if';
    Result := Result + ' Variable ' + xList[xList.IndexOf(Guid) +1] + ' ' + s + ' ' 
      + xList[xList.IndexOf(Guid) +3];
    if Kind = 'While' then
      Result := Result + ' ' + 'loop'
    else
    if Kind = 'Else If' then 
      Result := 'else ' + Result; 
    if AnsiPos('Compiler', Kind) <> 0 then 
      Result := '[compiler ' + Result + ']'; 
  end
  else
  if Kind = 'End' then 
    Result := 'end' 
  else
  if Kind = 'Wend' then 
    Result := 'wend' 
  else
  if Kind = 'Next' then 
    Result := 'next' 
  else
  if Kind = 'Break' then 
    Result := 'Break out of Loop' 
  else
  if Kind = 'Continue' then 
    Result := 'Continue to Next Iteration of Loop' 
  else
  if Kind = 'Repeat' then 
    Result := 'repeat' 
  else
  if Kind = 'Compiler Variable End' then 
    Result := '[compiler end]' 
  else
  if Kind = 'Else' then 
    Result := 'else' 
  else
  if Kind = 'Compiler Variable Else' then 
    Result := '[compiler else]' 
  else
  if Kind = 'Include Script' then 
  begin
    WidenColonDelimParam(xInclude[xInclude.IndexOf(Guid) +1], Wide1, Wide2);
    Result := 'Include Script: ' + Wide1;
    if Wide2 <> '' then
      Result := Result + ' (get result into variable ' + Wide2 + ')';
  end
  else
  if Kind = 'Display Dialog' then 
  begin
    Result := 'Display Dialog: ' + DisplayDialog[DisplayDialog.IndexOf(Guid) +1]; 
    if DisplayDialog[DisplayDialog.IndexOf(Guid) +4] <> '' then
      Result := Result + ' (if variable ' + 
        DisplayDialog[DisplayDialog.IndexOf(Guid) +4] +
        ' is ' + DisplayDialog[DisplayDialog.IndexOf(Guid) +5] + ')'; 
    if StrToBool(DisplayDialog[DisplayDialog.IndexOf(Guid) +3]) then
      Result := Result + ', wait for dialog to return (modal)' 
    else
      Result := Result + ', use as progress dialog (non-modal)'; 
  end
  else
  if Kind = 'Hide Dialog' then 
    Result := 'Hide Dialog' 
  else
  if Kind = 'Label' then 
    Result := 'label: ' + eLabel[eLabel.IndexOf(Guid) +1] 
  else
  if Kind = 'Delete Component' then 
    Result := 'Delete Component ' + DelComp[DelComp.IndexOf(Guid) +1] 
  else
  if Kind = 'Define Component' then 
    Result := 'Define Component: ' + DefComponent[DefComponent.IndexOf(Guid) +1] 
  else
  if Kind = 'Set Component State' then 
  begin
    if StrToBool(SetComponent[SetComponent.IndexOf(Guid) +2]) then
      s := 'Select' 
    else
      s := 'Deselect'; 
    Result := s + ' Component: ' + SetComponent[SetComponent.IndexOf(Guid) +1]; 
  end
  else
  if Kind = 'Set Component Space' then 
    Result := 'Set Component ' + 
      SpaceFeatures[SpaceFeatures.IndexOf(Guid) +1] +
      ' space requirements to ' + 
      SpaceFeatures[SpaceFeatures.IndexOf(Guid) +2]
      + ' bytes' 
  else
  if Kind = 'Get Component State' then 
    Result := 'Get Component ' + GetComponent[GetComponent.IndexOf(Guid) +1] 
      + ' Selection State into Variable ' + GetComponent[GetComponent.IndexOf(Guid) +2] 
  else
  if Kind = 'GoTo Label' then 
    Result := 'GoTo Label: ' + gLabel[gLabel.IndexOf(Guid) +1] 
  else
  if Kind = 'Terminate Install' then 
    Result := 'Terminate Installation' 
  else
  if Kind = 'Get Folder Location' then 
  begin
    if StrToBool(GetFolderLocation[GetFolderLocation.IndexOf(Guid) +3]) then
      s := 'Get Common Folder Location ' 
    else
      s := 'Get Folder Location '; 
    Result := s +
      scrGetFolderLocation.Folder.Items[
        StrToInt(GetFolderLocation[GetFolderLocation.IndexOf(Guid) +2])]
      + ' into ' + GetFolderLocation[GetFolderLocation.IndexOf(Guid) +1]; 
  end
  else
  if Kind = 'Apply Changes' then 
  begin
    if StrToBool(ApplyChanges[ApplyChanges.IndexOf(Guid) +3]) then
      Result := 'Apply Install' 
    else if StrToBool(ApplyChanges[ApplyChanges.IndexOf(Guid) +4]) then
      Result := 'Apply Uninstall' 
    else Result := 'Apply Advertised'; 
    s := '';
    if ApplyChanges[ApplyChanges.IndexOf(Guid) +2] <> '' then
      s := ' (get result into variable ' + ApplyChanges[ApplyChanges.IndexOf(Guid) +2] + ')'; 
    Result := Result + s;
  end
  else
  if Kind = 'Web Media Block' then 
  begin
    WidenColonDelimParam(MediaBlock[MediaBlock.IndexOf(Guid) +3],
      Wide1, Wide2, '$MYAH_CARET$'); 
    if MediaBlock[MediaBlock.IndexOf(Guid) +1] = '' then
      Result := '[OFFLINE CONTENT' 
    else
    begin
      Result := '[DEFINE WEB MEDIA ' + 
        MediaBlock[MediaBlock.IndexOf(Guid) +1];
      if StrToBool(Wide1) then
        Result := Result + ', Exclude from Build'; 
      if Wide2 <> '' then
        Result := Result + ', Encrypt with Password ' + Wide2; 
    end;
    Result := Result + ']';
  end
  else
  if Kind = 'Download File' then
  begin
    Result := 'Download File ' + DownloadFile[DownloadFile.IndexOf(Guid) +1] +
      ' to ' + DownloadFile[DownloadFile.IndexOf(Guid) +2];
    if DownloadFile[DownloadFile.IndexOf(Guid) +3] <> '' then
      Result := Result + ', get result into variable ' +
      DownloadFile[DownloadFile.IndexOf(Guid) +3];
  end
  else
  if Kind = 'File Bag' then
  begin
    Result := 'Define File Bag : ' + FileBag[FileBag.IndexOf(Guid) +1];
    if StrToBool(FileBag[FileBag.IndexOf(Guid) +2]) then
      Result := Result + ', include files recursively';
    if FileBag[FileBag.IndexOf(Guid) +4] <> '' then
      Result := Result + ', get runtime location of files into variable ' +
      FileBag[FileBag.IndexOf(Guid) +4];
  end
  else
  if Kind = 'Code Folding Region' then 
  begin
    if StrToBool(Region[Region.IndexOf(Guid) +1]) then
      Result := '[DEFINE REGION: ' + Region[Region.IndexOf(Guid) +2] + ']' 
    else
      Result := '[END REGION]'; 
  end
  else
  if Kind = 'Delete Files' then 
  begin
    Result := 'Delete Files ' + DeleteFiles[DeleteFiles.IndexOf(Guid) +1] 
      + '/' + DeleteFiles[DeleteFiles.IndexOf(Guid) +2];
    if StrToBool(DeleteFiles[DeleteFiles.IndexOf(Guid) +3]) and
      StrToBool(DeleteFiles[DeleteFiles.IndexOf(Guid) +4]) then
        Result := Result + ' (when installing and uninstalling)' 
    else
      if StrToBool(DeleteFiles[DeleteFiles.IndexOf(Guid) +3]) then
        Result := Result + ' (when installing)' 
      else
        if StrToBool(DeleteFiles[DeleteFiles.IndexOf(Guid) +4]) then
          Result := Result + ' (when uninstalling)'; 
  end
  else
  if Kind = 'Delete Files Recursive' then 
    Result := 'Recursively Delete Files ' + DeleteRec[DeleteRec.IndexOf(Guid) +1] 
  else
  if Kind = 'Create Link' then 
  begin
    if StrToBool(CreateLink[CreateLink.IndexOf(Guid) +3]) then
      Result := 'Create Soft (Symbolic) Link '
    else
      Result := 'Create Hard Link ';
    Result := Result + CreateLink[CreateLink.IndexOf(Guid) +1] + ' to file ' +
      CreateLink[CreateLink.IndexOf(Guid) +2];
    if StrToBool(CreateLink[CreateLink.IndexOf(Guid) +5]) then
      Result := Result + ' (Shared)';
  end
  else
  if Kind = 'Parse String' then 
    Result := 'Parse String ' + Parse[Parse.IndexOf(Guid) +1] + ' into Variables ' 
      + Parse[Parse.IndexOf(Guid) +3] + ' and ' + Parse[Parse.IndexOf(Guid) +4] + 
      ' (' + scrParseString.Operation.Items[StrToInt(Parse[Parse.IndexOf(Guid) +5])] + ')'
  else
  if (Kind = 'Create File Type') or (Kind = 'Advertised File Type') then 
  begin
    WidenColonDelimParam(FileType[FileType.IndexOf(Guid) +1], Wide1, Wide2);
    WidenColonDelimParam(FileType[FileType.IndexOf(Guid) +2], Wide3, Wide4);
    Result := Kind + ' ' + Wide1 +
      ' with extensions ' + FileType[FileType.IndexOf(Guid) +6] + 
      ' and associate with program ' + Wide3; 
    if Kind[1] = 'A' then
      Result := Result + ' (unconditionally executes when owner is installed)'; 
  end
  else
  if Kind = 'Mathematics' then 
  begin
    Result := Maths[Maths.IndexOf(Guid) +4] + ' = ' +
      Maths[Maths.IndexOf(Guid) +1] + ' ';
    case StrToInt(Maths[Maths.IndexOf(Guid) +3]) of
      0: Result := Result + '+';
      1: Result := Result + '-';
      2: Result := Result + '*';
      3: Result := Result + '/';
      4: Result := Result + 'mod'; 
      5: Result := Result + 'and'; 
      6: Result := Result + 'or'; 
      7: Result := Result + 'xor'; 
      8: Result := Result + 'shl'; 
      9: Result := Result + 'shr'; 
     10: begin
           Result := Maths[Maths.IndexOf(Guid) +4] + ' = ' +
             'not ' + Maths[Maths.IndexOf(Guid) +1]; 
           Exit;
         end;
     11: begin
           Result := Maths[Maths.IndexOf(Guid) +4] + ' = ' +
             'Ord(' + Maths[Maths.IndexOf(Guid) +1] + ')'; 
           Exit;
         end;
     12: begin
           Result := Maths[Maths.IndexOf(Guid) +4] + ' = ' +
             'Chr(' + Maths[Maths.IndexOf(Guid) +1] + ')'; 
           Exit;
         end;
     13: begin
           Result := 'Set Random Number Generator Constants' + ' = ' + 
             Maths[Maths.IndexOf(Guid) +1] + ', ' +
             Maths[Maths.IndexOf(Guid) +2];
           Exit;
         end;
     14: begin
           Result := 'Set Random Number Generator Seed' + ' = ' + 
             Maths[Maths.IndexOf(Guid) +1];
           Exit;
         end;
     15: begin
           Result := Maths[Maths.IndexOf(Guid) +4] + ' = ' +
             'Generate Random Number' + ' (max value ' + 
             Maths[Maths.IndexOf(Guid) +1] + ')';
           Exit;
         end;
    end;
    Result := Result + ' ' + Maths[Maths.IndexOf(Guid) +2];
  end
  else
  if Kind = 'Read from Text File' then 
  begin
    Result := 'Read from Text File ' +  ReadText[ReadText.IndexOf(Guid) +1] + 
      ' into Variable ' + ReadText[ReadText.IndexOf(Guid) +2]; 
    if ReadText[ReadText.IndexOf(Guid) +3] <> '' then
      Result := Result + ' (get EOF into ' + 
        ReadText[ReadText.IndexOf(Guid) +3] + ')';
  end
  else
  if Kind = 'Write to Text File' then 
  begin
    Result := 'Write into Text File ' +  WriteText[WriteText.IndexOf(Guid) +1] + 
      ' from Value ' + WriteText[WriteText.IndexOf(Guid) +2] + ' ('; 
    if StrToBool(WriteText[WriteText.IndexOf(Guid) +3]) then
      Result := Result + 'at start of file' 
    else
      Result := Result + 'at end of file'; 
    Result := Result + ')';
  end
  else
  if Kind = 'Set Access Control' then 
  begin
    if StrToBool(ACL[ACL.IndexOf(Guid) +9]) then
      Result := 'Add '; 
    if StrToBool(ACL[ACL.IndexOf(Guid) +10]) then
      Result := 'Remove '; 
    if StrToBool(ACL[ACL.IndexOf(Guid) +11]) then
      Result := 'Override Permissions as '; 
    if StrToBool(ACL[ACL.IndexOf(Guid) +7]) then
      Result := Result + 'Read '; 
    WidenColonDelimParam(ACL[ACL.IndexOf(Guid) +8], Wide1, Wide2);
    if StrToBool(Wide1) then
      Result := Result + 'Write '; 
    if Wide2 <> '' then
      if StrToBool(Wide2) then
        Result := Result + 'Execute '; 
    if StrToBool(ACL[ACL.IndexOf(Guid) +9]) then
      Result := Result + 'Permissions to'; 
    if StrToBool(ACL[ACL.IndexOf(Guid) +10]) then
      Result := Result + 'Permissions from'; 
    if StrToBool(ACL[ACL.IndexOf(Guid) +11]) then
      Result := Result + 'on'; 
    if StrToBool(ACL[ACL.IndexOf(Guid) +12]) then
      Result := Result + ' File System Object'; 
    if StrToBool(ACL[ACL.IndexOf(Guid) +13]) then
      Result := Result + ' Folder Share'; 
    if StrToBool(ACL[ACL.IndexOf(Guid) +14]) then
      Result := Result + ' Registry Key'; 
    if StrToBool(ACL[ACL.IndexOf(Guid) +15]) then
      Result := Result + ' Service'; 
    if StrToBool(ACL[ACL.IndexOf(Guid) +16]) then
      Result := Result + ' Printer Object'; 
    Result := Result + ' "';
    Result := Result + ACL[ACL.IndexOf(Guid) +1] + '"';
    if StrToBool(ACL[ACL.IndexOf(Guid) +9]) then
    begin
      Result := Result + ' for '; 
      if StrToBool(ACL[ACL.IndexOf(Guid) +2]) then
        Result := Result + 'Other '; 
      if StrToBool(ACL[ACL.IndexOf(Guid) +3]) then
        Result := Result + 'Owner '; 
      if StrToBool(ACL[ACL.IndexOf(Guid) +4]) then
        Result := Result + 'Group '; 
      if StrToBool(ACL[ACL.IndexOf(Guid) +5]) then
        Result := Result + ACL[ACL.IndexOf(Guid) +6];
    end;
  end
  else
  if Kind = 'Set Owner' then 
  begin
    Result := 'Set Owner on ' + Own[Own.IndexOf(Guid) +1] + ' to';
    if StrToBool(Own[Own.IndexOf(Guid) +2]) then
      Result := Result + ' Current User'
    else
    if StrToBool(Own[Own.IndexOf(Guid) +3]) then
      Result := Result + ' Root User'
    else
    if StrToBool(Own[Own.IndexOf(Guid) +4]) then
      Result := Result + ' Named User (' + Own[Own.IndexOf(Guid) +5] + ')';
  end
  else
  if Kind = 'Set Group' then 
    Result := 'Set Group on ' + Grp[Grp.IndexOf(Guid) +1] + ' to ' +
      Grp[Grp.IndexOf(Guid) +2]
  else
  if Kind = 'Check File Version' then 
    Result := 'Check File Version ' + CheckVersion[CheckVersion.IndexOf(Guid) +2] 
      + ' into Variable ' + CheckVersion[CheckVersion.IndexOf(Guid) +1] 
  else
  if Kind = 'Get File Version' then 
    Result := 'Get File Version ' + GetVers[GetVers.IndexOf(Guid) +1] + 
      ' into Variable ' + GetVers[GetVers.IndexOf(Guid) +2] 
  else
  if Kind = 'Get File Size' then
    Result := 'Get File Size ' + xGetFileSize[xGetFileSize.IndexOf(Guid) +2] + ' into variable ' + xGetFileSize[xGetFileSize.IndexOf(Guid) +1]
  else
  if Kind = 'For Each' then
    Result := 'for each Element ' + xForEach[xForEach.IndexOf(Guid) + 1] + ' in ' + xForEach[xForEach.IndexOf(Guid) + 2] + ' delimited Collection of ' + xForEach[xForEach.IndexOf(Guid) + 3] + ' do'
  else
  if Kind = 'Sleep' then
    Result := 'Sleep for ' + xSleep[xSleep.IndexOf(Guid) +1] + ' milliseconds'
  else
  if Kind = 'Terminate with Exit Code' then 
    Result := 'Terminate with Exit Code ' + 
      TermExitCode[TermExitCode.IndexOf(Guid) +1]
  else
  if Kind = 'Convert Path' then 
  begin
    if StrToBool(ConvertPath[ConvertPath.IndexOf(Guid) +2]) then
      s := 'Convert to Short Path: ' 
    else
      s := 'Convert to Long Path: '; 
    Result := s + ConvertPath[ConvertPath.IndexOf(Guid) +1] + ' '
  end
  else
  if Kind = 'Convert Case' then 
  begin
    Result := 'Convert Variable ' + ConvertCase[ConvertCase.IndexOf(Guid) +1] + ' to '; 
    if StrToBool(ConvertCase[ConvertCase.IndexOf(Guid) +2]) then
      Result := Result + 'UPPER case' 
    else
      Result := Result + 'lower case'; 
  end
  else
  if Kind = 'Extract Path' then 
  begin
    case StrToInt(ExtractPath[ExtractPath.IndexOf(Guid) +2]) of
      0: Result := 'Extract Full File Name'; 
      1: Result := 'Extract File Name Only'; 
      2: Result := 'Extract File Extension Only'; 
      3: Result := 'Extract File Folder'; 
      4: Result := 'Extract Parent Folder'; 
      5: Result := 'Extract Parent Drive'; 
      6: Result := 'Replace \\ with \' 
    end;
    Result := Result + ': ' + ExtractPath[ExtractPath.IndexOf(Guid) +1];
  end
  else
  if Kind = 'Format String' then
    Result := 'Format string "' + FormatStr[FormatStr.IndexOf(Guid) +3] + '" according to "' + FormatStr[FormatStr.IndexOf(Guid) +2] + '", return result in variable ' + FormatStr[FormatStr.IndexOf(Guid) +1]
  else
  if Kind = 'Get Link Target' then
    Result := 'Get Link Target of "' + GetLink[GetLink.IndexOf(Guid) +1] + '" into variable ' +
      GetLink[GetLink.IndexOf(Guid) +2]
  else
  if Kind = 'Get String Length' then
    Result := 'Get String Length of "' + GetStrLen[GetStrLen.IndexOf(Guid) +1] + '" into variable ' +
      GetStrLen[GetStrLen.IndexOf(Guid) +2]
  else
  if Kind = 'Evaluate Expression' then 
    Result := 'Evaluate Expression ' + Eval[Eval.IndexOf(Guid) +1] + ' into variable ' 
      + Eval[Eval.IndexOf(Guid) +2]
  else
  if Kind = 'Get String Position' then
  begin
    Result := 'Get String Position of "' +
      GetStrPos[GetStrPos.IndexOf(Guid) +2] +
      '" in "' + GetStrPos[GetStrPos.IndexOf(Guid) +3] +
      '" into variable ' + GetStrPos[GetStrPos.IndexOf(Guid) +1];
    if StrToBool(GetStrPos[GetStrPos.IndexOf(Guid) +4]) then
      Result := Result + ' (ignore case)';
  end
  else
  if Kind = 'Localization Variable' then 
  begin
    sZ := LocVar[LocVar.IndexOf(Guid) +1];
    Result := 'Set Localization Variable'; 
    Result := Result + ' ' + LocVar[LocVar.IndexOf(Guid) +1] +
      ' to ' + LocVar[LocVar.IndexOf(Guid) +2]; 
  end
  else
  if Kind = 'Replace String' then 
    Result := 'Replace ' + ReplaceStr[ReplaceStr.IndexOf(Guid) +2] + ' with ' + 
      ReplaceStr[ReplaceStr.IndexOf(Guid) +3] + ' in variable ' + 
      ReplaceStr[ReplaceStr.IndexOf(Guid) +1]
  else
  if Kind = 'Browse for Folder' then
  begin
    Result := 'Browse for a folder path into variable ' + xBrowseFolder[xBrowseFolder.IndexOf(Guid) +3] + ', with caption ' +
      xBrowseFolder[xBrowseFolder.IndexOf(Guid) +1];
    if xBrowseFolder[xBrowseFolder.IndexOf(Guid) +2] <> '' then
      Result := Result + ', based out of root directory ' + xBrowseFolder[xBrowseFolder.IndexOf(Guid) +2];
  end
  else
  if Kind = 'Browse for File' then
  begin
    Result := 'Browse for a(n) ';
    if StrToBool(xBrowseFile[xBrowseFile.IndexOf(Guid) +2]) then
      Result := Result + 'open ';
    if StrToBool(xBrowseFile[xBrowseFile.IndexOf(Guid) +3]) then
      Result := Result + 'save ';
    Result := Result + 'file path into variable ' + xBrowseFile[xBrowseFile.IndexOf(Guid) +4] + ', with caption ' +
      xBrowseFile[xBrowseFile.IndexOf(Guid) +1];
    if xBrowseFile[xBrowseFile.IndexOf(Guid) +6] <> '' then
      Result := Result + ', start at default directory ' + xBrowseFile[xBrowseFile.IndexOf(Guid) +6];
  end
  else
  if Kind = 'Load Feature Selections' then 
    Result := 'Load Feature Selections from file ' + 
      LoadFeatures[LoadFeatures.IndexOf(Guid) +1]
  else
  if Kind = 'Prompt for Text' then
  begin
    Result := 'Prompt for text into variable ' + xPromptForText[xPromptForText.IndexOf(Guid) +2] + ', with caption ' +
      xPromptForText[xPromptForText.IndexOf(Guid) +1];
  end
  else
  if Kind = 'Save Feature Selections' then 
    Result := 'Save Feature Selections into file ' + 
      SaveFeatures[SaveFeatures.IndexOf(Guid) +1]
  else
  if Kind = 'Set Component Choice' then 
  begin
    if StrToBool(SetChoice[SetChoice.IndexOf(Guid) +2]) then
      Result := 'Allow' 
    else
      Result := 'Do not allow'; 
    Result := Result + ' user to select or deselect Component: ' + SetChoice[SetChoice.IndexOf(Guid) +1]; 
  end
  else
  if Kind = 'Get Component Space' then 
  begin
    if GetSpace[GetSpace.IndexOf(Guid) +1] = '' then
      Result := 'Get Total Required Space' 
    else
      Result := 'Get Required Space by Component ' + GetSpace[GetSpace.IndexOf(Guid) +1]; 
    Result := Result + ' into variable ' + GetSpace[GetSpace.IndexOf(Guid) +2]; 
  end
  else
  if Kind = 'Set Component Visibility' then 
  begin
    if StrToBool(SetVisibility[SetVisibility.IndexOf(Guid) +2]) then
      Result := 'Show' 
    else
      Result := 'Hide'; 
    Result := Result + ' Component: ' + SetVisibility[SetVisibility.IndexOf(Guid) +1]; 
  end
  else
  if Kind = 'Check Disk Space' then 
  begin
    Result := 'Get '; 
    if StrToBool(CheckSpace[CheckSpace.IndexOf(Guid) +3]) then
      Result := Result + 'Free ' 
    else
      Result := Result + 'Total '; 
    Result := Result + 'Space on ' + 
      CheckSpace[CheckSpace.IndexOf(Guid) +2] + ' into variable ' + 
      CheckSpace[CheckSpace.IndexOf(Guid) +1];
  end
  else
  if Kind = 'Match Regular Expression' then
    Result := 'Match string "' + RegEx[RegEx.IndexOf(Guid) +3] + '" to regular expression "' + RegEx[RegEx.IndexOf(Guid) +2] + '", return result in variable ' + RegEx[RegEx.IndexOf(Guid) +1]
  else
  if Kind = 'Does File/Folder Exist' then 
  begin
    WidenColonDelimParam(DoesExist[DoesExist.IndexOf(Guid) +3], Wide1, Wide2);
    if Wide2 = '' then Wide2 := 'FALSE';
    if StrToBool(Wide1) then
      Result := 'Does File Exist ' 
    else
      Result := 'Does Folder Exist '; 
    if StrToBool(Wide2) then
      Result := Result + '(resolve link target) ';
    Result := Result + DoesExist[DoesExist.IndexOf(Guid) +2] + ' (get result into variable ' 
      + DoesExist[DoesExist.IndexOf(Guid) +1] + ')';
  end
  else
  if Kind = 'Find All Files' then 
  begin
    WidenColonDelimParam(FAF[FAF.IndexOf(Guid) +3], Wide1, Wide2);
    if Wide2 = '' then Wide2 := 'FALSE';
    Result := 'Find All Files in path ' + FAF[FAF.IndexOf(Guid) +1]; 
    if StrToBool(FAF[FAF.IndexOf(Guid) +2]) then
      Result := Result + ' (include subfolders)'; 
    if StrToBool(Wide2) then
      Result := Result + ' (follow linked folders)'; 
    Result := Result + ', write result into variable ' + 
      FAF[FAF.IndexOf(Guid) +4];
  end
  else
  if Kind = 'Generate GUID' then 
    Result := 'Generate GUID into Variable ' + xGUID[xGUID.IndexOf(Guid) +1] 
  else
  if Kind = 'Get Environment' then 
  begin
    if GetEnv[GetEnv.IndexOf(Guid) +1] <> '' then
      Result := 'Get Environment Variable %' + GetEnv[GetEnv.IndexOf(Guid) +1] + 
        '% into Variable ' 
    else
      Result := 'Get All Environment Variables into Variable '; 
    Result := Result + GetEnv[GetEnv.IndexOf(Guid) +2];
  end
  else
  if Kind = 'Get INI File Settings' then 
    Result := 'Get INI ' + GetIni[GetIni.IndexOf(Guid) +2] + 
      ', [' + GetIni[GetIni.IndexOf(Guid) +3] + '] ' +
      GetIni[GetIni.IndexOf(Guid) +4] + ' Value into Variable ' + 
      GetIni[GetIni.IndexOf(Guid) +1]
  else
  if Kind = 'Get Temporary File' then 
    Result := 'Get Temporary File Name into Variable ' + GetTemp[GetTemp.IndexOf(Guid) +1] 
  else
  if Kind = 'Is Native Setup Installed' then 
    Result := 'Get Installed State for Native Setup ' + IsNative[IsNative.IndexOf(Guid) +1] + 
      ' into Variable ' + IsNative[IsNative.IndexOf(Guid) +2] 
  else
  if Kind = 'Read from Binary File' then
    Result := 'Read ' + xReadBinary[xReadBinary.IndexOf(Guid) +4]
      + ' bytes from binary file ' + xReadBinary[xReadBinary.IndexOf(Guid) +1]
      + ' at offset ' + xReadBinary[xReadBinary.IndexOf(Guid) +3]
      + ' into variable ' + xReadBinary[xReadBinary.IndexOf(Guid) +2]
  else
  if Kind = 'Copy/Move Local Files' then 
  begin
    WidenColonDelimParam(LocalFiles[LocalFiles.IndexOf(Guid) +6], Wide1, Wide2);
    if Wide2 = '' then Wide2 := 'FALSE';
    WidenColonDelimParam(LocalFiles[LocalFiles.IndexOf(Guid) +5], Wide3, Wide4);
    if Wide4 = '' then Wide4 := 'FALSE';
    if StrToBool(Wide3) then
      Result := 'Copy' 
    else
      Result := 'Move'; 
    Result := Result + ' Local Files ' + 
      LocalFiles[LocalFiles.IndexOf(Guid) +1] + PathDelim +
      LocalFiles[LocalFiles.IndexOf(Guid) +2] + ' to ' + 
      LocalFiles[LocalFiles.IndexOf(Guid) +3] + PathDelim +
      LocalFiles[LocalFiles.IndexOf(Guid) +4];
    if StrToBool(Wide4) then
      Result := Result + '(resolve link targets) ';
    if StrToBool(Wide2) then
      Result := Result + ' (include subfolders)';
  end
  else
  if Kind = 'Set 64 Bit Mode' then 
  begin
    Result := 'Set '; 
    if StrToBool(Plat[Plat.IndexOf(Guid) +1]) then
      Result := Result + scrSet64BitMode.Win32.Caption;
    if StrToBool(Plat[Plat.IndexOf(Guid) +2]) then
      Result := Result + scrSet64BitMode.ia64.Caption;
    if StrToBool(Plat[Plat.IndexOf(Guid) +3]) then
      Result := Result + scrSet64BitMode.x64.Caption;
    Result := Result + ' - installation mode'; 
    Result := StringReplace(Result, '&', '', [rfReplaceAll, rfIgnoreCase]);
  end
  else
  if Kind = 'Edit INI File' then 
    Result := 'Edit INI File ' + EditIni[EditIni.IndexOf(Guid) +1] + '\' + 
      EditIni[EditIni.IndexOf(Guid) +2] + ', [' +
      EditIni[EditIni.IndexOf(Guid) +4] + '] ' +
      EditIni[EditIni.IndexOf(Guid) +5] + '=' +
      EditIni[EditIni.IndexOf(Guid) +6]
  else
  if Kind = 'Rename File/Folder' then
    Result := 'Rename ' + xRename[xRename.IndexOf(Guid) +1] + ' to ' + xRename[xRename.IndexOf(Guid) +2]
  else
  if Kind = 'Write to Binary File' then
  begin
    Result := 'Write ' + xWriteBinary[xWriteBinary.IndexOf(Guid) +2] + ' to binary file ' + xWriteBinary[xWriteBinary.IndexOf(Guid) +1] + ' at offset ' + xWriteBinary[xWriteBinary.IndexOf(Guid) +3];
    if StrToBool(xWriteBinary[xWriteBinary.IndexOf(Guid) +4]) then
      Result := Result + ' (appending a null terminator)';
  end
  else
  if Kind = 'Halt Compilation' then 
    Result := '[Halt Compilation] ' + HaltCompile[HaltCompile.IndexOf(Guid) +1] 
  else
  if Kind = 'Reboot and Resume' then 
    Result := 'Reboot Computer and Resume Setup' 
  else
  if Kind = 'Reboot Computer' then 
    Result := 'Reboot Computer' 
  else
  if Kind = 'Delete Registry' then 
  begin
    if StrToBool(DeleteReg[DeleteReg.IndexOf(Guid) +4]) then
      Result := 'KEY' 
    else
      Result := 'VALUE'; 
    WidenColonDelimParam(DeleteReg[DeleteReg.IndexOf(Guid) +1], Wide1, Wide2);
    case StrToInt(Wide1) of
      0: Result := Result + ' ' + 'HKCR'; 
      1: Result := Result + ' ' + 'HKCU'; 
      2: Result := Result + ' ' + 'HKLM'; 
      3: Result := Result + ' ' + 'HKU'; 
      4: Result := Result + ' ' + 'HKCC'; 
    end;
    if not ((StrToInt(Wide1) = 2) or (StrToInt(Wide1) = 3)) then
      Wide2 := '';
    Result := 'Delete Registry ' + Result + '\' + 
      DeleteReg[DeleteReg.IndexOf(Guid) +2] + '\';
    if not StrToBool(DeleteReg[DeleteReg.IndexOf(Guid) +4]) then
      Result := Result + DeleteReg[DeleteReg.IndexOf(Guid) +3]
    else
      Result := Result + '*.*';
    if Wide2 <> '' then
      Result := 'Remote ' + Result + ' (from computer ' + Wide2 + ')';
  end
  else
  if Kind = 'Find All Registry' then
  begin
    WidenColonDelimParam(FindAllReg[FindAllReg.IndexOf(Guid) +1], Wide1, Wide2);
    case StrToInt(FindAllReg[FindAllReg.IndexOf(Guid) +2]) of
      0: Result := 'HKCR'; 
      1: Result := 'HKCU'; 
      2: Result := 'HKLM'; 
      3: Result := 'HKU'; 
      4: Result := 'HKCC'; 
    end;
    if not ((Result = 'HKLM') or (Result = 'HKU')) then
      Wide2 := '';
    if StrToBool(FindAllReg[FindAllReg.IndexOf(Guid) +4]) then
      Result := 'Keys in ' + Result
    else
      Result := 'Values in ' + Result;
    if Wide2 <> '' then
      Result := 'Find All Remote Registry ' + Result + '\' +
        FindAllReg[FindAllReg.IndexOf(Guid) +3] + ' into ' +
        Wide1 + ' (from computer ' + Wide2 + ')'
    else
      Result := 'Find All Registry ' + Result + '\' +
        FindAllReg[FindAllReg.IndexOf(Guid) +3] + ' into ' +
        Wide1;
  end
  else
  if Kind = 'Get OS or SP Level' then 
  begin
    if StrToBool(ExactVer[ExactVer.IndexOf(Guid) +2]) then
      Result := 'Get Exact OS Level'; 
    if StrToBool(ExactVer[ExactVer.IndexOf(Guid) +3]) then
      Result := 'Get Exact SP Level'; 
    Result := Result + ' into ' + ExactVer[ExactVer.IndexOf(Guid) +1]; 
  end
  else
  if Kind = 'Get System Settings' then 
  begin
    Result := 'Get System Setting ' + 
      scrGetSystemSettings.Capability.Items[
        StrToInt(GetSystemSettings[GetSystemSettings.IndexOf(Guid) +2])]
      + ' into ' + GetSystemSettings[GetSystemSettings.IndexOf(Guid) +1]; 
  end
  else
  if Kind = 'Get Native Settings' then 
  begin
    Result := 'Get Native Setting ' + 
      scrGetNativeSettings.Capability.Items[
        StrToInt(GetNativeSettings[GetNativeSettings.IndexOf(Guid) +2])]
      + ' into ' + GetNativeSettings[GetNativeSettings.IndexOf(Guid) +1]; 
  end
  else
  if (Kind = 'Read Registry') or (Kind = 'Check Registry') then 
  begin
    case StrToInt(ReadReg[ReadReg.IndexOf(Guid) +2]) of
      0: Result := 'HKCR'; 
      1: Result := 'HKCU'; 
      2: Result := 'HKLM'; 
      3: Result := 'HKU'; 
      4: Result := 'HKCC'; 
    end;
    WidenColonDelimParam(ReadReg[ReadReg.IndexOf(Guid) +1], Wide1, Wide2);
    Result := Kind +  ' Key ' + Result + '\' + 
      ReadReg[ReadReg.IndexOf(Guid) +3] + '\' +
      ReadReg[ReadReg.IndexOf(Guid) +4] + ' into ' + 
      Wide1;
    if (ReadReg[ReadReg.IndexOf(Guid) +2] = '2') or (ReadReg[ReadReg.IndexOf(Guid) +2] = '3') then
      if Wide2 <> '' then
        Result := 'Remote ' + Result + ' (from computer ' + Wide2 + ')';
  end
  else
  if Kind = 'Write Registry' then 
  begin
    i := WriteReg.IndexOf(Guid);
    WidenColonDelimParam(WriteReg[i  +2], Wide1, Wide2);
    case StrToInt(Wide1) of
      0: Result := 'HKCR'; 
      1: Result := 'HKCU'; 
      2: Result := 'HKLM'; 
      3: Result := 'HKU'; 
      4: Result := 'HKUD'; 
    end;
    Result := 'Write Registry Key ' + Result + '\' + 
      WriteReg[i  +3] + '\' +
      WriteReg[i  +4] + ', ' +
      WriteReg[i  +5];
    if WriteReg[i  +1] = '10' then 
      Result := Result + ' (permanent)'; 
    if (Wide1 = '2') or (Wide1 = '3') then
      if Wide2 <> '' then
        Result := 'Remote ' + Result + ' (to computer ' + Wide2 + ')';
  end
  else
  if Kind = 'Compress 7Zip Archive' then 
  begin
    Result := 'Compress 7Zip Archive ' + Compress7Zip[Compress7Zip.IndexOf(Guid) +1];
    if Compress7Zip[Compress7Zip.IndexOf(Guid) +3] <> '' then
      Result := Result + ' with recursive files ' + Compress7Zip[Compress7Zip.IndexOf(Guid) +3] + ','; 
    if Compress7Zip[Compress7Zip.IndexOf(Guid) +4] <> '' then
      Result := Result + ' with non-recursive files ' + Compress7Zip[Compress7Zip.IndexOf(Guid) +4] + ','; 
    Result := Result + ' using the ' + scrCompress7Zip.ArchiveType.Items[StrToInt(Compress7Zip[Compress7Zip.IndexOf(Guid) +5])] + ' algorithm'; 
    if Compress7Zip[Compress7Zip.IndexOf(Guid) +10] <> '' then
      Result := Result + ' (get result into variable ' + Compress7Zip[Compress7Zip.IndexOf(Guid) +10] + ')'; 
  end
  else
  if Kind = 'Extract 7Zip Archive' then 
  begin
    Result := 'Extract 7Zip Archive ' + Extract7Zip[Extract7Zip.IndexOf(Guid) +1] + 
      ' into folder ' + Extract7Zip[Extract7Zip.IndexOf(Guid) +2]; 
    if Extract7Zip[Extract7Zip.IndexOf(Guid) +3] <> '' then
      Result := Result + ' (get result into variable ' + Extract7Zip[Extract7Zip.IndexOf(Guid) +3] + ')'; 
  end
  else
  if Kind = 'Return from Include Script' then
  begin
    Result := Kind;
    if ReturnInclude[ReturnInclude.IndexOf(Guid) +1] <> '' then
      Result := Result + ' with result ' + ReturnInclude[ReturnInclude.IndexOf(Guid) +1];
  end
  else
  if Kind = 'Run Program As' then
  begin
    if RunProgramAs[RunProgramAs.IndexOf(Guid) +5] <> '' then
    begin
      if RunProgramAs[RunProgramAs.IndexOf(Guid) +5] = '$MYAH_UAC$' then
        Result := 'Run Program capturing live console output '
      else
        if RunProgramAs[RunProgramAs.IndexOf(Guid) +5] = '$MYAH_UACEX$' then
          Result := 'Run Program elevated  '
        else
          if RunProgramAs[RunProgramAs.IndexOf(Guid) +5] = '$MYAH_UACEY$' then
            Result := 'Run Program elevated and capturing live console output ';
    end
    else
      Result := 'Run Program '; 
    Result := Result + RunProgramAs[RunProgramAs.IndexOf(Guid) +1] +
        ' ' + RunProgramAs[RunProgramAs.IndexOf(Guid) +3];
    if RunProgramAs[RunProgramAs.IndexOf(Guid) +2] <> '' then
      Result := Result + ', startup in folder ' + RunProgramAs[RunProgramAs.IndexOf(Guid) +2]; 
    if StrToBool(RunProgramAs[RunProgramAs.IndexOf(Guid) +9]) then
    begin
      Result := Result + ' (WAIT';
      if RunProgramAs[RunProgramAs.IndexOf(Guid) +7] <> '' then
        Result := Result + ', log output to file ' + RunProgramAs[RunProgramAs.IndexOf(Guid) +7];
      if RunProgramAs[RunProgramAs.IndexOf(Guid) +8] <> '' then
        Result := Result + ', get result into variable ' + RunProgramAs[RunProgramAs.IndexOf(Guid) +8];
      Result := Result + ')'; 
    end;
  end
  else
  if Kind = 'Refresh Shell' then 
    Result := 'Refresh Shell' 
  else
  if Kind = 'Check Process' then 
    Result := 'Check for Process "' + CheckProcess[CheckProcess.IndexOf(Guid) +1] 
      + '", get result into variable ' + CheckProcess[CheckProcess.IndexOf(Guid) +2] 
  else
  if Kind = 'Run Script' then 
  begin
    Result := 'Run ' + 'Script';
    {$IFDEF WINDOWS}
    if StrToInt(xRunScript[xRunScript.IndexOf(Guid) +2]) <> 0 then
      Result := Result + ', with ' + IntToStr(StrToInt(xRunScript[xRunScript.IndexOf(Guid) +2]) div 1000) + ' second(s) time-out';
    if StrToBool(xRunScript[xRunScript.IndexOf(Guid) +3]) then
      Result := Result + ', without unsafe constructs'
    else
      Result := Result + ', with unsafe constructs';
    if StrToBool(xRunScript[xRunScript.IndexOf(Guid) +4]) then
      Result := Result + ', with unconditional user interface interaction'
    else
      if StrToBool(xRunScript[xRunScript.IndexOf(Guid) +5]) then
        Result := Result + ', with user interface interaction enabled for non-silent setups only'
      else
        Result := Result + ', without any user interface interaction';
    {$ENDIF}
    if xRunScript[xRunScript.IndexOf(Guid) +6] <> '' then
      Result := Result + ', get result into variable ' + xRunScript[xRunScript.IndexOf(Guid) +6];
  end
  else
  if Kind = 'Wizard Loop' then 
    Result := 'wizard loop'; 
    
end;

function Tui.RemoveStackItem(Stack: TList; var Kind, Elements: String;
  IgnoreContext: Boolean): Boolean;
var
  i: Integer;
  l: TStringList;
begin
  Result := false;
  if Stack.Count = 0 then Exit;
  for i := Stack.Count downto 1 do
    if IgnoreContext or (TStringList(Stack[i -1])[0] = LastActiveContext) then
    begin
      l := TStringList(Stack[i -1]);
      Stack.Delete(i -1);
      Kind := l[1];
      Elements := l[2];
      l.Free;
      Result := True;
      Exit;
    end;
end;

procedure Tui.ClearStack(Stack: TList);
var
  s, sX: String;
begin
  repeat
  until not RemoveStackItem(Stack, s, sX);
end;

procedure Tui.FreeSavedContexts;
var
  i, j: Integer;
begin
  for i := 1 to AllContextBuffers.Count do
  begin
    for j := 1 to TList(AllContextBuffers.Objects[i -1]).Count do
      TStringList(TList(AllContextBuffers.Objects[i -1]).Items[j -1]).Free;
    TList(AllContextBuffers.Objects[i -1]).Free;
  end;
  AllContextBuffers.Clear;
  AllContextBuffersEx.Clear;
end;

procedure Tui.SaveContext(SaveAs: String);
var
  i: Integer;
  SavedStrings: THashedStringList;
  SaveToContext: TList;
  l, lX: THashedStringList;
begin
  
  SaveToContext := nil;
  if AllContextBuffers.IndexOf(SaveAs) <> -1 then
    SaveToContext := TList(AllContextBuffers.Objects[AllContextBuffers.IndexOf(SaveAs)]);
  
  if SaveToContext = nil then
  begin
    SaveToContext := TList.Create;
    AllContextBuffersEx.Add('');
    AllContextBuffers.Add(SaveAs);
    AllContextBuffers.Objects[AllContextBuffers.Count -1] := SaveToContext;
    
    for i := 1 to GlobalLists.Count +8 do
    begin
      
      SavedStrings := THashedStringList.Create;
      SaveToContext.Add(SavedStrings);
      
    end;
  end;
  
  AllContextBuffersEx[AllContextBuffers.IndexOf(SaveAs)] :=
    IntToStr(Script.ItemIndex);
  for i := 1 to GlobalLists.Count +8 do
  begin
    if i <= GlobalLists.Count then
      THashedStringList(SaveToContext.Items[i -1]).Text :=
        THashedStringList(GlobalLists.Items[i -1]).Text
    else
    begin
      if i = GlobalLists.Count +1 then
        lX := ScriptTypes;
      if i = GlobalLists.Count +2 then
        lX := ScriptReferences;
      if i = GlobalLists.Count +3 then
        lX := ScriptComments;
      if i = GlobalLists.Count +4 then
        lX := ScriptFetches;
      if i = GlobalLists.Count +5 then
        lX := ScriptFolds;
      if i = GlobalLists.Count +6 then
        lX := FoldList;
      if i = GlobalLists.Count +7 then
        lX := Breakpoints;
      if i = GlobalLists.Count +8 then
        lX := Bookmarks;
      THashedStringList(SaveToContext.Items[i -1]).Text := lX.Text;
    end;
  end;
end;

procedure Tui.FreeContext(Context: String);
var
  Cntx: TList;
  i: Integer;
begin
  if AllContextBuffers.IndexOf(Context) = -1 then
    raise Exception.Create(SUnableToFindSavedScriptContextFo + Context);
  
  Cntx := TList(AllContextBuffers.Objects[AllContextBuffers.IndexOf(Context)]);
  for i := 1 to Cntx.Count do
    TStringList(Cntx[i -1]).Free;
  Cntx.Free;
  i := AllContextBuffers.IndexOf(Context);
  AllContextBuffers.Delete(i);
  AllContextBuffersEx.Delete(i);
end;

procedure Tui.SwitchContext(NewContext: String);
var
  i: Integer;
  SavedStrings: THashedStringList;
  LoadFromContext: TList;
  l, lX: THashedStringList;
begin
  if AllContextBuffers.IndexOf(NewContext) = -1 then
    raise Exception.Create(SUnableToFindSavedScriptContextFo + NewContext);
  
  LoadFromContext := TList(AllContextBuffers.Objects[AllContextBuffers.IndexOf(NewContext)]);
  
  for i := 1 to GlobalLists.Count +8 do
  begin
    if i <= GlobalLists.Count then
      THashedStringList(GlobalLists.Items[i -1]).Text :=
        THashedStringList(LoadFromContext.Items[i -1]).Text
    else
    begin
      if i = GlobalLists.Count +1 then
        lX := ScriptTypes;
      if i = GlobalLists.Count +2 then
        lX := ScriptReferences;
      if i = GlobalLists.Count +3 then
        lX := ScriptComments;
      if i = GlobalLists.Count +4 then
        lX := ScriptFetches;
      if i = GlobalLists.Count +5 then
        lX := ScriptFolds;
      if i = GlobalLists.Count +6 then
        lX := FoldList;
      if i = GlobalLists.Count +7 then
        lX := Breakpoints;
      if i = GlobalLists.Count +8 then
        lX := Bookmarks;
      lX.Text := THashedStringList(LoadFromContext.Items[i -1]).Text;
    end;
  end;
  ui.Script.Items.Clear;
  if not globBlockRenderScript then RenderScript;
  i := StrToInt(AllContextBuffersEx[AllContextBuffers.IndexOf(NewContext)]);
  if i <> -1 then
    if Script.Items.Count <> 0 then
    begin
      Script.ItemIndex := i;
      Script.Selected[i] := True;
    end;
end;

function Tui.LoadContextFromDisk(Context, DiskFile: String): Boolean;
var
  BackupMainScriptName: String;
begin
  
  SaveContext('myah-predef-compile-context'); 
  
  BackupMainScriptName := ScriptFile;
  ClearProjectStructs(True);
  
  Result := LoadScriptEx(DiskFile);
  if not Result then Exit;
  
  ScriptFile := BackupMainScriptName;
  
  SaveContext(Context);
  
  SwitchContext('myah-predef-compile-context'); 
  
  FreeContext('myah-predef-compile-context'); 
end;

function Tui.LoadScriptEx(sScriptFile: String; Import: Boolean = false): Boolean;
var
  sX, sY, sZ: String;
  l: TStringList;
  i: Integer;
begin
  if Import then
  begin
    sY := '.fld';
    sZ := '.brk';
  end
  else
  begin
    sY := '.fldx';
    sZ := '.brkx';
  end;
  Result := True;
  sX := LoadScript(sScriptFile, Import);
  if sX <> '' then
  begin
    Result := false;
    Application.MessageBox(PChar(SThisScriptUsesAPlugInThatIsNotAv + MyLineEnding + sX + MyLineEnding + MyLineEnding +
      SPleaseInstallThisPlugInBeforeOpe + SToInstallPlugIns1OpenTheControlP),
    PChar(SScriptLoadError), mb_Ok + mb_IconStop);
    ClearProjectStructs;
    
    SetDirtyAll(false);
    AdjustUIProjectChanged;
    RenderScript;
    l := TStringList.Create;
    l.Add('');
    RenderInsertScriptEx('Comment', Comments, l, 0, True); 
    l.Free;
    RehashIndents;
    
    SetDirtyAll(false);
  end
  else
  begin
    if sScriptFile = ScriptFile then
      sScriptFile := GetFullProjectScriptFilePath;
    if MyFileExists(sScriptFile + sY) then 
      FoldList.LoadFromFile(sScriptFile + sY, TEncoding.UTF8); 
    if MyFileExists(sScriptFile + sZ) then 
      Breakpoints.LoadFromFile(sScriptFile + sZ, TEncoding.UTF8); 
    
      while Breakpoints.Count < ScriptTypes.Count do
        Breakpoints.Add('');
    if MyFileExists(sScriptFile + '.bokx') then 
      Bookmarks.LoadFromFile(sScriptFile + '.bokx', TEncoding.UTF8); 
    while Bookmarks.Count < ScriptTypes.Count do
      Bookmarks.Add('');
    ApplySavedCodeFolding;
  end;
end;

function Tui.LoadScript(sScriptFile: String; Import: Boolean = false): String;
var
  l: TStringList;
  i, j: Integer;
  jX, jY, jZ, jA: Integer;
  t: TextFile;
  s: String;
  
  sX, sY: String;
  iX: Integer;
  
  CacheS: String;
  hWait, hDef: THandle;
  BOM: Char;
  
  lX: TStringList;
begin
  if Import then
    PushStatusStack('Importing script ' + sScriptFile)
  else
    PushStatusStack('Loading script ' + sScriptFile);
  try
    Result := '';
    
    if ExtractFilePath(sScriptFile) = '' then
      AssignFile(t, AssertDir(ExtractFilePath(CurrentProjectName)) + sScriptFile, cp_utf8)
    else
      AssignFile(t, sScriptFile, CP_UTF8);
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
    s := '';
    
    while not EOF(t) and (s <> '$') do
    begin
      ReadLn(t, s);
      if s <> '$' then
        
          ScriptTypes.Add(s)
        ;
    end;
    s := '';
    
    while not EOF(t) and (s <> '$') do
    begin
      ReadLn(t, s);
      if s <> '$' then ScriptReferences.Add(s);
    end;
    
    s := '';
    iX := 0;
    try
      while not EOF(t) and (s <> '$') do
      begin
        repeat
          ReadLn(t, s);
        until (ScriptReferences.IndexOf(s) <> -1) or (s = '$'); 
        sX := s;
        iX := iX +1;
        if s = '$' then Break;
        
        CacheS := ScriptTypes[ScriptReferences.IndexOf(s)];
        if Import then 
        begin
          jX := -1;
          jY := -1;
          jZ := -1;
          jA := -1;
        end;
        if CacheS = 'Comment' then 
        begin
          i := 1;
          l := Comments;
        end
        else
        if CacheS = 'MessageBox' then 
        begin
          i := 5;
          l := xMessageBox;
        end
        else
        if CacheS = 'Set Variable' then 
        begin
          i := 2;
          l := SetVariable;
        end
        else
        if ((CacheS = 'If') or 
          (CacheS = 'Else If')) or 
          ((CacheS = 'Compiler Variable If') or
          ((CacheS = 'While') or (CacheS = 'Until'))) then 
        begin
          i := 4;
          if CacheS = 'While' then
            l := xWhile
          else
          if CacheS = 'Until' then
            l := xUntil
          else
            l := xIf;
        end
        else
        if CacheS = 'Include Script' then 
        begin
          i := 1;
          l := xInclude;
        end
        else
        if (CacheS = 'Create Shortcut') or 
          (CacheS = 'Advertised Shortcut') then 
        begin
          i := 9;
          l := Short;
          jX := 1;
          jY := 3;
          jZ := 6;
          jA := 7;
        end
        else
        if CacheS = 'Run Program' then 
        begin
          i := 5;
          l := RunProgram;
          jX := 1;
          jY := 3;
        end
        else
        if CacheS = 'Display Dialog' then 
        begin
          i := 6;
          l := DisplayDialog;
        end
        else
        if CacheS = 'Label' then 
        begin
          i := 1;
          l := eLabel;
        end
        else
        if CacheS = 'Remove Directory' then 
        begin
          i := 1;
          l := RmDir;
          jX := 1;
        end
        else
        if CacheS = 'Get Folder Location' then 
        begin
          i := 3;
          l := GetFolderLocation;
        end
        else
        if CacheS = 'Install Files' then 
        begin
          i := 12;
          l := InstallFiles;
          jX := 1;
          jY := 3;
        end
        else
        if CacheS = 'Apply Changes' then 
        begin
          i := 4;
          l := ApplyChanges;
        end
        else
        if CacheS = 'Define Component' then 
        begin
          i := 3;
          l := DefComponent;
        end
        else
        if CacheS = 'Set Component State' then 
        begin
          i := 2;
          l := SetComponent;
        end
        else
        if CacheS = 'Get Component State' then 
        begin
          i := 2;
          l := GetComponent;
        end
        else
        if CacheS = 'Delete Component' then 
        begin
          i := 1;
          l := DelComp;
        end
        else
        if CacheS = 'Create Folder' then 
        begin
          i := 1;
          l := CreateFolder;
          jX := 1;
        end
        else
        if CacheS = 'Set Component Space' then 
        begin
          i := 2;
          l := SpaceFeatures;
        end
        else
        if CacheS = 'GoTo Label' then 
        begin
          i := 1;
          l := gLabel;
        end
        else
        if CacheS = 'Download File' then 
        begin
          i := 6;
          l := DownloadFile;
          if Import then
            i := 0;
          jX := 2;
        end
        else
        if CacheS = 'File Bag' then 
        begin
          i := 4;
          l := FileBag;
          if Import then
            i := 0;
          jX := 1;
          jY := 3;
        end
        else
        if CacheS = 'Code Folding Region' then 
        begin
          i := 2;
          l := Region;
        end
        else
        if CacheS = 'Delete Files' then 
        begin
          i := 4;
          l := DeleteFiles;
          jX := 1;
        end
        else
        if CacheS = 'Delete Files Recursive' then 
        begin
          i := 1;
          l := DeleteRec;
          jX := 1;
        end
        else
        if CacheS = 'Read from Text File' then 
        begin
          i := 3;
          l := ReadText;
          jX := 1;
        end
        else
        if CacheS = 'Write to Text File' then 
        begin
          i := 4;
          l := WriteText;
          jX := 1;
        end
        else
        if CacheS = 'Create Link' then 
        begin
          i := 5;
          l := CreateLink;
        end
        else
        if CacheS = 'Web Media Block' then 
        begin
          i := 3;
          l := MediaBlock;
        end
        else
        if CacheS = 'Parse String' then 
        begin
          i := 7;
          l := Parse;
        end
        else
        if CacheS = 'Create File Type' then 
        begin
          i := 7;
          l := FileType;
        end
        else
        if CacheS = 'Set Group' then 
        begin
          i := 2;
          l := Grp;
          jX := 1; 
        end
        else
        if CacheS = 'Set Owner' then 
        begin
          i := 5;
          l := Own;
          jX := 1; 
        end
        else
        if CacheS = 'Set Access Control' then 
        begin
          i := 16;
          l := ACL;
          jX := 1;
        end
        else
        if CacheS = 'Get File Version' then 
        begin
          i := 2;
          l := GetVers;
          jX := 1;
        end
        else
        if CacheS = 'Check File Version' then 
        begin
          i := 5;
          l := CheckVersion;
          jX := 2;
          jY := 4;
        end
        else
        if CacheS = 'For Each' then 
        begin
          i := 3;
          l := xForEach;
        end
        else
        if CacheS = 'Get File Size' then
        begin
          l := xGetFileSize;
          i := 2;
          jX := 2;
        end
        else
        if CacheS = 'Sleep' then
        begin
          l := xSleep;
          i := 1;
        end
        else
        if CacheS = 'Mathematics' then 
        begin
          i := 4;
          l := Maths;
        end
        else
        if CacheS = 'Terminate with Exit Code' then 
        begin
          i := 1;
          l := TermExitCode;
        end
        else
        if CacheS = 'Convert Case' then 
        begin
          i := 2;
          l := ConvertCase;
        end
        else
        if CacheS = 'Evaluate Expression' then 
        begin
          i := 2;
          l := Eval;
        end
        else
        if CacheS = 'Extract Path' then 
        begin
          i := 2;
          l := ExtractPath;
        end
        else
        if CacheS = 'Format String' then
        begin
          l := FormatStr;
          i := 3;
        end
        else
        if CacheS = 'Get String Length' then
        begin
          l := GetStrLen;
          i := 2;
        end
        else
        if CacheS = 'Get String Position' then
        begin
          l := GetStrPos;
          i := 4;
        end
        else
        if CacheS = 'Localization Variable' then 
        begin
          i := 2;
          l := LocVar;
        end
        else
        if CacheS = 'Match Regular Expression' then
        begin
          l := RegEx;
          i := 3;
        end
        else
        if CacheS = 'Replace String' then 
        begin
          i := 5;
          l := ReplaceStr;
        end
        else
        if CacheS = 'Browse for Folder' then
        begin
          l := xBrowseFolder;
          i := 3;
          jX := 2;
        end
        else
        if CacheS = 'Browse for File' then
        begin
          l := xBrowseFile;
          i := 7;
          jX := 6;
        end
        else
        if CacheS = 'Load Feature Selections' then 
        begin
          i := 1;
          l := LoadFeatures;
          jX := 1;
        end
        else
        if CacheS = 'Prompt for Text' then
        begin
          l := xPromptForText;
          i := 3;
        end
        else
        if CacheS = 'Save Feature Selections' then 
        begin
          i := 1;
          l := SaveFeatures;
          jX := 1;
        end
        else
        if CacheS = 'Set Component Choice' then 
        begin
          i := 2;
          l := SetChoice;
        end
        else
        if CacheS = 'Get Component Space' then 
        begin
          i := 2;
          l := GetSpace;
        end
        else
        if CacheS = 'Set Component Visibility' then 
        begin
          i := 2;
          l := SetVisibility;
        end
        else
        if CacheS = 'Check Disk Space' then 
        begin
          i := 4;
          l := CheckSpace;
          jX := 2;
        end
        else
        if CacheS = 'Does File/Folder Exist' then 
        begin
          i := 3;
          l := DoesExist;
          jX := 2;
        end
        else
        if CacheS = 'Get Link Target' then 
        begin
          i := 2;
          l := GetLink;
        end
        else
        if CacheS = 'Find All Files' then 
        begin
          i := 4;
          l := FAF;
          jX := 1;
        end
        else
        if CacheS = 'Generate GUID' then 
        begin
          i := 1;
          l := xGUID;
        end
        else
        if CacheS = 'Get Environment' then 
        begin
          i := 2;
          l := GetEnv;
        end
        else
        if CacheS = 'Get INI File Settings' then 
        begin
          i := 4;
          l := GetINI;
          jX := 2;
        end
        else
        if CacheS = 'Get Temporary File' then 
        begin
          i := 1;
          l := GetTemp;
        end
        else
        if CacheS = 'Is Native Setup Installed' then 
        begin
          i := 2;
          l := IsNative;
        end
        else
        if CacheS = 'Read from Binary File' then
        begin
          l := xReadBinary;
          i := 4;
          jX := 1;
        end
        else
        if CacheS = 'Copy/Move Local Files' then 
        begin
          i := 6;
          l := LocalFiles;
          jX := 1;
          jY := 3;
        end
        else
        if CacheS = 'Edit INI File' then 
        begin
          i := 6;
          l := EditIni;
          jX := 1;
        end
        else
        if CacheS = 'Set 64 Bit Mode' then 
        begin
          i := 3;
          l := Plat;
        end
        else
        if CacheS = 'Rename File/Folder' then
        begin
          l := xRename;
          i := 2;
          jX := 1;
          jY := 2;
        end
        else
        if CacheS = 'Write to Binary File' then
        begin
          l := xWriteBinary;
          i := 4;
          jX := 1;
        end
        else
        if CacheS = 'Halt Compilation' then 
        begin
          i := 1;
          l := HaltCompile;
        end
        else
        if CacheS = 'Delete Registry' then 
        begin
          i := 4;
          l := DeleteReg;
        end
        else
        if CacheS = 'Find All Registry' then
        begin
          i := 5;
          l := FindAllReg;
        end
        else
        if CacheS = 'Get OS or SP Level' then 
        begin
          i := 3;
          l := ExactVer;
        end
        else
        if CacheS = 'Get System Settings' then 
        begin
          i := 2;
          l := GetSystemSettings;
        end
        else
        if CacheS = 'Get Native Settings' then 
        begin
          i := 2;
          l := GetNativeSettings;
        end
        else
        if (CacheS = 'Read Registry') or (CacheS = 'Check Registry') then 
        begin
          i := 4;
          l := ReadReg;
        end
        else
        if CacheS = 'Compress 7Zip Archive' then 
        begin
          i := 10;
          l := Compress7Zip;
          jX := 1;
          jY := 3;
          jZ := 4;
        end
        else
        if CacheS = 'Extract 7Zip Archive' then 
        begin
          i := 6;
          l := Extract7Zip;
          jX := 1;
          jY := 2;
        end
        else
        if CacheS = 'Write Registry' then 
        begin
          i := 7;
          l := WriteReg;
        end
        else
        if CacheS = 'Return from Include Script' then
        begin
          l := ReturnInclude;
          i := 1;
        end
        else
        if CacheS = 'Convert Path' then 
        begin
          i := 2;
          l := ConvertPath;
        end
        else
        if CacheS = 'Check Process' then 
        begin
          i := 2;
          l := CheckProcess;
        end
        else
        if CacheS = 'Run Script' then 
        begin
          i := 7;
          l := xRunScript;
        end
        else
        if CacheS = 'Run Program As' then 
        begin
          i := 10;
          l := RunProgramAs;
          jX := 1;
          jY := 2;
          jY := 3;
          jA := 10;
        end
        else
        if Import then
        begin
          
          Comments.Add(s);
          Comments.Add(CacheS + ' (plug-in) command unsupported in this version of InstallAware Multi Platform');
          ScriptTypes[ScriptReferences.IndexOf(s)] := 'Comment';
          l := nil;
          i := 0;
          
        end;
        
        if l <> nil then
        begin
          if s = '$DOLLAR$' then 
            l.Add('$')
          else
            l.Add(s);
          if Import and (i = 0) then
          begin
            
            lX := TStringList.Create;
            ReadLn(t, s);
            lX.CommaText := s;
            for j := 1 to lX.Count do
            begin
              sX := lX[j -1]; 
              if CacheS = 'File Bag' then
              begin
                if j = 1 then
                  WidenColonDelimParam(sX, sX, sY);
              end;
              
              if sX = '$DOLLAR$' then 
                l.Add('$')
              else
              begin
                if Import and (((j = jX) or (j = jY)) or ((j = jZ) or (j = jA))) then
                  sX := StringReplace(sX, '\', '/', [rfReplaceAll, rfIgnoreCase]);
                l.Add(sX);
              end;
              if CacheS = 'File Bag' then
              begin
                if j = 2 then
                  l.Add(sY); 
              end;
            end;
            lX.Free;
            i := 0;
          end;
          for j := 1 to i do
          begin
            ReadLn(t, s);
            if s = '$DOLLAR$' then 
              l.Add('$')
            else
            begin
              if Import and (((j = jX) or (j = jY)) or ((j = jZ) or (j = jA))) then
                s := StringReplace(s, '\', '/', [rfReplaceAll, rfIgnoreCase]);
              l.Add(s);
            end;
          end;
        end;
      end;
    except
      raise Exception.Create(SErrorLoadingLine + IntToStr(iX) + SWhileDereferencing + sX + '})');
    end;
    if Import then
    begin
      
      for i := 1 to ScriptTypes.Count do
        if Actions.Items.IndexOf(ScriptTypes[i -1]) = -1 then
        begin
          Comments.Add(ScriptReferences[i -1]);
          Comments.Add(ScriptTypes[i -1] + ' (plug-in) command unsupported in this version of InstallAware Multi Platform');
          ScriptTypes[i -1] := 'Comment';
        end;
    end;
    
    s := '';
    while not EOF(t) and (s <> '$') do
    begin
      ReadLn(t, s);
      if s <> '$' then ScriptComments.Add(s);
    end;
    s := '';
    while not EOF(t) and (s <> '$') do
    begin
      ReadLn(t, s);
      if s <> '$' then ScriptFetches.Add(s);
    end;
    CloseFile(t);
    ui.Script.Items.Clear;
    ScriptFolds.Clear;
    FoldList.Clear;
    Bookmarks.Clear;
    RenderScript;
  finally
    PopStatusStack;
    
  end;
end;

procedure Tui.RehashIndents;
var
  i, j: Integer;
  s: String;
begin
  if ScriptBuffer.Count < 10 then
    IndentDepth := 4
  else
  if ScriptBuffer.Count < 100 then
    IndentDepth := 5
  else
  if ScriptBuffer.Count < 1000 then
    IndentDepth := 6
  else
  if ScriptBuffer.Count < 10000 then
    IndentDepth := 7
  else
  if ScriptBuffer.Count < 100000 then
    IndentDepth := 8;
  i :=  FontWidth *IndentDepth;
  IndentHash.Clear;
  for j := 1 to ScriptBuffer.Count do
  begin
    s := AnsiLowerCase(ScriptBuffer[j -1]);
    if ((AnsiPos('end', s) = 1) or
      (AnsiPos('wend', s) = 1)) or
      ((AnsiPos('until', s) = 1) or
      (AnsiPos('next', s) = 1)) then 
      if i >  FontWidth *IndentDepth then
        i := i -  FontWidth *2;
    IndentHash.Add(IntToStr(i));
    if (((AnsiPos('if', s) = 1) or 
      (AnsiPos('wizard loop', s) = 1)) or
      ((AnsiPos('while', s) = 1) or
      ((AnsiPos('repeat', s) = 1)) or
      (AnsiPos('for each', s) = 1))) then 
      i := i +  FontWidth *2;
  end;
  if (((ScriptBuffer.Count = 9) or
    (ScriptBuffer.Count = 10)) or
    (((ScriptBuffer.Count = 99) or
    (ScriptBuffer.Count = 100)) or
    ((ScriptBuffer.Count = 999) or
    (ScriptBuffer.Count = 1000)))) or
    ((ScriptBuffer.Count = 9999) or
    (ScriptBuffer.Count = 10000))
    then
    Script.Repaint;
  SetHorizontalScrollBar(Script);
end;

function Tui.GetMemoFlat(Memo: TMemo): String;

begin
  
  Result := MultiLineToSingleLine(Memo.Text);
end;

procedure Tui.SetMemoFlat(Memo: TMemo; Flat: String);

begin
  
  Memo.Text := SingleLineToMultiLine(Flat);
end;

function Tui.GetFoldedLineNumber(RealLine: Integer): Integer;
var
  i: Integer;
  VisibleLines: Integer;
begin
  if not EnabledFolding then
  begin
    Result := RealLine;
    Exit;
  end;
  Result := -1;
  for i := 1 to RealLine +1 do
    if ScriptFolds[i -1] <> '' then
      Result := Result +1;
  if Result = -1 then
    raise Exception.Create(SUnableToGetFoldedLineNumberInCod);
end;

function Tui.GetNamedScriptNameAndFile(Given: String; var sName, sFile: String
  ): Boolean;
begin
  Result := True;
  if Given = '' then
  begin
    sName := ScriptFile;
    sFile := GetFullProjectScriptFilePath;
    Exit;
  end;
  sName := Given;
  if sName = ScriptFile then
    sFile := GetFullProjectScriptFilePath
  else
  begin
    if CurrentUnit.Tabs.IndexOf(Given) = -1 then
    begin
      Result := false;
      Exit;
    end;
    
        sFile := IncludeFiles[CurrentUnit.Tabs.IndexOf(Given) -2];
        sName := sFile;
       
  end;
end;

function Tui.IsContextLoaded(Context: String): Boolean;
begin
  Result := AllContextBuffers.IndexOf(Context) <> -1;
end;

function Tui.SaveNamedScript(sScriptFile, SaveFile, OldDir: String): Boolean;
var
  i, j: Integer;
  t, tX: TextFile;
  s, sX, sY, sZ: String;
  aGlobalLists, bGlobalLists: TList;
  aScriptTypes, aScriptReferences, aScriptComments, aScriptFetches,
  aScriptFolds, aFoldList, aBreakpoints, aBookmarks: THashedStringList;
begin
  
  aGlobalLists := MakeNewEmptyGlobalList;
  bGlobalLists := MakeNewEmptyInitializedGlobalList;
  
  AssignContext(sScriptFile, aGlobalLists, aScriptTypes, aScriptReferences,
    aScriptComments, aScriptFetches, aScriptFolds, aFoldList, aBreakpoints, aBookmarks);
  
  for i := 1 to aScriptTypes.Count do
    if CompareText('Ignore', aScriptTypes[i -1]) = 0 then 
    begin
      Application.MessageBox(PChar(SUnableToSaveProjectScriptHasBeen),
        PChar(Application.Title), mb_Ok + mb_IconExclamation);
      Result := false;
      Exit;
    end;
  
  if MyFileExists(SaveFile) then
    if not FileCopyFile(PChar(SaveFile), PChar(SaveFile + '.bak'), false) then 
    begin
      Application.MessageBox(PChar('Unable to write to project folder, please run the InstallAware IDE elevated with administrator rights.'),
        PChar(Application.Title), mb_Ok + mb_IconStop);
      Result := false;
      Exit;
    end;
  
  PushStatusStack('Saving script ' + SaveFile);
  Result := True;
  SetFileAttributes(PChar(SaveFile + '.fldx'), FILE_ATTRIBUTE_NORMAL); 
  aFoldList.SaveToFile(SaveFile + '.fldx', TEncoding.UTF8); 
  SetFileAttributes(PChar(SaveFile + '.bokx'), FILE_ATTRIBUTE_NORMAL); 
  aBookmarks.SaveToFile(SaveFile + '.bokx', TEncoding.UTF8);
  SetFileAttributes(PChar(SaveFile + '.brkx'), FILE_ATTRIBUTE_NORMAL); 
  aBreakpoints.SaveToFile(SaveFile + '.brkx', TEncoding.UTF8); 
  SetFileAttributes(PChar(SaveFile), FILE_ATTRIBUTE_NORMAL);
  AssignFile(t, SaveFile, CP_UTF8);
  ReWrite(t);
  if EnabledExport then
  begin
    FileCopyFile(PChar(SaveFile + '.txt'), PChar(SaveFile + '.txt.bak'), false); 
    SetFileAttributes(PChar(SaveFile + '.txt'), FILE_ATTRIBUTE_NORMAL);
    AssignFile(tX, SaveFile + '.txt',cp_utf8);
    ReWrite(tX);
    sX := '';
    for i := 1 to GlobalLists.Count do
    begin
      
      THashedStringList(bGlobalLists.Items[i -1]).Text :=
        THashedStringList(GlobalLists.Items[i -1]).Text;
      
      THashedStringList(GlobalLists.Items[i -1]).Text :=
        THashedStringList(aGlobalLists.Items[i -1]).Text;
    end;
  end;
  try
    
    for i := 1 to aScriptTypes.Count do
    begin
      sY := aScriptTypes[i -1];
      WriteLn(t, sY);
      if EnabledExport then
      begin
        sZ := aScriptComments[i -1];
        if sZ <> 'C' then
          if (((sY = 'Else') or (sY = 'Wend')) or ((sY = 'End') or (sY = 'Else If'))) or ((sY = 'Until') or (sY = 'Next')) then
          begin
            if Length(sX) >= 2 then
              Delete(sX, 1, 2);
          end;
        if sZ = 'C' then
          WriteLn(tX, sX + 'Comment: ' + RenderFunction(sY, aScriptReferences[i -1]))
        else
          WriteLn(tX, sX + RenderFunction(sY, aScriptReferences[i -1]));
        if sZ <> 'C' then
          if (((sY = 'If') or (sY = 'While')) or ((sY = 'Else') or (sY = 'Else If'))) or ((sY = 'Repeat') or (sY = 'For Each')) then
            sX := sX + '  ';
      end;
    end;
    WriteLn(t, '$');
  finally
    if EnabledExport then
    begin
      for i := 1 to GlobalLists.Count do
      begin
        
        THashedStringList(GlobalLists.Items[i -1]).Text :=
          THashedStringList(bGlobalLists.Items[i -1]).Text;
        
        THashedStringList(bGlobalLists.Items[i -1]).Free;
      end;
    end;
  end;
  if EnabledExport then
  begin
    CloseFile(tX);
    bGlobalLists.Free;
  end;
  
  for i := 1 to aScriptReferences.Count do
    WriteLn(t, aScriptReferences[i -1]);
  WriteLn(t, '$');
  
  for i := 1 to aGlobalLists.Count do
    for j := 1 to TStringList(aGlobalLists[i -1]).Count do
      if TStringList(aGlobalLists[i -1])[j -1] = '$' then
        WriteLn(t, '$DOLLAR$') 
      else
        WriteLn(t, TStringList(aGlobalLists[i -1])[j -1]);
  WriteLn(t, '$');
  
  for i := 1 to aScriptComments.Count do
    WriteLn(t, aScriptComments[i -1]);
  WriteLn(t, '$');
  
  for i := 1 to aScriptFetches.Count do
    WriteLn(t, aScriptFetches[i -1]);
  WriteLn(t, '$');
  CloseFile(t);
  aGlobalLists.Free;
  
  SetDirtyMia(false, sScriptFile);
  PopStatusStack;
end;

function Tui.MakeNewEmptyGlobalList: TList;
var
  i: Integer;
begin
  Result := TList.Create;
  for i := 1 to GlobalLists.Count do
    Result.Add(nil);
end;

function Tui.MakeNewEmptyInitializedGlobalList: TList;
var
  i: Integer;
begin
  Result := TList.Create;
  for i := 1 to GlobalLists.Count do
    Result.Add(THashedStringList.Create);
end;

procedure Tui.AssignContext(NewContext: String; var aGlobalLists: TList;
  var aScriptTypes, aScriptReferences, aScriptComments, aScriptFetches,
  aScriptFolds, aFoldList, aBreakpoints, aBookmarks: THashedStringList;
  DuplicateContext: Boolean);
var
  i: Integer;
  SavedStrings: THashedStringList;
  LoadFromContext: TList;
  l, lX: THashedStringList;
begin
  if DuplicateContext then
  begin
    
    for i := 1 to aGlobalLists.Count do
      aGlobalLists[i -1] := THashedStringList.Create;
    aScriptTypes := THashedStringList.Create;
    aScriptReferences := THashedStringList.Create;
    aScriptComments := THashedStringList.Create;
    aScriptFetches := THashedStringList.Create;
    aScriptFolds := THashedStringList.Create;
    aFoldList := THashedStringList.Create;
    aBookmarks := THashedStringList.Create;
    aBreakpoints := THashedStringList.Create;
    if LastActiveContext = NewContext then
    
    begin
      for i := 1 to GlobalLists.Count do
        THashedStringList(aGlobalLists[i -1]).Text := THashedStringList(GlobalLists[i -1]).Text;
      aScriptTypes.Text := ScriptTypes.Text;
      aScriptReferences.Text := ScriptReferences.Text;
      aScriptComments.Text := ScriptComments.Text;
      aScriptFetches.Text := ScriptFetches.Text;
      aScriptFolds.Text := ScriptFolds.Text;
      aFoldList.Text := FoldList.Text;
      aBookmarks.Text := Bookmarks.Text;
      aBreakpoints.Text := Breakpoints.Text;
    end
    else
    
    begin
      if AllContextBuffers.IndexOf(NewContext) = -1 then
        raise Exception.Create(SUnableToFindSavedScriptContextFo + NewContext);
      LoadFromContext := TList(AllContextBuffers.Objects[AllContextBuffers.IndexOf(NewContext)]);
      
      for i := 1 to aGlobalLists.Count +8 do
      begin
        if i <= aGlobalLists.Count then
          THashedStringList(aGlobalLists.Items[i -1]).Text :=
            THashedStringList(LoadFromContext.Items[i -1]).Text
        else
        begin
          lX := THashedStringList(LoadFromContext.Items[i -1]);
          if i = GlobalLists.Count +1 then
            aScriptTypes.Text := lX.Text;
          if i = GlobalLists.Count +2 then
            aScriptReferences.Text := lX.Text;
          if i = GlobalLists.Count +3 then
            aScriptComments.Text := lX.Text;
          if i = GlobalLists.Count +4 then
            aScriptFetches.Text := lX.Text;
          if i = GlobalLists.Count +5 then
            aScriptFolds.Text := lX.Text;
          if i = GlobalLists.Count +6 then
            aFoldList.Text := lX.Text;
          if i = GlobalLists.Count +7 then
            aBreakpoints.Text := lX.Text;
          if i = GlobalLists.Count +8 then
            aBookmarks.Text := lX.Text;
        end;
      end;
    end;
    Exit;
  end;
  if LastActiveContext = NewContext then
  
  begin
    for i := 1 to GlobalLists.Count do
      aGlobalLists[i -1] := GlobalLists[i -1];
    aScriptTypes := ScriptTypes;
    aScriptReferences := ScriptReferences;
    aScriptComments := ScriptComments;
    aScriptFetches := ScriptFetches;
    aScriptFolds := ScriptFolds;
    aFoldList := FoldList;
    aBreakpoints := Breakpoints;
    aBookmarks := Bookmarks;
  end
  else
  
  begin
    if AllContextBuffers.IndexOf(NewContext) = -1 then
      raise Exception.Create(SUnableToFindSavedScriptContextFo + NewContext);
    LoadFromContext := TList(AllContextBuffers.Objects[AllContextBuffers.IndexOf(NewContext)]);
    
    for i := 1 to aGlobalLists.Count +8 do
    begin
      if i <= aGlobalLists.Count then
        aGlobalLists.Items[i -1] :=
          THashedStringList(LoadFromContext.Items[i -1])
      else
      begin
        lX := THashedStringList(LoadFromContext.Items[i -1]);
        if i = GlobalLists.Count +1 then
          aScriptTypes := lX;
        if i = GlobalLists.Count +2 then
          aScriptReferences := lX;
        if i = GlobalLists.Count +3 then
          aScriptComments := lX;
        if i = GlobalLists.Count +4 then
          aScriptFetches := lX;
        if i = GlobalLists.Count +5 then
          aScriptFolds := lX;
        if i = GlobalLists.Count +6 then
          aFoldList := lX;
        if i = GlobalLists.Count +7 then
          aBreakpoints := lX;
        if i = GlobalLists.Count +8 then
          aBookmarks := lX;
      end;
    end;
  end;
end;

function Tui.GetCompilerVariableBool(Variable: String): Boolean;
var
  s: String;
begin
  Result := false;
  s := GetCompilerVariable(Variable);
  try
    Result := StrToBool(s);
  except
    Result := false;
  end;
end;

function Tui.GetCompilerVariable(Variable: String): String;
var
  s: String;
  i: Integer;
  sl: TStringList;
begin
  Result := '';
  sl := TStringList.Create;
  sl.CommaText := ProjectStruct.Conditionals;
  for i := 1 to sl.Count do
  begin
    s := Copy(sl[i -1], 1, AnsiPos('=', sl[i -1]) -1);
    if AnsiCompareText(s, Variable) = 0 then
    begin
      Result := Copy(sl[i -1], AnsiPos('=', sl[i -1]) +1, Length(sl[i -1]));
      Break;
    end;
  end;
  sl.Free;
end;

function Tui.GetCompilerVariableBoolDefault(Variable: String): Boolean;
var
  s: String;
begin
  Result := false;
  s := GetCompilerVariable(Variable);
  try
    Result := AnsiCompareText(s, 'DEFAULT') = 0;
  except
    Result := false;
  end;
end;

function Tui.SubstituteCompilerVariables(Literal: String; AddQuote: Boolean
  ): String;
var
  i: Integer;
  l, lX: TStringList;
begin
  Result := Literal;
  l := GetCompilerVariableNames;
  lX := GetCompilerVariableValues;
  l.Add('PROJDIR');
  lX.Add(PROJDIR);
  l.Add('IADIR');
  lX.Add(AssertDir(ExtractFilePath(ParamStr(0))));
  for i := 1 to l.Count do
    if AddQuote then
      Result := StringReplace(Result, '#' + l[i -1] + '#',
        '"' + lX[i -1] + '"', [rfReplaceAll, rfIgnoreCase])
    else
      Result := StringReplace(Result, '#' + l[i -1] + '#',
        lX[i -1], [rfReplaceAll, rfIgnoreCase]);
  if AnsiPos('#', Result) <> 0 then
    if Literal <> Result then
      Result := SubstituteCompilerVariables(Result, AddQuote);
  l.Free;
  lX.Free;
end;

function Tui.GetCompilerVariableNames: TStringList;
var
  i: Integer;
  sl: TStringList;
begin
  Result := TStringList.Create;
  sl := TStringList.Create;
  sl.CommaText := ProjectStruct.Conditionals;
  for i := 1 to sl.Count do
    Result.Add(Copy(sl[i -1], 1, AnsiPos('=', sl[i -1]) -1));
  sl.Free;
end;

function Tui.GetCompilerVariableValues: TStringList;
var
  s: String;
  i: Integer;
  sl: TStringList;
begin
  Result := TStringList.Create;
  sl := TStringList.Create;
  sl.CommaText := ProjectStruct.Conditionals;
  for i := 1 to sl.Count do
    Result.Add(Copy(sl[i -1], AnsiPos('=', sl[i -1]) +1, Length(sl[i -1])));
  sl.Free;
end;

function Tui.ReplaceTextInCommandAtLine(OldText, NewText: String; Line: Integer;
  MatchCase: Boolean): Boolean;
var
  CommandKind, CommandReference: String;
  CommandList, l: TStringList;
  CommandCount: Integer;
  i, j, k: Integer;
  s, sX: String;
begin
  Result := false;
  if not IsTextInCommandAtLine(OldText, Line, false, MatchCase) then Exit;
  CommandKind := ScriptTypes[Line];
  CommandReference := ScriptReferences[Line];
  GetFunctionOffsets(CommandKind, CommandList, CommandCount);
  sX := GetFunctionDataForStack(CommandKind, CommandReference);
  for i := 1 to CommandCount do
  begin
    s := CommandList[CommandList.IndexOf(CommandReference) + i];
    if not MatchCase then
      j := AnsiPos(AnsiLowerCase(OldText), AnsiLowerCase(s))
    else
      j := AnsiPos(OldText, s);
    if j <> 0 then
    begin
      Result := True;
      if MatchCase then
        CommandList[CommandList.IndexOf(CommandReference) + i] :=
          StringReplace(s, OldText, NewText, [rfReplaceAll])
      else
        CommandList[CommandList.IndexOf(CommandReference) + i] :=
          StringReplace(s, OldText, NewText, [rfReplaceAll, rfIgnoreCase]);
    end;
  end;
  if Result then
  begin
    l := TStringList.Create;
    l.Add(IntToStr(Line));
    l.Add(ScriptTypes[Line]);
    l.Add(ScriptReferences[Line]);
    l.Add(sX);
    AddStackItem(UndoStack, 'Edit', l.CommaText);
    l.Free;
    ClearStack(RedoStack);
    RenderLine(Line, True);
    SetHorizontalScrollBar(Script);
    
    SetDirtyMIA(True, '');
  end;
end;

procedure Tui.AddToMRUF(FileName: String);
begin
  if MyFileExists(EXEDIR + 'mruf.txt') then 
    MRUF.LoadFromFile(EXEDIR + 'mruf.txt', TEncoding.UTF8) 
  else
    MRUF.Clear;
  
  if MRUF.IndexOf({$IFDEF WINDOWS}AnsiLowerCase({$ENDIF}FileName{$IFDEF WINDOWS}){$ENDIF}) = -1 then
    MRUF.Insert(0, {$IFDEF WINDOWS}AnsiLowerCase({$ENDIF}FileName{$IFDEF WINDOWS}){$ENDIF})
  else
    MRUF.Move(MRUF.IndexOf({$IFDEF WINDOWS}AnsiLowerCase({$ENDIF}FileName{$IFDEF WINDOWS}){$ENDIF}), 0);
  while MRUF.Count > 26 do
    MRUF.Delete(MRUF.Count -1);
  MRUF.SaveToFile(EXEDIR + 'mruf.txt', TEncoding.UTF8); 
  RepaintMRUF;
end;

procedure Tui.RepaintMRUF;
var
  s: String;
  i: Integer;
  mi: TMenuItem;
  t, tX: TextFile;
  
  BOM: Char;
begin
  if MyFileExists(EXEDIR + 'mruf.txt') then 
    MRUF.LoadFromFile(EXEDIR + 'mruf.txt', TEncoding.UTF8) 
  else
    MRUF.Clear;
  
  Reopen.Clear;
  Existing.Items.Clear;
  for i := 1 to MRUF.Count do
  begin
    if i <= 10 then
    begin
      mi := TMenuItem.Create(Reopen);
      mi.Caption := MRUF[i -1];
      mi.OnClick := @ReopenClick;
      mi.ImageIndex := 43;
      Reopen.Add(mi);
    end;
    Existing.Items.Add(MRUF[i -1]);
  end;
  if MRUF.Count = 0 then
  begin
    mi := TMenuItem.Create(Reopen);
    mi.Caption := SEmpty;
    mi.Enabled := false;
    mi.ImageIndex := -1;
    Reopen.Add(mi);
  end;
  Existing.Items.Add(sOpenUnlisted);
   
end;

procedure Tui.OpenMRUF(FileName: String);
begin
  if not MyFileExists(FileName) then
    if Application.MessageBox(PChar(SThisProjectCanNoLongerBeLocatedD),
      PChar(Application.Title), mb_YesNo + mb_IconQuestion) = id_Yes then
    begin
      if MRUF.IndexOf({$IFDEF WINDOWS}AnsiLowerCase({$ENDIF}FileName{$IFDEF WINDOWS}){$ENDIF}) <> -1 then
      begin
        MRUF.Delete(MRUF.IndexOf({$IFDEF WINDOWS}AnsiLowerCase({$ENDIF}FileName{$IFDEF WINDOWS}){$ENDIF}));
        MRUF.SaveToFile(EXEDIR + 'mruf.txt', TEncoding.UTF8); 
        RepaintMRUF;
      end;
    end;
  if MyFileExists(FileName) then
  begin
    LoadProject(FileName);
    RepaintMRUF;
  end;
end;

procedure Tui.AdaptToolbar(aVisual: Boolean);
begin
  if aVisual then
  begin
    ToolButton1.Enabled := false;
    ToolButton5.Enabled := false;
    ToolButton6.Enabled := false;
    ToolButton7.Enabled := false;
    ToolButton17.Enabled := false;
  end
  else
  begin
    ToolButton1.Enabled := True;
    ToolButton5.Enabled := True;
    ToolButton6.Enabled := True;
    ToolButton7.Enabled := True;
    ToolButton17.Enabled := True;
  end;
end;

procedure Tui.MenuItem14Click(Sender: TObject);
begin
  About.ShowModal;
end;

procedure Tui.MenuItem1Click(Sender: TObject);
begin

end;

procedure Tui.MenuItem23Click(Sender: TObject);
var
  b: Boolean;
  s: String;
  i, j, k, m: Integer;
  prevTFSState, nextTFSState: Integer;
  l: TStringList;
begin
  if not SafeRunState then Exit;
  m := Script.Font.Size;
  Script.Font.Size := BaseFontSize;
  IDEOptions.Sample.Font := Script.Font;
  IDEOptions.Script.Color := Script.Color;
  CopyFont(fontComment, pxfontComment);
  CopyFont(fontStatement, pxfontStatement);
  CopyFont(fontLabel, pxfontLabel);
  CopyFont(fontFlowControl, pxfontFlowControl);
  CopyFont(fontDirective, pxfontDirective);
  CopyFont(fontPlugIn, pxfontPlugIn);
  CopyFont(fontWindowsInstaller, pxfontWindowsInstaller);
  CopyFont(fontModifySystem, pxfontModifySystem);
  CopyFont(fontLine, pxfontLine);
  b := EnabledFolding;
  IDEOptions.CodeCompletion.Checked := EnabledCodeCompletion;
  IDEOptions.EmitElse.Checked := EnabledCodeCompletionElse;
  
  IDEOptions.CodeFolding.Checked := EnabledFolding;
  IDEOptions.Export.Checked := EnabledExport;
  
  if IDEOptions.ShowModal = mrOk then
  begin
    Script.Font := IDEOptions.Sample.Font;
    BaseFontSize := Script.Font.Size;
    CopyFont(pxfontComment, fontComment);
    CopyFont(pxfontStatement, fontStatement);
    CopyFont(pxfontLabel, fontLabel);
    CopyFont(pxfontFlowControl, fontFlowControl);
    CopyFont(pxfontDirective, fontDirective);
    CopyFont(pxfontPlugIn, fontPlugIn);
    CopyFont(pxfontWindowsInstaller, fontWindowsInstaller);
    CopyFont(pxfontModifySystem, fontModifySystem);
    CopyFont(pxfontLine, fontLine);
    EnabledCodeCompletion := IDEOptions.CodeCompletion.Checked;
    EnabledCodeCompletionElse := IDEOptions.EmitElse.Checked;
    
    EnabledFolding := IDEOptions.CodeFolding.Checked;
    EnabledExport := IDEOptions.Export.Checked;
    
    if b <> EnabledFolding then
    begin
      if EnabledFolding then 
      begin
        ScriptFolds.Clear;
        for i := 1 to ScriptBuffer.Count do
          ScriptFolds.Add('V');
        ApplySavedCodeFolding;
      end
      else
      begin 
        Script.Items.BeginUpdate;
        Script.Items.Clear;
        for i := 1 to ScriptBuffer.Count do
          Script.Items.Add(ScriptBuffer[i -1]);
        Script.Items.EndUpdate;
      end;
    end;
    RedrawScript;
    SaveUISettings(wsNormal, True);
    
  end
  else
  begin
    Script.Font.Size := m;
  end;
end;

procedure Tui.MenuItem25Click(Sender: TObject);
begin
  
  DockMaster.MakeDockable(Project, True, True);
end;

procedure Tui.MenuItem26Click(Sender: TObject);
begin
  OpenURL(BuyURL);
end;

procedure Tui.Cut1Click(Sender: TObject);
begin
  if not SafeRunState then Exit;
  if not InDesigner then Exit;
  Copy1Click(Self);
  Delete1Click(Self);
end;

procedure Tui.Find1Click(Sender: TObject);
begin
  if not SafeRunState then Exit;
  FindDialog.Execute;
end;

procedure Tui.Comment1Click(Sender: TObject);
var
  i, j: Integer;
  l: TStringList;
begin
  if not SafeRunState then Exit;
  PushStatusStack('(De)Commenting selection');
  for i := 1 to Script.Items.Count do
    if Script.Selected[i -1] then
    begin
      
      SetDirtyMia(True, '');
      l := GetAllRealLines(i -1);
      for j := 1 to l.Count do
        if not IsLineCodeFolding(StrToInt(l[j -1])) then
        begin
          if ScriptComments[StrToInt(l[j -1])] = 'C' then
            ScriptComments[StrToInt(l[j -1])] := ''
          else
            ScriptComments[StrToInt(l[j -1])] := 'C';
          RenderLine(StrToInt(l[j -1]), false);
        end;
      l.Free;
      Script.Selected[i -1] := True;
    end;
  PopStatusStack;
end;

procedure Tui.MenuItem5Click(Sender: TObject);
begin
  try
    PushStatusStack('Opening project');
    if not SafeRunState then Exit;
    if not IsSafeToCloseProject then Exit;
    if not OpenProject.Execute then Exit;
    LoadProject(OpenProject.FileName);
  finally
    PopStatusStack;
  end;
end;

procedure Tui.SaveProject1Click(Sender: TObject);
begin
  if not SafeRunState then Exit;
  SaveExistingProject(PROJDIR);
end;

procedure Tui.SaveProjectAs1Click(Sender: TObject);
begin
  if not SafeRunState then Exit;
  SaveExistingProjectAs;
end;

procedure Tui.FormCreate(Sender: TObject);
var
  i: Integer;
  l: TStringList;
  sX: String;
  b: Boolean;
begin
  frmToolForm := nil;
  frmObjectInspector := nil;
  ShellTree.UseBuiltinIcons := True;
  ShellList.UseBuiltInIcons := True;
  {$IFDEF LINUX}
  Script.CommandCombo := LinuxShuntCombo;
  Script.Reassign;
  {$ENDIF}
  
  Script.ControlStyle := Script.ControlStyle + [csDisplayDragImage];
  
  fontComment := TFont.Create;
  fontStatement := TFont.Create;
  fontLabel := TFont.Create;
  fontFlowControl := TFont.Create;
  fontDirective := TFont.Create;
  fontPlugIn := TFont.Create;
  fontWindowsInstaller := TFont.Create;
  fontModifySystem := TFont.Create;
  fontLine := TFont.Create;
  
  RenderCache := THashedStringList.Create;
  IndentHash := THashedStringList.Create;
  ScriptComments := THashedStringList.Create;
  ScriptTypes := THashedStringList.Create;
  ScriptBuffer := THashedStringList.Create;
  ScriptFolds := THashedStringList.Create;
  ScriptReferences := THashedStringList.Create;
  ScriptFetches := THashedStringList.Create;
  ProhibitedScriptFetches := THashedStringList.Create;
  DownloadFile := THashedStringList.Create;
  Region := THashedStringList.Create;
  ReadText := THashedStringList.Create;
  WriteText := THashedStringList.Create;
  RmDir := THashedStringList.Create;
  CreateLink := THashedStringList.Create;
  FileType := THashedStringList.Create;
  CheckVersion := THashedStringList.Create;
  xForEach := THashedStringList.Create;
  xSleep := THashedStringList.Create;
  TermExitCode := THashedStringList.Create;
  ConvertCase := THashedStringList.Create;
  ConvertPath := THashedStringList.Create;
  Eval := THashedStringList.Create;
  FormatStr := THashedStringList.Create;
  GetStrLen := THashedStringList.Create;
  GetStrPos := THashedStringList.Create;
  LocVar := THashedStringList.Create;
  RegEx := THashedStringList.Create;
  ReplaceStr := THashedStringList.Create;
  xBrowseFile := THashedStringList.Create;
  xBrowseFolder := THashedStringList.Create;
  LoadFeatures := THashedStringList.Create;
  xPromptForText := THashedStringList.Create;
  SetVisibility := THashedStringList.Create;
  GetSpace := THashedStringList.Create;
  SetChoice := THashedStringList.Create;
  SaveFeatures := THashedStringList.Create;
  CheckSpace := THashedStringList.Create;
  DoesExist := THashedStringList.Create;
  GetLink := THashedStringList.Create;
  FAF := THashedStringList.Create;
  xGUID := THashedStringList.Create;
  GetEnv := THashedStringList.Create;
  GetINI := THashedStringList.Create;
  GetTemp := THashedStringList.Create;
  IsNative := THashedStringList.Create;
  xReadBinary := THashedStringList.Create;
  LocalFiles := THashedStringList.Create;
  EditINI := THashedStringList.Create;
  Plat := THashedStringList.Create;
  xRename := THashedStringList.Create;
  xWriteBinary := THashedStringList.Create;
  HaltCompile := THashedStringList.Create;
  FileBag := THashedStringList.Create;
  ExtractPath := THashedStringList.Create;
  xWhile := THashedStringList.Create;
  xUntil := THashedStringList.Create;
  DeleteReg := THashedStringList.Create;
  FindAllReg := THashedStringList.Create;
  ExactVer := THashedStringList.Create;
  GetSystemSettings := THashedStringList.Create;
  GetNativeSettings := THashedStringList.Create;
  ReadReg := THashedStringList.Create;
  WriteReg := THashedStringList.Create;
  xGetFileSize := THashedStringList.Create;
  Compress7Zip := THashedStringList.Create;
  Extract7Zip := THashedStringList.Create;
  ReturnInclude := THashedStringList.Create;
  RunProgramAs := THashedStringList.Create;
  xRunScript := THashedStringList.Create;
  CheckProcess := THashedStringList.Create;
  
  DeleteFiles := THashedStringList.Create;
  DeleteRec := THashedStringList.Create;
  MediaBlock := THashedStringList.Create;
  CreateFolder := THashedStringList.Create;
  GetFolderLocation := THashedStringList.Create;
  InstallFiles := THashedStringList.Create;
  eLabel := THashedStringList.Create;
  gLabel := THashedStringList.Create;
  Maths := THashedStringList.Create;
  Parse := THashedStringList.Create;
  ApplyChanges := THashedStringList.Create;
  DisplayDialog := THashedStringList.Create;
  Comments := THashedStringList.Create;
  xMessageBox := THashedStringList.Create;
  SetVariable := THashedStringList.Create;
  xIf := THashedStringList.Create;
  xInclude := THashedStringList.Create;
  Region := THashedStringList.Create;
  DefComponent := THashedStringList.Create;
  SetComponent := THashedStringList.Create;
  GetComponent := THashedStringList.Create;
  SpaceFeatures := THashedStringList.Create;
  DelComp := THashedStringList.Create;
  RunProgram := THashedStringList.Create;
  Short := THashedStringList.Create;
  ACL := THashedStringList.Create;
  Own := THashedStringList.Create;
  Grp := THashedStringList.Create;
  GetVers := THashedStringList.Create;
  GlobalLists := TList.Create;
  GlobalLists.Add(CheckVersion);
  GlobalLists.Add(GetVers);
  GlobalLists.Add(ReadText);
  GlobalLists.Add(WriteText);
  GlobalLists.Add(DeleteFiles);
  GlobalLists.Add(DeleteRec);
  GlobalLists.Add(RunProgram);
  GlobalLists.Add(Short);
  GlobalLists.Add(CreateFolder);
  GlobalLists.Add(DelComp);
  GlobalLists.Add(SpaceFeatures);
  GlobalLists.Add(GetComponent);
  GlobalLists.Add(SetComponent);
  GlobalLists.Add(DefComponent);
  GlobalLists.Add(ApplyChanges);
  GlobalLists.Add(Comments);
  GlobalLists.Add(xMessageBox);
  GlobalLists.Add(SetVariable);
  GlobalLists.Add(xIf);
  GlobalLists.Add(xInclude);
  GlobalLists.Add(Region);
  GlobalLists.Add(DisplayDialog);
  GlobalLists.Add(eLabel);
  GlobalLists.Add(gLabel);
  GlobalLists.Add(Maths);
  GlobalLists.Add(Parse);
  GlobalLists.Add(GetFolderLocation);
  GlobalLists.Add(InstallFiles);
  GlobalLists.Add(MediaBlock);
  GlobalLists.Add(DownloadFile);
  GlobalLists.Add(RmDir);
  GlobalLists.Add(ACL);
  GlobalLists.Add(Own);
  GlobalLists.Add(Grp);
  GlobalLists.Add(CreateLink);
  GlobalLists.Add(FileType);
  GlobalLists.Add(xForEach);
  GlobalLists.Add(xSleep);
  GlobalLists.Add(TermExitCode);
  GlobalLists.Add(ConvertCase);
  GlobalLists.Add(ConvertPath);
  GlobalLists.Add(Eval);
  GlobalLists.Add(FormatStr);
  GlobalLists.Add(GetStrLen);
  GlobalLists.Add(GetStrPos);
  GlobalLists.Add(LocVar);
  GlobalLists.Add(RegEx);
  GlobalLists.Add(ReplaceStr);
  GlobalLists.Add(xBrowseFile);
  GlobalLists.Add(xBrowseFolder);
  GlobalLists.Add(LoadFeatures);
  GlobalLists.Add(xPromptForText);
  GlobalLists.Add(GetSpace);
  GlobalLists.Add(SetChoice);
  GlobalLists.Add(SetVisibility);
  GlobalLists.Add(SaveFeatures);
  GlobalLists.Add(CheckSpace);
  GlobalLists.Add(DoesExist);
  GlobalLists.Add(GetLink);
  GlobalLists.Add(FAF);
  GlobalLists.Add(xGUID);
  GlobalLists.Add(GetEnv);
  GlobalLists.Add(GetINI);
  GlobalLists.Add(GetTemp);
  GlobalLists.Add(IsNative);
  GlobalLists.Add(xReadBinary);
  GlobalLists.Add(LocalFiles);
  GlobalLists.Add(EditINI);
  GlobalLists.Add(Plat);
  GlobalLists.Add(xRename);
  GlobalLists.Add(xWriteBinary);
  GlobalLists.Add(HaltCompile);
  GlobalLists.Add(FileBag);
  GlobalLists.Add(ExtractPath);
  GlobalLists.Add(xWhile);
  GlobalLists.Add(xUntil);
  GlobalLists.Add(DeleteReg);
  GlobalLists.Add(FindAllReg);
  GlobalLists.Add(ExactVer);
  GlobalLists.Add(GetSystemSettings);
  GlobalLists.Add(GetNativeSettings);
  GlobalLists.Add(ReadReg);
  GlobalLists.Add(WriteReg);
  GlobalLists.Add(xGetFileSize);
  GlobalLists.Add(Compress7Zip);
  GlobalLists.Add(Extract7Zip);
  GlobalLists.Add(ReturnInclude);
  GlobalLists.Add(RunProgramAs);
  GlobalLists.Add(xRunScript);
  GlobalLists.Add(CheckProcess);
  
  MRUF := TStringList.Create;
  
  DialogFiles := THashedStringList.Create;
  DialogFiles.Duplicates := dupIgnore;
  DialogFiles.CaseSensitive := false;
  DialogFiles.Sorted := True;
  SupportFiles := THashedStringList.Create;
  SupportFiles.Duplicates := dupIgnore;
  SupportFiles.CaseSensitive := false;
  SupportFiles.Sorted := True;
  IncludeFiles := THashedStringList.Create;
  CurrentProjectName := '';
  PROJDIR := EXEDIR;
  SetDirtyAll(false);
  
  Running := false;
  Breakpoints := THashedStringList.Create;
  VarWatches := TStringList.Create;
  OpaqueClipboard := TStringList.Create;
  
  Application.HelpFile := EXEDIR + 'miae.chm'; 
  
  DockMaster.MakeDockSite(Self, [akLeft, akBottom, akRight], admrpChild);
end;

procedure Tui.FormDestroy(Sender: TObject);
var
  i: Integer;
begin
  FreeSavedContexts;
  fontComment.Free;
  fontStatement.Free;
  fontLabel.Free;
  fontFlowControl.Free;
  fontDirective.Free;
  fontPlugIn.Free;
  fontWindowsInstaller.Free;
  fontModifySystem.Free;
  fontLine.Free;
  RenderCache.Free;
  IndentHash.Free;
  ScriptComments.Free;
  ScriptTypes.Free;
  ScriptBuffer.Free;
  ScriptFolds.Free;
  ScriptReferences.Free;
  ScriptFetches.Free;
  ProhibitedScriptFetches.Free;
  for i := 1 to GlobalLists.Count do
    TStringList(GlobalLists[i -1]).Free;
  GlobalLists.Free;
  OpaqueClipboard.Free;
  Breakpoints.Free;
  
  DialogFiles.Free;
  SupportFiles.Free;
  IncludeFiles.Free;
  VarWatches.Free;
  MRUF.Free;
  ClearStack(UndoStack);
  ClearStack(RedoStack);
end;

procedure Tui.FormShow(Sender: TObject);
var
  l: TStringList;
  b, bX, bY, bZ, bXX: Boolean;
  i, j, k: Integer;
  f: TextFile;
  s: String;
  ss: TShiftState;
  w: Word;
begin
  Image2.Visible := not IsDarkModeAppearance;
  Image3.Visible := IsDarkModeAppearance;
  if IsDarkModeAppearance then
  begin
    Label1.Font.Color := clWhite;
    Label2.Font.Color := clWhite;
    Label3.Font.Color := clWhite;
    Label4.Font.Color := clWhite;
    Label5.Font.Color := clWhite;
    Label6.Font.Color := clWhite;
    Label1.Color := clBlack;
    Label2.Color := clBlack;
    Label3.Color := clBlack;
    Label4.Color := clBlack;
    Label5.Color := clBlack;
    Label6.Color := clBlack;
  end
  else
  begin
    Label1.Font.Color := clDefault;
    Label2.Font.Color := clDefault;
    Label3.Font.Color := clDefault;
    Label4.Font.Color := clDefault;
    Label5.Font.Color := clDefault;
    Label6.Font.Color := clDefault;
    Label1.Color := clWhite;
    Label2.Color := clWhite;
    Label3.Color := clWhite;
    Label4.Color := clWhite;
    Label5.Color := clWhite;
    Label6.Color := clWhite;
  end;
  {$IFDEF DARWIN}
  
  for i := 1 to MainMenu.Items.Count do
    for j := 1 to MainMenu.Items[i -1].Count do
    begin
      ShortcutToKey(MainMenu.Items[i -1].Items[j -1].ShortCut, w, ss);
      if ssCtrl in ss then
      begin
        ss := ss - [ssCtrl];
        ss := ss + [ssMeta];
        MainMenu.Items[i -1].Items[j -1].ShortCut := KeyToShortcut(w, ss);
      end;
    end;
  {$ENDIF}
  l := TStringList.Create;
  l.CommaText := Actions.Items.CommaText;
  l.Delete(l.IndexOf(CommandSeperator));
  Script.CommandCacheCommaText := l.CommaText;
  l.Free;
  bZ := false;
  bZ := True;
  
  TreeEx.Selected := TreeEx.Items[0];
  
  b := false;
  
  if TabSet.TabIndex = 0 then
    RemoveShortcuts
  else
    InsertShortcuts;
  MoveUp2.ShortCut := ShortCut(38, [{$IFDEF DARWIN}ssMeta{$ELSE}ssCtrl{$ENDIF}]);
  MoveDown2.ShortCut := ShortCut(40, [{$IFDEF DARWIN}ssMeta{$ELSE}ssCtrl{$ENDIF}]);
  MoveUp1.ShortCut := ShortCut(38, [{$IFDEF DARWIN}ssMeta{$ELSE}ssCtrl{$ENDIF}]);
  MoveDown1.ShortCut := ShortCut(40, [{$IFDEF DARWIN}ssMeta{$ELSE}ssCtrl{$ENDIF}]);
  
  bXX := false;
  
  CreateNewProject;
  bY := LoadUISettings;
  s := '';
  RepaintMRUF;
  
  TreeEx.Selected := TreeEx.Items.Item[1];
  TreeExChange(Self, TreeEx.Selected);
  if s <> '' then
    if LoadProjectScript(s) then
      s := '';
  
  if (((s = '') and (ParamStr(1) = '')) or 
    (s <> '')) 
    and (not bY) then 
  begin
    NewShowTimer.Interval := 100;
    NewShowTimer.Enabled := True;
  end
  else
  begin
    
  end;
  if bXX then
    Application.Terminate;
end;

procedure Tui.Compile1Click(Sender: TObject);
var
  i, j: Integer;
  PullCntx: String;
  PullIndx: Integer;
  s, sX, sY: String;
  l: TList;
  hDef: TCursor;
  escondido, escondidoX: String;
  pPin: Boolean;
begin
  if not SafeRunState then Exit;
  
  hDef := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    PushStatusStack('Compiling project');
    i :=  PreCompileScript(s, false);
    if i = MAXINT -1 then 
    begin
      Screen.Cursor := hDef;
      Exit;
    end;
    if i <> -1 then
    try
      
      Code1Click(Self);
      Screen.Cursor := hDef;
      if i =  MAXINT -2 then
      begin
        Application.MessageBox(PChar(s), PChar(SCompileError), mb_Ok + mb_IconStop);
        Options1Click(Self);
        Exit;
      end;
      if i =  MAXINT -3 then
      begin
        Application.MessageBox(PChar(s), PChar(SCompileError), mb_Ok + mb_IconStop);
        Exit;
      end;
      try
        ShowIncludeLineFromGlobal(i, PullMap, True);
        try
          if not Script.Focused then Script.SetFocus;
        except
        end;
        
        Application.MessageBox(PChar(s), PChar(SCompileError), mb_Ok + mb_IconStop);
        EditAction1Click(Self);
        Exit;
      finally
        ProcessTemporaryExpand(false);
      end;
    finally
      
    end;
    
    if not ProjectStruct.BuildInFolder then
      sX := ProjectStruct.BuildCustomFolder
    else
    begin
      if CurrentProjectName = '' then
        sX := EXEDIR
      else
        sX := PROJDIR;
    end;
    if sX = '' then
    begin
      Screen.Cursor := hDef;
      Exit;
    end;
    sX := AssertDir(sX) + 'Release' + DirectorySeparator;
    if ProjectStruct.BuildLayout = 0 then
      sX := sX + 'Uncompressed' + DirectorySeparator; 
    if ProjectStruct.BuildLayout = 1 then
      sX := sX + 'Single' + DirectorySeparator; 
    if ProjectStruct.BuildLayout = 2 then
      sX := sX + 'Web' + DirectorySeparator; 
    ForceDirectories(sX);
    if not DirectoryExists(sX) then
    begin
      Screen.Cursor := hDef;
      Exit;
    end;
    if CurrentProjectName = '' then
      s := SUntitledMsi
    else
      s := ExtractFileNameOnly(CurrentProjectName) + '.msi'; 
    s := sX + s;
    
    try
      Screen.Cursor := crHourGlass;
      escondido := ProjectStruct.Conditionals;
      escondidoX := ProjectStruct.Conditionals;
      SetMakeContext(axGlobalLists, axScriptTypes, axScriptReferences,
        axScriptComments, escondidoX, l, sY,
        ProjectStruct.BuildLayout, ProjectStruct.Language, ProjectStruct.Name,
        ProjectStruct.aSign);
      StrCopy(ProjectStruct.Conditionals, PChar(escondidoX));
      thCurrentProjectName := CurrentProjectName;
      thProjectStruct := ProjectStruct;
      thScriptTypes := axScriptTypes;
      thScriptReferences := axScriptReferences;
      thScriptComments := axScriptComments;
      thScriptFetches := axScriptFetches;
      thProhibitedScriptFetches := ProhibitedScriptFetches;
      thDialogFiles := DialogFiles;
      thSupportFiles := SupportFiles;
      thIncludeFiles := IncludeFiles;
      thGlobalLists := l;
      thGlobal := THashedStringList.Create;
      for i := 1 to l.Count do
        for j := 1 to TStringList(l[i -1]).Count do
          thGlobal.Add(TStringList(l[i -1])[j -1]);
      
      BuildFinished := false;
      Cancelled := false;
      Success := false;
      Screen.Cursor := crHourGlass;
      try
        CompileMSI(s, nil, thProjectStruct.BuildLayout = 2, thGlobalLists,
          thScriptTypes, thScriptReferences, thScriptComments,
          thProjectStruct.Conditionals, thProjectStruct.BuildLayout,
          thProjectStruct.Language, thProjectStruct.Name,
          thProjectStruct.cFiles, thProjectStruct.cRegistry, thProjectStruct.cFeatures,
          thProjectStruct.cHashes, '',
          pPin, thProjectStruct.aSign); 
      except
        
        on E: Exception do
          Application.MessageBox(PChar(E.Message), PChar(Application.Title), mb_Ok + mb_IconStop);
      end;
      thGlobal.Free;
    finally
      SetEditContext(l, axScriptTypes);
      StrCopy(ProjectStruct.Conditionals, PChar(escondido));
      
      FreeAxContext;
    end;
    Screen.Cursor := hDef;
  finally
    PopStatusStack;
  end;
end;

procedure Tui.GenericPopupMenuPopup(Sender: TObject);
begin
  
  Action144.Caption := SNew_1;
  Action145.Caption := SEdit;
  Action146.Caption := SDelete;
  Action144.Enabled := false;
  Action145.Enabled := false;
  Action146.Enabled := false;
  if VisualNotebook.ActivePage = 'WeblocksPage' then
  begin
    
    Action144.Caption := SBuildSelected;
    Action145.Caption := SEdit;
    Action146.Caption := SSkipSelected;
    
    Action144.Enabled := BuildSel.Enabled;
    Action145.Enabled := EditWebBlock.Enabled;
    Action146.Enabled := SkipSel.Enabled;
  end
  else
  if VisualNotebook.ActivePage = 'ShortcutsPage' then
  begin
    
    Action144.Enabled := wodbc.Enabled;
    Action145.Enabled := EditShortcut.Enabled;
    Action146.Enabled := DeleteShortcut.Enabled;
  end
  else
  if VisualNotebook.ActivePage = 'AccessControlPage' then
  begin
    
    Action144.Enabled := NewAccess.Enabled;
    Action145.Enabled := EditAccess.Enabled;
    Action146.Enabled := DeleteAccess.Enabled;
  end
  else
  if VisualNotebook.ActivePage = 'FileAssociationsPage' then
  begin
    
    Action144.Enabled := NewAssocs.Enabled;
    Action145.Enabled := EditAssocs.Enabled;
    Action146.Enabled := DeleteAssocs.Enabled;
  end
  else
  if VisualNotebook.ActivePage = 'RunProgramsPage' then
  begin
    
    Action144.Enabled := RunNew.Enabled;
    Action145.Enabled := RunEdit.Enabled;
    Action146.Enabled := RunDelete.Enabled;
  end
  else
  if VisualNotebook.ActivePage = 'INIFilesPage' then
  begin
    
    Action144.Enabled := NewINI.Enabled;
    Action145.Enabled := EditINIs.Enabled;
    Action146.Enabled := DeleteINI.Enabled;
  end
  else
  if VisualNotebook.ActivePage = 'LocalFilesPage' then
  begin
    
    Action144.Enabled := NewLocal.Enabled;
    Action145.Enabled := EditLocal.Enabled;
    Action146.Enabled := DeleteLocal.Enabled;
  end
  else
  if VisualNotebook.ActivePage = 'VersionsPage' then
  begin
    
    Action144.Caption := SAdd;
    Action146.Caption := SRemove_1;
    
    Action144.Enabled := AddVer.Enabled;
    Action146.Enabled := RemoveVer.Enabled;
  end
  else
  if VisualNotebook.ActivePage = 'UpdatePacksPage' then
  begin
    Action146.Caption := SDelete_1;
    
    Action144.Enabled := NewPack.Enabled;
    Action145.Enabled := EditPack.Enabled;
    Action146.Enabled := DeletePack.Enabled;
  end;
end;

procedure Tui.Import1Click(Sender: TObject);

begin
end;

procedure Tui.INIChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  EditINIs.Enabled := INI.SelCount = 1;
  DeleteINI.Enabled := INI.SelCount >= 1;
  
end;

procedure Tui.INIDblClick(Sender: TObject);
begin
  if INI.Selected <> nil then
    EditINIsClick(Self);
end;

procedure Tui.INIFeaturesChange(Sender: TObject);
begin
  GetComponentPathFromComboCache := ''; 
  FeatureAwareINIPopulate;
end;

procedure Tui.INIFilterClick(Sender: TObject);
begin
  INIFeatures.Enabled := True; 
  INIFeatures.Enabled := INIFilter.Checked;
  FeatureAwareINIPopulate;
end;

procedure Tui.INIKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    INIDblClick(Self);
end;

procedure Tui.INIKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 45 then
    if NewINI.Enabled then
      NewINIClick(Self);
  if Key = 46 then
    if DeleteINI.Enabled then
      DeleteINIClick(Self);
end;

procedure Tui.INIMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  INIChange(Self, nil, ctState);
end;

procedure Tui.LinuxShuntComboExit(Sender: TObject);
begin
  {$IFDEF LINUX}
  Script.ReExit;
  {$ENDIF}
end;

procedure Tui.LinuxShuntComboKeyPress(Sender: TObject; var Key: char);
begin
  {$IFDEF LINUX}
  Script.ReKeyPress(Key);
  {$ENDIF}
end;

procedure Tui.LocalChange(Sender: TObject; Item: TListItem; Change: TItemChange
  );
begin
  EditLocal.Enabled := Local.SelCount = 1;
  DeleteLocal.Enabled := Local.SelCount >= 1;
  
end;

procedure Tui.LocalDblClick(Sender: TObject);
begin
  if Local.Selected <> nil then
    EditLocalClick(Self);
end;

procedure Tui.LocalFeaturesChange(Sender: TObject);
begin
  GetComponentPathFromComboCache := ''; 
  FeatureAwareLocalPopulate;
end;

procedure Tui.LocalFilterChange(Sender: TObject);
begin
end;

procedure Tui.LocalFilterClick(Sender: TObject);
begin
  LocalFeatures.Enabled := True; 
  LocalFeatures.Enabled := LocalFilter.Checked;
  FeatureAwareLocalPopulate;
end;

procedure Tui.LocalKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    LocalDblClick(Self);
end;

procedure Tui.LocalKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 45 then
    if NewLocal.Enabled then
      NewLocalClick(Self);
  if Key = 46 then
    if DeleteLocal.Enabled then
      DeleteLocalClick(Self);
end;

procedure Tui.LocalMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  LocalChange(Self, nil, ctState);
end;

procedure Tui.MenuItem10Click(Sender: TObject);
var
  i, j: Integer;
  b: Boolean;
  s: String;
begin
  try
    PushStatusStack('Stepping through project');
    if not Running then
    begin
      Code1Click(Self);
      i := PreCompileScript(s, false);
      if i = MAXINT -1 then 
      begin
        Exit;
      end;
      if i <> -1 then
      begin
        Compile1Click(Self);
        Exit;
      end;
      try
        ProcessTemporaryExpand(True);
        BreakRun := false;
        Stepping := True;
        Running := True;
        Script.Enabled := false;
        Globals.Enabled := false;
        Particulars.Enabled := false;
        SaveProject1.Enabled := false; 
        SaveProjectAs1.Enabled := false; 
        ToolButton3.Enabled := false; 
        AdjustUIProjectChanged;
        
        if Script.Items.Count > 0 then
          Script.TopIndex := 0; 
        b := ui.CurrentUnit.Enabled;
        ui.CurrentUnit.Enabled := false;
        RunScript(axScriptTypes, axScriptReferences, axScriptComments, axScriptFetches,
          axGlobalLists, @RunCallback, GetBuildFolder(not ProjectStruct.BuildDebug) + GetProjectFileNameOnly + '.msi'); 
        ui.CurrentUnit.Enabled := b;
        Running := false;
        AdjustUIProjectChanged;
        Script.Enabled := True;
        {$IFDEF DARWIN}
        {$IFDEF CPUAARCH64}
        NSTableView(NSScrollView(Script.Handle).documentView).setAllowsTypeSelect(false);
        {$ENDIF}
        {$ENDIF}
        Globals.Enabled := True;
        Particulars.Enabled := True;
        SaveProject1.Enabled := True;
        SaveProjectAs1.Enabled := True;
        ToolButton3.Enabled := True; 
        try
          if not Script.Focused then Script.SetFocus;
        except
        end;
      finally
        ProcessTemporaryExpand(false);
        FreeAxContext;
      end;
    end
    else
    begin
      Stepping := True;
      ContinueDebug := True;
    end;
  finally
    PopStatusStack;
  end;
  
end;

procedure Tui.MenuItem11Click(Sender: TObject);
begin
  BreakRun := True;
  ContinueDebug := True;
end;

procedure Tui.MenuItem13Click(Sender: TObject);
begin
  PushStatusStack('Adding variable watch');
  if AddWatch.ShowModal = mrOk then
    if VarWatches.IndexOf(AnsiUpperCase(AddWatch.Variable.Text)) = -1 then
    begin
      VarWatches.Add(AnsiUpperCase(AddWatch.Variable.Text));
      RefreshWatches;
      
      DockMaster.MakeDockable(Watches, True, True);
    end;
  PopStatusStack;
end;

procedure Tui.MenuItem15Click(Sender: TObject);
var
  l: TStringList;
  i, j: Integer;
  s: String;
begin
  if not SafeRunState then Exit;
  if not InDesigner then Exit;
  for i := 1 to Script.Items.Count do
    if Script.Selected[i -1] then
    begin
      
      SetDirtyMia(True, '');
      l := GetAllRealLines(i -1);
      for j := 1 to l.Count do
        if not IsLineCodeFolding(StrToInt(l[j -1])) then
        begin
          s := Breakpoints[StrToInt(l[j -1])];
          if s = '' then s := 'B' else s := '';
          BreakPoints[StrToInt(l[j -1])] := s;
          RenderLine(StrToInt(l[j -1]), false);
          
        end;
      l.Free;
      Script.Selected[i -1] := True;
    end;
end;

procedure Tui.MenuItem17Click(Sender: TObject);
begin
  OpenBuildFolder(-1);
end;

procedure Tui.MenuItem18Click(Sender: TObject);
begin
  if not SafeRunState then Exit;
  BatchBuild.ShowModal;
end;

procedure Tui.MenuItem20Click(Sender: TObject);
begin
  OpenRunFile(-1);
end;

procedure Tui.MenuItem21Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  LaunchAppAndWait(EXEDIR + 'miauix.exe', '', True, false);
  {$ELSE}
  {$IFDEF DARWIN}
  LaunchAppAndWait(EXEDIR + 'miauix.app/Contents/MacOS/miauix', '', True, false);
  {$ELSE}
  LaunchAppAndWait(EXEDIR + 'miauix', '', True, false);
  {$ENDIF}
  {$ENDIF}
end;

procedure Tui.MenuItem27Click(Sender: TObject);
var
  s, sX: String;
begin
  CollapseAllRegions1.Enabled :=  
    (ActiveTab <> 0) and not Running;
  ExpandAllRegions1.Enabled := CollapseAllRegions1.Enabled;
  Undo1.Enabled := PeekStackItem(UndoStack, s, sX);
  Redo1.Enabled := PeekStackItem(RedoStack, s, sX);
end;

procedure Tui.MenuItem28Click(Sender: TObject);
begin
  OpenURL('mailto:' + EmailURL + '?subject='
    + StringReplace(Brand, ' ' , '%20', [rfReplaceAll, rfIgnoreCase]) + '%20Feedback');
end;

procedure Tui.MenuItem31Click(Sender: TObject);
begin
  OpenURL('https://www.installaware.com/');
end;

procedure Tui.MenuItem32Click(Sender: TObject);
begin
  if not SafeRunState then Exit;
  ReplaceDialog.Execute;
end;

procedure Tui.MenuItem33Click(Sender: TObject);
var
  i: Integer;
begin
  
  if not SafeRunState then Exit;
  try
    i := ProjectStruct.BuildLayout;
    ProjectStruct.BuildLayout := 1;
    Build1Click(Self);
  finally
    ProjectStruct.BuildLayout := i;
  end;
end;

procedure Tui.MenuItem35Click(Sender: TObject);
var
  i: Integer;
begin
  
  if not SafeRunState then Exit;
  try
    i := ProjectStruct.BuildLayout;
    ProjectStruct.BuildLayout := 2;
    Build1Click(Self);
  finally
    ProjectStruct.BuildLayout := i;
  end;
end;

procedure Tui.MenuItem53Click(Sender: TObject);
begin
  
  OpenBuildFolder(0);
end;

procedure Tui.MenuItem54Click(Sender: TObject);
begin
  
  OpenBuildFolder(1);
end;

procedure Tui.MenuItem57Click(Sender: TObject);
begin
  
  OpenBuildFolder(2);
end;

procedure Tui.MenuItem58Click(Sender: TObject);
begin
  
  OpenRunFile(0);
end;

procedure Tui.MenuItem64Click(Sender: TObject);
begin
  
  OpenRunFile(1);
end;

procedure Tui.MenuItem65Click(Sender: TObject);
begin
  
  OpenRunFile(2);
end;

procedure Tui.MenuItem66Click(Sender: TObject);
begin
  
  if RenderInsertScript('Copy/Move Local Files',
    GetInsertionIndexBeforeApplyChangesWithFeatureSupport(GetComponentPathFromCombo(LocalFeatures), LocalFilter.Checked),
    GetLineVisibilityState(
      GetInsertionIndexBeforeApplyChangesWithFeatureSupport(GetComponentPathFromCombo(LocalFeatures), LocalFilter.Checked),
    false), True) then
  begin
    try
      Script.ItemIndex := GetFoldedLineNumber(
        GetInsertionIndexBeforeApplyChangesWithFeatureSupport(GetComponentPathFromCombo(LocalFeatures), LocalFilter.Checked));
    except
    end;
    AdjustVisualUI;
  end;
end;

procedure Tui.MenuItem67Click(Sender: TObject);
begin
  
  if RenderInsertScript('Delete Files',
    GetInsertionIndexBeforeApplyChangesWithFeatureSupport(GetComponentPathFromCombo(LocalFeatures), LocalFilter.Checked),
    GetLineVisibilityState(
      GetInsertionIndexBeforeApplyChangesWithFeatureSupport(GetComponentPathFromCombo(LocalFeatures), LocalFilter.Checked),
    false), True) then
  begin
    try
      Script.ItemIndex := GetFoldedLineNumber(
        GetInsertionIndexBeforeApplyChangesWithFeatureSupport(GetComponentPathFromCombo(LocalFeatures), LocalFilter.Checked));
    except
    end;
    AdjustVisualUI;
  end;
end;

procedure Tui.MenuItem68Click(Sender: TObject);
begin
  
  if RenderInsertScript('Edit INI File',
    GetInsertionIndexBeforeApplyChangesWithFeatureSupport(GetComponentPathFromCombo(INIFeatures), INIFilter.Checked),
    GetLineVisibilityState(
      GetInsertionIndexBeforeApplyChangesWithFeatureSupport(GetComponentPathFromCombo(INIFeatures), INIFilter.Checked),
    false), True) then
  begin
    try
      Script.ItemIndex := GetFoldedLineNumber(
        GetInsertionIndexBeforeApplyChangesWithFeatureSupport(GetComponentPathFromCombo(INIFeatures), INIFilter.Checked));
    except
    end;
    AdjustVisualUI;
  end;
end;

procedure Tui.MenuItem69Click(Sender: TObject);
var
  l, lX, lY: TStringList;
  i, j: Integer;
  tif: TIniFile;
  li: TListItem;
  s, sX: String;
  hDef: TCursor;
begin
  
  try
    PushStatusStack('Importing configuration file');
    if OpenINI.Execute then
    begin
      hDef := Screen.Cursor;
      Screen.Cursor := crHourGlass;
      try
        INI.Items.BeginUpdate;
        l := TStringList.Create;
        tif := TIniFile.Create(OpenINI.FileName); 
        tif.ReadSections(l);
        lY := TStringList.Create;
        for i := 1 to l.Count do
        begin
          lX := TStringList.Create;
          tif.ReadSection(l[i -1], lX);
          for j := 1 to lX.Count do
          begin
            s := tif.ReadString(l[i -1], lX[j -1], '$MYAH_NULL$');
            if s <> '$MYAH_NULL$' then
            begin
              lY.Clear;
              lY.Add(DeAssertDir(FixUpPath(AssertDir(ExtractFilePath(OpenINI.FileName)))));
              lY.Add(ExtractFileName(OpenINI.FileName));
              lY.Add('0');
              lY.Add(l[i -1]);
              lY.Add(lX[j -1]);
              lY.Add(FixUpPath(s));
              sX := RenderInsertScriptEx('Edit INI File', EditINI, lY, 
                GetInsertionIndexBeforeApplyChangesWithFeatureSupport(GetComponentPathFromCombo(INIFeatures), INIFilter.Checked),
                GetLineVisibilityState(
                  GetInsertionIndexBeforeApplyChangesWithFeatureSupport(GetComponentPathFromCombo(INIFeatures), INIFilter.Checked)
                  , false));
              li := INI.Items.Add;
              li.Caption := FixUpPath(OpenINI.FileName);
              li.SubItems.Add(l[i -1]);
              li.SubItems.Add(lX[j -1] + ' = ' + FixUpPath(s));
              li.SubItems.Add(scrEditIniFile.Action.Items[0]);
              li.ImageIndex := 101;
              li.SubItems.Add(sX);
            end;
          end;
          lX.Free;
        end;
        lY.Free;
        RehashIndents;
        INI.Items.EndUpdate;
        tif.Free;
        l.Free;
      finally
        Screen.Cursor := hDef;
      end;
    end;
  finally
    PopStatusStack;
  end;
end;

procedure Tui.MenuItem7Click(Sender: TObject);
var
  i: Integer;
begin
  
  if not SafeRunState then Exit;
  try
    i := ProjectStruct.BuildLayout;
    ProjectStruct.BuildLayout := 0;
    Build1Click(Self);
  finally
    ProjectStruct.BuildLayout := i;
  end;
end;

procedure Tui.NewAccessClick(Sender: TObject);
var
  InsertIndex: Integer;
begin
  InsertIndex := GetInsertionIndexAfterApplyChanges(True, True);
  if InsertIndex = -1 then
  begin
    Application.MessageBox(PChar(SApplyInstallCommandNotFoundInSet
      + MyLineEnding + SThisCommandMustBePresentInYourSc_7
      + MyLineEnding + MyLineEnding + SToAvoidSeeingThisMessageCreateNe),
      PChar(Application.Title), mb_Ok + mb_IconStop);
    Exit;
  end;
  if RenderInsertScript('Set Access Control', GetInsertionIndexAfterApplyChangesWithFeatureSupport(GetComponentPathFromCombo(AccFeatures), AccFilter.Checked, True),
    GetLineVisibilityState(
      GetInsertionIndexAfterApplyChangesWithFeatureSupport(GetComponentPathFromCombo(AccFeatures), AccFilter.Checked, True),
    false), True) then
  begin
    try
      Script.ItemIndex := GetFoldedLineNumber(GetInsertionIndexAfterApplyChangesWithFeatureSupport(GetComponentPathFromCombo(AccFeatures), AccFilter.Checked, True));
    except
    end;
    AdjustVisualUI;
  end;
end;

procedure Tui.NewAssocsClick(Sender: TObject);
var
  
  InsertIndex: Integer;
begin
  if not AssnFilter.Checked then
    InsertIndex := GetInsertionIndexBeforeApplyChanges(True)
  else
    InsertIndex := GetNewFilesInsertionIndex(GetComponentPathFromCombo(AssnFeatures));
  if InsertIndex = -1 then
  begin
    Application.MessageBox(PChar(SApplyInstallCommandNotFoundInSet
      + MyLineEnding + SThisCommandMustBePresentInYourSc
      + MyLineEnding + MyLineEnding + SToAvoidSeeingThisMessageCreateNe),
      PChar(Application.Title), mb_Ok + mb_IconStop);
    Exit;
  end;
  
  Define1Click(Self);
end;

procedure Tui.NewINIClick(Sender: TObject);
var
  p: TPoint;
  InsertIndex: Integer;
begin
  if not INIFilter.Checked then
    InsertIndex := GetInsertionIndexBeforeApplyChanges(True)
  else
    InsertIndex := GetNewFilesInsertionIndex(GetComponentPathFromCombo(INIFeatures));
  if InsertIndex = -1 then
  begin
    Application.MessageBox(PChar(SApplyInstallCommandNotFoundInSet
      + MyLineEnding + SThisCommandMustBePresentInYourSc
      + MyLineEnding + MyLineEnding + SToAvoidSeeingThisMessageCreateNe),
      PChar(Application.Title), mb_Ok + mb_IconStop);
    Exit;
  end;
  GetCursorPos(p);
  NewINIPopup.Popup(p.X, p.Y);
end;

procedure Tui.NewLocalClick(Sender: TObject);
var
  p: TPoint;
  InsertIndex: Integer;
begin
  if not LocalFilter.Checked then
    InsertIndex := GetInsertionIndexBeforeApplyChanges(True)
  else
    InsertIndex := GetNewFilesInsertionIndex(GetComponentPathFromCombo(LocalFeatures));
  if InsertIndex = -1 then
  begin
    Application.MessageBox(PChar(SApplyInstallCommandNotFoundInSet
      + MyLineEnding + SThisCommandMustBePresentInYourSc
      + MyLineEnding + MyLineEnding + SToAvoidSeeingThisMessageCreateNe),
      PChar(Application.Title), mb_Ok + mb_IconStop);
    Exit;
  end;
  GetCursorPos(p);
  NewLocalPopup.Popup(p.X, p.Y);
end;

procedure Tui.NewPackClick(Sender: TObject);
var
  i: Integer;
  tif: TIniFile;
begin
  if CurrentProjectName = '' then
  begin
    Application.MessageBox(PChar(SPleaseSaveYourProjectBeforeDefin),
      PChar(Application.Title), mb_Ok + mb_IconStop);
    Exit;
  end;
  with UpdatePack do
  begin
    PackName.Enabled := True;
    PackName.Text := '';
    DownloadURL.Text := '';
    Description.Lines.Text := '';
    Reboot.Checked := false;
    Silent.Checked := True;
    Parameters.Text := '';
    if ShowModal = mrOk then
    begin
      
      for i := 1 to Packs.Items.Count do
        if CompareText(Packs.Items[i -1].Caption, PackName.Text) = 0 then
        begin
          Application.MessageBox(PChar(SThisUpdatePackHasAlreadyBeenDefi),
            PChar(Application.Title), mb_Ok + mb_IconStop);
          Exit;
        end;
      
      tif := TIniFile.Create(PROJDIR + 'updates.ini'); 
      tif.WriteString(PackName.Text, 'URL', DownloadURL.Text); 
      tif.WriteString(PackName.Text, 'Description', MultiLineToSingleLine(Description.Lines.Text)); 
      if Reboot.Checked then
        tif.WriteString(PackName.Text, 'Reboot', 'Yes') 
      else
        tif.WriteString(PackName.Text, 'Reboot', 'No'); 
      if Silent.Checked then
        tif.WriteString(PackName.Text, 'Silent', 'Yes') 
      else
        tif.WriteString(PackName.Text, 'Silent', 'No'); 
      tif.WriteString(PackName.Text, 'Parameters', Parameters.Text); 
      tif.Free;
      
      if SupportFiles.IndexOf('updates.ini') = -1 then 
      begin
        SupportFiles.Add('updates.ini'); 
        Project.SetSupport(SupportFiles);
        SetDirtyMpr(True);
      end;
      
      AdjustVisualUI;
    end;
  end;
end;

procedure Tui.NewShowTimerTimer(Sender: TObject);
begin
  NewShowTimer.Enabled := false;
  if TimerMaximize.Enabled then
    repeat
      Application.ProcessMessages; 
    until not TimerMaximize.Enabled;
  ProjectSelection := -1;
  NewProject.ShowModal;
end;

procedure Tui.PacksChange(Sender: TObject; Item: TListItem; Change: TItemChange
  );
begin
  EditPack.Enabled := Packs.SelCount = 1;
  DeletePack.Enabled := Packs.SelCount >= 1;
end;

procedure Tui.PacksDblClick(Sender: TObject);
begin
  if Packs.Selected <> nil then
    EditPackClick(Self);
end;

procedure Tui.PacksKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    PacksDblClick(Self);
end;

procedure Tui.PacksKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 45 then
    if NewPack.Enabled then
      NewPackClick(Self);
  if Key = 46 then
    if DeletePack.Enabled then
      DeletePackClick(Self);
end;

procedure Tui.PacksMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  PacksChange(Self, nil, ctState);
end;

procedure Tui.PopupFolderPopup(Sender: TObject);
begin
  MenuItem53.Enabled := DirectoryExists(SniffBuildFolder(0));
  MenuItem54.Enabled := DirectoryExists(SniffBuildFolder(1));
  MenuItem57.Enabled := DirectoryExists(SniffBuildFolder(2));
end;

procedure Tui.PopupRunPopup(Sender: TObject);
begin
  MenuItem58.Enabled := MyFileExists(SniffRunFile(0)) or DirectoryExists(SniffRunFile(0));
  MenuItem64.Enabled := MyFileExists(SniffRunFile(1)) or DirectoryExists(SniffRunFile(1));
  MenuItem65.Enabled := MyFileExists(SniffRunFile(2)) or DirectoryExists(SniffRunFile(2));
end;

procedure Tui.PreviousTab2Click(Sender: TObject);
begin
  if not SafeRunState then Exit;
  if CurrentUnit.TabIndex <> 0 then
  begin
    CurrentUnit.TabIndex := CurrentUnit.TabIndex -1;
    CurrentUnitChange(Self);
  end;
end;

procedure Tui.NextTab2Click(Sender: TObject);
begin
  if not SafeRunState then Exit;
  if CurrentUnit.Tabs.Count > CurrentUnit.TabIndex +1 then
  begin
    CurrentUnit.TabIndex := CurrentUnit.TabIndex +1;
    CurrentUnitChange(Self);
  end;
end;

procedure Tui.MenuItem37Click(Sender: TObject);
begin
  ProcessAllCodeFolds(false);
end;

procedure Tui.MenuItem38Click(Sender: TObject);
begin
  ProcessAllCodeFolds(True);
end;

procedure Tui.MenuItem39Click(Sender: TObject);
var
  s: String;
  i, j: Integer;
  l: TStringList;
begin
  if not SafeRunState then Exit;
  PushStatusStack('Copying selection as plain text');
  l := TStringList.Create;
  for i := 1 to Script.Items.Count do
    if Script.Selected[i -1] then
    begin
      s := '';
      for j := 1 to (StrToInt(IndentHash[GetRealLineNumber(i -1)]) div (FontWidth)) -6 do
        s := s + ' ';
      s := s + Script.Items[i -1];
      s := StringReplace(s, '[END REGION]', SCodeFoldingRegion_1, [rfReplaceAll, rfIgnoreCase]); 
      l.Add(s);
    end;
  for i := 1 to l.Count do
  Clipboard.SetTextBuf(PChar(l.Text));
  l.Free;
  PopStatusStack;
end;

procedure Tui.MenuItem40Click(Sender: TObject);
begin
end;

procedure Tui.MenuItem41Click(Sender: TObject);
begin
  UndoAction;
end;

procedure Tui.MenuItem42Click(Sender: TObject);
begin
  RedoAction;
end;

procedure Tui.MenuItem43Click(Sender: TObject);
begin
  CreateBlankProject(false);
end;

procedure Tui.MenuItem44Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  LaunchAppAndWait(EXEDIR + 'mpax.exe', '', True, false);
  {$ELSE}
  {$IFDEF DARWIN}
  LaunchAppAndWait(EXEDIR + 'mpax.app/Contents/MacOS/mpax', '', True, false);
  {$ELSE}
  LaunchAppAndWait(EXEDIR + 'mpax', '', True, false);
  {$ENDIF}
  {$ENDIF}
end;

procedure Tui.MenuItem45Click(Sender: TObject);
begin
  try
    PushStatusStack('Importing InstallAware project');
    if not SafeRunState then Exit;
    if not IsSafeToCloseProject then Exit;
    if not OpenProjectEx.Execute then Exit;
    LoadProject(OpenProjectEx.FileName, True);
  finally
    PopStatusStack;
  end;
end;

procedure Tui.MenuItem46Click(Sender: TObject);
begin
  if not SafeRunState then Exit;
  DialogLocalize.ShowModal;
  AdjustUIProjectChanged;
end;

procedure Tui.MenuItem47Click(Sender: TObject);
var
  s: String;
begin
  try
    
    PushStatusStack('Importing PKG package');
    
    if not OpenPKG.Execute then Exit;
    s := ImportPKG(OpenPKG.FileName);
    if s <> '' then
      Application.MessageBox(PChar(OpenPKG.FileName + ' imported successfully into:'
        + LineEnding + LineEnding + s), 'InstallAware PKG Import', mb_IconInformation + mb_Ok);
  finally
    PopStatusStack;
  end;
end;

procedure Tui.MenuItem48Click(Sender: TObject);
var
  l: TStringList;
  i, j, k: Integer;
begin
  try
    PushStatusStack('Importing InstallAware dialogs');
    if ImpDlgDir.Execute then
    begin
      l := FindAllFilesEx(AssertDir(ImpDlgDir.FileName) + '*', True);
      j := 0;
      k := 0;
      for i := 1 to l.Count do
        if AnsiCompareText(ExtractFileExt(l[i -1]), '.dfm') = 0 then
        begin
          k := k +1;
          if Dfm2Txt(l[i -1], AssertDir(ExtractFilePath(l[i -1])) + ExtractFileNameOnly(l[i -1])
            + '.lfm') then
          begin
            j := j +1;
            ScrubNewLfm(AssertDir(ExtractFilePath(l[i -1])) + ExtractFileNameOnly(l[i -1])
              + '.lfm');
            FileCopyFile(l[i -1] + '.miaf',
              AssertDir(ExtractFilePath(l[i -1])) + ExtractFileNameOnly(l[i -1])
              + '.lfm.miaf', false);
          end;
        end;
      l.Free;
      Application.MessageBox(PChar(IntToStr(j) + ' of ' + IntToStr(k)
        + ' original dialog(s) were imported successfully into:' + LineEnding + LineEnding +
        ImpDlgDir.FileName), 'InstallAware Dialog Import', mb_IconInformation + mb_Ok);
    end;
  finally
    PopStatusStack;
  end;
end;

procedure Tui.MenuItem49Click(Sender: TObject);
begin
  {$IFDEF WINDOWS}
  ShellExecute(Handle, 'open', PChar(EXEDIR + 'trans\mTranslator.exe'), 
    '', PChar('"' + PROJDIR + '"'), SW_SHOW);
  {$ELSE}
  {$IFDEF DARWIN}
  LaunchAppAndWait(EXEDIR + 'trans/mTranslator.app/Contents/MacOS/mTranslator', '', True, false);
  {$ELSE}
  LaunchAppAndWait(EXEDIR + 'trans/mTranslator', '', True, false);
  {$ENDIF}
  {$ENDIF}
end;

procedure Tui.EditFiles1Click(Sender: TObject);
var
  s, sX: String;
  i, iX: Integer;
  l, lX: TStringList;
  SourcePath, TargetFolder, GUID: String;
begin
  if Files.SelCount > 1 then
  begin
    PushStatusStack('Editing multiple files');
    
    scrInstallFiles.Source.Text := SMultipleFiles;
    scrInstallFiles.Source.Enabled := false;
    scrInstallFiles.Exclude.Text := SMultipleWildcards;
    scrInstallFiles.Exclude.Enabled := false;
    scrInstallFiles.Button1.Enabled := false;
    
    l := TStringList.Create;
    lX := TStringList.Create;
    for i := 1 to Files.Items.Count do
      if Files.Items[i -1].Selected then
        l.Add(Files.Items[i -1].SubItems[1]);
    if HashMultipleCommandFields(InstallFiles, l, 13, 2, s) then
      scrInstallFiles.Target.Text := s
    else
    begin
      scrInstallFiles.Target.Text := SMultipleFolders;
      scrInstallFiles.Target.Enabled := false;
    end;
    HashForCheckBox(scrInstallFiles.Recursive, InstallFiles, l, 13, 1);
    HashForCheckBox(scrInstallFiles.ReadOnly, InstallFiles, l, 13, 3);
    HashForCheckBox(scrInstallFiles.Hidden, InstallFiles, l, 13, 4);
    HashForCheckBox(scrInstallFiles.System, InstallFiles, l, 13, 5);
    HashForCheckBox(scrInstallFiles.Vital, InstallFiles, l, 13, 6);
    HashForCheckBox(scrInstallFiles.Checksum, InstallFiles, l, 13, 7);
    HashForCheckBox(scrInstallFiles.SelfReg, InstallFiles, l, 13, 8);
    HashForCheckBox(scrInstallFiles.Shared, InstallFiles, l, 13, 9);
    HashForCheckBox(scrInstallFiles.Permanent, InstallFiles, l, 13, 10);
    HashForCheckBox(scrInstallFiles.Overwrite, InstallFiles, l, 13, 11);
    
    scrForceValue := scrInstallFiles.Target.Text;
    if scrInstallFiles.ShowModal = mrOk then
    begin
      if scrInstallFiles.Target.Enabled then
        UpdateMultipleValues(InstallFiles, l, 13, 2, scrInstallFiles.Target.Text);
      if scrInstallFiles.Recursive.State <> cbGrayed then
        UpdateMultipleValues(InstallFiles, l, 13, 1, BoolToStr(scrInstallFiles.Recursive.Checked));
      if scrInstallFiles.ReadOnly.State <> cbGrayed then
        UpdateMultipleValues(InstallFiles, l, 13, 3, BoolToStr(scrInstallFiles.ReadOnly.Checked));
      if scrInstallFiles.Hidden.State <> cbGrayed then
        UpdateMultipleValues(InstallFiles, l, 13, 4, BoolToStr(scrInstallFiles.Hidden.Checked));
      if scrInstallFiles.System.State <> cbGrayed then
        UpdateMultipleValues(InstallFiles, l, 13, 5, BoolToStr(scrInstallFiles.System.Checked));
      if scrInstallFiles.Vital.State <> cbGrayed then
        UpdateMultipleValues(InstallFiles, l, 13, 6, BoolToStr(scrInstallFiles.Vital.Checked));
      if scrInstallFiles.Checksum.State <> cbGrayed then
        UpdateMultipleValues(InstallFiles, l, 13, 7, BoolToStr(scrInstallFiles.Checksum.Checked));
      if scrInstallFiles.SelfReg.State <> cbGrayed then
        UpdateMultipleValues(InstallFiles, l, 13, 8, BoolToStr(scrInstallFiles.SelfReg.Checked));
      if scrInstallFiles.Shared.State <> cbGrayed then
        UpdateMultipleValues(InstallFiles, l, 13, 9, BoolToStr(scrInstallFiles.Shared.Checked));
      if scrInstallFiles.Permanent.State <> cbGrayed then
        UpdateMultipleValues(InstallFiles, l, 13, 10, BoolToStr(scrInstallFiles.Permanent.Checked));
      if scrInstallFiles.Overwrite.State <> cbGrayed then
        UpdateMultipleValues(InstallFiles, l, 13, 11, BoolToStr(scrInstallFiles.Overwrite.Checked));
      if scrForceValue <> scrInstallFiles.Target.Text then
        AdjustVisualUI;
    end;
    l.Free;
    
    scrInstallFiles.Source.Text := '';
    scrInstallFiles.Source.Enabled := True;
    scrInstallFiles.Exclude.Text := '';
    scrInstallFiles.Exclude.Enabled := True;
    scrInstallFiles.Button1.Enabled := True;
    scrInstallFiles.Target.Enabled := True;
    scrInstallFiles.Recursive.AllowGrayed := false;
    scrInstallFiles.ReadOnly.AllowGrayed := false;
    scrInstallFiles.Hidden.AllowGrayed := false;
    scrInstallFiles.System.AllowGrayed := false;
    scrInstallFiles.Vital.AllowGrayed := false;
    scrInstallFiles.Checksum.AllowGrayed := false;
    scrInstallFiles.SelfReg.AllowGrayed := false;
    scrInstallFiles.Shared.AllowGrayed := false;
    scrInstallFiles.Permanent.AllowGrayed := false;
    scrInstallFiles.Overwrite.AllowGrayed := false;
    PopStatusStack;
    Exit;
  end;
  SourcePath := AssertDir(Files.Selected.SubItems[0]) + Files.Selected.Caption;
  TargetFolder := AssertDir(GetFolderPathFromTree(Folders.Selected));
  GUID := 
    Files.Selected.SubItems[1];
  if RenderUpdateScript(GetScriptSmartPosition(GUID), false) then
  begin
    if AssertDir(InstallFiles[InstallFiles.IndexOf(GUID) + 3]) <> TargetFolder then
    begin
      AdjustVisualUI;
      Exit;
    end
    else
    if InstallFiles[InstallFiles.IndexOf(GUID) + 1] <> SourcePath then
    begin
      Files.Selected.Caption :=
        ExtractFileName(InstallFiles[InstallFiles.IndexOf(GUID) + 1]);
      Files.Selected.SubItems.Clear;
      Files.Selected.SubItems.Add(
        AssertDir(ExtractFilePath(InstallFiles[InstallFiles.IndexOf(GUID) + 1])));
      Files.Selected.SubItems.Add(GUID);
    end;
  end;
end;

procedure Tui.MenuItem50Click(Sender: TObject);
begin
  Files.SelectAll;
  EditFiles1Click(Self);
end;

procedure Tui.MenuItem51Click(Sender: TObject);
begin
  if Application.MessageBox(PChar(SAreYouSureYouWishToDeleteAllFile),
    PChar(Application.Title), mb_YesNo + mb_IconQuestion) = id_Yes then
  begin
    Files.SelectAll;
    DeleteFiles1Click(Self);
  end;
end;

procedure Tui.MenuItem52Click(Sender: TObject);

procedure DeleteNodeRecursive(Node: TTreeNode);
var
  i: Integer;
  l: TStrings;
  n: TTreeNode;
begin
  for i := Node.Count downto 1 do
    DeleteNodeRecursive(Node[i -1]);
  
  n := Node;
  
  i := FindCreateOrMapFolderIndex(DeAssertDir(GetFolderPathFromTree(n)));
  FoldersChange(Folders, n);
  if (Files.Items.Count > 0) or (i <> -1) then
  begin
    
    if i <> -1 then RenderDeleteScriptEx(i, True);
    
    l := GetFilesAndSourcesForComponentInFolder(
      GetComponentPathFromCombo(FilesFeatures),
      GetFolderPathFromTree(n), FileFilter.Checked);
    for i := 1 to l.Count do
      if i mod 2 = 1 then
        RenderDeleteScriptEx(ScriptReferences.IndexOf(l[i]), True);
    l.Free;
    
      n.Delete; 
      
  end
  else
    if FileFilter.Checked then 
    begin
      if IsSafeToDeleteFileViewFolderNode(Node, false) then
        Node.Delete;
    end
    else
      if IsSafeToDeleteFileViewFolderNode(Node, True) then
        Node.Delete;
end;

var
  n, nX: TTreeNode;
  hWait, hDef: TCursor;
begin
  if Application.MessageBox('Are you sure you wish to delete all files and subfolders inside this folder?',
    PChar(Application.Title), mb_YesNo + mb_IconQuestion) = id_Yes then
    try
      
      hDef := Screen.Cursor;
      Screen.Cursor := crHourGlass;
      AllowFileRehash := false;
      n := Folders.Selected.Parent;
      DeleteNodeRecursive(Folders.Selected);
      while (n <> nil) and (n.Count = 0) do
      begin
        if IsSafeToDeleteFileViewFolderNode(n, false) then
        begin
          nX := n.Parent;
          n.Delete;
          n := nX;
        end
        else
          Break;
      end;
      RehashIndents;
    finally
      AllowFileRehash := True;
      
      Screen.Cursor := hDef;
    end;
end;

procedure Tui.CreateSubfolder1Click(Sender: TObject);
var
  s: String;
  l: TStringList;
  InsertIndex: Integer;
begin
  InsertIndex := GetInsertionIndexBeforeApplyChanges(True);
  if InsertIndex = -1 then
  begin
    Application.MessageBox(PChar(SApplyInstallCommandNotFoundInSet
      + MyLineEnding + SThisCommandMustBePresentInYourSc_14
      + MyLineEnding + MyLineEnding + SToAvoidSeeingThisMessageCreateNe),
      PChar(Application.Title), mb_Ok + mb_IconStop);
    Exit;
  end;
  if InputQuery(SCreateSubfolder, SSubfolder, s) then
    if s <> '' then
    begin
      s := AssertDir(GetFolderPathFromTree(Folders.Selected)) + s;
      l := TStringList.Create;
      l.Add(s);
      RenderInsertScriptEx('Create Folder', CreateFolder, l, 
        InsertIndex, GetLineVisibilityState(InsertIndex, false));
      l.Free;
      
      RehashIndents;
      CategoriesButtonClicked(Self);
    end;
end;

procedure Tui.RemoveVerClick(Sender: TObject);
var
  tif: TIniFile;
begin
  if Versions.Items.Count = 0 then
  begin
    Application.MessageBox(PChar(SThereAreNoDefinedApplicationVers),
      PChar(Application.Title), mb_Ok + mb_IconStop);
    Exit;
  end;
  if Versions.ItemIndex = -1 then
  begin
    Application.MessageBox(PChar(SPleaseSelectTheApplicationVersio),
      PChar(Application.Title), mb_Ok + mb_IconStop);
    Exit;
  end;
  if Application.MessageBox(PChar(SAreYouSureYouWishToRemoveAllUpda),
    PChar(Application.Title), mb_YesNo + mb_IconQuestion) = id_Yes then
  begin
    tif := TIniFile.Create(PROJDIR + 'updates.ini'); 
    tif.DeleteKey(SUpdatePacksForVersions, Versions.Items[Versions.ItemIndex]);
    Versions.Items.Delete(Versions.ItemIndex);
    Served.Items.Clear;
    tif.Free;
  end;
end;

procedure Tui.RunChange(Sender: TObject; Item: TListItem; Change: TItemChange);
begin
  RunEdit.Enabled := Run.SelCount = 1;
  RunDelete.Enabled := Run.SelCount >= 1;
end;

procedure Tui.RunDblClick(Sender: TObject);
begin
  if Run.Selected <> nil then
    RunEditClick(Self);
end;

procedure Tui.RunDeleteClick(Sender: TObject);
var
  i: Integer;
begin
  for i := Run.Items.Count downto 1 do
    if Run.Items[i -1].Selected then
    begin
      RenderDeleteScriptEx(
        GetScriptSmartPosition(Run.Items[i -1].SubItems[2]), True);
      Run.Items[i -1].Delete;
    end;
  RehashIndents;
  
  RunChange(Self, nil, ctState);
end;

procedure Tui.RunEditClick(Sender: TObject);
var
  i: Integer;
begin
  if RenderUpdateScript(
    GetScriptSmartPosition(Run.Selected.SubItems[2]), false) then
  begin
    i := Run.Selected.Index;
    AdjustVisualUI;
    Run.Selected := Run.Items[i];
    Run.ItemFocused := Run.Items[i];
    Run.Items[i].MakeVisible(false);
  end;
end;

procedure Tui.RunKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    RunDblClick(Self);
end;

procedure Tui.RunKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 45 then
    if RunNew.Enabled then
      RunNewClick(Self);
  if Key = 46 then
    if RunDelete.Enabled then
      RunDeleteClick(Self);
end;

procedure Tui.RunMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  RunChange(Self, nil, ctState);
end;

procedure Tui.RunNewClick(Sender: TObject);
var
  i: Integer;
  s, sX: String;
  l, lX: TStringList;
  InsertIndex: Integer;
begin
  
  NewRunProgram.ProgramFile.Text := '';
  NewRunProgram.LoadFirst.Checked := false;
  NewRunProgram.LoadURL.Text := '';
  NewRunProgram.Parameters.Text := '';
  NewRunProgram.Wait.Checked := false;
  NewRunProgram.Finish.Checked := True;
  if NewRunProgram.ShowModal = mrOk then
  begin
    if NewRunProgram.Before.Checked then
      InsertIndex := GetInsertionIndexBeforeApplyChanges(True);
    if NewRunProgram.BeforeU.Checked then
      InsertIndex := GetInsertionIndexBeforeApplyChanges(false);
    if NewRunProgram.After.Checked then
      InsertIndex := GetInsertionIndexAfterApplyChanges(True, True);
    if NewRunProgram.AfterU.Checked then
      InsertIndex := GetInsertionIndexAfterApplyChanges(false, True);
    if NewRunProgram.Finish.Checked then
      InsertIndex := GetInsertionIndexAtFinish;
    if InsertIndex = -1 then
    begin
      if NewRunProgram.Before.Checked or NewRunProgram.After.Checked then
        Application.MessageBox(PChar(SApplyInstallCommandNotFoundInSet
          + MyLineEnding + SThisCommandMustBePresentInYourSc_9
          + MyLineEnding + MyLineEnding + SToAvoidSeeingThisMessageCreateNe),
          PChar(Application.Title), mb_Ok + mb_IconStop)
      else
        if NewRunProgram.BeforeU.Checked or NewRunProgram.AfterU.Checked then
          Application.MessageBox(PChar(SApplyUninstallCommandNotFoundInS
            + MyLineEnding + SThisCommandMustBePresentInYourSc_10
            + MyLineEnding + MyLineEnding + SToAvoidSeeingThisMessageCreateNe_1),
            PChar(Application.Title), mb_Ok + mb_IconStop)
        else
          Application.MessageBox(PChar(SSomeNecessaryCommandsCouldNotBeL
            + MyLineEnding + MyLineEnding + SToAvoidSeeingThisMessageCreateNe_2),
            PChar(Application.Title), mb_Ok + mb_IconStop);
      Exit;
    end;
    if NewRunProgram.LoadFirst.Checked then
    begin
      l := TStringList.Create;
      s := 'DOWNLOADED_' + Trim(ExtractFileNameOnly(StringReplace(NewRunProgram.LoadUrl.Text, '/', '\', [rfReplaceAll, rfIgnoreCase])));
      l.Add(s + '$MYAH$MYAH$FALSE');
      l.Add('');
      RenderInsertScriptEx('Set Variable', SetVariable, l, InsertIndex, 
        GetLineVisibilityState(InsertIndex, false));
      l.Clear;
      l.Add(NewRunProgram.LoadUrl.Text);
      l.Add('$SUPPORTDIR$/' + ExtractFileName(StringReplace(NewRunProgram.LoadUrl.Text, '/', '/', [rfReplaceAll, rfIgnoreCase])));
      l.Add(s);
      l.Add('');
      l.Add('');
      l.Add('TRUE');
      RenderInsertScriptEx('Download File', DownloadFile, l, InsertIndex +1, 
        GetLineVisibilityState(InsertIndex +1, false));
      l.Clear;
      l.Add(s);
      l.Add('0');
      l.Add('SUCCESS');
      l.Add('FALSE');
      RenderInsertScriptEx('If', xIf, l, InsertIndex +2, 
        GetLineVisibilityState(InsertIndex +2, false));
      l.Clear;
      l.Add('$SUPPORTDIR$/' + ExtractFileName(StringReplace(NewRunProgram.LoadUrl.Text, '/', '/', [rfReplaceAll, rfIgnoreCase])));
      l.Add('FALSE'); 
      l.Add(NewRunProgram.Parameters.Text);
      l.Add(BoolToStr(NewRunProgram.Wait.Checked));
      l.Add('');
      RenderInsertScriptEx('Run Program', RunProgram, l, InsertIndex +3, 
        GetLineVisibilityState(InsertIndex +3, false));
      l.Clear;
      RenderInsertScriptEx('End', nil, nil, InsertIndex +4, 
        GetLineVisibilityState(InsertIndex +4, false));
      l.Free;
    end
    else
    begin
      l := TStringList.Create;
      l.Add(RunBrowseSelectedFile);
      l.Add('FALSE'); 
      l.Add(NewRunProgram.Parameters.Text);
      l.Add(BoolToStr(NewRunProgram.Wait.Checked));
      l.Add('');
      RenderInsertScriptEx('Run Program', RunProgram, l, InsertIndex, 
        GetLineVisibilityState(InsertIndex, false));
      l.Free;
    end;
    
    RehashIndents;
    
    SetDirtyMIA(True, '');
    AdjustVisualUI;
  end;
end;

procedure Tui.ServedClickCheck(Sender: TObject);
var
  s: String;
  i: Integer;
  tfi: TIniFile;
  l: TStringList;
begin
  l := TStringList.Create;
  tfi := TIniFile.Create(PROJDIR + 'updates.ini'); 
  for i := 1 to Served.Items.Count do
    if Served.Checked[i -1] then
      l.Add(Served.Items[i -1]);
  s := MultiLineToSingleLine(l.Text);
  if s <> '' then
    s := Copy(s, 1, Length(s) - Length('$NEWLINE$')); 
  tfi.WriteString(SUpdatePacksForVersions, Versions.Items[Versions.ItemIndex], s);
  tfi.Free;
  l.Free;
end;

procedure Tui.ServedKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 38 then
    if Shift = [{$IFDEF DARWIN}ssMeta{$ELSE}ssCtrl{$ENDIF}] then
      if SpeedButton3.Enabled then
        SpeedButton3Click(Self);
  if Key = 40 then
    if Shift = [{$IFDEF DARWIN}ssMeta{$ELSE}ssCtrl{$ENDIF}] then
      if SpeedButton4.Enabled then
        SpeedButton4Click(Self);
end;

procedure Tui.ShortcutFeaturesChange(Sender: TObject);
begin
  GetComponentPathFromComboCache := ''; 
  FeatureAwareShortcutPopulate;
end;

procedure Tui.ShortcutFilterClick(Sender: TObject);
begin
  ShortcutFeatures.Enabled := True; 
  ShortcutFeatures.Enabled := ShortcutFilter.Checked;
  FeatureAwareShortcutPopulate;
end;

procedure Tui.ShortcutsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  EditShortcut.Enabled := Shortcuts.SelCount = 1;
  DeleteShortcut.Enabled := Shortcuts.SelCount >= 1;
  ShortcutType.Enabled := DeleteShortcut.Enabled;
end;

procedure Tui.ShortcutsDblClick(Sender: TObject);
begin
  if Shortcuts.Selected <> nil then
    EditShortcutClick(Self);
end;

procedure Tui.ShortcutsKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    ShortcutsDblClick(Self);
end;

procedure Tui.ShortcutsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key = 45 then
    if wodbc.Enabled then
      wodbcClick(Self);
  if Key = 46 then
    if DeleteShortcut.Enabled then
      DeleteShortcutClick(Self);
end;

procedure Tui.ShortcutsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  ShortcutsChange(Self, nil, ctState);
end;

procedure Tui.SkipSelClick(Sender: TObject);
var
  i: Integer;
  hWait, hDef: THandle;
begin
  PushStatusStack('Skipping selected Web Media Block(s)');
  hDef := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    for i := 1 to WebBlocks.Items.Count do
      if WebBlocks.Items[i -1].Selected then
      begin
        SetMediaBlockSkipEx(WebBlocks.Items[i -1].SubItems[3], True);
        
        WebBlocks.Items[i -1].SubItems[2] := SDoNotBuild;
      end;
  finally
    Screen.Cursor := hDef;
    PopStatusStack;
  end;
end;

procedure Tui.SpeedButton3Click(Sender: TObject);
begin
  if Served.Items.Count = 0 then Exit;
  if not Served.Enabled then Exit;
  if Served.ItemIndex <> 0 then
  begin
    Served.Items.Exchange(Served.ItemIndex, Served.ItemIndex -1);
    ServedClickCheck(Self);
  end;
end;

procedure Tui.SpeedButton4Click(Sender: TObject);
begin
  if Served.Items.Count = 0 then Exit;
  if not Served.Enabled then Exit;
  if Served.ItemIndex <> Served.Items.Count -1 then
  begin
    Served.Items.Exchange(Served.ItemIndex, Served.ItemIndex +1);
    ServedClickCheck(Self);
  end;
end;

procedure Tui.SpoolTimerTimer(Sender: TObject);
var
  b: Graphics.TBitmap;
begin
  b := nil;
  SpoolTimer.Enabled := false;
  EditDialogBtn.Enabled := DialogsListEx.ItemIndex <> -1;
  BitBtn8.Enabled := DialogsListEx.Items.Count <> 0;
  if EditDialogBtn.Enabled then
  begin
    b := GetBitmapForm(PROJDIR +
      DialogsListEx.Items[DialogsListEx.ItemIndex] + '.lfm'); 
    if Assigned(b) then
    begin
      DlgPreview.Picture.Bitmap := b;
      DlgPreviewEx.Picture.Bitmap := b;
    end;
  end;
  if EditDialogBtn.Enabled and (Assigned(b)) then
  begin
    DlgPreview.Visible := (b.Width >= DlgPreview.Width) or (b.Height >= DlgPreview.Height);
    DlgPreviewEx.Visible := not DlgPreview.Visible;
  end
  else
  begin
    DlgPreview.Visible := false;
    DlgPreviewEx.Visible := false;
  end;
  if Assigned(b) then
    b.Free;
end;

procedure Tui.TabSetGetImageIndex(Sender: TObject; TabIndex: Integer;
  var ImageIndex: Integer);
begin
  ImageIndex := TabIndex;
end;

procedure Tui.UpdatesClick(Sender: TObject);
var
  s: String;
  i, iX: Integer;
  v: Boolean;
  l, lX: TStringList;
begin
  if OffTheHook > 0 then Exit;
  if Notebook.ActivePage <> 'Visual' Then Exit; 
  MonitorURL.Enabled := Updates.Checked;
  
  Label192.Enabled := Updates.Checked;
  if Updates.Checked then
  begin
    
      SetUpdateShortcut(True)
    ;
    
    for i := 1 to IncludeFiles.Count do
      if AnsiPos('updates.miax', IncludeFiles[i -1]) <> 0 then 
        Break
      else
        if i = IncludeFiles.Count then
        begin
          if not MyFileExists(PROJDIR + 'updates.miax') then
            FileCopyFile(PChar(EXEDIR + 'runtimes' + PathDelim + 'updates.miax'),
              PChar(PROJDIR + 'updates.miax'), false);
          IncludeFiles.Add(PROJDIR + 'updates.miax'); 
          Project.SetInclude(IncludeFiles);
        end;
    if IncludeFiles.Count = 0 then
    begin
      if not MyFileExists(PROJDIR + 'updates.miax') then
        FileCopyFile(PChar(EXEDIR + 'runtimes' + PathDelim + 'updates.miax'),
          PChar(PROJDIR + 'updates.miax'), false);
      IncludeFiles.Add(PROJDIR + 'updates.miax'); 
      Project.SetInclude(IncludeFiles);
    end;
    
    lX := MyFindAllFiles(EXEDIR + 'runtimes' + PathDelim, '*.lfm', false); 
    if DialogFiles.Count = 0 then
    begin
      for i := 1 to lX.Count do
      begin
        AddDialog.Manual.Checked := True;
        AddDialog.SingleDialog.Text := '"' + lX[i -1] + '"';
        AddDialog.OKClick(Self);
      end;
    end
    else
      for i := 1 to lX.Count do
        for iX := 1 to DialogFiles.Count do
          if CompareText(DialogFiles[iX -1], lX[i -1]) = 0 then
            Break
          else
            if iX = DialogFiles.Count then
            begin
              AddDialog.Manual.Checked := True;
              AddDialog.SingleDialog.Text := '"' + lX[i -1] + '"';
              AddDialog.OKClick(Self);
            end;
    
    l := TStringList.Create;
    l.CommaText := ProjectStruct.Conditionals;
    s := ProjectStruct.arUpdates;
    if s = '' then s := SHttpWwwMywebsiteCom;
    s := s + 'updates.ini'; 
    for i := 1 to l.Count do
      if AnsiPos('UPDATE_SERVER=', l[i -1]) = 1 then 
      begin
        s := '';
        Break; 
      end
      else
        if i = l.Count then 
          l.Add('UPDATE_SERVER=' + s); 
    if l.Count = 0 then
      l.Add('UPDATE_SERVER=' + s); 
    if s <> '' then 
    try
      OffTheHook := OffTheHook +1;
      MonitorURL.Text := s;
    finally
      OffTheHook := OffTheHook -1;
    end;
    StrCopy(ProjectStruct.Conditionals, PChar(l.CommaText));
    
    l.Free;
    
    i := GetUpdateInsertionIndex(True);
    v := GetLineVisibilityState(i, false);
    l := TStringList.Create;
    l.Add('updates'); 
    RenderInsertScriptEx('Include Script', xInclude, l, i, v); 
    l.Free;
    RehashIndents;
    
    SetDirtyMia(True, '');
    SetDirtyMpr(True);
  end
  else
  begin
    
    SetUpdateShortcut(false);
    
    Project.Tree.ClearSelection(false);
    SaveJ := MAXINT;
    for i := Project.Tree.Items[0].Items[3].Count downto 1 do
      if CompareText('updates', Project.Tree.Items[0].Items[3].Items[i -1].Text) = 0 then
      begin
        Project.Tree.Items[0].Items[3].Items[i -1].Selected := True;
        Project.RemoveIncludeClick(Self);
      end;
    SaveJ := 0;
    
    for i := xInclude.Count downto 1 do
      if (i mod 2) = 0 then
        if CompareText(xInclude[i -1], 'updates') = 0 then 
        begin
          RenderDeleteScriptEx(GetScriptSmartPosition(xInclude[i -2]), True);
          SetDirtyMia(True, '');
          RehashIndents;
        end;
  end;
end;

procedure Tui.VersionsClick(Sender: TObject);
var
  i, j: Integer;
  tif: TIniFile;
  l, lX: TStringList;
begin
  if Versions.ItemIndex = -1 then Exit; 
  tif := TIniFile.Create(PROJDIR + 'updates.ini'); 
  l := TStringList.Create;
  lX := TStringList.Create;
  lX.Text := MemoMultiToDefaultMultiLineAdapter((SingleLineToMultiLine(
    tif.ReadString(SUpdatePacksForVersions, Versions.Items[Versions.ItemIndex], ''))));
  tif.ReadSections(l);
  for i := 1 to l.Count do
    if CompareText(SUpdatePacksForVersions, l[i -1]) = 0 then
    begin
      l.Delete(i -1);
      Break;
    end;
  Served.Items.Clear;
  
  for i := 1 to lX.Count do
    for j := l.Count downto 1 do
      if CompareText(l[j -1], lX[i -1]) = 0 then
      begin
        Served.Items.Add(lX[i -1]);
        Served.Checked[Served.Items.Count -1] := True;
        l.Delete(j -1);
      end;
  
  for i := 1 to l.Count do
    Served.Items.Add(l[i -1]);
  
  Served.Enabled := Served.Items.Count > 0;
  if Served.Items.Count = 0 then
    Served.Items.Add(SNoUpdatePacksAvailable);
  lX.Free;
  l.Free;
  tif.Free;
end;

procedure Tui.VersionsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 45 then
    if AddVer.Enabled then
      AddVerClick(Self);
  if Key = 46 then
    if RemoveVer.Enabled then
      RemoveVerClick(Self);
end;

procedure Tui.Visual1Click(Sender: TObject);
begin
  SwitchToUI(True);
end;

procedure Tui.Code1Click(Sender: TObject);
begin
  SwitchToUI(false);
end;

procedure Tui.MenuItem55Click(Sender: TObject);
begin
  if not SafeRunState then Exit;
  NewProject.ShowModal;
end;

procedure Tui.MenuItem56Click(Sender: TObject);
begin
  
  FindDialogFind(Self);
  
end;

procedure Tui.MenuItem59Click(Sender: TObject);
begin
  ShellList.ViewStyle := vsIcon; 
end;

procedure Tui.MenuItem60Click(Sender: TObject);
begin
  ShellList.ViewStyle := vsSmallIcon; 
end;

procedure Tui.MenuItem61Click(Sender: TObject);
begin
  ShellList.ViewStyle := vsList;
end;

procedure Tui.MenuItem62Click(Sender: TObject);
begin
  ShellList.ViewStyle := vsReport; 
end;

procedure Tui.MenuItem63Click(Sender: TObject);
var
  s: String;
begin
  
  if Assigned(ShellTree.Selected) then
  begin
    
    s := ShellTree.Path;
    while not DirectoryExists(s) do 
    begin
      if s = ExtractFilePath(DeAssertDir(s)) then Break;
      s := ExtractFilePath(DeAssertDir(s));
    end;
    ShellTree.Path := s;
    
    ShellTree.Selected.Expanded := false;
    ShellTree.Selected.SelectedIndex := ShellTree.Selected.SelectedIndex;
    ShellTree.Selected.Expanded := True;
  end;
  
  s := ShellList.Root;
  ShellList.Root := '';
  while not DirectoryExists(s) do 
  begin
    if s = ExtractFilePath(DeAssertDir(s)) then Break;
    s := ExtractFilePath(DeAssertDir(s));
  end;
  ShellList.Root := s;
end;

procedure Tui.MenuItem8Click(Sender: TObject);
begin
  
  DockMaster.MakeDockable(Watches, True, True);
end;

procedure Tui.NewFeatureClick(Sender: TObject);
var
  i, j, k: Integer;
  s, sX: String;
  b, v: Boolean;
  l: TStringList;
  n, nX: TTreeNode;
begin
  
  s := SNewFeature;
  j := 1;
  b := Features.Selected.Count = 0;
  while not b do
    for i := 1 to Features.Selected.Count do
      if AnsiLowerCase(Features.Selected.Items[i -1].Text) = AnsiLowerCase(s) then
      begin
        j := j +1;
        s := SNewFeature_1 + IntToStr(j) + ')';
        Break;
      end
      else if i = Features.Selected.Count then
        b := True;
  
  n := Features.Items.AddChildFirst(Features.Selected, s);
  
  if n.Parent.Parent <> nil then
  begin
    nX := n;
    while nX.Parent.Parent <> nil do
      nX := nX.Parent;
    nX.MoveTo(nX.Parent.Items[0], naAddFirst);
  end;
  
  with n do
  begin
    ImageIndex := 1;
    SelectedIndex := 1;
    Parent.Expand(True);
  end;
  
  l := TStringList.Create;
  if GetComponentPathFromTree(Features.Selected) = '' then
    l.Add(s)
  else
    l.Add(GetComponentPathFromTree(Features.Selected) + '\' + s);
  l.Add('TRUE'); 
  l.Add(SDescriptionForFeature + s);
  v := GetLineVisibilityState(GetSmartPositionInClass('Define Component', false), 
    false);
  RenderInsertScriptEx('Define Component', DefComponent, l, 
    GetSmartPositionInClass('Define Component', false), v); 
  l.Free;
  
  if GetSetComponentStateSmartPosition(True, false) <> 0 then
  begin
    l := TStringList.Create;
    if GetComponentPathFromTree(Features.Selected) = '' then
      l.Add(s)
    else
      l.Add(GetComponentPathFromTree(Features.Selected) + '\' + s);
    l.Add('TRUE'); 
    v := GetLineVisibilityState(GetSetComponentStateSmartPosition(True, false),
      false);
    RenderInsertScriptEx('Set Component State', SetComponent, l, 
      GetSetComponentStateSmartPosition(True, false), v);
    l.Free;
  end;
  
  if GetSetComponentStateSmartPosition(false, false) <> 0 then
  begin
    l := TStringList.Create;
    if GetComponentPathFromTree(Features.Selected) = '' then
      l.Add(s)
    else
      l.Add(GetComponentPathFromTree(Features.Selected) + '\' + s);
    l.Add('FALSE'); 
    v := GetLineVisibilityState(GetSetComponentStateSmartPosition(false, false),
      false);
    RenderInsertScriptEx('Set Component State', SetComponent, l, 
      GetSetComponentStateSmartPosition(false, false), v);
    l.Free;
  end;
  
  k := GetSmartPositionInClass('Web Media Block', True); 
  v := GetLineVisibilityState(k, false);
  
  sX := s;
  l := TStringList.Create;
  l.Add(sX);
  l.Add(AssertUrl(ProjectStruct.arUpdates) + s + '.7zip');
  l.Add('FALSE'); 
  RenderInsertScriptEx('Web Media Block', MediaBlock, l, k, v); 
  l.Clear;
  k := k +1;
  if GetComponentPathFromTree(Features.Selected) = '' then
    l.Add(s)
  else
    l.Add(GetComponentPathFromTree(Features.Selected) + '\' + s);
  l.Add('SELECTED'); 
  RenderInsertScriptEx('Get Component State', GetComponent, l, k, v); 
  l.Clear;
  k := k +1;
  l.Add('SELECTED'); 
  l.Add('0');
  l.Add('TRUE'); 
  l.Add('FALSE'); 
  RenderInsertScriptEx('If', xIf, l, k, v); 
  k := k +1;
  l.Free;
  RenderInsertScriptEx('End', nil, nil, k, v); 
  
  RehashIndents;
  
  Features.SetFocus;
  n.Selected := True;
  
  n.EditText;
end;

procedure Tui.RemoveSubfolder1Click(Sender: TObject);
begin
  RenderDeleteScriptEx(
    FindCreateOrMapFolderIndex(DeAssertDir(GetFolderPathFromTree(Folders.Selected))), True);
  RehashIndents;
  CategoriesButtonClicked(Self);
end;

procedure Tui.RenameFeatureClick(Sender: TObject);
begin
  Features.SetFocus;
  Features.Selected.EditText;
end;

procedure Tui.ReplaceDialogClose(Sender: TObject);
begin
  InsertShortcuts;
  CurrentUnit.Enabled := True;
  Visual1.Enabled := True; 
  NextTab1.Enabled := True;
  NextTab2.Enabled := True;
  PreviousTab1.Enabled := True;
  PreviousTab2.Enabled := True;
  
  TabSet.Enabled := True;
  globSearchOn := false;
  Script.Refresh;
  try
    if not Script.Focused then Script.SetFocus;
  except
  end;
  PopStatusStack;
end;

procedure Tui.ReplaceDialogFind(Sender: TObject);
var
  i: Integer;
  hDef: TCursor;
begin
  hDef := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    PushStatusStack('Searching text');
    FindDialog.FindText := ReplaceDialog.FindText;
    globSearchOn := True;
    Script.Refresh;
    if LastReplaceSearch <> ReplaceDialog.FindText then
    begin
      LastFindIndex := 0;
      LastReplaceSearch := ReplaceDialog.FindText;
    end
    else
      LastFindIndex := GetRealLineNumber(Script.ItemIndex) +1;
    
    LastFindIndex := LastFindIndex +1;
    for i := LastFindIndex to ScriptBuffer.Count do
      if 
        IsTextInCommandAtLine(ReplaceDialog.FindText, i -1, false, frMatchCase in ReplaceDialog.Options) then
      begin
        
        LastFindIndex := i;
        AssertLineIsVisible(i -1);
        ClearSelectionEx(Script);
        Script.ItemIndex := GetFoldedLineNumber(i -1);
        Script.Selected[GetFoldedLineNumber(i -1)] := True;
        MyPlaySound(PChar(EXEDIR + 'audio\find_in_path.wav')); 
        Exit;
      end;
  finally
    Screen.Cursor := hDef;
    PopStatusStack;
  end;
end;

procedure Tui.ReplaceDialogReplace(Sender: TObject);
var
  i, j, k: Integer;
  b: Boolean;
  hDef: TCursor;
begin
  hDef := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    PushStatusStack('Replacing text');
    LastReplaceSearch := '';
    if LastReplaceSearch <> ReplaceDialog.FindText then
    begin
      LastFindIndex := 0;
      LastReplaceSearch := ReplaceDialog.FindText;
    end
    else
      LastFindIndex := GetRealLineNumber(Script.ItemIndex) +1;
    b := frReplaceAll in ReplaceDialog.Options;
    if b then k := 0;
    LastFindIndex := LastFindIndex +1;
    for i := LastFindIndex to ScriptBuffer.Count do
      if IsTextInCommandAtLine(ReplaceDialog.FindText, i -1, false, frMatchCase in ReplaceDialog.Options) then
      begin
        LastFindIndex := i;
        AssertLineIsVisible(i -1);
        ClearSelectionEx(Script);
        Script.ItemIndex := GetFoldedLineNumber(i -1);
        Script.Selected[GetFoldedLineNumber(i -1)] := True;
        if not b then MyPlaySound(PChar(EXEDIR + 'audio\find_in_path.wav')); 
        if not b then 
          j := Application.MessageBox(PChar(STextFoundInStatementReplace),
            PChar(Application.Title), mb_YesNoCancel + mb_IconQuestion)
        else
          j := id_Yes;
        if j = id_Yes then
        begin
          if ReplaceTextInCommandAtLine(ReplaceDialog.FindText,
            ReplaceDialog.ReplaceText, i -1,
            frMatchCase in ReplaceDialog.Options) then
            k := k +1;
        end;
        if j = id_Cancel then
        begin
          LastReplaceSearch := '';
          Exit;
        end;
      end;
  finally
    Screen.Cursor := hDef;
    PopStatusStack;
  end;
    if b then
      if k <> 0 then
        Application.MessageBox(PChar(IntToStr(k) + SInstanceSReplaced),
          PChar(Application.Title), mb_Ok + mb_IconInformation);
end;

procedure Tui.ReplaceDialogShow(Sender: TObject);
begin
  LastReplaceSearch := '';
  FindDialog.CloseDialog;
  PushStatusStack('Finding and replacing text');
  Application.ProcessMessages;
  if CurrentUnit.TabIndex = 0 then
  begin
    CurrentUnit.TabIndex := 1;
    CurrentUnitChange(Self);
  end;
  CurrentUnit.Enabled := false;
  Visual1.Enabled := false; 
  NextTab1.Enabled := false;
  NextTab2.Enabled := false;
  PreviousTab1.Enabled := false;
  PreviousTab2.Enabled := false;
  
  TabSet.Enabled := false;
  RemoveShortcuts;
end;

procedure Tui.Run2Click(Sender: TObject);
var
  i, j: Integer;
  b: Boolean;
  s: String;
begin
  try
    PushStatusStack('Debugging project');
    if Running then
    begin
      Stepping := false;
      ContinueDebug := True;
    end
    else
    begin
      Code1Click(Self);
      i := PreCompileScript(s, false);
      if i = MAXINT -1 then 
      begin
        Exit;
      end;
      if i <> -1 then
      begin
        Compile1Click(Self);
        Exit;
      end;
      try
        ProcessTemporaryExpand(True);
        BreakRun := false;
        Stepping := false;
        Running := True;
        AdjustUIProjectChanged;
        Script.Enabled := false;
        Globals.Enabled := false;
        Particulars.Enabled := false;
        SaveProject1.Enabled := false; 
        SaveProjectAs1.Enabled := false; 
        ToolButton3.Enabled := false;
        
        if Script.Items.Count > 0 then
          Script.TopIndex := 0; 
        b := ui.CurrentUnit.Enabled;
        ui.CurrentUnit.Enabled := false;
        RunScript(axScriptTypes, axScriptReferences, axScriptComments, axScriptFetches,
          axGlobalLists, @RunCallback, GetBuildFolder(not ProjectStruct.BuildDebug) + GetProjectFileNameOnly + '.msi'); 
        CurrentUnit.Enabled := b;
        Running := false;
        AdjustUIProjectChanged;
        Script.Enabled := True;
        {$IFDEF DARWIN}
        {$IFDEF CPUAARCH64}
        NSTableView(NSScrollView(Script.Handle).documentView).setAllowsTypeSelect(false);
        {$ENDIF}
        {$ENDIF}
        Globals.Enabled := True;
        Particulars.Enabled := True;
        SaveProject1.Enabled := True; 
        SaveProjectAs1.Enabled := True; 
        ToolButton3.Enabled := True;
        try
          if not Script.Focused then Script.SetFocus;
        except
        end;
      finally
        ProcessTemporaryExpand(false);
        FreeAxContext;
      end;
    end;
  finally
    PopStatusStack;
  end;
  
end;

procedure Tui.MenuItem4Click(Sender: TObject);
begin
end;

procedure Tui.Options1Click(Sender: TObject);
var
  s: String;
  i: Integer;
  sl: TStringList;
  Wide1, Wide2: String;
begin
  if not SafeRunState then Exit;
  with ProjectStruct do
    with Options do
    begin
      s := ProjectStruct.Name;
      
      CD.Checked := BuildLayout = 0;
      SFX.Checked := BuildLayout = 1;
      Web.Checked := BuildLayout = 2;
      Debug.Checked := BuildDebug = True;
      
      if TryStrToInt(CompressProfile, i) then
      begin
        if i < 0 then CompressProfile := '0'
        else
        if i > 8 then CompressProfile := '8'
        else
          StrCopy(CompressProfile, PChar(IntToStr(i)));
          
      end
      else
        CompressProfile := '6';
      
      CompressBar.Position := StrToInt(CompressProfile);
      ProjectFolder.Checked := BuildInFolder;
      CustomFolder.Checked := not BuildInFolder;
      BuildFolder.Text := BuildCustomFolder;
      AutoUpdate.Checked := AutoIncrement;
      BuildFilename.Text := OutputFile;
      
      CodeSign.Checked := ProjectStruct.aSign;
      
      WidenColonDelimParam(ProjectStruct.aCertificate, Wide1, Wide2);
      SPC.Text := Wide1;
      TeamID.Text := Wide2;
      
      WidenColonDelimParam(ProjectStruct.aKey, Wide1, Wide2);
      PVK.Text := Wide1;
      PFX.Text := Wide2;
      
      WidenColonDelimParam(ProjectStruct.aTimeStamp, Wide1, Wide2);
      BackTimeStampText := Wide1;
      TimeStamp.Text := Wide1;
      AppleIDPassword.Text := Wide2;
      InfoURL.Text := ProjectStruct.aInfo;
      
      Manufacturer.Text := ProjectStruct.Manufacturer;
      ProductName.Text := ProjectStruct.Name;
      ProductCode.Text := ProjectStruct.Code;
      RevisionCode.Text := ProjectStruct.Revision;
      
      Encrypt.Checked := ProjectStruct.PassEnabled;
      Key.Text := ProjectStruct.Password;
      Password.Text := ProjectStruct.CodeSignPassword;
      LangEx.Checked := ProjectStruct.MultiLang;
      ProductVersion.Text := ProjectStruct.Version;
      
      sl := TStringList.Create;
      sl.CommaText := ProjectStruct.Conditionals;
      Conditional.Items.BeginUpdate;
      Conditional.Items.Clear;
      Vista.ItemIndex := -1;
      CacheSource.State := cbGrayed;
      for i := 1 to sl.Count do
      begin
        with Conditional.Items.Add do
        begin
          Caption := Copy(sl[i -1], 1, AnsiPos('=', sl[i -1]) -1);
          SubItems.Add(Copy(sl[i -1], AnsiPos('=', sl[i -1]) +1, Length(sl[i -1])));
          if AnsiCompareText(Caption, 'UAC') = 0 then
          begin
            if AnsiCompareText(SubItems[0], 'asInvoker') = 0 then
              Vista.ItemIndex := 2
              else
              if AnsiCompareText(SubItems[0], 'requireAdministrator') = 0 then
                Vista.ItemIndex := 0
                else
                  Vista.ItemIndex := 1;
          end
          else
          if AnsiCompareText(Caption, 'CACHESOURCES') = 0 then
          begin
            if AnsiCompareText(SubItems[0], 'TRUE') = 0 then
              CacheSource.State := cbChecked
              else
              if AnsiCompareText(SubItems[0], 'FALSE') = 0 then
                CacheSource.State := cbUnchecked
                else
                  CacheSource.State := cbGrayed;
          end
        end;
      end;
      if Vista.ItemIndex = -1 then
        Vista.ItemIndex := 1; 
      Conditional.Items.EndUpdate;
      sl.Free;
      
      poSignAll.Checked := GetCompilerVariableBool('SIGN_ALL');
      if GetCompilerVariableBoolDefault('SIGN_ALL') then
        poSignAll.State := cbGrayed;
      IgnoreMissing.Checked := GetCompilerVariableBool('IGNOREMISSINGFILES');
      if AnsiCompareText(GetCompilerVariable('NOGUI'), 'TRUE') = 0 then
        Console.State := cbChecked
      else
      if AnsiCompareText(GetCompilerVariable('NOGUI'), 'FALSE') = 0 then
        Console.State := cbUnchecked
      else
      if AnsiCompareText(GetCompilerVariable('NOGUI'), 'AUTO') = 0 then
        Console.State := cbGrayed
      else
        {$IFDEF LINUX}
        Console.State := cbGrayed;
        {$ELSE}
        Console.State := cbUnchecked;
        {$ENDIF}
      if ShowModal = mrOk then
      begin
        
        StrCopy(ProjectStruct.CodeSignPassword, PChar(Password.Text));
        
        ProjectStruct.PassEnabled := Encrypt.Checked;
        StrCopy(ProjectStruct.Password, PChar(Key.Text));
        
        ProjectStruct.MultiLang :=LangEx.Checked;
        
        sl := TStringList.Create;
        for i := 1 to Conditional.Items.Count do
          sl.Add(Conditional.Items[i -1].Caption + '='
            + Conditional.Items[i -1].SubItems[0]);
        StrCopy(ProjectStruct.Conditionals, PChar(sl.CommaText));
        
        sl.Free;
        
        ProjectStruct.aSign := CodeSign.Checked;
        StrCopy(ProjectStruct.aCertificate, PChar(SPC.Text + '|' + TeamID.Text));
        StrCopy(ProjectStruct.aKey, PChar(PVK.Text + '|' + PFX.Text));
        StrCopy(ProjectStruct.aTimeStamp, PChar(TimeStamp.Text + '|' + AppleIDPassword.Text));
        StrCopy(ProjectStruct.aInfo, PChar(InfoURL.Text));
        
        if CD.Checked then BuildLayout := 0;
        if SFX.Checked then BuildLayout := 1;
        if Web.Checked then BuildLayout := 2;
        BuildDebug := Debug.Checked;
        StrCopy(CompressProfile, PChar(IntToStr(CompressBar.Position)));
        BuildInFolder := ProjectFolder.Checked;
        StrCopy(BuildCustomFolder, PChar(BuildFolder.Text));
        AutoIncrement := AutoUpdate.Checked;
        StrCopy(OutputFile, PChar(BuildFilename.Text));
        
        StrCopy(ProjectStruct.Manufacturer, PChar(Manufacturer.Text));
        StrCopy(ProjectStruct.Name, PChar(ProductName.Text));
        StrCopy(ProjectStruct.Code, PChar(ProductCode.Text));
        StrCopy(ProjectStruct.Revision, PChar(RevisionCode.Text));
        
        StrCopy(ProjectStruct.Language, PChar(Language.Text));
        StrCopy(ProjectStruct.Version, PChar(ProductVersion.Text));
        Project.SetSupport(SupportFiles);
        
        SetDirtyMpr(True);
        
        AdjustVisualUI;
        if s <> ProjectStruct.Name then
          AdjustUIProjectChanged;
      end;
    end;
end;

procedure Tui.FormClose(Sender: TObject; var CloseAction: TCloseAction);
var
  w: TWindowState;
begin
  if Running then MenuItem11Click(Self);
  
  w := WindowState;
  if (WindowState = wsMaximized) or (WindowState = wsMinimized) then
  begin
    
    SendMessage(Handle, LM_SYSCOMMAND, SC_RESTORE, 0);
    Application.ProcessMessages;
  end;
  SaveUISettings(w);
end;

procedure Tui.ActionsDblClick(Sender: TObject);
var
  i: Integer;
begin
  if Actions.ItemIndex = -1 then Exit;
  if Script.ItemIndex = -1 then i := 0
    else i := Script.ItemIndex;
  if RenderInsertScript(Actions.Items[Actions.ItemIndex], i, True)
    then
    begin
      
      Script.SetFocus;
      CodeComplete(Actions.Items[Actions.ItemIndex], i);
      ClearSelectionEx(Script);
      Script.ItemIndex := i;
      Script.Selected[i] := True;
    end
    else
    begin
      Script.SetFocus;
      ClearSelectionEx(Script);
      if Script.Items.Count > i then
      begin
        Script.ItemIndex := i;
        Script.Selected[i] := True;
      end;
    end;
end;

procedure Tui.Action144Click(Sender: TObject);
begin
  if VisualNotebook.ActivePage = 'WeblocksPage' then
    BuildSelClick(Self);
  if VisualNotebook.ActivePage = 'ShortcutsPage' then
    wodbcClick(Self);
  if VisualNotebook.ActivePage = 'AccessControlPage' then
    NewAccessClick(Self);
  if VisualNotebook.ActivePage = 'FileAssociationsPage' then
    NewAssocsClick(Self);
  if VisualNotebook.ActivePage = 'RunProgramsPage' then
    RunNewClick(Self);
  if VisualNotebook.ActivePage = 'INIFilesPage' then
    NewINIClick(Self);
  if VisualNotebook.ActivePage = 'LocalFilesPage' then
    NewLocalClick(Self);
  if VisualNotebook.ActivePage = 'VersionsPage' then
    AddVerClick(Self);
  if VisualNotebook.ActivePage = 'UpdatePacksPage' then
    NewPackClick(Self);
end;

procedure Tui.AccFilterClick(Sender: TObject);
begin
  AccFeatures.Enabled := True; 
  AccFeatures.Enabled := AccFilter.Checked;
  FeatureAwareAccPopulate;
end;

procedure Tui.AccFeaturesChange(Sender: TObject);
begin
  GetComponentPathFromComboCache := ''; 
  FeatureAwareAccPopulate;
end;

procedure Tui.StaticPropertyChange(Sender: TObject);
begin
  
  if OffTheHook > 0 then Exit;
  if Notebook.ActivePage <> 'Visual' Then Exit; 
  
  SetDirtyMpr(True);
  
  if VisualNotebook.PageIndex = VisualNotebook.Pages.IndexOf('ProjectPropertiesPage') then
  begin
    StrCopy(ProjectStruct.Name, PChar(ProductName.Text));
    
    StrCopy(ProjectStruct.Manufacturer, PChar(Manufacturer.Text));
    
    StrCopy(ProjectStruct.Version, PChar(ProductVersion.Text));
    
    StrCopy(ProjectStruct.Language, PChar(Language.Text));
    
    StrCopy(ProjectStruct.Code, PChar(ProductCode.Text));
    
    StrCopy(ProjectStruct.Revision, PChar(Revision.Text));
    
    ProjectStruct.MultiLang := MultiLangEx.Checked;
  end;
  
  if VisualNotebook.PageIndex = VisualNotebook.Pages.IndexOf('BuildSettingsPage') then
  begin
    if Debug.Checked then
      CD.Checked := True;
    if CD.Checked then ProjectStruct.BuildLayout := 0;
    if SFX.Checked then ProjectStruct.BuildLayout := 1;
    if Web.Checked then ProjectStruct.BuildLayout := 2;
    ProjectStruct.BuildDebug := Debug.Checked;
    ProjectStruct.BuildInFolder := ProjectFolder.Checked;
    StrCopy(ProjectStruct.BuildCustomFolder, PChar(BuildFolder.Text));
    
    StrCopy(ProjectStruct.OutputFile, PChar(BuildFilename.Text));
    
    BuildFolder.Enabled := CustomFolder.Checked;
    BuildFolderBrowse.Enabled := CustomFolder.Checked;
  end;
  
  if Sender = ProductName then
    AdjustUIProjectChanged;
end;

procedure Tui.MonitorURLChange(Sender: TObject);
var
  l: TStringList;
  i: Integer;
begin
  if OffTheHook > 0 then Exit;
  if Notebook.ActivePage <> 'Visual' Then Exit; 
  
  l := TStringList.Create;
  l.CommaText := ProjectStruct.Conditionals;
  for i := 1 to l.Count do
    if AnsiPos('UPDATE_SERVER=', l[i -1]) = 1 then 
    begin
      l[i -1] := 'UPDATE_SERVER=' + MonitorURL.Text; 
      Break;
    end
    else
      if i = l.Count then 
        l.Add('UPDATE_SERVER=' + MonitorURL.Text); 
  if l.Count = 0 then
    l.Add('UPDATE_SERVER=' + MonitorURL.Text); 
  StrCopy(ProjectStruct.Conditionals, PChar(l.CommaText));
  
  SetDirtyMpr(True);
  l.Free;
end;

procedure Tui.ParticularsChange(Sender: TObject);
var
  i,j: integer;
begin
  i := Particulars.ItemIndex;
  j := Integer(Particulars.ItemsEx[i].Data);
  DisplayLine(j, True);
end;

procedure Tui.ParticularsDropDown(Sender: TObject);
var
  s, sX: String;
  i, j, k: Integer;
  l: TStrings;
  lX: THashedStringList;
begin
  if Globals.ItemIndex = -1 then Exit;
  lX := THashedStringList.Create;
  lX.Sorted := True;
  lX.Duplicates := dupIgnore;
  Particulars.ItemsEx.Clear;
  s := Globals.ItemsEx[Globals.ItemIndex].Caption;
  j := Globals.ItemsEx[Globals.ItemIndex].ImageIndex;
  l := HashItems(s);
  for i := 1 to l.Count do
  begin
    sX := '';
    k := ScriptReferences.IndexOf(l[i -1]);
    if Globals.ItemsEx[Globals.ItemIndex].Caption = 'MSIcode Bookmarks' then
    begin
      
      sX := ScriptBuffer[ScriptReferences.IndexOf(l[i -1])];
    end;
    if Globals.ItemsEx[Globals.ItemIndex].Caption = 'Comments' then 
    begin
      sX := Comments[Comments.IndexOf(l[i -1]) +1];
      if sX <> '' then
        if AnsiPos(' ', sX) = 1 then
          sX := '';
    end;
    if Globals.ItemsEx[Globals.ItemIndex].Caption = SWebMediaBlocks then
    begin
      sX := MediaBlock[MediaBlock.IndexOf(l[i -1]) +1];
      if sX = '' then sX := SOffline;
    end;
    if Globals.ItemsEx[Globals.ItemIndex].Caption = 'Regions' then 
      if StrToBool(Region[Region.IndexOf(l[i -1]) +1]) then
        sX := Region[Region.IndexOf(l[i -1]) +2];
    if Globals.ItemsEx[Globals.ItemIndex].Caption = 'Labels' then 
      sX := eLabel[eLabel.IndexOf(l[i -1]) +1];
    if Globals.ItemsEx[Globals.ItemIndex].Caption = 'Apply Changes' then 
      if StrToBool(ApplyChanges[ApplyChanges.IndexOf(l[i -1]) +3]) then
        sX := SInstallProduct
      else
        if StrToBool(ApplyChanges[ApplyChanges.IndexOf(l[i -1]) +4]) then
          sX := SUninstallProduct
        else
          sX := SAdvertiseProduct;
    if Globals.ItemsEx[Globals.ItemIndex].Caption = 'Components' then 
      if CompareText(GetComponent[GetComponent.IndexOf(l[i -1]) +2], 'SELECTED') = 0 then 
        sX := GetComponent[GetComponent.IndexOf(l[i -1]) +1];
    if sX <> '' then
      
      lX.Add(StringReplace(sX, ';', '', [rfReplaceAll, rfIgnoreCase]) + ';' + IntToStr(k));
      
  end;
  for i := 1 to lX.Count do
  begin
    s := lX[i -1];
    sX := Copy(s, AnsiPos(';', s) +1, Length(s));
    Delete(s, AnsiPos(';', s), Length(s));
    Particulars.ItemsEx.AddItem(s, j, j, -1, 0, Pointer(StrToInt(sX)));
  end;
  lX.Free;
  Particulars.Font.Color := clWindowText;
end;

procedure Tui.ScriptKeyDown(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  {$IFDEF DARWIN}
  {$IFDEF CPUAARCH64}
  
  {$ENDIF}
  {$ENDIF}
end;

procedure Tui.ScriptKeyPress(Sender: TObject; var Key: char);
begin
  {$IFDEF DARWIN}
  {$IFDEF CPUAARCH64}
  
  {$ENDIF}
  {$ENDIF}
end;

procedure Tui.ScriptSelectionChange(Sender: TObject; User: boolean);
begin
  Script.SignalIndent := True;
end;

procedure Tui.SearchBoxChange(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  s := AnsiLowerCase(SearchBox.Text);
  Actions.Visible := s = '';
  ActionsEx.Visible := s <> '';
  
  try
    
    ActionsEx.Items.Clear;
    
    for i := 1 to Actions.Items.Count do
      if AnsiPos(s, AnsiLowerCase(Actions.Items[i -1])) <> 0 then
        ActionsEx.Items.Add(Actions.Items[i -1]);
  finally
    
  end;
end;

procedure Tui.SearchBoxKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key = 27 then
    SearchBox.Text := '';
end;

procedure Tui.SelectAllExClick(Sender: TObject);
var
  s: String;
  i, j: Integer;
begin
  if not InDesigner then Exit;
  
  i := Script.ItemIndex;
  s := ScriptTypes[i];
  for j := 1 to ScriptTypes.Count do 
    if ScriptTypes[j -1] = s then
      Script.Selected[j -1] := True;
  {$IFNDEF DARWIN}
  Script.ItemIndex := i;
  {$ENDIF}
end;

procedure Tui.Button3Click(Sender: TObject);
begin
  MenuItem46Click(Self); 
end;

procedure Tui.BitBtn5Click(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  try
    PushStatusStack('Loading document');
    if not OpenDialogText.Execute then Exit;
    if DisplayText.ItemIndex = 0 then
      s := 'license' 
    else
      s := 'readme'; 
    for i := SupportFiles.Count downto 1 do
      if ((AnsiCompareText(ExtractFileNameOnly(SupportFiles[i -1]), s) = 0) and
        (AnsiCompareText(ExtractFileExt(SupportFiles[i -1]), '.txt') = 0))
      then
        SupportFiles.Delete(i -1);
    s := s + '.txt';
    FileCopyFile(PChar(OpenDialogText.FileName), PChar(PROJDIR + s), false);
    SupportFiles.Add(s);
    RichEdit.Lines.LoadFromFile(PROJDIR + s);
    Project.SetSupport(SupportFiles);
    SetDirtyMPR(True);
    if AnsiCompareText(ExtractFileNameOnly(s), 'license') = 0 then 
      DisplayText.ItemIndex := 0
    else
      DisplayText.ItemIndex := 1;
    DisplayTextChange(Self);
  finally
    PopStatusStack;
  end;
end;

procedure Tui.ActionsExDblClick(Sender: TObject);
begin
  if ActionsEx.ItemIndex <> -1 then
    if ActionsEx.Items.Count <> 0 then
      if Actions.Items.IndexOf(ActionsEx.Items[ActionsEx.ItemIndex]) <> -1 then
      begin
        Actions.ItemIndex := Actions.Items.IndexOf(ActionsEx.Items[ActionsEx.ItemIndex]);
        ActionsDblClick(Self);
      end;
end;

procedure Tui.ActionsEndDrag(Sender, Target: TObject; X, Y: Integer);
begin
  DragAcceptEx := false;
end;

procedure Tui.ActionsExStartDrag(Sender: TObject; var DragObject: TDragObject);
var
  i: Integer;
begin
  
  DragAcceptEx := True;
  for i := 1 to ActionsEx.Items.Count do
    if ActionsEx.Selected[i -1] then
    begin
      DragAcceptCaption := ActionsEx.Items[i -1];
      Exit;
    end;
  DragAcceptEx := false;
  
end;

procedure Tui.BitBtn6Click(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  if DisplayText.ItemIndex = 0 then
    s := 'license' 
  else
    s := 'readme'; 
  for i := SupportFiles.Count downto 1 do
    if ((AnsiCompareText(ExtractFileNameOnly(SupportFiles[i -1]), s) = 0) and
      (AnsiCompareText(ExtractFileExt(SupportFiles[i -1]), '.txt') = 0))
    then
      SupportFiles.Delete(i -1);
  s := s + '.txt'; 
  SupportFiles.Add(s);
  RichEdit.Lines.SaveToFile(PROJDIR + s);
  Project.SetSupport(SupportFiles);
  SetDirtyMPR(True);
  if s = 'license.txt' then 
    DisplayText.ItemIndex := 0
  else
    DisplayText.ItemIndex := 1;
  DisplayTextChange(Self);
end;

procedure Tui.BitBtn7Click(Sender: TObject);
var
  s: String;
  i: Integer;
begin
  PushStatusStack('Removing document');
  if DisplayText.ItemIndex = 0 then
    s := 'license' 
  else
    s := 'readme'; 
  if Application.MessageBox(PChar(SAreYouSureYouWantToEraseThe + DisplayText.Text + SText),
    PChar(SClearText), mb_YesNo or mb_IconExclamation) = id_Yes then
    begin
      for i := SupportFiles.Count downto 1 do
        if ((AnsiCompareText(ExtractFileNameOnly(SupportFiles[i -1]), s) = 0) and
          (AnsiCompareText(ExtractFileExt(SupportFiles[i -1]), '.txt') = 0))
        then
          SupportFiles.Delete(i -1);
      RichEdit.Lines.Clear;
      Project.SetSupport(SupportFiles);
      SetDirtyMPR(True);
    end;
  if s = 'license' then 
    DisplayText.ItemIndex := 0
  else
    DisplayText.ItemIndex := 1;
  DisplayTextChange(Self);
  PopStatusStack;
end;

procedure Tui.BuildFolderBrowseClick(Sender: TObject);
var
  s: String;
begin
  PushStatusStack('Selecting build folder');
  if SelectDirectory(SBuildFolder, '', s) then
    BuildFolder.Text := AssertDir(s);
  PopStatusStack;
end;

procedure Tui.Button4Click(Sender: TObject);
begin
  ProductCode.Text := CreateGUIDUp;
end;

procedure Tui.Button5Click(Sender: TObject);
begin
  Revision.Text := CreateGUIDUp;
end;

procedure Tui.Button6Click(Sender: TObject);
begin
  try
    PushStatusStack('Loading project icon for Linux');
    if OpenIconLinux.Execute then
    begin
      try
        IconDisplayLinux.Picture.LoadFromFile(OpenIconLinux.FileName);
        IconDisplayLinux.Visible := True;
      except
        Application.MessageBox(PChar(SInvalidIconFilePleaseChooseANewI), PChar(Application.Title), mb_Ok + mb_IconStop);
        Exit;
      end;
      if SupportFiles.IndexOf('icon.png') = -1 then 
        SupportFiles.Add('icon.png'); 
      FileCopyFile(PChar(OpenIconLinux.FileName), PChar(PROJDIR + 'icon.png'), false); 
      Project.SetSupport(SupportFiles);
      
      SetDirtyMPR(True);
    end;
  finally
    PopStatusStack;
  end;
end;

procedure Tui.Button7Click(Sender: TObject);
begin
  try
    PushStatusStack('Loading project icon for macOS');
    if OpenIconmacOS.Execute then
    begin
      try
        IconDisplaymacOS.Picture.LoadFromFile(OpenIconmacOS.FileName);
        IconDisplaymacOS.Visible := True;
      except
        Application.MessageBox(PChar(SInvalidIconFilePleaseChooseANewI), PChar(Application.Title), mb_Ok + mb_IconStop);
        Exit;
      end;
      if SupportFiles.IndexOf('icon.icns') = -1 then 
        SupportFiles.Add('icon.icns'); 
      FileCopyFile(PChar(OpenIconmacOS.FileName), PChar(PROJDIR + 'icon.icns'), false); 
      Project.SetSupport(SupportFiles);
      
      SetDirtyMPR(True);
    end;
  finally
    PopStatusStack;
  end;
end;

procedure Tui.Button8Click(Sender: TObject);
begin
  try
    PushStatusStack('Loading project icon for Windows');
    if OpenIconWindows.Execute then
    begin
      try
        IconDisplayWindows.Picture.LoadFromFile(OpenIconWindows.FileName);
        IconDisplayWindows.Visible := True;
      except
        Application.MessageBox(PChar(SInvalidIconFilePleaseChooseANewI), PChar(Application.Title), mb_Ok + mb_IconStop);
        Exit;
      end;
      if SupportFiles.IndexOf('icon.ico') = -1 then 
        SupportFiles.Add('icon.ico'); 
      FileCopyFile(PChar(OpenIconWindows.FileName), PChar(PROJDIR + 'icon.ico'), false); 
      Project.SetSupport(SupportFiles);
      
      SetDirtyMPR(True);
    end;
  finally
    PopStatusStack;
  end;
end;

procedure Tui.CacheSourceChange(Sender: TObject);
var
  s, sX: String;
  i: Integer;
  b: Boolean;
  sl: TStringList;
begin
  b := false;
  case CacheSource.State of
    cbChecked: sX := 'TRUE';
    cbUnchecked: sX := 'FALSE';
    cbGrayed: sX := '';
  end;
  sl := TStringList.Create;
  sl.CommaText := ProjectStruct.Conditionals;
  for i := sl.Count downto 1 do
  begin
    s := Copy(sl[i -1], 1, AnsiPos('=', sl[i -1]) -1);
    if AnsiCompareText(s, 'CACHESOURCES') = 0 then
    begin
      sl[i -1] := s + '=' + sX;
      b := True;
      if sX = '' then
        sl.Delete(i -1);
      Break;
    end;
  end;
  if b = false then
    if sX <> '' then
      sl.Add('CACHESOURCES=' + sX);
  StrCopy(ProjectStruct.Conditionals, PChar(sl.CommaText));
  
  sl.Free;
  SetDirtyMpr(True);
end;

procedure Tui.ConsoleChange(Sender: TObject);
var
  s, sX: String;
  i: Integer;
  b: Boolean;
  sl: TStringList;
begin
  b := false;
  case Console.State of
    cbChecked: sX := 'TRUE';
    cbUnchecked: sX := 'FALSE';
    cbGrayed: sX := 'AUTO';
  end;
  sl := TStringList.Create;
  sl.CommaText := ProjectStruct.Conditionals;
  for i := sl.Count downto 1 do
  begin
    s := Copy(sl[i -1], 1, AnsiPos('=', sl[i -1]) -1);
    if AnsiCompareText(s, 'NOGUI') = 0 then
    begin
      sl[i -1] := s + '=' + sX;
      b := True;
      if sX = '' then
        sl.Delete(i -1);
      Break;
    end;
  end;
  if b = false then
    if sX <> '' then
      sl.Add('NOGUI=' + sX);
  StrCopy(ProjectStruct.Conditionals, PChar(sl.CommaText));
  
  sl.Free;
  SetDirtyMpr(True);
end;

procedure Tui.DisplayTextChange(Sender: TObject);
var
  i: Integer;
  s: String;
begin
  RichEdit.Lines.Clear;
  if DisplayText.ItemIndex = 0 then
    s := 'license.txt' 
  else
    s := 'readme.txt'; 
  for i := 1 to SupportFiles.Count do
    if AnsiCompareText(SupportFiles[i -1], s) = 0 then
    begin
      RichEdit.Lines.LoadFromFile(PROJDIR + s);
      Break;
    end;
end;

procedure Tui.ExTrapException(Sender: TObject; E: Exception);
begin
  
end;

function Tui.ExTrapHelp(Command: Word; Data: PtrInt; var CallHelp: Boolean
  ): Boolean;
var
  s: String;
begin
  s := PChar(Data);
  if AnsiPos('.htm', s) = 0 then
    s := s + '.htm';
  OpenURL('https://www.installaware.com/helpx.asp?topic=' + s);
  CallHelp := false;
end;

procedure Tui.FormResize(Sender: TObject);
begin
  
  Globals.Width := (NavPanelEx.Width -15) div 2;
  Particulars.Width := Globals.Width;
  Globals.Left := 5;
  Particulars.Left := Globals.Left + Globals.Width + 5;
end;

procedure Tui.GlobalsChange(Sender: TObject);
begin
  Particulars.Items.Clear;
end;

procedure Tui.Image2Click(Sender: TObject);
begin

end;

procedure Tui.Image3Click(Sender: TObject);
begin

end;

procedure Tui.Label16Click(Sender: TObject);
begin
  Application.HelpKeyword('classesofcommands.htm'); 
end;

procedure Tui.Label16MouseEnter(Sender: TObject);
begin
  Label16.Font.Color := clHighlight;
end;

procedure Tui.Label16MouseLeave(Sender: TObject);
begin
  Label16.Font.Color := clHotlight;
end;

procedure Tui.MenuItem70Click(Sender: TObject);
var
  i: Integer;
begin
  
  if not SafeRunState then Exit;
  if InDesigner then
  begin
    if Script.ItemIndex = -1 then Exit;
    i := GetRealLineNumber(Script.ItemIndex);
    if IsLineCodeFolding(i) then ProcessCodeFolding(i);
  end;
end;

procedure Tui.AccessChange(Sender: TObject; Item: TListItem; Change: TItemChange
  );
begin
  EditAccess.Enabled := Access.SelCount = 1;
  DeleteAccess.Enabled := Access.SelCount >= 1;
end;

procedure Tui.AccessDblClick(Sender: TObject);
begin
  if Access.Selected <> nil then
    EditAccessClick(Self);
end;

procedure Tui.AccessKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    AccessDblClick(Self);
end;

procedure Tui.AccessKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 45 then
    if NewAccess.Enabled then
      NewAccessClick(Self);
  if Key = 46 then
    if DeleteAccess.Enabled then
      DeleteAccessClick(Self);
end;

procedure Tui.AccessMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  AccessChange(Self, nil, ctState);
end;

procedure Tui.Action145Click(Sender: TObject);
begin
  if VisualNotebook.ActivePage = 'WeblocksPage' then
    EditWebBlockClick(Self);
  if VisualNotebook.ActivePage = 'ShortcutsPage' then
    EditShortcutClick(Self);
  if VisualNotebook.ActivePage = 'AccessControlPage' then
    EditAccessClick(Self);
  if VisualNotebook.ActivePage = 'FileAssociationsPage' then
    EditAssocsClick(Self);
  if VisualNotebook.ActivePage = 'RunProgramsPage' then
    RunEditClick(Self);
  if VisualNotebook.ActivePage = 'INIFilesPage' then
    EditINIsClick(Self);
  if VisualNotebook.ActivePage = 'LocalFilesPage' then
    EditLocalClick(Self);
  if VisualNotebook.ActivePage = 'UpdatePacksPage' then
    EditPackClick(Self);
end;

procedure Tui.Action146Click(Sender: TObject);
begin
  if VisualNotebook.ActivePage = 'WeblocksPage' then
    SkipSelClick(Self);
  if VisualNotebook.ActivePage = 'ShortcutsPage' then
    DeleteShortcutClick(Self);
  if VisualNotebook.ActivePage = 'AccessControlPage' then
    DeleteAccessClick(Self);
  if VisualNotebook.ActivePage = 'FileAssociationsPage' then
    DeleteAssocsClick(Self);
  if VisualNotebook.ActivePage = 'RunProgramsPage' then
    RunDeleteClick(Self);
  if VisualNotebook.ActivePage = 'INIFilesPage' then
    DeleteINIClick(Self);
  if VisualNotebook.ActivePage = 'LocalFilesPage' then
    DeleteLocalClick(Self);
  if VisualNotebook.ActivePage = 'VersionsPage' then
    RemoveVerClick(Self);
  if VisualNotebook.ActivePage = 'UpdatePacksPage' then
    DeletePackClick(Self);
end;

procedure Tui.ActionsStartDrag(Sender: TObject; var DragObject: TDragObject);
var
  i: Integer;
begin
  
  DragAcceptEx := True;
  for i := 1 to Actions.Items.Count do
    if Actions.Selected[i -1] then
    begin
      DragAcceptCaption := Actions.Items[i -1];
      Exit;
    end;
  DragAcceptEx := false;
  
end;

procedure Tui.AddFiles1Click(Sender: TObject);
begin
  if FilesAddDialog.Execute then
    AddNewFiles(FilesAddDialog.Files);
end;

procedure Tui.AddNewFolder1Click(Sender: TObject);
var
  s: String;
begin
  if SelectDirectory(SAddNewFolder, '', s) then
    AddNewFolder(s);
end;

procedure Tui.AddVerClick(Sender: TObject);
var
  s: String;
  i: Integer;
  tif: TIniFile;
begin
  try
    PushStatusStack('Defining version');
    if CurrentProjectName = '' then
    begin
      Application.MessageBox(PChar(SPleaseSaveYourProjectBeforeDefin_1),
        PChar(Application.Title), mb_Ok + mb_IconStop);
      Exit;
    end;
    if InputQuery(SNewApplicationVersion, SVersion, s) then
    begin
      
      if s = '' then
      begin
        Application.MessageBox(PChar(SPleaseEnterAVersionNumberVersion),
          PChar(Application.Title), mb_Ok + mb_IconStop);
        Exit;
      end;
      
      for i := 1 to Versions.Items.Count do
        if CompareText(Versions.Items[i -1], s) = 0 then
        begin
          Application.MessageBox(PChar(SThisVersionNumberHasAlreadyBeenD),
            PChar(Application.Title), mb_Ok + mb_IconStop);
          Exit;
        end;
      tif := TIniFile.Create(PROJDIR + 'updates.ini'); 
      tif.WriteString(SUpdatePacksForVersions, s, '');
      Versions.Items.Add(s);
      Versions.ItemIndex := Versions.Items.IndexOf(s);
      VersionsClick(Self);
      tif.Free;
      
      if SupportFiles.IndexOf('updates.ini') = -1 then 
      begin
        SupportFiles.Add('updates.ini'); 
        Project.SetSupport(SupportFiles);
        SetDirtyMpr(True);
      end;
    end;
  finally
    PopStatusStack;
  end;
end;

procedure Tui.AssnFeaturesChange(Sender: TObject);
begin
  GetComponentPathFromComboCache := ''; 
  FeatureAwareAssnPopulate;
end;

procedure Tui.AssnFilterClick(Sender: TObject);
begin
  AssnFeatures.Enabled := True; 
  AssnFeatures.Enabled := AssnFilter.Checked;
  FeatureAwareAssnPopulate;
end;

procedure Tui.AssocsChange(Sender: TObject; Item: TListItem; Change: TItemChange
  );
begin
  EditAssocs.Enabled := Assocs.SelCount = 1;
  DeleteAssocs.Enabled := Assocs.SelCount >= 1;
  FileTypeType.Enabled := DeleteAssocs.Enabled;
end;

procedure Tui.AssocsDblClick(Sender: TObject);
begin
  if Assocs.Selected <> nil then
    EditAssocsClick(Self);
end;

procedure Tui.AssocsKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    AssocsDblClick(Self);
end;

procedure Tui.AssocsKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 45 then
    if NewAssocs.Enabled then
      
      Define1Click(Self);
  if Key = 46 then
    if DeleteAssocs.Enabled then
      DeleteAssocsClick(Self);
end;

procedure Tui.AssocsMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
  AssocsChange(Self, nil, ctState);
end;

procedure Tui.BitBtn10Click(Sender: TObject);
begin
  MenuItem46Click(Self); 
end;

procedure Tui.BitBtn1Click(Sender: TObject);
var
  n, m: TTreeNode;
  b: Boolean;
  i, j: Integer;
begin
  try
    PushStatusStack('Adding folder');
    
    b := AddNewFolder(ShellTree.Path);
    
    if b then
    begin
      repeat
        n := nil;
        while n = nil do
        begin
          for i := 1 to Folders.Items[0].Count do
          begin
            if CompareText('$TARGETDIR$', Folders.Items[0].Items[i -1].Text) = 0 then 
            begin
              n := Folders.Items[0].Items[i -1];
              
              for j := 1 to n.Count do
                if CompareText(ExtractFileName(ShellTree.Path),
                  n[j -1].Text) = 0 then
                begin
                  n := nil;
                  CategoriesButtonClicked(Self);
                  Exit;
                end;
              
              Break;
            end;
            if i = Folders.Items[0].Count then
              CategoriesButtonClicked(Self);
          end;
        end;
        if n.Count = 0 then
          CategoriesButtonClicked(Self);
      until n.Count <> 0;
      m := nil;
      while m = nil do
      begin
        for i := 1 to n.Count do
        begin
          if CompareText(ExtractFileName(DeAssertDir(ShellTree.Path)),
            n.Items[i -1].Text) = 0 then
            begin
              m := n.Items[i -1];
              Break;
            end;
          if i = n.Count then
          begin
            CategoriesButtonClicked(Self);
            n := nil;
            while n = nil do
            begin
              for j := 1 to Folders.Items[0].Count do
              begin
                if CompareText('$TARGETDIR$', Folders.Items[0].Items[j -1].Text) = 0 then 
                begin
                  n := Folders.Items[0].Items[j -1];
                  Break;
                end;
                if j = Folders.Items[0].Count then
                  CategoriesButtonClicked(Self);
              end;
            end;
          end;
        end;
      end;
      Folders.Selected := m;
    end;
  finally
    PopStatusStack;
  end;
end;

procedure Tui.BitBtn2Click(Sender: TObject);
var
  s: String;
  b: Boolean;
  i: Integer;
  n: TTreeNode;
  l: TStringList;

begin
  try
    PushStatusStack('Adding files');
    s := AssertDir(ShellTree.Path);
    l := TStringList.Create;
    for i := 1 to ShellList.Items.Count do
      if ShellList.Items[i -1].Selected then
        l.Add(s + ShellList.Items[i -1].Caption);
    b := AddNewFiles(l);
    l.Free;
    
    if b then
    begin
      for i := 1 to Folders.Selected.Count do
      begin
        if CompareText('$TARGETDIR$', Folders.Selected.Items[i -1].Text) = 0 then 
        begin
          Folders.Selected := Folders.Selected.Items[i -1];
          Break;
        end;
        if i = Folders.Selected.Count then
          CategoriesButtonClicked(Self);
      end;
      if Folders.Selected.Count = 0 then
        CategoriesButtonClicked(Self);
    end;
    
    if Folders.Selected.Parent = nil then
    begin
      n := Folders.Selected;
      FoldersChange(Self, n);
      for i := 1 to Folders.Selected.Count do
      begin
        if CompareText('$TARGETDIR$', Folders.Selected.Items[i -1].Text) = 0 then 
        begin
          Folders.Selected := Folders.Selected.Items[i -1];
          Break;
        end;
      end;
    end;
  finally
    PopStatusStack;
  end;
end;

procedure Tui.BitBtn8Click(Sender: TObject);
begin
  if ChangeTheme.ShowModal = mrOk then
    DialogsListExClick(Self);
end;

procedure Tui.Build1Click(Sender: TObject);
var
  i, j: Integer;
  s: String;
  l: TList;
  escondido, escondidoX: String;
begin
  if not SafeRunState then Exit;
  try
    PushStatusStack('Building project');
    i := PreCompileScript(s, false);
    if i = MAXINT -1 then 
    begin
      Exit;
    end;
    if i <> -1 then Compile1Click(Self)
      else
      begin
        if ProjectStruct.AutoIncrement then
        begin
          
          StrCopy(ProjectStruct.Revision, PChar(CreateGUIDUp));
          
          SetDirtyMpr(True);
          
        end;
        
        try
          escondido := ProjectStruct.Conditionals;
          escondidoX := ProjectStruct.Conditionals;
          SetMakeContext(axGlobalLists, axScriptTypes, axScriptReferences,
            axScriptComments, escondidoX, l, s,
            ProjectStruct.BuildLayout, ProjectStruct.Language, ProjectStruct.Name,
            ProjectStruct.aSign);
          StrCopy(ProjectStruct.Conditionals, PChar(escondidoX));
          thCurrentProjectName := CurrentProjectName;
          thProjectStruct := ProjectStruct;
          thScriptTypes := axScriptTypes;
          thScriptReferences := axScriptReferences;
          thScriptComments := axScriptComments;
          thScriptFetches := axScriptFetches;
          thProhibitedScriptFetches := ProhibitedScriptFetches;
          thDialogFiles := DialogFiles;
          thSupportFiles := SupportFiles;
          thIncludeFiles := IncludeFiles;
          thGlobalLists := l;
          thGlobal := THashedStringList.Create;
          for i := 1 to l.Count do
            for j := 1 to TStringList(l[i -1]).Count do
              thGlobal.Add(TStringList(l[i -1])[j -1]);
          
          Build.ShowModal;
          
          thGlobal.Free;
        finally
          SetEditContext(l, axScriptTypes);
          StrCopy(ProjectStruct.Conditionals, PChar(escondido));
          
          FreeAxContext;
          
        end;
      end;
  finally
    PopStatusStack;
  end;
end;

procedure Tui.BuildSelClick(Sender: TObject);
var
  i: Integer;
  hDef: THandle;
begin
  PushStatusStack('Building selected Web Media Block(s)');
  hDef := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    for i := 1 to WebBlocks.Items.Count do
      if WebBlocks.Items[i -1].Selected then
      begin
        
        SetMediaBlockSkipEx(WebBlocks.Items[i -1].SubItems[3], false);
        WebBlocks.Items[i -1].SubItems[2] := SBuild;
      end;
  finally
    Screen.Cursor := hDef;
    PopStatusStack;
  end;
end;

procedure Tui.Button1Click(Sender: TObject);
begin
  if not SafeRunState then Exit;
  NewProject.ShowModal;
end;

procedure Tui.Button2Click(Sender: TObject);
begin
  try
    PushStatusStack('Opening project');
    if not SafeRunState then Exit;
    if not IsSafeToCloseProject then Exit;
    if (Existing.ItemIndex = -1) or (Existing.ItemIndex = Existing.Items.Count -1) then
    begin
      MenuItem5Click(Self);
      Exit;
    end;
    MRUF.Move(MRUF.IndexOf(Existing.GetSelectedText), 0);
    MRUF.SaveToFile(EXEDIR + 'mruf.txt', TEncoding.UTF8); 
    OpenMRUF(Existing.GetSelectedText);
  finally
    PopStatusStack;
  end;
end;

procedure Tui.CommandCountsColumnClick(Sender: TObject; Column: TListColumn);
begin
  PhatAnalyticsFirstColumn := Column.Index = 0;
  CommandCounts.AlphaSort;
end;

procedure Tui.CommandCountsCompare(Sender: TObject; Item1, Item2: TListItem;
  Data: Integer; var Compare: Integer);
begin
  if PhatAnalyticsFirstColumn then
    Compare := AnsiCompareText(Item1.Caption, Item2.Caption)
  else
    Compare := StrToInt(Item1.SubItems[0]) - StrToInt(Item2.SubItems[0]);
end;

procedure Tui.CommandCountsSelectItem(Sender: TObject; Item: TListItem;
  Selected: Boolean);
var
  i: Integer;
  s, sX: String;
  li: TListItem;
  h: TCursor;
  hDef: TCursor;
begin
  hDef := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    PushStatusStack('Analyzing ' + Item.Caption + ' commands');
    if Selected then
    begin
      CommandListing.Items.BeginUpdate;
      CommandListing.Items.Clear;
      s := Item.Caption;
      for i := 1 to ScriptTypes.Count do
        if AnsiCompareText(ScriptTypes[i -1], s) = 0 then
        begin
          sX := ScriptReferences[i -1];
          li := CommandListing.Items.Add;
          li.Caption := RenderFunction(s, sX);
          li.SubItems.Add(sX);
        end;
      CommandListing.Items.EndUpdate;
    end
    else
    begin
      CommandListing.Items.BeginUpdate;
      CommandListing.Items.Clear;
      CommandListing.Items.EndUpdate;
    end;
  finally
    PopStatusStack;
    Screen.Cursor := hDef;
  end;
end;

procedure Tui.CommandListingDblClick(Sender: TObject);
begin
  if CommandListing.Selected <> nil then
  begin
    PushStatusStack('Editing ' + CommandCounts.Selected.Caption);
    
    if EditFunction(CommandCounts.Selected.Caption,
      CommandListing.Selected.SubItems[0]) then
      begin
        CommandListing.Selected.Caption :=
          RenderFunction(CommandCounts.Selected.Caption,
            CommandListing.Selected.SubItems[0]);
        SetDirtyMIA(True, '');
        RenderUpdateScriptEx(GetScriptSmartPosition(
          CommandListing.Selected.SubItems[0]), false);
        
      end;
    PopStatusStack;
  end;
end;

procedure Tui.ComponentisSelected1Click(Sender: TObject);
begin
  SetDefaultComponentSelectionState(GetComponentPathFromTree(Features.Selected),
    True);
  Features.Selected.ImageIndex := 1;
  Features.Selected.SelectedIndex := 1;
end;

procedure Tui.Copy1Click(Sender: TObject);
var
  l: TStringList;
  i, j: Integer;
  s: String;
begin
  if not SafeRunState then Exit;
  if not InDesigner then Exit;
  try
    PushStatusStack('Copying selection');
    OpaqueClipboard.Clear;
    for i := Script.Items.Count downto 1 do
      if Script.Selected[i -1] then
      begin
        l := GetAllRealLines(i -1);
        for j := l.Count downto 1 do
        begin
          OpaqueClipboard.Add(ScriptTypes[StrToInt(l[j -1])]);
          OpaqueClipboard.Add(ScriptReferences[StrToInt(l[j -1])]);
          RenderFunctionToClipboard(ScriptTypes[StrToInt(l[j -1])],
            ScriptReferences[StrToInt(l[j -1])], OpaqueClipboard);
        end;
      end;
    if OpaqueClipboard.Count = 0 then
      Exit;

    OpaqueClipboard.Insert(0, Brand + ' Clipboard Data'); 
    s := '';
    for i := 1 to OpaqueClipboard.Count do
      s := s + '~' + OpaqueClipboard[i -1] + '~' + LineEnding;
    Clipboard.SetFormat(CF_TEXT, nil);
    Clipboard.SetTextBuf(PChar(s));
  finally
    PopStatusStack;
  end;
end;

procedure Tui.CurrentUnitChange(Sender: TObject);
begin
  CurrentUnitChangeEx(false);
end;

procedure Tui.Define1Click(Sender: TObject);
begin
  if RenderInsertScript('Create File Type',
    GetInsertionIndexBeforeApplyChangesWithFeatureSupport(GetComponentPathFromCombo(AssnFeatures), AssnFilter.Checked),
    GetLineVisibilityState(
      GetInsertionIndexBeforeApplyChangesWithFeatureSupport(GetComponentPathFromCombo(AssnFeatures), AssnFilter.Checked),
    false), True) then
  begin
    try
      Script.ItemIndex := GetFoldedLineNumber(
        GetInsertionIndexBeforeApplyChangesWithFeatureSupport(GetComponentPathFromCombo(AssnFeatures), AssnFilter.Checked));
    except
    end;
    AdjustVisualUI;
  end;
end;

procedure Tui.Delete1Click(Sender: TObject);
var
  i, iX: Integer;
  Undoable: Boolean;
  l, lX, lY: TStringList;
  s: String;
  j: Integer;
  SmartPosition: Integer;
begin
  Undoable := false;
  if not SafeRunState then Exit;
  if not InDesigner then Exit;
  try
    PushStatusStack('Deleting selection');
    iX := Script.ItemIndex +1;
    for i := 1 to Script.Items.Count do
      if Script.Selected[i -1] then iX := iX -1;
    if iX < 0 then iX := 0;
    if InDesigner then
      Undoable := True;
    if Undoable then
    begin
      l := TStringList.Create;
      lY := TStringList.Create;
    end;
    for i := Script.Items.Count downto 1 do
      if Script.Selected[i -1] then
      begin
        
        SetDirtyMia(True, '');
        if Undoable then
        begin
          lX := GetAllRealLines(i -1);
          for j := lX.Count downto 1 do
          begin
            SmartPosition := StrToInt(lX[j -1]);
            l.Add(IntToStr(SmartPosition));
            l.Add(ScriptTypes[SmartPosition]);
            l.Add(ScriptReferences[SmartPosition]);
            l.Add(GetFunctionDataForStack(ScriptTypes[SmartPosition], ScriptReferences[SmartPosition]));
            
            lY.Add(l.CommaText);
            l.Clear;
          end;
          lX.Free;
        end;
        RenderDeleteScriptEx(i -1, false);
      end;
    if Undoable then
    begin
      
      AddStackItem(UndoStack, 'Delete', lY.CommaText);
      ClearStack(RedoStack);
      lY.Free;
      l.Free;
    end;
    RehashIndents;
    if Script.Items.Count <> 0 then
    begin
      Script.ItemIndex := iX;
      Script.Selected[Script.ItemIndex] := True;
    end;
    Script.Repaint;
  finally
    PopStatusStack;
  end;
end;

procedure Tui.DeleteAccessClick(Sender: TObject);
var
  i: Integer;
begin
  for i := Access.Items.Count downto 1 do
    if Access.Items[i -1].Selected then
    begin
      RenderDeleteScriptEx(
        GetScriptSmartPosition(Access.Items[i -1].SubItems[3]), True);
      Access.Items[i -1].Delete;
    end;
  RehashIndents;
  
  AccessChange(Self, nil, ctState);
end;

procedure Tui.DeleteAssocsClick(Sender: TObject);
var
  i: Integer;
begin
  for i := Assocs.Items.Count downto 1 do
    if Assocs.Items[i -1].Selected then
    begin
      RenderDeleteScriptEx(
        GetScriptSmartPosition(Assocs.Items[i -1].SubItems[4]), True);
      Assocs.Items[i -1].Delete;
    end;
  RehashIndents;
  
  AssocsChange(Self, nil, ctState);
end;

procedure Tui.DeleteFeatureClick(Sender: TObject);
var
  i, j, k: Integer;
  BaseString: String;
  l, lX, lY: TStringList;
begin
  l := TStringList.Create;
  lX := TStringList.Create;
  lY := TStringList.Create;
  BaseString := GetComponentPathFromTree(Features.Selected);
  l.Add(BaseString); 
  BaseString := BaseString + '\';
  for i := 1 to Features.Items.Count do
    if AnsiPos(BaseString, GetComponentPathFromTree(Features.Items[i -1])) = 1 then
      l.Add(GetComponentPathFromTree(Features.Items[i -1])); 
  
  lX.AddObject('1,4', DefComponent); 
  lX.AddObject('1,3', SetComponent); 
  lX.AddObject('1,3', GetComponent); 
  for i := 1 to l.Count do
    for j := 1 to lX.Count do
    begin
      lY.CommaText := lX[j -1];
      repeat
        try
          k := FindIndexOfStringAtOffset(TStringList(lX.Objects[j -1]), StrToInt(lY[0]),
            StrToInt(lY[1]), l[i -1]);
        except
          k := -1;
        end;
        if k <> -1 then
          RenderDeleteScriptEx(GetScriptSmartPosition(
            GetStringAtListIndexOffSet(TStringList(lX.Objects[j -1]), k, 0)), True);
      until k = -1;
    end;
  
  RehashIndents;
  lY.Free;
  lX.Free;
  l.Free;
  Features.Selected.Delete;
end;

procedure Tui.DeleteFiles1Click(Sender: TObject);
var
  i: Integer;
  SourcePath, TargetFolder, GUID: String;
  l: TStrings;
begin
  
  Files.Items.BeginUpdate;
  for i := Files.Items.Count downto 1 do
    if Files.Items[i -1].Selected then
    begin
      SourcePath := AssertDir(Files.Items[i -1].SubItems[0]) + Files.Items[i -1].Caption;
      TargetFolder := AssertDir(GetFolderPathFromTree(Folders.Selected));
      GUID := 
        Files.Items[i -1].SubItems[1];
      RenderDeleteScriptEx(ScriptReferences.IndexOf(GUID), True);
      Files.Items[i -1].Delete;
    end;
  if AllowFileRehash then
    RehashIndents;
  Files.Items.EndUpdate;
  
  if Files.Items.Count = 0 then
    if IsSafeToDeleteFileViewFolderNode(Folders.Selected, false) then
      Folders.Selected.Delete;
    
end;

procedure Tui.DeleteINIClick(Sender: TObject);
var
  i: Integer;
  hDef: TCursor;
begin
  hDef := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    INI.Items.BeginUpdate;
    for i := INI.Items.Count downto 1 do
      if INI.Items[i -1].Selected then
      begin
        RenderDeleteScriptEx(
          GetScriptSmartPosition(INI.Items[i -1].SubItems[3]), True);
        INI.Items[i -1].Delete;
      end;
    RehashIndents;
    INI.Items.EndUpdate;
  finally
    Screen.Cursor := hDef;
  end;
  
  INIChange(Self, nil, ctState);
end;

procedure Tui.DeleteLocalClick(Sender: TObject);
var
  i: Integer;
  hDef: TCursor;
begin
  hDef := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    Local.Items.BeginUpdate;
    for i := Local.Items.Count downto 1 do
      if Local.Items[i -1].Selected then
      begin
        RenderDeleteScriptEx(
          GetScriptSmartPosition(Local.Items[i -1].SubItems[1]), True);
        Local.Items[i -1].Delete;
      end;
    RehashIndents;
    Local.Items.EndUpdate;
  finally
    Screen.Cursor := hDef;
  end;
  
  LocalChange(Self, nil, ctState);
end;

procedure Tui.DeletePackClick(Sender: TObject);
var
  i: Integer;
  tif: TIniFile;
begin
  if Application.MessageBox(PChar(SAreYouSureYouWantToDeleteSelecte),
    PChar(Application.Title), mb_YesNo + mb_IconQuestion) = id_No then Exit;
  for i := Packs.Items.Count downto 1 do
    if Packs.Items[i -1].Selected then
    begin
      tif := TIniFile.Create(PROJDIR + 'updates.ini'); 
      tif.EraseSection(Packs.Items[i -1].Caption);
      tif.Free;
      Packs.Items[i -1].Delete;
    end;
  
  PacksChange(Self, nil, ctState);
end;

procedure Tui.DeleteShortcutClick(Sender: TObject);
var
  i: Integer;
begin
  for i := Shortcuts.Items.Count downto 1 do
    if Shortcuts.Items[i -1].Selected then
    begin
      RenderDeleteScriptEx(
        GetScriptSmartPosition(Shortcuts.Items[i -1].SubItems[5]), True);
      Shortcuts.Items[i -1].Delete;
    end;
  RehashIndents;
  
  ShortcutsChange(Self, nil, ctState);
end;

procedure Tui.DialogsListExClick(Sender: TObject);

begin
  
  SpoolTimerTimer(Self);
  
end;

procedure Tui.DialogsListExClickCheck(Sender: TObject);
begin
  if DialogsListEx.Checked[DialogsListEx.ItemIndex] then
    ScriptComments[StrToInt(DialogsList[DialogsListEx.ItemIndex])] := ''
      else ScriptComments[StrToInt(DialogsList[DialogsListEx.ItemIndex])] := 'C';
  RenderLine(StrToInt(DialogsList[DialogsListEx.ItemIndex]), false);
  SetDirtyMia(True, '');
end;

procedure Tui.DialogsListExDblClick(Sender: TObject);
begin
  if DialogsListEx.ItemIndex <> -1 then
    EditDialogBtnClick(Self);
end;

procedure Tui.DialogsListExKeyPress(Sender: TObject; var Key: char);
begin
  if Key = #13 then
    DialogsListExDblClick(Self);
end;

procedure Tui.DisplaySystemFolder1Click(Sender: TObject);
var
  s: String;
  i: Integer;
  l: TStringList;
begin
  
  i := GetSmartPositionInClass('Get Folder Location', false); 
  if i = 0 then
  begin
    Application.MessageBox(PChar(SSomeNecessaryCommandsCouldNotBeL
      + MyLineEnding + MyLineEnding + SToAvoidSeeingThisMessageCreateNe_2),
      PChar(Application.Title), mb_Ok + mb_IconStop);
    Exit;
  end;
  if DisplaySystemFolder.ShowModal = mrOk then
  begin
    l := TStringList.Create;
    case DisplaySystemFolder.Folder.ItemIndex of
      
      0: s := 'INETCACHE'; 
      
      1: s := 'INETCOOKIES'; 
      
      2: s := 'DOCUMENTS'; 
      
      3: s := 'FAVORITES'; 
      
      4: s := 'MUSIC'; 
      
      5: s := 'PICTURES'; 
      
      6: s := 'VIDEOS'; 
      
      7: s := 'NETHOOD'; 
      
      8: s := 'PRINTHOOD'; 
      
      9: s := 'BOOTPATH'; 
      
      10: s := 'CDPATH'; 
      
      11: s := 'STARTADMIN'; 
      
      12: s := 'STARTMENU'; 
      
      13: s := 'STARTUP'; 
      
      14: s := 'PROGRAMS'; 
      
      15: s := 'APPDATA'; 
      
      16: s := 'CDBURN'; 
      
      17: s := 'DESKTOP'; 
      
      18: s := 'FONTS'; 
      
      19: s := 'PROFILES'; 
      
      20: s := 'PROGRAMFILES'; 
      
      21: s := 'RECENTFILES'; 
      
      22: s := 'SENDTO'; 
      
      23: s := 'WINSYSDIR'; 
      
      24: s := 'TEMPLATES'; 
      
      25: s := 'WINDIR'; 
      
      26: s := 'QUICKLAUNCHDIR'; 
      
      27: s := 'WWWROOTDIR'; 
      
      28: s := 'LOCALAPPDATA'; 
      
      29: s := 'DOWNLOADS'; 
    end;
    
    if DisplaySystemFolder.AllUsers.Checked then
      s := 'ALL' + s 
    else
      s := 'MY' + s; 
    l.Add(s);
    l.Add(IntToStr(DisplaySystemFolder.Folder.ItemIndex));
    if DisplaySystemFolder.AllUsers.Checked then
      l.Add('TRUE') 
    else
      l.Add('FALSE'); 
    RenderInsertScriptEx('Get Folder Location', GetFolderLocation, l, 
      i, GetLineVisibilityState(i, false));
    l.Free;
    
    RehashIndents;
    CategoriesButtonClicked(Self);
  end;
end;

procedure Tui.EditAccessClick(Sender: TObject);
var
  i: Integer;
begin
  if RenderUpdateScript(
    GetScriptSmartPosition(Access.Selected.SubItems[3]), false) then
  begin
    
    FeatureAwareAccPopulate(Access.Selected);
  end;
end;

procedure Tui.EditAction1Click(Sender: TObject);
var
  i: Integer;
begin
  if not SafeRunState then Exit;
  if InDesigner then
  begin
    if Script.ItemIndex = -1 then Exit;
    RenderUpdateScript(Script.ItemIndex);
  end
  else
  begin
    if (ui.ActiveControl <> Actions) and (ui.ActiveControl <> ActionsEx) then Exit;
    if Screen.ActiveForm <> ui then Exit;
    if ActionsEx.Visible then
      ActionsExDblClick(Self)
    else
      ActionsDblClick(Self);
  end;
end;

procedure Tui.EditAssocsClick(Sender: TObject);
var
  i: Integer;
begin
  if RenderUpdateScript(
        GetScriptSmartPosition(Assocs.Selected.SubItems[4]), false) then
  begin
    
    FeatureAwareAssnPopulate(Assocs.Selected);
  end;
end;

procedure Tui.EditDialogBtnClick(Sender: TObject);
var
  sl: TStringList;
begin
  if EditDialogBtn.Enabled = false then Exit; 
  sl := TStringList.Create;
  sl.Add(PROJDIR + DialogsListEx.Items[DialogsListEx.ItemIndex] + '.lfm');
  {$IFDEF WINDOWS}
  if MyFileExists(EXEDIR + 'miauix.exe') then 
    LaunchAppAndWait2(EXEDIR + 'miauix.exe', sl, True, false)
  {$ELSE}
  {$IFDEF DARWIN}
  if MyFileExists(EXEDIR + 'miauix.app/Contents/MacOS/miauix') then 
    LaunchAppAndWait2(EXEDIR + 'miauix.app/Contents/MacOS/miauix', sl, True, false)
  {$ELSE}
  if MyFileExists(EXEDIR + 'miauix') then 
    LaunchAppAndWait2(EXEDIR + 'miauix', sl, True, false)
  {$ENDIF}
  {$ENDIF}
  else
    Application.MessageBox(PChar(STheDialogEditorHasNotBeenInstall),
      PChar(Application.Title), mb_Ok + mb_IconStop);
  sl.Free;
end;

procedure Tui.EditINIsClick(Sender: TObject);
var
  i: Integer;
begin
  if RenderUpdateScript(
        GetScriptSmartPosition(INI.Selected.SubItems[3]), false) then
  begin
    
    FeatureAwareINIPopulate(INI.Selected);
  end;
end;

procedure Tui.EditLocalClick(Sender: TObject);
var
  i: Integer;
begin
  if RenderUpdateScript(
        GetScriptSmartPosition(Local.Selected.SubItems[1]), false) then
  begin
    
    FeatureAwareLocalPopulate(Local.Selected);
  end;
end;

procedure Tui.EditPackClick(Sender: TObject);
var
  tif: TIniFile;
begin
  with UpdatePack do
  begin
    PackName.Enabled := false;
    PackName.Text := Packs.Selected.Caption;
    DownloadURL.Text := Packs.Selected.SubItems[0];
    Description.Lines.Text := SingleLineToMultiLine(Packs.Selected.SubItems[1]);
    
    Reboot.Checked := ytm_SmartPos('Yes', Packs.Selected.SubItems[2], false) <> 0; 
    Silent.Checked := ytm_SmartPos('No', Packs.Selected.SubItems[3], false) = 0; 
    
    Parameters.Text := Packs.Selected.SubItems[4];
    if ShowModal = mrOk then
    begin
      
      tif := TIniFile.Create(PROJDIR + 'updates.ini'); 
      tif.WriteString(PackName.Text, 'URL', DownloadURL.Text); 
      tif.WriteString(PackName.Text, 'Description', MultiLineToSingleLine(Description.Lines.Text)); 
      if Reboot.Checked then
        tif.WriteString(PackName.Text, 'Reboot', 'Yes') 
      else
        tif.WriteString(PackName.Text, 'Reboot', 'No'); 
      if Silent.Checked then
        tif.WriteString(PackName.Text, 'Silent', 'Yes') 
      else
        tif.WriteString(PackName.Text, 'Silent', 'No'); 
      tif.WriteString(PackName.Text, 'Parameters', Parameters.Text); 
      tif.Free;
      
      Packs.Selected.SubItems[0] := DownloadURL.Text;
      Packs.Selected.SubItems[1] := MultiLineToSingleLine(Description.Lines.Text);
      if Reboot.Checked then Packs.Selected.SubItems[2] := 'Yes' 
        else Packs.Selected.SubItems[2] := 'No'; 
      if Silent.Checked then Packs.Selected.SubItems[3] := 'Yes' 
        else Packs.Selected.SubItems[3] := 'No'; 
      Packs.Selected.SubItems[4] := Parameters.Text;
    end;
  end;
end;

procedure Tui.EditShortcutClick(Sender: TObject);
var
  i: Integer;
begin
  if RenderUpdateScript(
    GetScriptSmartPosition(Shortcuts.Selected.SubItems[5]), false) then
  begin
    
    FeatureAwareShortcutPopulate(Shortcuts.Selected);
  end;
end;

procedure Tui.EditWebBlockClick(Sender: TObject);
var
  b: Boolean;
  i: Integer;
begin
  b := WebBlocks.Selected.SubItems[2] = SDoNotBuild;
  if RenderUpdateScript(
    GetScriptSmartPosition(WebBlocks.Selected.SubItems[3]), false) then
  begin
    i := WebBlocks.Selected.Index;
    AdjustVisualUI;
    WebBlocks.Selected := WebBlocks.Items[i];
    WebBlocks.ItemFocused := WebBlocks.Items[i];
    try
      WebBlocks.Items[i].MakeVisible(false);
    except
      
    end;
  end;
end;

procedure Tui.ExistingDblClick(Sender: TObject);
begin
  Button2Click(Self);
end;

procedure Tui.ExistingKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 13 then
    Button2Click(Self);
end;

procedure Tui.FeatureisInitiallyDeselected1Click(Sender: TObject);
begin
  SetDefaultComponentSelectionState(GetComponentPathFromTree(Features.Selected),
    false);
  Features.Selected.ImageIndex := 0;
  Features.Selected.SelectedIndex := 0;
end;

procedure Tui.FeaturesChange(Sender: TObject; Node: TTreeNode);
begin
  NewFeature.Enabled := Features.Selected <> nil;
  RenameFeature.Enabled := (Features.Selected <> nil)
    and (Features.Selected <> Features.Items.Item[0]);
  DeleteFeature.Enabled := RenameFeature.Enabled;
  FeaturesText.Enabled := RenameFeature.Enabled;
  FeaturesTextCaption.Enabled := RenameFeature.Enabled;
  if RenameFeature.Enabled then
  begin
    try
      SetMemoFlat(FeaturesText,
        GetStringAtListIndexOffset(DefComponent,
          FindIndexOfStringAtOffset(DefComponent, 1, 4,
            GetComponentPathFromTree(Node)), 3));
    except
      FeaturesText.OnChange := nil;
      FeaturesText.Lines.Clear;
      FeaturesText.Lines.Add(SThisFeatureHasNotBeenExplicitlyD);
      FeaturesText.Lines.Add(SPleaseDefineItExplicitlyInYourSc);
      FeaturesText.OnChange := @FeaturesTextChange;
      FeaturesText.Enabled := false;
      FeaturesTextCaption.Enabled := false;
      RenameFeature.Enabled := false;
      DeleteFeature.Enabled := false;
    end;
  end
  else
  begin
    FeaturesText.Lines.Clear;
    FeaturesText.Lines.Add(SPleaseChooseAFeatureBeforeEditin);
  end;
  
  if Assigned(Features.Selected) then
    Features.Selected.MakeVisible;
end;

procedure Tui.FeaturesEdited(Sender: TObject; Node: TTreeNode; var S: string);
var
  sX, sY: String;
  b: Boolean;
  i, j, k, kX: Integer;
  BaseString, NewBaseString: String;
  l, lX, lY: TStringList;
begin
  Features.OnKeyUp := @FeaturesKeyUp;
  if s = '' then
  begin
    s := Node.Text;
    Exit;
  end;
  BaseString := GetComponentPathFromTree(Features.Selected);
  NewBaseString := ExtractFilePath(BaseString) + S;
  if AnsiSameText(BaseString, NewBaseString) then Exit;
  l := TStringList.Create;
  lX := TStringList.Create;
  lY := TStringList.Create;
  l.Add(BaseString);
  l.Add(NewBaseString);
  BaseString := BaseString + '\';
  NewBaseString := NewBaseString + '\';
  b := CompareText(BaseString, NewBaseString) = 0;
  
  lX.AddObject('1,4', DefComponent); 
  lX.AddObject('1,3', SetComponent); 
  lX.AddObject('1,3', GetComponent); 
  for i := 1 to Features.Items.Count do
  begin
    if AnsiPos(BaseString, GetComponentPathFromTree(Features.Items[i -1])) = 1 then
    begin
      l.Add(GetComponentPathFromTree(Features.Items[i -1]));
      
      l.Add(StringReplace(GetComponentPathFromTree(Features.Items[i -1]),
      
        BaseString, NewBaseString, [rfReplaceAll, rfIgnoreCase]));
    end;
  end;
  for i := 1 to l.Count do
    if (i -1) mod 2 = 0 then
      for j := 1 to lX.Count do
      begin
        lY.CommaText := lX[j -1];
        repeat
          try
            k := FindIndexOfStringAtOffset(TStringList(lX.Objects[j -1]),
              StrToInt(lY[0]), StrToInt(lY[1]), l[i -1], b);
            kX := GetScriptSmartPosition(GetStringAtListIndexOffSet(TStringList(lX.Objects[j -1]),
              FindIndexOfStringAtOffset(TStringList(lX.Objects[j -1]),
              StrToInt(lY[0]), StrToInt(lY[1]), l[i -1]), 0));
          except
            k := -1;
          end;
          if k <> -1 then
          begin
            SetStringAtListIndexOffset(TStringList(lX.Objects[j -1]),
              FindIndexOfStringAtOffset(TStringList(lX.Objects[j -1]),
              StrToInt(lY[0]), StrToInt(lY[1]), l[i -1]),
              StrToInt(lY[0]), l[i]);
            RenderLine(kX, True);
          end;
        until k = -1;
      end;
  
  sX := s;
  sY := ExtractFileName(DeAssertDir(BaseString));
  for i := 1 to MediaBlock.Count do
    if (i mod 4) = 1 then
      if MediaBlock[i -1 +1] = sY then
      begin
        MediaBlock[i -1 +1] := sX;
        MediaBlock[i -1 +2] := AssertUrl(ProjectStruct.arUpdates) + sX + '.7zip';
        RenderLine(ScriptReferences.IndexOf(MediaBlock[i -1]), false);
      end;
  SetHorizontalScrollBar(Script);
  lY.Free;
  lX.Free;
  l.Free;
end;

procedure Tui.FeaturesEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  AllowEdit := Node <> Features.Items.Item[0];
  if AllowEdit then
    Features.OnKeyUp := nil;
end;

procedure Tui.FeaturesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  if Key = 38 then
    if Shift = [{$IFDEF DARWIN}ssMeta{$ELSE}ssCtrl{$ENDIF}] then
      if SpeedButton1.Enabled then
        SpeedButton1Click(Self);
  if Key = 40 then
    if Shift = [{$IFDEF DARWIN}ssMeta{$ELSE}ssCtrl{$ENDIF}] then
      if SpeedButton2.Enabled then
        SpeedButton2Click(Self);
  if Key = 45 then
    if NewFeature.Enabled then
      NewFeatureClick(Self);
  if Key = 46 then
    if DeleteFeature.Enabled then
      DeleteFeatureClick(Self);
  if Key = 113 then
    if RenameFeature.Enabled then
      RenameFeatureClick(Self);
end;

procedure Tui.FeaturesMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
var
  p: TPoint;
  t: TTreeView;
begin
  t := TTreeView(Sender);
  if t.Selected = nil then Exit;
  if t.Selected = t.Items.Item[0] then Exit;
  
  if not (htOnIcon in t.GetHitTestInfoAt(X, Y)) then Exit;
  GetCursorPos(p);
  
  FeaturesPopup.Popup(p.X, p.Y);
end;

procedure Tui.FeaturesTextChange(Sender: TObject);
begin
  if (Features.Selected = nil) or
    (Features.Selected = Features.Items.Item[0]) then Exit;
  
  SetDirtyMia(True, '');
  SetStringAtListIndexOffset(DefComponent,
    FindIndexOfStringAtOffset(DefComponent, 1, 4,
    GetComponentPathFromTree(Features.Selected)),
    3, GetMemoFlat(FeaturesText));
end;

procedure Tui.FileFilterChange(Sender: TObject);
begin
end;

procedure Tui.FileFilterClick(Sender: TObject);
begin
  FilesFeatures.Enabled := True; 
  FilesFeatures.Enabled := FileFilter.Checked;
  FoldersChange(Self, Folders.Selected);
end;

procedure Tui.FilesCustomDrawItem(Sender: TCustomListView; Item: TListItem;
  State: TCustomDrawState; var DefaultDraw: Boolean);
begin
  if CheckIsBadPathFunction('Install Files', Item.SubItems[1]) then
    Sender.Canvas.Font.Style := Sender.Canvas.Font.Style + [fsStrikeOut]
  else
    Sender.Canvas.Font.Style := Sender.Canvas.Font.Style - [fsStrikeOut];
end;

procedure Tui.FilesDblClick(Sender: TObject);
begin
  if Files.SelCount = 1 then
    EditFiles1Click(Self);
end;

procedure Tui.FilesDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if Source is TShellTreeView then BitBtn1Click(Self);
  if Source is TShellListView then BitBtn2Click(Self);
end;

procedure Tui.FilesDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := false;
  if Source is TShellTreeView then
    if TShellTreeView(Source).Name = 'ShellTree' then
      Accept := BitBtn1.Enabled;
  if Source is TShellListView then
    if TShellListView(Source).Name = 'ShellList' then
      Accept := BitBtn2.Enabled;
end;

procedure Tui.FilesKeyPress(Sender: TObject; var Key: char);
begin
  FilesPopupExPopup(Self);
  if Key = #13 then 
    if EditFiles1.Enabled then
      EditFiles1Click(Self);
end;

procedure Tui.FilesKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FilesPopupExPopup(Self);
  if Key = 45 then
    if AddFiles1.Enabled then
      AddFiles1Click(Self);
  if Key = 46 then
    if DeleteFiles1.Enabled then
      DeleteFiles1Click(Self);
end;

procedure Tui.FilesFeaturesChange(Sender: TObject);
begin
  GetComponentPathFromComboCache := ''; 
  FoldersChange(Self, Folders.Selected);
end;

procedure Tui.FilesPopupExTreePopup(Sender: TObject);
begin
  MenuItem50.Enabled := Files.Items.Count > 0; 
  MenuItem51.Enabled := Files.Items.Count > 0; 
  MenuItem52.Enabled := (Folders.Selected <> nil) and (Folders.Selected.Parent <> nil); 
  CreateSubfolder1.Enabled := (Folders.Selected <> nil) and (Folders.Selected.Parent <> nil);
  RemoveSubfolder1.Enabled := (Folders.Selected <> nil) and (Folders.Selected.Parent <> nil);
  if RemoveSubfolder1.Enabled then
    RemoveSubfolder1.Enabled :=
      FindCreateOrMapFolderIndex(DeAssertDir(GetFolderPathFromTree(Folders.Selected))) <> -1;
end;

procedure Tui.FilesPopupExPopup(Sender: TObject);
begin
  EditFiles1.Enabled := Files.SelCount > 0;
  
  DeleteFiles1.Enabled := Files.SelCount > 0;
  DeleteFiles1.Enabled := Files.SelCount > 0;
  AddFiles1.Enabled := (Folders.Selected <> nil) and (Folders.Selected.Parent <> nil);
  AddNewFolder1.Enabled := (Folders.Selected <> nil) and (Folders.Selected.Parent <> nil);
end;

procedure Tui.FileTypeTypeClick(Sender: TObject);

begin
end;

procedure Tui.FindDialogClose(Sender: TObject);
begin
  InsertShortcuts;
  CurrentUnit.Enabled := True;
  Visual1.Enabled := True; 
  NextTab1.Enabled := True;
  NextTab2.Enabled := True;
  PreviousTab1.Enabled := True;
  PreviousTab2.Enabled := True;
  
  TabSet.Enabled := True;
  globSearchOn := false;
  Script.Refresh;
  try
    if not Script.Focused then Script.SetFocus;
  except
  end;
  PopStatusStack;
end;

procedure Tui.FindDialogFind(Sender: TObject);
var
  i: Integer;
  h: TCursor;
  hDef: TCursor;
begin
  hDef := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  try
    PushStatusStack('Searching text');
    globSearchOn := True;
    Script.Refresh;
    LastFindIndex := GetRealLineNumber(Script.ItemIndex) +1;
    if LastFindIndex = 0 then LastFindIndex := 1;
    if frDown in FindDialog.Options then
    begin
      LastFindIndex := LastFindIndex +1;
      for i := LastFindIndex to ScriptBuffer.Count do
        if 
          IsTextInCommandAtLine(FindDialog.FindText, i -1, True, frMatchCase in FindDialog.Options) then
        begin
          
          LastFindIndex := i;
          AssertLineIsVisible(i -1);
          ClearSelectionEx(Script);
          Script.ItemIndex := GetFoldedLineNumber(i -1);
          Script.Selected[GetFoldedLineNumber(i -1)] := True;
          MyPlaySound(PChar(EXEDIR + 'audio' + PathDelim + 'find_in_path.wav')); 
          Exit;
        end;
    end
    else
    begin
      LastFindIndex := LastFindIndex -1;
      for i := LastFindIndex downto 1 do
        if 
          IsTextInCommandAtLine(FindDialog.FindText, i -1, True, frMatchCase in FindDialog.Options) then
        begin
          
          LastFindIndex := i;
          AssertLineIsVisible(i -1);
          ClearSelectionEx(Script);
          Script.ItemIndex := GetFoldedLineNumber(i -1);
          Script.Selected[GetFoldedLineNumber(i -1)] := True;
          MyPlaySound(PChar(EXEDIR + 'audio' + PathDelim + 'find_in_path.wav')); 
          Exit;
        end;
    end;
  finally
    PopStatusStack;
    Screen.Cursor := hDef;
  end;
end;

procedure Tui.FindDialogShow(Sender: TObject);
begin
  ReplaceDialog.CloseDialog;
  Application.ProcessMessages;
  PushStatusStack('Finding text');
  if CurrentUnit.TabIndex = 0 then
  begin
    CurrentUnit.TabIndex := 1;
    CurrentUnitChange(Self);
  end;
  Visual1.Enabled := True; 
  NextTab1.Enabled := True;
  NextTab2.Enabled := True;
  PreviousTab1.Enabled := True;
  PreviousTab2.Enabled := True;
  CurrentUnit.Enabled := false;
  TabSet.Enabled := false;
  RemoveShortcuts;
end;

procedure Tui.FoldersChange(Sender: TObject; Node: TTreeNode);
var
  l: TStrings;
  i: Integer;
  hWait, hDef: TCursor;
begin
  if AllowFileRehash then
  begin
    hDef := Screen.Cursor;
    Screen.Cursor := crHourGlass;
  end;
  try
    Files.Items.BeginUpdate;
    Files.Items.Clear;
    
    begin
      FilesPage.Enabled := True;
      l := GetFilesAndSourcesForComponentInFolder(
        GetComponentPathFromCombo(FilesFeatures),
        GetFolderPathFromTree(Node), FileFilter.Checked);
      for i := 1 to l.Count do
        if i mod 2 = 1 then
          AddFileToFileList(Files,
            ExtractFilePath(l[i -1]),
            ExtractFileName(l[i -1]),
            l[i]);
      l.Free;
    end;
    Files.Items.EndUpdate;
  finally
    if AllowFileRehash then
      Screen.Cursor := hDef;
  end;
  if Assigned(Node) then
    Folders.Selected.MakeVisible;
end;

procedure Tui.FoldersDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  if Source is TShellTreeView then BitBtn1Click(Self);
  if Source is TShellListView then BitBtn2Click(Self);
end;

procedure Tui.FoldersDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept := false;
  if Source is TShellTreeView then
    if TTreeView(Source).Name = 'ShellTree' then
      Accept := BitBtn1.Enabled;
  if Source is TShellListView then
    if TListView(Source).Name = 'ShellList' then
      Accept := BitBtn2.Enabled;
end;

procedure Tui.FoldersKeyPress(Sender: TObject; var Key: char);
begin
  FilesPopupExTreePopup(Self);
  if Key = #13 then
    if MenuItem50.Enabled then
      MenuItem50Click(Self);
end;

procedure Tui.FoldersKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
begin
  FilesPopupExTreePopup(Self);
  if Key = 45 then
  begin
    if CreateSubfolder1.Enabled then
      CreateSubfolder1Click(Self)
    else
      if DisplaySystemFolder1.Enabled then
        DisplaySystemFolder1Click(Self);
  end;
  if (Key = 46) and (ssShift in Shift) then
    if MenuItem52.Enabled then
      MenuItem52Click(Self);
  if (Key = 46) and not (ssShift in Shift) then
  begin
    if MenuItem51.Enabled then 
      MenuItem51Click(Self)
    else
      if RemoveSubfolder1.Enabled then 
        RemoveSubfolder1Click(Self);
  end;
  if Key = 113 then
    if MenuItem50.Enabled then
      MenuItem50Click(Self);
end;

procedure Tui.FormCloseQuery(Sender: TObject; var CanClose: boolean);
begin
  if not SafeRunState then
  begin
    CanClose := false;
    Exit;
  end;
  CanClose := IsSafeToCloseProject;
end;

initialization
  IconCache := TStringList.Create;
  SelectedIconCache := TStringList.Create;
  gbp := SyncObjs.TCriticalSection.Create;
  UndoStack := TList.Create;
  RedoStack := TList.Create;
  DirtyBuffer := THashedStringList.Create;
  StatusStack := TStringList.Create;
  FoldList := THashedStringList.Create;
  BackupFoldList := THashedStringList.Create;
  Bookmarks := THashedStringList.Create;
  AllContextBuffers := THashedStringList.Create;
  AllContextBuffersEx := THashedStringList.Create;
  PullMap := THashedStringList.Create;
  BreakMap := THashedStringList.Create;
  TopLines := THashedStringList.Create;
  IncludeDepth := THashedStringList.Create;
  IncludeDepthStack := TStringList.Create;
  
  DialogsList := TStringList.Create;

finalization
  
  if Assigned(IconCache) then
    FreeAndNil(IconCache);
  if Assigned(SelectedIconCache) then
    FreeAndNil(SelectedIconCache);
  if Assigned(UndoStack) then
    FreeAndNil(UndoStack);
  if Assigned(RedoStack) then
    FreeAndNil(RedoStack);
  if Assigned(DirtyBuffer) then
    FreeAndNil(DirtyBuffer);
  if Assigned(FoldList) then
    FreeAndNil(FoldList);
  if Assigned(BackupFoldList) then
    FreeAndNil(BackupFoldList);
  if Assigned(Bookmarks) then
    FreeAndNil(Bookmarks);
  if Assigned(AllContextBuffers) then
    FreeAndNil(AllContextBuffers);
  if Assigned(AllContextBuffersEx) then
    FreeAndNil(AllContextBuffersEx);
  if Assigned(StatusStack) then
    FreeAndNil(StatusStack);
  if Assigned(PullMap) then
    FreeAndNil(PullMap);
  if Assigned(BreakMap) then
    FreeAndNil(BreakMap);
  if Assigned(TopLines) then
    FreeAndNil(TopLines);
  if Assigned(IncludeDepth) then
    FreeAndNil(IncludeDepth);
  if Assigned(IncludeDepthStack) then
    FreeAndNil(IncludeDepthStack);
  if Assigned(DialogsList) then
    FreeAndNil(DialogsList);
  gbp.Free;

end.
