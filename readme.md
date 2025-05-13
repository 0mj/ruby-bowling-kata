Refactored to mimic real bowling score card.

#### RED Step 01: Create Test Class and Require 
Create new test file `game_test.rb` and add following code and save.
```ruby
require 'minitest/autorun'

class GameTest < Minitest::Test
end
```

#### RED Still: Step 000: 
Create `Game` class file
```ruby
class Game
end
```

#### GREEN Require Game
Add `require_relative` for the `Game` class file.  Run this `ruby <testFile> name` in your console
```ruby
require 'minitest/autorun'
require_relative '../lib/game'

class GameTest < Minitest::Test
end
```
#### RED Step 0: Setup Test File
Ensure ability to instantiate `Game` 
```ruby
  def setup
    @game = Game.new
  end

  def test_game_class_exists
    assert_instance_of Game, @game
  end
```
#### GREEN Step 1 Create Game class file
```ruby
class Game
end
```
#### RED Step 2 Add Gutter Game Test
Add test to your `GameTest` class and verify it fails with "GameTest#test_gutter_game: NoMethodError: undefined method"
```ruby
def test_gutter_game
  20.times do 
    @game.roll(0)
  end
end
```

#### GREEN Step 3 Add Roll Method
Add `#roll` method to `Game` class to get passing test
```ruby
class Game
  def roll(pins)
  end
end
```


#### RED Step 4 Game Frames Array exists? 
Add test to `GameTest` class to ensure `@frames` array exists and is empty. It should fail with: "NoMethodError: undefined method `frames` "

```ruby
def test_frames_array_exists
  assert_instance_of Array, @game.frames
  assert_empty @game.frames
end
```

#### GREEN Step 5 Add Instance Variable `@frames` array
Add `attr_accessor` to `Game` class and create `@frames` instance variable and set it to an empty array.
```ruby
class Game
  attr_accessor :frames

  def initialize
    @frames = []
  end

  def roll(pins)
  end
end
```
#### Refactor
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



#### RED Step 6 Test we have 10 Frames
Now that we have `@frames` array, let's ensure there are 10 frames
Add following test to `GameTest` class, run it and it should fail with "Should have 10 frames.
Expected: 10
  Actual: 0"
```ruby
def test_for_ten_frames
  roll_many(20,0)
  @game.score
  assert_equal 10, @game.frames.size, "Should have 10 frames"
end
```

#### GREEN Step 7 Add FRAMES constant & #score method
Add a `FRAMES` constant to top of `Game` class.  
Add `#score` method which iterates our integer `FRAMES` constant, adding a `:frame` hash and number value to `@frames` array.
```ruby
FRAMES = 10
#..
def score
  @frames.clear
  FRAMES.times do |frame_number|
    @frames << { frame: frame_number + 1 }
  end
end
```





#### GREEN Step 7 Add some rolls & call score
Call `roll_many` method to add rolls to an instance of `Game` class.  
Call `#score` method to 
```ruby
def calculate_score
  @frames.clear
  FRAMES.times do |frame_number|
    @frames << { frame: frame_number + 1, type: :open, rolls: [], score: 0 }
  end
end
```






#### GREEN Step 7 #calculate_score method
Add `#calculate_score` method to the `Game` class
```ruby
def calculate_score
  @frames.clear
  FRAMES.times do |frame_number|
    @frames << { frame: frame_number + 1, type: :open, rolls: [], score: 0 }
  end
end
```


Step 1: Red - Test for a Gutter Game

We'll start with the simplest scenario: a gutter game (all rolls are 0). But wait how / what's going on with `@game.frames` ? 

```ruby
class GameTest < Minitest::Test
  def setup
    @game = Game.new
  end

  def test_gutter_game
    roll_many(20, 0)
    @game.calculate_score # Explicitly call calculate_score
    assert_equal 0, @game.frames.sum{|frame| frame[:score]}, "Gutter game should score 0"
  end

  private
  def roll_many(rolls, pins)
    rolls.times do
      @game.roll(pins)
    end
  end
  def roll_frame(roll1, roll2)
    @game.roll(roll1)
    @game.roll(roll2)
  end
end
```

Run this test. It should fail because the calculate_score method isn't calculating the score yet.

Step 2: Green - Make the Gutter Game Test Pass

Modify the calculate_score method to handle a gutter game:

```ruby
class Game
  attr_accessor :rolls, :frames
  FRAMES = 10
  PINS = 10

  def initialize
    @rolls = []
    @frames = []
  end

  def roll(pins)
    @rolls << pins
  end

  def score
    calculate_score
    @frames.sum { |frame| frame[:score] }
  end

  private

  def calculate_score
    @frames.clear
    roll_index = 0
    FRAMES.times do |frame_number|
      roll1 = @rolls.fetch(roll_index, 0)
      roll2 = @rolls.fetch(roll_index + 1, 0)
      frame_score = roll1 + roll2
      @frames << { frame: frame_number + 1, type: :open, rolls: [roll1,roll2], score: frame_score }
      roll_index += 2
    end
  end
end
```


Run the test_gutter_game test. It should now pass.

Step 3: Red - Test for a Game with All Ones

Now, let's test a game where each roll is 1.

