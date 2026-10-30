# AGENTS.md

Guía para agentes que editen este repositorio. Es documentación en español; no hay código de aplicación.

## Qué es este repositorio

Guía práctica de trabajo agéntico con GitHub Copilot en VS Code: cómo definir el contexto de un proyecto, generar su estructura, planificar y especializar instrucciones.

## Mapa de archivos

| Archivo | Contenido |
| --- | --- |
| `README.md` | Entrada: qué hay, ruta de lectura y flujo de implementación. |
| `flujo-de-trabajo.md` | Procedimiento operativo: fases, puertas de calidad y validación del flujo. |
| `guia-copilot-vscode.md` | Guía principal: `/new`, `/init`, agente Plan, `/create-instructions`, cierre de tarea. |
| `archivos-objetivos-especificaciones.md` | Cómo integrar los documentos de contexto en cada fase. |
| `creacion-objetivos-especificaciones-proyecto.md` | Plantillas de `objetivos-proyecto.md` y `especificaciones-proyecto.md`. |
| `instrucciones-y-prompts-para-agentes.md` | Diferencia entre `/init` y `/create-instructions`. |
| `CHANGELOG.md` | Historial de cambios. |
| `LICENSE` | CC BY 4.0, texto legal canónico. |

## Reglas de edición

- Español neutro y tuteo consistente. Sin anglicismos innecesarios; los términos técnicos se dejan en su forma original.
- Un solo `H1` por archivo, secciones en `H2` y sin saltar niveles.
- Enlaces relativos entre documentos, nunca rutas absolutas.
- No dupliques contenido: si el tema ya existe en otro documento, enlázalo.
- No inventes comandos, versiones ni cifras. Si algo no está verificado, dilo explícitamente.
- Todo documento que describa comandos lleva su fecha de verificación.

## Flujo de trabajo

Antes de empezar, sigue las fases descritas en `flujo-de-trabajo.md`: alcance, contexto, especificación, plan aprobado, implementación, verificación y cierre. No empieces por la implementación.

## Verificación obligatoria

Antes de declarar terminado cualquier cambio:

```bash
bash scripts/check-links.sh
```

Comprueba que existan los archivos obligatorios, que haya un solo `H1` por documento y que no haya enlaces relativos rotoa. Si falla, el trabajo no está terminado.

En CI corre automáticamente en cada push a `main` y en cada pull request (`.github/workflows/docs-check.yml`).

## Antes de cerrar un cambio

1. Ejecuta la verificación y mira la salida.
2. Añade la entrada correspondiente en `CHANGELOG.md`.
3. Revisa el diff completo (`git diff`), no solo los archivos que tocaste.
4. Commits en español, en imperativo y con alcance claro.
5. Un pull request por tema; no mezcles correcciones con reescrituras.

## No tocar

- `LICENSE`: es el texto legal canónico de CC BY 4.0.
- No reformatees documentos completos solo por estilo; genera ruido en el diff.
- No modifiques el workflow de CI para saltarte una verificación que falla.
