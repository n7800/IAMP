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

unit CollEdit;

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
  ComCtrls, ExtCtrls, StdCtrls, InspCtrl, CompInsp, Menus, TypInfo, PropList,
  PropEdit, DBGrids;

type 

  TCollectionPropertyEditor = class(TPropertyEditor)
  private
    function GetCollection: TCollection;
  public
    function Execute: Boolean; override;
    property Collection: TCollection read GetCollection;
  end;

  TTargetPosition = (tpNone,tpTop,tpItem,tpBottom);

  TfrmCollectionEditor = class(TForm)
    splMain: TSplitter;
    pnlButtons: TPanel;
    btnAdd: TButton;
    btnDelete: TButton;
    pnlSysButtons: TPanel;
    btnClose: TButton;
    cinItemProperties: TComponentInspector;
    lsbItems: TListBox;
    btnUp: TButton;
    btnDown: TButton;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure lsbItemsClick(Sender: TObject);
    procedure lsbItemsDragOver(Sender, Source: TObject; X, Y: Integer;
      State: TDragState; var Accept: Boolean);
    procedure lsbItemsDragDrop(Sender, Source: TObject; X, Y: Integer);
    procedure lsbItemsMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure btnUpClick(Sender: TObject);
    procedure btnDownClick(Sender: TObject);
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure cinItemPropertiesChange(Sender: TObject; TheIndex: Integer);
    procedure cinItemPropertiesExit(Sender: TObject);
  private
    
    FEditor: TCollectionPropertyEditor;
    FDragIndex: Integer;
    {$IFnDEF FPC}
    procedure WMGetMinMaxInfo(var Msg: TMessage); message WM_GETMINMAXINFO;
    {$ENDIF}
    function ItemText(CI: TCollectionItem): string;
    procedure UpdateSelection;
    procedure MoveUp(Target: Integer);
    procedure MoveDown(Target: Integer);
    procedure Reorder;
    procedure FillList;
  public
    
  end;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

function TCollectionPropertyEditor.GetCollection: TCollection;
begin
  Result:=Prop.AsObject as TCollection;
end;

function TCollectionPropertyEditor.Execute: Boolean;
begin
  Result:=True;
  with TfrmCollectionEditor.Create(Application) do
  try
    FEditor:=Self;
    FillList;
    {$IFNDEF FPC}
    if Collection is TDBGridColumns then
      TDBGridColumns(Collection).State:=csCustomized;
    {$ENDIF}
    with cinItemProperties do
    begin
      Root:=TCompInspPropertyList(Prop.Owner).Root;
      PaintStyle:=TCompInspPropertyList(Prop.Owner).CompInspList.Owner.PaintStyle;
      TCompInspPropertyList(Prop.Owner).CompInspList.Owner.CustomizeInspector(cinItemProperties);
    end;
    ShowModal;
  finally
    Free;
  end;
end;

{$IFnDEF FPC}
procedure TfrmCollectionEditor.WMGetMinMaxInfo(var Msg: TMessage);
begin
  inherited;
  with PMinMaxInfo(Msg.LParam)^.ptMinTrackSize do
  begin
    X:=415;
    Y:=200;
  end;
end;
{$ENDIF}

function TfrmCollectionEditor.ItemText(CI: TCollectionItem): string;
begin
  with CI do
    Result:=Format('%d - %s',[Index,DisplayName]);
end;

procedure TfrmCollectionEditor.UpdateSelection;
var
  i,Idx: Integer;
begin
  with cinItemProperties,lsbItems,Items do
    if (SelCount<1) or (ItemIndex=-1) then Instance:=nil
    else
      if (SelCount=1) and (Instance<>Objects[ItemIndex]) then Instance:=TComponent(Objects[ItemIndex])
      else
      begin
        i:=0;
        while i<InstanceCount do
        begin
          Idx:=IndexOfObject(Instances[i]);
          if (Idx<>-1) and not Selected[Idx] then DeleteInstance(Instances[i])
          else Inc(i);
        end;
        for i:=0 to Pred(Count) do
          if Selected[i] and (IndexOfInstance(TComponent(Objects[i]))=-1) then
            AddInstance(TComponent(Objects[i]));
      end;
end;

procedure TfrmCollectionEditor.MoveUp(Target: Integer);
var
  i,OldSelCount: Integer;
begin
  with lsbItems,Items do
  begin
    OldSelCount:=SelCount;
    for i:=0 to Pred(Count) do
      if Selected[i] then
      begin
        Move(i,Target);
        Inc(Target);
      end;
    Reorder;
    for i:=Target-OldSelCount to Pred(Target) do Selected[i]:=True;
  end;
end;

procedure TfrmCollectionEditor.MoveDown(Target: Integer);
var
  i,OldSelCount: Integer;
begin
  with lsbItems,Items do
  begin
    OldSelCount:=SelCount;
    i:=0;
    while (i<Count) and (SelCount>0) do
      if Selected[i] and (i<>Target) then Move(i,Target)
      else Inc(i);
    Reorder;
    for i:=Target-Pred(OldSelCount) to Target do Selected[i]:=True;
  end;
