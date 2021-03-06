name             'aws_ecs'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          ''
description      'Installs/Configures aws_ecs-cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.19'

depends 'aufs'
depends 'sysctl', '~> 1.0.5'
depends 'iptables', '~> 4.2.0'
depends 'docker', '~> 4.1.0'
depends 'chef-apt-docker', '~> 2.0.4'
depends 'storage', '6.0.4'
