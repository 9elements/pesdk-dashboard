# config valid only for current version of Capistrano

set :application, 'imgly internal dashboard'
set :repo_url, 'ssh://git@github.com:imgly/dashboard.git'
set :ssh_options, { forward_agent: true }
set :linked_dirs, %w{log tmp}
