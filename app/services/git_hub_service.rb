require 'faraday'
require 'json'


class GitHubService
  attr_reader :contributor_names
            
              
# SRP: Communicate with Github API
  def initialize
    @contributor_names = contributor_names
    @owner = "brueck1988"
    @repo = "little-esty-shop"
  end
  


  def conn
    Faraday.new(
      url: 'https://api.github.com',
      headers: {
        # 'Authorization' => "token #{@token}",
        'Accept' => 'application/vnd.github.v3+json'
      }
    ) # Set up a "connection" object
  end



  def get_repo_name
    resp = conn.get("/repos/#{@owner}/#{@repo}") 
    JSON.parse(resp.body, symbolize_names: true)
  end

  def get_contributors
    resp = conn.get("/repos/#{@owner}/#{@repo}/contributors")
    contributors = JSON.parse(resp.body, symbolize_names: true)
    contributors.map do |contributor|
      contributor[:login]
    end
  end

  def get_pull_requests
    resp = conn.get("/repos/#{@owner}/#{@repo}/pulls?state=all")
    JSON.parse(resp.body, symbolize_names: true)
  end
end

# service = GitHubService.new
# owner = "brueck1988"
# repo = "little-esty-shop"
# data = service.get_repo_name(owner, repo)
# contributors = service.get_contributors(owner, repo)

# @repo_name = data[:full_name]

# @contributor_names = contributors.map do |contributor|
#   contributor[:login]
# end



