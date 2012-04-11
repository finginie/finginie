class MfObjective
  include Mongoid::Document
end

class AddObjectiveToScheme < Mongoid::Migration
  def self.up
    MfObjective.all.each do |mf_objective|
      @scheme = Scheme.where(securitycode: mf_objective.securitycode).first
      @scheme.update_attributes(objective: mf_objective.objective) if @scheme
    end
  end

  def self.down
    MfObjective.all.each do |mf_objective|
      @scheme = Scheme.where(securitycode: mf_objective.securitycode).first
      @scheme.update_attributes(objective: nil ) if @scheme
    end
  end
end
