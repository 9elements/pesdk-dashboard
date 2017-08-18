set :stage, :production
set :app_port, 3032

set :ssh_options, { forward_agent: true, port: 24005 }

server = 'pesdk-dashboard-internal.gort.9elements.com'

role :app, server, user: 'app'

set :deploy_to, '/home/app/dashboard.internal.photoeditorsdk.com'
set :branch, ENV.fetch('BRANCH', 'master')
