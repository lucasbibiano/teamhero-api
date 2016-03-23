module Events
  class WikiEventParser
    def parse(payload)
      WikiEvent.create do |wiki|
        wiki.pages = payload.dig("pages").map do |page|
          page.slice("page_name", "action", "title")
        end.to_s
        wiki.actor = payload.dig("sender", "login")
        wiki.repository = payload.dig("repository", "name")
        wiki.organization = payload.dig("organization", "login")
      end
    end
  end
end
