#import "/import.typ": *

#body-entry.create(
  "Game Overview",
  "Game Analysis",
  "identify problem",
  "Shreyas Bhatt",
  datetime(year: 2025, month: 7, day: 8),
  witness: "Juliana Curtis",
)[

  This year’s game for the VEX Robotics Competition is Push Back.

  #box(
    height: 130pt,
    clip: true,
    [#figure(
      image("pbblocks.png", width: 8in),
      caption: [Red and Blue Blocks, the main scoring objects in VRC Push Back],
    )],

    //TODO: fix caption on block image
  )

  === Game Objectives:
  - Place blocks into goals
  - Maintain control bonuses
  - In the endgame, park your robot in the park zones
    - Even better if both robots on an alliance can park

  == Field Layout
  - In a V5RC Push Back match, there are a total of 88 blocks:
    - *30 blocks* start on the field
      - According to the figure above, 24 blocks start in the match loaders (3 in each)
      - 36 start in *predetermined field locations* (18 blue, 18 red)
    - 14 Introducible blocks
      - 4 preloads (2 blue, 2 red)
      - 24 match loads (12 blue, 12 red)
  - Park Zones (1 blue, 1 red)
    - Enclosed area with *ramps facing inwards*
  - Goals
    - 2 Long Goals on opposite sides of the field
      - *Max of 15 blocks*
    - 2 Center Goals
      - 1 Upper Goal
        - Max of 7 blocks
      - 1 Lower Goal
        - Max of 7 blocks
  - Match Loader *in each corner* of the field (2 blue, 2 red)
    - Max of 6 blocks
  - VEX Field
    - 12’ x 12’ field, with a metal or plastic border
      - 6 x 6 grid of 24” foam field tiles

  == Game Object Analysis
  Blocks, the main game objects, as seen in Figure 1.1, are the primary source of points in a VRC Push Back match. Therefore, we came to the following early-season conclusions on the importance of the block.
  - Maintaining blocks in goals is going to be a large challenge due to:
    - The low *coefficient of static friction*
    - The lack of legal protection
    - *4 goals to focus on for only 2 robots*
  - Due to this, scoring is also difficult because it must be done very quickly to avoid losing control. Issues may appear when:
    - *Aligning the robot*
      - This was found to be a problem during High Stakes while scoring on wall stakes and climbing the ladder
    - Inserting blocks into the goal

#let image-width=2.86in

#grid(
    columns: (1fr, image-width),
    inset: 0.5em,
    [
    - Intaking different orientations of blocks
      - A block is an 18 sided object with a maximum diameter of 3.84” and a minimum of 3.23”, so the *sides have different face shapes*
      - The medium size limits the ability to possess an excess of blocks
    - The long goals have a minimum diameter of 3.61” which is smaller than the maximum diameter of the block, meaning when scored, they *have to be oriented very specifically*
    - We also have to *raise the blocks up* to the height of the goal

    ],
    [
      #figure(image("block_dimensions.png"), caption: [Block dimensions from the V5RC Game Manual])
    ]
)

#figure(image("longgoal_dimensions.png", width: 70%),
caption: [Long Goal Dimensions from V5RC Game Manual])

== Point Value Analysis
In a VRC Push Back match, points may be scored in the following ways:

- A block is placed in…
  - A Long Goal
  - A Center Goal
- In the endgame, a robot parks in the Park Zone
- The alliance wins the autonomous bonus

=== Point Breakdown

  #figure(table(
    columns: (1.1fr, 0.8fr, 1.25fr, 1.5fr),
    rows: 8,
    inset: 10pt,
    table.header([], [*Point Value*], [*Total Object Amount*], [*Maximum Points Possible*]), 

    [Block Scored], [3], [44], [132],
    
    [Controlled Zone in a Long Goal], [10],
    [2], [20],
    
    [Controlled Center Goal - Upper], [8], [1], [8],
    
    [Controlled Center Goal - Lower], [6], [1], [6],
    
    [2 Parked Robots], [30], [1], [30],
    
    [Autonomous Bonus], [10], [1], [30],
    
    [Highest Score Possible], [], [], [*206*],
  ),
  
caption: [Point Breakdown of Each Scoring Method in Push Back. Highest possible score assumes all blocks are scored in the Goals])

As seen in Table 1, scoring blocks goals hold the highest proportion of total
score in a Push Back match.
- If an alliance scores all 44 blocks, the maximum amount, in the goals, the 132 points is 64% of the 206 total possible score.
  - Based on this, it should be a priority for a team to score Triballs in an alliance
goal.




]

#body-entry.create(
  "Important Game Rules",
  "Game Analysis",
  "identify problem",
  "Juliana Curtis",
  datetime(year: 2025, month: 7, day: 8),
  witness: "Kairui Dai",
)[

// TODO: Make sure game overview and game rules are on different pages althoigh on the same date

- *`<SG2>`* and *`<SG3>`* - Horizontal and vertical expansion is limited
  - Robots cannot exceed 22" at any point in any direction
    - Robots must be able to fit inside a hypothetical *22"x22"x22"* box
    - Since the field is crowded with goals, we'd like to be able to *go under the long goals* which limits our height
    - Since the double park is more than triple the points of a normal park (1 robot), our width is limited to *fit the parking space*

- *`<SG6>`* - Robots may interact with/hold an unlimited number of blocks
  - Unlike previous years, the possession limit in Push Back is unlimited
    - This means that *robots can stockpile blocks*, whether it be their own or the opposing alliance's
      - Stockpiling your own could be useful for the worst case scenario or dispensing all of them at the end for a control bonus/points
      - Stockpiling others' could useful to prevent them from scoring points

- *`<SG11>`* - Park Zones are protected during the endgame
  - During the last 20 seconds of a match, robots may not contact the other alliance's Park Zone or the robots parked in that Zone
    - This is similar to the elevation protection in High Stakes which caused robots to only park during the endgame
    - This could also provide *more time for complicated mechanisms/systems for double parking*

- *`<R25>`* - A limited amount of custom plastic is allowed
  - Unlike previous years, the plastic limit has changed to 12 individual pieces which cannot be larger than 4" x 8" each
    - This means that *plastic use must be intentional* and can no longer be used on large scales for bracing
    - This also means we cannot use it to solve small mounting problems
  


]