NB.
NB. Functions to play around with geometric computations
NB.

pointsToCircle =: 3 : 0

NB. given three points - return center radius of circle that can be drawn through the points
NB.
NB. If the three points are collinear - returns infinite radius and center
NB.
NB. currently only works in two dimensions
NB.
NB. Y - (x1 , y1) , (x2, y2) ,: (x3, y3)
NB. 

'x0 y0 x1 y1 x2 y2' =. , y 

A =. x1 - x0
B =. y1 - y0
C =. x2 - x0
D =. y2 - y0

E =. ( A * (x0 + x1) ) + B * (y0 + y1)
F =. ( C * (x0 + x2) ) + D * (y0 + y2)

G =. 2 * ( (A * (y2 - y1) ) - B * (x2 - x1) )

if. G -.@:-: 0 do.

  NB. we should have a circle - compute center and radius

  xc =. G %~ (D * E) - B * F
  yc =. G %~ (A * F) - C * E

  r =. %: +/ *: (x0 - xc) , (y0 - yc) 

  xc , yc , r 

else.

  NB. G=0 thus points are collinear 

  _ _ _ 

end. 
)

linePointPerp =: 4 : 0

NB. Given point A and line L specified by two points
NB. Return - intersection of line and perpendicular to line through specified point A
NB.
NB. x - 2 element list specifying point A
NB. y - 4 element list giving two points that specify line L
NB.
NB. Returns 2 element list giving intersection lf L and perpendicular to L through A
NB.

r1 =. 2&{. y
r2 =. 2&}. y

l2 =.  +/ *: (r2 - r1) 

if. l2 = 0 do.

  NB. Degenerate points for line L - no actual line defined - just return (_ _)

  _ _

else.

  r1 + (r2 - r1) * (x - r1) +/@:* (r2 - r1) % l2  
    
end. 
)

lineIntersect =: 4 : 0

NB. Given two lines specified by two points
NB. Return - intersection point of lines or (_,_) if lines are parallel
NB.
NB. x - 4 element list specifying points for line 1 - (x1,y1,x2,y2)
NB. y - 4 element list specifying points for line 2 - (x3,y3,x4,y4)
NB.
NB. Returns - intersection point or (_,_) for parallel lines
NB.
NB. 

'x1 y1 x2 y2' =. x
'x3 y3 x4 y4' =. y 

den =. ( (x1-x2)*(y3-y4) ) - (y1-y2)*(x3-x4)

if. den = 0 do.
    
  NB. lines do not intersect, return _,_

  _ _

else.

  px =. den %~ ( ( (x1*y2) - y1*x2) * (x3-x4) ) - (x1-x2)*((x3*y4) - y3*x4)
  py =. den %~ ( ( (x1*y2) - y1*x2) * (y3-y4) ) - (y1-y2)*((x3*y4) - y3*x4)

  px , py

end. 

)

lineSegmentCheckIntersect =: {{)d

NB. Given two line segments in two dimensions - return intersection point or (_ _) if they don't intersect 
NB.
NB. x - (x1, y1, x2, y2) - line segment one goes from (x1 y1) ==> (x2 y2)
NB. y - (x3, y3, x4, y4) - line segment two goes from (x3 y3) ==> (x4 y4)
NB. 

lineIntersectPoint =. x lineIntersect y

NB. does our lineIntersectPoint fall on both line segments

if. lineIntersectPoint -: (_ _) do.

  (_ _)

else.

  if. ( lineIntersectPoint isPointInRectangle x ) *. ( lineIntersectPoint isPointInRectangle y )  do.

    lineIntersectPoint

  else.

    (_ _)

  end. 
 
end. 
}}




