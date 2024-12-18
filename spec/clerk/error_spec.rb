require "spec_helper"

RSpec.describe Clerk::Error do
  describe "#initialize" do
    let(:error_msg) { {"errors" => ["Invalid token"]} }
    let(:status) { 401 }

    subject(:error) { described_class.new(error_msg, status: status) }

    it "sets the status" do
      expect(error.status).to eq(status)
    end

    it "includes status in the error message" do
      expect(error.message).to include("status=>401")
    end
  end
end

RSpec.describe Clerk::AuthenticationError do
  it "inherits from Clerk::Error" do
    expect(described_class.superclass).to eq(Clerk::Error)
  end
end

RSpec.describe Clerk::ConfigurationError do
  it "inherits from StandardError" do
    expect(described_class.superclass).to eq(StandardError)
  end
end

RSpec.describe Clerk::FatalError do
  it "inherits from Clerk::Error" do
    expect(described_class.superclass).to eq(Clerk::Error)
  end
end
