class AddPublicAttributeToPortfolio < ActiveRecord::Migration
  def change
    add_column :portfolios, :is_public, :boolean, :default => false
  end
end
