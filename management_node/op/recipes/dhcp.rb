
# ------------------------------------------------------------------------------
# Install and configure DHCP daemon for private VCL network
# ------------------------------------------------------------------------------

package 'dhcp'

cookbook_file '/dhcpd.conf' do
  path '/etc/dhcp/dhcpd.conf'
end

service 'dhcpd' do
  action :enable
end

service 'dhcpd' do
  action :restart
end

