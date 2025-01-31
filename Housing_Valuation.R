---
  title: "R Notebook"
output: html_notebook
---
  
  ```{r}
install.packages("psych")
library(psych)
install.packages("dplyr")
library(dplyr)
install.packages("caret")
library(caret)
install.packages("tidyr")
library(tidyr)
install.packages("ggplot2")
library(ggplot2)
install.packages("corrplot")
library(corrplot)
install.packages("plotly")
library(plotly)
install.packages("GGally")
library(GGally)


```

PART B
Question 1:
  ```{r}
housing_valuation <- read.csv("HousingValuation.csv")
str(housing_valuation)
housing_valuation

LotArea <- housing_valuation$LotArea
LotShape <- housing_valuation$LotShape
LandContour <- housing_valuation$LandContour
Utilities <- housing_valuation$Utilities
LotConfig <- housing_valuation$LotConfig
Slope <- housing_valuation$Slope          
DwellClass <- housing_valuation$DwellClass
OverallQuality <- housing_valuation$OverallQuality
OverallCondition <- housing_valuation$OverallCondition
YearBuilt <- housing_valuation$YearBuilt
ExteriorCondition <- housing_valuation$ExteriorCondition
BasementCondition <- housing_valuation$BasementCondition
TotalBSF <- housing_valuation$TotalBSF
CentralAir <- housing_valuation$CentralAir
LowQualFinSF <- housing_valuation$LowQualFinSF
LivingArea <- housing_valuation$LivingArea
FullBath <- housing_valuation$FullBath
HalfBath <- housing_valuation$HalfBath
BedroomAbvGr <- housing_valuation$BedroomAbvGr   
KitchenQuality <- housing_valuation$KitchenQuality  
KitchenAbvGr <- housing_valuation$KitchenAbvGr
TotalRmsAbvGrd <- housing_valuation$TotalRmsAbvGrd
Fireplaces <- housing_valuation$Fireplaces  
GarageType  <- housing_valuation$GarageType
GarageCars <- housing_valuation$GarageCars
PavedDrive <- housing_valuation$PavedDrive
PoolArea <- housing_valuation$PoolArea
OpenPorchSF <- housing_valuation$OpenPorchSF
MoSold <- housing_valuation$MoSold          
YrSold <- housing_valuation$YrSold          
SalePrice <- housing_valuation$SalePrice   

#Transform Categorical Variables into Numerical (One-hot encoding)
LotConfig_Inside <- as.numeric(housing_valuation$LotConfig == "Inside")
LotConfig_Corner <- as.numeric(housing_valuation$LotConfig == "Corner")
LotConfig_CulDSac <- as.numeric(housing_valuation$LotConfig == "CulDSac")
LotConfig_FR2 <- as.numeric(housing_valuation$LotConfig == "FR2")
LotConfig_FR3 <- as.numeric(housing_valuation$LotConfig == "FR3")



DwellClass_1Fam <- as.numeric(housing_valuation$DwellClass == "1Fam")
DwellClass_2fmCon <- as.numeric(housing_valuation$DwellClass == "2fmCon")
DwellClass_Duplex <- as.numeric(housing_valuation$DwellClass == "Duplex")
DwellClass_TwnhsE <- as.numeric(housing_valuation$DwellClass == "TwnhsE")
DwellClass_Twnhs <- as.numeric(housing_valuation$DwellClass == "Twnhs")


CentralAir_N <- as.numeric(housing_valuation$CentralAir == "N")
CentralAir_Y <- as.numeric(housing_valuation$CentralAir == "Y")


housing_valuation <- housing_valuation %>%
  mutate(GarageType = ifelse(is.na(GarageType), "NoGarage", GarageType)) #change NA to NoGarage 
GarageType_2Types <- as.numeric(housing_valuation$GarageType == "2Types")
GarageType_Attchd <- as.numeric(housing_valuation$GarageType == "Attchd")
GarageType_Basment <- as.numeric(housing_valuation$GarageType == "Basment")
GarageType_BuiltIn <- as.numeric(housing_valuation$GarageType == "BuiltIn")
GarageType_CarPort <- as.numeric(housing_valuation$GarageType == "CarPort")
GarageType_Detchd <- as.numeric(housing_valuation$GarageType == "Detchd")
GarageType_NoGrageType <- as.numeric(housing_valuation$GarageType == "NoGarage")

housing_valuation <- cbind(housing_valuation, LotConfig_Inside,LotConfig_Corner, LotConfig_CulDSac, LotConfig_FR2, LotConfig_FR3, DwellClass_1Fam, DwellClass_2fmCon, DwellClass_Duplex, DwellClass_TwnhsE, DwellClass_Twnhs, CentralAir_N, CentralAir_Y, GarageType_2Types, GarageType_Attchd, GarageType_Basment, GarageType_BuiltIn, GarageType_CarPort, GarageType_Detchd, GarageType_NoGrageType)

housing_valuation$LotConfig <- NULL
housing_valuation$DwellClass <- NULL
housing_valuation$CentralAir <- NULL
housing_valuation$GarageType <- NULL
housing_valuation$Id <- NULL


#Convert Categorical Variables to Factor
housing_valuation$LotShape <- factor(housing_valuation$LotShape, levels = 1:4, labels = c(0, 1, 2, 3))
housing_valuation$LotShape <- as.numeric(as.character(housing_valuation$LotShape))

housing_valuation$LandContour <- factor(housing_valuation$LandContour, c("Lvl","Bnk","HLS","Low"), labels = c(0,1,2,3))
housing_valuation$LandContour <- as.numeric(as.character(housing_valuation$LandContour))

housing_valuation$Utilities <- factor(housing_valuation$Utilities, c("AllPub","NoSeWr","NoSeWa","ELO"), labels = c(0,1,2,3))
housing_valuation$Utilities <- as.numeric(as.character(housing_valuation$Utilities))

housing_valuation$Slope <- factor(housing_valuation$Slope, c("Gtl","Mod","Sev"), labels = c(0,1,2))
housing_valuation$Slope <- as.numeric(as.character(housing_valuation$Slope))

housing_valuation$OverallQuality <- factor(housing_valuation$OverallQuality, levels = 1:10, labels = 0:9)
housing_valuation$OverallQuality <- as.numeric(as.character(housing_valuation$OverallQuality))


housing_valuation$OverallCondition <- factor(housing_valuation$OverallCondition, levels = 1:10, labels = 0:9)
housing_valuation$OverallCondition <- as.numeric(as.character(housing_valuation$OverallCondition))

housing_valuation$ExteriorCondition <- factor(housing_valuation$ExteriorCondition, c("Ex","Gd","TA","Fa","Po"), labels = c(0,1,2,3,4))
housing_valuation$ExteriorCondition <- as.numeric(as.character(housing_valuation$ExteriorCondition))

housing_valuation$BasementCondition <- factor(housing_valuation$BasementCondition, c("Ex","Gd","TA","Fa","Po","NB"), labels = c(0,1,2,3,4,5))
housing_valuation$BasementCondition <- as.numeric(as.character(housing_valuation$BasementCondition))

housing_valuation$KitchenQuality <- factor(housing_valuation$KitchenQuality, c("Ex","Gd","TA","Fa","Po"), labels = c(0,1,2,3,4))
housing_valuation$KitchenQuality <- as.numeric(as.character(housing_valuation$KitchenQuality))

housing_valuation$PavedDrive <- factor(housing_valuation$PavedDrive, c("Y","P","N"), labels = c(0,1,2))
housing_valuation$PavedDrive <- as.numeric(as.character(housing_valuation$PavedDrive))


View(housing_valuation)


```


