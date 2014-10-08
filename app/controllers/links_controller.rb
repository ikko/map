class LinksController < ApplicationController

  hobo_model_controller

  auto_actions :none


  def index
    if request.format.html?
      hobo_index 
    else
      hobo_index(:paginate => false) do |expects|
        expects.json { render :json => @this.to_json }
        expects.pdf 
        expects.csv  { send_data @this.to_csv }
        expects.xls  { send_data @this.to_csv(col_sep: "\t") }
      end
    end
  end

end
