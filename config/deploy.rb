# config valid only for current version of Capistrano

set :application, 'dashboard'
set :repo_url, 'ssh://git@github.com:imgly/#{application}.git'
set :ssh_options, { forward_agent: true }
set :linked_dirs, %w{log tmp}
