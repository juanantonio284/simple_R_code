# ..................................................................................................
# FUNCTIONS: eval and eval q
# DESCRIPTION: "eval: evaluate an (Unevaluated) Expression"
# SOURCE: 
# * TITLE: "R: A Language and Environment for Statistical Computing, Reference Index, V. 4.3.0
#   (2023-04-21)"
# * Page: 184
# ..................................................................................................
# USAGE:
#
# eval( expr, 
#       envir = parent.frame(),
#       enclos = if( is.list(envir) || is.pairlist(envir) ) 
#       parent.frame() else baseenv() )
#
# evalq(expr, envir, enclos)
#
# eval.parent(expr, n = 1)
#
# local( expr, envir = new.env() )
# ..................................................................................................
# ..................................................................................................


# eval evaluates the expr argument in the environment specified by envir and returns the computed
# value.

# Objects to be evaluated can be of types:
# * call, 
# * expression,
# * name (when the name is looked up in the current scope and its binding is evaluated), 
# * promise, 
# * any of basic types such as vectors, functions, and environments (which are returned unchanged)

# eval evaluates its first argument in the current scope before passing it to the evaluator. 
# In simple words: it evaluates arguments right from the start and, thus needs all the variables to 
# exist before running. evalq, equivalent to eval(quote(expr), ...), avoids this. 

# evalq passes the whole expression to the evaluator and, thus there may be values passed inside
# evalq and they will override the values in the global environment.


# Example 1 ------------------------------------------------------------------------------
a <- 3 ; aa <- 4

# The code below first passes the whole expression (expr = ...), which includes creating a list with
# value a = 1, and this expression, in the evaluation, will override the a = 3 that's in the global
# env.

# Then evalq will evaluate a+b+aa=1+5+4, which gives the result 10.

evalq( 
  expr = evalq( expr = a+b+aa, envir = list(a = 1) ),
  envir = list(b = 5)
) 

# the instruction below accesses frame -1 on the stack (whatever that means ...)
# In this case, the value a will be the one in the global environment.
# Thus, a + b + aa = 3 + 5 + 4 = 12
evalq(
  expr = evalq( expr = a+b+aa, envir = -1 ),
  envir = list(b = 5)
  )
# == 12


# Example 2 ------------------------------------------------------------------------------
N <- 3 # in global environment
env <- new.env()
assign("N", 27, envir = env) # N = 27 in "env" environment

# eval evaluates the expr argument right away, thus whatever is in envir = env is disregarded?
eval( expr = N <- 4, envir = env)
N
get("N", envir = env)

# this version does the assignment in env, and changes N only there.
evalq( expr = N <- 5, envir = env)
N
get("N", envir = env) # N = 5 in "env" environment


# continue reading manual page 190 for objects of class "expression"
