# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
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

ENV.each { |k, v| env(k, v) }

set :output, 'log/cron.log'
set :environment, ENV['RAILS_ENV']
job_type :runner, "cd :path && bin/rails runner -e :environment ':task' :output"

every 1.hours do
   
   rake "db:test:prepare"
   runner "Chat.update_messages_count"
   runner "Application.update_chats_count"
   
end