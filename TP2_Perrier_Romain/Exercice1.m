%--------------------------- Exercice 1 ---------------------------------
clear all 
close all
% Transformée en cosinus discrète – 1.5pts
% Initialisation des fonctions tests
N = 8;
fn_1 = zeros(1,8) + 20;
fn_2 = zeros(1,8);
for i = 1:8
    fn_2(i) = 4*(i-1);
end
fn_3 = [62 5 17 5 83 7 28 25];
% Calcul des transformée en cosinus discrète
DCT_1 = TransfoCosinus(fn_1,8)
DCT_2 = TransfoCosinus(fn_2,8)
DCT_3 = TransfoCosinus(fn_3,8)
% On trouve le bon résultat pour la dernière : 
% 41 1.9 0.6 17.2 20.9 -4.9 -2.2 26.2
