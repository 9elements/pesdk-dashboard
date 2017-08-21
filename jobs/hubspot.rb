# require 'hubspot-ruby'
# Hubspot.configure(hapikey: "e10d0faa-e6e3-419d-8923-067f37af09e4")

# max_recent_deals = 5

# SCHEDULER.every '2m', first_in: '0s' do
#   hubspot_recent_deals = Hubspot::Deal.recent.first(max_recent_deals)

#   hubspot_deals = hubspot_recent_deals
#     .map(&:properties)
#     .map{ |deal|
#       {
#         'label' => deal.fetch('dealname'),
#         'value' => "$ #{deal.fetch('amount')}"
#       }
#     }
#   # List widget requires items with label and valiue
#   send_event(['hubspot', 'deals'].join(':'), { items: hubspot_deals })
# end
