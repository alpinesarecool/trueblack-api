ActiveAdmin.register Store do
  permit_params :name, :address, :phone, :latitude, :longitude,
                :space_name, :area, :hours

  index do
    selectable_column
    id_column
    column :name
    column :space_name
    column :area
    column :address
    column :phone
    actions
  end

  filter :name
  filter :area
  filter :created_at

  form do |f|
    f.inputs do
      f.input :name
      f.input :space_name
      f.input :area
      f.input :address
      f.input :phone
      f.input :latitude
      f.input :longitude
      f.input :hours
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :space_name
      row :area
      row :address
      row :phone
      row :latitude
      row :longitude
      row :hours
      row :created_at
      row :updated_at
    end

    panel "Categories" do
      table_for store.categories do
        column :name do |category|
          link_to category.name, admin_category_path(category)
        end
        column :menu_items_count do |category|
          category.menu_items.count
        end
      end
    end
  end
end
