require "ssh-ruby/version"
require 'sourcify'
require 'net/ssh'

module Ssh
  module Ruby
    def ssh(*hosts, &block)
      hosts.each do |host| 
        Net::SSH.start(host.to_s,'motoki') do |ssh|
          ssh.exec "echo '#{block.to_source(:strip_enclosure => true)}' > ssh_test.rb"
          res = ssh.exec! "ruby ssh_test.rb"
          system "echo '#{res}' > zz"
          system "cat zz"
        end
      end
    end

    # sample
    # ssh :localhost do
    #   p 1
    #   [1, 2, 23].each do |i|
    #     p i
    #   end
    #   lambda {|i| p i}
    # end

  end
end
