
# response = Faraday.get ‘https://api.github.com/user/followers’
# token = ‘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’
# service = GitHubService.new
# data = service.get_repo_name
# require 'pry';binding.pry
# followings = service.get_followings.map do |following_hash|
#   following_hash[:login]
# end
# service.get_followers.each do |follower_hash|
#   follower_username = follower_hash[:login]
#   if followings.include? follower_username # Check if I’m already following them
#     # If already following
#       # print out a message
#     puts “Already following: #{follower_username}”
#    else
#     # If not already following
#       # follow them back
#     puts “Not following: #{follower_username}. Now following back.”
#     service.follow(follower_username)
#   end
# end