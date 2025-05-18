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
unit MessageHelper;
{$MODE Delphi} {$H+}
interface
uses
  Windows, SysUtils, LMessages, Messages;
type
  TMsgHelper = record helper for TMsg
    function ToString: string; inline;
  end;
  function MessageToString(const Msg: TMsg): string; overload;
  function MessageToString(wnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): string; overload;
  function MessageToString(const Msg: TMessage): string; overload;

implementation
const
  
  CM_BASE                   = $B000;
  CM_APPKEYDOWN             = CM_BASE + 22;

function MessageStr(msg: UINT): string;
begin
  case msg of

  WM_NULL             : Result := 'WM_NULL';
  WM_CREATE           : Result := 'WM_CREATE';
  WM_DESTROY          : Result := 'WM_DESTROY';
  WM_MOVE             : Result := 'WM_MOVE';
  WM_SIZE             : Result := 'WM_SIZE';
  WM_ACTIVATE         : Result := 'WM_ACTIVATE';
  WM_SETFOCUS         : Result := 'WM_SETFOCUS';
  WM_KILLFOCUS        : Result := 'WM_KILLFOCUS';
  WM_ENABLE           : Result := 'WM_ENABLE';
  WM_SETREDRAW        : Result := 'WM_SETREDRAW';
  WM_SETTEXT          : Result := 'WM_SETTEXT';
  WM_GETTEXT          : Result := 'WM_GETTEXT';
  WM_GETTEXTLENGTH    : Result := 'WM_GETTEXTLENGTH';
  WM_PAINT            : Result := 'WM_PAINT';
  WM_CLOSE            : Result := 'WM_CLOSE';
  WM_QUERYENDSESSION  : Result := 'WM_QUERYENDSESSION';
  WM_QUIT             : Result := 'WM_QUIT';
  WM_QUERYOPEN        : Result := 'WM_QUERYOPEN';
  WM_ERASEBKGND       : Result := 'WM_ERASEBKGND';
  WM_SYSCOLORCHANGE   : Result := 'WM_SYSCOLORCHANGE';
  WM_ENDSESSION       : Result := 'WM_ENDSESSION';
 
  WM_SHOWWINDOW       : Result := 'WM_SHOWWINDOW';
  WM_CTLCOLOR         : Result := 'WM_CTLCOLOR';
  
  WM_SETTINGCHANGE    : Result := 'WM_SETTINGCHANGE'; 
  WM_DEVMODECHANGE    : Result := 'WM_DEVMODECHANGE';
  WM_ACTIVATEAPP      : Result := 'WM_ACTIVATEAPP';
  WM_FONTCHANGE       : Result := 'WM_FONTCHANGE';
  WM_TIMECHANGE       : Result := 'WM_TIMECHANGE';
  WM_CANCELMODE       : Result := 'WM_CANCELMODE';
  WM_SETCURSOR        : Result := 'WM_SETCURSOR';
  WM_MOUSEACTIVATE    : Result := 'WM_MOUSEACTIVATE';
  WM_CHILDACTIVATE    : Result := 'WM_CHILDACTIVATE';
  WM_QUEUESYNC        : Result := 'WM_QUEUESYNC';
  WM_GETMINMAXINFO    : Result := 'WM_GETMINMAXINFO';
  WM_PAINTICON        : Result := 'WM_PAINTICON';
  WM_ICONERASEBKGND   : Result := 'WM_ICONERASEBKGND';
  WM_NEXTDLGCTL       : Result := 'WM_NEXTDLGCTL';
  WM_SPOOLERSTATUS    : Result := 'WM_SPOOLERSTATUS';
  WM_DRAWITEM         : Result := 'WM_DRAWITEM';
  WM_MEASUREITEM      : Result := 'WM_MEASUREITEM';
  WM_DELETEITEM       : Result := 'WM_DELETEITEM';
  WM_VKEYTOITEM       : Result := 'WM_VKEYTOITEM';
  WM_CHARTOITEM       : Result := 'WM_CHARTOITEM';
  WM_SETFONT          : Result := 'WM_SETFONT';
  WM_GETFONT          : Result := 'WM_GETFONT';
  WM_SETHOTKEY        : Result := 'WM_SETHOTKEY';
  WM_GETHOTKEY        : Result := 'WM_GETHOTKEY';
  WM_QUERYDRAGICON    : Result := 'WM_QUERYDRAGICON';
  WM_COMPAREITEM      : Result := 'WM_COMPAREITEM';
  WM_GETOBJECT        : Result := 'WM_GETOBJECT';
  WM_COMPACTING       : Result := 'WM_COMPACTING';

  WM_WINDOWPOSCHANGING : Result := 'WM_WINDOWPOSCHANGING';
  WM_WINDOWPOSCHANGED  : Result := 'WM_WINDOWPOSCHANGED';
  WM_POWER             : Result := 'WM_POWER';

  WM_COPYDATA         : Result := 'WM_COPYDATA';
  WM_CANCELJOURNAL    : Result := 'WM_CANCELJOURNAL';
  WM_NOTIFY           : Result := 'WM_NOTIFY';
  WM_INPUTLANGCHANGEREQUEST : Result := 'WM_INPUTLANGCHANGEREQUEST';
  WM_INPUTLANGCHANGE  : Result := 'WM_INPUTLANGCHANGE';
  WM_TCARD            : Result := 'WM_TCARD';
  WM_HELP             : Result := 'WM_HELP';
  WM_USERCHANGED      : Result := 'WM_USERCHANGED';
  WM_NOTIFYFORMAT     : Result := 'WM_NOTIFYFORMAT';

  WM_CONTEXTMENU      : Result := 'WM_CONTEXTMENU';
  WM_STYLECHANGING    : Result := 'WM_STYLECHANGING';
  WM_STYLECHANGED     : Result := 'WM_STYLECHANGED';
  WM_DISPLAYCHANGE    : Result := 'WM_DISPLAYCHANGE';
  WM_GETICON          : Result := 'WM_GETICON';
  WM_SETICON          : Result := 'WM_SETICON';

  WM_NCCREATE         : Result := 'WM_NCCREATE';
  WM_NCDESTROY        : Result := 'WM_NCDESTROY';
  WM_NCCALCSIZE       : Result := 'WM_NCCALCSIZE';
  WM_NCHITTEST        : Result := 'WM_NCHITTEST';
  WM_NCPAINT          : Result := 'WM_NCPAINT';
  WM_NCACTIVATE       : Result := 'WM_NCACTIVATE';
  WM_GETDLGCODE       : Result := 'WM_GETDLGCODE';
  WM_NCMOUSEMOVE      : Result := 'WM_NCMOUSEMOVE';
  WM_NCLBUTTONDOWN    : Result := 'WM_NCLBUTTONDOWN';
  WM_NCLBUTTONUP      : Result := 'WM_NCLBUTTONUP';
  WM_NCLBUTTONDBLCLK  : Result := 'WM_NCLBUTTONDBLCLK';
  WM_NCRBUTTONDOWN    : Result := 'WM_NCRBUTTONDOWN';
  WM_NCRBUTTONUP      : Result := 'WM_NCRBUTTONUP';
  WM_NCRBUTTONDBLCLK  : Result := 'WM_NCRBUTTONDBLCLK';
  WM_NCMBUTTONDOWN    : Result := 'WM_NCMBUTTONDOWN';
  WM_NCMBUTTONUP      : Result := 'WM_NCMBUTTONUP';
  WM_NCMBUTTONDBLCLK  : Result := 'WM_NCMBUTTONDBLCLK';

  WM_NCXBUTTONDOWN       : Result := 'WM_NCXBUTTONDOWN';
  WM_NCXBUTTONUP         : Result := 'WM_NCXBUTTONUP';
  WM_NCXBUTTONDBLCLK     : Result := 'WM_NCXBUTTONDBLCLK';
  WM_INPUT_DEVICE_CHANGE : Result := 'WM_INPUT_DEVICE_CHANGE';
  WM_INPUT               : Result := 'WM_INPUT';

  WM_KEYDOWN          : Result := 'WM_KEYDOWN'; 
  WM_KEYUP            : Result := 'WM_KEYUP';
  WM_CHAR             : Result := 'WM_CHAR';
  WM_DEADCHAR         : Result := 'WM_DEADCHAR';
  WM_SYSKEYDOWN       : Result := 'WM_SYSKEYDOWN';
  WM_SYSKEYUP         : Result := 'WM_SYSKEYUP';
  WM_SYSCHAR          : Result := 'WM_SYSCHAR';
  WM_SYSDEADCHAR      : Result := 'WM_SYSDEADCHAR';
  WM_UNICHAR          : Result := 'WM_UNICHAR'; 
  
  WM_INITDIALOG       : Result := 'WM_INITDIALOG';
  WM_COMMAND          : Result := 'WM_COMMAND';
  WM_SYSCOMMAND       : Result := 'WM_SYSCOMMAND';
  WM_TIMER            : Result := 'WM_TIMER';
  WM_HSCROLL          : Result := 'WM_HSCROLL';
  WM_VSCROLL          : Result := 'WM_VSCROLL';
  WM_INITMENU         : Result := 'WM_INITMENU';
  WM_INITMENUPOPUP    : Result := 'WM_INITMENUPOPUP';

  WM_GESTURE       : Result := 'WM_GESTURE';
  WM_GESTURENOTIFY : Result := 'WM_GESTURENOTIFY';

  WM_MENUSELECT       : Result := 'WM_MENUSELECT';
  WM_MENUCHAR         : Result := 'WM_MENUCHAR';
  WM_ENTERIDLE        : Result := 'WM_ENTERIDLE';

  WM_MENURBUTTONUP    : Result := 'WM_MENURBUTTONUP';
  WM_MENUDRAG         : Result := 'WM_MENUDRAG';
  WM_MENUGETOBJECT    : Result := 'WM_MENUGETOBJECT';
  WM_UNINITMENUPOPUP  : Result := 'WM_UNINITMENUPOPUP';
  WM_MENUCOMMAND      : Result := 'WM_MENUCOMMAND';

  WM_CHANGEUISTATE    : Result := 'WM_CHANGEUISTATE';
  WM_UPDATEUISTATE    : Result := 'WM_UPDATEUISTATE';
  WM_QUERYUISTATE     : Result := 'WM_QUERYUISTATE';

  WM_CTLCOLORMSGBOX   : Result := 'WM_CTLCOLORMSGBOX';
  WM_CTLCOLOREDIT     : Result := 'WM_CTLCOLOREDIT';
  WM_CTLCOLORLISTBOX  : Result := 'WM_CTLCOLORLISTBOX';
  WM_CTLCOLORBTN      : Result := 'WM_CTLCOLORBTN';
  WM_CTLCOLORDLG      : Result := 'WM_CTLCOLORDLG';
  WM_CTLCOLORSCROLLBAR: Result := 'WM_CTLCOLORSCROLLBAR=';
  WM_CTLCOLORSTATIC   : Result := 'WM_CTLCOLORSTATIC';

  WM_MOUSEMOVE        : Result := 'WM_MOUSEMOVE'; 
  WM_LBUTTONDOWN      : Result := 'WM_LBUTTONDOWN';
  WM_LBUTTONUP        : Result := 'WM_LBUTTONUP';
  WM_LBUTTONDBLCLK    : Result := 'WM_LBUTTONDBLCLK';
  WM_RBUTTONDOWN      : Result := 'WM_RBUTTONDOWN';
  WM_RBUTTONUP        : Result := 'WM_RBUTTONUP';
  WM_RBUTTONDBLCLK    : Result := 'WM_RBUTTONDBLCLK';
  WM_MBUTTONDOWN      : Result := 'WM_MBUTTONDOWN';
  WM_MBUTTONUP        : Result := 'WM_MBUTTONUP';
  WM_MBUTTONDBLCLK    : Result := 'WM_MBUTTONDBLCLK';
  WM_MOUSEWHEEL       : Result := 'WM_MOUSEWHEEL';

  WM_XBUTTONDOWN   : Result := 'WM_XBUTTONDOWN';
  WM_XBUTTONUP     : Result := 'WM_XBUTTONUP';
  WM_XBUTTONDBLCLK : Result := 'WM_XBUTTONDBLCLK';
  WM_MOUSEHWHEEL   : Result := 'WM_MOUSEHWHEEL'; 

  WM_PARENTNOTIFY     : Result := 'WM_PARENTNOTIFY';
  WM_ENTERMENULOOP    : Result := 'WM_ENTERMENULOOP';
  WM_EXITMENULOOP     : Result := 'WM_EXITMENULOOP';
  WM_NEXTMENU         : Result := 'WM_NEXTMENU';

  WM_SIZING          : Result := 'WM_SIZING';
  WM_CAPTURECHANGED  : Result := 'WM_CAPTURECHANGED';
  WM_MOVING          : Result := 'WM_MOVING';
  WM_POWERBROADCAST  : Result := 'WM_POWERBROADCAST';
  WM_DEVICECHANGE    : Result := 'WM_DEVICECHANGE';

  WM_IME_STARTCOMPOSITION        : Result := 'WM_IME_STARTCOMPOSITION';
  WM_IME_ENDCOMPOSITION          : Result := 'WM_IME_ENDCOMPOSITION';
  WM_IME_COMPOSITION             : Result := 'WM_IME_COMPOSITION'; 

  WM_IME_SETCONTEXT              : Result := 'WM_IME_SETCONTEXT';
  WM_IME_NOTIFY                  : Result := 'WM_IME_NOTIFY';
  WM_IME_CONTROL                 : Result := 'WM_IME_CONTROL';
  WM_IME_COMPOSITIONFULL         : Result := 'WM_IME_COMPOSITIONFULL';
  WM_IME_SELECT                  : Result := 'WM_IME_SELECT';
  WM_IME_CHAR                    : Result := 'WM_IME_CHAR';
  WM_IME_REQUEST                 : Result := 'WM_IME_REQUEST';

  WM_IME_KEYDOWN                 : Result := 'WM_IME_KEYDOWN';
  WM_IME_KEYUP                   : Result := 'WM_IME_KEYUP';

  WM_MDICREATE        : Result := 'WM_MDICREATE';
  WM_MDIDESTROY       : Result := 'WM_MDIDESTROY';
  WM_MDIACTIVATE      : Result := 'WM_MDIACTIVATE';
  WM_MDIRESTORE       : Result := 'WM_MDIRESTORE';
  WM_MDINEXT          : Result := 'WM_MDINEXT';
  WM_MDIMAXIMIZE      : Result := 'WM_MDIMAXIMIZE';
  WM_MDITILE          : Result := 'WM_MDITILE';
  WM_MDICASCADE       : Result := 'WM_MDICASCADE';
  WM_MDIICONARRANGE   : Result := 'WM_MDIICONARRANGE';
  WM_MDIGETACTIVE     : Result := 'WM_MDIGETACTIVE';
  WM_MDISETMENU       : Result := 'WM_MDISETMENU';

  WM_ENTERSIZEMOVE    : Result := 'WM_ENTERSIZEMOVE';
  WM_EXITSIZEMOVE     : Result := 'WM_EXITSIZEMOVE';
  WM_DROPFILES        : Result := 'WM_DROPFILES';
  WM_MDIREFRESHMENU   : Result := 'WM_MDIREFRESHMENU';

  WM_MOUSEHOVER       : Result := 'WM_MOUSEHOVER';
  WM_MOUSELEAVE       : Result := 'WM_MOUSELEAVE';

  WM_NCMOUSEHOVER     : Result := 'WM_NCMOUSEHOVER';
  WM_NCMOUSELEAVE     : Result := 'WM_NCMOUSELEAVE';
  WM_WTSSESSION_CHANGE : Result := 'WM_WTSSESSION_CHANGE';

  WM_TABLET_LAST      : Result := 'WM_TABLET_LAST';

  WM_CUT              : Result := 'WM_CUT';
  WM_COPY             : Result := 'WM_COPY';
  WM_PASTE            : Result := 'WM_PASTE';
  WM_CLEAR            : Result := 'WM_CLEAR';
  WM_UNDO             : Result := 'WM_UNDO';
  WM_RENDERFORMAT     : Result := 'WM_RENDERFORMAT';
  WM_RENDERALLFORMATS : Result := 'WM_RENDERALLFORMATS';
  WM_DESTROYCLIPBOARD : Result := 'WM_DESTROYCLIPBOARD';
  WM_DRAWCLIPBOARD    : Result := 'WM_DRAWCLIPBOARD';
  WM_PAINTCLIPBOARD   : Result := 'WM_PAINTCLIPBOARD';
  WM_VSCROLLCLIPBOARD : Result := 'WM_VSCROLLCLIPBOARD';
  WM_SIZECLIPBOARD    : Result := 'WM_SIZECLIPBOARD';
  WM_ASKCBFORMATNAME  : Result := 'WM_ASKCBFORMATNAME';
  WM_CHANGECBCHAIN    : Result := 'WM_CHANGECBCHAIN';
  WM_HSCROLLCLIPBOARD : Result := 'WM_HSCROLLCLIPBOARD';
  WM_QUERYNEWPALETTE  : Result := 'WM_QUERYNEWPALETTE';
  WM_PALETTEISCHANGING: Result := 'WM_PALETTEISCHANGING=';
  WM_PALETTECHANGED   : Result := 'WM_PALETTECHANGED';
  WM_HOTKEY           : Result := 'WM_HOTKEY';

  WM_PRINT           : Result := 'WM_PRINT';
  WM_PRINTCLIENT     : Result := 'WM_PRINTCLIENT';
  WM_APPCOMMAND       : Result := 'WM_APPCOMMAND';
  WM_THEMECHANGED     : Result := 'WM_THEMECHANGED';

  WM_CLIPBOARDUPDATE  : Result := 'WM_CLIPBOARDUPDATE';

  WM_PENWINFIRST      : Result := 'WM_PENWINFIRST';
  WM_PENWINLAST       : Result := 'WM_PENWINLAST';

  WM_DWMCOMPOSITIONCHANGED        : Result := 'WM_DWMCOMPOSITIONCHANGED';
  WM_DWMNCRENDERINGCHANGED        : Result := 'WM_DWMNCRENDERINGCHANGED';
  WM_DWMCOLORIZATIONCOLORCHANGED  : Result := 'WM_DWMCOLORIZATIONCOLORCHANGED';
  WM_DWMWINDOWMAXIMIZEDCHANGE     : Result := 'WM_DWMWINDOWMAXIMIZEDCHANGE';

  WM_DWMSENDICONICTHUMBNAIL       : Result := 'WM_DWMSENDICONICTHUMBNAIL';
  WM_DWMSENDICONICLIVEPREVIEWBITMAP : Result := 'WM_DWMSENDICONICLIVEPREVIEWBITMAP';

  WM_GETTITLEBARINFOEX : Result := 'WM_GETTITLEBARINFOEX';

  WM_APP : Result := 'WM_APP';

  BM_GETCHECK : Result := 'BM_GETCHECK';
  BM_SETCHECK : Result := 'BM_SETCHECK';
  BM_GETSTATE : Result := 'BM_GETSTATE';
  BM_SETSTATE : Result := 'BM_SETSTATE';
  BM_SETSTYLE : Result := 'BM_SETSTYLE';
  BM_CLICK    : Result := 'BM_CLICK';
  BM_GETIMAGE : Result := 'BM_GETIMAGE';
  BM_SETIMAGE : Result := 'BM_SETIMAGE';
  BM_SETDONTCLICK : Result := 'BM_SETDONTCLICK';

  LB_ADDSTRING           : Result := 'LB_ADDSTRING';
  LB_INSERTSTRING        : Result := 'LB_INSERTSTRING';
  LB_DELETESTRING        : Result := 'LB_DELETESTRING';
  LB_SELITEMRANGEEX      : Result := 'LB_SELITEMRANGEEX';
  LB_RESETCONTENT        : Result := 'LB_RESETCONTENT';
  LB_SETSEL              : Result := 'LB_SETSEL';
  LB_SETCURSEL           : Result := 'LB_SETCURSEL';
  LB_GETSEL              : Result := 'LB_GETSEL';
  LB_GETCURSEL           : Result := 'LB_GETCURSEL';
  LB_GETTEXT             : Result := 'LB_GETTEXT';
  LB_GETTEXTLEN          : Result := 'LB_GETTEXTLEN';
  LB_GETCOUNT            : Result := 'LB_GETCOUNT';
  LB_SELECTSTRING        : Result := 'LB_SELECTSTRING';
  LB_DIR                 : Result := 'LB_DIR';
  LB_GETTOPINDEX         : Result := 'LB_GETTOPINDEX';
  LB_FINDSTRING          : Result := 'LB_FINDSTRING';
  LB_GETSELCOUNT         : Result := 'LB_GETSELCOUNT';
  LB_GETSELITEMS         : Result := 'LB_GETSELITEMS';
  LB_SETTABSTOPS         : Result := 'LB_SETTABSTOPS';
  LB_GETHORIZONTALEXTENT : Result := 'LB_GETHORIZONTALEXTENT';
  LB_SETHORIZONTALEXTENT : Result := 'LB_SETHORIZONTALEXTENT';
  LB_SETCOLUMNWIDTH      : Result := 'LB_SETCOLUMNWIDTH';
  LB_ADDFILE             : Result := 'LB_ADDFILE';
  LB_SETTOPINDEX         : Result := 'LB_SETTOPINDEX';
  LB_GETITEMRECT         : Result := 'LB_GETITEMRECT';
  LB_GETITEMDATA         : Result := 'LB_GETITEMDATA';
  LB_SETITEMDATA         : Result := 'LB_SETITEMDATA';
  LB_SELITEMRANGE        : Result := 'LB_SELITEMRANGE';
  LB_SETANCHORINDEX      : Result := 'LB_SETANCHORINDEX';
  LB_GETANCHORINDEX      : Result := 'LB_GETANCHORINDEX';
  LB_SETCARETINDEX       : Result := 'LB_SETCARETINDEX';
  LB_GETCARETINDEX       : Result := 'LB_GETCARETINDEX';
  LB_SETITEMHEIGHT       : Result := 'LB_SETITEMHEIGHT';
  LB_GETITEMHEIGHT       : Result := 'LB_GETITEMHEIGHT';
  LB_FINDSTRINGEXACT     : Result := 'LB_FINDSTRINGEXACT';
  LB_SETLOCALE           : Result := 'LB_SETLOCALE';
  LB_GETLOCALE           : Result := 'LB_GETLOCALE';
  LB_SETCOUNT            : Result := 'LB_SETCOUNT';
  LB_INITSTORAGE         : Result := 'LB_INITSTORAGE';
  LB_ITEMFROMPOINT       : Result := 'LB_ITEMFROMPOINT';
  
  CB_GETEDITSEL            : Result := 'CB_GETEDITSEL';
  CB_LIMITTEXT             : Result := 'CB_LIMITTEXT';
  CB_SETEDITSEL            : Result := 'CB_SETEDITSEL';
  CB_ADDSTRING             : Result := 'CB_ADDSTRING';
  CB_DELETESTRING          : Result := 'CB_DELETESTRING';
  CB_DIR                   : Result := 'CB_DIR';
  CB_GETCOUNT              : Result := 'CB_GETCOUNT';
  CB_GETCURSEL             : Result := 'CB_GETCURSEL';
  CB_GETLBTEXT             : Result := 'CB_GETLBTEXT';
  CB_GETLBTEXTLEN          : Result := 'CB_GETLBTEXTLEN';
  CB_INSERTSTRING          : Result := 'CB_INSERTSTRING';
  CB_RESETCONTENT          : Result := 'CB_RESETCONTENT';
  CB_FINDSTRING            : Result := 'CB_FINDSTRING';
  CB_SELECTSTRING          : Result := 'CB_SELECTSTRING';
  CB_SETCURSEL             : Result := 'CB_SETCURSEL';
  CB_SHOWDROPDOWN          : Result := 'CB_SHOWDROPDOWN';
  CB_GETITEMDATA           : Result := 'CB_GETITEMDATA';
  CB_SETITEMDATA           : Result := 'CB_SETITEMDATA';
  CB_GETDROPPEDCONTROLRECT : Result := 'CB_GETDROPPEDCONTROLRECT';
  CB_SETITEMHEIGHT         : Result := 'CB_SETITEMHEIGHT';
  CB_GETITEMHEIGHT         : Result := 'CB_GETITEMHEIGHT';
  CB_SETEXTENDEDUI         : Result := 'CB_SETEXTENDEDUI';
  CB_GETEXTENDEDUI         : Result := 'CB_GETEXTENDEDUI';
  CB_GETDROPPEDSTATE       : Result := 'CB_GETDROPPEDSTATE';
  CB_FINDSTRINGEXACT       : Result := 'CB_FINDSTRINGEXACT';
  CB_SETLOCALE             : Result := 'CB_SETLOCALE';
  CB_GETLOCALE             : Result := 'CB_GETLOCALE';
  CB_GETTOPINDEX           : Result := 'CB_GETTOPINDEX';
  CB_SETTOPINDEX           : Result := 'CB_SETTOPINDEX';
  CB_GETHORIZONTALEXTENT   : Result := 'CB_GETHORIZONTALEXTENT';
  CB_SETHORIZONTALEXTENT   : Result := 'CB_SETHORIZONTALEXTENT';
  CB_GETDROPPEDWIDTH       : Result := 'CB_GETDROPPEDWIDTH';
  CB_SETDROPPEDWIDTH       : Result := 'CB_SETDROPPEDWIDTH';
  CB_INITSTORAGE           : Result := 'CB_INITSTORAGE';
  
  EM_GETSEL              : Result := 'EM_GETSEL';
  EM_SETSEL              : Result := 'EM_SETSEL';
  EM_GETRECT             : Result := 'EM_GETRECT';
  EM_SETRECT             : Result := 'EM_SETRECT';
  EM_SETRECTNP           : Result := 'EM_SETRECTNP';
  EM_SCROLL              : Result := 'EM_SCROLL';
  EM_LINESCROLL          : Result := 'EM_LINESCROLL';
  EM_SCROLLCARET         : Result := 'EM_SCROLLCARET';
  EM_GETMODIFY           : Result := 'EM_GETMODIFY';
  EM_SETMODIFY           : Result := 'EM_SETMODIFY';
  EM_GETLINECOUNT        : Result := 'EM_GETLINECOUNT';
  EM_LINEINDEX           : Result := 'EM_LINEINDEX';
  EM_SETHANDLE           : Result := 'EM_SETHANDLE';
  EM_GETHANDLE           : Result := 'EM_GETHANDLE';
  EM_GETTHUMB            : Result := 'EM_GETTHUMB';
  EM_LINELENGTH          : Result := 'EM_LINELENGTH';
  EM_REPLACESEL          : Result := 'EM_REPLACESEL';
  EM_GETLINE             : Result := 'EM_GETLINE';

  EM_CANUNDO             : Result := 'EM_CANUNDO';
  EM_UNDO                : Result := 'EM_UNDO';
  EM_FMTLINES            : Result := 'EM_FMTLINES';
  EM_LINEFROMCHAR        : Result := 'EM_LINEFROMCHAR';
  EM_SETTABSTOPS         : Result := 'EM_SETTABSTOPS';
  EM_SETPASSWORDCHAR     : Result := 'EM_SETPASSWORDCHAR';
  EM_EMPTYUNDOBUFFER     : Result := 'EM_EMPTYUNDOBUFFER';
  EM_GETFIRSTVISIBLELINE : Result := 'EM_GETFIRSTVISIBLELINE';
  EM_SETREADONLY         : Result := 'EM_SETREADONLY';
  EM_SETWORDBREAKPROC    : Result := 'EM_SETWORDBREAKPROC';
  EM_GETWORDBREAKPROC    : Result := 'EM_GETWORDBREAKPROC';
  EM_GETPASSWORDCHAR     : Result := 'EM_GETPASSWORDCHAR';
  EM_SETMARGINS          : Result := 'EM_SETMARGINS';
  EM_GETMARGINS          : Result := 'EM_GETMARGINS';
  EM_SETLIMITTEXT        : Result := 'EM_SETLIMITTEXT';   
  EM_GETLIMITTEXT        : Result := 'EM_GETLIMITTEXT';
  EM_POSFROMCHAR         : Result := 'EM_POSFROMCHAR';
  EM_CHARFROMPOS         : Result := 'EM_CHARFROMPOS';
  
  SBM_SETPOS           : Result := 'SBM_SETPOS';
  SBM_GETPOS           : Result := 'SBM_GETPOS';
  SBM_SETRANGE         : Result := 'SBM_SETRANGE';
  SBM_SETRANGEREDRAW   : Result := 'SBM_SETRANGEREDRAW';
  SBM_GETRANGE         : Result := 'SBM_GETRANGE';
  SBM_ENABLE_ARROWS    : Result := 'SBM_ENABLE_ARROWS';
  SBM_SETSCROLLINFO    : Result := 'SBM_SETSCROLLINFO';
  SBM_GETSCROLLINFO    : Result := 'SBM_GETSCROLLINFO';
  
  CM_APPKEYDOWN : Result  := 'CM_APPKEYDOWN';

  else if msg >= $0400 then
    Result :=  Format('WM_USER($%x)', [msg])
  else
    Result := Format('WM_???($%x)', [msg]);
  end;
