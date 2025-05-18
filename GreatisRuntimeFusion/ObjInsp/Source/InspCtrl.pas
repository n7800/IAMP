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

unit InspCtrl;

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
  {$DEFINE VERSION3}
{$ENDIF}

{$IFDEF VER100}
  {$DEFINE VERSION3}
{$ENDIF}
{$IFDEF VER110}
  {$DEFINE VERSION3}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Mask, Windows,
{$ELSE}
  Masks, MaskEdit, LCLIntf, LCLType, LMessages,
{$ENDIF}
  SysUtils, Classes, TypInfo, Messages, Controls, StdCtrls,
  Dialogs, Graphics, ExtCtrls, Forms;

{$IFDEF FPC}
const
   WM_CHARTOITEM = LM_CHARTOITEM;
   WM_VKEYTOITEM = LM_VKEYTOITEM;
   WM_NCLBUTTONUP = LM_NCLBUTTONUP;
   WM_RBUTTONUP = LM_RBUTTONUP;
   WM_MOVE = LM_MOVE;
   WM_NCMOUSEMOVE = LM_NCMOUSEMOVE;
   WM_NCLBUTTONDOWN = LM_NCLBUTTONDOWN;
   WM_MOUSEWHEEL = LM_MOUSEWHEEL;
   WM_RBUTTONDBLCLK = LM_RBUTTONDBLCLK;
   WM_MBUTTONDBLCLK = LM_MBUTTONDBLCLK;
   WM_NCLBUTTONDBLCLK = LM_NCLBUTTONDBLCLK;
   WM_RBUTTONDOWN = LM_RBUTTONDOWN;
  
{$ENDIF}

