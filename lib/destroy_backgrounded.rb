require 'active_support/all'
require 'active_record'
require 'backgrounded'

module DestroyBackgrounded
  module ActiveRecordExtensions
    def destroy_backgrounded?
      false
    end

    def acts_as_destroy_backgrounded(*args)
      extend DestroyBackgrounded::ClassMethods
      include DestroyBackgrounded::AliasMethods
      include DestroyBackgrounded::InstanceMethods
    end
  end

  module ClassMethods
    def destroy_backgrounded?
      true
    end
  end

  module AliasMethods
    def self.included(base)
      base.send(:alias_method, :destroy_immediate, :destroy)
    end
  end

  module InstanceMethods
    backgrounded :destroy_immediate
    
    def destroy
      if self.class.destroy_backgrounded?
        destroy_immediate_backgrounded
      else
        destroy_immediate
      end
    end

  end
end

ActiveRecord::Base.send(:extend, DestroyBackgrounded::ActiveRecordExtensions)
