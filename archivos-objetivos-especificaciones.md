# Documentos de contexto: objetivos y especificaciones

Para integrar documentos de diseño existentes como `objetivos.md` o `especificaciones.md` en el flujo de automatización con GitHub Copilot, debes utilizarlos como **fuentes de contexto primario** mediante el mecanismo de referencias de archivo (utilizando el símbolo `#` o `@file` en la interfaz de chat).

A continuación, se detalla la estrategia de ingeniería de prompts para acoplar estos archivos a los comandos `/new`, `/init` y al agente Plan (`/plan`) de manera efectiva.

---

## Flujo de Contexto con Archivos Locales

```text
[objetivos.md / especificaciones.md]
                 │
                 ├───> Combinado con [/new] ───> Scaffolding alineado al negocio
                 │
                 └───> Combinado con [/init] ──> Gobernanza técnica adaptada al alcance

```

---

## 1. Con el comando `/new` (Generación del Scaffolding)

Si vas a inicializar el proyecto y ya tienes estos archivos creados en una carpeta temporal o en la raíz, debes forzar a Copilot a que lea su contenido para que la estructura de carpetas propuesta refleje las necesidades reales del negocio y no un esqueleto genérico.

### Técnica de Prompting

Invoca el comando e indexa los archivos usando `#` (o arrastrándolos al contexto del chat).

```text
/new Lee #objetivos.md y #especificaciones.md. Genera la estructura de directorios y el scaffolding inicial del proyecto en Python basándote estrictamente en el alcance, los módulos de software y el stack tecnológico descritos en dichos documentos. Asegúrate de incluir los archivos de configuración requeridos por las especificaciones.

```

---

## 2. Con el comando `/init` (Gobernanza Global)

El objetivo de `.github/copilot-instructions.md` es guiar el comportamiento de la IA a largo plazo. Al cruzar las reglas de desarrollo (como PEP 8) con tus especificaciones funcionales, logras que Copilot entienda no solo *cómo* programar, sino *qué restricciones de dominio* debe respetar siempre.

### Técnica de Prompting

Utiliza los documentos para extraer métricas de éxito o restricciones arquitectónicas globales (por ejemplo, latencia máxima, uso de una base de datos específica o cumplimiento de normativas).

```text
/init Genera el archivo .github/copilot-instructions.md para este espacio de trabajo. Utiliza la información de #objetivos.md y #especificaciones.md para establecer las reglas del negocio globales. Añade restricciones de arquitectura basadas en las especificaciones (por ejemplo, manejo de volumen de datos o librerías obligatorias) y combínalas con estándares de código limpio (PEP 8, tipado estricto).

```

---

## 3. Con el Agente Plan (`/plan`)

Esta es la integración más potente. Aunque el agente indexa el workspace por su cuenta, puede pasar por alto detalles minuciosos de los archivos de texto. Referenciarlos explícitamente con `#file` o `#codebase` obliga al modelo a validar cruzado antes de proponer el plan de ejecución. Al referenciarlos explícitamente, obligas al modelo a realizar una validación cruzada antes de proponer el plan de ejecución.

### Técnica de Prompting

```text
/plan Diseña la lógica del primer hito técnico. Revisa detalladamente #especificaciones.md para asegurar que los requerimientos funcionales del módulo 'data_ingestion' se cumplan al 100%. Genera el plan de archivos y funciones necesarias, contrastando tu propuesta contra las metas descritas en #objetivos.md antes de escribir cualquier línea de código.

```

---

## Buenas Prácticas de Contexto

* **Prioridad de Documentos:** Si ambos documentos entran en contradicción, especifica en tu prompt cuál tiene mayor jerarquía: *"En caso de conflicto en los requerimientos, prioriza lo dictado en #especificaciones.md"*.
* **Ubicación Inicial:** Coloca `objetivos.md` y `especificaciones.md` en la raíz del espacio de trabajo antes de abrir el chat de Copilot. Esto garantiza que la indexación local de VS Code los reconozca inmediatamente al usar el comando `#`.
* **Actualización Dinámica:** Si las especificaciones cambian a mitad del proyecto, actualiza el archivo físico y vuelve a pedírselo al agente Plan (`/plan`) para que re-evalúe el código existente frente a la nueva versión del documento.
