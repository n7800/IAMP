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
unit mProject;

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, Forms, Controls, Graphics, Dialogs, ComCtrls, Menus,
  mUtils, LCLType, madddialog, LCLIntf, AnchorDocking;

type

  TProject = class(TForm)
    AddDialogstoProject1: TMenuItem;
    AddFilestoProject1: TMenuItem;
    ChangeScript1: TMenuItem;
    ImageList: TImageList;
    NewInclude: TMenuItem;
    AddInclude: TMenuItem;
    RemoveInclude: TMenuItem;
    N4: TMenuItem;
    N1: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    OpenDialog: TOpenDialog;
    OpenDialogSupport: TOpenDialog;
    pPopupMenu: TPopupMenu;
    ProjectOptions1: TMenuItem;
    RemoveDialog1: TMenuItem;
    RemoveFiles1: TMenuItem;
    SaveDialog: TSaveDialog;
    SaveProjectAs1: TMenuItem;
    SaveScriptAs1: TMenuItem;
    Tree: TTreeView;
    procedure AddDialogstoProject1Click(Sender: TObject);
    procedure AddFilestoProject1Click(Sender: TObject);
    procedure ChangeScript1Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure NewIncludeClick(Sender: TObject);
    procedure AddIncludeClick(Sender: TObject);
    procedure pPopupMenuPopup(Sender: TObject);
    procedure ProjectOptions1Click(Sender: TObject);
    procedure RemoveDialog1Click(Sender: TObject);
    procedure RemoveFiles1Click(Sender: TObject);
    procedure RemoveIncludeClick(Sender: TObject);
    procedure SaveProjectAs1Click(Sender: TObject);
    procedure SaveScriptAs1Click(Sender: TObject);
    procedure TreeDblClick(Sender: TObject);
    procedure TreeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState);
  private
  public
    procedure Clear;
    procedure SetProject(ProjectName: String);
    procedure SetScript(FileName: String);
    procedure SetDialogs(List: TStrings);
    procedure SetSupport(List: TStrings);
    procedure SetInclude(List: TStrings);
  end;

var
  Project: TProject;
  SaveJ: Integer = 0;
  LastProjDir: String = '';
  
  EnabledFullPaths: Boolean = false;

implementation

{$R *.lfm}

uses
  uGui;

procedure TProject.SaveScriptAs1Click(Sender: TObject);
var
  i: Integer;
  t: TextFile;
  MemoryBuffer, FileBuffer: String;
begin
  try
    ui.PushStatusStack('Saving main script as');
    if not ui.SafeRunState then Exit;
    if PROJDIR <> LastProjDir then
    begin
      LastProjDir := PROJDIR;
      SaveDialog.InitialDir := PROJDIR;
    end;
    if SaveDialog.Execute then
    begin
      
      for i := 3 to ui.CurrentUnit.Tabs.Count do 
        if CompareText(ExtractFileNameOnly(SaveDialog.FileName), ui.CurrentUnit.Tabs[i -1]) = 0 then
        begin
          Application.MessageBox(PChar(SThereIsAlreadyAScriptInYourProje),
            PChar(Application.Title), mb_Ok + mb_IconStop);
          Exit;
        end;
      
      ui.ReBindMainScriptRename(SaveDialog.FileName);
      if ScriptFile = '' then
      begin
        
        ui.GetNamedScriptNameAndFile('', MemoryBuffer, FileBuffer);
        if ui.IsContextLoaded(MemoryBuffer) then 
          ui.SaveNamedScript(MemoryBuffer, FileBuffer, '')
        else 
          if LastActiveContext = ScriptFile then
            ui.SaveNamedScript(MemoryBuffer, FileBuffer, '')
        else 
        begin
          AssignFile(t, SaveDialog.FileName,cp_utf8);
          ReWrite(t);
          WriteLn(t, '$');
          WriteLn(t, '$');
          WriteLn(t, '$');
          WriteLn(t, '$');
          WriteLn(t, '$');
          CloseFile(t);
          AssignFile(t, SaveDialog.FileName + '.fld',cp_utf8); 
          ReWrite(t);
          CloseFile(t);
          AssignFile(t, SaveDialog.FileName + '.brk',cp_utf8); 
          ReWrite(t);
          CloseFile(t);
        end;
      end
      else
        FileCopyFile(PChar(ScriptFile), PChar(SaveDialog.FileName), false);
      ScriptFile := SaveDialog.FileName;
      
      ui.SetDirtyMpr(True);
      ui.AdjustUIProjectChanged;
    end;
  finally
    ui.PopStatusStack;
  end;
