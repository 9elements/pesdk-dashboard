set :stage, :production

set :ssh_options, { forward_agent: true }

server = '46.101.103.13'

role :app, server, user: 'app'

set :deploy_to, '/home/app/dashboard.internal.photoeditorsdk.com'
set :branch, ENV.fetch('BRANCH', 'master')
