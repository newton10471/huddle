class StatusReport < ActiveRecord::Base
	attr_accessible :project_id, :user_id
  belongs_to :project
  belongs_to :user
  attr_accessible :status_date, :today, :yesterday
end