isPointInPolygon =: {{)d

NB. given point and polygon - specified by N points - check if point is contained inside polygon - assumes convex polygon
NB.
NB. x - point - (x y)
NB. y - N points specifying vertexes of polynomial - (x0 y0 x1 y1 ..... xN-1 yN-1) 
NB.

point =. x

sides =. 2 (,//\)  (] , {.) ( (-:@:# , 2&[) $ ] ) y

minXSides =. min 0&{"1 sides

incomingRay =. ( (minXSides - 10)&[ , {: , ] ) point

1&= 2&| # (_ _) -.~ incomingRay lineSegmentCheckIntersect"(_ _1) sides 
}}


isPointInRectangle =: {{)d

NB. given a point and rectangle specified by two points (opposite corners) - return 1 if point in rectangle and 0 if not
NB.
NB. x - point (x y)
NB. y - (x0 y0 x1 y1) - oppposite corner of rectangle
NB. 

sortRectX =. /:~ (0 2)&{ y
sortRectY =. /:~ (1 3)&{ y

(({. sortRectY) <: {: x) *. ( ({. sortRectX) <: {. x ) *. ( ({: sortRectY) >: {: x) *. ( ({: sortRectX) >: {. x) 
}}

pointsCollinear2 =: 3 : 0

0 pointsCollinear2 y

:

NB. Check if three points are collinear in two dimensions
NB.
NB. x - tolerance for check (default = 0) - note that default will likely not work for anything other than integers or rational numbers
NB. y - 3 points - list of length 6 - (x1, y1, x2, y2, x3, y3)
NB.
NB. returns 1 if points are colinear and 0 otherwise
NB.
NB. Essentially takes the cross product of (r2 - r1) X (r3 - r1)  - where rn = (xn , yn)
NB.

tol =. x
'x1 y1 x2 y2 x3 y3' =. y

(tol&>: , ]) (x1 * (y2 - y3) ) + (x2 * (y3 - y1)) + x3 * (y1 - y2 )
)



circleInversion =: 3 : 0

(1 0 0) circleInversion y 

:

NB. Invert specified point around specified circle
NB.
NB. X - circle radius (default 1), center x (default 0), center y (default 0)
NB. Y - Point to invert - (x, y)
NB.
NB. Strategy - if inversion point is center of circle, then just return _ _
NB. - otherwise return  Rc + (R - Rc) * (a / |R - Rc|)^2
NB.

a =. 0&{ :: 1: x 
rc =. (1 2)&{ :: (0 0)&[ x
r =. y

if. y -: rc do. 

  _ _ 

else.

  dr =. r - rc

  rc + dr * (a^2) % (+/ dr^2)
  
end.
)

testFun =: 3 : 0

1
)


lineSegmentCheckIntersectParallel =: {{)v

NB. Given two parallel line segments - assumed to be parallel to x axis
NB. determine if the two line segments overlap / intersect
NB.
NB. NB. line segments specified by start location and length - e.g. (x0, l0) goes from x0 ==> (x0 + l0) 
NB.
NB. Y - (x0, l0, x1, l1)
NB.
NB. returns - (xi, li) - line segment of intersection / overlap (if any) or (_,_) if no intersection / overlap
NB. 

'x0 l0 x1 l1' =. y

if. x0 <: x1 do.

  xl0 =. x0 + l0 

  if. (x0 + l0) >: x1 do.

    intersection =. x1 , x1 -~ xl0 <. x1 + l1   

  else.

    intersection =. _ _ 

  end. 

else.

  xl1 =. x1 + l1 

  if. x0 <: xl1 do.

    intersection =. x0 , x0 -~ xl1 <. x0 + l0 

  else.

    intersection =. _ _

  end. 

end. 

intersection 
}}

rectCheckIntersect =: {{)v

NB. check if two rectangles with parallel sides intersect
NB.
NB. Rectangles specified by lower right corner (xr0, yr0) and width + height (w0, h1)
NB. - thus corners of rectangle are (xr0, yr0) , (xr0 + w0, yr0) , (xr0 + w0, yr0 + h0) , (xr0, yr0 + h)
NB.
NB. Returns lower right corner of intersection area + width and height of intersection area
NB.




}}



twoPointsToRect =: {{)v

NB. take vertices on opposite ends of rectangle with sides parallel to x and y axes
NB.
NB. return "canonical" form for rectangle - vertices in clockwise order + size (list of length 10)
NB.
NB. y - list of length 4 - giving two vertices
NB.

sortedPoints =. (/:~)"1 ( (0 2)&{ ,: (1 3)&{ ) y 

rectSize =. 1&+ -~/"1 sortedPoints 

rectSize ,~ (0 2 0 3 1 3 1 2)&{ , sortedPoints  
}}

rectTopLeftSizeToVertexes =: {{)v

NB. generate vertexes of a rectangle given top left corner and size
NB.
NB. y - (top left corner of rectangle) , (size of rectangle) 

,/ (2&}. ,~ 2&{. +"1 ( (0: , 0:) , (0: , {:) , ] ,: ({. , 0:) )@:<:@:(2&}.)) y 
}}