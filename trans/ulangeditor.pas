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
unit uLangEditor;

{$MODE Delphi}

interface

uses
  mUtils, LCLIntf, LCLType, LMessages, Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ImgList, Menus, ComCtrls, ExtCtrls, ToolWin,  ActnList;

const
  
  ClosedBook = 0;
  OpenBook = 1;
  Page = 2;
  Alpha = 3;
  MagicChar = '"';

type
  TCategory = class(TObject)
    Messages: TStringList;
    ScreenText: String;
  end;

  TTranslator = class(TForm)
    AppEx: TApplicationProperties;
    MainMenu: TMainMenu;
    MenuItem1: TMenuItem;
    MenuItem10: TMenuItem;
    Separator4: TMenuItem;
    MenuItem2: TMenuItem;
    MenuItem3: TMenuItem;
    MenuItem4: TMenuItem;
    MenuItem5: TMenuItem;
    MenuItem6: TMenuItem;
    MenuItem7: TMenuItem;
    MenuItem8: TMenuItem;
    MenuItem9: TMenuItem;
    Separator3: TMenuItem;
    Separator2: TMenuItem;
    Separator1: TMenuItem;
    Splitter: TSplitter;
    List: TListView;
    LoResImages: TImageList;
    Status: TStatusBar;
    CoolBar: TCoolBar;
    Container: TPanel;
    Tree: TTreeView;
    Panel: TPanel;
    TopPanel: TPanel;
    TreeMenu: TPopupMenu;
    Actions: TActionList;
    New: TAction;
    Rename: TAction;
    Delete: TAction;
    Grid: TAction;
    Help: TAction;
    New1: TMenuItem;
    Rename1: TMenuItem;
    Delete1: TMenuItem;
    N1: TMenuItem;
    Help1: TMenuItem;
    ListPopup: TPopupMenu;
    Grid1: TMenuItem;
    N3: TMenuItem;
    Help2: TMenuItem;
    ToolBarMenu: TToolBar;
    FileMenu: TPopupMenu;
    New2: TMenuItem;
    Rename2: TMenuItem;
    Delete2: TMenuItem;
    N4: TMenuItem;
    Exit1: TMenuItem;
    ViewMenu: TPopupMenu;
    Grid2: TMenuItem;
    HelpMenu: TPopupMenu;
    Help3: TMenuItem;
    ToolButton4: TToolButton;
    ToolButton5: TToolButton;
    ToolButton6: TToolButton;
    ToolButton7: TToolButton;
    ToolButton10: TToolButton;
    ToolButton11: TToolButton;
    ToolButton12: TToolButton;
    Version: TAction;
    Version1: TMenuItem;
    N2: TMenuItem;
    HiResImages: TImageList;
    Revert: TAction;
    Revert1: TMenuItem;
    Revert2: TMenuItem;
    ToolButton8: TToolButton;
    procedure AppExException(Sender: TObject; E: Exception);
    procedure FormCreate(Sender: TObject);
    procedure TreeExpanded(Sender: TObject; Node: TTreeNode);
    procedure TreeEditing(Sender: TObject; Node: TTreeNode;
      var AllowEdit: Boolean);
    procedure TreeEdited(Sender: TObject; Node: TTreeNode; var S: String);
    procedure TreeKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure HelpExecute(Sender: TObject);
    procedure GridExecute(Sender: TObject);
    procedure RenameExecute(Sender: TObject);
    procedure DeleteExecute(Sender: TObject);
    procedure NewExecute(Sender: TObject);
    procedure TreeChange(Sender: TObject; Node: TTreeNode);
    procedure ListEditing(Sender: TObject; Item: TListItem;
      var AllowEdit: Boolean);
    procedure ListKeyUp(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ListDblClick(Sender: TObject);
    procedure FormResize(Sender: TObject);
    procedure ListEdited(Sender: TObject; Item: TListItem; var S: String);
    procedure Exit1Click(Sender: TObject);
    procedure VersionExecute(Sender: TObject);
    procedure RevertExecute(Sender: TObject);
    procedure ActionsUpdate(Action: TBasicAction; var Handled: Boolean);
    procedure Action1Execute(Sender: TObject);
  private
    procedure Note(Note: String);
    function Ask(Ask: String): Boolean;
    function AddLanguageNode(Name: String): TTreeNode;
    procedure UpdateClient;
  public
    function GetLanguageList: TStrings;
    procedure MapLanguageTree;
    function GetGrid: Boolean;
    procedure SetGrid(Enabled: Boolean);
    procedure LoadLanguageStrings(Name: String);
    procedure LoadOriginalLanguageStrings;
    procedure SaveLanguageStrings(Name: String);
    procedure UpdateList(Language, Selection: String);
  end;

  procedure InitializeMasterGrid;
  procedure FinalizeMasterGrid;

var
  Translator: TTranslator;
  MasterGrid: TStringList;
  EXE: String;

implementation

resourcestring
  SUseTheTranslatorToCreateProductV = 'Use the Translator to create product versions in any language:';
  S1ClickNewAndTypeInTheNameOfYourL = '1. Click "New", and type in the name of your language.';
  S2ClickEachOfTheCategoriesDisplay = '2. Click each of the categories displayed under your language, and translate each string under the categories.';
  SHintPressF2ToEditSelectedText = 'Hint: Press F2 to edit selected text.';
  SInstallAwareTranslator = 'InstallAware Translator';
  SAreYouSureYouWantToDeleteLanguag = 'Are you sure you want to delete language "';
  SThisIsTheLastAvailableLanguageTh = 'This is the last available language. There must at least be one language available at all times!';
  SDeletedLanguage = 'Deleted language "';
  STranslationsNewLanguage = 'translations.New Language';
  STranslationsNewLanguage_1 = 'translations.New Language (';
  SNewLanguage = 'New Language';
  SStringCategoriesFor = 'String Categories for ';
  SStringTranslation = 'String Translation (';
  SStringMeaningEnglish = 'String Meaning (English)';
  SViewing = 'Viewing ';
  SStringCategories = ' string categories';
  SStringsIn = ' strings (in ';
  SEditingString = 'Editing string "';
  SFinishedEditingString = 'Finished editing string "';
  SVersion = 'Version ';

{$R *.lfm}

function TTranslator.GetGrid: Boolean;
var
  t: TextFile;
  s: String;
begin
  if FileExists(EXE + 'grid.msin') then
  begin
    AssignFile(t, EXE + 'grid.msin'); 
    Reset(t);
    ReadLn(t, s);
    CloseFile(t);
    
  end;
  Result := MyStrToBool(s); 
end;

function TTranslator.GetLanguageList: TStrings;
var
  i: Integer;
begin
  Result := mUtils.FindAllFilesEx(EXE + 'translations.*', false); 
  for i := Result.Count downto 1 do
  begin
    Result[i -1] := ExtractFileExtOnly(Result[i -1]);
    if ((Result[i -1] = 'Definition') or (Result[i -1] = 'Original')) or 
      ((Result[i -1] = 'Map') or (Result[i -1] = '')) then Result.Delete(i -1); 
  end;
  TStringList(Result).Sorted:= True;
end;

procedure TTranslator.SaveLanguageStrings(Name: String);
var
  t, mt: TextFile;
  ms: String;
  mb: TStringList;
begin

  AssignFile(t, EXE + 'translations.' + Name, cp_utf8) 
  ; 
 ReWrite(t);
 
  AssignFile(mt, EXE + 'translations.Map');
  Reset(mt);

  while not EOF(mt) do
  begin
    ReadLn(mt, ms);
    mb := TCategory(MasterGrid.Objects[MasterGrid.IndexOf(ms)]).Messages;
    WriteLn(t, mb[0]);
    mb.Delete(0);
  end;
  CloseFile(t);
  CloseFile(mt);
end;

procedure TTranslator.SetGrid(Enabled: Boolean);
var
  t: TextFile;
begin
  AssignFile(t, EXE + 'grid.msin'); 
  ReWrite(t);
  WriteLn(t, Enabled);
  CloseFile(t);
end;

procedure TTranslator.FormCreate(Sender: TObject);
begin
  
  if True then
  begin
    Tree.Images := HiResImages;
    List.SmallImages := HiResImages;
  end
  else
  begin
    Tree.Images := LoResImages;
    List.SmallImages := LoResImages;
  end;
  
  Grid.Checked := GetGrid;
  List.GridLines := GetGrid;
  MapLanguageTree;
  Tree.Selected := Tree.Items[0];
  LoadOriginalLanguageStrings;
end;

procedure TTranslator.AppExException(Sender: TObject;
  E: Exception);
begin
  
end;

procedure TTranslator.LoadLanguageStrings(Name: String);
var
  i: Integer;
  t, mt: TextFile;
  ms, s: String;
  
begin
  
  AssignFile(t, EXE + 'translations.' + Name, cp_utf8); 
  Reset(t);
  
  AssignFile(mt, EXE + 'translations.Map');

  Reset(mt);
  for i := 1 to MasterGrid.Count do
    if Pos(MagicChar, MasterGrid[i -1]) = 0 then 
      TCategory(MasterGrid.Objects[i -1]).Messages.Clear;
  while not EOF(t) do
  begin
    ReadLn(t, s);
    ReadLn(mt, ms);
    TCategory(MasterGrid.Objects[MasterGrid.IndexOf(ms)]).Messages.Add(s);
  end;
  CloseFile(t);
  CloseFile(mt);
end;

procedure TTranslator.LoadOriginalLanguageStrings;
var
  i: Integer;
  t, mt: TextFile;
  ms, s: String;
begin
  AssignFile(t, EXE + 'translations.Original'); 
  Reset(t);
  AssignFile(mt, EXE + 'translations.Map'); 
  Reset(mt);
  for i := 1 to MasterGrid.Count do
    if Pos(MagicChar, MasterGrid[i -1]) <> 0 then 
      TCategory(MasterGrid.Objects[i -1]).Messages.Clear;
  while not EOF(t) do
  begin
    ReadLn(t, s);
    ReadLn(mt, ms);
    TCategory(MasterGrid.Objects[MasterGrid.IndexOf(ms + MagicChar)]).Messages.Add(s);
  end;
  CloseFile(t);
  CloseFile(mt);
end;

procedure TTranslator.MapLanguageTree;
var
  i: Integer;
  l: TStrings;
begin
  Tree.Items.BeginUpdate;
  Tree.Items.Clear;
  l := GetLanguageList;
  for i := 1 to l.Count do
    AddLanguageNode(l[i -1]);
  Tree.Items.EndUpdate;
  l.Free;
end;

procedure TTranslator.TreeExpanded(Sender: TObject; Node: TTreeNode);
var
  i: Integer;
begin
  if Node.Parent = nil then
  begin
    if Node.Expanded then i := OpenBook
      else i := ClosedBook;
    Node.ImageIndex := i;
    Node.SelectedIndex := i;
  end;
  Tree.Repaint;
end;

procedure TTranslator.TreeEditing(Sender: TObject; Node: TTreeNode;
  var AllowEdit: Boolean);
begin
  AllowEdit := Node.Parent = nil;
end;

procedure TTranslator.TreeEdited(Sender: TObject; Node: TTreeNode;
  var S: String);
begin
  if not RenameFile(EXE + 'translations.' + Node.Text, EXE + 'translations.' + s) then 
  begin
    s := Node.Text;
    Exit;
  end;
  UpdateClient;
  if Tree.Selected.ImageIndex = Page then
    UpdateList(s, Tree.Selected.Text)
  else
    UpdateList(s, s);
end;

procedure TTranslator.TreeKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if Key = 113 then
    RenameExecute(Self);
  if Key = 46 then
    DeleteExecute(Self);
end;

procedure TTranslator.HelpExecute(Sender: TObject);
begin
  Note(SUseTheTranslatorToCreateProductV + #13#13 +
    SHintPressF2ToEditSelectedText);
end;

procedure TTranslator.GridExecute(Sender: TObject);
begin
  Grid.Checked := not Grid.Checked;
  List.GridLines := Grid.Checked;
  SetGrid(Grid.Checked);
end;

procedure TTranslator.RenameExecute(Sender: TObject);
begin
  if Tree.Selected.Parent = nil then
    Tree.Selected.EditText
  else
    Tree.Selected.Parent.EditText;
end;

function TTranslator.Ask(Ask: String): Boolean;
begin
  Result := Application.MessageBox(PChar(Ask), PChar(SInstallAwareTranslator), mb_YesNo + mb_IconQuestion) = id_Yes;
end;

procedure TTranslator.Note(Note: String);
begin
  Application.MessageBox(PChar(Note), PChar(SInstallAwareTranslator), mb_Ok + mb_IconInformation);
end;

procedure TTranslator.DeleteExecute(Sender: TObject);
var
  s: String;
begin
  if Tree.Selected.Parent = nil then
    s := Tree.Selected.Text
  else
    s := Tree.Selected.Parent.Text;
  if Ask(SAreYouSureYouWantToDeleteLanguag + s + '"?') then
  begin
    if Tree.Items.Count = 5 then
    begin
      Note(SThisIsTheLastAvailableLanguageTh);
      Exit;
    end;
    DeleteFile(EXE + 'translations.' + s); 
    UpdateClient;
    Status.SimpleText := SDeletedLanguage + s + '".';
    if s = Tree.Selected.Text then
      Tree.Selected.Delete
    else
      Tree.Selected.Parent.Delete;  
  end;
end;

procedure TTranslator.NewExecute(Sender: TObject);
var
  i: Integer;
  n: TTreeNode;
  s: String;
begin
  s := '';
  if FileExists(EXE + STranslationsNewLanguage) then
    for i := 1 to MAXINT do
    begin
      if not FileExists(EXE + STranslationsNewLanguage_1 + IntToStr(i) + ')') then
      begin
        s := ' (' + IntToStr(i) + ')';
        Break;
      end;
    end;
  FileCopyFile(PChar(EXE + 'translations.Original'), PChar(EXE + STranslationsNewLanguage + s), false); 
  UpdateClient;
  n := AddLanguageNode(SNewLanguage + s);
  Tree.Selected := n;
  n.Expanded := True;
  n.EditText;
end;

function TTranslator.AddLanguageNode(Name: String): TTreeNode;
var
  i: Integer;
  n: TTreeNode;
begin
  Result := Tree.Items.Add(nil, Name);
  Result.ImageIndex := ClosedBook;
  Result.SelectedIndex := ClosedBook;
  for i := 1 to MasterGrid.Count do
    if Pos(MagicChar, MasterGrid[i -1]) = 0 then
    begin
      n := Tree.Items.AddChild(Result, TCategory(MasterGrid.Objects[i -1]).ScreenText);
      n.ImageIndex := Page;
      n.SelectedIndex := Page;
    end;
end;

procedure TTranslator.UpdateList(Language, Selection: String);
var
  l: TListItem;
  t, ot: TStrings;
  i: Integer;
begin
  List.Items.BeginUpdate;
  List.Items.Clear;
  if Selection = Language then
  begin
    List.Columns.Clear;
    List.Columns.Add;
    List.Columns[0].Width := (List.Width -4);
    List.Columns[0].Caption := SStringCategoriesFor + Language;
    for i := 1 to MasterGrid.Count do
      if Pos(MagicChar, MasterGrid[i -1]) = 0 then
      begin
        l := List.Items.Add;
        l.Caption := TCategory(MasterGrid.Objects[i -1]).ScreenText;
        l.ImageIndex := Page;
      end;
  end
  else
  begin
    List.Columns.Clear;
    List.Columns.Add;
    List.Columns.Add;
    List.Columns[0].Width := (List.Width -4) div 2;
    List.Columns[0].Caption := SStringTranslation + Language + ')';
    List.Columns[1].Width := (List.Width -4) div 2;
    List.Columns[1].Caption := SStringMeaningEnglish;
    t := nil;
    ot := nil;
    for i := 1 to MasterGrid.Count do
      if Pos(MagicChar, MasterGrid[i -1]) = 0 then 
      begin
        if TCategory(MasterGrid.Objects[i -1]).ScreenText = Tree.Selected.Text then
          t := TCategory(MasterGrid.Objects[i -1]).Messages;
      end
      else 
      begin
        if TCategory(MasterGrid.Objects[i -1]).ScreenText = Tree.Selected.Text then
          ot := TCategory(MasterGrid.Objects[i -1]).Messages;
      end;
    for i := 1 to t.Count do
    begin
      l := List.Items.Add;
      l.Caption := t[i -1];
      l.ImageIndex := -1;
      l.SubItems.Add(ot[i -1]);
    end;
  end;
  List.Items.EndUpdate;
  List.Repaint;
end;

procedure TTranslator.TreeChange(Sender: TObject; Node: TTreeNode);
var
  s: String;
begin
  if Tree.Selected.Parent = nil then
    s := Tree.Selected.Text
  else
    s := Tree.Selected.Parent.Text;
  LoadLanguageStrings(s);
  UpdateList(s, Tree.Selected.Text);
  if Tree.Selected.Parent = nil then
    Status.SimpleText := SViewing + Tree.Selected.Text + SStringCategories
  else
    Status.SimpleText := SViewing + Tree.Selected.Text + SStringsIn + s + ')';
end;

procedure TTranslator.ListEditing(Sender: TObject; Item: TListItem;
  var AllowEdit: Boolean);
begin
  AllowEdit := Item.ImageIndex <> Page;
  if AllowEdit then Status.SimpleText := SEditingString + List.Selected.SubItems[0] + '"';
end;

procedure TTranslator.ListKeyUp(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if (Key = 113) and (List.Selected <> nil) then
    List.Selected.EditCaption;
  if (Key = 8) and (Tree.Selected.Parent <> nil) then
    if not List.IsEditing then
      Tree.Selected := Tree.Selected.Parent;
  if (Key = 13) and (Tree.Selected.Parent = nil) then
    ListDblClick(Self);
end;

procedure TTranslator.ListDblClick(Sender: TObject);
var
  i: Integer;
begin
  if List.Selected = nil then Exit;
  if Tree.Selected.Parent = nil then
  begin
    for i := 1 to Tree.Selected.Count do
      if Tree.Selected.Items[i -1].Text = List.Selected.Caption then
      begin
        Tree.Selected := Tree.Selected.Items[i -1];
        Exit;
      end;
  end;
  if Tree.Selected.Parent <> nil then
    List.Selected.EditCaption;
end;

procedure TTranslator.FormResize(Sender: TObject);
begin
  if List.Columns.Count = 1 then
    List.Columns[0].Width := List.Width -4
  else if List.Columns.Count = 2 then
  begin
    List.Columns[0].Width := (List.Width -4) div 2;
    List.Columns[1].Width := (List.Width -4) div 2;
  end;
end;

procedure TTranslator.ListEdited(Sender: TObject; Item: TListItem;
  var S: String);
var
  i: Integer;
  t: TStringList;
begin
  t := nil;
  for i := 1 to MasterGrid.Count do
    if AnsiPos(MagicChar, MasterGrid[i -1]) = 0 then 
      if TCategory(MasterGrid.Objects[i -1]).ScreenText = Tree.Selected.Text then
      begin
        t := TCategory(MasterGrid.Objects[i -1]).Messages;
        Break;
      end;
  t[List.Selected.Index] := s;
  List.Selected.ImageIndex := Alpha;
  SaveLanguageStrings(Tree.Selected.Parent.Text);
  LoadLanguageStrings(Tree.Selected.Parent.Text);
  Status.SimpleText := SFinishedEditingString + List.Selected.SubItems[0] + '"';
end;

procedure TTranslator.Exit1Click(Sender: TObject);
begin
  Application.Terminate;
end;

procedure TTranslator.UpdateClient;
begin
end;

procedure TTranslator.VersionExecute(Sender: TObject);
begin
  Note(SVersion + 'Multi Platform');
end;

procedure FinalizeMasterGrid;
var
  i: Integer;
begin
  for i := 1 to MasterGrid.Count do
  begin
    TCategory(MasterGrid.Objects[i -1]).Messages.Free;
    MasterGrid.Objects[i -1].Free;
  end;  
end;

procedure InitializeMasterGrid;
var
  c: TCategory;
  t: TextFile;
  i, j: Integer;
  s: String;
begin
  AssignFile(t, ExtractFilePath(EXE) + 'translations.Definition'); 
  Reset(t);
  while not EOF(t) do
  begin
    ReadLn(t, s);
    i := MasterGrid.Add(s);
    j := MasterGrid.Add(s + MagicChar);
    ReadLn(t, s);
    c := TCategory.Create;
    c.Messages := TStringList.Create;
    c.ScreenText := s;
    MasterGrid.Objects[i] := c;
    c := TCategory.Create;
    c.Messages := TStringList.Create;
    c.ScreenText := s;
    MasterGrid.Objects[j] := c;
  end;
  CloseFile(t);
end;

procedure TTranslator.RevertExecute(Sender: TObject);
var
  s: String;
begin
  if (List.Selected = nil) or (Tree.Selected.Parent = nil) then Exit;
  s := List.Selected.SubItems[0];
  List.Selected.Caption := s;
  List.OnEdited(Self, List.Selected, s);
end;

procedure TTranslator.ActionsUpdate(Action: TBasicAction;
  var Handled: Boolean);
begin
  Revert.Enabled := (List.Selected <> nil) and (Tree.Selected.Parent <> nil);
end;

procedure TTranslator.Action1Execute(Sender: TObject);
begin
  Application.Terminate;
end;

initialization
  EXE := ExtractFilePath(MyParamStr(0));
  {$IFDEF DARWIN}
  EXE := AssertDir(ExtractFilePath(DeAssertDir(ExtractFilePath(DeAssertDir(ExtractFilePath(DeAssertDir(EXE)))))));
  {$ENDIF}
  
  MasterGrid := TStringList.Create;
  InitializeMasterGrid;

finalization
  
  FinalizeMasterGrid;
  MasterGrid.Free;

end.