end;

procedure TProject.NewIncludeClick(Sender: TObject);
var
  s: String;
  t: TextFile;
begin
  try
    ui.PushStatusStack('Creating new script');
    if not ui.SafeRunState then Exit;
    s := CreateGuidUp;
    if PROJDIR <> LastProjDir then
    begin
      LastProjDir := PROJDIR;
      SaveDialog.InitialDir := PROJDIR;
    end;
    if SaveDialog.Execute then
    begin
      if CompareText(ui.GetFullProjectScriptFilePath, SaveDialog.FileName) = 0 then
      begin
        Application.MessageBox(PChar(SThisScriptIsAlreadyYourSetupSPri),
          PChar(Application.Title), mb_Ok + mb_IconStop);
        Exit;
      end;
      try
        AssignFile(t, SaveDialog.FileName,cp_utf8);
        ReWrite(t);
        WriteLn(t, 'Comment'); 
        WriteLn(t, '$');
        WriteLn(t, s);
        WriteLn(t, '$');
        WriteLn(t, s);
        WriteLn(t, '');
        WriteLn(t, '$');
        WriteLn(t, '');
        WriteLn(t, '$');
        WriteLn(t, '');
        WriteLn(t, '$');
        CloseFile(t);
        IncludeFiles.Add(SaveDialog.FileName);
        
        ui.SetDirtyMPR(True);
        Project.SetInclude(IncludeFiles);
      except
      end;
    end;
  finally
    ui.PopStatusStack;
  end;
end;

procedure TProject.ChangeScript1Click(Sender: TObject);
var
  i: Integer;
  s: String;
  MemoryBuffer, FileBuffer: String;
begin
  try
    ui.PushStatusStack('Changing main project script');
    if not ui.SafeRunState then Exit;
    if PROJDIR <> LastProjDir then
    begin
      LastProjDir := PROJDIR;
      OpenDialog.InitialDir := PROJDIR;
    end;
    if OpenDialog.Execute then
    begin
      if IncludeFiles.IndexOf(OpenDialog.FileName) <> -1 then
      begin
        Application.MessageBox(PChar(SThisScriptIsAlreadyPartOfYourPro),
          PChar(Application.Title), mb_Ok + mb_IconStop);
        Exit;
      end;
      ui.CurrentUnit.TabIndex := 1; 
      
      if DirtyBuffer.IndexOf(ScriptFile) <> -1 then
      begin
        i := Application.MessageBox(PChar(SSaveChangesToScriptBeforeClosing),
          PChar(Application.Title), mb_YesNoCancel + mb_IconQuestion);
        if i = id_Cancel then Exit;
        ui.GetNamedScriptNameAndFile('', MemoryBuffer, FileBuffer);
        if i = id_Yes then
          ui.SaveNamedScript(MemoryBuffer, FileBuffer, PROJDIR);
        if i = id_No then
          DirtyBuffer.Delete(DirtyBuffer.IndexOf(MemoryBuffer));
      end;
      
      s := ScriptFile;
      ui.ReBindMainScriptRename(OpenDialog.FileName);
      ScriptFile := OpenDialog.FileName;
      if AnsiUpperCase(AssertDir(ExtractFilePath(ScriptFile))) =
        AnsiUpperCase(AssertDir(ExtractFilePath(CurrentProjectName))) then
        ScriptFile := ExtractFileName(ScriptFile);
      
      ui.SetDirtyMPR(True);
      LastActiveContext := '';
      ui.ClearScriptStructsOnly;
      if not ui.LoadScriptEx(ScriptFile) then Exit;
      ui.AdjustUIProjectChanged;
      ui.CurrentUnit.TabIndex := 1;
      
      if ui.IsContextLoaded(s) then
        ui.FreeContext(s);
    end;
  finally
    ui.PopStatusStack;
  end;
