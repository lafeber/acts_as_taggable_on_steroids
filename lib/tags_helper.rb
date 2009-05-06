module TagsHelper
  # See the README for an example using tag_cloud.
  def tag_cloud(tags, classes)
    return if tags.empty?
    
    max_count = tags.sort_by(&:count).last.count.to_f
    max_count = 1 if max_count == 0
    
    tags.each do |tag|
      index = ((double_count(tag, tags, tag.count) / (max_count)) * (classes.size - 1)).round
      yield tag, classes[index]
    end
  end
  
  # This makes sure that multiple tags sum their count
  def double_count(tag, tags, count)
    doubles = tags.select{|t| t.name == tag.name}
    return count if doubles.size < 2
    doubles.map(&:count).sum
  end
end
