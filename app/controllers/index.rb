before do
  @client = Twilio::REST::Client.new ENV['twilio_account_sid'], ENV['twilio_auth_token']
end

get '/' do
  @questions = Question.includes(:user, :answers).all
  erb :index
end

get '/complete_message_list' do
  @incoming = @client.account.sms.messages.list
  erb :incoming
end

post '/send_message' do
  send_response({
                to: params[:to], 
                body: params[:message], 
                question_id: params[:question_id]
                                                 })
  redirect to('/')
end

post '/receive_callback' do
  if user = User.where(phone_number: params[:From]).first
    user.questions.create(question: params[:Body], status: "open")
  else
    sms_response(USER_NOT_FOUND_MSG)
  end
end

