-- \\\\\\\\\\\\\\\\\\\\
-- \\\\\\\\\\\\\\\\\\\\
-- \\HASKELL PRACTICE 
-- \\\\\\\\\\\\\\\\\\\
-- \\\\\\\\\\\\\\\\\\\\
--import System.Random (randomRIO)
--import Data.List
--import Control.Monda (replicateM)

--seed = newStdGen

--randomlist :: Int -> StdGen -> [Int]
--randomlist n = take n . unfoldr (Just . random)
--randomlist 0 = []
--randomlist n = [random]:randomlist (n-1)

l1 = [2,6,1,2,72,36,12,7,2]
l2 = [[1,2],[3,4],[5,6],[7,8]]

-- #1 Powerfunc: Raise 'm' to the power of 'n'
powerfunc :: Integer -> Integer -> Integer
powerfunc _ 0 = 1
powerfunc m n = (m * (powerfunc m (n - 1)))

-- #2 Logfunc: (log m q) returns n such that (power m n) returns q.   
logfunc :: Integer -> Integer -> Integer
logfunc m q = 
	let x = quot m q
	in if (m <= q)
		then 1
		else (logfunc x q) + 1

-- #3 Comb function such that (comb n k) returns the number of combinations n-choose-k
comb n 0 = 1
comb n k = n * (comb n (k - 1))

-- #4 Insertion_Sort function such that (insertion_sort L) returns the elements of L arrange into ascending order
insertion_sort [] = []
insertion_sort (x:xs) = (insertion_helper x (insertion_sort (xs)))

insertion_helper m [] = [m]
insertion_helper m (x:xs) = 
	let 	y = x
	   	z = xs
	in if (m < x)
		then m:(x:xs)
		else y:(insertion_helper m xs)

-- #5 selection_sort 
selection_sort :: Ord a => [a] -> [a]
selection_sort [] = []
selection_sort (x:xs) = smallest x xs: selection_sort(remove (smallest x xs) (x:xs))

smallest m [] = m
smallest m (x:xs) = 
	if (x < m)
		then smallest x xs
		else smallest m xs

remove m [] = []
remove m (x:xs) = 
	if (m == x)
		then xs
		else x:remove m xs
-- #6 merge_sort
merge :: Ord a => [a] -> [a] -> [a]
merge [] ys = ys
merge xs [] = xs
merge (x:xs) (y:ys)
	| x <= y = x : merge xs (y:ys)
	| otherwise = y : merge (x:xs) ys

mergesort :: Ord a => [a] -> [a]
mergesort [] = []
mergesort [x] = [x]
mergesort xs 
	= merge (mergesort top) (mergesort bottom)
	where
	(top, bottom) = splitAt (length xs `div` 2) xs

-- #7 quick_sort
quicksort :: (Ord a) => [a] -> [a]
quicksort [] = []
quicksort (x:xs) = 
	let 	smallerSorted = quicksort [ a | a <- xs, a <= x]
		biggerSorted = quicksort [ a | a <- xs, a > x]
	in smallerSorted ++ [x] ++ biggerSorted 

-- #8-11 build BST
data BinaryTree a = Nil | BinaryNode a (BinaryTree a) (BinaryTree a)

node [] = []
node (x:xs) = x

left [] = []
left (x:xs) = (head xs)

right [] = []
right (x:xs) = (head (tail xs))

--maketree [] (y:ys) = (y:ys)
--maketree (x:xs) [] = maketree (xs) (insert x [])
--maketree (x:xs) m =  maketree (xs) (insert x m)

--insert m [] = [m] ++ [] ++ []
--insert m (x:xs) = 
--	if (m == x)
--		then [m] ++ (constree (left (x:xs))) ++ (constree (right (x:xs)))
--		else 
--			if ( x < m)
--				then [node (x:xs)] ++ (constree (left (x:xs))) ++ (insert m (right (x:xs)))
--				else [node (x:xs)] ++ (insert m (left (x:xs))) ++ (constree (right (x:xs))) 
--		
--constree [] = []
--constree (x:xs) = 
--	if ( (left (x:xs)) == [])
--		then if ( (right (x:xs)) == [])
--			then [x] ++ [] ++ []
--			else [x] ++ [] ++ (constree (right (x:xs)))
--		else 
--			if ( (right (x:xs)) == [])
--				then [x] ++ (constree (left (x:xs))) ++ []
--				else [x] ++ (constree (left (x:xs))) ++ (constree (right (x:xs)))
--			

--anonymous functions
add x y = (\a b -> a + b) x y
subt x y = (\a b -> a -b) x y
times x y = (\a b -> a * b) x y
divide x y = (\a b -> a `div` b) x y

sq x = (\a -> a*a) x
pow x y = (\a b -> a*b) x y

--Exam 1

-- #1 sequence s f n returns a list of length n that starts iwth the s such that each successive value is obtained by applying f to its predecessor
-- (sequence 2 square 5) returns (2 4 16 256 65536)

sequence s f 1 = [s]
sequence s f n = [s] ++ sequencehelp s f (n-1)

sequencehelp s f 1 = [(f s)]
sequencehelp s f n = [(f s)] ++ (sequencehelp (f s) f (n-1))

-- #2 (twist (x:xs)) reversed the top level of list (x:xs) and recursivley twists every nested sublist
-- (twist '(1 2 (a b) (3 (4 c) d) ((e f) (5 6)) g 7)) returns (7 g ((6 5) (f e)) (d (c 4) 3) (b a) 2 1)

twist [] = []
twist (x:xs) = (reverse ((reverse x) ++ (twisthelper (xs)) ))

twisthelper [] = []
twisthelper (x:xs) = (reverse x) ++ (twisthelper (xs)) 

-- #4 (mapall f (x:xs)) applies the function f to all values within all nested levels of (x:xs) that are neither paris nor null
-- (mapall square '(2 3 (4 () (5)) (( 6 (7) ((8)) ()) 9))) returns (4 9 (16 () (25)) ((36 (49) ((64)) ()) 81))

--mapall f [] = []
--mapall f (x:xs) = (mapallhelper f x) ++ (mapall f xs)

--mapallhelper f [] = []
--mapallhelper f (x:xs) = (map f x) ++ (mapallhelper f xs)

-- #5 mysqrt n returns the truncated square root of non-negative integer n
-- mysqrt 31 returns 5 because 5 <= sqrt(31) < 6

--nonefficient
mysqrt1 n = mysqrthelper1 n 1
mysqrthelper1 n p = 
	if ( p*p < n)
		then 1 + (mysqrthelper1 n (p+1))
		else 0

--efficient
--mysqrt2 n = mysqrthelper2 n (n `quot` 2)
--
--
--mysqrthelper2 n p = 
--	if (p*p == n)
--		then p
--		else if (p*p < n) 
--			then if (p*p == n)
--				then p
--				else if(
--					then mysqrthelper2 n (p + (n `quot` (p `quot` 2)))
--					else p
--			else if (p*p mysqrthelper2 n (p - (n `quot` (p `quot` 2)))
