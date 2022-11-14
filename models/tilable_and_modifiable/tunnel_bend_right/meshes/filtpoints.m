b=load('txt');
puntos=b ; b=puntos(abs(puntos(:,3))==0,:);
d=b;
out = [];
c = [ 0 0 0];
b=b/100;

while length(b)> 1
    mindist = 1e6;
    idx = -1;
    i = 1;
    while i<length(b)-1
        d=b(i,:);
        dist = norm(c-d);
        if (dist < mindist)
            mindist=dist;
            idx = i;
        end
        i = i + 1;
     end
    if (idx < 0)        
        break;
    end
    
    c = b(idx,:);
    out=[out; c];
    b(idx,:) = [];    
    
end

c = [ 0 0 0];
kk=[];
for i=1:length(out)
        d=out(i,:);
        dist = norm(c-d);
        if (dist > 0.5)
            kk=[kk; d];
            c=d;
        end
end


close all;
plot(kk(:,1), kk(:,2),'*');
%plot(out(:,1),out(:,2),'*');

out = out(1:50,:);
out = kk(1:28,:);


figure;
sortrows(out, 1);
plot(out(:,1),out(:,2),'.');


dout = diff(out);
atanout = atan2(dout(:,2),dout(:,1));
atanout = [ pi/2; atanout];
atanout = atanout - pi/2;

y=0:0.01:25;
x=interp1(out(:,2),out(:,1),y);

theta=interp1(out(:,2),atanout,y);
theta(isnan(theta))=0;

y=(y-25.6090)';
x=(x-14.9386)';
theta=(theta+pi/2)';

out = [x y theta];

out(any(isnan(out),2),:) = []
dlmwrite('/home/danilo/hola.txt',out,'delimiter',' ');

plot(x,y);

figure;
plot(theta);


