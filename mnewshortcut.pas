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
unit mnewshortcut;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils,
  Variants, Classes, Graphics, Controls, Forms,
  Dialogs, ExtCtrls, ImgList, StdCtrls, mvirtualbrowse, mUtils,
  Buttons, ComCtrls;

type
  TNewShortcut = class(TForm)
    OK: TBitBtn;
    Cancel: TBitBtn;
    Timer: TTimer;
    GroupBox1: TGroupBox;
    GroupBox2: TGroupBox;
    StartFolder: TCheckBox;
    Desktop: TCheckBox;
    QuickLaunch: TCheckBox;
    StartTop: TCheckBox;
    Label1: TLabel;
    ShortText: TEdit;
    Label2: TLabel;
    ShortDescription: TEdit;
    Label3: TLabel;
    ShortcutTarget: TEdit;
    BitBtn3: TBitBtn;
    GroupBox3: TGroupBox;
    PinXP: TCheckBox;
    Pin7: TCheckBox;
    Image14: TImage;
    Label55: TLabel;
    Pin8: TCheckBox;
    procedure BitBtn3Click(Sender: TObject);
    procedure OKClick(Sender: TObject);
    procedure FilesDblClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure TimerTimer(Sender: TObject);
    procedure StartTopEnter(Sender: TObject);
    procedure StartFolderEnter(Sender: TObject);
    procedure DesktopEnter(Sender: TObject);
    procedure PinXPClick(Sender: TObject);
    procedure Pin7Click(Sender: TObject);
    procedure QuickLaunchEnter(Sender: TObject);
    procedure Pin8Click(Sender: TObject);
    procedure FormHide(Sender: TObject);
  private
    
  public
    
  end;

var
  NewShortcut: TNewShortcut;
  ShortcutsBrowseSelectedFile: String;
  pinsTop, pinsMenu, pinsDesktop, pinsQuick: String;
  ActiveBox: String;
  Reentry: Boolean;

implementation

{$R *.lfm}

uses
  uGui;

procedure TNewShortcut.TimerTimer(Sender: TObject);
var
  b: Boolean;
begin
  Timer.Enabled := false;
  b := false;
  if StartTop.Checked then b := True;
  if StartFolder.Checked then b := True;
  if Desktop.Checked then b := True;
  if QuickLaunch.Checked then b := True;
  OK.Enabled := (b and (ShortText.Text <> ''));
  Timer.Enabled := True;
end;

procedure TNewShortcut.FormCreate(Sender: TObject);
begin
  Timer.Interval := 100;
  Timer.Enabled := True;
end;

procedure TNewShortcut.FormHide(Sender: TObject);
begin
  ui.PopStatusStack;
end;

procedure TNewShortcut.FormShow(Sender: TObject);
begin
  ui.PushStatusStack('Creating new shortcut(s)');
  ShortcutTarget.SetFocus;
  ShortcutsBrowseSelectedFile := '';
end;

procedure TNewShortcut.DesktopEnter(Sender: TObject);
begin
  ActiveBox := 'Desktop';
  Reentry := false;
  PinXP.Checked := Pos('X', pinsDesktop) <> 0;
  Pin7.Checked := Pos('7', pinsDesktop) <> 0;
  Pin8.Checked := Pos('8', pinsDesktop) <> 0;
  Reentry := True;
end;

procedure TNewShortcut.FilesDblClick(Sender: TObject);
begin
  if OK.Enabled then
  begin
    OKClick(Self);
    ModalResult := mrOk;
  end;
end;

procedure TNewShortcut.OKClick(Sender: TObject);
begin
  ShortcutsBrowseSelectedFile := ShortcutTarget.Text;
end;

procedure TNewShortcut.Pin7Click(Sender: TObject);
begin
  if not Reentry then Exit;
  Reentry := false;
  if ActiveBox = '' then
  begin
    Application.MessageBox('Please select at least one shortcut location before tacking pins on top of shortcuts.',
      PChar(Application.Title), mb_Ok + mb_IconExclamation);
    Pin7.Checked := false;
    Reentry := True;
    Exit;
  end;
  if Pin7.Checked then
  begin
    if ActiveBox = 'QuickLaunch' then
      if Pos('7', pinsQuick) = 0 then
        pinsQuick := pinsQuick + '7';
    if ActiveBox = 'StartFolder' then
      if Pos('7', pinsMenu) = 0 then
        pinsMenu := pinsMenu + '7';
    if ActiveBox = 'StartTop' then
      if Pos('7', pinsTop) = 0 then
        pinsTop := pinsTop + '7';
    if ActiveBox = 'Desktop' then
      if Pos('7', pinsDesktop) = 0 then
        pinsDesktop := pinsDesktop + '7';
  end
  else
  begin
    if ActiveBox = 'QuickLaunch' then
      if Pos('7', pinsQuick) <> 0 then
        Delete(pinsQuick, Pos('7', pinsQuick), 1);
    if ActiveBox = 'StartFolder' then
      if Pos('7', pinsMenu) <> 0 then
        Delete(pinsMenu, Pos('7', pinsMenu), 1);
    if ActiveBox = 'StartTop' then
      if Pos('7', pinsTop) <> 0 then
        Delete(pinsTop, Pos('7', pinsTop), 1);
    if ActiveBox = 'Desktop' then
      if Pos('7', pinsDesktop) <> 0 then
        Delete(pinsDesktop, Pos('7', pinsDesktop), 1);
  end;
  Reentry := True;
