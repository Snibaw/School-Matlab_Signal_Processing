%--------------------------- Exercice 2 ---------------------------------
clear all 
close all
q = 5;
N = 720;
% 1] Ouverture du fichier, redimensionnement et enregistrement
% Selection de l'image par l'utilisateur avec renvoie du chemin et du nom
[file,path] = uigetfile;
image = imread(strcat(path,file));
% Enregistrement de l'image en format jpg dans le même dossier
imwrite(image,file) % On passe de 357 ko à 149 ko (/2.4)
% Redimensionnement de l'image en 720x464
imresize(image,[464,720]);
subplot(2,2,1)
imshow(image);
title('image redimensionnée');


% 2]Calcul de la DCT et affichage du spectre de fréquences
% Inversion du niveau de gris
imageInv = 255.-image;
subplot(2,2,2)
imshow(imageInv); % Affichage de l'image inversée
title('image redimensionnée et inversée');
% Conversion uint8 en double
imageDouble = double(imageInv);
% Calcul de la DCT pour chaque ligne
DCT_k= zeros(464,N);
for i = 1:464
    DCT_k(i,:) = TransfoCosinus(imageDouble(i,:),N);
end
% Valeur absolue de la DCT multiplié par 10 pour le contraste
Spectre = abs(DCT_k.*10);
% Conversion double en uint8
Spectre= uint8(Spectre);
% Inversion du niveau de gris
Spectre = 255.-Spectre;
subplot(2,2,3);
imshow(Spectre); % Affichage du spectre de fréquence


% 3] Quantification et DCT inverse
% Calcul de la DCT inverse pour la reconstitution
IDCT = zeros(464,720);
for i = 1:464
    % Division du spectre par q puis on prend l'entier le plus proche avant le calcul
    IDCT(i,:) = TransfoInvCosinus(round(DCT_k(i,:)./q),720);
end
% Multiplication du spectre par q puis inversion du niveau de gris
IDCT = 255 - IDCT.*q;
% Conversion double en uint8
IDCT = uint8(IDCT);
subplot(2,2,4)
imshow(IDCT); % Affichage de l'image reconstituée
title('Image reconstituée');