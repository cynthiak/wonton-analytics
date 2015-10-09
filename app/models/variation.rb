class Variation < ActiveRecord::Base
  #######################################################
  # Specifies Associations
  # Read more about Rails Associations here: http://guides.rubyonrails.org/association_basics.html
  belongs_to :product
  has_many :listings

  #######################################################
  # Makes it so that when you print the object, you print a display name instead of the "#<ActiveRecord>blahblah" object name
  alias_attribute :name, :variation_name

  #######################################################
  # Makes it so that you can edit these database columns via ActiveAdmin and forms
  attr_accessible :variation_name, :style, :gender, :color, :size, :product_id

  def display_name
    product = Product.find_by_id(self.product_id)
    return product.product_name + ' - ' + self.variation_name.to_s
  end

  def get_unshipped_order_items_count
    OrderItem.where(variation: self).where(date_shipped: nil).sum(:quantity)
  end

  def get_shipped_order_items_count
    OrderItem.where(variation: self).where.not(date_shipped: nil).sum(:quantity)
  end

  def get_sold_order_items_count
    OrderItem.where(variation: self).sum(:quantity)
  end

end