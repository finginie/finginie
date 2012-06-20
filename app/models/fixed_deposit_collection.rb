class FixedDepositCollection < SheetMapper::Base
  columns :min_duration, :max_duration, :rate_of_interest_general,
          :rate_of_interest_senior_citizen, :min_amount, :max_amount,
          :bank, :sector

  module ClassMethods
    def all
      @collection ||= fetch
    end

    def find_by_amount(amount)
      lambda { |fd_detail| fd_detail.min_amount <= amount and fd_detail.max_amount >= amount }
    end

    def find_by_duration(params)
      duration = duration(params)
      lambda { |fd_detail| fd_detail.min_duration <= duration and fd_detail.max_duration >= duration }
    end

    def duration(params)
      duration = (Date.today - params[:month].to_i.months.ago.to_date + params[:days].to_i + params[:year].to_i * 365)
      duration = duration > 0 ? duration : 365
    end

    def order_by(column)
      lambda { |x,y| y.send(column) <=> x.send(column) }
    end

    def public_sector
      lambda {|fd_detail| fd_detail.sector == "public" || fd_detail.sector == "PUBLIC"}
    end

    def find_by_bank(name)
      lambda {|fd_detail| fd_detail.bank == name }
    end

    def find_by_special_tenure(params)
      duration = duration(params)
      lambda { |fd_detail| fd_detail.min_duration <= duration + 60 and fd_detail.min_duration >= duration -60 and fd_detail.max_duration == 0 }
    end

    def private_sector
      lambda {|fd_detail| fd_detail.sector == "private" || fd_detail.sector == "PRIVATE"}
    end

    def top_public_banks
      all.
        select(&public_sector).
        select(&find_by_duration({:year => 1})).
        sort(&order_by("rate_of_interest_general")).
        group_by(&:bank).keys.take(5)
    end

    def top_private_banks
      all.
        select(&private_sector).
        select(&find_by_duration({:year => 1})).
        sort(&order_by("rate_of_interest_general")).
        group_by(&:bank).keys.take(5)
    end

    def top_five_public_banks_interest_rates
      top_public_banks.map do |bank|
        build_bank_interest_rates(all.select(&find_by_bank(bank)))
      end
    end

    def top_five_private_banks_interest_rates
      top_private_banks.map do |bank|
        build_bank_interest_rates(all.select(&find_by_bank(bank)))
      end
    end

    def search(params)
      search_option(params, "duration")
    end

    def special_tenure(params)
      search_option(params, "special_tenure")
    end

  private
    def search_option(params, duration_options)
      search = all
      search = (params[:senior_citizen] == "Yes") ? search.sort(&order_by("rate_of_interest_senior_citizen")) : search.sort(&order_by("rate_of_interest_general"))
      search = search.select(&find_by_amount(params[:amount].to_i))              if params[:amount]
      search = search.select(&send("find_by_#{duration_options}", params))       if params[:year] || params[:month] || params[:days]
      search
    end

    def fetch
      sheet = SheetMapper::Spreadsheet.new(
          :mapper => FixedDepositCollection,
          :key => ENV['SPREADSHEET_KEY'],
          :login => ENV['SPREADSHEET_LOGIN'],
          :password => ENV['SPREADSHEET_PASSWORD']
        )
      collection = sheet.find_collection_by_title('data').records
      collection.map do |fd_data|
        fixed_deposit_detail(fd_data.attributes)
      end
    end

    def fixed_deposit_detail(data)
      FixedDepositDetail.new(data)
    end

    def build_bank_interest_rates(fd_detail)
      Bank.new(
          :name => fd_detail.first.bank,
          :sector => fd_detail.first.sector,
          :one_year_interest_rate => fd_detail.select(&find_by_duration(:year => 1)).first.try(:rate_of_interest_general),
          :six_month_interest_rate => fd_detail.select(&find_by_duration(:month => 6)).first.try(:rate_of_interest_general),
          :three_month_interest_rate => fd_detail.select(&find_by_duration(:month => 3)).first.try(:rate_of_interest_general),
          :one_month_interest_rate => fd_detail.select(&find_by_duration(:month => 1)).first.try(:rate_of_interest_general)
      )
    end
  end; extend ClassMethods
end
