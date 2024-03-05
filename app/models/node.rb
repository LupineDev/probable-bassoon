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
        root_id: common_ancestors.last,
        lowest_common_ancestor: common_ancestors.first,
        depth: common_ancestors.length
      }
    end

    return result
  end

  class BootstrapParadoxError < StandardError
  end

  def ancestor_ids
    id_conditional = self.class.sanitize_sql_for_conditions(['id=?',id])
    sql_string = <<-SQL
    WITH RECURSIVE ancestors AS (
        SELECT id, parent_id
        FROM nodes
        WHERE #{id_conditional}
      UNION
        SELECT nodes.id, nodes.parent_id
        FROM nodes
          JOIN ancestors ON nodes.id = ancestors.parent_id
    )
    SELECT id FROM ancestors;
    SQL

    query_result = self.class.connection.execute(sql_string)
    ids = query_result.to_a.map(&:values).flatten
    validate_root(ids.last)
  
    return ids
  end

  private

  def validate_root(root_id)
    # If the node we beleive is root has a parent, this is a circlular reference
    raise BootstrapParadoxError if !Node.exists?(id: root_id, parent_id: nil)
  end
end
