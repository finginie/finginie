class Stock < Security
  validates :name, :uniqueness => true
end
