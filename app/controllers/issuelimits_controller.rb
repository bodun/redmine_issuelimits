class IssuelimitsController < ApplicationController
  unloadable
  before_filter :find_project, :authorize, :only => [:index, :savelimit, :switch_mode]
  def index
    if @project == nil
      render_404
      return
    end

    @trackers = Tracker.find(:all)

    @issuelimits = Issuelimit.find(:first, :conditions => { :projectid => @project.id })

    # Check limit header
    if @issuelimits.nil?
      @issuelimits = Issuelimit.create(:projectid => @project.id, :pertracker => 0)
    end

    # Check limit items
    if @issuelimits.limits.count < @trackers.count
      # Record for per project mode
      if Limit.find(:first, :conditions => { :issuelimit_id => @issuelimits.id, :trackerid => nil }).nil?
        @issuelimits.limits.create(:limitactive => 0, :issuecount => 0, :trackerid => nil)
      end

      # Records for per tracker mode
      @trackers.each do |trc|
        if Limit.find(:first, :conditions => { :issuelimit_id => @issuelimits.id, :trackerid => trc.id }).nil?
          @issuelimits.limits.create(:limitactive => 0, :issuecount => 0, :trackerid => trc.id)
        end
      end

      @issuelimits.save
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

  def switch_mode
    @issuelimits = Issuelimit.find(params[:id])
    @issuelimits.pertracker = !@issuelimits.pertracker
    @issuelimits.save
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
