This project is no longer under active development.  For alternatives
take a look at the [Alternative Plugins][] section below.  Or check out
the actively developed forks of this project:
[wookiehangover/jshint.vim][] and [FuDesign2008/jslint.vim][].

[Alternative Plugins]: #alternative-plugins
[wookiehangover/jshint.vim]: https://github.com/wookiehangover/jshint.vim
[FuDesign2008/jslint.vim]: https://github.com/FuDesign2008/jslint.vim

*jslint.vim*
=============

Vim plugin and command line tool for running [JSLint][].

[JSLint]: http://jslint.com/

JSLint is a handy tool that spots errors and common mistakes in
JavaScript code.

The source code for jslint.vim is hosted at
<http://github.com/hallettj/jslint.vim>.

This is alpha software and is under heavy development.


Installation
-----------------------

- Make sure you have a JavaScript interpreter installed.  On Linux jslint.vim
  supports Spidermonkey, Rhino, and node.js.  Spidermonkey or node.js are
  recommended because Rhino tends to have a long startup time.

  In Ubuntu you can install the Spidermonkey shell with this command:

        $ sudo apt-get install spidermonkey-bin

  Latest Ubuntu versions don't have spidermonkey in the default repositories.
  You can use rhino instead:

        $ sudo apt-get install rhino

  Or you can find instructions for installing node.js on the [node.js website][nodejs].

  [nodejs]: http://nodejs.org/

  On Windows you can use `cscript.exe` - which is probably already installed.

  On MacOS X you don't need to install any JavaScript interpreter because one
  is included with OS X by default.

- If you have rake installed, run:

        $ rake install

  Otherwise copy the directory ftplugin/ into your Vim ftplugin directory.
  Usually this is `~/.vim/ftplugin/`. On Windows it is `~/vimfiles/ftplugin/`.

- Finally, activate filetype plugins in your .vimrc, by adding the following line:

        filetype plugin on


Usage
-----------------------

- This plugin automatically checks the JavaScript source and highlights the
  lines with errors.

  It also will display more information about the error in the commandline if the curser is
  in the same line.

- You also can call it manually via `:JSLintUpdate`

- You can toggle automatic checking on or off with the command `:JSLintToggle`.
  You can modify your `~/.vimrc` file to bind this command to a key or to turn
  off error checking by default.

- (optional) Add any valid JSLint options to `~/.jslintrc` file, they will be
  used as global options for all JavaScript files.
  For example:

        /*jslint browser: true, regexp: true */
        /*global jQuery, $ */

        /* vim: set ft=javascript: */

To get a detailed report of any issues in your JavaScript file outside of Vim,
run the `bin/jslint` executable in a terminal. For example:

    $ bin/jslint ftplugin/jslint/fulljslint.js

You can copy `bin/jslint` into for `PATH` for easier access. The executable
requires that the Vim plugin is installed and also requires Ruby.

To disable error highlighting altogether add this line to your `~/.vimrc` file:

    let g:JSLintHighlightErrorLine = 0


Working with quickfix
------------------------

When automatic error checking is enabled jslint.vim will automatically display
errors in the [quickfix][] window in addition to highlighting them.

You can open and close the quickfix window with the commands `:copen` and
`:cclose`.  Use the command `:cn` to go to the next error or `:cc [nr]` to go
to a specific error, where `[nr]` is a number.  The first error in the list is
`1`, the second is `2`, and so on.

Once an error is fixed the corresponding quickfix line will disappear.

[quickfix]: http://vimdoc.sourceforge.net/htmldoc/quickfix.html  "Vim documentation: quickfix"


Alternative Plugins
---------------------

[Syntastic][] supports syntax checking for a number of languages,
including JavaScript via jshint or JSLint.

[Syntastic]: https://github.com/scrooloose/syntastic

There are other plugins for Vim that integrate [JavaScript Lint][].  JavaScript
Lint is another JavaScript checker that is similar to JSLint.

[JavaScript Lint]: http://www.javascriptlint.com/

[jsl.vim][] uses Vim's compiler infrastructure making its use consistent with
syntax checkers for other languages.

[jsl.vim]: http://www.vim.org/scripts/script.php?script_id=2630

[javaScriptLint.vim][] runs the contents of a JavaScript file through
JavaScript Lint after the file's buffer is saved and places any warnings in the
quickfix error window.

[javaScriptLint.vim]: http://www.vim.org/scripts/script.php?script_id=2578


Credits
---------

- Jesse Hallett -- original author
- Nathan Smith -- Windows compatibility, quickfix integration, better OS X
  compatibility, support for node.js, and other improvements
- Travis Jeffery -- Easy plugin installation with rake
- Sam Goldstein -- Display of problem report for the current line and bug fixes
- Bryan Chow -- Fixes for formatting issues and typos
- Jeff Buttars -- Options to remove and to disable error highlighting
- Rainux Luo -- Support for reading JSLint options from a `~/.jslintrc` file,
  Pathogen compatibility on Windows
- Pascal Hartig -- Support for running jslint with rhino and other updates
- Martin Schürrer -- Fixing path issues and error handling
- Nik Graf -- Documentation updates
- Ian McCracken -- Real-time error checking
- Luke Smith -- Enhancement of OS X support
- Michael Smith -- Feature to customize JavaScript executable that is used by
  setting JS_CMD environment variable
- Szilágyi Szilveszter -- Fixes for bugs when running in Windows
- Yasuhiro Matsumoto -- Pathogen compatibility and `:JSLintToggle` command
- Ben Loveridge -- Integrated quickfix with automatic error checking
- Brian Egan -- Documentation for enabling filetype plugins
- Trent Mick -- Feature to ignore #! lines for compatibility with shell scripts
- Christopher Sexton -- Fixed errors in MacVim on Lion and Snow Leopard
- Brian Donovan -- Fix for non-POSIX shells
- guileen (Lin Gui) -- Prefer node over jsc on Mac OS
- daethorian (Lowe Thiderman) -- Fix for error in updated spidermonkey
  version
- afairley -- Check for `nodejs` executable if `node` is not present


License
---------

Copyright (c) 2008-2012 Jesse Hallett <hallettj@gmail.com>, except where
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
