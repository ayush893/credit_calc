class CreditDetailsController < ApplicationController
    def new
        @credit_detail=CreditDetail.new
    end

    def create
        @credit_detail = CreditDetail.new(credit_detail_params)

        if @credit_detail.save
          redirect_to your_detail_credit_details_path
            # render json: {
            #   success: true,
            #   message: "YOUR DETAILS IS SAVED SUCEESFULL.",
            # }, status: :ok
        else
          render 'new'
        end
    end

    
    def index
        @credit_detail = CreditDetail.all
    end 

    def your_detail
      @credit_detail = CreditDetail.last
      @credit_detail
      @credit_detail
      render json: {
        email: @credit_detail.email,
        credit_limit: @credit_detail.meta["credit_limit_val"],
        credit_status: @credit_detail.meta["credibility_score_val"]
      }
    end

    private
    def credit_detail_params
      params.permit(:email, :pan_card, :aadhar_no, :bank_account_no, :bank_ifsc, :balance_inflow, :balance_outflow)
    end
end
