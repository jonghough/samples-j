NB. Simple Machine Learning example, which trains logical operators.
NB. e.g. the neural net can learn AND, XOR etc.
NB. This is just a simple demo for a single hidden layer feed forward neural network.
NB.

NB. matrix product
dot=: +/ . *
NB. activation function
tanh=: 7&o.
NB. derivative of activation
dtanh=: (tanh f.) d. 1

NB. Learning rate.
LEARNING_RATE=: 0.125


init=: 3 : 0
LAYERS=: y
INPUT=: 0{LAYERS
HIDDEN=: 1{LAYERS
OUTPUT=: 2{LAYERS

NB. Here the weights are random between 0 and 0.25
NB. Ideally, random weights should be taken form range
NB. (-%%:N, %%: N), where N is number if inputs.
NB.W1=: ((INPUT+1), HIDDEN) $ %4 + (INPUT * HIDDEN) ? 45*(INPUT * HIDDEN)
NB.W2=: ((HIDDEN+1), OUTPUT) $ %4+(INPUT * HIDDEN) ? 45*(INPUT * HIDDEN)

W1=: ((INPUT+1), HIDDEN) $ 200%~ ((INPUT+1)* HIDDEN)?100
W2=: ((HIDDEN+1), OUTPUT) $ 200%~ ((HIDDEN+1)* OUTPUT)?100
)


NB. Run the training algorithm.
fit=: 4 : 0
INPUTDATA=: y
RESULT=: x


C=: 0
while. C < 5000 do.
INDEX =: ?4
DATA=: (INDEX) { INPUTDATA
DATA=: DATA, 1 NB. APPEND CONSTANT, FOR BIAS INPUT
EXPECTED=: (INDEX) { RESULT
C=: C+1
HIDDEN_NET=: (|:W1) dot DATA
HIDDEN_THETA=: tanh HIDDEN_NET
HIDDEN_THETA =: HIDDEN_THETA,1
OUT_NET=: (|:W2) dot HIDDEN_THETA
OUT_THETA=: tanh OUT_NET
NB. ERROR AND BACKPROP
ERROR=: EXPECTED - OUT_THETA
DELTA=: ERROR * dtanh OUT_NET
HIDDEN_ERRORS=: (+/ DELTA *"0 _(}: W2) * (dtanh HIDDEN_NET)) dot ((1&,@:$ $ ]), DATA)
NB. CHANGE WEIGHTS
W2=: W2 + (($W2) $, (LEARNING_RATE * DELTA) *"1 0 HIDDEN_THETA)
W1=: W1 + |: LEARNING_RATE * HIDDEN_ERRORS
end.
)


NB. Validate the solution
validate=: 3 : 0
VDATA=: y
HIDDEN_NET=: (|:W1) dot VDATA,1
HIDDEN_THETA=: tanh HIDDEN_NET
HIDDEN_THETA =: HIDDEN_THETA,1
OUT_NET=: (|:W2) dot HIDDEN_THETA
OUT_THETA=: tanh OUT_NET
)


NB. =================== TRAINING DATA ================

input=: 4 2 $ 0 0 ,1 0, 0 1, 1 1
r=: 4 1 $ 0 1 1 0

init 2 2 1
r fit input
smoutput'=== VALIDATION ==='
validate 2 1 $ 0 0
validate 2 1 $ 0 1
validate 2 1 $ 1 0
validate 2 1 $ 1 1
