module ApplicationHelper
	def flash_class(nivel)
		case nivel
		when :notice then
			"alert alert-info alert-dismissable"
		when :success then
			"alert alert-success alert-dismissable"
		when :warning then
			"alert alert-warning alert-dismissable"
		when :error then
			"alert alert-danger alert-dismissable"
		end
	end
end
