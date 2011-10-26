class IssuelimitsController < ApplicationController
  unloadable
  before_filter :find_project, :authorize, :only => [:index, :savelimit]

  def index
    if @project == nil
      render_404
      return
    end

    #@project = Project.find(params[:project_id])

    @issuelimits = Issuelimit.find(:first, :conditions => { :projectid => @project.id })

    if @issuelimits.nil?
      @issuelimits = Issuelimit.create(:projectid => @project.id, :limitactive => 0, :issuecount => 0)
    end
  end

  def savelimit
    @issuelimits = Issuelimit.find(params[:id])

    if @issuelimits.update_attributes(params[:issuelimits])
      flash[:notice] = l(:msg_save_success)
    else
      flash[:error] = l(:msg_save_error)
    end

    redirect_to :action => "index", :project_id => params[:project_id]
  end

  private

  def find_project
    begin
      @project = Project.find(params[:project_id])
    rescue ActiveRecord::RecordNotFound
      render_404
      @project = nil
    rescue => e
      flash.now[:error] = e
      @project = nil
    end
  end
end
