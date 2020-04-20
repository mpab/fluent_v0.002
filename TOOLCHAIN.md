# Toolchain

C++11, boost, lex, yacc...

- General
  - yacc (bison) should be > 3.x
- Windows
  - boost: <https://www.boost.org/users/download/>
  - The VS project expects to find boost in %BOOST_HOME% e.g. BOOST_HOME=%APPS%\boost_1_72_0
  - lex, yacc For Windows use this port: <https://sourceforge.net/projects/winflexbison/>
  - ...and define %WIN_FLEX_BISON_HOME% as the installation folder in build.bat.

- OSX and Linux
  - google is your friend (for the purposes of search...)
  - xcode uses an older, incompatible version of yacc, use homebrew to get the latest, and update your path settings accordingly.
  - brew install bison
  - brew install flex

In .zshrc

```shell
export LDFLAGS="-L/usr/local/opt/flex/lib"
export CPPFLAGS="-I/usr/local/opt/flex/include"
export PATH="/usr/local/opt/flex/bin:$PATH"

export LDFLAGS="-L/usr/local/opt/bison/lib"
export PATH="/usr/local/opt/bison/bin:$PATH"

export CPATH=/usr/local/opt/flex/include/
```

The last line is important, else the old headers are used