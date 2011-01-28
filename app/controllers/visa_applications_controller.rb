require 'digest/sha1'
class VisaApplicationsController < ApplicationController
  # GET /visa_applications
  # GET /visa_applications.xml

  before_filter do
    [:uk_visa_application, :dk_visa_application].each do |type|
      if va = params[type]
        params[:visa_application] = va
      end
    end
  end

  before_filter :authenticate, :except => [:index, :show]
  def index
    @visa_applications = VisaApplication.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @visa_applications }
    end
  end

  # GET /visa_applications/1
  # GET /visa_applications/1.xml
  def show
    @visa_application = VisaApplication.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @visa_application }
    end
  end

  # GET /visa_applications/new
  # GET /visa_applications/new.xml
  def new
    @visa_application = VisaApplication.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @visa_application }
    end
  end

  # GET /visa_applications/1/edit
  def edit
    @visa_application = VisaApplication.find(params[:id])
  end

  # POST /visa_applications
  # POST /visa_applications.xml
  def create
    klass = params[:visa_application][:type].constantize
    @visa_application = klass.new(params[:visa_application])

    respond_to do |format|
      if @visa_application.save
        format.html { redirect_to(@visa_application, :notice => 'Visa application was successfully created.') }
        format.xml  { render :xml => @visa_application, :status => :created, :location => @visa_application }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @visa_application.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /visa_applications/1
  # PUT /visa_applications/1.xml
  def update
    @visa_application = VisaApplication.find(params[:id])

    respond_to do |format|
      if @visa_application.update_attributes(params[:visa_application])
        format.html { redirect_to(@visa_application, :notice => 'Visa application was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @visa_application.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /visa_applications/1
  # DELETE /visa_applications/1.xml
  def destroy
    @visa_application = VisaApplication.find(params[:id])
    @visa_application.destroy

    respond_to do |format|
      format.html { redirect_to(visa_applications_url) }
      format.xml  { head :ok }
    end
  end
  
  def update_status
    @visa_application = VisaApplication.find(params[:id])
    @visa_application.update_status
    render :json => @visa_application
  end
  private
  def authenticate
    authenticate_or_request_with_http_basic('Administration') do |username, password|
      md5_of_password = Digest::SHA1.hexdigest(password)
      username == 'admin' && md5_of_password == '77d1a9ba4e8434164911fb8184eac3c31bfe7c41'
    end
  end

end
