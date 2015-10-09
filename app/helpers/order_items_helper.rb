module OrderItemsHelper

  # Sold Order Items ##############
  def get_items_sold
    OrderItem.all
  end

  def get_items_sold_count
    get_items_sold.sum(:quantity)
  end

  def get_items_sold_by_type(product_type)
    OrderItem.joins(:product).where(products: {product_type: product_type})
  end

  def get_items_sold_by_type_count(product_type)
    get_items_sold_by_type(product_type).sum(:quantity)
  end


  # Unshipped Order Items ##############
  def get_unshipped_items
    OrderItem.where(date_shipped: nil)
  end

  def get_unshipped_items_count
    get_unshipped_items.sum(:quantity)
  end

  def get_unshipped_items_by_type(product_type)
    OrderItem.joins(:product).where(products: {product_type: product_type}).where(date_shipped: nil)
  end

  def get_unshipped_items_by_type_count(product_type)
    get_unshipped_items_by_type(product_type).sum(:quantity)
  end

end