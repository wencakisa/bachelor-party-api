class Party < ApplicationRecord
  belongs_to :quotation, -> { where(status: :approved) }

  belongs_to :host,
             class_name: 'User',
             foreign_key: :host_id,
             optional: true,
             inverse_of: :host_parties

  belongs_to :guide,
             class_name: 'User',
             foreign_key: :guide_id,
             optional: true,
             inverse_of: :guide_parties

  has_many :activities, through: :quotation

  has_many :user_parties, dependent: :delete_all
  has_many :users, through: :user_parties

  has_many :invites, as: :invitable


  validates_presence_of :quotation
  validates :title, presence: true, length: { maximum: 50 }, uniqueness: true


  after_commit :notify_guide_for_party_assignment,
               :notify_guide_for_party_withdrawal,
               on: :update

  def customers
    users
  end

  def date
    quotation.date
  end

  def as_json(options = {})
    super(
      only: %i[id title],
      methods: %i[customers date],
      include: {
        host:       { only: %i[id email] },
        guide:      { only: %i[id email] },
        activities: { only: %i[id title] },
        invites:    { only: %i[invitable_id email] }
      }
    )
  end

  private

  @@guide_email = ""

  def notify_guide_for_party_assignment
    if self.guide
      @@guide_email = self.guide.email
      PartyMailer.notify_guide_for_party_assignment(self).deliver_later
    end
  end

  def notify_guide_for_party_withdrawal
    if self.guide.nil?
      PartyMailer.notify_guide_for_party_withdrawal(self, @@guide_email).deliver_later
    end
  end
end
