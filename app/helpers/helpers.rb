helpers do
  TWILLIO_NUM = '+17202599396'
  USER_NOT_FOUND_MSG = "Your number does not seem to be on our system. Please register an your number at www.wezolo.com!"
  VERIFY_PHONE_NUM_MSG = "Please enter the following code into the registration website: #{SecureRandom.hex(2)}"

  def date(date)
    date.strftime("%Y-%m-%d %H:%M:%S UTC")
  end

  def send_message(args)
    @client.account.sms.messages.create(
      :from => TWILLIO_NUM,
      :to => args[:to],
      :body => args[:body]
      )
  end

  def send_response(args)
    send_message(args)
    save_message(args)
  end

  def save_message(args)
    question = Question.where(id: args[:question_id]).first
    #note create association with current user
    question.answers.create(:question => question, answer: args[:body])
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
