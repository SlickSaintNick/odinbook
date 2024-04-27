module ApplicationHelper
  def format_status(status)
    status.split('_')[0].capitalize
  end

  def format_time(time)
    now = Time.current
    if time < 6.months.ago
      time.strftime('%-d %B %Y')
    elsif time < 2.months.ago
      time.strftime('%-d %B at %I:%M')
    elsif time < 1.week.ago
      "#{((now - time) / (60 * 60 * 24 * 7)).round}w"
    elsif time < 1.day.ago
      "#{((now - time) / (60 * 60 * 24)).round}d"
    elsif time < 1.hour.ago
      "#{((now - time) / (60 * 60)).round}h"
    elsif time < now
      "#{((now - time) / 60).round}m"
    end
  end

  def mutual_followers(user1, user2)
    return if user1 == user2

    mutual_count = (user1.followed_users.where(follows: { status: 'accepted_follow' }) &
    user2.followed_users.where(follows: { status: 'accepted_follow' })).count

    return if mutual_count.zero?

    pluralize(mutual_count, 'mutual follower')
  end

  def post_image(post:, image_width:, image_height: nil)
    image = post.post_image
    return if image.blank?

    image_tag(image.variant(resize_to_limit: [image_width, image_height]), alt: nil)
  end

  def profile_image(user:, image_width: nil, image_height: nil)
    image = user.profile.profile_image
    if image.blank?
      image_tag('profile_image_default.png', width: image_width, height: image_height, alt: user.profile.name)
    else
      image_tag(image.variant(resize_to_limit: [image_width, image_height]), alt: user.profile.name)
    end
  end
end
