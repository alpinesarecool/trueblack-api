ActiveAdmin.register Category do
  permit_params :name, :store_id

  index do
    selectable_column
    id_column
    column :name
    column :store
    column :menu_items_count do |category|
      category.menu_items.count
    end
    actions
  end

  filter :name
  filter :store
  filter :created_at

  form do |f|
    f.inputs do
      f.input :store, as: :select, collection: Store.all.map { |s| [s.name, s.id] }
      f.input :name
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :store
      row :created_at
      row :updated_at
    end

    panel "Menu Items" do
      table_for category.menu_items do
        column :name do |item|
          link_to item.name, admin_menu_item_path(item)
        end
        column :price
        column :is_available
        column :is_veg
      end
    end
  end
end
