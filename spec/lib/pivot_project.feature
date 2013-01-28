Feature: pivot projection

  Scenario: magic
  Given I load example
  When I magic-pivot it
  Then the result table is
  | group_by       | 2011-07 | 2011-08 | 2011-09 | 2011-10 |
  | HOTEL A34, GRO | 1       |         |         |         |
  | HOTELBEDS, YYY |         | 1       | 3       | 1       |
  | MIKI, YYY      |         | 1       | 2       |         |
  | KUONI, YYY     |         | 1       | 1       |         |
  | ROOMZ, YYY     |         |         |         | 1       |
  | TOURICO, YYY   |         |         |         | 1       |
  | AOT, YYY       |         |         | 1       | 2       |
  | OHG, YYY       |         |         |         | 1       |
  | GTA, YYY       |         |         |         | 3       |
