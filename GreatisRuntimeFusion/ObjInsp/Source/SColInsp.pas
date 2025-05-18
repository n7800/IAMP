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

unit SColInsp;

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
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
  Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  SysUtils, Classes, Graphics, StdCtrls, Dialogs, InspCtrl;

const
  {$IFDEF VERSION3}
  COLOR_GRADIENTACTIVECAPTION = 27;
  COLOR_GRADIENTINACTIVECAPTION = 28;
  {$ENDIF}

  clMoneyGreen = TColor($C0DCC0);
  clSkyBlue = TColor($F0CAA6);
  clCream = TColor($F0FBFF);
  clMedGray = TColor($A4A0A0);

  STR_COLOR_3DDKSHADOW              = '3D dark shadow';
  STR_COLOR_3DFACE                  = '3D face';
  STR_COLOR_3DHILIGHT               = '3D highlight';
  STR_COLOR_3DLIGHT	                = '3D light';
  STR_COLOR_3DSHADOW                = '3D shadow';
  STR_COLOR_ACTIVEBORDER	          = 'Active window border';
  STR_COLOR_ACTIVECAPTION	          = 'Active window caption';
  STR_COLOR_GRADIENTACTIVECAPTION   = 'Active window caption gradient';
  STR_COLOR_APPWORKSPACE            =	'MDI background color';
  STR_COLOR_DESKTOP	                = 'Desktop';
  STR_COLOR_BTNTEXT	                = 'Text on push buttons';
  STR_COLOR_CAPTIONTEXT	            = 'Active window caption text';
  STR_COLOR_GRAYTEXT	              = 'Grayed text';
  STR_COLOR_HIGHLIGHT	              = 'Selected item';
  STR_COLOR_HIGHLIGHTTEXT	          = 'Text of selected item';
  STR_COLOR_INACTIVEBORDER	        = 'Inactive window border';
  STR_COLOR_INACTIVECAPTION	        = 'Inactive window caption';
  STR_COLOR_GRADIENTINACTIVECAPTION	= 'Inactive window caption gradient';
  STR_COLOR_INACTIVECAPTIONTEXT	    = 'Inactive window caption text';
  STR_COLOR_INFOBK                  = 'Tooltip background';
  STR_COLOR_INFOTEXT	              = 'Tooltip text';
  STR_COLOR_MENU	                  = 'Menu background';
  STR_COLOR_MENUTEXT	              = 'Menu text';
  STR_COLOR_SCROLLBAR	              = 'Scroll bar background';
  STR_COLOR_WINDOW	                = 'Window background';
  STR_COLOR_WINDOWFRAME	            = 'Window frame';
  STR_COLOR_WINDOWTEXT	            = 'Window text';

  strWhite      = 'White';
  strBlack      = 'Black';
  strSilver     = 'Silver';
  strGray       = 'Gray';
  strRed        = 'Red';
  strMaroon     = 'Maroon';
  strYellow     = 'Yellow';
  strOlive      = 'Olive';
  strLime       = 'Lime';
  strGreen      = 'Green';
  strAqua       = 'Aqua';
  strTeal       = 'Teal';
  strBlue       = 'Blue';
  strNavy       = 'Navy';
  strFuchsia    = 'Fuchsia';
  strPurple     = 'Purple';
  strMoneyGreen = 'Money Green';
  strSkyBlue    = 'Sky Blue';
  strCream      = 'Cream';
  strMedGray    = 'Medium Gray';

type
  TColorData = record
    ColorID: Integer;
    ColorName: ShortString;
  end;

