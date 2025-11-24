class AddMarketplaceCategory < ActiveRecord::Migration[7.0]
  def up
    # Add marketplace category and items to all stores
    Store.find_each do |store|
      # Create or find the MARKETPLACE category
      category = store.categories.find_or_create_by!(name: 'MARKETPLACE')
      
      # Marketplace items data
      marketplace_items = [
        { 
          name: 'Coffee Scrub', 
          description: '100% Arabica coffee body scrub', 
          price: 550,
          image_url: 'https://trueblack-api-production.up.railway.app/images/menu/coffee-scrub.jpg'
        },
        { 
          name: 'Dune Mug', 
          description: 'Handcrafted ceramic mug', 
          price: 850,
          image_url: 'https://trueblack-api-production.up.railway.app/images/menu/dune-mug.jpg'
        },
        { 
          name: 'Dune Cup', 
          description: 'Artisan ceramic cup', 
          price: 650,
          image_url: 'https://trueblack-api-production.up.railway.app/images/menu/dune.jpg'
        },
        { 
          name: 'Kinto Tumbler Beige', 
          description: 'Insulated travel tumbler', 
          price: 1250,
          image_url: 'https://trueblack-api-production.up.railway.app/images/menu/kinto-tumblr-beige.jpg'
        },
        { 
          name: 'Kinto Tumbler Steel', 
          description: 'Stainless steel tumbler', 
          price: 1450,
          image_url: 'https://trueblack-api-production.up.railway.app/images/menu/kinto-tumblr-stainless-steel.jpg'
        },
        { 
          name: 'Moonlight Cup', 
          description: 'Elegant ceramic cup', 
          price: 750,
          image_url: 'https://trueblack-api-production.up.railway.app/images/menu/moonlight-cup.jpg'
        },
        { 
          name: 'True Mocha Soap', 
          description: 'Coffee & cocoa natural soap', 
          price: 350,
          image_url: 'https://trueblack-api-production.up.railway.app/images/menu/true-mocha-soap.jpg'
        },
        { 
          name: 'Valencia Orange Soap', 
          description: 'Valencia orange natural soap', 
          price: 350,
          image_url: 'https://trueblack-api-production.up.railway.app/images/menu/valencia-orange-soap.jpg'
        }
      ]
      
      # Create each marketplace item
      marketplace_items.each do |item_data|
        category.menu_items.find_or_create_by!(name: item_data[:name]) do |item|
          item.description = item_data[:description]
          item.price = item_data[:price]
          item.image_url = item_data[:image_url]
          item.is_available = true
          item.is_veg = true
        end
      end
      
      puts "✅ Added marketplace category with #{marketplace_items.count} items to #{store.name}"
    end
  end

  def down
    # Remove marketplace category and its items from all stores
    Store.find_each do |store|
      category = store.categories.find_by(name: 'MARKETPLACE')
      category&.destroy
      puts "🗑️ Removed marketplace category from #{store.name}"
    end
  end
end
