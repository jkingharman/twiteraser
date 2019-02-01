require_relative '../../spec_helper.rb'

describe TweetDelete::TweetDeleter do
  let(:tweet_id) { 1 }
  let(:client) { double('Client', destroy_status: nil) }

  before do
    ENV["TEST"] = "true"
    allow(Twitter::REST::Client).to receive(:new).and_return(client)
  end

  describe '#call' do
    it "invokes 'destroy_status' on the twitter client object'" do
      ENV["TEST"] = "true"
      expect(client).to receive(:destroy_status).with(tweet_id)
      subject.call(tweet_id)
    end
  end
end
