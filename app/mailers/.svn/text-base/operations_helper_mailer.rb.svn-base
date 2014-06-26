class OperationsHelperMailer < ActionMailer::Base
  default from: "stratus@stratus.crt.travelocity.com"

  def deployment_needs_help(sender_id, deployment_id)
    @from = User.find(sender_id)
    @deployment = Deployment.find(deployment_id)
    @deployment_show_url = deployment_path(deployment_id)
    @to = "DeveloperServices@sabre.com"
  end
end
