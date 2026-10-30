# Changelog

Todos los cambios notables de este repositorio se documentan en este archivo.

El formato se basa en [Keep a Changelog](https://keepachangelog.com/es-ES/1.1.0/),
y este proyecto usa un versionado simple por fecha dado que es una guía de
consulta en evolución continua, no un paquete de software versionado.

## [Unreleased]

### Added
- `AGENTS.md` — guía para agentes: mapa del repositorio, reglas de edición, verificación obligatoria y archivos que no se tocan.
- `guia-copilot-vscode.md` — nueva sección 7 "Cierre de tarea": verificación con evidencia, revisión del diff, permisos y sandbox, y separación entre reglas deterministas y preferencias.
- `scripts/check-links.sh` — verificador local de archivos obligatorios, encabezados H1 y enlaces relativos.
- `.github/workflows/docs-check.yml` — ejecuta la verificación en CI en cada push a `main` y en cada pull request.
- `flujo-de-trabajo.md` — procedimiento operativo del repositorio: siete fases, puertas de calidad, dos velocidades de trabajo y registro de validación con evidencia (2026-10-30).
- `README.md` — sección de verificación y referencia a `AGENTS.md`.
- `LICENSE` — se adopta Creative Commons Attribution 4.0 International (CC BY 4.0) para el contenido del repositorio.
- `CHANGELOG.md` — este archivo, para llevar registro de cambios relevantes en la guía.
- `README.md` — mapa de documentos y ruta de lectura recomendada.
- Nota de vigencia con fecha de última verificación en `README.md`, `guia-copilot-vscode.md` e `instrucciones-y-prompts-para-agentes.md`.

### Changed
- Se fusionaron `guia.md` y `guia-copilot-vscode.md` (contenido redundante) en un único documento: `guia-copilot-vscode.md`. Ver PR #1.
- `LICENSE` ahora contiene el texto legal canónico de CC BY 4.0, para que GitHub detecte la licencia automáticamente.
- `README.md`: se corrige el enlace cuyo texto no coincidía con el archivo destino y se unifica la nomenclatura a `especificaciones-proyecto.md`.
- `instrucciones-y-prompts-para-agentes.md`: jerarquía de encabezados corregida (de H1 a H2 para las secciones internas) y retitulado del Prompt Maestro como *one-shot*.
- `guia-copilot-vscode.md`: el Prompt Maestro se distingue explícitamente como interactivo y se referencia al *one-shot*.

### Fixed
- Enlaces internos del `README.md` que apuntaban a un documento distinto del que anunciaba su texto.
- `archivos-objetivos-especificaciones.md` y `creacion-objetivos-especificaciones-proyecto.md`: se añade el H1 que faltaba para cumplir la convención de un solo título por documento.

### Removed
- `guia.md` — contenido incorporado a `guia-copilot-vscode.md`.

## [2026-07-06] - Versión inicial

### Added
- `README.md` — flujo de implementación de un proyecto con el entorno agéntico (`/new`, `/init`, `/create-instructions`).
- `guia-copilot-vscode.md` — guía de creación y desarrollo de proyectos con GitHub Copilot.
- `guia.md` — guía técnica alternativa del ciclo de vida del proyecto con Copilot.
- `archivos-objetivos-especificaciones.md` — cómo integrar `objetivos.md`/`especificaciones.md` como contexto para Copilot.
- `creacion-objetivos-especificaciones-proyecto.md` — plantillas para generar `objetivos-proyecto.md` y `especificaciones-proyecto.md`.
- `instrucciones-y-prompts-para-agentes.md` — diferencias entre `/init` y `/create-instructions`, y meta-prompt generador de ambos.
