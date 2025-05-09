kay, let's try a more incremental approach. I'll provide a series of very small steps, with a corresponding test for each step.

Step 1: Red - Test for a Gutter Game

We'll start with the simplest scenario: a gutter game (all rolls are 0).

```
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

```
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

```
def test_all_ones
  roll_many(20, 1)
  @game.calculate_score
  assert_equal 20, @game.frames.sum{|frame| frame[:score]}, "All ones game should score 20"
end
```

Run this test. It should also pass, because our current calculate_score method correctly handles this scenario.

Step 4: Red - Test for a Spare

Let's introduce a spare. This is where things get more complex.

```
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

```
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

```
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

```
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

```
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