end;

procedure TProject.FormShow(Sender: TObject);
begin
end;

procedure TProject.AddFilestoProject1Click(Sender: TObject);
var
  i: Integer;
  s: String;
begin
  try
    ui.PushStatusStack('Adding files');
    if OpenDialogSupport.Execute then
    begin
      if CurrentProjectName = '' then
        s := EXEDIR
      else
        s := AssertDir(ExtractFilePath(CurrentProjectName));
      for i := 1 to OpenDialogSupport.Files.Count do
      begin
        SetFileAttributes(PChar(s + ExtractFileName(OpenDialogSupport.Files[i -1])),
          FILE_ATTRIBUTE_NORMAL);
        FileCopyFile(PChar(OpenDialogSupport.Files[i -1]),
          PChar(s + ExtractFileName(OpenDialogSupport.Files[i -1])), false);
        SupportFiles.Add(ExtractFileName(OpenDialogSupport.Files[i -1]));
        
      end;
      
      ui.SetDirtyMpr(True);
      Project.SetSupport(SupportFiles);
    end;
  finally
    ui.PopStatusStack;
  end;
end;

procedure TProject.AddDialogstoProject1Click(Sender: TObject);
begin
  AddDialog.ShowModal;
end;

procedure TProject.AddIncludeClick(Sender: TObject);
var
  i, j: Integer;
begin
  try
    ui.PushStatusStack('Adding scripts');
    if not ui.SafeRunState then Exit;
    if PROJDIR <> LastProjDir then
    begin
      LastProjDir := PROJDIR;
      OpenDialog.InitialDir := PROJDIR;
    end;
    if OpenDialog.Execute then
    begin
      for i := 1 to OpenDialog.Files.Count do
      begin
        if IncludeFiles.IndexOf(OpenDialog.Files[i -1]) <> -1 then
        begin
          Application.MessageBox(PChar(SThe + OpenDialog.Files[i -1] + SIncludeScriptIsAlreadyPartOfYour),
            PChar(Application.Title), mb_Ok + mb_IconStop);
          Exit;
        end;
        if CompareText(ui.GetFullProjectScriptFilePath, OpenDialog.Files[i -1]) = 0 then
        begin
          Application.MessageBox(PChar(SThe + OpenDialog.Files[i -1] + SScriptIsAlreadyYourSetupSPrimary),
            PChar(Application.Title), mb_Ok + mb_IconStop);
          Exit;
        end;
        for j := 1 to IncludeFiles.Count do
          if CompareText(ExtractFileNameOnly(IncludeFiles[j -1]),
            ExtractFileNameOnly(OpenDialog.Files[i -1])) = 0 then
          begin
            Application.MessageBox(PChar(SAnotherIncludeScriptWithTheSameF + OpenDialog.Files[i -1] + SHasAlreadyBeenAddedIntoYourProje),
              PChar(Application.Title), mb_Ok + mb_IconStop);
            Exit;
          end;
        IncludeFiles.Add(OpenDialog.Files[i -1]);
        
      end;
      ui.SetDirtyMPR(True);
      Project.SetInclude(IncludeFiles);
    end;
  finally
    ui.PopStatusStack;
  end;
end;

procedure TProject.pPopupMenuPopup(Sender: TObject);
var
  i, j: Integer;
  b: Boolean;
  pW, pH, pV: Boolean;
