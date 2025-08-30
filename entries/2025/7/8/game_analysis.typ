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


]
