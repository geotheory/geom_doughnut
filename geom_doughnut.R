require(tidyverse)
library(ggplot2)
require(ggthemes)

stat_doughnut = function(x, y=NULL, g1=NULL, g2=NULL, w=.2){
  if(!is.null(y)) x = data_frame(cat = x, val = y)
  if(!is.null(g1)) x = mutate(x, g1 = g1)
  if(!is.null(g2)) x = mutate(x, g2 = g2)
  names(x) = c('cat', 'val', 'g1', 'g2')[1:ncol(x)]
  
  nut = function(d){
    d %>% mutate(fraction = val/sum(val)) %>% 
    #arrange(fraction) %>% 
    mutate(ymax = cumsum(fraction),
           ymin = c(0, head(ymax, n=-1)))
  }
  if(ncol(x) == 2){
    d = nut(x)
  } else if(ncol(x) == 3){
    d = split(x, x$g1) %>% lapply(nut) %>% bind_rows()
  } else if(ncol(x) == 4){
    d = split(x, paste(x$g1, x$g2), sep='#') %>% lapply(nut) %>% bind_rows()
  } else return()
  d
}

geom_doughnut = function(x, w=.3, col = 'white'){
  p = ggplot(x, aes(fill=cat, ymax=ymax, ymin=ymin, xmax=1-w, xmin=1)) +
    geom_rect(col = col) + coord_polar(theta="y") + xlim(c(0, 1)) +
    theme_minimal() + 
    theme(strip.text = element_text(size = 14, vjust=-1), 
          legend.text = element_text(size = 14),
          legend.title = element_text(size = 14),
          title = element_text(size = 16),
          axis.text = element_blank(), 
          axis.ticks = element_blank(), 
          axis.line = element_blank(),
          panel.grid = element_blank())

  if('g1' %in% names(x) & !'g2' %in% names(x)) p = p + facet_wrap(~ g1)
  if('g2' %in% names(x)) p = p + facet_wrap(g1 ~ g2, labeller = label_wrap_gen(multi_line=FALSE))
  p 
}


