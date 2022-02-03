################################################################################
########## Custom functions used in the Bove_CoralPhysiology.Rmd file ##########
################################################################################

### Function to remove rows with any missing values

completeFun <- function(data, desiredCols) {
  completeVec <- complete.cases(data[, desiredCols])
  return(data[completeVec, ])
}



################################################################################

### Function to calculate AIC (and other metrics) of PERMANOVA from adonis2() function
## Script for this function from: https://github.com/kdyson/R_Scripts/blob/master/AICc_PERMANOVA.R

AICc.PERMANOVA2 <- function(adonis2.model) {
  
  # check to see if object is an adonis2 model...
  
  if (is.na(adonis2.model$SumOfSqs[1]))
    stop("object not output of adonis2 {vegan} ")
  
  # Ok, now extract appropriate terms from the adonis model Calculating AICc
  # using residual sum of squares (RSS or SSE) since I don't think that adonis
  # returns something I can use as a likelihood function... maximum likelihood
  # and MSE estimates are the same when distribution is gaussian See e.g.
  # https://www.jessicayung.com/mse-as-maximum-likelihood/;
  # https://towardsdatascience.com/probability-concepts-explained-maximum-likelihood-estimation-c7b4342fdbb1
  # So using RSS or MSE estimates is fine as long as the residuals are
  # Gaussian https://robjhyndman.com/hyndsight/aic/ If models have different
  # conditional likelihoods then AIC is not valid. However, comparing models
  # with different error distributions is ok (above link).
  
  
  RSS <- adonis2.model$SumOfSqs[ length(adonis2.model$SumOfSqs) - 1 ]
  MSE <- RSS / adonis2.model$Df[ length(adonis2.model$Df) - 1 ]
  
  nn <- adonis2.model$Df[ length(adonis2.model$Df) ] + 1
  
  k <- nn - adonis2.model$Df[ length(adonis2.model$Df) - 1 ]
  
  
  # AIC : 2*k + n*ln(RSS/n)
  # AICc: AIC + [2k(k+1)]/(n-k-1)
  
  # based on https://en.wikipedia.org/wiki/Akaike_information_criterion;
  # https://www.statisticshowto.datasciencecentral.com/akaikes-information-criterion/ ;
  # https://www.researchgate.net/post/What_is_the_AIC_formula;
  # http://avesbiodiv.mncn.csic.es/estadistica/ejemploaic.pdf;
  # https://medium.com/better-programming/data-science-modeling-how-to-use-linear-regression-with-python-fdf6ca5481be 
  
  # AIC.g is generalized version of AIC = 2k + n [Ln( 2(pi) RSS/n ) + 1]
  # AIC.pi = k + n [Ln( 2(pi) RSS/(n-k) ) +1],
  
  AIC <- 2*k + nn*log(RSS/nn)
  AIC.g <- 2*k + nn * (1 + log( 2 * pi * RSS / nn))
  AIC.MSE <- 2*k + nn * log(MSE)
  AIC.pi <- k + nn*(1 + log( 2*pi*RSS/(nn-k) )   )
  AICc <- AIC + (2*k*(k + 1))/(nn - k - 1)
  AICc.MSE <- AIC.MSE + (2*k*(k + 1))/(nn - k - 1)
  AICc.pi <- AIC.pi + (2*k*(k + 1))/(nn - k - 1)
  
  output <- list("AIC" = AIC, "AICc" = AICc, "AIC.g" = AIC.g, 
                 "AIC.MSE" = AIC.MSE, "AICc.MSE" = AICc.MSE,
                 "AIC.pi" = AIC.pi, "AICc.pi" = AICc.pi, "k" = k, "N" = nn)
  
  return(output)   
  
}



################################################################################

### Custom functions to modify the asthetics of the correlation plots

## Add border around the text
panel.txt.brdr <- function (x = 0.5, y = 0.5, txt, cex, font, srt) 
{
  text(x, y, txt, cex = cex, font = font, srt = srt)
  box(col = "#525252")
}

## Modify the top point fill/shape panel
panel.pts.col <- function (x, y, corr = NULL, col.regions, cor.method, color, ...) 
{
  if (!is.null(corr)) 
    return()
  plot.xy(xy.coords(x, y), col = color, type = "p", ...)
  box(col = "#525252")
}

