class Talk
  include Mongoid::Document
  field :title
  field :subject
  field :category
  field :duration
  belongs_to :presenter
end
