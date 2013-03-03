
SOLO_HOME=default[:solo_script_home]

DB_USER=default[:vcl_db][:user]
DB_PASSWORD=default[:vcl_db][:password]

# Unpack apache vcl

execute 'tar' do
  command 'tar -jxvf apache-VCL-2.3.tar.bz2'
  cwd SOLO_HOME
end


# Configure IP Tables

cookbook_file 'iptables' do
  path '/etc/sysconfig/iptables'
  mode 0777
end

service 'iptables' do
  action :restart
end


# Install MySQL Server

package 'mysql-server'

service 'mysqld' do
  action :enable
end

service 'mysqld' do
  action :restart
end


# Configure database for management node web application

execute 'mysql' do
  command "mysql -e 'DROP DATABASE IF EXISTS vcl; CREATE DATABASE vcl;' "
end

execute 'mysql' do
  command "mysql -e \"GRANT SELECT,INSERT,UPDATE,DELETE,CREATE TEMPORARY TABLES ON vcl.* TO '#{DB_USER}'@'localhost' IDENTIFIED BY '#{DB_PASSWORD}';\" "
end

execute 'mysql' do
  command "mysql vcl < apache-VCL-2.3/mysql/vcl.sql"
  cwd SOLO_HOME
end

# Install Apache HTTP Server

package 'httpd'

service 'httpd' do
  action :enable
end

service 'httpd' do
  action :restart
end



#package 'ntp'
#package 'sysstat'

## --- Add the data partition ---
#directory '/mnt/data_joliss'
#
#mount '/mnt/data_joliss' do
#  action [:mount, :enable]  # mount and add to fstab
#  device 'data_joliss'
#  device_type :label
#  options 'noatime,errors=remount-ro'
#end
#
## --- Set host name ---
## Note how this is plain Ruby code, so we can define variables to
## DRY up our code:
#hostname = 'opinionatedprogrammer.com'
#
#file '/etc/hostname' do
#  content "#{hostname}\n"
#end
#
#service 'hostname' do
#  action :restart
#end
#
#file '/etc/hosts' do
#  content "127.0.0.1 localhost #{hostname}\n"
#end
#
## --- Deploy a configuration file ---
## For longer files, when using 'content "..."' becomes too
## cumbersome, we can resort to deploying separate files:
#cookbook_file '/etc/apache2/apache2.conf'
## This will copy cookbooks/op/files/default/apache2.conf (which
## you'll have to create yourself) into place. Whenever you edit
## that file, simply run "./deploy.sh" to copy it to the server.
#
#service 'apache2' do
#  action :restart
#end