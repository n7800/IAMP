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

unit CompInsp;

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}

interface

{$IFDEF VER100}
  {$DEFINE VERSION3}
{$ENDIF}
{$IFDEF VER110}
  {$DEFINE VERSION3}
{$ENDIF}

uses
{$IFnDEF FPC}
  Windows,
  CommCtrl,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  Messages, Classes, SysUtils, TypInfo, Graphics, Controls, Menus,
  StdCtrls, ComCtrls, InspCtrl, PropList, PropEdit, IniFiles, Forms;

const
  CM_OIUPDATED = WM_USER + 2000;

type
  TCompInspMode = (imProperties,imEvents);

  TCompInspList = class;

  TCustomComponentInspector = class;
  TComponentInspector = class;

  TNotifyComponentEvent = procedure(Sender: TObject; TheComponent: TComponent) of object;
  TIndexComponentEvent = procedure(Sender: TObject; TheComponent: TComponent; var Index: Integer) of object;
  TSetStringEnableEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: string; var EnableDefault: Boolean) of object;
  TEditorClassEvent = procedure(Sender: TObject; TheIndex: Integer; var Value: TPropertyEditorClass) of object;
  TPropFilterEvent = procedure(Sender: TObject; Prop: TProperty; var Result: Boolean) of object;
  TPropCompareEvent = procedure(Sender: TObject; Prop1,Prop2: TProperty; var Result: Integer) of object;
  TFillEventListEvent = procedure(Sender: TObject; EventType: PTypeInfo; Strings: TStrings) of object;
  TCustomizeInspectorEvent = procedure(Sender: TObject; Inspector: TComponentInspector) of object;
  TFilterComponentEvent = procedure(Sender: TObject; AComponent: TComponent; var EnableAdd: Boolean) of object;
  TGetComponentTextEvent = procedure(Sender: TObject; AComponent: TComponent; var Text: string) of object;

  TCustomComponentTree = class(TCustomTreeView)
  private
    
    FFilled: Boolean;
    FIgnoreUpdate: Boolean;
    FRoot: TComponent;
    FInstance: TComponent;
    FComponentInspector: TCustomComponentInspector;
    FShowNonVisual: Boolean;
    FOnSelect: TNotifyComponentEvent;
    FOnFilter: TFilterComponentEvent;
    FOnGetText: TGetComponentTextEvent;
    FOnEditText: TGetComponentTextEvent;
    FOnComponentImage: TIndexComponentEvent;
    procedure SetRoot(const Value: TComponent);
    procedure SetInstance(const Value: TComponent);
    procedure SetComponentInspector(const Value: TCustomComponentInspector);
    procedure SetShowNonVisual(const Value: Boolean);
  protected
    
    procedure Loaded; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Change(Node: TTreeNode); override;
    {$IFNDEF FPC} procedure Edit(const Item: TTVItem); override; {$ENDIF}
    function Filter(AComponent: TComponent): Boolean; virtual;
    function GetText(AComponent: TComponent): string; virtual;
    procedure EditText(AComponent: TComponent; var AText: string); virtual;
    procedure SelectInstance(AComponent: TComponent); virtual;
    function GetComponentImage(AComponent: TComponent): Integer; virtual;
    procedure CMOIUpdated(var Message: TMessage); message CM_OIUPDATED;
    property Root: TComponent read FRoot write SetRoot;
    property Instance: TComponent read FInstance write SetInstance;
    property ComponentInspector: TCustomComponentInspector read FComponentInspector write SetComponentInspector;
    property ShowNonVisual: Boolean read FShowNonVisual write SetShowNonVisual default False;
    property OnSelect: TNotifyComponentEvent read FOnSelect write FOnSelect;
    property OnFilter: TFilterComponentEvent read FOnFilter write FOnFilter;
    property OnGetText: TGetComponentTextEvent read FOnGetText write FOnGetText;
    property OnEditText: TGetComponentTextEvent read FOnEditText write FOnEditText;
    property OnComponentImage: TIndexComponentEvent read FOnComponentImage write FOnComponentImage;
  public
    
    function GetComponentNode(AComponent: TComponent): TTreeNode;
    procedure AddComponent(AComponent: TComponent);
    procedure DeleteComponent(AComponent: TComponent);
    procedure RefreshTree;
  end;

  TComponentTree = class(TCustomComponentTree)
  published
    
    {$IFNDEF VERSION3}
    property Anchors;
    property BiDiMode;
    property BorderWidth;
    property Constraints;
    property AutoExpand;
    {$IFNDEF FPC} property ChangeDelay;  {$ENDIF}
    property HotTrack;
    property RightClickSelect;
    property RowSelect;
    property ToolTips;
    property OnCustomDraw;
    property OnCustomDrawItem;
    property OnEndDock;
    property OnStartDock;
    {$ENDIF}
    property Align;
    property BorderStyle;
    {$IFNDEF FPC} property Ctl3D;  {$ENDIF}
    property Color;
    property HelpContext;
    {$IFNDEF FPC} property ParentCtl3D; {$ENDIF}
    property TabOrder;
    property TabStop;
    property DragMode;
    property HideSelection;
    property Images;
    property Indent;
    property Items;
    property ReadOnly;
    property ShowButtons;
    property ShowLines;
    property ShowRoot;
    property SortType;
    property StateImages;
    property Root;
    property Instance;
    property ComponentInspector;
    property ShowNonVisual;
    property OnSelect;
    property OnFilter;
    property OnGetText;
    property OnEditText;
    property OnComponentImage;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnClick;
    property OnDblClick;
    property OnDragDrop;
    property OnDragOver;
    property OnEndDrag;
    property OnMouseDown;
    property OnMouseMove;
    property OnMouseUp;
    property OnStartDrag;
  end;

  TCustomComponentComboBox = class(TCustomComboBox)
  private
    FRoot: TComponent;
    FComponentInspector: TCustomComponentInspector;
    FOnFilter: TFilterComponentEvent;
    FOnGetComponentText: TGetComponentTextEvent;
    procedure SetRoot(const Value: TComponent);
    function GetInstance: TComponent;
    procedure SetInstance(const Value: TComponent);
    procedure SetComponentInspector(const Value: TCustomComponentInspector);
  protected
    procedure CreateWnd; override;
    procedure Change; override;
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function TranslateComponent(AComponent: TComponent): TComponent; virtual;
    function Filter(AComponent: TComponent): Boolean; virtual;
    function GetComponentText(AComponent: TComponent): string; virtual;
    procedure CMOIUpdated(var Message: TMessage); message CM_OIUPDATED;
  public
    constructor Create(AOwner: TComponent); override;
    procedure RefreshList;
    property Root: TComponent read FRoot write SetRoot;
    property Instance: TComponent read GetInstance write SetInstance;
    property ComponentInspector: TCustomComponentInspector read FComponentInspector write SetComponentInspector;
    property OnFilter: TFilterComponentEvent read FOnFilter write FOnFilter;
    property OnGetComponentText: TGetComponentTextEvent read FOnGetComponentText write FOnGetComponentText;
  end;

  TComponentComboBox = class(TCustomComponentComboBox)
  published
    {$IFNDEF VERSION3}
    property Anchors;
    property Constraints;
    {$ENDIF}
    property Root;
    property Instance;
    property ComponentInspector;
    property OnFilter;
    property OnGetComponentText;
    property Color;
    {$IFNDEF FPC} property Ctl3D; {$ENDIF}
    property DragMode;
    property DragCursor;
    property DropDownCount;
    property Enabled;
    property Font;
    {$IFNDEF FPC} property ImeMode; {$ENDIF}
    {$IFNDEF FPC} property ImeName; {$ENDIF}
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
    property OnChange;
    property OnDragDrop;
    property OnDragOver;
    property OnDrawItem;
    property OnDropDown;
    property OnEndDrag;
    property OnEnter;
    property OnExit;
    property OnKeyDown;
    property OnKeyPress;
    property OnKeyUp;
    property OnMeasureItem;
    property OnStartDrag;
  end;

  TCompInspProperty = class(TProperty)
  private
    FCompInspList: TCompInspList;
  public
    constructor CreateWithOwner(AOwner: TPropertyList; ARoot: TComponent; AInstance: TPersistent; APropInfo: PPropInfo; APropData: TCustomPropData; ACompInspList: TCompInspList);
    function CreatePropertyList: TPropertyList; override;
  end;

  TCompInspPropertyList = class(TPropertyList)
  private
    FCompInspList: TCompInspList;
    FMode: TCompInspMode;
    procedure SetMode(const Value: TCompInspMode);
  public
    constructor CreateWithOwner(AOwner: TProperty; ACompInspList: TCompInspList);
    function CreateProperty(APropInfo: PPropInfo; APropData: TCustomPropData): TProperty; override;
    function Compare(P1,P2: TProperty): Integer; override;
    function Filter(P: TProperty): Boolean; override;
    property CompInspList: TCompInspList read FCompInspList;
    property Mode: TCompInspMode read FMode write SetMode;
  end;

  TCompInspList = class
  private
    FOwner: TCustomComponentInspector;
    FRoot: TComponent;
    FMode: TCompInspMode;
    FPropertyLists: TList;
    FProperties: TList;
    FExpanded: TStrings;
    procedure SetRoot(const Value: TComponent);
    function GetInstance: TComponent;
    procedure SetInstance(const Value: TComponent);
    function GetInstanceCount: Integer;
    function GetArrayInstance(Index: Integer): TComponent;
    procedure SetMode(const Value: TCompInspMode);
    function GetPropertyCount: Integer;
    function GetProperty(Index: Integer): TProperty;
    function GetPropertyListCount: Integer;
    function GetPropertyList(Index: Integer): TCompInspPropertyList;
    procedure Clear;
  public
    constructor CreateWithOwner(AOwner: TCustomComponentInspector);
    destructor Destroy; override;
    procedure Update; virtual;
    procedure AddInstance(AInstance: TComponent); virtual;
    procedure DeleteInstance(AInstance: TComponent); virtual;
    function IndexOfInstance(AInstance: TComponent): Integer;
    function ValidPropIndex(Index: Integer): Boolean;
    function ValidListIndex(Index: Integer): Boolean;
    property Owner: TCustomComponentInspector read FOwner;
    property Root: TComponent read FRoot write SetRoot;
    property Instance: TComponent read GetInstance write SetInstance;
    property Mode: TCompInspMode read FMode write SetMode;
    property InstanceCount: Integer read GetInstanceCount;
    property Instances[Index: Integer]: TComponent read GetArrayInstance;
    property PropertyCount: Integer read GetPropertyCount;
    property Properties[Index: Integer]: TProperty read GetProperty;
    property PropertyListCount: Integer read GetPropertyListCount;
    property PropertyLists[Index: Integer]: TCompInspPropertyList read GetPropertyList;
  end;

  TCustomComponentInspector = class(TCustomInspector)
  private
    FDictionary: TStrings;
    FPropertyList: TCompInspList;
    FNotificationControls: TList;
    FSelectedProperty: string;
    FMultiSelect: Boolean;
    FDictionaryFile: string;
    FOnSetValue: TSetStringEnableEvent;
    FOnCallEditor: TCallEditorEnableEvent;
    FOnBeforeExpand: TIndexEnableEvent;
    FOnAfterExpand: TIndexNotifyEvent;
    FOnBeforeCollapse: TIndexEnableEvent;
    FOnAfterCollapse: TIndexNotifyEvent;
    FOnGetEditorClass: TEditorClassEvent;
    FOnFilter: TPropFilterEvent;
    FOnCompare: TPropCompareEvent;
    FOnFillEventList: TFillEventListEvent;
    FOnChange: TIndexNotifyEvent;
    FOnCustomizeInspector: TCustomizeInspectorEvent;
    FOnGetPropSubsLongint: TGetPropSubsLongint;
    FOnSetPropSubsLongint: TSetPropSubsLongint;
    procedure SetMultiSelectProperty(const Value: Boolean);
    procedure SetDictionary(const Value: TStrings);
    procedure SetDictionaryFile(const Value: string);
    procedure SetRoot(const Value: TComponent);
    function GetRoot: TComponent;
    procedure SetInstance(const Value: TPersistent);
    function GetInstance: TPersistent;
    function GetInstanceCount: Integer;
    function GetArrayInstance(Index: Integer): TPersistent;
    function GetMode: TCompInspMode;
    function GetPropertyCount: Integer;
    function GetProperty(TheIndex: Integer): TProperty;
    procedure SetMode(const Value: TCompInspMode);
    procedure UpdateList;
    procedure UpdateDictionary;
  protected
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    function GetDefaultIndex: Integer; override;
    function GetPopupItemWidth(ListBox: TListBox; TheIndex: Integer): Integer; override;
    procedure DrawPopupItem(ListBox: TListBox; ListItemIndex: Integer; R: TRect; TheIndex: Integer); override;
    procedure DrawPropertyValue(TheCanvas: TCanvas; TheIndex: Integer; R: TRect); override;
    function GetName(TheIndex: Integer): string; override;
    function GetValue(TheIndex: Integer): string; override;
    function GetNextValue(TheIndex: Integer): string; override;
    procedure SetValue(TheIndex: Integer; const Value: string); override;
    procedure DragValue(TheIndex,Offset: Integer); override;
    function GetButtonType(TheIndex: Integer): TButtonType; override;
    function GetInplaceEditorType(TheIndex: Integer): TInplaceEditorType; override;
    function GetEnableExternalEditor(TheIndex: Integer): Boolean; override;
    function GetReadOnly(TheIndex: Integer): Boolean; override;
    function GetExpandState(TheIndex: Integer): TExpandState; override;
    function GetLevel(TheIndex: Integer): Integer; override;
    procedure GetValuesList(TheIndex: Integer; const Strings: TStrings); override;
    function GetSortValuesList(TheIndex: Integer): Boolean; override;
    function GetSelectedValue(TheIndex: Integer): string; override;
    function GetAutoApply(TheIndex: Integer): Boolean; override;
    function CallEditor(TheIndex: Integer): Boolean; override;
    procedure Expand(TheIndex: Integer); override;
    procedure Collapse(TheIndex: Integer); override;
    procedure SelectItem(TheIndex: Integer); override;
    function GetEditorClass(TheIndex: Integer): TPropertyEditorClass; virtual;
    procedure Compare(Prop1,Prop2: TProperty; var Result: Integer); virtual;
    procedure Filter(Prop: TProperty; var Result: Boolean); virtual;
    procedure Change(TheIndex: Integer); virtual;
    property MultiSelect: Boolean read FMultiSelect write SetMultiSelectProperty default True;
    property DictionaryFile: string read FDictionaryFile write SetDictionaryFile;
    property Dictionary: TStrings read FDictionary write SetDictionary;
    property Root: TComponent read GetRoot write SetRoot;
    property Instance: TPersistent read GetInstance write SetInstance;
    property Mode: TCompInspMode read GetMode write SetMode default imProperties;
    property OnSetValue: TSetStringEnableEvent read FOnSetValue write FOnSetValue;
    property OnCallEditor: TCallEditorEnableEvent read FOnCallEditor write FOnCallEditor;
    property OnBeforeExpand: TIndexEnableEvent read FOnBeforeExpand write FOnBeforeExpand;
    property OnAfterExpand: TIndexNotifyEvent read FOnAfterExpand write FOnAfterExpand;
    property OnBeforeCollapse: TIndexEnableEvent read FOnBeforeCollapse write FOnBeforeCollapse;
    property OnAfterCollapse: TIndexNotifyEvent read FOnAfterCollapse write FOnAfterCollapse;
    property OnGetEditorClass: TEditorClassEvent read FOnGetEditorClass write FOnGetEditorClass;
    property OnFilter: TPropFilterEvent read FOnFilter write FOnFilter;
    property OnCompare: TPropCompareEvent read FOnCompare write FOnCompare;
    property OnFillEventList: TFillEventListEvent read FOnFillEventList write FOnFillEventList;
    property OnChange: TIndexNotifyEvent read FOnChange write FOnChange;
    property OnCustomizeInspector: TCustomizeInspectorEvent read FOnCustomizeInspector write FOnCustomizeInspector;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Update; override;
    procedure CreateWnd; override;
    procedure RefreshList;
    procedure ClearExpanded;
    procedure AddInstance(AInstance: TPersistent); virtual;
    procedure DeleteInstance(AInstance: TPersistent); virtual;
    function IndexOfInstance(AInstance: TPersistent): Integer;
    procedure AddNotification(TheControl: TControl);
    procedure DeleteNotification(TheControl: TControl);
    procedure FillEventList(EventType: PTypeInfo; Strings: TStrings); virtual;
    procedure CustomizeInspector(Inspector: TComponentInspector); virtual;
    procedure FullExpand;
    function IndexOfPropertyName(AFullName: string): Integer;
    procedure SelectProperty(AFullName: string);
    function IndexOfProperty(P: TProperty): Integer;
    function Translate(const Value: string; Direction: Boolean): string; virtual;
    property PropertyCount: Integer read GetPropertyCount;
    property Properties[Index: Integer]: TProperty read GetProperty;
    property InstanceCount: Integer read GetInstanceCount;
    property Instances[Index: Integer]: TPersistent read GetArrayInstance;
    property OnGetPropSubsLongint: TGetPropSubsLongint read FOnGetPropSubsLongint write FOnGetPropSubsLongint;
    property OnSetPropSubsLongint: TSetPropSubsLongint read FOnSetPropSubsLongint write FOnSetPropSubsLongint;
  end;

  TComponentInspector = class(TCustomComponentInspector)
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
    {$IFNDEF FPC} property ImeMode; {$ENDIF}
    {$IFNDEF FPC} property ImeName; {$ENDIF}
    property IntegralHeight;
    property ParentColor;
    {$IFNDEF FPC} property ParentCtl3D; {$ENDIF}
    property ParentFont;
    property ParentShowHint;
    property PopupMenu;
    property ShowHint;
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
    property OnSelect;
    property OnUpdate;
    property OnValidateChar;
    property OnChangeValue;
    property OnDrawName;
    property OnDrawValue;
    property OnDrawPopupItem;
    
    property MultiSelect;
    property DictionaryFile;
    property Dictionary;
    property Root;
    property Instance;
    property Mode;
    property OnGetName;
    property OnGetValue;
    property OnGetNextValue;
    property OnSetValue;
    property OnGetButtonType;
    property OnGetInplaceEditorType;
    {$IFDEF GOICUSTOMEDIT}
    property OnGetInplaceEditor;
    {$ENDIF}
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
    property OnBeforeExpand;
    property OnAfterExpand;
    property OnBeforeCollapse;
    property OnAfterCollapse;
    property OnGetEditorClass;
    property OnFilter;
    property OnCompare;
    property OnSelectItem;
    property OnDeselectItem;
    property OnValueDoubleClick;
    property OnFillEventList;
    property OnChange;
    property OnCustomizeInspector;
    property OnGetPasswordChar;
  end;

