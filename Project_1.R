# import package
library(readxl)

# read data
survey <- read_excel("./survey.xlsx")

# variables
age <- factor(survey$A, levels = c("young", "adult", "old"))
sex <- factor(survey$S, levels = c("M", "F"))
education <- factor(survey$E, levels = c("high", "uni"))
occupation <- factor(survey$O, levels = c("emp", "self"))
residence <- factor(survey$R, levels = c("small", "big"))
transportationi <- factor(survey$T, levels = c("car", "train", "other"))

# CPTs
total <- 500

# A, P(A)
p_adult <- length(which(age == "adult")) / length(age)
p_young <- length(which(age == "young")) / length(age)
p_old <- length(which(age == "old")) / length(age)
cpt_a <- c(p_young, p_adult, p_old)
names(cpt_a) <- c("young", "adult", "old")
print(cpt_a)

# S, P(S)
p_m <- length(which(sex == "M")) / length(sex)
p_f <- length(which(sex == "F")) / length(sex)
cpt_s <- c(p_m, p_f)
names(cpt_s) <- c("M", "F")
print(cpt_s)

# E, P(E | A, S)

e_get_p <- function(a, s, e) {
  return(length(which(survey$A == a & survey$S == s & survey$E == e)) /
           length(which(survey$A == a & survey$S == s)))
}

p_high_adult_m <- e_get_p("adult", "M", "high")
p_uni_adult_m <- 1 - p_high_adult_m
p_high_adult_f <- e_get_p("adult", "F", "high")
p_uni_adult_f <- 1 - p_high_adult_f
p_high_young_m <- e_get_p("young", "M", "high")
p_uni_young_m <- 1 - p_high_young_m
p_high_young_f <- e_get_p("young", "F", "high")
p_uni_young_f <- 1 - p_high_young_f
p_high_old_m <- e_get_p("old", "M", "high")
p_uni_old_m <- 1 - p_high_old_m
p_high_old_f <- e_get_p("old", "F", "high")
p_uni_old_f <- 1 - p_high_old_f

cpt_e <- matrix(c(p_high_adult_m, p_uni_adult_m,
                  p_high_adult_f, p_uni_adult_f,
                  p_high_young_m, p_uni_young_m,
                  p_high_young_f, p_uni_young_f,
                  p_high_old_m, p_uni_old_m,
                  p_high_old_f, p_uni_old_f), nrow = 6, ncol = 2, byrow = TRUE)

colnames(cpt_e) <- c("high", "uni")
rownames(cpt_e) <- c("adult_M", "adult_F", "young_M", "young_F",
                     "old_M", "old_F")
print(cpt_e)

# O, P(O | A, S)

o_get_p <- function(e, o) {
  return(length(which(survey$E == e & survey$O == o)) /
           length(which(survey$E == e)))
}

p_emp_high <- o_get_p("high", "emp")
p_self_high <- 1 - p_emp_high
p_emp_uni <- o_get_p("uni", "emp")
p_self_uni <- 1 - p_emp_uni

cpt_o <- matrix(c(p_emp_high, p_self_high,
                  p_emp_uni, p_self_uni), nrow = 2, ncol = 2, byrow = TRUE)
colnames(cpt_o) <- c("emp", "self")
rownames(cpt_o) <- c("high", "uni")
print(cpt_o)

# R, P(R | A, S)

r_get_p <- function(e, r) {
  return(length(which(survey$E == e & survey$R == r)) /
           length(which(survey$E == e)))
}

p_small_high <- r_get_p("high", "small")
p_big_high <- 1 - p_small_high
p_small_uni <- r_get_p("uni", "small")
p_big_uni <- 1 - p_small_uni

cpt_r <- matrix(c(p_small_high, p_big_high,
                  p_small_uni, p_big_uni), nrow = 2, ncol = 2, byrow = TRUE)
colnames(cpt_r) <- c("small", "big")
rownames(cpt_r) <- c("high", "uni")
print(cpt_r)

# T, P(T | R)

t_get_p <- function(o, r, t) {
  return(length(which(survey$O == o & survey$R == r & survey$T == t)) /
           length(which(survey$O == o & survey$R == r)))
}

p_car_emp_small <- t_get_p("emp", "small", "car")
p_train_emp_small <- t_get_p("emp", "small", "train")
p_other_emp_small <- 1 - p_car_emp_small - p_train_emp_small
p_car_emp_big <- t_get_p("emp", "big", "car")
p_train_emp_big <- t_get_p("emp", "big", "train")
p_other_emp_big <- 1 - p_car_emp_big - p_train_emp_big
p_car_self_small <- t_get_p("self", "small", "car")
p_train_self_small <- t_get_p("self", "small", "train")
p_other_self_small <- 1 - p_car_self_small - p_train_self_small
p_car_self_big <- t_get_p("self", "big", "car")
p_train_self_big <- t_get_p("self", "big", "train")
p_other_self_big <- 1 - p_car_self_big - p_train_self_big

cpt_t <- matrix(c(p_car_emp_small, p_train_emp_small,p_other_emp_small,
                  p_car_emp_big, p_train_emp_big, p_other_emp_big,
                  p_car_self_small, p_train_self_small, p_other_self_small,
                  p_car_self_big, p_train_self_big, p_other_self_big),
                nrow = 4, ncol = 3, byrow = TRUE)
colnames(cpt_t) <- c("car", "train", "other")
rownames(cpt_t) <- c("emp_small", "emp_big", "self_small", "self_big")
print(cpt_t)
