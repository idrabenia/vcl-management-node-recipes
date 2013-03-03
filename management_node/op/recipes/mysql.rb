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
  command "mysql -e \"GRANT SELECT,INSERT,UPDATE,DELETE,CREATE TEMPORARY TABLES ON vcl.* TO '#{node[:vcl_db][:user]}'@'localhost' IDENTIFIED BY '#{node[:vcl_db][:password]}';\" "
end

execute 'mysql' do
  command "mysql vcl < apache-VCL-2.3/mysql/vcl.sql"
  cwd node[:chef_solo][:script_home]
end
