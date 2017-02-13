base_dir = pwd();

f_id = fopen('trainval.txt', 'r');
line = fgetl(f_id);

while(ischar(line))
    img = imread([base_dir '/style_transfer/' line '.jpg']);
    img = imresize(img, [480, 640]);
    xml_id = fopen([base_dir '/annotations/' line '.xml'],'r');
    xml_line = fgetl(xml_id);
    Rect = [];
    while(ischar(xml_line))
        begin_at = findstr(xml_line, '<xmin>');
        if(~isempty(begin_at))
            end_at =findstr(xml_line, '</xmin>');
            Rect(1) = str2double(xml_line(begin_at+6:end_at-1));
            
            xml_line = fgetl(xml_id);
            begin_at = findstr(xml_line, '<ymin>');
            end_at =findstr(xml_line, '</ymin>');
            Rect(2) = str2double(xml_line(begin_at+6:end_at-1));
            
            xml_line = fgetl(xml_id);
            begin_at = findstr(xml_line, '<xmax>');
            end_at =findstr(xml_line, '</xmax>');
            Rect(3) = str2double(xml_line(begin_at+6:end_at-1)) - Rect(1);
                        
            xml_line = fgetl(xml_id);
            begin_at = findstr(xml_line, '<ymax>');
            end_at =findstr(xml_line, '</ymax>');
            Rect(4) = str2double(xml_line(begin_at+6:end_at-1)) - Rect(2);
        end
        xml_line = fgetl(xml_id);
        %fprintf('%s\n', xml_line);
    end
    img = imcrop(img,Rect);
    imwrite(img, [base_dir '/patches/ST_' line '.jpg']);
    
    
    
    line = fgetl(f_id);
end