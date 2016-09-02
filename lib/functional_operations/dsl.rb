module FunctionalOperations::DSL
  def run(operation_class, params = {})
    operation = operation_class.new

    operation.call(params)
  end
end
