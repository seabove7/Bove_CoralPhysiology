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

PCAplast <- function(pca, data) {
  
  pca_df <- pca
  data_df <- data
  
  pca_dist <- pca_df$x[,1:2] # grab PC1 and PC2 distances from prcomp() object
  dist_df <- cbind(data_df[,c(1,7,8, 10,11,12,27)], pca_dist) # combine the datasets
  
  # adds column with the control value PC1/PC2 per colony
  dist_df$cont_pc1[dist_df$treat2 == "447_28"] <- dist_df$PC1[dist_df$treat2 == "447_28"]
  dist_df$cont_pc2[dist_df$treat2 == "447_28"] <- dist_df$PC2[dist_df$treat2 == "447_28"]
  
  # get the 400_28 PC values
  dist_df2 <- dist_df %>%  
    group_by(colony) %>% 
    summarise(con2_pc1 = sum(cont_pc1, na.rm = TRUE),
              con2_pc2 = sum(cont_pc2, na.rm = TRUE))
  
  # Make columns of the 400_28 PC values
  dist_df <- dist_df %>% 
    left_join(dist_df2, by = c("colony" = "colony"))
  
  dist_df$dist <- sqrt(((dist_df$PC1 - dist_df$con2_pc1)^2) + ((dist_df$PC2 - dist_df$con2_pc2)^2)) # formula for calculating distance between control (T90) and treatment values
  dist_df$treat_plot = paste(dist_df$fpco2, dist_df$ftemp, sep = "_")
  
  
  ## modify dataframe to remove the control treatment and reorder levels
  dist_df <- dist_df %>% 
    filter(treat_plot != "420_28") %>% 
    mutate(treat_plot = factor(treat_plot, levels = c("300_28", "300_31", "420_28", "420_31", "680_28", "680_31", "3300_28", "3300_31")),
           reef = factor(reef, levels = c("N", "F")),
           ftemp = factor(ftemp, levels = c("28", "31")),
           fpco2 = factor(fpco2, levels = c("300", "420", "680", "3300")))
  
  
}



### Summary function for plotting plasticity

DistSum <- function(data) {
  data_update <- data %>% 
    mutate(treat_plot = factor(treat_plot, levels = c("300_28", "300_31", "420_28", "420_31", "680_28", "680_31", "3300_28", "3300_31"))) %>% 
    group_by(treat_plot, reef, species) %>% 
    summarise(mean = mean(dist),
              se = (sd(dist) / sqrt(n()))) 
}