Question 2
```{r}

continuous_vars <- c("LotArea", "TotalBSF", "LowQualFinSF", "LivingArea",  "OpenPorchSF","PoolArea","SalePrice")

# Loop through each continuous variable and print the summary statistics
for (var in continuous_vars) {
  cat("\n", var, ":\n")
  cat("Mean:", round(mean(housing_valuation[[var]], na.rm = TRUE), 4), "\n")
  cat("Median:", round(median(housing_valuation[[var]], na.rm = TRUE), 4), "\n")
  cat("Max:", max(housing_valuation[[var]], na.rm = TRUE), "\n")
  cat("Standard Deviation:", round(sd(housing_valuation[[var]], na.rm = TRUE), 4), "\n")
}

```
```{r}
# Count for each categorical variable
categorical_vars <- c("LotArea", "LotShape", "LandContour", "Utilities", "LotConfig_Inside",
                      "LotConfig_Corner", "LotConfig_CulDSac", "LotConfig_FR2", 
                      "LotConfig_FR3", "Slope", 
                      "DwellClass_1Fam", "DwellClass_2fmCon", "DwellClass_Duplex", 
                      "DwellClass_TwnhsE", "DwellClass_Twnhs", "OverallQuality", 
                      "OverallCondition", "YearBuilt", "ExteriorCondition", 
                      "BasementCondition", "TotalBSF", "CentralAir_N", "CentralAir_Y", 
                      "LowQualFinSF", "LivingArea", "FullBath", "HalfBath", 
                      "BedroomAbvGr", "KitchenQuality", "KitchenAbvGr", 
                      "TotalRmsAbvGrd", "Fireplaces", "GarageType_2Types", 
                      "GarageType_Attchd", "GarageType_Basment", "GarageType_BuiltIn", 
                      "GarageType_CarPort", "GarageType_Detchd", "GarageType_NoGarageType", 
                      "GarageCars", "PavedDrive", "PoolArea", "OpenPorchSF", "MoSold", 
                      "YrSold", "SalePrice")

# Create an empty data frame with row numbers 0 to 9
result_df <- data.frame(row.names = 0:9)

# Loop through each categorical variable
for (var in categorical_vars) {
  # Calculate the counts for each category (0:9) for the variable
  category_counts <- table(factor(housing_valuation[[var]], levels = 0:9))
  
  # Add the category counts as a column in the data frame
  result_df[[var]] <- as.numeric(category_counts)
}

# Display the resulting data frame
print(result_df)
```


