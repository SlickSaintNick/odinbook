User.destroy_all

test_user = User.create!(email: ENV.fetch('TEST_USER_EMAIL_1', nil), password: ENV.fetch('TEST_USER_EMAIL_1', nil))
homer = User.create!(email: ENV.fetch('TEST_USER_EMAIL_2', nil), password: ENV.fetch('TEST_USER_EMAIL_2', nil))
marge = User.create!(email: ENV.fetch('TEST_USER_EMAIL_3', nil), password: ENV.fetch('TEST_USER_EMAIL_3', nil))
bart = User.create!(email: ENV.fetch('TEST_USER_EMAIL_4', nil), password: ENV.fetch('TEST_USER_EMAIL_4', nil))
monty = User.create!(email: ENV.fetch('TEST_USER_EMAIL_5', nil), password: ENV.fetch('TEST_USER_EMAIL_5', nil))

Rails.logger.info "Created #{User.count} users"

# User has dependent_destroy for all linked tables,
# however use destroy_all for each table proactively.

# Chat GPT generated content for bios, posts, comments.

Profile.destroy_all

test_user.profile = Profile.new(
  name: 'Test Name',
  bio: 'Test Bio'
)
homer.profile = Profile.new(
  name: 'Homer Simpson',
  bio: "Doughnut enthusiast, nuclear safety inspector, and proud father of three. D'oh! 🍩👨‍👩‍👧‍👦"
)
marge.profile = Profile.new(
  name: 'Marge Simpson',
  bio: 'Homemaker, loving wife, and devoted mom. Always keeping Springfield together with love and hairspray! 💇‍♀️💖'
)
bart.profile = Profile.new(
  name: 'Bart Simpson',
  bio: 'Skateboarding troublemaker, prankster extraordinaire, and expert in staying ten steps ahead of detention. Eat my shorts! 🛹😎'
)
monty.profile = Profile.new(
  name: 'Monty Burns',
  bio: 'Billionaire tycoon, owner of the Springfield Nuclear Power Plant, and connoisseur of evil schemes. Excellent... 😈💰'
)

Rails.logger.info "Created #{Profile.count} profiles"

Follow.destroy_all

# Test user follows everyone.
test_user.follows.create!(followed_user_id: homer.id)
test_user.follows.create!(followed_user_id: marge.id)
test_user.follows.create!(followed_user_id: bart.id)
test_user.follows.create!(followed_user_id: monty.id)

# Homer follows Marge and has requested to follow Monty.
homer.follows.create!(followed_user_id: marge.id)
homer.follows.create!(followed_user_id: monty.id, status: 'pending_follow')

# Marge follows Homer and Bart.
marge.follows.create!(followed_user_id: homer.id)
marge.follows.create!(followed_user_id: bart.id)

# Bart follows Homer and Marge and has requested to follow Monty.
bart.follows.create!(followed_user_id: homer.id)
bart.follows.create!(followed_user_id: marge.id)
bart.follows.create!(followed_user_id: monty.id, status: 'pending_follow')

# Monty follows no-one.

Rails.logger.info "Created #{Follow.count} follows"

Post.destroy_all

posts = []
# Test user posts
test_user.posts.create!(
  body: 'Test post',
  created_at: 10.days.ago
)

# Homer posts
homer.posts.create!(
  body: 'Just won the donut eating contest at Lard Lad Donuts. Best. Day. Ever. 🍩🏆',
  created_at: 6.days.ago
)
homer.posts.create!(
  body: 'Attempting to fix the TV remote... how hard can it be? Need more duct tape. 📺🔧',
  created_at: 4.days.ago
)
homer.posts.create!(
  body: "Family BBQ this weekend! If anyone needs me, I'll be by the grill with a Duff in hand. 🍔🍺",
  created_at: 2.days.ago
)

# Marge posts
marge.posts.create!(
  body: 'Spent the morning reorganizing the pantry. Who knew we had five kinds of cinnamon? 🏡✨',
  created_at: 7.days.ago
)
marge.posts.create!(
  body: 'Baking sale at Springfield Elementary tomorrow! Hope my marshmallow squares are a hit again this year! 🍰🎉',
  created_at: 1.day.ago
)
marge.posts.create!(
  body: 'Finally started that knitting project. First up: mittens for Maggie! 🧶👶',
  created_at: 2.days.ago
)

