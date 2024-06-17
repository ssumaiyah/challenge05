require 'csv'

# Clear out the existing data
Product.destroy_all
Category.destroy_all

# Load the CSV file
csv_file = Rails.root.join('db/products.csv')
csv_data = File.read(csv_file)

# Parse the CSV data
products = CSV.parse(csv_data, headers: true)

products.each do |product|
  # Get or create the category
  category_name = product['category']
  category = Category.find_or_create_by(name: category_name)

  # Create the product
  Product.create(
    title: product['name'],
    description: product['description'],
    price: product['price'],
    stock_quantity: product['stock_quantity'],
    category: category
  )
end

puts "Created #{Product.count} products and #{Category.count} categories."
