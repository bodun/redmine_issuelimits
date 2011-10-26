require 'redmine'

require 'dispatcher'
Dispatcher.to_prepare :redmine_issuelimits do 
  require_dependency 'issue'
  
  unless Issue.included_modules.include? RedmineIssuelimits::IssuePatch 
    Issue.send(:include, RedmineIssuelimits::IssuePatch)
  end
  
end

Redmine::Plugin.register :redmine_issuelimits do
  name 'Issuelimits plugin'
  author 'Yevhen Kyrylchenko'
  description 'Plugin for limitation of new issues'
  version '0.0.1'
  url 'https://github.com/bodun/redmine_issuelimits'
  author_url 'http://www.facebook.com/profile.php?id=100002042757641'

  project_module :issuelimits do
    permission :view_issuelimits, {:issuelimits => :index}, :require => :member
    permission :edit_issuelimits, {:issuelimits => [:index, :savelimit]}, :require => :member
  end
  
  menu :project_menu, :issuelimits, { :controller => 'issuelimits', :action => 'index' }, :caption => :lbl_menu, :param => :project_id
end
