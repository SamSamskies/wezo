helpers do
  TWILLIO_NUM = '+17202599396'

  def date(date)
    date.strftime("%Y-%m-%d %H:%M:%S UTC")
  end

  def save_message(args)
    incoming = Incoming.where(id: args[:incoming_id]).first
    incoming.responses.create(message: args[:body], user_id: args[:response_user_id])
  end

  def sms_response(message)
    twiml = Twilio::TwiML::Response.new do |r|
      r.Sms message
    end
    twiml.text
  end

  def verify_phone_number(to)
    send_message({:to => to,
                  :body => VERIFY_PHONE_NUM_MSG})
    #Verification.create()
  end
end