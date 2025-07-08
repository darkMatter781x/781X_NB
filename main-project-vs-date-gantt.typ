#import "/lib/themes/dark-matter/theme.typ" as theme
#import "/lib/fragments.typ": *
#import "@preview/codly:1.2.0": *
#import "@preview/codly-languages:0.1.5": *

#show: codly-init.with()
#codly(languages: codly-languages)

#set text(size: 15pt, kerning: true, font: "Calibri")
#set par(justify: true, linebreaks: "optimized")
#show figure.caption: emph
// #show math.equation: set text(font: "Fira Math")
#set raw(theme: "/assets/MyLight.tmTheme")
#show raw.where().and(label("code")): set text(size: 9pt)
#show raw: set text(font: "Monaspace Neon", ligatures: true)
#set math.mat(delim: "[")
#set math.vec(delim: "[")

#set page(
  "us-letter",
  margin: (top: 1.75in, bottom: 1in, left: .5in, right: .5in),
)

// #theme.initialize()

// #for i in range(1, 6) {
//   theme.create-body-fragment(
//     "fragment " + str(i),
//     "Project",
//     ("identify problem", "brainstorming", "select", "build", "test").at(calc.rem(i, 4)),
//     range(1, i + 1).map(j => "Author " + str(j)),
//     datetime(year: 2023, day: 10 + i, month: 1),
//     witness: "Witness ",
//   )[#lorem(i * 10)]
// }

#let group-by(arr, key-func) = {
  assert.eq(type(arr), array)
  assert.eq(type(key-func), function)

  let out = (:)
  for item in arr {
    let key = key-func(item)

    if key in out and type(out.at(key)) == array {
      out.at(key).push(item)
    } else {
      out += ((key): (item,))
    }
  }
  return out
}
#set page(flipped: true)

#let gantt(fragments) = {
  assert.eq(type(fragments), array)
  for fragment in fragments {
    assert.eq(type(fragment), dictionary)
    assert("date" in fragment)
    assert.eq(type(fragment.date), datetime)
    assert("title" in fragment)
    assert.eq(type(fragment.title), str)
    assert("project" in fragment)
    assert.eq(type(fragment.project), str)
    assert("location" in fragment)
    assert.eq(type(fragment.location), location)
    assert("step" in fragment)
    assert.eq(type(fragment.step), str)
  }
  let design_process = (
    // research: rgb("#3a6b8aff"),
    "identify problem": rgb("#45818eff"),
    brainstorming: rgb("#76a5afff"),
    select: rgb("#a2c4c9ff"),
    build: rgb("#f1c232ff"),
    test: rgb("#cc4125ff"),
    // tune: rgb("#dd7e6bff"),
    // deliver: rgb("#8e7cc3ff")
  )

  let projects = {
    let grouped = group-by(fragments, e => e.project)
    let with-start-and-ends = grouped
      .pairs()
      .map(((project, fragments)) => {
        let sorted-fragments = fragments.sorted(key: e => e.date)
        let dates = sorted-fragments.map(e => e.date)
        let start = dates.first()
        let end = dates.last()
        return (project: project, start: start, end: end, fragments: sorted-fragments)
      })
    with-start-and-ends.sorted(key: e => e.start)
  }

  let fragment-dates = fragments.map(e => e.date).dedup().sorted()

  let start = projects.first().start
  let end = projects.last().end
  let dates-with-gaps = fragment-dates
    .windows(2)
    .enumerate()
    .map(((i, (a, b))) => {
      let diff = b.day() - a.day()
      (
        (a,)
          + if diff > 1 {
            ("gap",)
          }
          + if i == fragment-dates.len() - 2 {
            (b,)
          }
      )
    })
    .flatten()

  let date-spacer = box(inset: (x: .3em), sym.dots.h.c)

  context grid(
    rows: dates-with-gaps.len() + 1,
    columns: (auto,) + (1fr,) * (projects.len()),
    inset: 0.3em,
    stroke: 2pt + black,
    grid.header(..(("Date",) + projects.map(p => p.project)).map(s => grid.cell(align: center, s))),
    ..dates-with-gaps
      .enumerate()
      .filter(((i, d)) => d == "gap")
      .map(((i, d)) => {
        let y = i + 1
        for x in range(projects.len() + 1) {
          (
            grid.cell(
              inset: (x: 0em),
              date-spacer,
              x: x,
              y: y,
            ),
          )
        }
      })
      .flatten(),
    ..fragment-dates
      .map(date => (
        date.display("[month padding:none]/[day padding:none]/[year repr:last_two padding:none]"),
        projects.map(((fragments: all-fragments)) => {
          let fragments = all-fragments.filter(e => e.date == date)
          stack(
            dir: ttb,
            spacing: .1em,
            ..fragments.map(fragment => {
              let color = design_process.at(fragment.step)
              box(
                width: 100%,
                height: 1em,
                fill: color,
                align(
                  horizon + center,
                  link(fragment.location)[
                    #fragment.title: #underline(numbering("1", ..counter(page).at(fragment.location)))
                  ],
                ),
                radius: 5pt,
              )
            }),
          )
        }),
      ))
      .flatten(),

    // ..dates-with-gaps
    //   .enumerate()
    //   .map(day => grid.cell(
    //     if (day == none) {
    //       date-spacer
    //     } else {
    //       day.display("[month padding:none]/[day padding:none]/[year repr:last_two padding:none]")
    //     },
    //     inset: 0.3em,
    //     align: horizon + center,
    //   )),
    // ..projects
    //   .map(project => (
    //     grid.cell(project.project, inset: 0.3em),
    //     ..fragment-dates
    //       .filter(day => day != none)
    //       .map(day => grid.cell(
    //         inset: 1pt,
    //         stroke: (left: 0pt),
    //         align: horizon + center,
    //         stack(
    //           dir: ttb,
    //           spacing: .1em,
    //           ..project
    //             .fragments
    //             .filter(e => e.date == day)
    //             .map(fragment => {
    //               let color = design_process.at(fragment.step)
    //               box(
    //                 width: 100%,
    //                 height: 1em,
    //                 fill: color,
    //                 align(
    //                   horizon + center,
    //                   link(fragment.location)[
    //                     #fragment.title: #underline(numbering("1", ..counter(page).at(fragment.location)))
    //                   ],
    //                 ),
    //                 radius: 5pt,
    //               )
    //             }),
    //         ),
    //       )),
    //   ))
    //   .flatten(),
    // grid.vline(x: 1, stroke: 2pt + black),
  )
}

