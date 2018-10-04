name             'aws_ecs'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          ''
description      'Installs/Configures aws_ecs-cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.5'

depends 'aufs'
depends 'sysctl', '~> 1.0.5'
depends 'iptables', '~> 4.2.0'
depends 'docker', '~> 2.15.28'
depends 'chef-apt-docker', '~> 2.0.4'
depends 'storage', '>= 3.0'
