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

unit FDEditor;

{$IFDEF FPC}
  {$MODE Delphi} {$H+}
{$ENDIF}

{$IFDEF FDADDINCLUDE}{$I FD.INC}{$ENDIF}

interface

uses
{$IFnDEF FPC}
  Windows,
{$ELSE}
  LCLIntf, LCLType, LMessages,
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  StdCtrls, ExtCtrls, FDMain;

type
  TfrmFDEditor = class(TForm)
    btnDelete: TButton;
    btnAdd: TButton;
    btnOk: TButton;
    btnCancel: TButton;
    btnClear: TButton;
    lsbLocked: TListBox;
    rgrControls: TRadioGroup;
    lsbProtected: TListBox;
    lsbTransparent: TListBox;
    procedure btnAddClick(Sender: TObject);
    procedure btnDeleteClick(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure rgrControlsClick(Sender: TObject);
    procedure lsbProtectedClick(Sender: TObject);
  private
    
    procedure UpdateButtons;
    procedure UpdateLists;
    function ActiveList: TListBox;
    procedure FillList(AOwner: TComponent; ListType: TListType; Target: TStrings; Exclude: TStrings; AName: string);
  public
    
    FormDesigner: TCustomFormDesigner;
    constructor Create(AOwner: TComponent); override;
  end;

function EditLists(AFormDesigner: TCustomFormDesigner; DefaultList: TListType): Boolean;

implementation

{$IFDEF VER100}
{$DEFINE NOFRAMES}
{$ENDIF}
{$IFDEF VER110}
{$DEFINE NOFRAMES}
{$ENDIF}
{$IFDEF VER120}
{$DEFINE NOFRAMES}
{$ENDIF}
{$IFDEF VER125}
{$DEFINE NOFRAMES}
{$ENDIF}

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

uses FDAdd;

procedure TfrmFDEditor.UpdateButtons;
begin
  with ActiveList,Items do
  begin
    btnDelete.Enabled:=ItemIndex<>-1;
    btnClear.Enabled:=Count>0;
  end;
end;

procedure TfrmFDEditor.UpdateLists;
begin
  lsbLocked.Visible:=rgrControls.ItemIndex=0;
  lsbProtected.Visible:=rgrControls.ItemIndex=1;
  lsbTransparent.Visible:=rgrControls.ItemIndex=2;
  with ActiveList do
    if (Items.Count>0) and (ItemIndex=-1) then ItemIndex:=0;
  UpdateButtons;
end;

function TfrmFDEditor.ActiveList: TListBox;
begin
  case rgrControls.ItemIndex of
    0: Result:=lsbLocked;
    1: Result:=lsbProtected;
  else Result:=lsbTransparent;
  end;
end;

constructor TfrmFDEditor.Create(AOwner: TComponent);
begin
  inherited Create(Application);
end;

procedure TfrmFDEditor.FillList(AOwner: TComponent; ListType: TListType; Target: TStrings; Exclude: TStrings; AName: string);
var
  i: Integer;
begin
  with AOwner do
    for i:=0 to Pred(ComponentCount) do
      if not (Components[i] is TCustomFormDesigner) then
      begin
        if (not Assigned(Exclude) or (Exclude.IndexOf(Components[i].Name)=-1)) then
          Target.Add(AName+Components[i].Name);
        {$IFNDEF NOFRAMES}
        if Components[i] is TCustomFrame then
          FillList(Components[i],ListType,Target,Exclude,AName+Components[i].Name+'.');
        {$ENDIF}
      end;
end;

procedure TfrmFDEditor.btnAddClick(Sender: TObject);
var
  i: Integer;
begin
  with TfrmFDAdd.Create(Self) do
  try
    with lsbAddControls,Items do
    begin
      Clear;
      FillList(FormDesigner.ParentForm,TListType(rgrControls.ItemIndex),lsbAddControls.Items,ActiveList.Items,'');
      if ShowModal=mrOk then
        for i:=0 to Pred(Count) do
          if Selected[i] then
            ActiveList.Items.Add(Items[i]);
      with ActiveList do
        if ItemIndex=-1 then ItemIndex:=0;
    end;
  finally
    Free;
  end;
  UpdateButtons;
end;

procedure TfrmFDEditor.btnDeleteClick(Sender: TObject);
var
  I: Integer;
begin
  with ActiveList,Items do
    if ItemIndex<>-1 then
    begin
      I:=ItemIndex;
      Delete(I);
      if I>Pred(Count) then I:=Pred(Count);
      ItemIndex:=I;
    end;
  UpdateButtons;
end;

procedure TfrmFDEditor.FormShow(Sender: TObject);
begin
  UpdateLists;
  with ActiveList,Items do
    if Count>0 then ItemIndex:=0;
  UpdateButtons;
end;

procedure TfrmFDEditor.btnClearClick(Sender: TObject);
begin
  ActiveList.Items.Clear;
end;

procedure TfrmFDEditor.rgrControlsClick(Sender: TObject);
begin
  UpdateLists;
end;

procedure TfrmFDEditor.lsbProtectedClick(Sender: TObject);
begin
  UpdateButtons;
end;

function EditLists(AFormDesigner: TCustomFormDesigner; DefaultList: TListType): Boolean;
begin
  with TfrmFDEditor.Create(Application) do
  try
    FormDesigner:=AFormDesigner;
    if Assigned(FormDesigner) then
    begin
      Caption:=FormDesigner.Name;
      if Assigned(FormDesigner.Owner) then Caption:=FormDesigner.Owner.Name+'.'+Caption;
      rgrControls.ItemIndex:=Integer(DefaultList);
      lsbTransparent.Items.Assign(FormDesigner.TransparentControls);
      {$IFDEF TFD1COMPATIBLE}
      lsbLocked.Items.Assign(FormDesigner.FixedControls);
      {$ELSE}
      lsbLocked.Items.Assign(FormDesigner.LockedControls);
      {$ENDIF}
      lsbProtected.Items.Assign(FormDesigner.ProtectedControls);
      Result:=ShowModal=mrOk;
      if Result then
        with FormDesigner do
        begin
          TransparentControls.Assign(lsbTransparent.Items);
          {$IFDEF TFD1COMPATIBLE}
          FixedControls.Assign(lsbLocked.Items);
          {$ELSE}
          LockedControls.Assign(lsbLocked.Items);
          {$ENDIF}
          ProtectedControls.Assign(lsbProtected.Items);
        end;
    end
    else Result:=False;
  finally
    Free;
  end;
end;

end.
