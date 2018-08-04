function [matches, confidences] = match_features_new(features1, features2, limit)

  %calculo do metodo de "nearest neighbor distance ratio test"
  %implementado sem as funcoes proibidas

    for f1index = 1 : size(features1, 1)

    %computa as diferencas entre todas as features1 e features2 retiradas da imagem
    differences = zeros(size(features2, 1), 1);
    
      for f2index = 1 : size(features2, 1)
          differences(f2index) = sum(abs(features1(f1index,:) - features2(f2index,:)));
      end

      %encontra o primeiro e o segundo vizinho mais proximo
      [mindiff1val, mindiff1index] = min(differences(differences>0));
      differences2 = differences .* (differences> mindiff1val);
      [mindiff2val, mindiff2index] = min(differences2(differences2>0));

      %calcula a semelhanca entre os dois pontos, mais proximo de 1 mais semelhante
      % o limite da semelhanca esta sendo passado como 0.7
      semelha = mindiff1val / mindiff2val;

      %se for semelhance adiciona ao vetor match e confidence
      %incrimenta o vetor de match indice
      if semelha < limit
          matches(matchindex, :) = [f1index; mindiff1index];
          confidences(matchindex) = 1 / semelha;
          matchindex = matchindex + 1;
      end

  %truncate match and confidence vector
  matches = matches(1:matchindex-1,:);
  confidences = confidences(1:matchindex-1);
end