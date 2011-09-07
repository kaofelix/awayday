class Talk
  include Mongoid::Document
  field :title
  field :subject
  field :category
  field :duration
  belongs_to :presenter

  DURATIONS = {:talk=>45, :workshop=>90}
  CATEGORIES = [
    "SIP",
    "Technical",
    "Non-Technical",
    "Entrepreuneurial",
    "Life Skills",
    "Nothing to do with Technology",
    "Health and Well Being",
    "Hobbies"
  ]

end
