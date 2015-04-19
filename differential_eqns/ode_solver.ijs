NB.  Verbs for finding analytic solutions of some ordinary differential
NB. equations, of orders 1 and 2. 

NB. Get roots of polynomial
roots=: >@:(1&{)@p.


solve=: 1 : ' (roots m) get_exponential'
solve_n=: 2 : '(n{ (roots m)) get_exponential'


NB. Caluclates individual summand solutions
NB. for the given polynomial and derivative and puts them
NB. into a gerund array.
solve_n2=: dyad define
diff =. x
cf =. y
rt =. roots cf
num =. i. # rt
sols =. ''
for_j. num do.
sols=. sols`(((j{rt)get_exponential) d. diff)
end.
sols
)

NB. gets the correct row from
NB. matrix
getRow =: dyad define
index =. x
mat=.y
index{index{mat
)

solveNow =: conjunction define
coeffs=. y NB. polynomial coefficients
deriv=. >0{ x NB. the orders of derivatives
val=. >1{ x NB. values to put in
res=. >2{ x NB. the values' results, i.e. y^(deriv)(val) = res

summands =. deriv solve_n2"(0 _) coeffs
sm =.(summands)(`:0)"1 0 val
num=. # sm
lst=. i. num
sm =. lst getRow"(0 _) sm
mat=. x: %. sm
constants=. mat (+/ . *) res
len=. # constants

sma=.''
for_j. i.len do.
sma=. sma`+`((j{constants)&*@:(coeffs solve_n j))
end.
((>:i.<:#sma){sma)`:6 NB. we want to remove the leading '+' from the output verb.
)




NB. Gets the solution
get_exponential=: 1 : 0
sols=: m
if. (# sols ) = 2 do.
  if. =/ sols do.
    ((>:)*(^@:(_1x&*)))
  elseif. 1 do. ^@:(m&*)
  end.
else.
  ^@:(m&*)
end.
)

NB. Solution for duplicate roots.
solve_duplicate=: 2 : 0
rt0=. 0{ (roots n)
((0{m)&*@:(^@:(rt0&*)))+ ((1{m)&*@:(]*(^@:(rt0&*))))
)


NB. Boundary Conditions. Returns the coefficients
NB. of the soluton's summands, calculated from
NB. the given boundary conditions.
boundary_conditions=: conjunction define
coeffs=. y NB. polynomial coefficients
deriv=. >0{ x NB. the orders of derivatives
val=. >1{ x NB. values to put in
res=. >2{ x NB. the values' results, i.e. y^(deriv)(val) = res
if. (# coeffs) = 3 do. NB. Quadratic ODE (e.g. y''+y'+y = 0)
  if. =/ (roots y) do.
    c1=. 1 :'^@:((0{ (roots m))&*)'
    c2=. 1 :']*(^@:((0{ (roots m))&*))'
    r1=. y c1
    r2=. y c2
NB. non-repeating roots. Get the two summands of the
NB. solution independently.
  else.
    r1=. y solve_n 0
    r2=. y solve_n 1
  end.
NB. solutions - for quadratics, differentiate the
NB. summands and input the values.
NB. This gets four numbers, we can put into a matrix to find
NB. the 2 coefficients of the summands.
'dr1 dr2'=. ((r1,r2) d. (0{deriv)) (0{val)
'dr3 dr4'=. ((r1,r2) d. (1{deriv)) (1{val)
NB. matrixify, get the coefficient constants
  mat=. (2 2) $ dr1, dr2, dr3, dr4
  mat=. x: %. mat
  constants=. mat (+/ . *) res
  constants NB. these are the two constants for summands 1 and 2.
  if. =/ (roots y) do.
    ((0{constants)&*@:(y c1)) + ((1{constants)&*@:(y c2))
  else.
    ((0{constants)&*@:(y solve_n 0)) + ((1{constants)&*@:(y solve_n 1))
  end.
elseif. (# coeffs) = 2 do. NB. order 1 eqn (e.g. y'+y = 0)
  r1=. y solve_n 0 NB. ge the general solution, without coefficient.
  dr1=. (r1 d. (0{deriv)) (0{val)
  constant=. res % dr1 NB. coefficient.
  constant &(y solve_n 0) NB. returning constant&r1 doesn't work, so (y solve_n 0) needed to be called again here.
end.
)

NB. solve the ordinary differential eqn
solve_ode=: conjunction define
m boundary_conditions n
)
