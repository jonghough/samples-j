NB. bloom filter implementation
NB. This is a proof of concept implementation
NB. of a bloom filter in J. Hashing is done with openSSL's
NB. MD5 hash algorithm.

filtersize=: 100
keysize=: 10

NB. the bloom filter expressed as a boolean array
BF=: filtersize $ 0

NB. Hash function is
NB. 1. MD5 of arg
NB. 2. get bytes
NB. 3. sum bytes and take module the filtersize
hash=: monad define
str=. ":y
NB. will not work on windows
filtersize|+/ 2 dfh\ 9}. spawn_jtask_ 'echo "',str,'" | openssl md5'
)


NB. add an item to the bloom filter.
NB. Create an array of size 'keysize'
NB. and do multiple hashing for each
NB. item. These hashes are the indices
NB. to be inserted into the bloom filter.
additem=: 3 : 0
l=. (hash ":y), i.(<:keysize)
v=. +/@:(a.&i.)@:":y
H=. hash@:(v&+)@:+/
indices=. 2 H\l
smoutput indices
BF=: 1 indices}BF
)


NB. Test if y is an item in the bloom filter.
NB. Possibility of false positive.
contains=: 3 : 0
l=. (hash ":y), i.(<:keysize)
v=. +/@:(a.&i.)@:":y
H=. hash@:(v&+)@:+/
indices=. 2 H\l
NB. if a zero exists then this item
NB. was not added to the bloom filter.
-.(0 e. indices{BF)

)


NB. Add some items ot the filter.
additem&.> ('dog';'cat';'bird';'octopus';'horse';'cow';'mouse';'chicken';'salmon';'hamster';'wolf';'elephant';'pig';'sheep';'zebra')
