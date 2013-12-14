module VisaApplicationTracker
  class VisaApplication

    def initialize(reference_number, date_of_birth)
      @reference_number = reference_number
      @date_of_birth = date_of_birth
    end

    def status
      @status ||= fetch_status
    end

    def intern_status
      raise 'Not implemented'
    end

    def self.reference_number_valid?(reference_number)
      true
    end

  end
end