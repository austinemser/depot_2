class FillPricesInLineItems < ActiveRecord::Migration
  def up
    LineItem.all.each do |item|
      item.price = item.product.price
    end
  end

  def down
    LineItem.all.each do |item|
      item.price = nil
    end
  end
end