Question 3
```{r}
continuous_vars <- housing_valuation %>% select("LotArea", "TotalBSF", "LowQualFinSF", "LivingArea",  "OpenPorchSF", "PoolArea", "SalePrice")
# Pivot the data to long format and create histograms
continuous_vars %>% keep(is.numeric) %>% 
  gather() %>% 
  ggplot(aes(value)) + 
  facet_wrap(~ key, scales = "free") + 
  geom_histogram() + 
  labs(title = "Histograms of Continuous Variables", x = "Value", y = "Frequency") +  
  theme_minimal()

summary(continuous_vars)
```



Question 4
```{r}
#Checking missing value
missing_values <- colSums(is.na(housing_valuation))
cat("\n", "The variable have missing value: ", "\n")
missing_values[missing_values > 0]

#Replacing all NAs with 0
zero_transformed <- housing_valuation
zero_transformed[is.na(zero_transformed)] <- 0
sum(is.na(zero_transformed)) 
#Selected Column "YearBuilt"
plot(density(zero_transformed$YearBuilt), col="red",  
     main="Year Built Original (Blue) vs Zero Transformed (Red)")  
lines(density(housing_valuation$YearBuilt, na.rm = TRUE), col="blue")
#Selected Column "LivingArea"
plot(density(zero_transformed$LivingArea), col="red",  
     main="Living Area Original (Blue) vs Zero Transformed (Red)")  
lines(density(housing_valuation$LivingArea, na.rm = TRUE), col="blue")


#Replacing missing values with the mean 
mean_transformed <- housing_valuation
#Selected Column "YearBuilt"
mean_transformed$YearBuilt[is.na(mean_transformed$YearBuilt)] <- median(mean_transformed$YearBuilt,na.rm = TRUE)
plot(density(mean_transformed$YearBuilt), col="red",  
     main="Year Built Original (Blue) vs Median Transformed (Red)")  
lines(density(housing_valuation$YearBuilt, na.rm = TRUE), col="blue")
#Selected Column "LivingArea"
mean_transformed$LivingArea[is.na(mean_transformed$LivingArea)] <- mean(mean_transformed$LivingArea,na.rm = TRUE)
plot(density(mean_transformed$LivingArea), col="red",  
     main="Living Area Original (Blue) vs Mean Transformed (Red)")  
lines(density(housing_valuation$LivingArea, na.rm = TRUE), col="blue")


#Deleting all rows which have missing value 
delete_NA <- housing_valuation[complete.cases(housing_valuation),]
#Selected Column "YearBuilt"
plot(density(delete_NA$YearBuilt), col="red",  
     main="Year Built Original (Blue) vs NA Deleted (Red)")  
lines(density(housing_valuation$YearBuilt, na.rm = TRUE), col="blue")
#Selected Column "LivingArea"
plot(density(delete_NA$LivingArea), col="red",  
     main="Living Area Original (Blue) vs NA Deleted (Red)")  
lines(density(housing_valuation$LivingArea, na.rm = TRUE), col="blue")

cat("\n", "Year Built Original Summary" , ":\n")
summary(housing_valuation$YearBuilt)
cat("\n", "Year Built Zero Transformed Summary" , ":\n")
summary(zero_transformed$YearBuilt)
cat("\n", "Year Built Mean Transformed Summary" , ":\n")
summary(mean_transformed$YearBuilt)
cat("\n", "Year Built NA Deleted Summary" , ":\n")
summary(delete_NA$YearBuilt)

cat("\n")
cat("\n", "Living Area Original Summary" , ":\n")
summary(housing_valuation$LivingArea)
cat("\n", "Living Area Zero Transformed Summary" , ":\n")
summary(zero_transformed$LivingArea)
cat("\n", "Living Area Transformed Summary" , ":\n")
summary(mean_transformed$LivingArea)
cat("\n", "Living Area NA Deleted Summary" , ":\n")
summary(delete_NA$LivingArea)

```


