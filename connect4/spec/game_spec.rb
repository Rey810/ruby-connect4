require './lib/game'

describe Game do
    context "a new game starts" do
        game = Game.new
        game.player1.name = "Rey"
        game.player2.name = "Bob"
        
        it "results in two players being created" do
            expect(game.player1.name).to eql("Rey")
            expect(game.player2.name).to eql("Bob")
        end

        it "each player has a set colour" do
            expect(game.player1.colour).to eql("blue")
            expect(game.player2.colour).to eql("red")
        end
    end

 #   context "the sequence of play commences" do
 #       it 
end