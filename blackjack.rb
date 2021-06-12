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
    end
end

# stops the code execution at this point
#binding.pry

# do not need, has same code as 'player' class
# class TheHouse
#     attr_reader :name
#     attr_accessor :bankroll, :hand

#     def initialize(name, bankroll, hand)
#         @name = name
#         @bankroll = bankroll
#         @hand = hand
#     end
# end


# THE DECK
deck = []

# CARDS
class Card
    attr_reader :value

    def initialize(value)
        @value = value
    end
end

# 4 sets of 13
first_set = [deck.shuffle.pop, deck.shuffle.pop]
second_set = [deck.shuffle.pop, deck.shuffle.pop]
third_set = [deck.shuffle.pop, deck.shuffle.pop]
fourth_set = [deck.shuffle.pop, deck.shuffle.pop]

# CARD PROPERTIES
# why we used attr_reader instead of attr_accessor

# SHUFFLE DECK
deck = deck.shuffle

# GETTING STARTED
puts("Welcome to BlackJack")
puts("What is your name?")
name = gets.chomp

# create person object
player = Player.new(name, 100, [])
puts "You have $#{player.bankroll}"

# create house object
the_house = Player.new("the_house", 10000, [])

option = "d"
bet_size = 10

# getting loopy 
while option != "q" do 

 if deck.length < 4
    deck = []
    # add the other cards on own
    ace = Card.new(11)
    deck << ace

    jack = Card.new(10)
    deck << jack
    queen = Card.new(10)
    deck << queen
    king = Card.new(10)
    deck << king

    two = Card.new(2)
    deck << two
    three = Card.new(3)
    deck << three
    four = Card.new(4)
    deck << four
    five = Card.new(5)
    deck << five
    six = Card.new(6)
    deck << six
    seven = Card.new(7)
    deck << seven
    eight = Card.new(8)
    deck << eight
    nine = Card.new(9)
    deck << nine
    ten = Card.new(10)
    deck << ten
end

    # each player gets 2 random cards
    player.hand = [deck.shuffle.pop, deck.shuffle.pop]
    the_house.hand = [deck.shuffle.pop, deck.shuffle.pop]

    # player with the larger sum of their two cards wins the round
    # enter what cards the house
   

    if player.card_sum <= 21 && the_house.card_sum <= 21
        if player.card_sum > the_house.card_sum
            puts("You won! #{player.display_hand}")
            player.bankroll = player.bankroll + bet_size
            the_house.bankroll = the_house.bankroll - bet_size
        elsif player.card_sum < the_house.card_sum
            puts("The house won! #{the_house.display_hand}")
            the_house.bankroll = the_house.bankroll + bet_size
            player.bankroll = player.bankroll - bet_size
        else 
            puts("It's a tie.")
        end
    elsif player.card_sum == 21 || the_house.card_sum == 21
        if player.card_sum == the_house.card_sum
            puts("It's a tie")
        elsif player.card_sum == 21 
            puts("You won! #{player.display_hand}")
            player.bankroll = player.bankroll + bet_size
            the_house.bankroll = the_house.bankroll - bet_size
        else 
            puts("The house won!")
            the_house.bankroll = the_house.bankroll + bet_size
            player.bankroll = player.bankroll - bet_size
        end
    else
        puts("The house won!")
        the_house.bankroll = the_house.bankroll + bet_size
        player.bankroll = player.bankroll - bet_size
    end

    puts "You have #{player.bankroll}"
    puts "The house has #{the_house.bankroll}"

    if player.bankroll <= 0 
        puts("You're broke!!")
        break
    elsif the_house.bankroll <= 0
        puts("The house is broke!!")
        break
    end

option = "b"

    while option == "b" do
        puts ("choose (d)eal, (q)uit, (b)ankroll or (u)pdate bet")
        option = gets.chomp

        if option == "b"
            puts "You have #{player.bankroll}"
        elsif option == "u"
            puts("How much money would you like to bet?")
            bet_size = gets.chomp.to_i
        end
    end
end