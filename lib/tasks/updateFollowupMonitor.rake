namespace :db do
  desc "update followup monitor of all patients under research"
  task(:updatefollowupmonitor => :environment) do
    numOfFollowup=0
    puts " "
    puts " "
    puts "Followup Monitor Updated at: #{Time.now}"
    Patient.all.each_with_index do |patient, i|
      if patient.status.value==2
        begin
          numOfFollowup+=1
          patient.followup_monitor.save
          puts("followup monitor of PATIENT_#{patient.id},name:#{patient.name} is updated")
        rescue
          puts("EXCPTION EMERGED WHEN UPDATE PATIENT_#{patient.id}")
        end
      end
    end
    puts "#{numOfFollowup} course monitors are updated"
  end
end




