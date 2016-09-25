require "spec_helper"

class SomeOperation < FunctionalOperations::Operation
  attr_reader :called

  def arguments
    required :foo, String
    optional :bar, String
  end

  def perform
    @called ||= []
    @called << "perform"
  end
end

RSpec.describe FunctionalOperations::Operation do
  context "when running with params" do
    let(:params) {{
      foo: "value",
    }}

    let(:operation) { SomeOperation.new }

    before :each do
      operation.call(params)
    end

    it "calls perform on self" do
      expect(operation.called).to eq(["perform"])
    end

    it "makes params available to subclass" do
      expect(operation.send(:params)).to eq(params)
    end
  end

  describe "optional params" do
    context "when missing param" do
      let(:operation) { SomeOperation.new }
      let(:params) do
        {
          foo: "valid foo",
        }
      end

      it "does not raise any exception" do
        expect { operation.call(params) }.to_not raise_error
      end
    end

    context "when present" do
      let(:operation) { SomeOperation.new }

      context "with an incorrect type" do
        let(:params) do
          {
            foo: "value",
            bar: 1,
          }
        end

        it "raises an exception" do
          expect { operation.call(params) }.to raise_error("Param bar has wrong type: Fixnum instead of String")
        end
      end

      context "with the correct type" do
        let(:params) do
          {
            foo: "value",
            bar: "bar value",
          }
        end

        it "sets an instance variable with the param for the perform method" do
          expect(operation).to receive(:perform) do
            expect(operation.instance_variable_get("@bar")).to eq("bar value")
          end

          operation.call(params)
        end
      end
    end
  end

  describe "required params" do
    context "when missing param" do
      let(:operation) { SomeOperation.new }
      let(:params) do
        {
          other: "value",
        }
      end

      it "raises an exception" do
        expect { operation.call(params) }.to raise_error("Missing required param: foo")
      end
    end

    context "when present" do
      let(:operation) { SomeOperation.new }

      context "with an incorrect type" do
        let(:params) do
          {
            foo: 1,
          }
        end

        it "raises an exception" do
          expect { operation.call(params) }.to raise_error("Param foo has wrong type: Fixnum instead of String")
        end
      end

      context "with the correct type" do
        let(:params) do
          {
            foo: "value",
          }
        end

        it "sets an instance variable with the param for the perform method" do
          expect(operation).to receive(:perform) do
            expect(operation.instance_variable_get("@foo")).to eq("value")
          end

          operation.call(params)
        end
      end
    end
  end

  describe "perform interface" do
    let(:params) {{
      foo: "value",
    }}

    let(:operation) { double(SomeOperation) }

    it "calls perform on self" do
      allow(SomeOperation).to receive(:new).and_return(operation)
      allow(operation).to receive(:call)

      SomeOperation.perform(params)

      expect(operation).to have_received(:call).with(params)
    end
  end
end
