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

unit IniInsp;

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
  SysUtils, Classes, IniFiles, InspCtrl;

type

  TCustomIniInspector = class(TCustomInspector)
  private
    FIniFile: TIniFile;
    FFileName: TFileName;
    procedure SetFileName(const Value: TFileName);
    function ValidIndex(TheIndex: Integer): Boolean;
    function GetSection(TheIndex: Integer): string;
  protected
    function GetName(TheIndex: Integer): string; override;
    function GetValue(TheIndex: Integer): string; override;
    procedure SetValue(TheIndex: Integer; const Value: string); override;
    function GetReadOnly(TheIndex: Integer): Boolean; override;
    function GetExpandState(TheIndex: Integer): TExpandState; override;
    function GetLevel(TheIndex: Integer): Integer; override;
    function GetAutoApply(TheIndex: Integer): Boolean; override;
    procedure Expand(TheIndex: Integer); override;
    procedure Collapse(TheIndex: Integer); override;
    property FileName: TFileName read FFileName write SetFileName;
  public
    procedure CreateWnd; override;
  end;

  TIniInspector = class(TCustomIniInspector)
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
    property FileName;
    property Splitter;
    property PaintStyle;
    property OnUpdate;
    property OnValidateChar;
    property OnChangeValue;
    property OnDrawName;
    property OnDrawValue;
    property OnGetName;
    property OnGetValue;
    property OnGetNextValue;
    property OnSetValue;
    property OnGetButtonType;
    property OnGetInplaceEditorType;
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
    property OnSelectItem;
    property OnDeselectItem;
    property OnValueDoubleClick;
  end;

implementation

procedure TCustomIniInspector.SetFileName(const Value: TFileName);
var
  Buffer: array[0..2048] of Char;
  NamePart: PChar;
begin
  if Assigned(FIniFile) then
  begin
    FIniFile.Free;
    FIniFile:=nil;
  end;
  {$IFDEF FPC}
  FFileName:=Value;
  {$ELSE}
  if SearchPath(nil,PChar(Value),nil,Length(Buffer),Buffer,NamePart)>0 then
    FFileName:=Buffer
  else FFileName:=Value;
  {$ENDIF}
  if HandleAllocated then
  begin
    FIniFile:=TIniFile.Create(FFileName);
    FIniFile.ReadSections(Items);
    if Items.Count>0 then ItemIndex:=0;
  end;
end;

function TCustomIniInspector.ValidIndex(TheIndex: Integer): Boolean;
begin
  Result:=(TheIndex>=0) and (TheIndex<Items.Count);
end;

function TCustomIniInspector.GetSection(TheIndex: Integer): string;
begin
  while ValidIndex(TheIndex) and (GetLevel(TheIndex)>0) do Dec(TheIndex);
  Result:=GetName(TheIndex);
end;

procedure TCustomIniInspector.CreateWnd;
begin
  inherited;
  FIniFile:=TIniFile.Create(FFileName);
  FIniFile.ReadSections(Items);
  if Items.Count>0 then ItemIndex:=0;
end;

function TCustomIniInspector.GetName(TheIndex: Integer): string;
begin
  if ValidIndex(TheIndex) then
    if GetLevel(TheIndex)=0 then Result:=Items[TheIndex]
    else Result:=Items.Names[TheIndex]
  else Result:='';
end;

function TCustomIniInspector.GetValue(TheIndex: Integer): string;
begin
  if ValidIndex(TheIndex) then
    if GetLevel(TheIndex)=0 then Result:='(Section)'
    else
    begin
      Result:=Items[TheIndex];
      Result:=Copy(Result,Succ(Pos('=',Result)),Length(Result));
    end
  else Result:='';
end;

procedure TCustomIniInspector.SetValue(TheIndex: Integer; const Value: string);
begin
  if ValidIndex(TheIndex) and (GetLevel(TheIndex)>0) then
  begin
    FIniFile.WriteString(GetSection(TheIndex),GetName(TheIndex),Value);
    Items[TheIndex]:=GetName(TheIndex)+'='+Value;
  end;
end;

function TCustomIniInspector.GetReadOnly(TheIndex: Integer): Boolean;
begin
  Result:=GetLevel(TheIndex)=0;
end;

function TCustomIniInspector.GetExpandState(TheIndex: Integer): TExpandState;
begin
  if GetLevel(TheIndex)=0 then
    if ValidIndex(Succ(TheIndex)) and (GetLevel(Succ(TheIndex))>0) then
      Result:=esCollapse
    else Result:=esExpand
  else Result:=esNone;
end;

function TCustomIniInspector.GetLevel(TheIndex: Integer): Integer;
begin
  if ValidIndex(TheIndex) then Result:=Integer(Assigned(Items.Objects[TheIndex]))
  else Result:=0;
end;

function TCustomIniInspector.GetAutoApply(TheIndex: Integer): Boolean;
begin
  Result:=GetLevel(TheIndex)>0;
end;

procedure TCustomIniInspector.Expand(TheIndex: Integer);
var
  SL: TStringList;
  i: Integer;
begin
  if GetExpandState(TheIndex)=esExpand then
  begin
    SL:=TStringList.Create;
    try
      FIniFile.ReadSection(GetName(TheIndex),SL);
      for i:=0 to Pred(SL.Count) do
        Sl[i]:=SL[i]+'='+FIniFile.ReadString(GetName(TheIndex),SL[i],'');
      SL.Sorted:=Sorted;
      with Items do
      begin
        BeginUpdate;
        try
          for i:=Pred(SL.Count) downto 0 do
            InsertObject(Succ(TheIndex),SL[i],Pointer(1));
        finally
          EndUpdate;
        end;
      end;
      Invalidate;
    finally
      SL.Free;
    end;
  end;
end;

procedure TCustomIniInspector.Collapse(TheIndex: Integer);
begin
  if (GetExpandState(TheIndex)=esCollapse) and ValidIndex(Succ(TheIndex)) then
    with Items do
    begin
      BeginUpdate;
      try
        while GetLevel(Succ(TheIndex))>0 do Delete(Succ(TheIndex));
      finally
        EndUpdate;
      end;
    end;
end;

end.
