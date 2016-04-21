require 'octokit'

module Services
  class GithubRepositoryReader
    def initialize(repository, token=nil)
      Octokit.auto_paginate = true

      @repository = repository
      @client = Octokit::Client.new(access_token: token)
    end

    def process
      {
        Issue: get_issues,
        IssueComment: get_issues_comments,
        PullRequest: get_pull_requests,
        PullRequestComment: get_pull_requests_comments,
        Commit: get_commits_on_master
      }
    end

    def get_issues
      @client.issues(@repository, state: "all").map do |entry|
        next nil if entry.pull_request
        { author: entry.user.login, title: entry.title, repository: @repository }
      end.compact
    end

    def get_issues_comments
      @client.issues_comments(@repository).map do |entry|
        { author: entry.user.login, body: entry.body, repository: @repository }
      end
    end

    def get_pull_requests
      @client.pull_requests(@repository, state: "all").map do |entry|
        { author: entry.user.login, title: entry.title, merged_at: entry.merged_at, repository: @repository }
      end
    end

    def get_pull_requests_comments
      @client.pull_requests_comments(@repository).map do |entry|
        { author: entry.user.login, body: entry.body, repository: @repository }
      end
    end

    def get_commits_on_master
      @client.commits_since(@repository, '1970-10-01').map do |entry|
        { author: entry.author.login, message: entry.commit.message, repository: @repository }
      end
    end

    def self.call(repository, token=nil)
      new(repository, token).process
    end
  end
end