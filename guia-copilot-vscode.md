# Guía Técnica: Automatización del Ciclo de Vida del Proyecto con GitHub Copilot en VS Code

Esta guía unifica el flujo de trabajo secuencial y avanzado para inicializar, estructurar, desarrollar y gobernar un proyecto de software o ciencia de datos utilizando las capacidades de agente y comandos de barra diagonal (`/`) en GitHub Copilot para VS Code, junto con plantillas de prompts listas para usar en cada fase.

> 🗓️ **Vigencia:** verificada por última vez el **2026-10-30**. Los comandos de Copilot Chat cambian entre releases de VS Code; si detectas una diferencia con tu versión, abre un issue.

---

## Flujo de Trabajo Secuencial

```text
[0. Planificación] ──> [1. /new] ─────────> [2. /init] ─────────> [3. /plan] ─────────────> [4. /create-instructions]
Alcance y            Scaffolding          Instrucciones         Lógica de Negocio         Especialización
Requisitos           Inicial              de workspace          (agente Plan)             Subcarpetas (applyTo)
```

### Paso 0: Definición del Alcance y Requisitos

Antes de escribir código o interactuar con la IA, define el objetivo del proyecto, el lenguaje de programación principal (ej. Python), las librerías clave y la arquitectura general. Si ya cuentas con documentos de contexto (`objetivos-proyecto.md`, `especificaciones-proyecto.md`), consulta [archivos-objetivos-especificaciones.md](archivos-objetivos-especificaciones.md) para integrarlos al flujo.

---

## 1. `/new` | Generación de la Estructura Base (Scaffolding)

El comando `/new` en Copilot Chat permite estructurar un proyecto completo desde cero, generando directorios y archivos de configuración iniciales basados en un stack tecnológico específico.

### Propósito Técnico

Configurar el esqueleto (*scaffolding*) del proyecto evitando la creación manual de directorios y la configuración repetitiva de archivos base (`README.md`, `.gitignore`, `requirements.txt`, etc.).

### Cómo funciona

Le indicas a Copilot qué tipo de aplicación deseas (puede invocarse también como `/newNotebook` para notebooks) y este te sugerirá una estructura completa de carpetas y archivos. Puedes previsualizarlos y, con un solo botón (`Create Workspace`), Copilot los creará físicamente en disco y abrirá la nueva ventana de VS Code.

### Ejemplo de Prompt para Copilot Chat

```text
@workspace /new Crea un proyecto de Ciencia de Datos en Python utilizando POO y PEP 8. Debe incluir una carpeta 'src' con subcarpetas para 'data_ingestion', 'models' y 'utils', una carpeta 'tests' con la configuración de pytest, un archivo 'main.py' como punto de entrada, un '.gitignore' para Python y un 'requirements.txt' con dependencias clave como pandas, scikit-learn y mlflow.
```

---

## 2. `/init` | Instrucciones Persistentes del Workspace

Una vez generada la estructura, `/init` en Copilot Chat **genera o actualiza las instrucciones del workspace** en una sesión de agente local. No es un instalador de entorno: no crea `Dockerfile`, ni `.gitignore`, ni `.vscode/settings.json`.

### Propósito Técnico

Producir el archivo de instrucciones persistentes (`.github/copilot-instructions.md`; también se soporta `AGENTS.md`) para que cualquier interacción posterior respete el stack, idioma y estándares definidos.

### Cómo funciona

Analiza el código y los documentos del workspace y propone un archivo de instrucciones que puedes revisar y editar antes de aceptarlo. Para configuraciones de entorno (Docker, linters, ajustes de VS Code), pídeselas al agente en un prompt normal: ya no son parte de `/init`.

> ⚠️ **Cambio respecto a versiones anteriores:** `/init` se describía como inicializador de configuraciones del entorno. Hoy su alcance es exclusivamente las instrucciones del workspace.

### Ejemplo de Prompt para Copilot Chat

```text
/init Genera un archivo de gobernanza global para el espacio de trabajo en .github/copilot-instructions.md. Especifica que el idioma oficial del código y documentación es inglés, que todo el código Python debe cumplir estrictamente con PEP 8, que se prefiere la programación funcional sobre el estado mutable cuando sea posible, y que todas las funciones deben incluir type hints y docstrings en formato Google.
```

---

## 3. Agente Plan (`/plan`) | Desarrollo Estructurado de la Lógica de Negocio

El **agente Plan** divide la ejecución del código en dos fases críticas: **Planificación** y **Ejecución**. Se invoca con `/plan` en el chat o seleccionando **Plan** en el selector de agentes.

