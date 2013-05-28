before do
  @client = Twilio::REST::Client.new ENV['twilio_account_sid'], ENV['twilio_auth_token']
end

post '/send_message' do
  send_response({
                to_user_id: params[:incoming_user_id], 
                response_user_id: params[:response_user_id],
                incoming_id: params[:incoming_id],
                body: params[:message]
                                                 })
end

post '/receive_callback' do
  if user = User.where(phone_number: params[:From]).first
    user.incomings.create(message: params[:Body])
  else
    sms_response(USER_NOT_FOUND_MSG)
  end
end


# get '/' do
#   @questions = Message.includes(:user).all
#   erb :index
# end

# get '/complete_message_list' do
#   @incoming = @client.account.sms.messages.list
#   erb :incoming
# end