begin
  SaveProjectAs1.Enabled := false;
  SaveScriptAs1.Enabled := false;
  ChangeScript1.Enabled := false;
  AddDialogsToProject1.Enabled := false;
  RemoveDialog1.Enabled := false;
  AddFilesToProject1.Enabled := false;
  RemoveFiles1.Enabled := false;
  NewInclude.Enabled := false;
  AddInclude.Enabled := false;
  RemoveInclude.Enabled := false;
  if Tree.Selected = nil then
  begin
    
    for i := 1 to Tree.Items.Count do
      for j := 1 to Tree.Items[i -1].Count do
        if Tree.Items[i -1].Items[j -1].Selected then
        begin
          Tree.Selected := Tree.Items[i -1].Items[j -1];
          Break;
        end;
    
    if Tree.Selected = nil then
      
      Exit;
  end;
  if Tree.Selected = Tree.Items[0] then SaveProjectAs1.Enabled := True;
  if Tree.Selected = Tree.Items[0].Items[0] then
  begin
    SaveScriptAs1.Enabled := True;
    ChangeScript1.Enabled := True;
  end;
  if Tree.Selected = Tree.Items[0].Items[1] then
  begin
    AddDialogsToProject1.Enabled := True;
    RemoveDialog1.Enabled := True;
  end;
  if Tree.Selected = Tree.Items[0].Items[2] then
  begin
    AddFilesToProject1.Enabled := True;
    RemoveFiles1.Enabled := True;
  end;
  if Tree.Selected = Tree.Items[0].Items[5 -2] then
  begin
    NewInclude.Enabled := True;
    AddInclude.Enabled := True;
    RemoveInclude.Enabled := True;
  end;
  
  if Tree.Selected.Parent <> nil then
  begin
    if Tree.Selected.Parent = Tree.Items[0].Items[0] then
    begin
      SaveScriptAs1.Enabled := True;
      ChangeScript1.Enabled := True;
    end;
    if Tree.Selected.Parent = Tree.Items[0].Items[1] then
    begin
      AddDialogsToProject1.Enabled := True;
      RemoveDialog1.Enabled := True;
    end;
    if Tree.Selected.Parent = Tree.Items[0].Items[2] then
    begin
      AddFilesToProject1.Enabled := True;
      RemoveFiles1.Enabled := True;
    end;
    if Tree.Selected.Parent = Tree.Items[0].Items[5 -2] then
    begin
      NewInclude.Enabled := True;
      AddInclude.Enabled := True;
      RemoveInclude.Enabled := True;
    end;
    
  end;
end;

procedure TProject.ProjectOptions1Click(Sender: TObject);
begin
  if not ui.SafeRunState then Exit;
  ui.Options1Click(Self);
end;

procedure TProject.RemoveDialog1Click(Sender: TObject);
var
  i, j: Integer;
  s: String;
begin
  try
    ui.PushStatusStack('Removing dialogs');
    s := '';
    if Tree.Selected <> nil then
    begin
      j := Application.MessageBox(PChar(SDoYouWishToDeleteRemovedDialogsF),
        PChar(Application.Title), mb_YesNoCancel or mb_IconQuestion);
      if j = id_Cancel then Exit;
    end;
    for i := Tree.Items.Count downto 1 do
      if Tree.Items[i -1].Selected then
        if Tree.Items[i -1].Parent <> nil then
          if Tree.Items[i -1].Parent = Tree.Items[0].Items[1] then
            begin
              DialogFiles.Delete(DialogFiles.IndexOf(
                Tree.Items[i -1].Text + '.lfm')); 
              DialogFiles.Delete(DialogFiles.IndexOf(
                Tree.Items[i -1].Text + '.lfm.miaf')); 
              if j = id_Yes then
              begin
                DeleteFile(PROJDIR + Tree.Items[i -1].Text + '.lfm'); 
                DeleteFile(PROJDIR + Tree.Items[i -1].Text + '.lfm.miaf'); 
              end;
            end;
    
    ui.SetDirtyMpr(True);
    SetDialogs(DialogFiles);
  finally
    ui.PopStatusStack;
  end;
