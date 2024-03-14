class ContactMessagesController < ApplicationController
  def new
    @contact_message = ContactMessage.new
  end

  def create
    @contact_message = ContactMessage.new(contact_message_params)
    if @contact_message.save
      # Handle successful submission (e.g., redirect to a thank you page)
      redirect_to root_path, notice: "Thank you for your message!"
    else
      # Handle validation errors (e.g., re-render the form with errors)
      render :new
    end
  end

  private

  def contact_message_params
    params.require(:contact_message).permit(:name, :email, :message)
  end
end
