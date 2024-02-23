def seed_test_nodes
  Node.create(id: 125, parent_id: 130)
  Node.create(id: 130)
  Node.create(id: 2820230, parent_id: 125)
  Node.create(id: 4430546, parent_id: 125)
  Node.create(id: 5497637, parent_id: 4430546)
end
