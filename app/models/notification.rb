class Notification < ActionMailer::Base

  @@webistrano_sender_address = 'Webistrano'

  def self.webistrano_sender_address=(val)
    @@webistrano_sender_address = val
  end

  def deployment(deployment, email)
    @deployment = deployment

    mail({
      :subject => "Deployment of #{deployment.stage.project.name}/#{deployment.stage.name} finished: #{deployment.status}",
      :from => @@webistrano_sender_address,
      :to => email
    })
  end
end
