load 'graphics/jpeg'
   
shft =: (33 b.)   

avg =: 3 : 0
amsk =. dfh 'FF000000'
rmsk =. dfh 'FF0000'
gmsk =. dfh 'FF00'
bmsk =. dfh 'FF'

g =: y AND bmsk
b =: (_8 shft y) AND bmsk
r =: (_16 shft y) AND bmsk

 (3%~ (g+b+r))

)

PATH_TO_IMAGE=: '...'
PATH_TO_OUTPUT=:'...' 

image =: readjpeg jpath PATH_TO_IMAGE




asciiart =: a. {~ 33+ 93 | (69) ([ * (<.@:%~)) avg image  NB.  (0.2;80) modcontrast image
   
l =: ' .,-!0#WX'
asciiart2 =: l {~ (#l) | (37) ([ * (<.@:%~)) avg image 

asciiart =: ": asciiart2

  ( toHOST, asciiart,"1 LF)    (1!:2)<PATH_TO_OUTPUT


modcontrast =:>@:(1&{)@[ + (>@:(0&{)@[ * ])
