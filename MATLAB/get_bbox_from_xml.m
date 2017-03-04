  xml = textread(anno_name,'%s');
   pattern = '<[xy]m[inax]+>(?<value>\d+)</[xy]m[inax]+>';
   matchStr = regexp(xml, pattern, 'names');
   for j = 1:length(matchStr)
      if length(matchStr{j})~=0
          xmin = str2double( matchStr{j}.value);
          ymin = str2double( matchStr{j+1}.value);
          xmax = str2double( matchStr{j+2}.value);
          ymax = str2double( matchStr{j+3}.value);
          break;
      end
   end
