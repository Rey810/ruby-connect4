require './lib/board'

describe Board do
    context "creates a board with a 7x6 grid" do
        it "creates a board of length 7 (columns)" do
            board = Board.new
            expect(board.grid.length).to eql(7)
        end

        it "creates a board of breadth 6 (rows)" do
            board = Board.new
            board.grid.each do |row|
                expect(row.length).to eql(6)
            end
        end
    end

    context "board cells should be nil or contain a game piece" do
        describe "nothing is added to cells" do   
            it "all cells are nil" do
                board = Board.new
                expect(board.grid[2][3]).to eql(nil)
                expect(board.grid[0][0]).to eql(nil)
            end
        end

        describe "put a piece into column 1 - 7" do
            describe "#place_piece" do
                it "cells contain a game piece" do
                    board = Board.new 
                    object = double("object")                   #a double creates a fake object that can be used as an example object
                    board.place_piece(1, object)
                    expect(board.grid[0][0]).to eql(object)
                    expect(board.grid[0][1]).to eql(nil)
                end

                it "places piece in second row when first row is occupied" do
                    board = Board.new
                    object = double("object")
                    board.place_piece(1, object)
                    board.place_piece(1, object)
                    expect(board.grid[0][0]).to eql(object)
                    expect(board.grid[0][1]).to eql(object)
                end

                it "places a piece in the last column" do
                    board = Board.new
                    object = double("object")
                    board.place_piece(7, object)
                    expect(board.grid[6][0]).to eql(object)
                end

                it "places a piece in the last row" do
                    board = Board.new
                    object = double("object") 
                    6.times do 
                        board.place_piece(1, object)
                    end
                    expect(board.grid[0][5]).to eql(object)
                end
            end
        end
    end

    context "#winner?" do
=begin
        describe 'initial tests run at onset of method building. Should be red now' do
            it 'an object has been found in the grid' do
                board = Board.new
                object = double("object")
                board.place_piece(1, object)
                expect(board.winner?(object)).to eql(true)
            end

            it 'returns true if the colour of the object is returned' do
                board = Board.new
                object = double("object", :colour => "blue")
                board.place_piece(1, object)
                expect(board.winner?(object)).to eql("blue")
            end
        end