# Bart posts
bart.posts.create!(
  body: "Who knew you could make a skateboard ramp from old wood planks? Principal Skinner didn't. 🛹😜",
  created_at: 0.days.ago
)
bart.posts.create!(
  body: "Prank called Moe's Tavern today. Never gets old! 📞😂",
  created_at: 7.days.ago
)
bart.posts.create!(
  body: 'Got an A in math!? Just kidding, but imagine if I did... 😂',
  created_at: 4.days.ago
)

# Monty posts
monty.posts.create!(
  body: "Inspected the new security upgrades at the plant. If a fly tries to sneak in, it'll be a very poor fly indeed. 🔒🏭",
  created_at: 9.days.ago
)
monty.posts.create!(
  body: 'Thinking of buying a new painting. Perhaps something with dollar signs... 💵🖼',
  created_at: 4.days.ago
)
monty.posts.create!(
  body: "Just won Springfield's 'Most Feared Citizen' award again. I'm on a roll! 😈🏆",
  created_at: 1.day.ago
)

Rails.logger.info "Created #{Post.count} posts"

Comment.destroy_all

# Test user comment and reply
test_user.posts.first.comments.create!(
  user_id: test_user.id,
  body: 'Test comment',
  created_at: 7.days.ago
)
test_user.posts.first.comments.first.comment_replies.create!(
  post_id: test_user.posts.first.id,
  user_id: test_user.id,
  body: 'Test comment reply',
  created_at: 4.days.ago
)

# Comments on Homer's last post.
homer.posts.last.comments.create!(
  user_id: marge.id,
  body: "Can't wait for your famous BBQ ribs, Homer! I'll make sure there's plenty of potato salad ready. 🍖🥔",
  created_at: 1.day.ago
)
homer.posts.last.comments.first.comment_replies.create!(
  post_id: homer.posts.last.id,
  user_id: homer.id,
  body: "Thanks, Marge! You know how to make a man feel appreciated. Can't wait to see you and the kids enjoying the grub! 🤗👨‍👩‍👧‍👦",
  created_at: 12.hours.ago
)
homer.posts.last.comments.first.comment_replies.create!(
  post_id: homer.posts.last.id,
  user_id: marge.id,
  body: "Of course, Homer! Family time around the grill is always the best. And don't forget to wear your apron this time, last BBQ was quite the mess! 😅👩‍🍳",
  created_at: 6.hours.ago
)
homer.posts.last.comments.create!(
  user_id: bart.id,
  body: 'Cowabunga Dude! 🛹',
  created_at: 1.hour.ago
)

# Comments on Bart's last post.
bart.posts.last.comments.create!(
  user_id: marge.id,
  body: 'Oh Bart, you always keep us on our toes! But hey, keep dreaming big, who knows what surprises the next report card might hold? 😄📚',
  created_at: 3.days.ago
)
bart.posts.last.comments.create!(
  user_id: marge.id,
  body: 'Remember, Bart, dreams do come true... but only if you do your homework! 😜✏️',
  created_at: 2.days.ago
)
bart.posts.last.comments.last.comment_replies.create!(
  post_id: bart.posts.last.id,
  user_id: bart.id,
  body: 'Haha, thanks for the encouragement, Mom! Guess I better start studying... or at least start daydreaming about studying. 😂📖',
  created_at: 1.minute.ago
)

# Monty commenting on his own posts.
monty.posts.last.comments.create!(
  user_id: monty.id,
  body: "Another accolade for yours truly. It's good to be feared, but it's even better to be recognized for it. 😈🏆",
  created_at: 1.minute.ago
)
monty.posts.last.comments.create!(
  user_id: monty.id,
  body: 'Ah, the sweet taste of victory! Let the peasants tremble in awe at my magnificence. #FearTheBurns 😈👑',
  created_at: 7.hours.ago
)

Rails.logger.info "Created #{Comment.count} comments"

Like.destroy_all

# Test user likes own post and first comment
test_user.posts.first.likes.create!(user_id: test_user.id)
test_user.comments.first.likes.create!(user_id: test_user.id)

# Homer likes all of Marge's posts and comments
marge.posts.each do |post|
  post.likes.create!(user_id: homer.id)
end

<<<<<<< HEAD
marge.comments.each do |comment|
  comment.likes.create!(user_id: homer.id)
end

# Marge likes all of Homer's and Bart's posts, and all of Bart's comments
homer.posts.each do |post|
  post.likes.create!(user_id: marge.id)
end

bart.posts.each do |post|
  post.likes.create!(user_id: marge.id)
end

bart.comments.each do |comment|
  comment.likes.create!(user_id: marge.id)
end

# Monty likes his final post
monty.posts.last.likes.create!(user_id: monty.id)

Rails.logger.info "Created #{Like.count} likes"
