before do
  @client = Twilio::REST::Client.new ENV['twilio_account_sid'], ENV['twilio_auth_token']
end

get '/' do
  @questions = Message.includes(:user).all
  erb :index
end

# get '/complete_message_list' do
#   @incoming = @client.account.sms.messages.list
#   erb :incoming
# end

post '/send_message' do
  p params
  send_response({
                to_user_id: params[:to_user_id], 
                body: params[:message], 
                incoming_id: params[:incoming_id],
                from_user_id: params[:from_user_id]
                                                 })
  redirect to('/')
end

post '/receive_callback' do
  if user = User.where(phone_number: params[:From]).first
    user.questions.create(message: params[:Body], status: "open", msg_type: "incoming")
  else
    sms_response(USER_NOT_FOUND_MSG)
  end
end

