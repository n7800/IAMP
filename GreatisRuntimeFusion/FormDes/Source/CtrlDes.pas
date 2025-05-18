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

unit CtrlDes;

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages, Forms, 
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls;

type

  TMouseZone = (mzNone,mzFrame,mzLeftTop,mzCenterTop,mzRightTop,mzLeftCenter,mzRightCenter,mzLeftBottom,mzCenterBottom,mzRightBottom);
  THintMode = (hmMove,hmSize);
  TControlEvent = procedure(Sender: TObject; TheControl: TControl) of object;
  TControlAllowEvent = procedure(Sender: TObject; TheControl: TControl; var Allow: Boolean) of object;

  TCustomControlDesigner = class;

  TControlDesignerFrame = class(TCustomControl)
  private
    
    FRegion: HRGN;
    FDragRect: TRect;
    FDragPoint: TPoint;
    FDragZone: TMouseZone;
    FHintWindow: THintWindow;
    FControl: TControl;
    FThickness: Integer;
    FDirectDrag: Boolean;
    FMinSize: Integer;
    FShowMoveSizeHint: Boolean;
    FBorderColor: TColor;
    FFrameColor: TColor;
    FGrabColor: TColor;
    FEnableKeys: Boolean;
    FOnAllowSelectControl: TControlAllowEvent;
    FOnSelectControl: TControlEvent;
    FOnAllowDragControl: TControlAllowEvent;
    FOnDragControl: TControlEvent;
    FOnDblClick: TNotifyEvent;
    procedure UpdateShape;
    function MouseZone(X,Y: Integer): TMouseZone;
    procedure DrawDragRect;
    procedure ShowDragHint(AHint: string);
    procedure HideDragHint;
    function GetDesigner: TCustomControlDesigner;
    procedure SetControl(const Value: TControl);
    procedure SetThickness(const Value: Integer);
    procedure SetBorderColor(const Value: TColor);
    procedure SetFrameColor(const Value: TColor);
    procedure SetGrabColor(const Value: TColor);
    procedure SetEnableKeys(const Value: Boolean);
  protected
    
    procedure CreateHandle; override;
    procedure Paint; override;
    procedure WndProc(var Message: TMessage); override;
  public
    
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    procedure UpdatePosition;
    property Designer: TCustomControlDesigner read GetDesigner;
    property Control: TControl read FControl write SetControl;
    property Thickness: Integer read FThickness write SetThickness;
    property DirectDrag: Boolean read FDirectDrag write FDirectDrag;
    property MinSize: Integer read FMinSize write FMinSize;
    property ShowMoveSizeHint: Boolean read FShowMoveSizeHint write FShowMoveSizeHint;
    property BorderColor: TColor read FBorderColor write SetBorderColor;
    property FrameColor: TColor read FFrameColor write SetFrameColor;
    property GrabColor: TColor read FGrabColor write SetGrabColor;
    property EnableKeys: Boolean read FEnableKeys write SetEnableKeys;
    property OnAllowSelectControl: TControlAllowEvent read FOnAllowSelectControl write FOnAllowSelectControl;
    property OnSelectControl: TControlEvent read FOnSelectControl write FOnSelectControl;
    property OnAllowDragControl: TControlAllowEvent read FOnAllowDragControl write FOnAllowDragControl;
    property OnDragControl: TControlEvent read FOnDragControl write FOnDragControl;
    property OnDblClick: TNotifyEvent read FOnDblClick write FOnDblClick;
  end;

  TCustomControlDesigner = class(TComponent)
  private
    
    FFrame: TControlDesignerFrame;
    FActive: Boolean;
    procedure SetActive(const Value: Boolean);
    function GetControl: TControl;
    procedure SetControl(const Value: TControl);
    function GetThickness: Integer;
    procedure SetThickness(const Value: Integer);
    function GetDirectDrag: Boolean;
    procedure SetDirectDrag(const Value: Boolean);
    function GetMinSize: Integer;
    procedure SetMinSize(const Value: Integer);
    function GetShowMoveSizeHint: Boolean;
    procedure SetShowMoveSizeHint(const Value: Boolean);
    function GetBorderColor: TColor;
    procedure SetBorderColor(const Value: TColor);
    function GetFrameColor: TColor;
    procedure SetFrameColor(const Value: TColor);
    function GetGrabColor: TColor;
    procedure SetGrabColor(const Value: TColor);
    function GetEnableKeys: Boolean;
    procedure SetEnableKeys(const Value: Boolean);
    function GetOnAllowSelectControl: TControlAllowEvent;
    procedure SetOnAllowSelectControl(const Value: TControlAllowEvent);
    function GetOnSelectControl: TControlEvent;
    procedure SetOnSelectControl(const Value: TControlEvent);
    function GetOnAllowDragControl: TControlAllowEvent;
    procedure SetOnAllowDragControl(const Value: TControlAllowEvent);
    function GetOnDragControl: TControlEvent;
    procedure SetOnDragControl(const Value: TControlEvent);
    function GetOnDblClick: TNotifyEvent;
    procedure SetOnDblClick(const Value: TNotifyEvent);
  protected
    
  public
    
    constructor Create(AOwner: TComponent); override;
    procedure Update; virtual;
    property Active: Boolean read FActive write SetActive;
    property Control: TControl read GetControl write SetControl;
    property Thickness: Integer read GetThickness write SetThickness;
    property DirectDrag: Boolean read GetDirectDrag write SetDirectDrag;
    property MinSize: Integer read GetMinSize write SetMinSize;
    property ShowMoveSizeHint: Boolean read GetShowMoveSizeHint write SetShowMoveSizeHint;
    property BorderColor: TColor read GetBorderColor write SetBorderColor;
    property FrameColor: TColor read GetFrameColor write SetFrameColor;
    property GrabColor: TColor read GetGrabColor write SetGrabColor;
    property EnableKeys: Boolean read GetEnableKeys write SetEnableKeys;
    property OnAllowSelectControl: TControlAllowEvent read GetOnAllowSelectControl write SetOnAllowSelectControl;
    property OnSelectControl: TControlEvent read GetOnSelectControl write SetOnSelectControl;
    property OnAllowDragControl: TControlAllowEvent read GetOnAllowDragControl write SetOnAllowDragControl;
    property OnDragControl: TControlEvent read GetOnDragControl write SetOnDragControl;
    property OnDblClick: TNotifyEvent read GetOnDblClick write SetOnDblClick;
  end;

  TControlDesigner = class(TCustomControlDesigner)
  published
    
    property Active;
    property Control;
    property Thickness;
    property DirectDrag;
    property MinSize;
    property ShowMoveSizeHint;
    property BorderColor;
    property FrameColor;
    property GrabColor;
    property EnableKeys;
    property OnAllowSelectControl;
    property OnSelectControl;
    property OnAllowDragControl;
    property OnDragControl;
    property OnDblClick;
  end;

