# Sources & Licenses

Status: SOURCE POLICY ACTIVE

## Biblical Hebrew

Primary source family:

- Open Scriptures Hebrew Bible (OSHB)
- Base text: Westminster Leningrad Codex (WLC)

Licensing:

- WLC text: Public Domain
- OSHB lemma and morphology data: CC BY 4.0

Attribution:

> Open Scriptures Hebrew Bible Project

Rules:

- Hebrew may be normalized for learner display by removing cantillation while preserving consonants and vowel points when useful.
- Morphology derived from OSHB retains attribution.
- Morphology describes form before interpretation; syntactic or exegetical disputes belong in marked notes.

## Koine Greek New Testament

Primary text:

- SBL Greek New Testament (SBLGNT), project baseline v1.2

Morphological support:

- MorphGNT: SBLGNT Edition

Licensing:

- SBLGNT electronic text: governed by the published SBLGNT End-User License Agreement / permission terms; it must not be mislabeled as CC BY 4.0.
- MorphGNT parsing and lemmatization: CC BY-SA.

Attribution:

> SBL Greek New Testament, ed. Michael W. Holmes, Society of Biblical Literature / Logos Bible Software.

> MorphGNT: SBLGNT Edition, ed. James Tauber.

Rules:

- Every quoted passage declares edition, license and attribution.
- Morphology derived from MorphGNT must retain compatible attribution.
- Course-authored morphology must remain independently reviewable.
- No proprietary lexicon prose or critical apparatus is copied without compatible permission.

## Septuagint bridge forms

Short LXX forms are used only as explicitly labeled pedagogical bridges, for example `γενηθήτω φῶς` in Gênesis 1:3.

Before publishing extended LXX passages, the project must select and document one canonical openly usable edition.

## Portuguese and Esperanto

Learner-facing Portuguese and Esperanto renderings are course-authored pedagogical translations unless a named edition is explicitly declared.

Esperanto is a bridge language, not an authority layer over Hebrew or Greek.

## Required analysis order

```text
source text
→ transliteration
→ lemma / lexical gloss
→ morphology
→ literal translation
→ natural translation
→ translation note
→ theological / exegetical interpretation
```

## Current provenance

Lesson 001:
- Gênesis 1:1 — OSHB / WLC.
- João 1:1 — SBLGNT; morphology reviewed against MorphGNT where used.

Lesson 002:
- Êxodo 3:14 — OSHB / WLC.
- João 1:6 — SBLGNT; morphology reviewed against MorphGNT where used.
- `אֶהְיֶה` remains morphologically Qal imperfect 1cs even when the natural Portuguese layer uses the traditional “EU SOU”.

Lesson 003:
- Gênesis 1:3 — OSHB / WLC.
- João 1:3a–b — SBLGNT; morphology reviewed against MorphGNT where used.
- `יְהִי` is treated as jussive and `וַיְהִי` as a narrative consecutive form; the short LXX bridge is labeled as such.

Lesson 004:
- Gênesis 12:1 — OSHB / WLC.
- Lucas 1:27 — SBLGNT; morphology reviewed against MorphGNT.
- `מִבֵּית אָבִיךָ` is used to introduce construct relationship + possessive suffix.
- `ἐξ οἴκου Δαυίδ` and `τὸ ὄνομα τῆς παρθένου` are used to introduce Greek genitive relations without claiming structural identity with Hebrew construct syntax.

Lesson 005:
- Gênesis 1:5 — OSHB / WLC.
- Marcos 1:15 — SBLGNT; morphology reviewed against MorphGNT.
- `יוֹם אֶחָד` is preserved in the literal layer as “dia um”; “primeiro dia” belongs to the natural translation layer.
- `πεπλήρωται` is treated as perfect middle/passive indicative 3sg and `ἤγγικεν` as perfect active indicative 3sg.
- `καιρός` is presented as time/occasion appropriate or decisive according to context, not as an automatic theological category.

## Publication gate

A Lesson is not publication-ready if any quoted source passage lacks `sourceEdition`, `sourceLicense` or `sourceAttribution`.
