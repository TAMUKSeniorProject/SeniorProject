module DiscussionsHelper
    
    def discussion_author(discussion)
        user_signed_in? && current_user.id == discussion.user_id
    end
    
    def reply_author(reply)
        user_signed_in? && current_user.id == reply.user_id
    end
    
    def tag_links(tags)
        tags.split(",").map{|tag| link_to tag.strip, tag_path(tag.strip) }.join(", ")
    end
end