procedure Register;

implementation

procedure TControlDesignerFrame.UpdateShape;
var
  R: TRect;
  RGN: HRGN;
begin
  if FRegion<>0 then DeleteObject(FRegion);
  R:=Rect(0,0,Width,Height);
  with R do FRegion:=CreateRectRgn(Left,Top,Right,Bottom);
  InflateRect(R,-FThickness,-FThickness);
  with R do RGN:=CreateRectRgn(Left,Top,Right,Bottom);
  try
    CombineRgn(FRegion,FRegion,RGN,RGN_DIFF);
  finally
    DeleteObject(RGN);
  end;
  SetWindowRgn(Handle,FRegion,True);
end;

function TControlDesignerFrame.MouseZone(X,Y: Integer): TMouseZone;
begin
  Result:=mzNone;
  if Y<=FThickness then
    if X<=FThickness then Result:=mzLeftTop
    else
      if X>=Width-FThickness then Result:=mzRightTop
      else
        if (X>=(Width-FThickness) div 2) and (X<=(Width+FThickness) div 2) then Result:=mzCenterTop
        else Result:=mzFrame
  else
    if Y>=Height-FThickness then
      if X<=FThickness then Result:=mzLeftBottom
      else
        if X>=Width-FThickness then Result:=mzRightBottom
        else
          if (X>=(Width-FThickness) div 2) and (X<=(Width+FThickness) div 2) then Result:=mzCenterBottom
          else Result:=mzFrame
    else
      if X<=FThickness then
        if (Y>=(Height-FThickness) div 2) and (Y<=(Height+FThickness) div 2) then Result:=mzLeftCenter
        else Result:=mzFrame
      else
        if X>=Width-FThickness then
          if (Y>=(Height-FThickness) div 2) and (Y<=(Height+FThickness) div 2) then Result:=mzRightCenter
          else Result:=mzFrame;
