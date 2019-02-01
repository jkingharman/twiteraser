require_relative '../../spec_helper.rb'

describe TweetDelete::DeletionRecorder do
  let(:tweets_path) { './spec/support/tweets.json' }
  let(:tweets_archive) { {"1": "mock", "2": "dummy"} }

  before do
    ENV["TEST"] = "true"
    File.write(tweets_path, tweets_archive.to_json)
    stub_const('TweetDelete::DeletionRecorder::BATCH_SIZE', 3)
    stub_const('TweetDelete::DeletionRecorder::PATH_TO_TWEETS', tweets_path)
  end

  describe '#to_delete' do
    context 'when an archived tweet isn\'t yet deleted' do
      it 'returns those tweet\'s IDs' do
        expect(subject.to_delete).to eq [1, 2]
      end
    end

    context 'when an archived tweet has been deleted' do
      before do
        File.write(tweets_path, {"1": "mock", "deleted_2": "dummy" }.to_json)
      end
      it 'does not return that tweet\'s ID' do
        expect(subject.to_delete).to eq [1]
      end
    end
  end

  describe "record_deletes" do
    it 'marks deleted tweets as such in the archive' do
      subject.to_delete
      subject.record_deletes(["1"])

      archived_tweets = JSON.parse(File.read(subject.class::PATH_TO_TWEETS))
      expect(archived_tweets.include?("deleted_1")).to be true
    end
  end
end
