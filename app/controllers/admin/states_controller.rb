class Admin::StatesController < ApplicationController
	before_action :set_state, only: ['show','edit','update','destroy']
	layout "admin/application"

	def index
		@states = State.all
    @states = @states.paginate(:page => (params[:page] || 1), :per_page => 20)
		respond_to do |format|
      format.html
      format.js 
    end
	end

	def new
		@state = State.new
    respond_to do |format|
      format.js
    end
    
	end

	def create
		if params[:state_attachment].present?
      State.set_state_upload(params) 
      respond_to do |format|
        format.js
      end
      
    else

      @state = State.new(state_params)
  		@state.save if @state
  		respond_to do |format|
        format.js
      end
    end

	end

	def show
		respond_to do |format|
      format.js
    end
	end

	def edit
    
		respond_to do |format|
      format.js
    end
	end

	def update
		@state.update_attributes(state_params)
		respond_to do |format|
      format.js
    end
	end

	def destroy
		@state.delete if @state
		respond_to do |format|
      format.js
    end
	end

	private

	def state_params
    params.require(:state).permit!
  end

	def set_state
		@state = State.find(params[:id])
	end

end
