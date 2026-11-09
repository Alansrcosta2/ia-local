# ia-local

Ambiente local de OCR com Indra OCR e modelos salvos no proprio repositorio.
Roda em CPU, sem GPU e sem PyTorch.

## Estrutura

```
ia-local\
├── .venv\                 Python 3.11 + indra-ocr (nao versionado)
├── models\indra-ocr\      Pesos ONNX (~97 MB, versionados)
├── scripts\
│   ├── ocr.ps1            OCR de um arquivo ou varios
│   └── ocr-notas.ps1      OCR em lote de uma pasta
├── textos\                Saidas (nao versionado)
└── notas\                 Imagens de entrada (nao versionado)
```

Notas, cupons e textos gerados **nunca** vao para o Git: `notas/`, `textos/` e
`exemplos/` estao no `.gitignore`.

## Uso

Um arquivo ou varios:

```powershell
.\scripts\ocr.ps1 caminho\da\nota.jpg
.\scripts\ocr.ps1 caminho\da\nota.jpg --format json
.\scripts\ocr.ps1 nota1.jpg nota2.jpg --out textos\
```

Lote de uma pasta (padrao: `notas` -> `textos`):

```powershell
.\scripts\ocr-notas.ps1 -Pasta notas -Saida textos -Formato md
.\scripts\ocr-notas.ps1 -Pasta notas -Formato text
```

Viewer local em http://localhost:8765:

```powershell
.\.venv\Scripts\indra-ocr-viewer.exe
```

Os scripts definem `INDRA_OCR_MODEL_DIR=models\indra-ocr`, entao os modelos
locais sao usados sem baixar do Hugging Face.

## Instalar do zero

```powershell
python -m venv .venv
.\.venv\Scripts\python.exe -m pip install indra-ocr
.\.venv\Scripts\python.exe -c "from huggingface_hub import snapshot_download; snapshot_download('datalab-to/indra-ocr', local_dir='models/indra-ocr')"
```

## Formatos de saida

- `--format md` (padrao): markdown com titulos, listas e tabelas
- `--format text`: texto puro, uma linha por linha detectada
- `--format json`: linhas, caixas (bbox), blocos de layout e confiancas

## Licencas

- Codigo do Indra OCR: Apache 2.0
- Pesos do modelo: OpenRAIL-M modificada (uso pessoal e pesquisa liberados;
  startups ate US$ 20M de receita/financiamento). Veja `models/indra-ocr/LICENSE`.

Fonte: https://github.com/datalab-to/indra e https://huggingface.co/datalab-to/indra-ocr
