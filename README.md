```
LLLLLLLLLLL             
L:::::::::L             
LL:::::::LL             
  L:::::L               
  L:::::L               
  L:::::L               
  L:::::L               
  L:::::L               
  L:::::L         LLLLLL
LL:::::::LLLLLLLLL:::::L
L::::::::::::::::::::::L
LLLLLLLLLLLLLLLLLLLLLLLL
```
# lisp-web-stack
fully lisp web stack

this repo exists to show how you can build web apps fully in lisp and encourage you to try it out.

IMO lisp (specifically common lisp) is a very fun and enjoyable way to build fullstack web applications. you need some experience in programming to understand what is going on though so be warned. lisp-web-stack follows the "keep it simple, stupid" principle (unlinke modern js frameworks) and keeps everything in one file.

## running

- install `sbcl`
- install `quicklisp` (through your package manager or https://www.quicklisp.org/beta/#installation)
- run `sbcl --load tutorial.lisp` and open http://localhost:5555
- later you can setup up an editor for comfortable editing like shown further below

## the code

https://parenscript.common-lisp.dev/tutorial.html - the tutorial i followed

i am too lazy to write comments. but everything in lisp is just a s-expression, specifically a function call which is `(function argument1 argument2 ...)` or a list which is `'(a b c d)` so read the docs. (with few exceptions to the rule like \` or [sharpsign macros](http://clhs.lisp.se/Body/02_dh.htm))

i understand that the code is a mess but i just don't have time to refactor and that is part of the beauty.

### what is being used
- js frontend libs (called from lisp)
  - tailwind
  - htmx
  - fomantic ui
- lisp specific
  - hunchentoot web server
  - parenscript (translate lisp to js)
  - macros (to do funny stuff, like automatic dark mode css generation)
- missing (for now)
  - database (sqlite is cool)

## why lisp?

- it is old, tested and stable
- it has macros
- it is multiparadigm (= very flexible), see how lisp compares to other languages: [wikipedia: comparison of multi-paradigm programming languages](https://en.wikipedia.org/w/index.php?title=Comparison_of_multi-paradigm_programming_languages&oldid=1278926551#Language_overview)
  - most interestingly it supports metaprogramming and functional programming
- it has s-exps which are easy to edit with vim bindings, makes refactoring easy
  - no need to learn a lot of syntactic sugar like other languages
- it is fast (can be natively compiled, has many optimizations)
- it has many libraries (if you feeling brave you can use interops with other languages like python to access even more libraries)
- it sparks joy

## editor

to make the process enjoyable you need a good editor. emacs is a perfect choice because it is written in lisp itself and is very extensible. and it has vim bindings via `evil-mode`. i use `slime` with `sbcl`. installing `slime` can be a litte annoying, but it is well worth it once you have everything set up. i also use [`slime-star`](https://github.com/mmontone/slime-star), `aggressive-indent-global-mode`, `rainbow-delimiters-mode` and `evil-cleverparens-mode`.

## further reading

- https://github.com/CodyReichert/awesome-cl
- https://parenscript.common-lisp.dev/reference.html
- http://bettermotherfuckingwebsite.com/
- https://github.com/emacs-evil/evil-cleverparens?tab=readme-ov-file#movement

## contributing

you are welcome to do so

### project status

i basically just dumped the thing i wrote onto github and added some webpages that helped me along the way in case somebody would find this interesting. i don't really plan on extending this, cleaning up or turning it into a full fledged course. still, i am open to contibutions. i hope it sparked some interest in you to dig deeper.

## misc

ascii art http://patorjk.com/software/taag/
