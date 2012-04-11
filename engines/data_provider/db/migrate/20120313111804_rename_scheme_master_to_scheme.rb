class RenameSchemeMasterToScheme < Mongoid::Migration
  def self.up
    mongo_db = Mongoid.database
    mongo_db.collection("scheme_masters").rename("schemes")
  end

  def self.down
    mongo_db = Mongoid.database
    mongo_db.collection("schemes").rename("scheme_masters")
  end
end
