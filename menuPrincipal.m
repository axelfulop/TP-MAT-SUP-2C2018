
%pkg load control;
%pkg load signal;


%Inicializo las variables de navegacion
volver_atras = 0;
volver_menu_ppal = 1;
sel_menu_ppal = 0;


%Inicializo variables para pedir datos despues
%matriz diagonalmente dominante = [5 2 1; 0 -3 2; -4 1 6]
prompt = {'Ingrese la matriz de coeficientes(A)','Ingrese la matriz de incognitas(X)','Ingrese la matriz de terminos independientes(B)'};
prompt2 = {'ingrese el vector inicial','ingrese la cantidad de decimales','ingrese la cota de error'};
%la matriz [1 2 3; 4 5 6; 7 8 10] no es diagonalmente dominante..
defaults = {'[5 2 1; 0 -3 2; -4 1 6]','[11; 13]','[1; 1]'};
defaults2 = {'[x;y;z]','3','4'};


%Verifico que no elija la opcion finalizar

while (sel_menu_ppal~= 4) 
  
  %Verifico que volvio al menu ppal
  if(volver_menu_ppal == 1)
    sel_menu_ppal = menu('Seleccione una opcion','-Ingresar datos','-Finalizar');
      volver_atras = 0;
      opcion = 0 ;
      volver_menu_ppal = 0;
  end
  
  switch sel_menu_ppal
      case 1
          switch opcion          
              case 0
                  sel_menu_ppal = 1; 
                  dims = inputdlg(prompt,'Ingreso de datos',3, defaults);
                  if(dims{1} == ""  || dims{2} == ""  || dims{3} == "" )
                   p=questdlg('No pueden haber campos vacios','TP SUPERIOR','Ok','Ok');
                  switch p
                  case 'Ok'
                  opcion = 0;
                  sel_menu_ppal = 1; 
                  end
                  else
                  A= str2num(dims{1});
                  X= str2num(dims{2});
                  B= str2num(dims{3});
                  esDominante= matrizDiagonalDominante(A,'');
                  esEstrictamenteDom = matrizDiagonalDominante(A,'estricta');
                  if( esDominante == 1 || esEstrictamenteDom== 1)
                  opcion = 1;
                  else
                  h=questdlg('La matriz debe ser Diagonalmente dominante, vuelva a intentarlo','TP SUPERIOR','Modificar matriz','Volver','Volver');
                  switch h
                  case 'Modificar matriz'
                  sel_menu_ppal = 1; 
                  opcion = 0;
                  case 'Volver'
                  volver_menu_ppal = 1;
                  end
                  end
                  end
              case 1
                  sel_menu1 = menu('Por favor seleccione un metodo:','1) Metodo Jacobi.','2) Metodo gauss-seidel','calcular normas',' - Volver atras - ',' - Ir al menu principal -');
                  switch sel_menu1 
                      case 1
                     dims2 = inputdlg(prompt,'Ingreso de datos',3, defaults2);
                     vec0 = str2num(dims2{1});
                     cantDec = str2num(dims2{2});
                     error = str2num(dims2{3});
                     %jacobi
                     volver_atras = 1;
                      case 2
                      dims2 = inputdlg(prompt,'Ingreso de datos',3, defaults2);
                     vec0 = str2num(dims2{1});
                     cantDec = str2num(dims2{2});
                     error = str2num(dims2{3});
                     %seidel
                     volver_atras = 1;
                      case 3
                   sel_menu12 = menu('Seleccione una opcion','1)Norma 1','2)Norma 2','3)Norma inf',' - Volver atras  normas-',' - Ir al menu principal - ');
                  switch sel_menu12
                      case 1
                       norm1 = norm(A,1);
                       msgnorm1 = sprintf('el valor de la norma 1 es: %d',norm1);
                       msgbox(msgnorm1,'TP SUPERIOR');
                      case 2
                         norm2 = norm(A,2);
                         msgnorm2 = sprintf('el valor de la norma 2 es: %d',norm2);
                         msgbox(msgnorm2,'TP SUPERIOR');
                      case 3
                         norminf = norm(A,inf);
                         msgnorminf = sprintf('el valor de la norma inf es: %d',norminf);
                         msgbox(msgnorminf,'TP SUPERIOR');
                          
                      case 4
                          volver_atras=1;
                          volver_menu_ppal = 0;
                          opcion = 1;
                      case 5
                          volver_menu_ppal = 1;
                          volver_atras = 0;
                  end
              case 4
              volver_atras=1;
              volver_menu_ppal = 0;
              opcion = 1;   
            case 5
          volver_menu_ppal = 1;
          volver_atras = 0;
                          
              end
                  
          end
              
      case 2
         break;
    
      otherwise
        disp('Opcion incorrecta, por favor vuelva a seleccionar otra opcion');
  end
end

