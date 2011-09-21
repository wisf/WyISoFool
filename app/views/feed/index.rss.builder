xml.instruct! :xml, :version => "1.0"
xml.rss :version => "2.0" do
  xml.channel do
    xml.title "Почему я такая дура?"
    xml.description "На самом деле не такая уж ты и дура"
    xml.link url_for(:only_path => false,
                     :controller => "rss",
                     :action => "index")

    for story in @stories
      xml.item do
        xml.title story.id.to_s
        xml.description story.content
        xml.pubDate story.created_at.to_s(:rfc822)
        xml.link url_for(:only_path => false,
                         :controller => "stories",
                         :action => "show",
                         :id => story.id)
        xml.guid  url_for(:only_path => false,
                         :controller => "stories",
                         :action => "show",
                         :id => story.id)
      end
    end
  end
end