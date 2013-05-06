grulec
======

Automate lexer compilation for Gherkin's Ruby lexer.


***Background:***

[Gherkin](https://github.com/cucumber/gherkin)'s built in C lexer recently started throwing random lexing errors. 
There is still an open [issue](https://github.com/cucumber/gherkin/issues/182) on the project's GitHub page.
The common workaround seems to be to fall back to a Ruby lexer. However, since that one needs to be compiled first,
here is a little script to reduce the pain. This is especially true, if you are running a CI server, where you don't 
want to recompile your lexer every time your gem changes (or even for every build, if you bundle your gems with your 
app).


***Usage:***

Just call the script and tell it where your app resides. The parameter is actually optional. So if you're calling
grulec from your app's root directory, you can remove the argument.

```
./compile_ruby_lexer.rb --app path/to/your/app/that/differs/from/$PWD
```

I'm aware that this could be transformed into a gem, but since it is basically a bugfix for another gem (and 
hopefully only a temporary solution), I'd rather stick with the small script.


***License:***

Released under the MIT License (MIT). 
Copyright (c) 2013 Dominik Bamberger
