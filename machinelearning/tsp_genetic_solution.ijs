NB. solution to the Traveling Salesman Problem using a genetic algorithm
NB. to find the minimum cost path through all cities.

MUTATION_RATE=: 0.1 NB. rate of gene mutation after mating.
POPULATION=: 10 NB. population of chromosomes
MATING_POP=: <.POPULATION % 2
SELECTED_POP=: <.MATING_POP % 2
CITYCOUNT=: 50 NB. number of cities.

list=: (#~ </"1)@(#: i.@:(*/)) 2 # CITYCOUNT

NB. list of cities with random distances
cities=: list,"(1 1) (1,~ 2!CITYCOUNT) $ 1000 * (? (2!CITYCOUNT) # 0)
boxedcities=: <"1 ( 0 1 {"1 cities)

NB. create POPULATION chromsomes, each representing
NB. a hamiltonian path on the city network.
createChromosomes=: ] ?&.> (<"0@:(POPULATION&$))

chromosomes=: createChromosomes CITYCOUNT

NB. calculates the cost of a single chromosome,
NB. i.e. the total distance along the path
NB. represented by the chromosome.
cost=: 3 : 0
edges=. <"1 /:~"1 (2]\ > y)
+/, 2{"1 ((edges ="0 _ boxedcities) # cities)

)

NB. sort the paths, since we want the minimum cost.
sortPaths=: chromosomes /: (cost"0 chromosomes)

sortChromosomes=: ] /: cost"(0)

mate=: 3 : 0
mother=. >0{y
father=. >1{y
child1=. >2{y
child2=. >3{y
CUT=. 5

for_j. i. # mother do.
  if. j < CUT do.
    for_k. i. CITYCOUNT do.
      if. -.(k e. child1) do.
        child1=. k (j}) child1
        break.
      end.
    end.
    for_k. i.CITYCOUNT do.
      if. -.(k e. child2) do.
        child2=. (k{father) j} child2
        break.
      end.
    end.
  elseif. j > CUT do.
    for_k. i. CITYCOUNT do.
      k=. <: CITYCOUNT - k
      if. -.(k e. child1) do.
        child1=. (k) j}child1
        break.
      end.
    end.
    for_k. i.CITYCOUNT do.
      
      k=. <: CITYCOUNT - k
      if. -.((k{father) e. child2) do.
        child2=. (k{father) j}child2
        break.
      end.
    end.
    
    
  end.
end.


NB. handle mutations
mrate=. 100 * MUTATION_RATE
chance=. ?. 2 # 100
if. mrate < 0{chance do.
  mutated=. ? 2 # CITYCOUNT
  m1=. (0{mutated){child1
  m2=. (1{mutated){child1
  child1=. (m2, m1) mutated} child1
end.

chance=. ?. 2 # 100
if. mrate < 0{chance do.
  mutated=. ? 2 # CITYCOUNT
  m1=. (0{mutated){child2
  m2=. (1{mutated){child2
  child2=. (m2, m1) mutated} child2
end.

child1;child2
)


NB. iterate for x generations, where one
NB. iteration is the mating of all
NB. matable chromosomes, and the sorting
NB. of the new chromosomes by the cost function.
iterate=: 4 : 0
generations=. x
orderedPaths=. y
op=. orderedPaths
minCost=. ''
c=. 0
while. c < generations do.
  c=. c + 1
  nextchild=. MATING_POP
  for_j. i. SELECTED_POP do.
    mother=. j { op
    father=. (? SELECTED_POP) { op
    child1=. nextchild { op
    child2=. (>: nextchild) { op
    newGeneration=. mate mother,father,child1,child2
    
    op=. newGeneration (nextchild, (>: nextchild)) } op
    nextchild=. nextchild + 2
    
  end.
  
  op=. sortChromosomes op
end.
op
)
