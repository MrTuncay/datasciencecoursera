#_____________________________________________________________________________________________________________
# R Programming | Week 2
# Course Slide: control_intro.pdf
#
# Control Structures
# Control structures in R allow you to control the flow of execution of the program, depending on
# runtime conditions. Common structures are
# - if, else: testing a condition
# - for: execute a loop a fixed number of times
# - while: execute a loop while a condition is true
# - repeat: execute an infinite loop
# - break: break the execution of a loop
# - next: skip an interation of a loop
# - return: exit a function
# Most control structures are not used in interactive sessions, but rather when writing functions or
# longer expresisons.
#  
#_____________________________________________________________________________________________________________
#
# Course Slide: control_if.pdf
#
# Control Structures: if
if(<condition>) {
  ## do something
} else {
  ## do something else
}
if(<condition1>) {
  ## do something
} else if(<condition2>) {
  ## do something different
} else {
  ## do something different
}
# if
# This is a valid if/else structure.
if(x > 3) {
  y <- 10
} else {
  y <- 0
}
# So is this one.
y <- if(x > 3) {
  10
} else {
  0
}
# Of course, the else clause is not necessary.
#  
#_____________________________________________________________________________________________________________
#
# Course Slide: control_forloop.pdf
#
# for
# for loops take an interator variable and assign it successive values from a sequence or vector. For
# loops are most commonly used for iterating over the elements of an object (list, vector, etc.)
for(i in 1:10) {
  print(i)
}
# This loop takes the i variable and in each iteration of the loop gives it values 1, 2, 3, ..., 10, and then
# exits.
#
# These three loops have the same behavior:
x <- c("a", "b", "c", "d")
for(i in 1:4) {
  print(x[i])
}
#
for(i in seq_along(x)) {
  print(x[i])
}
#
for(letter in x) {
  print(letter)
}
for(i in 1:4) print(x[i])
#
# Nested for loops
x <- matrix(1:6, 2, 3)
for(i in seq_len(nrow(x))) {
  for(j in seq_len(ncol(x))) {
    print(x[i, j])
  }
}
#  
#_____________________________________________________________________________________________________________
#
# Course Slide: control_forloop.pdf
#
# while
# While loops begin by testing a condition. If it is true, then they execute the loop body. Once the loop
# body is executed, the condition is tested again, and so forth.
count <- 0
while(count < 10) {
  print(count)
  count <- count + 1
}
# While loops can potentially result in infinite loops if not written properly. Use with care!
# Sometimes there will be more than one condition in the test:
z <- 5
while(z >= 3 && z <= 10) {
  print(z)
  coin <- rbinom(1, 1, 0.5)
  if(coin == 1) { ## random walk
    z <- z + 1
  } else {
    z <- z - 1
  }
}
#  
#_____________________________________________________________________________________________________________
#
# Course Slide: control_forloop.pdf
#
# repeat
#
# Repeat initiates an infinite loop; these are not commonly used in statistical applications but they do
# have their uses. The only way to exit a repeat loop is to call break.
x0 <- 1
tol <- 1e-8
repeat {
  x1 <- computeEstimate()
  if(abs(x1 - x0) < tol) {
    break
  } else {
    x0 <- x1
  }
}
# 
# The loop in the previous slide is a bit dangerous because there's no guarantee it will stop. Better to
# set a hard limit on the number of iterations (e.g. using a for loop) and then report whether
# convergence was achieved or not.
#
# next, return
# next is used to skip an iteration of a loop
for(i in 1:100) {
  if(i <= 20) {
    ## Skip the first 20 iterations
    next
  }
  ## Do something here
}
#return signals that a function should exit and return a given value
#  
#_____________________________________________________________________________________________________________
#
# Course Slide: functions.pdf
#
# Functions
#
# Functions are created using the function() directive and are stored as R objects just like anything
# else. In particular, they are R objects of class "function".
f <- function(<arguments>) {
  ## Do something interesting
}
# Functions in R are "first class objects", which means that they can be treated much like any other R
# object. Importantly:
# - Functions can be passed as arguments to other functions
# - Functions can be nested, so that you can define a function inside of another function
# - The return value of a function is the last expression in the function body to be evaluated.
#
# Function Arguments
# Functions have named arguments which potentially have default values.
# The formal arguments are the arguments included in the function definition
# The formals function returns a list of all the formal arguments of a function
# Not every function call in R makes use of all the formal arguments
# Function arguments can be missing or might have default values
#
# Argument Matching
# R functions arguments can be matched positionally or by name. So the following calls to sd are all
# equivalent
mydata <- rnorm(100)
sd(mydata)
sd(x = mydata)
sd(x = mydata, na.rm = FALSE)
sd(na.rm = FALSE, x = mydata)
sd(na.rm = FALSE, mydata)
#
# Even though it's legal, I don't recommend messing around with the order of the arguments too much,
# since it can lead to some confusion.
#
# You can mix positional matching with matching by name. When an argument is matched by name, it
# is "taken out" of the argument list and the remaining unnamed arguments are matched in the order
# that they are listed in the function definition.
args(lm)
function (formula, data, subset, weights, na.action,
          method = "qr", model = TRUE, x = FALSE,
          y = FALSE, qr = TRUE, singular.ok = TRUE,
          contrasts = NULL, offset, ...)
