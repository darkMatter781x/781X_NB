/// Creates the Table of Contents fragment for the notebook.
///
/// **Warning:** Should only be ran once
#let create-toc() = {
  import "/lib/themes/dark-matter/fragments.typ": create-fragment
  import "/lib/themes/dark-matter/style.typ": date-format, section-numbering
  import "/lib/themes/dark-matter/metadata.typ": sections
  import "/lib/themes/dark-matter/util/table-with-merged-rows.typ": table-with-merged-rows

  /// Returns a TOC section for the frontmatter
  let display-frontmatter((section, fragments)) = {
    // TODO: Implement
  }
  /// Returns a TOC section for the backmatter
  let display-backmatter((section, fragments)) = [
    // TODO: Implement
    #let appendices = fragments.filter(e => e.value.type == "appendix")

    #if appendices.len() > 0 [
      == Appendices
      #grid(
        columns: 1fr,
        ..appendices.map(metadata => {
          let loc = metadata.location()
          link(metadata.location(), metadata.value.title)
        })
      )
    ]
  ]

  /// Returns a table of contents for the body entries
  /// The table will have the following columns:
  /// - Date
  /// - Project
  /// - Design process Step
  /// - Entry Title + Page Number
  ///
  /// = Parameters:
  /// 1. param1: Dict with an entry named section whose value is the section name. The section name should be "body".
  let display-body-entries((section,)) = [
    #assert.eq(type(section), str)

    #import "/lib/themes/dark-matter/util/capitalize.typ": capitalize

    // TODO: Use a variable for the <notebook-body-entry> label so that no problems arise if the label is changed.

    /// All of the body entries in the notebook.
    #let entries = query(label("notebook-body-entry"))

    /// Returns a formatted cell for the entry title and page number.
    ///
    /// Parameters:
    /// - entry-title: The title of the entry.
    /// - page-number: The formatted page number of the entry.
    #let entry-plus-page(entry-title, page-number) = [
      #entry-title
      #box(width: 1fr, line(length: 100%, stroke: (dash: ("dot", 4pt))))
      #page-number
    ]
    #show link: it => {
      set underline(stroke: 0pt)
      // Disable italics
      emph(it)
    }

    #let prev-date = (date: none, page-loc: none)

    #let children = for entry in entries {
      let metadata = entry.value
      if prev-date.date != metadata.date {
        prev-date.date = metadata.date
        prev-date.page-loc = entry.location()
      }
      let linkify(body) = link(entry.location(), body)
      let linkify-date(date) = link(prev-date.page-loc, date)
      (
        /* Date: */ linkify-date(metadata.date.display(date-format)),
        /* Project: */ linkify(capitalize(metadata.project)),
        // TODO: Render colored icon for the design process step
        /* Step: */ table.cell(
          linkify(capitalize(metadata.step)),
          fill: metadata.color,
        ),
        linkify(entry-plus-page(
          /* Entry Title: */ metadata.title,
          /* Page #: */ numbering(section-numbering.at(section), ..counter(page).at(entry.location())),
        )),
      )
    }

    // `table-with-merged-rows` is used to merge consecutive dates that are the same.
    #table-with-merged-rows(
      columns: (auto, auto, auto, 1fr),
      // Ensures only the dates are merged
      merge-columns: (0,),
      inset: 0.3em,
      // Disable stroke for the table
      stroke: 0pt,
      // Add header row that will be repeated on each page
      table.header([Date], [Project], [Design Process], entry-plus-page("Entry Title", "Page #")),
      // Add horizontal line below the header
      table.hline(stroke: 1pt),

      // TODO: Investigate adding `table.hline`s to divide dates

      // Add the entries
      ..children,
    )
  ]

  // Create the Table of Contents fragment
  create-fragment(
    (
      // This fragment must go before all other frontmatter fragments, besides the cover page.
      sort-key: -1,
      section: "frontmatter",
      title: "Table of Contents",
      // Do not include in table of contents
      outlined: false,
    ),
    (
      // Appears at the top of each TOC page
      // TODO: Make this match the other headers used in the notebook, specifically the body entries
      header: (
        color: gray,
        content: [ Table of Contents ],
      ),
      // Appears at the bottom of each TOC page
      // TODO: Make this match the other footers used in the notebook, specifically the body entries.
      footer: align(right)[
        #context counter(page).display(section-numbering.frontmatter)
      ],
    ),
    // The actual body content of the TOC fragment
    context {
      // TODO: Use a variable for the <notebook-fragment> label so that no problems arise if the label is changed.

      /// All the fragments in the notebook that are to be placed in the TOC.
      let outlined-fragments = query(label("notebook-fragment")).filter(e => "outlined" in e.value and e.value.outlined)

      // Create a section of the TOC for each section in the notebook.
      for section in sections {
        /// All the fragments in the notebook that belong to this section, sorted by page.
        let fragments = outlined-fragments.filter(e => e.value.section == section).sorted(key: e => e.location().page())
        if fragments.len() > 0 {
          let param = (section: section, fragments: fragments)
          if section == "frontmatter" [
            = Frontmatter
            #display-frontmatter(param)
          ] else if section == "body" [
            = Entries
            #display-body-entries(param)
          ] else if section == "backmatter" [
            = Backmatter
            #display-backmatter(param)
          ]
        }
      }
    },
  )
}
