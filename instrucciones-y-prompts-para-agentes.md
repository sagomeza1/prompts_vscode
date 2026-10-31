# Guía de Configuración de Agentes y Plantillas de Prompts para VS Code

Esta guía detalla cómo sacar el máximo provecho a los comandos de inicialización de entornos agénticos en GitHub Copilot y proporciona un generador de prompts especializado para automatizar la creación de tus reglas de espacio de trabajo.

> 🗓️ **Vigencia:** verificada por última vez el **2026-10-30**. Complementa la sección 4 de [guia-copilot-vscode.md](guia-copilot-vscode.md), que cubre el mismo tema desde el flujo completo del proyecto.

## 1. Sugerencias de Uso para ``/init`` y ``/create-instructions``

Ambos comandos sirven para automatizar la creación de directrices dentro de tu espacio de trabajo, pero tienen propósitos y alcances muy distintos:

### Comando ``/init`` (Instrucciones del Workspace)

Se utiliza al inicio del ciclo de vida del proyecto o cuando cambian las reglas del workspace. Su objetivo es generar o actualizar el archivo maestro de instrucciones (``.github/copilot-instructions.md``, o ``AGENTS.md``). No crea estructura de directorios ni archivos de entorno: eso se le pide al agente en un prompt aparte.

- **Sugerencia de enfoque**: No le pidas detalles de implementación de lógica de negocio. En su lugar, utilízalo para definir el **Stack Tecnológico**, la **Arquitectura del Software**, las **Reglas de Estilo de Código** y las **Restricciones Generales** (por ejemplo, prohibir ciertas librerías obsoletas).

- **Ejemplo de comando efectivo**:

    ``/init para un backend en Go utilizando Clean Architecture, PostgreSQL con gorm, y Docker para contenedores. Define reglas estrictas para el manejo de errores idiomáticos y logging con Zap.``

### Comando ``/create-instructions`` (Instrucciones Contextuales)

Crea archivos ``.instructions.md`` dentro de subcarpetas o para módulos específicos del repositorio, limitando su alcance mediante metadatos (como ``applyTo``). Vive en ``.github/instructions/**/*.instructions.md`` y solo está disponible en sesiones de agente **Local**.

- **Sugerencia de enfoque**: Utilízalo para automatizar flujos de trabajo repetitivos, políticas de testing para un framework concreto, o integraciones específicas de APIs. Sé extremadamente específico con los directorios donde debe actuar.

- **Ejemplo de comando efectivo**:

    ``/create-instructions para la carpeta /tests utilizando pytest y bases de datos mockeadas con pytest-mock. Configura reglas de aislamiento de base de datos para que aplique solo a archivos *.test.py.``

## 2. Prompt Maestro *one-shot* para Nueva Sesión

Copia y pega el siguiente bloque en una nueva sesión de chat de Copilot cuando desees que la IA diseñe a medida los dos prompts de inicialización para un nuevo proyecto:

```
[Actúa como un ingeniero de prompts experto en GitHub Copilot y desarrollo agéntico en VS Code. Tu tarea es redactar dos prompts altamente detallados, estructurados y optimizados basados estrictamente en las indicaciones que te proporciono en la sección de especificaciones. 

El primer prompt debe estar diseñado exclusivamente para ser utilizado con el comando '/init', enfocándose en establecer las directrices globales, arquitectura, estándares de calidad y stack técnico del espacio de trabajo. 

El segundo prompt debe estar diseñado para el comando '/create-instructions', enfocándose en reglas contextuales, dinámicas o locales (como políticas de testing específicas, manejo de estado o componentes UI específicos de un subdirectorio). 

Escribe ambos prompts resultantes dentro de bloques de código Markdown con instrucciones claras de uso y asegúrate de que aprovechen el formato YAML Frontmatter cuando corresponda.]

[Aquí debes escribir de forma detallada qué es lo que quieres desarrollar. Por ejemplo: "Quiero desarrollar una plataforma de e-commerce utilizando Next.js 14 App Router, TypeScript, Tailwind CSS y Stripe para pagos. El proyecto debe seguir principios de arquitectura de carpetas modular, tipado estricto sin usar 'any', accesibilidad web WCAG AA, y pruebas unitarias con Jest en la carpeta /components."]
```

## 3. Ejemplo Práctico de Salida Esperada

Si ejecutas el prompt anterior con las indicaciones de la plataforma de e-commerce, el agente te devolverá dos instrucciones optimizadas similares a estas:

Para `/init`:

```
/init para una plataforma de e-commerce usando Next.js 14 (App Router), TypeScript, Tailwind CSS y Stripe. Configura directrices de Arquitectura de Carpetas Modular, prohíbe el uso de 'any' para garantizar tipado estricto, y establece que todos los componentes interactivos deben cumplir con los estándares de accesibilidad WCAG AA.
```


Para `/create-instructions`:

```
/create-instructions para la carpeta /components. Configura un archivo de instrucciones que aplique a "components/**/*.tsx" enfocado en pruebas unitarias con Jest y React Testing Library, exigiendo que cada componente interactivo tenga cobertura de pruebas de renderizado, accesibilidad y eventos de usuario.
```
