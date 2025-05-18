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
unit mnewproject;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, Buttons, StdCtrls, ComCtrls, ImgList, ExtCtrls, FileCtrl, mUtils, mAutomate, madddialog,
  mquickstart, mquickstartthread;

type

  TNewProject = class(TForm)
    Custom: TListView;
    ImageList: TImageList;
    Label7: TLabel;
    Label8: TLabel;
    PageControl: TPageControl;
    Panel5: TPanel;
    Converters: TListView;
    CustomPanel: TPanel;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    TabSheet3: TTabSheet;
    Label1: TLabel;
    ProjectName: TEdit;
    Label2: TLabel;
    ProjectFolder: TEdit;
    Button1: TButton;
    Subfolder: TCheckBox;
    OK: TBitBtn;
    BitBtn2: TBitBtn;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    AllX: TTabSheet;
    Label6: TLabel;
    GroupBox1: TGroupBox;
    Hints: TLabel;
    Panel1: TPanel;
    TabSheet4: TTabSheet;
    TabSheet5: TTabSheet;
    Wizards: TListView;
    Panel2: TPanel;
    Templates: TListView;
    Panel3: TPanel;
    Samples: TListView;
    Panel4: TPanel;
    All: TListView;
    procedure FormHide(Sender: TObject);
    procedure PageControlChange(Sender: TObject);
    procedure WizardsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure Button1Click(Sender: TObject);
    procedure AllDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
  private
    
  public
    procedure MyClose(Cancel: Boolean = false);
    procedure CreateFailsafeProject;
    procedure CreateDefaultProject;
    procedure ClearSelectedObjects;
    procedure RefreshCustomTemplates;
    function AddCustomTemplate(CloneTemp: String = ''): Boolean;
    procedure CreateAuthProject;
    procedure CreateBlankProject;
    procedure CreateCloneProject;
    procedure CreateLangProject;
    procedure CreateSerialProject;
    procedure CreateXcodeProject;
    procedure CreateAGPTProject;
    procedure CreateSysInfoProject;
    procedure CreateRegProject;
    procedure ConvertIAProject;
    procedure QuickStart;
    procedure SaveProjectIntoFolder;
    procedure CloneTemplateProject(Location: String);
    function AssertURL(URL: String): String;
    procedure CreateTemplateProject;
    procedure CreateUserModeProject;
    procedure CreateCDAutorunProject;
    procedure CreateSingleClickProject;
  end;

var
  NewProject: TNewProject;
  ProjectSelection: Integer;
  AllCount: Integer = 0;
  IconCount: Integer = 0;
  TemplateName: String = '';

implementation

{$R *.lfm}

uses
  uGui;

procedure TNewProject.WizardsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
var
  b: Boolean;
  i: Integer;
begin
  if (Change = ctState) and ((Item <> nil) and (Item.Selected)) then
  begin
    
    Label1.Enabled := True;
    Label2.Enabled := True;
    Button1.Enabled := True;
    ProjectName.Enabled := True;
    ProjectFolder.Enabled := True;
    Subfolder.Enabled := True;
    
    if Item.Caption = SCDAutorun then
      Hints.Caption := SGeneratesAScriptForATypicalCDAut;
    if Item.Caption = SLUASetup then
      Hints.Caption := SLUA;
    if Item.Caption = cBlank then
      Hints.Caption := hBlank;
    if Item.Caption = cClone then
      Hints.Caption := hClone;
    if Item.Caption = cBlankEx then
      Hints.Caption := hBlankEx;
    if Item.Caption = cSingleClick then
      Hints.Caption := hSingleClick;
    if Item.Caption = cIA then
      Hints.Caption := hIA;
    if Item.Caption = cSerial then
      Hints.Caption := hSerial;
    if Item.Caption = cXcode then
      Hints.Caption := hXcode;
    if Item.Caption = cAGPT then
      Hints.Caption := hAGPT;
    if Item.Caption = cSysInfo then
      Hints.Caption := hSysInfo;
    if Item.Caption = cFeedback then
      Hints.Caption := hFeedback;
    if Item.Caption = cLang then
      Hints.Caption := hLang;
    if Item.Caption = SQuickStart then
      Hints.Caption := QuickStartHint;
    if Item.Caption = SOnlineUserAuthentication then
      Hints.Caption := AuthHint;
    if Item.Caption = cPackageAware then 
    begin
      Label1.Enabled := false;
      Label2.Enabled := false;
      Button1.Enabled := false;
      ProjectName.Enabled := false;
      ProjectFolder.Enabled := false;
      Subfolder.Enabled := false;
      Hints.Caption := hPackageAware;
    end;
    if Item.Caption = cAddTemplate then
    begin
      Label1.Enabled := false;
      Label2.Enabled := false;
      Button1.Enabled := false;
      ProjectName.Enabled := false;
      ProjectFolder.Enabled := false;
      Subfolder.Enabled := false;
      Hints.Caption := hAddTemplate;
    end;
    if  (Item.ImageIndex = 33) then
    begin
      Hints.Caption := hTemplate;
      TemplateName := Item.Caption;
    end;
    if Item.Caption = cIA then
    begin
      Label1.Enabled := false;
      Label2.Enabled := false;
      Button1.Enabled := false;
      ProjectName.Enabled := false;
      ProjectFolder.Enabled := false;
      Subfolder.Enabled := false;
      Hints.Caption := hIA;
    end;
  end
  else
  begin
    b := True;
    {$IFDEF LINUX}
    
    if Assigned(Item) then
      for i := 1 to Item.ListView.Items.Count do
        if Item.ListView.Items[i -1].Selected then
        begin
          b := false;
          Break;
        end;
    {$ENDIF}
    if b then
      Hints.Caption := '';
  end;
  OK.Enabled := Hints.Caption <> '';
end;

procedure TNewProject.PageControlChange(Sender: TObject);
begin
  ClearSelectedObjects;
end;

procedure TNewProject.FormHide(Sender: TObject);
begin
  ui.PopStatusStack; 
end;

procedure TNewProject.Button1Click(Sender: TObject);
var
  s: String;
begin
  if SelectDirectory('Choose project folder', '', s) then
    ProjectFolder.Text := AssertDir(s);
end;

