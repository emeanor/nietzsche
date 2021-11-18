module Division
  extend ActiveSupport::Concern

  def has_subtitle?
    self.subtitle.present?
  end

  def has_children?
    self.children.any?
  end

  def has_child?(child_id)
    self.children.where(id: child_id).exists?
  end

  def valid_position?(position)
    position.is_a?(Integer) && position > 0 && position <= self.children.maximum('position')
  end

  def add_child(child, position=nil)
    self.children << child unless self.has_child?(child.id)
    move_child(child, position) unless position.nil?
    return child
  end

  def destroy_child(child)
    self.children.destroy(child.id) if self.has_child?(child)
  end

  def move_child(child, position)
    return unless self.has_child?(child)
    valid_position?(position) ? child.set_list_position(position) : child.move_to_bottom
  end

end