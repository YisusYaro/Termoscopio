%   INTEGRACION DE ECUACIONES DIFERENCIALES DEL TIPO 
%
%   dy/dx = f(y,u)
%
%   DONDE "y" ES LA VARIABLE DE SALIDA, "x" LA VARIABLE DE INTEGRACION 
%   Y "u" ES LA VARIABLE DE ENTRADA.           
%
%   xi: x INICIAL
%   xf: x FINAL
%   dx: INCREMENTO DE INTEGRACION
%   X:  VECTOR DE "x"
%   Y:  VECTOR DE "y"
%   n:  NUMERO DE ITERACIONES

clear; clc  % LIMPIA WORKSPACE Y COMMAND WINDOW
global dx

%Datos experimentales 
exp = [0,   7, 13 ,15, 17, 18, 18.5, 18.5, 18.5, 18.5, 18.5 ]
texp = [0 ,15, 30, 45,   60,   75, 90, 105, 120, 135, 150  ]

% RANGO DE INTEGRACION
xi = 0;
xf = 150;


% PARAMETROS
A = 0.04; %alfa
B = 1.74; %beta
Tm = 23+273.15; %temp manos en kelvin (maximo desplazamiento de agua)
Ta = 20+273.15; %temp amb en kelvin (no hay deslazamiento de agua dentro del popote)
Vi = 510; %volumen en cm3
a = 0.2827; %area en cm2


% SECCION DE INICACION
% ---------------------------------------------------
dx = 0.001;
XPRINT = 1;     % INTERVALO DE IMPRESION DE DATOS
X = xi:dx:xf;
n = length(X);
Y = Ta;          % INICIALIZA EL VECTOR Y
Va = Vi;
h = 0;
% ---------------------------------------------------
%bucle
for i = 1:n-1
% SECCION DE ECUACIONES
% ---------------------------------------------------

    dTa = A *(Tm - Ta);
    
    
    % SECCION DE INTEGRACION
    % ---------------------------------------------------
    Ta = INT_EULER(Ta,dTa);
    
    Y(i+1) = Ta;
    
    Va(i+1) = B * (Ta);%calculo basado en un despeje de la formula gas ideal
    
    Vp = Va(i+1) - Vi; %diferencia del volumen respecto al inicial, misma catidad desplazada hacia dentro del popote de agua
    
    h(i+1) = (Vp / a); %calculo de la altura respecto al volumen dentro del popote
    
    
end



% SECCION DE PRESENTACION DE RESULTADOS
% ---------------------------------------------------
% GRAFICA DE APROXIMACION DE EULER

subplot (2,2,1),plot(X,Y,'b-','LineWidth',1)
xlabel('Tiempo (segundos)')
ylabel('Temperatura (k)')
axis square
ax = gca;
ax.FontName = 'Arial';
ax.FontSize = 12;
 

subplot (2,2,2),plot(X,Va,'g-','LineWidth',1)
xlabel('Tiempo (segundos)')
ylabel(['Volumen (L)'])
axis square
ax = gca;
ax.FontName = 'Arial';
ax.FontSize = 12;


subplot (2,2,3),plot(X,h,'r-','LineWidth',1)
xlabel('Tiempo (segundos)')
ylabel('altura (cm)')
axis square
ax = gca;
ax.FontName = 'Arial';
ax.FontSize = 12;
hold on

subplot (2,2,3),plot(texp,exp,'k.','LineWidth',1)
xlabel('Tiempo (segundos)')
ylabel('altura Popote (cm)')
axis square
ax = gca;
ax.FontName = 'Arial';
ax.FontSize = 12;
hold off 


% TABLA DE RESULTADOS
X_Y = PRINT_INT(X,Y,XPRINT)


