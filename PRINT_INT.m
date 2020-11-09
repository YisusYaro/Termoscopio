function DATOS = PRINT_INT(X,Y,XPRINT)

global dx

i = XPRINT/dx;
j = i+1:i:size(X,2);

XP = X(j);
YP = Y(j);

XP = [X(1),XP];
YP = [Y(1),YP];

DATOS = [XP',YP'];

end