end;

procedure TControlDesignerFrame.DrawDragRect;
var
  ParentCanvas: TCanvas;
begin
  if Assigned(Parent) then
  begin
    ParentCanvas:=TCanvas.Create;
    with ParentCanvas do
    begin
      {$IFNDEF FPC}
       Handle:=GetDCEx(Parent.Handle,0,DCX_CACHE or DCX_CLIPSIBLINGS or DCX_PARENTCLIP);
      {$ENDIF}
      try
        with Pen do
        begin
          Style:=psSolid;
          Mode:=pmXor;
          Width:=2;
          Color:=clGray;
        end;
        Brush.Style:=bsClear;
        with FDragRect do Rectangle(Left+1,Top+1,Right,Bottom);
      finally
        ReleaseDC(0,ParentCanvas.Handle);
        ParentCanvas.Handle:=0;
      end;
    end;
  end;
end;

procedure TControlDesignerFrame.ShowDragHint(AHint: string);
var
  R: TRect;
  P: TPoint;
begin
  if FShowMoveSizeHint then
    with FHintWindow do
    begin
      R:=CalcHintRect(255,AHint,nil);
      GetCursorPos(P);
      OffsetRect(R,P.X,P.Y+12);
      ActivateHint(R,AHint);
    end;
end;

procedure TControlDesignerFrame.HideDragHint;
begin
  FHintWindow.ReleaseHandle;
end;

function TControlDesignerFrame.GetDesigner: TCustomControlDesigner;
begin
  if Assigned(Owner) and (Owner is TCustomControlDesigner) then
    Result:=TCustomControlDesigner(Owner)
  else Result:=nil;
end;

procedure TControlDesignerFrame.SetControl(const Value: TControl);
var
  Allow: Boolean;
begin
  if (csDesigning in ComponentState) or not Assigned(Designer) or not Designer.Active then
  begin
    FControl:=Value;
    Visible:=False;
  end
  else
  begin
    Allow:=True;
    if Assigned(Designer) and Assigned(Designer.OnAllowSelectControl) then
      Designer.OnAllowSelectControl(Designer,Value,Allow);
    if Allow then
    begin
      FControl:=Value;
      Visible:=Assigned(FControl);
      UpdatePosition;
      if Assigned(Designer) and Assigned(Designer.OnSelectControl) then
        Designer.OnSelectControl(Designer,FControl);
      if FEnableKeys and Showing and CanFocus then SetFocus;
    end;
  end;
end;

procedure TControlDesignerFrame.SetThickness(const Value: Integer);
begin
  if Value<>FThickness then
  begin
    FThickness:=Value;
    UpdatePosition;
  end;
end;

procedure TControlDesignerFrame.SetBorderColor(const Value: TColor);
begin
  if Value<>FBorderColor then
  begin
    FBorderColor:=Value;
    Invalidate;
  end;
end;

procedure TControlDesignerFrame.SetFrameColor(const Value: TColor);
begin
  if Value<>FFrameColor then
  begin
    FFrameColor:=Value;
    Invalidate;
  end;
end;

procedure TControlDesignerFrame.SetGrabColor(const Value: TColor);
begin
  if Value<>FGrabColor then
  begin
    FGrabColor:=Value;
    Invalidate;
  end;
end;

procedure TControlDesignerFrame.SetEnableKeys(const Value: Boolean);
begin
  FEnableKeys:=Value;
  if FEnableKeys and Showing and CanFocus then SetFocus;
end;

procedure TControlDesignerFrame.CreateHandle;
begin
  inherited;
  UpdatePosition;
end;

procedure TControlDesignerFrame.Paint;
var
  T: Integer;
begin
  with Canvas do
  begin
    Pen.Color:=FBorderColor;
    Brush.Color:=FFrameColor;
    Rectangle(0,0,Width,Height);
    Rectangle(Pred(FThickness),Pred(FThickness),Width-Pred(FThickness),Height-Pred(FThickness));
    Brush.Color:=FGrabColor;
    T:=FThickness;
    Rectangle((Width-T) div 2,0,(Width+T) div 2,T);
    Rectangle((Width-T) div 2,(Height-T),(Width+T) div 2,Height);
    Rectangle(0,(Height-T) div 2,T,(Height+T) div 2);
    Rectangle(Width-T,(Height-T) div 2,Width,(Height+T) div 2);
    Rectangle(0,0,T,T);
    Rectangle(Width-T,0,Width,T);
    Rectangle(0,Height-T,T,Height);
    Rectangle(Width-T,Height-T,Width,Height);
  end;
