class Node < ApplicationRecord
  belongs_to :parent, class_name: 'Node', optional: true
  has_many :children, class_name: 'Node', inverse_of: :parent

  def self.lowest_common_ancestor(a, b)
  end

  def ancestor_ids
    return [] if parent_id.nil?

    ids = []
    next_ancestor = parent
    while next_ancestor do
      ids.prepend next_ancestor.id
      next_ancestor = next_ancestor.parent
    end

    ids
  end
end
