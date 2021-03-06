class Customer < ActiveRecord::Base
  #######################################################
  # Specifies Associations
  # Read more about Rails Associations here: http://guides.rubyonrails.org/association_basics.html
  has_many :orders

  #######################################################
  # Makes it so that when you print the object, you print a display name instead of the "#<ActiveRecord>blahblah" object name
  alias_attribute :name, :etsy_username

  #######################################################
  # Makes it so that you can edit these database columns via ActiveAdmin and forms
  attr_accessible *column_names

  def display_name
    if etsy_username
      "#{first_name} #{last_name} (#{etsy_username})"
    else
      "#{first_name} #{last_name}"
    end
  end

  def get_first_purchase_date
    order = Order.where(customer: self).order(sale_date: :asc).first
    if order
      order.sale_date
    else
      nil
    end
  end

  def get_last_purchase_date
    order = Order.where(customer: self).order(sale_date: :desc).first
    if order
      order.sale_date
    else
      nil
    end
  end

  def get_orders
    orders = Order.where(customer: self)
  end

  def get_unshipped_orders_count
    unshipped_orders = Order.where(customer: self, date_shipped: nil).count
  end

  def get_order_items
    OrderItem.joins(:order).where(orders: {customer: self})
  end

  def get_total_order_count
    get_orders.count
  end

  def get_total_order_items_count
    get_orders.sum(:number_of_items)
  end

  def get_total_spend
    # Accounts for fees
    (get_orders.sum(:order_net) - get_orders.sum(:refund)).round(2)
  end

  def get_average_items_per_order
    (get_total_order_items_count/get_total_order_count).round(2)
  end

  def get_average_spend_per_order
    (get_total_spend/get_total_order_count).round(2)
  end

end
