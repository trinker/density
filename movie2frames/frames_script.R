## http://stackoverflow.com/questions/3917601/ffmpeg-split-avi-into-frames-with-known-frame-rate
## http://bioeng-student.blogspot.com/2011/05/splitting-video-into-frames-using.html

#getwd()
setwd("movie2frames")
browseURL("https://copy.com/web/spliced.mp4?download=1")
##  move to working directory

## cd GitHub/density/movie2frames  ## shell command

## Splice
ffmpeg -i truly_amazing_teacher.mp4 -ss 00:00:20.0 -c copy -t 00:00:35.0 spliced.mp4

## movie to frames
ffmpeg -i spliced.mp4 -f image2 out1/image-%07d.png
ffmpeg -i spliced.mp4 -r 1000 -f image2 out2/image-%07d.png
ffmpeg -i spliced.mp4 -r 1 -f image2 out3/image-%07d.png
ffmpeg -i spliced.mp4 -r 5 -f image2 out4/image-%07d.png


