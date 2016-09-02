module FunctionalOperations::GrapeDSL
  def respond(operation_class, params = self.params)
    operation = operation_class.new

    operation.call(declared(params))
  end
end
