require 'chartmogul'
require 'pry'
ChartMogul.account_token = 'cb67558394369d9edb40105f88826e9b'
ChartMogul.secret_key = 'bf324aa567cade946a5843c097c70fb2'


next_mrr_goal = 50000

SCHEDULER.every '200s', first_in: '0s' do
  end_date = DateTime.now.iso8601.slice(0,10)
  start_date = (DateTime.new(DateTime.now.year)).iso8601.slice(0,10)
  metrics = ChartMogul::Metrics.all(start_date: start_date, end_date: end_date, interval: 'month')

  previous_metrics =  metrics.entries[-2]
  current_metrics =  metrics.entries[-1]

  all_mrr = metrics
    .entries.map.with_index{ |entry, i|
    {
      'x' => i,
      'y' => entry.mrr/100
    }
  }

  all_mrr_goal = metrics
   .entries.map.with_index{ |entry, i|
    {
      'x' => i,
      'y' => (entry.mrr/next_mrr_goal).to_i
    }
  }


  start_mrr = metrics.entries.first.mrr

  all_mrr_increase = metrics
  .entries.map.with_index{ |entry, i|
    {
     'x' => i,
     'y' => (((entry.mrr-start_mrr).to_f/start_mrr.to_f)*100).to_i
     }
 }


  send_event(['chartmogul', 'mrr_timeseries'].join(':'), points: all_mrr, displayedValue: all_mrr.last["y"])
  send_event(['chartmogul', 'mrr_goal_timeseries'].join(':'), points: all_mrr_goal, displayedValue: all_mrr_goal.last["y"])

  send_event(['chartmogul', 'mrr_increase_timeseries'].join(':'), points: all_mrr_increase, displayedValue: all_mrr_increase.last["y"])


  send_event(['chartmogul', 'mrr'].join(':'), {
    points: current_metrics.mrr/100,
    last: previous_metrics.mrr/100,
  })


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
    value: current_metrics.mrr/next_mrr_goal
  })

  send_event( ['chartmogul', 'intermedia_mrr_goal'].join(':'), {
    value: (current_metrics.mrr-5000000)/5000
  })

  send_event( ['chartmogul', 'next_mrr_goal'].join(':'), {
    value: (current_metrics.mrr-5000000)/10000
  })
end