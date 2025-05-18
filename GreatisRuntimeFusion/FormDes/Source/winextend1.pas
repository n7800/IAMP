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
unit winextend;

{$MODE Delphi} {$H+}

interface

uses
  LCLIntf, LCLType, Types,  Classes, SysUtils, LMessages, Messages,
  {$IFDEF Windows}Windows, ShellApi, LazUtf16,{$ENDIF}  LCLProc,

  Controls,
  Forms, clipbrd;

const
  HWND_DESKTOP = HWND(0);
  WH_GETMESSAGE = 3;
  DCX_CACHE = 2;
  DCX_CLIPSIBLINGS = $10;
  DCX_PARENTCLIP = $20;
  DCX_CLIPCHILDREN = 8;
  MA_ACTIVATE = 1;
  MA_NOACTIVATE = 3;
  GMEM_MOVEABLE = 2;
  MOUSEEVENTF_LEFTDOWN        = $0002;
  MOUSEEVENTF_LEFTUP          = $0004;
  VER_PLATFORM_WIN32_NT = 2;
  DI_NORMAL = 3;

  {$IFNDEF Windows}
  WM_NCLBUTTONUP      = $00A2;
  WM_RBUTTONUP        = $0205;
  WM_NCRBUTTONUP      = $00A5;
  WM_MOVE             = $0003;
  WM_MOUSEACTIVATE    = $0021;
  WM_RBUTTONDBLCLK    = $0206;
  WM_MBUTTONDBLCLK    = $0209;
  WM_NCLBUTTONDBLCLK  = $00A3;
  WM_NCRBUTTONDBLCLK  = $00A6;
  WM_NCMBUTTONDBLCLK  = $00A9;
  WM_RBUTTONDOWN      = $0204;
  WM_NCRBUTTONDOWN    = $00A4;
  WM_NCLBUTTONDOWN    = $00A1;
  WM_MDIACTIVATE = $0222;
  WM_NCMOUSEMOVE = $00A0;
  WM_MOUSEWHEEL = $020A;
  {$ENDIF}

type
  TDWordFiller = record
  {$IFDEF CPU64}
    Filler: array[1..4] of Byte; 
  {$ENDIF}
  end;

  TCMCancelMode = record
    Msg: UINT;
    MsgFiller: TDWordFiller;
    Unused: WPARAM;
    Sender: TControl;
    Result: Longint;
  end;

  TCMFocusChanged = record
    Msg: UINT;
    MsgFiller: TDWordFiller;
    Unused: WPARAM;
    Sender: TWinControl;
    Result: LRESULT;
  end;

  PMinMaxInfo = ^TMinMaxInfo;
  {$EXTERNALSYM tagMINMAXINFO}
  tagMINMAXINFO = record
    ptReserved: TPoint;
    ptMaxSize: TPoint;
    ptMaxPosition: TPoint;
    ptMinTrackSize: TPoint;
    ptMaxTrackSize: TPoint;
  end;
  TMinMaxInfo = tagMINMAXINFO;
  {$EXTERNALSYM MINMAXINFO}
  MINMAXINFO = tagMINMAXINFO;

  {$IFNDEF Windows}
  SIZE_T = ULONG_PTR;
  {$ENDIF}
    TMessageEvent = procedure (var Msg: TMsg; var Handled: Boolean) of object;

    TApplicationHelper = class helper for TApplication
    private
      function GetOnMessage: TMessageEvent;
      function GetUpdateMetricSettings: Boolean;
      procedure SetOnMessage(const AValue: TMessageEvent);
      procedure SetUpdateMetricSettings(Value: Boolean);
    public
      procedure AddControlToHandler(Control: TControl);
      procedure RemoveControlFromHandler(Control: TControl);
      property OnMessage: TMessageEvent read GetOnMessage write SetOnMessage;
      property UpdateMetricSettings: Boolean read GetUpdateMetricSettings write SetUpdateMetricSettings;
    end;

    TClipboardHelper = class helper for TClipboard
    public
      procedure SetAsHandle(Format: Word; Value: THandle);
      function GetAsHandle(Format: Word): THandle;
    end;

    TFNHookProc = function (code: Integer; wparam: WPARAM; lparam: LPARAM): LRESULT stdcall;

