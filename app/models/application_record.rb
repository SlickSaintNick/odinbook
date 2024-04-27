class ApplicationRecord < ActiveRecord::Base
  primary_abstract_class

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
end
