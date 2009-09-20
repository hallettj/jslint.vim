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

        $ sudo apt-get install spidermonkey-bin

  On Windows you can use `cscript.exe` - which is probably already installed.

- If you have rake installed, run:

        $ rake install

  Otherwise copy the directory plugin/jslint/ into your Vim plugin directory.
  Usually this is `~/.vim/plugin/`. On Windows it is `~/vimfiles/plugin/`.

- Simple mode:

    *   Open a JavaScript file in Vim and run the command `:JSLintLight` to
        check the file. If there are potential errors they will be highlighted
        in red.  If there is an error on the line under the cursor an
        explanation of that error will be printed at the bottom of the screen.

        Run `:JSLintLight` again once the errors are fixed to remove error
        highlighting.

- Quickfix mode:

    *   Open a JavaScript file in Vim and run the command `:JSLint` to check
        the file. If there are potential errors they will be highlighted in red
        and the quickfix window will open.

        Run `:JSLint` again once the errors are fixed to remove error
        highlighting and to close the quickfix window.

- (optional) Add any valid JSLint options to `~/.jslintrc` file, they will be
  used as global options for all JavaScript file.
  For example:

        /*jslint browser: true, regexp: true */
        /*global jQuery, $ */

        /* vim: set ft=javascript: */

- (optional) Add configuration to your `~/.vimrc` file to bind JSLint to a key.
  For example:

        " Run JSLint on the current file in simple mode when <F4> is pressed.
        map <F4> :JSLintLight<CR>

        " Run JSLint on the current file with quickfix when <F5> is pressed.
        map <F5> :JSLint<CR>

To get a detailed report of any issues in your JavaScript file outside of Vim,
run the `bin/jslint` executable in a terminal. For example:

    $ bin/jslint plugin/jslint/fulljslint.js

You can copy `bin/jslint` into for `PATH` for easier access. The executable
requires that the Vim plugin is installed and also requires Ruby.

To clear highlighted errors run `:JSLintClear`.  To disable error highlighting
altogether add this line to your `~/.vimrc` file:

    let g:JSLintHighlightErrorLine = 0 


Working with quickfix
-----------------------

The quickfix window will display a list of all potential errors in the file
with an explanation for each. Running `:JSLint` will automatically open the
quickfix window if there are potential errors and will close it if no problems
are detected.

Note that the quickfix list will be cleared and regenerated every time you run
`:JSLint`.

Here are some quick notes for using quickfix:

- In the quickfix window, moving your cursor over an item and pressing enter
  will jump the cursor to that line in your file.

- In either your file or the quickfix window `:cn` will jump the cursor to the
  next potential error, and `:cp` will jump the cursor to the previous item.

- Open and close the quickfix window with `:copen[n]` and `:ccl[ose]`.

You can find more detailed documentation in the [Vim Reference Manual][quickfix
manual].

[quickfix manual]: http://www.vim.org/htmldoc/quickfix.html


Credits
---------

- Jesse Hallett -- original author
- Nathan Smith -- Windows compatibility, quickfix integration, better OS X
  compatibility, and many other improvements
- Travis Jeffery -- Easy plugin installation with rake
- Sam Goldstein -- Display of problem report for the current line and bug fixes
- Bryan Chow -- Fixes for formatting issues and typos
- Jeff Buttars -- Options to remove and to disable error highlighting
- Rainux Luo -- Support for reading JSLint options from a `~/.jslintrc` file


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
