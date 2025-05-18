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

unit DBInspct;

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
  SysUtils, Classes, Graphics, Forms, Controls, DB, DBCtrls,
  InspCtrl, StrsEdit, PicsEdit;

type

  TCustomDBInspector = class;

  TInspectorDataLink = class(TDataLink)
  private
    FInspector: TCustomDBInspector;
    procedure DataSetBeforePost(ADataSet: TDataSet);
  protected
    procedure CheckBrowseMode; override;
    procedure ActiveChanged; override;
    procedure DataSetChanged; override;
    procedure LayoutChanged; override;
    procedure RecordChanged(Field: TField); override;
  public
    constructor Create(AInspector: TCustomDBInspector);
  end;

  TBlobEditorType = (beNone,beText,beImage);

  TGetBlobEditorTypeEvent = procedure(Sender: TObject; Field: TField; var BlobEditorType: TBlobEditorType) of object;

  TCustomDBInspector = class(TCustomInspector)
  private
    FMyself: Boolean;
    FDataLink: TInspectorDataLink;
    FOnGetBlobEditorType: TGetBlobEditorTypeEvent;
    function GetDataSource: TDataSource;
    procedure SetDataSource(Value: TDataSource);
    function GetReadOnlyProperty: Boolean;
    procedure SetReadOnlyProperty(Value: Boolean);
    procedure ActiveChanged;
    function ActiveDataSet: Boolean;
    function LinkedDataSet: TDataSet;
    function VisibleCount: Integer;
  protected
    procedure ChangeValue(TheIndex: Integer; Editing: Boolean; const AText: string); override;
    function GetName(TheIndex: Integer): string; override;
    function GetValue(TheIndex: Integer): string; override;
    procedure SetValue(TheIndex: Integer; const Value: string); override;
    function GetMaxLength(TheIndex: Integer): Integer; override;
    function GetReadOnly(TheIndex: Integer): Boolean; override;
    function GetIndent: Integer; override;
    function GetAutoApply(TheIndex: Integer): Boolean; override;
    function GetButtonType(TheIndex: Integer): TButtonType; override;
    function GetEnableExternalEditor(TheIndex: Integer): Boolean; override;
    function CallEditor(TheIndex: Integer): Boolean; override;
    function GetBlobEditor: TBlobEditorType; virtual;
    property DataSource: TDataSource read GetDataSource write SetDataSource;
    property ReadOnly: Boolean read GetReadOnlyProperty write SetReadOnlyProperty default False;
    property OnGetBlobEditorType: TGetBlobEditorTypeEvent read FOnGetBlobEditorType write FOnGetBlobEditorType;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
    function VisibleIndex(TheIndex: Integer): Integer;
  end;

  TDBInspector = class(TCustomDBInspector)
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
    property DataSource;
    property ReadOnly;
    property OnGetNextValue;
    property OnGetButtonType;
    property OnGetEditMask;
    property OnGetEnableExternalEditor;
    property OnGetValuesList;
    property OnGetSortValuesList;
    property OnGetSelectedValue;
    property OnGetNameFont;
    property OnGetNameColor;
    property OnGetValueFont;
    property OnGetValueColor;
    property OnCallEditor;
    property OnSelectItem;
    property OnDeselectItem;
    property OnValueDoubleClick;
    property OnGetBlobEditorType;
  end;

implementation

procedure TInspectorDataLink.DataSetBeforePost(ADataSet: TDataSet);
begin
  FInspector.ApplyChanges;
end;

procedure TInspectorDataLink.CheckBrowseMode;
begin
  inherited;
  if Assigned(DataSet) and (DataSet.State=dsEdit) then FInspector.ApplyChanges;
end;

procedure TInspectorDataLink.ActiveChanged;
begin
  inherited;
  FInspector.ActiveChanged;
end;

procedure TInspectorDataLink.DataSetChanged;
begin
  inherited;
  if Assigned(DataSet) then DataSet.BeforePost:=DataSetBeforePost;
  FInspector.Update;
end;

procedure TInspectorDataLink.LayoutChanged;
begin
  with FInspector do
  begin
    ItemCount:=VisibleCount;
    Update;
  end;
end;

procedure TInspectorDataLink.RecordChanged(Field: TField);
begin
  inherited;
  with FInspector do
    if not FMyself then Update
    else FMyself:=False;
end;

constructor TInspectorDataLink.Create(AInspector: TCustomDBInspector);
begin
  inherited Create;
  FInspector:=AInspector;
end;

function TCustomDBInspector.GetDataSource: TDataSource;
begin
  Result:=FDataLink.DataSource;
end;

procedure TCustomDBInspector.SetDataSource(Value: TDataSource);
begin
  FDataLink.DataSource:=Value;
end;

function TCustomDBInspector.GetReadOnlyProperty: Boolean;
begin
  Result:=FDataLink.ReadOnly;
end;

procedure TCustomDBInspector.SetReadOnlyProperty(Value: Boolean);
begin
  FDataLink.ReadOnly:=Value;
end;

procedure TCustomDBInspector.ActiveChanged;
begin
  if ActiveDataSet then ItemCount:=VisibleCount
  else ItemCount:=0;
end;

function TCustomDBInspector.ActiveDataSet: Boolean;
begin
  with FDataLink do
    Result:=Assigned(DataSource) and Assigned(DataSource.DataSet) and DataSource.DataSet.Active;
