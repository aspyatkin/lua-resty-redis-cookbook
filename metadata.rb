name 'lua-resty-redis'
maintainer 'Alexander Pyatkin'
maintainer_email 'aspyatkin@gmail.com'
license 'MIT'
description 'Installs and configures lua-resty-redis'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'

recipe 'lua-resty-redis', 'Installs and configures lua-resty-redis'

depends 'apt'
depends 'build-essential'
depends 'lua', '~> 1.0.0'

source_url 'https://github.com/aspyatkin/lua-resty-redis-cookbook' if respond_to? :source_url
