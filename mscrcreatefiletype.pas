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
unit mscrcreatefiletype;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils,
  
  Variants, Classes, Graphics, Controls, Forms,
  inifiles, Dialogs, StdCtrls, Buttons, ComCtrls, ExtCtrls, mvirtualbrowse;

type
  TscrCreateFileType = class(TForm)
    PageControl: TPageControl;
    TabSheet1: TTabSheet;
    TabSheet2: TTabSheet;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Label2: TLabel;
    OpensWith: TEdit;
    Label3: TLabel;
    Description: TEdit;
    TabSheet3: TTabSheet;
    Label4: TLabel;
    Label5: TLabel;
    AddExt: TEdit;
    Label6: TLabel;
    ExtensionsList: TListBox;
    Button1: TButton;
    Button2: TButton;
    Button3: TButton;
    Label7: TLabel;
    Verbs: TListView;
    Label8: TLabel;
    Label9: TLabel;
    IconFile: TEdit;
    IconNumber: TEdit;
    Label10: TLabel;
    DDECommandLabel: TLabel;
    DDECommand: TEdit;
    Label12: TLabel;
    Parameters: TEdit;
    Replace: TButton;
    Add: TButton;
    Delete: TButton;
    FileType: TEdit;
    DDEApplicationLabel: TLabel;
    DDEApplication: TEdit;
    DDETopicLabel: TLabel;
    DDETopic: TEdit;
    Label15: TLabel;
    Verb: TComboBox;
    Timer: TTimer;
    Image1: TImage;
    Image2: TImage;
    BitBtn3: TBitBtn;
    Label11: TLabel;
    Default: TRadioButton;
    AllUsers: TRadioButton;
    CurrentUser: TRadioButton;
    Image3: TImage;
    Label13: TLabel;
    Label14: TLabel;
    OpenWithProgIDs: TCheckBox;
    UserChoice: TCheckBox;
    procedure BitBtn3Click(Sender: TObject);
    procedure VerbsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure ReplaceClick(Sender: TObject);
    procedure DeleteClick(Sender: TObject);
    procedure AddClick(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Button2Click(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure Button3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
  private
    
  public
    function xGetListViewFlat(List: TListView): String;
    procedure xSetListViewFlat(List: TListView; Flat: String);
  end;

var
  scrCreateFileType: TscrCreateFileType;
  FlatBuffer: String;

implementation

{$R *.lfm}

uses
  uGui;

resourcestring
  SAreYouSureYouWantToClearTheListO = 'Are you sure you want to clear the list of all file extensions associated with this fle type?';

procedure TscrCreateFileType.FormShow(Sender: TObject);
var
  Kind: String;
begin
  Kind := Caption;
  scrCreateFileType.DDECommandLabel.Visible := Kind = 'Create File Type'; 
  scrCreateFileType.DDECommand.Visible := Kind = 'Create File Type'; 
  scrCreateFileType.DDEApplicationLabel.Visible := Kind = 'Create File Type'; 
  scrCreateFileType.DDEApplication.Visible := Kind = 'Create File Type'; 
  scrCreateFileType.DDETopicLabel.Visible := Kind = 'Create File Type'; 
  scrCreateFileType.DDETopic.Visible := Kind = 'Create File Type'; 
  scrCreateFileType.AddExt.Text := '';
  scrCreateFileType.Verb.Text := '';
  scrCreateFileType.Parameters.Text := '';
  scrCreateFileType.DDECommand.Text := '';
  scrCreateFileType.DDEApplication.Text := '';
  scrCreateFileType.DDETopic.Text := '';
  xSetListViewFlat(Verbs, FlatBuffer);
  
  scrCreateFileType.Default.Visible := Kind = 'Create File Type'; 
  scrCreateFileType.AllUsers.Visible := Kind = 'Create File Type'; 
  scrCreateFileType.CurrentUser.Visible := Kind = 'Create File Type'; 
  
  scrCreateFileType.Label11.Visible := Kind = 'Create File Type'; 
  scrCreateFileType.Label13.Visible := Kind = 'Create File Type'; 
  scrCreateFileType.Image3.Visible := Kind = 'Create File Type'; 
  
  PageControl.ActivePage := TabSheet1;
  FileType.SetFocus;
  Timer.Enabled := True;
end;

function TscrCreateFileType.xGetListViewFlat(List: TListView): String;
var
  l, lX: TStringList;
  i, j: Integer;
  loc: TLVChangeEvent;
begin
  loc := List.OnChange;
  List.OnChange := nil;
  try
    l := TStringList.Create;
    lX := TStringList.Create;
    for i := 1 to List.Items.Count do
    begin
      lX.Clear;
      lX.Add(List.Items[i -1].Caption);
      for j := 1 to List.Items[i -1].SubItems.Count do
        lX.Add(List.Items[i -1].SubItems[j -1]);
      l.Add(lX.CommaText);
    end;
    Result := l.CommaText;
    lX.Free;
    l.Free;
  finally
    List.OnChange := loc;
  end;
end;

procedure TscrCreateFileType.xSetListViewFlat(List: TListView; Flat: String);
var
  l, lX: TStringList;
  li: TListItem;
  i, j: Integer;
  loc: TLVChangeEvent;
begin
  loc := List.OnChange;
  List.OnChange := nil;
  try
    l := TStringList.Create;
    lX := TStringList.Create;
    List.Items.BeginUpdate;
    List.Items.Clear;
    l.CommaText := Flat;
    for i := 1 to l.Count do
    begin
      lX.CommaText := l[i -1];
      for j := 1 to lX.Count do
        if j = 1 then
        begin
          li := List.Items.Add;
          li.Caption := lX[j -1];
        end
        else
          li.SubItems.Add(lX[j -1]);
    end;
    List.Items.EndUpdate;
    lX.Free;
    l.Free;
  finally
    List.OnChange := loc;
  end;
end;

procedure TscrCreateFileType.Button3Click(Sender: TObject);
var
  s: String;
begin
  s := AddExt.Text; 
  if AnsiPos('.', s) <> 1 then
    s := '.' + s;
  if ExtensionsList.Items.IndexOf(s) = -1 then
    ExtensionsList.Items.Add(s);
end;

procedure TscrCreateFileType.Button1Click(Sender: TObject);
begin
  ExtensionsList.DeleteSelected;
end;

procedure TscrCreateFileType.Button2Click(Sender: TObject);
begin
  if Application.MessageBox(PChar(SAreYouSureYouWantToClearTheListO),
    PChar(Caption), mb_YesNo + mb_IconQuestion) = id_Yes then
    ExtensionsList.Items.Clear;
end;

procedure TscrCreateFileType.FormHide(Sender: TObject);
begin
  Timer.Enabled := false;
  FlatBuffer := xGetListViewFlat(Verbs);
end;

procedure TscrCreateFileType.TimerTimer(Sender: TObject);
begin
  Replace.Enabled := Verbs.Selected <> nil;
  Delete.Enabled := Verbs.Selected <> nil;
  Add.Enabled := (Verb.Text <> '');
end;

procedure TscrCreateFileType.AddClick(Sender: TObject);
var
  i: Integer;
  li: TListItem;
  ParametersText, DDECommandText, DDEApplicationText, DDETopicText: String;
begin
  
  ParametersText := Parameters.Text;
  DDECommandText := DDECommand.Text;
  DDEApplicationText := DDEApplication.Text;
  DDETopicText := DDETopic.Text;
  for i := 1 to Verbs.Items.Count do
    if AnsiLowerCase(Verbs.Items[i -1].Caption) = AnsiLowerCase(Verb.Text) then Exit;
  li := Verbs.Items.Add;
  li.Caption := Verb.Text;
  li.SubItems.Add(ParametersText);
  li.SubItems.Add(DDECommandText);
  li.SubItems.Add(DDEApplicationText);
  li.SubItems.Add(DDETopicText);
end;

procedure TscrCreateFileType.DeleteClick(Sender: TObject);
begin
  Verbs.Selected.Delete;
end;

procedure TscrCreateFileType.ReplaceClick(Sender: TObject);
begin
  Verbs.Selected.Caption := Verb.Text;
  Verbs.Selected.SubItems[0] := Parameters.Text;
  Verbs.Selected.SubItems[1] := DDECommand.Text;
  Verbs.Selected.SubItems[2] := DDEApplication.Text;
  Verbs.Selected.SubItems[3] := DDETopic.Text;
end;

procedure TscrCreateFileType.VerbsChange(Sender: TObject; Item: TListItem;
  Change: TItemChange);
begin
  if Verbs.Selected = nil then Exit;
  Verb.Text := Verbs.Selected.Caption;
  Parameters.Text := Verbs.Selected.SubItems[0];
  DDECommand.Text := Verbs.Selected.SubItems[1];
  DDEApplication.Text := Verbs.Selected.SubItems[2];
  DDETopic.Text := Verbs.Selected.SubItems[3];
end;

procedure TscrCreateFileType.BitBtn3Click(Sender: TObject);
begin
  VirtualBrowse.BrowseWithTextControl(OpensWith);
end;

end.

