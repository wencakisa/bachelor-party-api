class Party < ApplicationRecord
  belongs_to :quotation, -> { where(status: :approved) }
  validates_presence_of :quotation

  belongs_to :host,
             class_name: 'User',
             foreign_key: :host_id,
             inverse_of: :host_parties

  belongs_to :guide,
             class_name: 'User',
             foreign_key: :guide_id,
             optional: true,
             inverse_of: :guide_parties

  has_many :activities, through: :quotation

  has_many :user_parties, dependent: :delete_all
  has_many :users, through: :user_parties

  invitable named_by: :title

  validates :title, presence: true, length: { maximum: 50 }, uniqueness: true

  def customers
    users
  end

  def as_json(options = {})
    super(
      only: %i[id title host guide date],
      include: {
        activities: { only: %i[id title] },
        invites:    { only: %i[invitable_id email] },
        users:      { only: %i[id email] }
      }
    )
  end
end
