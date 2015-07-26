NB. Examples of recursion with memoization

NB. 1) Fibonacci, recursive
fib =:1:`(($:@:<:) + ($:@:-&2))@.(2&<)M. 

col1 =: (>:@:(3&*))`(%&2)@.(0&=@|&2)^:_