const
  ColorCount = 27;
  ColorsData: array[0..Pred(ColorCount)] of TColorData = (
    (ColorID: COLOR_3DDKSHADOW; ColorName: STR_COLOR_3DDKSHADOW),
    (ColorID: COLOR_3DFACE; ColorName: STR_COLOR_3DFACE),
    (ColorID: COLOR_3DHILIGHT; ColorName: STR_COLOR_3DHILIGHT),
    (ColorID: COLOR_3DLIGHT; ColorName: STR_COLOR_3DLIGHT),
    (ColorID: COLOR_3DSHADOW; ColorName: STR_COLOR_3DSHADOW),
    (ColorID: COLOR_DESKTOP; ColorName: STR_COLOR_DESKTOP),
    (ColorID: COLOR_APPWORKSPACE; ColorName: STR_COLOR_APPWORKSPACE),
    (ColorID: COLOR_WINDOWFRAME; ColorName: STR_COLOR_WINDOWFRAME),
    (ColorID: COLOR_WINDOW; ColorName: STR_COLOR_WINDOW),
    (ColorID: COLOR_WINDOWTEXT; ColorName: STR_COLOR_WINDOWTEXT),
    (ColorID: COLOR_ACTIVEBORDER; ColorName: STR_COLOR_ACTIVEBORDER),
    (ColorID: COLOR_ACTIVECAPTION; ColorName: STR_COLOR_ACTIVECAPTION),
    (ColorID: COLOR_GRADIENTACTIVECAPTION; ColorName: STR_COLOR_GRADIENTACTIVECAPTION),
    (ColorID: COLOR_CAPTIONTEXT; ColorName: STR_COLOR_CAPTIONTEXT),
    (ColorID: COLOR_INACTIVEBORDER; ColorName: STR_COLOR_INACTIVEBORDER),
    (ColorID: COLOR_INACTIVECAPTION; ColorName: STR_COLOR_INACTIVECAPTION),
    (ColorID: COLOR_GRADIENTINACTIVECAPTION; ColorName: STR_COLOR_GRADIENTINACTIVECAPTION),
    (ColorID: COLOR_INACTIVECAPTIONTEXT; ColorName: STR_COLOR_INACTIVECAPTIONTEXT),
    (ColorID: COLOR_HIGHLIGHT; ColorName: STR_COLOR_HIGHLIGHT),
    (ColorID: COLOR_HIGHLIGHTTEXT; ColorName: STR_COLOR_HIGHLIGHTTEXT),
    (ColorID: COLOR_GRAYTEXT; ColorName: STR_COLOR_GRAYTEXT),
    (ColorID: COLOR_BTNTEXT; ColorName: STR_COLOR_BTNTEXT),
    (ColorID: COLOR_INFOBK; ColorName: STR_COLOR_INFOBK),
    (ColorID: COLOR_INFOTEXT; ColorName: STR_COLOR_INFOTEXT),
    (ColorID: COLOR_MENU; ColorName: STR_COLOR_MENU),
    (ColorID: COLOR_MENUTEXT; ColorName: STR_COLOR_MENUTEXT),
    (ColorID: COLOR_SCROLLBAR; ColorName: STR_COLOR_SCROLLBAR));

  StdColorCount = 20;
  StdColorsData: array[0..Pred(StdColorCount)] of TColorData = (
    (ColorID: clWhite; ColorName: strWhite),
    (ColorID: clBlack; ColorName: strBlack),
    (ColorID: clSilver; ColorName: strSilver),
    (ColorID: clGray; ColorName: strGray),
    (ColorID: clRed; ColorName: strRed),
    (ColorID: clMaroon; ColorName: strMaroon),
    (ColorID: clYellow; ColorName: strYellow),
    (ColorID: clOlive; ColorName: strOlive),
    (ColorID: clLime; ColorName: strLime),
    (ColorID: clGreen; ColorName: strGreen),
    (ColorID: clAqua; ColorName: strAqua),
    (ColorID: clteal; ColorName: strTeal),
    (ColorID: clBlue; ColorName: strBlue),
    (ColorID: clNavy; ColorName: strNavy),
    (ColorID: clFuchsia; ColorName: strFuchsia),
    (ColorID: clPurple; ColorName: strPurple),
    (ColorID: clMoneyGreen; ColorName: strMoneyGreen),
    (ColorID: clSkyBlue; ColorName: strSkyBlue),
    (ColorID: clCream; ColorName: strCream),
    (ColorID: clMedGray; ColorName: strMedGray));

