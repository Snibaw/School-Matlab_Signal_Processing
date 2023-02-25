%TP1 Perrier Romainn et Masse Julien
%-------------------------- Initialisation -------------------------------
clear all
close all
filename = 'Data.csv'; %Nom du fichier à ouvrir
T = 0.005; % Période d'échantillonage
retard_MG = 15; % Retard dû au calcul de la moyenne glissante
delais = 24 + retard_MG; % Délais calculé grâce à l'article + moyenne glissante
tailledonnees = 2000; % Taille d'une colonne dans le fichier des données

% Fonction de transfert du filtre Passe-Bas :
% Coefficients du numérateur
nPB(1) = 1;
nPB(7) = -2;
nPB(13) = 1; 
dPB = [1,-2,1]; % Coefficients du dénominateur

% Fonction de transfert du filtre Passe-Haut :
% Coefficients du numérateur
nPH(1) = -1; 
nPH(17) = 32;
nPH(18) = -32;
nPH(33) = 1;
dPH = [1 -1]; % Coefficients du dénominateur

Noyau_Convolution = [-1 -2 0 2 1];
%Noyau_Convolution = Noyau_Convolution /8*T;(amplitude pas importante)

% Utile pour la dernière courbe
picQRS = [];
i=1;
j=1;

%-------------------------- Question 1 -------------------------------

donneesBrutes = dlmread(filename) %Stockage des données brutes et écriture

%   Graphique 1
temps = donneesBrutes(:,1); % Utile pour afficher les graphiques
valeurs = donneesBrutes(:,2); % Valeur de l'ECG à chaque temps t

%-------------------------- Question 2 -------------------------------

%   Graphique 2
sortie_Passe_Bas = filter(nPB,dPB,valeurs);% Signal obtenu après le filtre

%   Graphique 3
sortie_Passe_Haut = filter(nPH,dPH,sortie_Passe_Bas);% Signal sortie Passe Haut

% Normalisation du signal de sortie (correspond au final à un Passe-Bande)
sortie_Passe_Haut = sortie_Passe_Haut / max(sortie_Passe_Haut);

%   Graphique 4
% Calcul de la dérivé du signal en sortie du Passe-Bande + normalisation
Derive = conv(sortie_Passe_Haut,Noyau_Convolution,'same');
Derive = Derive/max(Derive);
%On utilise la convolution car la dérivé d'une convolution vaut :
% (f*g)' = f'*g , ce qui simplifie les calculs

%   Graphique 5
% Mise au carré de la dérivé
Derive_Carre = Derive.^2;

%   Graphique 6
Vecteur1 = ones (30 ,1)/30; %Vecteur de 30 élements de valeur 1/30
% On fait la moyenne glissante en utilisant la convolution avec cette
% méthode qui est moins lourde en calcul qu'en utilisant une gaussienne
glissante = conv (Derive_Carre ,Vecteur1,'same');

%Mise en place des graphiques 3x2 avec titre sur les axes et sur le plot
tiledlayout(3,2);

%   Graphique 1
nexttile
plot(temps,valeurs)
title('Raw Signal')
xlabel('time (s)')
ylabel('values')

%   Graphique 2
nexttile
plot(temps,sortie_Passe_Bas)
title('Low pass filtered')
xlabel('time (s)')
ylabel('values')

%   Graphique 3
nexttile
plot(temps,sortie_Passe_Haut)
title('High pass filtered')
xlabel('time (s)')
ylabel('values')

%   Graphique 4
nexttile
plot(temps,Derive)
title('Normalized Derivated ECG')
xlabel('time (s)')
ylabel('values')

%   Graphique 5
nexttile
plot(temps,Derive_Carre)
title('Normalized derivated and squared ECG')
xlabel('time (s)')
ylabel('values')

%   Graphique 6
nexttile
plot(temps,glissante)
title('Moving windows average ECG')
xlabel('time (s)')
ylabel('values')
figure;

% On décale l'axe des abscisses en fonction du delais
glissante_decale = glissante(1+delais:tailledonnees);
% Le seuil correspond à 1/2 si c'est normalisé, max(f)/2 sinon
seuil = max(glissante_decale)/2;

%Détection des pics QRS
%On parcourt toute la liste
while i<(tailledonnees-delais)
    % On vérifie que la valeur est supérieur au seuil
    if (glissante_decale(i) > seuil)
         % On sauvegarde l'indice et la valeur
         ipicQRS = i;
         vpicQRS = valeurs(i+retard_MG);
         i = i+1;
         while (glissante_decale(i) > seuil)
             % On remplace la valeur si il y a un maximum local 
             % plus élevé dans la fenêtre
             inew = i+retard_MG;
             if (valeurs(inew) > vpicQRS)
                 vpicQRS = valeurs(inew);
                 ipicQRS= inew;
             end
             i = i+1;
         end
         picQRS(j)=ipicQRS; % On sauvegarde l'indice de tout nos pics
         j = j+1;
     end
     i = i+1; 
end
hold on 
% On affiche le graphique 1 et on rajoute des losanges autour des pics
plot(temps(picQRS),valeurs(picQRS),'rd');
plot(temps,valeurs,'b'); 
title("ECG Signal with R Points");
xlabel('time (s)')
ylabel('values')
hold off





