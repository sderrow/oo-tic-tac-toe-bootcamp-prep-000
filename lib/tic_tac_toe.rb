class TicTacToe
  def initialize
    @board = [" "] * 9
  end

  WIN_COMBINATIONS = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6]
  ]

  def display_board
    puts " #{@board[0]} | #{@board[1]} | #{@board[2]} "
    puts "-----------"
    puts " #{@board[3]} | #{@board[4]} | #{@board[5]} "
    puts "-----------"
    puts " #{@board[6]} | #{@board[7]} | #{@board[8]} "
  end

  def input_to_index(user_input)
    user_input.to_i - 1
  end

  def move(index, current_player="X")
    @board[index] = current_player
  end

  def position_taken?(index)
    !(@board[index].nil? || @board[index] == " ")
  end

  def turn
    puts "Please enter 1-9:"
    input = gets.strip
    index = self.input_to_index(input)
    if self.valid_move?(index)
      self.move(index, self.current_player)
      self.display_board()
    else
      turn(board)
    end
  end
  
end

def won?(board)
  WIN_COMBINATIONS.detect do |combo|
    combo.all? { |i| board[i] == "X" } || combo.all? { |i| board[i] == "O" }
  end
end

def full?(board)
  board.all? { |x| !(x.nil? || x == " ") }
end

def draw?(board)
  full?(board) && !won?(board)
end

def over?(board)
  draw?(board) || won?(board)
end

def winner(board)
  winning = won?(board)
  if winning
    board[winning[0]]
  end
end

def turn_count(board)
  (board.collect { |x| x == " " ? 0 : 1 }).inject(:+)
end

def current_player(board)
  turn_count(board) % 2 == 0 ? "X" : "O"
end

def valid_move?(board, index)
  index.between?(0,8) && !position_taken?(board, index)
end

def play(board)
  until over?(board)
    turn(board)
  end
  if won?(board)
    puts "Congratulations #{winner(board)}!"
  else
    puts "Cat's Game!"
  end
end
