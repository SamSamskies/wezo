before do
  @client = Twilio::REST::Client.new ENV['twilio_account_sid'], ENV['twilio_auth_token']
end

get '/' do
  erb :index
end

get '/incoming' do
  @incoming = @client.account.sms.messages.list.select { |message| message.body.match(/#twt/)}
  @incoming.each { |message| Twitter.update(message.body + " test2 ") }
  erb :incoming
end

post '/' do
  @message = @client.account.sms.messages.create(
    :from => '+17202599396',
    :to => params[:to],
    :body => params[:message]
    )
  p @message
  redirect to('/incoming')
end

get '/incoming_message' do
  p params
  p params[:AccountSid]
  p params[:Body]
  p params[:From]
  p session
  sms_count = session["counter"]
  if sms_count == 0
    message = "Hello, thanks for the new message."
  else
    message = "Hello, thanks for message number #{sms_count + 1}"
  end
  twiml = Twilio::TwiML::Response.new do |r|
    r.Sms message
  end
  session["counter"] += 1
  twiml.text

end


  # twiml = Twilio::TwiML::Response.new do |r|
  #   r.Sms "Hey Sam, you are a dickhead!"
  # end
  # p twiml.text
  # twiml.text
