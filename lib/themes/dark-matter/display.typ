/// Returns the body of the notebook, with some catches:
///
/// - If called multiple times with weakly=false, this will panic.
/// - If called with weakly=true,
///   then it will return the body only if it has not been called strongly before and called weakly before,
///   otherwise it will return nothing.
///
/// This is used by all the notebook fragments to display the notebook body, so that previews of smaller sections of the nb automatically work.
///
/// - weakly (bool): See above for behavior.
#let _internal-display-notebook(weak: true) = {
  assert.eq(type(weak), bool)

  let has-been-called-strongly = state("notebook-display-notebook-displayed-strongly", false)

  if not weak {
    context assert.eq(
      has-been-called-strongly.at(here()),
      false,
      message: "The notebook has already been displayed strongly.",
    )
    has-been-called-strongly.update(true)
  }

  let nb-content = {
    // TODO: Move styling stuff to other function?
    // Configure styling
    import "/import.typ": codly, codly-init, codly-languages

    // Use codly for code blocks
    show: codly-init.with()
    codly(languages: codly-languages)

    // Set text font size and family
    set text(size: 15pt, kerning: true, font: "Calibri")
    // Set paragraph style
    set par(justify: true, linebreaks: "optimized")
    // Make figure captions italic
    show figure.caption: emph
    // Set code theme
    set raw(theme: "/assets/MyLight.tmTheme")
    // Reduce font size for code blocks
    show raw.where().and(label("code")): set text(size: 9pt)
    // Set code font and enable ligatures
    show raw: set text(font: "Monaspace Neon", ligatures: true)
    // Use square brackets for matrices and vectors
    set math.mat(delim: "[")
    set math.vec(delim: "[")

    // Set page size and margins
    set page("us-letter", margin: (top: 1.75in, bottom: 1in, left: .5in, right: .5in))

    // Set header style
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


    // Get the types of sections
    import "./metadata.typ": sections

    // Display the notebook body
    import "/lib/fragments.typ": display-fragments
    display-fragments(sections.map(s => (
      id: s,
      start-content: {
        // Reset page counter for each section
        counter(page).update(1)
      },
    )))
  }

  if weak {
    let has-been-called-weakly = state("notebook-display-notebook-displayed-weakly", false)

    context if has-been-called-strongly.final() {
      // Notebook has been displayed strongly before
      return none
    } else {
      // Notebook has only been displayed weakly

      if has-been-called-weakly.at(here()) {
        // Notebook has already been displayed weakly, so we fail silently
        return none
      }

      nb-content
    }

    has-been-called-weakly.update(true)
  } else { nb-content }
}
