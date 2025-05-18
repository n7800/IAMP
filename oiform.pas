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

unit OIForm;

{$MODE Delphi}

interface

uses
  LCLIntf, LCLType, LMessages, Messages, SysUtils,
  Classes, Graphics, Controls, Forms, Dialogs, StdCtrls,
  ComCtrls, RunFus, TypInfo, Design, InspCtrl, PropList, CompInsp;

type

  TfrmObjectInspector = class(TForm)
    cmbObjectInspector: TRFComboBox;
    cmpObjectInspector: TRFInspector;
    procedure cmpObjectInspectorChange(Sender: TObject; TheIndex: Integer);
    procedure cmpObjectInspectorChangeValue(Sender: TObject; TheIndex: Integer;
      Editing: Boolean; const Value: string);
    procedure cmpObjectInspectorFilter(Sender: TObject; Prop: TProperty;
      var Result: Boolean);
    procedure cmpObjectInspectorGetValuesList(Sender: TObject;
      TheIndex: Integer; const Strings: TStrings);
    procedure FormResize(Sender: TObject);
    procedure cmbObjectInspectorFilter(Sender: TObject;
      AComponent: TComponent; var EnableAdd: Boolean);
    procedure cmbObjectInspectorChange(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure cmbObjectInspectorGetComponentText(Sender: TObject;
      AComponent: TComponent; var Text: string);
  private
    
  public
    
  end;

var
  frmObjectInspector: TfrmObjectInspector;

function IsFilteredProp(Prop: String): Boolean;

implementation

{$R *.lfm}

uses ToolForm, Rules, uPool;

var
  ChangeMon: Boolean = false;
  ChangeOld: String = '';
  ChangeNew: String = '';
  ChangeIndex: Integer = -1;

function IsFilteredProp(Prop: String): Boolean;
begin
  Result := True;
  if Prop = 'HotTrackColor' then Exit;
  if Prop = 'HotTrackColorType' then Exit;
  if Prop = 'HotTrack' then Exit;
  if Prop = 'DisabledColor' then Exit;
  if Prop = 'LightTextStyle' then Exit;
  if Prop = 'HighlightColor' then Exit;
  if Prop = 'TextHighlightColor' then Exit;
  if Prop = 'TextShadowColor' then Exit;
  if Prop = 'TextShadowDepth' then Exit;
  if Prop = 'TextStyle' then Exit;
  if Prop = 'UseCustomGlyphs' then Exit;
  if Prop = 'WinMaskColor' then Exit;
  if Prop = 'About' then Exit;
  if Prop = 'AllowGrayed' then Exit;
  if Prop = 'CustomGlyphs' then Exit;
  if Prop = 'DefaultMonitor' then Exit;
  if Prop = 'OldCreateOrder' then Exit;
  
  if Prop = 'PrintScale' then Exit;
  if Prop = 'Scaled' then Exit;
  if Prop = 'Action' then Exit;
  if Prop = 'Anchors' then Exit;
  if Prop = 'Constraints' then Exit;
  if Prop = 'DragKind' then Exit;
  if Prop = 'DockSite' then Exit;
  if Prop = 'HelpKeyword' then Exit;
  if Prop = 'HelpType' then Exit;
  
  if Prop = 'DragCursor' then Exit;
  if Prop = 'DragMode' then Exit;
  if Prop = 'PopupMenu' then Exit;
  if Prop = 'HelpContext' then Exit;
  if Prop = 'UseDockManager' then Exit;
  if Prop = 'ActiveControl' then Exit;
  if Prop = 'HelpContext' then Exit;
  if Prop = 'HelpFile' then Exit;
  if Prop = 'KeyPreview' then Exit;
  if Prop = 'Menu' then Exit;
  if Prop = 'ObjectMenuItem' then Exit;
  if Prop = 'WindowMenu' then Exit;
  if Prop = 'ModalResult' then Exit;
  if Prop = 'IntegralHeight' then Exit;
  
  if Prop = 'ItemHeight' then Exit;
  if Prop = 'Locked' then Exit;
  if Prop = 'Ctl3D' then Exit;
  if Prop = 'Tag' then Exit;
  
  if Prop = 'VisitedMaxCount' then Exit;
  if Prop = 'ServerRoot' then Exit;
  if Prop = 'ImageCacheCount' then Exit;
  if Prop = 'HistoryMaxCount' then Exit;
  
  if AnsiPos('On', Prop) <> 0 then Exit;
  if AnsiPos('Scroll', Prop) <> 0 then Exit;
  if AnsiPos('Parent', Prop) <> 0 then Exit;
  if AnsiPos('Ime', Prop) <> 0 then Exit;
  if AnsiPos('OEM', Prop) <> 0 then Exit;
  if AnsiPos('Hint', Prop) <> 0 then Exit;
  if AnsiPos('Frame', Prop) <> 0 then Exit;
  if AnsiPos('Tab', Prop) <> 0 then Exit;
  if AnsiPos('Images', Prop) <> 0 then Exit;
  if AnsiPos('Folder', Prop) <> 0 then Exit;
  Result := false;
end;

procedure TfrmObjectInspector.FormResize(Sender: TObject);
begin
  
end;

procedure TfrmObjectInspector.cmbObjectInspectorFilter(Sender: TObject;
  AComponent: TComponent; var EnableAdd: Boolean);
begin
  EnableAdd:=AComponent is TControl;
end;

procedure TfrmObjectInspector.cmbObjectInspectorGetComponentText(
  Sender: TObject; AComponent: TComponent; var Text: string);
begin
  
end;

procedure TfrmObjectInspector.cmbObjectInspectorChange(Sender: TObject);
begin
  
end;

procedure TfrmObjectInspector.FormShow(Sender: TObject);
begin
  cmpObjectInspector.DefaultInstance:=frmDesign;
end;

procedure TfrmObjectInspector.cmpObjectInspectorChangeValue(Sender: TObject;
  TheIndex: Integer; Editing: Boolean; const Value: string);
begin
  GlobDirty := True;
end;

procedure TfrmObjectInspector.cmpObjectInspectorFilter(Sender: TObject;
  Prop: TProperty; var Result: Boolean);
begin
  Result := not IsFilteredProp(Prop.FullName);
  
end;

procedure TfrmObjectInspector.cmpObjectInspectorGetValuesList(Sender: TObject;
  TheIndex: Integer; const Strings: TStrings);
begin
  with cmpObjectInspector.Properties[TheIndex] do
    if (TypeKind=tkMethod) and (PropType=TypeInfo(TNotifyEvent)) then
      Strings.Text:='ShowYes'#13'ShowNo';
end;

procedure TfrmObjectInspector.cmpObjectInspectorChange(Sender: TObject;
  TheIndex: Integer);
var
  i: Integer;
begin
  GlobDirty := True;
   
  if TheIndex = ChangeIndex then
    if ChangeMon then
      if ChangeOld <> '' then
        if ChangeNew <> '' then
        begin
          for i := 1 to frmRules.Existing.Items.Count do
            frmRules.Existing.Items[i -1] := StringReplace(frmRules.Existing.Items[i -1], ChangeOld, ChangeNew, [rfReplaceAll, rfIgnoreCase]);
          ChangeMon := false;
          ChangeOld := '';
          ChangeNew := '';
          ChangeIndex := -1;
        end;
end;

end.