Question 5
```{r}
#Q5a:
new_HousingValuation <- mean_transformed
cor.plot(new_HousingValuation, numbers = TRUE)

```


```{r}
#Q5b:
#Reduce data dimensions
target <- new_HousingValuation$SalePrice
new_HousingValuation <- subset(new_HousingValuation, select = -c(SalePrice))

#Explore the correlation between attributes in the dataset
ggcorr(new_HousingValuation, label=TRUE)

#Get the correlation matrix using caret package
M <- data.matrix(new_HousingValuation)
corrM <- cor(M)

#Find the variables with higher cross-correlation
highlyCorrM <- findCorrelation(corrM, cutoff = 0.5)
names(new_HousingValuation)[highlyCorrM]

HousingValuation_selected <- subset(new_HousingValuation, select = -c(TotalRmsAbvGrd,FullBath)) 
View(HousingValuation_selected)

#Evaluate correlation of the dimension reduced dataset
ggcorr(HousingValuation_selected, label=TRUE)

#Merge the target variable back to the dataset
HousingValuation_selected$SalePrice <- target
View(HousingValuation_selected)

```

```{r}
#Q5c:
# Plot the histograms of all variables
HousingValuation_selected %>% 
  keep(is.numeric) %>%  
  gather() %>%  
  ggplot(aes(value)) + 
  facet_wrap(~ key, scales = "free") + 
  geom_histogram() 

```


```{r}
HousingValuation_selected$OpenPorchSF[HousingValuation_selected$OpenPorchSF == 0] <- 0.00001
HousingValuation_selected$LotArea[HousingValuation_selected$LotArea == 0] <- 0.00001
HousingValuation_selected$TotalBSF[HousingValuation_selected$TotalBSF == 0] <- 0.00001

#Tranform LotArea, TotalBSF, OpenPorchSF which are right skewed variables so using log function. 
trans_lotarea <- log(HousingValuation_selected$LotArea) 
trans_totalBSF <- log(HousingValuation_selected$TotalBSF) 
trans_porchFS <- log(HousingValuation_selected$OpenPorchSF) 
par(mfrow=c(1,2))

hist(HousingValuation_selected$LotArea, col="orange", main="Original") 
hist(trans_lotarea, col="orange", main="Transformed")

hist(HousingValuation_selected$TotalBSF, col="orange", main="Original") 
hist(trans_totalBSF, col="orange", main="Transformed")

hist(HousingValuation_selected$OpenPorchSF, col="orange", main="Original") 
hist(trans_porchFS, col="orange", main="Transformed")



cols <- c('LotArea', 'TotalBSF', 'OpenPorchSF') 
HousingValuation_selected[cols] <- log(HousingValuation_selected[cols]) 

View(HousingValuation_selected)

```

