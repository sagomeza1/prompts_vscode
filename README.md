# Prompts para VS Code (Workflows Agénticos)

Este repositorio es una guía práctica para configurar y desplegar **entornos de trabajo agénticos** optimizados en VS Code, maximizando el uso de asistentes de IA y flujos de trabajo autónomos.

> 🗓️ **Vigencia:** contenido verificado por última vez el **2026-10-30** con GitHub Copilot Chat en VS Code. Los comandos de barra diagonal (`/`) evolucionan en cada release: si algo no coincide con tu versión, abre un issue.

---

## 📚 Qué hay en este repositorio

| Documento | Para qué sirve |
| --- | --- |
| [`guia-copilot-vscode.md`](guia-copilot-vscode.md) | **Empieza aquí si vienes de cero.** Guía técnica del ciclo completo: `/new`, `/init`, Modo Plan (`@workspace`), `/create-instructions`, Prompt Maestro interactivo y resumen de comandos. |
| [`creacion-objetivos-especificaciones-proyecto.md`](creacion-objetivos-especificaciones-proyecto.md) | Plantillas para generar `objetivos-proyecto.md` y `especificaciones-proyecto.md`. |
| [`archivos-objetivos-especificaciones.md`](archivos-objetivos-especificaciones.md) | Cómo integrar esos dos documentos como contexto en cada fase (`/new`, `/init`, Modo Plan). |
| [`instrucciones-y-prompts-para-agentes.md`](instrucciones-y-prompts-para-agentes.md) | Profundiza en la diferencia entre `/init` y `/create-instructions` y ofrece un Prompt Maestro *one-shot*. |
| [`AGENTS.md`](AGENTS.md) | Guía para agentes que editen este repositorio: reglas de edición, verificación y archivos que no se tocan. |
| [`CHANGELOG.md`](CHANGELOG.md) | Historial de cambios del repositorio. |
| [`LICENSE`](LICENSE) | CC BY 4.0: puedes reutilizar y adaptar el contenido citando la fuente. |

> 🧭 **Ruta recomendada:** `creacion-objetivos-especificaciones-proyecto.md` → `guia-copilot-vscode.md` → `archivos-objetivos-especificaciones.md` → `instrucciones-y-prompts-para-agentes.md`.

---

## 🛠️ Flujo de Implementación de un Proyecto

Para estructurar un nuevo proyecto utilizando este entorno agéntico, sigue este proceso paso a paso:

### 1. Definición de la Base Documental

Antes de interactuar con el agente, es fundamental establecer el contexto. Crea y define los siguientes archivos en la raíz de tu espacio de trabajo:

* 📂 `objetivos-proyecto.md`: Define el alcance, metas y entregables del desarrollo.
* 📂 `especificaciones-proyecto.md`: Detalla las reglas de negocio, dependencias y restricciones técnicas.

> 💡 **Guía de referencia:** para redactar correctamente estos archivos, usa las plantillas de [creacion-objetivos-especificaciones-proyecto.md](creacion-objetivos-especificaciones-proyecto.md).

---

### 2. Inicialización del Proyecto con el Agente

Una vez definidos los archivos de contexto, utiliza los comandos de barra diagonal (`/`) en la terminal o chat del asistente para estructurar el entorno:

1. **`/new`**: Utiliza este comando para indicarle al agente la creación del nuevo espacio.
2. **`/init`**: Inicializa la estructura de directorios y los archivos base del proyecto de forma automatizada.

> 📘 **Nota:** el detalle de estos comandos y cómo integrarlos con los documentos de contexto está en [archivos-objetivos-especificaciones.md](archivos-objetivos-especificaciones.md).

---

### 3. Generación de Instrucciones Específicas

Para tareas complejas o flujos de trabajo muy concretos dentro del desarrollo, puedes automatizar la creación de directivas adicionales:

* Utiliza el comando **`/create-instructions`** para generar pautas específicas que guíen al agente en tareas subsecuentes.

---

## 🚀 Buenas Prácticas

* Mantén los archivos de objetivos y especificaciones actualizados a medida que el proyecto evolucione.
* Asegúrate de que el agente tenga visibilidad completa del contexto de los archivos `.md` antes de ejecutar comandos de generación de código.
* Revisa el plan que propone el agente en Modo Plan antes de aprobar la ejecución.
* Revalida la guía cuando actualices VS Code o GitHub Copilot: los comandos y su comportamiento cambian.
* Cierra cada tarea con evidencia: verificación ejecutada y diff revisado (sección 7 de la guía).
* Si una regla no admite excepciones, no la dejes solo en el prompt: llévala a un hook, un lint o CI.

---

## ✅ Verificación

Los cambios de documentación se comprueban antes de cerrar:

```bash
bash scripts/check-links.sh
```

Valida archivos obligatorios, un solo `H1` por documento y enlaces relativos. Corre también en CI en cada push a `main` y en cada pull request.

## 📄 Licencia

Contenido bajo [Creative Commons Attribution 4.0 International (CC BY 4.0)](LICENSE). Puedes compartirlo y adaptarlo, incluso comercialmente, citando a `sagomeza1` e indicando si hubo cambios.
