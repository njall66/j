NB.
NB. play around with bitmaps - looking for simple ways to generate interesting visualizations
NB.

simpleDiskMap =: {{

NB. create bitmap with disk filled in
NB.
NB. x - size for full bitmap 
NB. y - disk radius (in pixels)

dim =. x 
r =. y

dim =. ( ((<. y)&[) ` ] @. (0&<) ) x 

(r^2)&> (|."1 ,. ]) (|. , ]) +/~ *: 0.5&+ i. dim }}

