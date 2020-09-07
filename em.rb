require 'eventmachine'

EM.run do
  puts "#{Time.now} ran"
  EM.add_timer(1) do
    puts "#{Time.now} sleeping..."
    EM.system('sleep 1') { puts "#{Time.now} woke up!" }
    puts "#{Time.now} continuing..."
  end
  EM.add_timer(3) { EM.stop }
end
