HW1
================
Reina Li
8/26/2021

# 2.7

``` r
# initialize matrices
A <- matrix(data = c(1,-1,4,-1,1,3,4,3,2), ncol = 3)
B <- matrix(data = c(3,7,2,-2,1,3,4,0,5), ncol = 3)
x <- matrix(data = c(1,-1,2), ncol = 1)
y <- matrix(data = c(3,2,1), ncol =1)
```

Find the following:

1.  Bx

``` r
B %*% x
```

    ##      [,1]
    ## [1,]   13
    ## [2,]    6
    ## [3,]    9

2.  y’B

``` r
t(y) %*% B
```

    ##      [,1] [,2] [,3]
    ## [1,]   25   -1   17

3.  x’Ax

``` r
t(x) %*% A %*% x
```

    ##      [,1]
    ## [1,]   16

4.  x’Ay

``` r
t(x) %*% A %*% y
```

    ##      [,1]
    ## [1,]   43

5.  x’x

``` r
t(x) %*% x
```

    ##      [,1]
    ## [1,]    6

6.  x’y

``` r
t(x) %*% y
```

    ##      [,1]
    ## [1,]    3

7.  xx’

``` r
x %*% t(x)
```

    ##      [,1] [,2] [,3]
    ## [1,]    1   -1    2
    ## [2,]   -1    1   -2
    ## [3,]    2   -2    4

8.  xy’

``` r
x %*% t(y)
```

    ##      [,1] [,2] [,3]
    ## [1,]    3    2    1
    ## [2,]   -3   -2   -1
    ## [3,]    6    4    2

1.  B’B

``` r
t(B) %*% B
```

    ##      [,1] [,2] [,3]
    ## [1,]   62    7   22
    ## [2,]    7   14    7
    ## [3,]   22    7   41