# Bitmap editor

## Archive Structure:

Archive file contains three folders :
* **lib:** Contains source code of application
* **examples:** Contains sample data
* **spec:** Contains Rspec tests for source codes

## How to run

1. Unzip the _archive file_ into a path or clone th repo `https://github.com/shahriarb/bitmap_editor
2. Go to the path
3. Run `bin/bitmap_editor path_to_the_input_data_file` (i.e `bin/bitmap_editor examples/all_commands.txt`)

## How to test

Rspec tests are present in _spec_ folder. 

1. Unzip the _archive file_ into a path or clone th repo `https://github.com/shahriarb/bitmap_editor
2. Go to the path
3. Run `bundle install` to install the `rspec` gem
4. Run `rspec`

## Classes and Application flow

__BitmapEditor__ is the main class responsible to handle the flow of application. It receives an input file as an argument which will be passed to __InputHandler__ class.  

__InputHandler__ reads the file - line by line - parse each line and check for format and commands listed in file. It will return list of command and their parameters and list of errors in file.

__BitmapEditor__ will check the result of __InputHandler__ parsing and if there is any error, it will print them to output and return. If there is no error, __BitmapEditor__  will add the commands to a __CommandList__ with the help of __CommandFactory__. 

__CommandFactory__ is a factory class responsible to create a specific __Command__ base on `command` and `*params` passed to it. If any exception happens during `command` creation (i.e wrong parameter ), __BitmapEditor__ will capture it to send to output. 

With no error __BitmapEditor__ will add the command to a __CommandList__ which is a _CommandComposite_ in _Command design pattern_.
After all commands added to __CommandList__ with no error, __BitmapEditor__ will use `execute` method of __CommandList__ to run the command and get the result.

__Commands__ and its children are following _Command Design Pattern_.  All of them have an `execute` method which receive a `bitmap` and will return `changed_bitmap`, `output_message` of command(Only :show command has an output now)  and `error_message` during execution of command if there is any.   
__CommandList__ also has an `execute` method with the same input and output of`command.execute`.  It will pass the input `bitmap` and run each commands in order they added into list. If any error happens during execution, __CommandList__ will stop execution and will return error.
 
At the end __BitmapEditor__ will check the outputs and will write `errors` or `output_messages` (if there is any) to stdout.


