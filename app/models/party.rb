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

  class << self
    def title_from_email(email)
      "Party of #{email}"
    end

    def from_quotation(quotation, host = nil)
      create!(
        quotation: quotation,
        title: title_from_email(quotation.user_email),
        host: host
      )
    end
  end

  private

  def notify_guide_for_party_assignment
    return unless guide

    PartyMailer.notify_guide_for_party_assignment(self).deliver_later
  end

  def notify_guide_for_party_withdrawal
    return if guide || last_guide_email.nil?

    PartyMailer.notify_guide_for_party_withdrawal(self).deliver_later
  end
end
