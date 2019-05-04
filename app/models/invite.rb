class Invite < ApplicationRecord
  belongs_to :invitable, polymorphic: true

  belongs_to :sender, class_name: 'User'
  belongs_to :recipient, class_name: 'User', optional: true

  before_create :generate_token
  before_save :set_recipient_if_exists
  after_create :notify_recipient

  validates :email, presence: true

  STATUSES = %i[sent accepted].freeze
  enum status: STATUSES

  def generate_token
    self.token = SecureRandom.hex(20).encode('UTF-8')
  end

  def set_recipient_if_exists
    recipient = User.find_by_email(email)
    self.recipient_id = recipient.id if recipient
  end

  def notify_recipient
    InviteMailer.new_user_invite(self).deliver_later
  end
end
