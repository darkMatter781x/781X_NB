/// Creates default fragments and returns the content of the entire notebook.
///
/// These default fragments include the table of contents and the backmatter.
///
/// = Parameters:
/// - `only-body`: bool - If true, only the body of the notebook is displayed without the table of contents.
#let initialize() = {
  // Table of contents
  import "/lib/themes/dark-matter/fragments/toc.typ": create-toc
  create-toc()

  // Strongly display the notebook content
  import "/lib/themes/dark-matter/display.typ": _internal-display-notebook
  _internal-display-notebook(weak: false)
}
