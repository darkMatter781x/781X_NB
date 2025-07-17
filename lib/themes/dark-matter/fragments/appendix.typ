#let create(title, body) = {
  let appendix-label = label("781x-nb-appendix")
  let entry-counter = counter("781x-nb-appendix-entry")
  entry-counter.step()
  context {
    /// Create a unique label for each appendix
    let entry-label = label("781x-nb-appendix-entry-" + repr(entry-counter.get()))
    let entry = (title: title, body: [#metadata(none) #entry-label] + body)

    let letter = entry-counter.display("A")
    let full-title = [ Appendix #letter: #title ]

    import "/lib/themes/dark-matter/fragments.typ": create-fragment
    create-fragment(
      (
        title: full-title,
        section: "backmatter",
        type: "appendix",
        sort-key: ("appendix", entry-counter.get()),
      ),
      (
        header: (color: gray, content: full-title),
        footer: [
          #set align(right)
          #context counter(page).display((n, ..) => [
            #letter#"-"#n
          ])
        ],
        args: (
          numbering: (n, ..) => [
            #letter#"-"#n
          ],
        ),
      ),
    )[
      // Reset page counter for each appendix
      #counter(page).update((1,))
      #metadata(full-title) #appendix-label
      #metadata(none) #entry-label
      #body
    ]

    context {
      let page = query(selector(appendix-label).before(entry-label)).last()
      let loc = page.location()

      link(loc, page.value)
    }
  }
}


#let _test-appendix() = {
  import "./body.typ": create as create-body-entry
  create-body-entry("a", "a", "identify problem", "a", datetime(year: 1, month: 1, day: 1))[

    // Create a nicer function to add entries to the appendix
    // Append the appendix to the end of the document
    // #show: it => it + (_appendix-impl.display)()

    #let me-file = read("/lib/themes/dark-matter/fragments/appendix.typ")
    #let excerpt = raw(
      {
        let lines = me-file.split("\n")
        let start-regex = regex("//<EXCERPT-START>")
        let end-regex = regex("//<EXCERPT-END>")
        let start = lines.position(l => l.find(start-regex) != none)
        let end = lines.position(l => l.find(end-regex) != none)
        "\n" + lines.slice(start + 1, end).join("\n")
      },
      lang: "typc",
    )

    Here's how the appendix gets displayed:
    #excerpt

    See the #create("Source Code", lorem(500)) for more details.


    // See the #create-appendix("Source Code", raw(me-file, lang: "typ")) for more details.

    // See the #create-appendix("Source Code", raw(me-file, lang: "typ")) for more details.

  ]

  create-body-entry("a", "a", "identify problem", "a", datetime(year: 2, month: 1, day: 1))[
    See the #create("Source Code", lorem(500)) for more details.

  ]

  import "../initialize.typ": initialize
  initialize()
}

// #test-appendix()
