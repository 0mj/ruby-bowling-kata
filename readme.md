Refactored to mimic real bowling score card.



### 1 Create Test Class and Require 
Create new test file `game_test.rb` and add following code and save.
```ruby
require 'minitest/autorun'

class GameTest < Minitest::Test
end
```



### 2: Create Game class file
Create `Game` class file in lib directory `lib/game.rb`
```ruby
class Game
end
```



### 3 RED Instantiate Game
Attempt to instantiate the Game class from you test file and run it.  
Add the following test to your `GameTest` class and verify it fails with "Error: `GameTest#test_game_class_exists`: NameError: uninitialized constant `GameTest::Game`"
```ruby
require 'minitest/autorun'

class GameTest < Minitest::Test
  def test_game_class_exists
    game = Game.new
  end
end
```



### 4 GREEN Create Game & Require
Create `Game` class file
```ruby
class Game
end
```
Add `require_relative` for the `Game` class in your test file  `game_test.rb` 
```ruby
require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test
  def test_game_class_exists
    game = Game.new
    assert_instance_of Game, game
  end
end
```




### 5 Refactor
Add a `setup` method to create a new instance variable of `@game` to each test.  Update `game` variable to the instance variable `@game`
```ruby
  def setup
    @game = Game.new
  end

  def test_game_class_exists
    assert_instance_of Game, @game
  end
```
        


### 6 RED Gutter Game
Add gutter game test to  `GameTest` class. Verify it fails with "  1) Error: GameTest#test_gutter_game: NoMethodError: undefined method 'roll' "
```ruby
def test_gutter_game
  20.times do 
    @game.roll(0)
  end
end
```



### 7 GREEN Add #roll Method
Add `#roll` method to the `Game` class to get passing test
```ruby
class Game
  def roll(pins)
  end
end
```


### 8 RED #score the gutter game
Add `assert_equal 0, @game.score` to the gutter game test.  Verify it fails with "Error: GameTest#test_gutter_game: NoMethodError: undefined method 'score' "
```ruby
def test_gutter_game
  20.times do 
    @game.roll(0)
  end
  assert_equal 0, @game.score
end
```



### 9 GREEN Define #score method
Define the `#score` method and simply return a zero to make the test pass.
```ruby
class Game
  def roll(pins)
  end

  def score
    0
  end
end
```



### 10 Refactor
Add `#roll_many` method to `GameTest` class.
```ruby
private
def roll_many(rolls, pins)
  rolls.times do
    @game.roll(pins)
  end
end
```
Refactor `#test_gutter_game` method replacing the `20.times .. ` loop
```ruby
def test_gutter_game
  roll_many(20,0)
end
```



### 11 RED Open Frame Bowler
Add open frame bowler test. They roll 4,3  5,3  6,1  and 14 gutters.  Should result in score of 22. Verify it fails with "`Expected: 22 Actual: 0`"
```ruby
def test_open_frame_bowler
  @game.roll(4)
  @game.roll(3)
  @game.roll(5)
  @game.roll(3)
  @game.roll(6)
  @game.roll(1)
  roll_many(14,0)
  assert_equal 22, @game.score
end
```

### 12 GREEN Sum the rolls
Adjust Game class initializing a `@rolls` array when a `Game` object is created, push (<<) `pins` into `@rolls` array within the `#roll` method and finally sum the `@rolls` array in `#score` method:
```ruby
class Game
  def initialize
    @rolls = []
  end
  def roll(pins)
    @rolls << pins
  end
  def score
    @rolls.sum
  end
end
```




### 13 Refactor
Add `#roll_frame` method to `GameTest` class.
```ruby
private
def roll_frame(roll1, roll2)
    @game.roll(roll1)
    @game.roll(roll2)
end
```
Refactor `#test_open_frame_bowler` 
```ruby
def test_open_frame_bowler
  roll_frame(4,3)
  roll_frame(5,3)
  roll_frame(6,1)
  roll_many(14,0)
  assert_equal 22, @game.score
end
```



### 14 RED Spare Test
Add `#test_spare` test method to your GameTest.  It should fail with `"Expected: 26 Actual: 19"`
```ruby
def test_spare
  roll_frame(9,1) #spare
  roll_frame(7,2)
  roll_many(16,0)
  assert_equal 26, @game.score
end
```



### 15 Still RED
Lots of refactoring to account for the spare, so let's comment out that test for now.  
Break out `#score` method to individually add each roll and add it to the result which will be the bowlers total score.
```ruby
def score
  result = 0
  roll_index = 0 

  10.times do
    result += @rolls.fetch(roll_index, 0) + @rolls.fetch(roll_index + 1,0)
    roll_index += 2
  end
  result
end
```


