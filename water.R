library(ggplot2)
library(pROC)
library(iml)
library(dplyr)
water <- read.csv("C:/Users/Willi/OneDrive/Desktop/HW/LIS 4930/Water Quality Testing.csv")
stopifnot(all(c("pH","Turbidity") %in% names(water)))

set.seed(42)

# 1) Split
idx <- sample(seq_len(nrow(water)), size = floor(0.7 * nrow(water)))
train_dataset <- water[idx, ]
test_dataset  <- water[-idx, ]

# 2) Create target INSIDE each split (your rule-based label)
train_dataset$Unsafe <- ifelse(train_dataset$pH <= 7.35 | train_dataset$pH >= 8, 1, 0)
test_dataset$Unsafe  <- ifelse(test_dataset$pH <= 7.35 | test_dataset$pH >= 8, 1, 0)

# 3) Fit logistic regression on TRAIN  (IMPORTANT: rebuild model here)
model <- glm(Unsafe ~ pH + Turbidity, data = train_dataset, family = binomial)

# 4) Predict probabilities on TEST
test_dataset$pred_prob <- predict(model, newdata = test_dataset, type = "response")

# 5) iml data (features only)
X_train <- train_dataset %>% select(pH, Turbidity)
X_test  <- test_dataset  %>% select(pH, Turbidity)

pred_fun <- function(m, newdata) predict(m, newdata = newdata, type = "response")

predictor_iml <- Predictor$new(
  model = model,
  data  = X_train,
  y     = train_dataset$Unsafe,
  predict.function = pred_fun
)

# pick case: borderline or high-risk
threshold <- 0.45
i_border <- which.min(abs(test_dataset$pred_prob - threshold))
i_high   <- which.max(test_dataset$pred_prob)

# 6) SHAP (Shapley) for one case
shap_border <- Shapley$new(predictor_iml, x.interest = X_test[i_border, , drop = FALSE])
shap_high   <- Shapley$new(predictor_iml, x.interest = X_test[i_high, , drop = FALSE])

plot(shap_border)
plot(shap_high)

# ----------------ROC------------------------
stopifnot(all(c("pH","Turbidity") %in% names(water)))

set.seed(42)

# 1) Split
idx <- sample(seq_len(nrow(water)), size = floor(0.7 * nrow(water)))
train_dataset <- water[idx, ]
test_dataset  <- water[-idx, ]

# 2) Create target INSIDE each split (rule-based label example)
train_dataset$Unsafe <- ifelse(train_dataset$pH <= 7.35 | train_dataset$pH >= 8, 1, 0)
test_dataset$Unsafe  <- ifelse(test_dataset$pH <= 7.35 | test_dataset$pH >= 8, 1, 0)

# 3) Fit logistic regression on TRAIN
model <- glm(Unsafe ~ pH + Turbidity,
             data = train_dataset,
             family = binomial)

# 4) Predict probabilities on TEST
test_dataset$pred_prob <- predict(model,
                                  newdata = test_dataset,
                                  type = "response")

# 5) ROC + AUC
roc_obj <- roc(response = test_dataset$Unsafe,
               predictor = test_dataset$pred_prob)

plot(roc_obj, main = "ROC Curve (Logistic Regression)")

print(auc(roc_obj))
