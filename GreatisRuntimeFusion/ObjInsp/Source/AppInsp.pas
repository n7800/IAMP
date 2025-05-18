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

unit AppInsp;

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$DEFINE VERSION4}
{$DEFINE VERSION5}
{$DEFINE VERSION6}
{$DEFINE VERSION7}
{$DEFINE VERSION9}
{$ENDIF}

{$IFDEF VER120}
  {$DEFINE VERSION4}
{$ENDIF}
{$IFDEF VER125}
  {$DEFINE VERSION4}
{$ENDIF}
{$IFDEF VER130}
  {$DEFINE VERSION4}
  {$DEFINE VERSION5}
{$ENDIF}
{$IFDEF VER140}
  {$DEFINE VERSION4}
  {$DEFINE VERSION5}
  {$DEFINE VERSION6}
{$ENDIF}
{$IFDEF VER150}
  {$DEFINE VERSION4}
  {$DEFINE VERSION5}
  {$DEFINE VERSION6}
  {$DEFINE VERSION7}
{$ENDIF}
{$IFDEF VER170}
  {$DEFINE VERSION4}
  {$DEFINE VERSION5}
  {$DEFINE VERSION6}
  {$DEFINE VERSION7}
  {$DEFINE VERSION9}
{$ENDIF}
{$IFDEF VER180}
  {$DEFINE VERSION4}
  {$DEFINE VERSION5}
  {$DEFINE VERSION6}
  {$DEFINE VERSION7}
  {$DEFINE VERSION9}
{$ENDIF}
{$IFDEF VER200}
  {$DEFINE VERSION4}
  {$DEFINE VERSION5}
  {$DEFINE VERSION6}
  {$DEFINE VERSION7}
  {$DEFINE VERSION9}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  SysUtils, Classes, Graphics, Forms, Dialogs,
  {$IFDEF VERSION4}
  ActnList,
  {$ENDIF}
  PropList, InspCtrl, CompInsp;

