#let include-entries() = {
  import "/lib/themes/dark-matter/theme.typ": body-entry
  (body-entry.standalone-mode.disable)()
  for entry in json("./entries.json") {
    include entry
  }
}
