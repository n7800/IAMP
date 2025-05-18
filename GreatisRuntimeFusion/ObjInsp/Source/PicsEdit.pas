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

unit PicsEdit;

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
  Messages, SysUtils, Classes, Graphics, Controls, Forms, Dialogs, ExtCtrls,
  ExtDlgs, StdCtrls, PropEdit, GraphType, IntfGraphics, IcnsTypes, Menus,
  FPImage;

type

  TPictureItem = record
  public
    FWidth: Integer;
    FHeight: Integer;
    FDepth: Integer;
    FIntfImage: TLazIntfImage;
  end;
  PPictureItem = ^TPictureItem;

  TPictureList = class(TList)
  private
    function GetItem(Index: Integer): PPictureItem;
    procedure SetItem(Index: Integer; const AValue: PPictureItem);
  protected
    procedure Notify(Ptr: Pointer; Action: TListNotification); override;
  public
    function Add(AHeight, AWidth, ADepth: Integer; AIntfImage: TLazIntfImage): Integer; reintroduce;
    property Items[Index: Integer]: PPictureItem read GetItem write SetItem; default;
  end;

  TfrmPicture = class(TForm)
    btnOK: TButton;
    btnCancel: TButton;
    cbSizeSelection: TComboBox;
    lSizeSelection: TLabel;
    opdImage: TOpenPictureDialog;
    svdImage: TSavePictureDialog;
    pnlImage: TPanel;
    btnLoad: TButton;
    btnSave: TButton;
    btnClear: TButton;
    pntImage: TPaintBox;
    procedure btnLoadClick(Sender: TObject);
    procedure btnSaveClick(Sender: TObject);
    procedure btnClearClick(Sender: TObject);
    procedure cbSizeSelectionChange(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure pntImagePaint(Sender: TObject);
  private
    
    FPicture: TPicture;
    FPictureList: TPictureList;
    procedure SelectIconCurrent;
  public
    
    property Picture: TPicture read FPicture;
  end;

  TPicturePropertyEditor = class(TPropertyEditor)
    function Execute: Boolean; override;
  end;

implementation

{$IFnDEF FPC}
  {$R *.dfm}
{$ELSE}
  {$R *.lfm}
{$ENDIF}

function TPictureList.GetItem(Index: Integer): PPictureItem;
begin
  Result := inherited Get(Index);
end;

procedure TPictureList.SetItem(Index: Integer; const AValue: PPictureItem);
begin
  inherited Put(Index, AValue);
end;

procedure TPictureList.Notify(Ptr: Pointer; Action: TListNotification);
begin
  if Action = lnDeleted then
  begin
    PPictureItem(Ptr).FIntfImage.Free;
    Dispose(PPictureItem(Ptr));
  end;
  inherited Notify(Ptr, Action);
end;

function TPictureList.Add(AHeight, AWidth, ADepth: Integer; AIntfImage: TLazIntfImage): Integer;
var
  Rec: PPictureItem;
begin
  New(Rec);
  Rec^.FHeight := AHeight;
  Rec^.FWidth := AWidth;
  Rec^.FDepth := ADepth;
  Rec^.FIntfImage := AIntfImage;
  Result := inherited Add(Rec);
end;

function TPicturePropertyEditor.Execute: Boolean;
begin
  with TfrmPicture.Create(nil) do
  try
    with Prop do
      if PropType=TypeInfo(TPicture) then FPicture.Assign(TPicture(Prop.AsObject))
      else if PropType=TypeInfo(TBitmap) then FPicture.Bitmap.Assign(TBitmap(Prop.AsObject))
      else if PropType=TypeInfo(TIcon) then FPicture.Icon.Assign(TIcon(Prop.AsObject))
      {$IFNDEF DisableLCLJPEG}
      else if PropType=TypeInfo(TJPEGImage) then FPicture.Jpeg.Assign(TJPEGImage(Prop.AsObject))
      {$ENDIF}
      else if PropType=TypeInfo(TPixmap) then FPicture.Pixmap.Assign(TPixmap(Prop.AsObject))
      else if PropType=TypeInfo(TPortableNetworkGraphic) then FPicture.PNG.Assign(TPortableNetworkGraphic(Prop.AsObject))
      {$IFNDEF DisableLCLPNM}
      else if PropType=TypeInfo(TPortableAnyMapGraphic) then FPicture.PNM.Assign(TPortableAnyMapGraphic(Prop.AsObject))
      {$ENDIF}
      else if PropType=TypeInfo(TGraphic) then FPicture.Graphic.Assign(TGraphic(Prop.AsObject))
      else FPicture.Graphic:=TGraphic(Prop.AsObject);

    opdImage.Filter:=GraphicFilter(TGraphic);
    svdImage.Filter:=opdImage.Filter;
    Result:=ShowModal=mrOk;

    if Result then
      with Prop do
        if PropType=TypeInfo(TPicture) then TPicture(Prop.AsObject).Assign(FPicture)
        else if PropType=TypeInfo(TBitmap) then TBitmap(Prop.AsObject).Assign(FPicture.Bitmap)
        else if PropType=TypeInfo(TIcon) then TIcon(Prop.AsObject).Assign(FPicture.Icon)
        {$IFNDEF DisableLCLJPEG}
        else if PropType=TypeInfo(TJPEGImage) then TJPEGImage(Prop.AsObject).Assign(FPicture.Jpeg)
        {$ENDIF}
        else if PropType=TypeInfo(TPixmap) then TPixmap(Prop.AsObject).Assign(FPicture.Pixmap)
        else if PropType=TypeInfo(TPortableNetworkGraphic) then TPortableNetworkGraphic(Prop.AsObject).Assign(FPicture.PNG)
        {$IFNDEF DisableLCLPNM}
        else if PropType=TypeInfo(TPortableAnyMapGraphic) then TPortableAnyMapGraphic(Prop.AsObject).Assign(FPicture.PNM)
        {$ENDIF}
        else if PropType=TypeInfo(TGraphic) then TGraphic(Prop.AsObject).Assign(FPicture.Graphic)
        else Prop.AsObject:=FPicture.Graphic;
  finally
    Free;
  end;
end;

procedure TfrmPicture.btnLoadClick(Sender: TObject);
  procedure LoadIcon;
  var I : Integer;
  begin
    if FPicture.Icon.Count > 0 then
    begin
      for I := 0 to TCustomIcon(FPicture.Graphic).Count - 1 do
      begin
        TCustomIcon(FPicture.Graphic).Current := I;
        if (TCustomIcon(FPicture.Graphic).Height > 0) and
           (TCustomIcon(FPicture.Graphic).Width > 0) then
           FPictureList.Add(TCustomIcon(FPicture.Graphic).Height,
                            TCustomIcon(FPicture.Graphic).Width,
                            PIXELFORMAT_BPP[TCustomIcon(FPicture.Graphic).PixelFormat],
                            TCustomIcon(FPicture.Graphic).CreateIntfImage);
      end;
    end;
  end;

  procedure ConvertAlfaIcon(FileName: String);
  var
    Stream: TMemoryStream;
    Resource: TIconFamilyResource;

    IntfImage: TLazIntfImage;
    ImgReader: TLazReaderIcnsPart;
    LazReader: ILazImageReader;
    RawImg: TRawImage;

    nStart, nFinish: Int64;
    LInput: TMemoryStream;
    Buffer: array of Byte;
    Picture: TPicture;
  begin

    Stream := TMemoryStream.Create;
    Stream.LoadFromFile(FileName);
    Stream.Position:=0;
    Stream.Read(Resource, SizeOf(Resource));

    if (Resource.resourceType = kIconFamilyType) then
    begin

      IntfImage := nil;
      ImgReader := nil;

      Resource.resourceSize := BEtoN(Resource.resourceSize);

      while Stream.Position <  Resource.resourceSize do
      begin
        IntfImage := TLazIntfImage.Create(0,0,[]);

        if ImgReader = nil then
        ImgReader := TLazReaderIcnsPart.Create;

        if Supports(ImgReader, ILazImageReader, LazReader) then
          LazReader.UpdateDescription := True
        else IntfImage.DataDescription := QueryDescription([riqfRGB, riqfAlpha, riqfMask]);

        nStart:= Stream.Position;
        ImgReader.ImageRead(Stream, IntfImage);
        nFinish:= Stream.Position;
        IntfImage.GetRawImage(RawImg, True);

        if (RawImg.Description.Height > 0) and (RawImg.Description.Width > 0) then
          if not (ImgReader.IconType in icnsDataTypes) and not (ImgReader.IconType in icnsMaskTypes) then
          begin

            nStart := nStart + 8;
            LInput:= TMemoryStream.Create;
            Picture:= TPicture.Create;
            try
              SetLength(Buffer, nFinish - nStart);

              Stream.Position:= nStart;
              Stream.ReadBuffer(Buffer[0], Length(Buffer));
              Stream.Position:= nFinish;

              LInput.WriteBuffer(Buffer[0], Length(Buffer));
              LInput.Position:=0;

              if Buffer[0] = 137 then
              begin
                Picture.PNG.LoadFromStream(LInput);
                FPictureList.Add(RawImg.Description.Height, RawImg.Description.Width, RawImg.Description.Depth, Picture.Icon.CreateIntfImage)
              end;

            finally
              FreeAndNil(Picture);
              FreeAndNil(LInput);
            end;
          end
          else IntfImage.Free
        else IntfImage.Free;

      end;

      LazReader := nil;
      ImgReader.Free;
    end;
    Stream.Free;

  end;

begin
  with opdImage do
    if Execute then
    begin
      FPicture.LoadFromFile(FileName);
      if FPictureList.Count > 0 then FPictureList.Clear;
      if FPicture.Graphic is TCustomIcon then LoadIcon;
      if FPicture.Graphic is TCustomIcon then ConvertAlfaIcon(FileName);
      SelectIconCurrent;
      pntImage.Repaint;
    end;
end;

procedure TfrmPicture.btnSaveClick(Sender: TObject);
begin
  with FPicture,svdImage do
    if not Graphic.Empty and Execute then SaveToFile(FileName);
end;

procedure TfrmPicture.btnClearClick(Sender: TObject);
begin
  FPicture.Graphic:=nil;
  pntImage.Repaint;
end;

procedure TfrmPicture.cbSizeSelectionChange(Sender: TObject);
begin
  FPicture.Bitmap.LoadFromIntfImage(FPictureList.Items[cbSizeSelection.ItemIndex].FIntfImage);
  pntImage.Repaint;
end;

procedure TfrmPicture.SelectIconCurrent;
  var I: Integer;
begin
  if FPictureList.Count > 0 then
  begin
    cbSizeSelection.Items.Clear;
    if FPictureList.Count > 1 then
      for I := 0 to FPictureList.Count - 1 do
      begin
        cbSizeSelection.Items.Add(IntToStr(FPictureList.Items[I].FWidth) + 'x' +
                                  IntToStr(FPictureList.Items[I].FHeight) + ' ' +
                                  IntToStr(FPictureList.Items[I].FDepth) + ' bit');
      end;

    lSizeSelection.Visible := FPictureList.Count > 1;
    if lSizeSelection.Visible then cbSizeSelection.ItemIndex:=0;

    FPicture.Bitmap.LoadFromIntfImage(FPictureList.Items[0].FIntfImage);
  end else lSizeSelection.Visible := False;

  cbSizeSelection.Visible := lSizeSelection.Visible;
  if not cbSizeSelection.Visible then cbSizeSelection.Items.Clear;
end;

procedure TfrmPicture.FormCreate(Sender: TObject);
begin
  FPicture:=TPicture.Create;
  FPictureList:=TPictureList.Create;

  lSizeSelection.Visible:=False;
  cbSizeSelection.Visible:=False;
end;

procedure TfrmPicture.FormDestroy(Sender: TObject);
begin
  FPictureList.Free;
  FPicture.Free;
end;

procedure TfrmPicture.pntImagePaint(Sender: TObject);
var
  R: TRect;
  Bmp: TBitmap;
begin
  if Assigned(FPicture.Bitmap) and not FPicture.Bitmap.Empty then
  begin
    Bmp:= TBitmap.Create;
    try
      Bmp.LoadFromIntfImage(FPicture.Bitmap.CreateIntfImage);

      with Bmp do R:=Rect(0,0,Width,Height);
      with pntImage,R do
      begin
        if (Right>ClientWidth) or (Bottom>ClientHeight) then
          if Right>Bottom then
          begin
            Right:=ClientWidth;
            Bottom:=Right*Bmp.Height div Bmp.Width;
          end
          else
          begin
            Bottom:=ClientHeight;
            Right:=Bottom*Bmp.Width div Bmp.Height;
          end;
        OffsetRect(R,(ClientWidth-Right) div 2,(ClientHeight-Bottom) div 2);
        Canvas.StretchDraw(R,Bmp);
      end;
    finally
      FreeAndNil(Bmp);
    end;
  end;
end;

end.
