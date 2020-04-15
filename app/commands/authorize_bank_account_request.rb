class AuthorizeBankAccountRequest
  prepend SimpleCommand

  def initialize(headers = {})
    @headers = headers
  end

  def call
    bank_account
  end

  private

  attr_reader :headers

  def bank_account
    @bank_account ||= BankAccount.find(decoded_auth_token[:account_id]) if decoded_auth_token
    @bank_account || errors.add(:token, 'Invalid token') && nil
  end

  def decoded_auth_token
    @decoded_auth_token ||= JsonWebToken.decode(http_auth_header)
  end

  def http_auth_header
    if headers['Authorization'].present?
      return headers['Authorization'].split(' ').last
    else
      errors.add(:token, 'Missing token')
    end
    nil
  end
end