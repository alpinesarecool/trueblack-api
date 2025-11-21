ActiveAdmin.register MenuItem do
  permit_params :name, :description, :price, :category_id,
                :is_available, :is_veg, :image

  index do
    selectable_column
    id_column
    column :image do |item|
      if item.image.attached?
        image_tag url_for(item.image), size: "50x50"
      else
        "No image"
      end
    end
    column :name
    column :description do |item|
      truncate(item.description, length: 50)
    end
    column :price do |item|
      number_to_currency(item.price, unit: "₹")
    end
    column :category
    column :is_available
    column :is_veg
    actions
  end

  filter :name
  filter :category
  filter :is_available
  filter :is_veg
  filter :price

  form do |f|
    f.inputs do
      f.input :category, as: :select,
              collection: Category.includes(:store).map { |c|
                ["#{c.store.name} - #{c.name}", c.id]
              }
      f.input :name
      f.input :description, as: :text
      f.input :price
      f.input :is_available
      f.input :is_veg
      f.input :image, as: :file, hint: f.object.image.attached? ?
              image_tag(url_for(f.object.image), size: "200x200") :
              content_tag(:span, "No image uploaded yet")
    end
    f.actions
  end

  show do
    attributes_table do
      row :id
      row :name
      row :description
      row :price do |item|
        number_to_currency(item.price, unit: "₹")
      end
      row :category do |item|
        "#{item.category.store.name} - #{item.category.name}"
      end
      row :is_available
      row :is_veg
      row :image do |item|
        if item.image.attached?
          image_tag url_for(item.image), size: "400x400"
        else
          "No image"
        end
      end
      row :created_at
      row :updated_at
    end
  end
end