procedure TNewProject.AllDblClick(Sender: TObject);
var
  s, sC: String;
begin
  try
    if Sender <> nil then
      if Sender is TListView then
        if TListView(Sender).Selected = nil then
          Exit;
  except
    Exit;
  end;
  
  if Hints.Caption = hAddTemplate then
  begin
    if AddCustomTemplate then
    begin
      Application.MessageBox('New template added successfully.',
        PChar(Application.Title), mb_Ok + mb_IconInformation);
      PageControl.ActivePageIndex := 6;
      ClearSelectedObjects;
      RefreshCustomTemplates;
      Exit;
    end;
    Exit;
  end;
  
  if Hints.Caption = hPackageAware then
  begin
    if not MyFileExists(
      {$IFDEF WINDOWS}
      EXEDIR + 'mpax.exe'
      {$ELSE}
      {$IFDEF DARWIN}
      EXEDIR + 'mpax.app/Contents/MacOS/mpax'
      {$ELSE}
      EXEDIR + 'mpax'
      {$ENDIF}
      {$ENDIF}
      ) then 
    begin
      Application.MessageBox(PChar(SPackageAwareHasNotBeenInstalledP),
        PChar(Application.Title), mb_Ok + mb_IconExclamation);
      MyClose;
      Exit;
    end;
    Application.MessageBox(PChar(SPackageAwareIsAStandAloneUtility),
      Brand, mb_Ok + mb_IconInformation);
    ui.MenuItem44Click(Self);
    MyClose;
    Exit;
  end;
  
  sC := ProjectName.Text + ';' + ProjectFolder.Text; 
  if not ui.IsSafeToCloseProject then
  begin
    MyClose(True);
    Exit;
  end;
  if Hints.Caption = hIA then
  begin
    ConvertIAProject;
    MyClose;
    Exit;
  end;
  
  if ProjectName.Text = '' then
  begin
    Application.MessageBox('Please enter a project name.',
      Brand, mb_OK + mb_IconExclamation);
    Exit;
  end;
  if ProjectFolder.Text = '' then
  begin
    Application.MessageBox('Please enter a project folder.',
      Brand, mb_OK + mb_IconExclamation);
    Exit;
  end;
  s := AssertDir(ProjectFolder.Text);
  if Subfolder.Checked then s := s + ProjectName.Text + PathDelim;
  
  if DirectoryExists(s) then
  begin
    if Application.MessageBox(PChar('Specified folder already exists. Use folder for new project?' + MyLineEnding + MyLineEnding +
      'Warning: All folder contents will be erased!'),
      Brand, mb_YesNo + mb_IconQuestion) = id_No then
      Exit
    else
      WipeFolder(s, True);
  end;
  
  ForceDirectories(s);
  if not DirectoryExists(s) then
  begin
    Application.MessageBox('Unable to create target folder.',
      Brand, mb_OK + mb_IconStop);
    Exit;
  end;
  if (AnsiPos('\', ProjectName.Text) <> 0) or
    (AnsiPos('/', ProjectName.Text) <> 0) then
  begin
    Application.MessageBox('Please choose a valid project name.',
      Brand, mb_OK + mb_IconStop);
    Exit;
  end;
  ForceDirectories(s + ProjectName.Text);
  if not DirectoryExists(s + ProjectName.Text) then
  begin
    Application.MessageBox('Please choose a valid project name.',
      Brand, mb_OK + mb_IconStop);
    Exit;
  end;
  RemoveDirectory(PChar(s + ProjectName.Text));
  if Hints.Caption = hTemplate then CreateTemplateProject;
  if Hints.Caption = hBlank then CreateBlankProject;
  if Hints.Caption = hBlankEx then CreateDefaultProject;
  if Hints.Caption = hFeedback then CreateRegProject;
  if Hints.Caption = hLang then CreateLangProject;
  if Hints.Caption = hSerial then CreateSerialProject;
  if Hints.Caption = hClone then CreateCloneProject;
  if Hints.Caption = QuickStartHint then QuickStart;
  if Hints.Caption = AuthHint then CreateAuthProject;
  if Hints.Caption = SLUA then CreateUserModeProject;
  if Hints.Caption = SGeneratesAScriptForATypicalCDAut then CreateCDAutorunProject;
  if Hints.Caption = hSingleClick then CreateSingleClickProject;
  if Hints.Caption = hXcode then CreateXcodeProject;
  if Hints.Caption = hAGPT then CreateAGPTProject;
  if Hints.Caption = hSysInfo then CreateSysInfoProject;
  MyClose;
end;

procedure TNewProject.FormShow(Sender: TObject);
var
  s: String;
begin
  ui.PushStatusStack('Creating new project');
  
  ClearSelectedObjects;
  RefreshCustomTemplates;
  if True then
  begin
    ProjectName.Text := SMyInstallationProject;
    PageControl.ActivePage := PageControl.Pages[0];
    Wizards.SetFocus;
    Wizards.ClearSelection;
    Wizards.Items[0].Selected := True;
    
  end;
  GetSpecialFolder($5, s);
  Subfolder.Checked := True;
  ProjectFolder.Text := AssertDir(s);
end;

procedure TNewProject.CreateBlankProject;
begin
  CloneTemplateProject(EXEDIR + 'Templates' + PathDelim + 'Empty Script'); 
end;

procedure TNewProject.CreateCloneProject;
var
  i: Integer;
  s: String;
begin
  i := 0;
  repeat
    i := i +1;
    s := EXEDIR + 'clone' + IntToStr(i) + '.tmp'
  until not DirectoryExists(s);
  
  if AddCustomTemplate(s) then
    CloneTemplateProject(s); 
  WipeFolder(s, True);
  RemoveDirectory(PChar(s));
end;

procedure TNewProject.CreateLangProject;
begin
  CloneTemplateProject(EXEDIR + 'Samples' + PathDelim + 'Multi Lingual'); 
end;

procedure TNewProject.CreateSerialProject;
begin
  CloneTemplateProject(EXEDIR + 'Samples' + PathDelim + 'Serial Number Validator'); 
end;

procedure TNewProject.CreateXcodeProject;
begin
  CloneTemplateProject(EXEDIR + 'Samples' + PathDelim + 'Xcode Command Line Tools'); 
end;

procedure TNewProject.CreateAGPTProject;
begin
  CloneTemplateProject(EXEDIR + 'Samples' + PathDelim + 'Game Porting Toolkit Installer'); 
end;

procedure TNewProject.CreateSysInfoProject;
begin
  CloneTemplateProject(EXEDIR + 'Samples' + PathDelim + 'Native System Information'); 
end;

procedure TNewProject.CreateRegProject;
begin
  CloneTemplateProject(EXEDIR + 'Samples' + PathDelim + 'User Registration and Feedback'); 
end;

procedure TNewProject.ConvertIAProject;
begin
  ui.MenuItem45Click(Self);
end;

procedure TNewProject.QuickStart;
var
  t: TTreeNode;
  i, j, k: Integer;
  s, sX, sY, sZ: String;
  l, lX, lY: TStringList;
  SetupCompts: Integer;
  SourceFile, TargetDir, TargetDirEx: String;
  b: Boolean;
  User, Organization, LastShort: String;
begin
  
  QuickStartWizard.PrepNewRun;
  
  if QuickStartWizard.ShowModal = mrOk then
  begin
    LastShort := '';
    
    lY := TStringList.Create;
    UI.ClearProjectStructs;
    StrCopy(ProjectStruct.Name, PChar(QuickStartWizard.Product.Text));
    
    ProjectStruct.BuildDebug := false;
    ProjectStruct.BuildLayout := 0;
    ProjectStruct.BuildCustomFolder := '';
    ProjectStruct.BuildInFolder := True;
    StrCopy(ProjectStruct.Manufacturer, PChar(QuickStartWizard.Organization.Text));
    
    StrCopy(ProjectStruct.Code, PChar(CreateGUIDUp));
    
    StrCopy(ProjectStruct.UpgradeCode, PChar(CreateGUIDUp));
    
    ProjectStruct.Version := '1.0.0';
    ProjectStruct.Language := 'English'; 
    StrCopy(ProjectStruct.Title, PChar(QuickStartWizard.Product.Text));
    
    StrCopy(ProjectStruct.Subject, PChar(QuickStartWizard.Product.Text + SInstallation));
    
    StrCopy(ProjectStruct.Author, PChar(QuickStartWizard.Organization.Text));
    
    StrCopy(ProjectStruct.Comments, PChar(SAllRightsReserved));
    
    StrCopy(ProjectStruct.Revision, PChar(CreateGUIDUp));
    
    StrCopy(ProjectStruct.arPublisher, PChar(QuickStartWizard.Organization.Text));
    
    StrCopy(ProjectStruct.arContact, PChar(QuickStartWizard.Organization.Text));
    
    ProjectStruct.arHelp := 'http://www.mywebsite.com/';
    ProjectStruct.arUpdates := 'http://www.mywebsite.com/';
    StrCopy(ProjectStruct.arComments, PChar(SAllRightsReserved));
    
    ProjectStruct.OutputFile := '';
    ProjectStruct.AutoIncrement := True;
    ProjectStruct.AutoHash := false;
    ProjectStruct.cFiles := false;
    ProjectStruct.cRegistry := false;
    ProjectStruct.cFeatures := True;
    ProjectStruct.cHashes := false;
    PROJDIR := AssertDir(ProjectFolder.Text);
    if Subfolder.Checked then PROJDIR := PROJDIR + ProjectName.Text + PathDelim;
    ForceDirectories(PROJDIR);
    CurrentProjectName := PROJDIR + ProjectName.Text + '.mprx'; 
    ScriptFile := PROJDIR + ProjectName.Text + '.miax'; 
    
    AddDialog.Auto.Checked := True;
    AddDialog.FormShow(Self);
    if AddDialog.Themes.Items.IndexOf('macOS') <> 0 then 
      AddDialog.Themes.ItemIndex := AddDialog.Themes.Items.IndexOf('macOS') 
    else
      AddDialog.Themes.ItemIndex := 0;
    AddDialog.OKClick(Self);
    
    InitializeScript;
    Breakpoints.Clear;
    EmitAddCommand('Comment', '"' + QuickStartWizard.Product.Text + SSetupProject); 
    EmitAddCommand('Comment', '""'); 
    EmitAddCommand('Code Folding Region', '"TRUE","Check Application Requirements"'); 
    lY.Add('Check Application Requirements'); 
    EmitAddCommand('Code Folding Region', '"FALSE",""'); 
    EmitAddCommand('Comment', '""'); 
    EmitAddCommand('Code Folding Region', '"TRUE","Check/Install Application Pre-Requisites"'); 
    lY.Add('Check/Install Application Pre-Requisites'); 
    EmitAddCommand('Comment', '""'); 
    
    EmitAddCommand('Code Folding Region', '"TRUE","Check Application Pre-Requisites"'); 
    lY.Add('Check Application Pre-Requisites'); 
    EmitAddCommand('Comment', '"Check setup pre-requisites"'); 
    EmitAddCommand('Set Variable', '"PREREQ","FALSE"'); 
    EmitAddCommand('Set Variable', '"PRELIST",""'); 
    
    EmitAddCommand('If', '"RECOMMENDEDUPGRADE","0","TRUE","FALSE"'); 
    EmitAddCommand('Set Variable', '"PREREQ","TRUE"'); 
    EmitAddCommand('Set Variable', '"PRELIST","$PRELIST$$NEWLINE$Previous Version Removal"'); 
    EmitAddCommand('End', ''); 
    
    EmitAddCommand('Code Folding Region', '"FALSE",""'); 
    EmitAddCommand('Comment', '""'); 
    EmitAddCommand('Code Folding Region', '"TRUE","Install Application Pre-Requisites"'); 
    lY.Add('Install Application Pre-Requisites'); 
    EmitAddCommand('Comment', '"Install setup pre-requisites"'); 
    EmitAddCommand('If', '"PREREQ","0","FALSE","TRUE"'); 
    EmitAddCommand('Display Dialog', '"prereq","WIZARD","TRUE","","TRUE","FALSE"'); 
    EmitAddCommand('If', '"WIZARD","0","CANCEL","FALSE"'); 
    EmitAddCommand('Terminate Install', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('Display Dialog', '"progressprereq","WIZARD","FALSE","","TRUE","FALSE"'); 
    EmitAddCommand('If', '"RECOMMENDEDUPGRADE","0","TRUE","FALSE"'); 
    EmitAddCommand('Comment', '"Bind to external setup log"'); 
    EmitAddCommand('Set Variable', '"NATIVE_LOGGING","$NATIVE_OLDLOG$"'); 
    EmitAddCommand('Apply Changes', '"progress","NATIVE_UNINSTALL","FALSE","TRUE"'); 
    EmitAddCommand('If', '"NATIVE_UNINSTALL","0","REBOOT","FALSE"'); 
    EmitAddCommand('MessageBox', STITLESetup + 
      SYourComputerNeedsToBeRestartedBe + SAndClickOKToRestartYourComputerS +
      '"2","2","REBOOTNOW"'); 
    EmitAddCommand('If', '"REBOOTNOW","0","OK","FALSE"'); 
    EmitAddCommand('Reboot and Resume', ''); 
    EmitAddCommand('Else', ''); 
    EmitAddCommand('Terminate Install', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('Else', ''); 
    EmitAddCommand('If', '"NATIVE_UNINSTALL","0","COMPLETE","TRUE"'); 
    EmitAddCommand('MessageBox', STITLESetup + 
      SUnableToUninstallOldVersionOfTIT +
      '"2","1",""'); 
    EmitAddCommand('If', '"NATIVE_UNINSTALL","0","OK","FALSE"'); 
    EmitAddCommand('Terminate Install', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('Comment', '"Bind to internal setup log"'); 
    EmitAddCommand('Set Variable', '"NATIVE_LOGGING",""'); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('Hide Dialog', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('Code Folding Region', '"FALSE",""'); 
    EmitAddCommand('Comment', '""'); 
    EmitAddCommand('Code Folding Region', '"FALSE",""'); 
    EmitAddCommand('Comment', '""'); 
    
    EmitAddCommand('Code Folding Region', '"TRUE","Define Setup Globals"'); 
    lY.Add('Define Setup Globals'); 
    SetupCompts := 0;
    EmitAddCommand('Comment', '"Define Setup Components"'); 
    EmitAddCommand('Define Component', '"' + 
      QuickStartWizard.Product.Text +
      '","TRUE","Description for #TITLE#' + 
       '"');
    EmitAddCommand('Comment', '""'); 
    
    EmitAddCommand('Comment', '"Initialize Setup Variables"'); 
    EmitAddCommand('Get Folder Location', '"LOCALAPPDATA","28","0"'); 
    EmitAddCommand('Get Folder Location', '"SYSTEMAPPDATA","15","1"'); 
    EmitAddCommand('Get Folder Location', '"USERAPPDATA","15","0"'); 
    EmitAddCommand('Get Folder Location', '"PROGRAMFILES","20","FALSE"'); 
    EmitAddCommand('Get Folder Location', '"COMMONFILES","20","TRUE"'); 
    EmitAddCommand('Get Folder Location', '"STARTMENUALL","14","TRUE"'); 
    EmitAddCommand('Get Folder Location', '"STARTMENU","14","FALSE"'); 
    EmitAddCommand('Get Folder Location', '"DESKTOP","17","FALSE"'); 
    EmitAddCommand('Get Folder Location', '"DOCUMENTS","2","TRUE"'); 
    EmitAddCommand('Code Folding Region', '"FALSE",""'); 
    EmitAddCommand('Comment', '""'); 
    
    EmitAddCommand('Code Folding Region', '"TRUE","Setup User Interview"'); 
    lY.Add('Setup User Interview'); 
    EmitAddCommand('If', '"MAINTENANCE","0","TRUE","FALSE"'); 
    EmitAddCommand('GoTo Label', '"Maintenance"'); 
    EmitAddCommand('Else', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('Comment', '""'); 
    EmitAddCommand('Label', '"Welcome Dialog"'); 
    EmitAddCommand('Display Dialog', '"welcome","WIZARD","TRUE","","TRUE","FALSE"'); 
    EmitAddCommand('If', '"WIZARD","0","CANCEL","FALSE"'); 
    EmitAddCommand('GoTo Label', '"Main Install"'); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('Label', '"License Check"'); 
    EmitAddCommand('Display Dialog', '"licensecheck","WIZARD","TRUE","","TRUE","FALSE"'); 
    EmitAddCommand('If', '"WIZARD","0","BACK","FALSE"'); 
    EmitAddCommand('GoTo Label', '"Welcome Dialog"'); 
    EmitAddCommand('Else', ''); 
    EmitAddCommand('If', '"WIZARD","0","CANCEL","FALSE"'); 
    EmitAddCommand('GoTo Label', '"Main Install"'); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('Label', '"ReadMe Information"'); 
    EmitAddCommand('Display Dialog', '"readme","WIZARD","TRUE","","TRUE","FALSE"'); 
    EmitAddCommand('If', '"WIZARD","0","BACK","FALSE"'); 
    EmitAddCommand('GoTo Label', '"License Check"'); 
    EmitAddCommand('Else', ''); 
    EmitAddCommand('If', '"WIZARD","0","CANCEL","FALSE"'); 
    EmitAddCommand('GoTo Label', '"Main Install"'); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('Label', '"Destination Select"'); 
    EmitAddCommand('Display Dialog', '"destination","WIZARD","TRUE","","TRUE","FALSE"'); 
    EmitAddCommand('If', '"WIZARD","0","BACK","FALSE"'); 
    EmitAddCommand('GoTo Label', '"ReadMe Information"'); 
    EmitAddCommand('Else', ''); 
    EmitAddCommand('If', '"WIZARD","0","CANCEL","FALSE"'); 
    EmitAddCommand('GoTo Label', '"Main Install"'); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('Label', '"Setup Type"'); 
    EmitAddCommand('Display Dialog', '"setuptype","WIZARD","TRUE","","TRUE","FALSE"'); 
    EmitAddCommand('If', '"WIZARD","0","BACK","FALSE"'); 
    EmitAddCommand('GoTo Label', '"Destination Select"'); 
    EmitAddCommand('Else', ''); 
    EmitAddCommand('If', '"WIZARD","0","STANDARD","FALSE"'); 
    EmitAddCommand('Set Component State', '"' + 
      QuickStartWizard.Product.Text + '","TRUE"'); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('GoTo Label', '"Main Install"'); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('Comment', '""'); 
    EmitAddCommand('Label', '"Maintenance"'); 
    EmitAddCommand('Comment', '"Maintenance Install/Uninstall"'); 
    EmitAddCommand('Display Dialog', '"maintenance","WIZARD","TRUE","","TRUE","FALSE"'); 
    EmitAddCommand('If', '"WIZARD","0","REMOVE","FALSE"'); 
    EmitAddCommand('Set Variable', '"REMOVE","TRUE"'); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('Code Folding Region', '"FALSE",""'); 
    EmitAddCommand('Comment', '""'); 
    
    EmitAddCommand('Code Folding Region', '"TRUE","Process (Un)Installation"'); 
    lY.Add('Process (Un)Installation'); 
    EmitAddCommand('Label', '"Main Install"'); 
    EmitAddCommand('Comment', '"Exit Setup if Wizard Loop cancelled"'); 
    EmitAddCommand('If', '"WIZARD","0","CANCEL","FALSE"'); 
    EmitAddCommand('Terminate Install', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('Comment', '""'); 
    EmitAddCommand('Comment', '"Prepare to install"'); 
    EmitAddCommand('Set Variable', SPROGRESSTEXTInstallingTITLE); 
    EmitAddCommand('Set Variable', '"SUCCESS",""'); 
    EmitAddCommand('Set Variable', '"LASTERROR",""'); 
    EmitAddCommand('If', '"PLATFORM","0","MACOS","FALSE"'); 
    
    EmitAddCommand('Set Variable', '"PLATFORMMENU","/Applications"'); 
    EmitAddCommand('Else', ''); 
    EmitAddCommand('If', '"ALLUSERS","0","TRUE","FALSE"'); 
    EmitAddCommand('Set Variable', '"PLATFORMMENU","$STARTMENUALL$"'); 
    EmitAddCommand('Else', ''); 
    EmitAddCommand('Set Variable', '"PLATFORMMENU","$STARTMENU$"'); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('Display Dialog', '"progress","WIZARD","FALSE","","TRUE","FALSE"'); 
    EmitAddCommand('Comment', '""'); 
    
    EmitAddCommand('Comment', '"Modify Target System"'); 
    EmitAddCommand('Code Folding Region', '"TRUE","Perform Uninstallation"'); 
    lY.Add('Perform Uninstallation'); 
    EmitAddCommand('If', '"REMOVE","0","TRUE","FALSE"'); 
    EmitAddCommand('Comment', '"Uninstall product"'); 
    EmitAddCommand('Set Variable', '"PROGRESSTEXT","Removing $TITLE$"'); 
    EmitAddCommand('Comment', '"TO-DO: Insert any additional uninstall commands here"'); 
    EmitAddCommand('Apply Changes', '"progress","SUCCESS","FALSE","TRUE"'); 
    EmitAddCommand('Set Variable', '"PROGRESS","100"'); 
    EmitAddCommand('Else', ''); 
    EmitAddCommand('Code Folding Region', '"FALSE",""'); 
    EmitAddCommand('Code Folding Region', '"TRUE","Perform First Time or Maintenance Installation"'); 
    lY.Add('Perform First Time or Maintenance Installation'); 
    EmitAddCommand('Comment', '"Re-Installation/Maintenance Operation"'); 
    EmitAddCommand('If', '"MAINTENANCE","0","TRUE","FALSE"'); 
    EmitAddCommand('If', '"MODIFY","0","TRUE","FALSE"'); 
    EmitAddCommand('Comment', '"Facilitate removal of deselected features prior to adding selected features"'); 
    EmitAddCommand('Apply Changes', '"progress","SUCCESS","FALSE","TRUE"'); 
    EmitAddCommand('If', '"SUCCESS","0","CANCEL","FALSE"'); 
    EmitAddCommand('Terminate Install', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('Comment', '"First Time Production Installation"'); 
    EmitAddCommand('Create Shortcut', '"$UNINSTALLLINK$",' + 
      '"#TITLE# Maintenance' +  '",' + 
      '"$PLATFORMMENU$","Removes this ' + QuickStartWizard.Organization.Text + ' product",' + 
      '"","","","","0"'); 
    
    EmitAddCommand('Web Media Block', '"","","FALSE"'); 
    sX := Trim(ExtractFileName(QuickStartWizard.Product.Text));
    EmitAddCommand('Web Media Block', '"' + sX + '","' + 
      AssertURL('http://www.mywebsite.com/') + sX + '.7zip","FALSE"');
    EmitAddCommand('Get Component State', '"' + 
      QuickStartWizard.Product.Text + '","SELECTED"'); 
    EmitAddCommand('If', '"SELECTED","0","TRUE","FALSE"'); 
    
    if QuickStartWizard.Dynamic.Checked then
    begin
      SourceFile := AssertDir(QuickStartWizard.Files.Text) + '*';
      TargetDir := '$TARGETDIR$';
      s := 'TRUE'; 
      EmitAddCommand('Install Files', '"' + SourceFile + '",' + 
        '"' + s + '","' + TargetDir + '","FALSE","FALSE","FALSE",' + 
        '"FALSE","FALSE","FALSE","FALSE","FALSE","FALSE"'); 
    end
    else
      for j := 1 to qstList.Count do
      begin
        SourceFile := qstList[j -1];
        TargetDir := '$TARGETDIR$';
        TargetDirEx := AssertDir(ExtractFilePath(qstList[j -1])); 
        Delete(TargetDirEx, 1, Length(AssertDir(QuickStartWizard.Files.Text))); 
        if TargetDirEx <> '' then
          TargetDir := DeAssertDir(TargetDir + '/' + TargetDirEx);
        s := 'FALSE';
        EmitAddCommand('Install Files', '"' + SourceFile + '",' + 
          '"' + s + '","' + TargetDir + '","FALSE","FALSE","FALSE",' + 
          '"FALSE","FALSE","FALSE","FALSE","FALSE","FALSE"'); 
      end;
    
    for j := 1 to QuickStartWizard.Shortcuts.Items.Count do
      if (StrToBool(QuickStartWizard.Shortcuts.Items[j -1].SubItems[1]) or
        StrToBool(QuickStartWizard.Shortcuts.Items[j -1].SubItems[2])) or
        StrToBool(QuickStartWizard.Shortcuts.Items[j -1].SubItems[3]) then
      begin
        TargetDirEx := AssertDir(ExtractFilePath(QuickStartWizard.Shortcuts.Items[j -1].SubItems[0])); 
        Delete(TargetDirEx, 1, Length(AssertDir(QuickStartWizard.Files.Text))); 
        TargetDirEx := AssertDir('$TARGETDIR$' + '/' + TargetDirEx)
          + ExtractFileName(QuickStartWizard.Shortcuts.Items[j -1].SubItems[0]);
        if StrToBool(QuickStartWizard.Shortcuts.Items[j -1].SubItems[1]) then
        begin
          EmitAddCommand('Create Shortcut', '"' +
            TargetDirEx + 
            '","' + QuickStartWizard.Shortcuts.Items[j -1].Caption + '","' +
            '$PLATFORMMENU$","Link to ' + 
            ExtractFileName(QuickStartWizard.Shortcuts.Items[j -1].SubItems[0]) + '","","' +
            ExtractFilePath(TargetDirEx) +
            '","","","0"'); 
          LastShort := TargetDirEx; 
        end;
        
      end;
    
    if QuickStartWizard.Extension.Text <> '' then
    begin
      TargetDir := QuickStartWizard.Extension.Text;
      TargetDir := StringReplace(TargetDir, '.', '', [rfReplaceAll, rfIgnoreCase]);
      TargetDirEx := AssertDir(ExtractFilePath(QuickStartWizard.OpenWith.Text)); 
      Delete(TargetDirEx, 1, Length(AssertDir(QuickStartWizard.Files.Text))); 
      TargetDirEx := AssertDir('$TARGETDIR$' + '/' + TargetDirEx)
        + ExtractFileName(QuickStartWizard.OpenWith.Text);
      EmitAddCommand('Create File Type', 
        '"' + TargetDir + ' File' + '",' +
        '"' + TargetDirEx + '",' +
        '"' + TargetDir + ' Document",' + 
        '"",' +
        '"",' +
        '.' + TargetDir + ',' +
        '"""Open,""""""""""""%1"""""""""""",,,"""'); 
    end;
    EmitAddCommand('End', ''); 
    EmitAddCommand('Comment', '"TO-DO: Insert any additional install commands here"'); 
    
    EmitAddCommand('Apply Changes', '"progress","SUCCESS","TRUE","FALSE"'); 
    
    EmitAddCommand('Set Variable', '"PROGRESS","100"'); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('Code Folding Region', '"FALSE",""'); 
    EmitAddCommand('Code Folding Region', '"FALSE",""'); 
    EmitAddCommand('Comment', '""'); 
    
    EmitAddCommand('Code Folding Region', '"TRUE","Finish Setup"'); 
    lY.Add('Finish Setup'); 
    EmitAddCommand('Comment', '"End of Installation"'); 
    EmitAddCommand('Hide Dialog', ''); 
    EmitAddCommand('Display Dialog', '"finish","WIZARD","TRUE","","TRUE","FALSE"'); 
    EmitAddCommand('If', '"SILENT","0","FALSE","FALSE"'); 
    
    EmitAddCommand('If', '"RUNAPP","0","TRUE","FALSE"'); 
    EmitAddCommand('If', '"REMOVE","0","FALSE","FALSE"'); 
    EmitAddCommand('If', '"SUCCESS","0","COMPLETE","FALSE"'); 
    EmitAddCommand('Comment', '"TO-DO: Insert command that starts your application here"'); 
    if LastShort <> '' then
    begin
      
      LastShort := StringReplace(LastShort, '.exe', '', [rfReplaceAll, rfIgnoreCase]);
      
      if AnsiPos('.app', AnsiLowerCase(LastShort)) <> 0 then
        System.Delete(LastShort, AnsiPos('.app', AnsiLowerCase(LastShort)) , Length(LastShort));
      
      LastShort := LastShort + '$APPEXTENSION$';
      EmitAddCommand('Run Program', '"' + LastShort + '","FALSE","","FALSE",""'); 
      
    end;
    EmitAddCommand('End', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('End', ''); 
    EmitAddCommand('Code Folding Region', '"FALSE",""'); 
    EmitAddCommand('Comment', '""'); 
    
    for i := 1 to GetTotalLines do
      Breakpoints.Add('');
    
    UI.SaveExistingProject(PROJDIR);
    FinalizeScript(PROJDIR + ProjectName.Text + '.miax'); 
    lY.SaveToFile(PROJDIR + ProjectName.Text + '.fldx', TEncoding.UTF8); 
    lY.Free;
    
    UI.LoadProject(PROJDIR + ProjectName.Text + '.mprx'); 
    
    if QuickStartWizard.BuildNow.Checked then
      UI.Build1Click(Self);
  end;
end;

procedure TNewProject.SaveProjectIntoFolder;
begin
  ProjectStruct.Name := ProjectName.Text;
  PROJDIR := AssertDir(ProjectFolder.Text);
  if Subfolder.Checked then PROJDIR := PROJDIR + ProjectName.Text + PathDelim;
  ScriptFile := ProjectName.Text + '.miax';
  CurrentProjectName := PROJDIR + ProjectName.Text + '.mprx';
  UI.SaveExistingProject(PROJDIR);
  UI.AdjustUIProjectChanged;
  UI.AddToMRUF(CurrentProjectName);
end;

procedure TNewProject.CloneTemplateProject(Location: String);
var
  src, trg: TextFile;
  s, sX, sY, sZ, sZZ: String;
  i: Integer;
  l: TStringList;
  sMPR, sMIA: String;
  BOM: Char;
  hDef: TCursor;
begin
  if not DirectoryExists(Location) then
  begin
    Application.MessageBox(PChar(SThisItemHasNotBeenInstalledCreat),
      PChar(Application.Title), mb_Ok + mb_IconExclamation);
    CreateFailsafeProject;
    Exit;
  end;
  hDef := Screen.Cursor;
  Screen.Cursor := crHourGlass;
  s := AssertDir(ProjectFolder.Text);
  if Subfolder.Checked then s := s + ProjectName.Text + PathDelim;
  l := FindAllFilesEx(AssertDir(Location) + '*', false);
  for i := 1 to l.Count do
    FileCopyFile(PChar(l[i -1]), PChar(s + ExtractFileName(l[i -1])), false);
  
  sMIA := s + MyCreateGuid + '.miax'; 
  RenameFile(s + ExtractFileName(DeAssertDir(Location))
    + '.miax', sMIA); 
  sMPR := s + MyCreateGuid + '.mprx'; 
  RenameFile(s + ExtractFileName(DeAssertDir(Location))
    + '.mprx', sMPR); 
  
  DeleteFile(s + ProjectName.Text + '.miax'); 
  RenameFile(sMIA, s + ProjectName.Text + '.miax'); 
  AssignFile(src, sMPR, cp_utf8);
  AssignFile(trg, s + ProjectName.Text + '.mprx', cp_utf8); 
  sY := s;
  sX := s + ProjectName.Text + '.mprx'; 
  Reset(src);
  if not eof(src) then
  begin
    read(src, BOM);
    if ansicomparetext(BOM, #$FEFF) <> 0 then
    begin
      closefile(src);
      reset(src);
    end;
  end;
  ReWrite(trg);
  ReadLn(src, sZZ);
  if MyFileExists(sY + ProjectName.Text + '.miax') then
    
    WriteLn(trg, ProjectName.Text + '.miax')
  else
    
    WriteLn(trg, sZZ); 
  while not EOF(src) do
  begin
    ReadLn(src, s);
    s := StringReplace(s, '$$$', ProjectName.Text, [rfReplaceAll]);
    if ui.IsValidGuid(s) then 
      s := MyCreateGUID; 
    WriteLn(trg, s);
  end;
  CloseFile(src);
  CloseFile(trg);
  Erase(src);
  if MyFileExists(sY + ProjectName.Text + '.miax') then
    
    sZ := sY + ProjectName.Text + '.miax'
  else
    
    sZ := sY + sZZ;
  AssignFile(src, sZ, cp_utf8); 
  AssignFile(trg, sZ + '.tmp', cp_utf8); 
  Reset(src);
  if not eof(src) then
  begin
    read(src, BOM);
    if ansicomparetext(BOM, #$FEFF) <> 0 then
    begin
      closefile(src);
      reset(src);
    end;
  end;
  ReWrite(trg);
  while not EOF(src) do
  begin
    ReadLn(src, s);
    s := StringReplace(s, '$$$', ProjectName.Text, [rfReplaceAll]);
    WriteLn(trg, s);
  end;
  CloseFile(src);
  CloseFile(trg);
  Erase(src);
  Rename(trg, sZ); 
  l.Free;
  l := FindAllFilesEx(sY + '*.fldx', false); 
  if l.Count <> 0 then
    if MyFileExists(sY + ExtractFileName(DeAssertDir(Location)) + '.miax.fldx') then
      RenameFile(sY +
        ExtractFileName(DeAssertDir(Location)) + '.miax.fldx',
        sY + ProjectName.Text + '.miax.fldx'); 
  l.Free;
  l := FindAllFilesEx(sY + '*.brkx', false); 
  if l.Count <> 0 then
    if MyFileExists(sY + ExtractFileName(DeAssertDir(Location)) + '.miax.brkx') then
      RenameFile(sY +
        ExtractFileName(DeAssertDir(Location)) + '.miax.brkx',
        sY + ProjectName.Text + '.miax.brkx'); 
  l.Free;
  UI.LoadProject(sX);
  Screen.Cursor := hDef;
end;

procedure TNewProject.FormCreate(Sender: TObject);
var
  l: TListItem;
begin
  l := Custom.Items.Add;
  l.Caption := cAddTemplate;
  l.ImageIndex := 32;
  
  l := Wizards.Items.Add;
  l.Caption := SQuickStart;
  l.ImageIndex := 26;
  l := Wizards.Items.Add;
  l.Caption := cPackageAware; 
  l.ImageIndex := 8;
  l := Wizards.Items.Add;
  l.Caption := cClone;
  l.ImageIndex := 9;
  
  l := Templates.Items.Add;
  l.Caption := cBlank;
  l.ImageIndex := 2;
  l := Templates.Items.Add;
  l.Caption := cBlankEx;
  l.ImageIndex := 0;
  l := Templates.Items.Add;
  l.Caption := cSingleClick;
  l.ImageIndex := 36;
  l := Templates.Items.Add;
  l.Caption := SLUASetup;
  l.ImageIndex := 35;
  l := Templates.Items.Add;
  l.Caption := SCDAutorun;
  l.ImageIndex := 9;
  
  l := Samples.Items.Add;
  l.Caption := cFeedback;
  l.ImageIndex := 15;
  l := Samples.Items.Add;
  l.Caption := SOnlineUserAuthentication;
  l.ImageIndex := 18;
  l := Samples.Items.Add;
  l.Caption := cSerial;
  l.ImageIndex := 22;
  l := Samples.Items.Add;
  l.Caption := cLang;
  l.ImageIndex := 16;
  l := Samples.Items.Add;
  l.Caption := cXcode;
  l.ImageIndex := 37;
  l := Samples.Items.Add;
  l.Caption := cAGPT;
  l.ImageIndex := 38;
  l := Samples.Items.Add;
  l.Caption := cSysInfo;
  l.ImageIndex := 39;
  
  l := Converters.Items.Add;
  l.Caption := cIA;
  l.ImageIndex := 33;
  
  l := All.Items.Add;
  l.Caption := SQuickStart;
  l.ImageIndex := 26;
  l := All.Items.Add;
  l.Caption := cPackageAware; 
  l.ImageIndex := 8;
  l := All.Items.Add;
  l.Caption := cClone;
  l.ImageIndex := 9;
  l := All.Items.Add;
  l.Caption := cBlank;
  l.ImageIndex := 2;
  l := All.Items.Add;
  l.Caption := cBlankEx;
  l.ImageIndex := 0;
  l := All.Items.Add;
  l.Caption := cSingleClick;
  l.ImageIndex := 36;
  l := All.Items.Add;
  l.Caption := SLUASetup;
  l.ImageIndex := 35;
  l := All.Items.Add;
  l.Caption := SCDAutorun;
  l.ImageIndex := 9;
  l := All.Items.Add;
  l.Caption := cFeedback;
  l.ImageIndex := 15;
  l := All.Items.Add;
  l.Caption := SOnlineUserAuthentication;
  l.ImageIndex := 18;
  l := All.Items.Add;
  l.Caption := cSerial;
  l.ImageIndex := 22;
  l := All.Items.Add;
  l.Caption := cLang;
  l.ImageIndex := 16;
  l := All.Items.Add;
  l.Caption := cXcode;
  l.ImageIndex := 37;
  l := All.Items.Add;
  l.Caption := cAGPT;
  l.ImageIndex := 38;
  l := All.Items.Add;
  l.Caption := cSysInfo;
  l.ImageIndex := 39;
  l := All.Items.Add;
  l.Caption := cAddTemplate;
  l.ImageIndex := 32;
  l := All.Items.Add;
  l.Caption := cIA;
  l.ImageIndex := 33;
  AllCount := All.Items.Count;
  IconCount := ImageList.Count;
end;

procedure TNewProject.MyClose(Cancel: Boolean = false);
begin
  if Cancel then
    ModalResult := mrCancel
  else
    ModalResult := mrOk;
  NewProject.Hide; 
  ui.PopStatusStack;
end;

procedure TNewProject.CreateFailsafeProject;
begin
  ui.CreateBlankProject(false);
end;

procedure TNewProject.CreateDefaultProject;
begin
  CloneTemplateProject(EXEDIR + 'Templates' + PathDelim + 'Empty Setup'); 
end;

procedure TNewProject.ClearSelectedObjects;
begin
  Wizards.ClearSelection;
  Templates.ClearSelection;
  Converters.ClearSelection;
  All.ClearSelection;
  Samples.ClearSelection;
  Custom.ClearSelection;
  
  WizardsChange(Self, nil, ctState);
end;

procedure TNewProject.RefreshCustomTemplates;
var
  i: Integer;
  s: String;
  li, liX: TListItem;
  l: TStringList;
  ti: TIcon;
begin
  for i := Custom.Items.Count downto 2 do
    Custom.Items[i -1].Delete;
  for i := All.Items.Count downto AllCount +1 do
    All.Items[i -1].Delete;
  GetSpecialFolder($5, s);
  s := AssertDir(s) + 'InstallAware Templates' + PathDelim;
  l := FindAllDirs(s, false);
  for i := 1 to l.Count do
  begin
    li := Custom.Items.Add;
    li.Caption := ExtractFileName(l[i -1]);
    if MyFileExists(AssertDir(l[i -1]) + 'icon.ico') then
    begin
      
      ti := TIcon.Create;
      ti.LoadFromFile(AssertDir(l[i -1]) + 'icon.ico');
      try
        li.ImageIndex := ImageList.AddIcon(ti);
      except
        
        li.ImageIndex := 33;
      end;
      ti.Free;
    end
    else
      li.ImageIndex := 33;
    liX := All.Items.Add;
    liX.Caption := li.Caption;
    liX.ImageIndex := li.ImageIndex;
  end;
end;

function TNewProject.AddCustomTemplate(CloneTemp: String): Boolean;
var
  s, sX, sC: String;
begin
  Result := false;
  
  if ProjectStruct.Name = '' then
  begin
    Application.MessageBox(PChar(SPleaseGiveYourProjectANameFillIn),
      PChar(Application.Title), mb_OK + mb_IconStop);
    ui.Options1Click(Self);
    Exit;
  end;
  
  if not ui.IsProjectNameOK then Exit;
  
  if CloneTemp <> '' then
    sX := 'Would you like to save your most recent changes before cloning the on-disk project?'
  else
    sX := 'Would you like to save your most recent changes before converting the on-disk project to a custom template?';
  sC := ProjectName.Text + ';' + ProjectFolder.Text; 
  if ui.IsDirty then
    if Application.MessageBox(PChar(sX), PChar(Application.Title), mb_YesNo + mb_IconQuestion) = id_Yes then
        if not ui.IsSafeToCloseProject then Exit;
  
  if CloneTemp = '' then
  begin
    GetSpecialFolder($5, s);
    s := AssertDir(s) + 'InstallAware Templates' + PathDelim;
    s := AssertDir(s + ProjectStruct.Name); 
  end
  else
    s := AssertDir(CloneTemp);
  
  if DirectoryExists(s) then
  begin
    if Application.MessageBox(PChar(SSpecifiedFolderAlreadyExistsTUseF + MyLineEnding + MyLineEnding +
      SWarningAllFolderContentsTWillBeEr),
      Brand, mb_YesNo + mb_IconQuestion) = id_No then
      Exit
    else
      WipeFolder(s, True);
  end;
  Result := ui.SaveProjectAsTemplate(CurrentProjectName, PROJDIR, s);
end;

procedure TNewProject.CreateAuthProject;
begin
  CloneTemplateProject(EXEDIR + 'Samples' + PathDelim + 'User Authentication'); 
end;

function TNewProject.AssertURL(URL: String): String;
begin
  Result := '';
  if URL = '' then Exit;
  if URL[Length(URL)] = '/' then
    Result := URL
  else
    URL := URL + '/';
end;

procedure TNewProject.CreateTemplateProject;
var
  s: String;
begin
  GetSpecialFolder($5, s);
  s := AssertDir(s) + 'InstallAware Templates' + PathDelim;
  CloneTemplateProject(s + TemplateName); 
end;

procedure TNewProject.CreateUserModeProject;
begin
  CloneTemplateProject(EXEDIR + 'Templates' + PathDelim + 'User Mode'); 
end;

procedure TNewProject.CreateCDAutorunProject;
begin
  CloneTemplateProject(EXEDIR + 'Templates' + PathDelim + 'Autorun'); 
end;

procedure TNewProject.CreateSingleClickProject;
begin
  CloneTemplateProject(EXEDIR + 'Templates' + PathDelim + 'Single'); 
end;

end.
