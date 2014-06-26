class CheckoutResultsController < InheritedResources::Base

  def send_email
    begin
      yield
    rescue Errno::ECONNREFUSED
      logger.info "can't connect to sendmail?"
    end if @config.send_emails?
  end

  def start
    if @checkout_result
      @checkout_result.update_attribute(:executed_by, current_user.id)
      @checkout_result.update_attribute(:executed_at, Time.now)
      @checkout_result.execute!

      if @checkout_result.save
        send_email do
#          CheckoutResultsMailer.delay.checkout_result_completed(@checkout_result.mail_recipient, @checkout_result)
        end
        flash[:notice] = "You have successfully Executed this Checkout Result.  Refresh the page to read the details."
        redirect_to root_url
      else
        flash[:error] = "There was a problem with executing this Checkout Result!"
        redirect_to checkout_results_path
      end
    else
      flash[:error] = "That Checkout Result was not found.  Check your work!"
      redirect_to checkout_results_path
    end    
  end
end
