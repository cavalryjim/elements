class ElementsController < InheritedResources::Base

  actions :all
  respond_to :html, :xml, :json, :js
  # Require authentication for edit and delete.
  before_filter :authenticate_user!, :except => [:index,:show,:tag_cloud]
  #filter_resource_access
  
  #respond_to :iphone, :except => [ :edit, :update ]

  before_filter :new_element, :only => [:new, :new_element_attachable_from_params]

  before_filter :tag_cloud, :only => [:index]
  before_filter :set_attachable, :only => [:new, :update, :new_element_attachable_from_params]
  
  # this way allows us to browse via the polymorphic controllers
  #belongs_to :page,:picture,:domain, :polymorphic => true, :optional => true, :singleton => true
  # this way allows us to browse via the elements controller, but not nested polymorphic models
  #belongs_to :page, :picture, :domain, :polymorphic => true, :optional => true
  #belongs_to :domain, :singleton => true, :optional => true

  has_scope :featured, :type => :boolean
  has_scope :by_tag
  has_scope :limit, :default => 1000, :only => :index
  has_scope :by_type
 
  caches_action :tag_cloud
  
  def index
    @elements = apply_scopes(Element).all
  end
  
  def edit
    edit! do |format|
      format.js { render "edit.html.erb", :layout => false, :content_type => Mime::HTML }
    end
  end
  
  def create
    create! do |success,failure|
      success.json { render :json => { :status => 200, :id => resource.id, :url => resource_path(resource) }, :layout => false }
      failure.json { render :json => { :status => :unprocessible_entity, :errors => resource.errors }, :layout => false }
    end
  end
  
  def update
    update! do |format|
      format.html { render "edit.html.erb", :layout => false, :content_type => Mime::HTML }
    end
  end
  
  def destroy
    destroy! do |format|
      format.json { render :nothing => true }
    end
  end

  # GET /elements/new_element_attachable_from_params
  def new_element_attachable_from_params
    @element.build_attachable(params)
    respond_to do |format|
      format.html { render :layout => false }# new_component.html.erb
      format.js { render :layout => false, :content_type => Mime::HTML }# new_component.html.js
      format.xml  { render :xml => @element }
    end
  end
  
  def tag_cloud
    # prime candidate for caching
    @tags ||= Element.tag_counts_on(:tags)
  end
  
  protected
  
    def after_save
      expire_cache
    end
  
    def expire_cache
      expire_action :action => :edit
    end
    
    def new_element
      @element = Element.new
    end
    
    def set_attachable
      @classname = "element_attachable_attributes"
    end

end
