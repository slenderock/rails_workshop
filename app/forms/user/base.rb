module User::Base
  ALL_ATTRIBUTES = User::Update::ATTRIBUTES | User::Create::ATTRIBUTES

  def self.included(base)
    base.include ActiveModel::Model
    base.attr_accessor :user, :success
    base.attr_accessor *base::ATTRIBUTES
    base.validates_presence_of base::ATTRIBUTES

    base.include InstanceMethods
  end

  module InstanceMethods
    def initialize(attributes, user = User.new)
      self.user = user

      super(attributes.slice(*self.class::ATTRIBUTES))
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

    private

    def persist!
      user.update!(record_attributes)
    end

    def record_attributes
      self.class::ATTRIBUTES.map { |attr| [attr, send(attr)] }.to_h
    end
  end
end