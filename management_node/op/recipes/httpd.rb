

# Install Apache HTTP Server

package 'httpd'

service 'httpd' do
  action :enable
end

service 'httpd' do
  action :restart
end


# Install PHP

package 'mod_ssl'
package 'php'
package 'php-gd'
package 'php-mysql'
package 'php-xml'
package 'php-xmlrpc'
package 'php-ldap'
package 'php-process'


# Install VCL Web Site

execute 'cp' do
  command 'cp -r apache-VCL-2.3/web/ /var/www/html/vcl'
  cwd node[:chef_solo][:script_home]
end

cookbook_file 'secrets.php' do
  path '/var/www/html/vcl/.ht-inc/secrets.php'
  mode 0777
end

cookbook_file 'conf.php' do
  path '/var/www/html/vcl/.ht-inc/conf.php'
  mode 0777
end

execute './genkeys.sh' do
  command './genkeys.sh'
  cwd '/var/www/html/vcl/.ht-inc'
end

execute 'chown' do
  command 'chown apache maintenance'
  cwd '/var/www/html/vcl/.ht-inc'
end

