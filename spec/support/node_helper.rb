def seed_test_nodes
  Node.insert_all([
    {id: 125, parent_id: 130},
    {id: 130, parent_id: nil},
    {id: 2820230, parent_id: 125},
    {id: 4430546, parent_id: 125},
    {id: 5497637, parent_id: 4430546},
    # Separate root
    {id: 9, parent_id: nil},
    # Circlular Tree
    {id: 1234, parent_id: 12345},
    {id: 12345, parent_id: 123456},
    {id: 123456, parent_id: 1234},
  ])
end
