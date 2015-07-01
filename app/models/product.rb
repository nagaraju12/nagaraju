class Product < ActiveRecord::Base
	has_many :line_items

	has_attached_file :photo, :styles => { :small => "150x150>" },
                  :url  => "/assets/products/:id/:style/:basename.:extension",
                  :path => ":rails_root/public/assets/products/:id/:style/:basename.:extension"

validates_attachment_presence :photo
validates_attachment_size :photo, :less_than => 5.megabytes
validates_attachment_content_type :photo, :content_type => ['image/jpeg', 'image/png']
has_many :comments
  validates :title, presence: true,
                    length: { minimum: 5 }
end
def self.latest
Product.order(:updated_at).last
end

private

 def ensure_not_referenced_by_any_line_item
	if line_items.empty?
	 return true
	else
	 errors.add(:base, 'Line Items present')
	 return false
	end
 end
