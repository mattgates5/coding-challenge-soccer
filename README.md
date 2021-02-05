## The Solution

Since the solution to the problem is supposed to be a demonstration of good hygiene,
separation of concerns, testing habits, and so on...I have broken down this solution
into a slightly more complex solution than I would if it was supposed to be a quick
and dirty script. 

The idea is that the `League` structure should be re-usable. If this were a streaming
API that is supposed to read a large amount of realtime data, I would have probably
provided this as a proper Gem. Rather, this is just a simple tool with a little factoring
done to separate out testable code from basic IO and stream processing functions.

### Notes

* In order to overcome platform specific constraints (vis-à-vis DOS and UNIX line-endings),
  I used Ruby's builtin `ARGF` and `IO` objects to stream input so it will use the OS's
  native file descriptors and pathing, and used a regular expression to break down the lines 
  into their teams and scores: `/ ?([A-z ]+) (\d+)/`.
* Matchday tracking is done in the main script `process_matches.rb`, but overall league
  scoring is performed by the `League` object.
* I used Ruby's builtin `ARGF` and `IO` objects to stream input so it will use the OS's
  native file descriptors and pathing
  hesitant to include both shell and batch scripts, rather leaving the instructions below to execute.

### Usage

#### Installation
To install the required libraries (`rspec`, etc.):
```shell
bundle install
```

#### Testing
To run tests on *nix:
```shell
./run_tests.sh
```
and on Windows:
```shell
run_tests.bat
```

#### Execution
To run the script itself, you can pass the file in from stdin:
```shell
cat sample-input.txt | ./process_matches.rb
```
Or pass the filename to the script:
```shell
./process_matches.rb sample-input.txt
```