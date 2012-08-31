match 'projects/:project_id/issuelimits', :to => 'issuelimits#index'
match 'projects/:project_id/issuelimits/savelimit', :to => 'issuelimits#savelimit'
match 'projects/:project_id/issuelimits/switch_mode', :to => 'issuelimits#switch_mode'
match 'projects/:project_id/issuelimits/find_project', :to => 'issuelimits#find_project'
