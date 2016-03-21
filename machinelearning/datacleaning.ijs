dropfirstcolumn =: }."1
getfirstcolumn =: {."1
mineachcolumn =: <./"2
maxeachcolumn =: >./"2
normalizecolumns =: ] %"1 1 >./"2
NB. decimate the data, select 1 in 10 data points (rows)
NB. for use as validation.
decimate =: 10&*@i.@<.@(%&10)@# { ]
undecimated =: (i.@:# -. (10&*@i.@<.@(%&10)@#)) { ]