end;

procedure TControlDesignerFrame.WndProc(var Message: TMessage);
var
  P: TPoint;
  R: TRect;
  X,Y,Step: Integer;
  Shift: Boolean;
begin
  with Message do
    case Msg of
      WM_SETCURSOR:
      begin
        GetCursorPos(P);
        P:=ScreenToClient(P);
        case MouseZone(P.X,P.Y) of
          {$IFNDEF FPC}
          mzFrame: SetCursor(LoadCursor(0,IDC_SIZEALL));
          mzLeftTop,mzRightBottom: SetCursor(LoadCursor(0,IDC_SIZENWSE));
          mzLeftBottom,mzRightTop: SetCursor(LoadCursor(0,IDC_SIZENESW));
          mzCenterTop,mzCenterBottom: SetCursor(LoadCursor(0,IDC_SIZENS));
          mzLeftCenter,mzRightCenter: SetCursor(LoadCursor(0,IDC_SIZEWE));
          {$ELSE}
          
          mzFrame: SetCursor(LoadCursor(0,'IDC_SIZEALL'));
          mzLeftTop,mzRightBottom: SetCursor(LoadCursor(0,'IDC_SIZENWSE'));
          mzLeftBottom,mzRightTop: SetCursor(LoadCursor(0,'IDC_SIZENESW'));
          mzCenterTop,mzCenterBottom: SetCursor(LoadCursor(0,'IDC_SIZENS'));
          mzLeftCenter,mzRightCenter: SetCursor(LoadCursor(0,'IDC_SIZEWE'));
          {$ENDIF}
        end;
      end;
      WM_LBUTTONDOWN:
      begin
        Visible:=False;
        FDragRect:=FControl.Parent.ClientRect;
        {$IFNDEF FPC}MapWindowPoints(FControl.Parent.Handle,HWND_DESKTOP,FDragRect,2);
        ClipCursor(@FDragRect);
        {$ENDIF}
        FDragRect:=FControl.BoundsRect;

        GetCursorPos(FDragPoint);
        if not FDirectDrag then DrawDragRect;
        SetCapture(Handle);
      end;
      WM_MOUSEMOVE:
        if FDragZone<>mzNone then
        begin
          GetCursorPos(P);
          R:=FDragRect;
          with R do
          begin
            X:=P.X-FDragPoint.X;
            Y:=P.Y-FDragPoint.Y;
            case FDragZone of
              mzFrame: OffsetRect(R,X,Y);
              mzLeftTop:
              begin
                Inc(Left,X);
                Inc(Top,Y);
              end;
              mzCenterTop: Inc(Top,Y);
              mzRightTop:
              begin
                Inc(Right,X);
                Inc(Top,Y);
              end;
              mzLeftCenter: Inc(Left,X);
              mzRightCenter: Inc(Right,X);
              mzLeftBottom:
              begin
                Inc(Left,X);
                Inc(Bottom,Y);
              end;
              mzCenterBottom: Inc(Bottom,Y);
              mzRightBottom:
              begin
                Inc(Right,X);
                Inc(Bottom,Y);
              end;
            end;
            if Right-Left<FMinSize then
              case FDragZone of
                mzLeftTop,mzLeftCenter,mzLeftBottom: Left:=Right-FMinSize;
                mzRightTop,mzRightCenter,mzRightBottom: Right:=Left+FMinSize;
              end;
            if Bottom-Top<FMinSize then
              case FDragZone of
                mzLeftTop,mzCenterTop,mzRightTop: Top:=Bottom-FMinSize;
                mzLeftBottom,mzCenterBottom,mzRightBottom: Bottom:=Top+FMinSize;
              end;
            if not EqualRect(R,FDragRect) then
            begin
              HideDragHint;
              if not FDirectDrag then DrawDragRect;
              FDragRect:=R;
              GetCursorPos(FDragPoint);
              if not FDirectDrag then DrawDragRect
              else FControl.BoundsRect:=FDragRect;
              if FDragZone=mzFrame then ShowDragHint(Format('%d, %d',[Left,Top]))
              else ShowDragHint(Format('%d x %d',[Right-Left,Bottom-Top]));
            end;
          end;
        end;
      WM_LBUTTONUP:
      begin
        {$IFNDEF FPC}ClipCursor(nil);{$ENDIF}
        if GetCapture=Handle then ReleaseCapture;
        HideDragHint;
        if not FDirectDrag then
        begin
          DrawDragRect;
          Control.BoundsRect:=FDragRect;
        end;
        FDragZone:=mzNone;
        UpdatePosition;
        Visible:=Assigned(FControl);
        if Assigned(FControl) and Assigned(FOnDragControl) then FOnDragControl(Self,FControl);
      end;
      WM_LBUTTONDBLCLK:
        if Assigned(Designer) and Assigned(Designer.OnDblClick) then
          Designer.OnDblClick(Designer)
        else
          if not FDirectDrag then DrawDragRect;
      WM_NCPAINT: if FEnableKeys then SetFocus;
      CM_CHILDKEY:
        if Assigned(FControl) then
        begin
          if GetKeyState(VK_CONTROL) and $80 <> 0 then Step:=8
          else Step:=1;
          Shift:=GetKeyState(VK_SHIFT) and $80 <> 0;
          with FControl do
            case wParam of
              VK_LEFT:
                if Shift then
                begin
                  X:=Width-Step;
                  if X<FMinSize then X:=FMinSize;
                  if X<>Width then Width:=X;
                end
                else Left:=Left-Step;
              VK_RIGHT:
                if Shift then Width:=Width+Step
                else Left:=Left+Step;
              VK_UP:
                if Shift then
                begin
                  Y:=Height-Step;
                  if Y<FMinSize then Y:=FMinSize;
                  if Y<>Height then Height:=Y;
                end
                else Top:=Top-Step;
              VK_DOWN:
                if Shift then Height:=Height+Step
                else Top:=Top+Step;
            else
            begin
              inherited;
              Exit;
            end;
            end;
          UpdatePosition;
          Result:=1;
        end;
      else inherited;
    end;
