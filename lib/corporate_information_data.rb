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
    'MFDividendDetails.xml',
    'MFNAVDetails.xml',
    'MFObjectives.xml',
    'MFRollingReturn.xml',
    'MFSchemeWisePortfolio.xml',
    'NAVCategoryDetails.xml',
    'NAVCP.xml',
    'NavMaster.xml',
    'NAVMonthlyDetails.xml',
    'NAVQuarterlyDetails.xml',
    'NAVWeeklyDetails.xml',
    'News.xml',
    'NinemonthsResults.xml',
    'NotesToAccount.xml',
    'NSEPrice.xml',
    'Products.xml',
    'QuarterlyResults.xml',
    'Ratios.xml',
    'Rawmaterial.xml',
    'SchemeMaster.xml',
    'ShareHolding.xml',
    'Splits.xml',
    'Subsidiaries.xml',
    'CurrDetails.xml'
  ]

  FILE_NAME_AND_MODEL = {
    "CurrDetails" => Company,
    "CompanyMaster" => Company
  }

  FIELDS_FOR_EXTRACTION = {
    "CurrDetails" => [ :company_code, :pe_ratio, :fifty_twoweek_high, :fifty_twoweek_low, :eps ]
  }

  FIELDS_FOR_RENAME = {
    "CurrDetails" => {
      :pe_ratio           => :pe,
      :fifty_twoweek_high => :fifty_two_week_high_price,
      :fifty_twoweek_low  => :fifty_two_week_low_price }
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
  def modify_attributes(key, attributes)
    attributes = attributes.extract!(*FIELDS_FOR_EXTRACTION[key]) if FIELDS_FOR_EXTRACTION[key] #extract the required fields
    FIELDS_FOR_RENAME[key] && FIELDS_FOR_RENAME[key].each do |key, value|
      attributes[value] = attributes.delete(key)         # rename the required fields
    end
    attributes
  end

end