> ⚠️ **`@workspace` está deprecado.** Los *chat participants* ya no están soportados en el harness Copilot. El agente ve el workspace por sí mismo; si necesitas dirigir el contexto, adjúntalo con `#codebase`, `#file` o `#folder`. En versiones antiguas esto se hacía con `@workspace`.

### Flujo de Aprobación y Ejecución

1. **Fase de Planificación:** el agente analiza el espacio de trabajo, interpreta el requerimiento y propone una lista secuencial de cambios detallando qué archivos se crearán o modificarán.
2. **Revisión del Usuario:** el desarrollador evalúa el plan propuesto, solicita ajustes si es necesario y otorga su aprobación explícita.
3. **Fase de Ejecución:** con la aprobación dada, el agente procede a implementar el código de manera iterativa, aplicando refactorizaciones y solicitando confirmación al finalizar el bloque de tareas.

### Ejemplo de Prompt para el Agente (`/plan`)

```text
/plan Diseña e implementa el módulo de 'data_ingestion' en 'src/data_ingestion/'. Necesito una clase 'DataDownloader' que descargue archivos CSV desde una URL, maneje excepciones de conexión mediante reintentos exponenciales y guarde el archivo en 'data/raw/'. Muestra primero el plan de archivos antes de escribir el código.
```

---

## 4. `/create-instructions` | Segmentación y Especialización mediante `applyTo`

Para proyectos de gran envergadura, las reglas globales no son suficientes. El comando `/create-instructions` genera archivos de instrucciones (`.github/instructions/**/*.instructions.md`) específicos para directorios determinados dentro del repositorio.

> ⚠️ Disponible solo en **sesiones de agente Local**. En el harness Copilot no aparece; allí se usan `/prompts` y `/hooks`.

### Propósito Técnico

Definir directrices persistentes de estilo, diseño y arquitectura que Copilot respeta solo dentro del alcance indicado, evitando que reglas de un dominio contaminen a otro (por ejemplo, reglas de frontend afectando al backend).

### El Campo `applyTo` y Glob Patterns

| Glob Pattern | Significado Técnico | Caso de Uso |
| --- | --- | --- |
| `src/models/**` | Aplica a cualquier archivo o subcarpeta dentro de `src/models/`. | Reglas de entrenamiento de modelos ML. |
| `tests/**/*.py` | Aplica a todos los archivos `.py` dentro de la carpeta `tests/`. | Reglas de aserciones y mocks para testing. |
| `src/utils/*.py` | Aplica únicamente a archivos `.py` en la raíz de `src/utils/` (sin recursividad). | Estándares de funciones utilitarias puras. |

### Ejemplo de Prompt para Copilot Chat

```text
/create-instructions Genera un archivo de instrucciones específico para la carpeta 'src/models/'. Usa el campo 'applyTo' configurado para 'src/models/**'. Las reglas deben exigir que cualquier modelo de Machine Learning implementado use tracking de experimentos con MLflow, valide las dimensiones de los tensores/matrices de entrada mediante aserciones, y maneje semillas aleatorias (random_state) fijas para garantizar la reproducibilidad.
```

---

## 5. Prompt Maestro (interactivo) | Diseñador de Prompts

Cuando no tengas claro cómo formular el prompt ideal para `/new` o `/init`, copia y pega este meta-prompt en Copilot Chat (o en tu LLM preferido) para que te guíe con preguntas antes de generar el resultado final.

> 🔀 **No lo confundas** con el Prompt Maestro *one-shot* de [instrucciones-y-prompts-para-agentes.md](instrucciones-y-prompts-para-agentes.md): este **pregunta antes de responder**; aquel parte de unas especificaciones que ya tienes escritas. Usa el interactivo si vienes de cero y el one-shot si ya sabes qué quieres construir.

