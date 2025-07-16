#let include-entries() = {
  import "/lib/themes/dark-matter/theme.typ": body-entry
  for entry in json("./entries.json") {
    include entry
  }
}
