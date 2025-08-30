#import "/import.typ": *
#show figure.caption: set text(size: 8pt)

#body-entry.create(
  "Requirements for Wheel and Gear Configuration",
  "drivetrain",
  "identify problem",
  "Kairui Dai",
  datetime(year: 2025, month: 7, day: 8),
  witness: "Shreyas Bhatt",
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
  "Wheel and Gear Configurations",
  "drivetrain",
  "brainstorm",
  "Kairui Dai",
  datetime(year: 2025, month: 7, day: 8),
  witness: "Shreyas Bhatt",
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

  #table(
    columns: (0.8fr, 1fr),
    rows: 6,
    inset: 10pt,
    [#figure(
      image("360 on 3.25.png"),
      caption: [360 rpm on 3.25 in Drive from Vex Robotics Drivebase Tutorial by 9MotorGang on Youtube],
    )],

    [
      - Achieved by gearing down a 600 rpm motor cartridge with a *36:60 gear ratio*
      - This setup produces the *highest torque output* among the six available options, making it ideal for pushing, pulling, and defense
      - However, it also results in the *lowest rotational speed*, making it the *slowest option*
      - The speed and torque highlights its suitability for playing and resisting defense

    ],

    [#figure(image("450_2.75_finished.png"), caption: [450 rpm on 2.75 by Owen 16610A on Discord])],
    [
      - Achieved by gearing down a 600 rpm motor cartridge with a *36:48 gear ratio*
      - This configuration produces the *second highest torque output* among the six options, which also allows it to be viable for pushing, pulling, and defense
      - This configuration is faster than 360 rpm on 3.25, however it is *not much faster*
      - Similar to 360, where it is suitable for playing and resisting defense while being fast enough to maneuver the field

    ],

    [#figure(image("450 on 3.25.png"), caption: [450 rpm on 3.25 by Greyson 654J on Discord])],
    [
      // TODO: crop the drivetrain reference images

      - Achieved by gearing down a 600 rpm motor cartridge with a *36:48 gear ratio*
      - Among the 6 configurations we are considering, this configuration is in the *middle* when talking about torque output and rotational speed
      - This configuration allows for a *mixed playstyle*, allowing for both defence play, while being agile to easily maneuver around the field

    ],

    [#figure(image("480 on 3.25.png"), caption: [480 rpm on 3.25 by Greyson 654J on Discord])],

    [
      - Achieved by gearing down a 600 rpm motor cartridge with a *48:60 gear ratio*
      - This drivetrain configuration has the *second highest* rotational speed among the 6 configurations
      - This results in the drivetrain also having the *second lowest* torque output
      - This configuration specializes with *quickly maneuvering* around the field, mainly making *offensive* plays
    ],

    [#figure(image("480 on 2.75.png"), caption: [480 rpm on 2.75 by 7996R on Discord])],

    [
      - Achieved by gearing down a 600 rpm motor cartridge using a *48:60 gear ratio*
      - This drivetrain configuration is in the *middle* respective to the other six drivetrains similar to 450 on 3.25
      - This configuration allows for a *mixed playstyle*, allowing for both defence play, while being agile to easily maneuver around the field
    ],

    [#figure(image("600 on 2.75.png"), caption: [600 rpm on 2.75 by Franklin 2971B on Discord])],

    [
      - Achieved by gearing down a 600 rpm motor cartridge with a *36:36 gear ratio*
      - This drivetrain configuration has the *highest* rotational speed among the 6 configurations
      - This results in the drivetrain also having the *lowest* torque output
      - This configuration specializes with *quickly maneuvering* around the field, mainly making *offensive* plays similar to 480 on 3.25
    ],
  )

]

#body-entry.create(
  "Picking Wheel and Gear Configurations",
  "drivetrain",
  "select",
  "Kairui Dai",
  datetime(year: 2025, month: 7, day: 8),
  witness: "Shreyas Bhatt",
)[

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

  #colbreak()

  #table(
    columns: (auto, 1fr, 1fr, 1fr, 1fr, 1fr),
    rows: 7,
    inset: 10pt,
    table.header([*Configuration*], [*Speed (1)*], [*Acceleration (1)*], [*Torque (0.6)*], [*Control (0.8)*], [*Total*]), 

    [600 rpm - 2.75"], [5 - > 5.0], [5 - > 5.0], [2 - > 1.2], [2 - > 1.6], [*12.8*],
    
    [480 rpm - 3.25"], [4 - > 4.0], [4 - > 4.0], [2 - > 1.2], [3 - > 2.4], [*11.6*],
    
    [450 rpm - 3.25"], [3 - > 3.0], [3 - > 3.0], [3 - > 1.8], [4 - > 3.2], [*11.0*],
    
    [480 rpm - 2.75"], [2 - > 2.0], [2 - > 2.0], [4 - > 2.4], [4 - > 3.2], [*9.6*],
    
    [450 rpm - 2.75"], [1 - > 1.0], [1 - > 1.0], [5 - > 3.0], [5 - > 4.0], [*9.0*],

    [360 rpm - 3.25"], [1 - > 1.0], [1 - > 1.0], [5 - > 3.0], [ 5 - > 4.0], [*9.0*]
  )

= Scoring Notes
- *Scores range from 1 (worst) to 5 (best)* for each category
- *Weight* reflects how important that criterion is for drivetrain performance in this `year’s` game
  - Higher weight = more important

= Decision Reasoning

// TODO: add reference for where in the game analysis we mention a need for speed

We weighted the categories of *top speed, acceleration*, and *control* the highest because, based on our game analysis (see page), we determined that a fast robot is essential for effectively controlling both the *long goal* and the *center goal*. Additionally, high speed is critical for making *split-second decisions*, such as *parking*, *descoring*, or *preventing a descore* by the opposing alliance.

In contrast, we assigned *lower weights* to *torque output* and *control & precision*, as they are less important in this year’s game. As stated in our game analysis (see page), all game elements are relatively *lightweight*, so the drivetrain does not require a high amount of torque to perform effectively. The need for precision is also reduced, since we can improve the robot’s accuracy using *hardware solutions* like *aligners*, allowing us to deprioritize software-based precision control.

= Conclusion
Despite its *lower torque and control*, the drivetrain configuration *600 rpm on 2.75"* ranks highest in this matrix due to:

- Fastest *top speed*

- Best for *quick field traversal*

- Optimal in *speed-based game strategies*


]
