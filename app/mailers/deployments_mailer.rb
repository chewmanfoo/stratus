class DeploymentsMailer < ActionMailer::Base
  default from: "stratus@#{HOSTNAME}"

  def deployment_created(mail_recipient, deployment)
    @mail_recipient = mail_recipient 
#    @to = @mail_recipient.addresses.split(';') << Deployment.PROCESS_OWNER
    @to = [Deployment.PROCESS_OWNER]
    @deployment = deployment
    @user_desc = random_bin[rand(random_bin.size)] 
    @user = deployment.creator
    @url = "http://#{HOSTNAME}/deployments/#{deployment.id}"
    mail(:to => @to, :subject => "A Deployment Request for #{deployment.full_name} has been SUBMITTED to Stratus")
  end

  def deployment_accepted(mail_recipient, deployment)
    @mail_recipient = mail_recipient
#    @to = @mail_recipient.addresses.split(';') << Deployment.PROCESS_OWNER
    @to = [Deployment.PROCESS_OWNER]
    @deployment = deployment
    @user_desc = random_bin[rand(random_bin.size)] 
    @user = deployment.acceptor
    @url = "http://#{HOSTNAME}/deployments/#{deployment.id}"
    mail(:to => @to, :subject => "A Deployment Request for #{deployment.full_name} has been ACCEPTED in Stratus")
  end

  def deployment_approved(mail_recipient, deployment)
    @mail_recipient = mail_recipient
#    @to = @mail_recipient.addresses.split(';') << Deployment.PROCESS_OWNER
    @to = [Deployment.PROCESS_OWNER]
    @deployment = deployment
    @user_desc = random_bin[rand(random_bin.size)] 
    @user = deployment.approver
    @url = "http://#{HOSTNAME}/deployments/#{deployment.id}"
    mail(:to => @to, :subject => "A Deployment Request for #{deployment.full_name} has been APPROVED in Stratus")
  end

  def deployment_terminated(mail_recipient, deployment)
    @mail_recipient = mail_recipient
#    @to = @mail_recipient.addresses.split(';') << Deployment.PROCESS_OWNER
    @to = [Deployment.PROCESS_OWNER]
    @deployment = deployment
    @user_desc = random_bin[rand(random_bin.size)] 
    @user = deployment.terminator
    @url = "http://#{HOSTNAME}/deployments/#{deployment.id}"
    mail(:to => @to, :subject => "A Deployment Request for #{deployment.full_name} has been TERMINATED in Stratus")
  end

  def deployment_rejected(mail_recipient, deployment)
    @mail_recipient = mail_recipient
    @to = @mail_recipient.addresses.split(';') << Deployment.PROCESS_OWNER
    @deployment = deployment
    @user_desc = random_bin[rand(random_bin.size)] 
    @user = deployment.rejector
    @url = "http://#{HOSTNAME}/deployments/#{deployment.id}"
    mail(:to => @to, :subject => "A Deployment Request for #{deployment.full_name} has been REJECTED in Stratus")
  end

  def deployment_started(mail_recipient, deployment)
    @mail_recipient = mail_recipient
    @to = @mail_recipient.addresses.split(';') << Deployment.PROCESS_OWNER
    @deployment = deployment
    @user_desc = random_bin[rand(random_bin.size)] 
    @user = deployment.starter
    @url = "http://#{HOSTNAME}/deployments/#{deployment.id}"
    mail(:to => @to, :subject => "A Deployment Request for #{deployment.full_name} has STARTED in Stratus")
  end

  def deployment_terminated(mail_recipient, deployment)
    @mail_recipient = mail_recipient
    @to = @mail_recipient.addresses.split(';') << Deployment.PROCESS_OWNER
    @deployment = deployment
    @user_desc = random_bin[rand(random_bin.size)] 
    @user = deployment.terminator
    @url = "http://#{HOSTNAME}/deployments/#{deployment.id}"
    mail(:to => @to, :subject => "A Deployment Request for #{deployment.full_name} has BEEN TERMINATED in Stratus")
  end

  def deployment_completed(mail_recipient, deployment)
    @mail_recipient = mail_recipient
    @to = @mail_recipient.addresses.split(';') << Deployment.PROCESS_OWNER
    @deployment = deployment
    @user_desc = random_bin[rand(random_bin.size)] 
    @user = deployment.completor
    @url = "http://#{HOSTNAME}/deployments/#{deployment.id}"
    mail(:to => @to, :subject => "A Deployment Request for #{deployment.full_name} has been COMPLETED to Stratus")
  end

  def deployment_needs_approval(mail_recipient, deployment)
    @mail_recipient = mail_recipient
    @to = @mail_recipient.addresses.split(';') << Deployment.PROCESS_OWNER
    @deployment = deployment
    @user_desc = random_bin[rand(random_bin.size)] 
    @user = deployment.starter
    @url = "http://#{HOSTNAME}/deployments/#{deployment.id}/approve"
    mail(:to => @to, :subject => "A Deployment Request for #{deployment.full_name} is awaiting YOUR approval")
  end

private

  def random_bin
    ["A woman on the verge of a nervous breakdown", "A super-hero", "A restless slug", "A citizen, frustrated with outdated imperialist dogma", "A comrade in an anarcho-syndicalist commune", "An anxious patient", "An authentic replica", "An accurate stereotype", "An advanced beginner", "An anonymous colleague", "An acrophobic mountain climber", "An aging yuppie", "An amateur expert", "A clever user", "A witty copatriot", "An intriguing giant", "A proud partisan", "An attractive passers-by", "An erudite scholar", "A friendly foe", "A generous lion", "An honest friend", "A hard-working laborer", "A lucky gambler", "A neat user", "A fastidious nerve", "A polite soldier", "A popular thinker", "A shy rabbit", "A silly snail", "A smart homo-sapien", "A tidy homemaker", "A swift runner", "A wise old soul"]
  end
end