implementation

uses StrsEdit, PicsEdit, MenuEdit, CollEdit, TreeInsp, ListView;

procedure TCustomComponentTree.SetRoot(const Value: TComponent);
begin
  if FRoot<>Value then
  begin
    FRoot:=Value;
    if not (csDesigning in ComponentState) then RefreshTree;
    if Assigned (FRoot) then FreeNotification(FRoot);
  end;
end;

procedure TCustomComponentTree.SetInstance(const Value: TComponent);
begin
  if FInstance<>Value then
  begin
    FInstance:=Value;
    if not (csDesigning in ComponentState) then Selected:=GetComponentNode(Value);
    if Assigned (FInstance) then FreeNotification(FInstance);
  end;
end;

procedure TCustomComponentTree.SetComponentInspector(const Value: TCustomComponentInspector);
begin
  if Value<>FComponentInspector then
  begin
    if Assigned(FComponentInspector) then FComponentInspector.DeleteNotification(Self);
    FComponentInspector:=Value;
    if Assigned(FComponentInspector) then
    begin
      FComponentInspector.AddNotification(Self);
      FreeNotification(FComponentInspector);
    end;
  end;
end;

procedure TCustomComponentTree.SetShowNonVisual(const Value: Boolean);
begin
  if FShowNonVisual<>Value then
  begin
    FShowNonVisual:=Value;
    if not (csDesigning in ComponentState) then RefreshTree;
  end;
