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
        get_extension_files("./budgets", "zip")
      end

      def get_xlss
        get_extension_files("./budgets", "xls")
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

  class UniversityMonthBudget
    METHODS = %(creditos_aprobados sueldos gastos adicionar_dr adicional_ms ejecucion incentivo total)
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
    INTEREST_COLUMNS = [2, 3, 4, 5, 7, 8, 10]

    def initialize(xls)
      @xls = Excel.new(xls)
      @university_count = @xls.last_row - 1 - 9
    end

    def universities
      @universities ||= []
      if @universities.empty?
        (9..49).to_a.each do |i|
          @universities << @xls.cell(i, 1)
        end
      end
      @universities
    end

    def load_matrix(uni)
      @matrix ||= []
      if @matrix.empty?
        r = find_university(uni)
        INTEREST_COLUMNS.each do |c|
          @matrix << @xls.cell(r, c)
        end
      end
      @matrix
    end

    def find_university(uni)
      j=9
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
      date_range = /(\d{2}\/\d{2}\/\d{4})/.match(date_range)
      puts date_range
      @date_from = date_range[0]
      @date_to = date_range[1]
    end
  end

  class University
    attr_accessor :credito_aprobado, :sueldo, :gasto_funcionamiento, 
                  :adicional_dr, :adicional_ms, :ejecucion, :incentivo, 
                  :total
  end

  class BudgetUniversity
    def initialize
    end

    def creditos_aprobados(year=nil)
    end

    def sueldos(year=nil)
    end

    def gastos(year=nil)
    end
  end
end

#Budget::BudgetFile.extract_zips("./budgets")
umb = Budget::UniversityMonthBudget.new("BUENOS AIRES", "09-01-31.xls")
puts umb.matrix.inspect


