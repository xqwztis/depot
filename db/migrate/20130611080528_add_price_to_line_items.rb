class AddPriceToLineItems < ActiveRecord::Migration
  def change
    add_column :line_items, :price, :decimal, :precision => 8, :scale => 2
    LineItem.all.each do |item|
      product = Product.find(item.product_id)
      item.update_attribute :price => product.price
    end
  end
end
