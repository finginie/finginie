require 'spec_helper'

describe ProfileDecorator do
  before { ApplicationController.new.set_current_view_context }
  subject { ProfileDecorator.new(profile) }
  let(:profile) { create :user }

end