type

  TCustomSystemColorsInspector = class(TCustomInspector)
  private
    function StdColorToName(C: TColor): string;
    function StdNameToColor(S: string; var C: TColor): Boolean;
  protected
    function GetPopupItemWidth(ListBox: TListBox; TheIndex: Integer): Integer; override;
    procedure DrawPopupItem(ListBox: TListBox; ListItemIndex: Integer; R: TRect; TheIndex: Integer); override;
    procedure DrawPropertyValue(TheCanvas: TCanvas; TheIndex: Integer; R: TRect); override;
    function GetName(TheIndex: Integer): string; override;
    function GetValue(TheIndex: Integer): string; override;
    procedure SetValue(TheIndex: Integer; const Value: string); override;
    function GetIndent: Integer; override;
    procedure GetValuesList(TheIndex: Integer; const Strings: TStrings); override;
    function GetSelectedValue(TheIndex: Integer): string; override;
    function GetButtonType(TheIndex: Integer): TButtonType; override;
    function GetEnableExternalEditor(TheIndex: Integer): Boolean; override;
    function CallEditor(TheIndex: Integer): Boolean; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TSystemColorsInspector = class(TCustomSystemColorsInspector)
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
    property IntegralHeight;
    property ParentColor;
    {$IFNDEF FPC} property ParentCtl3D; {$ENDIF}
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
    property Sorted;
    property TabOrder;
    property TabStop;
    property Visible;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnStartDrag;
    property PaintStyle;
    property Splitter;
    property OnUpdate;
    property OnValidateChar;
    property OnChangeValue;
    property OnDrawName;
    property OnDrawValue;
    property OnGetName;
    property OnGetValue;
    property OnGetNextValue;
    property OnSetValue;
    property OnGetButtonType;
    property OnGetInplaceEditorType;
    property OnGetMaxLength;
    property OnGetEditMask;
    property OnGetEnableExternalEditor;
    property OnGetReadOnly;
    property OnGetExpandState;
    property OnGetLevel;
    property OnGetValuesList;
    property OnGetSortValuesList;
    property OnGetSelectedValue;
    property OnGetAutoApply;
    property OnGetNameFont;
    property OnGetNameColor;
    property OnGetValueFont;
    property OnGetValueColor;
    property OnCallEditor;
    property OnSelectItem;
    property OnDeselectItem;
    property OnValueDoubleClick;
  end;

implementation

function TCustomSystemColorsInspector.StdColorToName(C: TColor): string;
var
  i: Integer;
begin
  for i:=0 to Pred(StdColorCount) do
    with StdColorsData[i] do
      if ColorID=C then
      begin
        Result:=ColorName;
        Exit;
      end;
  Result:=Format('%d,%d,%d',[GetRValue(C),GetGValue(C),GetBValue(C)]);
end;

function TCustomSystemColorsInspector.StdNameToColor(S: string; var C: TColor): Boolean;
var
  i,R,G,B,P: Integer;
begin
  S:=AnsiUpperCase(S);
  for i:=0 to Pred(StdColorCount) do
    with StdColorsData[i] do
      if AnsiUpperCase(ColorName)=S then
      begin
        C:=ColorID;
        Result:=True;
        Exit;
      end;
  Result:=False;
  try
    P:=Pos(',',S);
    if P<>0 then
    begin
      R:=StrToInt(Copy(S,1,Pred(P)));
      Delete(S,1,P);
      P:=Pos(',',S);
      if P<>0 then
      begin
        G:=StrToInt(Copy(S,1,Pred(P)));
        Delete(S,1,P);
        B:=StrToInt(S);
        C:=RGB(R,G,B);
        Result:=True;
      end;
    end;
  except
  end;
