#import "/import.typ": *

#body-entry.create(
  "Requirements for Drivetrain Structure",
  "drivetrain",
  "identify problem",
  "Juliana Curtis",
  datetime(year: 2025, month: 7, day: 9),
  witness: "Kairui Dai",
)[




]


#body-entry.create(
  "Drivetrain Structures",
  "drivetrain",
  "brainstorm",
  "Juliana Curtis",
  datetime(year: 2025, month: 7, day: 9),
  witness: "Kairui Dai",
)[

  There are many different drivetrain structures that can be considered, some of which will be excluded (kiwi, asterix, and swivel) due to their lack of suitability for this year's game. The drivetrain structures that we are considering for this robot are of the following:

  #grid(columns: (1fr, 1fr))[
    - Tank Drive
    - H Drive
  ][
    - X Drive
    - Mecanum Drive
  ]

  === Key
  #grid(columns: (1fr, 1fr))[
    - Black Rectangles - Motors
    - Red Rectangles - Gears
    - Grey Rectangles - Omni/Traction Wheels
  ][
    - Green Rectangles - Mecanum Wheels
    - Light Grey Rectangles - Metal Structure
  ]


  #table(
    columns: (0.4fr, 1fr),
    rows: 4,
    inset: 10pt,

    [#figure(image("tankdrive.png"), caption: [Tank Drive drawn by Shreyas Bhatt on Excalidraw])],

    [
      Pros
      - More power allocated to the drive
      - Simple to construct
      - Easy to program and to drive

      Cons
      - No omni directional movement
    ],

    [#figure(image("xdrive.png"), caption: [X Drive drawn by Shreyas Bhatt on Excalidraw])],

    [
      Pros
      - Very mobile with its turning capabilities
      - Takes up minimal space
      - More speed than tank drive

      Cons
      - Hard to align
      - More difficult to program and to drive effectively
      - Has less power than a tank drive
    ],

    [#figure(image("hdrive.png"), caption: [H Drive drawn by Shreyas Bhatt on Excalidraw])],

    [
      Pros
      - Retains most of the structure of the tank drive
      - Has omni directional movement
      - More mobile than tank drive

      Cons
      - Has less power for horizontal movement
      - Uses and extra motor
      - Easy to push around
    ],

    [#figure(image("mecanumdrive.png"), caption: [Mecanum Drive drawn by Shreyas Bhatt on Excalidraw])],

    [
      Pros
      - Very mobile, with multiple possibilities of movement

      Cons
      - Wheels don’t work all that well
      - Extremely hard to program and to drive
    ],
  )


]
