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
        get_extension_files("#{Rails.root}/lib/budget/budgets", "zip")
      end

      def get_xlss
        get_extension_files("#{Rails.root}/lib/budget/budgets", "xls")
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

  METHODS = %(creditos_aprobados sueldos gastos adicionar_dr adicional_ms ejecucion incentivo total)

  class UniversityBudget
    def initialize(name)
      @name = name
    end

    def method_missing(sym, *args, &block)
      if METHODS.include?(sym.to_s)

      else
        super
      end
    end

    def respond_to?(sym, include_private=false)
      if METHODS.include?(sym.to_s)
        true
      else
        super
      end
    end

  end

  class UniversityMonthBudget
    def initialize(uni, xls)
      parser = XLSParser.new("./budgets/" + xls)
      @date = parser.date_to
      @matrix = parser.load_matrix(uni)
    end

    def matrix
      @matrix
    end

    def method_missing(sym, *args, &block)
      if METHODS.include?(sym.to_s)
        # ...
      else
        super
      end
    end

    def respond_to?(sym, include_private=false)
      if METHODS.include?(sym.to_s)
        true
      else
        super
      end
    end
  end

  class XLSParser
    attr_reader :xls
    INTEREST_COLUMNS = [2, 3, 4, 5, 7, 8, 10]

    def initialize(xls)
      @date = Date.parse(File.basename(xls, ".xls"))
      @xls = Excel.new(xls)
      @range = detect_range
    end

    def detect_range
      valid_rows = []
      @xls.last_row.times do |j|
        t = j+1
        puts @xls.cell(t,2)
        if /^\d+/.match(@xls.cell(t, 2).to_s)
          puts @xls.cell(t,2)
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

    def get_values
      output = []
      @range.to_a.each do |i|
        row = [@xls.cell(i, 1), @date]
        INTEREST_COLUMNS.each do |j|
          row << @xls.cell(i, j)
        end
        output << row
      end
      output
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
        output << XLSParser.new(xls).get_values
      end
      output
    end
  end
end
