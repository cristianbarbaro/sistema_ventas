class MarksController < ApplicationController
  before_action :set_mark, only: [:show, :edit, :update, :destroy]

  # GET /marks
  def index
    @q = Mark.ransack(params[:q])
    @marks = @q.result.paginate(:page => params[:page]).order(sort_column + " " + sort_direction)
  end

  # GET /marks/1
  def show
  end

  # GET /marks/new
  def new
    @mark = Mark.new
  end

  # GET /marks/1/edit
  def edit
  end

  # POST /marks
  def create
    @mark = Mark.new(mark_params)

    respond_to do |format|
      if @mark.save
        format.html {
            flash[:success] = 'La marca se ha creado correctamente.'
            redirect_to @mark
        }
        format.json { render :show, status: :created, location: @mark }
      else
        format.html { render :new }
        format.json { render json: @mark.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /marks/1
  def update
    respond_to do |format|
      if @mark.update(mark_params)
        format.html {
            flash[:success] = 'La marca se ha actualizado correctamente.'
            redirect_to @mark
        }
        format.json { render :show, status: :ok, location: @mark }
      else
        format.html { render :edit }
        format.json { render json: @mark.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /marks/1
  def destroy
    respond_to do |format|
        if @mark.destroy
            format.html {
                flash[:success] = 'La marca se ha creado correctamente.'
                redirect_to marks_url
            }
            format.json { head :no_content }
        else
            format.html {
                flash[:alert] = "No se puede eliminar la marca porque tiene artículos asociados."
                redirect_to marks_url
            }
        end
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mark
      @mark = Mark.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mark_params
      params.require(:mark).permit(:name)
    end

    def sort_column
      Provider.column_names.include?(params[:sort]) ? params[:sort] : "name"
    end
end