end;

procedure TCustomComponentTree.Loaded;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    RefreshTree;
    Selected:=GetComponentNode(FInstance);
    FFilled:=True;
  end;
end;

procedure TCustomComponentTree.Notification(AComponent: TComponent; Operation: TOperation);
var
  Node: TTreeNode;
begin
  inherited;
  if not (csDestroying in ComponentState) then
  begin
    if (Operation=opRemove) and (AComponent=FComponentInspector) and Assigned(FComponentInspector) then
    begin
      FComponentInspector.DeleteNotification(Self);
      FComponentInspector:=nil;
    end;
    if not (csDesigning in ComponentState) and (Operation=opRemove) and (ComponentState=[]) and FFilled then
    begin
      Node:=GetComponentNode(AComponent);
      if Assigned(Node) then Node.Free;
    end;
  end;
end;

procedure TCustomComponentTree.Change(Node: TTreeNode);
begin
  inherited;
  if Assigned(Selected) then SelectInstance(Selected.Data)
  else SelectInstance(nil);
end;

{$IFNDEF FPC}
procedure TCustomComponentTree.Edit(const Item: TTVItem);

var
  S: string;
  Node: TTreeNode;

  function GetNodeFromItem(const Item: TTVItem): TTreeNode;
  begin
    with Item do
      if (state and TVIF_PARAM)<>0 then Result:=Pointer(lParam)
      else Result:=Items.GetNode(hItem);
  end;

begin
  with Item do
    if Assigned(pszText) then
    begin
      S:=pszText;
      Node:=GetNodeFromItem(Item);
      EditText(Node.Data,S);
      if Node<>nil then Node.Text:=S;
    end;
end;
{$ENDIF}

function TCustomComponentTree.Filter(AComponent: TComponent): Boolean;
begin
  Result:=(AComponent<>Self) and (FShowNonVisual or (AComponent is TControl));
  if Assigned(FOnFilter) then FOnFilter(Self,AComponent,Result);
end;

function TCustomComponentTree.GetText(AComponent: TComponent): string;
begin
  Result:=AComponent.Name;
  if Assigned(FOnGetText) then FOnGetText(Self,AComponent,Result);
end;

procedure TCustomComponentTree.EditText(AComponent: TComponent; var AText: string);
begin
  if Assigned(FOnEditText) then FOnEditText(Self,AComponent,AText);
end;

procedure TCustomComponentTree.SelectInstance(AComponent: TComponent);
begin
  FInstance:=AComponent;
  if Assigned(FOnSelect) then FOnSelect(Self,FInstance);
  if Assigned(FComponentInspector) then
  begin
    FIgnoreUpdate:=True;
    if Assigned(FInstance) and (FInstance<>FComponentInspector.Instance) then
      FComponentInspector.Instance:=FInstance;
  end;
end;

procedure TCustomComponentTree.CMOIUpdated(var Message: TMessage);
begin
  if not FIgnoreUpdate then
  begin
    if Assigned(FComponentInspector) then
      with FComponentInspector do
        if InstanceCount=1 then Self.Instance:=TComponent(Instance)
        else Self.Instance:=nil;
    Update;
  end;
  FIgnoreUpdate:=False;
