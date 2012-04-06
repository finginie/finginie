require 'pinch'

class Hash
  def underscore_keys!
    keys.each do |key|
      self[(key.underscore rescue key) || key] = delete(key)
    end
    self
  end
end
class CorporateInformationData

  attr_accessor :file_list

  DATA_URL = 'http://download.dionglobal.in/portals/'

  FILE_NAMES = [
    # Corporate Data files
    'AccountingPolicy.xml',
    'AnnouncementsAGMBC.xml',
    'AnnouncementsBoardMeeting.xml',
    'AuditorsReport.xml',
    'AuditedResults.xml',
    'Bonus.xml',
    'BSEPrice.xml',
    'Capitalstructure.xml',
    'CashFlow.xml',
    'CompanyMaster.xml',
    'CorpGovernancereport.xml',
    'DirectorsReport.xml',
    'Dividend.xml',
    'HalfyearlyResults.xml',
    'IndividualHolding.xml',
    'IndustryMaster.xml',
    'KeyExecutives.xml',
    'News.xml',
    'NinemonthsResults.xml',
    'NotesToAccount.xml',
    'NSEPrice.xml',
    'Products.xml',
    'QuarterlyResults.xml',
    'Ratios.xml',
    'Rawmaterial.xml',
    'ShareHolding.xml',
    'Splits.xml',
    'Subsidiaries.xml',
    'CurrDetails.xml',
    #Mutual funds files
    'SchemeMaster.xml',
    'MfObjectives.xml',
    'NAVCP.xml',
    'NavMaster.xml',
    'FundMaster.xml',
    'MFDividendDetails.xml',
    'MFSchemeWisePortfolio.xml',
    'NAVCategoryDetails.xml',
    'MFBonusDetails.xml'
  ]

  FILE_NAME_AND_MODEL = {
    "CurrDetails"           => Company,
    "CompanyMaster"         => Company,
    "NAVCategoryDetails"    => NetAssetValueCategory,
    "SchemeMaster"          => Scheme,
    "MFDividendDetails"     => MfDividendDetail,
    "MFObjectives"          => Scheme,
    "NAVCP"                 => Scheme,
    "NavMaster"             => Scheme,
    "FundMaster"            => AssetManagementCompany,
    "MFBonusDetails"        => MfBonusDetail,
    "MFSchemeWisePortfolio" => MfSchemeWisePortfolio
  }

  FIELDS_FOR_EXTRACTION = {
    "CurrDetails"  => [ :company_code, :pe_ratio, :fifty_twoweek_high, :fifty_twoweek_low, :eps ],
    "MFObjectives" => [ :securitycode, :objective ],
    "NAVCP"        => [ :security_code,
                        :ticker,
                        :datetime,
                        :nav_amount,
                        :repurchase_load,
                        :repurchase_price,
                        :sale_load,
                        :sale_price,
                        :prev_nav_amount,
                        :prev_repurchase_price,
                        :prev_sale_price,
                        :percentage_change,
                        :prev1_week_amount,
                        :prev1_week_per,
                        :prev1_month_amount,
                        :prev1_month_per,
                        :prev3_months_amount,
                        :prev3_months_per,
                        :prev6_months_amount,
                        :prev6_months_per,
                        :prev9_months_amount,
                        :prev9_months_per,
                        :prev_year_amount,
                        :prev_year_per,
                        :prev2_year_amount,
                        :prev2_year_per,
                        :prev2_year_comp_per,
                        :prev3_year_amount,
                        :prev3_year_per,
                        :prev3_year_comp_per,
                        :list_date,
                        :list_amount,
                        :list_per,
                        :rank ],
  "NavMaster"     =>  [ :security_code,
                        :scheme_code,
                        :mapping_code,
                        :map_name,
                        :issue_price,
                        :description,
                        :issue_date ,
                        :expiry_date,
                        :face_value,
                        :market_lot,
                        :isin_code ,
                        :bench_mark_index,
                        :bench_mark_index_name ]

  }

  FIELDS_FOR_RENAME = {
    "CurrDetails" => {
      :pe_ratio           => :pe,
      :fifty_twoweek_high => :fifty_two_week_high_price,
      :fifty_twoweek_low  => :fifty_two_week_low_price
    },
    "SchemeMaster" => {
      :minimum_invement_amount => :minimum_investment_amount,
      :amc_code                => :asset_management_company_code,
      :redemption_ferq         => :redemption_frequency
    },
    "NAVCP"       => {
      :security_code         => :securitycode,
      :ticker                => :ticker_name,
      :prev1_week_per        => :prev1_week_percent,
      :prev1_month_per       => :prev1_month_percent,
      :prev3_months_per      => :prev3_months_percent,
      :prev6_months_per      => :prev6_months_percent,
      :prev9_months_per      => :prev9_months_percent,
      :prev_year_per         => :prev_year_percent,
      :prev2_year_per        => :prev2_year_percent,
      :prev2_year_comp_per   => :prev2_year_comp_percent,
      :prev3_year_per        => :prev3_year_percent,
      :prev3_year_comp_per   => :prev3_year_comp_percent,
      :list_per              => :list_percent
    },
    "NavMaster"   => {
      :security_code         => :securitycode,
    },
    "FundMaster"  => {
      :amc_code              => :asset_management_company_code,
      :amc_name              => :asset_management_company_name,
      :amc_inc_date          => :asset_management_company_incorporation_date
    }
  }

  def self.update_data
    parser = new
    parser.file_list.each do |file|
      begin
        parser.parse_and_update file
      rescue => ex
        Airbrake.notify ex
      end
    end
  end

  def initialize
    @remote_archive = Pinch.new("#{DATA_URL}XI#{Date.today.strftime('%d%m%Y')}#{type}.zip")
    @file_list = @remote_archive.file_list & FILE_NAMES
  end

  ##
  # {
  #   "AccountingPolicy" => {
  #     "Item" => [<Hashes of records>]
  #   }
  # }
  #
  def parse_and_update(file_name)
    data_hash = Hash.from_xml(@remote_archive.get file_name)

    data_hash.each do |key, value|
      model = FILE_NAME_AND_MODEL[key] || key.underscore.classify.constantize
      [value["Item"]].flatten.each do |attributes|
        attributes.underscore_keys!.symbolize_keys!
        attributes = modify_attributes(key, attributes)
        model.find_and_update_attributes attributes
      end
    end
    self
  end

  def type
    @type ||= case Time.now.strftime('%H%M').to_i
    when 0..1230
      "01"
    when 1230..2230
      "02"
    else
      "04"
    end
  end

private
  def modify_attributes(file_name, attributes)
    attributes = attributes.extract!(*FIELDS_FOR_EXTRACTION[file_name]) if FIELDS_FOR_EXTRACTION[file_name] #extract the required fields
    FIELDS_FOR_RENAME[file_name] && FIELDS_FOR_RENAME[file_name].each do |key, value|
      attributes[value] = attributes.delete(key)         # rename the required fields
    end
    attributes
  end

end
