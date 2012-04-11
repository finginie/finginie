class RenameFundMasterToAssetManagementCompany < Mongoid::Migration
  def self.up
    mongo_db = Mongoid.database
    mongo_db.collection("fund_masters").rename("asset_management_companies")
  end

  def self.down
    mongo_db = Mongoid.database
    mongo_db.collection("asset_management_companies").rename("fund_masters")
  end
end
