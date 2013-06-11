module ApplicationHelper
  def format( input )
    unless input.nil?
      input[:params].map!{|p| p.class == Array ? pluralize(*p) : p }
      input[:message] % input[:params]
    end
  end
end
