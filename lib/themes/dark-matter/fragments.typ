#let create-fragment(fragment-metadata, page-opts, body) = {
  import "/lib/fragments.typ": create-fragment
  import "./metadata.typ": sections

  // Validate parameters
  {
    assert.eq(type(fragment-metadata), dictionary)
    assert("section" in fragment-metadata)
    assert.eq(type(fragment-metadata.section), str)
    assert(fragment-metadata.section in sections)
    assert("title" in fragment-metadata)
    assert(type(fragment-metadata.title) == str or type(fragment-metadata.title) == content)
    assert("sort-key" in fragment-metadata)
    assert.ne(type(fragment-metadata.sort-key), none)
    if ("outlined" not in fragment-metadata) {
      fragment-metadata.outlined = true
    }
    assert.eq(type(fragment-metadata.outlined), bool)

    assert(type(page-opts) == dictionary or type(page-opts) == type(none))

    if type(page-opts) != type(none) {
      assert("header" in page-opts)
      assert.eq(type(page-opts.header), dictionary)
      assert("color" in page-opts.header)
      assert.eq(type(page-opts.header.color), color)

      // Indicates whether the header content should be wrapped with the default box.
      if "raw" not in page-opts.header {
        page-opts.header.raw = false
      }
      assert.eq(type(page-opts.header.raw), bool)
      assert("content" in page-opts.header)
      assert.eq(type(page-opts.header.content), content)
      assert("footer" in page-opts)
      assert.eq(type(page-opts.footer), content)
      if "args" not in page-opts {
        page-opts.args = (:)
      }
      assert.eq(type(page-opts.args), dictionary)
    }

    assert.eq(type(body), content)
  }

  let metadata-tag = [#metadata(fragment-metadata) <notebook-fragment>]

  // Add the fragment to the body section
  create-fragment((
    ..fragment-metadata,
    body: if page-opts == none {
      metadata-tag + body
    } else {
      page(
        header: [
          #set align(center + horizon)
          #set text(size: 30pt, fill: white, weight: "bold")

          #if (page-opts.header.raw) {
            page-opts.header.content
          } else {
            counter(footnote).update(0)
            pad(top: .5in)[
              #box(
                fill: page-opts.header.color,
                width: 100%,
                height: 1in,
                radius: 10pt,
                inset: .15in,
                page-opts.header.content,
              )
              #v(1fr)
            ]
          }
        ],
        footer: page-opts.footer,
        metadata-tag + body,
        ..page-opts.args,
      )
    },
  ))

  // If a file is being previewed, and the entire notebook is not being displayed,
  // then we should display the file contents.
  import "/lib/themes/dark-matter/display.typ": _internal-display-notebook
  _internal-display-notebook(weak: true)
}
