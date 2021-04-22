class ApplicationController < ActionController::Base
  def admin
  end

  git_api = GitHubService.new
  @repo_name = git_api.get_repo_name
  @contributors = git_api.get_contributors
  


  private

  def error_message(errors)
    errors.full_messages.join(', ')
  end

end
