class Picture < ActiveRecord::Base
	include Elements::Element
  using_access_control
  attr_accessible :title, :description, :image
  has_attached_file :image,
    :styles => { 
        :tiny_thumb => "50x20>", 
        :small_thumb =>"100x100>", 
        :thumb => "200x200", 
        :medium => "640x480>",
        :large => "1024x768",
        :x_large => "1280x1024",
        :xx_large => "1440x900"#,
        #:custom => Proc.new { |instance| "#{instance.photo_width}x#{instance.photo_height}>" }
        }#,
        #:custom => Proc.new { |instance| "#{instance.image_width}x#{instance.image_height}>" } }
    #:path => "/:class/:id/:style/:filename"
  validates_presence_of :image
  #validates_attachment_size :image, :less_than => 5.megabytes
  #validates_attachment_content_type :image, :content_type => [ 'image/gif', 'image/png', 'image/x-png', 'image/jpeg', 'image/pjpeg', 'image/jpg' ]
  liquid_methods :title, :description, :image
  #named_scope :has_element_with, lambda {|conditions| { :joins => :element, :conditions => conditions } }
      # Gets pictures
    # SELECT * FROM pictures INNER JOIN elements ON elements.attachable_id = pictures.id and elements.attachable_type = 'Picture' and elements.ancestry = '118'
  #named_scope :in_gallery, :joins => 
  #named_scope :ancestors_of, lambda { |object| {:conditions => to_node(object).ancestor_conditions} }

end
