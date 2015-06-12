node[:deploy].each do |application, deploy|

  template "#{deploy[:deploy_to]}/current/app/config/parameters.yml" do
    source "parameters.yml.erb"
    mode 0644
    group "root"

    if platform?("ubuntu")
      owner "deploy"
   elsif platform?("amazon")
      owner "deploy"
    end

    variables(
      :database => (deploy[:database]  rescue nil), 
      :parameters => (node[:custom_env]  rescue nil), 
      :application => ("#{application}"  rescue nil) 
    )

   only_if do
     File.directory?("#{deploy[:deploy_to]}/current/app/config")
   end
  end
end