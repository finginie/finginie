require 'pinch'

class CorporateInformationData

  DATA_SOURCES = {
    :url => 'http://download.dionglobal.in//portals//'
  }

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
    'Subsidiaries.xml'
  ]

  def self.update_data
    self.fetch_data.each do |key,values|
      model = key.constantize
      values.each do |attributes|
        conditions = {}
        model.primary_key.each do |key|
          conditions[key] = attributes[key]
          attributes.delete(key)
        end
        instance = model.find_or_initialize_by(conditions)
        instance.update_attributes(attributes)
      end
    end
  end

  def self.fetch_data
    data = {}
    type = get_type
    files = Pinch.file_list("#{DATA_SOURCES[:url]}XI#{Date.today.strftime('%d%m%Y')}#{type}.zip")
    FILE_NAMES.each do |file|
      if files.include?(file)
        rows_data = []
        xml_data = Pinch.get("#{DATA_SOURCES[:url]}XI#{Date.today.strftime('%d%m%Y')}#{type}.zip", file)
        if xml_data
          data_hash = Hash.from_xml(xml_data)
          if data_hash[File.basename(file,'.xml')]["Item"].class == Array
            data_hash[File.basename(file,'.xml')]["Item"].each do |item|
              rows_data << item.inject({}){|memo,(k,v)| memo[k.underscore.to_sym] = v; memo}
            end
          else
            rows_data << data_hash[File.basename(file,'.xml')]["Item"].inject({}){|memo,(k,v)| memo[k.underscore.to_sym] = v; memo}
          end
          data[File.basename(file,'.xml').underscore.classify] = rows_data
        end
      end
    end
    data
  end

  def self.get_type
    current_time = Time.now.strftime('%H%M').to_i
    case
      when current_time < 1230
        "01"
      when current_time > 1230 && current_time < 2230
        "02"
      else
        "04"
    end
  end
end
