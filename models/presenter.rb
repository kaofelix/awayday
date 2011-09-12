class Presenter
  include Mongoid::Document
  field :name, type: String
  field :email, type: String

  has_many :talks
end