# The following two calls are equivalent.
lm(data = mydata, y ~ x, model = FALSE, 1:100)
lm(y ~ x, mydata, 1:100, model = FALSE)  
# 
# Most of the time, named arguments are useful on the command line when you have a long
# argument list and you want to use the defaults for everything except for an argument near the
# end of the list
# Named arguments also help if you can remember the name of the argument and not its position
# on the argument list (plotting is a good example).
#
# Function arguments can also be partially matched, which is useful for interactive work. The order of
# operations when given an argument is
# 1. Check for exact match for a named argument
# 2. Check for a partial match
# 3. Check for a positional match
#
# Defining a Function
#
f <- function(a, b = 1, c = 2, d = NULL) {
}
#
# In addition to not specifying a default value, you can also set an argument value to NULL.
#
# Lazy Evaluation
# Arguments to functions are evaluated lazily, so they are evaluated only as needed.
f <- function(a, b) {
  a^2
}
f(2) ## [1] 4
# This function never actually uses the argument b, so calling f(2) will not produce an error because
# the 2 gets positionally matched to a.
f <- function(a, b) {
  print(a)
  print(b)
}
f(45) ## [1] 45
      ## Error: argument "b" is missing, with no default
# Notice that "45" got printed first before the error was triggered. This is because b did not have to be
# evaluated until after print(a). Once the function tried to evaluate print(b) it had to throw an
# error.
#
# The "..." Argument
# The ... argument indicate a variable number of arguments that are usually passed on to other
# functions.
# - ... is often used when extending another function and you don't want to copy the entire argument
#   list of the original function
myplot <- function(x, y, type = "l", ...) {
  plot(x, y, type = type, ...)
}
# - Generic functions use ... so that extra arguments can be passed to methods (more on this later).
mean
function (x, ...)
UseMethod("mean")
#
# The ... argument is also necessary when the number of arguments passed to the function cannot be
# known in advance.
#
args(paste)
function (..., sep = " ", collapse = NULL)
#
args(cat)
function (..., file = "", sep = " ", fill = FALSE,
          labels = NULL, append = FALSE)
#
# Arguments Coming After the "..." Argument
# One catch with ... is that any arguments that appear after ... on the argument list must be named
# explicitly and cannot be partially matched.
args(paste)
function (..., sep = " ", collapse = NULL)
 paste("a", "b", sep = ":")
# [1] "a:b"
paste("a", "b", se = ":")
# [1] "a b :"








