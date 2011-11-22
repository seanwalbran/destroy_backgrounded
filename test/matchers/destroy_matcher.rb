module DestroyBackgrounded
  class DestroyMatcher
    def softly
      @softly = true
      self
    end
    def description
      "destroy the subject"
    end
    def matches?(subject)
      @subject = subject
      errors.empty?
    end
    def failure_message
      "Expected #{@subject.inspect} to be destroyed: #{errors.join("\n")}"
    end
    def errors
      return @errors if @errors
      @errors = []
      @errors << "was found in database" if subject_found?
      @errors << "did not destroy instance" if destroyed? && !@subject.destroyed?
      @errors
    end
    def softly?
      !!@softly
    end
    def destroyed?
      !!@destroyed
    end
    def subject_found?
      !!@subject.class.find(@subject.id)
    rescue ActiveRecord::RecordNotFound
      false
    end

  end
end

class DestroyMatcher
  module MatcherMethods
    def soft_destroy
      DestroyMatcher.new :soft
    end
    def hard_destroy
      DestroyMatcher.new :hard
    end
    def destroy_subject
      DestroyBackgrounded::DestroyMatcher.new
    end
  end
end