end;

function TCustomComponentTree.GetComponentImage(AComponent: TComponent): Integer;
begin
  Result:=-1;
  if Assigned(FOnComponentImage) then FOnComponentImage(Self,AComponent,Result);
end;

function TCustomComponentTree.GetComponentNode(AComponent: TComponent): TTreeNode;

  procedure FindComponent;
  begin
     Result:=Items.GetFirstNode;
     while Assigned(Result) do
     begin
        if Result.Data=AComponent then Break;
        Result:=Result.GetNext;
     end;
  end;

begin
  Result:=nil;
  if Items.Count>0 then FindComponent;
end;

procedure TCustomComponentTree.AddComponent(AComponent: TComponent);
var
  Node: TTreeNode;
begin
  if not Assigned(GetComponentNode(AComponent)) and Filter(AComponent) then
  begin
    if AComponent is TControl then Node:=GetComponentNode(TControl(AComponent).Parent)
    else Node:=GetComponentNode(AComponent.Owner);
    Items.AddChildObject(Node,GetText(AComponent),AComponent).ImageIndex:=GetComponentImage(AComponent);
  end;
end;

procedure TCustomComponentTree.DeleteComponent(AComponent: TComponent);
var
  Node: TTreeNode;
begin
  if not Assigned(GetComponentNode(AComponent)) and Filter(AComponent) then
  begin
    if AComponent is TControl then Node:=GetComponentNode(TControl(AComponent).Parent)
    else Node:=GetComponentNode(AComponent.Owner);
    Items.AddChildObject(Node,AComponent.Name,AComponent);
  end;
end;

procedure TCustomComponentTree.RefreshTree;
var
  i: Integer;
begin
  Items.Clear;
  if Assigned(Root) then
  begin
    Items.AddObject(nil,Root.Name,Root);
    with Root do
      for i:=0 to Pred(ComponentCount) do AddComponent(Components[i]);
  end;
end;

procedure TCustomComponentComboBox.SetRoot(const Value: TComponent);
begin
  FRoot:=Value;
  RefreshList;
  Update;
  if Assigned (FRoot) then FreeNotification(FRoot);
end;

function TCustomComponentComboBox.GetInstance: TComponent;
begin
  if Assigned(Parent) then
    with Items do
      if (ItemIndex>=0) and (ItemIndex<Count) then
        Result:=TComponent(Items.Objects[ItemIndex])
      else Result:=nil
  else Result:=nil;
end;

procedure TCustomComponentComboBox.SetInstance(const Value: TComponent);
begin
  if Assigned(Parent) then
    ItemIndex:=Items.IndexOfObject(Value);
  if Assigned (Value) then FreeNotification(Value);
end;

procedure TCustomComponentComboBox.SetComponentInspector(const Value: TCustomComponentInspector);
begin
  if Value<>FComponentInspector then
  begin
    if Assigned(FComponentInspector) then FComponentInspector.DeleteNotification(Self);
    FComponentInspector:=Value;
    if Assigned(FComponentInspector) then
    begin
      FComponentInspector.AddNotification(Self);
      FreeNotification(FComponentInspector);
    end;
  end;
end;

procedure TCustomComponentComboBox.CreateWnd;
begin
  inherited;
  RefreshList;
end;

procedure TCustomComponentComboBox.Change;
begin
  inherited;
  if Assigned(FComponentInspector) and (Instance<>FComponentInspector.Instance) then
    FComponentInspector.Instance:=Instance;
end;

procedure TCustomComponentComboBox.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation=opRemove) and (AComponent=FComponentInspector) and Assigned(FComponentInspector) then
  begin
    FComponentInspector.DeleteNotification(Self);
    FComponentInspector:=nil;
  end;
  inherited;
end;

function TCustomComponentComboBox.TranslateComponent(AComponent: TComponent): TComponent;
begin
  Result:=AComponent;
end;

function TCustomComponentComboBox.Filter(AComponent: TComponent): Boolean;
begin
  Result:=True;
  if Assigned(FOnFilter) then FOnFilter(Self,AComponent,Result);
end;

function TCustomComponentComboBox.GetComponentText(AComponent: TComponent): string;
var
  N: string;
begin
  if Assigned(AComponent) then
    with AComponent do
    begin
      N:=Name;
      if N='' then N:='(noname)';
      Result:=Format('%s: %s',[N,ClassName]);
    end
  else Result:='';
  if Assigned(FOnGetComponentText) then FOnGetComponentText(Self,AComponent,Result);
end;

procedure TCustomComponentComboBox.CMOIUpdated(var Message: TMessage);
begin
  {$IFNDEF GOINOCOMBOAUTOREFRESH}
  RefreshList;
  {$ENDIF}
  if Assigned(FComponentInspector) then
    with FComponentInspector do
      if InstanceCount=1 then Self.Instance := TComponent(Instance)
      else Self.Instance:=nil;
  Invalidate;
end;

constructor TCustomComponentComboBox.Create(AOwner: TComponent);
begin
  inherited;

  Style:=csDropDownList;

end;

procedure TCustomComponentComboBox.RefreshList;
var
  i: Integer;
  Component: TComponent;
begin
  with Items do
  begin
    Clear;
    BeginUpdate;
    if Assigned(FRoot) then
      with FRoot do
      begin
        Component:=TranslateComponent(FRoot);
        if Self.Filter(Component) then
          AddObject(GetComponentText(Component),Component);
        for i:=0 to Pred(ComponentCount) do
          if Self.Filter(Components[i]) then
            with Components[i] do
            begin
              Component:=TranslateComponent(FRoot.Components[i]);
              AddObject(GetComponentText(Component),Component);
            end;
      end;
    EndUpdate;
  end;
end;

constructor TCompInspProperty.CreateWithOwner(AOwner: TPropertyList; ARoot: TComponent; AInstance: TPersistent; APropInfo: PPropInfo; APropData: TCustomPropData; ACompInspList: TCompInspList);
begin
  FCompInspList:=ACompInspList;
  inherited Create(AOwner,ARoot,AInstance,APropInfo,APropData);
end;

function TCompInspProperty.CreatePropertyList: TPropertyList;
begin
  Result:=TCompInspPropertyList.CreateWithOwner(Self,FCompInspList);
end;

procedure TCompInspPropertyList.SetMode(const Value: TCompInspMode);
begin
  if FMode<>Value then
  begin
    FMode:=Value;
    Update;
  end;
end;

constructor TCompInspPropertyList.CreateWithOwner(AOwner: TProperty; ACompInspList: TCompInspList);
begin
  inherited Create(AOwner);
  FCompInspList:=ACompInspList;
  Mode:=FCompInspList.Mode;
  Root:=FCompInspList.Root;
end;

function TCompInspPropertyList.CreateProperty(APropInfo: PPropInfo; APropData: TCustomPropData): TProperty;
begin
  Result:=TCompInspProperty.CreateWithOwner(Self,Root,Instance,APropInfo,APropData,FCompInspList);
end;

function TCompInspPropertyList.Compare(P1,P2: TProperty): Integer;
begin
  Result:=inherited Compare(P1,P2);
  if Assigned(CompInspList) and Assigned(CompInspList.Owner) then
    CompInspList.Owner.Compare(P1,P2,Result);
end;

function TCompInspPropertyList.Filter(P: TProperty): Boolean;
begin
  Result:=((P.TypeKind=tkMethod) xor (FMode=imProperties)) and ((P.TypeKind=tkClass) or (P.Custom or Assigned(P.SetProc) and Assigned(P.GetProc)));
  if Assigned(CompInspList) and Assigned(CompInspList.Owner) then
    CompInspList.Owner.Filter(P,Result);
end;

procedure TCompInspList.SetRoot(const Value: TComponent);
begin
  if FRoot<>Value then
  begin
    FRoot:=Value;
    Update;
  end;
end;

