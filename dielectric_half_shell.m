%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%This function generates a dielectric half shell of given outer radius and
%%inner radius in the variables passed as arguments 'outer' and 'inner';
%%plot_flag is used to decide if generated stucture has to be plotted,
%%i.e., the structure is plotted on a graph iff plot_flag is 1. The
%%function returs the coordinates (X1,Y1), (X,Y) in the cartesian plane for the
%%generated structure and radius 'a' of the equivalent circular patch.

function [X1, Y1, a, X, Y] = dielectric_half_shell(outer,inner,lambda,N,plot_flag)
    shellsize = lambda;      %temporary space to carve out the dielectric shell
    %N is the number of pixels in which space is broken
    x1    = linspace(-shellsize,shellsize,N);   %x-space of square space
    y1    = linspace(-shellsize,shellsize,N);   %y-space of square space
    [X, Y] = meshgrid(x1,y1);
    X     = reshape(X,[(N)^2,1]);           %to generate the coordinate system
    Y     = reshape(Y,[(N)^2,1]);           %to generate the coordinate system
    
    %carving out dielectric shell from the square space generated by X and Y
    t = 0;      %temporary variable to hold index 
    for m = 1:(N)^2
        if (X(m)>=0 && Y(m)>=0) || (X(m)>=0 && Y(m)<=0)
            if ((X(m)^2 + Y(m)^2) <= (outer*lambda)^2) && ((X(m)^2 + Y(m)^2) >= (inner*lambda)^2)
               t = t + 1; 
               X1(t) = X(m);
               Y1(t) = Y(m);
            end
        end
    end

    del = 2*lambda/N;
    area_patch = del^2;
    a =  del/sqrt(pi); %radius of equivalent circle
    
    if plot_flag == 1
        %plotting the square space
        scatter(X,Y,'k','filled');
        hold on; grid on; axis('equal','tight');
    
        %plotting the dielectric shell
        scatter(X1,Y1,'red','filled');
        grid on; axis('equal'); hold off;
        set(gca,'fontsize',20)
    end
end

