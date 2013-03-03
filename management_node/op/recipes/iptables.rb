# Configure IP Tables

cookbook_file 'iptables' do
  path '/etc/sysconfig/iptables'
  mode 0777
end

service 'iptables' do
  action :restart
end