function TCompInspList.GetInstance: TComponent;
begin
  if ValidListIndex(0) then Result:=TComponent(PropertyLists[0].Instance)
  else Result:=nil;
end;

procedure TCompInspList.SetInstance(const Value: TComponent);
var
  i: Integer;
  PL: TCompInspPropertyList;
begin
  if (Owner as TCustomComponentInspector).FMultiSelect then
  begin
    AddInstance(Value);
    i:=0;
    while i<InstanceCount do
      if Instances[i]<>Value then DeleteInstance(Instances[i])
      else Inc(i);
  end
  else
  begin
    while InstanceCount>0 do DeleteInstance(Instances[0]);
    PL:=TCompInspPropertyList.CreateWithOwner(nil,Self);
    PL.Instance:=Value;
    FPropertyLists.Add(PL);
    Update;
  end;
end;

function TCompInspList.GetInstanceCount: Integer;
begin
  Result:=FPropertyLists.Count;
end;

function TCompInspList.GetArrayInstance(Index: Integer): TComponent;
begin
  if ValidListIndex(Index) then Result:=TComponent(TCompInspPropertyList(FPropertyLists[Index]).Instance)
  else Result:=nil;
end;

procedure TCompInspList.SetMode(const Value: TCompInspMode);
var
  i: Integer;
begin
  FMode:=Value;
  for i:=0 to Pred(PropertyListCount) do
    PropertyLists[i].Mode:=FMode;
  Update;
end;

function TCompInspList.GetPropertyCount: Integer;
begin
  Result:=FProperties.Count;
end;

function TCompInspList.GetProperty(Index: Integer): TProperty;
begin
  if ValidPropIndex(Index) then Result:=TProperty(FProperties[Index])
  else Result:=nil;
end;

function TCompInspList.GetPropertyListCount: Integer;
begin
  Result:=FPropertyLists.Count;
end;

function TCompInspList.GetPropertyList(Index: Integer): TCompInspPropertyList;
begin
  if ValidListIndex(Index) then Result:=TCompInspPropertyList(FPropertyLists[Index])
  else Result:=nil;
end;

procedure TCompInspList.Clear;
var
  i: Integer;
begin
  with FPropertyLists do
  begin
    for i:=0 to Pred(Count) do TPropertyList(FPropertyLists[i]).Free;
    Clear;
  end;
  FProperties.Clear;
end;

constructor TCompInspList.CreateWithOwner(AOwner: TCustomComponentInspector);
begin
  inherited;
  FOwner:=AOwner;
  FPropertyLists:=TList.Create;
  FProperties:=TList.Create;
  FExpanded:=TStringList.Create;
end;

destructor TCompInspList.Destroy;
begin
  Clear;
  FPropertyLists.Free;
  FProperties.Free;
  FExpanded.Free;
  inherited;
end;

procedure TCompInspList.Update;

var
  i,j: Integer;
  Found: Boolean;
  P: TProperty;
  ClassList: TList;

  procedure ExpandProperty(Index: Integer; P: TProperty);
  var
    i: Integer;
  begin
    if FExpanded.IndexOf(P.FullName)<>-1 then
      with P.Properties do
        for i:=Pred(Count) downto 0 do
        begin
          if FExpanded.IndexOf(Properties[i].FullName)<>-1 then ExpandProperty(Index,Properties[i]);
          if Filter(Properties[i]) then FProperties.Insert(Succ(Index),Properties[i]);
        end;
  end;

begin
  ClassList:=TList.Create;
  try
    FProperties.Clear;
    if ValidListIndex(0) then
      with PropertyLists[0] do
        for i:=0 to Pred(Count) do
        begin
          if Filter(Properties[i]) then FProperties.Add(Properties[i]);
          ExpandProperty(Pred(FProperties.Count),Properties[i]);
        end;
    if PropertyListCount>1 then
    begin
      i:=0;
      while i<PropertyCount do
      begin
        Found:=AnsiUpperCase(Properties[i].FullName)<>'NAME';
        if Found then
        begin
          ClassList.Clear;
          for j:=0 to Pred(PropertyListCount) do
            if Properties[i].Custom then Found:=RegisteredProperty(PropertyLists[j].Instance.ClassType,Properties[i].Name)
            else
            begin
              if ClassList.IndexOf(PropertyLists[j].Instance.ClassType)=-1 then
              begin
                ClassList.Add(PropertyLists[j].Instance.ClassType);
                P:=PropertyLists[j].FindProperty(Properties[i].FullName);
                if not Properties[i].IsCompatible(P) then
                begin
                  Found:=False;
                  Break;
                end;
              end;
            end;
        end;
        if not Found then FProperties.Delete(i)
        else Inc(i);
      end;
    end;
    FOwner.ItemCount:=FProperties.Count;
  finally
    ClassList.Free;
  end;
end;

procedure TCompInspList.AddInstance(AInstance: TComponent);
var
  Index: Integer;
  PL: TCompInspPropertyList;
begin
  if not (Owner as TCustomComponentInspector).FMultiSelect then Instance:=AInstance
  else
    if Assigned(AInstance) then
    begin
      Index:=IndexOfInstance(AInstance);
      with FPropertyLists do
        if Index=-1 then
        begin
          PL:=TCompInspPropertyList.CreateWithOwner(nil, Self);
          PL.OnGetPropSubsLongint := FOwner.FOnGetPropSubsLongint;
          PL.OnSetPropSubsLongint := FOwner.FOnSetPropSubsLongint;
          PL.Instance:=AInstance;
          Add(PL);
        end;
      Update;             
    end;
end;

procedure TCompInspList.DeleteInstance(AInstance: TComponent);
var
  Index: Integer;
begin
  Index:=IndexOfInstance(AInstance);
  if Index<>-1 then
    with FPropertyLists do
    begin
      TPropertyList(FPropertyLists[Index]).Free;
      Delete(Index);
      Update;
    end;
  Update;
end;

function TCompInspList.IndexOfInstance(AInstance: TComponent): Integer;
var
  i: Integer;
begin
  Result:=-1;
  with FPropertyLists do
    for i:=0 to Pred(Count) do
      if TPropertyList(FPropertyLists[i]).Instance=AInstance then Result:=i;
end;

function TCompInspList.ValidListIndex(Index: Integer): Boolean;
begin
  with FPropertyLists do
    Result:=(Index>=0) and (Index<Count);
end;

function TCompInspList.ValidPropIndex(Index: Integer): Boolean;
begin
  with FProperties do
    Result:=(Index>=0) and (Index<Count);
end;

procedure TCustomComponentInspector.SetMultiSelectProperty(const Value: Boolean);
begin
  FMultiSelect:=Value;
  
end;

procedure TCustomComponentInspector.SetDictionary(const Value: TStrings);
begin
  FDictionary.Assign(Value);
end;

procedure TCustomComponentInspector.SetDictionaryFile(const Value: string);
begin
  if FDictionaryFile<>Value then
  begin
    FDictionaryFile:=Value;
    UpdateDictionary;
    Invalidate;
  end;
end;

procedure TCustomComponentInspector.SetRoot(const Value: TComponent);
begin
  FPropertyList.Root:=Value;
  if not Locked then UpdateList;
end;

function TCustomComponentInspector.GetRoot: TComponent;
begin
  Result:=FPropertyList.Root;
end;

function TCustomComponentInspector.IndexOfPropertyName(AFullName: string): Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=0 to Pred(ItemCount) do
    if AnsiUpperCase(Properties[i].FullName)=AnsiUpperCase(AFullName) then
    begin
      Result:=i;
      Break;
    end;
end;

procedure TCustomComponentInspector.SelectProperty(AFullName: string);
begin
  ItemIndex:=IndexOfPropertyName(AFullName);
end;

function TCustomComponentInspector.IndexOfProperty(P: TProperty): Integer;
var
  i: Integer;
