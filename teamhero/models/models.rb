module Models

  module DefaultScopes
    def since(date)
      date ||= '1970-01-01'
      where(:created_at.gte => date)
    end

    def before(date)
      date ||= Date.today.to_s
      where(:created_at.lte => date)
    end
  end

  %w[Message Issue PullRequest Commit PullRequestComment IssueComment].each do |klass|
    const_set(klass, Class.new do
                       include Mongoid::Document
                       include Mongoid::Attributes::Dynamic
                       extend Models::DefaultScopes

                       field :created_at, type: DateTime

                       store_in collection: klass.underscore
                     end)
  end
end