=end
        describe 'the various ways of winning' do
            it 'checks for 4 consecutively vertically to win' do
                board = Board.new
                object = double("object", :colour => "blue")
                board.place_piece(1, object)
                board.place_piece(1, object)
                board.place_piece(1, object)
                board.place_piece(1, object)
                expect(board.vertical_check(0, 3, "blue")).to eql(true)
            end

            it 'a vertical winner can be found' do
                board = Board.new
                object = double("object", :colour => "blue") 
                board.place_piece(1, object)
                board.place_piece(1, object)
                board.place_piece(1, object)
                board.place_piece(1, object)
                expect(board.winner?(object)).to eql(true)
            end

            it 'a false positive vertical winner is accounted for' do
                board = Board.new
                object = double("object", :colour => "blue") 
                board.place_piece(1, object)
                board.place_piece(1, object)
                expect(board.vertical_check(0, 3, "blue")).to eql(false)
                expect(board.winner?(object)).to eql(false)
            end

            it 'checks for 4 consecutively vertically blue with red on the board' do
                board = Board.new
                blue_object = double("object", :colour => "blue")
                red_object = double("object", :colour => "red")
                4.times do 
                    board.place_piece(1, blue_object)
                end
                4.times do 
                    board.place_piece(2, red_object)
                end
                expect(board.vertical_check(0, 3, "blue")).to eql(true)
            end

            it 'checks for 4 consecutively vertically blue with red on the same column' do
                board = Board.new
                blue_object = double("object", :colour => "blue")
                red_object = double("object", :colour => "red")
                2.times do 
                    board.place_piece(1, blue_object)
                end
                2.times do 
                    board.place_piece(1, red_object)
                end
                4.times do 
                    board.place_piece(1, blue_object)
                end
                expect(board.vertical_check(0, 7, "blue")).to eql(true)
            end

            it 'ensures correct colour won vertically' do
                board = Board.new
                blue_object = double("object", :colour => "blue")
                red_object = double("object", :colour => "red")
                4.times do 
                    board.place_piece(1, blue_object)
                end
                4.times do 
                    board.place_piece(2, red_object)
                end
                expect(board.vertical_check(0, 3, "blue")).to eql(true)
                expect(board.vertical_check(0, 0, "red")).to eql(false)
            end

            it 'checks for 4 consecutively horizontally to win' do
                board = Board.new
                object = double("object", :colour => "blue")
                board.place_piece(1, object)
                board.place_piece(2, object)
                board.place_piece(3, object)
                board.place_piece(4, object)
                expect(board.horizontal_check(0, 0, "blue")).to eql(true)
            end

            it 'a horizontal winner can be found' do
                board = Board.new
                object = double("object", :colour => "blue")
                board.place_piece(1, object)
                board.place_piece(2, object)
                board.place_piece(3, object)
                board.place_piece(4, object)
                expect(board.winner?(object)).to eql(true)
            end

            it 'checks for 4 consecutively horizontally blue with red on board' do
              board = Board.new
                blue_object = double("object", :colour => "blue")
                red_object = double("object", :colour => "red")
                board.place_piece(1, blue_object)
                board.place_piece(2, blue_object)
                board.place_piece(3, red_object)
                board.place_piece(4, blue_object)
                board.place_piece(5, blue_object)
                board.place_piece(6, blue_object)
                board.place_piece(7, blue_object)

                expect(board.horizontal_check(6, 0, "blue")).to eql(true)
            end

            it 'checks for 4 consecutively horizontally blue with red on same row' do
              board = Board.new
                blue_object = double("object", :colour => "blue")
                red_object = double("object", :colour => "red")
                board.place_piece(1, blue_object)
                board.place_piece(2, blue_object)
                board.place_piece(3, blue_object)
                board.place_piece(4, blue_object)

                board.place_piece(1, red_object)
                board.place_piece(2, red_object)
                board.place_piece(3, red_object)
                board.place_piece(4, red_object)
                expect(board.horizontal_check(0, 0, "blue")).to eql(true)
            end  

            it 'ensures correct colour won horizontally' do
                board = Board.new
                blue_object = double("object", :colour => "blue")
                red_object = double("object", :colour => "red")
                board.place_piece(1, blue_object)
                board.place_piece(2, blue_object)
                board.place_piece(3, blue_object)
                board.place_piece(4, blue_object)

                board.place_piece(1, red_object)
                board.place_piece(2, red_object)
                board.place_piece(3, red_object)
                board.place_piece(4, red_object)

                expect(board.horizontal_check(0, 0, "blue")).to eql(true)
                expect(board.horizontal_check(0, 0, "red")).to eql(false)
            end  

            it 'checks 4 consecutively diagonal left blue win' do
                board = Board.new
                blue_object = double("object", :colour => "blue")
                red_object = double("object", :colour => "red")

                board.place_piece(1, blue_object)
                board.place_piece(2, red_object)
                board.place_piece(2, blue_object)
                board.place_piece(3, red_object)
                board.place_piece(3, red_object)
                board.place_piece(3, blue_object)
                board.place_piece(4, red_object)
                board.place_piece(4, red_object)
                board.place_piece(4, red_object)
                board.place_piece(4, blue_object)

                expect(board.diagonal_left(3, 3, "blue")).to eql(true)
            end

            it 'checks 4 consecutively diagonal left blue win, above and below' do
                board = Board.new
                blue_object = double("object", :colour => "blue")
                red_object = double("object", :colour => "red")

                board.place_piece(1, blue_object)
                board.place_piece(2, red_object)
                board.place_piece(2, blue_object)
                board.place_piece(3, red_object)
                board.place_piece(3, red_object)
                board.place_piece(3, blue_object)
                board.place_piece(4, red_object)
                board.place_piece(4, red_object)
                board.place_piece(4, red_object)
                board.place_piece(4, blue_object)

                expect(board.diagonal_left(2, 2, "blue")).to eql(true)
            end

            it 'checks 4 consecutively diagonal right blue win' do
                board = Board.new
                blue_object = double("object", :colour => "blue")
                red_object = double("object", :colour => "red")

                board.place_piece(1, red_object)
                board.place_piece(1, red_object)
                board.place_piece(1, red_object)
                board.place_piece(2, red_object)
                board.place_piece(2, red_object)
                board.place_piece(2, blue_object)
                board.place_piece(3, red_object)
                board.place_piece(3, blue_object)
                board.place_piece(4, blue_object)
                board.place_piece(1, blue_object)


                expect(board.diagonal_right(0, 3, "blue")).to eql(true)
            end

            it 'checks 4 consecutively diagonal right blue win, above and below' do
                board = Board.new
                blue_object = double("object", :colour => "blue")
                red_object = double("object", :colour => "red")

                board.place_piece(1, red_object)
                board.place_piece(1, red_object)
                board.place_piece(1, red_object)
                board.place_piece(1, blue_object)
                board.place_piece(2, red_object)
                board.place_piece(2, red_object)
                board.place_piece(3, red_object)
                board.place_piece(3, blue_object)
                board.place_piece(4, blue_object)
                board.place_piece(2, blue_object)

                expect(board.diagonal_right(1, 2, "blue")).to eql(true)
            end

            it 'a piece can win diagonally left' do
                board = Board.new
                blue_object = double("object", :colour => "blue")
                red_object = double("object", :colour => "red")


                board.place_piece(2, red_object)
                board.place_piece(2, blue_object)
                board.place_piece(3, red_object)
                board.place_piece(3, red_object)
                board.place_piece(3, blue_object)
                board.place_piece(4, red_object)
                board.place_piece(4, red_object)
                board.place_piece(4, red_object)
                board.place_piece(4, blue_object)
                board.place_piece(1, blue_object)

                expect(board.winner?(blue_object)).to eql(true)
            end

            

        end
    end
    context 'checks for a draw' do 
        it 'is able to tell if the board is full' do
            board = Board.new
            object = double("object")

            7.times do |col|
                6.times do |row|
                    board.place_piece(col+1, object)
                end
            end

            expect(board.board_full?).to eql(true)
        end
    end
end
