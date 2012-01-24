#-------------------------------------------------------------------------------
# This module is meant to be included in the Base class of an STI model
# hierarchy.
#
# Heavily inspired by a couple key blog posts
# http://code.alexreisner.com/articles/single-table-inheritance-in-rails.html
# http://coderrr.wordpress.com/2008/04/22/building-the-right-class-with-sti-in-rails/#comment-1826
#
# Thanks to Alex and coderrr!
#-------------------------------------------------------------------------------
module StiHelper
  extend ActiveSupport::Concern

  module ClassMethods

    def select_options
      descendants.map{ |c| c.to_s }.sort
    end

    def inherited(child)
      child.instance_eval do
        def model_name
          sti_base_class.model_name
        end
      end
      super
    end

    def sti_base_class
      if "#{self.superclass.name}" == "ActiveRecord::Base"
        return self
      end
      return superclass.sti_base_class
    end

    # !! with the first conditional clause type logic will only apply to base class
    # this MAY not be what you'd want, in which case ommit.
    def new(*a, &b)
      if (self == sti_base_class) and (h = a.first).is_a? Hash and (type = h[:type] || h['type']) and (klass = type.classify.constantize) != self
        raise "wtF hax!!" unless klass < self # klass should be a descendant of us
        return klass.new(*a, &b)
      end
      super(*a, &b)
    end
  end

  def sti_base_class
    self.class.sti_base_class
  end

end
