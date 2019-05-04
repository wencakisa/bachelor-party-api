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

  has_many :invites, -> { where(status: :sent) }, as: :invitable

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

  def process_user(user)
    users << user
  end

  private

  @@guide_email = ""

  def notify_guide_for_party_assignment
    if guide
      @@guide_email = guide.email
      PartyMailer.notify_guide_for_party_assignment(self).deliver_later
    end
  end

  def notify_guide_for_party_withdrawal
    if guide.nil?
      PartyMailer.notify_guide_for_party_withdrawal(self, @@guide_email).deliver_later
    end
  end
end
