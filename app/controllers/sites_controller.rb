class SitesController < ApplicationController

  hobo_model_controller
  
  auto_actions [ :index, :show, :add, :do_add, :deep, :do_deep ]
  
  auto_actions_for :words, :index

  def index
    if request.format.html?
      if current_user.guest?
        hobo_index 
      else
        hobo_index current_user.sites
      end
    else
      hobo_index(:paginate => false) do |expects|
        expects.json { render :json => @this.to_json }
        expects.pdf 
        expects.csv  { send_data @this.to_csv }
        expects.xls  { send_data @this.to_csv(col_sep: "\t") }
      end
    end
  end

  def show
    redirect_to "/sites/#{params[:id]}/words/"
  end

  def do_add
    site = Site.find_by_name params[:name]
    if site
      do_creator_action :add, redirect_to: site
    else
      do_creator_action :add
    end
  end

end
