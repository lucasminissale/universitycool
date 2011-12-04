class CreateUniversityData < ActiveRecord::Migration
  def change
    create_table :university_data do |t|
      t.integer :university_id
      t.string :creditos_aprobados
      t.string :sueldos
      t.string :gastos
      t.string :adicional_dr
      t.string :adicional_ms
      t.string :ejecucion
      t.string :incentivo
      t.string :total
      t.datetime :date_from

      t.timestamps
    end
    UniversityData.reset_column_information

    Budget::University.data.each do |d|
      uni = University.find_by_name(d[0])
      UniversityData.create university_id: uni.id, date_from: d[1], creditos_aprobados: d[2], 
                            sueldos: d[3], gastos: d[4], adicional_dr: d[5], adicional_ms: d[6], 
                            ejecucion: d[7], incentivo: d[8], total: d[9]
    end
  end
end
