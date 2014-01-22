
b <- grid_calc(3, 4)

b[["points"]]
print(plotgrid(x, grid.data = grid_calc(60), text.color="yellow", text.size=2))

plotgrid <- function(file, text.color = "gray60", grid.color = text.color, 
	text.size = 3, grid.data = grid_calc()){
	width <- grid.data[["columns"]]
	height<- grid.data[["rows"]]
    ggplot(grid.data[["points"]]) + theme_bw()+
        annotation_custom(rasterGrob(readPNG(file), 0, 0, 1, 1, 
        	just=c("left", "bottom")), 0, width, 0, height)+
        geom_text(aes(x=x, y=y, label=labs), color=text.color, 
        	size = text.size)+
        geom_segment(aes(x=x, xend=xend, y=y, yend=yend), 
        	data=grid.data[["coords"]], color=grid.color) +
        coord_cartesian(c(0, width), c(0, height))
}

grid_calc <- function(columns = 20, rows = columns) {
	
    # generate the points and labels for the grid
    points <- data.frame(expand.grid(w=1:columns, h=1:rows))
    points$coords <- paste0("(", points$w, "," ,points$h, ")")
    nr <- nrow(points)
    nl <- ceiling(nr/26)
	
    points$labs <- paste0(rep(LETTERS, nl), rep(1:nl, each = 26))[1:nr]
	points$labs <- unlist(rev(split(points$labs, rep(1:rows, each = columns))))
	
	
    points$x <- points$w-0.5 # center
    points$y <- points$h-0.5
    
    # make the gridline co-ordinates
    gridx <- data.frame(x=0:columns, xend=0:columns, y=rep(0,columns+1), 
    	yend=rep(rows, columns+1))
    gridy <- data.frame(x=rep(0, rows+1), xend=rep(columns, rows+1), 
    	y=0:rows, yend=0:rows)
    list(coords = rbind(gridx, gridy), rows = rows, columns = columns, 
    	points = points)
}

## 
## grid_calc <- function(columns = 20, rows = columns) {
## 	
##     # generate the points and labels for the grid
##     points <- data.frame(expand.grid(w=1:rows, h=1:columns))
##     points$coords <- paste0("(", points$w, "," ,points$h, ")")
##     nr <- nrow(points)
##     nl <- ceiling(nr/26)
## #browser()	
## 	
##     points$labs <- paste0(rep(LETTERS, nl), rep(1:nl, each = nl))[1:nr]
## 		
##     points$x <- points$w-0.5 # center
##     points$y <- points$h-0.5
##     
##     # make the gridline co-ordinates
##     gridx <- data.frame(x=0:rows, xend=0:rows, y=rep(0,rows+1), 
##     	yend=rep(columns, rows+1))
##     gridy <- data.frame(x=rep(0, columns+1), xend=rep(rows, columns+1), 
##     	y=0:columns, yend=0:columns)
##     list(coords = rbind(gridx, gridy), columns = columns, rows = rows, 
##     	points = points)
## }