procedure MapWindowPoints(hWndFrom, hWndTo: HWND; var lpPoints; cPoints: UINT);
function ClipCursor(lpRect: PRect): BOOL;
function MessageBeep(uType: UINT): BOOL;
function SetWindowsHookEx(idHook: Integer; lpfn: TFNHookProc; hmod: HINST; dwThreadId: DWORD): HHOOK;
function UnhookWindowsHookEx(hhk: HHOOK): BOOL;
function GetDCEx(hWnd: HWND; hrgnClip: HRGN; flags: DWORD): HDC;
function GlobalAlloc(uFlags: UINT; dwBytes: SIZE_T): HGLOBAL;
function GlobalLock(hMem: HGLOBAL): Pointer;
function GlobalUnlock(hMem: HGLOBAL): BOOL;
function GlobalFree(hMem: HGLOBAL): HGLOBAL;
function GlobalSize(hMem: HGLOBAL): SIZE_T;
function GetParent(hWnd: HWND): HWND;
function SetParent(hWndChild, hWndNewParent: HWND): HWND;

function SetFocus(hWnd: HWND): HWND;
function GetWindowDC(hWnd: HWND): HDC;
function GetDesktopWindow(): HWND;
procedure mouse_event(dwFlags, dx, dy, dwData: DWORD; dwExtraInfo: UIntPtr);
function SetPixel(DC: HDC; X, Y: Integer; Color: COLORREF): COLORREF;
function ValidateRect(hWnd: HWND; lpRect: PRect): BOOL;
function DrawIconEx(hdc: HDC; xLeft, yTop: Integer; hIcon: HICON;
  cxWidth, cyWidth: Integer; istepIfAniCur: UINT;
  hbrFlickerFreeDraw: HBRUSH; diFlags: UINT): BOOL;

function lstrcmpi(lpString1, lpString2: LPCSTR): Integer;
function SearchPath(lpPath, lpFileName, lpExtension: LPCSTR;
  nBufferLength: DWORD; lpBuffer: LPCSTR; var lpFilePart: LPCSTR): DWORD;
function SetCurrentDirectory(lpPathName: LPCSTR): BOOL;

function Point(x, y: Longint): TPoint; inline;
function Rect(ALeft, ATop, ARight, ABottom: Longint): TRect; inline;

implementation

uses
  Generics.Collections, Generics.Defaults;

type
  TApplicationProxyMessage = class;
  TControlProxy = class;

  TListProxyControls = class (TList<TControlProxy>)
  private
    FFakeControl: TControlProxy;
  protected
    function ControlCompare(constref Item1, Item2: TControlProxy): Integer;
    procedure Notify(constref AValue: TControlProxy; ACollectionNotification: TCollectionNotification); override;
    function FindProxyForm(Control: TControl; var Index: Integer): Boolean;
    function ControlExists(Control: TControl): Boolean;
    procedure RemoveControl(Control: TControl);

  public
    constructor Create;
    destructor Destroy; override;

  end;

  TControlProxy = class
  private
    FControl: TControl;
    FOriginalProc: TWndMethod;
    FApp: TApplicationProxyMessage;
  public
    constructor Create(App: TApplicationProxyMessage; Control: TControl);
    destructor Destroy; override;
    procedure WndProc(var msg : TMessage);
  end;

  TApplicationProxyMessage = class(TObject)
  private
    FForms: TListProxyControls;
    FOnMessage: TMessageEvent;

    procedure ScreenFormEventAdd(Sender: TObject; Form: TCustomForm);
    procedure ScreenFormEventRemove(Sender: TObject; Form: TCustomForm);
    procedure ScreenControlEventAdd(Sender: TObject; Control: TControl);
    procedure ScreenControlEventRemove(Sender: TObject; Control: TControl);
    procedure InternalWndProc(wnd: HWND; var msg : TMessage; var Handled: Boolean);
  public
    constructor Create;
    destructor Destroy; override;
    property OnMessage: TMessageEvent read FOnMessage write FOnMessage;

  end;

