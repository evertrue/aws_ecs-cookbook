name             'aws_ecs'
maintainer       'EverTrue, Inc.'
maintainer_email 'devops@evertrue.com'
license          ''
description      'Installs/Configures aws_ecs-cookbook'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.2'

depends 'aufs'
depends 'sysctl'
depends 'iptables', '~> 4.2.0'
depends 'docker'
depends 'chef-apt-docker'
