class Stock < Security
  attr_accessible :symbol, :sector, :beta, :eps, :pe, :fifty_two_week_high_price, :fifty_two_week_high_date, :fifty_two_week_low_price, :fifty_two_week_low_date
  scope :by_last_traded_price, lambda { |min, max| where(:symbol => Scrip.find_ids_by_last_traded_price(min, max)) }
  scope :by_percent_change, lambda { |min, max| where(:symbol => Scrip.find_ids_by_percent_change(min, max)) }

  SECTOR_NAMES = [
    'Automobiles',
    'Banks - Private Sector',
    'Banks - Public Sector',
    'Bearings',
    'Biotechnology',
    'Breweries',
    'Cables',
    'Carbon Black',
    'Castings',
    'Cement',
    'Ceramics',
    'Chemicals',
    'Tobacco',
    'Chlor-Alkalies',
    'Cigarettes',
    'Coffee',
    'Coke',
    'Compressors / Drilling Equipment',
    'Computers',
    'Construction',
    'Consumer Durables',
    'Couriers & Logistics services',
    'Cycles and Spares',
    'Decorative - Wood-based',
    'Detergents / Intermediates',
    'Distilleries',
    'Diversified',
    'Dry Cells',
    'Dyes',
    'Edible oils',
    'Electrical Equipment',
    'Electrodes',
    'Electronics',
    'Engineering',
    'Engines',
    'Entertainment',
    'Fasteners',
    'Ferro Alloys',
    'Fertilizers',
    'Finance',
    'Fire - Protection Equipments',
    'Floriculture / Tissue Culture',
    'Food',
    'Forgings',
    'Gas Distribution',
    'Gems & Jewellery',
    'Glass',
    'Granite & Marbles',
    'Hatcheries',
    'Hospitals / Allied Medical Services',
    'Hotels',
    'Hydraulics',
    'Industrial Explosives',
    'Industrial Gas',
    'IT Enabled Services',
    'Laminates',
    'Leather',
    'Lubricants',
    'Machine Tools',
    'Metal',
    'Mining',
    'Miscellaneous',
    'Plastics',
    'Oil',
    'Packaging',
    'Paints',
    'Paper',
    'Personal Care',
    'Pesticides',
    'Petrochemicals',
    'Pharmaceuticals',
    'Photographics',
    'Power',
    'Printing & Stationery',
    'Pumps',
    'Refineries',
    'Refractories / Intermediates',
    'Retailing',
    'Rubber',
    'Ship',
    'Solvent Extraction',
    'Steel',
    'Sugar',
    'Tea',
    'Telecom',
    'Textile',
    'Trading Services ( Securities/Commodities)',
    'Trading',
    'Transmission Line Towers / Equipment',
    'Airlines',
    'Transport',
    'Travel Agencies',
    'Tyres',
  ]

  validates :name, :uniqueness => true
  validates :symbol, :uniqueness => true

  SCRIP_METHODS = [:last_traded_price, :percent_change, :net_change, :volume, :high_price, :low_price, :best_buy_price, :best_buy_quantity, :best_sell_price, :best_sell_quantity]
  delegate *SCRIP_METHODS, :to => :scrip, :allow_nil => true

  def scrip
    Scrip.find(symbol)
  end

  def current_value(transaction)
    last_traded_price
  end

  def as_json(options = {})
    options ||= {}
    super(options.merge(:methods => SCRIP_METHODS))
  end
end
