lobster_pid = spawn("ruby lobster_server.rb")
rusty_lobster_pid = -1

at_exit do
  if lobster_pid > 1
    begin
      Process.kill(:SIGINT, lobster_pid)
    rescue Errno::ESRCH
    end
  end
  if rusty_lobster_pid > 1
    begin
      Process.kill(:SIGINT, rusty_lobster_pid)
    rescue Errno::ESRCH
    end
  end
end

require_relative "./server/server"

BProxy.new.start
