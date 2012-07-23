class Product < ActiveRecord::Base
  has_many :line_items
  
  before_destroy :ensure_not_referenced_by_line_item
  
  validates :title, :description, :image_url, presence: true
  validates :price, numericality: {greater_than_or_equal_to: 0.01}
  validates :title, uniqueness: true
  validates :title, length: { minimum: 10, message: 'title must be atleast 10 characters.' }
  validates :image_url, allow_blank: true, format: {
    with:     %r{\.(gif|jpg|png)$}i,
    message:  'must be a URL for a GIF, JPG or PNG image.'
  }
  
  def ensure_not_referenced_by_line_item
    if line_items.empty?
      return true
    else
      errros.add(:base, 'Line Items Present')
      return false
    end
  end
  
end