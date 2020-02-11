class User::Create
  include ActiveModel::Model

  ATTRIBUTES = [:email, :password, :first_name, :last_name, :birthday]

  attr_accessor :user, :success
  attr_accessor *ATTRIBUTES

  validates_presence_of ATTRIBUTES

  def initialize(attributes, user = User.new)
    self.user = user

    super(attributes)
  end

  def save
    # Valid will setup the Form object errors
    if valid?
      persist!
      self.success = true
    else
      self.success = false
    end
  rescue ActiveRecord::RecordInvalid => e
    self.errors.add(:base, e.message)
    self.success = false
  end

  def serialized_record
    user.slice(*ATTRIBUTES).without(:password)
  end

  private

  def persist!
    user.update!(record_attributes)
  end

  def record_attributes
    ATTRIBUTES.map { |attr| [attr, send(attr)] }.to_h
  end
end
