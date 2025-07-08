#set page(height: 1in, width: 2in, margin: .1in)

// TODO: Document
#let table-with-merged-rows(merge-columns: auto, debug: false, ..table-args) = {
  let columns = table-args.named().columns
  assert.eq(type(columns), array)

  let merge-columns = if merge-columns == auto { range(columns.len()) } else {
    merge-columns
  }
  assert.eq(type(merge-columns), array)
  for col in merge-columns { assert.eq(type(merge-columns), array) }

  let children = arguments(..table-args).pos()

  let rows = table-args.at("rows", default: auto)
  let rows = if type(rows) != array {
    (rows,) * int(children.len() / columns.len())
  } else { rows }

  let label-prefix = "781x-table-with-merged-rows-"
  let row-probe-label = label(label-prefix + "row-probe-label")
  let start-label = label(label-prefix + "start-label")
  let end-label = label(label-prefix + "end-label")

  let transpose(arr) = {
    assert.eq(type(arr), array)
    assert(arr.all(e => type(e) == array))
    assert(arr.all(e => e.len() == arr.first().len()))

    range(calc.max(..arr.map(row => row.len()))).map(row-i => arr
      .filter(row => row-i < row.len())
      .map(row => row.at(row-i)))
  }

  let group(arr) = {
    assert.eq(type(arr), array)

    arr.fold(((..arr.first(), len: 0),), (acc, e) => {
      if acc.last().body == e.body {
        (..acc.slice(0, -1), (..acc.last(), len: acc.last().len + 1))
      } else { (..acc, (..e, len: 1)) }
    })
  }
  let make-cell((..cell, x: _, y, body)) = {
    assert.eq(type(body), content)
    assert.eq(type(cell.rowspan), int)
    assert.eq(type(y), int)

    // TODO: Investigate whether a label with the row number in the id would be better (rather than in the metadata value)
    // TODO: Investigate perf impacts
    let get-page-of-y(y) = query(
      selector(row-probe-label)
        .after(query(selector(start-label).before(here())).last().location())
        .before(query(selector(end-label).after(here())).first().location()),
    )
      .find(e => e.value == y)
      .location()
      .page()

    let repeat-per-page(body) = context (
      (body,)
        * if cell.rowspan > 1 {
          get-page-of-y(y + cell.rowspan - 1) - get-page-of-y(y) + 1
        } else { 1 }
    ).join(colbreak())

    assert.eq(type(repeat-per-page(body)), content)
    table.cell(..cell, repeat-per-page(body))
  }

  let out-columns = (..columns, 0pt, ..if debug { (auto,) } else {})

  let (cell: cells, ..other-children) = children
    .map(e => {
      let func = e.func()
      let type = [
        #{
          if func == table.header { "header" } else if func == table.footer {
            "footer"
          } else if func == table.hline { "hline" } else if (
            func == table.vline
          ) { "vline" } else { "cell" }
        }
      ]
      return (type: type, child: e)
    })
    .fold((:), (acc, e) => {
      if e.type not in acc { acc.insert(e.type, ()) }
      acc.at(e.type).push(e.child)
      acc
    })
  let children-with-positions-by-row = cells
    .chunks(columns.len())
    .enumerate()
    .map(((y, row)) => row
      .enumerate()
      .map(((x, cell)) => (body: cell, x: x, y: y)))
  let probed-children-by-row = children-with-positions-by-row.map(row => {
    let y = row.first().y
    (
      ..row,
      (
        body: [#metadata((y)) #row-probe-label],
        rowspan: 1,
        x: row.len(),
        y: y,
      ),
    )
  })
  let children-by-col = transpose(probed-children-by-row)
  let grouped-children-by-col = children-by-col.map(col => if merge-columns.contains(
    col.first().x,
  ) {
    {
      group(col).map(cell => {
        let (..out-cell, len: _) = (..cell, rowspan: cell.len)
        return out-cell
      })
    }
  } else {
    col.map(e => (..e, rowspan: 1))
  })
  let grouped-children-by-row = grouped-children-by-col
    .flatten()
    .map(cell => cell.y)
    .sorted()
    .dedup()
    .map(y => {
      grouped-children-by-col.flatten().filter(cell => cell.y == y)
    })

  let merged-children = grouped-children-by-row.map(col => col.map(make-cell))


  let out-children = (
    // TODO: Properly handle `other-children`
    other-children.values().flatten()
      + if debug {
        merged-children.map(e => (
          e
            + (
              box(
                context str(
                  query(
                    selector(row-probe-label)
                      .after(
                        query(selector(start-label).before(here()))
                          .last()
                          .location(),
                      )
                      .before(here()),
                  )
                    .last()
                    .value,
                ),
                clip: true,
              ),
            )
        ))
      } else { merged-children }.flatten()
  )

  [#metadata(none) #start-label]
  table(
    ..table-args.named(),
    ..out-children,
    columns: out-columns,
  )
  [#metadata(none) #end-label]
}

#table-with-merged-rows(
  columns: (auto, 1fr, 1fr),
  merge-columns: (0,),
  // debug: true,
  table.header([H0], [H1], [H2]),
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
)
