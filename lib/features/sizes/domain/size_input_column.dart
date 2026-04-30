/// Which label column to match first when parsing the user’s typed size.
enum SizeInputColumn {
  us,
  uk,
  eu,
  jp,

  /// Try EU → US → UK → JP (common for import-heavy markets).
  mixed,
}
