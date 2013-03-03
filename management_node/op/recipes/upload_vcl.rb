
# Unpack apache vcl

execute 'tar' do
  command 'tar -jxvf apache-VCL-2.3.tar.bz2'
  cwd node[:chef_solo][:script_home]
end

# -A INPUT -j REJECT --reject-with icmp-host-prohibited
# -A FORWARD -j REJECT --reject-with icmp-host-prohibited