end;

procedure TProject.RemoveFiles1Click(Sender: TObject);
var
  i, j: Integer;
  s: String;
begin
  try
    ui.PushStatusStack('Removing files');
    s := '';
    if Tree.Selected <> nil then
    begin
      j := Application.MessageBox(PChar(SDoYouWishToDeleteRemovedFilesFro),
        PChar(Application.Title), mb_YesNoCancel or mb_IconQuestion);
      if j = id_Cancel then Exit;
    end;
    for i := Tree.Items.Count downto 1 do
      if Tree.Items[i -1].Selected then
        if Tree.Items[i -1].Parent <> nil then
          if Tree.Items[i -1].Parent = Tree.Items[0].Items[2] then
            begin
              SupportFiles.Delete(SupportFiles.IndexOf
                (Tree.Items[i -1].Text));
              if j = id_Yes then
                DeleteFile(PROJDIR + Tree.Items[i -1].Text);
            end;
    
    ui.SetDirtyMpr(True);
    SetSupport(SupportFiles);
  finally
    ui.PopStatusStack;
  end;
end;

procedure TProject.RemoveIncludeClick(Sender: TObject);
var
  s: String;
  i, j, k: Integer;
  MemoryBuffer, FileBuffer: String;
begin
  try
    ui.PushStatusStack('Removing scripts');
    if not ui.SafeRunState then Exit;
    j := -1;
    if SaveJ > 0 then
      if SaveJ = MAXINT then
        j := -1 
      else
        j := SaveJ; 
    for i := Tree.Items.Count downto 1 do
      if Tree.Items[i -1].Selected then
        if Tree.Items[i -1].Parent <> nil then
          if Tree.Items[i -1].Parent = Tree.Items[0].Items[5 -2] then
          begin
            for k := 1 to IncludeFiles.Count do
              if CompareText(ExtractFileNameOnly(IncludeFiles[k -1]),
                Tree.Items[i -1].Text) = 0 then
              begin
                s := IncludeFiles[k -1];
                Break;
              end;
            if DirtyBuffer.IndexOf(s) <> -1 then
            begin
              if j = -1 then
                j := Application.MessageBox(PChar(SSaveChangesToScriptSBeforeClosin),
                  PChar(Application.Title), mb_YesNoCancel + mb_IconQuestion);
              if j = id_Cancel then
              begin
                if SaveJ > 0 then
                  SaveJ := j; 
                Exit;
              end;
              ui.GetNamedScriptNameAndFile(ExtractFileNameOnly(s),
                MemoryBuffer, FileBuffer);
              if j = id_Yes then
                ui.SaveNamedScript(MemoryBuffer, FileBuffer, PROJDIR);
              if j = id_No then
                DirtyBuffer.Delete(DirtyBuffer.IndexOf(MemoryBuffer));
              if SaveJ > 0 then
                SaveJ := j; 
            end;
            if LastActiveContext = s then
            begin
              
              if ui.CurrentUnit.TabIndex = IncludeFiles.IndexOf(s) +2 then
                ui.CurrentUnit.TabIndex := 1 
              
              else
                ui.CurrentUnit.TabIndex := 1;
              ui.CurrentUnitChange(Self);
            end;
            
            if ui.IsContextLoaded(s) then
              ui.FreeContext(s);
            IncludeFiles.Delete(IncludeFiles.IndexOf(s));
          end;
    
    ui.SetDirtyMPR(True);
    SetInclude(IncludeFiles);
  finally
    ui.PopStatusStack;
  end;
end;

procedure TProject.SaveProjectAs1Click(Sender: TObject);
begin
  if not ui.SafeRunState then Exit;
  ui.SaveProjectAs1Click(Self);
end;

procedure TProject.TreeDblClick(Sender: TObject);
var
  s: String;
  sl: TStringList;
  i: Integer;
