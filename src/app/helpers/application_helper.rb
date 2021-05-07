module ApplicationHelper
  def document_title
    if @title.present?
      "#{@title} - SAMPLE6-app"
    else
      "SAMPLE6"
    end
  end
end
