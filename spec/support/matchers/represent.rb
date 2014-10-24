RSpec::Matchers.define :represent do |expected|
  match do |actual|
    exposes? && aliases? && has_presenter? && has_runtime_exposure?
  end

  chain :as do |as_alias|
    @as_alias = as_alias
  end

  chain :using do |entity|
    @entity = entity
  end

  chain :runtime_exposure do |object, exposure|
    @transformation_object, @transformation_exposure = object, exposure
  end


  private

    def exposes?
      actual.exposures.key?(expected)
    end

    def aliases?
      actual.exposures[expected][:as] == @as_alias
    end

    def has_presenter?
      actual.exposures[expected][:using] == @entity
    end

    def has_runtime_exposure?
      if @transformation_object && @transformation_exposure
        actual.exposures[expected][:proc].call(@transformation_object) == @transformation_exposure
      else
        true
      end
    end
end