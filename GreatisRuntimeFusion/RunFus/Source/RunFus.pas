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

unit RunFus;

{$IFDEF FPC}
  {$MODE Delphi}
{$ENDIF}

interface

uses
 {$IFnDEF FPC}
  Mask, Windows,
{$ELSE}
  Masks, LCLIntf, LCLType, LMessages,
{$ENDIF}
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs,
  FDMain, CompInsp;

type

  TRFInspector = class;

  TRFTree = class(TComponentTree)
  private
    
    FShowContainers: Boolean;
    procedure SetShowContainers(const Value: Boolean);
  protected
    
    function Filter(AComponent: TComponent): Boolean; override;
  published
    
    property ShowContainers: Boolean read FShowContainers write SetShowContainers;
  end;

  TRFComboBox = class(TComponentComboBox)
  protected
    
    function TranslateComponent(AComponent: TComponent): TComponent; override;
  end;

  TRFDesigner = class(TFormDesigner)
  private
    
    FInspector: TRFInspector;
    FLockFusionDesigner: Boolean;
    procedure SetInspector(const Value: TRFInspector);
  protected
    
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure DoChange; override;
    procedure DoSelectionChange; override;
  published
    
    property Inspector: TRFInspector read FInspector write SetInspector;
  end;

  TRFInspector = class(TComponentInspector)
  private
    
    FDesigner: TRFDesigner;
    FDefaultInstance: TComponent;
    procedure SetDesigner(const Value: TRFDesigner);
    procedure SetDefaultInstance(const Value: TComponent);
  protected
    
    procedure Notification(AComponent: TComponent; Operation: TOperation); override;
    procedure Change(TheIndex: Integer); override;
  published
    
    property Designer: TRFDesigner read FDesigner write SetDesigner;
    property DefaultInstance: TComponent read FDefaultInstance write SetDefaultInstance;
  public
    
    procedure Update; override;
  end;

implementation

procedure TRFTree.SetShowContainers(const Value: Boolean);
begin
  if FShowContainers<>Value then
  begin
    FShowContainers:=Value;
    if not (csDesigning in ComponentState) then RefreshTree;
  end;
end;

function TRFTree.Filter(AComponent: TComponent): Boolean;
begin
  Result:=(AComponent<>Self) and
    (ShowNonVisual or (AComponent is TControl)) and
    (FShowContainers or not (AComponent is TComponentContainer));
  if Assigned(OnFilter) then OnFilter(Self,AComponent,Result);
end;

function TRFComboBox.TranslateComponent(AComponent: TComponent): TComponent;
begin
  if AComponent is TComponentContainer then Result:=TComponentContainer(AComponent).Component
  else Result:=inherited TranslateComponent(AComponent);
end;

procedure TRFDesigner.SetInspector(const Value: TRFInspector);
var
  OldInspector: TRFInspector;
begin
  if FInspector<>Value then
  begin
    OldInspector:=FInspector;
    FInspector:=Value;
    if Assigned(FInspector) then FInspector.Designer:=Self
    else
      if Assigned(OldInspector) then OldInspector.Designer:=nil;
    if Assigned(FInspector) then FreeNotification(FInspector);
  end;
end;

procedure TRFDesigner.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if not (csDestroying in ComponentState) and (Operation=opRemove) and (AComponent=FInspector) then
    if csDestroying in Inspector.ComponentState then FInspector:=nil
    else Inspector:=nil;
end;

procedure TRFDesigner.DoChange;
begin
  inherited;
  if not SynchroLocked then
    if Assigned(FInspector) then FInspector.Update;
end;

procedure TRFDesigner.DoSelectionChange;
var
  i: Integer;
  C: TControl;
begin
  inherited;
  FLockFusionDesigner:=True;
  try
    if not SynchroLocked then
      if Assigned(FInspector) then
        with FInspector,Self do
        begin
          case ControlCount of
            0: Instance:=DefaultInstance;
            1: Instance:=Component;
          else
            for i:=0 to Pred(ControlCount) do
              if IndexOfInstance(Controls[i])=-1 then AddInstance(Controls[i]);
            if InstanceCount>1 then DeleteInstance(DefaultInstance);
            i:=0;
            while i<InstanceCount do
            begin
              if Instances[i] is TControl then C:=TControl(Instances[i])
              else C:=FindComponentContainer(TComponent(Instances[i]));
              if ControlIndex(C)=-1 then DeleteInstance(Instances[i])
              else Inc(i);
            end;
          end;
        end;
  finally
    FLockFusionDesigner:=False;
  end;
end;

procedure TRFInspector.SetDesigner(const Value: TRFDesigner);
var
  OldDesigner: TRFDesigner;
begin
  if FDesigner<>Value then
  begin
    OldDesigner:=FDesigner;
    FDesigner:=Value;
    if Assigned(FDesigner) then
    begin
      FDesigner.Inspector:=Self;
      OnGetPropSubsLongint := FDesigner.GetPropSubsLongint;
      OnSetPropSubsLongint := FDesigner.SetPropSubsLongint;
    end else if Assigned(OldDesigner) then
    begin
      OnGetPropSubsLongint := Nil;
      OnSetPropSubsLongint := Nil;
      OldDesigner.Inspector:=nil;
    end;
    if not Assigned(FDesigner) then Instance:=FDefaultInstance;
    if Assigned(FDesigner) then FreeNotification(FDesigner);
  end;
end;

procedure TRFInspector.SetDefaultInstance(const Value: TComponent);
begin
  if FDefaultInstance<>Value then
  begin
    FDefaultInstance:=Value;
    if not Assigned(Instance) then Instance:=FDefaultInstance;
    if Assigned(FDefaultInstance) then FreeNotification(FDefaultInstance);
  end;
end;

procedure TRFInspector.Notification(AComponent: TComponent; Operation: TOperation);
begin
  inherited;
  if not (csDestroying in ComponentState) and (Operation=opRemove) then
    if AComponent=FDesigner then
      if csDestroying in Designer.ComponentState then FDesigner:=nil
      else Designer:=nil
    else
      if AComponent=FDefaultInstance then
        FDefaultInstance:=nil;
end;

procedure TRFInspector.Change(TheIndex: Integer);
begin
  inherited;
  if Assigned(FDesigner) then FDesigner.Update;
end;

procedure TRFInspector.Update;
begin
  inherited;
  {$IFNDEF GRFLOCKUPDATEDESIGNER}
  if Assigned(FDesigner) then
    with FDesigner do
      if not FLockFusionDesigner then
      begin
        SynchroLock;
        Lock;
        try
          case InstanceCount of
            0: Control:=nil;
            1:
              if Instance<>Control then
                if Instance is TControl then Control:=TControl(Instance)
                else Component:=TComponent(Instance);
          end;
        finally
          SynchroUnlock;
          Unlock;
        end;
      end;
  {$ENDIF}
end;

end.