end;

function TCustomSystemColorsInspector.GetPopupItemWidth(ListBox: TListBox; TheIndex: Integer): Integer;
begin
  Result:=inherited GetPopupItemWidth(ListBox,TheIndex)+ItemHeight-2;
end;

procedure TCustomSystemColorsInspector.DrawPopupItem(ListBox: TListBox; ListItemIndex: Integer; R: TRect; TheIndex: Integer);
var
  IR: TRect;
  OldColor: TColor;
begin
  with ListBox,Canvas,R do
  begin
    FillRect(R);
    Pen.Color:=clWindowText;
    OldColor:=Brush.Color;
    Brush.Color:=StdColorsData[ListItemIndex].ColorID;
    IR:=R;
    InflateRect(IR,-2,-2);
    with IR do
    begin
      Dec(Bottom);
      Right:=Left+(Bottom-Top);
      Rectangle(Left,Top,Right,Bottom);
    end;
    Brush.Color:=OldColor;
    Inc(Left,ItemHeight-1);
    DrawText(Handle,PChar(Items[ListItemIndex]),-1,R,DT_SINGLELINE or DT_VCENTER);
  end;
end;

procedure TCustomSystemColorsInspector.DrawPropertyValue(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
var
  IR: TRect;
begin
  with TheCanvas,R do
  begin
    Pen.Color:=clWindowText;
    Brush.Color:=GetSysColor(ColorsData[TheIndex].ColorID);
    IR:=R;
    InflateRect(IR,-2,-2);
    with IR do
    begin
      Dec(Bottom);
      Right:=Left+(Bottom-Top);
      Rectangle(Left,Top,Right,Bottom);
    end;
    Inc(Left,ItemHeight-2);
  end;
  inherited;
end;

function TCustomSystemColorsInspector.GetName(TheIndex: Integer): string;
begin
  Result:=ColorsData[TheIndex].ColorName;
end;

function TCustomSystemColorsInspector.GetValue(TheIndex: Integer): string;
begin
  Result:=StdColorToName(GetSysColor(ColorsData[TheIndex].ColorID));
end;

procedure TCustomSystemColorsInspector.SetValue(TheIndex: Integer; const Value: string);
var
  C: TColor;
begin
  if StdNameToColor(Value,C) and (C<>GetSysColor(ColorsData[TheIndex].ColorID)) then
    SetSysColors(1,ColorsData[TheIndex].ColorID,C);
end;

function TCustomSystemColorsInspector.GetIndent: Integer;
begin
  Result:=0;
end;

procedure TCustomSystemColorsInspector.GetValuesList(TheIndex: Integer; const Strings: TStrings);
var
  i: Integer;
begin
  for i:=0 to Pred(StdColorCount) do Strings.Add(StdColorsData[i].ColorName);
end;

function TCustomSystemColorsInspector.GetSelectedValue(TheIndex: Integer): string;
begin
  Result:=GetValue(TheIndex);
end;

function TCustomSystemColorsInspector.GetButtonType(TheIndex: Integer): TButtonType;
begin
  Result:=btDropDown;
end;

function TCustomSystemColorsInspector.GetEnableExternalEditor(TheIndex: Integer): Boolean;
begin
  Result:=True;
end;

function TCustomSystemColorsInspector.CallEditor(TheIndex: Integer): Boolean;
begin
  with TColorDialog.Create(Self) do
  try
    Color:=GetSysColor(ColorsData[TheIndex].ColorID);
    Result:=Execute;
    if Result and (Color<>GetSysColor(ColorsData[TheIndex].ColorID)) then
    begin
      SetSysColors(1,ColorsData[TheIndex].ColorID,Color);
      Update;
    end;
  finally
    Free;
  end;
end;

constructor TCustomSystemColorsInspector.Create(AOwner: TComponent);
begin
  inherited;
  ItemCount:=ColorCount;
end;

end.
