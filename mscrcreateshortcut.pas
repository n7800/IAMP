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
unit mscrcreateshortcut;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  Messages, SysUtils,
  Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, mvirtualbrowse, ExtCtrls;

type
  TscrCreateShortcut = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    Target: TEdit;
    Label2: TLabel;
    Source: TEdit;
    Label3: TLabel;
    Params: TEdit;
    Label4: TLabel;
    Startup: TEdit;
    Label5: TLabel;
    Description: TEdit;
    Label6: TLabel;
    IconPath: TEdit;
    Label7: TLabel;
    IconIndex: TEdit;
    Label8: TLabel;
    WindowSize: TComboBox;
    Label9: TLabel;
    Button1: TButton;
    OpenDialog: TOpenDialog;
    Location: TComboBox;
    BitBtn3: TBitBtn;
    PinXP: TCheckBox;
    Pin7: TCheckBox;
    Label10: TLabel;
    Label11: TLabel;
    AppUserID: TEdit;
    DoNot: TCheckBox;
    Pin8: TCheckBox;
    RunAs: TCheckBox;
    NoAuto: TCheckBox;
    Label12: TLabel;
    NoPin: TCheckBox;
    Bevel1: TBevel;
    Bevel2: TBevel;
    procedure BitBtn3Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure Button1Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure Pin8Click(Sender: TObject);
    procedure Pin7Click(Sender: TObject);
    procedure PinXPClick(Sender: TObject);
    procedure NoPinClick(Sender: TObject);
    procedure NoAutoClick(Sender: TObject);
  private
    
  public
    
  end;

var
  scrCreateShortcut: TscrCreateShortcut;
  AllowBypass: Boolean = True; 

implementation

{$IFnDEF FPC}
  {$R *.lfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

uses
  uGui;

procedure TscrCreateShortcut.FormHide(Sender: TObject);
begin
  AllowBypass := True;
end;

procedure TscrCreateShortcut.FormShow(Sender: TObject);
var
  i: Integer;
  s: String;
  sl: TStringList;
begin
  AllowBypass := false;
  s := Location.Text;
  Location.Items.Clear;
  Location.Items.Add('$TARGETDIR$'); 
  sl := TStringList.Create;
  sl.Add('$TARGETDIR$'); 
  for i := 1 to uGui.GetFolderLocation.Count do
    if (i -1) mod 4 = 0 then
      if sl.IndexOf('$' + AnsiUpperCase(uGui.GetFolderLocation[(i -1) +1]) + '$') = -1 then
      begin
        Location.Items.Add('$' + uGui.GetFolderLocation[(i -1) +1] + '$');
        sl.Add('$' + AnsiUpperCase(uGui.GetFolderLocation[(i -1) +1]) + '$');
      end;
  sl.Free;
  s := scrForceValue; 
  Location.Text := s;
  Target.SetFocus;
end;

procedure TscrCreateShortcut.NoAutoClick(Sender: TObject);
begin
  if AllowBypass then Exit;
  if NoAuto.Checked then
    Pin8.Checked := false;
end;

procedure TscrCreateShortcut.NoPinClick(Sender: TObject);
begin
  if AllowBypass then Exit;
  if NoPin.Checked then
  begin
    PinXP.Checked := false;
    Pin7.Checked := false;
    Pin8.Checked := false;
  end;
end;

procedure TscrCreateShortcut.Pin7Click(Sender: TObject);
begin
  if AllowBypass then Exit;
  if Pin7.Checked then
    NoPin.Checked := false;
end;

procedure TscrCreateShortcut.Pin8Click(Sender: TObject);
begin
  if AllowBypass then Exit;
  if Pin8.Checked then
  begin
    NoAuto.Checked := false;
    NoPin.Checked := false;
  end;
end;

procedure TscrCreateShortcut.PinXPClick(Sender: TObject);
begin
  if AllowBypass then Exit;
  if PinXP.Checked then
    NoPin.Checked := false;
end;

procedure TscrCreateShortcut.Button1Click(Sender: TObject);
begin
  if DirectoryExists(ExtractFilePath(IconPath.Text)) then
    OpenDialog.InitialDir := ExtractFilePath(IconPath.Text);
  if OpenDialog.Execute then
    IconPath.Text := OpenDialog.FileName;
end;

procedure TscrCreateShortcut.BitBtn3Click(Sender: TObject);
begin
  VirtualBrowse.BrowseWithTextControl(Target);
end;

end.

