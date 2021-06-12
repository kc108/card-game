require 'pry'

class Player 
    attr_reader :name
    attr_accessor :bankroll, :hand

    def initialize(name, bankroll, hand)
        #instance variables
        @name = name
        @bankroll = bankroll
        @hand = hand
    end

    def card_sum 
        sum = 0
        hand.each do |card|
            sum += card.value  
        end 
        return sum 
    end

    def display_hand
        hand.each do |card|
            puts(card.value)
        end
        return
    end
end

# CARDS
class Card
    attr_reader :value

    def initialize(value)
        @value = value
    end
end

class BlackJack
    attr_accessor :player, :the_house, :option, :bet_size, :deck, :winner

    def initialize(player, the_house)
        @player = player
        @the_house = the_house
        @option = "d"
        @bet_size = 10
        @deck = []
    end

    def play
        reset_deck
        while option != "q"
            puts "----------------------------------------------------------------------------"
            if deck.length < 4
                reset_deck
            end
            deal_cards
            get_winner
            update_bankroll
            display_winner
            display_bankrolls
            broke = anyone_broke?
            if broke
                break
            end
            display_menu
        end
    end

    private

    def reset_deck
        self.deck = []
        card_values = ((2..11).to_a + Array.new(3, 10)) * 4
        card_values.each do |value|
            self.deck << Card.new(value)
        end
    end

    def deal_cards
        self.player.hand = [deck.shuffle.pop, deck.shuffle.pop]
        self.the_house.hand = [deck.shuffle.pop, deck.shuffle.pop]
    end

    def display_menu
        self.option = "b"
        while option == "b" do
            puts ("choose (d)eal, (q)uit, (b)ankroll or (u)pdate bet")
            self.option = gets.chomp

            if self.option == "b"
                puts "You have $#{player.bankroll}"
            elsif self.option == "u"
                puts("How much money would you like to bet?")
                self.bet_size = gets.chomp.to_i
            end
        end
    end

    def display_bankrolls
        puts "You have $#{player.bankroll}"
        puts "The house has $#{the_house.bankroll}"
    end

    def anyone_broke?
        if player.bankroll <= 0 
            puts("You're broke!!")
            return true
        elsif the_house.bankroll <= 0
            puts("The house is broke!!")
            return true
        end
        return false
    end

    def player_won?
        winner == player
    end

    def the_house_won?
        winner == the_house
    end

    def display_winner
        if player_won?
            puts "You won, Good job! Your total card value is #{player.card_sum} and the house total card value is #{the_house.card_sum}."
        elsif the_house_won? 
            puts "You lost, better luck next time! Your total card value is #{player.card_sum} and the house total card value is #{the_house.card_sum}."
        else
            puts "It was a tie! You both have #{player.card_sum}."
        end
    end

    def update_bankroll
        if player_won?
            self.player.bankroll = player.bankroll + bet_size
            self.the_house.bankroll = the_house.bankroll - bet_size
        elsif the_house_won?
            self.the_house.bankroll = the_house.bankroll + bet_size
            self.player.bankroll = player.bankroll - bet_size
        end
    end

    def get_winner
        if player.card_sum <= 21 && the_house.card_sum <= 21
            if player.card_sum > the_house.card_sum
                self. winner = player
            elsif player.card_sum < the_house.card_sum
                self.winner = the_house
            else 
                self.winner = nil
            end
        elsif player.card_sum == 21 || the_house.card_sum == 21
            if player.card_sum == the_house.card_sum
                self.winner = nil
            elsif player.card_sum == 21 
                self.winner = player
            else 
                self.winner = the_house
            end
        else
            self.winner = the_house
        end
    end
end

# GETTING STARTED
puts("Welcome to BlackJack")
puts("What is your name?")
name = gets.chomp

# create person object
player = Player.new(name, 100, [])

# create house object
the_house = Player.new("the_house", 10000, [])

BlackJack.new(player, the_house).play