def seed_test_birds
  Bird.insert_all([
    {id: 1, node_id: 130},
    {id: 2, node_id: 130},
    {id: 3, node_id: 125},
    {id: 4, node_id: 4430546},
    {id: 5, node_id: 5497637},
    # Separate root
    {id: 6, node_id: 9},
    # Circlular Tree
    {id: 7, node_id: 1234},
    {id: 8, node_id: 12345},
    {id: 9, node_id: 123456},
  ])
end