begin
  Result:=-1;
  for i:=0 to Pred(ItemCount) do
    if Properties[i]=P then
    begin
      Result:=i;
      Break;
    end;
end;

function TCustomComponentInspector.Translate(const Value: string; Direction: Boolean): string;
var
  i: Integer;
begin
  if Value<>'' then
  begin
    with FDictionary do
      if Direction then Result:=Values[Value]
      else
      begin
        Result:='';
        for i:=0 to Pred(Count) do
          if Values[Names[i]] = Value then
          begin
            Result:=Names[i];
            Break;
          end;
      end;
    if Result='' then Result:=Value;
  end
  else Result:='';
end;

procedure TCustomComponentInspector.SetInstance(const Value: TPersistent);
begin
  ApplyChanges;
  FPropertyList.Instance:=TComponent(Value);
  if Assigned(Value) and Value.InheritsFrom(TComponent) then
    FreeNotification(TComponent(Value));
  UpdateList;
end;

function TCustomComponentInspector.GetInstance: TPersistent;
begin
  Result:=FPropertyList.Instance;
end;

function TCustomComponentInspector.GetInstanceCount: Integer;
begin
  Result:=FPropertyList.InstanceCount;
end;

function TCustomComponentInspector.GetArrayInstance(Index: Integer): TPersistent;
begin
  Result:=FPropertyList.Instances[Index];
end;

function TCustomComponentInspector.GetMode: TCompInspMode;
begin
  Result:=FPropertyList.Mode;
end;

procedure TCustomComponentInspector.SetMode(const Value: TCompInspMode);
begin
  if Mode<>Value then
  begin
    FPropertyList.Mode:=Value;
    UpdateList;
    SetSelectionPos(ItemIndex,True);
  end;
end;

function TCustomComponentInspector.GetPropertyCount: Integer;
begin
  Result:=FPropertyList.PropertyCount;
end;

function TCustomComponentInspector.GetProperty(TheIndex: Integer): TProperty;
begin
  Result:=FPropertyList.Properties[TheIndex];
end;

procedure TCustomComponentInspector.UpdateList;
begin
  FullUpdateNeeded;
  Update;
  ItemCount:=FPropertyList.PropertyCount;
  if GetDefaultIndex < Count then
     ItemIndex:=GetDefaultIndex;
end;

procedure TCustomComponentInspector.UpdateDictionary;
var
  S: string;
begin
  if FDictionaryFile<>'' then
  begin
    if ExtractFilePath(FDictionaryFile)='' then
    begin
      S:=ExtractFilePath(Application.ExeName);
      if S[Length(S)]<>'\' then S:=S+'\';
      S:=S+FDictionaryFile;
    end
    else S:=FDictionaryFile;
    with TIniFile.Create(S) do
    try
      ReadSectionValues('GOIDICT',FDictionary);
    finally
      Free;
    end;
  end;
end;

procedure TCustomComponentInspector.Update;
var
  i: Integer;
begin
  inherited;
  Lock;
  try
    with FNotificationControls do
      for i:=0 to Pred(Count) do
        TControl(FNotificationControls[i]).Perform(CM_OIUPDATED,0,0);
  finally
    Unlock;
  end;
end;

procedure TCustomComponentInspector.ClearExpanded;
begin
  with FPropertyList do
  begin
    FExpanded.Clear;
    Update;
  end;
end;

procedure TCustomComponentInspector.RefreshList;
var
  i: Integer;
begin
  with FPropertyList do
    for i:=0 to Pred(PropertyListCount) do PropertyLists[i].Update;
  FPropertyList.Update;
  ItemCount:=FPropertyList.PropertyCount;
  SelectProperty(FSelectedProperty);
  Invalidate;
end;

procedure TCustomComponentInspector.CreateWnd;
begin
  ItemCount:=FPropertyList.PropertyCount;
  inherited;
end;

procedure TCustomComponentInspector.Notification(AComponent: TComponent; Operation: TOperation);
begin
  if (Operation=opRemove) and not (csDestroying in ComponentState) then
  begin
    if FPropertyList.IndexOfInstance(AComponent)<>-1 then
    begin
      FPropertyList.DeleteInstance(AComponent);
      if HandleAllocated then UpdateList;
    end;
    if AComponent is TControl then DeleteNotification(TControl(AComponent));
  end;
  inherited;
end;

function TCustomComponentInspector.GetDefaultIndex: Integer;
var
  i: Integer;
begin
  Result:=0;
  if FSelectedProperty<>'' then
    with FPropertyList do
      for i:=0 to Pred(FProperties.Count) do
        if TProperty(FProperties[i]).FullName=FSelectedProperty then
        begin
          Result:=i;
          Break;
        end;
end;

function TCustomComponentInspector.GetPopupItemWidth(ListBox: TListBox; TheIndex: Integer): Integer;
begin
  Result:=inherited GetPopupItemWidth(ListBox,TheIndex);
  with FPropertyList do
    if ValidPropIndex(TheIndex) and (Properties[TheIndex].PropType=TypeInfo(TColor)) then Inc(Result,ItemHeight-2);
end;

procedure TCustomComponentInspector.DrawPopupItem(ListBox: TListBox; ListItemIndex: Integer; R: TRect; TheIndex: Integer);
var
  IR: TRect;
  OldColor: TColor;
begin
  if Assigned(OnDrawPopupItem) then OnDrawPopupItem(Self,TheIndex,ListBox,ListItemIndex,R)
  else
    with FPropertyList do
      if ValidPropIndex(TheIndex) and (Properties[TheIndex].PropType=TypeInfo(TColor)) then
        with ListBox,Canvas,R do
        begin
          FillRect(R);
          Pen.Color:=clWindowText;
          OldColor:=Brush.Color;
          try
            Brush.Color:=StringToColor(Translate(Items[ListItemIndex],False));
          except
            Brush.Color:=clWindow;
          end;
          IR:=R;
          InflateRect(IR,-2,-2);
          with IR do
          begin
            Dec(Bottom);
            Right:=Left+(Bottom-Top);
            Rectangle(Left,Top,Right,Bottom);
          end;
          Brush.Color:=OldColor;
          Inc(Left,ItemHeight);
          DrawText(Handle,PChar(Items[ListItemIndex]),-1,R,DT_SINGLELINE or DT_VCENTER);
        end
      else inherited;
end;

procedure TCustomComponentInspector.DrawPropertyValue(TheCanvas: TCanvas; TheIndex: Integer; R: TRect);
var
  IR: TRect;
begin
  if Assigned(OnDrawValue) then OnDrawValue(Self,TheIndex,TheCanvas,R)
  else
  begin
    with FPropertyList do
      if ValidPropIndex(TheIndex) and (Properties[TheIndex].PropType=TypeInfo(TColor)) then
        with TheCanvas,R do
        begin
          FillRect(R);
          Pen.Color:=clWindowText;
          Brush.Color:=Properties[TheIndex].AsInteger;
          IR:=R;
          InflateRect(IR,-2,-2);
          with IR do
          begin
            Dec(Bottom);
            Right:=Left+(Bottom-Top);
            Rectangle(Left,Top,Right,Bottom);
          end;
          Inc(Left,ItemHeight-1);
        end;
    inherited;
  end;
end;

function TCustomComponentInspector.GetName(TheIndex: Integer): string;
begin
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then Result:=Properties[TheIndex].Name
    else Result:='';
    Result:=Translate(Result,True);
    if Assigned(OnGetName) then OnGetName(Self,TheIndex,Result);
  end;
end;

function TCustomComponentInspector.GetValue(TheIndex: Integer): string;
var
  i: Integer;
  P: TProperty;
  FN: string;
