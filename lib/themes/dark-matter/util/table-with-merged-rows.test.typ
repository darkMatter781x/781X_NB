#import "./table-with-merged-rows.typ": table-with-merged-rows

#set page(height: 1in + 1em, width: 4in, margin: .1in)

#let typ = 1;

#let table-args = arguments(
  columns: (auto, 1fr, 1fr),
  // merge-columns: (0,),
  stroke: 0pt,
  // debug: true,
  table.header([H0], [H1], [H2]),
  // table.hline(stroke: 1pt),
  [hi],
  [fd],
  [fd1],
  [hi],
  [blah],
  [fd2],
  [hi],
  [fd],
  [fd1],
  [hi],
  [blah],
  [fd2],
  [hi],
  [blah],
  [fd3],
  [hi],
  [jfdd],
  [fd4],
  [hi],
  [jhjf],
  [fd5],
  [hi],
  [jhjf],
  [fd6],
  // table.footer([f1], [f2], [f3]),
)
#grid(
  columns: 2,
  grid.header(align(center)[table-with-merged-rows], align(center)[table]),
)[
  #table-with-merged-rows(..table-args)
][
  #table(..table-args)
]
