class ApplicationController < ActionController::Base
  before_action :github
  
  def admin
  end


  def github
    git_api = GitHubService.new
    @repo_name = git_api.get_repo_name
    @contributors = git_api.get_contributors
    @pulls = git_api.get_pull_requests
  end

  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end

end