begin
  Result:='';
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
    begin
      Result:=Properties[TheIndex].DisplayValue;
      FN:=Properties[TheIndex].FullName;
      if TheIndex<>ItemIndex then
        with FPropertyLists do
          for i:=1 to Pred(PropertyListCount) do
          begin
            P:=PropertyLists[i].FindProperty(FN);
            if Assigned(P) then
              if P.DisplayValue<>Result then
              begin
                Result:='';
                Break;
              end;
          end;
    end;
    Result:=Translate(Result,True);
    if Assigned(OnGetValue) then OnGetValue(Self,TheIndex,Result);
  end;
end;

function TCustomComponentInspector.GetNextValue(TheIndex: Integer): string;
var
  SL: TStringList;
  I: Integer;
begin
  with FPropertyList,FProperties do
  begin
    if ValidPropIndex(TheIndex) then
    begin
      SL:=TStringList.Create;
      try
        GetValuesList(TheIndex,SL);
        SL.Sorted:=GetSortValuesList(TheIndex);
        I:=SL.IndexOf(GetValue(TheIndex));
        if I<>-1 then
        begin
          if I<Pred(SL.Count) then Inc(I)
          else I:=0;
          Result:=SL[I];
        end
        else Result:=GetValue(TheIndex);
      finally
        SL.Free;
      end;
    end
    else Result:='';
    if Assigned(OnGetNextValue) then OnGetNextValue(Self,TheIndex,Result);
  end;
end;

procedure TCustomComponentInspector.SetValue(TheIndex: Integer; const Value: string);
var
  i: Integer;
  P: TProperty;
  Val,Name: string;
  EnableDefault: Boolean;
begin
  with FPropertyList do
  begin
    EnableDefault:=True;
    Val:=Value;
    if Assigned(OnSetValue) then
      OnSetValue(Self,TheIndex,Val,EnableDefault);
    if EnableDefault and ValidPropIndex(TheIndex) then
    begin
      Val:=Translate(Val,False);
      Name:=Properties[TheIndex].FullName;
      for i:=0 to Pred(PropertyListCount) do
      begin
        P:=PropertyLists[i].FindProperty(Name);
        if Assigned(P) then
          if P.TypeKind in [tkChar,tkWChar] then
            if Length(Val)>0 then P.AsChar:=Val[1]
            else P.AsChar:=#0
          else P.AsString:=Val;
      end;
    end;
    Change(TheIndex);
  end;
end;

procedure TCustomComponentInspector.DragValue(TheIndex,Offset: Integer);
begin
  with FPropertyList do
    if ValidPropIndex(TheIndex) then
      with Properties[TheIndex] do SetEditedText(IntToStr(AsInteger+Offset));
end;

function TCustomComponentInspector.GetButtonType(TheIndex: Integer): TButtonType;
begin
  if GetEnableExternalEditor(TheIndex) then Result:=btDialog
  else Result:=btNone;
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
      with Properties[TheIndex] do
        if Emulated and not Custom then
        begin
          if Assigned(OwnerProperty) and (OwnerProperty.TypeKind<>tkVariant) then
            Result:=btDropDown;
        end
        else
          case TypeKind of
            tkString,tkLString,tkWString:
              if PropType=TypeInfo(TFontName) then Result:=btDropDown;
            tkEnumeration {$IFDEF FPC}, tkBool {$ENDIF} :
              if GetInplaceEditorType(TheIndex)<>ieCheckBox then
                Result:=btDropDown;
            tkClass:
              if IsType(TypeInfo(TCollection)) or
                IsType(TypeInfo(TMenuItem)) or
                IsType(TypeInfo(TTreeNodes)) or
                IsType(TypeInfo(TListItems)) then Result:=btDialog
              else
                if IsType(TypeInfo(TComponent)) then Result:=btDropDown;
            {$IFNDEF VERSION3}
            tkInterface: Result:=btDropDown;
            {$ENDIF}
            tkInteger:
              if (PropType=TypeInfo(TColor)) or
                (PropType=TypeInfo(TCursor)) or
                (PropType=TypeInfo(TModalResult)) or
                (PropType=TypeInfo(TFontCharset)) or
                (PropType=TypeInfo(TShortCut)) then Result:=btDropDown
              else Result:=btUpDown;
            tkMethod: Result:=btDropDown;
          end;
    if (Result<>btDialog) and GetReadOnly(TheIndex) then Result:=btNone;
    if Assigned(OnGetButtonType) then OnGetButtonType(Self,TheIndex,Result);
  end;
end;

function TCustomComponentInspector.GetInplaceEditorType(TheIndex: Integer): TInplaceEditorType;
begin
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
      with Properties[TheIndex] do
        if (PropType=TypeInfo(Boolean)) and CheckBoxes then
          Result:=ieCheckBox
        else
          Result:=ieEdit
    else
      Result:=ieNone;
    if Assigned(OnGetInplaceEditorType) then OnGetInplaceEditorType(Self,TheIndex,Result);
  end;
end;

function TCustomComponentInspector.GetEnableExternalEditor(TheIndex: Integer): Boolean;
begin
  Result:=False;
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
      with Properties[TheIndex] do
        case TypeKind of
          tkInteger: Result:=PropType=TypeInfo(TColor);
          tkClass:
            Result:=
              IsType(TypeInfo(TCollection)) or
              IsType(TypeInfo(TMenuItem)) or
              IsType(TypeInfo(TTreeNodes)) or
              IsType(TypeInfo(TListItems)) or
              IsType(TypeInfo(TFont)) or
              IsType(TypeInfo(TStrings)) or
              IsType(TypeInfo(TGraphic)) or
              IsType(TypeInfo(TPicture));
        end;
    if Assigned(OnGetEnableExternalEditor) then OnGetEnableExternalEditor(Self,TheIndex,Result);
  end;
end;

function TCustomComponentInspector.GetReadOnly(TheIndex: Integer): Boolean;
begin
  Result:=False;
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
      with Properties[TheIndex] do
        if (TypeKind=tkClass) and not IsType(TypeInfo(TComponent)) then Result:=True;
    if Assigned(OnGetReadOnly) then OnGetReadOnly(Self,TheIndex,Result);
  end;
end;

function TCustomComponentInspector.GetExpandState(TheIndex: Integer): TExpandState;
begin
  Result:=esNone;
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
      with Properties[TheIndex] do
        case TypeKind of
          tkVariant,tkSet:
            if (TheIndex<Pred(PropertyCount)) and (GetLevel(Succ(TheIndex))>Level) then Result:=esCollapse
            else Result:=esExpand;
          tkClass:
            if not (AsObject is TComponent) and (Properties.Count>0) then
              if (TheIndex<Pred(PropertyCount)) and (GetLevel(Succ(TheIndex))>Level) then Result:=esCollapse
              else Result:=esExpand;
        end;
    if Assigned(OnGetExpandState) then OnGetExpandState(Self,TheIndex,Result);
  end;
end;

function TCustomComponentInspector.GetLevel(TheIndex: Integer): Integer;
begin
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then Result:=Properties[TheIndex].Level
    else Result:=0;
    if Assigned(OnGetLevel) then OnGetLevel(Self,TheIndex,Result);
  end;
end;

procedure TCustomComponentInspector.GetValuesList(TheIndex: Integer; const Strings: TStrings);
var
  i: Integer;
begin
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) and Assigned(Strings) then
    begin
      Properties[TheIndex].ValuesList(Strings);
      for i:=0 to Pred(Strings.Count) do Strings[i]:=Translate(Strings[i],True);
    end;
    if Assigned(OnGetValuesList) then OnGetValuesList(Self,TheIndex,Strings);
  end;
end;

function TCustomComponentInspector.GetSortValuesList(TheIndex: Integer): Boolean;
begin
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
      with Properties[TheIndex] do
        Result:=(PropType=TypeInfo(TCursor)) or (TypeKind=tkMethod) or
          Assigned(OwnerProperty) and (OwnerProperty.TypeKind=tkVariant)
    else Result:=False;
    if Assigned(OnGetSortValuesList) then OnGetSortValuesList(Self,TheIndex,Result);
  end;
end;

