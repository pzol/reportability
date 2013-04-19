module Reportability
  class Summary
    # level_fields   - group by fields
    # alawys_fields  - those must always be present in output
    # value_fields   - those are summarized
    def initialize(level_fields, always_fields, value_fields, aggregates={})
      @level_fields  = level_fields
      @always_fields = always_fields
      @value_fields  = value_fields
      @levels        = {}
      @aggregates    = Hash.new(default_aggregate).merge(aggregates)
    end

    def push(row)
      @level_fields.each do |e|
        update_level(e, row)
      end
    end

    # flattens the output
    def summary
      @levels.map { |k, v| k.merge(v) }
    end

    def inspect
      @levels
    end

  private
    def update_level(e, row)
      level_num    = @level_fields.index(e)
      key_fields   = @level_fields[0..level_num] + @always_fields
      keys         = row.select { |k| key_fields.include?(k) }
      level_key    = {_level: level_num + 1}.merge(keys)
      values       = row.select { |k| @value_fields.include?(k)}

      v = {level_key => values}

      @levels.merge!(v) do |key, oldval, newval|
        oldval.merge!(newval) { |k, x, y| @aggregates[k].(x, y)}
      end
    end

    def default_aggregate
      ->(x,y) { x + y}
    end

  end
end

