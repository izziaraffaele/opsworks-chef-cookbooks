
node[:deploy].each do |application, deploy|

  # Install dependencies using composer install
  include_recipe 'composer::install'

  # correct permissions to allow apache to write
  execute "chown #{deploy[:deploy_to]}/app/storage" do
      cwd "#{deploy[:deploy_to]}/app/storage"
      command "chown -R deploy.www-data ."
  end
  execute "chmod #{deploy[:deploy_to]}/app/storage" do
      cwd "#{deploy[:deploy_to]}/app/storage"
      command "chmod -R u+rwX,g+rwX ."
  end
end