begin
  if Tree.Selected = nil then Exit;
  if Tree.Selected.Parent = nil then Exit;
  if Tree.Selected.Parent = Tree.Items[0].Items[0] then
  begin
    ui.CurrentUnit.TabIndex := 1;
    ui.CurrentUnitChange(Self);
    
      ui.SwitchToUI(false);
  end;
  if Tree.Selected.Parent = Tree.Items[0].Items[1] then
  begin
    sl := TStringList.Create;
    sl.Add(PROJDIR + Tree.Selected.Text + '.lfm');
    {$IFDEF WINDOWS}
    LaunchAppAndWait2(EXEDIR + 'miauix.exe', sl, True, false);
    {$ELSE}
    {$IFDEF DARWIN}
    LaunchAppAndWait2(EXEDIR + 'miauix.app/Contents/MacOS/miauix', sl, True, false);
    {$ELSE}
    LaunchAppAndWait2(EXEDIR + 'miauix', sl, True, false);
    {$ENDIF}
    {$ENDIF}
    sl.Free;
  end;
  if Tree.Selected.Parent = Tree.Items[0].Items[2] then
    OpenDocument(PROJDIR + Tree.Selected.Text);
  if Tree.Selected.Parent = Tree.Items[0].Items[5 -2] then
  begin
    for i := 1 to IncludeFiles.Count do
      if CompareText(ExtractFileNameOnly(IncludeFiles[i -1]),
        Tree.Selected.Text) = 0 then
      begin
        s := IncludeFiles[i -1];
        Break;
      end;
    ui.CurrentUnit.TabIndex := IncludeFiles.IndexOf(s) +2;
    ui.CurrentUnitChange(Self);
    
      ui.SwitchToUI(false);
  end;
end;

procedure TProject.TreeKeyUp(Sender: TObject; var Key: Word; Shift: TShiftState
  );
begin
  if Key = 13 then
  begin
    TreeDblClick(Self);
    Exit;
  end;
  if Tree.Selected = nil then Exit;
  if Tree.Selected.Parent = nil then Exit;
  if (Tree.Selected = Tree.Items[0].Items[1]) and (Key = 45) then
    AddDialogsToProject1Click(Self);
  if (Tree.Selected.Parent = Tree.Items[0].Items[1]) and (Key = 45) then
    AddDialogsToProject1Click(Self);
  if (Tree.Selected = Tree.Items[0].Items[2]) and (Key = 45) then
    AddFilesToProject1Click(Self);
  if (Tree.Selected.Parent = Tree.Items[0].Items[2]) and (Key = 45) then
    AddFilesToProject1Click(Self);
  if (Tree.Selected.Parent = Tree.Items[0].Items[1]) and (Key = 46) then
    RemoveDialog1Click(Self);
  if (Tree.Selected.Parent = Tree.Items[0].Items[2]) and (Key = 46) then
    RemoveFiles1Click(Self);
  if (Tree.Selected = Tree.Items[0].Items[3]) and (Key = 45) then
    AddIncludeClick(Self);
  if (Tree.Selected.Parent = Tree.Items[0].Items[3]) and (Key = 45) then
    AddIncludeClick(Self);
  if (Tree.Selected.Parent = Tree.Items[0].Items[3]) and (Key = 46) then
    RemoveIncludeClick(Self);
end;

procedure TProject.Clear;
begin
  Tree.Items[0].Items[0].DeleteChildren;
  Tree.Items[0].Items[1].DeleteChildren;
  Tree.Items[0].Items[2].DeleteChildren;
  Tree.Items[0].Items[3].DeleteChildren;
end;

procedure TProject.SetProject(ProjectName: String);
begin
  if ProjectName = '' then ProjectName := SUntitled;
  if EnabledFullPaths then
    Tree.Items[0].Text := ProjectName
  else
    Tree.Items[0].Text := ExtractFileNameOnly(ProjectName);
end;

