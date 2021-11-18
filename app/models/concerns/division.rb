module Division
  extend ActiveSupport::Concern

  def has_subtitle?
    self.subtitle.present?
  end

  def valid_position?(position)
    position.is_a?(Integer) && position > 0 && position <= self.children.maximum('position')
  end

  def add_child(child, position=nil)
    self.children << child unless self.children.exists?(child.id)
    move_child(child, position) unless position.nil?
    return child
  end

  def destroy_child(child)
    self.children.destroy(child.id) if self.children.exists?(child.id)
  end

  def move_child(child, position)
    return unless self.children.exists?(child.id)
    valid_position?(position) ? child.set_list_position(position) : child.move_to_bottom
  end

end