### 16 GREEEN Spare
We'll need to account for a bonus ball in the scoring of a spare. [9,1] + next roll.  
10 + 7 = 17  
7 + 2  = 9    
17 + 9 = 26  
Add the following spare logic to account for adding the bonus ball when a spare is rolled.
```ruby
def score
  result = 0
  roll_index = 0 

  10.times do
    result += if @rolls.fetch(roll_index, 0) + @rolls.fetch(roll_index + 1,0) == 10 #spare!
                10 + @rolls.fetch(roll_index + 2, 0)
              else
                @rolls.fetch(roll_index, 0) + @rolls.fetch(roll_index + 1,0) 
              end
    roll_index += 2
  end
  result
end
```



### 17 Refactor
replace the literal `10`'s with new constants `FRAMES` and `PINS` Constants centralize configuration and make your code more adaptable to future changes.  
create intention revealing predicate method `#spare?` moving the spare logic within it  
create `#spare_bonus` method  and move logic into it  
adjust `#score` method  calling new methods..  
```ruby
class Game
  FRAMES = 10
  PINS = 10
  def initialize
    @rolls = []
  end
  def roll(pins)
    @rolls << pins
  end
  def score
    result = 0
    roll_index = 0 

    FRAMES.times do
      result += if spare?(roll_index)
                  spare_bonus(roll_index)
                else
                  @rolls.fetch(roll_index, 0) + @rolls.fetch(roll_index + 1,0) 
                end
      roll_index += 2
    end
    result
  end

  private
  def spare?(roll_index)
    @rolls.fetch(roll_index, 0) + @rolls.fetch(roll_index + 1,0) == PINS #spare!
  end
  def spare_bonus(roll_index)
    PINS + @rolls.fetch(roll_index + 2, 0)
  end
end
```




### 18 RED Strike Test
In bowling when strike is rolled that frame score is equal to the strike + next 2 rolls (bonus balls)  
Add the following test to your GameTest class.  Ensure it fails with `"Expected: 28 Actual: 19"`
```ruby
def test_strike
  @game.roll(Game::PINS)
  roll_frame(7,2)
  roll_many(16,0)
  assert_equal 28, @game.score
end
```



### 19 GREEN strike bonus balls
Adjust the `#score` method to account for strikes AND add the next 2 rolls to 10 to get the correct score.
```ruby
def score
    result = 0
    roll_index = 0 

    FRAMES.times do
      if @rolls.fetch(roll_index, 0) == PINS #STRIKE!
        result += PINS + @rolls.fetch(roll_index + 1, 0) + @rolls.fetch(roll_index + 2, 0)
        roll_index += 1
      elsif spare?(roll_index)
        result += spare_bonus(roll_index)
        roll_index += 2
      else
        result += @rolls.fetch(roll_index, 0) + @rolls.fetch(roll_index + 1,0) 
        roll_index += 2
      end
    end
    result
  end
```




### 20 REFACTOR
create intention revealing predicate method `#strike?` moving the strike logic within it  
create `#strike_bonus` method  and move logic into it  
adjust `#score` method ..
```ruby
class Game
  FRAMES = 10
  PINS = 10
  def initialize
    @rolls = []
  end
  def roll(pins)
    @rolls << pins
  end
  def score
    result = 0
    roll_index = 0 

    FRAMES.times do
      if strike?(roll_index)
        result += strike_bonus(roll_index)
        roll_index += 1
      elsif spare?(roll_index)
        result += spare_bonus(roll_index)
        roll_index += 2
      else
        result += @rolls.fetch(roll_index, 0) + @rolls.fetch(roll_index + 1,0) 
        roll_index += 2
      end
    end
    result
  end

  private
  def strike?(roll_index)
    @rolls.fetch(roll_index, 0) == PINS #STRIKE!
  end
  def strike_bonus(roll_index)
    PINS + @rolls.fetch(roll_index + 1, 0) + @rolls.fetch(roll_index + 2, 0)
  end
  def spare?(roll_index)
    @rolls.fetch(roll_index, 0) + @rolls.fetch(roll_index + 1,0) == PINS #spare!
  end
  def spare_bonus(roll_index)
    PINS + @rolls.fetch(roll_index + 2, 0)
  end
end
```



### 21 GREEN Perfect Game
Add following perfect game test and verify it passes.  
```ruby
def test_perfect_game
  roll_many(12, Game::PINS)
  assert_equal 300, @game.score
end
```