type

  TApplicationInterface = class(TComponent)
  private
    function GetHelpFile: string;
    procedure SetHelpFile(const Value: string);
    function GetHintColor: TColor;
    procedure SetHintColor(const Value: TColor);
    function GetHintHidePause: Integer;
    procedure SetHintHidePause(const Value: Integer);
    function GetHintPause: Integer;
    procedure SetHintPause(const Value: Integer);
    function GetHintShortPause: Integer;
    procedure SetHintShortPause(const Value: Integer);
    function GetIcon: TIcon;
    procedure SetIcon(const Value: TIcon);
    function GetShowHint: Boolean;
    procedure SetShowHint(const Value: Boolean);
    function GetTitle: string;
    procedure SetTitle(const Value: string);
    function GetUpdateFormatSettings: Boolean;
    procedure SetUpdateFormatSettings(const Value: Boolean);
    function GetUpdateMetricSettings: Boolean;
    procedure SetUpdateMetricSettings(const Value: Boolean);
    function GetOnActivate: TNotifyEvent;
    procedure SetOnActivate(const Value: TNotifyEvent);
    function GetOnDeactivate: TNotifyEvent;
    procedure SetOnDeactivate(const Value: TNotifyEvent);
    function GetOnException: TExceptionEvent;
    procedure SetOnException(const Value: TExceptionEvent);
    function GetOnHelp: THelpEvent;
    procedure SetOnHelp(const Value: THelpEvent);
    function GetOnHint: TNotifyEvent;
    procedure SetOnHint(const Value: TNotifyEvent);
    function GetOnIdle: TIdleEvent;
    procedure SetOnIdle(const Value: TIdleEvent);
    {$IFnDEF FPC}
    function GetOnMessage: TMessageEvent;
    procedure SetOnMessage(const Value: TMessageEvent);
    {$ENDIF}
    function GetOnMinimize: TNotifyEvent;
    procedure SetOnMinimize(const Value: TNotifyEvent);
    function GetOnRestore: TNotifyEvent;
    procedure SetOnRestore(const Value: TNotifyEvent);
    function GetOnShowHint: TShowHintEvent;
    procedure SetOnShowHint(const Value: TShowHintEvent);
    {$IFDEF VERSION4}
    function GetBiDiMode: TBiDiMode;
    procedure SetBiDiMode(const Value: TBiDiMode);
    function GetHintShortCuts: Boolean;
    procedure SetHintShortCuts(const Value: Boolean);
    function GetOnActionExecute: TActionEvent;
    procedure SetOnActionExecute(const Value: TActionEvent);
    function GetOnActionUpdate: TActionEvent;
    procedure SetOnActionUpdate(const Value: TActionEvent);
    function GetOnShortCut: TShortCutEvent;
    procedure SetOnShortCut(const Value: TShortCutEvent);
    {$ENDIF}
    {$IFDEF VERSION5}
    function GetBiDiKeyboard: string;
    procedure SetBiDiKeyboard(const Value: string);
    function GetNonBiDiKeyboard: string;
    procedure SetNonBiDiKeyboard(const Value: string);
    {$ENDIF}
    {$IFDEF VERSION6}
    function GetAutoDragDocking: Boolean;
    procedure SetAutoDragDocking(const Value: Boolean);
    {$IFnDEF FPC}
    function GetOnSettingChange: TSettingChangeEvent;
    procedure SetOnSettingChange(const Value: TSettingChangeEvent);
    {$ENDIF}
    {$ENDIF}
    {$IFDEF VERSION7}
    function GetOnModalBegin: TNotifyEvent;
    procedure SetOnModalBegin(const Value: TNotifyEvent);
    function GetOnModalEnd: TNotifyEvent;
    procedure SetOnModalEnd(const Value: TNotifyEvent);
    {$ENDIF}
  published
    property HelpFile: string read GetHelpFile write SetHelpFile;
    property HintColor: TColor read GetHintColor write SetHintColor;
    property HintHidePause: Integer read GetHintHidePause write SetHintHidePause;
    property HintPause: Integer read GetHintPause write SetHintPause;
    property HintShortPause: Integer read GetHintShortPause write SetHintShortPause;
    property Icon: TIcon read GetIcon write SetIcon;
    property ShowHint: Boolean read GetShowHint write SetShowHint;
    property Title: string read GetTitle write SetTitle;
    property UpdateFormatSettings: Boolean read GetUpdateFormatSettings write SetUpdateFormatSettings;
    property UpdateMetricSettings: Boolean read GetUpdateMetricSettings write SetUpdateMetricSettings;
    property OnActivate: TNotifyEvent read GetOnActivate write SetOnActivate;
    property OnDeactivate: TNotifyEvent read GetOnDeactivate write SetOnDeactivate;
    property OnException: TExceptionEvent read GetOnException write SetOnException;
    property OnHelp: THelpEvent read GetOnHelp write SetOnHelp;
    property OnHint: TNotifyEvent read GetOnHint write SetOnHint;
    property OnIdle: TIdleEvent read GetOnIdle write SetOnIdle;
    {$IFnDEF FPC}
    property OnMessage: TMessageEvent read GetOnMessage write SetOnMessage;
    {$ENDIF}
    property OnMinimize: TNotifyEvent read GetOnMinimize write SetOnMinimize;
    property OnRestore: TNotifyEvent read GetOnRestore write SetOnRestore;
    property OnShowHint: TShowHintEvent read GetOnShowHint write SetOnShowHint;
    {$IFDEF VERSION4}
    property BiDiMode: TBiDiMode read GetBiDiMode write SetBiDiMode;
    property HintShortCuts: Boolean read GetHintShortCuts write SetHintShortCuts;
    property OnActionExecute: TActionEvent read GetOnActionExecute write SetOnActionExecute;
    property OnActionUpdate: TActionEvent read GetOnActionUpdate write SetOnActionUpdate;
    property OnShortCut: TShortCutEvent read GetOnShortCut write SetOnShortCut;
    {$ENDIF}
    {$IFDEF VERSION5}
    property BiDiKeyboard: string read GetBiDiKeyboard write SetBiDiKeyboard;
    property NonBiDiKeyboard: string read GetNonBiDiKeyboard write SetNonBiDiKeyboard;
    {$ENDIF}
    {$IFDEF VERSION6}
    property AutoDragDocking: Boolean read GetAutoDragDocking write SetAutoDragDocking;
    {$IFnDEF FPC}
    property OnSettingChange: TSettingChangeEvent read GetOnSettingChange write SetOnSettingChange;
    {$ENDIF}
    {$ENDIF}
    {$IFDEF VERSION7}
    property OnModalBegin: TNotifyEvent read GetOnModalBegin write SetOnModalBegin;
    property OnModalEnd: TNotifyEvent read GetOnModalEnd write SetOnModalEnd;
    {$ENDIF}
  end;

  TCustomApplicationInspector = class(TCustomComponentInspector)
  private
    FApplicationInterface: TApplicationInterface;
  protected
    function GetButtonType(TheIndex: Integer): TButtonType; override;
    function GetEnableExternalEditor(TheIndex: Integer): Boolean; override;
    function CallEditor(TheIndex: Integer): Boolean; override;
  public
    procedure CreateWnd; override;
  end;

  TApplicationInspector = class(TCustomApplicationInspector)
  published
    {$IFDEF VERSION4}
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
    property CheckBoxes;
    property PaintStyle;
    property Splitter;
    property OnUpdate;
    property OnValidateChar;
    property OnChangeValue;
    property OnDrawName;
    property OnDrawValue;
    property Root;
    property Mode;
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
    property OnGetEditorClass;
    property OnFilter;
    property OnCompare;
    property OnSelectItem;
    property OnDeselectItem;
    property OnValueDoubleClick;
  end;

