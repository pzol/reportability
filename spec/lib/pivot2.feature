Feature: pivot projection

  Scenario: magic
  Given I load example2
  When I magic-pivot it2
  Then the result table is
  | group_by                                                                                 | 2012-12                     | 2013-01                     |
  | {"_level"=>1, "provider"=>"HOTELBEDS", "currency"=>"EUR"}                                | {"count"=>1, "value"=>10.0} | {"count"=>3, "value"=>30.0} |
  | {"_level"=>2, "provider"=>"HOTELBEDS", "currency"=>"EUR", "country"=>"IT"}               |                             | {"count"=>2, "value"=>20.0} |
  | {"_level"=>3, "provider"=>"HOTELBEDS", "currency"=>"EUR", "country"=>"IT", "tlc"=>"ROM"} |                             | {"count"=>1, "value"=>10.0} |
  | {"_level"=>3, "provider"=>"HOTELBEDS", "currency"=>"EUR", "country"=>"IT", "tlc"=>"VCE"} |                             | {"count"=>1, "value"=>10.0} |
  | {"_level"=>2, "provider"=>"HOTELBEDS", "currency"=>"EUR", "country"=>"ES"}               | {"count"=>1, "value"=>10.0} | {"count"=>1, "value"=>10.0} |
  | {"_level"=>3, "provider"=>"HOTELBEDS", "currency"=>"EUR", "country"=>"ES", "tlc"=>"MAD"} | {"count"=>1, "value"=>10.0} | {"count"=>1, "value"=>10.0} |
  | {"_level"=>1, "provider"=>"GTA", "currency"=>"EUR"}                                      | {"count"=>1, "value"=>10.0} |                             |
  | {"_level"=>2, "provider"=>"GTA", "currency"=>"EUR", "country"=>"IT"}                     | {"count"=>1, "value"=>10.0} |                             |
  | {"_level"=>3, "provider"=>"GTA", "currency"=>"EUR", "country"=>"IT", "tlc"=>"ROM"}       | {"count"=>1, "value"=>10.0} |                             |
