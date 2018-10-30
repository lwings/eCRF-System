namespace :db do
  desc "update course monitor of all patients under research"
  task(:updatecoursemonitor => :environment) do
    numOfReseaching=0
    puts "Course Monitor Updated at: #{Time.now}"
    Patient.all.each_with_index do |patient, i|
      if patient.status.value==1
        numOfReseaching+=1
        begin
          patient.course_monitor.save
          puts("course monitor of PATIENT_#{patient.id} is updated")
        rescue
          puts("EXCPTION EMERGED WHEN UPDATE PATIENT_#{patient.id}")
        end
      end
    puts "#{numOfReseaching} course monitors are updated"
    end
  end
end




