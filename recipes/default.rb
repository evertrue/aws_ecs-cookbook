#
# Cookbook Name:: aws_ecs-cookbook
# Recipe:: default
#
# Copyright 2017, EverTrue, Inc.
#
include_recipe 'aufs'
include_recipe 'iptables'
include_recipe 'chef-apt-docker'

docker_service 'default' do
  host           'unix:///var/run/docker.sock'
  install_method 'package'
  storage_driver 'aufs'
  action         %i(create start)
end

%w(/etc/ecs /var/log/ecs /var/lib/ecs/data).each do | filename |
   directory "#{filename}" do
      mode '0755'
      action :create
      recursive true
   end
end

template "/etc/ecs/ecs.config" do
   source "ecs.config.erb"
   mode "0644"
   variables(
      :data_dir => node['aws_ecs']['data_dir'],
      :log_file => node['aws_ecs']['log_file'],
      :cluster_name => node['aws_ecs']['cluster_name']
   )
   notifies :restart, "docker_container[ecs-agent]"
end

docker_image 'amazon/amazon-ecs-agent' do
  action :pull
  tag 'latest'
  notifies :redeploy, 'docker_container[ecs-agent]'
end

docker_container 'ecs-agent' do
  repo 'amazon/amazon-ecs-agent'
  tag 'latest'
  volumes [
     '/var/run:/var/run',
     '/var/log/ecs/:/log',
     '/var/lib/ecs/data:/data',
     '/etc/ecs:/etc/ecs']
  restart_policy 'on-failure'
  restart_maximum_retry_count 10
  network_mode 'host'
  env [
     "ECS_DATADIR=#{node['aws_ecs']['data_dir']}",
     'ECS_ENABLE_TASK_IAM_ROLE=true',
     'ECS_ENABLE_TASK_IAM_ROLE_NETWORK_HOST=true',
     "ECS_LOGFILE=#{node['aws_ecs']['log_file']}",
     'ECS_AVAILABLE_LOGGING_DRIVERS=["json-file","awslogs"]',
     'ECS_LOGLEVEL=info',
     "ECS_CLUSTER=#{node['aws_ecs']['cluster_name']}"
  ]
  action :run
end

sysctl_param 'net.ipv4.conf.all.route_localnet' do
  value 1
end

iptables_rule 'host_iam_dnat_51679' do
  lines '-A PREROUTING -p tcp -d 169.254.170.2 --dport 80 -j DNAT --to-destination 127.0.0.1:51679'
  table :nat
end

iptables_rule 'host_iam_redirect_51679' do
  lines '-A OUTPUT -d 169.254.170.2 -p tcp -m tcp --dport 80 -j REDIRECT --to-ports 51679'
  table :nat
end

include_recipe 'sysctl'
