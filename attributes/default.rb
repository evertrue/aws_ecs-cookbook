default['aws_ecs']['cluster_name'] = 'test'
default['aws_ecs']['data_dir'] = '/datadir'
default['aws_ecs']['log_file'] = '/log/ecs-agent.log'
default['aws_ecs']['aws_api_user'] = 'Ecs'

default['storage']['ignore_ephemeral_mounts'] = true
default['storage']['use_storage_aws_credentials'] = true
default['storage']['ebs_volumes']['vol1'] = {
  'device' => '/dev/xvdf',
  'size' => 100,
  'delete_on_termination' => false,
  'volume_type' => 'gp2'
}

override['storage'] = node['storage']
