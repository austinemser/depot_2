class LineItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :product
  
  def total_price
    quantity * price
  end
end

