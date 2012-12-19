Feature: pivot tables

  Scenario: sunny day
  Given I load example
  When I pivot it
  Then the output is
  """
group_by             2012-08 2012-09 2012-10 2012-11 2012-12 
["REZROOMZ", "MUC"]  1                                       
["EUROTOURS", "INN"]                         5               
["GTA", "LON"]       1                                       
["HOTELBEDS", "BER"] 4       8       4                       
["HOTELBEDS", "HAM"] 2                                       
["MIKI", "BER"]      1                                       
["REZROOMZ", "BER"]  25      20      4                       
["GTA", "MEX"]       1                                       
["TOURICO", "BER"]   1                                       
["WOTRA", "BZO"]                     1       51      1       
["WOTRA", "BUD"]                                     1       
["GTA", "BER"]       8       9                       1       
["GTA", "WRO"]       1       3       6               2       
["REZROOMZ", "ESS"]  1                                       
["WOTRA", "MUN"]                     71      1               
["HOTELBEDS", "MUC"] 1                                       
["REZROOMZ", "LON"]  1       1                               
["REZROOMZ", "WRO"]  1       3       6               2       
["REZROOMZ", "MGL"]  1                                       
["KUONI", "RSE"]     6                                       
["GTA", "BKK"]       2                                       
["WOTRA", "VIE"]                                     1       
["JACTRAVEL", "BER"] 2       1                               
["KUONI", "BER"]     1       2                               
["WOTRA", "LAX"]                             6               
["REZROOMZ", "MEX"]  1                                       
["WOTRA", "VIC"]                                     1       
["GTA", "HAM"]       1                                       
["REZROOMZ", "BKK"]  2                                       
["KUONI", "LON"]             1                               
["HOTELBEDS", "MGL"] 1                                       
["WOTRA", "LON"]                                     1       
["WOTRA", "PRG"]                                     1       
["REZROOMZ", "HAM"]  3                                       
["WOTRA", "INN"]                                     2       
["WOTRA", "WRO"]                                     1       

  """
