before do
  @client = Twilio::REST::Client.new ENV['twilio_account_sid'], ENV['twilio_auth_token']
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

# post '/receive_callback' do

#   conn = Faraday.new(:url => params[:callback]) do |faraday|
#       faraday.request  :url_encoded             # form-encode POST params
#       faraday.response :logger                  # log requests to STDOUT
#       faraday.adapter  Faraday.default_adapter  # make requests with Net::HTTP
#     end
#     response = conn.post '/receive_callback', params
# end
