require 'chartmogul'

ChartMogul.account_token = 'cb67558394369d9edb40105f88826e9b'
ChartMogul.secret_key = 'bf324aa567cade946a5843c097c70fb2'

SCHEDULER.every '200s', first_in: '0s' do
  metrics = ChartMogul::Metrics.all(start_date: '2017-07-01', end_date: '2017-08-17', interval: 'month')

  previous_metrics =  metrics.entries.first
  current_metrics =  metrics.entries.last

  ['arr', 'mrr'].each do |key|
    current = current_metrics.send(key)
    previous = previous_metrics.send(key)
    data_id = ['chartmogul', key].join(':')
    send_event(data_id, { current: current, last: previous })
  end

  # require 'pry'
  # binding.pry
  send_event('chartmogul:mrr_goal', {
    current: current_metrics.mrr/50000,
    last: previous_metrics.mrr/50000
  })



end