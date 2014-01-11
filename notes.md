# Notes

## Thoughts

1. To be more efficient on the grid the output could be A, B, C, ... Z, A1, B1, C1, ... Z1, A2...

2. The recording of data can look like:

| Image_Number      | Person_1    | Person_n     |
|:------------------|:------------|:-------------|
| image-0000001.png | A           | Z3           |
| image-0000002.png | C           | Z3           |   
| image-0000003.png | A           | A3           |     
| image-0000004.png | Z3          | B4           |      
| image-0000005.png | X2          | B3           |    
| image-000000n.png | X2          | C            |

This can then be read in, and the Cell IDs be converted to coordinates.

3. To get the worm effect from Deb Roy, first record  movement  coords, read in 
raster images, plot sequential points and connect with `geom_path`, output and 
stitch together with ffmpeg.

## Concerns

1. Getting exactly *n* images per second from ffmpeg.

2. Turning the round fish eye camera square (Deb Roy did this).

3. Does one fish eye camera cover the entire classroom?  If not could the images 
be spliced together?



