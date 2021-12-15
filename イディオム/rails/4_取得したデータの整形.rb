class MessagesController < ApplicationController
  ## ======= 👇 ここから追加する =======
  def index
    messages = Message.all
    messages_array = messages.map do |message|
      {
          id: message.id,
          user_id: message.user.id,
          name: message.user.name,
          content: message.content,
          email: message.user.email,
          created_at: message.created_at
      }
    end

    render json: messages_array, status: 200
  end
  ## ====== 👆 ここまで追加する =======
end