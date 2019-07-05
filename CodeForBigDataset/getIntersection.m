function [x0,y0] = getIntersection(x1,y1,x2,y2,x3,y3,x4,y4)

    a=x2-x1;
    b=x3-x4;
    c=y2-y1;
    d=y3-y4;
    g=x3-x1;
    h=y3-y1;
    f=a*d-b*c;
    
    if (a == 0 && c == 0)
        x0 = x1;
        y0 = y1;
    elseif (b == 0 && d == 0)
        x0 = x3;
        y0 = y3;
    else 

        t=(d*g-b*h)/f;
        s=(-c*g+a*h)/f;

        x0=x1+t*(x2-x1);
        y0=y1+t*(y2-y1);
    end

    
end

