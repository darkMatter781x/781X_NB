#set page(height: 1in + 1em, width: 4in, margin: .1in)

/// Merges cells with the same content that are consecutive in the same column.
///
/// See `./table-with-merged-rows.test.typ` for usage examples.
///
/// = Undefined behavior if:
/// - Any of the cells have a x or y parameter.
/// - The content of a merged cell doesn't fit on one page.
#let table-with-merged-rows(merge-columns: auto, debug: false, ..table-args) = {
  let columns = table-args.named().columns
  assert.eq(type(columns), array)

  let merge-columns = if merge-columns == auto { range(columns.len()) } else { merge-columns }
  assert.eq(type(merge-columns), array)
  for col in merge-columns { assert.eq(type(merge-columns), array) }

  let children = arguments(..table-args).pos()

  let rows = table-args.at("rows", default: auto)
  let rows = if type(rows) != array { (rows,) * int(children.len() / columns.len()) } else { rows }

  let label-prefix = "781x-table-with-merged-rows-"
  let row-probe-label = label(label-prefix + "row-probe-label")
  let start-label = label(label-prefix + "start-label")
  let end-label = label(label-prefix + "end-label")

  let transpose(arr) = {
    assert.eq(type(arr), array)
    assert(arr.all(e => type(e) == array))
    assert(arr.all(e => e.len() == arr.first().len()))

    if (arr.len() == 0) { return () }

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

    let (body, cell-args) = if body.func() == table.cell {
      let real-body = body.body
      let (..body-args, body: _) = body.fields()
      (body.body, (..body-args, ..cell, rowspan: cell.rowspan))
    } else {
      (body, cell)
    }


    // TODO: Investigate whether a label with the row number in the id would be better (rather than in the metadata value)
    // TODO: Investigate perf impacts
    let get-page-of-y(y) = query(selector(row-probe-label)
      .after(query(selector(start-label).before(here())).last().location())
      .before(query(selector(end-label).after(here())).first().location()))
      .find(e => e.value == y)
      .location()
      .page()

    let repeat-per-page(body) = context (
      (body,) * if cell-args.rowspan > 1 { get-page-of-y(y + cell-args.rowspan - 1) - get-page-of-y(y) + 1 } else { 1 }
    ).join(colbreak())

    assert.eq(type(repeat-per-page(body)), content)

    table.cell(..cell-args, repeat-per-page(body))
  }

  let out-columns = (..columns, 0pt, ..if debug { (auto,) } else {})

  let sorted-children = {
    let types = (
      "header": (check: func => func == table.header),
      "footer": (check: func => func == table.footer),
      "hlines": (check: func => func == table.hline),
      "vlines": (check: func => func == table.vline),
      "cells": (check: _ => true),
    )
    let sorted = types.keys().map(type => (type, ())).to-dict()
    for (i, child) in children.enumerate() {
      let type = if type(child) == content {
        let func = child.func()
        types.pairs().find(((_, (check,))) => check(func)).at(0)
      } else { "cells" }
      sorted.at(type).push((arg-i: i, value: child))
    }
    assert(sorted.header.len() <= 1, message: "cannot have more than one header")
    assert(sorted.footer.len() <= 1, message: "cannot have more than one footer")

    sorted
  }

  let cells-with-positions-by-row = sorted-children
    .cells
    .chunks(columns.len())
    .enumerate()
    .map(((y, row)) => row.enumerate().map(((x, (value: cell, arg-i))) => (body: cell, arg-i: arg-i, x: x, y: y)))
  let probed-cells-by-row = cells-with-positions-by-row.map(row => {
    let y = row.first().y
    (
      ..row,
      (
        body: [#metadata((y)) #row-probe-label],
        rowspan: 1,
        x: row.len(),
        y: y,
        arg-i: none,
      ),
    )
  })
  let cells-by-col = transpose(probed-cells-by-row)
  let grouped-cells-by-col = cells-by-col.map(col => if merge-columns.contains(col.first().x) {
    {
      group(col).map(cell => {
        let (..out-cell, len: _) = (..cell, rowspan: cell.len)
        return out-cell
      })
    }
  } else {
    col.map(e => (..e, rowspan: 1))
  })
  let grouped-cells-by-row = grouped-cells-by-col
    .flatten()
    .map(cell => cell.y)
    .sorted()
    .dedup()
    .map(y => {
      grouped-cells-by-col.flatten().filter(cell => cell.y == y)
    })

  let out-cells = {
    let cells = grouped-cells-by-row.map(col => col.map(cell => {
      let (..param, arg-i: _) = cell
      return make-cell(param)
    }))
    if debug {
      cells.map(e => (
        e
          + (
            box(
              context str(
                query(selector(row-probe-label)
                  .after(query(selector(start-label).before(here())).last().location())
                  .before(here()))
                  .last()
                  .value,
              ),
              clip: true,
            ),
          )
      ))
    } else { cells }
  }.flatten()

  let out-lines = {
    let sorted-cells = cells-with-positions-by-row.flatten().sorted(key: ((arg-i,)) => arg-i).rev()
    let header-exists = sorted-children.header.len() > 0
    let footer-exists = sorted-children.footer.len() > 0
    let get-prev-cell(arg-i) = sorted-cells.find(((arg-i: other-i)) => other-i < arg-i)

    let is-before-header(arg-i) = header-exists and arg-i < sorted-children.header.at(0).arg-i
    let is-after-footer(arg-i) = footer-exists and arg-i > sorted-children.footer.at(0).arg-i
    (
      h: {
        let get-y(arg-i) = {
          if is-before-header(arg-i) {
            // hline is before the header
            0
          } else {
            (
              if is-after-footer(arg-i) {
                // hline is after the footer
                int(sorted-children.cells.len() / columns.len())
              } else {
                let prev-cell = get-prev-cell(arg-i)

                if prev-cell == none { -1 } else { prev-cell.y }
              }
                + 1 // hline is always after the previous cell
                + int(header-exists) // if header exists, add 1 to the y value
            )
          }
        }

        sorted-children.hlines.map(((arg-i, value)) => {
          table.hline(y: get-y(arg-i), ..value.fields())
        })
      },
      v: {
        let get-x(arg-i) = {
          let max-x = columns.len()
          if is-after-footer(arg-i) { max-x } else {
            let prev-cell = get-prev-cell(arg-i)
            if prev-cell == none {
              if header-exists and not is-before-header(arg-i) {
                max-x // vline is after the header
              } else { 0 } // vline is before the header or there is no header
            } else { prev-cell.x + 1 }
          }
        }

        sorted-children.vlines.map(((arg-i, value)) => {
          table.vline(x: get-x(arg-i), ..value.fields())
        })
      },
    )
  }

  let out-children = (
    sorted-children.header.map(h => h.value)
      + out-cells
      + sorted-children.footer.map(f => f.value)
      + out-lines.h
      + out-lines.v
  )

  [#metadata(none) #start-label]
  table(
    ..table-args.named(),
    ..out-children,
    columns: out-columns,
  )
  [#metadata(none) #end-label]
}
