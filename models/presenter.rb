class Presenter
  include Mongoid::Document
  field :name, type: String
  field :email, type: String

  has_many :talks

  validates_presence_of :name
  validates_presence_of :email
  validates_presence_of :talks

  validates_format_of :email, with: /\b[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}\b/

  validates_uniqueness_of :name, case_sensitive: false
  validates_uniqueness_of :email, case_sensitive: false
end
