class Talk
  include Mongoid::Document
  field :title, type: String
  field :summary, type: String
  field :category, type: String
  field :duration, type: Integer

  belongs_to :presenter

  DURATIONS = {:talk => 45, :workshop => 90}
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

  validates_presence_of :title
  validates_presence_of :summary
  validates_presence_of :category
  validates_presence_of :duration
  validates_presence_of :presenter

  validates_inclusion_of :category, in: CATEGORIES
  validates_inclusion_of :duration, in: DURATIONS.values

  validates_length_of :summary, within: 50..400

end
