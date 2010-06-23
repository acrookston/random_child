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

  desc %{
    Renders the tag contents only if the current page is the first child in the context of
    a children:random tag
    
    *Usage:*
    
    <pre><code><r:children:random>
      <r:if_first >
        ...
      </r:if_first>
    </r:children:random>
    </code></pre>
    
  }
  tag 'children:random:if_first' do |tag|
    tag.expand if tag.locals.first_child
  end

  
  desc %{
    Renders the tag contents unless the current page is the first child in the context of
    a children:random tag
    
    *Usage:*
    
    <pre><code><r:children:random>
      <r:unless_first >
        ...
      </r:unless_first>
    </r:children:random>
    </code></pre>
    
  }
  tag 'children:random:unless_first' do |tag|
    tag.expand unless tag.locals.first_child
  end
  
  desc %{
    Renders the tag contents only if the current page is the last child in the context of
    a children:random tag
    
    *Usage:*
    
    <pre><code><r:children:random>
      <r:if_last >
        ...
      </r:if_last>
    </r:children:random>
    </code></pre>
    
  }
  tag 'children:random:if_last' do |tag|
    tag.expand if tag.locals.last_child
  end

  
  desc %{
    Renders the tag contents unless the current page is the last child in the context of
    a children:random tag
    
    *Usage:*
    
    <pre><code><r:children:random>
      <r:unless_last >
        ...
      </r:unless_last>
    </r:children:random>
    </code></pre>
    
  }
  tag 'children:random:unless_last' do |tag|
    tag.expand unless tag.locals.last_child
  end
  
end