procedure TProject.SetScript(FileName: String);
var
  t: TTreeNode;
begin
  if FileName = '' then
    FileName := 'untitled.miax'; 
  Tree.Items[0].Items[0].DeleteChildren;
  if EnabledFullPaths then
    t := Tree.Items.AddChild(Tree.Items[0].Items[0], FileName)
  else
    t := Tree.Items.AddChild(Tree.Items[0].Items[0], ExtractFileNameOnly(FileName));
  t.ImageIndex := 4;
  t.SelectedIndex := 4;
  Tree.Items[0].Items[0].Expand(false);
end;

procedure TProject.SetDialogs(List: TStrings);
var
  i: Integer;
  t: TTreeNode;
begin
  Tree.Items[0].Items[1].DeleteChildren;
  for i := 1 to List.Count do
    if AnsiPos('.miaf', List[i -1]) = 0 then 
    begin
      if EnabledFullPaths then
        t := Tree.Items.AddChild(Tree.Items[0].Items[1],
          PROJDIR + List[i -1])
      else
        t := Tree.Items.AddChild(Tree.Items[0].Items[1],
          ExtractFileNameOnly(List[i -1]));
      t.ImageIndex := 5;
      t.SelectedIndex := 5;
    end;
  Tree.Items[0].Items[1].Expand(false);
  
end;

procedure TProject.SetSupport(List: TStrings);
var
  i: Integer;
  t: TTreeNode;
begin
  Tree.Items[0].Items[2].DeleteChildren;
  for i := 1 to List.Count do
  begin
    if EnabledFullPaths then
      t := Tree.Items.AddChild(Tree.Items[0].Items[2],
        PROJDIR + List[i -1])
    else
      t := Tree.Items.AddChild(Tree.Items[0].Items[2],
        ExtractFileName(List[i -1]));
    t.ImageIndex := 6;
    t.SelectedIndex := 6;
  end;
  Tree.Items[0].Items[2].Expand(false);
  
end;

procedure TProject.SetInclude(List: TStrings);
var
  s: String;
  i, j: Integer;
  t: TTreeNode;
begin
  
  Tree.Items[0].Items[3].DeleteChildren;
  for i := 1 to List.Count do
  begin
    if EnabledFullPaths then
      t := Tree.Items.AddChild(Tree.Items[0].Items[3],
        List[i -1])
    else
      t := Tree.Items.AddChild(Tree.Items[0].Items[3],
        ExtractFileNameOnly(List[i -1]));
    t.ImageIndex := 16;
    t.SelectedIndex := 16;
  end;
  Tree.Items[0].Items[3].Expand(false);
  
  if ui.CurrentUnit.TabIndex <> -1 then
    s := ui.CurrentUnit.Tabs[ui.CurrentUnit.TabIndex]
  else
    s := '';
  j := -1;
  ui.CurrentUnit.OnChange := nil;
  ui.CurrentUnit.Tabs.Clear;
  uGui.OldTab := -1; 
  
  ui.CurrentUnit.Tabs.Add(SWelcomePage);
  if ScriptFile = '' then
    ui.CurrentUnit.Tabs.Add(SUntitled_1)
  else
    ui.CurrentUnit.Tabs.Add(ExtractFileNameOnly(ScriptFile));
  
  for i := 1 to List.Count do
  begin
    ui.CurrentUnit.Tabs.Add(ExtractFileNameOnly(List[i -1]));
    if CompareText(ExtractFileNameOnly(List[i -1]), s) = 0 then
      j := 2 + i -1;
  end;
  if j = -1 then
  begin
    if s = ExtractFileNameOnly(ScriptFile) then j := 1;
    if s = SWelcomePage then j := 0;
  end;
  if j = -1 then j := 1; 
  try
    ui.CurrentUnit.TabIndex := j;
    ui.CurrentUnitChange(Self); 
  except
  end;
  ui.CurrentUnit.OnChange := @ui.CurrentUnitChange;
end;

end.
