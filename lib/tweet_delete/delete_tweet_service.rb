# A service class that coordinates the deletion of tweets.
class DeleteTweetService
  def initialize(
    tweet_deleter: TweetDeleter.new,
    delete_recorder: DeletionRecorder.new
  )
    @tweet_deleter = tweet_deleter
    @delete_recorder = delete_recorder
  end

  # Asks for the IDs of tweets to delete and then their deletion.
  # After deletion, asks for those tweets to be recorded as such.
  def call
    deletes = delete_recorder.to_delete.map { |id| tweet_deleter.call(id) }
    ids = deletes.compact.flatten.map(&:id)
    delete_recorder.record_deletes(ids)
  end

  private

  attr_reader :tweet_deleter, :delete_recorder
end
