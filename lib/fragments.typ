/// Dictionary that should contain all the fragments in the notebook.
///
/// Each value in the array should be a dictionary with at least the following keys:
/// - `section`: str - The section of the fragment.
/// - `display`: content - The fragment's content.
/// - `sort-key`: any - A key to be used for sorting the fragments in a section.
#let fragments-state = state("notebook_fragments", ())

#let create-fragment(fragment) = {
  assert.eq(type(fragment), dictionary)
  assert("section" in fragment)
  assert.eq(type(fragment.section), str)
  assert("sort-key" in fragment)
  assert.ne(type(fragment.sort-key), none)
  assert("body" in fragment)
  assert.eq(type(fragment.body), content)

  // Add the fragment to the section
  fragments-state.update(x => if type(x) == array {
    x + (fragment,)
  } else { (fragment,) })
}

#let display-fragments(sections) = context {
  assert.eq(type(sections), array)
  assert(sections.all(s => type(s) == dictionary))
  assert(sections.all(s => "id" in s))
  assert(sections.all(s => type(s.id) == str))
  assert(sections.all(s => "start-content" in s))
  assert(sections.all(s => type(s.start-content) == content))

  let all-fragments = fragments-state.final()
  for (id: section-id, start-content) in sections {
    start-content
    for fragment in all-fragments.filter(e => e.section == section-id).sorted(key: e => e.sort-key) {
      fragment.body
    }
  }
}
