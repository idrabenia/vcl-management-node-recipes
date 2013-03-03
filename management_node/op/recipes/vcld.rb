

# ---------------------------------------------------------
# Install required linux packages
# ---------------------------------------------------------

package 'expat'
package 'expat-devel'
package 'gcc'
package 'krb5-libs'
package 'krb5-devel'
package 'libxml2'
package 'libxml2-devel'
package 'mysql'
package 'nmap'
package 'openssh'
package 'openssl'
package 'openssl-devel'
package 'perl'
package 'perl-DBD-MySQL'

# Resolve CentOs bug with package 'xmlsec1-openssl'
execute 'rpm' do
  command 'rpm -Uvh --replacepkgs http://download.fedoraproject.org/pub/epel/6/i386/epel-release-6-8.noarch.rpm'
end

# if script failed on this line then really failed previous command
package 'xmlsec1-openssl'


# ---------------------------------------------------------
# Install vcld
# ---------------------------------------------------------

execute 'cp' do
  command 'cp -r apache-VCL-2.3/managementnode /usr/local/vcl'
  cwd node[:chef_solo][:script_home]
end

execute 'perl' do
  command 'perl /usr/local/vcl/bin/install_perl_libs.pl -y'
end


# ---------------------------------------------------------
# Configure vcld
# ---------------------------------------------------------

execute 'mkdir' do
  command 'mkdir -p /etc/vcl'
end

cookbook_file '/vcld.conf' do
  path '/etc/vcl/vcld.conf'
end

execute 'cp' do
  command 'cp /usr/local/vcl/bin/S99vcld.linux /etc/init.d/vcld'
end

service 'vcld' do
  action :enable
end

service 'vcld' do
  action :restart
end

