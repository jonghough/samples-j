NB.  Verbs for finding analytic solutions of some ordinary differential
NB. equations, of orders 1 and 2.

NB. Get roots of polynomial
roots=: >@:(1&{)@p.


solve=: 1 : ' (roots m) getExponential'
solveN=: 2 : '(n{ (roots m)) getExponential'
NB. Get duplicate count of a list of numbers.
dups=: (~. ,: #/.~)@/:~

NB. Gets the solution for
NB. a single summand, that is, single exponential.
getExponential=: 1 : '^@:(m&*)'

NB. Caluclates individual summand solutions
NB. for the given polynomial and derivative and puts them
NB. into a gerund array.
solveN2=: dyad define
rt=. dups roots y
num=. i. 0{#"1 rt
sols=. ''
for_j. num do.
  if. 1<( >1{j{"1<"0 rt) do.
    cnt=. 0
    
    duplicates=. j{"1 rt
    while. cnt < 1{duplicates do.
      sols=. sols`(((^&cnt)*((0{duplicates) getExponential)) d. x)
      cnt=. cnt+1
    end.
  else.
    sols=. sols`((( 0{j{"1 rt)getExponential) d. x)
  end.
end.
sols
)

NB. Solve linear ODE of any order.
solveNow=: conjunction define
coeffs=. y 			NB. polynomial coefficients
deriv=. >0{ x 			NB. the orders of derivatives
val=. >1{ x 			NB. values to put in
res=. >2{ x 			NB. the values' results, i.e. y^(deriv)(val) = res
NB. slight hack. Need to get the actual summands
NB. (i.e. d. 0 derivatives), for the cases when
NB. the d. 0 derivatives are not in the boundary conditions.
summands0=. 0 solveN2"0 _ coeffs
summands=. deriv solveN2"0 _ coeffs
sm=. (summands)( 4 :'x`:6 y')"0 val	NB. evaluate each summand with corresponding argument value.
mat=. (j./@:(x:"0)@:+.)"0(%.sm) 	NB. if real matrix, try to use extended precision.
constants=. mat (+/ . *) res		NB. Calculate the constant coefficients of the summands.
len=. # constants
expression=. '' 			NB. the final expression.
NB. Loop through the constants and attach them to
NB. corresponding summand verb.
for_j. i.len do.
  c=. j{constants
  expression=. expression`+`(c&*@:((j{summands0)`:6))
end.
((>:i.<:#expression){expression)`:6 NB. we want to remove the leading '+' from the output verb.
)
