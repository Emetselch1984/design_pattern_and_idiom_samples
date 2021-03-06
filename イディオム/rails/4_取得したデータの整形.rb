class MessagesController < ApplicationController
  ## ======= π γγγγθΏ½ε γγ =======
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
  ## ====== π γγγΎγ§θΏ½ε γγ =======
end