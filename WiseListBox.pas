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
unit WiseListBox;

{$mode objfpc}{$H+}

interface

uses
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, LResources, LMessages, LCLType, LCLIntf, mUtils, ExtCtrls;

type
  TWiseListBox = class;

  TAddRemoveNotify = procedure(Sender: TWiseListBox;
    Index: Integer; Add: Boolean) of object;

  TAddCommandNotify = procedure(Sender: TWiseListBox;
    Index: Integer; Command: String) of object;

  TWiseListBoxCombo = class(TComboBox)
  private
    
    FListBox: TWiseListBox;
    FSelectionIndex: Integer;
    AlreadyHid: Boolean;
  protected
    
    procedure KeyPress(var Key: Char); override;
    
  published
    property SelectionIndex: Integer read FSelectionIndex write FSelectionIndex;
  end;

  TWiseListBox = class(TListBox)
  private
    
    FSignalIndent: Boolean;
    FInternalIndent: Integer;
    FBackupInternalIndent: Integer;
    FDownIndex: Integer;
    FCommandCacheCommaText: String;
    IsDown: Boolean;
    {$IFNDEF LINUX}
    FInPlaceCombo: TWiseListBoxCombo;
    {$ELSE}
    FInPlaceCombo: TComboBox;
    FAlreadyHid: Boolean;
    FSelectionIndex: Integer;
    FSetFocusTimer: TTimer;
    {$ENDIF}
    FOnAddRemoveNotify: TAddRemoveNotify;
    FOnAddCommandNotify: TAddCommandNotify;
    FCaret: TBitmap;
    FCaretFocus: Boolean;
  protected
    
    procedure Click; override;
    procedure dblClick; override;
    procedure KeyPress(var Key: Char); override;
    procedure KeyUp(var Key: Word; Shift: TShiftState); override;
    procedure Loaded; override;
    procedure CNDrawItem(var Message: TLMDrawItems); message CN_DRAWITEM;
    procedure WMKillFocus(var Message: TMessage); message WM_KILLFOCUS;
    procedure WMSetFocus(var Message: TMessage); message WM_SETFOCUS;
  public
    {$IFDEF LINUX}
    procedure FSetFocusTimerTimer(Sender: TObject);
    {$ENDIF}
    
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure InPlaceComboExit(Sender: TObject);
    function VisibleContrast(BackGroundColor : TColor):TColor;
    {$IFDEF LINUX}
    procedure Reassign;
    procedure ReKeyPress(var Key: Char);
    procedure ReExit;
    {$ENDIF}
  published
    
    property CommandCacheCommaText: String read FCommandCacheCommaText write FCommandCacheCommaText;
    property OnAddRemovePlaceholder: TAddRemoveNotify read FOnAddRemoveNotify write FOnAddRemoveNotify;
    property OnAddCommand: TAddCommandNotify read FOnAddCommandNotify write FOnAddCommandNotify;
    property InternalIndent: Integer read FInternalIndent write FInternalIndent;
    property SignalIndent: Boolean read FSignalIndent write FSignalIndent;
    property CaretFocus: Boolean read FCaretFocus;
    {$IFDEF LINUX}
    property CommandCombo: TComboBox read FInPlaceCombo write FInPlaceCombo;
    {$ENDIF}
  end;

{$IFDEF DARWIN}
{$IFDEF CPUAARCH64}

{$ENDIF}
{$ENDIF}

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('MSIN', [TWiseListBox]);
end;

constructor TWiseListBox.Create(AOwner: TComponent);
begin
  inherited;
  {$IFNDEF LINUX}
  FInPlaceCombo := TWiseListBoxCombo.Create(Self);
  FInPlaceCombo.Parent := Self;
  FInPlaceCombo.Hide;
  FInPlaceCombo.FListBox := Self;
  FInPlaceCombo.OnExit := @InPlaceComboExit;
  FInPlaceCombo.Sorted := True;
  FInPlaceCombo.AutoComplete := True;
  isDown := false;
  {$ELSE}
  FSetFocusTimer := TTimer.Create(Self);
  FSetFocusTimer.Interval := 100;
  FSetFocusTimer.OnTimer := @FSetFocusTimerTimer;
  {$ENDIF}
  FSignalIndent := True; 
end;

destructor TWiseListBox.Destroy;
begin
  {$IFNDEF LINUX}
  FInPlaceCombo.Free;
  {$ENDIF}
  inherited;
end;

procedure TWiseListBox.KeyPress(var Key: Char);
var
  r: TRect;
  i, j{$IFDEF LINUX}, k{$ENDIF}, l: Integer;
  b: Boolean;
