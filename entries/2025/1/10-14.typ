#import "/import.typ": *

#for i in range(0, 15) {
  body-entry.create(
    "Entry " + str(i),
    "Project " + str(calc.rem(i, 5)),
    ("identify problem", "brainstorm", "select", "build", "test", "compete").at(calc.rem(i, 6)),
    range(0, calc.rem(i, 3) + 1).map(j => "Author " + str(j)),
    datetime(year: 2023, day: 10 + calc.rem(i, 4), month: 1),
    witness: "Witness",
  )[#lorem((i + 1) * 10)]
}
