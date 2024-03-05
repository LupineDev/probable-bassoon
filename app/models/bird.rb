class Bird < ApplicationRecord
  belongs_to :node

  def self.ids_on_branches(node_ids)
    id_conditional = sanitize_sql_for_conditions(['id IN (?)', node_ids])
    sql_string = <<-SQL
    WITH RECURSIVE descendants AS (
        SELECT id, parent_id
        FROM nodes
        WHERE #{id_conditional}
      UNION
        SELECT nodes.id, nodes.parent_id
        FROM nodes
          JOIN descendants ON nodes.parent_id = descendants.id
    )
    SELECT birds.id FROM descendants JOIN birds on descendants.id = birds.node_id;
    SQL

    query_result = connection.execute(sql_string)
    ids = query_result.to_a.map(&:values).flatten
  
    return ids
  end
end
