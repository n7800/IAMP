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
unit mideoptions;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils, mUtils,
  Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ComCtrls,
  ExtCtrls, Registry, FileCtrl, ColorBox;

type
  TIDEOptions = class(TForm)
    PageControl1: TPageControl;
    TabSheet1: TTabSheet;
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    Label1: TLabel;
    FontDialog: TFontDialog;
    Sample: TPanel;
    ChangeFont: TButton;
    TabSheet2: TTabSheet;
    Label2: TLabel;
    Element: TComboBox;
    GroupBox1: TGroupBox;
    Bold: TCheckBox;
    Italic: TCheckBox;
    Underline: TCheckBox;
    Label3: TLabel;
    Color: TColorBox;
    Script: TListBox;
    Label4: TLabel;
    ColorBack: TColorBox;
    CodeFolding: TCheckBox;
    Label5: TLabel;
    Image14: TImage;
    NoFold: TImage;
    YesFold: TImage;
    TabSheet3: TTabSheet;
    Tips: TCheckBox;
    Label6: TLabel;
    TipsEx: TCheckBox;
    Label7: TLabel;
    Caution: TImage;
    Regular: TImage;
    Export: TCheckBox;
    Image1: TImage;
    Label8: TLabel;
    Bevel1: TBevel;
    Multiples: TCheckBox;
    TabSheet4: TTabSheet;
    EnableVSS: TCheckBox;
    VSSVersion: TComboBox;
    Label9: TLabel;
    Image2: TImage;
    Label10: TLabel;
    VMs: TTabSheet;
    PageControl2: TPageControl;
    TabSheet5: TTabSheet;
    TabSheet6: TTabSheet;
    Label11: TLabel;
    VMPaths: TListBox;
    AddVM: TButton;
    VMCred: TButton;
    ClearVMs: TButton;
    RemoveVM: TButton;
    Label12: TLabel;
    AddHyperVM: TButton;
    HyperVMCred: TButton;
    ClearHyperVMs: TButton;
    RemoveHyperVM: TButton;
    HyperVMPaths: TListBox;
    TabSheet7: TTabSheet;
    Label13: TLabel;
    sVMPaths: TListBox;
    AddsVM: TButton;
    sVMCred: TButton;
    ClearsVMs: TButton;
    RemovesVM: TButton;
    CodeCompletion: TCheckBox;
    EmitElse: TCheckBox;
    procedure CodeFoldingClick(Sender: TObject);
    procedure ChangeFontClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure ColorBackChange(Sender: TObject);
    procedure ScriptDrawItem(Control: TWinControl; Index: Integer;
      Rect: TRect; State: TOwnerDrawState);
    procedure ElementChange(Sender: TObject);
    procedure ScriptClick(Sender: TObject);
    procedure BoldClick(Sender: TObject);
    procedure ItalicClick(Sender: TObject);
    procedure UnderlineClick(Sender: TObject);
    procedure ColorChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormHide(Sender: TObject);
    procedure CodeCompletionClick(Sender: TObject);
  private
    
  public
    procedure ReflectSelection;
  end;

var
  IDEOptions: TIDEOptions;
  ActiveFont: TFont;
  pxfontComment, pxfontStatement, pxfontLabel, pxfontFlowControl,
  pxfontDirective, pxfontPlugIn, pxfontWindowsInstaller, pxfontModifySystem,
  pxfontLine: TFont;
  ActivateVM: Boolean = false;
  VMW: Boolean = false;
  VMHV: Boolean = false;
  VMVS: Boolean = false;

implementation

uses
  uGui, mproject;

{$R *.lfm}

procedure TIDEOptions.ChangeFontClick(Sender: TObject);
begin
  FontDialog.Font := Sample.Font;
  if FontDialog.Execute then
    Sample.Font := FontDialog.Font;
end;

