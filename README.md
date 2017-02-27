## UA-CS-403

UA CS 403 Programming Languages class with Dr. Borie during 2017 Spring semester. Many of the practice problems in this repo can be found at [CS-403 @ UA.EDU](https://cs403.cs.ua.edu/spring2017/exercises.htm).

# Scheme

Scheme is a unique functional language that uses too many parenthesis.  Even though this may be one of your last classes in the CS curriculum at UA, the effort required to balance parenthesis in this language will prompt you to consider throwing it all away and switching majors to MIS. 

My prefered method to write a function in scheme and remain sane is to balance the parenthesis vertically for each function such as:
```
(define (count L)
	(if (null? L)
		0
		+ 1 (count (cdr L))
	)	
)
```

Resources:
* [Scheme Wikipedia] (https://en.wikipedia.org/wiki/Scheme_(programming_language)
* [MIT/GNU Scheme References] (https://gnu.org/software/mit-scheme/documentation/mit-scheme-ref/)
* [Racket Scheme] (https://docs.racket-lang.org/guide/index.html)
* [Racket Lambda Functions] (https://docs.racket-lang.org/guide/lambda.html)

GLHF

# Haskell

Haskell is pure functional language (no side-effects).  It looks similiar to Scheme, but without the parenthesis and more built-in functions.  You must declare the function's return type and parameter types, and will make you want to pull your hair out.

Resources:
* [Haskell Wikipedia] (https://en.wikipedia.org/wiki/Haskell_(programming_language)
* [Official Haskell Documentation] (https://www.haskell.org/documentation)
* ['Currying'] (https://wiki.haskell.org/Currying)
* [Learn You a Haskell] (http://learnyouahaskell.com/chapters)
* [Type Declarations] (http://learnyouahaskell.com/types-and-typeclasses#believe-the-type)

# Prolog
