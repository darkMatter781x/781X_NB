#import "/import.typ": *

#show: codly-init.with()
#codly(languages: codly-languages)

#set par(justify: true, linebreaks: "optimized")
#show figure.caption: emph
// #show math.equation: set text(font: "Fira Math")
#set raw(theme: "/assets/MyLight.tmTheme")
#show raw.where().and(label("code")): set text(size: 9pt)
#show raw: set text(font: "Monaspace Neon", ligatures: true)
#set math.mat(delim: "[")
#set math.vec(delim: "[")

#theme.initialize()

#import "entries/entries.typ": include-entries
#include-entries()