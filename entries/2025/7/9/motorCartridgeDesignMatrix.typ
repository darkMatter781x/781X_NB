#import "/import.typ": *


#body-entry.create(
  "Requirements for Motor Cartridge",
  "drivetrain",
  "identify problem",
  "Kairui Dai",
  datetime(year: 2025, month: 7, day: 9),
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
  witness: "Ryan Bhimani"
)[

  #set text(size: 14pt)
  The following criteria was considered in the design matrix:

  == *Top Speed (Weight: 1)*
  - *What it is:* The maximum speed the drivetrain can reach.

  - *Why it matters:* In fast-paced games, top speed allows your robot to quickly move between key zones (e.g., goals, parking zones, scoring areas). A higher top speed reduces travel time and increases scoring cycles.

  - *Used in:* Games with a large field, multiple scoring zones, or limited match time.

  == *Acceleration (Weight: 1)*
  - *What it is:* How quickly the drivetrain reaches its top speed.

  - *Why it matters:* A robot with strong acceleration can respond faster to changes in gameplay, like dodging an opponent, contesting a goal, or switching directions. This is crucial for real-time strategic plays.

  - *Used in:* Defense, racing to contested goals, or sudden tactical moves like endgame parking.

  == *Torque Output (Weight: 0.6)*
  - *What it is:* The amount of rotational force the motor provides.

  - *Why it matters:* High torque is essential for pushing other robots, moving heavy game elements, or driving over resistance (like field barriers). If torque is too low, the robot may stall under pressure.

  - *Used in:* Pushing, defense, lifting, or heavy robot frames.


  == *Control & Precision (Weight: 0.8)*
  - *What it is:* How easy it is to drive or program the robot for accurate, smooth movements.

  - *Why it matters:* Robots need precise control when navigating tight spaces, turning accurately, or aligning with goals. Faster motors can be harder to control without tuning.

  - *Used in:* Autonomous routines, alignment with goals, or narrow pathways on the field.

  == *Field Coverage Speed (Weight: 1)*
  - *What it is:* How quickly the drivetrain can move across the game field during normal gameplay.

  - *Why it matters:* Fast field coverage is essential for maximizing scoring opportunities and minimizing downtime between tasks. It combines top speed and acceleration in a real-game context.

  - *Used in:* Games with high movement demands, like retrieving/distributing game pieces or switching field sides.

  #colbreak()

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
  We weighted the categories of top speed, acceleration, control, and field coverage speed the highest because, based on our game analysis (see page [insert page number here]), we determined that a fast robot is essential for effectively controlling both the long goal and the center goal. Additionally, high speed is critical for making split-second decisions, such as parking, descoring, or preventing a descore by the opposing team.

  In contrast, we assigned lower weights to torque output and control & precision, as they are less important in this year's game. As stated in our game analysis (see page [insert page number here]), all game elements are relatively lightweight, so the drivetrain does not require a high amount of torque to perform effectively. The need for precision is also reduced, since we can improve the robot's accuracy using hardware solutions like aligners, allowing us to deprioritize software-based precision control.

  = Conclusion
  Despite its *lower torque and control*, the *600 RPM cartridge *ranks highest in this matrix due to:
  - Fastest *top speed*
  - Best for *quick field traversal*
  - Optimal in *speed-based game strategies*

]