procedure TIDEOptions.FormShow(Sender: TObject);
begin
  ui.PushStatusStack('Editing IDE options');
  ColorBack.Selected := Script.Color;
  Script.ItemIndex := 0;
  ScriptClick(Self);
  CodeFoldingClick(Self);
  CodeCompletionClick(Self);
  if ActivateVM then
  begin
    PageControl1.ActivePageIndex := 4;
    if VMW then
      PageControl2.ActivePageIndex := 0;
    if VMHV then
      PageControl2.ActivePageIndex := 1;
    if VMVS then
      PageControl2.ActivePageIndex := 2;
  end
  else
    PageControl1.ActivePageIndex := 0;
end;

procedure TIDEOptions.ColorBackChange(Sender: TObject);
begin
  Script.Color := ColorBack.Selected;
end;

procedure TIDEOptions.ScriptDrawItem(Control: TWinControl; Index: Integer;
  Rect: TRect; State: TOwnerDrawState);
var
  i, j: Integer;
begin
  
  i := 24;
  for j := 1 to Index do
    if (AnsiPos('IF', Script.Items[j -1]) = 1) or 
      (AnsiPos('WIZARD LOOP', Script.Items[j -1]) = 1) then 
      i := i + 12;
  for j := 1 to Index +1 do
    if AnsiPos('END', Script.Items[j -1]) = 1 then 
      if i > 24 then
        i := i - 12;
  
  with (Control as TListBox).Canvas do
  begin
    FillRect(Rect);
    Font.Color := pxfontLine.Color;
    Font.Style := pxfontLine.Style;
    if IsDarkModeAppearance then
      Font.Color := InvertColor(Font.Color);
    TextOut(Rect.Left + 2, Rect.Top, IntToStr(Index +1));
    Font.Style := [];
    if AnsiPos(CommentConst, Script.Items[Index]) = 1 then
    begin
      Font.Color := pxfontComment.Color;
      Font.Style := pxfontComment.Style;
    end
    else
    if AnsiPos('CHECK/', Script.Items[Index]) = 1 then 
    begin
      Font.Color := pxfontPlugIn.Color;
      Font.Style := pxfontPlugIn.Style;
    end
    else
    if AnsiPos('IF', Script.Items[Index]) = 1 then 
    begin
      Font.Color := pxfontFlowControl.Color;
      Font.Style := pxfontFlowControl.Style;
    end
    else
    if AnsiPos('END', Script.Items[Index]) = 1 then 
    begin
      Font.Color := pxfontFlowControl.Color;
      Font.Style := pxfontFlowControl.Style;
    end
    else
    if AnsiPos('APPLY' 
      , Script.Items[Index]) = 1 then
    begin
      Font.Color := pxfontModifySystem.Color;
      Font.Style := pxfontModifySystem.Style;
    end
    else
    if AnsiPos('INSTALL FILES' 
      , Script.Items[Index]) = 1 then
    begin
      Font.Color := pxfontWindowsInstaller.Color;
      Font.Style := pxfontWindowsInstaller.Style;
    end
    else
    if AnsiPos('[DEFINE WEB MEDIA' 
      , Script.Items[Index]) = 1 then
      begin
        Font.Color := pxfontDirective.Color;
        Font.Style := pxfontDirective.Style;
        i := 24;
      end
    else
    if AnsiPos('LABEL: ' 
      , Script.Items[Index]) = 1 then
      begin
        Font.Color := pxfontLabel.Color;
        Font.Style := pxfontLabel.Style;
        i := 24;
      end
    else
    begin
      Font.Color := pxfontStatement.Color;
      Font.Style := pxfontStatement.Style;
    end;
    if IsDarkModeAppearance then
      Font.Color := InvertColor(Font.Color);
    TextOut(Rect.Left + i, Rect.Top, (Control as TListBox).Items[Index]);
	end;
end;

