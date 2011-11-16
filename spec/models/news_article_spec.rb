require 'spec_helper'

describe NewsArticle, :redis do
  it "saves a record" do
    NewsArticle.new.save.should be_true
  end
 end