end;

function TCustomDBInspector.LinkedDataSet: TDataSet;
begin
  Result:=FDataLink.DataSource.DataSet;
end;

function TCustomDBInspector.VisibleCount: Integer;
var
  i: Integer;
begin
  Result:=0;
  if LinkedDataSet<>nil then
    with LinkedDataSet do
      for i:=0 to Pred(FieldCount) do
        if Fields[i].Visible then Inc(Result);
end;

procedure TCustomDBInspector.ChangeValue(TheIndex: Integer; Editing: Boolean; const AText: string);
begin
  if Editing and ActiveDataSet then
    with LinkedDataSet do
      if not (State in [dsEdit,dsInsert]) and not Fields[VisibleIndex(TheIndex)].IsBlob then
      begin
        FMyself:=True;
        Edit;
      end;
  inherited;
end;

function TCustomDBInspector.GetName(TheIndex: Integer): string;
begin
  if ActiveDataSet then
    Result:=LinkedDataSet.Fields[VisibleIndex(TheIndex)].DisplayName
  else Result:='';
end;

function TCustomDBInspector.GetValue(TheIndex: Integer): string;
begin
  if ActiveDataSet then
    with LinkedDataSet.Fields[VisibleIndex(TheIndex)] do
      if IsBlob then
        if (LinkedDataSet.Fields[VisibleIndex(TheIndex)] as TBlobField).BlobSize=0 then Result:='(Blob)'
        else Result:='(BLOB)'
      else Result:=AsString
  else Result:='';
end;

procedure TCustomDBInspector.SetValue(TheIndex: Integer; const Value: string);
begin
  if ActiveDataSet then
    with LinkedDataSet do
    begin
      if not (State in [dsEdit,dsInsert]) then Edit;
      Fields[VisibleIndex(TheIndex)].AsString:=Value;
    end;
end;

function TCustomDBInspector.GetMaxLength(TheIndex: Integer): Integer;
begin
  if ActiveDataSet then
    Result:=LinkedDataSet.Fields[VisibleIndex(TheIndex)].Size
  else Result:=0;
end;

function TCustomDBInspector.GetReadOnly(TheIndex: Integer): Boolean;
begin
  Result:=ReadOnly or (ActiveDataSet and LinkedDataSet.Fields[VisibleIndex(TheIndex)].IsBlob);
end;

function TCustomDBInspector.GetIndent: Integer;
begin
  Result:=0;
end;

function TCustomDBInspector.GetAutoApply(TheIndex: Integer): Boolean;
begin
  Result:=True;
end;

function TCustomDBInspector.GetButtonType(TheIndex: Integer): TButtonType;
begin
  case GetBlobEditor of
    beText,beImage: Result:=btDialog;
  else Result:=inherited GetButtonType(TheIndex);
  end;
end;

function TCustomDBInspector.GetEnableExternalEditor(TheIndex: Integer): Boolean;
begin
  case GetBlobEditor of
    beText,beImage: Result:=True;
  else Result:=inherited GetEnableExternalEditor(TheIndex);
  end;
end;

function TCustomDBInspector.CallEditor(TheIndex: Integer): Boolean;
begin
  Result:=False;
  case GetBlobEditor of
    beText: 
      if ActiveDataSet then
        with LinkedDataSet,TfrmStrings.Create(Application) do
        try
          Strings.Assign(Fields[VisibleIndex(TheIndex)]);
          if ShowModal=mrOk then
          begin
            if not (State in [dsEdit,dsInsert]) then Edit;
            Fields[VisibleIndex(TheIndex)].Assign(Strings);
          end;
        finally
          Free;
        end;
    beImage:
      if ActiveDataSet then
        with LinkedDataSet,TfrmPicture.Create(Application) do
        try
          Picture.Assign(Fields[VisibleIndex(TheIndex)]);
          if ShowModal=mrOk then
          begin
            if not (State in [dsEdit,dsInsert]) then Edit;
            with Fields[VisibleIndex(TheIndex)] do
              if Picture.Graphic is TBitmap then Assign(Picture)
              else Clear;
          end;
        finally
          Free;
        end;
  else Result:=inherited CallEditor(TheIndex);
  end;
end;

function TCustomDBInspector.GetBlobEditor: TBlobEditorType;
begin
  Result:=beNone;
  if (ItemIndex<>-1) and ActiveDataSet then
    with LinkedDataSet,Fields[ItemIndex] do
      if IsBlob then
        if Assigned(FOnGetBlobEditorType) then FOnGetBlobEditorType(Self,Fields[ItemIndex],Result);
end;

constructor TCustomDBInspector.Create(AOwner: TComponent);
begin
  inherited;
  FDataLink:=TInspectorDataLink.Create(Self);
end;

destructor TCustomDBInspector.Destroy;
begin
  FDataLink.Free;
  inherited;
end;

function TCustomDBInspector.VisibleIndex(TheIndex: Integer): Integer;
var
  i,V: Integer;
begin
  Result:=-1;
  V:=-1;
  if LinkedDataSet<>nil then
    with LinkedDataSet do
      for i:=0 to Pred(FieldCount) do
        if Fields[i].Visible then
        begin
          Inc(V);
          if V=TheIndex then
          begin
            Result:=i;
            Break;
          end;
        end;
end;

end.
