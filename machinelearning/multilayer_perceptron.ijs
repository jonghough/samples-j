NB. Simple Multi Layer Perceptron implementation with backprop,
NB. where the number of hidden layers is arbitrary (1 to ...). 
NB. This is really a reference /  proof of concept / testing example.
NB. Vanishing gradient problem limits the number of hidden layers
NB. that is suitable for a MLP network, but for experimenting and 
NB. playing around, it is fun to create an arbitrary number of hidden layers.
NB. 
NB.
NB. example: 
NB.
NB. 	init 2 4 4 4 3 2 1
NB. 
NB. will create a MLP with two input neurons, 1 output neuron and 5 hidden layers!
NB. The hidden layers have 4, 4, 4, 3, 2 neurons, respectively.
NB.
NB. 	result_vector fit2 training_array
NB. 
NB. will perform the training algorithm. It will loop for ITERATIONS number of
NB. iterations, with a learning rate of LEARNING_RATE.
NB. 
NB. 	validate2 validation_vector
NB.
NB. will run the validation algorithm on validation_vector, which can then be compared to the
NB. correct output.

NB. matrix product
dot=: +/ . *
NB. activation function - tanh (x)
tanh=: 7&o.@:(1&*)
NB. derivative of activation
dtanh=: (tanh f.) d. 1

NB. sigmoid
sigmoid =: %@:>:@:^@:-
dsigmoid =: (sigmoid f.) d. 1

NB. Learning rate.
LEARNING_RATE=: 0.24
NB. number of iterations for learning
NB. function to run
ITERATIONS=: 500000

NB. initialize the random weights for the learning algorithm.
NB. y - integer array, length > 2. This is the number of neurons
NB. for each layer of the NN. e.g. y = 2 4 1, has two input
NB. neurons, 4 neurons in a single hidden layer, and 1 output
NB. neuron.
init=: 3 : 0
LAYERS=: y
INPUT=: {. LAYERS
HIDDEN_LAYERS=: }:}. LAYERS
OUTPUT=: {: LAYERS


DIMEN=: 2 ((>:@:[),]) /\ LAYERS
W=: <"1 (+: %~ ?~) */"1 DIMEN

WEIGHTS=: (<"1 DIMEN) $&.> W
)

NB. the training algorithm.
fit=: 4 : 0

INPUTDATA=: y
RESULT=: x

C=: 0
while. C < ITERATIONS do.
  
  C=: C+1
  INDEX=: ?# INPUTDATA
  DATA=: (INDEX) { INPUTDATA
  EXPECTED=: (INDEX) { RESULT
  THETA=: DATA
  ALL_NET=: <DATA
  
  for_j. i. # WEIGHTS do.
    
    NET=: (|:>j{WEIGHTS) dot THETA, 1
    ALL_NET=: ALL_NET, < NET
    THETA=: (sigmoid NET)
    
  end.
  
  ERROR=: EXPECTED - THETA
  DELTA=: ERROR * dsigmoid NET
  I_DELTA=: DELTA
  
  for_j. |. i. # WEIGHTS do.
    
    if. (<:#WEIGHTS) = j do.
      
      CURRENT_WEIGHT=: (>j{WEIGHTS)
      CURRENT_NET=: >(j){ ALL_NET
      wm=: (1,~ sigmoid CURRENT_NET) *"0 1 DELTA
      w=: CURRENT_WEIGHT + LEARNING_RATE * wm
      WEIGHTS=: (<w) j} WEIGHTS

    else.
      
      NEXT_WEIGHT=: >(j+1){ WEIGHTS
      CURRENT_WEIGHT=: (>j{WEIGHTS)
      CURRENT_NET=: >(j){ ALL_NET
      m=: dsigmoid >(j+1){ ALL_NET
      CURRENT_THETA=: (>@:{&ALL_NET )`(sigmoid@:>@:{&ALL_NET )@.(0&=) j
      I_DELTA=: (( +/"1 I_DELTA *"1 1 (}: NEXT_WEIGHT)) * m)
      herror=: (((,&1@:$) $ ]) I_DELTA) dot ((1&,@:$) $ ]) (CURRENT_THETA,1)
      NEW_W=: CURRENT_WEIGHT + |: LEARNING_RATE * herror
      WEIGHTS=: (<NEW_W) j } WEIGHTS
      
    end.
  end.
end.
THETA
)


NB. Validation of NN.
validate=: 3 : 0

INPUTDATA=: y
INDEX=: INPUTDATA
smoutput DATA
DATA=: INPUTDATA
THETA=: DATA

for_j. i. # WEIGHTS do.

  smoutput 'for j = ',(":j),', ',":THETA, 1
  NET=: (|:>j{WEIGHTS) dot THETA, 1
  THETA=: (sigmoid NET)

end.

THETA
)



cleanup =: 3 : 0

if. y = <'virginica' do.
< 0 0 1
elseif. y = <'versicolor' do.
< 0 1 0
elseif. y = <'setosa' do.
< 1 0 0

elseif. 1 do.
y
end.
)