procedure TIDEOptions.ReflectSelection;
begin
  case Script.ItemIndex of
    0: ActiveFont := pxfontComment;
    1: ActiveFont := pxfontFlowControl;
    2: ActiveFont := pxfontPlugIn;
    3: ActiveFont := pxfontDirective;
    4: ActiveFont := pxfontWindowsInstaller;
    5: ActiveFont := pxfontModifySystem;
    6: ActiveFont := pxfontFlowControl;
    7: ActiveFont := pxfontLabel;
    8: ActiveFont := pxfontStatement;
  end;
  Color.Selected := ActiveFont.Color;
  Bold.Checked := fsBold in ActiveFont.Style;
  Italic.Checked := fsItalic in ActiveFont.Style;
  Underline.Checked := fsUnderline in ActiveFont.Style;
end;

procedure TIDEOptions.ElementChange(Sender: TObject);
begin
  case Element.ItemIndex of
    0: Script.ItemIndex := 0;
    1: Script.ItemIndex := 8;
    2: Script.ItemIndex := 7;
    3: Script.ItemIndex := 1;
    4: Script.ItemIndex := 3;
    5: Script.ItemIndex := 2;
    6: Script.ItemIndex := 4;
    7: Script.ItemIndex := 5;
  end;
  ScriptClick(Self);
end;

procedure TIDEOptions.ScriptClick(Sender: TObject);
begin
  case Script.ItemIndex of
    0: Element.ItemIndex := 0;
    8: Element.ItemIndex := 1;
    7: Element.ItemIndex := 2;
    1: Element.ItemIndex := 3;
    3: Element.ItemIndex := 4;
    2: Element.ItemIndex := 5;
    4: Element.ItemIndex := 6;
    5: Element.ItemIndex := 7;
    6: Element.ItemIndex := 3;
  end;
  ReflectSelection;
end;

procedure TIDEOptions.BoldClick(Sender: TObject);
begin
  if Bold.Checked then
    ActiveFont.Style := ActiveFont.Style + [fsBold]
  else
    ActiveFont.Style := ActiveFont.Style - [fsBold];
  Script.Refresh;
end;

procedure TIDEOptions.ItalicClick(Sender: TObject);
begin
  if Italic.Checked then
    ActiveFont.Style := ActiveFont.Style + [fsItalic]
  else
    ActiveFont.Style := ActiveFont.Style - [fsItalic];
  Script.Refresh;
end;

procedure TIDEOptions.UnderlineClick(Sender: TObject);
begin
  if Underline.Checked then
    ActiveFont.Style := ActiveFont.Style + [fsUnderline]
  else
    ActiveFont.Style := ActiveFont.Style - [fsUnderline];
  Script.Refresh;
end;

procedure TIDEOptions.ColorChange(Sender: TObject);
begin
  ActiveFont.Color := Color.Selected;
  Script.Refresh;
end;

procedure TIDEOptions.FormCreate(Sender: TObject);
begin
  pxfontComment := TFont.Create;
  pxfontStatement := TFont.Create;
  pxfontLabel := TFont.Create;
  pxfontFlowControl := TFont.Create;
  pxfontDirective := TFont.Create;
  pxfontPlugIn := TFont.Create;
  pxfontWindowsInstaller := TFont.Create;
  pxfontModifySystem := TFont.Create;
  pxfontLine := TFont.Create;
  VSSVersion.Items.Clear;
end;

procedure TIDEOptions.FormDestroy(Sender: TObject);
begin
  pxfontComment.Free;
  pxfontStatement.Free;
  pxfontLabel.Free;
  pxfontFlowControl.Free;
  pxfontDirective.Free;
  pxfontPlugIn.Free;
  pxfontWindowsInstaller.Free;
  pxfontModifySystem.Free;
  pxfontLine.Free;
end;

procedure TIDEOptions.FormHide(Sender: TObject);
begin
  ui.PopStatusStack;
end;

procedure TIDEOptions.CodeCompletionClick(Sender: TObject);
begin
  EmitElse.Enabled := CodeCompletion.Checked;
end;

procedure TIDEOptions.CodeFoldingClick(Sender: TObject);
begin
  NoFold.Visible := not CodeFolding.Checked;
  YesFold.Visible := CodeFolding.Checked;
end;

end.

