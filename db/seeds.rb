# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

members = [
  { email: 'franck.dagostini@gmail.com', firstname: 'Franck', lastname: "D'agostini" },
  { email: 'cedric.waeles@yahoo.fr', firstname: 'Cedric', lastname: 'Waeles' },
  { email: 'fabien.leyrisset@gmail.com', firstname: 'Fabien', lastname: 'Leyrisset' }
]

members.each do |member|
  Member.where(email: member[:email]).first_or_create(member)
end
