include_recipe 'build-essential'
include_recipe 'lua'
id = 'lua-resty-redis'

lua_resty_redis_tar_path = ::File.join(
  ::Chef::Config['file_cache_path'],
  "lua-resty-redis-#{node[id]['version']}.tar.gz"
)
lua_resty_redis_src_url = "#{node[id]['url']}/v#{node[id]['version']}.tar.gz"
lua_resty_redis_src_dir = ::File.join(
  ::Chef::Config['file_cache_path'],
  "lua-resty-redis-#{node[id]['version']}"
)

remote_file lua_resty_redis_tar_path do
  source lua_resty_redis_src_url
  checksum node[id]['checksum']
  mode 0644
end

directory lua_resty_redis_src_dir do
  action :create
end

makefile_path = ::File.join lua_resty_redis_src_dir, 'Makefile'

execute "tar --no-same-owner -zxf #{::File.basename(lua_resty_redis_tar_path)}"\
        " -C #{lua_resty_redis_src_dir} --strip-components 1" do
  cwd ::Chef::Config['file_cache_path']
  creates makefile_path
end

execute 'make install lua-resty-redis package' do
  environment(
    'PATH' => '/usr/local/bin:/usr/bin:/bin',
    'LUA_LIB_DIR' => '/usr/local/share/lua/5.1'
  )
  command 'make install'
  cwd lua_resty_redis_src_dir
  creates ::File.join node[id]['dir'], node[id]['creates']
end
