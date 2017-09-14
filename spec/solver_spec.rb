require 'solver'

RSpec.describe Solver, '#solution_count' do
  it 'correctly calcuates the number of solutions of a board of 4' do
    expect(Solver.new(4).solution_count).to eql 2
  end

  it 'correctly calcuates the number of solutions of a board of 5' do
    expect(Solver.new(5).solution_count).to eql 10
  end

  it 'correctly calcuates the number of solutions of a board of 6' do
    expect(Solver.new(6).solution_count).to eql 4
  end

  it 'correctly calcuates the number of solutions of a board of 7' do
    expect(Solver.new(7).solution_count).to eql 40
  end

  it 'correctly calcuates the number of solutions of a board of 8' do
    expect(Solver.new(8).solution_count).to eql 92
  end
end
