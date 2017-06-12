class User < ActiveRecord::Base

  before_save :downcase_email

  has_secure_password

  validates :password, length: { minimum: 6 }
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true,
                    uniqueness: { case_sensitive: false }

  def self.authenticate_with_credentials(email, password)
    @user = User.find_by_email(email.downcase.strip)
    if @user.authenticate(password)
      return @user
    else
      return nil
    end
  end

  private

  def downcase_email
    self.email.downcase!
  end

end
