class Product < ActiveRecord::Base
  default_scope :order => "title"
  has_many :line_items
  attr_accessible :description, :image_url, :price, :line_item_id, :title
  validates :description, :image_url, :price, :title, :presence => true
  validates :price, :numericality => { :greater_than_or_equal_to => 0.01 }
  validates :title, :uniqueness => true
  validates :image_url, :format => {
    :with => %r{\.(jpg|gif|png)$}i,
    :message => 'must be a URL for GIF, JPG or PNG image.'
  }
  before_destroy :ensure_not_referenced_by_any_line_item
  
  def ensure_not_referenced_by_any_line_item
    if line_items.empty?
      return true
    else
      errors.add(:base, 'Line Items present' )
      return false
    end  
  end
end