#[fsdfsd] <locatable-thingy>
#context gantt((
  (
    date: datetime(year: 2023, month: 1, day: 1),
    title: "fragment 1",
    project: "Project A",
    location: locate(<locatable-thingy>),
    step: "identify problem",
  ),
  (
    date: datetime(year: 2023, month: 1, day: 2),
    title: "fragment 2",
    project: "Project A",
    location: locate(<locatable-thingy>),
    step: "build",
  ),
  (
    date: datetime(year: 2023, month: 1, day: 2),
    title: "fragment 5",
    project: "Project A",
    location: locate(<locatable-thingy>),
    step: "test",
  ),
  (
    date: datetime(year: 2023, month: 1, day: 1),
    title: "fragment 3",
    project: "Project B",
    location: locate(<locatable-thingy>),
    step: "test",
  ),
  (
    date: datetime(year: 2023, month: 1, day: 3),
    title: "fragment 4",
    project: "Project B",
    location: locate(<locatable-thingy>),
    step: "brainstorming",
  ),
  (
    date: datetime(year: 2023, month: 1, day: 5),
    title: "fragment 6",
    project: "Project C",
    location: locate(<locatable-thingy>),
    step: "brainstorming",
  ),
))
// #import "@preview/timeliney:0.2.1"

// #timeliney.timeline(
//   show-grid: true,
//   {
//     import timeliney: *

//     headerline(group(([*2023*], 4)), group(([*2024*], 4)))
//     headerline(
//       group(..range(4).map(n => strong("Q" + str(n + 1)))),
//       group(..range(4).map(n => strong("Q" + str(n + 1)))),
//     )

//     taskgroup(title: [*Research*], {
//       task("Research the market", (0, 2), style: (stroke: 2pt + gray))
//       task("Conduct user surveys", (1, 3), style: (stroke: 2pt + gray))
//     })

//     taskgroup(title: [*Development*], {
//       task("Create mock-ups", (2, 3), style: (stroke: 2pt + gray))
//       task("Develop application", (3, 5), style: (stroke: 2pt + gray))
//       task("QA", (3.5, 6), style: (stroke: 2pt + gray))
//     })

//     taskgroup(title: [*Marketing*], {
//       task("Press demos", (3.5, 7), style: (stroke: 2pt + gray))
//       task("Social media advertising                 ", (6, 7.5), style: (stroke: 2pt + gray))
//     })

//     milestone(
//       at: 3.75,
//       style: (stroke: (dash: "dashed")),
//       align(center, [
//         *Conference demo*\
//         Dec 2023
//       ])
//     )

//     milestone(
//       at: 6.5,
//       style: (stroke: (dash: "dashed")),
//       align(center, [
//         *App store launch*\
//         Aug 2024
//       ])
//     )
//   }
// )
