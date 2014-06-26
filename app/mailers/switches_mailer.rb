class SwitchesMailer < ActionMailer::Base
  default from: "stratus@#{HOSTNAME}"

  def switch_created(mail_recipient, switch)
    @mail_recipient = mail_recipient
#    @to = @mail_recipient.addresses.split(';') << Switch.PROCESS_OWNER
    @to = [Switch.PROCESS_OWNER]
    @switch = switch
    @user_desc = random_bin[rand(random_bin.size)]
    @url = "http://#{HOSTNAME}/switches/#{switch.id}"
    mail(:to => @to, :subject => "A Switch Request for #{switch.full_name} has been SUBMITTED to Stratus")
  end

  def switch_accepted(mail_recipient, switch)
    @mail_recipient = mail_recipient
#    @to = @mail_recipient.addresses.split(';') << Switch.PROCESS_OWNER
    @to = [Switch.PROCESS_OWNER]
    @switch = switch
    @user_desc = random_bin[rand(random_bin.size)]
    @url = "http://#{HOSTNAME}/switches/#{switch.id}"
    mail(:to => @to, :subject => "A Switch Request for #{switch.full_name} has been ACCEPTED in Stratus")
  end

  def switch_rejected(mail_recipient, switch)
    @mail_recipient = mail_recipient
    @to = @mail_recipient.addresses.split(';') << Switch.PROCESS_OWNER
    @switch = switch
    @user_desc = random_bin[rand(random_bin.size)]
    @url = "http://#{HOSTNAME}/switches/#{switch.id}"
    mail(:to => @to, :subject => "A Switch Request for #{switch.full_name} has been REJECTED in Stratus")
  end

  def switch_started(mail_recipient, switch)
    @mail_recipient = mail_recipient
    @to = @mail_recipient.addresses.split(';') << Switch.PROCESS_OWNER
    @switch = switch
    @user_desc = random_bin[rand(random_bin.size)]
    @url = "http://#{HOSTNAME}/switches/#{switch.id}"
    mail(:to => @to, :subject => "A Switch Request for #{switch.full_name} has STARTED in Stratus")
  end

  def switch_completed(mail_recipient, switch)
    @mail_recipient = mail_recipient
    @to = @mail_recipient.addresses.split(';') << Switch.PROCESS_OWNER
    @switch = switch
    @user_desc = random_bin[rand(random_bin.size)]
    @url = "http://#{HOSTNAME}/switches/#{switch.id}"
    mail(:to => @to, :subject => "A Switch Request for #{switch.full_name} has been COMPLETED to Stratus")
  end

private
  def random_bin
    ["An anxious patient", "An authentic replica", "An accurate stereotype", "An advanced beginner", "An anonymous colleague", "An acrophobic mountain climber", "An aging yuppie", "An amateur expert", "A clever user", "A witty copatriot", "An intriguing giant", "A proud partisan", "An attractive passers-by", "An erudite scholar", "A friendly foe", "A generous lion", "An honest friend", "A hard-working laborer", "A lucky gambler", "A neat user", "A fastidious nerve", "A polite soldier", "A popular thinker", "A shy rabbit", "A silly snail", "A smart homo-sapien", "A tidy homemaker", "A swift runner", "A wise old soul"]
  end
end
