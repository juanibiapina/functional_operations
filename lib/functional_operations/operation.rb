require "functional_operations/dsl"

class FunctionalOperations::Operation
  include FunctionalOperations::DSL

  def call(params)
    @params = params

    validate_params

    self.perform
  end

  protected

  def required(name, type = nil)
    raise "Missing required param: #{name}" if params[name].nil?

    if !type.nil?
      raise "Param #{name} has wrong type: #{params[name].class} instead of #{type}" unless params[name].is_a?(type)
    end
  end

  def optional(name, type = nil)
    if !params[name].nil? && !type.nil?
      raise "Param #{name} has wrong type: #{params[name].class} instead of #{type}" unless params[name].is_a?(type)
    end
  end

  def validate_params
    validate if respond_to?(:validate)
  end

  def params
    @params
  end
end
