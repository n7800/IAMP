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

unit ListView;

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  ComCtrls, ExtCtrls, StdCtrls, InspCtrl, CompInsp, TypInfo, PropList, PropEdit;

type

  TListViewPropertyEditor = class(TPropertyEditor)
  private
    function GetListItems: TListItems;
  public
    function Execute: Boolean; override;
    property ListItems: TListItems read GetListItems;
  end;

  TTargetPosition = (tpNone,tpTop,tpItem,tpBottom);

  TInspectorData = class(TPersistent)
  private
    FCaption: string;
    FImageIndex: Integer;
    FStateIndex: Integer;
    FSubitems: TStrings;
  published
    property Caption: string read FCaption write FCaption;
    property ImageIndex: Integer read FImageIndex write FImageIndex;
    property StateIndex: Integer read FStateIndex write FStateIndex;
    property Subitems: TStrings read FSubitems write FSubitems;
  public
    constructor Create;
    destructor Destroy; override;
  end;

  TfrmListViewEditor = class(TForm)
    splMain: TSplitter;
    pnlButtons: TPanel;
    btnAdd: TButton;
    btnDelete: TButton;
    pnlSysButtons: TPanel;
    btnOK: TButton;
    btnCancel: TButton;
    cinItemProperties: TComponentInspector;
    lsvItems: TListView;
    btnUp: TButton;
    btnDown: TButton;
    procedure lsvItemsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lsvItemsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure FormActivate(Sender: TObject);
    procedure trvItemsStartDrag(Sender: TObject;
      var DragObject: TDragObject);
    procedure FormDestroy(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cinItemPropertiesExit(Sender: TObject);
    procedure cinItemPropertiesChange(Sender: TObject; TheIndex: Integer);
    procedure lsvItemsChange(Sender: TObject; Item: TListItem;
      Change: TItemChange);
    procedure FormShow(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
  private
    
    FEditor: TListViewPropertyEditor;
    DragItem: TListItem;
    FInspectorData: TInspectorData;
    procedure ItemToData(Item: TListItem; Data: TInspectorData);
    procedure DataToItem(Data: TInspectorData; Item: TListItem);
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

function TListViewPropertyEditor.GetListItems: TListItems;
begin
  Result:=Prop.AsObject as TListItems;
end;

function TListViewPropertyEditor.Execute: Boolean;
begin
  with TfrmListViewEditor.Create(Application) do
  try
    FEditor:=Self;
    lsvItems.Items.Assign(ListItems);
    with cinItemProperties do
    begin
      if ListItems.Count>0 then
      begin
        ItemToData(lsvItems.Items[0], FInspectorData);
        Instance:= FInspectorData;
      end
      else Instance:=nil;
      Root:=TCompInspPropertyList(Prop.Owner).Root;
      PaintStyle:=TCompInspPropertyList(Prop.Owner).CompInspList.Owner.PaintStyle;
      TCompInspPropertyList(Prop.Owner).CompInspList.Owner.CustomizeInspector(cinItemProperties);
    end;
    Result:=ShowModal=mrOK;
    if Result then ListItems.Assign(lsvItems.Items);
  finally
    Free;
  end;
end;

constructor TInspectorData.Create;
begin
  inherited;
  FSubitems:=TStringList.Create;
end;

destructor TInspectorData.Destroy;
begin
  FSubitems.Free;
  inherited;
end;

procedure TfrmListViewEditor.lsvItemsDragOver(Sender, Source: TObject; X, Y: Integer;
  State: TDragState; var Accept: Boolean);
begin
  Accept:=Sender=Source;
  if Accept then DragItem:=lsvItems.GetItemAt(X,Y);
end;

procedure TfrmListViewEditor.lsvItemsDragDrop(Sender, Source: TObject; X, Y: Integer);
var
  I: TListItem;
begin
  with lsvItems,Items do
    if Assigned(DragItem) and (DragItem<>Selected) then
    begin
      I:=TListItem.Create(lsvItems.Items);
      try
        I.Assign(Selected);
        Selected.Free;
        Selected:=Insert(DragItem.Index);
        Selected.Assign(I);
        ItemFocused:=Selected;
      finally
        I.Free;
      end;
    end;
end;

procedure TfrmListViewEditor.FormActivate(Sender: TObject);
begin
  with FEditor do
    if ListItems.Count>0 then
    begin
      ItemToData(lsvItems.Items[0],FInspectorData);
      cinItemProperties.Instance:= FInspectorData;
    end
    else cinItemProperties.Instance:=nil;
end;

procedure TfrmListViewEditor.ItemToData(Item: TListItem; Data: TInspectorData);
begin
  Data.Caption:=Item.Caption;
  Data.ImageIndex:=Item.ImageIndex;
  Data.StateIndex:=Item.StateIndex;
  Data.Subitems.Assign(Item.Subitems);
end;

procedure TfrmListViewEditor.DataToItem(Data: TInspectorData; Item: TListItem);
begin
  Item.Caption:=Data.Caption;
  Item.ImageIndex:=Data.ImageIndex;
  Item.StateIndex:=Data.StateIndex;
  Item.Subitems.Assign(Data.Subitems);
end;

{$IFnDEF FPC}
procedure TfrmListViewEditor.WMGetMinMaxInfo(var Msg: TMessage);
begin
  inherited;
  with PMinMaxInfo(Msg.LParam)^.ptMinTrackSize do
  begin
    X:=413;
    Y:=200;
  end;
end;
{$ENDIF}

procedure TfrmListViewEditor.trvItemsStartDrag(Sender: TObject;
  var DragObject: TDragObject);
begin
  DragItem:=nil;
end;

procedure TfrmListViewEditor.FormDestroy(Sender: TObject);
begin
  FInspectorData.Free;
end;

procedure TfrmListViewEditor.FormCreate(Sender: TObject);
begin
  FInspectorData:=TInspectorData.Create;
end;

procedure TfrmListViewEditor.btnDeleteClick(Sender: TObject);
var
  I: Integer;
begin
  with lsvItems do
    if Assigned(Selected) then
    begin
      I:=Selected.Index;
      Selected.Free;
      if Items.Count>0 then
      begin
        if I>Pred(Items.Count) then I:=Pred(Items.Count);
        Selected:=Items[I];
        ItemFocused:=Selected;
      end
      else cinItemProperties.Instance:=nil;
    end;
end;

procedure TfrmListViewEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  if ModalResult=mrOk then cinItemProperties.ApplyChanges;
end;

procedure TfrmListViewEditor.cinItemPropertiesExit(Sender: TObject);
begin
  cinItemProperties.ApplyChanges;
end;

procedure TfrmListViewEditor.cinItemPropertiesChange(Sender: TObject;
  TheIndex: Integer);
begin
  with cinItemProperties do
    DataToItem(FInspectorData,lsvItems.Selected);
end;

procedure TfrmListViewEditor.lsvItemsChange(Sender: TObject;
  Item: TListItem; Change: TItemChange);
begin
  if not (csDestroying in ComponentState) then
    if (Change=ctState) and not (lsvItems.Dragging) then
    begin
      ItemToData(Item,FInspectorData);
      cinItemProperties.Instance:= FInspectorData;
    end;
end;

procedure TfrmListViewEditor.FormShow(Sender: TObject);
begin
  with lsvItems,Items do
  begin
    if Count>0 then ItemFocused:=Items[0];
    Selected:=ItemFocused;
  end;
end;

procedure TfrmListViewEditor.btnAddClick(Sender: TObject);
begin
  with lsvItems do
  begin
    ItemFocused:=Items.Add;
    ItemFocused.Caption:='NewItem';
    Selected:=ItemFocused;
  end;
end;

procedure TfrmListViewEditor.btnUpClick(Sender: TObject);
var
  I: TListItem;
  Idx: Integer;
begin
  with lsvItems,Items do
    if Selected.Index>0 then
    begin
      I:=TListItem.Create(lsvItems.Items);
      try
        Idx:=Selected.Index;
        I.Assign(Selected);
        Selected.Free;
        Selected:=Insert(Pred(Idx));
        Selected.Assign(I);
        ItemFocused:=Selected;
      finally
        I.Free;
      end;
    end;
end;

procedure TfrmListViewEditor.btnDownClick(Sender: TObject);
var
  I: TListItem;
  Idx: Integer;
begin
  with lsvItems,Items do
    if Selected.Index<Pred(Count) then
    begin
      I:=TListItem.Create(lsvItems.Items);
      try
        Idx:=Selected.Index;
        I.Assign(Selected);
        Selected.Free;
        Selected:=Insert(Succ(Idx));
        Selected.Assign(I);
        ItemFocused:=Selected;
      finally
        I.Free;
      end;
    end;
end;

end.
