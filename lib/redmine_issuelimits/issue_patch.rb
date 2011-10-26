module RedmineIssuelimits
  # Patches Redmine's IssuesController dynamically
  module IssuePatch
    def self.included(base) # :nodoc:
      base.extend(ClassMethods)
      base.send(:include, InstanceMethods)
      # Same as typing in the class 
      base.class_eval do 
        unloadable # Send unloadable so it will not be unloaded in development

        validate_on_create :check_limits

        # Add visible to Redmine
        unless respond_to?(:visible)
          named_scope :visible, lambda {|*args| { :include => :project,
                                                  :conditions => Project.allowed_to_condition(args.first || User.current, :view_issues) } }
        end
      end
    end
  end

  module ClassMethods
  end

  module InstanceMethods
    def check_limits
      # Redmine 1.2+ return if issue is private
      if self.respond_to?("is_private")
        if self.is_private?
          # TODO debug logs
          return true
        end
      end
      project=Project.find(self.project_id)

      issuelimit = Issuelimit.find(:first, :conditions => { :projectid => project.id } )
      if !issuelimit.nil?
        if issuelimit.limitactive
          #Find condition for opened statuses
          statuses = IssueStatus.find(:all, :conditions => ["is_closed = 0"])

          stat_str = String.new("")
          statuses.each do |s|
            stat_str << s.id.to_s << ", "
          end
          stat_str = stat_str[0..stat_str.length - 3]

          issues = Issue.find(:all, :conditions => ["project_id = #{project.id} and status_id in (#{stat_str})"])

          if issues.count >= issuelimit.issuecount
            errors.add_to_base(l(:error_limit_reached, :limit => issuelimit.issuecount))
            return false
          end
        end
      end

      return true
    end
  end
end