end;

function SWP_FLAGS_ToString(x: UINT): string;
const
  flags: array [0..15]of UINT = (
  SWP_NOSIZE, SWP_NOMOVE, SWP_NOZORDER, SWP_NOREDRAW,
  SWP_NOACTIVATE, SWP_FRAMECHANGED, SWP_SHOWWINDOW, SWP_HIDEWINDOW,
  SWP_NOCOPYBITS, SWP_NOOWNERZORDER, SWP_NOSENDCHANGING, SWP_DRAWFRAME,
  SWP_FRAMECHANGED, SWP_NOREPOSITION,
  SWP_DEFERERASE,
  SWP_ASYNCWINDOWPOS
  );
  flags_str: array [0..15] of string = (
  'SWP_NOSIZE', 'SWP_NOMOVE', 'SWP_NOZORDER', 'SWP_NOREDRAW',
  'SWP_NOACTIVATE', 'SWP_FRAMECHANGED', 'SWP_SHOWWINDOW', 'SWP_HIDEWINDOW',
  'SWP_NOCOPYBITS', 'SWP_NOOWNERZORDER', 'SWP_NOSENDCHANGING', 'SWP_DRAWFRAME',
  'SWP_FRAMECHANGED', 'SWP_NOREPOSITION',
  'SWP_DEFERERASE',
  'SWP_ASYNCWINDOWPOS'
  );
