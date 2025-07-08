/// Includes imports and styles for the docs.typ file.
/// The intention of this file is to hide the boilerplate code from the main docs.typ file.

// TODO: Share these styles with the theme to avoid duplication.
#import "/import.typ": *

#let prelude-init(body) = {
  // Use codly for code blocks
  show: codly-init.with()
  codly(languages: codly-languages)

  // Set text font size and family
  set text(size: 15pt, kerning: true, font: "Calibri")
  // Set paragraph style
  set par(justify: true, linebreaks: "optimized")
  // Make figure captions italic
  show figure.caption: emph
  // Set code theme
  set raw(theme: "/assets/MyLight.tmTheme")
  // Reduce font size for code blocks
  show raw.where().and(label("code")): set text(size: 9pt)
  // Set code font and enable ligatures
  show raw: set text(font: "Monaspace Neon", ligatures: true)

  body
}
