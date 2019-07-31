require './lib/player'

describe Player do
    it "the player has a name" do
        player1 = Player.new
        player1.name = "Rey"
        expect(player1.name).to eql("Rey")
    end
end