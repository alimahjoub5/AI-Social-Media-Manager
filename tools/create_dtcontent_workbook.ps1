$ErrorActionPreference = "Stop"

Add-Type -AssemblyName System.IO.Compression.FileSystem

$outPath = Join-Path $PSScriptRoot "..\Data\dtContent.xlsx"
$tempDir = Join-Path ([System.IO.Path]::GetTempPath()) ("dtContent_xlsx_" + [System.Guid]::NewGuid().ToString("N"))

New-Item -ItemType Directory -Path $tempDir | Out-Null
New-Item -ItemType Directory -Path (Join-Path $tempDir "_rels") | Out-Null
New-Item -ItemType Directory -Path (Join-Path $tempDir "xl\_rels") | Out-Null
New-Item -ItemType Directory -Path (Join-Path $tempDir "xl\worksheets") | Out-Null

Set-Content -LiteralPath (Join-Path $tempDir "[Content_Types].xml") -Encoding UTF8 -Value @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Types xmlns="http://schemas.openxmlformats.org/package/2006/content-types">
  <Default Extension="rels" ContentType="application/vnd.openxmlformats-package.relationships+xml"/>
  <Default Extension="xml" ContentType="application/xml"/>
  <Override PartName="/xl/workbook.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.sheet.main+xml"/>
  <Override PartName="/xl/worksheets/sheet1.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.worksheet+xml"/>
  <Override PartName="/xl/styles.xml" ContentType="application/vnd.openxmlformats-officedocument.spreadsheetml.styles+xml"/>
</Types>
'@

Set-Content -LiteralPath (Join-Path $tempDir "_rels\.rels") -Encoding UTF8 -Value @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/officeDocument" Target="xl/workbook.xml"/>
</Relationships>
'@

Set-Content -LiteralPath (Join-Path $tempDir "xl\workbook.xml") -Encoding UTF8 -Value @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<workbook xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main" xmlns:r="http://schemas.openxmlformats.org/officeDocument/2006/relationships">
  <sheets>
    <sheet name="Sheet1" sheetId="1" r:id="rId1"/>
  </sheets>
</workbook>
'@

Set-Content -LiteralPath (Join-Path $tempDir "xl\_rels\workbook.xml.rels") -Encoding UTF8 -Value @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<Relationships xmlns="http://schemas.openxmlformats.org/package/2006/relationships">
  <Relationship Id="rId1" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/worksheet" Target="worksheets/sheet1.xml"/>
  <Relationship Id="rId2" Type="http://schemas.openxmlformats.org/officeDocument/2006/relationships/styles" Target="styles.xml"/>
</Relationships>
'@

Set-Content -LiteralPath (Join-Path $tempDir "xl\styles.xml") -Encoding UTF8 -Value @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<styleSheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
  <fonts count="2"><font><sz val="11"/><name val="Calibri"/></font><font><b/><sz val="11"/><name val="Calibri"/></font></fonts>
  <fills count="1"><fill><patternFill patternType="none"/></fill></fills>
  <borders count="1"><border><left/><right/><top/><bottom/><diagonal/></border></borders>
  <cellStyleXfs count="1"><xf numFmtId="0" fontId="0" fillId="0" borderId="0"/></cellStyleXfs>
  <cellXfs count="2"><xf numFmtId="0" fontId="0" fillId="0" borderId="0" xfId="0"/><xf numFmtId="0" fontId="1" fillId="0" borderId="0" xfId="0" applyFont="1"/></cellXfs>
</styleSheet>
'@

Set-Content -LiteralPath (Join-Path $tempDir "xl\worksheets\sheet1.xml") -Encoding UTF8 -Value @'
<?xml version="1.0" encoding="UTF-8" standalone="yes"?>
<worksheet xmlns="http://schemas.openxmlformats.org/spreadsheetml/2006/main">
  <dimension ref="A1:J1"/>
  <sheetViews><sheetView workbookViewId="0"/></sheetViews>
  <sheetFormatPr defaultRowHeight="15"/>
  <cols>
    <col min="1" max="10" width="22" customWidth="1"/>
  </cols>
  <sheetData>
    <row r="1">
      <c r="A1" t="inlineStr" s="1"><is><t>Title</t></is></c>
      <c r="B1" t="inlineStr" s="1"><is><t>Instagram</t></is></c>
      <c r="C1" t="inlineStr" s="1"><is><t>Facebook</t></is></c>
      <c r="D1" t="inlineStr" s="1"><is><t>LinkedIn</t></is></c>
      <c r="E1" t="inlineStr" s="1"><is><t>Twitter</t></is></c>
      <c r="F1" t="inlineStr" s="1"><is><t>TikTok</t></is></c>
      <c r="G1" t="inlineStr" s="1"><is><t>Hook</t></is></c>
      <c r="H1" t="inlineStr" s="1"><is><t>CTA</t></is></c>
      <c r="I1" t="inlineStr" s="1"><is><t>Hashtags</t></is></c>
      <c r="J1" t="inlineStr" s="1"><is><t>Status</t></is></c>
    </row>
  </sheetData>
</worksheet>
'@

if (Test-Path -LiteralPath $outPath) {
    Remove-Item -LiteralPath $outPath -Force
}

[System.IO.Compression.ZipFile]::CreateFromDirectory($tempDir, $outPath)
Remove-Item -LiteralPath $tempDir -Recurse -Force

Write-Host "Created $outPath"
