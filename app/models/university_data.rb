class UniversityData < ActiveRecord::Base
  belongs_to :university
  
  def self.presupuestos(university)
    datas = self.where(:university_id => university.id).order(:date_from)
    months = datas.collect { |d| d.date_from.strftime("%m/%y") }
    money = datas.collect { |d| d.creditos_aprobados }
    [months, money]
  end
  
  def self.salaries(university)
    datas = self.where(:university_id => university.id).order(:date_from)
    money = datas.collect { |d| d.sueldos }
    money    
  end
  
  def self.last_year_on(uni, month)
    first_day = DateTime.parse("11-#{month}-01")
    last_day =  first_day.end_of_month
    self.where(:date_from => (first_day...last_day), :university_id => uni.id).first.creditos_aprobados.to_i
  end
  
  def self.last_first_month(uni)
    first_day = DateTime.parse("11-01-01")
    last_day =  first_day.end_of_month
    d = self.where(:date_from => (first_day...last_day), :university_id => uni.id).first
    100 * d.sueldos.to_f / d.creditos_aprobados.to_f
  end
  
  def self.populate
    Budget::University.data.each do |d|
      uni = University.find_by_name(d[0])
      if uni
        self.create university_id: uni.id, date_from: d[1], creditos_aprobados: d[2], 
                    sueldos: d[3], gastos: d[4], adicional_dr: d[5], adicional_ms: d[6], 
                    ejecucion: d[7], incentivo: d[8], total: d[9]
      else
        puts d[0]
      end
    end
  end
end
