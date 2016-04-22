module Models
  %w[Message Issue PullRequest Commit PullRequestComment IssueComment].each do |klass|
    const_set(klass, Class.new do
                       include Mongoid::Document
                       include Mongoid::Attributes::Dynamic

                       field :created_at, type: DateTime

                       store_in collection: klass
                     end)
  end
end
