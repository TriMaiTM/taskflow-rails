class Task < ApplicationRecord
  belongs_to :project

  has_many :comments, dependent: :destroy
  has_many_attached :files

  enum :status, {
    todo: 0,
    in_progress: 1,
    done: 2
  }, default: :todo

  validates :title, presence: true, length: { maximum: 150 }
  scope :recent_first, -> { order(created_at: :desc) }

  def overdue?
    due_on.present? && due_on < Date.current && !done?
  end
end

