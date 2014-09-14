class SmsClient
  attr_reader :client, :from_number

  def initialize
    sid, token = ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
    @client = Twilio::REST::Client.new(sid, token)
    @from_number = ENV['TWILIO_PHONE_NUMBER']
  end

  def send(phone_number, msg)
    params = {
      from: from_number,
      to: '+' + phone_number,
      body: msg
    }
    client.account.sms.messages.create(params)
  end
end
