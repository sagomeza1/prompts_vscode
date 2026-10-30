#!/usr/bin/env bash
# Verifica la documentación del repositorio.
# Comprueba: archivos obligatorios, un solo H1 por documento (ignorando bloques de código)
# y que no haya enlaces relativos rotoa.
set -uo pipefail
cd "$(dirname "$0")/.."

if ! command -v python3 >/dev/null 2>&1; then
  echo "ERROR: se requiere python3 para la verificación"
  exit 1
fi

python3 - <<'PY'
import os, re, sys

REQUIRED = [
    'README.md', 'AGENTS.md', 'CHANGELOG.md', 'LICENSE',
    'guia-copilot-vscode.md', 'archivos-objetivos-especificaciones.md',
    'creacion-objetivos-especificaciones-proyecto.md',
    'instrucciones-y-prompts-para-agentes.md',
]

def sin_bloques(text):
    fuera, dentro = [], False
    for linea in text.splitlines():
        if linea.lstrip().startswith('```'):
            dentro = not dentro
            continue
        if not dentro:
            fuera.append(linea)
    return '\n'.join(fuera)

errores = []

for nombre in REQUIRED:
    if not os.path.isfile(nombre):
        errores.append(f'FALTA archivo obligatorio: {nombre}')

for raiz, dirs, archivos in os.walk('.'):
    dirs[:] = [d for d in dirs if d != '.git']
    for nombre in archivos:
        if not nombre.endswith('.md'):
            continue
        ruta = os.path.join(raiz, nombre)
        texto = open(ruta, encoding='utf-8').read()
        visible = sin_bloques(texto)
        h1 = len(re.findall(r'^# ', visible, re.MULTILINE))
        if h1 != 1:
            errores.append(f'{ruta}: {h1} encabezados H1 (se espera exactamente 1)')
        for m in re.finditer(r'\]\(([^)\s]+)\)', visible):
            destino = m.group(1)
            if destino.startswith(('http://', 'https://', '#', 'mailto:')):
                continue
            local = os.path.normpath(os.path.join(raiz, destino.split('#')[0]))
            if not os.path.exists(local):
                errores.append(f'{ruta}: enlace roto -> {destino}')

if errores:
    print('\n'.join(errores))
    print('Verificación: FALLÓ')
    sys.exit(1)

print('Enlaces relativos: OK')
print('Encabezados: OK')
print('Verificación: OK')
PY
