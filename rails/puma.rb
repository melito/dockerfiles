threads 8,32
workers 4
 
bind "unix:///app/shared/tmp/sockets/puma.sock"
pidfile "/app/shared/tmp/pids/puma.pid"
state_path "/app/shared/tmp/sockets/puma.state"
 
#activate_control_app
preload_app!
 
on_worker_boot do
  ActiveSupport.on_load(:active_record) do
    ActiveRecord::Base.establish_connection
  end
end
