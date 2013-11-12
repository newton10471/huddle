class StatusReport < ActiveRecord::Base
 	attr_accessible :status_date, :today, :yesterday, :project_id, :user_id
 	belongs_to :project
  belongs_to :user

	before_save :set_status_date

	def set_status_date
		self.status_date = Date.today if status_date.nil?
	end
end