```ruby
def test_all_ones
  roll_many(20, 1)
  @game.calculate_score
  assert_equal 20, @game.frames.sum{|frame| frame[:score]}, "All ones game should score 20"
end
```

Run this test. It should also pass, because our current calculate_score method correctly handles this scenario.

Step 4: Red - Test for a Spare

Let's introduce a spare. This is where things get more complex.

```ruby
def test_spare
  roll_frame(5, 5) # Spare in the first frame
  roll_many(18, 1)
  @game.calculate_score
  assert_equal 29, @game.frames.sum{|frame| frame[:score]}, "Spare should add the next roll as a bonus"
end
```

Run this test. It will fail.

Step 5: Green - Make the Spare Test Pass

Modify calculate_score to handle spares:

```ruby
def calculate_score
  @frames.clear
  roll_index = 0
  FRAMES.times do |frame_number|
    roll1 = @rolls.fetch(roll_index, 0)
    roll2 = @rolls.fetch(roll_index + 1, 0)
    frame_score = roll1 + roll2
    frame_rolls = [roll1, roll2]
    if spare?(roll_index)
      frame_score = PINS + @rolls.fetch(roll_index + 2, 0)
      frame_rolls << @rolls.fetch(roll_index+2, 0)
      @frames << { frame: frame_number + 1, type: :spare, rolls: frame_rolls, score: frame_score }
      roll_index += 2
    else
      @frames << { frame: frame_number + 1, type: :open, rolls: frame_rolls, score: frame_score }
      roll_index += 2
    end
  end
end
def spare?(frame_index)
  @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0) == PINS
end
```

Run the test_spare test. It should now pass.

Step 6: Red - Test for a Strike

Now, let's add a test for a strike.

```ruby
def test_strike
  @game.roll(10) # Strike in the first frame
  roll_many(18, 1)
  @game.calculate_score
  assert_equal 30, @game.frames.sum{|frame| frame[:score]}, "Strike should add the next two rolls as a bonus"
end
```

Run this test. It will fail.

Step 7: Green - Make the Strike Test Pass

Modify calculate_score to handle strikes:

```ruby
def calculate_score
  @frames.clear
  roll_index = 0
  FRAMES.times do |frame_number|
    roll1 = @rolls.fetch(roll_index, 0)
    roll2 = @rolls.fetch(roll_index + 1, 0)
    frame_score = roll1 + roll2
    frame_rolls = [roll1, roll2]
    if strike?(roll_index)
      frame_score = PINS + @rolls.fetch(roll_index + 1, 0) + @rolls.fetch(roll_index + 2, 0)
      frame_rolls = [roll1, @rolls.fetch(roll_index + 1, 0), @rolls.fetch(roll_index + 2, 0)]
      @frames << { frame: frame_number + 1, type: :strike, rolls: frame_rolls, score: frame_score }
      roll_index += 1
    elsif spare?(roll_index)
      frame_score = PINS + @rolls.fetch(roll_index + 2, 0)
      frame_rolls << @rolls.fetch(roll_index+2, 0)
      @frames << { frame: frame_number + 1, type: :spare, rolls: frame_rolls, score: frame_score }
      roll_index += 2
    else
      @frames << { frame: frame_number + 1, type: :open, rolls: frame_rolls, score: frame_score }
      roll_index += 2
    end
  end
end

def strike?(frame_index)
  @rolls.fetch(frame_index, 0) == PINS
end
```

Run test_strike. It should now pass.

Step 8: Refactor

```ruby
class Game
  attr_accessor :rolls, :frames
  FRAMES = 10
  PINS = 10

  def initialize
    @rolls = []
    @frames = []
  end

  def roll(pins)
    @rolls << pins
  end

  def score
    calculate_score
    @frames.sum { |frame| frame[:score] }
  end

  private

  def calculate_score
    @frames.clear
    roll_index = 0

    FRAMES.times do |frame_number|
      roll1 = @rolls.fetch(roll_index, 0)
      roll2 = @rolls.fetch(roll_index + 1, 0)
      frame_score = 0
      frame_rolls = [roll1]

      if strike?(roll_index)
        frame_score = PINS + @rolls.fetch(roll_index + 1, 0) + @rolls.fetch(roll_index + 2, 0)
        frame_rolls << @rolls.fetch(roll_index + 1, 0)
        frame_rolls << @rolls.fetch(roll_index + 2, 0)
        roll_index += 1
      elsif spare?(roll_index)
        frame_score = PINS + @rolls.fetch(roll_index + 2, 0)
        frame_rolls << roll2
        frame_rolls << @rolls.fetch(roll_index + 2, 0)
        roll_index += 2
      else
        frame_score = roll1 + roll2
        frame_rolls << roll2
        roll_index += 2
      end
      @frames << { frame: frame_number + 1, type: frame_type(roll1, roll2), rolls: frame_rolls, score: frame_score }
    end
  end

  def frame_type(roll1, roll2)
    return :strike if roll1 == PINS
    return :spare if roll1 + roll2 == PINS
    :open
  end

  def spare?(frame_index)
    @rolls.fetch(frame_index, 0) + @rolls.fetch(frame_index + 1, 0) == PINS
  end

  def strike?(frame_index)
    @rolls.fetch(frame_index, 0) == PINS
  end
end
```

