#import "@preview/cineca:0.5.0": *

#import "/import.typ": *

#body-entry.create(
  "July Calendar",
  "Monthly Calendars",
  "project management",
  "Juliana Curtis",
  datetime(year: 2025, month: 7, day: 8),
  witness: "Andrew Curtis and Shreyas Bhatt",
)[

// TODO: fix calendar to have brief meeting goals/notes and include minutes

#let events2 = (
  (datetime(year: 2025, month: 7, day: 8, hour: 10, minute: 30, second: 0), ([Meeting], red)),
  (datetime(year: 2025, month: 7, day: 9, hour: 10, minute: 30, second: 0), ([Meeting], red)),
  (datetime(year: 2025, month: 7, day: 20, hour: 10, minute: 30, second: 0), ([Meeting], red)),
   (datetime(year: 2025, month: 7, day: 27, hour: 10, minute: 30, second: 0), ([Meeting], red)),
   (datetime(year: 2025, month: 7, day: 16, hour: 7, minute: 0, second: 0), ([First Day of School], green)),
)

#calendar-month(
  events2,
  sunday-first: true,
  rows: (2em,) * 2 + (5em,),
  template: (
    day-body: (day, events) => {
      show: block.with(width: 100%, height: 100%, inset: 2pt)
      set align(left + top)
      stack(
        spacing: 2pt,
        pad(bottom: 4pt, text(weight: "bold", day.display("[day]"))),
        ..events.map(((d, e)) => {
          let col = if type(e) == array and e.len() > 1 { e.at(1) } else { yellow }
          show: block.with(
            fill: col.lighten(45%),
            stroke: col,
            width: 100%,
            inset: 2pt,
            radius: 2pt
          )
          d.display("[hour]")
          h(4pt)
          if type(e) == array { e.at(0) } else { e }
        })
      )
    }
  )
)

]