/// Capitalize the first letter of each word in a string.
///
/// Example: `capitalize("hello world") == "Hello World"`
#let capitalize(str) = str.split(" ").map(word => upper(word.slice(0, 1)) + word.slice(1)).join(" ")
