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
unit PicsLib;

interface

uses SysUtils, Classes, Math, LazUtf8Classes;

type
  TImageFormat = (ifUnknown, ifBmp, ifPng, ifGif, ifJpg);

function GetImageSize(const Fn: String; out Width, Height: dword): Boolean;
function GetImageSizeAndFormat(const Fn: String; out Width, Height: dword): TImageFormat;

implementation

type

   TBitmapFileHeader = Packed Record
                         ID: word;
                         FileSize: dword;
                         Reserved: dword;
                         BitmapDataOffset: dword;
                       end;
   TBitmapInfo        = Packed Record
                          BitmapHeaderSize: dword;
                          Width: dword;
                          Height: dword;
                          Planes: word;
                          BitsPerPixel: word;
                          Compression: dword;
                          BitmapDataSize: dword;
                          XpelsPerMeter: dword;
                          YPelsPerMeter: dword;
                          ColorsUsed: dword;
                          ColorsImportant: dword;
                        end;

   TGIFHeader        = Packed Record
                         ID: array[0..5] of char;
                         Width, Height: Word;
                       end;

   TPNGHeader        = Packed Record
                         ID: array[0..7] of Char;
                         ChunkLength: dword;
                         ChunkType: array[0..3] of Char;
                         Width: dword;
                         Height: dword;
                         BitsPerPixel: byte;
                         ColorType: byte;
                         Compression: byte;
                         FilterMethod: byte;
                         CRC: dword;
                       end;

   TJPGHeader        = array[0..1] of Byte; 

   TSOFHeader        = Packed record
                         Len: word;
                         DataPrecision: byte;
                         Height, Width: word;
                         NrComponents: byte;
                       end;

function ExtToImageFormat(const Ext: String): TImageFormat;
begin
  if AnsiUpperCase(Ext) = '.BMP' then
  begin
    Result := ifBmp;
  end
  else if AnsiUpperCase(Ext) = '.GIF' then
  begin
    Result := ifGif;
  end
  else if (AnsiUpperCase(Ext) = '.JPG')
    or (AnsiUpperCase(Ext) = '.JPEG') then
  begin
    Result := ifJpg;
  end
  else if AnsiUpperCase(Ext) = '.PNG' then
  begin
    Result := ifPng;
  end
  else
  begin
    Result := ifUnknown;
  end;
end;

function MaybeBmp(St: TStream; ChunkSize: Integer; out Width, Height: DWord): TImageFormat;
var
  BFH: TBitmapFileHeader;
  BInfo: TBitmapInfo;
  IDStr: String;
begin
  Result := ifUnknown;
  if (ChunkSize < (SizeOf(TBitmapFileHeader) + SizeOf(TBitmapInfo))) then Exit;
  St.Position := 0;
  St.ReadBuffer(BFH, Sizeof(TBitmapFileHeader));
  St.ReadBuffer(BInfo, SizeOf(TBitmapInfo));
  BFH.ID := LeToN(BFH.ID);
  IDStr := Char(Lo(BFH.ID)) + Char(Hi(BFH.ID));
  {$ifdef DebugPicsLib}
  if IsConsole then writeln('IDStr = ',idstr);
  if IsConsole then writeln('BInfo.BitmapHeaderSize = $',IntToHex(BInfo.BitmapHeaderSize,2));
  if IsConsole then writeln('BInfo.BitsPerPixel = ',BInfo.BitsPerPixel);
  {$endif}
  BInfo.BitmapHeaderSize := LeToN(BInfo.BitmapHeaderSize);
  BInfo.BitsPerPixel := LeToN(BInfo.BitsPerPixel);
  if ((IDStr = 'BM') or (IDStr = 'BA')) and
     (BInfo.BitmapHeaderSize in [$28,$0c,$f0]) and
     (BInfo.BitsPerPixel in [1,4,8,16,24,32])then
  begin
    Width := LeToN(BInfo.Width);
    Height := LeToN(BInfo.Height);
    Result := ifBmp;
  end;
  {$ifdef DebugPicsLib}
  if IsConsole then writeln('MaybeBmp: Result = ',Result);
  {$endif}
