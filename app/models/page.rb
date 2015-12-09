class Page < ActiveRecord::Base
  belongs_to :website
  has_many :page_translations
  has_many :simple_blocks
  
  translates :title, :content, :slug
  extend FriendlyId
  friendly_id :title, use: [:slugged, :globalize]

  globalize_accessors locales: I18n.available_locales, attributes: [:title, :content]
end