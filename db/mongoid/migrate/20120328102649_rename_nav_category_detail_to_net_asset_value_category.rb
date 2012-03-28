class RenameNavCategoryDetailToNetAssetValueCategory < Mongoid::Migration
  def self.up
    mongo_db = Mongoid.database
    mongo_db.collection("nav_category_details").rename("net_asset_value_categories")
  end

  def self.down
    mongo_db = Mongoid.database
    mongo_db.collection("net_asset_value_categories").rename("nav_category_details")
  end
end