```{r}
#Merge the target variable back to the dataset
HousingValuation_selected$SalePrice <- target
View(HousingValuation_selected)
#Set up the sample configuration
smp_size <- floor(2/3 * nrow(HousingValuation_selected))
set.seed(2)
#Sample the dataset
HousingValuation_selected <- HousingValuation_selected[sample(nrow(HousingValuation_selected)), ]

HousingValuation.train <- HousingValuation_selected[1:smp_size, ]
HousingValuation.test <- HousingValuation_selected[(smp_size+1):nrow(HousingValuation_selected), ]

#Specifying target and input variables
formula = SalePrice ~.

#Fit the linear regression algorithm
model <-  lm(formula = formula, data = HousingValuation.train) 
summary(model)$coefficients

as.formula( 
  paste0("y ~ ", round(coefficients(model)[1],2), " + ",  
         paste(sprintf("%.2f * %s",coefficients(model)[-1], 
                       names(coefficients(model)[-1])),  
               collapse=" + ") 
  ) 
) 

# Make Predictions for test and train datasets
HousingValuation.train$predicted.SalePrice <- predict(model, HousingValuation.train) 
HousingValuation.test$predicted.SalePrice <- predict(model, HousingValuation.test) 
print("Actual Values") 
head(HousingValuation.test$SalePrice, 5) 
print("Predicted Values") 
head(HousingValuation.test$predicted.SalePrice, 5) 

#Plot Predicted values vs Actual values of the target variable 
pl1 <-HousingValuation.test %>%  
  ggplot(aes(SalePrice,predicted.SalePrice)) + 
  geom_point(alpha=0.5) +  
  stat_smooth(aes(colour='red')) + 
  xlab('Actual value of SalePrice') + 
  ylab('Predicted value of SalePrice')+ 
  theme_bw() 
ggplotly(pl1) 

#Calculate the Root Mean Squared Error (RMSE)
error <- HousingValuation.test$SalePrice - HousingValuation.test$predicted.SalePrice 
rmse <- sqrt(mean(error^2)) 
cat("\n")
print(paste("Root Mean Square Error: ", rmse)) 

```


```{r}
#Model-testing 1 (reducing OpenPorchSF,TotalBSF,LotArea)
HousingValuation_selected2 <- subset(HousingValuation_selected, select = -c(OpenPorchSF,TotalBSF,LotArea))
View(HousingValuation_selected2)

#Merge the target variable back to the dataset
HousingValuation_selected2$SalePrice <- target
View(HousingValuation_selected2)
#Set up the sample configuration
smp_size <- floor(2/3 * nrow(HousingValuation_selected2))
set.seed(2)
#Sample the dataset
HousingValuation_selected2 <- HousingValuation_selected2[sample(nrow(HousingValuation_selected2)), ]

HousingValuation.train <- HousingValuation_selected2[1:smp_size, ]
HousingValuation.test <- HousingValuation_selected2[(smp_size+1):nrow(HousingValuation_selected2), ]

#Specifying target and input variables
formula <- SalePrice ~.

#Fit the linear regression algorithm
model <-  lm(formula = formula, data = HousingValuation.train) 
summary(model)$coefficients

as.formula( 
  paste0("y ~ ", round(coefficients(model)[1],2), " + ",  
         paste(sprintf("%.2f * %s",coefficients(model)[-1], 
                       names(coefficients(model)[-1])),  
               collapse=" + ") 
  ) 
) 

# Make Predictions for test and train datasets
HousingValuation.train$predicted.SalePrice <- predict(model, HousingValuation.train) 
HousingValuation.test$predicted.SalePrice <- predict(model, HousingValuation.test) 
print("Actual Values") 
head(HousingValuation.test$SalePrice, 5) 
print("Predicted Values") 
head(HousingValuation.test$predicted.SalePrice, 5) 

#Plot Predicted values vs Actual values of the target variable 
pl1 <-HousingValuation.test %>%  
  ggplot(aes(SalePrice,predicted.SalePrice)) + 
  geom_point(alpha=0.5) +  
  stat_smooth(aes(colour='red')) + 
  xlab('Actual value of SalePrice') + 
  ylab('Predicted value of SalePrice')+ 
  theme_bw() 
ggplotly(pl1) 

#Calculate the Root Mean Squared Error (RMSE)
error <- HousingValuation.test$SalePrice - HousingValuation.test$predicted.SalePrice 
rmse <- sqrt(mean(error^2)) 
cat("\n")
print(paste("Root Mean Square Error: ", rmse)) 
```



