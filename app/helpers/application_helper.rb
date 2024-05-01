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
      "#{((now - time) / (60 * 60 * 24 * 7)).round} w"
    elsif time < 1.day.ago
      "#{((now - time) / (60 * 60 * 24)).round} d"
    elsif time < 1.hour.ago
      "#{((now - time) / (60 * 60)).round} h"
    elsif time < now
      "#{((now - time) / 60).round} m"
    end
  end

  def mutual_followers(user1, user2)
    return if user1 == user2

    mutual_count = (user1.followed_users.where(follows: { status: 'accepted_follow' }) &
    user2.followed_users.where(follows: { status: 'accepted_follow' })).count

    return if mutual_count.zero?

    pluralize(mutual_count, 'mutual follower')
  end

  def post_image(post:, image_width: nil, image_height: nil, class_list: nil)
    image = post.post_image
    return if image.blank?

    image_tag(image.variant(resize_to_limit: [image_width, image_height]), alt: nil, class: class_list)
  end

  def profile_image(user:, class_list: nil)
    image = user.profile.profile_image.presence || 'profile_image_default.png'
    image_tag(image.variant(resize_to_fill: [200, 200, { crop: :low }]), alt: user.profile.name,
                                                                         class: class_list)
  end
end
