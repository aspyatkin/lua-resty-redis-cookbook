id = 'lua-resty-redis'

default[id]['dir'] = '/usr/local'
default[id]['version'] = '0.21'
default[id]['url'] = 'https://github.com/openresty/lua-resty-redis/archive'
default[id]['checksum'] = 'a2c2686b18c4ab2943d1cb27da80f6b9e1902b78e50dfd0367c164244e193e73'
default[id]['creates'] = 'share/lua/5.1/resty/redis.so'
