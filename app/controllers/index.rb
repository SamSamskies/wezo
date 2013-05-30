before do
  @client = Twilio::REST::Client.new ENV['twilio_account_sid'], ENV['twilio_auth_token']
end

get '/' do
  status 200
end

post '/send_message' do
  @client.account.sms.messages.create(
    :from => TWILLIO_NUM,
    :to => params[:to],
    :body => params[:body]
    )
  status 200
  body "Message Sent"
end