end;

constructor TControlDesignerFrame.Create(AOwner: TComponent);
begin
  inherited;
  FHintWindow:=THintWindow.Create(Self);
  FHintWindow.Color:=clInfoBk;
  FThickness:=8;
  FMinSize:=8;
  FShowMoveSizeHint:=True;
  FBorderColor:=clGray;
  FGrabColor:=clWhite;
  FFrameColor:=clGray;
end;

destructor TControlDesignerFrame.Destroy;
begin
  DeleteObject(FRegion);
  inherited;
end;

procedure TControlDesignerFrame.UpdatePosition;
var
  R: TRect;
begin
  if not (csDesigning in ComponentState) and Assigned(FControl) then
  begin
    R:=FControl.BoundsRect;
    InflateRect(R,FThickness,FThickness);
    BoundsRect:=R;
    Parent:=FControl.Parent;
    BringToFront;
    UpdateShape;
  end;
end;

procedure TCustomControlDesigner.SetActive(const Value: Boolean);
begin
  FActive:=Value;
  if Assigned(FFrame) then FFrame.Visible:=FActive and not (csDesigning in ComponentState);
end;

function TCustomControlDesigner.GetControl: TControl;
begin
  if Assigned(FFrame) then Result:=FFrame.Control
  else Result:=nil;
end;

procedure TCustomControlDesigner.SetControl(const Value: TControl);
begin
  if Assigned(FFrame) then FFrame.Control:=Value;
end;

function TCustomControlDesigner.GetThickness: Integer;
begin
  if Assigned(FFrame) then Result:=FFrame.Thickness
  else Result:=0;
end;

procedure TCustomControlDesigner.SetThickness(const Value: Integer);
begin
  if Assigned(FFrame) then FFrame.Thickness:=Value;
end;

function TCustomControlDesigner.GetDirectDrag: Boolean;
begin
  if Assigned(FFrame) then Result:=FFrame.DirectDrag
  else Result:=False;
end;

procedure TCustomControlDesigner.SetDirectDrag(const Value: Boolean);
begin
  if Assigned(FFrame) then FFrame.DirectDrag:=Value;
end;

function TCustomControlDesigner.GetMinSize: Integer;
begin
  if Assigned(FFrame) then Result:=FFrame.MinSize
  else Result:=0;
