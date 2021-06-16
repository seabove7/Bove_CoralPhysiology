################################################################################
########## Custom functions used in the Bove_CoralPhysiology.Rmd file ##########
################################################################################

### Function to remove rows with any missing values

completeFun <- function(data, desiredCols) {
  completeVec <- complete.cases(data[, desiredCols])
  return(data[completeVec, ])
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

PCAplast <- function(pca, data, control_col, control_lvl, colony = "colony") {
  
  # rename the user input info
  pca_df <- pca
  data_df <- data
  control_name <- control_col
  control_lvl <- control_lvl
  
  
  # ifelse statement to pull PCs from dataframe or prcomp objects
  if(class(pca_df) == "prcomp"){
    pca_dist <- pca_df$x # grab PC1 and PC2 distances from prcomp() object
  } else {
    pca_dist <- pca_df # grab PC1 and PC2 distances from data.frame object
  }
  
  # combine the datasets
  dist_df <- cbind(data_df, pca_dist) 
  
  # make dataframe of control colonies only
  control_df <- dist_df %>%
    filter(dist_df[[control_name]] == list(control_lvl)[[1]]) %>% 
    rename_with(tolower) %>% # renames all pc's with lowercase 'PC' (just to differentiate from all sample PCs)
    dplyr::select(colnames(dist_df[colony]), starts_with("pc")) # select just the treatment, colony, and PCs 
  
  # add the control PC values to all samples from the same colony
  dist_df2 <- merge(dist_df, control_df, all=TRUE)
  
  
  
  ### Calculate sample (PC) distances from control (pc) using all 7 PCs by colony
  dist_df3 <- dist_df2 %>% 
    mutate(dist = sqrt( ((PC1 - pc1)^2) + 
                          ((PC2 - pc2)^2) + 
                          ((PC3 - pc3)^2) +
                          ((PC4 - pc4)^2) + 
                          ((PC5 - pc5)^2) + 
                          ((PC6 - pc6)^2) +
                          ((PC7 - pc7)^2)))
  
  
  # modify dataframe to remove the control treatment 
  dist_df <- dist_df3 %>% 
    filter(dist_df3[control_name] != list(control_lvl)[[1]], !is.na(pc1))
  
}



### Summary function for plotting plasticity

DistSum <- function(data) {
  data_update <- data %>% 
    #mutate(treat2 = factor(treat2, levels = c("300_28", "300_31", "420_28", "420_31", "680_28", "680_31", "3300_28", "3300_31"))) %>% 
    group_by(treat2, reef, species) %>% 
    summarise(mean = mean(dist),
              se = (sd(dist) / sqrt(n()))) 
}
