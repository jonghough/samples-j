# samples-j
Samples of J scripts.
------
1. Differential Equations
-----
Scripts to solve analytically some ordinary differential equations.
example: solve <b>y'' + 3y' + 2y = 0</b>, boundary conditions <b>y(0) = 1, y'(0) = -1</b>

          ]solution =: (0 1; 0 0; 0 _1) solve_ode 2 3 1

returns: 
          
          (1x&*@:(^@:(_2x&*)) + _1x&*@:(^@:(_1x&*)))
