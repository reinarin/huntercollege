HW4
================
Reina Li
9/30/2021

# 1. Evaluate the power differences between the multivariate T2 test and other options try to use at least 10,000 samples

## a) Use the code in the example as a starting point. Simulate data so that the average pictoral test is 1 unit higher in d2.

``` r
# load libraries
library(dplyr)
library(ggplot2)
library(here)
library(mvtnorm)
```

``` r
start_data <- as.matrix(table_5_1[-1])
(mu <- colMeans(start_data))
```

    ## pictoral    paper     tool    vocab 
    ## 14.15625 14.90625 21.92188 22.34375

``` r
(Sigma <- cov(start_data))
```

    ##           pictoral     paper     tool     vocab
    ## pictoral 10.387897  7.792659 15.29812  5.374008
    ## paper     7.792659 16.657738 13.70685  6.175595
    ## tool     15.298115 13.706845 57.05729 15.932044
    ## vocab     5.374008  6.175595 15.93204 22.133929

``` r
cor(start_data)
```

    ##           pictoral     paper      tool     vocab
    ## pictoral 1.0000000 0.5923983 0.6283745 0.3544094
    ## paper    0.5923983 1.0000000 0.4446046 0.3216189
    ## tool     0.6283745 0.4446046 1.0000000 0.4483185
    ## vocab    0.3544094 0.3216189 0.4483185 1.0000000

``` r
t2_stat <- function(prob, p, nu) {
  # based on Eq 5.7
  qf(p = prob,  df1 = p, df2 = nu - p + 1) * 
    nu * p/(nu - p + 1)
}
```

``` r
set.seed(1234)
calc_t2_stat <- function(x, y) {
  calcs <- list(x, y) %>%
    purrr::map(function(i) {
      list(y = colMeans(i),
           S = cov(i),
           n = nrow(i))
    })
  
  
  S_pl <- 1 / (calcs[[1]]$n + calcs[[2]]$n - 2) *
    (((calcs[[1]]$n - 1) * calcs[[1]]$S) + ((calcs[[2]]$n - 1) * calcs[[2]]$S))
  
  S_pl12 <- S_pl[1:2,1:2]
  S_pl34 <- S_pl[3:4,3:4]
  
  T2 <-
    (calcs[[1]]$n * calcs[[2]]$n) / (calcs[[1]]$n + calcs[[2]]$n) *
    t(calcs[[1]]$y - calcs[[2]]$y) %*% solve(S_pl) %*% (calcs[[1]]$y - 
                                                          calcs[[2]]$y)
  
  T2_val_12 <- (calcs[[1]]$n * calcs[[2]]$n)/(calcs[[1]]$n + calcs[[2]]$n) * 
    t(matrix(data=c(calcs[[1]]$y[1]-calcs[[2]]$y[1],
    calcs[[1]]$y[2]-calcs[[2]]$y[2]))) %*% solve(S_pl12) %*% 
    (matrix(data=c(calcs[[1]]$y[1]-calcs[[2]]$y[1],calcs[[1]]$y[2]-calcs[[2]]$y[2])))
  T2_val_34 <- (calcs[[1]]$n * calcs[[2]]$n)/(calcs[[1]]$n + calcs[[2]]$n) * 
    t(matrix(data=c(calcs[[1]]$y[3]-calcs[[2]]$y[3],
    calcs[[1]]$y[4]-calcs[[2]]$y[4]))) %*% solve(S_pl12) %*% 
    (matrix(data=c(calcs[[1]]$y[3]-calcs[[2]]$y[3],
    calcs[[1]]$y[4]-calcs[[2]]$y[4])))
  
  test_stat_12 <- (calcs[[1]]$n + calcs[[2]]$n - 2 - 2) * ((T2 - T2_val_12) / 
    (calcs[[1]]$n + calcs[[2]]$n - 2 + T2_val_12))
  test_stat_34 <- (calcs[[1]]$n + calcs[[2]]$n - 2 - 2) * ((T2 - T2_val_34) / 
    (calcs[[1]]$n + calcs[[2]]$n - 2 + T2_val_34))
  
  hypo_test12 <- 'Blank'
  
  if (test_stat_12 > T2_val_12) {
  hypo_test12 <-'Reject'
} else {
  hypo_test12 <- 'Fail to reject'
}
  
  hypo_test34 <- 'Blank'
  
  if (test_stat_34 > T2_val_34) {
  hypo_test34 <-'Reject'
} else {
  hypo_test34 <- 'Fail to reject'
}
  
  list(S_pl = S_pl,
       S_pl12 = S_pl12,
       S_pl34 = S_pl34,
       T2_val_12 = as.numeric(T2_val_12),
       T2_val_34 = as.numeric(T2_val_34),
       test_stat_12 = as.numeric(test_stat_12),
       test_stat_34 = as.numeric(test_stat_34),
       hypo_test12 = hypo_test12,
       hypo_test34 = hypo_test34,
       # convert from matrix to atomic
       T2 = as.numeric(T2))
}
```

