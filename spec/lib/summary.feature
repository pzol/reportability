Feature: Summary

  Scenario: Sunny Day

  Given the input table
  | provider  | country | tlc | currency | date    | count | value |
  | HOTELBEDS | IT      | ROM | EUR      | 2013-01 | 1     | 10    |
  | HOTELBEDS | IT      | VCE | EUR      | 2013-01 | 1     | 10    |
  | HOTELBEDS | ES      | MAD | EUR      | 2013-01 | 1     | 10    |
  | GTA       | IT      | ROM | EUR      | 2013-01 | 1     | 10    |
  And the fields
  | field    | type    |
  | provider | group:1 |
  | country  | group:2 |
  | tlc      | group:3 |
  | currency |         |
  | date     |         |
  | count    | sum     |
  | value    | sum     |
  Then the summary is
  | group_level | provider  | country | tlc | currency | date    | count | value |
  | 1           | HOTELBEDS |         |     | EUR      | 2013-01 | 3     | 30    |
  | 2           | HOTELBEDS | IT      |     | EUR      | 2013-01 | 2     | 20    |
  | 3           | HOTELBEDS | IT      | ROM | EUR      | 2013-01 | 1     | 10    |
  | 3           | HOTELBEDS | IT      | VCE | EUR      | 2013-01 | 1     | 10    |
  | 2           | HOTELBEDS | ES      |     | EUR      | 2013-01 | 1     | 10    |
  | 3           | HOTELBEDS | ES      | MAD | EUR      | 2013-01 | 1     | 10    |
  | 1           | GTA       |         |     | EUR      | 2013-01 | 1     | 10    |
  | 2           | GTA       | IT      |     | EUR      | 2013-01 | 1     | 10    |
  | 3           | GTA       | IT      | ROM | EUR      | 2013-01 | 1     | 10    |