type
  TCustomInspector = class;

  TButtonType = (btNone,btDropDown,btUpDown,btDialog);

  TInplaceEditorType = (ieNone,ieEdit,ieCheckBox{$IFDEF GOICUSTOMEDIT},ieCustomEdit{$ENDIF});

  TExpandState = (esNone,esExpand,esCollapse);

  TInspectorPopup = class(TListBox)
  private
    FInspector: TCustomInspector;
    
  protected
    procedure DrawItem(TheIndex: Integer; Rect: TRect; State: TOwnerDrawState); override;
    procedure WndProc(var Message: TMessage); override;
    procedure CreateParams(var Params: TCreateParams); override;
  public
    constructor Create(AOwner: TComponent); override;
    property Inspector: TCustomInspector read FInspector write FInspector;
  end;

  TInspectorEdit = class(TMaskEdit)
  private
    FEditing: Boolean;
    FInspector: TCustomInspector;
    
  protected
    {$IFDEF FPC}
    procedure CMChildKey(var Message: TCMChildKey); message CM_CHILDKEY;
    procedure CNKeyDown(var Message: TLMKeyDown); message CN_KEYDOWN;
    procedure CNSysKeyDown(var Message: TLMKeyDown); message CN_SYSKEYDOWN;
    {$ENDIF}

    procedure WndProc(var Message: TMessage); override;
    procedure KeyPress(var Key: Char); override;
    procedure Change; override;
    property Inspector: TCustomInspector read FInspector write FInspector;
  end;

  TInspectorCheckBox = class(TCheckBox)
  private
    
  protected
    FInspector: TCustomInspector;
    procedure Click; override;
    property Inspector: TCustomInspector read FInspector write FInspector;
  end;

  TInspectorButton = class(TCustomControl)
  private
    FDown: Boolean;
    FButtonType: TButtonType;
    FDropDown: TBitmap;
    FUpDown: TBitmap;
    FDialog: TBitmap;
    FInspector: TCustomInspector;
    procedure SetDown(const Value: Boolean);
    procedure SetButtonType(const Value: TButtonType);
    
  protected
    procedure WndProc(var Message: TMessage); override;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Paint; override;

    property Down: Boolean read FDown write SetDown;
    property ButtonType: TButtonType read FButtonType write SetButtonType;
    property Inspector: TCustomInspector read FInspector write FInspector;
  end;

  TDragKind = (dkNone,dkItem,dkSplitter);

  TItemAction = (iaDoubleClick,iaButtonClick);

  TPaintStyle = (psClassic,psTree,psGreatis);

  TValidateCharEvent = function(Sender: TObject; TheIndex: Integer; var Key: Char): Boolean of object;
  TGetStringEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: string) of object;
  TSetStringEvent = procedure(Sender: TObject; TheIndex: Integer; const Value: string) of object;
  TButtonTypeEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: TButtonType) of object;
  TInplaceEditorTypeEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: TInplaceEditorType) of object;
  {$IFDEF GOICUSTOMEDIT}
  TInplaceEditorEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: TComponent) of object;
  {$ENDIF}
  TBooleanEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: Boolean) of object;
  TExpandStateEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: TExpandState) of object;
  TIntegerEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: Integer) of object;
  TPointerEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: Pointer) of object;
  TColorEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: TColor) of object;
  TFontEvent = procedure(Sender: TObject; TheIndex: Integer; const TheFont: TFont) of object;
  TStringsEvent = procedure(Sender: TObject; TheIndex: Integer; const Strings: TStrings) of object;
  TEditEvent = procedure(Sender: TObject; TheIndex: Integer; const Strings: TStrings) of object;
  TCallEditorEvent = function(Sender: TObject; TheIndex: Integer): Boolean of object;
  TCallEditorEnableEvent = function(Sender: TObject; TheIndex: Integer; var EnableDefault: Boolean): Boolean of object;
  TIndexNotifyEvent = procedure(Sender: TObject; TheIndex: Integer) of object;
  TIndexDrawEvent = procedure(Sender: TObject; TheIndex: Integer; TheCanvas: TCanvas; TheRect: TRect) of object;
  TDrawPopupItemEvent = procedure(Sender: TObject; TheIndex: Integer; ListBox: TCustomListBox; ListItemIndex: Integer; TheRect: TRect) of object;
  TIndexEnableEvent = procedure(Sender: TObject; TheIndex: Integer; var EnableDefault: Boolean) of object;
  TChangeValueEvent = procedure(Sender: TObject; TheIndex: Integer; Editing: Boolean; const Value: string) of object;

  TCustomInspector = class(TCustomListBox)
  private
    FCheckBox: TInspectorCheckBox;
    {$IFDEF GOICUSTOMEDIT}
    FDefaultEdit: TInspectorEdit;
    {$ENDIF}
    FEdit: TInspectorEdit;
    FButton: TInspectorButton;
    FIndex: Integer;
    FFullUpdate: Boolean;
    FClicked: Boolean;
    FOldWidth: Integer;
    FOldHeight: Integer;
    FOldSplitter: Integer;
    FLockCounter: Integer;
    FSplitter: Integer;
    FCheckBoxes: Boolean;
    FPaintStyle: TPaintStyle;
    FDragSplitter: Integer;
    FDragKind: TDragKind;
    FPopup: TInspectorPopup;
    FPopupPanel: TPanel;
    FEditPanel: TPanel;
    FExpand: TBitmap;
    FCollapse: TBitmap;
    FItemCount: Integer;
    FSizing: Boolean;
    FItemIndexOld: Integer;
    FItemIndexPos: TPoint;
    FOnSelect: TIndexNotifyEvent;
    FOnUpdate: TNotifyEvent;
    FOnValidateChar: TValidateCharEvent;
    FOnChangeValue: TChangeValueEvent;
    FOnDrawName: TIndexDrawEvent;
    FOnDrawValue: TIndexDrawEvent;
    FOnDrawPopupItem: TDrawPopupItemEvent;
    FOnGetName: TGetStringEvent;
    FOnGetValue: TGetStringEvent;
    FOnGetNextValue: TGetStringEvent;
    FOnSetValue: TSetStringEvent;
    FOnGetButtonType: TButtonTypeEvent;
    FOnGetInplaceEditorType: TInplaceEditorTypeEvent;
    {$IFDEF GOICUSTOMEDIT}
    FOnGetInplaceEditor: TInplaceEditorEvent;
    {$ENDIF}
    FOnGetMaxLength: TIntegerEvent;
    FOnGetEditMask: TGetStringEvent;
    FOnGetEnableExternalEditor: TBooleanEvent;
    FOnGetReadOnly: TBooleanEvent;
    FOnGetExpandState: TExpandStateEvent;
    FOnGetLevel: TIntegerEvent;
    FOnGetData: TPointerEvent;
    FOnGetValuesList: TStringsEvent;
    FOnGetSortValuesList: TBooleanEvent;
    FOnGetSelectedValue: TGetStringEvent;
    FOnGetAutoApply: TBooleanEvent;
    FOnGetNameFont: TFontEvent;
    FOnGetNameColor: TColorEvent;
    FOnGetValueFont: TFontEvent;
    FOnGetValueColor: TColorEvent;
    FOnCallEditor: TCallEditorEvent;
    FOnExpand: TIndexNotifyEvent;
    FOnCollapse: TIndexNotifyEvent;
    FOnSelectItem: TIndexNotifyEvent;
    FOnDeselectItem: TIndexNotifyEvent;
    FOnValueDoubleClick: TIndexEnableEvent;
    FOnDragValue: TIntegerEvent;
    FOnGetPasswordChar: TValidateCharEvent;
    function GetLocked: Boolean;
    function GetItemCount: Integer;
    procedure SetItemCount(const Value: Integer);
    procedure SetSplitter(const Value: Integer);
    procedure SetCheckBoxes(const Value: Boolean);
    procedure SetPaintStyle(const Value: TPaintStyle);
    procedure DrawDragSplitter(TheCanvas: TCanvas);
    procedure SetMouseItem(Pos: LParam);
    function Action(A: TItemAction): Boolean;
    procedure HidePopup;
    procedure HideEditor;
    function IsFocused: Boolean;
    function SpecialClick(L: LParam): Boolean;
    procedure UpdateControls;
    procedure SetIndex(const Value: Integer);
    procedure FocusControl;
    {$IFDEF GOITRIAL}
    procedure TrialMessage;
    {$ENDIF}
  protected
    procedure WndProc(var Message: TMessage); override;
    procedure DrawItem(Index: Integer; ARect: TRect; State: TOwnerDrawState); override;
    function GetDefaultIndex: Integer; virtual;
    procedure FullUpdateNeeded;
    function GetPopupItemWidth(ListBox: TListBox; TheIndex: Integer): Integer; virtual;
    procedure DrawPopupItem(ListBox: TListBox; ListItemIndex: Integer; R: TRect; TheIndex: Integer); virtual;
    procedure SetEditedText(const AText: string); virtual;
    function ValidateChar(TheIndex: Integer; var Key: Char): Boolean; virtual;
    procedure ChangeValue(TheIndex: Integer; Editing: Boolean; const AText: string); virtual;
    procedure SetSelectionPos(TheIndex: Integer; NeedUpdate: Boolean);
    procedure DrawPropertyName(TheCanvas: TCanvas; TheIndex: Integer; R: TRect); virtual;
    procedure DrawPropertyValue(TheCanvas: TCanvas; TheIndex: Integer; R: TRect); virtual;
    procedure DrawVerticalSeparator(TheCanvas: TCanvas; TheIndex: Integer; R: TRect); virtual;
    procedure DrawHorizontalSeparator(TheCanvas: TCanvas; TheIndex: Integer; R: TRect); virtual;
    procedure DrawBorders(TheCanvas: TCanvas; TheIndex: Integer; R: TRect); virtual;
    function GetName(TheIndex: Integer): string; virtual;
    function GetValue(TheIndex: Integer): string; virtual;
    function GetNextValue(TheIndex: Integer): string; virtual;
    procedure SetValue(TheIndex: Integer; const Value: string); virtual;
    procedure DragValue(TheIndex,Offset: Integer); virtual;
    procedure GetPasswordChar(TheIndex: Integer; var Value: Char); virtual;
    function GetButtonType(TheIndex: Integer): TButtonType; virtual;
    function GetInplaceEditorType(TheIndex: Integer): TInplaceEditorType; virtual;
    {$IFDEF GOICUSTOMEDIT}
    function GetInplaceEditor(TheIndex: Integer): TComponent; virtual;
    {$ENDIF}
    function GetMaxLength(TheIndex: Integer): Integer; virtual;
    function GetEditMask(TheIndex: Integer): string; virtual;
    function GetEnableExternalEditor(TheIndex: Integer): Boolean; virtual;
    function GetReadOnly(TheIndex: Integer): Boolean; virtual;
    function GetExpandState(TheIndex: Integer): TExpandState; virtual;
    function GetLevel(TheIndex: Integer): Integer; virtual;
    function GetData(TheIndex: Integer): Pointer; virtual;
    procedure GetValuesList(TheIndex: Integer; const Strings: TStrings); virtual;
    function GetSortValuesList(TheIndex: Integer): Boolean; virtual;
    function GetSelectedValue(TheIndex: Integer): string; virtual;
    function GetAutoApply(TheIndex: Integer): Boolean; virtual;
    procedure GetNameFont(TheIndex: Integer; TheFont: TFont); virtual;
    function GetNameColor(TheIndex: Integer): TColor; virtual;
    procedure GetValueFont(TheIndex: Integer; TheFont: TFont); virtual;
    function GetValueColor(TheIndex: Integer): TColor; virtual;
    function GetIndent: Integer; virtual;
    function CallEditor(TheIndex: Integer): Boolean; virtual;
    procedure Expand(TheIndex: Integer); virtual;
    procedure Collapse(TheIndex: Integer); virtual;
    procedure SelectItem(TheIndex: Integer); virtual;
    procedure DeselectItem(TheIndex: Integer); virtual;
    {$IFDEF FPC}
    procedure DoSelectionChange(User: Boolean); override;
    {$ENDIF}
    property ItemCount: Integer read GetItemCount write SetItemCount default 0;
    property Splitter: Integer read FSplitter write SetSplitter default 100;
    property CheckBoxes: Boolean read FCheckBoxes write SetCheckBoxes default False;
    property OnSelect: TIndexNotifyEvent read FOnSelect write FOnSelect;
    property OnUpdate: TNotifyEvent read FOnUpdate write FOnUpdate;
    property OnValidateChar: TValidateCharEvent read FOnValidateChar write FOnValidateChar;
    property OnChangeValue: TChangeValueEvent read FOnChangeValue write FOnChangeValue;
    property OnDrawName: TIndexDrawEvent read FOnDrawName write FOnDrawName;
    property OnDrawValue: TIndexDrawEvent read FOnDrawValue write FOnDrawValue;
    property OnDrawPopupItem: TDrawPopupItemEvent read FOnDrawPopupItem write FOnDrawPopupItem;
    property OnGetName: TGetStringEvent read FOnGetName write FOnGetName;
    property OnGetValue: TGetStringEvent read FOnGetValue write FOnGetValue;
    property OnGetNextValue: TGetStringEvent read FOnGetNextValue write FOnGetNextValue;
    property OnSetValue: TSetStringEvent read FOnSetValue write FOnSetValue;
    property OnGetButtonType: TButtonTypeEvent read FOnGetButtonType write FOnGetButtonType;
    property OnGetInplaceEditorType: TInplaceEditorTypeEvent read FOnGetInplaceEditorType write FOnGetInplaceEditorType;
    {$IFDEF GOICUSTOMEDIT}
    property OnGetInplaceEditor: TInplaceEditorEvent read FOnGetInplaceEditor write FOnGetInplaceEditor;
    {$ENDIF}
    property OnGetMaxLength: TIntegerEvent read FOnGetMaxLength write FOnGetMaxLength;
    property OnGetEditMask: TGetStringEvent read FOnGetEditMask write FOnGetEditMask;
    property OnGetEnableExternalEditor: TBooleanEvent read FOnGetEnableExternalEditor write FOnGetEnableExternalEditor;
    property OnGetReadOnly: TBooleanEvent read FOnGetReadOnly write FOnGetReadOnly;
    property OnGetExpandState: TExpandStateEvent read FOnGetExpandState write FOnGetExpandState;
    property OnGetLevel: TIntegerEvent read FOnGetLevel write FOnGetLevel;
    property OnGetData: TPointerEvent read FOnGetData write FOnGetData;
    property OnGetValuesList: TStringsEvent read FOnGetValuesList write FOnGetValuesList;
    property OnGetSortValuesList: TBooleanEvent read FOnGetSortValuesList write FOnGetSortValuesList;
    property OnGetSelectedValue: TGetStringEvent read FOnGetSelectedValue write FOnGetSelectedValue;
    property OnGetAutoApply: TBooleanEvent read FOnGetAutoApply write FOnGetAutoApply;
    property OnGetNameFont: TFontEvent read FOnGetNameFont write FOnGetNameFont;
    property OnGetNameColor: TColorEvent read FOnGetNameColor write FOnGetNameColor;
    property OnGetValueFont: TFontEvent read FOnGetValueFont write FOnGetValueFont;
    property OnGetValueColor: TColorEvent read FOnGetValueColor write FOnGetValueColor;
    property OnCallEditor: TCallEditorEvent read FOnCallEditor write FOnCallEditor;
    property OnExpand: TIndexNotifyEvent read FOnExpand write FOnExpand;
    property OnCollapse: TIndexNotifyEvent read FOnCollapse write FOnCollapse;
    property OnSelectItem: TIndexNotifyEvent read FOnSelectItem write FOnSelectItem;
    property OnDeselectItem: TIndexNotifyEvent read FOnDeselectItem write FOnDeselectItem;
    property OnValueDoubleClick: TIndexEnableEvent read FOnValueDoubleClick write FOnValueDoubleClick;
    property OnDragValue: TIntegerEvent read FOnDragValue write FOnDragValue;
    property OnGetPasswordChar: TValidateCharEvent read FOnGetPasswordChar write FOnGetPasswordChar;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Update; override;
    procedure CreateWnd; override;
    procedure Lock; virtual;
    procedure Unlock; virtual;
    procedure DrawPropertyNameDefault(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
    procedure DrawPropertyValueDefault(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
    procedure DrawPopupItemDefault(ListBox: TCustomListBox; TheIndex: Integer; R: TRect; ListItemIndex: Integer);
    procedure ApplyChanges;
    procedure IgnoreChanges;
    property InplaceEdit: TInspectorEdit read FEdit;
    property InplaceCheckBox: TInspectorCheckBox read FCheckBox;
    property Locked: Boolean read GetLocked;
    property Names[Index: Integer]: string read GetName;
    property Values[Index: Integer]: string read GetValue;
    property ButtonType[Index: Integer]: TButtonType read GetButtonType;
    property InplaceEditorType[Index: Integer]: TInplaceEditorType read GetInplaceEditorType;
    {$IFDEF GOICUSTOMEDIT}
    property InplaceEditor[Index: Integer]: TComponent read GetInplaceEditor;
    {$ENDIF}
    property EnableExternalEditor[Index: Integer]: Boolean read GetEnableExternalEditor;
    property ReadOnly[Index: Integer]: Boolean read GetReadOnly;
    property ExpandState[Index: Integer]: TExpandState read GetExpandState;
    property Index: Integer read FIndex write SetIndex;
    property Clicked: Boolean read FClicked write FClicked;
    property PaintStyle: TPaintStyle read FPaintStyle write SetPaintStyle default psClassic;
  end;

  TCommonInspector = class(TCustomInspector)
  published
    {$IFNDEF VERSION3}
    property Anchors;
    property Constraints;
    {$ENDIF}
    property Align;
    property BorderStyle;
    property Color;
    {$IFNDEF FPC} property Ctl3D; {$ENDIF}
    property DragCursor;
    property DragMode;
    property Enabled;
    property Font;
    {$IFNDEF FPC} property ImeMode;  {$ENDIF}
    {$IFNDEF FPC} property ImeName;  {$ENDIF}
    property IntegralHeight;
    property ParentColor;
    {$IFNDEF FPC} property ParentCtl3D;  {$ENDIF}
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property TabOrder;
    property TabStop;
    property Visible;
    property ItemCount;
    property CheckBoxes;
    property PaintStyle;
    property Splitter;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;
    property OnUpdate;
    property OnValidateChar;
    property OnChangeValue;
    property OnDrawName;
    property OnDrawValue;
    property OnDrawPopupItem;
    property OnGetName;
    property OnGetValue;
    property OnGetNextValue;
    property OnSetValue;
    property OnGetButtonType;
    property OnGetMaxLength;
    property OnGetEditMask;
    property OnGetInplaceEditorType;
    {$IFDEF GOICUSTOMEDIT}
    property OnGetInplaceEditor;
    {$ENDIF}
    property OnGetEnableExternalEditor;
    property OnGetReadOnly;
    property OnGetExpandState;
    property OnGetLevel;
    property OnGetData;
    property OnGetValuesList;
    property OnGetSortValuesList;
    property OnGetSelectedValue;
    property OnGetAutoApply;
    property OnGetNameFont;
    property OnGetNameColor;
    property OnGetValueFont;
    property OnGetValueColor;
    property OnCallEditor;
    property OnExpand;
    property OnCollapse;
    property OnSelectItem;
    property OnDeselectItem;
    property OnValueDoubleClick;
    property OnDragValue;
    property OnGetPasswordChar;
  end;

implementation

{$R *.res}
{$R-}

{$IFDEF GOITRIAL}
const
  WM_TRIALMESSAGE = WM_USER + 1234;
{$ENDIF}

const
  crUpDown = 1;

function StringToBoolean(const S: string): Boolean;
begin
  Result:=GetEnumValue(TypeInfo(Boolean),S)>0;
end;

function  IsDarkTheme :  boolean ;
  function  _Level ( C :  TColor ) :  double ;
  begin
    Result :=  Red ( C ) * 0.3  +  Green ( C ) * 0.59  +  Blue ( C ) * 0.11 ;
  end ;
begin
  Result :=  _Level ( ColorToRGB ( clWindow ))  <  _Level ( ColorToRGB ( clWindowText )) ;
end ;

procedure TInspectorPopup.DrawItem(TheIndex: Integer; Rect: TRect; State: TOwnerDrawState);
begin
  inherited;
  Canvas.FillRect(Rect);
  with Inspector do DrawPopupItem(Self,TheIndex,Rect,ItemIndex);
end;

procedure TInspectorPopup.WndProc(var Message: TMessage);

  procedure Close(OK: Boolean);
  begin
    if Visible then
    begin
      Inspector.FPopupPanel.Hide;
      Hide;
      with Inspector do
      begin
        if OK and (Self.ItemIndex>-1) then
          {$IFDEF GOITRIAL}
          TrialMessage;
          {$ELSE}
          FEdit.FEditing:=True;
          if (Self.ItemIndex<>-1) and (Self.ItemIndex<Self.Items.Count) then
          begin
            SetValue(ItemIndex,Self.Items[Self.ItemIndex]);
            Invalidate;
          end;
          {$ENDIF}
        if Showing and CanFocus then
        begin
          SetFocus;
          FocusControl;
        end;
        UpdateControls;
      end;
    end;
  end;

begin
  with Message do
    case Msg of
      {$IFnDEF FPC}CM_CANCELMODE:
        if TCMCancelMode(Message).Sender<>Self then Close(False);
      CM_DIALOGCHAR, WM_ACTIVATEAPP: Close(False);{$ENDIF}
      WM_KEYDOWN:
        case wParam of
          VK_ESCAPE,VK_TAB: Close(False);
          VK_RETURN: Close(True);
        end;
      WM_MOUSEMOVE,WM_LBUTTONDOWN:
        if GetKeyState(VK_LBUTTON) and $80 <> 0 then
          ItemIndex:=ItemAtPos(Point(LoWord(lParam),HiWord(lParam)),True);
      WM_LBUTTONUP: Close(PtInRect(ClientRect,Point(LoWord(lParam),HiWord(lParam))));
    end;
  inherited;
end;

procedure TInspectorPopup.CreateParams(var Params: TCreateParams);
begin
  inherited;
  with Params do ExStyle:=ExStyle or WS_EX_TOOLWINDOW or WS_EX_TOPMOST;
  with Params do Style:=Style or WS_TABSTOP;
end;

constructor TInspectorPopup.Create(AOwner: TComponent);
begin
  inherited;
  {$IFNDEF FPC}
  ParentCtl3D:=False;
  Ctl3D:=False;
  {$ENDIF}
  Style:=lbOwnerDrawFixed;
  IntegralHeight:=True;
end;

{$IFDEF FPC}
procedure TInspectorEdit.CMChildKey(var Message: TCMChildKey);
{$if defined(linux) or defined(darwin)}
var
   p: TWinControl;
{$ifend}
begin
  {$IFDEF WINDOWS}
  if Parent <> nil then Parent.WindowProc(TMessage(Message));
  {$ELSE}
  p := Inspector;
  if p = nil then p := Parent;
  if p <> nil then p.WindowProc(TMessage(Message));
  {$ENDIF}
end;

procedure TInspectorEdit.CNKeyDown(var Message: TLMKeyDown);
begin
  if Perform(CM_CHILDKEY, Message.CharCode, LPARAM(Self)) <> 0 then exit;
  inherited;
end;

procedure TInspectorEdit.CNSysKeyDown(var Message: TLMKeyDown);
begin
  if Perform(CM_CHILDKEY, Message.CharCode, LPARAM(Self)) <> 0 then exit;
  inherited;
end;
{$ENDIF}

procedure TInspectorEdit.WndProc(var Message: TMessage);
begin
  inherited;
  with Message do
    case Msg of
      WM_LBUTTONDOWN:
      begin
        if Inspector.Clicked then Inspector.Clicked:=False
        else
        begin
          inherited;
          Inspector.HidePopup;
          if not Inspector.IsFocused then
          begin
            if Parent.CanFocus then Parent.SetFocus;
            if CanFocus then SetFocus;
          end;
        end;
      end;
      WM_LBUTTONDBLCLK:
      begin
        inherited;
        Inspector.Action(iaDoubleClick);
      end;
      CM_EXIT:
      begin
        inherited;
        with Inspector do
        begin
          ApplyChanges;
          Update;
        end;
        Modified:=False;
      end;
      WM_KILLFOCUS:
      begin
        ReleaseCapture;
        inherited;
      end;
    
    end;
end;

procedure TInspectorEdit.KeyPress(var Key: Char);
begin
  with Inspector do
  begin
    if not ValidateChar(ItemIndex,Key) then
    begin
      Key:=#0;
      {$IFDEF FPC}Beep{$ELSE}MessageBeep(0){$ENDIF};
    end;
    FEditing:=True;
  end;
end;

procedure TInspectorEdit.Change;
begin
  with Inspector do ChangeValue(ItemIndex,FEditing,Self.Text);
  FEditing:=False;
end;

procedure TInspectorCheckBox.Click;
begin
  inherited;
  with Inspector do
    if Boolean(GetEnumValue(TypeInfo(Boolean),GetValue(ItemIndex)))<>Checked then
    begin
      {$IFDEF GOITRIAL}
      TrialMessage;
      {$ELSE}
      FEdit.FEditing:=True;
      SetValue(FIndex,GetEnumName(TypeInfo(Boolean),Integer(Checked)));
      {$ENDIF}
      Update;
    end;
end;

procedure TInspectorButton.SetDown(const Value: Boolean);
begin
  if Value<>FDown then
  begin
    FDown:=Value;
    Invalidate;
  end;
end;

procedure TInspectorButton.SetButtonType(const Value: TButtonType);
begin
  FButtonType:=Value;
  Visible:=(FButtonType<>btNone) and not (csDesigning in ComponentState);
  Invalidate;
end;

procedure TInspectorButton.WndProc(var Message: TMessage);
var
  R: TRect;
begin
  inherited;
  with Message do
    case Msg of
      WM_LBUTTONDOWN:
        if not (csDesigning in ComponentState) then
          with Inspector do
          begin
            if not FPopupPanel.Showing then
            begin
              Down:=True;
              {$IFDEF WINDOWS} SetCapture(Self.Handle);  {$ENDIF}
            end
            else
            begin
              HidePopup;
              if IsFocused and CanFocus then
              begin
                SetFocus;
                FocusControl;
              end;
            end;
            if not IsFocused and CanFocus then
            begin
              SetFocus;
              FocusControl;
            end;
            if FButtonType=btUpDown then
            begin
              Self.Cursor:=crUpDown;
              Screen.Cursor:=crUpDown;
            end;
          end
        else inherited;
      WM_MOUSEMOVE:
                   
        begin
          Down:=(FButtonType=btUpDown) or PtInRect(ClientRect,Point(LoWord(lParam),HiWord(lParam)));
          if (FButtonType=btUpDown) and (GetKeyState(VK_LBUTTON) and $80 <> 0) then
          begin
            GetCursorPos(R.TopLeft);
            R.BottomRight:=ClientToScreen(Point(0,ClientHeight div 2));
            with Inspector do DragValue(ItemIndex,R.Bottom-R.Top);
          end;
        end;
      WM_LBUTTONUP:
        
        begin
          {$IFDEF WINDOWS} ReleaseCapture;  {$ENDIF}
          Cursor:=crDefault;
          Screen.Cursor:=crDefault;
          if Down then
          begin
            Down:=False;
            with Inspector do
              case FButtonType of
                btDropDown: if Action(iaButtonClick) then Update;
                btDialog: if Action(iaDoubleClick) then Update;
              else
                ApplyChanges;
                Update;
              end;
          end;
        end;
      WM_LBUTTONDBLCLK:
      begin
        Down:=False;
        {$IFDEF WINDOWS} ReleaseCapture; {$ENDIF}
        if FButtonType=btDropDown then Inspector.HidePopup;
        if FButtonType<>btUpDown then
          with Inspector do
            if IsFocused and CanFocus then
            begin
              SetFocus;
              FocusControl;
            end;
      end;
    else inherited;
    end;
end;

procedure TInspectorButton.Paint;
var R: TRect;
    Glyph: TBitmap;
begin
  inherited Paint;
  R:=ClientRect;
  with R,Canvas do
  begin
    Dec(Right);
    Dec(Bottom);
    if FDown then
    begin
      Pen.Color:=clBtnShadow;
      MoveTo(Left,Bottom);
      LineTo(Left,Top);
      LineTo(Right,Top);
      LineTo(Right,Bottom);
      LineTo(Left,Bottom);
    end
    else
    begin
      Pen.Color:=cl3DLight;
      MoveTo(Left,Bottom);
      LineTo(Left,Top);
      LineTo(Right,Top);
      Pen.Color:=clBlack;
      LineTo(Right,Bottom);
      LineTo(Pred(Left),Bottom);
      InflateRect(R,-1,-1);
      Pen.Color:=clBtnHighlight;
      MoveTo(Left,Bottom);
      LineTo(Left,Top);
      LineTo(Right,Top);
      Pen.Color:=clBtnShadow;
      LineTo(Right,Bottom);
      LineTo(Pred(Left),Bottom);
    end;
    case FButtonType of
      btDropDown: Glyph:=FDropDown;
      btUpDown: Glyph:=FUpDown;
      btDialog: Glyph:=FDialog;
    else Glyph:=nil;
    end;
    if Assigned(Glyph) then
    begin
      Left:=(Right+Left) div 2-(Glyph.Width) div 2;
      Top:=(Bottom+Top) div 2-(Glyph.Height) div 2;
      CopyMode:=cmSrcAnd;
      R:=Rect(Left,Top,Left+Glyph.Width,Top+Glyph.Height);
      if FDown then OffsetRect(R,1,1);
      CopyRect(R,Glyph.Canvas,Rect(0,0,Glyph.Width,Glyph.Height));
    end;
  end;
end;

constructor TInspectorButton.Create(AOwner: TComponent);
begin
  inherited;
  Color:=clBtnFace;
  FDropDown:=TBitmap.Create;
  FDropDown.Handle:=LoadBitmap(HInstance,'DROPDOWN');
  FUpDown:=TBitmap.Create;
  FUpDown.Handle:=LoadBitmap(HInstance,'UPDOWN');
  FDialog:=TBitmap.Create;
  FDialog.Handle:=LoadBitmap(HInstance,'DIALOG');
  ControlStyle:=ControlStyle-[csDoubleClicks,csOpaque];
end;

destructor TInspectorButton.Destroy;
begin
  FDropDown.Free;
  FUpDown.Free;
  FDialog.Free;
  inherited Destroy;
end;

procedure TCustomInspector.UpdateControls;
var
  R,Rv: TRect;
  WasFocused: Boolean;
  PC: Char;
  dY, dB, dE: Integer;
  ButtonSize: Integer;
begin
  if not (csDesigning in ComponentState) and (ItemCount>0) then
  begin
    WasFocused:=IsFocused;

    Rv:=Self.Parent.ClientToScreen(Self.BoundsRect);
    Rv.TopLeft:=TWinControl(Owner).ScreenToClient(Rv.TopLeft);
    Rv.BottomRight:=TWinControl(Owner).ScreenToClient(Rv.BottomRight);

    R := Self.ClientToScreen(Self.ItemRect(Self.ItemIndex));
    R.BottomRight := TWinControl(Owner).ScreenToClient(R.BottomRight);
    R.TopLeft := TWinControl(Owner).ScreenToClient(R.TopLeft);
    R.Left:=R.Left + FSplitter;
    ButtonSize := R.Height;

    if (FItemIndexOld = Self.ItemIndex) and (FItemIndexPos = R.TopLeft) and FPopupPanel.Visible then Exit;
    if FPopupPanel.Visible then FPopupPanel.Hide;
    FItemIndexOld := Self.ItemIndex;
    FItemIndexPos := R.TopLeft;

    dE:= 0;
    dB:= 0;
    if (Rv.Top > R.Top) or (Rv.Bottom < R.Bottom) then
    begin
      if (Rv.Top > R.Top) then
      begin
        dY:= Rv.Top - R.Top;
        dB:= dY;
        dE:= -dY;
      end else dY:= R.Bottom - Rv.Bottom;
    end else dY:= 0;

    with R do FEditPanel.SetBounds(Left, Top + dB, Width, Height - dY);

    with FButton do
    begin

      SetBounds(FEditPanel.Width - ButtonSize - 1, dE, ButtonSize, ButtonSize);
      ButtonType:=Inspector.GetButtonType(FIndex);
      Visible:=Visible and not (csDesigning in ComponentState) and (ItemCount>0);
    end;

    {$IFDEF GOICUSTOMEDIT}
    FEdit.Visible:=False;
    if GetInplaceEditorType(FIndex)=ieCustomEdit then
    begin
      FEdit:=GetInplaceEditor(FIndex) as TInspectorEdit;
      if FEdit=nil then FEdit:=FDefaultEdit;
    end
    else FEdit:=FDefaultEdit;
    {$ENDIF}
    with FEdit do
    begin
      ParentFont:=True;
      if not (csLoading in Self.ComponentState) then GetValueFont(FIndex,Font);
      
      if FButton.Visible then
        SetBounds(0, dE, FEditPanel.Width - FButton.Width, ButtonSize)
      else SetBounds(0, dE, FEditPanel.Width, ButtonSize);

      Text:=GetValue(FIndex);
      ReadOnly  := Self.GetReadOnly(FIndex);
      MaxLength := Self.GetMaxLength(FIndex);
      EditMask  := Self.GetEditMask(FIndex);
      if Height > R.Height then Top := Top - (Height - R.Height);
      Visible:=((GetInplaceEditorType(FIndex)=ieEdit) {$IFDEF GOICUSTOMEDIT} or (GetInplaceEditorType(FIndex)=ieCustomEdit){$ENDIF})
                                                      and not (csDesigning in ComponentState)
                                                      and (ItemCount>0);

      SelectAll;
      if Visible then
      begin
        PC:=#0;
        GetPasswordChar(FIndex,PC);
        PasswordChar:=PC;
      end;
      if WasFocused and CanFocus then SetFocus;
    end;

    with FCheckBox do
    begin
      
      if FButton.Visible then
        SetBounds(0, dE, FEditPanel.Width - FButton.Width, ButtonSize)
      else SetBounds(0, dE, FEditPanel.Width, ButtonSize);

      if GetInplaceEditorType(FIndex)=ieCheckBox then
        Checked:=StringToBoolean(GetValue(FIndex));
      Enabled:=not GetReadOnly(FIndex);
      if Height > R.Height then Top := Top - (Height - R.Height);
      Visible:=(GetInplaceEditorType(FIndex)=ieCheckBox) and CheckBoxes and
        not (csDesigning in ComponentState) and (ItemCount>0);

      if WasFocused and CanFocus then SetFocus;
    end;
    if WasFocused and not IsFocused and CanFocus then SetFocus;

    FEditPanel.Visible := FButton.Visible or FEdit.Visible or FCheckBox.Visible;
    if FEditPanel.Visible then FEditPanel.BringToFront;
  end
  else
  begin
    FEdit.Hide;
    FButton.Hide;
    FCheckBox.Hide;
  end;
end;

procedure TCustomInspector.SetIndex(const Value: Integer);
var
  R: TRect;
begin
  if Value<>FIndex then
  begin
    if GetAutoApply(FIndex) then ApplyChanges;
    R:=ItemRect(FIndex);
    Dec(R.Top,ItemHeight+2);
    Inc(R.Bottom,ItemHeight);
    FIndex:=Value;
    ItemIndex:=FIndex;
    UpdateControls;
    Dec(R.Top,ItemHeight+2);
    Inc(R.Bottom,ItemHeight);
    InvalidateRect(Handle,@R,True);
  end;
end;

procedure TCustomInspector.FocusControl;
begin
  if Showing and CanFocus and not FPopupPanel.Visible then
  begin
    case GetInplaceEditorType(FIndex) of
      ieEdit:
        with FEdit do
          if CanFocus and Enabled then
          begin
            SelectAll;
            SetFocus;
            Invalidate;
          end;
      ieCheckBox:
        with FCheckBox do
          if CanFocus and Enabled then
          begin
            SetFocus;
            Invalidate;
          end;
    end;
    with FButton do if Visible then Invalidate;
  end;
end;

{$IFDEF GOITRIAL}
procedure TCustomInspector.TrialMessage;
begin
  PostMessage(Self.Handle,WM_TRIALMESSAGE,0,0);
end;
{$ENDIF}

function TCustomInspector.GetLocked: Boolean;
begin
  Result:=FLockCounter>0;
end;

function TCustomInspector.GetItemCount: Integer;
begin
  Result:=Items.Count;
end;

procedure TCustomInspector.SetItemCount(const Value: Integer);
var
  i: Integer;
  Focused: HWND;
begin
  if HandleAllocated and (ItemCount<>Value) then
  begin
    with Items do
    begin
      BeginUpdate;
      try
        Clear;
        for i:=0 to Pred(Value) do AddObject(GetName(i),GetData(i));
      finally
        EndUpdate;
      end;
    end;
    Focused:=GetFocus;
    if Items.Count>0 then ItemIndex:=GetDefaultIndex;
    {$IFDEF FPC}{$ELSE}Windows.SetFocus(Focused){$ENDIF};
  end;
  FItemCount:=Value;
end;

procedure TCustomInspector.SetSplitter(const Value: Integer);
var
  FS: Integer;
begin
  FS:=Value;
  if FS<32 then FS:=32;
  if FS>ClientWidth-48 then FS:=ClientWidth-48;
  if FSplitter<>FS then
  begin
    FSplitter:=FS;
    if Value<>FSplitter then FSplitter:=Value;
    UpdateControls;
    Invalidate;
  end;
end;

procedure TCustomInspector.SetCheckBoxes(const Value: Boolean);
begin
  if FCheckBoxes<>Value then
  begin
    FCheckBoxes:=Value;
    Update;
    Invalidate;
  end;
end;

procedure TCustomInspector.SetPaintStyle(const Value: TPaintStyle);
begin
  if FPaintStyle<>Value then
  begin
    FPaintStyle:=Value;
    if Visible then
    begin
      Visible:=False;
      Visible:=True;
    end;
  end;
end;

procedure TCustomInspector.DrawDragSplitter(TheCanvas: TCanvas);
var
  OldPen: TPen;
  R: TRect;
  I: Integer;
begin
  if FDragKind = dkSplitter then
    with TheCanvas do
    try
      
      OldPen:=TPen.Create;
      try
        OldPen.Assign(Pen);
        R:=ClientRect;
        
        i := ScreenToClient(Point(FDragSplitter, 0)).X;
        with Pen,R do
        begin
          Color:=clSilver;
          Mode:=pmXor;
          MoveTo(I+ClientOrigin.X,Top);
          LineTo(I+ClientOrigin.X,Bottom);
          Assign(OldPen);
        end;
      finally
        OldPen.Free;
      end;
    finally
      
    end;
end;

procedure TCustomInspector.SetMouseItem(Pos: LParam);
var
  I: Integer;
begin
  with Items do
    if Count>0 then
    begin
      I:=ItemAtPos(Point(0,HiWord(Pos)),False);
      if I<0 then
        if SmallInt(HiWord(Pos))>ItemHeight*(ClientHeight div ItemHeight) then I:=Succ(ItemIndex)
        else I:=Pred(ItemIndex);
      if I<0 then I:=0;
      if I>Pred(Count) then I:=Pred(Count);
      ItemIndex:=I;
    end;
end;

function TCustomInspector.Action(A: TItemAction): Boolean;
var
  W: Integer;
  P: TPoint;
  EnableDefault: Boolean;
  ScrolledOffset: Integer;
  WScroll: Integer;
  R: TRect;
  P1, P2: TPoint;
begin
  Result:=False;
  if (ItemIndex>-1) and (ItemIndex<Items.Count) and Assigned(GetParentForm(Self)) then
  begin
    case A of
      iaDoubleClick:
      begin
        EnableDefault:=True;
        if Assigned(FOnValueDoubleClick) then FOnValueDoubleClick(Self,ItemIndex,EnableDefault);
        if EnableDefault then
        begin
          if GetEnableExternalEditor(ItemIndex) then Result:=CallEditor(ItemIndex)
          else
            if not GetReadOnly(ItemIndex) then
            begin
              Result:=True;
              {$IFDEF GOITRIAL}
              TrialMessage;
              {$ELSE}
              SetValue(ItemIndex,GetNextValue(ItemIndex));
              {$ENDIF}
            end;
          FocusControl;
        end;
        if Result then
        begin
          if GetAutoApply(FIndex) then ApplyChanges;
          Update;
        end;
      end;
      iaButtonClick:
      begin
        with FPopup do
        begin
          Visible:=False;
          FPopupPanel.Visible:=False;
          WScroll:= 0;
          ScrolledOffset:=0;

          Canvas.Font.Assign(Font);
          ItemHeight:=Self.ItemHeight;
          Items.Clear;
          Sorted:=false;
          GetValuesList(Self.ItemIndex,Items);
          Sorted:=GetSortValuesList(Self.ItemIndex);

          R := Self.ClientToScreen(Self.ItemRect(Self.ItemIndex));
          R.BottomRight := TWinControl(Owner).ScreenToClient(R.BottomRight);
          R.TopLeft := TWinControl(Owner).ScreenToClient(R.TopLeft);
          R.Offset(0, ItemHeight);

          R.Height:= ItemHeight;
          W:=Items.Count;
          if W>8 then W:=8;
          if W<1 then W:=1;
          R.Height:=R.Height*W + {$IFDEF LINUX} 4 {$ELSE}{$IFDEF UNIX} 2*W + 6  {$ELSE}{$IFDEF FPC}W + 2 {$ELSE}W + 2{$ENDIF}{$ENDIF}{$ENDIF};
          R.Height:=R.Height + GetSystemMetrics(SM_CYBORDER) * 2;

          R.Left:=R.Left + FSplitter;

          ItemIndex:=Items.IndexOf(GetSelectedValue(Self.ItemIndex));

          if ((R.Top + R.Height + 6) > TWinControl(Owner).Height) and ((R.Top - R.Height - ItemHeight + 6) >= 0) then
            R.Offset(0, - R.Height - ItemHeight);

          if (R.Top + R.Height) > TWinControl(Owner).Height then
            R.Bottom := R.Bottom - (R.Top + R.Height) + TWinControl(Owner).Height;
          ShowScrollBar(Handle, SB_Horz, False);

          with R do FPopupPanel.SetBounds(Left, Top, Width, Height);
          FPopupPanel.Visible:=True;
          Visible:=True;
          FPopupPanel.BringToFront;
          SetFocus;
        end;
      end;
    end;
  end;
end;                                                                  

procedure TCustomInspector.HidePopup;
begin
  if Assigned(FPopupPanel) and FPopupPanel.Visible then
  begin
    FPopupPanel.Hide;
    FPopup.Hide;
    FocusControl;
  end;
end;

procedure TCustomInspector.HideEditor;
begin
  if Assigned(FEdit) and FEdit.Visible then
  begin
    FEdit.Hide;
    FocusControl;
  end;
end;

function TCustomInspector.IsFocused: Boolean;
begin
  IsFocused:=
    Focused or
    FCheckBox.Focused or
    FEdit.Focused or
    FButton.Focused;
end;

function TCustomInspector.SpecialClick(L: LParam): Boolean;
begin
  Result:=(GetExpandState(ItemIndex)<>esNone) and
    (Abs(LoWord(L))>=GetLevel(ItemIndex)*GetIndent) and
    (Abs(LoWord(L))<=Succ(GetLevel(ItemIndex))*GetIndent+2);
end;

procedure TCustomInspector.WndProc(var Message: TMessage);
var
  R: TRect;
  P: TPoint;
  i,j: Integer;
  IFont: TFont;
  IPen: TPen;
  IBrush: TBrush;

  procedure SaveCanvas(C: TCanvas);
  begin
    with C do
    begin
      IFont.Assign(Font);
      IPen.Assign(Pen);
      IBrush.Assign(Brush);
    end;
  end;

  procedure RestoreCanvas(C: TCanvas);
  begin
    with C do
    begin
      Font.Assign(IFont);
      Pen.Assign(IPen);
      Brush.Assign(IBrush);
    end;
  end;

  procedure ExpandCollapse;
  begin
    case GetExpandState(ItemIndex) of
      esExpand:
      begin
        j:=ItemCount;
        Expand(ItemIndex);
        i:=ItemIndex+ItemCount-j-(ClientHeight div ItemHeight)+1;
        if i>TopIndex then TopIndex:=i;
      end;
      esCollapse:
      begin
        Collapse(ItemIndex);
        SetSelectionPos(ItemIndex,True);
      end;
    end;
  end;

begin
  inherited;
  with Message do
    case Msg of
      CM_ENTER:
      begin
        inherited;
        if FEdit.CanFocus then FEdit.SetFocus;
        if FCheckBox.CanFocus then FCheckBox.SetFocus;
        FocusControl;
      end;
      
      CM_FONTCHANGED:
      begin
        inherited;
        ItemHeight:=3*Abs(Font.Height) div 2;
        if ItemIndex<>-1 then SetSelectionPos(ItemIndex,True);
      end;
      CM_SHOWINGCHANGED:
      begin
        inherited;
        if FPopupPanel.Showing then HidePopup;
        FFullUpdate:=True;
      end;
      CM_FOCUSCHANGED:
      begin
        {$IFDEF FPC}{$ELSE}
        with TCmFocusChanged(Message) do
          if (Sender<>FPopup) and FPopup.Showing then FPopup.Hide;
        {$ENDIF}
        inherited;
      end;
      WM_CHAR,WM_CHARTOITEM,WM_VKEYTOITEM:;
      WM_KEYDOWN:
        if FPopup.CanFocus then
        begin
          FPopup.SetFocus;
          SendMessage(FPopup.Handle,WM_KEYDOWN,wParam,lParam);
          wParam:=0;
        end
        else
          case Char(wParam) of
            'A'..'Z','0'..'9':
              wParam:=0;
          else inherited;
          end;
      CM_CHILDKEY:
        if not (csDesigning in ComponentState) then
          if FPopup.CanFocus then
          begin
            Result:=1;
            FPopup.SetFocus;
            SendMessage(FPopup.Handle,WM_KEYDOWN,wParam,lParam);
          end
          else
            case wParam of
              VK_RETURN:
              begin
                Result:=1;
                if GetKeyState(VK_MENU) and $80 <> 0 then
                begin
                   if GetButtonType(ItemIndex)=btDropDown then Action(iaButtonClick);
                end
                else
                  if GetKeyState(VK_CONTROL) and $80 <> 0 then
                  begin
                    if GetButtonType(ItemIndex)=btDialog then Action(iaDoubleClick);
                  end
                  else
                  begin
                    FEdit.Modified:=True;
                    ApplyChanges;
                    Update;
                    FEdit.Modified:=False;
                  end;
              end;
              VK_ESCAPE:
              begin
                Result:=1;
                IgnoreChanges;
                Update;
              end;
              VK_UP:
              begin
                Result:=1;
                if ItemIndex>0 then
                   ItemIndex:=Pred(ItemIndex);
              end;
              VK_DOWN{$IFDEF GOITABNEXT},VK_TAB{$ENDIF}:
              begin
                Result:=1;
                if GetKeyState(VK_MENU) and $80 <> 0 then
                begin
                  if GetButtonType(ItemIndex)=btDropDown then Action(iaButtonClick);
                  Exit;
                end;
                if ItemIndex<Pred(Items.Count) then
                   ItemIndex:=Succ(ItemIndex);
              end;
            else inherited;
            end
        else inherited;
      WM_PAINT:
      begin
        inherited;
       
        UpdateControls;
       
      end;
      WM_SIZE:
      begin
        inherited;
        Splitter:=FSplitter;
        FEdit.Width:=ClientWidth;
        FFullUpdate:=True;
        FSizing:= True;
        try
          Update;
        finally
          FSizing:= False;
        end;
      end;
      WM_LBUTTONDOWN:
        if not (csDesigning in ComponentState) then
        begin
          with FPopupPanel do
            if Showing then Hide;
          with FPopup do
            if Showing then Hide;
          with FEdit do
            if CanFocus then SetFocus;
          with FCheckBox do
            if CanFocus then SetFocus;
          FocusControl;
          SetCapture(Handle);
          if Abs(LoWord(lParam)-FSplitter)<=2 then
          begin
            FDragKind:=dkSplitter;
            FDragSplitter:=LoWord(lParam);
            Invalidate;
            
          end
          else
          begin
            SetMouseItem(lParam);
            if SpecialClick(lParam) then ExpandCollapse
            else FDragKind:=dkItem;
          end;
        end
        else inherited;
      WM_MOUSEMOVE:
      begin
        
          case FDragKind of
            dkSplitter:
            begin
              
              FDragSplitter:=SmallInt(LoWord(lParam));
              if FDragSplitter<32 then FDragSplitter:=32;
              if FDragSplitter>ClientWidth-48 then FDragSplitter:=ClientWidth-48;
              
              Invalidate;
            end;
            dkItem: SetMouseItem(lParam);
          else begin inherited;         Screen.Cursor:=crDefault;     end;
          end
        
      end;
      WM_LBUTTONUP:
      begin
        inherited;
        case FDragKind of
          dkSplitter:
          begin
            
            Invalidate;
            Splitter:=FDragSplitter;
          end;
        end;
        ReleaseCapture;
        FDragKind:=dkNone;
        if FEdit.Visible and PtInRect(FEdit.BoundsRect,Point(LoWord(lParam),HiWord(lParam)))
          or FCheckBox.Visible and PtInRect(FCheckBox.BoundsRect,Point(LoWord(lParam),HiWord(lParam))) then
        begin
          Clicked:=True;
          {$IFDEF FPC}{$ELSE}
          mouse_event(MOUSEEVENTF_LEFTDOWN,0,0,0,0);
          mouse_event(MOUSEEVENTF_LEFTUP,0,0,0,0);
          {$ENDIF}
        end;
      end;
      
      WM_RBUTTONDOWN:
      begin
        SetMouseItem(lParam);
        inherited;
      end;
      WM_NCLBUTTONDOWN{$IFnDEF FPC}..WM_NCMBUTTONDBLCLK{$ENDIF}:
      begin
        HidePopup;
        inherited;
      end;
      WM_VSCROLL {$IFDEF LINUX}, LM_MOUSEWHEEL {$ENDIF}:
      begin
        inherited;
        HidePopup;
        UpdateControls;
      end;
      {$IFNDEF VERSION3}
      WM_MOUSEWHEEL:
      begin
        inherited;
        HidePopup;
        UpdateControls;
        Invalidate;
      end;
      {$ENDIF}
      {$IFnDEF FPC}
      LB_SETCURSEL:
      begin
        i:=FIndex;
        DeselectItem(ItemIndex);
        SetSelectionPos(wParam,False);
        inherited;
        R:=ItemRect(i);
        Dec(R.Top,2);
        Inc(R.Bottom);
        InvalidateRect(Handle,@R,True);
        UpdateControls;
        SelectItem(ItemIndex);
      end;
      {$ENDIF}
      WM_SETCURSOR:
        if not (csDesigning in ComponentState) and (HiWord(lParam)<>0) then
        begin
          GetCursorPos(P);
          P:=ScreenToClient(P);
          if Abs(P.X-FSplitter)<=2 then
          begin
            Screen.Cursor:=crHSplit;
          end
          else inherited;
        end
        else inherited;
      {$IFnDEF FPC}
      CN_DRAWITEM:
      begin
        IFont:=TFont.Create;
        IPen:=TPen.Create;
        IBrush:=TBrush.Create;
        try
          with PDrawItemStruct(lParam)^ do
            if (ODS_FOCUS and WordRec(LongRec(itemState).Lo).Lo=0) and (Integer(itemID)<>-1) then
              with Canvas do
              begin
                Font.Assign(Self.Font);
                Brush.Style:=bsSolid;
                SetBkMode(hDC,TRANSPARENT);
                R:=rcItem;
                R.Right:=R.Left+FSplitter;
                Brush.Color:=Color;
                Font.Color:=clWindowText;
                SaveCanvas(Canvas);
                try
                  DrawPropertyName(Canvas,itemID,R);
                finally
                  RestoreCanvas(Canvas);
                end;
                Font.Color:=clNavy;
                R:=rcItem;
                R.Left:=R.Left+FSplitter+1;
                if csDesigning in ComponentState then DrawPropertyValue(Canvas,itemID,R)
                else
                  if (itemID=DWORD(ItemIndex)) and (GetInplaceEditorType(itemID)<>ieNone) then
                  begin
                    case GetInplaceEditorType(itemID) of
                      ieEdit: Brush.Color:=clWindow;
                      ieCheckBox: Brush.Color:=clWindow;
                    end;
                    Dec(R.Bottom);
                    FillRect(R);
                  end
                  else
                  begin
                    SaveCanvas(Canvas);
                    try
                      DrawPropertyValue(Canvas,itemID,R);
                    finally
                      RestoreCanvas(Canvas);
                    end;
                  end;
                if ItemCount>0 then
                begin
                  DrawHorizontalSeparator(Canvas,itemID,rcItem);
                  if ItemID=DWORD(ItemIndex) then DrawBorders(Canvas,ItemID,rcItem);
                  DrawVerticalSeparator(Canvas,itemID,rcItem);
                end;
              end;
        finally
          IFont.Free;
          IPen.Free;
          IBrush.Free;
        end;
      end;
      {$ENDIF}
      {$IFDEF GOITRIAL}
      WM_TRIALMESSAGE:
        Application.MessageBox(
          'Data cannot be changed in trial version of the component.',
          'Trial Limitation - Greatis Object Inspector',
          MB_OK or MB_ICONEXCLAMATION);
      {$ENDIF}
    end;
end;

procedure TCustomInspector.DrawItem(Index: Integer; ARect: TRect;
  State: TOwnerDrawState);
var
  R: TRect;
  P: TPoint;
  i,j: Integer;
  IFont: TFont;
  IPen: TPen;
  IBrush: TBrush;

  procedure SaveCanvas(C: TCanvas);
  begin
    with C do
    begin
      IFont.Assign(Font);
      IPen.Assign(Pen);
      IBrush.Assign(Brush);
    end;
  end;

  procedure RestoreCanvas(C: TCanvas);
  begin
    with C do
    begin
      Font.Assign(IFont);
      Pen.Assign(IPen);
      Brush.Assign(IBrush);
    end;
  end;

  procedure ExpandCollapse;
  begin
    case GetExpandState(ItemIndex) of
      esExpand:
      begin
        j:=ItemCount;
        Expand(ItemIndex);
        i:=ItemIndex+ItemCount-j-(ClientHeight div ItemHeight)+1;
        if i>TopIndex then TopIndex:=i;
      end;
      esCollapse:
      begin
        Collapse(ItemIndex);
        SetSelectionPos(ItemIndex,True);
      end;
    end;
  end;
begin
   IFont:=TFont.Create;
   IPen:=TPen.Create;
   IBrush:=TBrush.Create;
   try    
       if  (Integer(Index)<>-1) then
         with Canvas do
         begin
           Font.Assign(Self.Font);
           Brush.Style:=bsSolid;
           SetBkMode(Handle, TRANSPARENT);
           R:=ARect;
           R.Right:=R.Left+FSplitter;
           Brush.Color:=Color;
           Font.Color:=clWindowText;
           SaveCanvas(Canvas);
           try
             DrawPropertyName(Canvas,Index,R);
           finally
             RestoreCanvas(Canvas);
           end;
           if IsDarkTheme then
             Font.Color:=clYellow
           else Font.Color:=clNavy;
           R:=ARect;
           R.Left:=R.Left+FSplitter+1;
           if csDesigning in ComponentState then DrawPropertyValue(Canvas,Index,R)
           else
             if (Index=DWORD(ItemIndex)) and (GetInplaceEditorType(Index)<>ieNone) then
             begin
               case GetInplaceEditorType(Index) of
                 ieEdit: Brush.Color:=clWindow;
                 ieCheckBox: Brush.Color:=clWindow;
               end;
               Dec(R.Bottom);
               FillRect(R);
             end
             else
             begin
               SaveCanvas(Canvas);
               try
                 DrawPropertyValue(Canvas,Index,R);
               finally
                 RestoreCanvas(Canvas);
               end;
             end;
           if ItemCount>0 then
           begin
             DrawHorizontalSeparator(Canvas,Index,ARect);
             if Index=DWORD(ItemIndex) then DrawBorders(Canvas,Index,ARect);
             DrawVerticalSeparator(Canvas,Index,ARect);
           end;
         end;
       DrawDragSplitter(Canvas);
   finally
     IFont.Free;
     IPen.Free;
     IBrush.Free;
   end;
end;

function TCustomInspector.GetDefaultIndex: Integer;
begin
  Result:=0;
end;

procedure TCustomInspector.FullUpdateNeeded;
begin
  FFullUpdate:=True;
end;

function TCustomInspector.GetPopupItemWidth(ListBox: TListBox; TheIndex: Integer): Integer;
var
  i: Integer;
begin
  Result:=0;
  with ListBox do
    for i:=0 to Pred(Items.Count) do
      with Canvas do
        if TextWidth(Items[i])>Result then Result:=TextWidth(Items[i]);
end;

procedure TCustomInspector.DrawPopupItem(ListBox: TListBox; ListItemIndex: Integer; R: TRect; TheIndex: Integer);
begin
  if Assigned(FOnDrawPopupItem) then FOnDrawPopupItem(Self,TheIndex,ListBox,ListItemIndex,R)
  else DrawPopupItemDefault(ListBox,TheIndex,R,ListItemIndex);
end;

procedure TCustomInspector.SetEditedText(const AText: string);
begin
  with FEdit do
  begin
    FEditing:=True;
    Text:=AText;
    Modified:=True;
    SelectAll;
  end;
end;

function TCustomInspector.ValidateChar(TheIndex: Integer; var Key: Char): Boolean;
begin
  if Assigned(FOnValidateChar) then Result:=FOnValidateChar(Self,TheIndex,Key)
  else Result:=True;
end;

procedure TCustomInspector.ChangeValue(TheIndex: Integer; Editing: Boolean; const AText: string);
begin
  if Assigned(FOnChangeValue) then FOnChangeValue(Self,TheIndex,Editing,AText);
end;

procedure TCustomInspector.SetSelectionPos(TheIndex: Integer; NeedUpdate: Boolean);
begin
  if not (csDesigning in ComponentState) and
    ((TheIndex<>Index) and (TheIndex<>-1) or NeedUpdate) then
  begin
    Font.Assign(Self.Font);
    FSplitter:=Self.FSplitter;
    try
      if (TheIndex<>-1) and not GetReadOnly(FIndex) and GetAutoApply(FIndex) then ApplyChanges;
      FIndex:=TheIndex;
    except
      ItemIndex:=FIndex;
      raise;
    end;
    FFullUpdate:=True;
    UpdateControls;
    if Assigned(FOnSelect) then FOnSelect(Self,TheIndex);
  end;
end;

procedure TCustomInspector.ApplyChanges;
var
  WasFocused: Boolean;
begin
  WasFocused:=IsFocused;
  if FIndex<>-1 then
    if (GetInplaceEditorType(FIndex)=ieEdit) and FEdit.Modified then
    begin
      {$IFDEF GOITRIAL}
      TrialMessage;
      {$ELSE}
      SetValue(FIndex,FEdit.Text);
      {$ENDIF}
      FEdit.Modified:=False;
    end;
  if WasFocused then
  begin
    if FEdit.CanFocus then FEdit.SetFocus;
    if FCheckBox.CanFocus then FCheckBox.SetFocus;
  end;
end;

procedure TCustomInspector.IgnoreChanges;
begin
  if FIndex<>-1 then
    case GetInplaceEditorType(FIndex) of
      ieEdit: FEdit.Text:=GetValue(FIndex);
      ieCheckBox: FCheckBox.Checked:=StringToBoolean(GetValue(FIndex));
    end;
end;

procedure TCustomInspector.DrawPropertyName(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
begin
  TheCanvas.Brush.Color:=GetNameColor(TheIndex);
  GetNameFont(TheIndex,TheCanvas.Font);
  if Assigned(FOnDrawName) then FOnDrawName(Self,TheIndex,TheCanvas,R)
  else DrawPropertyNameDefault(TheCanvas,TheIndex,R);
end;

procedure TCustomInspector.DrawPropertyNameDefault(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);

var
  X,S,E: Integer;
  EB: TBitmap;
  FR: TRect;

  function FindItem(Start,Level: Integer): Boolean;
  var
    i: Integer;
  begin
    Result:=False;
    for i:=Succ(Start) to Pred(Items.Count) do
    begin
      Result:=GetLevel(i)=Level;
      if Result then Break;
    end;
  end;

begin
  case GetExpandState(TheIndex) of
    esExpand: EB:=FExpand;
    esCollapse: EB:=FCollapse;
  else EB:=nil;
  end;
  with TheCanvas,R do
    case FPaintStyle of
      psClassic:
      begin
        FillRect(R);
        if Assigned(EB) then
          Draw(Left+GetLevel(TheIndex)*GetIndent+2,Top+(Bottom-Top-FExpand.Height) div 2,EB);
        Inc(Left,Succ(GetLevel(TheIndex))*GetIndent+4);
        DrawText(Handle,PChar(GetName(TheIndex)),-1,R,DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS);
      end;
      psTree:
      begin
        Pen.Color:=clWhite;
        Pen.Color:=clBtnShadow;
        for X:=0 to GetLevel(TheIndex) do
        begin
          S:=Top-2;
          E:=Bottom;
          if TheIndex=0 then Inc(S,ItemHeight div 2+2);
          if not FindItem(TheIndex,X) then
            if GetLevel(TheIndex)=X then Dec(E,ItemHeight div 2)
            else Continue;
          MoveTo(Left+X*(GetIndent+2)+GetIndent div 2,S);
          LineTo(PenPos.X,E);
        end;
        MoveTo(Left+GetLevel(TheIndex)*(GetIndent+2)+GetIndent div 2,(Top+Bottom) div 2);
        LineTo(Left+Pred(Succ(GetLevel(TheIndex))*(GetIndent+2)),PenPos.Y);
        if Assigned(EB) then
          Draw(Left+GetLevel(TheIndex)*(GetIndent+2)+2,Top+(Bottom-Top) div 2-(FExpand.Height) div 2,EB);
        Inc(Left,Succ(GetLevel(TheIndex))*(GetIndent+2)+2);
        Dec(Bottom);
        Inc(Top);
        Dec(Right);
        DrawText(Handle,PChar(GetName(TheIndex)),-1,R,DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS or DT_CALCRECT);
        FR:=R;
        InflateRect(FR,2,0);
        FillRect(FR);
        DrawText(Handle,PChar(GetName(TheIndex)),-1,R,DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS);
      end;
      psGreatis:
      begin
        FillRect(
          Rect(
            Left+Pred(GetLevel(TheIndex)*(GetIndent+2)),
            Top,Right,Bottom));
        if Assigned(EB) then
          Draw(Left+GetLevel(TheIndex)*(GetIndent+2)+2,Top+(Bottom-Top-FExpand.Height) div 2,EB);
        Pen.Color:=clWhite;
        Pen.Color:=clBtnShadow;
        if GetExpandState(TheIndex)<>esNone then
        begin
          MoveTo(Left+Pred(Succ(GetLevel(TheIndex))*(GetIndent+2)),Top);
          LineTo(PenPos.X,Bottom);
        end;
        MoveTo(Left+Pred(Getlevel(TheIndex)*(GetIndent+2)),Top);
        LineTo(PenPos.X,Bottom);
        Inc(Left,Succ(GetLevel(TheIndex))*(GetIndent+2)+2);
        DrawText(Handle,PChar(GetName(TheIndex)),-1,R,DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS);
      end;
    end;
end;

procedure TCustomInspector.DrawPropertyValue(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
begin
  TheCanvas.Brush.Color:=GetValueColor(TheIndex);
  GetValueFont(TheIndex,TheCanvas.Font);
  if Assigned(FOnDrawValue) then FOnDrawValue(Self,TheIndex,TheCanvas,R)
  else DrawPropertyValueDefault(TheCanvas,TheIndex,R);
end;

procedure TCustomInspector.DrawPropertyValueDefault(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
var
  S: Integer;
  IR: TRect;
  V: string;
  C: Char;
begin
  with TheCanvas do
  begin
    FillRect(R);
    Dec(R.Bottom);
    V:=GetValue(TheIndex);
    C:=#0;
    GetPasswordChar(TheIndex,C);
    if C<>#0 then
      for S:=1 to Length(V) do V[S]:=C;
    case GetInplaceEditorType(TheIndex) of
      ieNone,ieEdit{$IFDEF GOICUSTOMEDIT},ieCustomEdit{$ENDIF}:
      begin
        Inc(R.Left);
        DrawText(Handle,PChar(V),-1,R,DT_SINGLELINE or DT_VCENTER or DT_END_ELLIPSIS or DT_NOPREFIX);
      end;
      ieCheckBox:
      begin
        IR:=R;
        with IR do
        begin
          Right:=Left+GetSystemMetrics(SM_CXMENUCHECK);
          Bottom:=Top+Right-Left;
          OffsetRect(IR,1,((R.Bottom-R.Top+1)-(Bottom-Top)) div 2);
        end;
        S:=DFCS_BUTTONCHECK;
        if StringToBoolean(V) then S:=S or DFCS_CHECKED;
        DrawFrameControl(Handle,IR,DFC_BUTTON,S);
      end;
    end;
  end;
end;

procedure TCustomInspector.DrawPopupItemDefault(ListBox: TCustomListBox; TheIndex: Integer; R: TRect; ListItemIndex: Integer);
begin
  with ListBox,Canvas,R do
  begin
    Inc(Left,2);
    
    TextRect(R, R.Left, R.Top, PChar(Items[ListItemIndex]));
  end;
end;

procedure TCustomInspector.DrawBorders(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
begin
  {$IFDEF UNIX} if R.Top >= 0 then  {$ENDIF}
  with TheCanvas,R do
    case FPaintStyle of
      psClassic:
      begin
        Pen.Color:=clBlack;
        MoveTo(Left,Bottom-1);
        LineTo(Left,Top-1);
        LineTo(Right,Top-1);
        Pen.Color:=clBtnHighlight;
        LineTo(Right,Bottom-1);
        LineTo(Pred(Left),Bottom-1);
        InflateRect(R,-1,-1);
        Pen.Color:=clBtnShadow;
        MoveTo(Left,Bottom-2);
        LineTo(Left,Top-2);
        LineTo(Succ(Right),Top-2);
        Pen.Color:=cl3DLight;
        MoveTo(Left+1,Bottom);
        LineTo(Right+1,Bottom);
      end;
    end;
end;

procedure TCustomInspector.DrawVerticalSeparator(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
var
  B: Integer;
begin
  with TheCanvas,R do
    case FPaintStyle of
      psClassic:
      begin
        if TheIndex=ItemIndex then B:=Bottom-1
        else B:=Bottom;
        Pen.Color:=clBtnShadow;
        MoveTo(Pred(FSplitter),Top);
        LineTo(Pred(FSplitter),B);
        Pen.Color:=clBtnHighlight;
        MoveTo(FSplitter,Top);
        LineTo(FSplitter,B);
      end;
      psGreatis,psTree:
      begin
        Pen.Color:=clWhite;
        Pen.Color:=clBtnShadow;
        MoveTo(FSplitter,Top);
        LineTo(FSplitter,Bottom);
      end;
    end;
end;

procedure TCustomInspector.DrawHorizontalSeparator(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
var
  i: Integer;
begin
  with TheCanvas,R do
    case FPaintStyle of
      psClassic:
        {$IFDEF FPC};{$ELSE}for i:=Left to Pred(Right) do
          if not Odd(i) then
            SetPixel(Handle,i,Pred(Bottom),ColorToRGB(clBtnShadow));
        {$ENDIF}
      psTree:
      begin
        if TheIndex<Pred(Items.Count) then Pen.Color:=GetValueColor(TheIndex)
        else Pen.Color:=Self.Color;
        MoveTo(Left+FSplitter,Pred(Bottom));
        LineTo(Right,Pred(Bottom));
      end;
      psGreatis:
      begin
        Pen.Color:=clWhite;
        Pen.Color:=clBtnShadow;
        i:=GetLevel(TheIndex);
        if (TheIndex<Pred(ItemCount)) and (GetLevel(Succ(TheIndex))<i) then
          i:=GetLevel(Succ(TheIndex));
        MoveTo(Left+Pred(i*(GetIndent+2)),Pred(Bottom));
        LineTo(Right,Pred(Bottom));
      end;
    end;
end;

function TCustomInspector.GetName(TheIndex: Integer): string;
begin
  Result:='';
  if Assigned(FOnGetName) then FOnGetName(Self,TheIndex,Result);
end;

function TCustomInspector.GetValue(TheIndex: Integer): string;
begin
  Result:='';
  if Assigned(FOnGetValue) then FOnGetValue(Self,TheIndex,Result);
end;

function TCustomInspector.GetNextValue(TheIndex: Integer): string;
begin
  Result:='';
  if Assigned(FOnGetNextValue) then FOnGetNextValue(Self,TheIndex,Result);
end;

procedure TCustomInspector.SetValue(TheIndex: Integer; const Value: string);
begin
  if Assigned(FOnSetValue) then FOnSetValue(Self,TheIndex,Value);
end;

procedure TCustomInspector.DragValue(TheIndex,Offset: Integer);
begin
  if Assigned(FOnDragValue) then FOnDragValue(Self,TheIndex,Offset);
end;

procedure TCustomInspector.GetPasswordChar(TheIndex: Integer; var Value: Char);
begin
  if Assigned(FOnGetPasswordChar) then FOnGetPasswordChar(Self,TheIndex,Value);
end;

function TCustomInspector.GetButtonType(TheIndex: Integer): TButtonType;
begin
  Result:=btNone;
  if Assigned(FOnGetButtonType) then FOnGetButtonType(Self,TheIndex,Result);
end;

function TCustomInspector.GetInplaceEditorType(TheIndex: Integer): TInplaceEditorType;
begin
  Result:=ieEdit;
  if Assigned(FOnGetInplaceEditorType) then FOnGetInplaceEditorType(Self,TheIndex,Result);
end;

{$IFDEF GOICUSTOMEDIT}
function TCustomInspector.GetInplaceEditor(TheIndex: Integer): TComponent;
begin
  Result:=nil;
  if Assigned(FOnGetInplaceEditor) then FOnGetInplaceEditor(Self,TheIndex,Result);
end;
{$ENDIF}

function TCustomInspector.GetMaxLength(TheIndex: Integer): Integer;
begin
  Result:=0;
  if Assigned(FOnGetMaxLength) then FOnGetMaxLength(Self,TheIndex,Result);
end;

function TCustomInspector.GetEditMask(TheIndex: Integer): string;
begin
  Result:='';
  if Assigned(FOnGetEditMask) then FOnGetEditMask(Self,TheIndex,Result);
end;

function TCustomInspector.GetEnableExternalEditor(TheIndex: Integer): Boolean;
begin
  Result:=False;
  if Assigned(FOnGetEnableExternalEditor) then FOnGetEnableExternalEditor(Self,TheIndex,Result);
end;

function TCustomInspector.GetReadOnly(TheIndex: Integer): Boolean;
begin
  Result:=False;
  if Assigned(FOnGetReadOnly) then FOnGetReadOnly(Self,TheIndex,Result);
end;

function TCustomInspector.GetExpandState(TheIndex: Integer): TExpandState;
begin
  Result:=esNone;
  if Assigned(FOnGetExpandState) then FOnGetExpandState(Self,TheIndex,Result);
end;

function TCustomInspector.GetLevel(TheIndex: Integer): Integer;
begin
  Result:=2;
  if Assigned(FOnGetLevel) then FOnGetLevel(Self,TheIndex,Result);
end;

function TCustomInspector.GetData(TheIndex: Integer): Pointer;
begin
  Result:=nil;
  if Assigned(FOnGetData) then FOnGetData(Self,TheIndex,Result);
end;

procedure TCustomInspector.GetValuesList(TheIndex: Integer; const Strings: TStrings);
begin
  if Assigned(Strings) and Assigned(FOnGetValuesList) then
  begin
    Strings.Clear;
    FOnGetValuesList(Self,TheIndex,Strings);
  end;
end;

function TCustomInspector.GetSortValuesList(TheIndex: Integer): Boolean;
begin
  Result:=False;
  if Assigned(FOnGetSortValuesList) then FOnGetSortValuesList(Self,TheIndex,Result);
end;

function TCustomInspector.GetSelectedValue(TheIndex: Integer): string;
begin
  Result:=Values[TheIndex];
  if Assigned(FOnGetSelectedValue) then FOnGetSelectedValue(Self,TheIndex,Result);
end;

function TCustomInspector.GetAutoApply(TheIndex: Integer): Boolean;
begin
  Result:=False;
  if Assigned(FOnGetAutoApply) then FOnGetAutoApply(Self,TheIndex,Result);
end;

procedure TCustomInspector.GetNameFont(TheIndex: Integer; TheFont: TFont);
begin
  case FPaintStyle of
    psGreatis,psTree:
      if TheIndex=ItemIndex then TheFont.Color:=clHighlightText
  end;
  if Assigned(FOnGetNameFont) then FOnGetNameFont(Self,TheIndex,TheFont);
end;

function TCustomInspector.GetNameColor(TheIndex: Integer): TColor;
begin
  case FPaintStyle of
    psGreatis,psTree:
      if TheIndex=ItemIndex then Result:=clHighlight
      else Result:=Color;
  else Result:=Color;
  end;
  if Assigned(FOnGetNameColor) then FonGetNameColor(Self,TheIndex,Result);
end;

procedure TCustomInspector.GetValueFont(TheIndex: Integer; TheFont: TFont);
begin
  if Assigned(FOnGetValueFont) then FOnGetValueFont(Self,TheIndex,TheFont);
end;

function TCustomInspector.GetValueColor(TheIndex: Integer): TColor;
begin
  Result:=Color;
  if Assigned(FOnGetValueColor) then FonGetValueColor(Self,TheIndex,Result);
end;

function TCustomInspector.GetIndent: Integer;
begin
  Result:=FExpand.Width;
  case FPaintStyle of
    psGreatis: Inc(Result,3);
    psTree: Inc(Result,4);
  end;
end;

function TCustomInspector.CallEditor(TheIndex: Integer): Boolean;
begin
  if Assigned(FOnCallEditor) then Result:=FOnCallEditor(Self,TheIndex)
  else Result:=False;
end;

procedure TCustomInspector.Expand(TheIndex: Integer);
begin
  if Assigned(FOnExpand) then FOnExpand(Self,TheIndex);
end;

procedure TCustomInspector.Collapse(TheIndex: Integer);
begin
  if Assigned(FOnCollapse) then FOnCollapse(Self,TheIndex);
end;

procedure TCustomInspector.SelectItem(TheIndex: Integer);
begin
  if Assigned(FOnSelectItem) then FOnSelectItem(Self,TheIndex);
end;

procedure TCustomInspector.DeselectItem(TheIndex: Integer);
begin
  if Assigned(FOnDeselectItem) then FOnDeselectItem(Self,TheIndex);
end;

{$IFDEF FPC}
procedure TCustomInspector.DoSelectionChange(User: Boolean);
var i: Integer;
    R: TRect;
begin
  inherited DoSelectionChange(User);
  i:=FIndex;
  DeselectItem(ItemIndex);
  SetSelectionPos(ItemIndex ,False);
  inherited;
  R:=ItemRect(i);
  Dec(R.Top,2);
  Inc(R.Bottom);
  InvalidateRect(Handle,@R,True);
  UpdateControls;
  SelectItem(ItemIndex);
end;
{$ENDIF}

constructor TCustomInspector.Create(AOwner: TComponent);
var   B: TBitmap;
begin
  inherited;
  Style:=lbOwnerDrawFixed;
  Color:=clBtnFace;
  FSplitter:=100;
  FSizing:= False;
  FItemIndexOld:= -1;
  FEditPanel:=TPanel.Create(AOwner);
  FEditPanel.Parent := TWinControl(AOwner);
  FEditPanel.Visible:=False;
  FEditPanel.BevelInner := bvNone;
  FEditPanel.BevelOuter := bvNone;
  FEdit:=TInspectorEdit.Create(AOwner);
  FEdit.Parent:=TWinControl(FEditPanel);
  FEdit.Inspector := Self;
  
  {$IFDEF GOICUSTOMEDIT}
  FDefaultEdit:=FEdit;
  {$ENDIF}
  with FEdit do
  begin
    BorderStyle:=bsNone;
    Visible:=False;
    
  end;
  FCheckBox:=TInspectorCheckBox.Create(AOwner);
  FCheckBox.Parent:=TWinControl(FEditPanel);
  FCheckBox.Inspector := Self;
  
  with FCheckBox do
  begin
    ParentColor:=False;
    Color:=clWindow;
    Visible:=False;
    
  end;
  FButton:=TInspectorButton.Create(AOwner);
  FButton.Parent:=TWinControl(FEditPanel);
  FButton.Inspector := Self;
  
  {$IFDEF FPC}
  B := TBitmap.Create;
  try
    B.Canvas.Font := Font;
    ItemHeight := B.Canvas.TextHeight('Fj');
  finally
    B.Free;
  end;
  if ItemHeight < 16 then ItemHeight := 16;
  {$ENDIF}
  FPopupPanel:=TPanel.Create(AOwner);
  FPopupPanel.Parent := TWinControl(AOwner);
  FPopupPanel.Visible:=False;
  FPopup:=TInspectorPopup.Create(AOwner);
  FPopup.Inspector := Self;
  FPopup.Parent := TWinControl(FPopupPanel);
  FPopup.ItemHeight:=ItemHeight;
  FPopup.Align:=alClient;
  FExpand:=TBitmap.Create;
  FExpand.Handle:=LoadBitmap(HInstance,'EXPAND');
  with FExpand, Canvas do
  begin
    {$IFnDEF FPC}
    PixelFormat:=pf4bit;
    {$ENDIF}
    Brush.Color:=clWindow;
    FloodFill(2,2,clBlack,fsBorder);
  end;

  FCollapse:=TBitmap.Create;
  FCollapse.Handle:=LoadBitmap(HInstance,'COLLAPSE');
  with FCollapse,Canvas do
  begin
    {$IFnDEF FPC}
    PixelFormat:=pf4bit;
    {$ENDIF}
    Brush.Color:=clWindow;
    FloodFill(2,2,clBlack,fsBorder);
  end;
  {$IFDEF GOITRIAL}
  if not (csDesigning in ComponentState) then
    Application.MessageBox(
      'You are using trial version of GREATIS OBJECT INSPECTOR components'#13'with some functional limitations.',
      'GREATIS OBJECT INSPECTOR  - Trial Version',
      MB_OK or MB_ICONEXCLAMATION);
  {$ENDIF}
  Screen.Cursors[crUpDown]:=LoadCursor(HInstance,'UPDOWN');
end;

destructor TCustomInspector.Destroy;
begin
  FExpand.Free;
  FCollapse.Free;
  inherited;
end;

procedure TCustomInspector.Update;
var
  R: TRect;
begin
  if not Locked then
  begin
    if Assigned(FPopupPanel) and (Screen.ActiveControl <> FPopup) then HidePopup;
    RedrawWindow(Handle,nil,0,RDW_NOERASE or RDW_INVALIDATE);
    if not FFullUpdate then
    begin
      R:=ItemRect(ItemIndex);                   
      R.Right:=FSplitter;
      {$IFDEF FPC}{$ELSE}ValidateRect(Handle,@R);{$ENDIF}
    end;
    FFullUpdate:=False;
    UpdateControls;
    if Assigned(FOnUpdate) then FOnUpdate(Self);
  end;
end;

procedure TCustomInspector.Lock;
begin
  Inc(FLockCounter);
end;

procedure TCustomInspector.Unlock;
begin
  if Locked then Dec(FLockCounter);
end;

procedure TCustomInspector.CreateWnd;
begin
  inherited;
  ItemCount:=FItemCount;
  FOldWidth:=0;
  FOldHeight:=0;
  FOldSplitter:=0;
  UpdateControls;
end;

initialization
  RegisterClass(TInspectorPopup);
  RegisterClass(TInspectorButton);
  RegisterClass(TInspectorEdit);
  RegisterClass(TInspectorCheckBox);
end.
