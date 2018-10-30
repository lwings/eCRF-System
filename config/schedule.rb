# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
set :output, "~/little_wings/monitor_log"
set :chronic_options, :hours24 => true

# set the path of bundle, that is /usr/local/bin/, if the evironment of bundle is rvm, then comment the follwoing line command.
job_type :rake, "cd :path && :environment_variable=:environment /usr/local/bin/bundle exec rake :task --silent :output"

#
# every 2.hours do
#   command "/usr/bin/some_great_command"
#   runner "MyModel.some_method"
#   rake "some:great:rake:task"
# end
#
# every 4.days do
#   runner "AnotherModel.prune_old_records"
# end

# Learn more: http://github.com/javan/whenever


every 1.day, :at => '00:05' do
  rake "db:updatefollowupmonitor"
end

every 1.day, :at => '02:05' do
  rake "db:updatecoursemonitor"
end

# every :saturday, :at => '03:00' do
#   command "/home/mazt/mdt/rj-mdt/stop_unicorn.sh"
# end
#
# every :saturday, :at => '03:01' do
#   command "/home/mazt/mdt/rj-mdt/run_unicorn.sh"
# end



# every :saturday, :at => '04:00' do
  # command "~/mdt/rj-mdt/lib/scripts/restart_wf_mq.sh"
# end

## for workflow, first restart activemq, then restart workflow
# every :friday, :at => '03:00' do
  # command "/home/mazt/mdt/wf-production/stop_workflow.sh"
# end
# every :friday, :at => '03:01' do
  # command "/home/mazt/mdt/wf-production/run_workflow_schedule.sh"
# end

