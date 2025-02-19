#### grind it into your brain
![Just Start](https://media.giphy.com/media/wi8Ez1mwRcKGI/giphy.gif "DO IT")
:usa:  :+1: 2025-02-19-snsBndlr :+1: sansBundler :+1: 2022-11-09--043 :+1: 2022-10-25--042 :+1: 2022-10-06--041 :+1: 2022-09-22--040 :+1: 2022-09-12--039 [.......](https://gist.github.com/0mj/663e782ce5d55d48bbfc63dc9c28e3f5) :+1: 2022-09-05--038 :+1: 2022-08-25--037 :+1: 2022-08-08--035 :+1: 2022-08-05--035 :+1: 2022-07-29--034 :+1: 2022-07-15--033 :+1: 2022-07-15--032 :+1: 2022-07-08--031 :+1: 2022-06-28--030 :+1: 2022-06-22--029 :+1: 2022-06-14--028 :+1: 2022-06-07--027 :+1: 2022-06-02--026 :+1: 2022-05-23--025 :+1: 2022-05-10--024 :+1: 2022-05-09--023 :+1: 2022-05-02--022 :+1: 2022-04-26--021 :+1: 2022-04-21--020 :+1: 2022-04-18--019 :+1: 2022-04-14--018 :+1: 2022-04-11--017 :usa: :+1: 2022-04-07--016 :uk: :+1: 2022-04-05--015 :uk: :+1: 2022-03-27--014 :+1: 2022-03-24--013 :+1: 2022-03-21--012 :+1: 2022-03-18--011 :+1: 2022-03-17--010 :+1: 2022-03-16--009 :+1: 2022-03-15--008 :+1: 2022-03-14--007 :+1: 2022-03-11--006 :+1: 2022-03-09--005 :+1: 2022-03-09--004


# The Ruby Bowling Kata Steps

[Instructions](https://gist.github.com/theotherzach/1ddc1f348d1c711ea0e8da67efa82cf4)  

#### Creating Directory & Open (Powershell)

+ `Set-Location -Path $HOME`  
`Remove-Item -Recurse -Force -Path "$HOME\code\ruby-bowling-kata"`  
+ Re-create the directory. `New-Item -ItemType Directory -Path "C:\Users\mj6409\code\ruby-bowling-kata" -Force`  
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
+ Create *lib/bowling.rb* `New-Item -ItemType File -Path "lib/bowling.rb" -Force` & add the following
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

* Add the following to *bowling.rb* & verify that the test suite is green again
  ```ruby
  class Game
    def roll(pins)
    end
  end
  ```

**RED**

* Add `expect(game.score).to eq(0)` to *bowling_test.rb* & verify that it fails with a `undefined method 'score'`
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

* Update *bowling.rbo* & validate that the test passes.
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
**RED** 
* Add the following spec and verify that it fails with `expected: 10 got: 0`  
<img width="628" src="https://user-images.githubusercontent.com/1697198/94306717-12b08b00-ff39-11ea-991c-24d76a9fe2ff.png">

**GREEN**
* Update *bowling.rb* & verify that the spec passes  
<img width="514" src="https://user-images.githubusercontent.com/1697198/94307137-cf0a5100-ff39-11ea-8ff1-e5b22f33f186.png">  

**REFACTOR**
* In *bowling_test.rb*, extract `game = Game.new` into an [RSpec let](https://relishapp.com/rspec/rspec-core/v/3-9/docs/helper-methods/let-and-let)  
<img width="693" src="https://user-images.githubusercontent.com/1697198/94308346-fd892b80-ff3b-11ea-81f0-b8bc194a6043.png">  

* Add a `roll_many` method to DRY up *bowling_test.rb* loops  
<img width="722" src="https://user-images.githubusercontent.com/1697198/94308909-dbdc7400-ff3c-11ea-8711-dbd1e10e4c99.png">

### Test 3: Picking Up a Spare

**RED**
* Add the following test and confirm that it fails with a `expected: 16 got: 13`
<img width="810"  src="https://user-images.githubusercontent.com/1697198/94317802-a3449680-ff4c-11ea-8554-7f29bc380e9d.png">

**REVERSE, GREEN, AND REFACTOR**
* Our code needs to be changed too much to make this test pass, so skip the test and validate that you have 2 passing tests & 1 skipped test.
<img width="172" src="https://user-images.githubusercontent.com/1697198/94317966-0fbf9580-ff4d-11ea-957c-97a12649566f.png">  

* Update *bowling.rb* so that it sums 2 rolls at a time. This will be needed for when we are looking at spares & strikes. Verify that your tests are not failing.
<img width="823" src="https://user-images.githubusercontent.com/1697198/94319043-6a59f100-ff4f-11ea-9d3c-ebe06b50626f.png">

**RED(AGAIN)**

* Un-skip the spare test and confirm that it still fails with a `expected: 16 got: 13`
<img width="222" src="https://user-images.githubusercontent.com/1697198/94319290-e48a7580-ff4f-11ea-8b07-9db79006ed56.png">

**GREEN**

* Update *bowling.rb* so that it tests for spares and applies the spare bonus. Verify that you have no failing tests
<img width="1265" src="https://user-images.githubusercontent.com/1697198/94320175-ef460a00-ff51-11ea-9a4c-467dc6adae79.png">

**REFACTOR**

* In *bowling.rb* exptract the spare logic. Create an intention revealing predicate method. Ensure no failures.
<img width="852" src="https://user-images.githubusercontent.com/1697198/94320418-7bf0c800-ff52-11ea-8087-1c52f2a78c47.png">

* Eliminate a magic number and a comment by creating constants for `FRAMES` and `PINS`  

* Extract the `spare_bonus` logic into its own method.
<img width="781" src="https://user-images.githubusercontent.com/1697198/94321204-988dff80-ff54-11ea-8bff-4c393e13c67f.png">

* Create a `spare` method in *bowling_test.rb*
<img width="773" src="https://user-images.githubusercontent.com/1697198/94321292-ca06cb00-ff54-11ea-9556-a3e075d4eb2b.png">

### Test 4: Strike
**RED**
* Add the following spec and verify that it fails with `expected: 24 got: 17`
<img width="719" src="https://user-images.githubusercontent.com/1697198/94321661-e3f4dd80-ff55-11ea-8fb9-20ca0b5518e2.png">


**GREEN**
* Account for strikes in `Game#score` and ensure your tests are passing.
<img width="1024" src="https://user-images.githubusercontent.com/1697198/94322044-f885a580-ff56-11ea-9166-cb877a7367e6.png">

**REFACTOR**
* Create `roll_strike` method in *bowling_test.rb*
<img width="725" src="https://user-images.githubusercontent.com/1697198/94322305-bdd03d00-ff57-11ea-8b84-2cdad50f9b70.png">

* Extract intention revealing predicate method, `Game#strike?`
<img width="400" src="https://user-images.githubusercontent.com/1697198/94322406-18699900-ff58-11ea-891b-b84a83777145.png">

<img width="372" src="https://user-images.githubusercontent.com/1697198/94322412-1ef81080-ff58-11ea-9d50-cd96224b89cf.png">

* Extract `strike_bonus` logic into its own method
<img width="396" src="https://user-images.githubusercontent.com/1697198/94322592-8b730f80-ff58-11ea-91cb-65db89840ad7.png">
<img width="576" src="https://user-images.githubusercontent.com/1697198/94322638-a6458400-ff58-11ea-8dbd-f545739dfa8a.png">


### Test 5: The Perfect Game

**JUST GREEN**
* Add the following test & verify that it passes
<img width="686" src="https://user-images.githubusercontent.com/1697198/94322913-86fb2680-ff59-11ea-9f71-f43fca252a02.png">


