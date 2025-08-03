#import "/import.typ": *
#show figure.caption: set text(size: 8pt)

#body-entry.create(
  "Requirements for Wheel & Gear Configuration",
  "drivetrain",
  "identify problem",
  "Kairui Dai",
  datetime(year: 2025, month: 7, day: 8),
)[

When designing a competitive drivetrain for this year's VEX Robotics competition, it's crucial to carefully select both the gear ratio and wheel configuration. These two factors significantly impact speed, torque, acceleration, stability, and the robot's ability to interact with game elements and the field.

= Key Considerations
== Game Field Considerations
  - *Flat surfaces:* This year's game field is mostly flat, which supports high-speed wheel configurations.
  - *Barriers and obstacles:* If minor bumps exist, wheel size and ground clearance become more important.

== Game Strategy & Movement Requirements
  - Frequent traversal between scoring zones
  - Agile repositioning for defense or descoring
  - Precise alignment for scoring
  - Consistent, reliable speed and turning control
This year's strategy demands a drivetrain that is optimized for *speed, maneuverability*, and *quick response*, with enough *torque* to hold ground when needed.
== Robot Weight
  - *Light robots* can use faster gear ratios and smaller wheels

  - *Heavier robots* benefit from torque-oriented gearing and traction wheels to prevent stalling
= Desired Performance Outcomes
== To meet this year’s game challenges, the drivetrain must:
- Maintain *high speed* across the field
- Turn and strafe quickly for accurate positioning
- Avoid slippage or stalling during contact with other robots
- Adapt smoothly to different gameplay scenarios
]

#body-entry.create(
  "Wheel & Gear Configurations",
  "drivetrain",
  "brainstorm",
  "Kairui Dai",
  datetime(year: 2025, month: 7, day: 8),
)[

  There are many possible wheel and gear configurations possible, however only a few options are viable for a reasonable amount of speed and torque. The wheel and gear configurations that we are considering for this robot are of the following:
  #grid(columns: (1fr, 1fr))[
    - 360 rpm on 3.25 in wheels
    - 450 rpm on 2.75 in wheels
    - 450 rpm on 3.25 in wheels
  ][
    - 480 rpm on 2.75 in wheels
    - 480 rpm on 3.25 in wheels
    - 600 rpm on 2.75 in wheels
  ]

  #table(columns: (0.75fr, 1fr), rows: 6, inset: 10pt,
    [#figure(image("360 on 3.25.png"), caption: [360 rpm on 3.25 in Drive from Vex Robotics Drivebase Tutorial by 9MotorGang on Youtube])], [edef], [#figure(image("450_2.75_finished.png"), caption: [450 rpm on 2.75 by Owen 16610A on Discord])]
  ))

]