```{r}
#Model-testing 2 (reducing TotalBSF,OpenPorchSF)
HousingValuation_selected3 <- subset(HousingValuation_selected, select = -c(TotalBSF,OpenPorchSF))
View(HousingValuation_selected3)

#Merge the target variable back to the dataset
HousingValuation_selected3$SalePrice <- target
View(HousingValuation_selected3)
#Set up the sample configuration
smp_size <- floor(2/3 * nrow(HousingValuation_selected3))
set.seed(2)
#Sample the dataset
HousingValuation_selected3 <- HousingValuation_selected3[sample(nrow(HousingValuation_selected3)), ]

HousingValuation.train <- HousingValuation_selected3[1:smp_size, ]
HousingValuation.test <- HousingValuation_selected3[(smp_size+1):nrow(HousingValuation_selected3), ]

#Specifying target and input variables
formula <- SalePrice ~.

#Fit the linear regression algorithm
model <-  lm(formula = formula, data = HousingValuation.train) 
summary(model)$coefficients

as.formula( 
  paste0("y ~ ", round(coefficients(model)[1],2), " + ",  
         paste(sprintf("%.2f * %s",coefficients(model)[-1], 
                       names(coefficients(model)[-1])),  
               collapse=" + ") 
  ) 
) 

# Make Predictions for test and train datasets
HousingValuation.train$predicted.SalePrice <- predict(model, HousingValuation.train) 
HousingValuation.test$predicted.SalePrice <- predict(model, HousingValuation.test) 
print("Actual Values") 
head(HousingValuation.test$SalePrice, 5) 
print("Predicted Values") 
head(HousingValuation.test$predicted.SalePrice, 5) 

#Plot Predicted values vs Actual values of the target variable 
pl1 <-HousingValuation.test %>%  
  ggplot(aes(SalePrice,predicted.SalePrice)) + 
  geom_point(alpha=0.5) +  
  stat_smooth(aes(colour='red')) + 
  xlab('Actual value of SalePrice') + 
  ylab('Predicted value of SalePrice')+ 
  theme_bw() 
ggplotly(pl1) 

#Calculate the Root Mean Squared Error (RMSE)
error <- HousingValuation.test$SalePrice - HousingValuation.test$predicted.SalePrice 
rmse <- sqrt(mean(error^2)) 
cat("\n")
print(paste("Root Mean Square Error: ", rmse)) 
```
```{r}
#Model-testing 3 (reducing LivingArea,GarageCars)
HousingValuation_selected4 <- subset(HousingValuation_selected, select = -c(LivingArea,GarageCars))
View(HousingValuation_selected4)

#Evaluate correlation of the dimension reduced dataset
ggcorr(HousingValuation_selected4, label=TRUE)

#Merge the target variable back to the dataset
HousingValuation_selected4$SalePrice <- target
View(HousingValuation_selected4)
#Set up the sample configuration
smp_size <- floor(2/3 * nrow(HousingValuation_selected4))
set.seed(2)
#Sample the dataset
HousingValuation_selected4 <- HousingValuation_selected4[sample(nrow(HousingValuation_selected4)), ]

HousingValuation.train <- HousingValuation_selected4[1:smp_size, ]
HousingValuation.test <- HousingValuation_selected4[(smp_size+1):nrow(HousingValuation_selected4), ]

#Specifying target and input variables
formula <- SalePrice ~.

#Fit the linear regression algorithm
model <-  lm(formula = formula, data = HousingValuation.train) 
summary(model)$coefficients

as.formula( 
  paste0("y ~ ", round(coefficients(model)[1],2), " + ",  
         paste(sprintf("%.2f * %s",coefficients(model)[-1], 
                       names(coefficients(model)[-1])),  
               collapse=" + ") 
  ) 
) 

# Make Predictions for test and train datasets
HousingValuation.train$predicted.SalePrice <- predict(model, HousingValuation.train) 
HousingValuation.test$predicted.SalePrice <- predict(model, HousingValuation.test) 
print("Actual Values") 
head(HousingValuation.test$SalePrice, 5) 
print("Predicted Values") 
head(HousingValuation.test$predicted.SalePrice, 5) 

#Plot Predicted values vs Actual values of the target variable 
pl1 <-HousingValuation.test %>%  
  ggplot(aes(SalePrice,predicted.SalePrice)) + 
  geom_point(alpha=0.5) +  
  stat_smooth(aes(colour='red')) + 
  xlab('Actual value of SalePrice') + 
  ylab('Predicted value of SalePrice')+ 
  theme_bw() 
ggplotly(pl1) 

#Calculate the Root Mean Squared Error (RMSE)
error <- HousingValuation.test$SalePrice - HousingValuation.test$predicted.SalePrice 
rmse <- sqrt(mean(error^2)) 
cat("\n")
print(paste("Root Mean Square Error: ", rmse)) 
```




