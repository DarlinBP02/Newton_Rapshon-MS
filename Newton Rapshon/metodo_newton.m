function [raiz,err,time,f,df,Xn] = metodo_newton( h,x0,tol )
%Metodo de newton 
% Declara las variables simbólicas.
syms x y z t w;        
% Convierte la función h en una cadena de texto y la vectoriza.
m = vectorize(char(h));  
% Crea una función numérica a partir de la función simbólica h.
f = matlabFunction(eval(m)); 
% Calcula la derivada simbólica de la función original.
derivada = diff(eval(m));   
% Crea una función numérica a partir de la derivada simbólica.
df=matlabFunction(derivada); 
%Número de iteración de inicialización
n=1;          
% Crear vector de salida X0
Xn= zeros(1, 1000);         
% crear error de vector de salida
err = zeros(1, 1000);  
% tiempo de convergencia de inicialización
time = 0;                   
%Error de inicialización puede entrar en el bucle
error = tol + 1;             
% tiempo de inicio
tic;      

% Verifica que la función y su derivada en x0 no sean cero para asegurar la convergencia.
if(f(x0) ~= 0 && df(x0) ~= 0) 
    while(error > tol && n < 1000)          
        % Aplica la fórmula de Newton-Raphson para actualizar x0.
        x0 = x0 -  f(x0) / df(x0);
        Xn(n) = x0;
        error = abs(f(x0));
        err(n) = error;
        n = n+1;
        % Almacena los valores actualizados de x0, error y realiza el seguimiento de las iteraciones.
    end
    % Detiene el temporizador y guarda el tiempo transcurrido.
    time = toc;
    % Elimina los espacios no utilizados en los vectores Xn y err.
    Xn = Xn(1:n-1); 
    err = err(1:n-1);
    if(n < 1000)
        raiz = x0;
    else
        raiz = 'El metodo no converge';
    end 
    % Asigna la raíz encontrada a la variable raiz, o un mensaje de error si no converge.
else
    raiz = 'El metodo no converge';
end
end
% Fin de la función metodo_newton. Retorna los valores de raiz, err, time, f, df y Xn.