begin
  if not Enabled then Exit; 
  
  if FSignalIndent then
  begin
    
    l := FInternalIndent; 
    FBackupInternalIndent := FInternalIndent;
    FSignalIndent := false;
  end
  else
    l := FBackupInternalIndent;
  {$IFDEF LINUX}
  k := l;
  {$ENDIF}
  FInPlaceCombo.Items.CommaText := FCommandCacheCommaText;
  b := false;
  for i := 1 to FInPlaceCombo.Items.Count do
    if Pos(AnsiLowerCase(Key), AnsiLowerCase(FInPlaceCombo.Items[i -1])) = 1 then
    begin
      {$IFDEF DARWIN}
      {$IFDEF CPUAARCH64}
      
      {$ENDIF}
      {$ENDIF}
      j := ItemIndex;
      if not Assigned(FOnAddRemoveNotify) then
        ClearSelection;
      if j = -1 then
      begin
        if Assigned(FOnAddRemoveNotify) then
          FOnAddRemoveNotify(Self, j, True)
        else
          Items.Add('');
        j := 0;
      end
      else
      begin
        if Assigned(FOnAddRemoveNotify) then
          FOnAddRemoveNotify(Self, j, True)
        else
          Items.Insert(j, '');
      end;
      Selected[j] := True;
      ItemIndex := j;
      {$IFDEF LINUX}
      FAlreadyHid := false;
      FSelectionIndex := j;
      {$ELSE}
      FInPlaceCombo.AlreadyHid := false;
      FInPlaceCombo.SelectionIndex := j;
      {$ENDIF}
      r := ItemRect(j);
      {$IFDEF LINUX}
      
      FInPlaceCombo.Left := k + Self.Left; 
      FInPlaceCombo.Width := Self.Width - FInPlaceCombo.Left;
      if r.Top < 0 then
        FInPlaceCombo.Top := Self.Top
      else
        FInPlaceCombo.Top := r.Top + Self.Top;
      FInPlaceCombo.Height := r.Bottom - r.Top;
      {$ELSE}
      r.Left := l; 
      
      {$IFNDEF WINDOWS}
      r.Width := Self.Width - l{$IFDEF DARWIN} - {$IFDEF CPUAARCH64}20{$ELSE}10{$ENDIF}{$ENDIF}; 
      {$ENDIF}
      
      FInPlaceCombo.BoundsRect := r;
      {$ENDIF}
      FInPlaceCombo.Text := FInPlaceCombo.Items[i -1];
      FInPlaceCombo.Font.Assign(Self.Font);
      FInPlaceCombo.Show;
      FInPlaceCombo.BringToFront;
      FInPlaceCombo.SetFocus;
      {$IFNDEF LINUX}
      FInPlaceCombo.SetSelStart(1);
      FInPlaceCombo.SetSelLength(Length(FInPlaceCombo.Text) -1);
      {$ELSE}
      FInPlaceCombo.SelStart := 1;
      FInPlaceCombo.SelLength := Length(FInPlaceCombo.Text) -1;
      {$ENDIF}
      b := True;
      Break;
    end;
  Key := #0;
  inherited;
end;

procedure TWiseListBox.KeyUp(var Key: Word; Shift: TShiftState);
begin
  inherited;
end;

procedure TWiseListBox.Loaded;
begin
  inherited;
end;

procedure TWiseListBox.Click;
begin
  inherited;
  isDown := false;
  if Assigned(onClick) then
    onClick(Self);
end;

procedure TWiseListBox.dblClick;
begin
  isDown := false;
  if Assigned(onDblClick) then
    onDblClick(Self);
end;

procedure TWiseListBox.InPlaceComboExit(Sender: TObject);
var
  c: Char;
begin
  c := Char(VK_ESCAPE);
  {$IFDEF LINUX}
  if not FAlreadyHid then
    FInPlaceCombo.OnKeyPress(Self, c);
  {$ELSE}
  if not FInPlaceCombo.AlreadyHid then
    FInPlaceCombo.KeyPress(c);
  {$ENDIF}
end;

procedure TWiseListBox.CNDrawItem(var Message: TLMDrawItems);
var
  State: TOwnerDrawState;
  FCanvas: TCanvas;
begin
  with Message.DrawItemStruct^ do
  begin
    FCanvas := Canvas;
    State := TOwnerDrawState(itemState);
    FCanvas.Font := Font;
    FCanvas.Brush := Brush;
    if ((Integer(itemID) >= 0) and (odSelected in State)) and
      (not (odFocused in State) or (SelCount > 1)) then
    begin
      FCanvas.Brush.Color := clHighlight;
      FCanvas.Font.Color := clHighlightText
    end;
    if Integer(itemID) >= 0 then
      DrawItem(itemID, rcItem, State) else
      FCanvas.FillRect(rcItem);
    if odFocused in State then FCanvas.DrawFocusRect(rcItem);
    FCanvas.Handle := 0;
  end;
end;

