require "rails_helper"
require "support/mock_directory"

RSpec.describe Scan::CheckAllJob do
  let!(:thing) { create(:model, path: "model_one") } # rubocop:disable RSpec/LetSetup

  before do
    ActiveJob::Base.queue_adapter = :test
  end

  it "queues up integrity and analysis jobs for all models and files" do
    expect { described_class.perform_now }.to(
      have_enqueued_job(Scan::CheckModelJob).once
    )
  end
end
