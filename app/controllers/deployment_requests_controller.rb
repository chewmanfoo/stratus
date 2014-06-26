class DeploymentRequestsController < InheritedResources::Base

  respond_to :html, :json, :xml

  skip_before_filter :verify_authenticity_token, :if => Proc.new { |c| c.request.format == 'application/json' }

  def create
    @deployment_request = DeploymentRequest.new(params[:deployment_request])
    flash[:notice] = @deployment_request.save ? "Your deployment_request was created." : "DeploymentRequest failed to save."
    @deployment_request.verified!
    respond_with @deployment_request
  end

  def show_deployment_reference
    @deployment_request = DeploymentRequest.find(params[:id])
    
    if @deployment_request
      respond_to do |f|
        f.html
        f.json
        f.xml
      end
    else
      flash[:error] = "Could not find that Deployment Request!"
      redirect_to root_url
    end
  end
end
