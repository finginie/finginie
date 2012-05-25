class FixedDepositDetail < SheetMapper::Base
  columns :min_duration, :max_duration, :rate_of_interest_general,
          :rate_of_interest_senior_citizen, :min_amount, :max_amount,
          :bank, :sector

  def self.collection
    @collection ||= fetch
  end

  def self.find_by_amount(amount)
    lambda { |fd_detail| fd_detail.min_amount <= amount and fd_detail.max_amount >= amount }
  end

  def self.find_by_duration(params)
    duration = params[:year].to_i * 365 + params[:month].to_i * 30 + params[:days].to_i
    duration = duration > 0 ? duration : 365
    lambda { |fd_detail| fd_detail.min_duration <= duration and fd_detail.max_duration >= duration }
  end

  def self.order_by(column)
    lambda { |x,y| y.send(column) <=> x.send(column) }
  end

  def self.public_sector
    lambda {|fd_detail| fd_detail.sector == "public" || fd_detail.sector == "PUBLIC"}
  end

  def self.find_by_bank(name)
    lambda {|fd_detail| fd_detail.bank == name }
  end

  def self.private_sector
    lambda {|fd_detail| fd_detail.sector == "private" || fd_detail.sector == "PRIVATE"}
  end

  def self.top_public_banks
    collection.select(&public_sector)
              .select(&find_by_duration({:year => 1}))
              .sort(&order_by("rate_of_interest_general"))
              .group_by(&:bank).keys.take(5)
  end

  def self.top_private_banks
    collection.select(&private_sector)
              .select(&find_by_duration({:year => 1}))
              .sort(&order_by("rate_of_interest_general"))
              .group_by(&:bank).keys.take(5)
  end

  def self.top_five_public_banks_interest_rates
    top_public_banks.map do |bank|
      build_bank_interest_rates(collection.select(&find_by_bank(bank)))
    end
  end

  def self.top_five_private_banks_interest_rates
    top_private_banks.map do |bank|
      build_bank_interest_rates(collection.select(&find_by_bank(bank)))
    end
  end

  def self.search(params)
    search = collection
    search = search.select(&find_by_amount(params[:amount].to_i)) if params[:amount]
    search = search.select(&find_by_duration(params[:duration]))  if params[:duration]
    search = search.sort(&order_by(params[:senior_citizen]))      if params[:senior_citizen]
    search
  end

private
  def self.fetch
    sheet = SheetMapper::Spreadsheet.new(mapper: FixedDepositDetail, key: ENV['SPREADSHEET_KEY'],
                                         login: ENV['SPREADSHEET_LOGIN'], password: ENV['SPREADSHEET_PASSWORD'])
    collection = sheet.find_collection_by_title('data').records
    collection.map do |fd_data|
      attributes_hash(fd_data.attributes)
    end
  end

  def self.attributes_hash(data)
    FixedDepositDetailProxy.new(data)
  end

  def self.build_bank_interest_rates(fd_detail)
    Hashie::Mash.new(
        name: fd_detail.first.bank,
        sector: fd_detail.first.sector,
        one_year_interest_rate: fd_detail.select(&find_by_duration({:year => 1})).first.try(:rate_of_interest_general),
        six_month_interest_rate: fd_detail.select(&find_by_duration({:month => 6})).first.try(:rate_of_interest_general),
        three_month_interest_rate: fd_detail.select(&find_by_duration({:month => 3})).first.try(:rate_of_interest_general),
        one_month_interest_rate: fd_detail.select(&find_by_duration({:month => 1})).first.try(:rate_of_interest_general),
    )
  end
end
