module StagesHelper

  def display_deployment_problems(stage)
    out =  "<ul>"
    stage.deployment_problems.each do |k,v|
      out += "<li>#{v}</li>"
    end
    out += "</ul>"
    return out
  end

  # returns the escaped format of a config value
  def capfile_cast(val)
    case Webistrano::Deployer.type_cast(val)
    when String, ActiveSupport::SafeBuffer
      val.inspect.html_safe
    when Symbol
      val.to_s.html_safe
    when Array
      val.to_s.html_safe
    when Hash
      val.to_s.html_safe
    when TrueClass, FalseClass
      val
    when NilClass
      'nil'
    else
      val.to_s.html_safe
    end

  end


end
