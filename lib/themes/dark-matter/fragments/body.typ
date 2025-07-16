/// Creates a new body entry in the notebook.
///
/// // Parameters
/// - title (str): The title of the entry.
/// - project (str): Identifies which project this entry belongs to.
/// - step (str): The step of the design process.
/// - author (str, array): The author(s) of the entry.
/// - date (datetime): The date of the entry
/// - witness (str, none): The witness of the entry
/// - order (int): Used to decide which entry to display first if there are multiple entries on the same date.
/// - body (content): The content of the entry.
#let create(
  title,
  project,
  step,
  author,
  date,
  // TODO: Allow for multiple witnesses maybe (Is this necessary?).
  witness: none,
  order: 0,
  body,
) = {
  assert.eq(type(title), str)
  assert.eq(type(project), str)
  assert.eq(type(step), str)
  assert(type(author) == str or (type(author) == array and author.all(a => type(a) == str)))
  assert(type(witness) == str or witness == none)
  assert.eq(type(date), datetime)
  assert.eq(type(body), content)

  // TODO: Use our icons. I don't really like the FontAwesome icons, but they are good placeholders.
  // TODO: Place in another file to be also used by the TOC.
  import "@preview/fontawesome:0.5.0": *
  let design-process = (
    // research: rgb("#3a6b8aff"),
    "identify problem": (color: rgb("#45818eff"), symbol: fa-magnifying-glass()),
    brainstorm: (color: rgb("#76a5afff"), symbol: fa-lightbulb()),
    select: (color: rgb("#a2c4c9ff"), symbol: fa-crosshairs()),
    build: (color: rgb("#f1c232ff"), symbol: fa-hammer()),
    test: (color: rgb("#cc4125ff"), symbol: fa-flask()),
    // tune: rgb("#dd7e6bff"),
    // deliver: rgb("#8e7cc3ff")
  )

  assert(
    step in design-process,
    message: "Step must be one of the design process steps (" + design-process.keys().join(", ") + ")",
  )

  /// Whether the body fragment has been initialized.
  let body-fragment-state = state("notebook-body-fragments", false)

  /// Holds all of the body entries.
  /// Is structured as an array of dictionaries, where each dictionary represents a body entry.
  /// Each body entry dictionary should have the following keys:
  ///
  /// - `title`: str - The title of the entry.
  /// - `project`: str - The project the entry belongs to.
  /// - `step`: str - The step of the design process.
  /// - `author`: str or array - The author(s) of the entry.
  /// - `date`: datetime - The date of the entry.
  /// - `witness`: str or none - The witness of the entry.
  /// - `order`: int - Used to decide which entry to display first if there are multiple entries on the same date.
  /// - `body`: content - The content of the entry.
  let entry-state = state("notebook-body-entries", ())

  /// Creates the single body fragment that contains all the body entries.
  /// Must only be called once.
  let create-body-fragment() = {
    // Ensure that the body fragment is only created once.
    context assert.eq(
      body-fragment-state.at(here()),
      false,
      message: "The body fragment has already been created. You cannot create it again.",
    )

    import "/lib/themes/dark-matter/style.typ": date-format, section-numbering
    import "/lib/themes/dark-matter/fragments.typ": create-fragment

    /// Vertical space between entries.
    let between-entry-spacing = 2em

    /// The prefix for all labels in the body entries.
    let label-prefix = "notebook-body-"

    /// Indicates the end of an entry.
    /// Occurs once per entry.
    /// Attached to `#metadata(none)`.
    let entry-end-label = label(label-prefix + "entry-end")

    /// Indicates the top of an entry.
    /// Repeated at the top of each page of an entry.
    /// Attached to `#metadata(none)`.
    let entry-header-label = label(label-prefix + "entry-header")

    /// Indicates the bottom of an entry.
    /// Repeated at the bottom of each page of an entry.
    /// Attached to `#metadata(none)`
    let entry-footer-label = label(label-prefix + "entry-footer")

    // TODO: Move to a separate file to be shared with the TOC.
    /// Indicates the start of each entry and the entry's metadata.
    /// This is used for TOC, tabs, and project next and prev entries.
    ///
    /// Attached to ```typst #metadata(entry)```
    ///
    /// `entry` should be a dictionary with the same keys as in the `entry-state` state.
    let entry-label = label(label-prefix + "entry")

    /// Returns the content for each entry.
    /// Adds a header, footer, and metadata to the entry.
    let display-entry(entry) = [
      /// Color of the entry's step.
      #let color = design-process.at(entry.step).color

      // TODO: Move to a separate file to be shared with the TOC.
      /// Capitalize start of words
      #let capitalize(str) = str.split(" ").map(word => upper(word.slice(0, 1)) + word.slice(1)).join(" ")

      /// Text to be displayed as the author.
      #let author-text = if type(entry.author) == array { entry.author.join(", ") } else { entry.author }

      /// Text to be displayed as the witness.
      #let witness-text = if entry.witness != none { entry.witness } else { "N/A" }

      /// Text to be displayed to indicate the previous entry.
      #let prev-entry-text = context {
        let prev-entry = query(selector(entry-label).before(here()))
          .filter(queried-entry => queried-entry.value.project == entry.project)
          .at(-2, default: none)
        if prev-entry == none { "No previous entry!" } else {
          link(
            prev-entry.location(),
            "Prev. Project Entry: Page "
              + numbering(section-numbering.body, ..counter(page).at(prev-entry.location())),
          )
        }
      }

      /// Text to be displayed to indicate the next entry.
      #let next-entry-text = context {
        let prev-entry = query(selector(entry-label).after(here()))
          .filter(queried-entry => queried-entry.value.project == entry.project)
          .at(0, default: none)
        if prev-entry == none { "No next entry!" } else {
          link(
            prev-entry.location(),
            "Next Project Entry: Page "
              + numbering(section-numbering.body, ..counter(page).at(prev-entry.location())),
          )
        }
      }

      // Label start of entry and attach metadata to it.
      #metadata(entry) #entry-label
      // Actual content of the entry.
      #grid(
        columns: 100%,
        // Space out the header, body, and footer by 1em.
        row-gutter: 1em,
        // Repeated at the top of each page of the entry.
        grid.header(
          // Label the start of each page of the entry.
          [#metadata(none) #entry-header-label]
            + // Stack the header text and a line vertically.
            stack(
              dir: ttb,
              spacing: 0.5em,
              // Display the project and title of the entry.
              align(center, text(size: 1.25em, [#capitalize(entry.project): #entry.title])),
              line(length: 100%, stroke: 2pt + black),
            ),
        ),
        // The main content of the entry.
        entry.body,
        // Repeated at the bottom of each page of the entry.
        grid.footer([
          // First row: Author(s) and witness.
          By: #author-text
          #h(1fr)
          Witnessed by: #witness-text
          #linebreak()
          // Second row: Previous and next entry for the project.
          #prev-entry-text
          #h(1fr)
          #next-entry-text
          // Label the bottom of each page of the entry.
          #metadata(none) #entry-footer-label
        ])
      )
      // Label the end of the entry.
      #metadata(none) #entry-end-label
    ]

    /// Returns the content for an entry page's tabs.
    /// These tabs display the color and symbol of the entry's design process step.
    ///
    /// This should be used in the background of the body pages.
    ///
    /// - entry-page (dictionary):
    ///     A dictionary representing a page of an entry.
    ///     It should have the following pairs:
    ///     - start-y (length): The starting y position of the entry on this page.
    ///     - height (length): The height of the entry on this page.
    ///     - step (str): The step of the design process of the entry.
    let display-entry-tabs(entry-page) = {
      /// Step of the design process.
      let step = design-process.at(entry-page.step)
      /// Text to be displayed for the step.
      let step-text = strong(upper(entry-page.step))

      /// How much the tabs should expand vertically past the entry in each direction.
      let y-expansion = between-entry-spacing.to-absolute() / 8
      /// The height of the tabs in the y direction.
      let height = entry-page.height + 2 * y-expansion

      /// The length needed to display the step text.
      let step-text-length = measure(step-text).width
      /// The length needed to display each icon.
      let icon-height = measure(step.symbol).width

      /// The spacing between the step text and the icons.
      let row-gutter = 0.1in
      /// How much the content of the tabs should be inset from the edges.
      let box-inset = (x: .1em, y: .1in)

      /// Whether the can fit in the height of the entry.
      /// If the height is too small, then the text will not be displayed.
      let should-show-text = height > (step-text-length + 2 * box-inset.y)

      /// Whether the step icons should be displayed.
      /// If the text is not shown, then the icons should always be shown.
      /// Otherwise, the icons will only be shown if there is enough space.
      let should-show-icons = (
        not should-show-text or (height > (2 * icon-height + step-text-length + 2 * row-gutter + 2 * box-inset.y))
      )

      /// Returns the content for one of entry's tabs.
      ///
      /// - side (left, right):
      ///     Which side of the page the tab is to be placed on.
      ///     Must be either `left` or `right`.
      ///
      /// -> content
      let tab(side) = {
        assert(side in (left, right), message: "side must be either 'left' or 'right'")

        /// Which side of the tab should be rounded.
        /// Should be the opposite of the side parameter.
        /// Must be either `"left"` or `"right"`.
        ///
        /// -> str
        let rounded-side = if side == left { "right" } else { "left" }

        box(
          // Round the side opposite to the side parameter.
          radius: ((rounded-side): 10pt),
          // Big enough to contain the text.
          width: 1em + box-inset.x * 2,
          height: height,
          // Space the content away from the edges.
          inset: box-inset,
          fill: step.color,
          // Align the content in the center (horizontally).
          align(
            center,
            // Use a grid to enforce row gutter and placement of the icons/text.
            grid(
              row-gutter: row-gutter,
              // If should show icons, then create rows for them.
              // This is is to make sure the row gutter is applied correctly.
              rows: if should-show-icons { (auto, 1fr, auto) } else { (1fr,) },
              align: center + horizon,
              ..(
                // Top icon
                if should-show-icons { step.symbol },
                // Step text
                if should-show-text {
                  // Rotate the text so that it is vertical.
                  rotate(
                    -90deg,
                    reflow: true,
                    step-text,
                  )
                } else [], // Always have some content in the middle.
                // Bottom icon
                if should-show-icons { step.symbol },
                // Remove the icon elements if they should not be shown.
              ).filter(e => e != none)
            ),
          ),
        )
      }

      // Place the tabs on the left and right side of the entry.
      place(top + left, dy: entry-page.start-y, grid(
        columns: (auto, 1fr, auto),
        tab(left), [], tab(right),
      ))
    }

    /// Returns the background for the body fragment.
    /// This background is where the entry tabs are placed.
    let display-background() = context {
      // TODO: Investigate if there's a more efficient way to do this.
      let entry-pages = query(entry-label)
        .map(queried-entry => {
          let entry-data = queried-entry.value

          // Find the start and end locations of the entry.
          let start-loc = queried-entry.location()
          let end-loc = query(selector(entry-end-label).after(start-loc)).first().location()

          // Find start and end locations of each entry page.
          let header-locs = query(selector(entry-header-label).after(start-loc).before(end-loc)).map(h => h.location())
          let footer-locs = query(selector(entry-footer-label).after(start-loc).before(end-loc)).map(f => f.location())

          // Create an array of dictionaries representing each page of the entry.
          header-locs
            .zip(footer-locs)
            .map(((header-loc, footer-loc)) => (
              start-y: header-loc.position().y,
              height: footer-loc.position().y - header-loc.position().y,
              step: entry-data.step,
              page: header-loc.page(),
            ))
        })
        .flatten() //
        // Filter the entries to only include those that are on the current page.
        .filter(entry-page => entry-page.page == here().page())

      entry-pages.map(display-entry-tabs).sum(default: [])
    }

    // TODO: Add comments to rest of file.
    create-fragment((section: "body", outlined: true, title: "Body Entries", sort-key: 0), none, context {
      let entries-on-date = {
        let raw-entries = entry-state.final()
        raw-entries
          .map(e => e.date)
          .dedup()
          .map(date => {
            let entries = raw-entries.filter(e => e.date == date).sorted(key: e => e.order)
            return (date: date, entries: entries)
          })
      }
      entries-on-date
        .map(((date, entries)) => {
          let date-str = date.display(date-format)

          page(
            margin: (top: .75in, bottom: .75in),
            footer-descent: 1em,
            stack(dir: ttb, spacing: between-entry-spacing, ..entries.map(entry => display-entry(entry))),
            header: [
              #date-str
              #h(1fr)
              #context counter(page).display(section-numbering.body)
            ],
            background: display-background(),
          )
        })
        .sum()
    })

    body-fragment-state.update(true)
  }
  // Create the body fragment if it has not been created yet.
  context if not body-fragment-state.at(here()) {
    create-body-fragment()
  }

  entry-state.update(s => (
    s
      + (
        (
          title: title,
          project: project,
          step: step,
          author: author,
          date: date,
          witness: witness,
          body: body,
          order: order,
        ),
      )
  ))
}
