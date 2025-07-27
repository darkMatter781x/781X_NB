#import "/import.typ": *

#body-entry.create(
  "Team Overview",
  "Introduction",
  /* TODO: make a step for non design process entries */ "build",
  "Juliana Curtis",
  datetime(year: 2025, month: 7, day: 8),
)[

  #let create-appendix = none


  // This season, our team consists of 6 people. All of our team members have worked together at some point in VEX VRC. Andrew, Shreyas, and Neil started Dark Matter in 2022 whereas Kairui and Juliana joined in 2024, Ryan following this year. Shreyas, Neil, Kairui, and Ryan all participated in VEX VRC during their time at ACP Middle, so they have been on teams together. Combined, we total 22 years of experience in VRC and our team specifically has gone to Worlds twice along with all of our ACP members having gone at least once during middle school. In the past, we have had three, four, and five members on the team, but this is our first year of having six people, so we aspire to balance out the team dynamics as we work together.

  #let image-width = 2.45in;

  #grid(
    columns: (1fr, image-width),
    inset: 0.5em,
    [
      #grid(
        columns: (1fr, 1fr),
        [
          // TODO: fix header to look more appealing
          = Andrew Curtis
          - 12th Grade
          - 4 years of experience
          - 4th year on Dark Matter
        ],
        [
          #underline[Jobs:]
          - Coder
          - Mathematician
        ],
      )

      Andrew is our programmer and has been well versed with the world of programming in real world scenarios. Andrew has taken last year to build some code elements like Monte Carlo Localization
    ],
    // TODO: change image to real andrew
    figure(image("andrew.png"), caption: ["andrew"]),
  )
  #grid(
    columns: (image-width, 1fr),
    inset: 0.5em,

    (image("andrew.png")),

    [
      #grid(
        columns: (1fr, 1fr),
        [
          = Neil Joshi
          - 12th Grade
          - 6 years of experience
          - 4th year on Dark Matter
        ],
        [
          #underline[Jobs:]
          - Designer
          - Builder
          - Driver
          - Notebooker
        ],
      )
      Neil has had the most experience out of all of us in VEX. He is our driver, but also plays the vital roles of designing, building, and notebooking.

    ],
  )
  #grid(
    columns: (1fr, image-width),
    inset: 0.5em,
    [
      #grid(
        columns: (1fr, 1fr),
        [
          = Shreyas Bhatt
          - 12th Grade
          - 5 years of experience
          - 4th year on Dark Matter

        ],
        [
          #underline[Jobs:]
          - Designer
          - Builder
          - Notebooker

        ],
      )
      Shreyas is well versed in designing, especially using CAD, and building. He can lead and pitch in to almost any job required by the team along with documenting events.
    ],
    figure(image("andrew.png"), caption: ["andrew"]),
  )
  #grid(
    columns: (image-width, 1fr),
    inset: 0.5em,

    (image("andrew.png")),

    [
      #grid(
        columns: (1fr, 1fr),
        [
          = Kairui Dai
          - 10th Grade
          - 4 years of experience
            - 2nd year on Dark Matter
        ],
        [
          #underline[Jobs:]
          - Coder
          - Designer
          - Builder
          - Backup Driver
        ],
      )
      Kairui has four years of experience in the world of programming and driving. This experience allows him to complete both of his jobs with efficiency.

    ],
  )
]

