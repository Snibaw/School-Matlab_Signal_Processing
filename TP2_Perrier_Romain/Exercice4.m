%--------------------------- Exercice 4 ---------------------------------
clear all 
close all
i = 1;
j = 1;
indice = 1; % Indice à écrire dans la liste qui reportorie l'ensemble des [i,j]
X = zeros(64,2); % List réportoriant l'ensemble des [i,j]
X(indice,:) = [i,j]; % Première élément de la liste
indice = indice + 1;
sensDirect = 1; 
% SensDirect = 0 : On parcourt la diagonale d'en haut à droite jusqu'en bas à gauche
% SensDirect = 1 : On parcourt la diagonale d'en bas à gauche jusqu'en haut
% à droite

% Utilisation de 2 boucles pour la clarté
while i ~=8 && j ~=8 % tant qu'on a pas fait la moitié du chemin
     if i == 1 % Si on touche le bord du haut
         X(indice,:) = [i,j+1]; % On longe ce bords
         indice = indice + 1;
         i = i + 1;
         X(indice,:) = [i,j]; % Puis on repart sur la diagonale indirect
         indice = indice + 1;
         sensDirect = 0; %Diagonale indirect
     end
     if j == 1 % Si on touche le bord gauche
         X(indice,:) = [i+1,j]; % On longe ce bords
         indice = indice + 1;
         j = j + 1;
         X(indice,:) = [i,j]; % Puis on repart sur la diagonale direct
         indice = indice + 1;
         sensDirect = 1; %Diagonale direct
     end
     if j~=1 || i~=1
         if sensDirect == 0 % Si on est sur la diagonale indirect
             while j ~=1 % On fait une diagonale jusqu'au bord gauche
                i = i + 1;
                j = j - 1;
                X(indice,:) = [i,j];
                indice = indice + 1;
             end
         elseif sensDirect == 1 % Si on est sur la diagonale direct
             while i ~=1% On fait une diagonale jusqu'au bord du haut
                 i = i - 1;
                 j = j + 1;
                 X(indice,:) = [i,j];
                 indice = indice + 1;
             end
         end
     end
     
end
% Une fois qu'on est à mi-chemin
while i + j < 16 % Tant que [i,j] =/= [8,8]
     if i == 8 % Si on est sur le bords du bas
         j = j +1;
         X(indice,:) = [i,j]; % On longe ce bords
         indice = indice + 1;
         i = i - 1;
         j = j + 1;
         % Si on est à l'indice [8,8] on ne continue pas, fin de boucle
         if i + j < 16 
            X(indice,:) = [i,j];
         end
         indice = indice + 1;
         sensDirect = 1; % Diagonale direct
     end
     if j == 8% Si on est sur le bords de droite
         i = i +1;
         X(indice,:) = [i,j];  % On longe ce bords
         indice = indice + 1;
         i = i + 1;
         j = j - 1;
         X(indice,:) = [i,j];
         indice = indice + 1;
         sensDirect = 0; % Diagonale indirect
     end
     if j <8 || i <8 % Si on est pas sur un bords ( sur une diagonale)
         if sensDirect == 1 % Si on est sens direct
             while j < 8 % Tant qu'on atteints pas le bords droit
                i = i - 1;
                j = j + 1; % On longe cette diagonale
                X(indice,:) = [i,j];
                indice = indice + 1;
             end
         elseif sensDirect == 0 % Si on est en sens indirect
             while i < 8 % Tant qu'on atteints pas le bords du bas
                 i = i + 1;
                 j = j - 1; % On longe cette diagonale
                 X(indice,:) = [i,j];
                 indice = indice + 1;
             end
         end
     end
end
% Affichage du graphique avec inversion des axes
line(X(:,2),X(:,1),"LineWidth",3)
axis ij
title('Balayage en zigzag')
set(gca, 'XAxisLocation','top')
xlabel('longueur [pixel]')
ylabel('hauteur [pixel]')