implementation

function TApplicationInterface.GetHelpFile: string;
begin
  Result:=Application.HelpFile;
end;

procedure TApplicationInterface.SetHelpFile(const Value: string);
begin
  Application.HelpFile:=Value;
end;

function TApplicationInterface.GetHintColor: TColor;
begin
  Result:=Application.HintColor;
end;

procedure TApplicationInterface.SetHintColor(const Value: TColor);
begin
  Application.HintColor:=Value;
end;

function TApplicationInterface.GetHintPause: Integer;
begin
  Result:=Application.HintPause;
end;

procedure TApplicationInterface.SetHintPause(const Value: Integer);
begin
  Application.HintPause:=Value;
end;

function TApplicationInterface.GetHintHidePause: Integer;
begin
  Result:=Application.HintHidePause;
end;

procedure TApplicationInterface.SetHintHidePause(const Value: Integer);
begin
  Application.HintHidePause:=Value;
end;

function TApplicationInterface.GetHintShortPause: Integer;
begin
  Result:=Application.HintShortPause;
end;

procedure TApplicationInterface.SetHintShortPause(const Value: Integer);
begin
  Application.HintShortPause:=Value;
end;

function TApplicationInterface.GetIcon: TIcon;
begin
  Result:=Application.Icon;
end;

procedure TApplicationInterface.SetIcon(const Value: TIcon);
begin
  Application.Icon:=Value;
end;

function TApplicationInterface.GetShowHint: Boolean;
begin
  Result:=Application.ShowHint;
end;

procedure TApplicationInterface.SetShowHint(const Value: Boolean);
begin
  Application.ShowHint:=Value;
end;

function TApplicationInterface.GetTitle: string;
begin
  Result:=Application.Title;
end;

procedure TApplicationInterface.SetTitle(const Value: string);
begin
  Application.Title:=Value;
end;

function TApplicationInterface.GetUpdateFormatSettings: Boolean;
begin
  Result:=Application.UpdateFormatSettings;
end;

procedure TApplicationInterface.SetUpdateFormatSettings(
  const Value: Boolean);
begin
  Application.UpdateFormatSettings:=Value;
end;

function TApplicationInterface.GetUpdateMetricSettings: Boolean;
begin
  {$IFnDEF FPC}
  Result:=Application.UpdateMetricSettings;
  {$ENDIF}
