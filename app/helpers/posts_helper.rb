module PostsHelper
  def post_content(action_name, post)
    case action_name
    when 'index'
      post.content.truncate(177)
    when 'show'
      post.content
    end
  end
end
