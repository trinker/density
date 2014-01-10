## http://stackoverflow.com/questions/3917601/ffmpeg-split-avi-into-frames-with-known-frame-rate
## http://bioeng-student.blogspot.com/2011/05/splitting-video-into-frames-using.html
## http://linuxaria.com/howto/tricks-ffmpeg?lang=en

wd <- getwd()
setwd("movie2frames")
x <- folder(out)
setwd(x)
fls <-file.path("movie2frames/out", rdirs(out, 1:10, text.only = TRUE))
folder(folder.name = fls)


##  browseURL("https://copy.com/web/spliced.mp4?download=1")
##  move to working directory

## cd GitHub/density/movie2frames  ## shell command

## Splice
## ffmpeg -i truly_amazing_teacher.mp4 -ss 00:00:20.0 -c copy -t 00:00:35.0 spliced.mp4

shell("ffmpeg -i spliced.mp4 -r 1 -s 500x500 -f image2 out/out_05/image-%07d.png")

## movie to frames
ffmpeg -i spliced.mp4 -f image2 out/out_01/image-%07d.png
ffmpeg -i spliced.mp4 -r 1000 -f out/image2 out_02/image-%07d.png
ffmpeg -i spliced.mp4 -r 1 -f image2 out/out_03/image-%07d.png
ffmpeg -i spliced.mp4 -r 5 -f image2 out/out_04/image-%07d.png


setwd(wd)