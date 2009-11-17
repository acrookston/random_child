module RandomChild
  include Radiant::Taggable

  desc %{
    Cycles through each of the children in a random order.
    Inside this tag all page attribute tags are mapped to the current child page.
    
    *Usage:*
    
    <pre><code><r:children:random [limit="number"]
     [by="published_at|updated_at|created_at|slug|title|keywords|description"]
     [status="draft|reviewed|published|hidden|all"]>
     ...
    </r:children:random>
    </code></pre>
  }
  tag 'children:random' do |tag|
    options = children_find_options(tag)
    result = []
    children = tag.locals.children
    tag.locals.previous_headers = {}
    limit = options[:limit] || false
    options = options.delete_if {|key, value| key == :order or key == :limit }
    kids = children.find(:all, options).sort_by{rand}
    i = 0
    kids.each do |item|
      tag.locals.child = item
      tag.locals.page = item
      tag.locals.first_child = i == 0
      tag.locals.last_child = i == kids.length - 1
      tag.locals.index = i
      result << tag.expand
      i += 1
    end
    if limit
      result[0..(limit-1)]
    else
      result
    end
  end
end
