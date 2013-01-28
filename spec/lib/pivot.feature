Feature: pivot tables

  Scenario: simple
  Given the json
  """
  [
    ["c1", "r1", "v1"],
    ["c1", "r2", "v2"],
    ["c2", "r1", "v3"],
    ["c2", "r2", "v4"]
  ]
  """
  When I pivot it
  Then the result table is
  | group_by | c1 | c2 |
  | r1       | v1 | v3 |
  | r2       | v2 | v4 |
