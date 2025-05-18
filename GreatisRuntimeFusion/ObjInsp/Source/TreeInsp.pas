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

unit TreeInsp;

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages, Themes,
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, InspCtrl, CompInsp, TypInfo, PropList, PropEdit;

type

  TTreePropertyEditor = class(TPropertyEditor)
  private
    function GetTreeNodes: TTreeNodes;
  public
    function Execute: Boolean; override;
    property TreeNodes: TTreeNodes read GetTreeNodes;
  end;

  TTargetPosition = (tpNone,tpTop,tpItem,tpBottom);

  TPublishedTreeNode = class(TTreeNode)
  published
    property Text;
    property ImageIndex;
    property StateIndex;
    property SelectedIndex;
  end;

  TfrmTreeEditor = class(TForm)
    splMain: TSplitter;
    trvItems: TTreeView;
    pnlButtons: TPanel;
    btnNewItem: TButton;
    btnNewSubitem: TButton;
    btnDeleteItem: TButton;
    pnlSysButtons: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    cinItemProperties: TComponentInspector;
    procedure btnAddItemClick(Sender: TObject);
    procedure trvItemsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure trvItemsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure trvItemsChange(Sender: TObject; Node: TTreeNode);
    procedure trvItemsStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDeleteItemClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cinItemPropertiesExit(Sender: TObject);
    procedure cinItemPropertiesChange(Sender: TObject; TheIndex: Integer);
  private
    
    ListViewCanvas: TCanvas;
    FEditor: TTreePropertyEditor;
    TargetPosition: TTargetPosition;
    DragNode: TTreeNode;
    FPublishedTreeNode: TPublishedTreeNode;
    procedure DrawTargetIndicator;
    procedure CopyProps(Src,Trg: TTreeNode);
    {$IFnDEF FPC}
    procedure WMGetMinMaxInfo(var Msg: TMessage); message WM_GETMINMAXINFO;
    {$ENDIF}
  public
    
  end;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

const
  ScrollArea = 6;

function TTreePropertyEditor.GetTreeNodes: TTreeNodes;
begin
  Result:=Prop.AsObject as TTreeNodes;
end;

function TTreePropertyEditor.Execute: Boolean;
begin
  with TfrmTreeEditor.Create(Application) do
  try
    FEditor:=Self;
    trvItems.Items.Assign(TreeNodes);
    with cinItemProperties do
    begin
      if TreeNodes.Count>0 then
      begin
        CopyProps(TreeNodes[0],FPublishedTreeNode);
        Instance:=FPublishedTreeNode;
      end
      else Instance:=nil;
      Root:=TCompInspPropertyList(Prop.Owner).Root;
      PaintStyle:=TCompInspPropertyList(Prop.Owner).CompInspList.Owner.PaintStyle;
      TCompInspPropertyList(Prop.Owner).CompInspList.Owner.CustomizeInspector(cinItemProperties);
    end;
    Result:=ShowModal=mrOK;
    if Result then TreeNodes.Assign(trvItems.Items);
  finally
    Free;
  end;
end;

procedure TfrmTreeEditor.btnAddItemClick(Sender: TObject);
begin
  with trvItems do
    if TControl(Sender).Tag=1 then Selected:=Items.Add(Selected,'NewItem')
    else Selected:=Items.AddChild(Selected,'NewItem');
end;

procedure TfrmTreeEditor.trvItemsDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
var
  R: TRect;
  MP: TPoint;
  SBHMin,SBHMax,SBVMin,SBVMax: Integer;
begin
  Accept:=Sender=Source;
  if Accept then
    with trvItems do
    begin
      DrawTargetIndicator;
      GetScrollRange(Handle,SB_VERT,SBVMin,SBVMax);
      GetScrollRange(Handle,SB_HORZ,SBHMin,SBHMax);
      GetCursorPos(MP);
      MP:=ScreenToClient(MP);
      while (Abs(MP.Y)<ScrollArea) and (GetScrollPos(Handle,SB_VERT)>SBVMin) do
      begin
        Perform(WM_VSCROLL,SB_LINEUP,0);
        Sleep(50);
        GetCursorPos(MP);
        MP:=ScreenToClient(MP);
      end;
      while (Abs(MP.Y-ClientHeight)<ScrollArea) and (GetScrollPos(Handle,SB_VERT)<SBVMax) do
      begin
        Perform(WM_VSCROLL,SB_LINEDOWN,0);
        Sleep(50);
        GetCursorPos(MP);
        MP:=ScreenToClient(MP);
      end;
      while (Abs(MP.X)<ScrollArea) and (GetScrollPos(Handle,SB_HORZ)>SBHMin) do
      begin
        Perform(WM_HSCROLL,SB_LINEUP,0);
        Sleep(50);
        GetCursorPos(MP);
        MP:=ScreenToClient(MP);
      end;
      while (Abs(MP.X-ClientWidth)<ScrollArea) and (GetScrollPos(Handle,SB_HORZ)<SBHMax) do
      begin
        Perform(WM_HSCROLL,SB_LINEDOWN,0);
        Sleep(50);
        GetCursorPos(MP);
        MP:=ScreenToClient(MP);
      end;
      DragNode:=GetNodeAt(X,Y);
      if Assigned(DragNode) then
      begin
        R:=DragNode.DisplayRect(True);
        if (X<R.Left-2) and not DragNode.Expanded and (DragNode.Count>0) then
        begin
          DragNode.Expand(False);
          
        end;
        with R do
          if Y<Top+(Bottom-Top) div 3 then TargetPosition:=tpTop
          else
            if Y>Top+2*(Bottom-Top) div 3 then TargetPosition:=tpBottom
            else TargetPosition:=tpItem;
        DrawTargetIndicator;
      end;
    end;
