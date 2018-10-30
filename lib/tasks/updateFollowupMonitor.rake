namespace :db do
  desc "update followup monitor of all patients under research"
  task(:updatefollowupmonitor => :environment) do
    numOfFollowup=0
    puts "Followup Monitor Updated at: #{Time.now}"
    Patient.all.each_with_index do |patient, i|
      if patient.status.value==2
        numOfFollowup+=1
        begin
          patient.followup_monitor.save
          puts("followup monitor of PATIENT_#{patient.id} is updated")
        rescue
          puts("EXCPTION EMERGED WHEN UPDATE PATIENT_#{patient.id}")
        end
      end
    puts "#{numOfFollowup} course monitors are updated"
    end
  end
end




