class NavMaster
  include Mongoid::Document

  field  :scheme_code, :type => Float
  field  :ticker_name
  field  :mapping_code
  field  :map_name
  field  :issue_price, :type => Float
  field  :description
  field  :issue_date, :type => DateTime
  field  :expiry_date, :type => DateTime
  field  :face_value, :type => Float
  field  :market_lot, :type => Float
  field  :isin_code
  field  :bench_mark_index
  field  :bench_mark_index_name
end
class AddNavMasterFieldsToScheme < Mongoid::Migration
  def self.up
    NavMaster.all.each do |nav_master|
      @scheme = Scheme.where(securitycode: nav_master.security_code).first
      if @scheme
        @scheme.update_attributes( :scheme_code           => nav_master.scheme_code,
                                   :ticker_name           => nav_master.ticker_name,
                                   :map_name              => nav_master.map_name,
                                   :issue_price           => nav_master.issue_price,
                                   :description           => nav_master.description,
                                   :issue_date            => nav_master.issue_date,
                                   :expiry_date           => nav_master.expiry_date,
                                   :face_value            => nav_master.face_value,
                                   :market_lot            => nav_master.market_lot,
                                   :isin_code             => nav_master.isin_code,
                                   :bench_mark_index      => nav_master.bench_mark_index,
                                   :bench_mark_index_name => nav_master.bench_mark_index_name )
        nav_master.destroy
      end
    end
  end

  def self.down
  end
end
