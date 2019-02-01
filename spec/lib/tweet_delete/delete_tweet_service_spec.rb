require_relative '../../spec_helper.rb'

describe TweetDelete::DeleteTweetService do
  let(:tweet_id) { [1] }
  let(:tweet) { [double('Tweet1', id: 1)] }
  let(:deleter) { double('Deleter', call: [tweet]) }
  let(:recorder) { double('Rec', to_delete: tweet_id, record_deletes: nil) }

  before do
    allow(subject).to receive(:tweet_deleter).and_return(deleter)
    allow(subject).to receive(:delete_recorder).and_return(recorder)
  end

  describe '#call' do
    it 'invokes the tweet deleter with the tweet IDs to delete' do
      expect(deleter).to receive(:call).with(tweet_id.first)
      subject.call
    end

    it "#invokes the deletion recorder with the deleted tweets' IDs" do
      expect(recorder).to receive(:record_deletes).with(tweet_id)
      subject.call
    end
  end
end
