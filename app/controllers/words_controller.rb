class WordsController < ApplicationController

  hobo_model_controller

  auto_actions [ :index, :show ]
  
  auto_actions_for :sites, :index
  
  def show
    @w = Word.find(params[:id])
    if @w.words.size == 0
      redirect_to "/words/#{@w.id}/sites/"
    else
      hobo_index @this = @w.words
    end
  end
  

  def index
    if request.format.html?
      if current_user.guest?
        hobo_index Word.all.where( word_id: nil )
      else
        hobo_index current_user.words.where( word_id: nil )
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

  index_action :tree
  
  def tree
    render :json => Word.tree
  end

  
end
