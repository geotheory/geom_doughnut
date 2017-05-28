# ggplot2 doughnut chart

Functions based on the method [by bdemarest on Stackoverflow](https://stackoverflow.com/a/13636037/1156245) to make nice doughnut charts with ggplot2.

Note `stat_doughnut` and `geom_doughnut` do not work like conventional ggplot `stat_..` and `geom_..` functions, but are just simple wrappers for this `geom_rect` method.

### Install

    _[command line]_ git clone https://github.com/geotheory/geom_doughnut
    _[in R]_ source('/pathto/geom_doughnut.R'))

### Example

    # Basic usage
    d = data.frame(category=c("A", "B", "C"), count=c(10, 60, 30)) %>% stat_doughnut()
    p = geom_doughnut(d)
    p + labs(title = 'Doughnut plot')
    
    # With single facet
    data.frame(category=c("A", "B", "C", "A", "B", "C"), count=c(10, 60, 30, 20, 30, 50), 
               grp = c(rep('blue',3), rep('red',3))) %>% stat_doughnut() %>% geom_doughnut()
    
    # double facets
    data.frame(category=c("A", "B", "C", "A", "B", "C", "A", "B", "C", "A", "B", "C"), 
               count=c(10, 60, 30, 2, 3, 5, 10, 60, 30, 20, 30, 50), 
               grp = c(rep('Top',3), rep('Bottom',3), rep('Top',3), rep('Bottom',3)),
               set = c(rep('Left', 6), rep('Right', 6))) %>% 
      stat_doughnut() %>% geom_doughnut()


