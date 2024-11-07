def humanized_time_ago(time_ago_in_minutes)
 #if the time_ago_in_minutes is greater than 60
  if time_ago_in_minutes >= 60
    #return this string
    return "#{time_ago_in_minutes/ 60} hours ago"
  else
    #return this string
    return "#{time_ago_in_minutes} minutes ago"
  end
  
end

get '/' do
  finstagram_post_shark = { 
    username: "sharky_j",
    avatar_url: "https://learningimages.lighthouselabs.ca/flickr-assets/52358606250_01c667c5da_w.jpg",
    photo_url: "https://learningimages.lighthouselabs.ca/flickr-assets/52358421508_786aa10e2c_c.jpg",
    time_ago_in_minutes: 15,
    like_count: 1,
    comment_count: 1,
    comments: [{
      username:"sharky_j",
      text:"Out for the long weekend... too embarrassed to show y'all the beach bod!"
    } 
    ]
  }
  
  finstagram_post_whale = {
    username: "kirk_whalum",
    avatar_url: "https://learningimages.lighthouselabs.ca/flickr-assets/52358421348_f34c7996b1.jpg",
    photo_url: "https://learningimages.lighthouselabs.ca/flickr-assets/52357237337_1cc718f6a7_4k.jpg",
    humanized_time_ago: humanized_time_ago(65),
    like_count: 0,
    comment_count: 1,
    comments: [{
      username: "kirk_whalum",
      text: "#weekendvibes"
    }]
  }

  finstagram_post_marlin = {
    username: "marlin_peppa",
    avatar_url: "https://learningimages.lighthouselabs.ca/flickr-assets/52358415933_0a0e6bc35f_3k.jpg",
    photo_url: "https://learningimages.lighthouselabs.ca/flickr-assets/52358494794_f88b160d15_4k.jpg",
    humanized_time_ago: humanized_time_ago(190),
    like_count: 0,
    comment_count: 1,
    comments: [{
      username: "marlin_peppa",
      text: "lunchtime! ;)"
    }]
  }
[finstagram_post_shark, finstagram_post_whale, finstagram_post_marlin]. to_s
end
