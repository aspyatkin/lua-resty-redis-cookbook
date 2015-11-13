include_recipe 'build-essential'
include_recipe 'lua'

lua_resty_redis_tar_path = ::File.join Chef::Config['file_cache_path'], "lua-resty-redis-#{node['lua-resty-redis']['version']}.tar.gz"
lua_resty_redis_src_url = "#{node['lua-resty-redis']['url']}/v#{node['lua-resty-redis']['version']}.tar.gz"
lua_resty_redis_src_dir = ::File.join Chef::Config['file_cache_path'], "lua-resty-redis-#{node['lua-resty-redis']['version']}"

remote_file lua_resty_redis_tar_path do
  source lua_resty_redis_src_url
  checksum node['lua-resty-redis']['checksum']
  mode 0644
end

directory lua_resty_redis_src_dir do
  action :create
end

makefile_path = ::File.join lua_resty_redis_src_dir, 'Makefile'

execute "tar --no-same-owner -zxf #{::File.basename lua_resty_redis_tar_path } -C #{lua_resty_redis_src_dir} --strip-components 1" do
  cwd Chef::Config['file_cache_path']
  creates makefile_path
end

# cookbook_file 'patch Makefile' do
#   path makefile_path
#   source 'Makefile'
# end

execute 'make install lua-resty-redis package' do
  environment({
    'PATH' => '/usr/local/bin:/usr/bin:/bin',
    'LUA_LIB_DIR' => '/usr/local/share/lua/5.1'
  })
  command 'make install'
  cwd lua_resty_redis_src_dir
  # creates ::File.join(node['lua-cjson']['dir'], node['lua-cjson']['creates'])
end