function TCustomComponentInspector.GetSelectedValue(TheIndex: Integer): string;
begin
  Result:=GetValue(TheIndex);
  if Assigned(OnGetSelectedValue) then OnGetSelectedValue(Self,TheIndex,Result);
end;

function TCustomComponentInspector.GetAutoApply(TheIndex: Integer): Boolean;
begin
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
      Result:=(Properties[TheIndex].TypeKind<>tkClass) or (Properties[TheIndex].IsType(TypeInfo(TComponent))) and
        (PropertyListCount=1) and (GetInplaceEditorType(TheIndex)<>ieCheckBox)
    else Result:=False;
    if Assigned(OnGetAutoApply) then OnGetAutoApply(Self,TheIndex,Result);
  end;
end;

function TCustomComponentInspector.CallEditor(TheIndex: Integer): Boolean;
var
  PC: TPropertyEditorClass;
  PE: TPropertyEditor;
  P: TProperty;
  EnableDefault: Boolean;
begin
  EnableDefault:=True;
  if Assigned(FOnCallEditor) then Result:=FOnCallEditor(Self,TheIndex,EnableDefault)
  else Result:=False;
  if EnableDefault then
  begin
    PC:=GetEditorClass(TheIndex);
    if Assigned(PC) then
      with FPropertyList do
      begin
        P:=Properties[TheIndex];
        if Assigned(P) then
        begin
          PE:=PC.Create(P);
          try
            Result:=PE.Execute;
            if Result then
            begin
              SetValue(TheIndex,P.AsString);
              FullUpdateNeeded;
            end;
          finally
            PE.Free;
            Update;
          end;
        end;
    end;
  end;
end;

procedure TCustomComponentInspector.Expand(TheIndex: Integer);
var
  i: Integer;
  EnableDefault: Boolean;
begin
  if GetExpandState(TheIndex)=esExpand then
    with FPropertyList do
    begin
      EnableDefault:=True;
      if Assigned(FOnBeforeExpand) then FOnBeforeExpand(Self,TheIndex,EnableDefault);
      if EnableDefault and ValidPropIndex(TheIndex) then
      begin
        with Properties[TheIndex],Properties do
        begin
          FExpanded.Add(FullName);
          for i:=Pred(Count) downto 0 do
          begin
            FProperties.Insert(Succ(TheIndex),Properties[i]);
            Items.Insert(Succ(TheIndex),Properties[i].Name);
          end;
        end;
        if Assigned(FOnAfterExpand) then FOnAfterExpand(Self,TheIndex);
      end;
    end;
end;

procedure TCustomComponentInspector.Collapse(TheIndex: Integer);
var
  L,i: Integer;
  EnableDefault: Boolean;
begin
  if GetExpandState(TheIndex)=esCollapse then
  begin
    with FPropertyList do
    begin
      EnableDefault:=True;
      if Assigned(FOnBeforeCollapse) then FOnBeforeCollapse(Self,TheIndex,EnableDefault);
      if EnableDefault and ValidPropIndex(TheIndex) then
      begin
        L:=Properties[TheIndex].Level;
        with FExpanded do
        begin
          i:=IndexOf(Properties[TheIndex].FullName);
          if i<>-1 then Delete(i);
        end;
        while (Succ(TheIndex)<PropertyCount) and (Properties[Succ(TheIndex)].Level>L) do
        begin
          FProperties.Delete(Succ(TheIndex));
          Items.Delete(Succ(TheIndex));
        end;
        if Assigned(FOnAfterCollapse) then FOnAfterCollapse(Self,TheIndex);
      end;
    end;
  end;
end;

procedure TCustomComponentInspector.SelectItem(TheIndex: Integer);
begin
  inherited;
  with FPropertyList do
    if ValidPropIndex(ItemIndex) then
      FSelectedProperty:=FPropertyList.Properties[ItemIndex].FullName;
end;

function TCustomComponentInspector.GetEditorClass(TheIndex: Integer): TPropertyEditorClass;
begin
  Result:=nil;
  with FPropertyList do
  begin
    if ValidPropIndex(TheIndex) then
      with Properties[TheIndex] do
        case TypeKind of
          tkInteger:
            if PropType=TypeInfo(TColor) then Result:=TColorPropertyEditor;
          tkClass:
            if IsType(TypeInfo(TCollection)) then Result:=TCollectionPropertyEditor
            else
              if IsType(TypeInfo(TMenuItem)) then Result:=TMenuPropertyEditor
              else
                if IsType(TypeInfo(TTreeNodes)) then Result:=TTreePropertyEditor
                else
                  if IsType(TypeInfo(TListItems)) then Result:=TListViewPropertyEditor
                  else
                    if IsType(TypeInfo(TFont)) then Result:=TFontPropertyEditor
                    else
                      if IsType(TypeInfo(TStrings)) then Result:=TStringsPropertyEditor
                      else
                        if IsType(TypeInfo(TPicture)) or IsType(TypeInfo(TGraphic)) then
                          Result:=TPicturePropertyEditor;
        end;
    if Assigned(FOnGetEditorClass) then FOnGetEditorClass(Self,TheIndex,Result);
  end;
end;

procedure TCustomComponentInspector.Compare(Prop1,Prop2: TProperty; var Result: Integer);
begin
  if Assigned(FOnCompare) then FOnCompare(Self,Prop1,Prop2,Result);
end;

procedure TCustomComponentInspector.Filter(Prop: TProperty; var Result: Boolean);
begin
  if Assigned(FOnFilter) then FOnFilter(Self,Prop,Result);
end;

procedure TCustomComponentInspector.Change(TheIndex: Integer);
begin
  if Assigned(FOnChange) then FOnChange(Self,TheIndex);
end;

constructor TCustomComponentInspector.Create(AOwner: TComponent);
begin
  inherited;
  FDictionary:=TStringList.Create;
  FMultiSelect:=True;
  FPropertyList:=TCompInspList.CreateWithOwner(Self);
  FNotificationControls:=TList.Create;
end;

destructor TCustomComponentInspector.Destroy;
begin
  inherited;
  FPropertyList.Free;
  FNotificationControls.Free;
  FDictionary.Free;
end;

procedure TCustomComponentInspector.AddInstance(AInstance: TPersistent);
begin
  FPropertyList.AddInstance(TComponent(AInstance));
  if Assigned(AInstance) and AInstance.InheritsFrom(TComponent) then
    FreeNotification(TComponent(AInstance));
  if not Locked then UpdateList;
end;

procedure TCustomComponentInspector.DeleteInstance(AInstance: TPersistent);
begin
  FPropertyList.DeleteInstance(TComponent(AInstance));
  if not Locked then UpdateList;
end;

function TCustomComponentInspector.IndexOfInstance(AInstance: TPersistent): Integer;
begin
  Result:=FPropertyList.IndexOfInstance(TComponent(AInstance));
end;

procedure TCustomComponentInspector.AddNotification(TheControl: TControl);
begin
  with FNotificationControls do
    if IndexOf(TheControl)=-1 then Add(TheControl);
end;

procedure TCustomComponentInspector.DeleteNotification(TheControl: TControl);
var
  Index: Integer;
begin
  with FNotificationControls do
  begin
    Index:=IndexOf(TheControl);
    if Index<>-1 then Delete(Index);
  end;
end;

procedure TCustomComponentInspector.FillEventList(EventType: PTypeInfo; Strings: TStrings);
begin
  if Assigned(FOnFillEventList) then FOnFillEventList(Self,EventType,Strings);
end;

procedure TCustomComponentInspector.CustomizeInspector(Inspector: TComponentInspector);
begin
  if Assigned(FOnCustomizeInspector) then FOnCustomizeInspector(Self,Inspector);
end;

procedure TCustomComponentInspector.FullExpand;
var
  i: Integer;
begin
  i:=0;
  while i<ItemCount do
  begin
    if GetExpandState(i)=esExpand then Expand(i);
    Inc(i);
  end;
end;

end.
