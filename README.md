#### grind it into your brain
![Just Start](https://media.giphy.com/media/wi8Ez1mwRcKGI/giphy.gif "DO IT")
:usa:  :+1: 2025-02-19-snsBndlr :+1: sansBundler :+1: 2022-11-09--043 :+1: 2022-10-25--042 :+1: 2022-10-06--041 :+1: 2022-09-22--040 :+1: 2022-09-12--039 [.......](https://gist.github.com/0mj/663e782ce5d55d48bbfc63dc9c28e3f5) :+1: 2022-09-05--038 :+1: 2022-08-25--037 :+1: 2022-08-08--035 :+1: 2022-08-05--035 :+1: 2022-07-29--034 :+1: 2022-07-15--033 :+1: 2022-07-15--032 :+1: 2022-07-08--031 :+1: 2022-06-28--030 :+1: 2022-06-22--029 :+1: 2022-06-14--028 :+1: 2022-06-07--027 :+1: 2022-06-02--026 :+1: 2022-05-23--025 :+1: 2022-05-10--024 :+1: 2022-05-09--023 :+1: 2022-05-02--022 :+1: 2022-04-26--021 :+1: 2022-04-21--020 :+1: 2022-04-18--019 :+1: 2022-04-14--018 :+1: 2022-04-11--017 :usa: :+1: 2022-04-07--016 :uk: :+1: 2022-04-05--015 :uk: :+1: 2022-03-27--014 :+1: 2022-03-24--013 :+1: 2022-03-21--012 :+1: 2022-03-18--011 :+1: 2022-03-17--010 :+1: 2022-03-16--009 :+1: 2022-03-15--008 :+1: 2022-03-14--007 :+1: 2022-03-11--006 :+1: 2022-03-09--005 :+1: 2022-03-09--004


# The Ruby Bowling Kata Steps

[Instructions](https://gist.github.com/theotherzach/1ddc1f348d1c711ea0e8da67efa82cf4)  

#### Creating Directory & Open (Powershell)

+ `Remove-Item -Recurse -Force -Path "\code\ruby-bowling-kata"`  
+ Re-create the directory. `New-Item -ItemType Directory -Path "\code\ruby-bowling-kata" -Force`  
+ Open the directory as a project in your editor of choice. `code .`

  

#### Project Setup
 
  
## The Code

### Workflow
+ Run tests: `ruby spec/bowling_test.rb`  
+ Lint & Commit your code after each test ( native ruby linter? )

### Test 0: Create The Files
**RED**

+ Create the file *spec/bowling_test.rb* `New-Item -ItemType File -Path "spec\bowling_test.rb" -Force` & add the following
  ```ruby
  class TestBowling < Minitest::Test
  end
  ```

+ Verify spec is red (failing) because it doesn't know what a Game is `ruby spec/bowling_test.rb`  
+ Create *lib/game.rb* `New-Item -ItemType File -Path "lib/game.rb" -Force` & add the following
  ```ruby
  class Game
  end
  ```

**GREEN**
+ Update *spec/bowling_test.rb* so it looks like this..
  ```ruby
  require_relative "../lib/bowling"
  require "minitest/autorun"
  
  
  class TestBowling < Minitest::Test
  end 
  ```
+ Run tests & verify 0 runs, 0 assertions, 0 failures, 0 errors, 0 skips `ruby spec/bowling_test.rb`  


### Test 1: Gutter Game
**RED**

* Add the following test and verify that it fails with a `undefined method 'roll'`

**GREEN**

* Add the following to *game.rb* & verify that the test suite is green again
  ```ruby
  class Game
    def roll(pins)
    end
  end
  ```

**RED**

* Add 
  ```ruby
  assert_equal 0, @game.score
  ```
  to *bowling_test.rb* & verify that it fails with a 
  ```powershell
    NoMethodError: undefined method score
  ```

  ```ruby
  require_relative "../lib/game"
  require "minitest/autorun"


  class TestGame < Minitest::Test

    # 20 rolls of 0 must score 0
    def test_gutter_game
      game = Game.new
      20.times do
        game.roll(0)
      end
      assert_equal 0, game.score
    end

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


### Test 2: 10 gutter balls & 10 rolls of 1
**RED** 
* Add the following test and verify that it fails with `expected: 10 got: 0`  
  ```ruby
  require_relative "../lib/game"
  require "minitest/autorun"


  class TestGame < Minitest::Test

    def setup
      @game = Game.new
    end

    # 20 rolls of 0 must score 0
    def test_gutter_game
      
      20.times do
        @game.roll(0)
      end
      assert_equal 0, @game.score
    end

    # 10 rolls of 1 & 10 rolls of zero
    def test_ten_ones_ten_gutters
      10.times do
        @game.roll(1)
      end
      10.times do 
        @game.roll(0)
      end
      assert_equal 10, @game.score
    end

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
* In *bowling_test.rb*  
```ruby
  def setup
    @game = Game.new
  end
```


* Add a `roll_many` method to DRY up *bowling_test.rb* loops  
```ruby
  def roll_many(rolls, pins)
    rolls.times do
      @game.roll(pins)
    end
  end
  ```

### Test 3: Picking Up a Spare

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
* Our code needs to be changed too much to make this test pass, so skip the test and validate that you have 2 passing tests & 1 skipped test.

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

* In *game.rb* exptract the spare logic. Create an intention revealing predicate method. Ensure no failures.

* Eliminate a magic number and a comment by creating constants for `FRAMES` and `PINS`  

* Extract the `spare_bonus` logic into its own method.

* Create a `spare` method in *bowling_test.rb*


### Test 4: Strike
**RED**
* Add the following spec and verify that it fails with `expected: 24 got: 17`



**GREEN**
* Account for strikes in `Game#score` and ensure your tests are passing.


**REFACTOR**
* Create `roll_strike` method in *bowling_test.rb*


* Extract intention revealing predicate method, `Game#strike?`




* Extract `strike_bonus` logic into its own method




### Test 5: The Perfect Game

**JUST GREEN**
* Add the following test & verify that it passes



