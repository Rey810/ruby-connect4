require_relative 'player'
require_relative 'board'

class Game
    attr_accessor :board, :player1, :player2

    def initialize
        @board = Board.new
        @player1 = Player.new
        @player2 = Player.new
        @player1.colour = "blue"
        @player2.colour = "red"
        @current_player = @player1
    end

    def play
        clear_screen
        welcome_message
        get_player_names
        loop do
            clear_screen
            colour_message
            if @board.board_full?
                @board.print_board
                draw_message
                break
            end
            @board.print_board
            instruct_player
            get_move
            @board.place_piece(@move, @current_player)
            if @board.winner?(@current_player)
                clear_screen
                @board.print_board
                winner_message
                return
            end            
            switch_players
        end
    end

    def clear_screen 
        system("clear")
    end

    def welcome_message
        puts "Welcome to Connect4. Please enter your names below"
        puts
    end

    def get_player_names
        puts "Player 1: "
        @player1.name = gets.chomp
        puts
        puts "Player 2: "
        @player2.name = gets.chomp
        puts
    end

    def colour_message 
        puts "#{@player1.name} is #{@player1.colour}."
        puts "#{@player2.name} is #{@player2.colour}"
        puts "Let's play!"
        puts
    end

    def instruct_player
        puts "#{@current_player.name}, please choose your column"
    end

    def get_move
        @move = gets.chomp.to_i
        if @board.col_check?(@move)
            @move
        end
    end

    def winner_message
        puts "Congratulations, #{@current_player.name}! You've won!"
    end

    def switch_players
        @current_player == @player1 ? @current_player = @player2 : @current_player = @player1
    end

    def draw_message
        puts "#{player1.name} and #{player2.name}, you two have drawn the game!"
    end
end


x = Game.new
x.play