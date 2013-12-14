require 'digest/sha1'
class VisaApplicationsController < ApplicationController
  respond_to :html, :json
  before_filter :check_authentication, except: [:index]

  def index
    @visa_applications = params.has_key?(:all) ? VisaApplication.all : VisaApplication.not_closed
    respond_with @visa_applications
  end

  def share
    @visa_applications = VisaApplication
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
    @visa_application = VisaApplication.new(visa_application_attributes)

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
      if @visa_application.update_attributes(visa_application_attributes)
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
    @visa_application.update_status!
    render :json => @visa_application
  end
  private
  def visa_application_attributes
    params.require(:visa_application).permit(:application_type, :name, :reference_number, :date_of_birth, :notify_email)
  end

end
