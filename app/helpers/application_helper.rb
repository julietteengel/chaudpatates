module ApplicationHelper

	WEEKDAY_NAMES = [ "Sunday", "Monday", "Tuesday", "Wednesday", "Thursday", "Friday", "Saturday"]

	def wday(day)
		wday_from_name =  Hash[*WEEKDAY_NAMES.each_with_index.to_a.flatten]
		wday_from_name[day]
	end
end

module ApplicationHelper
  include Koudoku::ApplicationHelper
end


# module ApplicationHelper
#   module Rails
#     class Engine < ::Rails::Engine
#       initializer :set_decorator_paths, :before => :load_environment_hook do |app|
#         ActiveSupportDecorators.paths << File.join(config.root, 'app/**')
#       end
#     end
#   end
# end
