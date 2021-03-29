##########################################################################################
##  Credits: 
## https://github.com/djnavarro/flametree
##########################################################################################


# install.packages("devtools")
#devtools::install_github("djnavarro/flametree")

pacman::p_load(here, ggplot2, flametree, magrittr, patchwork)

## Functions --------------------------------------------------------------------------------

generating_trees <- function(time, seed) {
  flametree_grow(time, seed) %>%
    flametree_plot()
}

## Trees growing ---------------------------------------------------------------------------
trees_list <- mapply(generating_trees, 
                     time = rep(1:4, 3), 
                     seed = 2:13, 
                     SIMPLIFY = FALSE)

plot_list_growing <- wrap_plots(trees_list)

ggsave(plot =  plot_list_growing, 
       here("output", paste0("tree_growing", format(Sys.time(), "_%Y%m%d_%H%M"),".png")),
       width = 12, height = 12)

## Trees moving ----------------------------------------------------------------------------
trees_list_fix <- mapply(
  generating_trees,
  seed = rep(9, 12),
  time = 2:13,
  SIMPLIFY = FALSE
)


plot_list_fix <- wrap_plots(trees_list_fix)

ggsave(plot =  plot_list_fix, 
       here("output", paste0("tree_moving", format(Sys.time(), "_%Y%m%d_%H%M"),".png")),
       width = 12, height = 12)

## Tree clock  ----------------------------------------------------------------------------

layout <- '
###A###
##L#B##
#K###C#
J#####D
#I###E#
##H#F##
###G###
'

plot_list_clock <- wrap_plots(
  B = trees_list[[1]],
  C = trees_list[[2]],
  D = trees_list[[3]],
  E = trees_list[[4]],
  F = trees_list[[5]],
  G = trees_list[[6]],
  H = trees_list[[7]],
  I = trees_list[[8]],
  J = trees_list[[9]],
  K = trees_list[[10]],
  L = trees_list[[11]],
  A = trees_list[[12]],
  design = layout
) +
  plot_annotation(theme = theme(
    plot.background = element_rect(
      fill = "antiquewhite4"
    )
  ))

ggsave(plot =  plot_list_clock, 
       here("output", paste0("tree_clock", format(Sys.time(), "_%Y%m%d_%H%M"),".png")),
       width = 12, height = 12) 