procedure TWiseListBox.WMSetFocus(var Message: TMessage);
begin
  inherited;
  FCaret := TBitmap.Create;
  FCaret.Canvas.Brush.Color := VisibleContrast(clHighlight);
  FCaret.PixelFormat := pf24bit;
  FCaret.Width := GetSystemMetrics(SM_CXBORDER) *2;
  FCaret.Height := ItemHeight;
  
  CreateCaret(Handle, 0, GetSystemMetrics(SM_CXBORDER) *2, ItemHeight);
  ShowCaret(Handle);
  FCaretFocus := True;
end;

{$IFDEF LINUX}
procedure TWiseListBox.FSetFocusTimerTimer(Sender: TObject);
begin
  FSetFocusTimer.Enabled := false;
  SetFocus;
end;
{$ENDIF}

procedure TWiseListBox.WMKillFocus(var Message: TMessage);
begin
  FCaretFocus := false;
  HideCaret(Handle);
  DestroyCaret(Handle);
  FreeAndNil(FCaret);
  inherited;
end;

function TWiseListBox.VisibleContrast(BackGroundColor: TColor): TColor;
const
  cHalfBrightness = ((0.3 * 255.0) + (0.59 * 255.0) + (0.11 * 255.0)) / 2.0;
var
  Brightness: Double;
begin
  with TRGBQuad(BackGroundColor) do
    BrightNess := (0.3 * rgbRed) + (0.59 * rgbGreen) + (0.11 * rgbBlue);
  if (Brightness>cHalfBrightness) then
    Result := clBlack
  else
    Result := clWhite;
end;

procedure TWiseListBoxCombo.KeyPress(var Key: Char);
var
  Index: Integer;
  i: Integer;
  b: Boolean;
begin
  b := True;
  if Key = Char(VK_RETURN) then
  begin
    for i := 1 to Items.Count do
      if CompareText(Items[i -1], Text) = 0 then
      begin
        Key := #0;
        AlreadyHid := True; 
        Enabled := false;
        if Assigned(FListBox.OnAddCommand) then
          FListBox.OnAddCommand(FListBox, SelectionIndex, Items[i -1])
        else
          FListBox.Items[SelectionIndex] := Text;
        Hide;
        Enabled := True;
        FListBox.SetFocus;
        b := false;
        Break;
      end;
  end
  else
  if Key = Char(VK_ESCAPE) then
  begin
    if Assigned(FListBox.OnAddRemovePlaceholder) then
      FListBox.OnAddRemovePlaceholder(
        FListBox, SelectionIndex, false)
    else
      FListBox.Items.Delete(SelectionIndex);
    AlreadyHid := True;
    Hide;
    FListBox.SetFocus;
    b := false;
  end
  else
  begin
    b := True;
  end;
  if (not b and (FListBox.Items.Count > 0)) and
    (not Assigned(FListBox.FOnAddRemoveNotify)) then
  begin
    FListBox.ClearSelection;
    FListBox.Selected[SelectionIndex] := True;
    FListBox.ItemIndex := SelectionIndex;
  end;
  inherited;
end;

{$IFDEF LINUX}
procedure TWiseListBox.Reassign;
begin
  
  FInPlaceCombo.Hide;
  
  FInPlaceCombo.OnExit := @InPlaceComboExit;
  FInPlaceCombo.Sorted := True;
  FInPlaceCombo.AutoComplete := True;
  isDown := false;
end;

procedure TWiseListBox.ReKeyPress(var Key: Char);
var
  Index: Integer;
  i: Integer;
  b: Boolean;
begin
  b := True;
  if Key = Char(VK_RETURN) then
  begin
    for i := 1 to FInPlaceCombo.Items.Count do
      if CompareText(FInPlaceCombo.Items[i -1], FInPlaceCombo.Text) = 0 then
      begin
        Key := #0;
        FAlreadyHid := True; 
        Enabled := false;
        if Assigned(OnAddCommand) then
          OnAddCommand(Self, FSelectionIndex, FInPlaceCombo.Items[i -1])
        else
          Items[FSelectionIndex] := FInPlaceCombo.Text;
        FInPlaceCombo.Hide;
        Enabled := True;
        SetFocus;
        b := false;
        Break;
      end;
  end
  else
  if Key = Char(VK_ESCAPE) then
  begin
    
    if Assigned(OnAddRemovePlaceholder) then
      OnAddRemovePlaceholder(
        Self, FSelectionIndex, false)
    else
      Items.Delete(FSelectionIndex);
    FAlreadyHid := True;
    FInPlaceCombo.Hide;
    FSetFocusTimer.Enabled := True;
    b := false;
  end
  else
  begin
    b := True;
  end;
  if (not b and (Items.Count > 0)) and
    (not Assigned(FOnAddRemoveNotify)) then
  begin
    ClearSelection;
    Selected[FSelectionIndex] := True;
    ItemIndex := FSelectionIndex;
  end;
  inherited;
end;

procedure TWiseListBox.ReExit;
var
  c: Char;
begin
  c := Char(VK_ESCAPE);
  if not FAlreadyHid then
    ReKeyPress(c);
end;
{$ENDIF}

end.
