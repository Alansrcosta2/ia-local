$root = Split-Path -Parent $PSScriptRoot
$env:INDRA_OCR_MODEL_DIR = Join-Path $root "models\indra-ocr"
& (Join-Path $root ".venv\Scripts\indra-ocr.exe") @args
exit $LASTEXITCODE
