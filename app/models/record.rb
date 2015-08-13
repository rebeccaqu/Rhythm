class Record < ActiveRecord::Base
	extend SimpleCalendar
	has_calendar
end
