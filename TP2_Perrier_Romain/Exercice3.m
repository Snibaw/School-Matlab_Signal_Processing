%--------------------------- Exercice 3 ---------------------------------
clear all 
close all

% Partie [1 - 3] se trouve dans la fonction après l'affichage des résultats

% Partie 4] : Comparaison pour différentes matrices Q

[file,path] = uigetfile;

% Affichage Image et Spectre Q = 1
figure()
[Spectre,image_reconstituee] = DCT2D(1,file,path); % Calcul des images
% Affichage de l'image reconstituée
subplot(2,1,1)
imshow(image_reconstituee)
title('Image Reconstituee Q = Q*1')
% Affichage du spectre
subplot(2,1,2)
imshow(Spectre)
title('Spectre Q = Q*1')

% Affichage Image et Spectre Q = 5
figure()
[Spectre,image_reconstituee] = DCT2D(5,file,path); % Calcul des images
% Affichage de l'image reconstituée
subplot(2,1,1)
imshow(image_reconstituee)
title('Image Reconstituee Q = Q*5')
%Affichage du spectre
subplot(2,1,2)
imshow(Spectre)
title('Spectre Q = Q*5')

% Affichage Image et Spectre Q = 50
figure()
[Spectre,image_reconstituee] = DCT2D(50,file,path); % Calcul des images
% Affichage de l'image reconstituée
subplot(2,1,1)
imshow(image_reconstituee)
title('Image Reconstituee Q = Q*50')
%Affichage du spectre
subplot(2,1,2)
imshow(Spectre)
title('Spectre Q = Q*50')
% On trouve une perte d'information sur le spectre quand on augmente Q il
% y a donc bien une compression dans ce cas là
% Cependant on ne retrouve pas cette perte sur l'image reconstituée ce qui
% semble illogique au vu de l'article support

% Partie 1 à 3
% Utilisation d'une fonction pour simplifier la comparaison par la suite
function [Spectre,image_reconstituee] = DCT2D(x,file,path)
    multiplicateur = 5;
    
    % 1] Définition des matrices
    % Définition de M d'après la formule
    M = matriceM();
    % Définition de la transposé de M
    MT = M';
    % Définition de la matrice Q en utilisant les données du texte
    Q = matriceQ().*x; % x représente le nombre multipliant Q

    % 2] Calcul matriciel de la DCT, quantification et affichage des spectres 
    % Même chose que l'exercice 2
    image = imread(strcat(path,file));
    imresize(image,[464,720]);

    % Calcul de la DCT
    DCT_image = zeros(464,720);
    for i=1:8:464 % On utilise le fait que : DCT = M * image * MT
        for j=1:8:720
            image_double=double(image(i:i+7,j:j+7));
            DCT_image(i:i+7,j:j+7)=mtimes(M,mtimes(image_double,MT));
        end 
    end

    % Quantification :
    DCTQ = zeros(464,720);
    for i=1:8:464 % On divise par la matrice Q
       for j=1:8:720
            DCTQ(i:i+7,j:j+7)=(DCT_image(i:i+7,j:j+7))./Q;
        end 
    end

    % On obtient le spectre en multipliant la valeur absolue de DCTQ par "multiplicateur" = {5,10,15}
    % On transforme ensuite le double en uint8 avant d'inverser le niveau de
    % gris
    Spectre = (255-(uint8(abs(DCTQ).*multiplicateur))); 

    % Reconstruction de l'image
    % Calcul de DCTQ inverse
    DCTQI = zeros(464,720);
    % On réalise les opérations inverses
    for i=1:8:464 
       for j=1:8:720 % On Commence par multiplier par Q
            DCTQI(i:i+7,j:j+7)=(DCTQ(i:i+7,j:j+7)).*Q;
        end 
    end

    image_reconstituee = zeros(464,720);
    for i=1:8:464 % On utilise la formule : Ifinal = MT x I x M (M orthogonale)
        for j=1:8:720
            image_reconstituee(i:i+7,j:j+7)=mtimes(MT,mtimes(DCTQI(i:i+7,j:j+7),M));
        end 
    end
    image_reconstituee=uint8(image_reconstituee); % Conversion double en uint8
end