``` r
# test at least 10,000 samples
test_char <- purrr::map_dfr(1:10000, function(iter) {
  d1 <- rmvnorm(100, mean = mu, sigma = Sigma)
  
  mu2 <- mu
  # The average pictoral test is 1 unit higher in d2
  mu2[1] <- mu2[1] + 1
  d2 <- rmvnorm(100, mean = mu2, sigma = Sigma)
  
  t2_stat_samp <- calc_t2_stat(d1, d2)
  t2_comp <- t2_stat(1 - .05, p = ncol(d1), nrow(d1) + nrow(d2) - 2)
  
  # calculate univariate tests for each column and extract p.value
  uni_t_tests <- purrr::map_dbl(1:ncol(d1), function(j) {
    t.test(d1[,j], d2[,j] )$p.value
  })
  
  a_vect <- solve(t2_stat_samp$S_pl) %*% (colMeans(d1) - colMeans(d2))
  # turn a_vect into a vector instead of a column vector
  a_vect <- abs(as.numeric(a_vect))
  data.frame(
    T2 = t2_stat_samp$T2,
    t2_comp = t2_comp,
    
    pictoral_uni_t_test = uni_t_tests[1],
    paper_uni_t_test = uni_t_tests[2],
    tool_uni_t_test = uni_t_tests[3],
    vocab_uni_t_test = uni_t_tests[4],
    
    pictoral_discrim = a_vect[1],
    paper_discrim = a_vect[2],
    tool_discrim = a_vect[3],
    vocab_discrim = a_vect[4],
    
    # new columns
    T2_pictoral_paper = t2_stat_samp$T2_val_12,
    T2_comp_pictoral_paper = t2_stat_samp$test_stat_12,
    hypo_test12 = t2_stat_samp$hypo_test12,
    T2_tool_vocab = t2_stat_samp$T2_val_34,
    T2_comp_tool_vocab = t2_stat_samp$test_stat_34,
    hypo_test34 = t2_stat_samp$hypo_test34
  )
})
```

------------------------------------------------------------------------

## b) What’s the power of detecting a difference in d1 and d2 using the multivariate T2?

``` r
mean(with(test_char, T2 > t2_comp))
```

    ## [1] 0.7023

The power of detecting a difference in d1 and d2 using the multivariate
T2 is 0.7023.

------------------------------------------------------------------------

## c) What’s the power of finding a difference in just the pictoral column?

``` r
mean(with(test_char, pictoral_uni_t_test < .05))
```

    ## [1] 0.5823

The power of finding a difference in just the pictoral column is 0.5823.

------------------------------------------------------------------------

### Comment on the difference between this and the previous power.

The power of detecting a difference in d1 and d2 using the multivariate
T2 is greater than the power of finding a difference in just the
pictoral column. That means that there is a smaller risk of committing
Type 2 errors for the former. The latter has a larger risk of committing
Type 2 errors.

------------------------------------------------------------------------

## d) What’s the power of finding a difference between the two data sets using procedure 1 or procedure 2 in the book? What’s the problem with using these two methods?

``` r
# procedure 1
t.test(pictoral ~ gender, data = table_5_1)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  pictoral by gender
    ## t = -5.4173, df = 57.634, p-value = 1.234e-06
    ## alternative hypothesis: true difference in means between group F and group M is not equal to 0
    ## 95 percent confidence interval:
    ##  -4.964642 -2.285358
    ## sample estimates:
    ## mean in group F mean in group M 
    ##        12.34375        15.96875

``` r
t.test(paper ~ gender, data = table_5_1)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  paper by gender
    ## t = -2.0066, df = 60.249, p-value = 0.04928
    ## alternative hypothesis: true difference in means between group F and group M is not equal to 0
    ## 95 percent confidence interval:
    ##  -3.993501043 -0.006498957
    ## sample estimates:
    ## mean in group F mean in group M 
    ##        13.90625        15.90625