PART C
```{r}

install.packages("rpart", dependencies = TRUE)
library(rpart)
install.packages("rpart.plot", dependencies = TRUE)
library(rpart.plot)

HousingValuation <- mean_transformed
target <- HousingValuation$SalePrice
HousingValuation <- subset(HousingValuation, select = -c(SalePrice))

#Get the correlation matrix using caret package
matrix <- data.matrix(HousingValuation)
corrMatrix <- cor(matrix)

#Find the variables with higher cross-correlation
highlyCorrMatrix <- findCorrelation(corrMatrix, cutoff = 0.5)
names(HousingValuation)[highlyCorrMatrix]

HousingValuation.selected <- subset(HousingValuation, select = -c(TotalRmsAbvGrd,FullBath)) 
View(HousingValuation.selected)

#Merge the target variable back to the dataset
HousingValuation.selected$SalePrice <- target
head(HousingValuation.selected)
summary(HousingValuation.selected)

smp_size <- floor(2/3 * nrow(HousingValuation.selected))  
set.seed(2) 

HousingValuation.dateset.selected <- HousingValuation.selected[sample(nrow(HousingValuation.selected)), ] 

housingvaluation.train <- HousingValuation.dateset.selected[1:smp_size, ]   
housingvaluation.test <- 
  HousingValuation.dateset.selected[(smp_size+1):nrow(HousingValuation.dateset.selected), ]   

formula <- SalePrice ~.
dtree <- rpart(formula, data=housingvaluation.train, method="anova")
dtree$variable.importance
rpart.plot(dtree, type = 4, fallen.leaves = FALSE) 
print(dtree) 

Predicted.SalePrice <- predict(dtree, housingvaluation.test) 
print("Actual Values") 
head(housingvaluation.test$SalePrice[1:5]) 
print("Predicted Values") 
head(Predicted.SalePrice[1:5]) 

error <- housingvaluation.test$SalePrice - Predicted.SalePrice 
rmse <- sqrt(mean(error^2)) 
print(paste("Root Mean Square Error: ", rmse)) 

printcp(dtree)
dtree$cptable[which.min(dtree$cptable[,"xerror"]),"CP"]

pruned_dtree <- prune(dtree, cp = 0.011628) 
rpart.plot(pruned_dtree, type = 4, fallen.leaves = FALSE)
predicted_pruned.SalePrice <- predict(pruned_dtree, housingvaluation.test)
error_new <- housingvaluation.test$SalePrice-predicted_pruned.SalePrice
rmse_new <- sqrt(mean(error_new^2))
print(paste("New Root Mean Square Error: ", rmse_new))

pruned_dtree <- prune(dtree, cp = 0.02)
rpart.plot(pruned_dtree, type = 4, fallen.leaves = FALSE)
predicted_pruned.SalePrice <- predict(pruned_dtree, housingvaluation.test)
error_new <- housingvaluation.test$SalePrice-predicted_pruned.SalePrice
rmse_new <- sqrt(mean(error_new^2))
print(paste("New Root Mean Square Error
: ", rmse_new))
```

