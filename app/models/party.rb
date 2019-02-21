class Party < ApplicationRecord
  belongs_to :quotation
  validates_presence_of :quotation

  belongs_to :guide, class_name: 'User', foreign_key: :user_id, optional: true

  has_many :activities, through: :quotation

  has_many :user_parties, dependent: :delete_all
  has_many :users, through: :user_parties

  invitable named_by: :title

  validates :title, presence: true, length: { maximum: 50 }, uniqueness: true

  scope :for_customer_user, -> user {
    joins(:user_parties).where(user_parties: { customer: user })
  }

  scope :for_guide_user, -> user { where(guide: user) }

  def customers
    users.where(role: :customer)
  end

  def as_json(options = {})
    super(
      only: %i[id title datetime guide],
      include: {
        activities: { only: %i[id title] },
        invites:    { only: %i[invitable_id email] }
      }
    )
  end
end