``` r
t.test(tool ~ gender, data = table_5_1)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  tool by gender
    ## t = -7.7748, df = 61.966, p-value = 9.765e-11
    ## alternative hypothesis: true difference in means between group F and group M is not equal to 0
    ## 95 percent confidence interval:
    ##  -13.238961  -7.823539
    ## sample estimates:
    ## mean in group F mean in group M 
    ##        16.65625        27.18750

``` r
t.test(vocab ~ gender, data = table_5_1)
```

    ## 
    ##  Welch Two Sample t-test
    ## 
    ## data:  vocab by gender
    ## t = -0.68791, df = 58.235, p-value = 0.4942
    ## alternative hypothesis: true difference in means between group F and group M is not equal to 0
    ## 95 percent confidence interval:
    ##  -3.176558  1.551558
    ## sample estimates:
    ## mean in group F mean in group M 
    ##         21.9375         22.7500

``` r
# sample experiment wise false positive rate
mean(with(test_char, pictoral_uni_t_test < .05 | paper_uni_t_test < .05 | 
            tool_uni_t_test < .05 | vocab_uni_t_test < .05))
```

    ## [1] 0.6436

``` r
# expected experiment wise false positive
1 - (1 - .05)^4
```

    ## [1] 0.1854938

``` r
# procedure 2
# sample experiment wise false positive rate (bonferroni correction)
mean(with(test_char, pictoral_uni_t_test < .05/4 | paper_uni_t_test < .05/4 | 
            tool_uni_t_test < .05/4 | vocab_uni_t_test < .05/4))
```

    ## [1] 0.394

``` r
# expected bonferroni correction fp
1 - (1 - .05/4)^4
```

    ## [1] 0.04907029

The power of finding a difference between the two data sets using
procedure 1 is 0.6436.

The power of finding a difference between the two data sets using
procedure 2 is 0.394.

(pages 140-141)

In the book, procedure 1 is performing univariate t-tests, one for each
variable.Procedure 2 is adjusting the
![\\alpha](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Calpha "\alpha")-level
resulting from performing the p tests (use Bonferroni critical value
![t\_{\\alpha/2p,n\_{1}+n\_{2}-2}](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;t_%7B%5Calpha%2F2p%2Cn_%7B1%7D%2Bn_%7B2%7D-2%7D "t_{\alpha/2p,n_{1}+n_{2}-2}")).

They are both univariate approaches that do not use covariances or
correlations among the variables when computing the test statistic. The
problem with using these two methods is that we are performing only
univariate tests with no T2-test. The overall
![\\alpha](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Calpha "\alpha")
in procedure 1 is too high, and the overall
![\\alpha](https://latex.codecogs.com/png.image?%5Cdpi%7B110%7D&space;%5Cbg_white&space;%5Calpha "\alpha")
in procedure 2 is too low. But it these procedures are only performed
*after* T2-test rejects, then the tests will reject less often
(experimentwise error rates change).

------------------------------------------------------------------------

## e) What’s the power of the pictoral column having the largest determinant value given the multivariate T2 was significant?

``` r
mean(with(test_char, pictoral_discrim > paper_discrim & pictoral_discrim > 
            tool_discrim & pictoral_discrim > vocab_discrim & T2 > t2_comp))
