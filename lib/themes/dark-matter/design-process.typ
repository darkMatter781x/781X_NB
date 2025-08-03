
/// Holds the styling information and name of each the design process steps
///
/// -> Record<str, (color: color, symbol: content)>
#let design-process = {
  import "@preview/fontawesome:0.5.0": *
  // TODO: Use our icons. I don't really like the FontAwesome icons, but they are good placeholders.
  (
    "project management": (color: rgb("#d9d9d9"), symbol: fa-book()),
    "identify problem": (color: rgb("#BCD8EC"), symbol: fa-magnifying-glass()),
    brainstorm: (color: rgb("#D6E5BD"), symbol: fa-lightbulb(), alt: "bs"),
    select: (color: rgb("#ffeec6"), symbol: fa-crosshairs(), alt: "se"),
    build: (color: rgb("#FFCD9A"), symbol: fa-hammer(), alt: "bu"),
    test: (color: rgb("#FFADaD"), symbol: fa-flask(), alt: "te"),
    compete: (color: rgb("#DCCCEC"), symbol: fa-swords(), alt: "cp"),
  )
}