## Modify the bottom fill/R2 panel (with significance)
panel.fill.R2 <- function (x, y, corr = NULL, col.regions, cor.method, digits = 2, cex.cor, ...) 
{
  if (is.null(corr)) {
    if (sum(complete.cases(x, y)) < 2) {
      warning("Need at least 2 complete cases for cor()")
      return()
    }
    else {
      corr <- cor(x, y, use = "pair", method = cor.method)
    }
  }
  ncol <- 14
  pal <- col.regions(ncol)
  col.ind <- as.numeric(cut(corr, breaks = seq(from = -1, 
                                               to = 1, length.out = ncol + 1), include.lowest = TRUE))
  usr <- par("usr")
  rect(usr[1], usr[3], usr[2], usr[4], col = pal[col.ind], 
       border = NA)
  box(col = "#525252")
  
  auto <- missing(cex.cor)
  on.exit(par(usr))
  par(usr = c(0, 1, 0, 1))
  abscorr <- formatC(abs(corr), digits = digits, format = "f")
  corr2 <- formatC(corr, digits = digits, format = "f")
  pval <- cor.test(x, y, use = "pair", method = cor.method)[["p.value"]]
  sig <- if(pval > 0.05){""}else if(pval < 0.05 & pval > 0.01){"*"}else if(pval < 0.01 & pval > 0.001){"**"}else if(pval < 0.001){"***"}
  if (auto) 
    cex.cor <- 0.4/strwidth(abscorr)
  text(0.5, 0.5, paste0(corr2, sig), cex = cex.cor, font = 3, col = "#252525")
  
  
  
}



################################################################################

### Custom function to calculate PCA distances for plasticity

## To run the function, enter the following objects:
# PCAplast(pca = XXX, # the PCA dataframe containing the PCA eigenvalues
#          data = XXX, # the condition/treatment data corresponding to samples
#          sample_ID = "XXX", # the name of column that provide unique ID per sample (if blank, will pull rownames for this)
#          num_pca =  "XXX", # the number of PCAs to include in analysis (default is 'all', but you can specify another number with a minimum of 2 PCAs)
#          control_col = "XXX", # what the 'treatment' column is called
#          control_lvl = "XXX", # control level of the treatment 
#          group = "XXX") # the grouping column (i.e., colony). If blank, will assume control level grouping only!


