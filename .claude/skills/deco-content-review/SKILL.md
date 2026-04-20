---
name: deco-content-review
description: >
  SEO and copy reviewer for .deco/blocks/ JSON files in a Deco.cx CMS environment.
  Use when asked to review content changes in a PR, validate SEO fields, or check copy quality
  in .deco/blocks/*.json files. Reads git diff to scope only modified files.
  DO NOT use for code review, logic validation, or anything outside copy and SEO.
allowed-tools: Bash, Read, Glob, Grep
---

# Deco Content Reviewer

## Output Contract

Always produce BOTH of the following before responding:

**1. `review.json`** — machine-readable findings (write to working dir or emit as Action output)
```json
{
  "summary": {
    "files_reviewed": 0,
    "errors": 0,
    "warnings": 0
  },
  "findings": [
    {
      "file": ".deco/blocks/example.json",
      "path": "sections[0].seo.title",
      "severity": "error | warning",
      "rule": "seo/title-too-long",
      "message": "Descrição do problema em português.",
      "current_value": "...",
      "suggested_value": "..." // only present for errors
    }
  ]
}
```

**2. `pr-comment.md`** — human-readable PR comment in **Portuguese**
Structure:
```
## 🔍 Revisão de Conteúdo e SEO

### Resumo
X erro(s) · Y aviso(s) · Z arquivo(s) revisado(s)

---

### 📄 `<filename>`
#### ❌ Erros
- `<json.path>` — <mensagem> → **Sugestão:** `<valor>`

#### ⚠️ Avisos
- `<json.path>` — <mensagem>

---
✅ Nenhum problema encontrado. (if no findings)
```

---

## Step 1 — Identify modified files

Run the helper script to get the list of changed `.deco/blocks/` JSON files:

```bash
bash .claude/skills/deco-content-review/scripts/get_changed_blocks.sh
```

If no files are returned, output: `✅ Nenhum arquivo .deco/blocks/ modificado neste PR.` and stop.

---

## Step 2 — Parse each file

For each file, read its JSON and extract:
- `sections[]` array
- For each section: `seo` object (if present) and all other string/HTML fields

Identify HTML-bearing fields: any string value containing `<` and `>` characters.

---

## Step 3 — Apply review rules

Read full rules from `references/review-rules.md` before proceeding.

Quick reference of severity classification:
- **ERROR** → must suggest a fix (`suggested_value` required in JSON, listed under ❌ in PR comment)
- **WARNING** → comment only, no suggested value, listed under ⚠️

---

## Step 4 — Cross-file consistency check

After reviewing all files individually, scan ALL modified files together for:
- Inconsistent terminology for the same concept across files (e.g. "produto" vs "item")
- Duplicate `seo.title` or `seo.description` values across different pages
- Content that appears updated in most files but left stale in one specific file

Report cross-file issues under a separate `### 🔄 Consistência entre Arquivos` section in the PR comment.

---

## Step 5 — Output

Write `review.json` to the working directory.
Write `pr-comment.md` to the working directory.
Print both to stdout so the GitHub Action can capture them as outputs.

---

## Hard constraints

- **Never review code logic, component structure, imports, or non-content fields.**
- **Never suggest rewrites of copy based on style preference.** Only flag objective errors.
- **Never flag something as an error without a concrete rule violation** (see `references/review-rules.md`).
- The reviewer is a SEO/copy technician, not an editor. Impartial and rule-based only.
- All output messages must be in **Portuguese (PT-BR)**.
