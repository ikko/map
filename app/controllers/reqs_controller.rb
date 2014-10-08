class ReqsController < ApplicationController

  hobo_model_controller

  auto_actions :all


  def index
    if request.format.html?
      hobo_index Req.manual 
    else
      self.this = Req.manual
      hobo_index(:paginate => false) do |expects|
        expects.json { render :json => @this.to_json }
        expects.pdf 
        expects.csv  { send_data @this.to_csv }
        expects.xls  { send_data @this.to_csv(col_sep: "\t") }
      end
    end
  end

  index_action :auto do
    hobo_index Req.not_manual
  end

end
