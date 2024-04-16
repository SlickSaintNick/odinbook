User.destroy_all

users = [
  { id: 1,
    email: ENV.fetch('TEST_USER_EMAIL_1', nil),
    password: ENV.fetch('TEST_USER_PASSWORD_1', nil),
    password_confirmation: ENV.fetch('TEST_USER_PASSWORD_1', nil) },
  { id: 2,
    email: ENV.fetch('TEST_USER_EMAIL_2', nil),
    password: ENV.fetch('TEST_USER_PASSWORD_2', nil),
    password_confirmation: ENV.fetch('TEST_USER_PASSWORD_2', nil) },
  { id: 3,
    email: ENV.fetch('TEST_USER_EMAIL_3', nil),
    password: ENV.fetch('TEST_USER_PASSWORD_3', nil),
    password_confirmation: ENV.fetch('TEST_USER_PASSWORD_3', nil) },
  { id: 4,
    email: ENV.fetch('TEST_USER_EMAIL_4', nil),
    password: ENV.fetch('TEST_USER_PASSWORD_4', nil),
    password_confirmation: ENV.fetch('TEST_USER_PASSWORD_4', nil) },
  { id: 5,
    email: ENV.fetch('TEST_USER_EMAIL_5', nil),
    password: ENV.fetch('TEST_USER_PASSWORD_5', nil),
    password_confirmation: ENV.fetch('TEST_USER_PASSWORD_5', nil) }
]

users.each do |fields|
  User.create!(fields)
end

Rails.logger.info "Created #{User.count} users"

# User has dependent_destroy for all linked tables,
# however use destroy_all for each table proactively.
# Chat GPT generated content for bios, posts, comments.

Profile.destroy_all

profiles = [
  { id: 1,
    name: 'Test Name',
    bio: 'Test Bio',
    user_id: 1 },
  { id: 2,
    name: 'Homer Simpson',
    bio: "Doughnut enthusiast, nuclear safety inspector, and proud father of three. D'oh! 🍩👨‍👩‍👧‍👦",
    user_id: 2 },
  { id: 3,
    name: 'Marge Simpson',
    bio: 'Homemaker, loving wife, and devoted mom. Always keeping Springfield together with love and hairspray! 💇‍♀️💖',
    user_id: 3 },
  { id: 4,
    name: 'Bart Simpson',
    bio: 'Skateboarding troublemaker, prankster extraordinaire, and expert in staying ten steps ahead of detention. Eat my shorts! 🛹😎',
    user_id: 4 },
  { id: 5,
    name: 'Monty Burns',
    bio: 'Billionaire tycoon, owner of the Springfield Nuclear Power Plant, and connoisseur of evil schemes. Excellent... 😈💰',
    user_id: 5 }
]

profiles.each do |fields|
  User.find(fields[:user_id]).profile = Profile.new(fields)
end

Rails.logger.info "Created #{Profile.count} profiles"

# Test user follows everyone. 1-2 1-3 1-4 1-5
# Homer follows Marge and has requested to follow Monty. 2-3 2-5 pending
# Marge follows Homer and Bart. 3-2 3-4
# Bart follows Homer and Marge and Monty. 4-2 4-3 4-4
# Monty follows no-one.

Follow.destroy_all

follows = [
  { id: 1, following_user_id: 1, followed_user_id: 2, status: 'accepted_follow' },
  { id: 2, following_user_id: 1, followed_user_id: 3, status: 'accepted_follow' },
  { id: 3, following_user_id: 1, followed_user_id: 4, status: 'accepted_follow' },
  { id: 4, following_user_id: 1, followed_user_id: 5, status: 'accepted_follow' },
  { id: 5, following_user_id: 2, followed_user_id: 3, status: 'accepted_follow' },
  { id: 6, following_user_id: 2, followed_user_id: 5, status: 'pending_follow' },
  { id: 7, following_user_id: 3, followed_user_id: 2, status: 'accepted_follow' },
  { id: 8, following_user_id: 3, followed_user_id: 4, status: 'accepted_follow' },
  { id: 9, following_user_id: 4, followed_user_id: 2, status: 'accepted_follow' },
  { id: 10, following_user_id: 4, followed_user_id: 3, status: 'accepted_follow' },
  { id: 11, following_user_id: 4, followed_user_id: 4, status: 'accepted_follow' }
]

follows.each do |fields|
  User.find(fields[:following_user_id]).follows.create!(fields)
end

Rails.logger.info "Created #{Follow.count} follows"

Post.destroy_all

