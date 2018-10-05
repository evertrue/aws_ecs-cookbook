default['aws_ecs']['cluster_name'] = 'test'
default['aws_ecs']['data_dir'] = '/datadir'
default['aws_ecs']['log_file'] = '/log/ecs-agent.log'
default['aws_ecs']['aws_api_user'] = 'Ecs'

default['filesystem']['by_mountpoint'] = node['filesystem2']['by_mountpoint']
default['filesystem']['by_device'] = node['filesystem2']['by_device']
default['filesystem']['by_pair'] = node['filesystem2']['by_pair']

default['storage']['ebs_volumes']['vol1'] = {
  'device' => '/dev/xvde',
  'size' => 100,
  'delete_on_termination' => false,
  'volume_type' => 'gp2'
}

override['storage'] = node['storage']