var
  i: Integer;
begin
  Result := '';
  for I :=0 to Length(flags)-1 do
    begin
      if  x and flags[i] <> 0 then
        if i = 0 then
          Result := flags_str[i] else
          Result := Result +', ' + flags_str[i];
    end;

end;

function FormatMessage(hwnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): string;
begin
  case msg of
    WM_KEYDOWN, WM_KEYUP, WM_CHAR :
      begin
        Result := Format('%x  $%s '+sLineBreak+
                         '  wParam $%x'+sLineBreak+
                         '    virtKey %s'+sLineBreak+
                         '  lParam $%x'+sLineBreak+
                         '    fRepeat %x' +
                         '    ScanCode $%x' +
                         '    fExtended %x' +
                         '    contextCode(ALT key) %x' +
                         '    fPreviosState %x'+
                         '    transition state %x' ,
                        [hwnd, MessageStr(msg), wParam, chr(wParam),
                        lParam, lParam and $0000FFFF, (lParam and $00F70000) shr 16,
                        (lParam and $01000000) shr 24, (lParam and $20000000) shr 29,
                        (lParam and $40000000) shr 30, (lParam and $80000000) shr 31]);
      end;
    WM_WINDOWPOSCHANGING, WM_WINDOWPOSCHANGED:
      begin
        Result := Format('%x  $%s '+sLineBreak+
                         '  wParam $%x'+sLineBreak+
                         '  lParam $%x'+sLineBreak+
                         '    hwnd %x' + sLineBreak+
                         '    hwndInsertAfter $%x' + sLineBreak+
                         '    x %x' + sLineBreak+
                         '    y %x' + sLineBreak+
                         '    cx %x'+ sLineBreak+
                         '    cy %x'+ sLineBreak+
                         '    flags %x (%s)'  ,
                        [hwnd, MessageStr(msg), wParam, lParam,
                        PWindowPos(lParam).hwnd, PWindowPos(lParam).hwndInsertAfter,
                        PWindowPos(lParam).x, PWindowPos(lParam).y,
                        PWindowPos(lParam).cx, PWindowPos(lParam).cy,
                        PWindowPos(lParam).flags, SWP_FLAGS_ToString(PWindowPos(lParam).flags)
                        ]);
      end;
    else
      Result := Format('%x %s wParam $%x lParam $%x', [hwnd, MessageStr(msg),  wParam, lParam]);

  end;
end;

function MessageToString(const Msg: TMsg): string; overload;
begin
  Result := FormatMessage(msg.hwnd, msg.message,  Msg.wParam, Msg.lParam);
end;
function MessageToString(wnd: HWND; Msg: UINT; wParam: WPARAM; lParam: LPARAM): string; overload;
begin
  Result := FormatMessage(wnd, msg,  wParam, lParam);
end;
function MessageToString(const Msg: TMessage): string; overload;
begin
   Result := Format('%s wParam $%x lParam $%x', [MessageStr(msg.Msg), Msg.WParam, Msg.LParam]);
end;

function TMsgHelper.ToString: string;
begin
  Result := MessageToString(Self)
end;

end.

