#import "/import.typ": *


#body-entry.create(
  "Requirements for Motor Cartridge",
  "drivetrain",
  "identify problem",
  "Kairui Dai",
  datetime(year: 2025, month: 7, day: 9),
  witness: "Ryan Bhimani",
)[
  When selecting the appropriate #strong[motor cartridge] for the #strong[drivetrain] in this year's VEX Robotics competition, it is important to analyze both the #strong[game requirements] and the *robot's performance goals*. The drivetrain controls how fast and efficiently the robot can move around the field, so choosing the right motor cartridge directly affects overall strategy.

  = Key Requirements

  == *Game-Specific Demands*
  - This year's game requires fast movement between key scoring areas such as the *long goal* and *center goal*.
  - The ability to make *quick adjustments*—like parking or descoring—is critical.
  - Therefore, the drivetrain must prioritize *speed, acceleration*, and *responsiveness*.

  == *Motor Cartridge Options*
  - *100 RPM (Red)* – High torque, low speed
  - *200 RPM (Green)* – Balanced speed and torque
  - *600 RPM (Blue)* – High speed, low torque

  == *Desired Performance Outcomes*
  To meet the game’s challenges, the drivetrain must:
  - *Traverse the field quickly* to score and defend efficiently
  - *Accelerate quickly* to respond to sudden changes in gameplay
  - *Maintain control* during sharp turns or fast maneuvers
  - Avoid stalling, especially during pushing or tight situations


  == *Robot Weight and Design*
  - A *light to medium-weight robot* can safely use 600 RPM cartridges for maximum speed.
  - If the robot is heavy, using *external gear reduction* or switching to 200 RPM may be necessary to prevent motor stalls.
]

#body-entry.create(
  "Selecting Motor Cartridge for Drivetrain",
  "drivetrain",
  "select",
  "Kairui Dai",
  datetime(year: 2025, month: 7, day: 9),
  witness: "Ryan Bhimani",
)[

  #set text(size: 14pt)
  The following criteria was considered in the design matrix:

// TODO: add explanation/reference to old design matrice weights (ie. refer to this page for weights)

  == *Field Coverage Speed (Weight: 1)*
  - *What it is:* How quickly the drivetrain can move across the game field during normal gameplay.

  - *Why it matters:* Fast field coverage is essential for maximizing scoring opportunities and minimizing downtime between tasks. It combines top speed and acceleration in a real-game context.

  - *Used in:* Games with high movement demands, like retrieving/distributing game pieces or switching field sides.

  #table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr),
    rows: 7,
    inset: 10pt,
    table.header([*Criteria*], [*Weight*], [*100 RPM*], [*200 RPM*], [*600 RPM*]),
    [*Top Speed*], [1], [1], [3], [*5*],
    [*Accelerate*], [1], [2], [4], [*5*],
    [*Torque Output*], [0.6], [2], [4], [5],
    [*Control & Precision*], [0.8], [*5*], [4], [2],
    [*Field Coverage Speed*], [1], [1], [3], [*5*],
    [*Total*], [---], [11], [15], [17.2],
  )

  = Scoring Notes
  - *Scores range from 1 (worst) to 5 (best)* for each category
  - *Weight* reflects how important that criterion is for drivetrain performance in this year's game

  = Decision Reasoning
  
  // TODO: reference/link previous decision matrix weighting + field coverage explanation

  = Conclusion
  Despite its *lower torque and control*, the *600 RPM cartridge *ranks highest in this matrix due to:
  - Fastest *top speed*
  - Best for *quick field traversal*
  - Optimal in *speed-based game strategies*

]