PCAplast <- function(pca, data, sample_ID = NA, num_pca = "all", control_col, control_lvl, group = NA) {
  
  # rename the user input info
  pca_df <- pca
  data_df <- data
  control_name <- control_col
  control_lvl <- control_lvl
  group_col <- group
  
  # ifelse statement to pull PCs from dataframe or prcomp objects
  if(class(pca_df) == "prcomp"){
    pca_dist <- pca_df$x # grab PC distances from prcomp() object
  } else {
    pca_dist <- pca_df # grab PC distances from data.frame object
  }
  
  
  # check for correct number of PCAs provided
  if(class(num_pca) == "numeric") {
    if(num_pca < 2) { # will throw error if too few PCAs requested
      stop("please select more than 2 PCs to calculate distance")
    } 
  }
  
  if(class(num_pca) == "numeric") {
    if(num_pca > (pca_dist %>% dplyr::select(starts_with("PCA")) %>% ncol())) { # will throw error if too many PCAs requested
      stop(paste(num_pca, "PCs requested for calculation, but only", (pca_dist %>% dplyr::select(starts_with("PCA")) %>% ncol()), "PCs available. Select appropriate number of PCAs for calculation."))
    } 
  }
  
  
  # oder the dataframe to ensure correct pairing after calculating distance 
  if(sample_ID %in% colnames(data_df)){
    data_df <- data_df[order(data_df[[sample_ID]]),]
  } else {
    data_df <- data_df[order(row.names(data_df)),]
  }
  
  
  # combine the datasets
  dist_df <- cbind(data_df, pca_dist) 
  
  # make dataframe of control colonies only
  if(!is.na(group_col)) { # calculate mean per grouping ID (if provided)
    mean_control <- dist_df %>%
      filter(dist_df[[control_name]] == list(control_lvl)[[1]]) %>% 
      rename_with(tolower) %>% # renames all pc's with lowercase 'PC' (just to differentiate from all sample PCs)
      dplyr::select(colnames((dist_df %>% rename_with(tolower))[tolower(group_col)]), starts_with("pc"))
    
    # add the control PCA values to treatment samples per grouping
    dist_df2 <- left_join(dist_df, mean_control, by = "colony")
   
  } else { # calculate mean per control treatment
    mean_control <- dist_df %>%
      filter(dist_df[[control_name]] == list(control_lvl)[[1]]) %>% 
      rename_with(tolower) %>% # renames all pc's with lowercase 'PC' (just to differentiate from all sample PCs)
      dplyr::select(colnames((dist_df %>% rename_with(tolower))[tolower(group_col)]), starts_with("pc")) %>% # select just the PCs 
      summarise_if(is.numeric, mean)
    
    # add the control PCA values to all samples 
    dist_df2 <- merge(dist_df, mean_control, all = TRUE)
    
  }
  
  

  
  # again, reorder data
  if(sample_ID %in% colnames(data_df)){
    dist_df2 <- dist_df2[order(dist_df2[[sample_ID]]),]
  } else {
    rownames(dist_df2) <- rownames(data_df)
    dist_df2 <- dist_df2[order(row.names(dist_df2)),]
  }
  
  
  ### Calculate sample (PCA) distances from control (pca) using all PCAs
  # make dataframe to populate with pca distances
  full_calc_dist <- data.frame(control_name = dist_df2[control_name])
  
  if(num_pca == "all") {
    ## forloop that will calculate distances between control and sample for all PCs (n will be total number)
    for(n in 1:(dist_df %>% dplyr::select(starts_with("PC")) %>% ncol())){
      # makes the PCA column name for control (lowercase) and sample (uppercase)
      PC_col <- paste0("PC", n)
      pc_col <- paste0("pc", n)
      
      # pulls the PC column for control (lowercase) and sample (uppercase)
      PCx <- dist_df2[PC_col]
      pcx <- dist_df2[pc_col]
      
      pca_calc_dist <- data.frame((PCx - pcx)^2) # calculates the distance between 2 PCs
      full_calc_dist <- cbind(full_calc_dist, pca_calc_dist) # add that distance to running dataframe
    }
  } else {
    ## forloop that will calculate distances between control and sample for SPECIFIED # of PCs (n will be total number)
    for(n in 1:as.numeric(num_pca)){
      # makes the PC column name for control (lowercase) and sample (uppercase)
      PC_col <- paste0("PC", n)
      pc_col <- paste0("pc", n)
      
      # pulls the PC column for control (lowercase) and sample (uppercase)
      PCx <- dist_df2[PC_col]
      pcx <- dist_df2[pc_col]
      
      pca_calc_dist <- data.frame((PCx - pcx)^2) # calculates the distance between 2 PCs
      full_calc_dist <- cbind(full_calc_dist, pca_calc_dist) # add that distance to running dataframe
    }
  }
  
  
  ## final distance calculation (adds all PCA distances and takes squareroot)
  distance <- full_calc_dist %>% 
    mutate(dis_sum = rowSums(across(where(is.numeric)))) %>% 
    mutate(dist = sqrt(dis_sum)) %>% 
    dplyr::select(matches("dist"))
  
  
  ## combine the calculated distance with the metadata and remove controls for final dataframe
  dist_df <- data_df %>% 
    bind_cols(distance) %>% 
    filter(!is.na(dist)) 
  
  ## removes the control levels
  dist_df <- dist_df %>%
    filter(dist_df[[control_name]] != control_lvl)  %>% 
    droplevels()
}




################################################################################

### Custom function for bootstrapping with replacement GLMER model

bootFUN <- function(model, newdata) {
  nr <- nrow(model@frame) # count number of rows in the model (# of observations)
  data <- model@frame # pull data from model
  data2 <- data.frame(data[sample(1:nr, replace = TRUE), ]) # random sample of numbers from 1 - nr (# of rows) to select data from
  update <- update(model, data = data2) # rerun the model using the 'new' dataset from the random smapling above
  predict(update, newdata, type = "response", re.form = NA, allow.new.levels=TRUE) # predicts response variable with model and updated data 
}
