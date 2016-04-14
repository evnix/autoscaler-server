require 'net/ssh'

Net::SSH.start('104.238.174.236', 'root') do |ssh|
  # capture all stderr and stdout output from a remote process
  output = ssh.exec!("mkdir x")
  puts output

  # capture only stdout matching a particular pattern
 end