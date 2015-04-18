NB. Differential equation solver for Euler's equations. i.e.
NB. equations of the form ax^2y'' + bxy' +cy = 0, where y = y(x)
NB. Currently solutions assume values of x is positive.

euler=: ((0&{) , ((1&{) - (2&{)) , ((2&{)))


solve=: 1 : 0
sols=: m
if. (# sols ) = 2 do.
  if. =/ sols do.
    ((>:)*(^@:(_1x&*)))
  elseif. 1 do. (m&^)~
  end.
else.
  ^&m
end.
)


solve_n_euler=: 2 : '(n{ (roots m)) solve'

NB. solves general case of euler eqn with
NB. complex roots, without constant coefficients.
NB. constants must be calculated from boundary conditions.
solve_for_complex=: 3 : 0
comproot=. y
'r i'=. +. comproot
((^&r)*((2&o.)@:(i&*)@:^.))`((^&r)*((1&o.)@:(i&*)@:^.))
)

NB. Returns the given index verb form of the gerund solution.
comp_func=: conjunction define
gerund=: m
index=: n
((index{gerund)`:6)
)

NB. Solve the Euler egn diff egn for complex roots.
NB. i.e. solution is expected to hold circle functions.
comp_bounds=: conjunction define
coeffs=. euler y
deriv=. >0{ x NB. the orders of derivatives
val=. >1{ x NB. values to put in
res=. >2{ x NB. the values' results, i.e. y^(deriv)(val) = res

r1=. 0 { roots coeffs NB. gets the first root (second root is conjugate)

compgerund=. solve_for_complex r1
dr1=. ((compgerund comp_func 0) d. (0{deriv)) (0{val)
dr2=. ((compgerund comp_func 1) d. (0{deriv)) (0{val)
dr3=. ((compgerund comp_func 0) d. (1{deriv)) (1{val)
dr4=. ((compgerund comp_func 1) d. (1{deriv)) (1{val)

mat=. (2 2) $ dr1, dr2, dr3, dr4
mat=. %. mat
constants=. mat (+/ . *) res
(0{constants)&*@:(compgerund comp_func 0) + (1{constants)&*@:(compgerund comp_func 1)
)

NB. Solves euloer eqn differnetial equation for positive
NB. real arguments of boundary conditions.
NB. i.e. y(x) for x > 0
boundary_conditions_euler=: conjunction define

coeffs=. euler y NB. polynomial coefficients
deriv=. >0{ x NB. the orders of derivatives
val=. >1{ x NB. values to put in
res=. >2{ x NB. the values' results, i.e. y^(deriv)(val) = res
NB.if. (# coeffs) = 3 do. NB. Quadratic ODE (e.g. y''+y'+y = 0)
if. 0 (e.>) val do.
  smoutput 'Cannot have non-positive arguments in boundary conditions.'
  0
else.
  if. (<datatype 0{roots coeffs) = <'complex' do.
    x comp_bounds y
  else.
    if. =/ (roots coeffs) do.
      c1=. 1 :'^&(0{ (roots m))'
      c2=. 1 :'^.*(^&(0{ (roots m)))'
      r1=. coeffs c1
      r2=. coeffs c2
NB. non-repeating roots. Get the two summands of the
NB. solution independently.
    else.
      r1=. coeffs solve_n_euler 0
      r2=. coeffs solve_n_euler 1
    end.
    dr1=. (r1 d. (0{deriv)) (0{val)
    dr2=. (r2 d. (0{deriv)) (0{val)
    dr3=. (r1 d. (1{deriv)) (1{val)
    dr4=. (r2 d. (1{deriv)) (1{val)
    mat=. (2 2) $ dr1, dr2, dr3, dr4
    mat=. %. mat
    constants=. mat (+/ . *) res
    if. =/ (roots coeffs) do.
      ((0{constants)&*@:(coeffs c1)) + ((1{constants)&*@:(coeffs c2))
    else.
      ((0{constants)&*@:(coeffs solve_n_euler 0)) + ((1{constants)&*@:(coeffs solve_n_euler 1))
    end.
  end.
end.
)


solve_euler_ode=: conjunction define
m boundary_conditions_euler n
)