end;

function MaybePng(St: TStream; ChunkSize: Integer; out Width, Height: DWord): TImageFormat;
var
  PngHeader: TPngHeader;
begin
  Result := ifUnknown;
  if (ChunkSize < SizeOf(TPngHeader)) then Exit;
  St.Position := 0;
  St.ReadBuffer(PngHeader, SizeOf(TPngHeader));
  {$ifdef DebugPicsLib}
  if IsConsole then writeln('PNGHeader.ID= ',PNGHeader.ID);
  if IsConsole then writeln('PNGHeader.ChunkType = ',PNGHeader.ChunkType);
  {$endif}
  if (AnsiUpperCase(PNGHeader.ID) = #137'PNG'#13#10#26#10) or
     (AnsiUpperCase(PNGHeader.ChunkType) = 'IHDR') then
  begin
    
    Width := BeToN(PNGHeader.Width);
    Height := BeToN(PNGHeader.Height);
    Result := ifPng;
  end;
  {$ifdef DebugPicsLib}
  if IsConsole then writeln('MaybePng: Result = ',Result);
  {$endif}
end;

function MaybeGif(St: TStream; ChunkSize: Integer; out Width, Height: DWord): TImageFormat;
var
  GifHeader: TGifHeader;
begin
  Result := ifUnknown;
  if (ChunkSize < SizeOf(TGifHeader)) then Exit;
  St.Position := 0;
  St.ReadBuffer(GifHeader, SizeOf(TGifHeader));
  {$ifdef DebugPicsLib}
  if IsConsole then writeln('GifHeader.ID = ',GifHeader.ID);
  {$endif}
  if  ((AnsiUpperCase(GifHeader.ID) = 'GIF87A') or (AnsiUpperCase(GifHeader.ID) = 'GIF89A')) then
  begin
    Width := LeToN(GifHeader.Width);
    Height := LeToN(GifHeader.Height);
    Result := ifGif;
  end;
  {$ifdef DebugPicsLib}
  if IsConsole then writeln('MaybeGif: Result = ',Result);
  {$endif}
end;

function MaybeJpg(St: TStream; ChunkSize: Integer; out Width, Height: DWord): TImageFormat;
const
  Parameterless = [$01, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7];
var
  JPGHeader: TJPGHeader;
  SOFHeader: TSOFHeader;
  B, SegType: byte;
  SegSize: Word; 
  SOF_Found: boolean;
  Dummy: array[0..65532] of byte; 
begin
  Result := ifUnknown;
  if (ChunkSize < SizeOf(TJpgHeader)) then Exit;
  St.Position := 0;

  St.ReadBuffer(JPGHeader, SizeOf(TJPGHeader));
  if (JPGHeader[0] <> $FF) or (JPGHeader[1] <> $D8) then
  begin
    Exit;
  end;
  {$ifdef DebugPicsLib}
  if IsConsole then writeln('StartOfImage Found');
  {$endif}
  SOF_Found := False;

  St.ReadBuffer(B,1);
  While (not SOF_Found) and (St.Position < St.Size) and (B = $FF) do 
  begin
    St.ReadBuffer(SegType,1);
    {$ifdef DebugPicsLib}
    if IsConsole then write('Segment Type: '+IntToHex(SegType,2)+' ');
    {$endif}
    case SegType of
      $c0,$c1,$c2 :
      begin
        {$ifdef DebugPicsLib}
        if IsConsole then write('  Found SOF');
        {$endif}
        St.ReadBuffer(SOFHeader,SizeOf(TSOFHeader));
        
        SOFHeader.Len := BeToN(SOFHeader.Len);
        {$ifdef DebugPicsLib}
        if IsConsole then write('  Segment Length: '+IntToStr(SOFHeader.Len),' (StartOfFrame)');
        {$endif}
        
        SOFHeader.Height := BeToN(SOFHeader.Height);
        SOFHeader.Width := BeTon(SOFHeader.Width);

        St.ReadBuffer(Dummy,SOFHeader.NrComponents*3);
        Width := SOFHeader.Width;
        Height := SOFHeader.Height;
        SOF_Found := true;
      end;

      $01, $D0, $D1, $D2, $D3, $D4, $D5, $D6, $D7:
      begin
        {$ifdef DebugPicsLib}
        if IsConsole then write('  Parameterloos');
        {$endif}
        
      end;
      $d9:
      begin
        {$ifdef DebugPicsLib}
        if IsConsole then write('  EndOfImage');
        {$endif}
        Break;
      end;
      $da:
      begin
        {$ifdef DebugPicsLib}
        if IsConsole then write('  StartOfScan');
        {$endif}
        Break;
      end;
      else
      begin
        
        St.ReadBuffer(SegSize,SizeOf(SegSize));
        
        SegSize := BeTon(SegSize);
        {$ifdef DebugPicsLib}
        if IsConsole then write('  Segment Length: '+IntToStr(SegSize));
        {$endif}
        if SegSize > 2 then
        begin
          SegSize := SegSize - 2;
          St.ReadBuffer(Dummy,SegSize);
        end;
      end;
    end;
    
    St.ReadBuffer(B,1);
    {$ifdef DebugPicsLib}
    if IsConsole then writeln;
    {$endif}
  end;
  
  if SOF_Found then Result := ifJpg;
  {$ifdef DebugPicsLib}
  if IsConsole then begin writeln; writeln('  End of Search for markers'); writeln; end;
  if IsConsole then writeln('MaybeJpg: Result = ',Result);
  {$endif}
end;

type
  TMaybeFormatFunc = function(St: TStream; ChunkSize: Integer; out Width, Height: DWord): TImageFormat;
  TMaybeFormatFuncs = array[TImageFormat] of TMaybeFormatFunc;

const
  MaybeFormatFuncs: TMaybeFormatFuncs = (nil, @MaybeBmp, @MaybePng, @MaybeGif, @MaybeJpg);

function GetImageFormatAndDimensions(const St: TStream; const TryFirst: TImageFormat; out Width, Height: DWord): TImageFormat;
var
  ChunkSize: Integer;
  Buf: PByte;
  ImgFormat: TImageFormat;
begin
  ChunkSize := Max(SizeOf(TBitMapFileHeader) + SizeOf(TBitmapInfo),
                  Max(SizeOf(TPngHeader),
                  Max(SizeOf(TGifHeader), SizeOf(TJpgHeader))));
  {$ifdef DebugPicsLib}
  
  if IsConsole then writeln('chunksize ',chunksize);
  if IsConsole then writeln('TryFirst = ',TryFirst);
  {$endif}

  ChunkSize := Max(ChunkSize, St.Size);
  Result := ifUnknown;
  if (TryFirst <> ifUnknown) then Result := MaybeFormatFuncs[TryFirst](St, ChunkSize, Width, Height);
  if (Result = ifUnknown) then
  begin
    for ImgFormat := Succ(Low(TImageFormat)) to High(TImageFormat) do
    begin
      if (ImgFormat <> TryFirst) then Result := MaybeFormatFuncs[ImgFormat](St, ChunkSize, Width, Height);
      if (Result <> ifUnknown) then Break;
    end;
  end;
end;

function GetImageSizeAndFormat(const Fn: String; out Width, Height: dword): TImageFormat;
var
  ImgStream: TFileStreamUtf8;
  ImgFormat: TImageFormat;
begin
  Width := 0;
  Height := 0;
  try
    ImgStream := TFileStreamUtf8.Create(Fn,fmOpenRead or fmShareDenyNone);
    try
      ImgStream.Position := 0;
      ImgFormat := GetImageFormatAndDimensions(ImgStream, ExtToImageFormat(ExtractFileExt(Fn)), Width, Height);
      Result := ImgFormat;
    finally
      ImgStream.Free;
    end;
  except
     on EStreamError do Result := ifUnknown;
  end;
end;

function GetImageSize(const Fn: String; out Width, Height: dword): Boolean;
begin
  Result := (GetImageSizeAndFormat(Fn, Width, Height) <> ifUnknown);
end;

end.

