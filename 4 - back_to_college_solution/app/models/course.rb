class Course < ActiveRecord::Base
  has_many :students, through: :enrollments
  has_many :enrollments

  validates :name,
    presence: true
end
