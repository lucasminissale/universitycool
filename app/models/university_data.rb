class UniversityData < ActiveRecord::Base
  def self.populate
    Budget::University.data.each do |d|
      uni = University.find_by_name(d[0])
      self.create university_id: uni.id, date_from: d[1], creditos_aprobados: d[2], 
                  sueldos: d[3], gastos: d[4], adicional_dr: d[5], adicional_ms: d[6], 
                  ejecucion: d[7], incentivo: d[8], total: d[9]
    end
  end
end
