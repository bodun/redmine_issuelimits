ActionController::Routing::Routes.draw do |map|
    map.connect "projects/:project_id/issuelimits", :controller => "issuelimits", :action => "index"
    map.connect "projects/:project_id/issuelimits/savelimit", :controller => "issuelimits", :action => "savelimit"
    map.connect "projects/:project_id/issuelimits/switch_mode", :controller => "issuelimits", :action => "switch_mode"
    map.connect "projects/:project_id/issuelimits/find_project", :controller => "issuelimits", :action => "find_project"
end
