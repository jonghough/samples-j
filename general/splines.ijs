NB. Spline matrices in J
NB. B-spline matrix
matBSpline =: 6%~ 4 4 $ _1 3 _3 1 3 _6 3 0 _3 0 3 0 1 4 1 0
NB. Catmull-Rom spline matrix
matCRS =: 2%~ 4 4 $ _1 3 _3 1 2 _5 4 _1 _1 0 1 0 0 2 0 0

NB. define 4 points
p0 =: 0 0 0
p1 =: 0 0.5 12.5
p2 =: 3 4.6 18.1
p3 =: 7.5 10.3 25.0

NB. matrix of points
 pts =: 4 3 $ p0,p1,p2,p3

NB. catmull rom
m =: matCRS +/ .* pts

calcTime =: (^&(i.4))

NB. get some time samples in [0,1]
t =: calcTime"(0) 10%~ >:i. 10

t +/ .* m

