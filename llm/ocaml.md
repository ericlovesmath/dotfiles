---
name: OCaml
description: Use when the task involves writing OCaml code, contains OCaml style and design preferences
---

# OCaml Style Preferences

These are not hard rules, but general guidelines when writing clean OCaml code

- Prefer immutable data structures and pure functions over ref cells and mutable data structures
- Avoid repeated mutation, such as folding huge states, especially when you could do `List.concat_map` or something similar
- Types of functions at the toplevel should generally be explicitly annotated
- Make clean boundaries for modules that don't have to expose many functions or concrete types
- Prefer variable shadowing if the variable will not be reused later
- Avoid making functions with too many parameters, especially those with many flags, which can be hard to maintain
- Avoid passing huge states like records with many fields that are rarely used