end;

procedure TApplicationInterface.SetUpdateMetricSettings(
  const Value: Boolean);
begin
  {$IFnDEF FPC}
  Application.UpdateMetricSettings:=Value;
  {$ENDIF}
end;

function TApplicationInterface.GetOnActivate: TNotifyEvent;
begin
  Result:=Application.OnActivate;
end;

procedure TApplicationInterface.SetOnActivate(const Value: TNotifyEvent);
begin
  Application.OnActivate:=Value;
end;

function TApplicationInterface.GetOnDeactivate: TNotifyEvent;
begin
  Result:=Application.OnActivate;
end;

procedure TApplicationInterface.SetOnDeactivate(const Value: TNotifyEvent);
begin
  Application.OnActivate:=Value;
end;

function TApplicationInterface.GetOnException: TExceptionEvent;
begin
  Result:=Application.OnException;
end;

procedure TApplicationInterface.SetOnException(
  const Value: TExceptionEvent);
begin
  Application.OnException:=Value;
end;

function TApplicationInterface.GetOnHelp: THelpEvent;
begin
  Result:=Application.OnHelp;
end;

procedure TApplicationInterface.SetOnHelp(const Value: THelpEvent);
begin
  Application.OnHelp:=Value;
end;

function TApplicationInterface.GetOnHint: TNotifyEvent;
begin
  Result:=Application.OnHint;
end;

procedure TApplicationInterface.SetOnHint(const Value: TNotifyEvent);
begin
  Application.OnHint:=Value;
end;

function TApplicationInterface.GetOnIdle: TIdleEvent;
begin
  Result:=Application.OnIdle;
end;

procedure TApplicationInterface.SetOnIdle(const Value: TIdleEvent);
begin
  Application.OnIdle:=Value;
end;

{$IFnDEF FPC}
function TApplicationInterface.GetOnMessage: TMessageEvent;
begin
  Result:=Application.OnMessage;
end;

procedure TApplicationInterface.SetOnMessage(const Value: TMessageEvent);
begin
  Application.OnMessage:=Value;
end;
{$ENDIF}
function TApplicationInterface.GetOnMinimize: TNotifyEvent;
begin
  Result:=Application.OnMinimize;
end;

procedure TApplicationInterface.SetOnMinimize(const Value: TNotifyEvent);
begin
  Application.OnMinimize:=Value;
end;

function TApplicationInterface.GetOnRestore: TNotifyEvent;
begin
  Result:=Application.OnRestore;
end;

procedure TApplicationInterface.SetOnRestore(const Value: TNotifyEvent);
begin
  Application.OnRestore:=Value;
end;

function TApplicationInterface.GetOnShowHint: TShowHintEvent;
begin
  Result:=Application.OnShowHint;
end;

procedure TApplicationInterface.SetOnShowHint(const Value: TShowHintEvent);
begin
  Application.OnShowHint:=Value;
end;

{$IFDEF VERSION4}

function TApplicationInterface.GetBiDiMode: TBiDiMode;
begin
  Result:=Application.BiDiMode;
end;

procedure TApplicationInterface.SetBiDiMode(const Value: TBiDiMode);
begin
  Application.BiDiMode:=Value;
end;

function TApplicationInterface.GetHintShortCuts: Boolean;
begin
  Result:=Application.HintShortCuts;
end;

procedure TApplicationInterface.SetHintShortCuts(const Value: Boolean);
begin
  Application.HintShortCuts:=Value;
end;

function TApplicationInterface.GetOnActionExecute: TActionEvent;
begin
  Result:=Application.OnActionExecute;
end;

procedure TApplicationInterface.SetOnActionExecute(
  const Value: TActionEvent);
begin
  Application.OnActionExecute:=Value;
end;

function TApplicationInterface.GetOnActionUpdate: TActionEvent;
begin
  Result:=Application.OnActionUpdate;
end;

procedure TApplicationInterface.SetOnActionUpdate(const Value: TActionEvent);
begin
  Application.OnActionUpdate:=Value;
