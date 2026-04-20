# Regras de Revisão — Deco Content Reviewer

Todas as regras abaixo são objetivas e baseadas em padrões de SEO técnico e boas práticas
de copywriting para PT-BR. Nenhuma regra é subjetiva ou baseada em preferência de estilo.

---

## SEO — Campos `seo.title` e `seo.description`

### Erros (❌ — sugerir correção)

| Regra | ID | Condição |
|---|---|---|
| Title ausente | `seo/title-missing` | `seo.title` não existe ou é string vazia |
| Description ausente | `seo/description-missing` | `seo.description` não existe ou é string vazia |
| Title muito longo | `seo/title-too-long` | `seo.title.length > 60` caracteres |
| Title muito curto | `seo/title-too-short` | `seo.title.length < 20` caracteres |
| Description muito longa | `seo/description-too-long` | `seo.description.length > 160` caracteres |
| Description muito curta | `seo/description-too-short` | `seo.description.length < 70` caracteres |
| Title em caixa alta | `seo/title-all-caps` | Palavra com 4+ letras totalmente maiúscula (exceto siglas conhecidas: SEO, CMS, URL, API, HTML, CSS, JS) |
| Title duplicado | `seo/title-duplicate` | Mesmo valor de `seo.title` em dois ou mais arquivos modificados neste PR |
| Description duplicada | `seo/description-duplicate` | Mesmo valor de `seo.description` em dois ou mais arquivos modificados |
| Title com placeholder | `seo/title-placeholder` | Title contém `TODO`, `FIXME`, `[`, `]`, `{`, `}` ou está em inglês quando restante do conteúdo está em PT |
| Description com placeholder | `seo/description-placeholder` | Mesma condição acima para description |

### Avisos (⚠️ — apenas comentar)

| Regra | ID | Condição |
|---|---|---|
| Title termina com separador | `seo/title-trailing-separator` | Title termina com ` | `, ` - `, ` – `, ` — ` seguido do nome do site |
| Description sem verbo de ação | `seo/description-no-cta` | Description não contém verbo no imperativo ou infinitivo (ex: "descubra", "confira", "encontre", "acesse") |
| Title repete a mesma palavra | `seo/title-repeated-word` | A mesma palavra não-funcional aparece 2+ vezes no title |
| Description termina sem pontuação | `seo/description-no-period` | `seo.description` não termina com `.`, `!` ou `?` |

---

## HTML em campos de conteúdo

Os campos de conteúdo são identificados como: qualquer campo de string que contenha tags HTML (`<` e `>`), excluindo os campos `seo.*`.

### Diferenciando tags de copy vs. tags estruturais de componente

**Tags de copy** (sujeitas a revisão de SEO e copy):
`<h1>` `<h2>` `<h3>` `<h4>` `<h5>` `<h6>` `<p>` `<span>` `<a>` `<strong>` `<em>` `<b>` `<i>` `<li>` `<ul>` `<ol>` `<blockquote>` `<figcaption>` `<caption>` `<label>` `<button>` `<title>`

**Tags estruturais de componente** (ignorar para fins de copy/SEO):
`<div>` `<section>` `<article>` `<aside>` `<nav>` `<header>` `<footer>` `<main>` `<figure>` `<picture>` `<source>` `<template>` `<slot>` `<script>` `<style>` — **a menos que** contenham diretamente texto sem tags filhas de copy.

### Erros em HTML (❌ — sugerir correção)

| Regra | ID | Condição |
|---|---|---|
| Múltiplos `<h1>` | `html/multiple-h1` | Mais de um `<h1>` no mesmo campo ou somando todos os campos de uma section |
| `<h1>` ausente | `html/missing-h1` | Nenhum `<h1>` em nenhum campo de conteúdo da section (somente se a section parecer ser uma página ou hero) |
| Salto de nível de heading | `html/heading-level-skip` | Ex: `<h1>` seguido diretamente por `<h3>` sem `<h2>` no meio |
| `<img>` sem `alt` | `html/img-missing-alt` | Tag `<img>` sem atributo `alt` |
| `<img>` com `alt` vazio | `html/img-empty-alt` | `alt=""` em imagem que claramente não é decorativa (tem `src` com nome descritivo) |
| `<a>` sem texto âncora | `html/anchor-empty-text` | Tag `<a>` com conteúdo vazio ou apenas espaços |
| `<a>` com texto genérico | `html/anchor-generic-text` | Texto âncora é exatamente: "clique aqui", "saiba mais", "aqui", "link", "veja" (sem contexto adicional) |

### Avisos em HTML (⚠️ — apenas comentar)

| Regra | ID | Condição |
|---|---|---|
| Heading sem texto relevante | `html/heading-too-short` | `<h1>`-`<h3>` com texto menor que 3 palavras |
| `<strong>` em frase inteira | `html/strong-entire-sentence` | `<strong>` envolve 10+ palavras (provavelmente deveria ser `<h>` ou `<p>`) |
| Texto em `<div>` direto | `html/text-in-div` | Nó de texto diretamente dentro de `<div>` sem tag de copy intermediária |

---

## Copy — Campos de texto (incluindo HTML e strings simples)

### Erros de copy (❌ — sugerir correção)

| Regra | ID | Condição |
|---|---|---|
| Acento ausente óbvio | `copy/missing-accent` | Palavras PT comuns sem acento: "e" (é/ê), "a" (à/á), "nao" (não), "tambem" (também), "alem" (além), "voce" (você), "nós" vs "nos", "pé" vs "pe" — checar contexto antes de flaggar |
| Palavra duplicada adjacente | `copy/duplicate-word` | A mesma palavra aparece duas vezes seguidas (ex: "de de", "o o") |
| Frase incompleta | `copy/incomplete-sentence` | String de copy termina abruptamente sem pontuação e parece incompleta (menos de 4 palavras sem contexto) |
| Inconsistência de terminologia | `copy/terminology-inconsistency` | O mesmo conceito é chamado por nomes diferentes em arquivos distintos do mesmo PR (detectado na fase de cross-file check) |
| Conteúdo desatualizado | `copy/stale-content` | Campo foi atualizado em outros arquivos do PR mas não neste (detectado na fase de cross-file check) |

### Avisos de copy (⚠️ — apenas comentar)

| Regra | ID | Condição |
|---|---|---|
| Pontuação dupla | `copy/double-punctuation` | `!!`, `??`, `...` com mais de 3 pontos, `,.` |
| Capitalização inconsistente | `copy/capitalization` | Mesmo termo aparece com capitalização diferente no mesmo arquivo (ex: "Internet" e "internet") |
| Uso de caixa alta para ênfase | `copy/caps-for-emphasis` | Palavra em CAIXA ALTA dentro de frase corrida (não é sigla, não é heading) |

---

## O que NÃO revisar

- Nomes de campos JSON (keys)
- Valores de campos não-copy: URLs, IDs, booleans, números, arrays de configuração
- Qualquer campo que não seja `seo.*` ou string de texto/HTML
- Estrutura do componente, imports, lógica de negócio
- Código dentro de `<script>` ou `<style>`
- Atributos de componente que não sejam `alt`, `title` de imagens ou texto âncora
