jslint.vim
=============

Vim plugin and command line tool for running JSLint <http://jslint.com/>.

JSLint is a handy tool that spots errors and common mistakes in 
JavaScript code.

This is alpha software and is under heavy development.


Installation and Use
-----------------------

- Make sure you have a JavaScript interpreter installed. In Ubuntu you can
  install the Spidermonkey shell with this command:

        $ sudo apt-get install sipdermonkey-bin

  On Windows you can use `cscript.exe` - which is probably already installed.

- If you have rake installed, run:

        $ rake install

  Otherwise copy the directory plugin/jslint/ into your Vim plugin directory.
  Usually this is `~/.vim/plugin/`. On Windows it is `~/vimfiles/plugin/`.

- Open a JavaScript file in Vim and run the command `:JSLint` to check the
  file. Potential errors will be highlighted in red. Run `:JSLint` again once
  the errors are fixed to check the file again.

  If you run `:JSLint` with your cursor on a problem line you will see a
  description of the problem echoed at the bottom of the screen.

- (optional) Add configuration to your `~/.vimrc` file to bind JSLint to a key.
  For example:

        " Run JSLint on the current file when <F5> is pressed.
        map <F5> :JSLint<CR>

To get a detailed report of any issues in your JavaScript file, run the
`bin/jslint` executable in a terminal. For example:

      $ bin/jslint plugin/jslint/fulljslint.js

You can copy `bin/jslint` into for `PATH` for easier access. The executable
requires that the Vim plugin is installed and also requires Ruby.


Credits
---------

- Jesse Hallett -- original author
- Nathan Smith -- Windows compatibility and many other improvements
- Travis Jeffery -- Easy plugin installation with rake
- Sam Goldstein -- Display of problem report for the current line


License
---------

Copyright (c) 2008-2009 Jesse Hallett <hallettj@gmail.com>, except where
otherwise noted

Permission is hereby granted, free of charge, to any person obtaining a copy of
this software and associated documentation files (the "Software"), to deal in
the Software without restriction, including without limitation the rights to
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies
of the Software, and to permit persons to whom the Software is furnished to do
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

The Software shall be used for Good, not Evil.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
