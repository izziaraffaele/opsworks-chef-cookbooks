
node[:deploy].each do |application, deploy|

  # Install dependencies using composer install
  include_recipe 'composer::install'

  # correct permissions to allow apache to write
  execute "chown #{deploy[:deploy_to]}/storage" do
      cwd "#{deploy[:deploy_to]}/storage"
      command "chown -R  ."
  end
  execute "chmod #{deploy[:deploy_to]}/storage" do
      cwd "#{deploy[:deploy_to]}/storage"
      command "chmod -R u+rwX,g+rwX ."
  end

  # correct permissions to allow apache to write
  execute "chown #{deploy[:deploy_to]}/bootstrap/cache" do
      cwd "#{deploy[:deploy_to]}/bootstrap/cache"
      command "chown -R  ."
  end
  execute "chmod #{deploy[:deploy_to]}/bootstrap/cache" do
      cwd "#{deploy[:deploy_to]}/bootstrap/cache"
      command "chmod -R u+rwX,g+rwX ."
  end
end