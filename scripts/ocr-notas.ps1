param(
  [string]$Pasta = "notas",
  [string]$Saida = "textos",
  [string]$Formato = "md"
)

$root = Split-Path -Parent $PSScriptRoot
$env:INDRA_OCR_MODEL_DIR = Join-Path $root "models\indra-ocr"

if (-not (Test-Path -LiteralPath $Pasta)) {
  Write-Error "Pasta nao encontrada: $Pasta"
  exit 1
}

New-Item -ItemType Directory -Force -Path $Saida | Out-Null

$imgs = Get-ChildItem -LiteralPath $Pasta -File | Where-Object {
  $_.Extension -match '^\.(jpg|jpeg|png|tif|tiff|bmp|webp|pdf)$'
}

if ($imgs.Count -eq 0) {
  Write-Error "Nenhuma imagem ou PDF em: $Pasta"
  exit 1
}

& (Join-Path $root ".venv\Scripts\indra-ocr.exe") @($imgs.FullName) --out $Saida --format $Formato
exit $LASTEXITCODE
