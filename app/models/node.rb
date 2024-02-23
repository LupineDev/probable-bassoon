class Node < ApplicationRecord
  belongs_to :parent, class_name: 'Node', optional: true
  has_many :children, class_name: 'Node', inverse_of: :parent

  NOT_FOUND = {root_id: nil, lowest_common_ancestor: nil, depth: nil}

  def self.lowest_common_ancestor(id_a, id_b)
    node_a = find_by(id: id_a)
    node_b = find_by(id: id_b)
    if node_a.nil? || node_b.nil?
      return NOT_FOUND
    end

    common_ancestors = node_a.ancestor_ids.intersection(node_b.ancestor_ids)
    if common_ancestors.empty?
      result = NOT_FOUND
    else
      result = {
        root_id: common_ancestors.first,
        lowest_common_ancestor: common_ancestors.last,
        depth: common_ancestors.length
      }
    end

    return result
  end

  def ancestor_ids
    ids = [id]

    next_ancestor = parent
    while next_ancestor do
      ids.prepend next_ancestor.id
      next_ancestor = next_ancestor.parent
    end

    return ids
  end
end
