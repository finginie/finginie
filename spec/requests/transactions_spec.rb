require 'spec_helper'

describe "Transactions" do
  describe "GET /portfolios/1/net_positions/1/transactions/new" do
    let (:portfolio) { create :portfolio }
    let (:net_position) { create :net_position, :portfolio => portfolio}
    pending "works! (now write some real specs)"
  end
end
