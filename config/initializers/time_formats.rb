Time::DATE_FORMATS[:month_and_year] = "%B %Y"
Time::DATE_FORMATS[:pretty] = lambda { |time| (time - 12.hours).in_time_zone("Central Time (US & Canada)").strftime("%a, %b %e at %l:%M%p")}
