require 'redmine'

#require 'dispatcher'
ActionDispatch::Callbacks.to_prepare do
  require_dependency 'issue'
  
  unless Issue.included_modules.include? RedmineIssuelimits::IssuePatch 
    Issue.send(:include, RedmineIssuelimits::IssuePatch)
  end
  
end

Redmine::Plugin.register :redmine_issuelimits do
  name 'Issuelimits plugin'
  author 'Yevhen Kyrylchenko'
  description 'Plugin for limitation of new issues'
  version '0.0.3'
  url 'https://github.com/bodun/redmine_issuelimits'
  author_url 'http://www.facebook.com/profile.php?id=100002042757641'

  project_module :issuelimits do
    permission :view_issuelimits, {:issuelimits => :index}, :require => :member
    permission :edit_issuelimits, {:issuelimits => [:index, :savelimit, :switch_mode]}, :require => :member
  end
  
  menu :project_menu, :issuelimits, { :controller => 'issuelimits', :action => 'index' }, :caption => :lbl_menu, :param => :project_id
end