var
  AppProxy: TApplicationProxyMessage;

  function TListProxyControls.ControlCompare(constref Item1, Item2: TControlProxy
    ): Integer;
  begin
      Result := PtrUInt(Item1.FControl) - PtrUint(Item2.FControl);
  end;

  procedure TListProxyControls.Notify(constref AValue: TControlProxy;
    ACollectionNotification: TCollectionNotification);
  begin
    inherited Notify(AValue, ACollectionNotification);
    if ACollectionNotification in [cnExtracted, cnRemoved] then
      begin
        AValue.FApp := nil;
        AValue.Free;
      end;
  end;

  function TListProxyControls.FindProxyForm(Control: TControl; var Index: Integer
    ): Boolean;
  var
    c: TControlProxy;
  begin
    if Count = 0 then exit(false);
    FFakeControl.FControl := Control;
    Result := BinarySearch(FFakeControl, Index);
  end;

  function TListProxyControls.ControlExists(Control: TControl): Boolean;
  var
    i: Integer;
  begin
    if Count = 0 then exit(false);
    FFakeControl.FControl := Control;
    Result := BinarySearch(FFakeControl, i);
  end;

  procedure TListProxyControls.RemoveControl(Control: TControl);
  var
    i: Integer;
  begin
    if Count = 0 then exit;
    FFakeControl.FControl := Control;
    if BinarySearch(FFakeControl, i) then
      Delete(i);
  end;

  constructor TListProxyControls.Create;
  begin
    FFakeControl := TControlProxy.Create(Nil, nil);
    inherited Create(
      TComparer<TControlProxy>.Construct(ControlCompare)
      );
  end;

  destructor TListProxyControls.Destroy;
  begin
    FFakeControl.Free;
    inherited Destroy;
  end;

  constructor TControlProxy.Create(App: TApplicationProxyMessage; Control: TControl);
  begin
    inherited Create;
    FApp  := App;
    FControl := Control;
    if Assigned(FControl) then
      begin
        FOriginalProc   := FControl.WindowProc;
        FControl.WindowProc := WndProc;
      end;
  end;

  destructor TControlProxy.Destroy;
  begin
    FControl.WindowProc := FOriginalProc;
    inherited Destroy;
  end;

  procedure TControlProxy.WndProc(var msg: TMessage);
  var
    Handled: Boolean;
    w: TWinControl;
  begin
    if FControl is TWinControl then
      w := TWinControl(FControl) else
      w := FControl.Parent;
    
    if not Assigned(w) or not w.HandleAllocated then exit;
    Handled := false;
    if Assigned(FApp) then
      FApp.InternalWndProc(w.Handle, Msg, Handled);
    if not Handled then
      FOriginalProc(Msg);
  end;

  procedure TApplicationProxyMessage.ScreenFormEventAdd(Sender: TObject;
    Form: TCustomForm);
  begin
    if not FForms.ControlExists(Form) then
      FForms.Add(TControlProxy.Create(Self, Form));
  end;

  procedure TApplicationProxyMessage.ScreenFormEventRemove(Sender: TObject;
    Form: TCustomForm);
  begin
      FForms.RemoveControl(Form);
  end;

  procedure TApplicationProxyMessage.ScreenControlEventAdd(Sender: TObject;
    Control: TControl);
  begin
    if not FForms.ControlExists(Control) then
      FForms.Add(TControlProxy.Create(Self, Control));
  end;

  procedure TApplicationProxyMessage.ScreenControlEventRemove(Sender: TObject;
    Control: TControl);
  begin
      FForms.RemoveControl(Control);
  end;

  procedure TApplicationProxyMessage.InternalWndProc(wnd: HWND;
    var msg: TMessage; var Handled: Boolean);
  var
    proxy_msg: TMSG;
  begin

    if Assigned(FOnMessage) then
      begin
        FillChar(proxy_msg, SizeOf(proxy_msg), 0);
        Move(msg, proxy_msg.message, SizeOf(msg));
        proxy_msg.hwnd   := wnd;
        FOnMessage(proxy_msg, Handled);
        if not Handled then
          Move(proxy_msg.message, msg, SizeOf(msg));
      end;
  end;

  constructor TApplicationProxyMessage.Create;
  begin
    inherited Create;
    FForms    := TListProxyControls.Create;
    Screen.AddHandlerFormAdded(ScreenFormEventAdd, true);
    Screen.AddHandlerRemoveForm(ScreenFormEventRemove, true);
  end;

  destructor TApplicationProxyMessage.Destroy;
  begin
    Screen.RemoveHandlerFormAdded(ScreenFormEventAdd);
    Screen.RemoveHandlerRemoveForm(ScreenFormEventRemove);

    FForms.Free;
    inherited Destroy;
  end;

{$IFDEF Windows}
procedure  MapWindowPoints(hWndFrom, hWndTo: HWND; var lpPoints; cPoints: UINT);
begin
  Windows.MapWindowPoints(hWndFrom, hWndTo, lpPoints, cPoints);
