# see for more info:
# http://symfony.com/doc/2.2/book/installation.html
# https://help.ubuntu.com/community/FilePermissionsACLs

node[:deploy].each do |application, deploy|

  # Set ACL rules to give proper permission to cache and logs
  script "make_tmp_folders" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current/tmp"
    code <<-EOH
    mkdir -p database, cache
    EOH
  end

  # Create the parameters.yml file.
  include_recipe 'symfony::paramconfig'

  # Install dependencies using composer install
  include_recipe 'composer::install'

end
