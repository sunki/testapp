module ApplicationHelper

  def show_errors_for(model)
    return unless model.errors.any?
    errors = model.errors.full_messages.map do |error|
      %{ <li>#{error}</li> }
    end.join
    raw(%{ <ul>#{errors}</ul> })
  end
end