end;

function ClipCursor(lpRect: PRect): BOOL;
begin
  Result := Windows.ClipCursor(lpRect);
end;

function MessageBeep(uType: UINT): BOOL;
begin
  Result := Windows.MessageBeep(uType);
end;

function SetWindowsHookEx(idHook: Integer; lpfn: TFNHookProc; hmod: HINST; dwThreadId: DWORD): HHOOK;
begin
  Result := Windows.SetWindowsHookEx(idHook, lpfn, hmod, dwThreadId);
end;

function UnhookWindowsHookEx(hhk: HHOOK): BOOL;
begin
  Result := Windows.UnhookWindowsHookEx(hhk);
end;

function GetDCEx(hWnd: HWND; hrgnClip: HRGN; flags: DWORD): HDC;
begin
  Result := Windows.GetDCEx(hWnd, hrgnClip, flags);
end;

function GlobalAlloc(uFlags: UINT; dwBytes: SIZE_T): HGLOBAL;
begin
  Result := Windows.GlobalAlloc(uFlags, dwBytes);
end;

function GlobalLock(hMem: HGLOBAL): Pointer;
begin
  Result := Windows.GlobalLock(hMem);
end;

function GlobalUnlock(hMem: HGLOBAL): BOOL;
begin
  Result := Windows.GlobalUnlock(hMem);
end;

function GlobalFree(hMem: HGLOBAL): HGLOBAL;
begin
  Result := Windows.GlobalFree(hMem);
end;

function GlobalSize(hMem: HGLOBAL): SIZE_T;
begin
  Result := Windows.GlobalSize(hMem);
end;

function GetParent(hWnd: HWND): HWND;
begin
  Result := Windows.GetParent(hWnd);
end;

function SetFocus(hWnd: HWND): HWND;
begin
  Result := Windows.SetFocus(hWnd);
end;

function GetWindowDC(hWnd: HWND): HDC;
begin
  Result := Windows.GetWindowDC(hWnd);
end;

function GetDesktopWindow(): HWND;
begin
  Result := Windows.GetDesktopWindow();
end;

function SetParent(hWndChild, hWndNewParent: HWND): HWND;
begin
  Result := Windows.SetParent(hWndChild, hWndNewParent);
end;

procedure mouse_event(dwFlags, dx, dy, dwData: DWORD; dwExtraInfo: UIntPtr);
begin
  Windows.mouse_event(dwFlags, dx, dy, dwData, dwExtraInfo);
end;

function SetPixel(DC: HDC; X, Y: Integer; Color: COLORREF): COLORREF;
begin
  Result := Windows.SetPixel(DC, X, Y, Color);
end;

function ValidateRect(hWnd: HWND; lpRect: PRect): BOOL;
begin
  Result := Windows.ValidateRect(hWnd, lpRect);
end;

function DrawIconEx(hdc: HDC; xLeft, yTop: Integer; hIcon: HICON;
  cxWidth, cyWidth: Integer; istepIfAniCur: UINT;
  hbrFlickerFreeDraw: HBRUSH; diFlags: UINT): BOOL;
begin
  Result := Windows.DrawIconEx(hdc, xLeft, yTop, hIcon, cxWidth, cyWidth,
                                  istepIfAniCur, hbrFlickerFreeDraw, diFlags);
end;

function lstrcmpi(lpString1, lpString2: LPCSTR): Integer;
begin
  Result := Windows.lstrcmpi(lpString1, lpString2);
end;

function SearchPath(lpPath, lpFileName, lpExtension: LPCSTR;
  nBufferLength: DWORD; lpBuffer: LPCSTR; var lpFilePart: LPCSTR): DWORD;
begin
  Result := Windows.SearchPath(lpPath, lpFileName, lpExtension,
    nBufferLength, lpBuffer, lpFilePart)
end;

function SetCurrentDirectory(lpPathName: LPCSTR): BOOL;
begin
  Result := Windows.SetCurrentDirectory(lpPathName);
end;

{$ELSE}
procedure  MapWindowPoints(hWndFrom, hWndTo: HWND; var lpPoints; cPoints: UINT);
begin
  
end;

function ClipCursor(lpRect: PRect): BOOL;
begin
  Result := false
end;

function MessageBeep(uType: UINT): BOOL;
begin
  Result := false
