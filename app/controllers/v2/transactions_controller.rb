require "braintree"
class V2::TransactionsController < V2::BaseEntityController

  def create
      # Transaction
      card_no=params[:card][:card_no]
      mm=params[:card][:mm]
      cvv=params[:card][:cvv]
      yyyy=params[:card][:yyyy]
      result = Braintree::Transaction.sale(
        :amount => "20.00",
        :credit_card => {
          :number => card_no,
          :expiration_month => mm,
          :cvv =>cvv,
          :expiration_year => yyyy
        }
        )
    if result.success?
      @transaction= Transaction.new(transaction_id:result.transaction.id,applicant_id: params[:card][:applicant_id],status:result.transaction.status,amount:'20',card_type:result.transaction.credit_card_details.card_type, cardholder_name:result.transaction.credit_card_details.cardholder_name,purchased_type:result.transaction.type)
      if @transaction.save
        current_applicant.update(payment: true)
        render :json => @transaction
      else
        respond_with(@transaction, status: :unprocessable_entity, json: @transaction.errors, entity: _get_class)
      end
    else
      render :json => {:errors => result.errors}, status: :unprocessable_entity
    end
  end

  private

  def _entity_params
    params.require(:transaction).permit!
  end

  def _get_class
    Transaction
  end
end
