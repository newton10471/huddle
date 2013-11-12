class StatusReport < ActiveRecord::Base
 	attr_accessible :status_date, :today, :yesterday, :project_id, :user_id
 	belongs_to :project
  belongs_to :user

	before_save :set_status_date
	validate :validate_has_at_least_one_status

	def set_status_date
		self.status_date = Date.today if status_date.nil?
	end

	def validate_has_at_least_one_status
		if today.blank? && yesterday.blank?
			errors[:base] << "Must have at least one status set"
		end
	end
end
