// To view the output of this file, use the "Preview Opened File" button as seen in the README.md file

// Applies some styling (do not worry about this for now)
#import "/docs/prelude.typ": *
#show: prelude-init.with()

= Introduction
This document is intended to be an interactive introduction to how typst and this notebook work.

You should try to edit the source code to learn how it works.
Don't worry about breaking the document, you can always revert by pressing `ctrl+z`, or if you really screwed up, by calling the `Revert File` in the command palette.
This can be done by pressing `F1`, typing `File: Revert File`, and hitting enter in VS Code.

Here, try adding some text below in this blank space to see how it works:



Alright, hopefully you added some text there.

= A Bit of Formatting Syntax
In this section, we will learn the basics of formatting syntax.

== Headers
are created by starting a line with a number of equals signs (`=`) followed by a space.

=== More equal signs
Makes for smaller headers.
Headers should be used to structure your document and should be more and more specific.

== Writing Text
Plaintext in typst is interpreted as normal text, so you can just write text without any special formatting.
Adding
a new line
does not
create a
new paragraph.

But, leaving a blank space between paragraphs does create a new paragraph.

== Comments
// Comments are create by starting a line with two slashes (`//`).
// They are ignored by the compiler and are useful for leaving notes in the code.
Line comments // can occur after code as well.

/* You can also create block comments which can be ended whenever with a */
/* These block comments can span multiple lines.
 * And content can be placed after them.
 */
You can turn any line into a comment by pressing `Ctrl+/` or `⌘/` in VS Code.
Try it out!
You can press the same key combination again to uncomment the line!

Additionally, you can use `Alt+Shift+A` or `⇧⌥A` to toggle block comments in VS Code.
Try it out!

== Code Blocks
We can also tell typst to treat text as "raw".
This explicitly tells typst to not interpret the text as typst code, but rather as plain text.
This is denoted with backticks.

`// Despite starting with //, this is not ignored by typst, but rather treated as raw text.
= Headers don't work, as this is a raw block.
To escape from a raw block, you must use a backtick.`

// Ignore for now
#codly-disable()

```
More backticks can be used to further encapsulate raw text.
This means that you can use ` inside of here without problem!
```

``````
Does your raw block need to use more ```? Just add more backticks to your "fence"!
``````

Ok thats cool but why would I want that?
Well its power is that we can use it to write code snippets that are not interpreted by typst:

```cpp
/**
 * A hello world program in C++.
 */
#include <iostream>
int main() {
    std::cout << "Hello, World!" << std::endl;
}
```

Since we specified cpp on the first line, typst knew to use the C++ syntax highlighting for this code block.
Backticks can also be used to format text differently, such as `inline code` which is used to format the text in a monospace font.
If we want this code to be highlighted,
then we can also use triple backticks: ```js console.log("Hello, World!"); ```.

Additionally, this notebook uses the codly library to enable much richer code blocks:
// Re-enable codly
#codly-enable()
```cpp
/**
 * Same hello world program, but a bit more spiffy.
 */
#include <iostream>
int main() {
    std::cout << "Hello, World!" << std::endl;
}
```

== An escape
Alright, how do I write a normal backtick?
For that you must use the escape character `\` before the backtick.
Voila: \`, but this doesn't work in raw blocks: `\`.
We can also use the `#"text"` syntax to escape a backtick: #"`"

== A list
Lists can be created by starting a line with a dash (`-`) followed by a space.
- This is a list item
- Lists can be nested by indenting with spaces or tabs
  - This is a nested list item
- Lists can also be numbered by starting a line with a plus sign followed by a space.
  + List items can also be extended across multiple lines,
    by indenting the next line.
  + And they can contain other content such as:
    ```python
    # This is a code block inside a list item.
    print("Hello, World!")
    ```

= Your First Entry
Now that you know some basics of typst syntax, its time to learn how to create an entry in this notebook!

==

= TODO:
- Document
  - Integrations
    - Creating an entry
    - Entry preview
    - Typos
    - Git
    - Excalidraw
    - Formatter
    - Github workflows
    - Github PRs?
  - Formatting
    - Figures
      - Linking to figures
    - Images
    - Math
    - Links
    - Grids/Tables
    - Side by side content
- Implement and document:
  - Integrations:
    - Include code from git?
    - Docs compile checks (idk about docs for this)
  - Custom Formatting
    - Pro con charts
    - Admonitions (gentle-clues?)
    - Glossary
    - Appendix (new nb rules)
    - Improve styling (idk about docs for this)
    - QR codes?
    - Decision matrices?
    - Visualization Charts?
      - Line
      - Pie
      - Bar
      - Gantt
      - Radar?
      - Game Field??
