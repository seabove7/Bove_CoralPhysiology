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

