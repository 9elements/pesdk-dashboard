require 'chartmogul'

ChartMogul.account_token = 'cb67558394369d9edb40105f88826e9b'
ChartMogul.secret_key = 'bf324aa567cade946a5843c097c70fb2'

transform = {
  'arr': Proc.new { |val| val/100 },
  'mrr':  Proc.new { |val| val/100 },
  'asp':  Proc.new { |val| val/100 },
  'customers':  Proc.new { |val| val }
}

SCHEDULER.every '200s', first_in: '0s' do
  metrics = ChartMogul::Metrics.all(start_date: '2017-07-01', end_date: '2017-08-17', interval: 'month')

  previous_metrics =  metrics.entries.first
  current_metrics =  metrics.entries.last

  send_event(['chartmogul', 'mrr'].join(':'), {
    current: current_metrics.mrr/100,
    last: previous_metrics.mrr/100,
  })

  send_event(['chartmogul', 'arr'].join(':'), {
    current: current_metrics.arr/100,
    last: previous_metrics.arr/100,
  })

  send_event(['chartmogul', 'asp'].join(':'), {
    current: current_metrics.asp/100,
    last: previous_metrics.asp/100,
  })

  send_event(['chartmogul', 'customers'].join(':'), {
    current: current_metrics.customers,
    last: previous_metrics.customers,
  })

  send_event( ['chartmogul', 'mrr_goal'].join(':'), {
    value: current_metrics.mrr/50000
  })

end