```text
Actúa como un Ingeniero de Prompts experto en desarrollo de software y GitHub Copilot.

Tu objetivo es ayudarme a diseñar el prompt ideal de inicialización de proyecto para usar con los comandos '/new' o '/init' de Copilot en VS Code.

Para lograrlo, debes seguir estas reglas estrictas:
1. NO asumas ninguna información sobre mi proyecto (como el lenguaje, la arquitectura, la base de datos o las librerías a usar).
2. Hazme preguntas detalladas una por una o en un bloque organizado para recopilar todo el contexto necesario.
3. Las preguntas deben cubrir:
   - Objetivo principal del proyecto.
   - Lenguaje de programación, framework y versión preferida.
   - Patrón de arquitectura de software deseado (ej. modular, MVC, DDD, microservicios).
   - Estilo de código o estándares requeridos (ej. PEP 8 para Python).
   - Librerías clave o dependencias críticas.
   - Requisitos de entorno de desarrollo (ej. Docker, entorno virtual, soporte para Notebooks).
4. Una vez recopilada la información, entrégame dos outputs claros:
   - Opción A: Un prompt optimizado listo para usar con '/new' para crear el espacio de trabajo.
   - Opción B: Un prompt optimizado listo para usar con '/init' (o instrucciones complementarias) para configurar el entorno y dependencias.

Por favor, comienza haciéndome las preguntas necesarias de manera clara y directa.
```

### Ejemplo Práctico con Información Mínima

A continuación, se simula cómo interactuar con el Prompt Maestro utilizando los requisitos mínimos para un proyecto de ciencia de datos.

**Información mínima proporcionada por el usuario:**

- **Objetivo:** crear un pipeline básico de Machine Learning para entrenar un modelo de clasificación con el dataset Iris.
- **Lenguaje:** Python.
- **Restricciones de estilo:** seguir estrictamente PEP 8.

**Resultado generado por el Prompt Maestro:**

#### A. Prompt optimizado para `/new` (Estructura del Proyecto)

```text
/new Crea un proyecto modular de Python para un pipeline de Machine Learning (clasificación con el dataset Iris). Estructura el proyecto con la siguiente arquitectura:
- Una carpeta 'src' que contenga módulos para:
  - 'data_ingestion.py' (para cargar los datos).
  - 'features.py' (para preprocesamiento y escalado).
  - 'model.py' (para entrenar y evaluar un modelo RandomForestClassifier).
- Una carpeta 'tests' para pruebas unitarias básicas.
- Un script principal 'main.py' en la raíz que orqueste todo el flujo.
Todo el código de Python debe seguir estrictamente la guía de estilo PEP 8, usar anotaciones de tipo (type hinting) y funciones documentadas.
```

#### B. Prompt optimizado para `/init` (Instrucciones del Workspace)

```text
/init Genera el archivo de instrucciones del workspace. Además, en el mismo prompt, pide los archivos de configuración iniciales para este proyecto de Python:
1. Un archivo 'requirements.txt' que incluya las versiones estables más recientes de scikit-learn, pandas, numpy y pytest.
2. Un archivo '.gitignore' estándar optimizado para Python (que ignore .venv, __pycache__, .pytest_cache y archivos .pyc).
3. Una guía de estilo básica para el linter de VS Code en '.vscode/settings.json' que configure el formateador 'black' o 'autopep8' al guardar.
```

#### C. Prompt para generación de reglas persistentes (`/create-instructions`)

```text
/create-instructions Genera directrices para el desarrollo de este proyecto de Machine Learning. Especifica que todo código nuevo generado debe:
- Ser compatible con Python 3.10+.
- Cumplir con PEP 8.
- Implementar manejo de excepciones robusto, especialmente en la lectura de datos.
- Separar la lógica de negocio (entrenamiento del modelo) de la interfaz de consola o script principal.
```

---

## 7. Cierre de Tarea | Verificación, Revisión y Permisos

El flujo no termina cuando el agente dice que terminó. Termina cuando hay evidencia de que terminó bien.

### 7.1 Verificación: sin salida verde no hay tarea cerrada

- Define **un comando único** que ejecute pruebas, linter y chequeo de tipos. Si el proyecto no lo tiene, la primera tarea del agente es crearlo.
- El agente debe **pegar la salida real** del comando. "Debería funcionar" no es verificación.
- Si la verificación falla, el trabajo sigue abierto: no se entrega con la promesa de arreglarlo después.
- En este repositorio el comando es `bash scripts/check-links.sh`.

### 7.2 Revisión del diff antes de mergear

Checklist corta, en este orden:

1. **Alcance** — ¿el cambio se limita a lo pedido? Archivos que nadie pidió tocar son una señal de alarma.
2. **Evidencia** — ¿hay prueba o verificación que respalde el cambio?
3. **Dependencias** — ¿aparecieron librerías nuevas sin justificar?
4. **Secretos** — ¿se colaron credenciales, tokens o rutas locales?
5. **Archivos protegidos** — ¿se tocaron archivos generados o `LICENSE` sin motivo?
6. **Mensaje de commit** — ¿explica el porqué, no solo el qué?

### 7.3 Permisos y sandbox

**Requieren aprobación explícita del humano:**

