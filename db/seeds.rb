# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'csv'
puts "Seeding nodes, there are #{Node.count} nodes currently... "

csv = CSV.read('data/nodes.csv', headers: true)
node_data = []
csv.each do |row|
  node_data << { id: row["id"], parent_id: row["parent_id"] }
end
Node.insert_all(node_data)

puts "Done! There are now #{Node.count} nodes."
