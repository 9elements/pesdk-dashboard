# config valid only for current version of Capistrano

set :application, 'photoeditorsdk'
set :repo_url, 'ssh://git@gitlab.9elements.com/photoeditorsdk/pesdk-website.git'
set :ssh_options, { forward_agent: true }
set :linked_dirs, %w{log tmp}
