class Hangman
    attr_accessor :word, :lives, :word_teaser

    def initialize
        @word = words.sample
        @lives = 6
        @word_teaser = ""
        @word.first.size.times do
            @word_teaser += "_ "
        end
    end

    def words
        [
            ["basketball", "A game played by gentlemen"],
            ["crawling", "We are not walking..."],
            ["eureka", "Remembering special moments"],
            ["continents", "There are 7 of these"],
            ["potato", "not an onion"]
        ]
    end

    def print_teaser last_guess = nil

        update_teaser(last_guess) unless last_guess.nil?
        puts @word_teaser
    end

    def incorrect_guesses
        @word_teaser.split(' ').count("_")
        
    end

    def update_teaser last_guess
        new_teaser = @word_teaser.split

        new_teaser.each_with_index do |letter, index|
            if letter == '_' && @word.first[index] == last_guess
                new_teaser[index] = last_guess
            end
        end
        @word_teaser = new_teaser.join(' ')
    end


    def make_guess(guess)
        guess = guess.downcase

        if @lives > 0
            good_guess = @word.first.include? guess
    
            if guess == "exit"
                puts "Thank you for playing!"
            elsif good_guess
                puts "You are correct!"
                print_teaser guess
    
                if @word.first == @word_teaser.split.join
                    puts "Congratulations... you have won this round!"
                else
                    make_guess
                end
            else
                @lives -= 1
             
                puts "Sorry... you have #{@lives} lives left"
                make_guess if @lives > 0
            end
        else
            puts "Game over... better luck next time!"
        end
    end


    def begin
        puts "Welcome to Hangman!"
        puts "You have 7 lives to start with"
        puts "hint: #{@word.last}"
        print_teaser
        make_guess
    end
    def word
        @word
    end
    def lives
        @lives
    end
    def word_teaser
        @word_teaser
    end

    def won?    
        if @word.first == @word_teaser.split.join
            return true
        else
            return false
        end
    end

    def lost?
        @lives == 0
    end
    
end
