class ContactMailer < ApplicationMailer
  def contact_mail(contact)
    @contact = contact
    
    mail to: @contact.email, cc: "kokichi.omi@g.softbank.co.jp", subject: "お問い合わせの確認メール"
  end
  def post_mail(post)
    @post = post
    
    mail to: @post.user.email, cc: "kokichi.omi@g.softbank.co.jp", subject: "投稿完了メール"
  end  
end