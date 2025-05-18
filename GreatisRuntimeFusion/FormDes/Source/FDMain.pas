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

unit FDMain;

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
  {$DEFINE GFDENABLEAUTORANGE}
  {$DEFINE GFDTEXTCLIPBOARD}
{$ENDIF}

{$IFDEF FDADDINCLUDE}{$I FD.INC}{$ENDIF}

interface

uses
  {$IFnDEF FPC}
  Windows,
  {$ELSE}
  LCLIntf, LCLType, LMessages, Math, {$IFDEF Windows} CommCtrl, {$ENDIF}
  {$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, Types,
  Menus, IniFiles,  Clipbrd, ExtCtrls, ComCtrls, StdCtrls;

  {$IFDEF FPC}
const
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

  TGrabPosition = (
    gpNone,
    gpLeftTop,
    gpLeftMiddle,
    gpLeftBottom,
    gpMiddleTop,
    gpMiddleBottom,
    gpRightTop,
    gpRightMiddle,
    gpRightBottom);

  TGrabPositions = set of TGrabPosition;

  TGrabMode = (gmMiddle, gmInside, gmOutside);

  TCustomFormDesigner = class;
  TGrabSelectItem = class;

  TComponentContainer = class(TCustomControl)
  private
    FDesigner: TCustomFormDesigner;
    FComponent: TComponent;
    FBitmap: TBitmap;
    FCaption: TStaticText;
  protected
    procedure Paint; override;
    procedure WndProc(var Msg: TMessage); override;
  public
    constructor Create(aOwner: TComponent); override;
    constructor CreateWithComponent(AOwner, AComponent: TComponent;
      ADesigner: TCustomFormDesigner);
    destructor Destroy; override;
    procedure UpdateContainer;
    property Component: TComponent read FComponent write FComponent;
  end;

  TFDReader = class(TReader)
  private
    Designer: TCustomFormDesigner;
  protected
    function Error(const Message: string): boolean; override;
    procedure SetName(Reader: TReader; Component: TComponent; var Name: string);
  public
    constructor Create(AStream: TStream; ADesigner: TCustomFormDesigner);
  end;

  TLineSelect = class(TCustomControl)
  private
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TLineHandle = class(TCustomControl)
  private
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TDragRectsItem = class(TCollectionItem)
  private
    FControl: TControl;
    FVisible : Boolean;

    FItems: array[0..3] of TLineHandle;
    procedure SetVisible(Value : Boolean);
    function GetTabOrder: TTabOrder;
    procedure SetTabOrder(NewTabOrder: TTabOrder);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    procedure SetRectangle(AForm: TCustomForm; ARect : TRect; AThickness: Integer);
    property Control: TControl read FControl write FControl;
    property Visible : Boolean read FVisible write SetVisible;
    property TabOrder: TTabOrder read GetTabOrder write SetTabOrder;
  end;

  TGrabSelect = class(TCustomControl)
  private
    FGrabSelectItem: TGrabSelectItem;
  protected
    procedure Paint; override;
  public
    constructor Create(AOwner: TComponent); override;
  end;

  TGrabSelectItem = class(TCollectionItem)
  private
    FControl: TControl;
    FVisible : Boolean;

    FItems: array[0..3] of TGrabSelect;
    procedure SetVisible(Value : Boolean);
    function GetTabOrder: TTabOrder;
    procedure SetTabOrder(NewTabOrder: TTabOrder);
  public
    constructor Create(Collection: TCollection); override;
    destructor Destroy; override;
  published
    procedure SetGrabGlyph(AForm: TCustomForm; FGrabGlyph: TBitmap; ARect : TRect; AGrabMode: TGrabMode; AGrabSize: Integer);
    property Control: TControl read FControl write FControl;
    property Visible : Boolean read FVisible write SetVisible;
    property TabOrder: TTabOrder read GetTabOrder write SetTabOrder;
  end;

  TGrabHandle = class(TCustomControl)
  private
    FPosition: TGrabPosition;
    FRect: TRect;
    FLocked: boolean;
    procedure SetPosition(Value: TGrabPosition);
    procedure SetRect(Value: TRect);
    procedure SetLocked(Value: boolean);
    procedure UpdateCoords;
    procedure SetArrowCursor;
  protected
    procedure Paint; override;
    procedure WndProc(var Msg: TMessage); override;
    
  public
    constructor Create(AOwner: TComponent); override;
    property Position: TGrabPosition read FPosition write SetPosition;
    property Rect: TRect read FRect write SetRect;
    property Locked: boolean read FLocked write SetLocked;
  end;

  TGrabHandles = class(TComponent)
  private
    FItems: array[TGrabPosition] of TGrabHandle;
    FControl: TControl;
    FVisible: boolean;
    FEnabled: boolean;
    procedure SetControl(Value: TControl);
    procedure SetVisible(Value: boolean);
    procedure SetEnabled(Value: boolean);
    function GetParentForm: TCustomForm;
    function GetDesigner: TCustomFormDesigner;
  public
    constructor Create(AOwner: TComponent); override;
    procedure Update(MustHide: boolean);
    procedure BringToFront;
    function FindHandle(AHandle: HWND): TGrabPosition;
    function FindHandleControl(AHandle: HWND): TGrabHandle;
    function IsGrabHandle(AControl: TControl): boolean;
    property Control: TControl read FControl write SetControl;
    property Visible: boolean read FVisible write SetVisible;
    property Enabled: boolean read FEnabled write SetEnabled;
    property ParentForm: TCustomForm read GetParentForm;
    property Designer: TCustomFormDesigner read GetDesigner;
  end;

  TSubstPropItem = class(TCollectionItem)
  private
    FControl: TControl;
    FVisible : Boolean;
    FEnabled : Boolean;

  public
  published
    property Control: TControl read FControl write FControl;
    property Visible : Boolean read FVisible write FVisible;
    property Enabled : Boolean read FEnabled write FEnabled;
  end;

  TListType = (ltLocked, ltProtected, ltTransparent);

  TChildrenMode = (cmNone, cmNormal, cmRecurse);

  TProtectMode = (pmUnselect, pmLockKeyboard);

  TMessageProcessor = (mpEvent, mpHook);

  TMouseAction = (maNone, maDragging, maSelecting, maPlacing);

  THintMode = (hmCustom, hmMove, hmSize);

  TGrabType = (gtNormal, gtMulti, gtLocked);

  TAlignMode = (amNoChange, amLeftTop, amCenters, amRightBottom, amSpace, amWindowCenter);

  TSizeMode = (smNoChange, smToSmallest, smToLargest, smValue);

  TAlignmentPaletteOption = (apAutoShow, apStayOnTop, apShowHints, apFlatButtons);
  TAlignmentPaletteOptions = set of TAlignmentPaletteOption;

  TDFMFormat = (dfmBinary, dfmText);

  TEditBehaviour = (ebDefault, ebTransparent, ebLocked, ebProtected, ebDefaultRuntime, ebTransparentRuntime, ebLockedRuntime);

  TLinePosition = (lpLeft, lpTop, lpRight, lpBottom);
  TLinePositions = set of TLinePosition;

  TMoveLimitMode = (lmCursor, lmControls);

  TControlNotifyEvent = procedure(Sender: TObject; TheControl: TControl) of object;
  TComponentNotifyEvent = procedure(Sender: TObject; TheComponent: TComponent) of object;
  TLoadSaveEvent = procedure(Sender: TObject; TheControl: TControl; IniFile: TIniFile) of object;
  TDesignerMessageEvent = procedure(Sender: TObject; var Msg: TMsg) of object;
  TMoveLimitEvent = procedure(Sender: TObject; TheControl: TControl; var LimitRect: TRect) of object;
  TSizeLimitEvent = procedure(Sender: TObject; TheControl: TControl; var MinSize, MaxSize: TPoint) of object;
  TCustomizeGrabsEvent = procedure(Sender: TObject; var VisibleGrabs, EnabledGrabs: TGrabPositions) of object;
  TComponentTextEvent = procedure(Sender: TObject; TheComponent: TComponent; var Text: string) of object;
  TComponentBitmapEvent = procedure(Sender: TObject; TheComponent: TComponent; const Bitmap: TBitmap) of object;
  TComponentEditableEvent = procedure(Sender: TObject; TheComponent: TComponent; var Editable: boolean) of object;
  TComponentClipboardEvent = procedure(Sender: TObject; TheComponent: TComponent) of object;
  TComponentPopupEvent = procedure(Sender: TObject; var Handled: boolean) of object;
  TComponentBehaviourEvent = procedure(Sender: TObject; TheComponent: TComponent; var Behaviour: TEditBehaviour) of object;
  TValidateSelectionEvent = procedure(Sender: TObject; TheControl: TControl; var Valid: boolean) of object;
  TRectEvent = procedure(Sender: TObject; var R: TRect) of object;
  TFormEvent = procedure(Sender: TObject; Form: TForm) of object;
  {$IFDEF GFDIDEVENTS}
  TControlIDNotifyEvent = procedure(Sender: TObject; TheControl: TControl; ActionID: Integer) of object;
  {$ENDIF GFDIDEVENTS}

  {$IFDEF FPC}

  TDesignForm = class(TForm)
  private
    FDesigner: TCustomFormDesigner;
    FWndProc: TWndMethod;
    FOrigin: TWndMethod;
    FInPaint: Boolean;
    FCBInited: Boolean;
  protected
    
    procedure ProxyWndProc(var TheMessage : TLMessage);
    procedure WndProcDef(var TheMessage : TLMessage);
    procedure FormChangeBounds(Sender: TObject);
  public
    constructor Create(AOwner: TComponent); override;
    property onWndProc: TWndMethod read FWndProc write FWndProc;
    property Designer: TCustomFormDesigner read FDesigner write FDesigner;
  end;
  {$ENDIF}

  TCustomFormDesigner = class(TComponent)
  private
    
    FDefaultProc: TFarProc;
    FWinProc: Pointer;
    FBkgBitmap: TBitmap;
    FForm: TCustomForm;
    FAPForm: TForm;
    FHintControl: TControl;
    FHintTimer: TTimer;
    FIgnoreMouseMove: boolean;
    FKeySelect: boolean;
    FKeyMove: boolean;
    FClearBeforeLoad: boolean;
    FMustClear: boolean;
    FGrabSize: integer;
    FNormalGrabBorder: TColor;
    FNormalGrabFill: TColor;
    FMultiGrabBorder: TColor;
    FMultiGrabFill: TColor;
    FLockedGrabBorder: TColor;
    FLockedGrabFill: TColor;
    FNormalGrab: TBitmap;
    FNormalGrabGlyph: TBitmap;
    FMultiGrab: TBitmap;
    FMultiGrabGlyph: TBitmap;
    FLockedGrab: TBitmap;
    FLockedGrabGlyph: TBitmap;
    FHintWindow: THintWindow;
    
    FClickPos: TPoint;
    FCursorPos: TPoint;
    FControlPos: TPoint;
    FControlRect: TRect;
    FDefaultColor: TColor;
    FActive: boolean;
    FMessageProcessor: TMessageProcessor;
    FLockCounter: integer;
    FSynchroLockCounter: integer;
    FWaiting: boolean;
    FPlacingParent: TWinControl;
    FPlacedComponent: TComponent;
    FDefaultPlacing: boolean;
    FControls: TList;
    FDesignControl: TWinControl;
    FSelectControl: TWinControl;
    FMenuControl: TControl;
    FGrabHandles: TGrabHandles;
    {$IFDEF GFDADVANCEDGRID}
    FGridStepX: Integer;
    FGridStepY: Integer;
    {$ELSE}
    FGridStep: integer;
    {$ENDIF}
    FSnapToGrid: boolean;
    FSnapToGridKey: boolean;
    FDisplayGrid: boolean;
    FDesignerColor: TColor;
    FGridColor: TColor;
    FPopupMenu: TPopupMenu;
    FLockedControls: TStrings;
    FLockedInverse: boolean;
    FLockChildren: TChildrenMode;
    FProtectedControls: TStrings;
    FProtectedInverse: boolean;
    FProtectChildren: TChildrenMode;
    FProtectMode: TProtectMode;
    FTransparentControls: TStrings;
    FTransparentInverse: boolean;
    FTransparentChildren: TChildrenMode;
    FShowMoveSizeHint: boolean;
    FShowComponentHint: boolean;
    FAlignmentPalette: TAlignmentPaletteOptions;
    FMouseAction: TMouseAction;
    FDragPoint: TPoint;
    FDragRect: TRect;
    FSelectRect: TRect;
    FPlacingRect: TRect;
    FSelectCounter: integer;
    FDragHandle: TGrabPosition;
    FShowNonVisual: boolean;
    FShowComponentCaptions: boolean;
    FMultiSelect: boolean;
    FModified: boolean;
    FEnableAxisDrag: boolean;
    FDirectMove: boolean;
    FGrabMode: TGrabMode;
    FUseGrabGlyphs: boolean;
    FGrabsTransparentColor: TColor;
    FAlignmentEntireForm: boolean;
    FAlignmentLines: TLinePositions;
    FAlignmentColorLeft: TColor;
    FAlignmentColorTop: TColor;
    FAlignmentColorRight: TColor;
    FAlignmentColorBottom: TColor;
    FAlignmentLineWidth: integer;
    FMoveLimitMode: TMoveLimitMode;
    FAncestor: TComponent;
    OnPaintOld: TNotifyEvent;
    OnDestroyOld: TNotifyEvent;
    {$IFDEF GFDIDEVENTS}
    FActionID: Integer;
    {$ENDIF GFDIDEVENTS}
    FOnMoveSizeControl: TControlNotifyEvent;
    {$IFDEF GFDIDEVENTS}
    FOnMoveSizeControlID: TControlIDNotifyEvent;
    {$ENDIF GFDIDEVENTS}
    FOnChange: TNotifyEvent;
    FOnLoadControl: TLoadSaveEvent;
    FOnSaveControl: TLoadSaveEvent;
    FOnSelectControl: TControlNotifyEvent;
    FOnSelectionChange: TNotifyEvent;
    FOnControlDblClick: TControlNotifyEvent;
    FOnAddControl: TControlNotifyEvent;
    FOnDeleteControl: TControlNotifyEvent;
    FOnActivate: TNotifyEvent;
    FOnDeactivate: TNotifyEvent;
    FOnKeyDown: TKeyEvent;
    FOnKeyUp: TKeyEvent;
    FOnMessage: TDesignerMessageEvent;
    FOnMoveLimit: TMoveLimitEvent;
    FOnSizeLimit: TSizeLimitEvent;
    FOnReadError: TReaderError;
    FOnCustomizeGrabs: TCustomizeGrabsEvent;
    FOnComponentHint: TComponentTextEvent;
    FOnComponentCaption: TComponentTextEvent;
    FOnComponentBitmap: TComponentBitmapEvent;
    FOnComponentEditable: TComponentEditableEvent;
    FOnCopyComponent: TComponentClipboardEvent;
    FOnPasteComponent: TComponentClipboardEvent;
    FOnContextPopup: TComponentPopupEvent;
    FOnEditBehaviour: TComponentBehaviourEvent;
    FOnPlaceComponent: TComponentNotifyEvent;
    FOnEndPlacing: TRectEvent;
    FOnEndSelecting: TRectEvent;
    FOnShowAlignmentPalette: TFormEvent;
    FOnValidateSelection: TValidateSelectionEvent;
    
    {$IFDEF UNIX}
    FMouseTimer: TTimer;
    MouseX: Integer;
    MouseY: Integer;
    {$ENDIF}
    
    FDragRects: TCollection;
    FGrabSelects: TOwnedCollection;
    FSubstProp: TCollection;
    FPlacingRectArray: array[0..3] of TLineHandle;
    FSelectRectArray: array[0..3] of TLineSelect;

    function GetControlCount: integer;
    function GetLocked: boolean;
    function GetSynchroLocked: boolean;
    function GetParentForm: TCustomForm;
    procedure SetParentForm(const Value: TCustomForm);
    function GetFormData: string;
    procedure SetFormData(const Value: string);
    procedure SetActive(Value: boolean);
    procedure SetMessageProcessor(Value: TMessageProcessor);
    function GetControl: TControl;
    procedure SetControl(Value: TControl);
    function GetControlByIndex(Index: integer): TControl;
    function GetComponent: TComponent;
    procedure SetComponent(Value: TComponent);
    function GetComponentByIndex(Index: integer): TComponent;
    {$IFDEF GFDADVANCEDGRID}
    procedure SetGridStepX(Value: Integer);
    procedure SetGridStepY(Value: Integer);
    {$ELSE}
    procedure SetGridStep(Value: integer);
    {$ENDIF}
    procedure SetDisplayGrid(Value: boolean);
    procedure SetDesignerColor(Value: TColor);
    procedure SetGridColor(Value: TColor);
    procedure SetLockedControls(Value: TStrings);
    procedure SetLockedInverse(Value: boolean);
    procedure SetLockChildren(Value: TChildrenMode);
    procedure SetProtectedControls(Value: TStrings);
    procedure SetProtectedInverse(Value: boolean);
    procedure SetProtectChildren(Value: TChildrenMode);
    procedure SetProtectMode(Value: TProtectMode);
    procedure SetTransparentControls(Value: TStrings);
    procedure SetTransparentInverse(Value: boolean);
    procedure SetTransparentChildren(Value: TChildrenMode);
    procedure SetMoveSizeHint(Value: boolean);
    procedure SetComponentHint(Value: boolean);
    procedure SetGrabSize(Value: integer);
    procedure SetAlignmentPalette(Value: TAlignmentPaletteOptions);
    procedure SetNormalGrabBorder(Value: TColor);
    procedure SetNormalGrabFill(Value: TColor);
    procedure SetNormalGrabGlyph(Value: TBitmap);
    procedure SetMultiGrabBorder(Value: TColor);
    procedure SetMultiGrabFill(Value: TColor);
    procedure SetMultiGrabGlyph(Value: TBitmap);
    procedure SetLockedGrabBorder(Value: TColor);
    procedure SetLockedGrabFill(Value: TColor);
    procedure SetLockedGrabGlyph(Value: TBitmap);
    procedure SetShowNonVisual(const Value: boolean);
    procedure SetShowComponentCaptions(const Value: boolean);
    procedure SetMultiSelect(const Value: boolean);
    procedure SetDesignControl(const Value: TWinControl);
    procedure SetGrabMode(const Value: TGrabMode);
    procedure SetUseGrabGlyphs(const Value: boolean);
    procedure SetGrabsTransparentColor(const Value: TColor);
    
    procedure ApplicationIdle(Sender: TObject; var Done: boolean);
    procedure ApplicationMessage(var Msg: TMsg; var Handled: boolean);
    procedure TimerEvent(Sender: TObject);
    procedure StartTimer(AInterval: integer);
    procedure StopTimer;
    
    procedure DrawBackground;
    function InTheList(List: TStrings; AControl: TControl): boolean;
    procedure UpdateGrid;
    procedure ShowHint(AHint: string; Mode: THintMode);
    procedure HideHint;
    function GetControlsOrigin: TPoint;
    function CheckParent(AControl: TControl; DisableLocked: boolean): boolean;
    procedure SetArrowCursor;
    function ValidControl(AControl: TControl): boolean;
    procedure ScrollBoxPos(AControl: TControl);
    procedure CreateContainers;
    procedure DestroyContainers;
    procedure UpdateContainers;
    function InParentForm(WND: HWND): boolean;
    {$IFDEF TFDTRIAL}
    procedure ShowTrialWarning;
    {$ENDIF}
    
    procedure ListChange(Sender: TObject);
    
    procedure WinProc(var Message: TMessage);
  protected
    
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure MessageProc(var Msg: TMSG); virtual;
    procedure DoMoveSizeControl; virtual;
    procedure DoChange; virtual;
    procedure DoSelectControl(AControl: TControl); virtual;
    procedure DoSelectionChange; virtual;
    procedure DoAddControl(AControl: TControl); virtual;
    procedure DoDeleteControl(AControl: TControl); virtual;
    function DoValidateSelection(AControl: TControl): boolean; virtual;
    function GetEditBehaviour(AControl: TControl): TEditBehaviour; virtual;
    procedure KeyEventDown(Sender: TObject; var Key: Word; Shift: TShiftState);
    procedure ParentFormPaint(Sender: TObject);
    procedure ParentFormDestroy(Sender: TObject);
    {$IFDEF UNIX}
    procedure OnMouseTimer(Sender: TObject);
    {$ENDIF}
    {$IFDEF TFD1COMPATIBLE}
    property OnDragControl: TControlNotifyEvent read FOnMoveSizeControl write FOnMoveSizeControl;
    {$ELSE}
    property OnMoveSizeControl: TControlNotifyEvent read FOnMoveSizeControl write FOnMoveSizeControl;
    {$IFDEF GFDIDEVENTS}
    property OnMoveSizeControlID: TControlIDNotifyEvent read FOnMoveSizeControlID write FOnMoveSizeControlID;
    {$ENDIF GFDIDEVENTS}
    {$ENDIF}
    property OnChange: TNotifyEvent read FOnChange write FOnChange;
    property OnLoadControl: TLoadSaveEvent read FOnLoadControl write FOnLoadControl;
    property OnSaveControl: TLoadSaveEvent read FOnSaveControl write FOnSaveControl;
    property OnSelectControl: TControlNotifyEvent read FOnSelectControl write FOnSelectControl;
    property OnSelectionChange: TNotifyEvent read FOnSelectionChange write FOnSelectionChange;
    property OnControlDblClick: TControlNotifyEvent read FOnControlDblClick write FOnControlDblClick;
    property OnAddControl: TControlNotifyEvent read FOnAddControl write FOnAddControl;
    property OnDeleteControl: TControlNotifyEvent read FOnDeleteControl write FOnDeleteControl;
    property OnActivate: TNotifyEvent read FOnActivate write FOnActivate;
    property OnDeactivate: TNotifyEvent read FOnDeactivate write FOnDeactivate;
    property OnKeyDown: TKeyEvent read FOnKeyDown write FOnKeyDown;
    property OnKeyUp: TKeyEvent read FOnKeyUp write FOnKeyUp;
    property OnMessage: TDesignerMessageEvent read FOnMessage write FOnMessage;
    property OnMoveLimit: TMoveLimitEvent read FOnMoveLimit write FOnMoveLimit;
    property OnSizeLimit: TSizeLimitEvent read FOnSizeLimit write FOnSizeLimit;
    property OnReadError: TReaderError read FOnReadError write FOnReadError;
    property OnCustomizeGrabs: TCustomizeGrabsEvent read FOnCustomizeGrabs write FOnCustomizeGrabs;
    property OnComponentHint: TComponentTextEvent read FOnComponentHint write FOnComponentHint;
    property OnComponentCaption: TComponentTextEvent read FOnComponentCaption write FOnComponentCaption;
    property OnComponentBitmap: TComponentBitmapEvent read FOnComponentBitmap write FOnComponentBitmap;
    property OnComponentEditable: TComponentEditableEvent read FOnComponentEditable write FOnComponentEditable;
    property OnCopyComponent: TComponentClipboardEvent read FOnCopyComponent write FOnCopyComponent;
    property OnPasteComponent: TComponentClipboardEvent read FOnPasteComponent write FOnPasteComponent;
    property OnContextPopup: TComponentPopupEvent read FOnContextPopup write FOnContextPopup;
    property OnEditBehaviour: TComponentBehaviourEvent read FOnEditBehaviour write FOnEditBehaviour;
    property OnPlaceComponent: TComponentNotifyEvent read FOnPlaceComponent write FOnPlaceComponent;

    property OnEndPlacing: TRectEvent read FOnEndPlacing write FOnEndPlacing;
    property OnEndSelecting: TRectEvent read FOnEndSelecting write FOnEndSelecting;
    property OnShowAlignmentPalette: TFormEvent read FOnShowAlignmentPalette write FOnShowAlignmentPalette;
    property OnValidateSelection: TValidateSelectionEvent read FOnValidateSelection write FOnValidateSelection;
  public
    
    procedure ClearForm;
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure Update; virtual;
    procedure CreateObjects;
    procedure DestroyObjects;
    function IsLocked(AControl: TControl): boolean;
    function IsProtected(AControl: TControl): boolean;
    function IsTransparent(AControl: TControl): boolean;
    function FindNextControl(GoForward: boolean): TControl;
    function ControlAtMousePos(AParent: TWinControl; P: TPoint): TControl;
    function FindWinControl(Wnd: HWND): TWinControl;
    function FindComponentContainer(AComponent: TComponent): TComponentContainer;
    procedure SaveToFile(FileName: string);
    procedure LoadFromFile(FileName: string);
    procedure SaveToDFM(FileName: string; DFMFormat: TDFMFormat);
    procedure LoadFromDFM(FileName: string; DFMFormat: TDFMFormat);
    procedure SaveComponentToStream(Stream: TStream; Component: TComponent; DFMFormat: TDFMFormat);
    function LoadComponentFromStream(Stream: TStream; Component: TComponent; DFMFormat: TDFMFormat): TComponent;
    procedure SaveToStream(Stream: TStream; DFMFormat: TDFMFormat);
    procedure LoadFromStream(Stream: TStream; DFMFormat: TDFMFormat);
    function CanCopy: boolean;
    function CanPaste: boolean;
    procedure CopyToClipboard;
    procedure CutToClipboard;
    procedure PasteFromClipboard;
    function GetComponentProperties(AComponent: TComponent): string;
    procedure SetComponentProperties(AComponent: TComponent; Props: string);
    procedure AlignToGrid(TheControl: TControl);
    function EditControlLists(DefaultList: TListType): boolean;
    function AlignDialog: boolean;
    function SizeDialog: boolean;
    function TabOrderDialog: boolean;
    procedure ShowAlignmentPalette;
    procedure HideAlignmentPalette;
    procedure AlignControls(Hor, Ver: TAlignMode);
    procedure SizeControls(WMode: TSizeMode; WValue: integer; HMode: TSizeMode; HValue: integer);
    procedure Lock;
    procedure Unlock;
    procedure SynchroLock;
    procedure SynchroUnlock;
    procedure LeaveMouseAction;
    procedure AddControl(AControl: TControl);
    procedure DeleteControl(AControl: TControl);
    procedure AddComponent(AComponent: TComponent);
    procedure DeleteComponent(AComponent: TComponent);
    procedure SelectAll;
    procedure UnselectAll;
    procedure ClearControls;
    function ControlIndex(AControl: TControl): integer;
    procedure DrawGrab(Canvas: TCanvas; R: TRect; GrabType: TGrabType); virtual;
    procedure UpdateGrabs;
    function CreateComponentClass(AComponentClass: TComponentClass): TComponent;
    function CreateComponentClassName(AClassName: TComponentName): TComponent;
    function PlaceComponentClass(AComponentClass: TComponentClass): TComponent;
    function PlaceComponentClassName(AClassName: TComponentName): TComponent;
    procedure DrawEnvironment;
    procedure UpdateSubstProp;
    procedure ClearSubstProp;

    {$IFDEF FPC}
    procedure HandleMessage(var TheMessage : TLMessage);
    procedure UserInputEvent(Sender: TObject; Msg: Cardinal);
    {$ENDIF}

    procedure CancelPlacing;
    function GetComponentHint(AComponent: TComponent): string; virtual;
    function GetComponentCaption(AComponent: TComponent): string;

    procedure GetPropSubsLongint(AInstance: TPersistent; PropName: string; var Value: Longint);
    procedure SetPropSubsLongint(AInstance: TPersistent; PropName: string; var Value: Longint);

    property Modified: boolean read FModified write FModified;
    property ControlCount: integer read GetControlCount;
    property Locked: boolean read GetLocked;
    property SynchroLocked: boolean read GetSynchroLocked;
    property MouseAction: TMouseAction read FMouseAction;
    property Active: boolean read FActive write SetActive;
    property MessageProcessor: TMessageProcessor read FMessageProcessor write SetMessageProcessor default mpEvent;
    property Control: TControl read GetControl write SetControl;
    property Controls[Index: integer]: TControl read GetControlByIndex;
    property Component: TComponent read GetComponent write SetComponent;
    property Components[Index: integer]: TComponent read GetComponentByIndex;
    property ParentForm: TCustomForm read GetParentForm write SetParentForm;
    property AlignmentPaletteForm: TForm read FAPForm;
    property MenuControl: TControl read FMenuControl;
    property FormData: string read GetFormData write SetFormData;
    property ClearBeforeLoad: boolean read FClearBeforeLoad write FClearBeforeLoad default True;
    {$IFDEF TFD1COMPATIBLE}
    property FixedControls: TStrings read FLockedControls write SetLockedControls;
    property FixedInverse: Boolean read FLockedInverse write SetLockedInverse;
    property FixChildren: TChildrenMode read FLockChildren write SetLockChildren;
    {$ELSE}
    property LockedControls: TStrings read FLockedControls write SetLockedControls;
    property LockedInverse: boolean read FLockedInverse write SetLockedInverse default False;
    property LockChildren: TChildrenMode read FLockChildren write SetLockChildren default cmNone;
    {$ENDIF}
    property ProtectedControls: TStrings read FProtectedControls write SetProtectedControls;
    property ProtectedInverse: boolean read FProtectedInverse write SetProtectedInverse default False;
    property ProtectChildren: TChildrenMode read FProtectChildren write SetProtectChildren default cmNone;
    property ProtectMode: TProtectMode read FProtectMode write SetProtectMode default pmUnselect;
    property TransparentControls: TStrings read FTransparentControls write SetTransparentControls;
    property TransparentInverse: boolean read FTransparentInverse write SetTransparentInverse default False;
    property TransparentChildren: TChildrenMode read FTransparentChildren write SetTransparentChildren default cmNone;
    property PopupMenu: TPopupMenu read FPopupMenu write FPopupMenu default nil;
    {$IFDEF GFDADVANCEDGRID}
    property GridStepX: Integer read FGridStepX write SetGridStepX default 8;
    property GridStepY: Integer read FGridStepY write SetGridStepY default 8;
    {$ELSE}
    property GridStep: integer read FGridStep write SetGridStep default 8;
    {$ENDIF}
    property SnapToGrid: boolean read FSnapToGrid write FSnapToGrid default False;
    property SnapToGridKey: boolean read FSnapToGridKey write FSnapToGridKey default False;
    property DisplayGrid: boolean read FDisplayGrid write SetDisplayGrid default False;
    property DesignerColor: TColor read FDesignerColor write SetDesignerColor default clNone;
    property GridColor: TColor read FGridColor write SetGridColor default clNone;
    property ShowMoveSizeHint: boolean read FShowMoveSizeHint write SetMoveSizeHint default True;
    property ShowComponentHint: boolean read FShowComponentHint write SetComponentHint default False;
    property GrabSize: integer read FGrabSize write SetGrabSize default 5;
    property AlignmentPalette: TAlignmentPaletteOptions read FAlignmentPalette write SetAlignmentPalette default [apStayOnTop, apShowHints];
    property NormalGrabBorder: TColor read FNormalGrabBorder write SetNormalGrabBorder default clBlack;
    property NormalGrabFill: TColor read FNormalGrabFill write SetNormalGrabFill default clBlack;
    property NormalGrabGlyph: TBitmap read FNormalGrabGlyph write SetNormalGrabGlyph;
    property MultiGrabBorder: TColor read FMultiGrabBorder write SetMultiGrabBorder default clGray;
    property MultiGrabFill: TColor read FMultiGrabFill write SetMultiGrabFill default clGray;
    property MultiGrabGlyph: TBitmap read FMultiGrabGlyph write SetMultiGrabGlyph;
    property LockedGrabBorder: TColor read FLockedGrabBorder write SetLockedGrabBorder default clBlack;
    property LockedGrabFill: TColor read FLockedGrabFill write SetLockedGrabFill default clGray;
    property LockedGrabGlyph: TBitmap read FLockedGrabGlyph write SetLockedGrabGlyph;
    property KeySelect: boolean read FKeySelect write FKeySelect default True;
    property KeyMove: boolean read FKeyMove write FKeyMove default True;
    property ShowNonVisual: boolean read FShowNonVisual write SetShowNonVisual default True;
    property ShowComponentCaptions: boolean read FShowComponentCaptions write SetShowComponentCaptions default False;
    property MultiSelect: boolean read FMultiSelect write SetMultiSelect default True;
    property DesignControl: TWinControl read FDesignControl write SetDesignControl;
    property EnableAxisDrag: boolean read FEnableAxisDrag write FEnableAxisDrag default False;
    property DirectMove: boolean read FDirectMove write FDirectMove default False;
    property GrabMode: TGrabMode read FGrabMode write SetGrabMode default gmMiddle;
    property UseGrabGlyphs: boolean read FUseGrabGlyphs write SetUseGrabGlyphs default False;
    property GrabsTransparentColor: TColor read FGrabsTransparentColor write SetGrabsTransparentColor default clBlack;
    property AlignmentEntireForm: boolean read FAlignmentEntireForm write FAlignmentEntireForm default False;
    property AlignmentLines: TLinePositions read FAlignmentLines write FAlignmentLines default [];
    property AlignmentColorLeft: TColor read FAlignmentColorLeft write FAlignmentColorLeft default clGray;
    property AlignmentColorTop: TColor read FAlignmentColorTop write FAlignmentColorTop default clGray;
    property AlignmentColorRight: TColor read FAlignmentColorRight write FAlignmentColorRight default clGray;
    property AlignmentColorBottom: TColor read FAlignmentColorBottom write FAlignmentColorBottom default clGray;
    property AlignmentLineWidth: integer read FAlignmentLineWidth write FAlignmentLineWidth default 1;
    property MoveLimitMode: TMoveLimitMode read FMoveLimitMode write FMoveLimitMode default lmCursor;
    property Ancestor: TComponent read FAncestor write FAncestor;
    property SubstProp: TCollection read FSubstProp write FSubstProp;
  end;

  TFormDesigner = class(TCustomFormDesigner)
  published
    
    property ClearBeforeLoad;
    property MessageProcessor;
    {$IFDEF TFD1COMPATIBLE}
    property FixedControls;
    property FixedInverse;
    property FixChildren;
    {$ELSE}
    property LockedControls;
    property LockedInverse;
    property LockChildren;
    {$ENDIF}
    property ProtectedControls;
    property ProtectedInverse;
    property ProtectChildren;
    property ProtectMode;
    property TransparentControls;
    property TransparentInverse;
    property TransparentChildren;
    property PopupMenu;
    {$IFDEF GFDADVANCEDGRID}
    property GridStepX;
    property GridStepY;
    {$ELSE}
    property GridStep;
    {$ENDIF}
    property SnapToGrid;
    property SnapToGridKey;
    property DisplayGrid;
    property DesignerColor;
    property GridColor;
    property ShowMoveSizeHint;
    property ShowComponentHint;
    property GrabSize;
    property AlignmentPalette;
    property NormalGrabBorder;
    property NormalGrabFill;
    property NormalGrabGlyph;
    property MultiGrabBorder;
    property MultiGrabFill;
    property MultiGrabGlyph;
    property LockedGrabBorder;
    property LockedGrabFill;
    property LockedGrabGlyph;
    property KeySelect;
    property KeyMove;
    property ShowNonVisual;
    property ShowComponentCaptions;
    property MultiSelect;
    property DesignControl;
    property EnableAxisDrag;
    property DirectMove;
    property GrabMode;
    property UseGrabGlyphs;
    property GrabsTransparentColor;
    property AlignmentEntireForm;
    property AlignmentLines;
    property AlignmentColorLeft;
    property AlignmentColorTop;
    property AlignmentColorRight;
    property AlignmentColorBottom;
    property AlignmentLineWidth;
    property MoveLimitMode;
    {$IFDEF TFD1COMPATIBLE}
    property OnDragControl;
    {$ELSE}
    property OnMoveSizeControl;
    {$IFDEF GFDIDEVENTS}
    property OnMoveSizeControlID;
    {$ENDIF GFDIDEVENTS}
    {$ENDIF}
    property OnChange;
    property OnLoadControl;
    property OnSaveControl;
    property OnSelectControl;
    property OnSelectionChange;
    property OnAddControl;
    property OnDeleteControl;
    property OnControlDblClick;
    property OnActivate;
    property OnDeactivate;
    property OnKeyDown;
    property OnKeyUp;
    property OnMessage;
    property OnMoveLimit;
    property OnSizeLimit;
    property OnReadError;
    property OnCustomizeGrabs;
    property OnComponentHint;
    property OnComponentCaption;
    property OnComponentBitmap;
    property OnComponentEditable;
    property OnCopyComponent;
    property OnPasteComponent;
    property OnContextPopup;
    property OnEditBehaviour;
    property OnPlaceComponent;
    property OnEndPlacing;
    property OnEndSelecting;
    property OnShowAlignmentPalette;
    property OnValidateSelection;
  end;

  EFormDesigner = class(Exception);

function Designing: boolean;

implementation

{$IFDEF FDYESSTDICONS}
{$R STD.RES}
{$ENDIF}

{$BOOLEVAL OFF}
{$RANGECHECKS OFF}

{$IFDEF VER100}
{$DEFINE NOFRAMES}
{$DEFINE NOMOUSEWHEEL}
{$DEFINE NOREMOVENOTIFICATION}
{$ENDIF}
{$IFDEF VER110}
{$DEFINE NOFRAMES}
{$DEFINE NOMOUSEWHEEL}
{$DEFINE NOREMOVENOTIFICATION}
{$ENDIF}
{$IFDEF VER120}
{$DEFINE NOFRAMES}
{$DEFINE NOREMOVENOTIFICATION}
{$ENDIF}
{$IFDEF VER125}
{$DEFINE NOFRAMES}
{$DEFINE NOREMOVENOTIFICATION}
{$ENDIF}
{$IFDEF VER130}
{$DEFINE NOREMOVENOTIFICATION}
{$ENDIF}

{$IFNDEF VER150}
{$DEFINE NOCSSUBCOMPONENT}
{$ENDIF}

{$IFDEF VER230}
{$DEFINE XE2PLUS}
{$ENDIF}
{$IFDEF VER240}
{$DEFINE XE2PLUS}
{$ENDIF}
{$IFDEF VER250}
{$DEFINE XE2PLUS}
{$ENDIF}
{$IFDEF VER260}
{$DEFINE XE2PLUS}
{$ENDIF}

uses FDEditor, FDAlign, FDSize, FDTab, FDAlPal;

var
  {$IFNDEF FPC}
  SavedApplicationMessage: TMessageEvent = nil;
  {$ENDIF}
  SavedApplicationIdle: TIdleEvent = nil;
  Designers: TList;
  HookID: HHook = 0;
  {$IFNDEF GFDTEXTCLIPBOARD}
  CF_GS_DesignedObjects: word;
  {$ENDIF}
const
  WM_SECONDARYPAINT = WM_USER + 1000;
  WM_CONTEXTPOPUP = WM_USER + 1001;
  BufSize = 2048;
  {$IFDEF FPC}
  
  DCX_WINDOW = $1;
  DCX_CACHE = $2;
  DCX_PARENTCLIP = $20;
  DCX_CLIPSIBLINGS = $10;
  DCX_CLIPCHILDREN = $8;
  DCX_NORESETATTRS = $4;
  DCX_LOCKWINDOWUPDATE = $400;
  DCX_EXCLUDERGN = $40;
  DCX_INTERSECTRGN = $80;
  DCX_VALIDATE = $200000;
  DrCount : String = '';
  DrPrew : String = '';
  {$ENDIF}

  {$IFNDEF GFDTEXTCLIPBOARD}
  CF_GS_DESIGNEDOBJECTS_STR = 'CF_GS_DesignedObjects';
  {$ENDIF}

  {$IFNDEF FPC}
{$IFDEF VER240}
  function HookProc(Code,WParam,LParam: NativeUInt): LResult; stdcall;
  {$ELSE}

function HookProc(Code, WParam, LParam: integer): LResult; stdcall;
  {$ENDIF}
  {$ELSE}
  function HookProc(code: Integer; wparam: WPARAM; lparam: LPARAM): LResult; stdcall;
  {$ENDIF}
var
  i, ILockCounter: integer;
begin
  if Assigned(Designers) then
    for i := 0 to Pred(Designers.Count) do
      with TCustomFormDesigner(Designers[i]) do
      begin
        ILockCounter := FLockCounter;
        try
          MessageProc(PMsg(LParam)^);
        finally
          if FLockCounter > ILockCounter then FLockCounter := ILockCounter;
          {$IFNDEF GFDIGNOREUPCALL}
          if Locked then
            case PMsg(LParam)^.Message of
              WM_LBUTTONUP, WM_NCLBUTTONUP, WM_RBUTTONUP {$IFnDEF FPC}, WM_NCRBUTTONUP {$ENDIF}
                :
              begin
                Unlock;
                MessageProc(PMsg(LParam)^);
              end;
            end;
          {$ENDIF}
        end;
      end;
  Result := CallNextHookEx(HookID, Code, WParam, LParam);
end;

function GetGrabCursor(GP: TGrabPosition): TCursor;
begin
  case GP of
    gpLeftTop, gpRightBottom: Result := crSizeNWSE;
    gpLeftMiddle, gpRightMiddle: Result := crSizeWE;
    gpLeftBottom, gpRightTop: Result := crSizeNESW;
    gpMiddleTop, gpMiddleBottom: Result := crSizeNS;
    else Result := crArrow;
  end;
end;

function  IsDarkTheme :  boolean ;
  function  _Level ( C :  TColor ) :  double ;
  begin
    Result := Red ( C ) * 0.3  +  Green ( C ) * 0.59  +  Blue ( C ) * 0.11 ;
  end ;
begin
  Result :=  _Level ( ColorToRGB ( clWindow ))  <  _Level ( ColorToRGB ( clWindowText )) ;
end ;

function ScrollBarGetPosition(ScrollBox: TScrollBox; Kind: TScrollBarKind): Integer;
var
  ScrollInfo: TScrollInfo;
const
  IntfBarKind: array[TScrollBarKind] of Integer =
  (
    SB_HORZ,
    SB_VERT
  );
begin
  ScrollInfo.fMask := SIF_POS;
  GetScrollInfo(ScrollBox.Handle, IntfBarKind[Kind], ScrollInfo);
  Result := ScrollInfo.nPos;
end;

procedure TComponentContainer.Paint;
begin
  with Canvas do
  begin
    Brush.Color := clBtnFace;
    FillRect(ClientRect);
    Pen.Color := clBtnHighlight;
    MoveTo(0, Pred(Height));
    LineTo(0, 0);
    LineTo(Width, 0);
    Pen.Color := clBtnShadow;
    MoveTo(0, Pred(Height));
    LineTo(Pred(Width), Pred(Height));
    LineTo(Pred(Width), 0);
    Draw(2, 2, FBitmap);
  end;
end;

procedure TComponentContainer.WndProc(var Msg: TMessage);
begin
  with Msg do
    case Msg of
      WM_SIZE:
      begin
        Width := 28;
        Height := 28;
      end;
      WM_MOVE:
      begin
        inherited;
        if Assigned(FComponent) then
        begin
          FComponent.DesignInfo := Left + Top shl 16;
          UpdateContainer;
        end;
      end;
      else inherited;
    end;
end;

constructor TComponentContainer.Create(aOwner: TComponent);
begin
  inherited;
  FBitmap := TBitmap.Create;
  FCaption := TStaticText.Create(Self);
end;

constructor TComponentContainer.CreateWithComponent(AOwner, AComponent: TComponent;
  ADesigner: TCustomFormDesigner);
var
  hBmp: HBITMAP; 
begin
  Create(AOwner);
  FDesigner := ADesigner;
  FComponent := AComponent;
  with FBitmap do
  begin
    if Assigned(FDesigner) and Assigned(FDesigner.OnComponentBitmap) then
      FDesigner.OnComponentBitmap(FDesigner, FComponent, FBitmap)
    else
      hBmp := LoadBitmap(HInstance, PChar(AnsiUpperCase(AComponent.ClassName)));
    if hBmp = 0 then hBmp := LoadBitmap(HInstance, 'CONTAINER');
    Transparent := True;
  end;
  FBitmap.Handle := hBmp;
  Visible := Assigned(FComponent);
  Width := 28;
  Height := 28;
  ShowHint := True;
  with FComponent do
    if HandleAllocated then
      SetWindowPos(Handle, 0, LoWord(DesignInfo), HiWord(DesignInfo), 0, 0, SWP_NOSIZE or
        SWP_NOZORDER)
    else
    begin
      Left := LoWord(DesignInfo);
      Top := HiWord(DesignInfo);
    end;
  UpdateContainer;
  with FCaption do
  begin
    if Assigned(FDesigner) and FDesigner.ShowComponentCaptions then
      FCaption.Parent := AOwner as TWinControl;
    Alignment := taCenter;
  end;
  Parent := AOwner as TWinControl;
end;

destructor TComponentContainer.Destroy;
begin
  FBitmap.Free;
  inherited;
end;

procedure TComponentContainer.UpdateContainer;
begin
  with FCaption do
  begin
    if Assigned(FDesigner) then Caption := FDesigner.GetComponentCaption(FComponent)
    else Caption := '';
    Top := Self.Top + Self.Height + 2;
    Left := (Self.Left) + Self.Width div 2 - Width div 2;
  end;
end;

function TFDReader.Error(const Message: string): boolean;
begin
  Result := True;
  if Assigned(Designer) and Assigned(Designer.FOnReadError) then
    Designer.FOnReadError(Self, Message, Result);
end;

procedure TFDReader.SetName(Reader: TReader; Component: TComponent; var Name: string);

  procedure RenameComponent(AComponent: TComponent; var AName: string);
  var
    Index: integer;
  begin
    Index := 1;
    if Name <> '' then
    begin
      AName := Name;
      while Assigned(AComponent.Owner.FindComponent(AName)) do
      begin
        Inc(Index);
        AName := Copy(AComponent.ClassName, 2, Length(AComponent.ClassName)) + IntToStr(Index);
      end;
      
    end;
  end;

begin
  if Assigned(Component) and Assigned(Component.Owner) and Assigned(Designer) and Assigned(Designer.ParentForm) then
    RenameComponent(Component, Name);
end;

constructor TFDReader.Create(AStream: TStream; ADesigner: TCustomFormDesigner);
begin
  inherited Create(AStream, BufSize);
  OnSetName := SetName;
  Designer := ADesigner;
end;

constructor TLineSelect.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [];
  Visible := False;
end;

procedure TLineSelect.Paint;
begin
  inherited;
  with Canvas do
  begin
    with Pen do
    begin
      Width := 1;
      Style := psDot;
      if IsDarkTheme then
        Color := clMedGray
      else Color := clGray;
    end;

    with ClientRect do
      if (Height < Width) then
        Line(Left, Top, Right, Top)
      else Line(Left, Top, Left, Bottom);
  end;
end;

constructor TLineHandle.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [];
  Visible := False;
end;

procedure TLineHandle.Paint;
begin
  inherited;
  with Canvas do
  begin
    if IsDarkTheme then
      Pen.Color := clWhite
    else Pen.Color := clBlack;
    Brush.Color := Pen.Color;
    Rectangle(ClientRect);
  end;
end;

constructor TDragRectsItem.Create(Collection: TCollection);
  var I : Integer;
begin
  inherited;

  for I := 0 to High(FItems) do FItems[I] := TLineHandle.Create(Nil);
end;

destructor TDragRectsItem.Destroy;
  var I : Integer;
begin
  for I := 0 to High(FItems) do FItems[I].Free;
  inherited Destroy;
end;

procedure TDragRectsItem.SetVisible(Value : Boolean);
var I : Integer;
begin
  for I := 0 to High(FItems) do FItems[I].Visible := Value;
  FVisible := Value;
end;

function TDragRectsItem.GetTabOrder: TTabOrder;
begin
  Result := FItems[0].TabOrder;
end;

procedure TDragRectsItem.SetTabOrder(NewTabOrder: TTabOrder);
var I : Integer;
begin
  for I := 0 to High(FItems) do FItems[I].TabOrder := NewTabOrder;
end;

procedure TDragRectsItem.SetRectangle(AForm: TCustomForm; ARect : TRect; AThickness: Integer);
  var I : Integer;
begin
  for I := 0 to High(FItems) do FItems[I].Parent := AForm;

  FItems[0].Top :=  ARect.Top - AThickness;
  FItems[0].Left :=  ARect.Left;
  FItems[0].Height := AThickness;
  FItems[0].Width := ARect.Width;

  FItems[1].Top :=  ARect.Top - AThickness;
  FItems[1].Left := ARect.Left - AThickness;
  FItems[1].Height := ARect.Height + AThickness;
  FItems[1].Width := AThickness;

  FItems[2].Top :=  ARect.Top - AThickness;
  FItems[2].Left :=  ARect.Right;
  FItems[2].Height := ARect.Height + AThickness;
  FItems[2].Width := AThickness;

  FItems[3].Top :=  ARect.Bottom;
  FItems[3].Left :=  ARect.Left - AThickness;
  FItems[3].Height := AThickness;
  FItems[3].Width := ARect.Width + AThickness;

  for I := 0 to High(FItems) do
  begin
    FItems[I].BringToFront;
    FItems[I].Visible := True;
  end;
  FVisible := True;
end;

constructor TGrabSelect.Create(AOwner: TComponent);
begin
  inherited;
  ControlStyle := [];
  Visible := False;
end;

procedure TGrabSelect.Paint;
begin
  inherited;

  if Assigned(FGrabSelectItem) and Assigned(FGrabSelectItem.Collection.Owner) then
    TCustomFormDesigner(FGrabSelectItem.Collection.Owner).DrawGrab(Canvas, ClientRect, gtMulti);
end;

constructor TGrabSelectItem.Create(Collection: TCollection);
var I : Integer;
begin
  inherited;

  for I := 0 to High(FItems) do
  begin
    FItems[I] := TGrabSelect.Create(Nil);
    FItems[I].FGrabSelectItem := Self;
  end;
end;

destructor TGrabSelectItem.Destroy;
var I : Integer;
begin
  for I := 0 to High(FItems) do FItems[I].Free;

  inherited Destroy;
end;

procedure TGrabSelectItem.SetVisible(Value : Boolean);
var I : Integer;
begin
  for I := 0 to High(FItems) do FItems[I].Visible := Value;
  FVisible := Value;
end;

function TGrabSelectItem.GetTabOrder: TTabOrder;
begin
  Result := FItems[0].TabOrder;
end;

procedure TGrabSelectItem.SetTabOrder(NewTabOrder: TTabOrder);
var I : Integer;
begin
  for I := 0 to High(FItems) do FItems[I].TabOrder := NewTabOrder;
end;

procedure TGrabSelectItem.SetGrabGlyph(AForm: TCustomForm; FGrabGlyph: TBitmap; ARect : TRect; AGrabMode: TGrabMode; AGrabSize: Integer);
var I : Integer;
begin
  for I := 0 to High(FItems) do FItems[I].Parent := AForm;

  case AGrabMode of
    gmMiddle :  begin
                  FItems[0].Top :=  ARect.Top - AGrabSize div 2;
                  FItems[0].Left :=  ARect.Left - AGrabSize div 2;
                  FItems[1].Top :=  ARect.Top - AGrabSize div 2;
                  FItems[1].Left :=  ARect.Right - AGrabSize div 2;
                  FItems[2].Top :=  ARect.Bottom - AGrabSize div 2;
                  FItems[2].Left :=  ARect.Left - AGrabSize div 2;
                  FItems[3].Top :=  ARect.Bottom - AGrabSize div 2;
                  FItems[3].Left :=  ARect.Right - AGrabSize div 2;
                end;
    gmInside :  begin
                  FItems[0].Top :=  ARect.Top;
                  FItems[0].Left :=  ARect.Left;
                  FItems[1].Top :=  ARect.Top;
                  FItems[1].Left :=  ARect.Right - AGrabSize;
                  FItems[2].Top :=  ARect.Bottom - AGrabSize;
                  FItems[2].Left :=  ARect.Left;
                  FItems[3].Top :=  ARect.Bottom - AGrabSize;
                  FItems[3].Left :=  ARect.Right - AGrabSize;
                end;
    gmOutside : begin
                  FItems[0].Top :=  ARect.Top - AGrabSize;
                  FItems[0].Left :=  ARect.Left - AGrabSize;
                  FItems[1].Top :=  ARect.Top - AGrabSize;
                  FItems[1].Left :=  ARect.Right;
                  FItems[2].Top :=  ARect.Bottom;
                  FItems[2].Left :=  ARect.Left - AGrabSize;
                  FItems[3].Top :=  ARect.Bottom;
                  FItems[3].Left :=  ARect.Right;
                end;
  end;

  for I := 0 to High(FItems) do
  begin
    FItems[I].Height := AGrabSize;
    FItems[I].Width := AGrabSize;
    FItems[I].BringToFront;
    FItems[I].Visible := True;
  end;
  FVisible := True;
end;

constructor TGrabHandle.Create(AOwner: TComponent);
begin
  inherited;
  with (Owner as TGrabHandles).Designer do
  begin
    Width := FGrabSize;
    Height := FGrabSize;
  end;
  ControlStyle := ControlStyle + [csReplicatable];
  {$IFDEF FPC}
  
  {$ENDIF}
end;

procedure TGrabHandle.Paint;
var
  GrabRgn: HRGN;

  procedure CreateRegion;
  var
    X, Y: integer;
    RGN: HRGN;
    Vsbl: boolean;
  begin
    GrabRgn := CreateRectRgn(0, 0, 0, 0);
    with (Owner as TGrabHandles).Designer do
      for Y := 0 to Pred(FGrabSize) do
        for X := 0 to Pred(FGrabSize) do
        begin
          if FLocked then Vsbl := FLockedGrabGlyph.Canvas.Pixels[X, Y] <> FGrabsTransparentColor
          else Vsbl := FNormalGrabGlyph.Canvas.Pixels[X, Y] <> FGrabsTransparentColor;
          if Vsbl then
          begin
            RGN := CreateRectRgn(X, Y, Succ(X), Succ(Y));
            try
              CombineRgn(GrabRgn, GrabRgn, RGN, RGN_OR);
            finally
              DeleteObject(RGN);
            end;
          end;
        end;
    SetWindowRgn(Handle, GrabRgn, False);
  end;

  procedure DestroyRegion;
  begin
    SetWindowRgn(Handle, 0, False);
    DeleteObject(GrabRgn);
  end;

begin
  if Assigned(Parent) then
    with Canvas, (Owner as TGrabHandles).Designer do
    begin
      if FUseGrabGlyphs then
      begin
        Brush.Color := FNormalGrabFill;
        Brush.Style := bsSolid;
        CreateRegion;
        try
          if FLocked then
            if not FLockedGrabGlyph.Empty then Draw(0, 0, FLockedGrabGlyph)
            else
              FillRect(ClientRect)
          else
          if not FNormalGrabGlyph.Empty then Draw(0, 0, FNormalGrabGlyph)
          else
            FillRect(ClientRect)
        finally
          DestroyRegion;
        end;
      end
      else
      if FLocked then DrawGrab(Canvas, ClientRect, gtLocked)
      else DrawGrab(Canvas, ClientRect, gtNormal);
    end;
end;

procedure TGrabHandle.WndProc(var Msg: TMessage);
begin
  inherited;
  if not FLocked then
    case Msg.Msg of
      CM_MOUSEENTER: Screen.Cursor := crDefault;
      CM_MOUSELEAVE: SetArrowCursor;
    end;
end;

procedure TGrabHandle.SetPosition(Value: TGrabPosition);
begin
  if Value <> FPosition then
  begin
    FPosition := Value;
    Cursor := GetGrabCursor(FPosition);
    UpdateCoords;
  end;
end;

procedure TGrabHandle.SetRect(Value: TRect);
begin
  FRect := Value;
  UpdateCoords;
end;

procedure TGrabHandle.SetLocked(Value: boolean);
begin
  if Value <> FLocked then
  begin
    FLocked := Value;
    if Visible then Invalidate;
  end;
end;

procedure TGrabHandle.UpdateCoords;
var
  ALeft, ATop: integer;
begin
  if Assigned(Parent) then
    with (Owner as TGrabHandles).Designer do
    begin
      case FGrabMode of
        gmInside:
        begin
          case FPosition of
            gpLeftTop, gpLeftMiddle, gpLeftBottom: ALeft := FRect.Left;
            gpMiddleTop, gpMiddleBottom: ALeft := (FRect.Left + FRect.Right - FGrabSize) div 2;
            gpRightTop, gpRightMiddle, gpRightBottom: ALeft := Pred(FRect.Right - FGrabSize);
            else
              ALeft := 0;
          end;
          case FPosition of
            gpLeftTop, gpMiddleTop, gpRightTop: ATop := FRect.Top;
            gpLeftMiddle, gpRightMiddle: ATop := (FRect.Top + FRect.Bottom - FGrabSize) div 2;
            gpLeftBottom, gpMiddleBottom, gpRightBottom: ATop :=
                Pred(FRect.Bottom - FGrabSize);
            else
              ATop := 0;
          end;
        end;
        gmOutside:
        begin
          case FPosition of
            gpLeftTop, gpLeftMiddle, gpLeftBottom: ALeft := FRect.Left - FGrabSize;
            gpMiddleTop, gpMiddleBottom: ALeft := (FRect.Left + FRect.Right - FGrabSize) div 2;
            gpRightTop, gpRightMiddle, gpRightBottom: ALeft := Pred(FRect.Right);
            else
              ALeft := 0;
          end;
          case FPosition of
            gpLeftTop, gpMiddleTop, gpRightTop: ATop := FRect.Top - FGrabSize;
            gpLeftMiddle, gpRightMiddle: ATop := (FRect.Top + FRect.Bottom - FGrabSize) div 2;
            gpLeftBottom, gpMiddleBottom, gpRightBottom: ATop := Pred(FRect.Bottom);
            else
              ATop := 0;
          end;
        end;
        else
          case FPosition of
            gpLeftTop, gpLeftMiddle, gpLeftBottom: ALeft := FRect.Left - FGrabSize div 2;
            gpMiddleTop, gpMiddleBottom: ALeft := (FRect.Left + FRect.Right - FGrabSize) div 2;
            gpRightTop, gpRightMiddle, gpRightBottom: ALeft :=
                Pred(FRect.Right - FGrabSize div 2);
            else
              ALeft := 0;
          end;
          case FPosition of
            gpLeftTop, gpMiddleTop, gpRightTop: ATop := FRect.Top - FGrabSize div 2;
            gpLeftMiddle, gpRightMiddle: ATop := (FRect.Top + FRect.Bottom - FGrabSize) div 2;
            gpLeftBottom, gpMiddleBottom, gpRightBottom: ATop :=
                Pred(FRect.Bottom - FGrabSize div 2);
            else
              ATop := 0;
          end;
      end;
      
      Left := ALeft;
      Top := ATop;
      Width := FGrabSize;
      Height := FGrabSize;
    end;
end;

procedure TGrabHandle.SetArrowCursor;
begin
  {$IFNDEF STDCURSORS}
  Screen.Cursor := crArrow;
  {$ELSE}
  Screen.Cursor:=crDefault;
  {$ENDIF}
end;

procedure TGrabHandles.SetControl(Value: TControl);
begin
  if FControl <> Value then
  begin
    FControl := Value;
    if Assigned(FControl) and not (csDestroying in FControl.ComponentState) and
      FEnabled then
      Update(False)
    else
    begin
      FEnabled := False;
      Update(True);
    end;

  end;
end;

procedure TGrabHandles.SetVisible(Value: boolean);
var
  GP: TGrabPosition;
begin
  if Value <> FVisible then
  begin
    FVisible := Value;
    for GP := Succ(Low(GP)) to High(GP) do
      FItems[GP].Visible := FEnabled and FVisible;
  end;
end;

procedure TGrabHandles.SetEnabled(Value: boolean);
begin
  FEnabled := Value;
  Visible := FEnabled and FVisible;
end;

function TGrabHandles.GetParentForm: TCustomForm;
begin
  if Assigned(Designer) then Result := Designer.ParentForm
  else
    Result := nil;
end;

function TGrabHandles.GetDesigner: TCustomFormDesigner;
begin
  if Assigned(Owner) then Result := Owner as TCustomFormDesigner
  else
    Result := nil;
end;

constructor TGrabHandles.Create(AOwner: TComponent);
var
  GP: TGrabPosition;
begin
  inherited;
  for GP := Succ(Low(GP)) to High(GP) do
  begin
    FItems[GP] := TGrabHandle.Create(Self);
    with FItems[GP] do
    begin
      Position := GP;
      Visible := False;
      Parent := Designer.ParentForm;
    end;
  end;
  FEnabled := True;
end;

procedure TGrabHandles.Update(MustHide: boolean);
var
  GP: TGrabPosition;
  VisibleGrabs, EnabledGrabs: TGrabPositions;
  DR: TRect;
begin
  if Designer.Active then
  begin
    VisibleGrabs := [Low(TGrabPosition)..High(TGrabPosition)];
    EnabledGrabs := VisibleGrabs;
    if Assigned(Designer.FOnCustomizeGrabs) then
      Designer.FOnCustomizeGrabs(Designer, VisibleGrabs, EnabledGrabs);
    
    FVisible :=
      FEnabled and Assigned(FControl) and
      
      not Designer.IsProtected(FControl) and (Designer.ControlCount <= 1);
    for GP := Succ(Low(GP)) to High(GP) do
      if Assigned(FItems[GP]) then
        with FItems[GP] do
          if Assigned(FControl) then
          begin
            if MustHide then Visible := False;
            
            Parent := Designer.ParentForm;
            if (FControl is TCustomGroupBox) or (FControl is TScrollBox) then
              DR := FControl.Parent.ClientToScreen(FControl.BoundsRect)
            else DR := FControl.ClientToScreen(FControl.ClientRect);

            DR.TopLeft := Parent.ScreenToClient(DR.TopLeft);
            DR.BottomRight := Parent.ScreenToClient(DR.BottomRight);
            
            Rect := DR;
            Locked := Designer.IsLocked(FControl);
            Visible := FVisible and (GP in VisibleGrabs);
            Enabled := GP in EnabledGrabs;
            if Visible then BringToFront;
            
          end
          else
          try
            Parent := Designer.ParentForm;
            Visible := False;
            Enabled := False;
          except
          end;
    
  end;
end;

procedure TGrabHandles.BringToFront;
var
  GP: TGrabPosition;
begin
  for GP := Succ(Low(GP)) to High(GP) do
    if Assigned(FItems[GP]) and FItems[GP].Visible then FItems[GP].BringToFront;
end;

function TGrabHandles.FindHandle(AHandle: HWND): TGrabPosition;
var
  GP: TGrabPosition;
begin
  Result := gpNone;
  for GP := Succ(Low(GP)) to High(GP) do
    if Assigned(FItems[GP]) and (FItems[GP].HandleAllocated) and
      (FItems[GP].Handle = AHandle) then
    begin
      Result := GP;
      Break;
    end;
end;

function TGrabHandles.FindHandleControl(AHandle: HWND): TGrabHandle;
var
  GP: TGrabPosition;
begin
  GP := FindHandle(AHandle);
  if GP <> gpNone then Result := FItems[GP]
  else
    Result := nil;
end;

function TGrabHandles.IsGrabHandle(AControl: TControl): boolean;
var
  GP: TGrabPosition;
begin
  Result := False;
  for GP := Succ(Low(GP)) to High(GP) do
    if FItems[GP] = AControl then
    begin
      Result := True;
      Break;
    end;
end;

{$IFDEF FPC}

procedure TDesignForm.ProxyWndProc(var TheMessage: TLMessage);
begin
  
  if Assigned(FWndProc) then
     FWndProc(TheMessage)  else
     WndProcDef(TheMessage);
end;

procedure TDesignForm.WndProcDef(var TheMessage: TLMessage);
begin
  if not (FInPaint and (TheMessage.msg = WM_ERASEBKGND)) then
    FOrigin(TheMessage);
end;

procedure TDesignForm.FormChangeBounds(Sender: TObject);
var
  TheMessage: TLMessage;
begin
  if FCBInited then  exit;

  TheMessage.msg:=WM_NCLBUTTONDOWN;
  TheMessage.wParam:=HTCAPTION;
  if Assigned(FWndProc) then
     FWndProc(TheMessage);

  FCBInited := true;
end;

constructor TDesignForm.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FDesigner := Nil;
  FOrigin := WindowProc;
  WindowProc := ProxyWndProc;
  OnChangeBounds := FormChangeBounds;
end;

{$ENDIF}

constructor TCustomFormDesigner.Create(AOwner: TComponent);
var i: Integer;
begin
  inherited Create(AOwner);
  FLockedControls := TStringList.Create;
  TStringList(FLockedControls).OnChange := ListChange;
  FProtectedControls := TStringList.Create;
  TStringList(FProtectedControls).OnChange := ListChange;
  FTransparentControls := TStringList.Create;
  FControls := TList.Create;
  FAlignmentPalette := [apStayOnTop, apShowHints];
  FAlignmentLineWidth := 1;
  FGrabSize := 5;
  FClearBeforeLoad := True;

  if not Assigned(FForm) and Assigned(Owner) and (Owner is TCustomForm) then
  begin
    OnPaintOld:=TCustomForm(Owner).OnPaint;
    OnDestroyOld:=TCustomForm(Owner).OnDestroy;
    TCustomForm(Owner).OnPaint:=ParentFormPaint;
    TCustomForm(Owner).OnDestroy:=ParentFormDestroy();
  end;
  Application.AddOnKeyDownBeforeHandler(KeyEventDown);

  if IsDarkTheme then
  begin
    FNormalGrabBorder := clWhite;
    FNormalGrabFill := clWhite;
    FMultiGrabBorder := clMedGray;
    FMultiGrabFill := clMedGray;
    FLockedGrabBorder := clWhite;
    FLockedGrabFill := clMedGray;
  end else
  begin
    FNormalGrabBorder := clBlack;
    FNormalGrabFill := clBlack;
    FMultiGrabBorder := clGray;
    FMultiGrabFill := clGray;
    FLockedGrabBorder := clBlack;
    FLockedGrabFill := clGray;
  end;

  {$IFDEF GFDADVANCEDGRID}
  FGridStepX:=8;
  FGridStepY:=8;
  {$ELSE}
  FGridStep := 8;
  {$ENDIF}
  FDesignerColor := clNone;
  FGridColor := clNone;
  FShowMoveSizeHint := True;
  FKeySelect := True;
  FKeyMove := True;
  {$IFDEF TFDTRIAL}
  if not (csDesigning in ComponentState) then
    MessageBox(
      0,
      'Currently you are using a trial version of Greatis Form Designer with some functional limitations.'#13+
      'To obtain a fully-functional component please visit http://www.greatis.com/formdesbuy.htm',
      'Greatis Form Designer - Trial Version',
      MB_OK or MB_ICONEXCLAMATION);
  {$ENDIF}
  FShowNonVisual := True;
  FShowComponentCaptions := False;
  FMultiSelect := True;
  FAlignmentColorLeft := clGray;
  FAlignmentColorTop := clGray;
  FAlignmentColorRight := clGray;
  FAlignmentColorBottom := clGray;
  {$IFDEF UNIX}
  FMouseTimer := TTimer.Create(nil);
  FMouseTimer.Enabled:= False;
  FMouseTimer.OnTimer:= OnMouseTimer;
  FMouseTimer.Interval:=100;
  {$ENDIF}
  FDragRects := TCollection.Create(TDragRectsItem);
  FGrabSelects := TOwnedCollection.Create(Self, TGrabSelectItem);
  FSubstProp := TCollection.Create(TSubstPropItem);
  for i := 0 to High(FPlacingRectArray) do FPlacingRectArray[i] := TLineHandle.Create(Nil);
  for i := 0 to High(FSelectRectArray) do FSelectRectArray[i] := TLineSelect.Create(Nil);

  CreateObjects;
  UpdateGrid;
end;

destructor TCustomFormDesigner.Destroy;
var i: Integer;
begin
  if Assigned(ParentForm) then
  begin
    ParentForm.OnDestroy := OnDestroyOld;
    ParentForm.OnPaint := OnPaintOld;
  end;
  if not (csDesigning in ComponentState) then Active := False;
  Application.RemoveOnKeyDownBeforeHandler(KeyEventDown);
  DestroyObjects;
  FLockedControls.Free;
  FTransparentControls.Free;
  FProtectedControls.Free;
  FControls.Free;
  {$IFDEF UNIX}
  FMouseTimer.Free;
  {$ENDIF}
  FDragRects.Free;
  FGrabSelects.Free;
  FSubstProp.Free;
  for I := 0 to High(FPlacingRectArray) do FPlacingRectArray[I].Free;
  for I := 0 to High(FSelectRectArray) do FSelectRectArray[I].Free;
  FControls := nil;
  inherited;
end;

procedure TCustomFormDesigner.CreateObjects;
begin
  if not (csDesigning in Self.ComponentState) then
    FAPForm := TfrmAlignmentPalette.Create(Self);
  FLockedGrab := TBitmap.Create;
  FLockedGrabGlyph := TBitmap.Create;
  FMultiGrab := TBitmap.Create;
  FMultiGrabGlyph := TBitmap.Create;
  FNormalGrab := TBitmap.Create;
  FNormalGrabGlyph := TBitmap.Create;
  if not (csDesigning in Self.ComponentState) then
  begin
    FHintWindow := THintWindow.Create(Self);
    FHintWindow.Color := clInfoBk;
  end;
  
  FHintTimer := TTimer.Create(Self);
  FHintTimer.Enabled := False;
  FHintTimer.OnTimer := TimerEvent;
  FBkgBitmap := TBitmap.Create;
  UpdateGrid;
end;

procedure TCustomFormDesigner.DestroyObjects;

  procedure FreeAndNil(var Obj: TObject);
  begin
    if Assigned(Obj) then Obj.Free;
    Obj := nil;
  end;

begin
  FreeAndNil(TObject(FHintWindow));
  
  FreeAndNil(TObject(FLockedGrab));
  FreeAndNil(TObject(FLockedGrabGlyph));
  FreeAndNil(TObject(FMultiGrab));
  FreeAndNil(TObject(FMultiGrabGlyph));
  FreeAndNil(TObject(FNormalGrab));
  FreeAndNil(TObject(FNormalGrabGlyph));
  FreeAndNil(TObject(FBkgBitmap));
end;

procedure TCustomFormDesigner.Update;
var
  i: integer;
begin
  UpdateGrabs;
  UpdateContainers;
  
end;

function TCustomFormDesigner.IsLocked(AControl: TControl): boolean;
begin
  if ValidControl(AControl) then
    if AControl = ParentForm then Result := True
    else
      case GetEditBehaviour(AControl) of
        ebDefault, ebDefaultRuntime:
        begin
          case FLockChildren of
            cmNormal: Result := InTheList(FLockedControls, AControl) or
                InTheList(FLockedControls, AControl.Parent);
            cmRecurse:
              repeat
                Result := InTheList(FLockedControls, AControl);
                if Result then Break
                else
                if ValidControl(AControl) then AControl := AControl.Parent
                else
                  AControl := nil;
              until (AControl = nil) or (AControl = ParentForm);
            else
              Result := InTheList(FLockedControls, AControl);
          end;
          Result := Result xor FLockedInverse;
        end;
        ebLocked, ebLockedRuntime: Result := True;
        else
          Result := False;
      end
  else
    Result := False;
end;

function TCustomFormDesigner.IsProtected(AControl: TControl): boolean;

  function IsTopLevel(AControl: TControl): boolean;
  var
    i: integer;
  begin
    Result := False;
    if Assigned(AControl) then
      with ParentForm do
        for i := 0 to Pred(ComponentCount) do
          if Components[i] = AControl then
          begin
            Result := True;
            Exit;
          end;
  end;

  function FindTopLevel(AControl: TControl): TControl;
  begin
    Result := nil;
    while Assigned(AControl) do
    begin
      if IsTopLevel(AControl) then
      begin
        Result := AControl;
        Exit;
      end;
      AControl := AControl.Parent;
    end;
  end;

begin
  if ValidControl(AControl) then
    case GetEditBehaviour(AControl) of
      ebDefault, ebDefaultRuntime:
      begin
        if Assigned(FDesignControl) then
        begin
          Result := True;
          while Assigned(AControl.Parent) do
          begin
            AControl := AControl.Parent;
            if AControl = FDesignControl then
            begin
              Result := False;
              Exit;
            end;
          end;
        end
        else
        begin
          AControl := FindTopLevel(AControl);
          if not Assigned(AControl) or (AControl = ParentForm) then Result := True
          else
          begin
            case FProtectChildren of
              cmNormal: Result := InTheList(FProtectedControls, AControl) or
                  InTheList(FProtectedControls, AControl.Parent);
              cmRecurse:
                repeat
                  Result := InTheList(FProtectedControls, AControl);
                  if Result then Break
                  else
                  if ValidControl(AControl) then AControl := AControl.Parent
                  else
                    AControl := nil;
                until (AControl = nil) or (AControl = ParentForm);
              else
                Result := InTheList(FProtectedControls, AControl);
            end;
            Result := Result xor FProtectedInverse;
          end;
        end;
      end;
      ebProtected: Result := True;
      else
        Result := False;
    end
  else
    Result := False;
end;

function TCustomFormDesigner.IsTransparent(AControl: TControl): boolean;
begin
  if ValidControl(AControl) then
    case GetEditBehaviour(AControl) of
      ebDefault, ebDefaultRuntime:
        if AControl = ParentForm then Result := True
        else
        begin
          case FTransparentChildren of
            cmNormal: Result := InTheList(FTransparentControls, AControl) or
                InTheList(FTransparentControls, AControl.Parent);
            cmRecurse:
              repeat
                Result := InTheList(FTransparentControls, AControl);
                if Result then Break
                else
                if ValidControl(AControl) then AControl := AControl.Parent
                else
                  AControl := nil;
              until (AControl = nil) or (AControl = ParentForm);
            else
              Result := InTheList(FTransparentControls, AControl);
          end;
          Result := Result xor FTransparentInverse;
        end;
      ebTransparent, ebTransparentRuntime: Result := True;
      else
        Result := False;
    end
  else
    Result := False;
end;

function TCustomFormDesigner.GetControlCount: integer;
begin
  if Assigned(FControls) then Result := FControls.Count
  else
    Result := 0;
end;

function TCustomFormDesigner.GetLocked: boolean;
begin
  Result := FLockCounter > 0;
end;

function TCustomFormDesigner.GetSynchroLocked: boolean;
begin
  Result := FSynchroLockCounter > 0;
end;

function TCustomFormDesigner.GetParentForm: TCustomForm;
begin
  if Assigned(FForm) then Result := FForm
  else
  if Assigned(Owner) and (Owner is TCustomForm) then Result := TCustomForm(Owner)
  else
    Result := nil;
end;

procedure TCustomFormDesigner.SetParentForm(const Value: TCustomForm);
begin
  if FForm <> Value then
  begin
    if not (csDesigning in ComponentState) then LeaveMouseAction;
    if Assigned(FDefaultProc) then
      SetWindowLong(ParentForm.Handle, GWL_WNDPROC, integer(FDefaultProc));
    if Assigned(FForm) then
    begin
      FForm.OnPaint:=OnPaintOld;
      {$IFNDEF NOREMOVENOTIFICATION}
      FForm.RemoveFreeNotification(Self);
      {$ENDIF}
      FForm.Invalidate;

    end;

    FForm := Value;

    if Assigned(FForm) then
    begin
      OnPaintOld:=FForm.OnPaint;
      FForm.OnPaint:=ParentFormPaint;
      OnDestroyOld:=FForm.OnDestroy;
      FForm.OnDestroy:=ParentFormDestroy;
      FForm.Invalidate;
      if Assigned(FForm) then FForm.FreeNotification(Self);
      if Assigned(FWinProc) then
        SetWindowLong(ParentForm.Handle, GWL_WNDPROC, integer(FWinProc));
    end;
  end;
end;

function TCustomFormDesigner.GetFormData: string;
var
  StringStream: TStringStream;
begin
  StringStream := TStringStream.Create('');
  try
    SaveToStream(StringStream, dfmText);
    Result := StringStream.DataString;
  finally
    StringStream.Free;
  end;
end;

procedure TCustomFormDesigner.SetFormData(const Value: string);
var
  StringStream: TStringStream;
begin
  StringStream := TStringStream.Create(Value);
  try
    LoadFromStream(StringStream, dfmText);
  finally
    StringStream.Free;
  end;
end;

type
  TDesignAccessComponent = class(TComponent)
  public
    procedure SetDesigningPublic(Value: boolean);
  end;

procedure TDesignAccessComponent.SetDesigningPublic(Value: boolean);
begin
  {$IFNDEF GFDNOCSDESIGNING}
  SetDesigning(Value);
  {$ENDIF}
end;

procedure TCustomFormDesigner.SetActive(Value: boolean);
var
  i: integer;

  function ParentFormOK: boolean;
  begin
    Result := Assigned(ParentForm) and ParentForm.HandleAllocated;
  end;

begin
  if Value <> FActive then
  begin
    if Value then
    begin
      if Assigned(Owner) then
        if Owner is TCustomForm then
        begin
          FGrabHandles := TGrabHandles.Create(Self);
          Control := nil;
          DoSelectionChange;
          UpdateGrabs;
          if Assigned(ParentForm) then ParentForm.ActiveControl := nil;
        end
        else
          raise EFormDesigner.Create('Owner of TFormDesigner must be TCustomForm descendant.')
      else
        raise EFormDesigner.Create('TFormDesigner has no parent window.');
      if Assigned(Designers) then
        with Designers do
          if IndexOf(Self) = -1 then Add(Self);
      if MessageProcessor = mpEvent then
      begin
        if Designers.Count = 1 then
        begin
          {$IFDEF FPC}
          Application.AddOnUserInputHandler(UserInputEvent);
          {$ELSE}
          if not Assigned(SavedApplicationMessage) then
            SavedApplicationMessage := Application.OnMessage;
          Application.OnMessage := ApplicationMessage;
          {$ENDIF}
        end;
      end
      {$IFDEF FPC}
;
      {$ELSE}
      else
      if HookID = 0 then
        {$IFDEF XE2PLUS}
        HookID:=SetWindowsHookEx(WH_GETMESSAGE,@HookProc,HInstance,GetCurrentThreadID);
        {$ELSE}
        HookID := SetWindowsHookEx(WH_GETMESSAGE, HookProc, HInstance, GetCurrentThreadID);
      {$ENDIF}
      {$ENDIF}
      if Assigned(Designers) and (Designers.Count = 1) then
      begin
        if not Assigned(SavedApplicationIdle) then
          SavedApplicationIdle := Application.OnIdle;
        Application.OnIdle := ApplicationIdle;
      end;
      if ParentFormOK then
        with ParentForm do
        begin
          {$IFNDEF GFDENABLEAUTORANGE}
          DisableAutoRange;
          {$ENDIF}
          FDefaultColor := Color;
          Invalidate;
        end;
      Update;
      CreateContainers;
      if apAutoShow in FAlignmentPalette then ShowAlignmentPalette;
    end
    else
    begin
      CancelPlacing;
      Designers.Remove(Self);
      Application.OnIdle := SavedApplicationIdle;
      if MessageProcessor = mpEvent then
      begin
        {$IFNDEF FPC}
        if Designers.Count = 0 then Application.OnMessage := SavedApplicationMessage;
        {$ENDIF}
      end
      else
      if not Assigned(Designers) or (Designers.Count = 0) then
      begin
        {$IFNDEF FPC}
        UnhookWindowsHookEx(HookID);
        {$ENDIF}
        HookID := 0;
      end;
      if not (csDestroying in ComponentState) then
      begin
        if Assigned(FAPForm) then FAPForm.Hide;
        LeaveMouseAction;
        if ParentFormOK then ParentForm.Color := FDefaultColor;
        Control := nil;
        DoSelectionChange;
        if Assigned(FGrabHandles) then
        begin
          FGrabHandles.Free;
          FGrabHandles := nil;
        end;
        DestroyContainers;
      end;
      if ParentFormOK then
        with ParentForm do
        begin
          {$IFNDEF GFDENABLEAUTORANGE}
          EnableAutoRange;
          {$ENDIF}
          Color := FDefaultColor;
          Invalidate;
        end;
    end;
    FActive := Value;
    if ParentFormOK then
      with ParentForm do
      begin
        for i := 0 to Pred(ComponentCount) do
          if (Components[i] is TControl) then
          begin
            if not (GetEditBehaviour(TControl(Components[i])) in
              [ebDefaultRuntime, ebTransparentRuntime, ebLockedRuntime]) and
              not IsProtected(TControl(Components[i])) then
              TDesignAccessComponent(Components[i]).SetDesigningPublic(FActive);
            if (Components[i] is TWinControl) then
            begin
              if not HandleAllocated then HandleNeeded;
              with TWinControl(Components[i]) do
                if FActive then
                begin
                  {$IFNDEF GFDHIDEINVISIBLE}
                  if csDesigning in ComponentState then
                    ShowWindow(Handle, SW_SHOW);
                  {$ENDIF}
                  EnableWindow(Handle, True);
                end
                else
                begin
                  if not Visible then
                    ShowWindow(Handle, SW_HIDE);
                  EnableWindow(Handle, Enabled);
                end;
            end;
            Realign;
          end;
      end;
    {$IFDEF FPC}
 
    if FActive then
    begin
      if ParentFormOK and (ParentForm is TDesignForm) then
      begin
         TDesignForm(ParentForm).onWndProc := HandleMessage;
         TDesignForm(ParentForm).Designer := Self;
      end;
      FModified:=False;
    end
    else
    begin
      if ParentFormOK and (ParentForm is TDesignForm) then
      begin
         TDesignForm(ParentForm).onWndProc := nil;
         TDesignForm(ParentForm).Designer := nil;
      end;
    end;
    {$ELSE}
    if FActive then
    begin
      if ParentFormOK then
        FDefaultProc := TFarProc(GetWindowLong(ParentForm.Handle, GWL_WNDPROC));
      FWinProc := MakeObjectInstance(WinProc);
      SetWindowLong(ParentForm.Handle, GWL_WNDPROC, integer(FWinProc));
      FModified := False;
    end
    else
    begin
      if ParentFormOK and Assigned(FDefaultProc) then
        SetWindowLong(ParentForm.Handle, GWL_WNDPROC, integer(FDefaultProc));
      if Assigned(FWinProc) then FreeObjectInstance(FWinProc);
      FDefaultProc := nil;
      FWinProc := nil;
    end;
    {$ENDIF}
    Screen.Cursor := crDefault;
    if ParentFormOK then ParentForm.Invalidate;
    if FActive then
    begin
      if Assigned(FOnActivate) then FOnActivate(Self);
    end
    else
    begin
      if Assigned(FOnDeactivate) then FOnDeactivate(Self);
    end;
  end;
end;

procedure TCustomFormDesigner.SetMessageProcessor(Value: TMessageProcessor);
begin
  if FActive then EFormDesigner.Create(
      'Cannot change message processor when TFormDesigner is active')
  else
  if Value <> FMessageProcessor then FMessageProcessor := Value;
end;

{$IFDEF GFDADVANCEDGRID}

procedure TCustomFormDesigner.SetGridStepX(Value: Integer);
begin
  if Value<2 then Value:=2;
  if Value>128 then Value:=128;
  if Value<>FGridStepX then
  begin
    FGridStepX:=Value;
    UpdateGrid;
  end;
end;

procedure TCustomFormDesigner.SetGridStepY(Value: Integer);
begin
  if Value<2 then Value:=2;
  if Value>128 then Value:=128;
  if Value<>FGridStepY then
  begin
    FGridStepY:=Value;
    UpdateGrid;
  end;
end;

{$ELSE}

procedure TCustomFormDesigner.SetGridStep(Value: integer);
begin
  if Value < 2 then Value := 2;
  if Value > 128 then Value := 128;
  if Value <> FGridStep then
  begin
    FGridStep := Value;
    UpdateGrid;
  end;
end;

{$ENDIF}
procedure TCustomFormDesigner.SetDisplayGrid(Value: boolean);
begin
  if Value <> FDisplayGrid then
  begin
    FDisplayGrid := Value;
    if Assigned(ParentForm) then ParentForm.Invalidate;
  end;
end;

procedure TCustomFormDesigner.SetDesignerColor(Value: TColor);
begin
  if Value <> FDesignerColor then
  begin
    FDesignerColor := Value;
    UpdateGrid;
  end;
end;

procedure TCustomFormDesigner.SetGridColor(Value: TColor);
begin
  if Value <> FGridColor then
  begin
    FGridColor := Value;
    UpdateGrid;
  end;
end;

procedure TCustomFormDesigner.SetMoveSizeHint(Value: boolean);
begin
  if Value <> FShowMoveSizeHint then
  begin
    FShowMoveSizeHint := Value;
    if not FShowMoveSizeHint then HideHint;
  end;
end;

procedure TCustomFormDesigner.SetComponentHint(Value: boolean);
begin
  if Value <> FShowComponentHint then
  begin
    FShowComponentHint := Value;
    if not FShowComponentHint then HideHint;
  end;
end;

procedure TCustomFormDesigner.SetGrabSize(Value: integer);
begin
  if Value < 3 then Value := 3;
  if Value > 32 then Value := 32;
  if Value <> FGrabSize then
  begin
    FGrabSize := Value;
    UpdateGrabs;
  end;
end;

procedure TCustomFormDesigner.SetAlignmentPalette(Value: TAlignmentPaletteOptions);
begin
  FAlignmentPalette := Value;
  if Assigned(FAPForm) then
    with TfrmAlignmentPalette(FAPForm) do
    begin
      if apStayOnTop in FAlignmentPalette then FormStyle := fsStayOnTop
      else
        FormStyle := fsNormal;
      ShowHint := apShowHints in FAlignmentPalette;
      SetFlatButtons(apFlatButtons in FAlignmentPalette);
    end;
end;

procedure TCustomFormDesigner.SetNormalGrabBorder(Value: TColor);
begin
  if Value <> FNormalGrabBorder then
  begin
    FNormalGrabBorder := Value;
    UpdateGrabs;
  end;
end;

procedure TCustomFormDesigner.SetNormalGrabFill(Value: TColor);
begin
  if Value <> FNormalGrabFill then
  begin
    FNormalGrabFill := Value;
    UpdateGrabs;
  end;
end;

procedure TCustomFormDesigner.SetNormalGrabGlyph(Value: TBitmap);
begin
  FNormalGrabGlyph.Assign(Value);
end;

procedure TCustomFormDesigner.SetMultiGrabBorder(Value: TColor);
begin
  if Value <> FMultiGrabBorder then
  begin
    FMultiGrabBorder := Value;
    UpdateGrabs;
  end;
end;

procedure TCustomFormDesigner.SetMultiGrabFill(Value: TColor);
begin
  if Value <> FMultiGrabFill then
  begin
    FMultiGrabFill := Value;
    UpdateGrabs;
  end;
end;

procedure TCustomFormDesigner.SetMultiGrabGlyph(Value: TBitmap);
begin
  FMultiGrabGlyph.Assign(Value);
end;

procedure TCustomFormDesigner.SetLockedGrabBorder(Value: TColor);
begin
  if Value <> FLockedGrabBorder then
  begin
    FLockedGrabBorder := Value;
    UpdateGrabs;
  end;
end;

procedure TCustomFormDesigner.SetLockedGrabFill(Value: TColor);
begin
  if Value <> FLockedGrabFill then
  begin
    FLockedGrabFill := Value;
    UpdateGrabs;
  end;
end;

procedure TCustomFormDesigner.SetLockedGrabGlyph(Value: TBitmap);
begin
  FLockedGrabGlyph.Assign(Value);
end;

procedure TCustomFormDesigner.SetShowNonVisual(const Value: boolean);
begin
  if Value <> FShowNonVisual then
  begin
    FShowNonVisual := Value;
    if FShowNonVisual then CreateContainers
    else
      DestroyContainers;
  end;
end;

procedure TCustomFormDesigner.SetShowComponentCaptions(const Value: boolean);
begin
  if Value <> FShowComponentCaptions then
  begin
    FShowComponentCaptions := Value;
    if not (csDesigning in ComponentState) then
    begin
      DestroyContainers;
      if FShowNonVisual then CreateContainers;
    end;
  end;
end;

procedure TCustomFormDesigner.SetMultiSelect(const Value: boolean);
begin
  if Value <> FMultiSelect then
  begin
    FMultiSelect := Value;
    UnselectAll;
  end;
end;

procedure TCustomFormDesigner.SetDesignControl(const Value: TWinControl);
begin
  FDesignControl := Value;
  if Assigned(FDesignControl) and FActive then LeaveMouseAction;
end;

procedure TCustomFormDesigner.SetGrabMode(const Value: TGrabMode);
begin
  if Value <> FGrabMode then
  begin
    FGrabMode := Value;
    if Assigned(FGrabHandles) then FGrabHandles.Update(False);
  end;
end;

procedure TCustomFormDesigner.SetUseGrabGlyphs(const Value: boolean);
begin
  if FUseGrabGlyphs <> Value then
  begin
    FUseGrabGlyphs := Value;
    if Assigned(FGrabHandles) then UpdateGrabs;
  end;
end;

procedure TCustomFormDesigner.SetGrabsTransparentColor(const Value: TColor);
begin
  if FGrabsTransparentColor <> Value then
  begin
    FGrabsTransparentColor := Value;
    if Assigned(FGrabHandles) then UpdateGrabs;
  end;
end;

function TCustomFormDesigner.GetControl: TControl;
begin
  if Assigned(FControls) then
    with FControls do
      if Count > 0 then Result := FControls[0]
      else
        Result := nil
  else
    Result := nil;
end;

function TCustomFormDesigner.DoValidateSelection(AControl: TControl): boolean;
begin
  Result := True;
  if Assigned(FOnValidateSelection) then FOnValidateSelection(Self, AControl, Result);
end;

procedure TCustomFormDesigner.SetControl(Value: TControl);
begin
  {$IFDEF TFDTRIAL}
  if ValidControl(Value) and (Value.Parent<>ParentForm) then
  begin
    Control:=nil;
    DoSelectionChange;
    ShowTrialWarning;
    Exit;
  end;
  {$ENDIF}
  if Value = ParentForm then Value := nil;
  if DoValidateSelection(Value) then
    if (Value <> Control) and not IsTransparent(Value) and not IsProtected(Value) then
    begin
      with FControls do
        while Count > 0 do DeleteControl(Controls[0]);
      if FGrabHandles <> nil then FGrabHandles.Enabled := Assigned(Value)
      else
        FGrabHandles.Enabled := False;
      if Value <> ParentForm then AddControl(Value);
      if ValidControl(Control) and Assigned(ParentForm) then
        ParentForm.ActiveControl := nil;
      
      if not ValidControl(Control) then
      begin
        if Assigned(FOnSelectControl) then FOnSelectControl(Self, Control);
        
      end;
    end;
end;

function TCustomFormDesigner.GetControlByIndex(Index: integer): TControl;
begin
  with FControls do
    if (Index >= 0) and (Index < Count) then Result := FControls[Index]
    else
    begin
      Result := nil;
      EFormDesigner.Create('Index of Controls array is out or range.');
    end;
end;

function TCustomFormDesigner.GetComponent: TComponent;
begin
  Result := Control;
  if Result is TComponentContainer then Result := TComponentContainer(Result).Component;
end;

procedure TCustomFormDesigner.SetComponent(Value: TComponent);
begin
  if Value is TControl then Control := TControl(Value)
  else
    Control := FindComponentContainer(Value);
  DoSelectionChange;
end;

function TCustomFormDesigner.GetComponentByIndex(Index: integer): TComponent;
begin
  Result := Controls[Index];
  if Result is TComponentContainer then Result := TComponentContainer(Result).Component;
end;

procedure TCustomFormDesigner.SetLockedControls(Value: TStrings);
begin
  FLockedControls.Assign(Value);
  if FActive and IsLocked(Control) then
  begin
    Control := nil;
    DoSelectionChange;
  end;
end;

procedure TCustomFormDesigner.SetLockedInverse(Value: boolean);
begin
  if Value <> FLockedInverse then
  begin
    FLockedInverse := Value;
    if FActive and IsLocked(Control) then
    begin
      Control := nil;
      DoSelectionChange;
    end;
  end;
end;

procedure TCustomFormDesigner.SetLockChildren(Value: TChildrenMode);
begin
  if Value <> FLockChildren then
  begin
    FLockChildren := Value;
    if FActive and IsLocked(Control) then
    begin
      Control := nil;
      DoSelectionChange;
    end;
  end;
end;

procedure TCustomFormDesigner.SetProtectedControls(Value: TStrings);
begin
  FProtectedControls.Assign(Value);
  if FActive and IsProtected(Control) then
  begin
    Control := nil;
    DoSelectionChange;
  end;
end;

procedure TCustomFormDesigner.SetProtectedInverse(Value: boolean);
begin
  if Value <> FProtectedInverse then
  begin
    FProtectedInverse := Value;
    if FActive and IsProtected(Control) then
    begin
      Control := nil;
      DoSelectionChange;
    end;
  end;
end;

procedure TCustomFormDesigner.SetProtectChildren(Value: TChildrenMode);
begin
  if Value <> FProtectChildren then
  begin
    FProtectChildren := Value;
    if FActive and IsProtected(Control) then
    begin
      Control := nil;
      DoSelectionChange;
    end;
  end;
end;

procedure TCustomFormDesigner.SetProtectMode(Value: TProtectMode);
begin
  if Value <> FProtectMode then
  begin
    FProtectMode := Value;
    if FActive and (ProtectMode = pmUnselect) and Assigned(ParentForm) and
      (ParentForm.ActiveControl <> nil) then
    begin
      Control := nil;
      DoSelectionChange;
    end;
  end;
end;

procedure TCustomFormDesigner.SetTransparentControls(Value: TStrings);
begin
  FTransparentControls.Assign(Value);
  if FActive and IsTransparent(Control) then
  begin
    Control := nil;
    DoSelectionChange;
  end;
end;

procedure TCustomFormDesigner.SetTransparentInverse(Value: boolean);
begin
  if Value <> FTransparentInverse then
  begin
    FTransparentInverse := Value;
    if FActive and IsTransparent(Control) then
    begin
      Control := nil;
      DoSelectionChange;
    end;
  end;
end;

procedure TCustomFormDesigner.SetTransparentChildren(Value: TChildrenMode);
begin
  if Value <> FTransparentChildren then
  begin
    FTransparentChildren := Value;
    if FActive and IsTransparent(Control) then
    begin
      Control := nil;
      DoSelectionChange;
    end;
  end;
end;

procedure TCustomFormDesigner.DrawBackground;
var x, y: Integer;
begin
  if Assigned(ParentForm) then
  begin
    with ParentForm do
    begin
      if FActive and FDisplayGrid then
        with FBkgBitmap do
          for Y := 0 to ClientHeight div Height do
            for X := 0 to ClientWidth div Width do
              BitBlt(ParentForm.Canvas.Handle, X * Width, Y * Height,
                Width, Height, Canvas.Handle, 0, 0, SRCCOPY);

    end;
  end;
end;

function TCustomFormDesigner.InTheList(List: TStrings; AControl: TControl): boolean;
var
  AName: string;
  AComponent: TComponent;
begin
  if Assigned(List) and ValidControl(AControl) then
  begin
    if AControl is TComponentContainer then
      AName := TComponentContainer(AControl).Component.Name
    else
      AName := AControl.Name;
    Result := List.IndexOf(AName) <> -1;
    if not Result then
    begin
      AComponent := AControl.Owner;
      while not Result and Assigned(AComponent) do
      begin
        AName := AComponent.Name + '.' + AName;
        Result := List.IndexOf(AName) <> -1;
        AComponent := AComponent.Owner;
      end;
    end;
  end
  else
    Result := False;
end;

procedure TCustomFormDesigner.UpdateGrid;
var
  X, Y: integer;
  BkColor, DotColor: TColor;
begin
  if Assigned(FBkgBitmap) then
    with FBkgBitmap, FBkgBitmap.Canvas do
    begin
      if FDesignerColor = clNone then
        if Assigned(ParentForm) then BkColor := ParentForm.Color
        else
          BkColor := clBtnFace
      else
        BkColor := FDesignerColor;
      if FGridColor = clNone then
        if Assigned(ParentForm) then DotColor := ParentForm.Font.Color
        else
          DotColor := clBlack
      else
        DotColor := FGridColor;
      {$IFDEF GFDADVANCEDGRID}
      {$IFDEF GFDNOFASTGRID}
      Width:=FGridStepX;
      Height:=FGridStepY;
      {$ELSE}
      Width:=Screen.Width div FGridStepX*FGridStepX;
      Height:=Screen.Height div FGridStepY*FGridStepY;
      {$ENDIF}
      {$ELSE}
      {$IFDEF GFDNOFASTGRID}
      Width:=FGridStep;
      Height:=FGridStep;
      {$ELSE}
      {$IFNDEF FPC}
      Width := Screen.Width div FGridStep * FGridStep;
      Height := Screen.Height div FGridStep * FGridStep;
      {$ELSE}
        FBkgBitmap.Width  := Screen.Width div FGridStep*FGridStep;
        FBkgBitmap.Height := Screen.Height div FGridStep*FGridStep;
      {$ENDIF}
      {$ENDIF}
      {$ENDIF}
      Brush.Color := BkColor;
      FillRect(Rect(0, 0, Width, Height));
      {$IFDEF GFDADVANCEDGRID}
      for Y:=0 to Height div FGridStepY do
        for X:=0 to Width div FGridStepX do
          Pixels[X*FGridStepX,Y*FGridStepY]:=DotColor;
      {$ELSE}
      for Y := 0 to Height div FGridStep do
        for X := 0 to Width div FGridStep do
          Pixels[X * FGridStep, Y * FGridStep] := DotColor;
      {$ENDIF}
    end;
  if Assigned(ParentForm) then ParentForm.Invalidate;
end;

procedure TCustomFormDesigner.ShowHint(AHint: string; Mode: THintMode);
var
  R: TRect;
  P: TPoint;
  Offset: integer;
begin
  if Assigned(FHintWindow) then
    if ((FShowMoveSizeHint and (Mode <> hmCustom)) or
      (FShowComponentHint and (Mode = hmCustom))) and (AHint <> '') then
      with FHintWindow do
      begin
        HideHint;
        with Self.FControls do
          
          R := CalcHintRect(255, AHint, nil);
        GetCursorPos(P);
        case Mode of
          hmCustom: Offset := 24;
          hmMove: Offset := 18
          else
            Offset := 8;
        end;
        OffsetRect(R, P.X, P.Y + Offset);
        ActivateHint(R, AHint);
      end
    else
      HideHint;
end;

procedure TCustomFormDesigner.HideHint;
begin
  if Assigned(FHintWindow) then FHintWindow.ReleaseHandle;
end;

function TCustomFormDesigner.GetControlsOrigin: TPoint;
var
  i: integer;
begin
  case ControlCount of
    0: Result := Point(0, 0);
    1: with Control do Result := Point(Left, Top);
    else
    begin
      Result := Point(MaxInt, MaxInt);
      for i := 0 to Pred(ControlCount) do
        with Controls[i], Result do
        begin
          if Left < X then X := Left;
          if Top < Y then Y := Top;
        end;
    end;
  end;
end;

function TCustomFormDesigner.CheckParent(AControl: TControl;
  DisableLocked: boolean): boolean;
var
  i: integer;

  function IsControlLocked(AControl: TControl): boolean;
  begin
    Result := IsLocked(AControl) and DisableLocked;
  end;

begin
  Result := False;
  i := 0;
  while i < ControlCount do
    if (Controls[i].Parent <> AControl.Parent) or IsControlLocked(Controls[i]) then
    begin
      Result := IsControlLocked(Controls[i]);
      Controls[i].Invalidate;
      DeleteControl(Controls[i]);
    end
    else
      Inc(i);
  if ControlCount = 1 then Control.Invalidate;
end;

procedure TCustomFormDesigner.SetArrowCursor;
begin
  {$IFNDEF STDCURSORS}
  Screen.Cursor := crArrow;
  {$ELSE}
  Screen.Cursor:=crDefault;
  {$ENDIF}
end;

procedure TCustomFormDesigner.ClearForm;
var
  i: integer;
  OldActive: boolean;
begin
  OldActive := Active;
  Active := False;
  try
    i := 0;
    if Assigned(ParentForm) then
    begin
      with ParentForm do
        while i < ComponentCount do
          if Components[i] <> Self then Components[i].Free
          else
            Inc(i);
      if Assigned(ParentForm.Icon) then ParentForm.Icon.Clear;
    end;
  finally
    Active := OldActive;
  end;
end;

function TCustomFormDesigner.ValidControl(AControl: TControl): boolean;
begin
  try
    Result := Assigned(AControl) and (AControl.ClassInfo <> nil)
    ;
  except
    Result := False;
  end;
end;

procedure TCustomFormDesigner.ScrollBoxPos(AControl: TControl);
begin
  if Assigned(AControl) and Assigned(AControl.Parent) and (AControl.Parent is TScrollBox) then
  begin
    if (AControl.BoundsRect.Right - AControl.Parent.Width) > 0 then
      TScrollBox(AControl.Parent).HorzScrollBar.Position := AControl.BoundsRect.Right - AControl.Parent.Width;
    if TScrollBox(AControl.Parent).HorzScrollBar.Visible and
      ((AControl.BoundsRect.Right - (AControl.Parent.Width - TScrollBox(AControl.Parent).HorzScrollBar.Size)) > 0) then
      TScrollBox(AControl.Parent).HorzScrollBar.Position := ScrollBarGetPosition(TScrollBox(AControl.Parent), sbHorizontal) + TScrollBox(AControl.Parent).HorzScrollBar.Size;

    if (AControl.BoundsRect.Bottom - AControl.Parent.Height) > 0 then
      TScrollBox(AControl.Parent).VertScrollBar.Position := AControl.BoundsRect.Bottom - AControl.Parent.Height;
    if TScrollBox(AControl.Parent).VertScrollBar.Visible and
      ((AControl.BoundsRect.Bottom - (AControl.Parent.Height - TScrollBox(AControl.Parent).VertScrollBar.Size)) > 0) then
      TScrollBox(AControl.Parent).VertScrollBar.Position := ScrollBarGetPosition(TScrollBox(AControl.Parent), sbVertical) + TScrollBox(AControl.Parent).VertScrollBar.Size;

    if AControl.BoundsRect.Left < ScrollBarGetPosition(TScrollBox(AControl.Parent), sbHorizontal) then
      if AControl.BoundsRect.Left > 0 then
        TScrollBox(AControl.Parent).HorzScrollBar.Position := AControl.BoundsRect.Left
      else TScrollBox(AControl.Parent).HorzScrollBar.Position := 0;
    if AControl.BoundsRect.Top < ScrollBarGetPosition(TScrollBox(AControl.Parent), sbVertical) then
      if AControl.BoundsRect.Top > 0 then
        TScrollBox(AControl.Parent).VertScrollBar.Position := AControl.BoundsRect.Top
      else TScrollBox(AControl.Parent).VertScrollBar.Position := 0;
  end;
end;

procedure TCustomFormDesigner.CreateContainers;
var
  i: integer;
  Editable: boolean;
begin
  if not (csDesigning in ComponentState) then
    if FShowNonVisual then
      with ParentForm do
        for i := 0 to Pred(ComponentCount) do
          if not (Components[i] is TControl) and not
            (Components[i] is TMenuItem) and not (Components[i] is
            TCustomFormDesigner) and not
            Assigned(FindComponentContainer(Components[i])) then
          begin
            Editable := True;
            if Assigned(FOnComponentEditable) then
              FOnComponentEditable(Self, Components[i], Editable);    
    
            if Editable then
              TComponentContainer.CreateWithComponent(ParentForm, Components[i], Self);
          end;
end;

procedure TCustomFormDesigner.DestroyContainers;
var
  i: integer;
begin
  i := 0;
  with ParentForm do
    while i < ComponentCount do
      if Components[i] is TComponentContainer then Components[i].Free
      else
        Inc(i);
end;

procedure TCustomFormDesigner.UpdateContainers;
var
  i: integer;
begin
  with ParentForm do
    for i := 0 to Pred(ComponentCount) do
      if Components[i] is TComponentContainer then
        TComponentContainer(Components[i]).UpdateContainer;
end;

function TCustomFormDesigner.InParentForm(WND: HWND): boolean;
var
  i: integer;
begin
  with ParentForm do
  begin
    Result := WND = Handle;
    if not Result then
      for i := 0 to Pred(ComponentCount) do
        if (Components[i] is TWinControl) and TWinControl(
          Components[i]).HandleAllocated and (TWinControl(Components[i]).Handle = WND) then
        begin
          Result := True;
          Break;
        end;
  end;
end;

{$IFDEF TFDTRIAL}
procedure TCustomFormDesigner.ShowTrialWarning;
begin
  MessageBox(
    0,
    'In the trial version of this component you can select only the controls that are parented by a form, not by another control.',
    'Greatis Form Designer - Trial Version',
    MB_OK or MB_ICONEXCLAMATION);
end;
{$ENDIF}

procedure TCustomFormDesigner.ListChange(Sender: TObject);
begin
  if not (csDesigning in ComponentState) and Active then
  try
    Update;
  except
  end;
end;

procedure TCustomFormDesigner.WinProc(var Message: TMessage);
var
  X, Y: integer;
  GP: TGrabPosition;

  function CallDefault: integer;
  begin
    {$IFDEF FPC}
      if ParentForm is TDesignForm then TDesignForm(ParentForm).WndProcDef(Message);
    {$ELSE}
    with Message do
      CallDefault := CallWindowProc(FDefaultProc, ParentForm.Handle, Msg, wParam, lParam);
    {$ENDIF}
  end;

  function OnInactiveForm: boolean;
  var
    F: TControl;
  begin
    Result := True;
    F := ParentForm;
    while Assigned(F) do
    begin
      if F = Screen.ActiveForm then
      begin
        Result := False;
        Exit;
      end;
      F := F.Parent;
    end;
  end;

  function ParentedByForm: boolean;
  var
    C: TWinControl;
  begin
    C := ParentForm.Parent;
    Result := False;
    while Assigned(C) do
    begin
      if C is TCustomForm then
      begin
        Result := True;
        Break;
      end;
      C := C.Parent;
    end;
  end;

begin
  with Message do
    case Msg of
      
      WM_SIZE, WM_MOVE:
      begin
        Result := CallDefault;
        
        FModified := True;
      end;
      WM_ACTIVATE:
      begin
        if LoWord(wParam) = WA_INACTIVE then LeaveMouseAction
        else
        begin
          {$IFNDEF FPC}
          Result := MA_ACTIVATE;
          {$ENDIF}
          {$IFDEF GFDHIDEINVISIBLE}
          with ParentForm do
            for X:=0 to Pred(ComponentCount) do
              if (Components[X] is TWinControl) then
                with TWinControl(Components[X]) do
                  if not Visible and (csDesigning in ComponentState) then
                    ShowWindow(Handle,SW_HIDE);
          {$ENDIF}
        end;
      end;
      {$IFnDEF FPC}
      WM_MOUSEACTIVATE:
        if LoWord(lParam) = HTCAPTION then Result := MA_NOACTIVATE
        else
          Result := MA_ACTIVATE;
      {$ENDIF}
      CM_DEACTIVATE: LeaveMouseAction;
        {$IFDEF FPC}
      WM_NCLBUTTONDOWN: UserInputEvent(ParentForm, WM_NCLBUTTONDOWN);
        {$ENDIF}
      else
        Result := CallDefault
    end;
end;

procedure TCustomFormDesigner.Notification(AComponent: TComponent;
  Operation: TOperation);
var
  CC: TComponentContainer;
begin
  inherited;
  if not (csDesigning in ComponentState) then
  begin
    if FActive and (ComponentState = []) and (AComponent.Owner = ParentForm) and
      not (AComponent is TComponentContainer) then FModified := True;
    if Active and not (csLoading in ComponentState) and (Operation = opInsert) and
      (AComponent <> Self) and (AComponent is TComponent) and
      (AComponent.Owner = ParentForm) and not (AComponent is TComponentContainer) then
      CreateContainers;
    if not (csDestroying in ComponentState) and (Operation = opRemove) then
    begin
      
      StopTimer;
      if AComponent is TControl then
      begin
        if ControlIndex(TControl(AComponent)) <> -1 then
        begin
          DeleteControl(TControl(AComponent));
          DoSelectionChange;
        end;
      end
      else
      begin
        CC := FindComponentContainer(AComponent);
        if Assigned(CC) then
        begin
          DeleteControl(CC);
          DoSelectionChange;
          if Assigned(FGrabHandles) then FGrabHandles.Control := Control;
          CC.Free;
        end;
      end;
      Exit;
      if Assigned(FGrabHandles) and not (csDestroying in
        FGrabHandles.ComponentState) then
        FGrabHandles.Control := Control;
      if (ControlCount = 1) and (AComponent = Control.Parent) then
      begin
        Control := nil;
        LeaveMouseAction;
        DoSelectionChange;
      end;
      if AComponent = FPopupMenu then FPopupMenu := nil;
      if AComponent = FDesignControl then DesignControl := nil;
      if AComponent = ParentForm then ParentForm := nil;
    end;
  end;
end;

function TCustomFormDesigner.FindNextControl(GoForward: boolean): TControl;
var
  i, StartIndex: integer;
  CurControl: TControl;
  Found: boolean;
  List:{$IFDEF FPC}TFPList{$ELSE}TList{$ENDIF};

  function ParentsVisible(Control: TControl): boolean;
  var
    P: TWinControl;
  begin
    if ValidControl(Control) then
    begin
      Result := True;
      P := Control.Parent;
      while ValidControl(P) and (P <> ParentForm) do
      begin
        if not P.Visible then
        begin
          Result := False;
          Break;
        end;
        P := P.Parent;
      end;
    end
    else
      Result := False;
  end;

begin
  Result := nil;
  if Assigned(Control) then
  begin
    CurControl := Control;
    if Assigned(CurControl.Owner) then
      with CurControl.Owner do
      begin
        if ValidControl(CurControl) then
          if ComponentCount > 0 then
          begin
            Found := False;
            for StartIndex := 0 to Pred(ComponentCount) do
              if Components[StartIndex] = Control then
              begin
                Found := True;
                Break;
              end;
            if not Found then StartIndex := -1;
          end
          else
            StartIndex := -1
        else
          StartIndex := -1;

        if ComponentCount > 0 then
        begin
          if StartIndex = -1 then
            if GoForward then StartIndex := Pred(ComponentCount)
            else
              StartIndex := 0;
          i := StartIndex;
          repeat
            if GoForward then
            begin
              Inc(i);
              if i = ComponentCount then i := 0;
            end
            else
            begin
              if i = 0 then i := ComponentCount;
              Dec(i);
            end;
            if Components[i] is TControl then
            begin
              CurControl := TControl(Components[i]);
              if not (CurControl is TGrabHandle) and
                 ParentsVisible(CurControl) and
                not IsTransparent(CurControl) and not
                IsProtected(CurControl) and (CurControl <> Control) then
                Result := CurControl;
            end;
          until (Result <> nil) or (i = StartIndex);
        end;
      end;
  end
  else
  begin
    List := {$IFDEF FPC} TFPList{$ELSE} TList{$ENDIF}.Create;
    try
      ParentForm.GetTabOrderList(List);
      for i := 0 to Pred(List.Count) do
        if not Assigned(FGrabHandles) or
          (Assigned(FGrabHandles) and not FGrabHandles.IsGrabHandle(
          TControl(List[i]))) and not (TControl(List[i]) is TComponentContainer) then
            if TControl(List[i]).Owner = ParentForm then
            begin
              Result :=  TControl(List[i]);
              Break;
            end;
    finally
      List.Free;
    end;
  end;

end;

function TCustomFormDesigner.ControlAtMousePos(AParent: TWinControl;
  P: TPoint): TControl;
var
  i: integer;
  SR: TRect;
begin
  Result := nil;
  if AParent = nil then AParent := ParentForm;
  if Assigned(AParent) then
    with AParent do
      for i := 0 to Pred(ControlCount) do
        with Controls[i] do
        begin
          SR := BoundsRect;
          SR.TopLeft := ClientToScreen(SR.TopLeft);
          SR.BottomRight := ClientToScreen(SR.BottomRight);
          if PtInRect(SR, ClientToScreen(P)) then
          begin
            Result := Controls[i];
            Break;
          end;
        end;
end;

function TCustomFormDesigner.FindWinControl(Wnd: HWND): TWinControl;

  procedure FindInComponent(aWnd: HWND; Component: TComponent; var Control: TWinControl);
  var
    i: integer;
    fff: TWinControl;
  begin
    if Assigned(Component) and not Assigned(Control) then
      if (Component is TWinControl) then
      begin
        fff := TWinControl(Component);

        if fff.HandleAllocated and ValidControl(fff.Parent) and
          (fff.Handle = aWnd)
        {$IFNDEF NOCSSUBCOMPONENT}
            and not (csSubComponent in Component.ComponentStyle)
        {$ENDIF}
        then
          Control := fff
        else
          with Component do
            for i := Pred(ComponentCount) downto 0 do
              FindInComponent(Wnd, Components[i], Control);
      end;
  end;

begin
  Result := nil;
  FindInComponent(Wnd, ParentForm, Result);
end;

function TCustomFormDesigner.FindComponentContainer(AComponent: TComponent):
TComponentContainer;
var
  i: integer;
begin
  Result := nil;
  with ParentForm do
    for i := 0 to Pred(ComponentCount) do
      if (Components[i] is TComponentContainer) and
        (TComponentContainer(Components[i]).Component = AComponent) then
      begin
        Result := TComponentContainer(Components[i]);
        Break;
      end;
end;

procedure TCustomFormDesigner.SaveToFile(FileName: string);
var
  F: TIniFile;
  SL: TStringList;
  i: integer;

  procedure SaveControl(AControl: TControl);
  var
    i: integer;
  begin
    if (AControl <> ParentForm) and not (AControl is TGrabHandle) and
      (AControl.Name <> '') and ValidControl(AControl.Parent) then
    begin
      if Assigned(FOnSaveControl) then FOnSaveControl(Self, AControl, F);
      with F, AControl do
      begin
        WriteString(Name, 'Class', ClassName);
        WriteString(Name, 'Parent', Parent.Name);
        WriteInteger(Name, 'Left', Left);
        WriteInteger(Name, 'Top', Top);
        WriteInteger(Name, 'Width', Width);
        WriteInteger(Name, 'Height', Height);
      end;
      if AControl is TWinControl then
        with TWinControl(AControl) do
          for i := 0 to Pred(ControlCount) do SaveControl(Controls[i]);
    end;
  end;

begin
  F := TIniFile.Create(FileName);
  try
    SL := TStringList.Create;
    try
      F.ReadSections(SL);
      for i := 0 to Pred(SL.Count) do F.EraseSection(SL[i])
    finally
      SL.Free;
    end;
    if Assigned(FOnSaveControl) then FOnSaveControl(Self, ParentForm, F);
    if Assigned(ParentForm) then
      with ParentForm do
        for i := 0 to Pred(ControlCount) do SaveControl(Controls[i]);
  finally
    F.Free;
  end;
end;

procedure TCustomFormDesigner.LoadFromFile(FileName: string);
var
  F: TIniFile;
  i: integer;
  SL: TStringList;

  procedure LoadControl(AName: string);
  var
    PC: TPersistentClass;
    C: TComponent;
  begin
    with F do
    begin
      PC := GetClass(ReadString(AName, 'Class', ''));
      if Assigned(PC) then
      begin
        C := TComponentClass(PC).Create(ParentForm);
        if Assigned(C) and (C is TControl) then
        begin
          with TControl(C) do
          begin
            Name := AName;
            Left := ReadInteger(AName, 'Left', Left);
            Top := ReadInteger(AName, 'Top', Top);
            Width := ReadInteger(AName, 'Width', Width);
            Height := ReadInteger(AName, 'Height', Height);
          end;
        end;
      end;
    end;
  end;

  procedure SetParent(AName: string);
  var
    C, P: TComponent;
  begin
    if Assigned(ParentForm) then
    begin
      C := TControl(ParentForm.FindComponent(AName));
      if Assigned(C) and (C is TControl) then
      begin
        P := TWinControl(ParentForm.FindComponent(F.ReadString(AName, 'Parent', '')));
        if Assigned(P) and (P is TWinControl) then TControl(C).Parent := TWinControl(P)
        else
          TControl(C).Parent := ParentForm;
        if Assigned(FOnLoadControl) then FOnLoadControl(Self, TControl(C), F);
      end;
    end;
  end;

begin
  if Assigned(ParentForm) then
  begin
    with ParentForm do
    begin
      i := 0;
      while i < ComponentCount do
        if Components[i] is TControl then Components[i].Free
        else
          Inc(i);
    end;
    F := TIniFile.Create(FileName);
    try
      SL := TStringList.Create;
      try
        if Assigned(FOnLoadControl) then FOnLoadControl(Self, ParentForm, F);
        F.ReadSections(SL);
        for i := 0 to Pred(SL.Count) do LoadControl(SL[i]);
        for i := 0 to Pred(SL.Count) do SetParent(SL[i]);
      finally
        SL.Free;
      end;
    finally
      F.Free;
    end;
  end;
end;

procedure TCustomFormDesigner.SaveToDFM(FileName: string; DFMFormat: TDFMFormat);
var
  Form: TCustomForm;
  Stream: TFileStream;
  TxtStream, BinStream: TMemoryStream;
  OldOwner: TComponent;
begin
  if Assigned(ParentForm) then
  begin
    Control := nil;
    DoSelectionChange;
    DestroyContainers;
    ClearSubstProp;
    try
      Stream := TFileStream.Create(FileName, fmCreate);
      BinStream := TMemoryStream.Create;
      try
        with TWriter.Create(BinStream, BufSize) do
        try
          Form := ParentForm;
          if Form = Owner then
          begin
            OldOwner := Owner;
            Form.RemoveComponent(Self);
          end
          else
            OldOwner := nil;
          Form.ActiveControl := nil;
          try
            WriteDescendent(Form, FAncestor);
          finally
            if Assigned(OldOwner) then OldOwner.InsertComponent(Self);
          end;
        finally
          Free;
        end;
        BinStream.Seek(0, soFromBeginning);
        if DFMFormat = dfmText then ObjectBinaryToText(BinStream, Stream)
        else
        begin
          TxtStream := TMemoryStream.Create;
          try
            ObjectBinaryToText(BinStream, TxtStream);
            TxtStream.Seek(0, soFromBeginning);
            ObjectTextToResource(TxtStream, Stream);
          finally
            TxtStream.Free;
          end;
        end;
        {$IFDEF TFDSAVEITSELF}
        BinStream.Clear;
        with TWriter.Create(BinStream,BufSize) do
        try
          WriteRootComponent(Self);
        finally
          Free;
        end;
        BinStream.Seek(0,soFromBeginning);
        if DFMFormat=dfmText then ObjectBinaryToText(BinStream,Stream)
        else Stream.CopyFrom(BinStream,0);
        {$ENDIF}
      finally
        Stream.Free;
        BinStream.Free;
      end;
    finally
      if Active then CreateContainers;
      UpdateSubstProp;
    end;
  end;
end;

procedure TCustomFormDesigner.LoadFromDFM(FileName: string; DFMFormat: TDFMFormat);
var
  Stream: TFileStream;
  TxtStream, BinStream: TMemoryStream;
begin
  if Assigned(ParentForm) then
  begin
    DestroyContainers;
    try
      if FClearBeforeLoad or FMustClear then ClearForm;
      Stream := TFileStream.Create(FileName, fmOpenRead);
      BinStream := TMemoryStream.Create;
      try
        if DFMFormat = dfmText then ObjectTextToBinary(Stream, BinStream)
        else
        begin
          TxtStream := TMemoryStream.Create;
          try
            ObjectResourceToText(Stream, TxtStream);
            TxtStream.Seek(0, soFromBeginning);
            ObjectTextToBinary(TxtStream, BinStream);
          finally
            TxtStream.Free;
          end;
        end;
        BinStream.Seek(0, soFromBeginning);
        ParentForm.Name := '';
        with TFDReader.Create(BinStream, Self) do
        try
          ReadRootComponent(ParentForm);
          DoSelectionChange;
        finally
          Free;
        end;
        {$IFDEF TFDSAVEITSELF}
        if Stream.Position<Stream.Size then
        begin
          BinStream.Clear;
          if DFMFormat=dfmText then ObjectTextToBinary(Stream,BinStream)
          else BinStream.CopyFrom(Stream,Stream.Size-Stream.Position);
          BinStream.Seek(0,soFromBeginning);
          with TFDReader.Create(BinStream,Self) do
          try
            ReadRootComponent(Self);
          finally
            Free;
          end;
        end;
        {$ENDIF}
      finally
        Stream.Free;
        BinStream.Free;
      end;
    finally
      if Active then CreateContainers;
      UpdateSubstProp;
    end;
    ParentForm.Invalidate;
  end;
end;

procedure TCustomFormDesigner.SaveComponentToStream(Stream: TStream;
  Component: TComponent; DFMFormat: TDFMFormat);
var
  BinStream: TMemoryStream;
begin
  if Assigned(Component) then
  begin
    BinStream := TMemoryStream.Create;
    try
      with TWriter.Create(BinStream, BufSize) do
      try
        Root := ParentForm;
        WriteSignature;
        WriteComponent(Component);
      finally
        Free;
      end;
      BinStream.Seek(0, soFromBeginning);
      if DFMFormat = dfmText then ObjectBinaryToText(BinStream, Stream)
      else
        Stream.CopyFrom(BinStream, 0);
    finally
      BinStream.Free;
    end;
  end;
end;

function TCustomFormDesigner.LoadComponentFromStream(Stream: TStream;
  Component: TComponent; DFMFormat: TDFMFormat): TComponent;
var
  BinStream: TMemoryStream;
begin
  BinStream := TMemoryStream.Create;
  try
    if DFMFormat = dfmText then ObjectTextToBinary(Stream, BinStream)
    else
      BinStream.CopyFrom(Stream, 0);
    BinStream.Seek(0, soFromBeginning);
    with TFDReader.Create(BinStream, Self) do
    try
      BeginReferences;
      try
        Root := ParentForm;
        Owner := ParentForm;
        if Assigned(DesignControl) and (Component <> DesignControl) then
          Parent := DesignControl
        else
          Parent := ParentForm;
        ReadSignature;
        Result := ReadComponent(Component);
        FixupReferences;
      finally
        EndReferences;
      end;
    finally
      Free;
    end;
  finally
    BinStream.Free;
  end;
end;

procedure TCustomFormDesigner.SaveToStream(Stream: TStream; DFMFormat: TDFMFormat);
var
  Form: TCustomForm;
  BinStream: TMemoryStream;
begin
  if Assigned(ParentForm) then
  begin
    DestroyContainers;
    try
      BinStream := TMemoryStream.Create;
      try
        with TWriter.Create(BinStream, BufSize) do
        try
          Form := ParentForm;
          Form.RemoveComponent(Self);
          try
            
            WriteDescendent(Form, FAncestor);
          finally
            Form.InsertComponent(Self);
          end;
        finally
          Free;
        end;
        BinStream.Seek(0, soFromBeginning);
        if DFMFormat = dfmText then ObjectBinaryToText(BinStream, Stream)
        else
          Stream.CopyFrom(BinStream, 0);
      finally
        BinStream.Free;
      end;
    finally
      if Active then CreateContainers;
    end;
  end;
end;

procedure TCustomFormDesigner.LoadFromStream(Stream: TStream; DFMFormat: TDFMFormat);
var
  BinStream: TMemoryStream;
begin
  if Assigned(ParentForm) then
  begin
    DestroyContainers;
    try
      if FClearBeforeLoad or FMustClear then ClearForm;
      BinStream := TMemoryStream.Create;
      try
        if DFMFormat = dfmText then ObjectTextToBinary(Stream, BinStream)
        else
          BinStream.CopyFrom(Stream, 0);
        BinStream.Seek(0, soFromBeginning);
        with TFDReader.Create(BinStream, Self) do
        try
          ReadRootComponent(ParentForm);
        finally
          Free;
        end;
      finally
        BinStream.Free;
      end;
    finally
      if Active then CreateContainers;
    end;
  end;
end;

function TCustomFormDesigner.CanCopy: boolean;
begin
  Result := ControlCount > 0;
end;

{$IFDEF GFDTEXTCLIPBOARD}

function TCustomFormDesigner.CanPaste: Boolean;
begin
  Result:=Pos('object ',Clipboard.AsText)=1;
end;

procedure TCustomFormDesigner.CopyToClipboard;
var
  i: Integer;
  BinStream: TMemoryStream;
  StringStream: TStringStream;
  ComponentList: TList;
begin
  CheckParent(Control,False);
  if (Assigned(ParentForm)) and (ControlCount>0) then
  begin
    ComponentList:=TList.Create;
    for i:=0 to Pred(ControlCount) do
      if Controls[i] is TComponentContainer then
        ComponentList.Add(TComponentContainer(Controls[i]).Component);
    DestroyContainers;
    try
      i:=0;
      while i<ControlCount do
        if ValidControl(Controls[i].Parent) and (ControlIndex(Controls[i].Parent)<>-1) then
          DeleteControl(Controls[i])
        else Inc(i);
      BinStream:=TMemoryStream.Create;
      try
        with TWriter.Create(BinStream,BufSize) do
        try
          Root:=ParentForm;
          for i:=0 to Pred(ControlCount) do
          begin
            WriteSignature;
            WriteComponent(Controls[i]);
            if Assigned(FOnCopyComponent) then
              FOnCopyComponent(Self,Controls[i]);
          end;
          with ComponentList do
            for i:=0 to Pred(Count) do
            begin
              WriteSignature;
              WriteComponent(TComponent(Items[i]));
              if Assigned(FOnCopyComponent) then
                FOnCopyComponent(Self,TComponent(Items[i]));
            end;
        finally
          Free;
        end;
        BinStream.Seek(0,soFromBeginning);
        StringStream:=TStringStream.Create('');
        try
          while BinStream.Position<BinStream.Size do
            ObjectBinaryToText(BinStream,StringStream);
          Clipboard.AsText:=StringStream.DataString;
        finally
          StringStream.Free;
        end;
      finally
        BinStream.Free;
      end;
    finally
      if Active then CreateContainers;
      with ComponentList do
      begin
        for i:=0 to Pred(Count) do
          AddControl(FindComponentContainer(TComponent(Items[i])));
        Free;
      end;
    end;
  end;
end;

procedure TCustomFormDesigner.PasteFromClipboard;
var
  BinStream: TMemoryStream;
  StringStream: TStringStream;
  ParentControl: TWinControl;
  NewComponent: TComponent;
  Container: TComponentContainer;
  NewControl: TControl;

  procedure SetPosition(Control: TControl);
    var CompStream: TStringStream;
        Parser: TParser;
        Flags: Byte;
  begin
    CompStream:=TStringStream.Create;
    try
      Flags := 0;
      BinStream.Position:=0;
      ObjectBinaryToText(BinStream, CompStream);
      CompStream.Position:=0;
      Parser:= TParser.Create(CompStream);
      try
        while parser.NextToken <> #0 do
        begin
          if Parser.TokenSymbolIs('TOP') then
          begin
            parser.NextToken;
            parser.NextToken;
            Control.Top := StrToIntDef(parser.TokenString, 0);
            Flags:= Flags or 1;
          end;
          if Parser.TokenSymbolIs('LEFT') then
          begin
            parser.NextToken;
            parser.NextToken;
            Control.Left := StrToIntDef(parser.TokenString, 0);
            Flags:= Flags or 2;
          end;
          if Parser.TokenSymbolIs('HEIGHT') then
          begin
            parser.NextToken;
            parser.NextToken;
            Control.Height := StrToIntDef(parser.TokenString, 0);
            Flags:= Flags or 4;
          end;
          if Parser.TokenSymbolIs('WIDTH') then
          begin
            parser.NextToken;
            parser.NextToken;
            Control.Width := StrToIntDef(parser.TokenString, 0);
            Flags:= Flags or 8;
          end;
          if Flags = 15 then Break;
        end;
      finally
        Parser.Free;
      end;
    finally
      CompStream.Free;
    end;
  end;

begin
  if (Assigned(ParentForm)) and (Clipboard.AsText<>'') then
  begin
    StringStream:=TStringStream.Create(Clipboard.AsText);
    if StringStream.Size>0 then
      try
        if ValidControl(Control) then
          if Control is TWinControl then ParentControl:=TWinControl(Control)
          else ParentControl:=Control.Parent
        else ParentControl:=ParentForm;
        while ValidControl(ParentControl) and not (csAcceptsControls in ParentControl.ControlStyle) do
          ParentControl:=ParentControl.Parent;
        if not ValidControl(ParentControl) then ParentControl:=ParentForm;
        Control:=nil;
        DoSelectionChange;
        BinStream:=TMemoryStream.Create;
        try
          while StringStream.Position<StringStream.Size do
          begin
            BinStream.Seek(0,soFromBeginning);
            ObjectTextToBinary(StringStream,BinStream);
            BinStream.Seek(0,soFromBeginning);
            with TFDReader.Create(BinStream,Self) do
            try
              BeginReferences;
              try
                Root:=ParentForm;
                Owner:=ParentForm;
                Parent:=ParentControl;
                ReadSignature;
                NewComponent:=ReadComponent(nil);
                FixupReferences;
                if Assigned(FOnPasteComponent) then FOnPasteComponent(Self,NewComponent);
                if FActive then
                begin
                  if NewComponent is TControl then
                  begin
                    NewControl := TControl(NewComponent);
                    SetPosition(NewControl);
                    if ControlCount = 0 then Control := NewControl
                    else
                      AddControl(NewControl);
                    with NewControl do
                    begin
                      if Left + Width > ParentControl.ClientWidth then
                        Left := ParentControl.ClientWidth - Width;
                      if Top + Height > ParentControl.ClientHeight then
                        Top := ParentControl.ClientHeight - Height;
                    end;
                  end
                  else
                  begin
                    Container:=FindComponentContainer(NewComponent);
                    if Assigned(Container) then
                    begin
                      with NewComponent do
                        SetWindowPos(Container.Handle,0,LoWord(DesignInfo),HiWord(DesignInfo),0,0,SWP_NOSIZE or SWP_NOZORDER);
                      Container.UpdateContainer;
                      SetPosition(Container);
                      if ControlCount = 0 then Control := Container
                      else
                        AddControl(Container);
                    end;
                  end;
                  if Assigned(NewControl) then
                  begin
                  end;
                  DoSelectionChange;
                end;
              finally
                EndReferences;
              end;
            finally
              Free;
            end;
          end;
        finally
          BinStream.Free;
        end;
      finally
        StringStream.Free;
      end;
  end;
  DrawEnvironment;
end;

{$ELSE}
function TCustomFormDesigner.CanPaste: boolean;
begin
  Result := Assigned(ParentForm) and Clipboard.HasFormat(CF_GS_DesignedObjects);
end;

procedure TCustomFormDesigner.CopyToClipboard;
var
  i: integer;
  BinStream: TMemoryStream;
  ComponentList: TList;
  Data: THandle;
  DataPtr: Pointer;
begin
  CheckParent(Control, False);
  if (Assigned(ParentForm)) and (ControlCount > 0) then
  begin
    ComponentList := TList.Create;
    for i := 0 to Pred(ControlCount) do
      if Controls[i] is TComponentContainer then
        ComponentList.Add(TComponentContainer(Controls[i]).Component);
    DestroyContainers;
    try
      i := 0;
      while i < ControlCount do
        if ValidControl(Controls[i].Parent) and
          (ControlIndex(Controls[i].Parent) <> -1) then
          DeleteControl(Controls[i])
        else
          Inc(i);
      BinStream := TMemoryStream.Create;
      try
        with TWriter.Create(BinStream, BufSize) do
        try
          Root := ParentForm;
          for i := Pred(ControlCount) downto 0 do
          begin
            WriteSignature;
            WriteComponent(Controls[i]);
            if Assigned(FOnCopyComponent) then FOnCopyComponent(Self, Controls[i]);
          end;
          with ComponentList do
            for i := Pred(Count) downto 0 do
            begin
              WriteSignature;
              WriteComponent(TComponent(Items[i]));
              if Assigned(FOnCopyComponent) then
                FOnCopyComponent(Self, TComponent(Items[i]));
            end;
        finally
          Free;
        end;
        BinStream.Seek(0, soFromBeginning);
        {$IFNDEF FPC}
        Data := GlobalAlloc(GMEM_MOVEABLE, BinStream.Size);
        {$ENDIF}
        if (Data = 0) then
          raise EOutOfMemory.Create(
            'GlobalAlloc Failed to allocate memory for the Clipboard.');
        try
          {$IFNDEF FPC}
          DataPtr := GlobalLock(Data);
          {$ENDIF}
          if (DataPtr = nil) then
            raise Exception.Create(
              'GlobalLock Failed to lock memory for the Clipboard.');
          try
            Move(BinStream.Memory^, DataPtr^, BinStream.Size);
            {$IFNDEF FPC}
            Clipboard.SetAsHandle(CF_GS_DesignedObjects, Data);
            {$ENDIF}
          finally
            {$IFNDEF FPC}
            GlobalUnlock(Data);
            {$ENDIF}
          end;
        except
          
          {$IFNDEF FPC}
          GlobalFree(Data);
          {$ENDIF}
          raise;
        end;
      finally
        BinStream.Free;
      end;
    finally
      if Active then CreateContainers;
      with ComponentList do
      begin
        for i := 0 to Pred(Count) do
          AddControl(FindComponentContainer(TComponent(Items[i])));
        DoSelectionChange;
        Free;
      end;
    end;
  end;
end;

procedure TCustomFormDesigner.PasteFromClipboard;
var
  BinStream: TMemoryStream;
  ParentControl: TWinControl;
  NewComponent: TComponent;
  Container: TComponentContainer;
  NewControl: TControl;
  Data: THandle;
  DataPtr: Pointer;
  Size: integer;
begin
  if CanPaste then
  begin
    if ValidControl(Control) then
      if Control is TWinControl then ParentControl := TWinControl(Control)
      else
        ParentControl := Control.Parent
    else
      ParentControl := ParentForm;
    while (ValidControl(ParentControl) and not (csAcceptsControls in
        ParentControl.ControlStyle)) do
      ParentControl := ParentControl.Parent;
    if not ValidControl(ParentControl) then ParentControl := ParentForm;
    Control := nil;
    DoSelectionChange;
    BinStream := TMemoryStream.Create;
    try
      {$IFNDEF FPC}
      Data := Clipboard.GetAsHandle(CF_GS_DesignedObjects);
      {$ENDIF}
      if (Data <> 0) then
      begin
        {$IFNDEF FPC}
        DataPtr := GlobalLock(Data);
        {$ENDIF}
        if (DataPtr = nil) then
          raise Exception.Create('GlobalLock Failed to lock the Clipboard memory.');
        try
          {$IFNDEF FPC}
          Size := GlobalSize(Data);
          {$ENDIF}
          BinStream.SetSize(Size);
          Move(DataPtr^, BinStream.Memory^, Size);
        finally
          {$IFNDEF FPC}
          GlobalUnlock(Data);
          {$ENDIF}
        end;

        BinStream.Seek(0, soFromBeginning);
        while (BinStream.Position < BinStream.Size) do
        begin
          with TFDReader.Create(BinStream, Self) do
          try
            BeginReferences;
            try
              Root := ParentForm;
              Owner := ParentForm;
              Parent := ParentControl;
              while BinStream.Position < BinStream.Size do
              begin
                ReadSignature;
                NewComponent := ReadComponent(nil);
                if Assigned(FOnPasteComponent) then
                  FOnPasteComponent(Self, NewComponent);
                if FActive then
                begin
                  if NewComponent is TControl then
                  begin
                    NewControl := TControl(NewComponent);
                    if ControlCount = 0 then Control := NewControl
                    else
                      AddControl(NewControl);
                    DoSelectionChange;
                  end
                  else
                  begin
                    Container := FindComponentContainer(NewComponent);
                    if Assigned(Container) then
                    begin
                      with NewComponent do
                        SetWindowPos(Container.Handle, 0, LoWord(DesignInfo),
                          HiWord(DesignInfo), 0, 0, SWP_NOSIZE or SWP_NOZORDER);
                      Container.UpdateContainer;
                      if ControlCount = 0 then Control := Container
                      else
                        AddControl(Container);
                      DoSelectionChange;
                    end;
                    NewControl := FindComponentContainer(NewComponent);
                  end;
                  if Assigned(NewControl) then
                  begin
                    with NewControl do
                    begin
                      if Left + Width > ParentControl.ClientWidth then
                        Left := ParentControl.ClientWidth - Width;
                      if Top + Height > ParentControl.ClientHeight then
                        Top := ParentControl.ClientHeight - Height;
                    end;
                  end;
                end;
              end;
              FixupReferences;
            finally
              EndReferences;
            end;
          finally
            Free;
          end;
        end;
      end;
    finally
      BinStream.Free;
    end;
  end;
end;
{$ENDIF}

procedure TCustomFormDesigner.CutToClipboard;
var
  C: TComponent;
begin
  CopyToClipboard;
  while ControlCount > 0 do
  begin
    if Controls[0] is TComponentContainer then
      C := TComponentContainer(Controls[0]).Component
    else
      C := nil;
    Controls[0].Free;
    if Assigned(C) then C.Free;
  end;
  DrawEnvironment;
end;

function TCustomFormDesigner.GetComponentProperties(AComponent: TComponent): string;
var
  B: TMemoryStream;
  S: TStringStream;
begin
  if Assigned(AComponent) then
  begin
    B := TMemoryStream.Create;
    S := TStringStream.Create('');
    try
      B.WriteComponent(AComponent);
      B.Seek(0, soFromBeginning);
      ObjectBinaryToText(B, S);
      Result := S.DataString;
    finally
      S.Free;
      B.Free;
    end;
  end
  else
    Result := '';
end;

procedure TCustomFormDesigner.SetComponentProperties(AComponent: TComponent;
  Props: string);
var
  B: TMemoryStream;
  S: TStringStream;
begin
  if Assigned(AComponent) then
  begin
    B := TMemoryStream.Create;
    S := TStringStream.Create(Props);
    try
      ObjectTextToBinary(S, B);
      B.Seek(0, soFromBeginning);
      B.ReadComponent(AComponent);
    finally
      S.Free;
      B.Free;
    end;
  end;
end;

procedure TCustomFormDesigner.AlignToGrid(TheControl: TControl);
begin
  if FActive and ValidControl(TheControl) and not IsLocked(TheControl) and not
    IsTransparent(TheControl) and not IsProtected(TheControl) then
  begin
    with TheControl do
    begin
      {$IFDEF GFDADVANCEDGRID}
      if Left mod FGridStepX < FGridStepX div 2 then Left:=Left div FGridStepX * FGridStepX
      else Left:=Succ(Left div FGridStepX) * FGridStepX;
      if Top mod FGridStepY < FGridStepY div 2 then Top:=Top div FGridStepY * FGridStepY
      else Top:=Succ(Top div FGridStepY) * FGridStepY;
      {$ELSE}
      if Left mod FGridStep < FGridStep div 2 then Left := Left div FGridStep * FGridStep
      else
        Left := Succ(Left div FGridStep) * FGridStep;
      if Top mod FGridStep < FGridStep div 2 then Top := Top div FGridStep * FGridStep
      else
        Top := Succ(Top div FGridStep) * FGridStep;
      {$ENDIF}
      FGrabHandles.Update(False);
      
    end;
    DoMoveSizeControl;
    DoChange;
  end;
end;

function TCustomFormDesigner.EditControlLists(DefaultList: TListType): boolean;
begin
  Result := EditLists(Self, DefaultList);
end;

function TCustomFormDesigner.AlignDialog: boolean;
begin
  Result := False;
  with TfrmAlign.Create(Application) do
  try
    Result := ShowModal = mrOk;
    if Result then
      AlignControls(TAlignMode(rgrHorizontal.ItemIndex), TAlignMode(
        rgrVertical.ItemIndex));
  except
    Free;
  end;
end;

function TCustomFormDesigner.SizeDialog: boolean;
var
  W, H: TSizeMode;

  function GetInt(S: string): integer;
  begin
    if S = '' then Result := 0
    else
      Result := StrToInt(S);
  end;

begin
  Result := False;
  with TfrmSize.Create(Application) do
  try
    Result := ShowModal = mrOk;
    if Result then
    begin
      if rbtWNoChange.Checked then W := smNoChange
      else
      if rbtWToSmallest.Checked then W := smToSmallest
      else
      if rbtWToLargest.Checked then W := smToLargest
      else
        W := smValue;
      if rbtHNoChange.Checked then H := smNoChange
      else
      if rbtHToSmallest.Checked then H := smToSmallest
      else
      if rbtHToLargest.Checked then H := smToLargest
      else
        H := smValue;
      SizeControls(W, GetInt(edtWidth.Text), H, GetInt(edtHeight.Text));
    end;
  except
    Free;
  end;
end;

function TCustomFormDesigner.TabOrderDialog: boolean;
var
  PC: TWinControl;
  i: integer;
  List:{$IFDEF FPC}TFPList{$ELSE}TList{$ENDIF};
begin
  with TfrmTabOrder.Create(Application) do
  try
    CheckParent(Control, False);
    if ValidControl(Control) then
    begin
      if Control is TWinControl then PC := TWinControl(Control)
      else
        PC := Control.Parent;
      while ValidControl(PC) and (PC.ControlCount = 0) do PC := PC.Parent;
      if not ValidControl(PC) then PC := ParentForm;
    end
    else
      PC := ParentForm;
    List := {$IFDEF FPC} TFPList{$ELSE} TList{$ENDIF}.Create;
    try
      PC.GetTabOrderList(List);
      for i := 0 to Pred(List.Count) do
        if not Assigned(FGrabHandles) or
          (Assigned(FGrabHandles) and not FGrabHandles.IsGrabHandle(
          TControl(List[i]))) and not (TControl(List[i]) is TComponentContainer) then
          with TControl(List[i]) do
            if Parent = PC then
              lsbControls.Items.AddObject(Name + ': ' + ClassName, List[i]);
    finally
      List.Free;
    end;
    
    begin
      if lsbControls.Count > 0 then lsbControls.ItemIndex := 0
      else
        btnOK.Enabled := False;
      Result := ShowModal = mrOk;
      if Result then
        for i := 0 to Pred(lsbControls.Count) do
          (lsbControls.Items.Objects[i] as TWinControl).TabOrder := i;
    end;
  finally
    Free;
  end;
end;

procedure TCustomFormDesigner.ShowAlignmentPalette;
begin
  if Assigned(FAPForm) then
    with FAPForm do
    begin
      if apStayOnTop in FAlignmentPalette then FormStyle := fsStayOnTop
      else
        FormStyle := fsNormal;
      if Assigned(FOnShowAlignmentPalette) then FOnShowAlignmentPalette(Self, FAPForm);
      Show;
    end;
end;

procedure TCustomFormDesigner.HideAlignmentPalette;
begin
  if Assigned(FAPForm) then FAPForm.Hide;
end;

function LeftSort(Item1, Item2: Pointer): integer;
begin
  if TControl(Item1).Left < TControl(Item2).Left then Result := -1
  else
  if TControl(Item1).Left > TControl(Item2).Left then Result := 1
  else
    Result := 0;
end;

function RightSort(Item1, Item2: Pointer): integer;

  function Right(Item: Pointer): integer;
  begin
    with TControl(Item) do Result := Left + Width;
  end;

begin
  if Right(Item1) < Right(Item2) then Result := -1
  else
  if Right(Item1) > Right(Item2) then Result := 1
  else
    Result := 0;
end;

function TopSort(Item1, Item2: Pointer): integer;
begin
  if TControl(Item1).Top < TControl(Item2).Top then Result := -1
  else
  if TControl(Item1).Top > TControl(Item2).Top then Result := 1
  else
    Result := 0;
end;

function BottomSort(Item1, Item2: Pointer): integer;

  function Bottom(Item: Pointer): integer;
  begin
    with TControl(Item) do Result := Top + Height;
  end;

begin
  if Bottom(Item1) < Bottom(Item2) then Result := -1
  else
  if Bottom(Item1) > Bottom(Item2) then Result := 1
  else
    Result := 0;
end;

procedure TCustomFormDesigner.AlignControls(Hor, Ver: TAlignMode);
var
  i, Val, Min, Max: integer;
begin
  if FActive then
  begin
    CheckParent(Control, True);
    if ControlCount > 0 then
    begin
      with TList.Create do
      try
        for i := Pred(ControlCount) downto 0 do
          if not IsLocked(Controls[i]) then Add(Controls[i]);
        case Hor of
          amLeftTop:
            if ControlCount > 1 then
            begin
              {$IFDEF GFDDELPHIALIGN}
              Sort(LeftSort);
              {$ENDIF}
              for i := Pred(ControlCount) downto 0 do
                if not IsLocked(Controls[i]) then
                  Controls[i].Left := TControl(Items[Pred(ControlCount)]).Left;
            end;
          amCenters:
            if ControlCount > 1 then
            begin
              {$IFDEF GFDDELPHIALIGN}
              Sort(LeftSort);
              {$ENDIF}
              
              with TControl(Items[Pred(Count)]) do Val := Left + Width div 2;
              if FMoveLimitMode = lmControls then
                for i := Pred(ControlCount) downto 0 do
                  if not IsLocked(Controls[i]) then
                    with Controls[i] do
                      if Val + Width div 2 > Parent.ClientWidth then
                        Dec(Val, Val + Width div 2 - Parent.ClientWidth);
              for i := Pred(ControlCount) downto 0 do
                if not IsLocked(Controls[i]) then
                  with Controls[i] do Left := Val - Width div 2;
            end;
          amRightBottom:
            if ControlCount > 1 then
            begin
              {$IFDEF GFDDELPHIALIGN}
              Sort(RightSort);
              {$ENDIF}
              with TControl(Items[Pred(Count)]) do Val := Left + Width;
              for i := Pred(ControlCount) downto 0 do
                if not IsLocked(Controls[i]) then
                  with Controls[i] do Left := Val - Width;
            end;
          amSpace:
            if Count > 1 then
            begin
              {$IFDEF GFDDELPHIALIGN}
              Sort(LeftSort);
              {$ENDIF}
              Val := (TControl(Items[Pred(Count)]).Left - TControl(Items[0]).Left) div
                Pred(Count);
              for i := 0 to Pred(Count) do
                TControl(Items[i]).Left := TControl(Items[0]).Left + Val * i;
            end;
          amWindowCenter:
          begin
            Val := Control.Parent.ClientWidth;
            Min := MaxInt;
            Max := -MaxInt;
            for i := Pred(ControlCount) downto 0 do
              with Controls[i] do
              begin
                if Left < Min then Min := Left;
                if Left + Width > Max then Max := Left + Width;
              end;
            for i := Pred(ControlCount) downto 0 do
              if not IsLocked(Controls[i]) then
                with Controls[i] do Left := Left + (Val - Max + Min) div 2 - Min;
          end;
        end;
        case Ver of
          amLeftTop:
            if ControlCount > 1 then
            begin
              {$IFDEF GFDDELPHIALIGN}
              Sort(TopSort);
              {$ENDIF}
              for i := Pred(ControlCount) downto 0 do
                if not IsLocked(Controls[i]) then
                  Controls[i].Top := TControl(Items[Pred(ControlCount)]).Top;
            end;
          amCenters:
            if ControlCount > 1 then
            begin
              {$IFDEF GFDDELPHIALIGN}
              Sort(TopSort);
              {$ENDIF}
              
              with TControl(Items[Pred(Count)]) do Val := Top + Height div 2;
              if FMoveLimitMode = lmControls then
                for i := Pred(ControlCount) downto 0 do
                  if not IsLocked(Controls[i]) then
                    with Controls[i] do
                      if Val + Height div 2 > Parent.ClientHeight then
                        Dec(Val, Val + Height div 2 - Parent.ClientHeight);
              for i := Pred(ControlCount) downto 0 do
                if not IsLocked(Controls[i]) then
                  with Controls[i] do Top := Val - Height div 2;
            end;
          amRightBottom:
            if ControlCount > 1 then
            begin
              {$IFDEF GFDDELPHIALIGN}
              Sort(BottomSort);
              {$ENDIF}
              with TControl(Items[Pred(Count)]) do Val := Top + Height;
              for i := Pred(ControlCount) downto 0 do
                if not IsLocked(Controls[i]) then
                  with Controls[i] do Top := Val - Height;
            end;
          amSpace:
            if Count > 1 then
            begin
              {$IFDEF GFDDELPHIALIGN}
              Sort(TopSort);
              {$ENDIF}
              Val := (TControl(Items[Pred(Count)]).Top - TControl(Items[0]).Top) div
                Pred(Count);
              for i := 0 to Pred(Count) do
                TControl(Items[i]).Top := TControl(Items[0]).Top + Val * i;
            end;
          amWindowCenter:
          begin
            Val := Control.Parent.ClientHeight;
            Min := MaxInt;
            Max := -MaxInt;
            for i := Pred(ControlCount) downto 0 do
              with Controls[i] do
              begin
                if Top < Min then Min := Top;
                if Top + Height > Max then Max := Top + Height;
              end;
            for i := Pred(ControlCount) downto 0 do
              if not IsLocked(Controls[i]) then
                with Controls[i] do Top := Top + (Val - Max + Min) div 2 - Min;
          end;
        end;
        if FMoveLimitMode = lmControls then
        begin
          
          Val := 0;
          for i := 0 to Pred(ControlCount) do
            with Controls[i] do
              if Left < Val then Val := Left;
          if Val < 0 then
            for i := 0 to Pred(ControlCount) do
              with Controls[i] do Left := Left - Val;
          
          Val := 0;
          for i := 0 to Pred(ControlCount) do
            with Controls[i] do
              if Top < Val then Val := Top;
          if Val < 0 then
            for i := 0 to Pred(ControlCount) do
              with Controls[i] do Top := Top - Val;
          
          Val := Control.Parent.ClientWidth;
          for i := 0 to Pred(ControlCount) do
            with Controls[i] do
              if Left + Width > Val then Val := Left + Width;
          if Val > Control.Parent.ClientWidth then
            for i := 0 to Pred(ControlCount) do
              with Controls[i] do Left := Left + Control.Parent.ClientWidth - Val;
          
          Val := Control.Parent.ClientHeight;
          for i := 0 to Pred(ControlCount) do
            with Controls[i] do
              if Top + Height > Val then Val := Top + Height;
          if Val > Control.Parent.ClientHeight then
            for i := 0 to Pred(ControlCount) do
              with Controls[i] do Top := Top + Control.Parent.ClientHeight - Val;
        end;
      finally
        Free;
      end;
      
      if ControlCount = 1 then
      begin
        Control.Invalidate;
        FGrabHandles.Update(False);
      end;
      
      DoMoveSizeControl;
      DoChange;
    end;
  end;
end;

procedure TCustomFormDesigner.SizeControls(WMode: TSizeMode; WValue: integer; HMode: TSizeMode; HValue: integer);
var
  i, Val: integer;
begin
  if FActive then
  begin
    CheckParent(Control, True);
    if ControlCount > 0 then
    begin
      case WMode of
        smToSmallest:
        begin
          Val := MaxInt;
          for i := 0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              with Controls[i] do
                if Width < Val then Val := Width;
          for i := 0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Width := Val;
        end;
        smToLargest:
        begin
          Val := -MaxInt;
          for i := 0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              with Controls[i] do
                if Width > Val then Val := Width;
          for i := 0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Width := Val;
        end;
        smValue:
        begin
          for i := 0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Width := WValue;
        end;
      end;
      case HMode of
        smToSmallest:
        begin
          Val := MaxInt;
          for i := 0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              with Controls[i] do
                if Height < Val then Val := Height;
          for i := 0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Height := Val;
        end;
        smToLargest:
        begin
          Val := -MaxInt;
          for i := 0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              with Controls[i] do
                if Height > Val then Val := Height;
          for i := 0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Height := Val;
        end;
        smValue:
        begin
          for i := 0 to Pred(ControlCount) do
            if not IsLocked(Controls[i]) then
              Controls[i].Height := HValue;
        end;
      end;
      
      if ControlCount = 1 then
      begin
        Control.Invalidate;
        FGrabHandles.Update(False);
      end;
      
      DoMoveSizeControl;
      DoChange;
    end;
  end;
end;

procedure TCustomFormDesigner.Lock;
begin
  Inc(FLockCounter);
end;

procedure TCustomFormDesigner.Unlock;
begin
  if FLockCounter > 0 then Dec(FLockCounter);
  if GetCapture = ParentForm.Handle then ReleaseCapture;
end;

procedure TCustomFormDesigner.SynchroLock;
begin
  Inc(FSynchroLockCounter);
end;

procedure TCustomFormDesigner.SynchroUnlock;
begin
  if FSynchroLockCounter > 0 then Dec(FSynchroLockCounter);
end;

procedure TCustomFormDesigner.LeaveMouseAction;
begin
  if FActive and (FMouseAction <> maNone) then
  begin
    
    ReleaseCapture;
    {$IFNDEF FPC} ClipCursor(nil);{$ENDIF}
    HideHint;
    FMouseAction := maNone;
    if Assigned(FGrabHandles) then FGrabHandles.Visible := ValidControl(Control);
    if ValidControl(Control) then FDragRect := Control.BoundsRect;
  end;
end;

procedure TCustomFormDesigner.AddControl(AControl: TControl);
var
  Index: integer;
  OldControl: TControl;
begin
  OldControl := nil;
  if Assigned(FGrabHandles) and FGrabHandles.IsGrabHandle(AControl) then Exit;
  if ValidControl(AControl) then
  begin
    {$IFDEF TFDTRIAL}
    if AControl.Parent<>ParentForm then
    begin
      ShowTrialWarning;
      Exit;
    end;
    {$ENDIF}
    with FControls do
    begin
      Index := IndexOf(AControl);
      if Index = -1 then
      begin
        OldControl := Control;
        Add(AControl);
        AControl.FreeNotification(Self);
        
        DoAddControl(AControl);
        DoSelectControl(AControl);
        
      end;
      
      AControl.Invalidate;
      if Assigned(FGrabHandles) then FGrabHandles.Control:=AControl;
      
    end;
  end;
end;

procedure TCustomFormDesigner.DeleteControl(AControl: TControl);
var
  Index: integer;
begin
  with FControls do
  begin
    Index := IndexOf(AControl);
    if Index <> -1 then
    begin
      Delete(Index);
      {$IFNDEF NOREMOVENOTIFICATION}
      AControl.RemoveFreeNotification(Self);
      {$ENDIF}
      try
        if ValidControl(AControl.Parent) then
        begin
          if AControl is TWinControl then
            RedrawWindow(TWinControl(AControl).Handle, nil, 0, RDW_INVALIDATE or RDW_ALLCHILDREN);
          AControl.Invalidate;
        end;
      except
      end;
      if Assigned(FGrabHandles) then
        if FGrabHandles.Control = AControl then FGrabHandles.Control := Control;
      
      DoDeleteControl(AControl);
      
    end;
  end;
end;

procedure TCustomFormDesigner.AddComponent(AComponent: TComponent);
begin
  AddControl(FindComponentContainer(AComponent));
  DoSelectionChange;
end;

procedure TCustomFormDesigner.DeleteComponent(AComponent: TComponent);
begin
  DeleteControl(FindComponentContainer(AComponent));
  DoSelectionChange;
end;

procedure TCustomFormDesigner.SelectAll;
var
  i: integer;
begin
  SynchroLock;
  try
    
    if Assigned(ParentForm) then
      with ParentForm do
        for i := 0 to Pred(ComponentCount) do
          if (Components[i] is TControl) and
            (TControl(Components[i]).Parent is TForm) and
            TControl(Components[i]).Visible and
            ValidControl(TControl(Components[i]).Parent) and
            TControl(Components[i]).Parent.Showing and not
            FGrabHandles.IsGrabHandle(TControl(Components[i])) and not
            IsProtected(TControl(Components[i])) and not
            IsTransparent(TControl(Components[i])) then Self.AddControl(TControl(Components[i]));
  finally
    SynchroUnlock;
  end;
  DoSelectionChange;
end;

procedure TCustomFormDesigner.UnselectAll;
begin
  Control := nil;
  DoSelectionChange;
end;

procedure TCustomFormDesigner.ClearControls;
begin
  with FControls do
    while Count > 0 do DeleteControl(Controls[Count - 1]);
  DoSelectionChange;
end;

function TCustomFormDesigner.ControlIndex(AControl: TControl): integer;
begin
  if Assigned(FControls) then Result := FControls.IndexOf(AControl)
  else Result := -1;
end;

procedure TCustomFormDesigner.DrawGrab(Canvas: TCanvas; R: TRect; GrabType: TGrabType);
begin
  with Canvas do
  begin
    case GrabType of
      gtNormal:
      begin
        Pen.Color := FNormalGrabBorder;
        Brush.Color := FNormalGrabFill;
      end;
      gtMulti:
      begin
        Pen.Color := FMultiGrabBorder;
        Brush.Color := FMultiGrabFill;
      end;
      gtLocked:
      begin
        Pen.Color := FLockedGrabBorder;
        Brush.Color := FLockedGrabFill;
      end;
    end;
    with R do Rectangle(Left, Top, Right, Bottom);
  end;
end;

procedure TCustomFormDesigner.UpdateGrabs;
begin
  
  if Assigned(FGrabHandles) then FGrabHandles.Update(True);
end;

function TCustomFormDesigner.CreateComponentClass(AComponentClass: TComponentClass):
TComponent;
begin
  Result := AComponentClass.Create(ParentForm);
end;

function TCustomFormDesigner.CreateComponentClassName(AClassName: TComponentName):
TComponent;
var
  CC: TComponentClass;
begin
  CC := TComponentClass(GetClass(AClassName));
  if Assigned(CC) then Result := CreateComponentClass(CC)
  else
    Result := nil;
end;

function TCustomFormDesigner.PlaceComponentClass(AComponentClass: TComponentClass):
TComponent;
var
  CC: TComponentContainer;
begin
  CancelPlacing;
  Result := nil;
  if Assigned(AComponentClass) then
  begin
    Lock;
    FWaiting := True;
    FPlacedComponent := CreateComponentClass(AComponentClass);
    Result := FPlacedComponent;
    if not (FPlacedComponent is TControl) then
    begin
      CC := FindComponentContainer(FPlacedComponent);
      if Assigned(CC) then CC.Visible := False;
      {$IFDEF FPC}
      
      {$ENDIF}
    end;
    
  end;
end;

function TCustomFormDesigner.PlaceComponentClassName(AClassName: TComponentName):
TComponent;
var
  CC: TComponentClass;
begin
  CC := TComponentClass(GetClass(AClassName));
  if Assigned(CC) then Result := PlaceComponentClass(CC)
  else
    Result := nil;
end;

{$IFDEF FPC}
procedure TCustomFormDesigner.HandleMessage(var TheMessage : TLMessage);
var
  LMessage: TMessage;
begin
  
   LMessage := TheMessage;
   WinProc(LMessage);
end;

procedure TCustomFormDesigner.UserInputEvent(Sender: TObject; Msg: Cardinal);
  function CreateMouseMessage(Sender: TObject; Msg: Cardinal): TMSG;
  var
    pt: TPoint;
  begin
    if (Sender is TWinControl) then
      begin
        result.hwnd := TWinControl(Sender).Handle;
        pt := TWinControl(Sender).ScreenToClient(Mouse.CursorPos);
        result.lParam := MakeLong(pt.x, pt.y);
      end else
        FillChar(Result, SizeOf(Result), 0);
  
    result.message := Msg; 

  end;

var
  LMsg: TMSG;
  Handled: Boolean;
begin

 if (Sender is TApplication) then
    Sender := ParentForm;

  case msg of
     LM_LBUTTONDOWN, LM_LBUTTONUP, LM_RBUTTONDOWN, LM_RBUTTONUP, LM_MOUSEMOVE,
     WM_NCLBUTTONDOWN, WM_NCLBUTTONUP, {$IFnDEF FPC}WM_NCRBUTTONDOWN, WM_NCRBUTTONUP,{$ENDIF}
     WM_NCMOUSEMOVE: begin
    
       LMsg := CreateMouseMessage(Sender, Msg);
       ApplicationMessage(LMsg, Handled);
     end;
  end;
end;

{$ENDIF}

procedure TCustomFormDesigner.CancelPlacing;
begin
  if FWaiting then
  begin
    if not (csDestroying in ComponentState) then
    begin
      FPlacedComponent.Free;
      FPlacedComponent := nil;
      Unlock;
    end;
    FWaiting := False;
  end;
end;

function TCustomFormDesigner.GetComponentHint(AComponent: TComponent): string;
begin
  if Assigned(AComponent) and not FGrabHandles.IsGrabHandle(TControl(AComponent)) then
  begin
    if AComponent is TComponentContainer then
      AComponent := TComponentContainer(AComponent).Component;
    if Assigned(AComponent) then
    begin
      with AComponent do Result := Format('%s: %s', [Name, ClassName]);
      if Assigned(FOnComponentHint) then FOnComponentHint(Self, AComponent, Result);
    end
    else
      Result := '';
  end
  else
    Result := '';
end;

function TCustomFormDesigner.GetComponentCaption(AComponent: TComponent): string;
begin
  if Assigned(AComponent) then
    if AComponent.Name <> '' then Result := AComponent.Name
    else
      Result := AComponent.ClassName
  else
    Result := '[none]';
  if Assigned(FOnComponentCaption) then FOnComponentCaption(Self, AComponent, Result);
end;

procedure TCustomFormDesigner.ApplicationIdle(Sender: TObject; var Done: boolean);
var
  i: integer;
  OldDesigning: boolean;
  LParentForm: TCustomForm;
begin
  LParentForm := ParentForm;
  if not (csDestroying in LParentForm.ComponentState) and (MouseAction = maNone) then
  begin
    if Assigned(LParentForm) and LParentForm.HandleAllocated then
      with LParentForm do
        for i := 0 to Pred(ComponentCount) do
        begin
          if (Components[i] is TControl) and not
            IsProtected(TControl(Components[i])) then
          begin
            OldDesigning := csDesigning in Components[i].ComponentState;
            if not (Components[i] is TCustomForm) and not
              (GetEditBehaviour(TControl(LParentForm.Components[i])) in
              [ebDefaultRuntime, ebTransparentRuntime, ebLockedRuntime]) then
              TDesignAccessComponent(
                LParentForm.Components[i]).SetDesigningPublic(FActive);
            if (OldDesigning xor (csDesigning in Components[i].ComponentState)) then
            begin
              TControl(Components[i]).Invalidate;
              ParentForm.Invalidate;
            end;
          end;
        end;
    
    if Assigned(FGrabHandles) then FGrabHandles.Update(False);
  end;
  if Assigned(LParentForm) then
    with LParentForm do
      if not IsProtected(ActiveControl) then ActiveControl := nil;
  Done := True;
  if Assigned(SavedApplicationIdle) then SavedApplicationIdle(Sender, Done);
end;

procedure TCustomFormDesigner.ApplicationMessage(var Msg: TMsg; var Handled: boolean);
var
  i, ILockCounter: integer;
  iMsg: TMsg;
begin
  
  if Assigned(Designers) then
    for i := 0 to Pred(Designers.Count) do
    begin
      iMsg := Msg;
      with TCustomFormDesigner(Designers[i]) do
      begin
        ILockCounter := FLockCounter;
        try
          MessageProc(iMsg);
        finally
          if FLockCounter > ILockCounter then FLockCounter := ILockCounter;
          {$IFNDEF GFDIGNOREUPCALL}
          if Locked and InParentForm(Msg.hwnd) then
            case Msg.Message of
              WM_LBUTTONUP, WM_NCLBUTTONUP, WM_RBUTTONUP
                {$IFnDEF FPC}
                , WM_NCRBUTTONUP
                {$ENDIF}
                :
              begin
                Unlock;
                MessageProc(iMsg);
              end;
            end;
          {$ENDIF}
        end;
      end;
      Msg := iMsg;
    end;
  {$IFNDEF FPC}
  if Assigned(SavedApplicationMessage) then SavedApplicationMessage(Msg, Handled);
  {$ENDIF}
end;

procedure TCustomFormDesigner.TimerEvent(Sender: TObject);
begin
  if FShowComponentHint and (integer(FHintTimer.Interval) = Application.HintPause) then
  begin
    ShowHint(GetComponentHint(FHintControl), hmCustom);
    FHintTimer.Interval := Application.HintHidePause;
  end
  else
  begin
    FHintTimer.Enabled := False;
    HideHint;
  end;
end;

procedure TCustomFormDesigner.StartTimer(AInterval: integer);
begin
  with FHintTimer do
  begin
    Interval := AInterval;
    Enabled := True;
  end;
end;

procedure TCustomFormDesigner.StopTimer;
begin
  if Assigned(FHintTimer) then FHintTimer.Enabled := False;
end;

procedure TCustomFormDesigner.MessageProc(var Msg: TMSG);
type
  TKeyType = (ktSelect, ktMove, ktFastMove, ktSize);
var
  NewControl: TControl;
  NewDrag, P, CP, Min, Max: TPoint;
  R: TRect;
  KeyType: TKeyType;
  Key: word;
  i, DX, DY: integer;
  Handled: boolean;
  WinControl: TWinControl;
  CC: TComponentContainer;

  procedure ProcessKey(Key: word);
  var
    R: TRect;
    i: integer;

    procedure GrowRect(var R: TRect; X, Y: integer);
    begin
      Inc(R.Right, X);
      Inc(R.Bottom, Y);
    end;

    procedure CheckRect(AControl: TControl; var R: TRect);
    var
      Limit: TRect;
    begin
      if ValidControl(AControl) and ValidControl(AControl.Parent) then
        with AControl.Parent, R do
          if KeyType = ktSize then
          begin
            Min := Point(0, 0);
            Max := Point(MaxInt, MaxInt);
            if FMoveLimitMode = lmControls then
            begin
              if Right > ClientWidth then R.Right := ClientWidth;
              if Bottom > ClientHeight then R.Bottom := ClientHeight;
            end;
            if Assigned(FOnSizeLimit) then FOnSizeLimit(Self, Control, Min, Max);
            if Right - Left < Min.X then Right := Left + Min.X;
            if Bottom - Top < Min.Y then Bottom := Top + Min.Y;
            if Right - Left > Max.X then Right := Left + Max.X;
            if Bottom - Top > Max.Y then Bottom := Top + Max.Y;
          end
          else
          begin
            Limit := ClientRect;
            if Assigned(FOnMoveLimit) then FOnMoveLimit(Self, AControl, Limit);
            if Left < Limit.Left then OffsetRect(R, Limit.Left - Left, 0);
            if Top < Limit.Top then OffsetRect(R, 0, Limit.Left - Top);
            if Right > Limit.Right - FGrabSize div 2 then
              OffsetRect(R, Limit.Right - Right - FGrabSize div 2, 0);
            if Bottom > Limit.Bottom - FGrabSize div 2 then
              OffsetRect(R, 0, Limit.Bottom - Bottom - FGrabSize div 2);
          end;
    end;

  begin
    if KeyType = ktMove then
    begin
      i := 0;
      while i < ControlCount do
        if (Controls[i].Parent <> Control.Parent) or IsLocked(Controls[i]) then
          DeleteControl(Controls[i])
        else
          Inc(i);
      DoSelectionChange;
    end;
    for i := 0 to Pred(ControlCount) do
      if ValidControl(Controls[i]) then
        with Controls[i] do
        begin
          R := BoundsRect;
          case Key of
            VK_RIGHT:
              case KeyType of
                ktSelect:
                begin
                  Control := FindNextControl(True);
                  DoSelectionChange;
                end;
                ktMove: OffsetRect(R, 1, 0);
                {$IFDEF GFDADVANCEDGRID}
                ktFastMove: OffsetRect(R,FGridStepX,0);
                {$ELSE}
                ktFastMove: OffsetRect(R, FGridStep, 0);
                {$ENDIF}
                ktSize: GrowRect(R, 1, 0);
              end;
            VK_LEFT:
              case KeyType of
                ktSelect:
                begin
                  Control := FindNextControl(False);
                  DoSelectionChange;
                end;
                ktMove: OffsetRect(R, -1, 0);
                {$IFDEF GFDADVANCEDGRID}
                ktFastMove: OffsetRect(R,-FGridStepX,0);
                {$ELSE}
                ktFastMove: OffsetRect(R, -FGridStep, 0);
                {$ENDIF}
                ktSize: GrowRect(R, -1, 0);
              end;
            VK_UP:
              case KeyType of
                ktSelect:
                begin
                  Control := FindNextControl(False);
                  DoSelectionChange;
                end;
                ktMove: OffsetRect(R, 0, -1);
                {$IFDEF GFDADVANCEDGRID}
                ktFastMove: OffsetRect(R,0,-FGridStepY);
                {$ELSE}
                ktFastMove: OffsetRect(R, 0, -FGridStep);
                {$ENDIF}
                ktSize: GrowRect(R, 0, -1);
              end;
            VK_DOWN:
              case KeyType of
                ktSelect:
                begin
                  Control := FindNextControl(True);
                  DoSelectionChange;
                end;
                ktMove: OffsetRect(R, 0, 1);
                {$IFDEF GFDADVANCEDGRID}
                ktFastMove: OffsetRect(R,0,FGridStepY);
                {$ELSE}
                ktFastMove: OffsetRect(R, 0, FGridStep);
                {$ENDIF}
                ktSize: GrowRect(R, 0, 1);
              end;
          end;
          if (KeyType <> ktSelect) and Assigned(ParentForm) then
          begin
            CheckRect(Controls[i], R);
            if not EqualRect(BoundsRect, R) then
            begin
              BoundsRect := R;
              {$IFDEF FPC}
              {$ELSE}
              if ValidControl(Controls[i]) and Assigned(Parent) then
                MapWindowPoints(Parent.Handle, ParentForm.Handle, R, 2);
              {$ENDIF}
              
              if Assigned(FGrabHandles) then FGrabHandles.Update(False);
              
              DoMoveSizeControl;
            end;
          end
          else
            Break;
        end;
    DoChange;
  end;

  function GetMouseControl(Wnd: HWND; LParam: integer): TControl;
  var
    Child: TControl;
    Parent: TWinControl;
    ParentPoint: TPoint;
    OrgWnd: HWND;
    {$IFNDEF NOFRAMES}
    i: integer;
    {$ENDIF}

    function TopLevel(AOwner: TComponent; C: TControl): boolean;
    begin
      Result := False;
      if Assigned(C) then
        with C do
          Result := (C.Owner = AOwner) or (Owner is TCustomForm)
            {$IFNDEF NOFRAMES}
            or (Owner is TCustomFrame)
      {$ENDIF}
      ;
    end;

    function CtrlAtPos: TControl;
    var
      i: integer;

      function FormRect(Control: TControl): TRect;
      begin
        if ValidControl(Control) and ValidControl(Control.Parent) then
        begin
          Result := Control.BoundsRect;
          with Result do
          begin
            TopLeft := ParentForm.ScreenToClient(Control.Parent.ClientToScreen(TopLeft));
            BottomRight := ParentForm.ScreenToClient(
              Control.Parent.ClientToScreen(BottomRight));
          end;
        end
        else
          Result := Rect(0, 0, 0, 0);
      end;

    begin
      if Assigned(ParentForm) then
        with ParentForm do
        begin
          Result := ControlAtPos(ParentPoint, True);
          if Assigned(Result) then
            Result := nil;
          if IsTransparent(Result) or not TopLevel(ParentForm, Result) then
            Result := nil;
          if not ValidControl(Result) or IsTransparent(Result) then
            for i := Pred(ComponentCount) downto 0 do
              if (Components[i] is TControl) and
                (ValidControl(TControl(Components[i]))) then
                if TControl(Components[i]).Visible and
                  PtInRect(FormRect(TControl(Components[i])), ParentPoint) and
                  not IsTransparent(TControl(Components[i])) and
                  TopLevel(ParentForm, TControl(Components[i])) then
                begin
                  Result := TControl(Components[i]);
                  Break;
                end;
        end
      else
        Result := nil;
    end;

    function ControlAtPoint(C: TWinControl; P: TPoint): TControl;
    var
      i: integer;
    begin
      Result := nil;
      with C do
        for i := Pred(ControlCount) downto 0 do
          if PtInRect(Controls[i].BoundsRect, P) and
            ((csDesigning in Controls[i].ComponentState) or Controls[i].Visible) then
          begin
            Result := Controls[i];
            Break;
          end;
    end;

  begin
    ParentPoint := Point(LoWord(LParam), HiWord(LParam));
    Parent := FindWinControl(Wnd);
    if not Assigned(Parent) then Parent := ParentForm;
    {$IFDEF FPC}
    {$ELSE}
    MapWindowPoints(Wnd, Parent.Handle, ParentPoint, 1);
    {$ENDIF}
    OrgWnd := Wnd;
    if Assigned(FGrabHandles) then Result := FGrabHandles.FindHandleControl(Wnd)
    else
      Result := nil;
    if not ValidControl(Result) then
    begin
      Result := FindWinControl(Wnd);
      if ValidControl(Result) then
      begin
        Child := ControlAtPoint((Result as TWinControl),
          (Point(LoWord(LParam), HiWord(LParam))));
        if Assigned(Child) then
          if not TopLevel(ParentForm, Child) then Child := nil;
      end
      else
        Child := nil;
      if ValidControl(Child) then Result := Child
      else
      begin
        if Result = nil then
          while (Wnd <> 0) and not ValidControl(Result) do
          begin
            Wnd := GetParent(Wnd);
            Result := FindWinControl(Wnd);
          end;
        if (Result = nil) and InParentForm(OrgWnd) then
          Result := CtrlAtPos;
      end;
    end;
    {$IFNDEF NOFRAMES}
    if Result is TCustomFrame then
      with TCustomFrame(Result) do
      begin
        for i := Pred(ComponentCount) downto 0 do
          if Components[i] is TWinControl then
            if TWinControl(Components[i]).Handle = OrgWnd then
            begin
              Result := TControl(Components[i]);
              Break;
            end;
        if ValidControl(Result) and (Result is TWinControl) then
        begin
          Child := (Result as TWinControl).ControlAtPos(
            Point(LoWord(LParam), HiWord(LParam)), True);
          if not TopLevel(Result, Child) then Child := nil;
        end
        else
          Child := nil;
        if ValidControl(Child) then Result := Child;
      end;
    {$ENDIF}
    if Assigned(FGrabHandles) and not FGrabHandles.IsGrabHandle(Result) then
    begin
      while Assigned(Result) and not TopLevel(ParentForm, Result) do
        Result := Result.Parent;
      while Assigned(Result) and (Result <> DesignControl) and IsTransparent(Result) do
        Result := Result.Parent;
      if Result = ParentForm then Result := nil;
    end;
  end;

  function SelectableParent(AControl: TControl): TControl;
  begin
    if ValidControl(AControl) then
    begin
      Result := AControl.Parent;
      while ValidControl(Result) and (Result <> ParentForm) and
        (IsLocked(Result) or IsTransparent(Result) or IsProtected(Result)) do
        Result := Result.Parent;
      if Result = ParentForm then Result := nil;
    end
    else
      Result := nil;
  end;

  function NormalRect(Rect: TRect): TRect;
  begin
    with Rect do
    begin
      if Left < Right then
      begin
        Result.Left := Left;
        Result.Right := Right;
      end
      else
      begin
        Result.Left := Right;
        Result.Right := Left;
      end;
      if Top < Bottom then
      begin
        Result.Top := Top;
        Result.Bottom := Bottom;
      end
      else
      begin
        Result.Top := Bottom;
        Result.Bottom := Top;
      end;
    end;
  end;

  function GetPopupParent(W: HWND): HWND;
  var
    C: TWinControl;
  begin
    Result := W;
    C := FindControl(W);
    if Assigned(ParentForm) then
      while (W <> 0) and (W <> ParentForm.Handle) and (W <> Application.Handle) do
      begin
        W := GetParent(W);
        if (W <> 0) and (W <> Application.Handle) then Result := W;
      end;

    if W = 0 then
      while Assigned(C) and Assigned(C.Parent) do
      begin
        if  (C.Parent.Handle = ParentForm.Handle) or (C.Parent.Handle = Application.Handle) then
        begin
          Result := C.Parent.Handle;
          Exit;
        end;
        C := C.Parent;
      end;
  end;

  function IsActiveOwner: boolean;
  var
    F: TWinControl;
  begin
    Result := Application.Active and IsLibrary;
    if not Result then
    begin
      F := ParentForm;
      while ValidControl(F) do
      begin
        
          Result := True;
          Break;
        
        F := F.Parent;
      end;
    end;
  end;

  function FindControlHandle(C: TComponent; W: HWND): boolean;
  var
    i: integer;
  begin
    Result := False;
    with C do
      for i := 0 to Pred(ComponentCount) do
        if Components[i] is TWinControl then
          with TWinControl(Components[i]) do
            if HandleAllocated and (Handle = W) then
            begin
              Result := True;
              Break;
            end;
    if not Result then
    begin
      W := GetParent(W);
      if (W <> 0) and (W <> ParentForm.Handle) then Result := FindControlHandle(C, W);
    end;
  end;

  function IsProtectedHandle(W: HWND): boolean;
  var
    C: TWinControl;
  begin
    Result := False;
    while W <> 0 do
    begin
      C := FindControl(W);
      if ValidControl(C) and IsProtected(C) then
      begin
        Result := True;
        Break;
      end;
      W := GetParent(W);
    end;
  end;

  function InParentForm(WND: HWND): boolean;
  var
    C: TWinControl;
  begin
    Result := False;
    C := FindControl(WND);
    while WND <> 0 do
    begin
      if WND = ParentForm.Handle then
      begin
        Result := True;
        Exit;
      end;
      WND := GetParent(WND);
    end;

    while Assigned(C) do
    begin
      if C.Parent = ParentForm then
      begin
        Result := True;
        Exit;
      end;
      C := C.Parent;
    end;
  end;

  function InDesignControl(WND: HWND): boolean;
  var
    C: TWinControl;
  begin
    if not Assigned(DesignControl) then Result := InParentForm(WND)
    else
    begin
      Result := False;
      C := FindControl(WND);
      if Assigned(C) then
        while Assigned(C) do
        begin
          if C = DesignControl then
          begin
            Result := True;
            Break;
          end;
          C := C.Parent;
        end;
    end;
  end;

  function AutoName(Component: TComponent): boolean;
  var
    i: integer;
    CN: string;
  begin
    Result := False;
    if Assigned(Component) then
      with ParentForm, Component do
      begin
        if (Name = '') or Assigned(ParentForm.FindComponent(Name)) then
        begin
          CN := Copy(ClassName, 2, Pred(Length(ClassName)));
          for i := 1 to 32768 do
            if not Assigned(ParentForm.FindComponent(CN + IntToStr(i))) then
            begin
              Name := CN + IntToStr(i);
              Result := True;
              Break;
            end;
        end;
      end;
  end;

begin
  {$IFNDEF FPC}
  if not Assigned(DesignControl) and Assigned(ParentForm) and
    ParentForm.HandleAllocated then
    if GetWindowLong(ParentForm.Handle, GWL_WNDPROC) <> integer(FWinProc) then
    begin
      SetWindowLong(ParentForm.Handle, GWL_WNDPROC, integer(FDefaultProc));
      FDefaultProc := TFarProc(GetWindowLong(ParentForm.Handle, GWL_WNDPROC));
      SetWindowLong(ParentForm.Handle, GWL_WNDPROC, integer(FWinProc));
    end;
  {$ENDIF}

  if not Locked then
  begin
    if Assigned(ParentForm) and IsActiveOwner then
    begin
      Lock;
      try
      with Msg do
        case Message of
          WM_MOVE, WM_SIZE:
            if hwnd = ParentForm.Handle then
              UpdateGrabs;
          CM_DEACTIVATE: LeaveMouseAction;
          WM_PAINT:
            if (hwnd <> ParentForm.Handle) and Assigned(FHintWindow) and
              (hwnd <> FHintWindow.Handle) and (MouseAction = maDragging) then
              Message := 0;
          WM_LBUTTONDBLCLK, WM_RBUTTONDBLCLK, WM_MBUTTONDBLCLK,
          WM_NCLBUTTONDBLCLK {$IFnDEF FPC}, WM_NCRBUTTONDBLCLK, WM_NCMBUTTONDBLCLK {$ENDIF}
            :
          begin
            GetCursorPos(P);
            NewControl := GetMouseControl(hwnd, LParam);
            if (FClickPos.X = P.X) and (FClickPos.Y = P.Y) then
            begin
              if ValidControl(NewControl) and not IsProtected(NewControl) then
              begin
                if (Message = WM_LBUTTONDBLCLK) or (Message = WM_NCLBUTTONDBLCLK) then
                  if Assigned(FOnControlDblClick) then
                    FOnControlDblClick(Self, NewControl);
                Message := 0;
              end;
              if (hwnd <> ParentForm.Handle) and not IsProtectedHandle(hwnd) and
                InParentForm(hwnd) then Message := 0;
              if not ValidControl(NewControl) and (hwnd <> ParentForm.Handle) and
                InParentForm(hwnd) then Message := 0;
              if ValidControl(Control) and (Control = NewControl) then Message := 0;
            end
            else
            if Assigned(NewControl) then Message := 0;
          end;
          WM_RBUTTONDOWN {$IFnDEF FPC}, WM_NCRBUTTONDOWN {$ENDIF}
            :
          begin
            NewControl := GetMouseControl(hwnd, LParam);
            if ValidControl(NewControl) then
              if not IsProtected(NewControl) then
              begin
                {$IFDEF TFDTRIAL}
                if NewControl.Parent<>ParentForm then
                begin
                  Message:=0;
                  ShowTrialWarning;
                  Exit;
                end;
                {$ENDIF}
                FMenuControl := NewControl;
                if ControlIndex(NewControl) = -1 then
                begin
                  Control := NewControl;
                  DoSelectionChange;
                end;
              end
              else
                FMenuControl := nil
            else
              FMenuControl := nil;
            if (hwnd = ParentForm.Handle) and not Assigned(FMenuControl) then
              FMenuControl := ParentForm;
          end;
          WM_CONTEXTPOPUP:
            if Assigned(FPopupMenu) then
            begin
              Lock;
              try
                
                LeaveMouseAction;
                GetCursorPos(NewDrag);
                with NewDrag do FPopupMenu.Popup(X, Y);
              finally
                Unlock;
              end;
            end;
          WM_RBUTTONUP {$IFnDEF FPC}, WM_NCRBUTTONUP {$ENDIF}
            :
          begin
            if Assigned(MenuControl) then
            begin
              Handled := False;
              if Assigned(FOnContextPopup) then
                FOnContextPopup(Self, Handled);
              if not Handled and ValidControl(FMenuControl) and
                ((GetMouseControl(hwnd, LParam) = FMenuControl) or
                (FMenuControl = ParentForm)) then
              begin
                if Assigned(FPopupMenu) then FPopupMenu.PopUp;
                  
                Message := 0;
              end
              else
              if not IsProtected(GetMouseControl(hwnd, LParam)) then Message := 0;
            end;
          end;
          WM_LBUTTONDOWN, WM_NCLBUTTONDOWN:
          begin
            FIgnoreMouseMove := True;
            if GetCapture = ParentForm.Handle then ReleaseCapture;
            GetCursorPos(FClickPos);
            FCursorPos := FClickPos;
            FControlPos := FClickPos;
            HideHint;
            if (Message = WM_NCLBUTTONDOWN) and
              ((hwnd = ParentForm.Handle) and (wParam <> HTCLIENT)) then Exit;
            if GetPopupParent(hwnd) <> ParentForm.Handle then Exit;
            if (hwnd <> ParentForm.Handle) and not
              FindControlHandle(ParentForm, hwnd) and (not Assigned(FGrabHandles) or
              not Assigned(FGrabHandles.FindHandleControl(hwnd))) then Exit;
            {$IFnDEF FPC}
            if TForm(ParentForm).FormStyle = fsMDIChild then
              SendMessage(ParentForm.Handle, WM_MDIACTIVATE, 0, ParentForm.Handle);
            {$ENDIF}
            NewControl := GetMouseControl(Msg.hwnd, lParam);
            if Assigned(NewControl) and
              (NewControl.Perform(CM_DESIGNHITTEST, wParam, lParam) <> 0) then
              Exit;
            if not DoValidateSelection(NewControl) then Exit;
            if FMultiSelect and (Assigned(FDesignControl) and
              (NewControl = FDesignControl) or (GetKeyState(VK_CONTROL) and $80 <> 0) or
              (hwnd = ParentForm.Handle) and (not ValidControl(NewControl) or
              (NewControl = ParentForm.Parent))) then
            begin
              FGrabHandles.Enabled := False;
              with FSelectRect do
              begin
                GetCursorPos(TopLeft);
                BottomRight := TopLeft;
              end;
              FSelectCounter := 0;
              if ControlCount > 1 then
                while ControlCount > 0 do
                begin
                  DoDeleteControl(FControls[0]);
                  if ValidControl(TControl(FControls[0]).Parent) then
                    if TControl(FControls[0]) is TWinControl then
                      RedrawWindow(TWinControl(FControls[0]).Handle, nil, 0, RDW_INVALIDATE or RDW_ALLCHILDREN);
                  TControl(FControls[0]).Invalidate;
                  FControls.Delete(0);
                end
              else
              begin
                if Assigned(Control) then DoDeleteControl(Control);
                FControls.Clear;
                DoSelectControl(Control);
                DoSelectionChange;
              end;
              FGrabHandles.Control := nil;
              FSelectControl := FindWinControl(hwnd);
              if not ValidControl(FSelectControl) then FSelectControl := ParentForm
              else
                while ValidControl(FSelectControl.Parent) and
                  not (csAcceptsControls in FSelectControl.ControlStyle) do
                  FSelectControl := FSelectControl.Parent;
              with FSelectControl, R do
              begin
                R := ClientRect;
                TopLeft := ClientToScreen(TopLeft);
                BottomRight := ClientToScreen(BottomRight);
              end;
              SetCapture(ParentForm.Handle);
              {$IFNDEF FPC}
              ClipCursor(@R);
              {$ENDIF}
              FMouseAction := maSelecting;     
              ParentForm.ActiveControl := nil;
              Message := 0;
            end
            else
            begin
              GetCursorPos(FDragPoint);
              if Assigned(FGrabHandles) then
              begin
                FDragHandle := FGrabHandles.FindHandle(hwnd);
                if not IsProtected(NewControl) or (NewControl = FDesignControl) then
                  FGrabHandles.Enabled := False;
              end
              else
                FDragHandle := gpNone;
              FGrabHandles.Enabled := False;
              {$IFNDEF GFDXPTHEMES}
              
              {$ENDIF}
              if FDragHandle = gpNone then
              begin
                if ValidControl(NewControl) then
                  if not IsProtected(NewControl) then
                  begin
                    {$IFDEF TFDTRIAL}
                    if NewControl.Parent<>ParentForm then
                    begin
                      Message:=0;
                      ShowTrialWarning;
                      Exit;
                    end;
                    {$ENDIF}
                    ParentForm.ActiveControl := nil;
                    if FMultiSelect and (GetKeyState(VK_SHIFT) and $80 <> 0) then
                    begin
                      if ControlIndex(NewControl) = -1 then
                      begin
                        
                        AddControl(NewControl);
                      end
                      else
                      if ControlCount > 1 then
                      begin
                        DeleteControl(NewControl);
                        NewControl.Invalidate;
                        if ControlCount = 1 then Control.Invalidate;
                      end;
                      DoSelectionChange;
                      if Assigned(FGrabHandles) and (FGrabHandles.Control <> Control) then
                        FGrabHandles.Control := Control;
                      
                      Message := 0;
                      Exit;
                    end
                    else
                    begin
                      if (ControlIndex(NewControl) <> -1) and (ControlCount > 1) then
                      begin
                        AddControl(NewControl);
                        DoSelectionChange;
                        if CheckParent(NewControl, True) then Message := 0;
                      end
                      else
                      begin
                        if ControlCount > 1 then
                          while ControlCount > 0 do
                          begin
                            DoDeleteControl(FControls[0]);
                            TControl(FControls[0]).Invalidate;
                            FControls.Delete(0);
                          end;
                        if NewControl <> Control then
                        begin
                          if Assigned(Control) then DoDeleteControl(Control);
                          FControls.Clear;
                          AddControl(NewControl);
                          DoSelectionChange;
                        end;
                        if IsLocked(NewControl) then
                        begin
                          FGrabHandles.Control := Control;
                          Message := 0;
                          Exit;
                        end;
                      end;
                    end;
                  end
                  else
                  begin
                    if (FProtectMode = pmUnselect) and (NewControl <> Control) then
                    begin
                      Control := nil;
                      DoSelectionChange;
                      if NewControl is TWinControl then
                        with TWinControl(NewControl) do
                          if Showing and CanFocus then SetFocus;
                    end;
                    if NewControl = FDesignControl then
                    begin
                      Control := nil;
                      DoSelectionChange;
                    end;
                    Exit;
                  end
                else
                begin
                  if GetPopupParent(hwnd) = ParentForm.Handle then
                  begin
                    Control := nil;
                    DoSelectionChange;
                    ParentForm.ActiveControl := nil;
                  end;
                end;
              end
              else
                NewControl := nil;
              
              ParentForm.Repaint;
              if ValidControl(NewControl) and not IsLocked(NewControl) or
                ValidControl(Control) and not IsLocked(Control) and
                (FDragHandle <> gpNone) then
              begin
                Screen.Cursor := GetGrabCursor(FDragHandle);
                if ValidControl(Control) then
                begin
                  FDragRect := Control.BoundsRect;
                  FGrabHandles.Control := Control;
                  if ValidControl(Control) and ValidControl(Control.Parent) then
                  begin
                    
                    with Control.Parent, R do
                    begin
                      R := ClientRect;
                      if Assigned(FOnMoveLimit) then FOnMoveLimit(Self, Control, R);
                      if FMoveLimitMode = lmControls then
                      begin
                        Min.X := MaxInt;
                        Min.Y := MaxInt;
                        Max.X := -MaxInt;
                        Max.Y := -MaxInt;
                        for i := 0 to Pred(Self.ControlCount) do
                        begin
                          with Self.Controls[i] do
                          begin
                            if Left < Min.X then Min.X := Left;
                            if Top < Min.Y then Min.Y := Top;
                            if Left + Width > Max.X then Max.X := Left + Width;
                            if Top + Height > Max.Y then Max.Y := Top + Height;
                          end;
                        end;
                        if FDragHandle = gpNone then
                          with ScreenToClient(FDragPoint) do
                          begin
                            Inc(Left, X - Min.X);
                            Inc(Top, Y - Min.Y);
                            Dec(Right, Max.X - X);
                            Dec(Bottom, Max.Y - Y);
                          end;
                      end;
                      TopLeft := ClientToScreen(TopLeft);
                      BottomRight := ClientToScreen(BottomRight);
                    end;
                    SetCapture(ParentForm.Handle);
                    {$IFNDEF FPC} ClipCursor(@R); {$ENDIF}
                  end;
                end;
                Message := 0;
                FMouseAction := maDragging;
                if ValidControl(Control) then
                begin
                  FControlRect := Control.BoundsRect;
                  with Control do
                    if FDragHandle <> gpNone then
                      Self.ShowHint(Format('%d x %d', [Width, Height]), hmSize)
                    else
                      Self.ShowHint(Format('%d, %d', [Left, Top]), hmMove);
                end;
              end
              else
                Message := 0;
            end;
          end;
          WM_LBUTTONUP, WM_NCLBUTTONUP:
          begin
            HideHint;
            if (Message = WM_NCLBUTTONUP) and
              ((hwnd = ParentForm.Handle) or (wParam <> HTCLIENT)) then Exit;
            case MouseAction of
              maDragging:
              begin
                
                FMouseAction := maNone;
                FDragHandle := gpNone;
                if ControlCount > 1 then
                begin
                  NewDrag.X := FDragRect.Left - Control.Left;
                  NewDrag.Y := FDragRect.Top - Control.Top;
                  for i := 0 to Pred(ControlCount) do
                  begin
                    R := Controls[i].BoundsRect;
                    OffsetRect(R, NewDrag.X, NewDrag.Y);
                    if not EqualRect(R, Controls[i].BoundsRect) then
                    begin
                      Controls[i].BoundsRect := R;
                      
                    end;
                  end;
                  
                  DoMoveSizeControl;
                  DoChange;
                end
                else
                begin
                  R := NormalRect(FDragRect);
                  if ValidControl(Control) then
                  begin
                    if Assigned(FOnSizeLimit) then
                      with R do
                      begin
                        Min := Point(0, 0);
                        Max := Point(MaxInt, MaxInt);
                        FOnSizeLimit(Self, Control, Min, Max);
                        if Right - Left < Min.X then Right := Left + Min.X;
                        if Bottom - Top < Min.Y then Bottom := Top + Min.Y;
                        if Right - Left > Max.X then Right := Left + Max.X;
                        if Bottom - Top > Max.Y then Bottom := Top + Max.Y;
                      end;
                    if not EqualRect(R, Control.BoundsRect) then
                    begin
                      Control.BoundsRect := R;
                      
                      DoMoveSizeControl;
                      DoChange;
                    end;
                    FDragRect := Control.BoundsRect;
                    ScrollBoxPos(Control);
                  end;
                end;
                
                Message := 0;
                if Assigned(FGrabHandles) then
                  with FGrabHandles do
                  begin
                    if FindHandle(hwnd) = gpNone then SetArrowCursor;
                    Enabled := True;
                    Update(True);
                  end
                else
                  SetArrowCursor;
                
                if GetCapture = ParentForm.Handle then ReleaseCapture;
                {$IFNDEF FPC}
                ClipCursor(nil);
                {$ENDIF}
                if FAlignmentLines <> [] then ParentForm.Invalidate
                else SendMessage(ParentForm.Handle, WM_ERASEBKGND, 0, 0);
              end;
              maSelecting:
              begin
                FMouseAction := maNone; 
                
                Lock;
                try
                  if Assigned(FSelectControl) then
                  begin
                    with FSelectControl do
                    begin
                      FSelectRect := NormalRect(FSelectRect);
                      with FSelectRect do
                      begin
                        TopLeft := ScreenToClient(TopLeft);
                        BottomRight := ScreenToClient(BottomRight);
                      end;
                      if Assigned(FOnEndSelecting) then
                        FOnEndSelecting(Self, FSelectRect);
                      for i := 0 to Pred(ControlCount) do
                        if not IsTransparent(Controls[i]) and
                          not IsProtected(Controls[i]) and
                          ((csDesigning in Controls[i].ComponentState) or
                          Controls[i].Visible) and (Controls[i].Owner = ParentForm) and
                          {$IFNDEF NOCSSUBCOMPONENT}
                          not (csSubComponent in Controls[i].ComponentStyle) and
                          {$ENDIF}
                          (Controls[i].Parent.Showing) then
                        begin
                          IntersectRect(R, FSelectRect, Controls[i].BoundsRect);
                          if not IsRectEmpty(R) then
                          begin
                            with FControls do
                            begin
                              if (IndexOf(Controls[i]) = -1) and
                                DoValidateSelection(Controls[i]) then
                              begin
                                Insert(0, Controls[i]);
                                
                                DoAddControl(Controls[i]);
                              end;
                            end;
                            DoSelectControl(Controls[i]);
                          end;
                        end;
                    end;
                    DoSelectionChange;
                    if (ControlCount = 1) and Assigned(FGrabHandles) then
                      with FGrabHandles do
                      begin
                        Control := Self.Control;
                        Enabled := True;
                        Update(False);
                      end;
                    if Assigned(FGrabHandles) then
                      with FGrabHandles do
                      begin
                        Enabled := True;
                        Update(False);
                      end;
                  end;
                finally
                  Unlock;
                end;
                
                Message := 0;
                if GetCapture = ParentForm.Handle then ReleaseCapture;
                {$IFNDEF FPC}
                ClipCursor(nil);
                {$ENDIF}
              end;
              else
              begin
                if not IsProtected(Control) and Assigned(FGrabHandles) then
                  with FGrabHandles do
                  begin
                    if FindHandle(hwnd) = gpNone then SetArrowCursor;
                    if not Enabled then
                    begin
                      Enabled := True;
                      Update(True);
                    end;
                  end;
              end;
            end;
            {$IFDEF LIKE236}
            Application.ProcessMessages;
            {$ENDIF}
          end;
          WM_MOUSEMOVE, WM_NCMOUSEMOVE:
            if GetPopupParent(hwnd) = ParentForm.Handle then
            begin
              if not ValidControl(Control) and (GetCapture = ParentForm.Handle) and
                not ((Message <> WM_NCMOUSEMOVE) and (hwnd = ParentForm.Handle)) then
                ReleaseCapture;
              if GetKeyState(VK_LBUTTON) and $80 = 0 then
              begin
                if IsProtected(GetMouseControl(hwnd, lParam)) or not
                  InDesignControl(hwnd) then Screen.Cursor := crDefault;
                LeaveMouseAction;
                NewControl := GetMouseControl(hwnd, LParam);
                if FShowComponentHint and Assigned(NewControl) and
                  not IsProtected(NewControl) and (GetCapture = 0) then
                begin
                  if FHintControl <> NewControl then
                  begin
                    FHintControl := NewControl;
                    if FHintTimer.Enabled then
                    begin
                      ShowHint(GetComponentHint(NewControl), hmCustom);
                      StartTimer(Application.HintHidePause);
                    end
                    else
                      StartTimer(Application.HintPause);
                  end
                  else
                  if not FHintTimer.Enabled then StartTimer(Application.HintHidePause);
                end
                else
                begin
                  FHintControl := nil;
                  StopTimer;
                  HideHint;
                end;
              end;
              case FMouseAction of
                maDragging:
                  if FIgnoreMouseMove then FIgnoreMouseMove := False
                  else
                  begin
                    StopTimer;
                    if GetKeyState(VK_LBUTTON) and $80 = 0 then LeaveMouseAction
                    else
                    if ValidControl(Control) then
                    begin
                      if FDirectMove and (FDragHandle = gpNone) then
                      begin
                        GetCursorPos(CP);
                        if (CP.X <> FCursorPos.X) or (CP.X <> FCursorPos.X) then
                        begin
                          DX := CP.X - FDragPoint.X;
                          DY := CP.Y - FDragPoint.Y;
                          if FSnapToGrid then
                          begin
                            DX := Trunc(DX / FGridStep) * FGridStep;
                            DY := Trunc(DY / FGridStep) * FGridStep;
                          end;
                          R := FControlRect;
                          OffsetRect(R, DX, DY);
                          OffsetRect(R, -Control.Left, -Control.Top);
                          DX := R.Left;
                          DY := R.Top;
                          
                          if (DX <> 0) or (DY <> 0) then
                          begin
                            for i := 0 to Pred(ControlCount) do
                            begin
                              R := Controls[i].BoundsRect;
                              OffsetRect(R, DX, DY);
                              Controls[i].BoundsRect := R;
                            end;
                            DoMoveSizeControl;
                            DoChange;
                          end;
                          GetCursorPos(FCursorPos);
                          FDragRect := Control.BoundsRect;
                          if not EqualRect(R, FDragRect) then
                          begin
                            HideHint;
                            P := GetControlsOrigin;
                            Self.ShowHint(Format('%d, %d', [P.X, P.Y]), hmMove);
                          end;
                          
                        end;
                      end
                      else
                      begin
                        GetCursorPos(NewDrag);
                        with NewDrag do
                        begin
                          X := X - FDragPoint.X;
                          Y := Y - FDragPoint.Y;
                          if FEnableAxisDrag and
                            (GetKeyState(VK_CONTROL) and $80 <> 0) then
                            if (X <> 0) and (Y <> 0) then
                            begin
                              if Abs(Y) > Abs(X) then X := 0
                              else
                                Y := 0;
                            end;
                          if (FDragHandle = gpNone) and
                            FSnapToGrid and (GetKeyState(VK_MENU) and $80 = 0) then
                          begin
                            {$IFDEF GFDADVANCEDGRID}
                              X:=Round(X/FGridStepX)*FGridStepX;
                              Y:=Round(Y/FGridStepY)*FGridStepY;
                            {$ELSE}
                            X := Round(X / FGridStep) * FGridStep;
                            Y := Round(Y / FGridStep) * FGridStep;
                            {$ENDIF}
                          end;
                        end;
                        if ValidControl(Control) then R := Control.BoundsRect;
                        with NewDrag do
                          case FDragHandle of
                            {$IFDEF GFD2542921}
                              gpNone: if Control.Tag<>2542921 then OffsetRect(R,X,Y);
                            {$ELSE}
                            gpNone:
                            begin
                              OffsetRect(R, X, Y);
                              if FMoveLimitMode = lmControls then
                                with R do
                                begin
                                  if Left < 0 then OffsetRect(R, FGridStep, 0);
                                  if Top < 0 then OffsetRect(R, 0, FGridStep);
                                  if Right > Control.Parent.ClientWidth then
                                    OffsetRect(R, -FGridStep, 0);
                                  if Bottom > Control.Parent.ClientHeight then
                                    OffsetRect(R, 0, -FGridStep);
                                end;
                            end;
                              {$ENDIF}
                            else
                              with R do
                              begin
                                case FDragHandle of
                                  gpLeftTop:
                                  begin
                                    Left := Left + X;
                                    Top := Top + Y;
                                  end;
                                  gpLeftMiddle: Left := Left + X;
                                  gpLeftBottom:
                                  begin
                                    Left := Left + X;
                                    Bottom := Bottom + Y;
                                  end;
                                  gpMiddleTop: Top := Top + Y;
                                  gpMiddleBottom: Bottom := Bottom + Y;
                                  gpRightTop:
                                  begin
                                    Right := Right + X;
                                    Top := Top + Y;
                                  end;
                                  gpRightMiddle: Right := Right + X;
                                  gpRightBottom:
                                  begin
                                    Right := Right + X;
                                    Bottom := Bottom + Y;
                                  end;
                                end;
                                if FSnapToGrid and
                                  (GetKeyState(VK_MENU) and $80 = 0) then
                                begin
                                  {$IFDEF GFDADVANCEDGRID}
                                  if FDragHandle in [gpLeftTop,gpLeftMiddle,gpLeftBottom] then
                                    Left:=Round(Left/FGridStepX)*FGridStepX;
                                  if FDragHandle in [gpLeftTop,gpMiddleTop,gpRightTop] then
                                    Top:=Round(Top/FGridStepY)*FGridStepY;
                                  if FDragHandle in [gpRightTop,gpRightMiddle,gpRightBottom] then
                                    Right:=Succ(Round(Right/FGridStepX)*FGridStepX);
                                  if FDragHandle in [gpLeftBottom,gpMiddleBottom,gpRightBottom] then
                                    Bottom:=Succ(Round(Bottom/FGridStepY)*FGridStepY);
                                  {$ELSE}
                                  if FDragHandle in
                                    [gpLeftTop, gpLeftMiddle, gpLeftBottom] then
                                    Left := Round(Left / FGridStep) * FGridStep;
                                  if FDragHandle in
                                    [gpLeftTop, gpMiddleTop, gpRightTop] then
                                    Top := Round(Top / FGridStep) * FGridStep;
                                  if FDragHandle in
                                    [gpRightTop, gpRightMiddle, gpRightBottom] then
                                    Right := Succ(Round(Right / FGridStep) * FGridStep);
                                  if FDragHandle in
                                    [gpLeftBottom, gpMiddleBottom, gpRightBottom] then
                                    Bottom := Succ(Round(Bottom / FGridStep) * FGridStep);
                                  {$ENDIF}
                                end;
                                if GetKeyState(VK_SHIFT) and $80 <> 0 then
                                  if Abs(Right - Left) / (Control.Width) <
                                    Abs(Bottom - Top) / Control.Height then
                                    Bottom :=
                                      Top + (Right - Left) * Control.Height div Control.Width
                                  else
                                    Right :=
                                      Left + (Bottom - Top) * Control.Width div Control.Height;
                              end;
                          end;
                        if not EqualRect(R, FDragRect) then
                        begin
                          HideHint;
                          
                          FDragRect := R;
                          
                          with FDragRect do
                            if FDragHandle <> gpNone then
                              Self.ShowHint(Format('%d x %d', [Abs(Right - Left), Abs(Bottom - Top)]), hmSize)
                            else
                            begin
                              P := GetControlsOrigin;
                              Inc(P.X, FDragRect.Left - Control.Left);
                              Inc(P.Y, FDragRect.Top - Control.Top);
                              Self.ShowHint(Format('%d, %d', [P.X, P.Y]), hmMove);
                            end;
                        end;
                      end;
                    end;
                  end;
                maSelecting:
                  if GetKeyState(VK_LBUTTON) and $80 = 0 then LeaveMouseAction
                  else
                  begin
                    
                    GetCursorPos(FSelectRect.BottomRight);
                    if FSelectCounter = 0 then FSelectRect.TopLeft := FSelectRect.BottomRight;
                    
                    Inc(FSelectCounter);
                  end;
                else
                  if GetCapture = 0 then
                  begin
                    NewControl := GetMouseControl(HWND, lParam);
                    if ValidControl(NewControl) then
                    begin
                      if Assigned(FGrabHandles) and
                        (FGrabHandles.FindHandle(HWND) = gpNone) then
                        if IsProtected(NewControl) or IsTransparent(NewControl) or
                          not InDesignControl(hwnd) then
                          Screen.Cursor := crDefault
                        else
                          SetArrowCursor
                      else
                      if Assigned(FGrabHandles) and
                        (FGrabHandles.FindHandle(HWND) <> gpNone) then
                        Screen.Cursor := crDefault
                      else
                      if IsLocked(NewControl) then SetArrowCursor;
                    end
                    else
                      Screen.Cursor := crDefault;
                  end;
              end;
            end;
          WM_KEYDOWN:
            
            begin
              if FSnapToGridKey then
                if GetKeyState(VK_SHIFT) and $80 <> 0 then
                  if GetKeyState(VK_CONTROL) and $80 <> 0 then KeyType := ktFastMove
                  else
                    KeyType := ktSize
                else
                if GetKeyState(VK_CONTROL) and $80 <> 0 then KeyType := ktFastMove
                else
                  KeyType := ktSelect
              else
              if GetKeyState(VK_SHIFT) and $80 <> 0 then
                if GetKeyState(VK_CONTROL) and $80 <> 0 then KeyType := ktFastMove
                else
                  KeyType := ktSize
              else
              if GetKeyState(VK_CONTROL) and $80 <> 0 then KeyType := ktMove
              else
                KeyType := ktSelect;
              if (KeyType = ktSelect) and not FKeySelect then Exit;
              if (KeyType <> ktSelect) and not FKeyMove then Exit;
              case wParam of
                VK_ESCAPE:
                  if MouseAction <> maNone then LeaveMouseAction
                  else
                  begin
                    Control := SelectableParent(Control);
                    DoSelectionChange;
                  end;
                VK_TAB:
                begin
                  Control := FindNextControl(GetKeyState(VK_SHIFT) and $80 = 0);
                  if ValidControl(Control) then Message := 0;
                  ScrollBoxPos(Control);
                  DoSelectionChange;
                end;
                VK_RIGHT, VK_LEFT, VK_UP, VK_DOWN:
                begin
                  ProcessKey(wParam);
                  if ValidControl(Control) then Message := 0;
                  ScrollBoxPos(Control);
                end;
                else
                begin
                  if Assigned(FOnKeyDown) then
                  begin
                    Key := wParam;
                    FOnKeyDown(Self, Key, KeyDataToShiftState(lParam));
                    wParam := Key;
                  end;
                  Exit;
                end;
              end;
            end;
          WM_KEYUP:
            case wParam of
              VK_TAB, VK_RIGHT, VK_LEFT, VK_UP, VK_DOWN: Message := 0;
              else
                if Assigned(FOnKeyUp) then
                begin
                  Key := wParam;
                  FOnKeyUp(Self, Key, KeyDataToShiftState(lParam));
                  wParam := Key;
                end;
            end;
          CN_HSCROLL, CN_VSCROLL, WM_VSCROLL, WM_HSCROLL:
            FGrabHandles.Update(False);
          WM_SYSKEYDOWN, WM_SYSKEYUP: ;
          {$IFNDEF NOMOUSEWHEEL}
          WM_MOUSEWHEEL: ParentForm.DefaultHandler(Msg);
          {$ENDIF}
        end; 

      finally
        Unlock;
      end;
    end
    else
    if IsActiveOwner then
      if GetPopupParent(Msg.hwnd) <> ParentForm.Handle then Screen.Cursor := crDefault
      else
        SetArrowCursor;
  end
  else
  begin

    Screen.Cursor := crDefault;
    if FWaiting then
      with Msg, ParentForm do
        case Message of
          WM_CAPTURECHANGED: if {$IFDEF FPC} not Assigned(FPlacingParent) or {$ENDIF} (hwnd <> FPlacingParent.Handle) then CancelPlacing;
          WM_LBUTTONDOWN:
          begin
            if (GetPopupParent(hwnd) = ParentForm.Handle) and InDesignControl(hwnd) then
            begin
              FMouseAction := maPlacing; 
              Message := 0;
              if hwnd = Handle then FPlacingParent := ParentForm
              else
              begin
                FPlacingParent := FindWinControl(hwnd);
                while Assigned(FPlacingParent) and not (csAcceptsControls in FPlacingParent.ControlStyle) do
                  FPlacingParent := FPlacingParent.Parent;
              end;
              if not Assigned(FPlacingParent) then FPlacingParent := ParentForm;
              if Assigned(FPlacingParent) and Assigned(FPlacedComponent) then
              begin
                if (GetCapture <> FPlacingParent.Handle) then
                  SetCapture(FPlacingParent.Handle);
                with FPlacingRect do
                begin
                  
                  TopLeft := FPlacingParent.ScreenToClient(Point(Mouse.CursorPos.x, Mouse.CursorPos.y));
                  {$IFDEF FPC}
                  {$ELSE}
                  MapWindowPoints(hwnd, FPlacingParent.Handle, TopLeft, 1);
                  {$ENDIF}
                  BottomRight := TopLeft;
                end;
                
                FDefaultPlacing := True;
              end;
            end;
          end;
          WM_MOUSEMOVE:
            if FMouseAction = maPlacing then
              with FPlacingRect do
              begin
                
                BottomRight := FPlacingParent.ScreenToClient(Point(Mouse.CursorPos.x, Mouse.CursorPos.y));
                
                {$IFDEF FPC}
                {$ELSE}
                MapWindowPoints(hwnd, FPlacingParent.Handle, BottomRight, 1);
                {$ENDIF}
                
                if (Top <> Bottom) or (Left <> Right) then FDefaultPlacing := False;
              end;
          WM_LBUTTONUP:
          begin
            if FMouseAction = maPlacing then
            begin
              FMouseAction := maNone; 
              ReleaseCapture;
              
              Message := 0;
              if hwnd = Handle then WinControl := ParentForm
              else
              begin
                WinControl := FindWinControl(hwnd);
                while Assigned(WinControl) and not
                  (csAcceptsControls in WinControl.ControlStyle) do
                  WinControl := WinControl.Parent;
              end;
              if Assigned(WinControl) and
                ((InDesignControl(WinControl.Handle)) or (WinControl = ParentForm) or
                not IsProtected(WinControl)) and Assigned(FPlacedComponent) then
                if Assigned(FPlacedComponent) then
                  if not AutoName(FPlacedComponent) then
                  begin
                    FPlacedComponent.Free;
                    FPlacedComponent := nil;
                  end
                  else
                  begin
                    FPlacingRect := NormalRect(FPlacingRect);
                    {$IFDEF FPC}
                    {$ELSE}
                    MapWindowPoints(hwnd, WinControl.Handle, FPlacingRect, 2);
                    {$ENDIF}
                    if Assigned(FOnEndPlacing) then FOnEndPlacing(Self, FPlacingRect);
                    if FPlacedComponent is TControl then
                      with TControl(FPlacedComponent) do
                      begin
                        if FDefaultPlacing then
                        begin
                          Left := FPlacingRect.Left;
                          Top := FPlacingRect.Top;
                        end
                        else
                          with FPlacingRect do
                            if ((Right - Left) > 10) and (Bottom - Top > 10) then
                              SetBounds(Left, Top, Right - Left, Bottom - Top)
                            else
                              SetBounds(Left, Top, Width, Height);
                        if FSnapToGrid then AlignToGrid(TControl(FPlacedComponent));
                        Parent := WinControl;
                        {$IFDEF GFDHIDEINVISIBLE}
                        with ParentForm do
                          for i:=0 to Pred(ComponentCount) do
                            if (Components[i] is TWinControl) then
                              with TWinControl(Components[i]) do
                                if not Visible and (csDesigning in ComponentState) then
                                  ShowWindow(Handle,SW_HIDE);
                        {$ENDIF}
                      end
                    else
                    begin
                      CC := FindComponentContainer(FPlacedComponent);
                      if Assigned(CC) then
                      begin
                        with CC do
                        begin
                          Left := FPlacingRect.Left;
                          Top := FPlacingRect.Top;
                          Visible := True;
                          ShowWindow(Handle, SW_SHOW);
                        end;
                        if FSnapToGrid then AlignToGrid(CC);
                      end;
                    end;
                    FGrabHandles.FEnabled := True;
                    Component := FPlacedComponent;
                    
                    if Assigned(FOnPlaceComponent) then FOnPlaceComponent(Self, Component);
                    FPlacedComponent := nil;
                  end;
              if Assigned(FPlacedComponent) then
              begin
                FPlacedComponent.Free;
                FPlacedComponent := nil;
              end;
              Unlock;
              FWaiting := False;
            end;
          end;
        end
    else
    if Assigned(FOnMessage) and (GetPopupParent(Msg.hwnd) = ParentForm.Handle) then
      FOnMessage(Self, Msg);
    ParentForm.SetFocus;
  end;
  
  DrawEnvironment;
  {$IFDEF UNIX}
  FMouseTimer.Enabled:=FDragHandle<>gpNone;
  {$ENDIF}
end;

procedure TCustomFormDesigner.DoMoveSizeControl;
var
  i: integer;
begin
  if Assigned(FOnMoveSizeControl) then
    for i := 0 to Pred(ControlCount) do FOnMoveSizeControl(Self, Controls[i]);
  {$IFDEF GFDIDEVENTS}
  if Assigned(FOnMoveSizeControlID) then
  begin
    Inc(FActionID);
    for i:=0 to Pred(ControlCount) do FOnMoveSizeControlID(Self,Controls[i],FActionID);
  end;
  {$ENDIF GFDIDEVENTS}
end;

procedure TCustomFormDesigner.DoChange;
begin
  FModified := True;
  if not SynchroLocked and Assigned(FOnChange) then FOnChange(Self);
end;

procedure TCustomFormDesigner.DoSelectControl(AControl: TControl);
var
  OldControl: TControl;
begin
  if Assigned(AControl) then
  begin
    if AControl is TComponentContainer then
    begin
      OldControl := AControl;
      if Assigned(TComponentContainer(AControl).Component) then
      try
        AControl := TControl(TComponentContainer(AControl).Component);
      except
        AControl := OldControl;
      end;
    end;
  end;
  if Assigned(FOnSelectControl) then
    FOnSelectControl(Self, AControl);
end;

procedure TCustomFormDesigner.DoSelectionChange;
begin
  if not SynchroLocked and Assigned(FOnSelectionChange) then
    FOnSelectionChange(Self);
  DrawEnvironment;
end;

procedure TCustomFormDesigner.DoAddControl(AControl: TControl);
begin
  if Assigned(FOnAddControl) then FOnAddControl(Self, AControl);
end;

procedure TCustomFormDesigner.DoDeleteControl(AControl: TControl);
begin
  if Assigned(FOnDeleteControl) then FOnDeleteControl(Self, AControl);
end;

function TCustomFormDesigner.GetEditBehaviour(AControl: TControl): TEditBehaviour;
var
  AComponent: TComponent;
begin
  Result := ebDefault;
  if Assigned(AControl) then
  begin
    if AControl is TComponentContainer then
      AComponent := TComponentContainer(AControl).Component
    else
      AComponent := AControl;
    if Assigned(AComponent) and Assigned(FOnEditBehaviour) then
      FOnEditBehaviour(Self, AComponent, Result);
  end;
end;

procedure TCustomFormDesigner.KeyEventDown(Sender: TObject; var Key: Word; Shift: TShiftState);
  var iMsg: TMsg;
begin
  if Assigned(ParentForm) and (Assigned(Screen.ActiveControl) and (
    (Screen.ActiveControl = ParentForm) or
    (Screen.ActiveControl.Owner = ParentForm)) or
    
    not Assigned(Screen.ActiveControl)) then
  begin
    iMsg.message := WM_KEYDOWN;
    iMsg.wParam:=Key;
    if iMsg.wParam > 0 then MessageProc(iMsg);
  end;
end;

procedure TCustomFormDesigner.ParentFormPaint(Sender: TObject);
begin
  if Assigned(OnPaintOld) then OnPaintOld(Sender);

  if Assigned(ParentForm) then DrawBackground;
end;

procedure TCustomFormDesigner.ParentFormDestroy(Sender: TObject);
begin
  TCustomForm(Sender).OnDestroy := Nil;
  TCustomForm(Sender).OnPaint := Nil;
  if Assigned(OnDestroyOld) then OnDestroyOld(Sender);

  ClearControls;
end;

{$IFDEF UNIX}
procedure TCustomFormDesigner.OnMouseTimer(Sender: TObject);
begin
  FMouseTimer.Enabled:= False;
  if GetKeyState(VK_LBUTTON) and $80 <> 0 then
  begin
    if (Mouse.CursorPos.x <> MouseX) or (Mouse.CursorPos.y <> MouseY) then
    begin
      MouseX := Mouse.CursorPos.x;
      MouseY := Mouse.CursorPos.y;

      UserInputEvent(ParentForm, LM_MOUSEMOVE);
    end else FMouseTimer.Enabled:= True;
  end else
  begin

    UserInputEvent(ParentForm, LM_LBUTTONUP);
    UserInputEvent(ParentForm, LM_LBUTTONDOWN);
    UserInputEvent(ParentForm, LM_LBUTTONUP);
  end;
end;
{$ENDIF}

procedure TCustomFormDesigner.DrawEnvironment;
var i, j: Integer;
    DRI: TDragRectsItem;
    GSI: TGrabSelectItem;
    DR: TRect;
    P: TPoint;
    GP: TGrabPosition;

  procedure DroppingTabOrder(WinControl: TWinControl);
    var i, j, k: Integer;
        List: {$IFDEF FPC} TFPList{$ELSE} TList{$ENDIF};
  begin
    List := {$IFDEF FPC} TFPList{$ELSE} TList{$ENDIF}.Create;
    try
      J:= 0; k := -1;
      WinControl.GetTabOrderList(List);
      for i := 0 to Pred(List.Count) do
        if TControl(List[i]).Owner = ParentForm then
        begin
          J:= I;
          if (TControl(List[i]) is TWinControl) and (csAcceptsControls in TWinControl(List[i]).ControlStyle) then
            DroppingTabOrder(TWinControl(List[i]));
        end else if k < 0 then k := i;
      if (k >= 0) and (J >= k) then
        for i := j downto 0 do if TControl(List[i]) is TWinControl then
          if TControl(List[i]).Owner <> ParentForm then TWinControl(List[i]).TabOrder := 32767;
    finally
      List.Free;
    end;
  end;

begin

  if (GetKeyState(VK_LBUTTON) and $80 = 0) then
  begin
    for i := FDragRects.Count - 1 downto 0 do TDragRectsItem(FDragRects.Items[i]).Visible := False;
  end else for i := FDragRects.Count - 1 downto 0 do
  begin
    DRI := TDragRectsItem(FDragRects.Items[i]);
    if ControlIndex(DRI.Control) < 0 then DRI.Visible := False;
  end;

  if (ControlCount <= 1) or (GetKeyState(VK_LBUTTON) and $80 <> 0) then
  begin
    for i := FGrabSelects.Count - 1 downto 0 do TGrabSelectItem(FGrabSelects.Items[i]).Visible := False;
  end else for i := FGrabSelects.Count - 1 downto 0 do
  begin
    GSI := TGrabSelectItem(FGrabSelects.Items[i]);
    if ControlIndex(GSI.Control) < 0  then GSI.Visible := False;
  end;

  if (FMouseAction <> maPlacing) or (GetKeyState(VK_LBUTTON) and $80 = 0) then
    for I := 0 to High(FPlacingRectArray) do FPlacingRectArray[I].Visible := False;

  if (FMouseAction <> maSelecting) or (GetKeyState(VK_LBUTTON) and $80 = 0) then
    for I := 0 to High(FSelectRectArray) do FSelectRectArray[I].Visible := False;

  if not Assigned(ParentForm) then Exit;

  DroppingTabOrder(ParentForm);

  if (FMouseAction = maDragging) and (GetKeyState(VK_LBUTTON) and $80 <> 0) and ValidControl(Control) and Assigned(ParentForm) then
  begin
    for i := 0 to Pred(ControlCount) do
    begin
      if (Controls[i] is TCustomGroupBox) or (Controls[i] is TScrollBox) then
        DR := Controls[i].Parent.ClientToScreen(Controls[i].BoundsRect)
      else DR := Controls[i].ClientToScreen(Controls[i].ClientRect);
      DR.TopLeft := ParentForm.ScreenToClient(DR.TopLeft);
      DR.BottomRight := ParentForm.ScreenToClient(DR.BottomRight);

      if i = 0 then
      begin
        P.x := FDragRect.Left - Controls[i].BoundsRect.Left;
        P.y := FDragRect.Top - Controls[i].BoundsRect.Top;
      end;
      Types.OffsetRect(DR, P.x, P.y);

      DRI := Nil;
      for j := 0 to FDragRects.Count - 1 do
        if TDragRectsItem(FDragRects.Items[j]).Control = Controls[i] then
        begin
          DRI := TDragRectsItem(FDragRects.Items[j]);
          Break;
        end;

      if not Assigned(DRI) then
      begin
        DRI := TDragRectsItem(FDragRects.Add);
        DRI.Control := Controls[i];
      end;

      DRI.SetRectangle(ParentForm, DR, 1);
    end;
  end;

  if (ControlCount > 1) and (GetKeyState(VK_LBUTTON) and $80 = 0) then
    for I := 0 to Pred(ControlCount) do
    begin
      if (Controls[i] is TCustomGroupBox) or (Controls[i] is TScrollBox) then
        DR := Controls[i].Parent.ClientToScreen(Controls[i].BoundsRect)
      else DR := Controls[i].ClientToScreen(Controls[i].ClientRect);
      DR.TopLeft := ParentForm.ScreenToClient(DR.TopLeft);
      DR.BottomRight := ParentForm.ScreenToClient(DR.BottomRight);

      GSI := Nil;
      for j := 0 to FGrabSelects.Count - 1 do
        if TGrabSelectItem(FGrabSelects.Items[j]).Control = Controls[i] then
        begin
          GSI := TGrabSelectItem(FGrabSelects.Items[j]);
          Break;
        end;

      if not Assigned(GSI) then
      begin
        GSI := TGrabSelectItem(FGrabSelects.Add);
        GSI.Control := Controls[i];
      end;

      if FUseGrabGlyphs then
      begin
        FMultiGrabGlyph.TransparentColor := FGrabsTransparentColor;
        GSI.SetGrabGlyph(ParentForm, FMultiGrabGlyph, DR, gmInside, FGrabSize)
      end
      else
      begin
        FMultiGrab.TransparentColor := FGrabsTransparentColor;
        GSI.SetGrabGlyph(ParentForm, FMultiGrab, DR, gmInside, FGrabSize);
      end;

    end;

  if (FMouseAction = maPlacing) and (GetKeyState(VK_LBUTTON) and $80 <> 0) then
  begin
    for I := 0 to High(FPlacingRectArray) do FPlacingRectArray[I].Parent := ParentForm;

    if Assigned(FPlacingParent) then
    begin
      DR.TopLeft := ParentForm.ScreenToClient(FPlacingParent.ClientToScreen(FPlacingRect).TopLeft);
      DR.BottomRight := ParentForm.ScreenToClient(FPlacingParent.ClientToScreen(FPlacingRect).BottomRight);
    end else DR := FPlacingRect;

    FPlacingRectArray[0].Top :=  Min(DR.Top, DR.Bottom) - 1;
    FPlacingRectArray[0].Left :=  Min(DR.Left, DR.Right);
    FPlacingRectArray[0].Height := 1;
    FPlacingRectArray[0].Width := Abs(DR.Width);

    FPlacingRectArray[1].Top :=  Min(DR.Top, DR.Bottom) - 1;
    FPlacingRectArray[1].Left := Min(DR.Left, DR.Right) - 1;
    FPlacingRectArray[1].Height := Abs(DR.Height) + 1;
    FPlacingRectArray[1].Width := 1;

    FPlacingRectArray[2].Top :=  Min(DR.Top, DR.Bottom) - 1;
    FPlacingRectArray[2].Left :=  Max(DR.Right, DR.Left);
    FPlacingRectArray[2].Height := Abs(DR.Height) + 1;
    FPlacingRectArray[2].Width := 1;

    FPlacingRectArray[3].Top :=  Max(DR.Bottom, DR.Top);
    FPlacingRectArray[3].Left :=  Min(DR.Left, DR.Right) - 1;
    FPlacingRectArray[3].Height := 1;
    FPlacingRectArray[3].Width := Abs(DR.Width) + 1;

    for I := 0 to High(FPlacingRectArray) do
    begin
      FPlacingRectArray[I].BringToFront;
      FPlacingRectArray[I].Visible := True;
    end;
  end;

  if (FMouseAction = maSelecting) and (GetKeyState(VK_LBUTTON) and $80 <> 0) then
  begin
    for I := 0 to High(FSelectRectArray) do FSelectRectArray[I].Parent := ParentForm;

    DR := FSelectRect;
    DR.TopLeft := ParentForm.ScreenToClient(DR.TopLeft);
    DR.BottomRight := ParentForm.ScreenToClient(DR.BottomRight);

    FSelectRectArray[0].Top :=  Min(DR.Top, DR.Bottom) - 1;
    FSelectRectArray[0].Left :=  Min(DR.Left, DR.Right);
    FSelectRectArray[0].Height := 1;
    FSelectRectArray[0].Width := Abs(DR.Width);

    FSelectRectArray[1].Top :=  Min(DR.Top, DR.Bottom) - 1;
    FSelectRectArray[1].Left := Min(DR.Left, DR.Right) - 1;
    FSelectRectArray[1].Height := Abs(DR.Height) + 1;
    FSelectRectArray[1].Width := 1;

    FSelectRectArray[2].Top :=  Min(DR.Top, DR.Bottom) - 1;
    FSelectRectArray[2].Left :=  Max(DR.Right, DR.Left);
    FSelectRectArray[2].Height := Abs(DR.Height) + 1;
    FSelectRectArray[2].Width := 1;

    FSelectRectArray[3].Top :=  Max(DR.Bottom, DR.Top);
    FSelectRectArray[3].Left :=  Min(DR.Left, DR.Right) - 1;
    FSelectRectArray[3].Height := 1;
    FSelectRectArray[3].Width := Abs(DR.Width) + 1;

    for I := 0 to High(FSelectRectArray) do
    begin
      FSelectRectArray[I].BringToFront;
      FSelectRectArray[I].Visible := True;
    end;
  end;
end;

procedure TCustomFormDesigner.GetPropSubsLongint(AInstance: TPersistent; PropName: string; var Value: Longint);
  var I: Integer;

  function BoolToInt(b: Boolean): Integer;
  begin
    if b then Result := 1 else Result := 0;
  end;

begin
  if (PropName = 'Enabled') or (PropName = 'Visible') then
  begin
    for I := 0 to FSubstProp.Count - 1 do
      if TSubstPropItem(FSubstProp.Items[I]).Control = AInstance then
      begin
         if (PropName = 'Enabled') then Value := BoolToInt(TSubstPropItem(FSubstProp.Items[I]).Enabled)
         else if (PropName = 'Visible') then Value := BoolToInt(TSubstPropItem(FSubstProp.Items[I]).Visible);
         Break;
     end;
  end;
end;

procedure TCustomFormDesigner.SetPropSubsLongint(AInstance: TPersistent; PropName: string; var Value: Longint);
  var I, Index: Integer;
      bDel: Boolean;
begin
  if not (AInstance is TControl) or (TControl(AInstance).Owner <> ParentForm) then Exit;

  if (PropName = 'Enabled') or (PropName = 'Visible') then
  begin
    Index:= -1;
    bDel:= False;
    for I := 0 to FSubstProp.Count - 1 do
      if TSubstPropItem(FSubstProp.Items[I]).Control = AInstance then
      begin
         if (PropName = 'Enabled') then TSubstPropItem(FSubstProp.Items[I]).Enabled := Value > 0
         else if (PropName = 'Visible') then TSubstPropItem(FSubstProp.Items[I]).Visible := Value > 0;
         Index:= I;
         bDel:= TSubstPropItem(FSubstProp.Items[I]).Enabled and TSubstPropItem(FSubstProp.Items[I]).Visible;
         Value:= 1;
         Break;
      end;

    if (Index >= 0) and bDel then FSubstProp.Delete(Index);

    if Index < 0 then
    begin
      with TSubstPropItem(FSubstProp.Add) do
      begin
        Control := TControl(AInstance);
        if (PropName = 'Enabled') then Enabled := Value > 0 else Enabled := True;
        if (PropName = 'Visible') then Visible := Value > 0 else Visible := True;
      end;
      Value:= 1;
    end;
  end;
end;

procedure TCustomFormDesigner.UpdateSubstProp;
  var I: Integer;
begin
  FSubstProp.Clear;

  for I := 0 to ParentForm.ComponentCount - 1  do
    if (ParentForm.Components[i].Owner = ParentForm) and (ParentForm.Components[i] is TControl) then
    begin
      if not TControl(ParentForm.Components[i]).Visible or not TControl(ParentForm.Components[i]).Enabled then
      begin
        with TSubstPropItem(FSubstProp.Add) do
        begin
          Control := TControl(ParentForm.Components[i]);
          Visible := TControl(ParentForm.Components[i]).Visible;
          Enabled := TControl(ParentForm.Components[i]).Enabled;
        end;
        TControl(ParentForm.Components[i]).Visible := True;
        TControl(ParentForm.Components[i]).Enabled := True;
      end;
    end;
end;

procedure TCustomFormDesigner.ClearSubstProp;
  var I: Integer;
begin
  for I := 0 to FSubstProp.Count - 1  do
    with TSubstPropItem(FSubstProp.Items[I]) do
    begin
      Control.Visible := Visible;
      Control.Enabled := Enabled;
    end;

  FSubstProp.Clear;
end;

function Designing: boolean;
begin
  Result := Assigned(Designers) and (Designers.Count > 0);
end;

initialization
  Designers := TList.Create;
  {$IFNDEF GFDTEXTCLIPBOARD}
  CF_GS_DesignedObjects := RegisterClipboardFormat(CF_GS_DESIGNEDOBJECTS_STR);
  {$ENDIF}
  {$IFDEF FPC}
  RegisterClass(TDesignForm);
  {$ENDIF}

finalization
  Designers.Free;
end.
