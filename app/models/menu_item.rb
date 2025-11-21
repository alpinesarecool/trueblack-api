class MenuItem < ApplicationRecord
  belongs_to :category
  has_one_attached :image

  validates :name, presence: true
  validates :price, presence: true, numericality: { greater_than_or_equal_to: 0 }

  # Generate image URL for GraphQL
  def image_url_with_fallback
    if image.attached?
      Rails.application.routes.url_helpers.url_for(image)
    elsif image_url.present?
      image_url
    else
      # Fallback to static images
      slug = name.downcase.gsub(' ', '-')
      "#{ENV['BASE_URL'] || 'https://trueblack-api-production.up.railway.app'}/images/menu/#{slug}.jpg"
    end
  end
end
