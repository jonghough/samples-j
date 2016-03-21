NB. principal components analysis of datasets
load 'math/lapack'
load 'math/lapack/geev'
mean =: +/ % #
var =: (+/@(*:@(] - +/ % #)) % #)"1
stddev =: %:@var"1
dot=: +/ . *

pca =: 3 : 0
data =. y
means =. mean data
centered =. data -"1 1 means
covmatrix =: (|:centered) dot centered
NB. TODO eigenstuff (use LAPACK)
 geev_jlapack_ covmatrix
)