end;

function TApplicationInterface.GetOnShortCut: TShortCutEvent;
begin
  Result:=Application.OnShortCut;
end;

procedure TApplicationInterface.SetOnShortCut(const Value: TShortCutEvent);
begin
  Application.OnShortCut:=Value;
end;

{$ENDIF}

{$IFDEF VERSION5}

function TApplicationInterface.GetBiDiKeyboard: string;
begin
  {$IFnDEF FPC}
  Result:=Application.BiDiKeyboard;
  {$ENDIF}
end;

procedure TApplicationInterface.SetBiDiKeyboard(const Value: string);
begin
  {$IFnDEF FPC}
  Application.BiDiKeyboard:=Value;
  {$ENDIF}
end;

function TApplicationInterface.GetNonBiDiKeyboard: string;
begin
  {$IFnDEF FPC}
  Result:=Application.NonBiDiKeyboard;
  {$ENDIF}
end;

procedure TApplicationInterface.SetNonBiDiKeyboard(const Value: string);
begin
  {$IFnDEF FPC}
  Application.NonBiDiKeyboard:=Value;
  {$ENDIF}
end;

{$ENDIF}

{$IFDEF VERSION6}

function TApplicationInterface.GetAutoDragDocking: Boolean;
begin
  {$IFnDEF FPC}
  Result:=Application.AutoDragDocking;
  {$ENDIF}
end;

procedure TApplicationInterface.SetAutoDragDocking(const Value: Boolean);
begin
  {$IFnDEF FPC}
  Application.AutoDragDocking:=Value;
  {$ENDIF}
end;

{$IFnDEF FPC}
function TApplicationInterface.GetOnSettingChange: TSettingChangeEvent;
begin
  Result:=Application.OnSettingChange;
end;

procedure TApplicationInterface.SetOnSettingChange(const Value: TSettingChangeEvent);
begin
  Application.OnSettingChange:=Value;
end;
{$ENDIF}

{$ENDIF}

{$IFDEF VERSION7}

function TApplicationInterface.GetOnModalBegin: TNotifyEvent;
begin
  Result:=Application.OnModalBegin;
end;

procedure TApplicationInterface.SetOnModalBegin(const Value: TNotifyEvent);
begin
  Application.OnModalBegin:=Value;
end;

function TApplicationInterface.GetOnModalEnd: TNotifyEvent;
begin
  Result:=Application.OnModalEnd;
end;

procedure TApplicationInterface.SetOnModalEnd(const Value: TNotifyEvent);
begin
  Application.OnModalEnd:=Value;
end;

{$ENDIF}

function TCustomApplicationInspector.GetButtonType(TheIndex: Integer): TButtonType;
var
  P: TProperty;
begin
  P:=Properties[TheIndex];
  if Assigned(P) and (P.Name='HelpFile') then Result:=btDialog
  else Result:=inherited GetButtonType(TheIndex);
end;

function TCustomApplicationInspector.GetEnableExternalEditor(TheIndex: Integer): Boolean;
var
  P: TProperty;
begin
  P:=Properties[TheIndex];
  Result:=inherited GetEnableExternalEditor(TheIndex) or Assigned(P) and (P.Name='HelpFile');
end;

function TCustomApplicationInspector.CallEditor(TheIndex: Integer): Boolean;
var
  P: TProperty;
begin
  P:=Properties[TheIndex];
  if Assigned(P) and (P.Name='HelpFile') then
    with TOpenDialog.Create(nil) do
    try
      FileName:=Properties[TheIndex].AsString;
      DefaultExt:='hlp';
      Filter:='Help Files (*.hlp)|*.hlp';
      Result:=Execute;
      if Result then Properties[TheIndex].AsString:=FileName;
    finally
      Free;
    end
  else Result:=inherited CallEditor(TheIndex);
end;

procedure TCustomApplicationInspector.CreateWnd;
begin
  inherited;
  FApplicationInterface:=TApplicationInterface.Create(Self);
  Instance:=FApplicationInterface;
end;

end.
