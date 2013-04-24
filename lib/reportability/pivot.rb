module Reportability
  class Table
    attr_reader :cols, :rows
    def initialize(args)
      @cols, @rows = args[:cols], args[:rows]
    end

    def inspect
      lengths = cols.map { |col| max_column_length(col) }
      rows.map do |row|
        "|".tap do |s|
          row.each_index { |i| s << (" %-#{lengths[i]}s |" % row[i].to_s)}
        end
      end.join("\n")
    end

    def max_column_length(col)
      idx = cols.index(col)
      ([col.to_s] + rows).map { |row| row[idx].to_s.length }.max
    end
  end

  class Pivot
    attr_accessor :source_data, :pivot, :values
    def project(&block)
      @project = block
    end

    def project=(proc)
      @project = proc
    end

    def new_row(v_group, num_cols)
      Array.new(num_cols) {|e| v_group if e == 0}
    end

    def call(cols, input)
      if @project
        projection = input.map { |e| @project.call(e) }
      else
        projection = input
      end
      pivot_idx = 0 # cols.index(pivot)
      group_idx = 1 # cols.index(group)
      value_idx = 2 # cols.index(values)

      out_cols = ['group_by'] + projection.map { |e| e[pivot_idx]  }.uniq.sort
      num_cols = out_cols.length
      rows = { nil => out_cols }

      projection.each do |i|
        raise Reportability::InputDataError, "Invalid row #{i.inspect}" unless i.is_a?(Array) && i.length == 3
        v_group = i[group_idx]
        v_pivot = i[pivot_idx]
        v_value = i[value_idx]

        row = (rows[v_group] ||= new_row(v_group, num_cols))
        value_col = out_cols.index(v_pivot)
        row[value_col] = v_value if value_col
      end
      t = Table.new :cols => out_cols, :rows => rows.values
    end
  end
end
