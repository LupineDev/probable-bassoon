class Node < ApplicationRecord
  belongs_to :parent, class_name: 'Node', optional: true
  has_many :children, class_name: 'Node', inverse_of: :parent
  has_many :birds, dependent: :destroy, inverse_of: :node

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

  def self.descendant_ids(ids)
    id_list = ids.dup
    return id_list if id_list.empty?

    next_generation_ids = where(parent_id: id_list).ids

    while next_generation_ids.present? do
      id_list = (id_list + next_generation_ids).uniq
      next_generation_ids = where(parent_id: next_generation_ids).ids
      # don't search ids we already found in the next generation
      # to avoid infinite loops
      next_generation_ids -= id_list
    end

    return id_list
  end

  class BootstrapParadoxError < StandardError
  end

  def ancestor_ids
    ids = [id]

    next_ancestor = parent
    while next_ancestor do
      ids.prepend next_ancestor.id
      next_ancestor = next_ancestor.parent
      if ids.count != ids.uniq.count
        raise BootstrapParadoxError.new("The following nodes have circular ancestory: #{ids}")
      end
    end

    return ids
  end

end
