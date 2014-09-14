# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)
Plan.create(name: 'TextMogul1', stripe_id: 'TM1', price: 39.95, interval: 'month')
Plan.create(name: 'TextMogulSubscriber1', stripe_id: 'TMS1', price: 2.99, interval: 'month')