end;

function SetWindowsHookEx(idHook: Integer; lpfn: TFNHookProc; hmod: HINST; dwThreadId: DWORD): HHOOK;
begin
  Result := 0
end;

function UnhookWindowsHookEx(hhk: HHOOK): BOOL;
begin
  Result := false
end;

function GetDCEx(hWnd: HWND; hrgnClip: HRGN; flags: DWORD): HDC;
begin
  Result := GetDC(hWnd);
end;

function GlobalAlloc(uFlags: UINT; dwBytes: SIZE_T): HGLOBAL;
begin
  Result := 0
end;

function GlobalLock(hMem: HGLOBAL): Pointer;
begin
  Result := nil
end;

function GlobalUnlock(hMem: HGLOBAL): BOOL;
begin
  Result := false
end;

function GlobalFree(hMem: HGLOBAL): HGLOBAL;
begin
  Result := 0
end;

function GlobalSize(hMem: HGLOBAL): SIZE_T;
begin
  Result := 0
end;

function GetParent(hWnd: HWND): HWND;
begin
  Result := 0
end;

function SetFocus(hWnd: HWND): HWND;
begin
  Result := 0
end;

function GetWindowDC(hWnd: HWND): HDC;
begin
  Result := 0
end;

function GetDesktopWindow(): HWND;
begin
  Result := 0
end;

function SetParent(hWndChild, hWndNewParent: HWND): HWND;
begin
  Result := 0
end;

procedure mouse_event(dwFlags, dx, dy, dwData: DWORD; dwExtraInfo: UIntPtr);
begin
  Result := 0
end;

function SetPixel(DC: HDC; X, Y: Integer; Color: COLORREF): COLORREF;
begin
  Result := 0;
end;

function ValidateRect(hWnd: HWND; lpRect: PRect): BOOL;
begin
  Result := false;
end;

function DrawIconEx(hdc: HDC; xLeft, yTop: Integer; hIcon: HICON;
  cxWidth, cyWidth: Integer; istepIfAniCur: UINT;
  hbrFlickerFreeDraw: HBRUSH; diFlags: UINT): BOOL;
begin
  Result := false;
end;

function lstrcmpi(lpString1, lpString2: LPCSTR): Integer;
begin
  Result := 0;
end;

function SearchPath(lpPath, lpFileName, lpExtension: LPCSTR;
  nBufferLength: DWORD; lpBuffer: LPCSTR; var lpFilePart: LPCSTR): DWORD;
begin
  Result := 0
end;

function SetCurrentDirectory(lpPathName: LPCSTR): BOOL;
begin
  Result := 0;
end;

{$ENDIF}

procedure TClipboardHelper.SetAsHandle(Format: Word; Value: THandle);
begin
  raise Exception.Create('Not implemented');
end;

function TClipboardHelper.GetAsHandle(Format: Word): THandle;
begin
  raise Exception.Create('Not implemented');
end;

function TApplicationHelper.GetOnMessage: TMessageEvent;
begin
  if Assigned(AppProxy) then
    Result := AppProxy.OnMessage else
    Result := nil;
end;

function TApplicationHelper.GetUpdateMetricSettings: Boolean;
begin
  Result := false;
end;

procedure TApplicationHelper.SetOnMessage(const AValue: TMessageEvent);
begin
  if Assigned(AppProxy) then
    AppProxy.OnMessage := AValue;
end;

procedure TApplicationHelper.SetUpdateMetricSettings(Value: Boolean);
begin

end;

procedure TApplicationHelper.AddControlToHandler(Control: TControl);
begin
  if Assigned(AppProxy) then
    AppProxy.ScreenControlEventAdd(Self, Control);
end;

procedure TApplicationHelper.RemoveControlFromHandler(Control: TControl);
begin
  if Assigned(AppProxy) then
    AppProxy.ScreenControlEventRemove(Self, Control);
end;

function Point(x, y: Longint): TPoint; inline;
begin
  Result.X  := x;
  Result.Y  := y;
end;

function Rect(ALeft, ATop, ARight, ABottom: Longint): TRect; inline;
begin
  Result.Left   := ALeft;
  Result.Top    := ATop;
  Result.Right  := ARight;
  Result.Bottom := ABottom;
end;

initialization
  AppProxy := TApplicationProxyMessage.Create;
finalization
  AppProxy.Free;
  AppProxy := nil;
end.