end;

procedure TCustomControlDesigner.SetMinSize(const Value: Integer);
begin
  if Assigned(FFrame) then FFrame.MinSize:=Value;
end;

function TCustomControlDesigner.GetShowMoveSizeHint: Boolean;
begin
  if Assigned(FFrame) then Result:=FFrame.ShowMoveSizeHint
  else Result:=False;
end;

procedure TCustomControlDesigner.SetShowMoveSizeHint(const Value: Boolean);
begin
  if Assigned(FFrame) then FFrame.ShowMoveSizeHint:=Value;
end;

function TCustomControlDesigner.GetBorderColor: TColor;
begin
  if Assigned(FFrame) then Result:=FFrame.BorderColor
  else Result:=clBlack;
end;

procedure TCustomControlDesigner.SetBorderColor(const Value: TColor);
begin
  if Assigned(FFrame) then FFrame.BorderColor:=Value;
end;

function TCustomControlDesigner.GetFrameColor: TColor;
begin
  if Assigned(FFrame) then Result:=FFrame.FrameColor
  else Result:=clBlack;
end;

procedure TCustomControlDesigner.SetFrameColor(const Value: TColor);
begin
  if Assigned(FFrame) then FFrame.FrameColor:=Value;
end;

function TCustomControlDesigner.GetGrabColor: TColor;
begin
  if Assigned(FFrame) then Result:=FFrame.GrabColor
  else Result:=clBlack;
end;

procedure TCustomControlDesigner.SetGrabColor(const Value: TColor);
begin
  if Assigned(FFrame) then FFrame.GrabColor:=Value;
end;

function TCustomControlDesigner.GetEnableKeys: Boolean;
begin
  if Assigned(FFrame) then Result:=FFrame.EnableKeys
  else Result:=False;
end;

procedure TCustomControlDesigner.SetEnableKeys(const Value: Boolean);
begin
  if Assigned(FFrame) then FFrame.EnableKeys:=Value;
end;

function TCustomControlDesigner.GetOnAllowSelectControl: TControlAllowEvent;
begin
  if Assigned(FFrame) then Result:=FFrame.OnAllowSelectControl
  else Result:=nil;
end;

procedure TCustomControlDesigner.SetOnAllowSelectControl(const Value: TControlAllowEvent);
begin
  if Assigned(FFrame) then FFrame.OnAllowSelectControl:=Value;
end;

function TCustomControlDesigner.GetOnSelectControl: TControlEvent;
begin
  if Assigned(FFrame) then Result:=FFrame.OnSelectControl
  else Result:=nil;
end;

procedure TCustomControlDesigner.SetOnSelectControl(const Value: TControlEvent);
begin
  if Assigned(FFrame) then FFrame.OnSelectControl:=Value;
end;

function TCustomControlDesigner.GetOnAllowDragControl: TControlAllowEvent;
begin
  if Assigned(FFrame) then Result:=FFrame.OnAllowDragControl
  else Result:=nil;
end;

procedure TCustomControlDesigner.SetOnAllowDragControl(const Value: TControlAllowEvent);
begin
  if Assigned(FFrame) then FFrame.OnAllowDragControl:=Value;
end;

function TCustomControlDesigner.GetOnDragControl: TControlEvent;
begin
  if Assigned(FFrame) then Result:=FFrame.OnDragControl
  else Result:=nil;
end;

procedure TCustomControlDesigner.SetOnDragControl(const Value: TControlEvent);
begin
  if Assigned(FFrame) then FFrame.OnDragControl:=Value;
end;

function TCustomControlDesigner.GetOnDblClick: TNotifyEvent;
begin
  if Assigned(FFrame) then Result:=FFrame.OnDblClick
  else Result:=nil;
end;

procedure TCustomControlDesigner.SetOnDblClick(const Value: TNotifyEvent);
begin
  if Assigned(FFrame) then FFrame.FOnDblClick:=Value;
end;

constructor TCustomControlDesigner.Create(AOwner: TComponent);
begin
  inherited;
  FFrame:=TControlDesignerFrame.Create(Self);
end;

procedure TCustomControlDesigner.Update;
begin
  if Assigned(Control) then FFrame.UpdatePosition;
end;

procedure Register;
begin
  RegisterComponents('Designers', [TControlDesigner]);
end;

end.