- borrar o mover archivos fuera del alcance de la tarea
- reescribir historia (`git push --force`) o empujar directo a `main`
- instalar dependencias o ejecutar migraciones de datos
- cualquier comando de red que use credenciales

**Prohibido por defecto:**

- escribir credenciales en prompts, código o configuración versionada
- desactivar checks de CI para que pase un cambio
- ejecutar un comando que no se ha leído entero

Para trabajo autónomo largo, usa un **worktree o contenedor por tarea**: el agente experimenta sin tocar el árbol de trabajo principal.

### 7.4 Lo determinista no se escribe en Markdown

Un archivo de instrucciones es contexto, no un mecanismo de control: el modelo puede saltárselo. Si una regla no admite excepciones, se impone en el arnés.

| Tipo de regla | Dónde se impone |
| --- | --- |
| Preferencia de estilo o criterio | `AGENTS.md` o instrucciones del workspace |
| "Nunca toques `src/generated/**`" | hook previo a la herramienta o regla de lint |
| "Los tests deben pasar antes de cerrar" | CI obligatorio en la rama |
| "No instales dependencias sin aprobación" | permiso del agente o revisión obligatoria |

> 💡 Regla práctica: si al escribirla piensas "esto tiene que cumplirse siempre", no la dejes en el prompt.

---

## Resumen de Comandos y Herramientas

| Comando / Modo | Fase del Proyecto | Salida Principal |
| --- | --- | --- |
| `/new` | Inicialización | Estructura de directorios y archivos base del proyecto. |
| `/init` | Configuración | Instrucciones del workspace (`.github/copilot-instructions.md` o `AGENTS.md`). |
| `/plan` (agente Plan) | Desarrollo Activo | Implementación guiada, iterativa y segura de la lógica de negocio. |
| `/create-instructions` | Optimización / Escala | Reglas contextuales por carpeta (`applyTo`) en `.github/instructions/**`. |

---

## 6. Mapa de Comandos Vigentes (verificado 2026-10-30)

La lista real depende del *surface* (Chat view, editor, CLI), del *harness* y de tu plan. Escribe `/` en el chat para ver la tuya. Estos son los comandos documentados hoy:

**Flujo y estructura del proyecto**

| Comando | Qué hace |
| --- | --- |
| `/new`, `/newNotebook` | Crea el scaffolding de un workspace, archivo o notebook. |
| `/plan` | Investiga y propone un plan de implementación. |
| `/init` | Genera o actualiza las instrucciones del workspace (sesión de agente local). |
| `/create-instructions` | Genera una personalización `.instructions.md` con `applyTo` (sesión local). |
| `/create-agent`, `/create-skill`, `/create-prompt`, `/create-hook` | Generan esa personalización concreta. |
| `/agents`, `/instructions`, `/skills`, `/prompts`, `/hooks` | Abren el editor de la personalización correspondiente. |

**Desarrollo diario**

| Comando | Qué hace |
| --- | --- |
| `/explain`, `/fix`, `/tests` | Explican código, proponen una corrección o generan pruebas. |
| `/doc` | Genera comentarios de documentación desde el chat inline del editor. |
| `/setupTests` (experimental) | Ayuda a elegir y configurar un framework de pruebas. |

**Sesión y diagnóstico**

| Comando | Qué hace |
| --- | --- |
| `/clear` | Empieza un chat nuevo y archiva el actual. |
| `/compact` | Compacta el contexto de la conversación. |
| `/fork` | Bifurca la conversación conservando su historial. |
| `/rename <nombre>`, `/help` | Renombra el chat o lista comandos y agentes. |
| `/models`, `/tools` | Abren el selector de modelo o la configuración de herramientas. |
| `/troubleshoot`, `/debug`, `/sandbox` | Analizan logs del agente, abren la vista de depuración o inspeccionan la política de sandbox. |
| `/<nombre>` | Invoca una skill o un prompt reutilizable por su nombre. |

> ⛔ **Retirado:** `@workspace` y el resto de *chat participants* (`@vscode`, `@terminal`, `@github`). No están soportados en el harness Copilot; su función la cubren el agente y las menciones `#codebase`, `#file`, `#folder`.

> Ver también [instrucciones-y-prompts-para-agentes.md](instrucciones-y-prompts-para-agentes.md) para la diferencia detallada entre `/init` y `/create-instructions`, y [creacion-objetivos-especificaciones-proyecto.md](creacion-objetivos-especificaciones-proyecto.md) para plantillas de documentos de contexto previos.