end;

procedure TfrmCollectionEditor.Reorder;
var
  i: Integer;
  Sel: Boolean;
begin
  with lsbItems,Items do
    for i:=0 to Pred(Count) do
    begin
      Sel:=Selected[i];
      TCollectionItem(Objects[i]).Index:=i;
      Items[i]:=ItemText(TCollectionItem(Objects[i]));
      if Sel then Selected[i]:=True;
    end;
end;

procedure TfrmCollectionEditor.FillList;
var
  i: Integer;
begin
  with FEditor,lsbItems do
  begin
    Items.BeginUpdate;
    try
      Items.Clear;
      for i:=0 to Pred(Collection.Count) do
        
        if Collection.Items [i] is Collection.ItemClass then
          lsbItems.Items.AddObject(ItemText(Collection.Items[i]),Collection.Items[i]);
    finally
      Items.EndUpdate;
    end;
  end;
end;

procedure TfrmCollectionEditor.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  cinItemProperties.ApplyChanges;
end;

procedure TfrmCollectionEditor.FormShow(Sender: TObject);
begin
  with lsbItems,Items do
  begin
    if Count>0 then
    begin
      ItemIndex:=0;
      Selected[0]:=True;
      UpdateSelection;
    end
    else cinItemProperties.Instance:=nil;
    btnDelete.Enabled:=SelCount>0;
  end;
end;

procedure TfrmCollectionEditor.lsbItemsClick(Sender: TObject);
begin
  UpdateSelection;
end;

procedure TfrmCollectionEditor.lsbItemsDragOver(Sender, Source: TObject; X,
  Y: Integer; State: TDragState; var Accept: Boolean);
var
  Index: Integer;
begin
  with lsbItems do
  begin
    Index:=ItemAtPos(Point(X,Y),True);
    Accept:=(Index>=0) and (Index<Items.Count) and not Selected[Index];
  end;
end;

procedure TfrmCollectionEditor.lsbItemsDragDrop(Sender, Source: TObject; X,
  Y: Integer);
var
  Index: Integer;
begin
  with lsbItems do
  begin
    Index:=ItemAtPos(Point(X,Y),True);
    if Index<FDragIndex then MoveUp(Index)
    else MoveDown(Index);
  end;
end;

procedure TfrmCollectionEditor.lsbItemsMouseDown(Sender: TObject;
  Button: TMouseButton; Shift: TShiftState; X, Y: Integer);
begin
  FDragIndex:=lsbItems.ItemAtPos(Point(X,Y),True);
end;

procedure TfrmCollectionEditor.btnUpClick(Sender: TObject);
var
  i,Index: Integer;
begin
  Index:=-1;
  with lsbItems,Items do
    for i:=0 to Pred(Count) do
      if Selected[i] then
      begin
        Index:=i;
        Break;
      end;
  case Index of
    -1:;
    0: MoveUp(Index);
  else MoveUp(Pred(Index));
  end;
end;

procedure TfrmCollectionEditor.btnDownClick(Sender: TObject);
var
  i,Index: Integer;
begin            
  Index:=-1;
  with lsbItems,Items do
  begin
    for i:=Pred(Count) downto 0 do
      if Selected[i] then
      begin
        Index:=i;
        Break;
      end;
    if Index<>-1 then
      if Index=Pred(Count) then MoveDown(Index)
      else MoveDown(Succ(Index));
  end
end;

procedure TfrmCollectionEditor.btnAddClick(Sender: TObject);
var
  Index: Integer;
  CI: TCollectionItem;
begin
  with lsbItems,Items do
  begin
    with FEditor do CI:=Collection.ItemClass.Create(Collection);
    for Index:=0 to Pred(Count) do Selected[Index]:=False;
    FillList;
    Selected[CI.Index]:=True;
    cinItemProperties.Instance := CI;
    btnDelete.Enabled:=SelCount>0;
  end;
end;

procedure TfrmCollectionEditor.btnDeleteClick(Sender: TObject);
var
  i,OldSel: Integer;
begin
  with lsbItems,Items do
  begin
    OldSel:=ItemIndex;
    i:=0;
    while (i<Count) and (SelCount>0) do
      if Selected[i] then
      begin
        Delete(i);
        FEditor.Collection.Items[i].Free;
      end
      else Inc(i);
    FillList;
    if OldSel>Pred(Count) then OldSel:=Pred(Count);
    ItemIndex:=OldSel;
    Selected[OldSel]:=True;
    btnDelete.Enabled:=SelCount>0;
  end;
  UpdateSelection;
end;

procedure TfrmCollectionEditor.cinItemPropertiesChange(Sender: TObject;
  TheIndex: Integer);
begin
  Reorder;
end;

procedure TfrmCollectionEditor.cinItemPropertiesExit(Sender: TObject);
begin
  cinItemProperties.ApplyChanges;
end;

end.
