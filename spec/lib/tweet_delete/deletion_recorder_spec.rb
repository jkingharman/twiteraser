require_relative '../../spec_helper.rb'

describe TweetDelete::DeletionRecorder do
  let(:tweets_path) { './spec/support/tweets.js' }
  let(:tweets_archive) { [{"id_str":"743116669128736769"},{"deleted":"true","id_str":"222"}] }

  before do
    File.write(tweets_path, tweets_archive.to_json)
    stub_const('TweetDelete::DeletionRecorder::BATCH_SIZE', 3)
    stub_const('TweetDelete::DeletionRecorder::PATH_TO_TWEETS', tweets_path)
  end

  describe '#to_delete' do
    context 'when an archived tweet isn\'t yet deleted' do
      it 'returns those tweet\'s IDs' do
        expect(subject.to_delete).to eq [743116669128736769]
      end
    end

    context 'when an archived tweet has been deleted' do
      before do
        File.write(tweets_path, tweets_archive.to_json)
      end
      it 'does not return that tweet\'s ID' do
        expect(subject.to_delete).to_not eq [222]
      end
    end
  end
end
