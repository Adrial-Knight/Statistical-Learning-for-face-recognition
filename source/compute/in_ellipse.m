function boolean = in_ellipse(point, centre, V, lambda)
    a = 2*sqrt(lambda(1, 1));
    b = 2*sqrt(lambda(2, 1));
    
    point_centre(1, 1) = point(1, 1)-centre(1, 1);
    point_centre(2, 1) = point(2, 1)-centre(2, 1);
    
    point_rot = V\point_centre;
    
    if (point_rot(1, 1)/a)^2+(point_rot(2, 1)/b)^2 <= 1
        boolean = true;
    else
        boolean = false;
    end
end

