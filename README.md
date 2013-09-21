# sec_entities

A ruby gem for searching and retrieving data from the Security and Exchange Commission's Edgar web system.

This gem was originally made by Ty Rauber and had more functions, but I couldn't get to work and I didn't need all of the functions so I made it work for what I needed.
If I can get the other one to work eventually, I'll retire this one.


## Installation

To install the 'sec_entities' Ruby Gem run the following command at the terminal prompt.

`gem install sec_entities`

For an example of what type of information 'sec_entities' can retrieve, run the following command:

`bundle exec rspec spec`

If running 'sec_entities' from the command prompt in irb:

`irb -rubygems`

`require "sec_entities"`

## Functionality

### FIND COMPANY:

#### By Name:

Sec::Entity.find("WEYERHAUSER")


## License

Copyright (c) 2011 Ty Rauber

Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
