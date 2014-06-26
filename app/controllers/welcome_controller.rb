class WelcomeController < ApplicationController
  before_filter :authenticate_user!
  before_filter :setup

  def index
    @deployments = Deployment.incomplete_or_rejected.sort_by(&:created_at).reverse
    @deployment_sets = @deployments.group_by(&:deployment_set_id)
    @deployments_landed_size = Deployment.landed.size
    @switches = Switch.incomplete_or_rejected.sort_by(&:created_at).reverse
    @refreshes = Refresh.incomplete.sort_by(&:created_at).reverse
    @workload = Deployment.incomplete.sort_by(&:created_at).reverse + Switch.incomplete.sort_by(&:created_at).reverse
    @my_workload = Deployment.by_acceptor(current_user.id).incomplete.sort_by(&:created_at).reverse + Switch.by_user(current_user.id).incomplete.sort_by(&:created_at).reverse
  end

private
  def setup
    basic_setup
  end
end
