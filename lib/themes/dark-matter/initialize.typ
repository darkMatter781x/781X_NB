/// Creates default fragments and returns the content of the entire notebook.
///
/// These default fragments include the table of contents and the backmatter.
///
/// = Parameters:
/// - `only-body`: bool - If true, only the body of the notebook is displayed without the table of contents.
#let initialize(only-body: false) = {
  assert.eq(type(only-body), bool)

  import "/lib/fragments.typ": display-fragments
  let sections = {
    if only-body {
      ("body",)
    } else {
      import "./metadata.typ": sections
      sections
    }
  }

  import "/import.typ": codly, codly-init, codly-languages

  show: codly-init.with()
  codly(languages: codly-languages)

  set text(size: 15pt, kerning: true, font: "Calibri")
  set par(justify: true, linebreaks: "optimized")
  show figure.caption: emph
  // #show math.equation: set text(font: "Fira Math")
  set raw(theme: "/assets/MyLight.tmTheme")
  show raw.where().and(label("code")): set text(size: 9pt)
  show raw: set text(font: "Monaspace Neon", ligatures: true)
  set math.mat(delim: "[")
  set math.vec(delim: "[")

  set page("us-letter", margin: (top: 1.75in, bottom: 1in, left: .5in, right: .5in))

  show heading: it => {
    set block(below: 1em)

    let content = if it.level == 1 {
      set text(size: 15pt)
      box(fill: gray, outset: 0.5em, radius: 1.5pt, it.body)
    } else if it.level == 2 {
      set text(size: 14pt)

      it.body
    } else {
      set text(size: 11pt)
      it.body
    }

    block(content)
  }

  // Table of contents
  import "/lib/themes/dark-matter/fragments/toc.typ": create-toc
  create-toc()

  display-fragments(sections.map(s => (
    id: s,
    start-content: {
      counter(page).update(1)
    },
  )))
}
