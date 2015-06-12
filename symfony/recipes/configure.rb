# see for more info:
# http://symfony.com/doc/2.2/book/installation.html
# https://help.ubuntu.com/community/FilePermissionsACLs

node[:deploy].each do |application, deploy|

  # Set ACL rules to give proper permission to cache and logs
  # script "before_composer" do
  #   interpreter "bash"
  #   user "root"
  #   cwd "#{deploy[:deploy_to]}/current/tmp"
  #   code <<-EOH
    
  #   EOH
  # end

  # Create the parameters.yml file.
  include_recipe 'symfony::paramconfig'

  # Install dependencies using composer install
  include_recipe 'composer::install'

  script "after_composer" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    code <<-EOH
    mkdir -p tmp/database tmp/cache tmp/supervisord
    php vendor/bin/doctrine orm:generate-proxies
    EOH
  end
end
