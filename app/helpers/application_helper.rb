module ApplicationHelper
  def fetch_content(key, format=false)
    @string = "#{params[:controller]}.#{params[:action]}.#{key.to_s}"
    format == :raw ? raw(t(@string)) : t(@string)
  end
end