end;

procedure TfrmTreeEditor.trvItemsDragDrop(Sender, Source: TObject; X, Y: Integer);
begin
  DrawTargetIndicator;
  if Assigned(DragNode) and (DragNode<>trvItems.Selected) then
    with trvItems,Selected do
      case TargetPosition of
        tpTop: MoveTo(DragNode,naInsert);
        tpItem: MoveTo(DragNode,naAddChild);
        tpBottom:
          if DragNode.GetNextSibling<>nil then MoveTo(DragNode.GetNextSibling,naInsert)
          else MoveTo(DragNode,naAdd);
      end;
end;

procedure TfrmTreeEditor.FormActivate(Sender: TObject);
begin
  with FEditor do
    if TreeNodes.Count>0 then
    begin
      CopyProps(TreeNodes[0],FPublishedTreeNode);
      cinItemProperties.Instance := FPublishedTreeNode;
    end
    else cinItemProperties.Instance:=nil;
  ListViewCanvas:=TCanvas.Create;
  ListViewCanvas.Handle:=GetDC(trvItems.Handle);
end;

procedure TfrmTreeEditor.trvItemsChange(Sender: TObject; Node: TTreeNode);
begin
  CopyProps(Node,FPublishedTreeNode);
  cinItemProperties.Instance := FPublishedTreeNode;
end;

procedure TfrmTreeEditor.DrawTargetIndicator;
var
  R: TRect;
begin
  if Assigned(DragNode) then
  begin
    R:=DragNode.DisplayRect(True);
    with R,ListViewCanvas do
    begin
      Left:=Right+6;
      Inc(Right,16);
      case TargetPosition of

        tpTop: {$IFDEF FPC};{$ELSE}DrawIconEx(Handle,Left,Top,LoadIcon(HInstance,'TARGETTOP'),16,16,0,0,DI_NORMAL);{$ENDIF}
        tpItem:{$IFDEF FPC} ;{$ELSE}DrawIconEx(Handle,Left,Top+(Bottom-Top-6) div 2,LoadIcon(HInstance,'TARGETITEM'),16,16,0,0,DI_NORMAL);{$ENDIF}
        tpBottom: {$IFDEF FPC} ;{$ELSE}DrawIconEx(Handle,Left,Bottom-7,LoadIcon(HInstance,'TARGETBOTTOM'),16,16,0,0,DI_NORMAL);{$ENDIF}
      end;
    end;
  end;
end;

procedure TfrmTreeEditor.CopyProps(Src,Trg: TTreeNode);
begin
  Trg.Text:=Src.Text;
  Trg.ImageIndex:=Src.ImageIndex;
  Trg.SelectedIndex:=Src.SelectedIndex;
  Trg.StateIndex:=Src.StateIndex;
end;

{$IFnDEF FPC}
procedure TfrmTreeEditor.WMGetMinMaxInfo(var Msg: TMessage);
begin
  inherited;
  with PMinMaxInfo(Msg.LParam)^.ptMinTrackSize do
  begin
    X:=413;
    Y:=200;
  end;
end;
{$ENDIF}

procedure TfrmTreeEditor.trvItemsStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  TargetPosition:=tpNone;
  DragNode:=nil;
  DrawTargetIndicator;
end;

procedure TfrmTreeEditor.FormDestroy(Sender: TObject);
begin
  ListViewCanvas.Free;
  FPublishedTreeNode.Free;
end;

procedure TfrmTreeEditor.FormCreate(Sender: TObject);
begin
  FPublishedTreeNode:=TPublishedTreeNode.Create(trvItems.Items);
  ListViewCanvas:=TCanvas.Create;
  ListViewCanvas.Handle:=GetDC(trvItems.Handle);
end;

procedure TfrmTreeEditor.btnDeleteItemClick(Sender: TObject);
begin
  with trvItems do Selected.Free;
end;

procedure TfrmTreeEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult=mrOk then cinItemProperties.ApplyChanges;
end;

procedure TfrmTreeEditor.cinItemPropertiesExit(Sender: TObject);
begin
  cinItemProperties.ApplyChanges;
end;

procedure TfrmTreeEditor.cinItemPropertiesChange(Sender: TObject;
  TheIndex: Integer);
begin
  with cinItemProperties do
    CopyProps(FPublishedTreeNode,trvItems.Selected);
end;

end.
