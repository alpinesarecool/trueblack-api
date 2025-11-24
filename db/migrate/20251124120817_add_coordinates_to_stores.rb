class AddCoordinatesToStores < ActiveRecord::Migration[8.0]
  def up
    # Update each store with coordinates and metadata
    stores_data = [
      { name: 'Kompally', space_name: 'Soft Sand', area: 'Kompally', latitude: 17.5367, longitude: 78.4878, hours: '7:00 AM - 11:00 PM' },
      { name: 'Jubilee Hills', space_name: 'Modern Beige', area: 'Jubilee Hills', latitude: 17.4326, longitude: 78.4071, hours: '7:00 AM - 11:00 PM' },
      { name: 'Loft', space_name: 'Oak Moss', area: 'Madhapur', latitude: 17.4483, longitude: 78.3915, hours: '8:00 AM - 12:00 AM' },
      { name: 'Film Nagar', space_name: 'Burnt Earth', area: 'Film Nagar', latitude: 17.4134, longitude: 78.4084, hours: '7:00 AM - 11:00 PM' },
      { name: 'Kokapet', space_name: 'Travertine', area: 'Kokapet', latitude: 17.3956, longitude: 78.3323, hours: '7:00 AM - 11:00 PM' }  
    ]

    stores_data.each do |data|
      store = Store.find_by(name: data[:name])
      if store
        store.update!(
          space_name: data[:space_name],
          area: data[:area],
          latitude: data[:latitude],
          longitude: data[:longitude],
          hours: data[:hours]
        )
        puts "✅ Updated #{store.name} with coordinates"
      else
        puts "⚠️  Store #{data[:name]} not found"
      end
    end
  end

  def down
    # Optionally clear the coordinates if rolling back
    Store.update_all(latitude: nil, longitude: nil, space_name: nil, area: nil, hours: nil)
  end
end