posts = [
  { id: 1,
    body: 'Test post',
    user_id: 1 },
  { id: 2,
    body: 'Just won the donut eating contest at Lard Lad Donuts. Best. Day. Ever. 🍩🏆',
    user_id: 2 },
  { id: 3,
    body: 'Attempting to fix the TV remote... how hard can it be? Need more duct tape. 📺🔧',
    user_id: 2 },
  { id: 4,
    body: "Family BBQ this weekend! If anyone needs me, I'll be by the grill with a Duff in hand. 🍔🍺",
    user_id: 2 },
  { id: 5,
    body: 'Spent the morning reorganizing the pantry. Who knew we had five kinds of cinnamon? 🏡✨',
    user_id: 3 },
  { id: 6,
    body: 'Baking sale at Springfield Elementary tomorrow! Hope my marshmallow squares are a hit again this year! 🍰🎉',
    user_id: 3 },
  { id: 7,
    body: 'Finally started that knitting project. First up: mittens for Maggie! 🧶👶',
    user_id: 3 },
  { id: 8,
    body: "Who knew you could make a skateboard ramp from old wood planks? Principal Skinner didn't. 🛹😜",
    user_id: 4 },
  { id: 9,
    body: "Prank called Moe's Tavern today. Never gets old! 📞😂",
    user_id: 4 },
  { id: 10,
    body: 'Got an A in math!? Just kidding, but imagine if I did... 😂',
    user_id: 4 },
  { id: 11, body: "Inspected the new security upgrades at the plant. If a fly tries to sneak in, it'll be a very poor fly indeed. 🔒🏭",
    user_id: 5 },
  { id: 12,
    body: 'Thinking of buying a new painting. Perhaps something with dollar signs... 💵🖼',
    user_id: 5 },
  { id: 13,
    body: "Just won Springfield's 'Most Feared Citizen' award again. I'm on a roll! 😈🏆",
    user_id: 5 }
]

posts.each do |fields|
  User.find(fields[:user_id]).posts.create!(fields)
end

Comment.destroy_all

comments = [
  { id: 1,
    body: 'Test comment',
    post_id: 1,
    user_id: 1 },
  { id: 2,
    body: "Can't wait for your famous BBQ ribs, Homer! I'll make sure there's plenty of potato salad ready. 🍖🥔",
    post_id: 4,
    user_id: 3 },
  { id: 3,
    body: "Thanks, Marge! You know how to make a man feel appreciated. Can't wait to see you and the kids enjoying the grub! 🤗👨‍👩‍👧‍👦",
    post_id: 4,
    comment_reply_id: 2,
    user_id: 2 },
  { id: 4,
    body: "Of course, Homer! Family time around the grill is always the best. And don't forget to wear your apron this time, last BBQ was quite the mess! 😅👩‍🍳",
    post_id: 4,
    comment_reply_id: 3,
    user_id: 3 },
  { id: 5,
    body: 'Cowabunga Dude! 🛹',
    post_id: 4,
    user_id: 4 },
  { id: 6,
    body: 'Oh Bart, you always keep us on our toes! But hey, keep dreaming big, who knows what surprises the next report card might hold? 😄📚',
    post_id: 10,
    user_id: 3 },
  { id: 7,
    body: 'Remember, Bart, dreams do come true... but only if you do your homework! 😜✏️',
    post_id: 10,
    comment_reply_id: 6,
    user_id: 3 },
  { id: 8,
    body: 'Haha, thanks for the encouragement, Mom! Guess I better start studying... or at least start daydreaming about studying. 😂📖',
    post_id: 11,
    user_id: 4 },
  { id: 9,
    body: "Another accolade for yours truly. It's good to be feared, but it's even better to be recognized for it. 😈🏆",
    post_id: 13,
    user_id: 5 },
  { id: 10,
    body: 'Ah, the sweet taste of victory! Let the peasants tremble in awe at my magnificence. #FearTheBurns 😈👑',
    post_id: 13,
    user_id: 5 },
  { id: 11,
    body: 'Test comment reply',
    post_id: 1,
    comment_reply_id: 1,
    user_id: 1 }
]

comments.each do |fields|
  Post.find(fields[:post_id]).comments.create!(fields)
end

Like.destroy_all

liked_posts = [
  { id: 1,
    user_id: 1,
    post_id: 1 },
  { id: 2,
    user_id: 2,
    post_id: 5 },
  { id: 3,
    user_id: 2,
    post_id: 6 },
  { id: 4,
    user_id: 3,
    post_id: 4 },
  { id: 5,
    user_id: 3,
    post_id: 10 }
]

liked_posts.each do |fields|
  Post.find(fields[:post_id]).likes.create!(id: fields[:id], user_id: fields[:user_id])
end

liked_comments = [
  { id: 6,
    user_id: 1,
    comment_id: 1 },
  { id: 7,
    user_id: 2,
    comment_id: 4 },
  { id: 8,
    user_id: 3,
    comment_id: 4 },
  { id: 9,
    user_id: 4,
    comment_id: 4 },
  { id: 10,
    user_id: 5,
    comment_id: 10 }
]

liked_comments.each do |fields|
  Comment.find(fields[:comment_id]).likes.create!(id: fields[:id], user_id: fields[:user_id])
end
