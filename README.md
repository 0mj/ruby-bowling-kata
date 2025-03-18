# The Ruby Bowling Kata

[The Ruby Bowling Kata](http://butunclebob.com/ArticleS.UncleBob.TheBowlingGameKata) is based on the original Bowling Game Kata created by Robert C. Martin, also known as "Uncle Bob." He introduced this kata as a practice exercise for developers to improve their skills in Test-Driven Development (TDD) and object-oriented design.  

#### Creating Directory & Open

**Remove previous practice**
+ `Remove-Item -Recurse -Force -Path "ruby-bowling-kata"` (Powershell)  
+ `rm -rf ruby-bowling-kata`(Bash)  
**Create directory.**  
`New-Item -ItemType Directory -Path "ruby-bowling-kata" -Force`  
+ `mkdir ruby-bowling-kata`(Bash)  
 
+ Change directory and create *spec* directory   
`cd ruby-bowling-kata`  
 
`New-Item -ItemType Directory -Path "spec" -Force`  
or  
`mkdir spec`(Bash)  

+ Open the directory as a project in your editor of choice. `code .` (Bash & Powershell)

#### Project Setup & Code Workflow
+ Run tests: `ruby spec/game_test.rb` (powershell)
+ Lint & Commit your code after each test ( native ruby linter? )

## Test 0: Create The Files
**RED**

+ Inside *ruby-bowling-kata* directory create file *spec/game_test.rb*  
`New-Item -ItemType File -Path "spec\game_test.rb" -Force`(powershell)    
or `touch spec/game_test.rb`(Bash)  
& add the following method `test_game_class_exists` to verify your test sees the `Game` class.
```ruby
require "MiniTest/autorun"

class TestGame < Minitest::Test

  def test_game_class_exists
    game = Game.new
    assert_instance_of Game, game
  end

end
```

+ Verify spec(test) is failing because it doesn't know what a Game is  
`ruby spec/game_test.rb`  
+ Create *lib* directory  
Within and *ruby-bowling-kata* create new *lib* directory  
`New-Item -ItemType Directory -Path "lib" -Force`  
or 
`mkdir lib`(Bash) 

+ Create *lib/game.rb*  
`New-Item -ItemType File -Path "lib/game.rb" -Force`  
or
`touch lib/game.rb`  
& add the following to *game.rb*
```ruby
class Game
end
```

**GREEN**
+ Update *spec/game_test.rb* with `require_relative '../lib/game'` ..
```ruby
require_relative "../lib/game"
require "minitest/autorun"

class TestGame < Minitest::Test
  
  def test_game_class_exists
    game = Game.new
    assert_instance_of Game, game
  end

end 
```
+ Run tests & verify 0 runs, 0 assertions, 0 failures, 0 errors, 0 skips  
`ruby spec/game_test.rb`  


## Test 1: Gutter Game
**RED**

* Add the following test and verify that it fails with a `undefined method 'roll'`
```ruby
def test_gutter_game
  game = Game.new
  20.times do
    game.roll(0)
  end
end
```

**GREEN**

* Add the following to *game.rb* & verify that the test suite is green again
```ruby
class Game
  def roll(pins)
  end
end
```

**RED**

* Break your test by asserting game score must be 0.  Add the following to *spec/game_test.rb*
```ruby
assert_equal 0, game.score
```
* Run tests and verify it's failing with: `NoMethodError: undefined method score`  Test method `test_gutter_game` should look like..
```ruby
  # 20 rolls of 0 must score 0
  def test_gutter_game
    game = Game.new
    20.times do
      game.roll(0)
    end
    assert_equal 0, game.score
  end
```

**GREEN**

* Update *game.rb* & validate that the test passes.
```ruby
class Game
  def roll(pins)
  end

  def score
    0
  end
end
``` 


## Test 2:  10 gutter balls & 10 rolls of 1 must score 10
**RED** 
* Add the following test to *spec/game_test.rb* and verify that it fails with `expected: 10 got: 0`  
```ruby
# 10 rolls of 1 & 10 rolls of zero
def test_ten_ones_ten_gutters
  10.times do
    game.roll(1)
  end
  10.times do 
    game.roll(0)
  end
  assert_equal 10, game.score
end
```

**GREEN**
* Update *game.rb* & verify that the spec passes  
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

**REFACTOR**
* In *game_test.rb* add the `setup` method from Minitest.  It runs before each test, prepares the test environment and is commonly used to initialize objects or set state for the tests.   
```ruby
def setup
  @game = Game.new
end
```
+ replace `game` variable with the instance variable `@game`  


* Add a `roll_many` method to DRY up *game_test.rb* loops  
```ruby
def roll_many(rolls, pins)
  rolls.times do
    @game.roll(pins)
  end
end
```

## Test 3: Picking Up a Spare

**RED**
* Add the following test and confirm that it fails with a `expected: 16 got: 13`  
```ruby
def test_spare
  @game.roll(5)
  @game.roll(5)
  @game.roll(3)
  assert_equal 16, @game.score
end
```
**REVERSE, GREEN, AND REFACTOR**
* Our code needs to be changed too much to make this test pass, so skip the test(add an x in front of it like `xtest..`) and validate that you have 2 passing tests & 1 skipped test.

* Update *game.rb* so that it sums 2 rolls at a time. This will be needed for when we are looking at spares & strikes. Verify that your tests are not failing.
```ruby
def score
  result = 0
  frame_index = 0

  10.times do
    result += @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0)
    frame_index += 2
  end

  result
end
```

**RED(AGAIN)**

* Un-skip the spare test and confirm that it still fails with a `expected: 16 got: 13`

**GREEN**

* Update *game.rb* so that it tests for spares and applies the spare bonus. Verify that you have no failing tests
```ruby
def score
  result = 0
  frame_index = 0

  10.times do #Frames in a game
    result += if @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0) == 10 #spare
                10 + @rolls.fetch(frame_index +2, 0) 
              else
                @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0) 
              end
    frame_index += 2
  end

  result
end
```

**REFACTOR**

* In *game.rb* extract the spare logic. Create an intention revealing predicate method. Ensure no failures.
```ruby
def score
  result = 0
  frame_index = 0

  10.times do #Frames in a game
    result += if spare?(frame_index)
                10 + @rolls.fetch(frame_index +2, 0) 
              else
                @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0) 
              end
    frame_index += 2
  end

  result
end

private 

def spare?(frame_index)
  @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0) == 10 #spare
end
```

* Eliminate a magic number and a comment by creating constants for `FRAMES` and `PINS`  
```ruby
class Game

  FRAMES = 10
  PINS   = 10   
```

* Extract the `spare_bonus` logic into its own method.
```ruby
def spare_bonus(frame_index)
  @rolls.fetch(frame_index + 2, 0)
end
```

* Create a `spare` method in *game_test.rb*  and call it in `test_spare` replacing calls to `@game.roll(5)` When calling this method ensure the two rolls sum to 10.
```ruby
def roll_spare(roll_one, roll_two)
  @game.roll(roll_one)
  @game.roll(roll_two)
end
```


## Test 4: Strike
**RED**
* Add the following test and verify that it fails with `expected: 24 got: 17`
```ruby
def test_strike
  @game.roll(10)
  @game.roll(3)
  @game.roll(4)
  roll_many(16,0)
  assert_equal 24, @game.score
end
```


**GREEN**
* Account for strikes in `Game#score` and ensure your tests are passing.
```ruby
def score
  result = 0
  frame_index = 0

  FRAMES.times do #Frames in a game
    if @rolls.fetch(frame_index, 0) == PINS #strike!
      result += PINS + @rolls.fetch(frame_index + 1, 0) + @rolls.fetch(frame_index + 2, 0) # strike bonus adds next to balls
      frame_index += 1
    elsif spare?(frame_index)
      result += PINS + spare_bonus(frame_index) 
      frame_index += 2
    else
      result += @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0) 
      frame_index += 2
    end
    
  end

  result
end
```

**REFACTOR**
* Create `roll_strike` method in *game_test.rb*
```ruby
def roll_strike
  @game.roll(Game::PINS)
end
```

* Extract intention revealing predicate method, `Game#strike?`
```ruby
private 

def strike?(frame_index)
  @rolls.fetch(frame_index, 0) == PINS #strike!
end
```



* Extract `strike_bonus` logic into its own method
```ruby
def strike_bonus(frame_index)
  @rolls.fetch(frame_index + 1, 0) + @rolls.fetch(frame_index + 2, 0) # strike bonus adds next to balls
end
```



## Test 5: The Perfect Game

**JUST GREEN**
* Add the following test & verify that it passes
```ruby
def test_perfect_game
  roll_many(12, Game::PINS)
  assert_equal 300, @game.score
end
```



