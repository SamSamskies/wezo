get '/' do


@client = Twilio::REST::Client.new ENV['twilio_account_sid'], ENV['twilio_auth_token']

@client.account.sms.messages.create(
  :from => '+12026013563',
  :to => '+18082183629',
  :body => 'Hey there!'
)

erb :index
end
