NB. Extended Integration script that allows integration for
NB. some verbs that d. _1 fails for.
NB. @author Jon Hough
NB. @since 24 April 2015


NB. conjunction that takes two verbs,
NB. u and v and attempts to integrate
NB. (u*v). v (right-verb) must eventually reach
NB. a constant on continued differentiation. 
NB. (i.e. should be a finite ploynomial)
NB. If not, conjunction may cause stack overflow.
INTEGRATE =: 2 : 0
if. ('"') = >0{,>(v`'') do. NB. stopping condition
(u d. _1)* v
else.
(( u d. _1) * v) -  ((u d. _1) INTEGRATE (v d. 1))
end.
)
