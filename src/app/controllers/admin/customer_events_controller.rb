class Admin::CustomerEventsController < Admin::Base
  def index
    if params[:customer_id]
      @customer = Customer.find(params[:customer_id])
      @events = @customer.events
    else
      @events = CustomerEvent
    end
    @events = @events.order(occurred_at: :desc).includes(:member).page(params[:page])
  end
end
