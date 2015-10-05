class HelpController < ApplicationController
require 'twilio-ruby'
skip_before_action :verify_authenticity_token

  def ivr_welcome
    response = Twilio::TwiML::Response.new do |r|
      r.Gather numDigits: '1', action: menu_path do |g|
        g.Say "Welcome to eyeHelp, If this is an emergency please press 1, 
        if you need any additional support please press 2", loop: 2, :voice => 'woman'
      end
    end
    render text: response.text
  end

  def menu_selection 
    user_selection = params['Digits']
      
      case user_selection
      when "1"
          response = Twilio::TwiML::Response.new do |r|
              r.Say("Please, Do not hang up the phone we are going to 
                          get you help now", loop: 2, :voice => 'woman') 
          end
      when "2"
          response = Twilio::TwiML::Response.new do |r|
              r.Gather numDigits: '1', action: ngo_path do |g|
                  g.Say("To call for medical assistance, press 2. To call for a counselers
                        assistance, press 3. To call for relocation support press 4. To call for 
                        sexual harassement help press 5", :voice => 'woman', loop:3)
                  # g.Dial("+17188857033")
              end
          end
      end
    render text: response.text
  end

def ngo_selection
    user_selection = params['Digits']

     case user_selection
     when "2"
      response = Twilio::TwiML::Response.new do |r|
       r.Dial("+17188857033")
      end
     when "3"
      response = Twilio::TwiML::Response.new do |r|
       r.Dial("+12027336386")
      end
     when "4"
      response = Twilio::TwiML::Response.new do |r|
       r.Dial("+12027336637")
      end
     else
      response = Twilio::TwiML::Response.new do |r|
       r.Say("GoodBye!")
      end
     end
  end

end
