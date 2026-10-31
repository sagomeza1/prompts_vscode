# Flujo de trabajo del repositorio

Procedimiento operativo para encargar, ejecutar y cerrar cambios en este repositorio. Sirve igual para una persona y para un agente: las fases son las mismas y cada una tiene una salida verificable.

> 🗓️ **Vigencia:** validado el **2026-10-30**. El registro de las pruebas está en la sección 6.

---

## 1. Roles

| Rol | Decide |
| --- | --- |
| Humano | Alcance, aprobación del plan, revisión del diff y merge. |
| Agente | Propone plan, implementa, ejecuta la verificación y prepara el cierre. |

El agente no aprueba su propio trabajo: puede verificar y proponer, pero el merge lo decide el humano.

---

## 2. Las siete fases

### 0. Entrada
La petición debe traer dos cosas: **qué cambia** y **cómo se comprueba**. Si falta la segunda, la primera tarea es escribirla.

### 1. Contexto
Leer `AGENTS.md`, el `README.md` y el documento afectado. Comprobar la rama actual y que el árbol esté limpio.

**Salida:** lista de archivos que se van a tocar.

### 2. Especificación
Si el cambio altera contenido (no solo estilo), decir qué sección y qué queda fuera. Lo que no se escribe aquí, no se hace.

**Salida:** criterio de aceptación en una frase verificable.

### 3. Plan
Proponer el cambio como pasos con archivos concretos. **Requiere aprobación explícita** si toca más de dos documentos, `LICENSE` o el workflow de CI.

**Salida:** plan aprobado.

### 4. Implementación
Cambios pequeños y con un solo tema por rama. Nada de reformateos masivos ni cambios de estilo colados en una corrección.

**Salida:** diff acotado.

### 5. Verificación
```bash
bash scripts/check-links.sh
```
Debe salir `Verificación: OK`. Si falla, el trabajo sigue abierto. Después, revisión del diff con la checklist de la sección 7.2 de la guía.

**Salida:** salida del comando pegada en la conversación.

### 6. Cierre
Entrada en `CHANGELOG.md`, commit en imperativo y, si aplica, pull request. El merge lo decide el humano tras revisar el diff.

**Salida:** commit publicado y PR abierto.

---

## 3. Puertas de calidad

| Puerta | Cuándo | Quién | Evidencia |
| --- | --- | --- | --- |
| Alcance definido | Antes de tocar nada | Humano | Una frase de qué cambia y cómo se comprueba |
| Plan aprobado | Cambios estructurales | Humano | Plan escrito en la conversación |
| Verificación verde | Antes de commitear | Agente | Salida de `check-links.sh` |
| Diff revisado | Antes de mergear | Humano | Checklist de 6 puntos |
| CI en verde | Al abrir el PR | Automático | Estado del check `docs-check` |

---

## 4. Dos velocidades

**Flujo corto** — corrección de enlace, errata, fecha: rama, cambio, verificación, commit.

**Flujo con PR** — contenido nuevo, cambio de estructura, CI o `LICENSE`: plan aprobado, rama, verificación, PR y revisión humana.

Si dudas de en cuál estás, estás en el segundo.

---

## 5. Checklist para copiar en cada tarea

- [ ] Alcance y criterio de aceptación escritos.
- [ ] Archivos afectados identificados.
- [ ] Plan aprobado (si aplica).
- [ ] Cambios acotados a un tema.
- [ ] `bash scripts/check-links.sh` en verde.
- [ ] Diff revisado completo, no solo los archivos tocados.
- [ ] `CHANGELOG.md` actualizado.
- [ ] Commit en imperativo.
- [ ] PR abierto y CI en verde.

---

## 6. Validación del flujo (2026-10-30)

El flujo se probó sobre una copia temporal del repositorio, con el verificador real. No son afirmaciones: es la salida observada.

| # | Prueba | Esperado | Observado | Resultado |
| --- | --- | --- | --- | --- |
| A | Árbol intacto | Pasa | `Enlaces relativos: OK` / `Encabezados: OK` / exit 0 | ✅ |
| B | Enlace relativo roto en `README.md` | Falla y lo nombra | `./README.md: enlace roto -> no-existe.md` / exit 1 | ✅ |
| C | Segundo `H1` en `README.md` | Falla y lo nombra | `./README.md: 2 encabezados H1` / exit 1 | ✅ |
| D | `LICENSE` eliminado | Falla y lo nombra | `FALTA archivo obligatorio: LICENSE` / exit 1 | ✅ |
| E | YAML del workflow | Disparadores y job correctos | triggers `push`, `pull_request`; job `verificar`; `run: bash scripts/check-links.sh` | ✅ |
| F | Estado restaurado | Pasa de nuevo | `Verificación: OK` / exit 0 | ✅ |

Cada prueba se ejecutó en `/tmp/flowtest`, una copia del árbol, y los cambios se revirtieron con `git checkout`. La rama de trabajo no se ensució.

### Ejecución real en CI

El workflow ya corrió en los runners de GitHub sobre `main`: dos ejecuciones `push`, ambas con conclusión **success** (`41152177163` y `41152210527`, 2026-10-31T00:48-00:49Z). Con eso queda cerrada la única puerta que faltaba comprobar de punta a punta.

### Qué queda fuera de esta validación
- **Enlaces externos**: solo se comprueban los relativos. Una URL puede morir sin que el verificador lo detecte.
- **Ramas protegidas**: la ejecución directa sobre `main` funciona hoy porque no hay protección de rama; si se activa, el flujo pasa a requerir pull request.
- **Calidad editorial**: el verificador comprueba forma, no que lo escrito sea correcto o esté actualizado.
