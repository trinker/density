## add gridlines
## http://stackoverflow.com/a/21043587/1000343
## Compliments of Troy

# pre-req libraries
p_load(ggplot2, grid, png)      # to read the PNG file

grid_calc <- function(width = 10, height = width) {
	
    # generate the points and labels for the grid
    points <- data.frame(expand.grid(w=1:width, h=1:height))
    points$labs <- paste0("(", points$w, "," ,points$h, ")")
    points$x <- points$w-0.5 # center
    points$y <- points$h-0.5
    
    # make the gridline co-ordinates
    gridx <- data.frame(x=0:width, xend=0:width, y=rep(0,width+1), 
    	yend=rep(height, width+1))
    gridy <- data.frame(x=rep(0, height+1), xend=rep(width, height+1), 
    	y=0:height, yend=0:height)
    list(coords = rbind(gridx, gridy), w = width, h = height, points = points)
}

grid_dat <- grid_calc(20)
# function to plot using ggplot with annotation_custom for the image
#' @importFrom ggplot2 ggplot annotation_custom geom_text geom_segment coord_cartesian aes theme_bw
#' @importFrom png readPNG
plotgrid <- function(file, coord.color = "gray60", grid.color = coord.color, 
	text.size = 3, grid.data = grid_dat){
	width <- grid.data[["w"]]
	height <- grid.data[["h"]]
    ggplot(grid.data[["points"]]) + theme_bw()+
        annotation_custom(rasterGrob(readPNG(file), 0, 0, 1, 1, 
        	just=c("left", "bottom")), 0, width, 0, height)+
        geom_text(aes(x=x, y=y, label=labs), color=coord.color, 
        	size = text.size)+
        geom_segment(aes(x=x, xend=xend, y=y, yend=yend), 
        	data=grid.data[["coords"]], color=grid.color) +
        coord_cartesian(c(0, width), c(0, height))
}

# run the function for each file in the folder
wd <- getwd()
setwd("movie2frames/out/out_05")
xpath <- folder(gridout)
## xpath <- folder(gridout_20)
fls <- dir()[-c(1:2)]
#t1 <- Sys.time()
w <- 800
h <- w
## x <- "image-0000036.png"
lapply(fls,function(x){
	png(file.path(xpath, x), width=w, height=h)
	print(plotgrid(x, grid.data = grid_calc(6, 10)))
	dev.off()
})
#t2 <- Sys.time()
#difftime(t2, t1) #33.40391 on 38f iles
setwd(wd)

#' @importFrom parallel parLapply makeCluster detectCores stopCluster clusterEvalQ clusterExport
#' @importFrom tools file_ext
gridify <- function(path = ".", out = file.path(path, "out"), 
    columns = 20, rows = columns, parallel = FALSE, cores = detectCores()/2,
    width = 480, height = 480, ...){

    if (file.exists(file.path(path, "out"))) {
        message(paste0("\"", file.path(path, "out"), 
            "\" already exists:\nDo you want to overwrite?\n"))
        ans <- menu(c("Yes", "No"))
        if (ans == "2") {
            stop("gridify aborted")
        }
        else {
            delete(file.path(path, "out"))
        }
    }
	folder(folder.name = out)
	
    fls <- dir(path)
	fls <-file.path(path, fls)[file_ext(fls) == "png"]
    dat <- grid_calc(columns, rows)

        invisible(lapply(fls, function(x){
            png(file.path(out, basename(x)), width=width, height=height, ...)
            print(plotgrid(x, grid.data = dat))
            dev.off()
        }))

	message(sprintf("Grid files plotted to:\n%s", out))
}

gridify("C:/Users/trinker/Desktop/out")

















