# Plantillas para objetivos y especificaciones de proyecto

Aquí tienes la propuesta de estructura para el prompt del sistema. He diseñado las plantillas de los archivos Markdown con un estándar profesional de ingeniería de software, ideal para que los agentes de GitHub Copilot comprendan el contexto sin ambigüedades.

Dado que **no has suministrado información previa sobre el proyecto** en tu mensaje, he dejado la sección de información en blanco y, justo abajo, te planteo las preguntas necesarias para completarla antes de que dispares el prompt en tu nueva sesión.

---

### [PROMPT]

```markdown
Actúa como un Arquitecto de Software y Líder Técnico experto. Tu objetivo es generar dos archivos de configuración y documentación para un nuevo proyecto: 'objetivos-proyecto.md' y 'especificaciones-proyecto.md'. 

Estos archivos se utilizarán como "Contexto Clave" (Knowledge Base) para los agentes de GitHub Copilot y Copilot Chat dentro de VS Code, por lo que deben ser extremadamente precisos, estructurados y libres de ambigüedades para que la IA genere código alineado con el proyecto.

Básate única y exclusivamente en la sección [INFORMACIÓN DEL USUARIO] provista al final. No supongas, inventes ni agregues características, dependencias o alcances que no estén explícitamente mencionados. Si la información es insuficiente para llenar un apartado obligatorio de la estructura, déjalo marcado como "[PENDIENTE: Especificar por el usuario]".

Genera los archivos con la siguiente estructura estricta:

---
# ARCHIVO 1: objetivos-proyecto.md
---

# Objetivos del Proyecto: [Nombre del Proyecto]

## 1. Visión General del Proyecto
[Breve descripción de qué es el proyecto y qué problema resuelve]

## 2. Objetivos Principales (Core Objectives)
*   **Objetivo General:** [Meta macro del proyecto]
*   **Objetivos Específicos:**
    *   [Objetivo específico 1]
    *   [Objetivo específico 2]

## 3. Alcance del Proyecto (Scope)
### 3.1. Características Incluidas (In-Scope)
*   [Característica / Módulo 1]
*   [Característica / Módulo 2]

### 3.2. Fuera de Alcance (Out-of-Scope)
*   [Elementos que explícitamente NO se desarrollarán en esta fase]

## 4. Criterios de Aceptación y Éxito
*   [Criterio 1: Ej. Cobertura de pruebas, métricas de rendimiento esperadas, o comportamiento esperado]

---
# ARCHIVO 2: especificaciones-proyecto.md
---

# Especificaciones Técnicas: [Nombre del Proyecto]

## 1. Stack Tecnológico y Entorno
*   **Lenguaje de Programación:** [Ej. Python + versión]
*   **Frameworks / Librerías Principales:** [Ej. PyTorch, PySpark, FastAPI, etc.]
*   **Gestión de Entornos / Contenedores:** [Ej. Docker, Conda, etc.]
*   **Base de Datos / Almacenamiento:** [Ej. SQL Server, PostgreSQL, etc.]

## 2. Arquitectura y Estructura del Código
### 2.1. Patrón de Diseño / Arquitectura
[Ej. Arquitectura limpia, MVC, Programación orientada a objetos, etc.]

### 2.2. Guías de Estilo y Calidad de Código
*   [Ej. Cumplimiento estricto de PEP 8, tipado estático con Mypy, etc.]

## 3. Requerimientos Funcionales y Técnicos Detallados
### 3.1. Flujo de Datos / Lógica de Negocio
[Pasos o algoritmos clave que el sistema debe ejecutar]

### 3.2. Especificaciones de Datos e Interfaces
*   **Entradas:** [Formatos de archivo, variables, o esquemas de tablas]
*   **Salidas:** [Formatos de respuestas, logs, o persistencia]

## 4. Instrucciones de Contexto para GitHub Copilot
> **Nota para el Agente de Copilot:** Al desarrollar código para este repositorio, prioriza la optimización de código en Python, el manejo estructurado de excepciones y modularidad. Asegúrate de verificar este archivo de especificaciones antes de proponer cambios estructurales.

---
Genera el contenido de ambos archivos utilizando bloques de código independientes para que puedan ser copiados y guardados fácilmente.

```

### [INFORMACIÓN DEL USUARIO]

*(Aquí debes pegar los datos del proyecto una vez respondas las preguntas de abajo).*

---

### ❓ Preguntas para estructurar los documentos

Para poder rellenar la sección **[INFORMACIÓN DEL USUARIO]** sin asumir ningún contexto, por favor ayúdame respondiendo a los siguientes puntos sobre tu nuevo proyecto:

1. **Identificación Básica:** ¿Cuál es el nombre del proyecto y qué problema o tarea principal busca resolver?
2. **Alcance:** ¿Cuáles son las funciones o módulos indispensables que debe tener el código en esta etapa? ¿Hay algo que quieras dejar por fuera explícitamente?
3. **Tecnologías:** Además de Python (si aplica), ¿qué librerías específicas (ej. PyTorch, PySpark, SQLAlchemy), bases de datos o herramientas de entorno (Docker, Conda) se van a emplear?
4. **Entradas y Salidas:** ¿Con qué tipo de datos va a interactuar el sistema? (Por ejemplo: archivos CSV, bases de datos SQL relacionales, variables matemáticas/físicas específicas, etc.) y ¿qué debe entregar como resultado?
5. **Estilo de Desarrollo:** ¿Tienes alguna preferencia sobre la arquitectura del código (ej. scripts modulares, orientación a objetos) o alguna regla matemática/técnica estricta que Copilot deba respetar?
