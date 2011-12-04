require 'rubygems'
require 'roo'
require 'zip/zip'

module Budget
  class BudgetFile
    class << self
      def extract_zips(path = nil)
        get_zips.each do |file|
          if path
            basename =  File.basename(file, ".zip")
            Zip::ZipFile.open(file).first.extract(path + "/" + basename + ".xls")
          else
            Zip::ZipFile.open(file).first.extract
          end
        end
      end

      def get_zips
        begin
          get_extension_files("#{Rails.root}/lib/budget/budgets", "zip")
        rescue NameError
          get_extension_files("./budgets", "zip")
        end
      end

      def get_xlss
        begin
          get_extension_files("#{Rails.root}/lib/budget/budgets", "xls")
        rescue NameError
          get_extension_files("./budgets", "xls")
        end
      end

      def get_extension_files(path, ext)
        output = []
        Dir.new(path).each do |file|
          full_path_file = path + "/" + file
          if File.file?(full_path_file) && File.extname(full_path_file) == ("." + ext)
            output << full_path_file
          end
        end
        output
      end
    end
  end

  METHODS = %(creditos_aprobados sueldos gastos adicional_dr adicional_ms ejecucion incentivo total)

  class XLSParser
    attr_reader :xls

    def initialize(xls)
      @date = Date.parse(File.basename(xls, ".xls"))
      @xls = Excel.new(xls)
      @range = detect_range
    end

    def detect_range
      valid_rows = []
      @xls.last_row.times do |j|
        t = j+1
        if /^\d+/.match(@xls.cell(t, 2).to_s)
          valid_rows << t 
        end
      end
      valid_rows[0]..valid_rows[-2]
    end

    def universities
      @universities ||= []
      if @universities.empty?
        @range.to_a.each do |i|
          @universities << @xls.cell(i, 1) if @xls.cell(i,1) =~ /\w+/
        end
      end
      @universities
    end

    def get_titles
      row = detect_range.first - 1
      last_column = @xls.last_column
      titles = []
      (2..last_column).to_a.each do |j|
        titles << @xls.cell(row, j)
      end
      titles
    end

    def get_values
      output = []
      @range.to_a.each do |i|
        row = [@xls.cell(i, 1), @date]
        [2, 3].each do |j|
          v = @xls.cell(i,j)
          if blank?(v)
            row << "0"
          else
            row << @xls.cell(i, j)
          end
        end
        puts row.inspect
        output << row
      end
      output
    end

    def blank?(cad)
      cad.nil? || cad == ""
    end

    def find_university(uni)
      j=1
      while j < @university_count
        break unless @xls.cell(j, 1) == uni
        j += 1
      end
      return j
    end

    def date_from
      parse_dates unless @date_from
      @date_from
    end

    def date_to
      parse_dates unless @date_to
      @date_to
    end

  private
    
    def parse_dates
      date_range = @xls.cell(2, 1)
      date_range = /(\d{2}\/\d{2}\/\d{4})/.match(date_range.to_s)
      @date_from = date_range[0]
      @date_to = date_range[1]
    end
  end

  class University
    def self.get_universities
      output = []
      xlss = Budget::BudgetFile.get_xlss
      xlss.each do |xls|
        output << XLSParser.new(xls).universities
      end
      output.flatten.uniq
    end

    def self.data
      output = []
      xlss = Budget::BudgetFile.get_xlss
      xlss.each do |xls|
        XLSParser.new(xls).get_values.each do |dd|
          output << dd
        end
      end
      output
    end
  end
end

xlss = Budget::BudgetFile.get_xlss
xlss.each do |xls|
  Budget::XLSParser.new(xls).get_values.inspect
end
#puts Budget::XLSParser.new("budgets/09-12-31.xls").get_titles
#11-08-31
#11-03-31
#10-08-31
#09-10-31
#09-02-28