end;

procedure TNewShortcut.Pin8Click(Sender: TObject);
begin
  if not Reentry then Exit;
  Reentry := false;
  if ActiveBox = '' then
  begin
    Application.MessageBox('Please select at least one shortcut location before tacking pins on top of shortcuts.',
      PChar(Application.Title), mb_Ok + mb_IconExclamation);
    Pin8.Checked := false;
    Reentry := True;
    Exit;
  end;
  if Pin8.Checked then
  begin
    if ActiveBox = 'QuickLaunch' then
      if Pos('8', pinsQuick) = 0 then
        pinsQuick := pinsQuick + '8';
    if ActiveBox = 'StartFolder' then
      if Pos('8', pinsMenu) = 0 then
        pinsMenu := pinsMenu + '8';
    if ActiveBox = 'StartTop' then
      if Pos('8', pinsTop) = 0 then
        pinsTop := pinsTop + '8';
    if ActiveBox = 'Desktop' then
      if Pos('8', pinsDesktop) = 0 then
        pinsDesktop := pinsDesktop + '8';
  end
  else
  begin
    if ActiveBox = 'QuickLaunch' then
      if Pos('8', pinsQuick) <> 0 then
        Delete(pinsQuick, Pos('8', pinsQuick), 1);
    if ActiveBox = 'StartFolder' then
      if Pos('8', pinsMenu) <> 0 then
        Delete(pinsMenu, Pos('8', pinsMenu), 1);
    if ActiveBox = 'StartTop' then
      if Pos('8', pinsTop) <> 0 then
        Delete(pinsTop, Pos('8', pinsTop), 1);
    if ActiveBox = 'Desktop' then
      if Pos('8', pinsDesktop) <> 0 then
        Delete(pinsDesktop, Pos('8', pinsDesktop), 1);
  end;
  Reentry := True;
end;

procedure TNewShortcut.PinXPClick(Sender: TObject);
begin
  if not Reentry then Exit;
  Reentry := false;
  if ActiveBox = '' then
  begin
    Application.MessageBox('Please select at least one shortcut location before tacking pins on top of shortcuts.',
      PChar(Application.Title), mb_Ok + mb_IconExclamation);
    PinXP.Checked := false;
    Reentry := True;
    Exit;
  end;
  if PinXP.Checked then
  begin
    if ActiveBox = 'QuickLaunch' then
      if Pos('X', pinsQuick) = 0 then
        pinsQuick := pinsQuick + 'X';
    if ActiveBox = 'StartFolder' then
      if Pos('X', pinsMenu) = 0 then
        pinsMenu := pinsMenu + 'X';
    if ActiveBox = 'StartTop' then
      if Pos('X', pinsTop) = 0 then
        pinsTop := pinsTop + 'X';
    if ActiveBox = 'Desktop' then
      if Pos('X', pinsDesktop) = 0 then
        pinsDesktop := pinsDesktop + 'X';
  end
  else
  begin
    if ActiveBox = 'QuickLaunch' then
      if Pos('X', pinsQuick) <> 0 then
        Delete(pinsQuick, Pos('X', pinsQuick), 1);
    if ActiveBox = 'StartFolder' then
      if Pos('X', pinsMenu) <> 0 then
        Delete(pinsMenu, Pos('X', pinsMenu), 1);
    if ActiveBox = 'StartTop' then
      if Pos('X', pinsTop) <> 0 then
        Delete(pinsTop, Pos('X', pinsTop), 1);
    if ActiveBox = 'Desktop' then
      if Pos('X', pinsDesktop) <> 0 then
        Delete(pinsDesktop, Pos('X', pinsDesktop), 1);
  end;
  Reentry := True;
end;

procedure TNewShortcut.QuickLaunchEnter(Sender: TObject);
begin
  ActiveBox := 'QuickLaunch';
  Reentry := false;
  PinXP.Checked := Pos('X', pinsQuick) <> 0;
  Pin7.Checked := Pos('7', pinsQuick) <> 0;
  Pin8.Checked := Pos('8', pinsQuick) <> 0;
  Reentry := True;
end;

procedure TNewShortcut.StartFolderEnter(Sender: TObject);
begin
  ActiveBox := 'StartFolder';
  Reentry := false;
  PinXP.Checked := Pos('X', pinsMenu) <> 0;
  Pin7.Checked := Pos('7', pinsMenu) <> 0;
  Pin8.Checked := Pos('8', pinsQuick) <> 0;
  Reentry := True;
end;

procedure TNewShortcut.StartTopEnter(Sender: TObject);
begin
  ActiveBox := 'StartTop';
  Reentry := false;
  PinXP.Checked := Pos('X', pinsTop) <> 0;
  Pin7.Checked := Pos('7', pinsTop) <> 0;
  Pin8.Checked := Pos('8', pinsQuick) <> 0;
  Reentry := True;
end;

procedure TNewShortcut.BitBtn3Click(Sender: TObject);
begin
  VirtualBrowse.BrowseWithTextControl(ShortcutTarget);
  if ShortcutTarget.Text <> '' then
    if ShortText.Text = '' then
      ShortText.Text := ExtractFileNameOnly(ShortcutTarget.Text);
end;

end.
