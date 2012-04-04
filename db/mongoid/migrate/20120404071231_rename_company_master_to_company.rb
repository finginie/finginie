class RenameCompanyMasterToCompany < Mongoid::Migration
  def self.up
    mongo_db = Mongoid.database
    mongo_db.collection("company_masters").rename("companies")
  end

  def self.down
    mongo_db = Mongoid.database
    mongo_db.collection("companies").rename("company_masters")
  end
end
