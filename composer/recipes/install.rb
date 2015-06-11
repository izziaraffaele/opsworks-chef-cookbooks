#
# Taken from:
# http://docs.aws.amazon.com/opsworks/latest/userguide/gettingstarted.walkthrough.photoapp.3.html
#
node[:deploy].each do |application, deploy|
  script "install_composer" do
    interpreter "bash"
    user "root"
    cwd "#{deploy[:deploy_to]}/current"
    if deploy[:scm]
      ensure_scm_package_installed(deploy[:scm][:scm_type])
      prepare_git_checkouts(
        :user => deploy[:user],
        :group => deploy[:group],
        :home => deploy[:home],
        :ssh_key => deploy[:scm][:ssh_key]
      ) if deploy[:scm][:scm_type].to_s == 'git'
    end
    code <<-EOH
    curl -s https://getcomposer.org/installer | php
    php composer.phar install --no-dev --no-interaction --optimize-autoloader
    EOH
    only_if { ::File.exists?("#{deploy[:deploy_to]}/current/composer.json") }
  end
end 