```

    ## [1] 0.6985

The power of the pictoral column having the largest discriminant value
given the multivariate T2 was significant is 0.6985.

------------------------------------------------------------------------

# 2. Evaluate the ‘additional information’ T2 statistics.

## a) Using the parameters above, add a new ‘column’ to the output data frame which checks to see how often:

### 1. The first two columns (pictoral and paper) help split the data

### 2. The second two columns (tool and vocab) help to split the data

``` r
# show first 6 rows
head(test_char)
```

    ##          T2  t2_comp pictoral_uni_t_test paper_uni_t_test tool_uni_t_test
    ## 1 24.517026 9.820648         0.050154297       0.38086102      0.08959313
    ## 2 12.528215 9.820648         0.001914714       0.07162001      0.06434065
    ## 3  9.889328 9.820648         0.027632964       0.88301714      0.26738399
    ## 4  7.991805 9.820648         0.023231674       0.13410366      0.90781339
    ## 5 19.723531 9.820648         0.017169753       0.47102729      0.66334138
    ## 6  9.610892 9.820648         0.193190351       0.26357438      0.99182550
    ##   vocab_uni_t_test pictoral_discrim paper_discrim tool_discrim vocab_discrim
    ## 1        0.3325459        0.2973747   0.105192750  0.085317960   0.011745672
    ## 2        0.6863933        0.1436593   0.003740256  0.010308094   0.062798439
    ## 3        0.3885927        0.1796858   0.092248308  0.009089284   0.003679254
    ## 4        0.6750570        0.1416910   0.023875296  0.039707837   0.001463635
    ## 5        0.6428331        0.2914098   0.102857006  0.060993605   0.011568250
    ## 6        0.1521051        0.1494389   0.082306208  0.005145539   0.055477816
    ##   T2_pictoral_paper T2_comp_pictoral_paper    hypo_test12 T2_tool_vocab
    ## 1         10.670069              13.006194         Reject    18.6223890
    ## 2          9.901542               2.476306 Fail to reject    25.3218529
    ## 3          9.760841               0.121214 Fail to reject     8.0540982
    ## 4          5.307420               2.587902 Fail to reject     0.2887056
    ## 5         13.101523               6.148291 Fail to reject     1.1379157
    ## 6          6.536469               2.946110 Fail to reject     4.4442576
    ##   T2_comp_tool_vocab    hypo_test34
    ## 1           5.333469 Fail to reject
    ## 2         -11.228427 Fail to reject
    ## 3           1.745683 Fail to reject
    ## 4           7.614189         Reject
    ## 5          18.292752         Reject
    ## 6           5.002169         Reject

``` r
# show last 6 rows
tail(test_char)
```

    ##              T2  t2_comp pictoral_uni_t_test paper_uni_t_test tool_uni_t_test
    ## 9995  16.743297 9.820648        0.0003083095       0.09299642      0.29195873
    ## 9996   5.358661 9.820648        0.2634179759       0.73267431      0.86871774
    ## 9997  11.532978 9.820648        0.0101592022       0.12319249      0.80262946
    ## 9998  12.346214 9.820648        0.0133546546       0.62059906      0.86319351
    ## 9999   1.332767 9.820648        0.5449353872       0.79704178      0.74343986
    ## 10000 16.616174 9.820648        0.0029093806       0.90476137      0.05153703
    ##       vocab_uni_t_test pictoral_discrim paper_discrim tool_discrim
    ## 9995        0.38106321       0.21755170   0.013063586  0.039719150
    ## 9996        0.27694383       0.13715788   0.052012948  0.022658651
    ## 9997        0.88216287       0.17125452   0.017516176  0.046202682
    ## 9998        0.50844298       0.21370131   0.037747442  0.021568901
    ## 9999        0.90012111       0.06491524   0.001178454  0.023293977
    ## 10000       0.04757928       0.20202736   0.108424039  0.005458272
    ##       vocab_discrim T2_pictoral_paper T2_comp_pictoral_paper    hypo_test12
    ## 9995    0.004311802        13.8812146              2.6475595 Fail to reject
    ## 9996    0.030511083         2.7708189              2.5263483 Fail to reject
    ## 9997    0.011787291         6.7563773              4.5723305 Fail to reject
    ## 9998    0.059834684         7.8299287              4.3005987 Fail to reject
    ## 9999    0.003346598         0.3771081              0.9442079         Reject
    ## 10000   0.041329031        15.1737545              1.3262152 Fail to reject
    ##       T2_tool_vocab T2_comp_tool_vocab    hypo_test34
    ## 9995      5.7563715         10.5686873         Reject
    ## 9996      2.1109668          3.1809753         Reject
    ## 9997      0.8783060         10.5004706         Reject
    ## 9998      1.6223043         10.5293158         Reject
    ## 9999      0.7361014          0.5884515 Fail to reject
    ## 10000    21.1510418         -4.0558056 Fail to reject

**Note: I added a few new columns to the output data frame:**

-   **T2_pictoral_paper**: this is the T2 value we calculated for
    pictoral and paper

-   **T2_comp_pictoral_paper**: this is the T2 test statistic value for
    pictoral and paper

-   **hypo_test12**:

    -   ***Reject***: Reject the hypothesis that x = (y3,y4)’ = (tool
        and vocab)’ is redundant, and conclude that x = (y3,y4)’ = (tool
        and vocab)’ adds a significant amount of separation to y =
        (y1,y2)’ = (pictoral and paper)’
    -   ***Fail to reject***: We fail to reject the hypothesis that x =
        (y3,y4)’ = (tool and vocab)’ is redundant

-   **T2_tool_vocab**: this is the T2 value we calculated for tool and
    vocab

-   **T2_comp_tool_vocab**: this is the T2 test statistic value for tool
    and vocab

-   **hypo_test34**:

    -   ***Reject***: Reject the hypothesis that x = (y1,y2)’ =
        (pictoral and paper)’ is redundant, and conclude that x =
        (y1,y2)’ = (pictoral and paper)’ adds a significant amount of
        separation to y = (y1,y2)’ = (tool and vocab)’
    -   ***Fail to reject***: We fail to reject the hypothesis that x =
        (y1,y2)’ = (pictoral and paper)’ is redundant
