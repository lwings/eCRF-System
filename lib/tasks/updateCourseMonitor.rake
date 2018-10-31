namespace :db do
  desc "update course monitor of all patients under research"
  task(:updatecoursemonitor => :environment) do
    numOfReseaching=0
    puts " "
    puts " "
    puts "Course Monitor Updated at: #{Time.now}"
    Patient.all.each_with_index do |patient, i|
      if patient.status.value==1
        begin
          numOfReseaching+=1
          patient.course_monitor.save
          puts("course monitor of PATIENT_#{patient.id},name:#{patient.name} is updated")
        rescue
          puts("EXCPTION EMERGED WHEN UPDATE PATIENT_#{patient.id}")
        end
      end

    end
    puts "#{numOfReseaching} course monitors are updated"
  end
end




