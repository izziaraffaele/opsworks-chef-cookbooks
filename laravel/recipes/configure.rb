
node[:deploy].each do |application, deploy|

  # Install dependencies using composer install
  include_recipe 'composer::install'

  # correct permissions to allow apache to write
  execute "chown #{path}/app/storage" do
      cwd "#{path}/app/storage"
      command "chown -R deploy.www-data ."
  end
  execute "chmod #{path}/app/storage" do
      cwd "#{path}/app/storage"
      command "chmod -R u+rwX,g+rwX ."
  end
end