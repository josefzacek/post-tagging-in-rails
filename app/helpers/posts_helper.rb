module PostsHelper
  def post_action_button(action_name, post)
    case action_name
    when 'index'
      link_to 'Read more', post_path(post), class: 'small button'
    when 'show'
      link_to 'Posts listings', root_path, class: 'small button'
    end
  end

  def post_content(action_name, post)
    case action_name
    when 'index'
      post.content.truncate(177)
    when 'show'
      post.content
    end
  end
end
