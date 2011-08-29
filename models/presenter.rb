class Presenter
  include Mongoid::Document
  field :name
  has_many :talks
end
