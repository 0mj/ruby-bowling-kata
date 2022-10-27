#### grind it into your brain
2022-10-25--042  
:+1: 2022-10-06--041   
:+1: 2022-09-22--040  
:+1: 2022-09-12--039  [.......](https://gist.github.com/0mj/663e782ce5d55d48bbfc63dc9c28e3f5)  
:+1: 2022-09-05--038  
:+1: 2022-08-25--037  
:+1: 2022-08-08--035  
:+1: 2022-08-05--035  
:+1: 2022-07-29--034  
:+1: 2022-07-15--033  
:+1: 2022-07-15--032  
:+1: 2022-07-08--031  
:+1: 2022-06-28--030  
:+1: 2022-06-22--029  
:+1: 2022-06-14--028  
:+1: 2022-06-07--027  
:+1: 2022-06-02--026  
:+1: 2022-05-23--025  
:+1: 2022-05-10--024  
:+1: 2022-05-09--023  
:+1: 2022-05-02--022  
:+1: 2022-04-26--021  
:+1: 2022-04-21--020  
:+1: 2022-04-18--019  
:+1: 2022-04-14--018 :usa:  
![Just Start](https://media.giphy.com/media/wi8Ez1mwRcKGI/giphy.gif "DO IT")  
:+1: 2022-04-11--017 :usa:  
:+1: 2022-04-07--016 :uk:   
:+1: 2022-04-05--015 :uk:   
:+1: 2022-03-27--014  
:+1: 2022-03-24--013  
:+1: 2022-03-21--012  
:+1: 2022-03-18--011  
:+1: 2022-03-17--010  
:+1: 2022-03-16--009  
:+1: 2022-03-15--008  
:+1: 2022-03-14--007  
:+1: 2022-03-11--006  
:+1: 2022-03-09--005  
:+1: 2022-03-09--004  


# The Ruby Bowling Kata Steps

[Instructions](https://gist.github.com/theotherzach/1ddc1f348d1c711ea0e8da67efa82cf4)  

#### Creating Directory & Open

+ Delete the directory from your previous kata run. Probably `cd ~/ && rm -rf ~/code/ruby-bowling-kata` or `rm -rf .rubocop.yml .ruby-version Gemfile Gemfile.lock lib spec`       
+ Re-create the directory. I suggest `mkdir -p ~/code/ruby-bowling-kata`
+ cd (change directory) into your project root. Probably `cd ~/code/ruby-bowling-kata`
+ Open the directory as a project in your editor of choice. `code .`

  

#### Project Setup
+ Create the file *.ruby-version* `touch .ruby-version` append the following, save & close
  ```
  2.6.6
  ```  


+ We'll be using `bundler` to manage our dependencies, so run `gem install bundler && bundle init` and then append the following to the *Gemfile*
  ```ruby
  group :test do
    gem "rspec", "3.9.0"
    gem "rubocop", "0.92.0"
  end
  ```
+ Install project dependencies:  `bundle install`  
+ Initialize rubocop: `bundle exec rubocop --init` Open *.ruobcop.yml* and append the following, save and close.
  ```ruby
  AllCops:
    NewCops: enable

  Style/StringLiterals:
    EnforcedStyle: double_quotes
  ```

+ Create *lib* and *spec* directories `mkdir lib spec`  
+ Make *.keep* files for commiting empty directories. `touch lib/.keep spec/.keep`  
+ Run rubocop with autocorrect: `bundle exec rubocop -A` Manually correct any outstanding issues.  
  
## The Code

### Workflow
+ Run your specs: `bundle exec rspec`
+ Run rubocop: `bundle exec rubocop -A`
+ Lint & Commit your code after each test

### Test 0: Create The Files
**RED**

+ Create the file *spec/game_spec.rb* `touch spec/game_spec.rb` & add the following
  ```ruby
  RSpec.describe Game do
  end
  ```

+ Verify specs is red (failing) because it doesn't know what a Game is
+ Create *lib/game.rb* `touch lib/game.rb` & add the following
  ```ruby
  class Game
  end
  ```
+ Run rubocop `bundle exec rubocop -A`  

**GREEN**
+ Update *spec/game_spec.rb* so it looks like this..
  ```ruby
  # frozen_string_literal: true

  require_relative "../lib/game/"

  RSpec.describe Game do
  end
  ```
+ Run your specs & verify 0 examples, 0 failures `bundle exec rspec`  


### Test 1: Gutter Game
**RED**

* Add the following test and verify that it fails with a `undefined method 'roll'`

**GREEN**

* Add the following to *game.rb* & verify that the test suite is green again
  ```ruby
  # frozen_string_literal: true

  class Game
    def roll(pins)
    end
  end
  ```

**RED**

* Add `expect(game.score).to eq(0)` to *game_spec.rb* & verify that it fails with a `undefined method 'score'`
  ```ruby
  # frozen_string_literal: true

  require_relative "../lib/game"
  RSpec.describe Game do
    it "20 rolls of 0 must score 0" do
      game = Game.new
      20.times do
        game.roll(0)
      end
      expect(game.score).to eq(0)
    end
  end
  ```

**GREEN**

* Update *game.rbo* & validate that the test passes.
  ```ruby
  # frozen_string_literal: true

  class Game
    def roll(pins); end

    def score
      0
    end
  end
  ```


### Test 2: 10 gutter balls & 10 rolls of 1
* Add the following spec and verify that it fails with `expected: 10 got: 0`
  * <img width="628" alt="Screen Shot 2020-09-25 at 2 10 35 PM" src="https://user-images.githubusercontent.com/1697198/94306717-12b08b00-ff39-11ea-991c-24d76a9fe2ff.png">

