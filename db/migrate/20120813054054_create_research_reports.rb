class CreateResearchReports < ActiveRecord::Migration
  def change
    create_table :research_reports do |t|
      t.date :date
      t.string :source
      t.string :name
      t.string :company_name
      t.string :sector
      t.string :nse_code
      t.string :bse_code
      t.string :link_url
      t.string :recommendation
      t.decimal :current_market_price
      t.decimal :target_price

      t.timestamps
    end
  end
end
