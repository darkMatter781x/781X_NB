#import "/import.typ": *

#body-entry.create(
  "Team Overview",
  "Project",
  /* TODO: make a step for non design process entries */ "build",
  "author",
  datetime(year: 2025, month: 7, day: 8),
)[

  #let create-appendix = none


  This season, our team consists of 6 people. All of our team members have worked together at some point in VEX VRC. Andrew, Shreyas, and Neil started Dark Matter in 2022 whereas Kairui and Juliana joined in 2024, Ryan following this year. Shreyas, Neil, Kairui, and Ryan all participated in VEX VRC during their time at ACP Middle, so they have been on teams together. Combined, we total 22 years of experience in VRC and our team specifically has gone to Worlds twice along with all of our ACP members having gone at least once during middle school. In the past, we have had three, four, and five members on the team, but this is our first year of having six people, so we aspire to balance out the team dynamics as we work together.

  #image("image.png")

  ```cpp
  int main() {
    std::cout << "Hello, World!" << std::endl;
    return 0;
  }
  ```

  // See the code for this file: #appendix.create("Source Code", raw(read("/entries/2025/6/19/entry.typ"), lang: "typ"))
]
