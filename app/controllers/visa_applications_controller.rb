require 'digest/sha1'
class VisaApplicationsController < ApplicationController
  respond_to :html, :json

  before_filter do
    [:uk_visa_application, :dk_visa_application].each do |type|
      if va = params[type]
        params[:visa_application] = va
      end
    end
  end

  before_filter :check_authentication, :except => [:index, :show]

  def index
    @visa_applications = params.has_key?(:all) ? VisaApplication.all : VisaApplication.not_closed
    respond_with @visa_applications
  end

  def show
    @visa_application = VisaApplication.find(params[:id])
    respond_with @visa_application
  end

  def new
    @visa_application = VisaApplication.new
    respond_with @visa_application
  end

  def edit
    @visa_application = VisaApplication.find(params[:id])
  end

  def create
    klass = params[:visa_application][:type].constantize
    @visa_application = klass.new(params[:visa_application])

    respond_to do |format|
      if @visa_application.save
        format.html { redirect_to(@visa_application, :notice => 'Visa application was successfully created.') }
        format.json  { render :json => @visa_application, :status => :created, :location => @visa_application }
      else
        format.html { render :action => "new" }
        format.json  { render :json => @visa_application.errors, :status => :unprocessable_entity }
      end
    end
  end

  def update
    @visa_application = VisaApplication.find(params[:id])

    respond_to do |format|
      if @visa_application.update_attributes(params[:visa_application])
        format.html { redirect_to(@visa_application, :notice => 'Visa application was successfully updated.') }
        format.json  { head :ok }
      else
        format.html { render :action => "edit" }
        format.json  { render :json => @visa_application.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @visa_application = VisaApplication.find(params[:id])
    @visa_application.destroy

    respond_to do |format|
      format.html { redirect_to(visa_applications_url) }
      format.json  { head :ok }
    end
  end

  def update_status
    @visa_application = VisaApplication.find(params[:id])
    @visa_application.update_status
    render :json => @visa_application
  end
  private
  def check_authentication
    unless current_user
      redirect_to new_user_session_path
    end
  end

end
