clc;
clear;
p = genpath('E:\Downloads\stage1_train');% ����ļ���data���������ļ���·������Щ·�������ַ���p�У���';'�ָ�
length_p = size(p,2);%�ַ���p�ĳ���
path = {};%����һ����Ԫ���飬�����ÿ����Ԫ�а���һ��Ŀ¼
temp = [];
for i = 1:length_p %Ѱ�ҷָ��';'��һ���ҵ�����·��tempд��path������
    if p(i) ~= ';'
        temp = [temp p(i)];
    else 
        temp = [temp '\']; %��·���������� '\'
        path = [path ; temp];
        temp = [];
    end
end  
clear p length_p temp;


file_num = size(path,1);% ���ļ��еĸ���
for i = 1:file_num
    
    file_path =  path{i}; % ͼ���ļ���·��
    img_path_list = dir(strcat(file_path,'*.png'));
    img_num = length(img_path_list); %���ļ�����ͼ������
    if img_num > 1
        %img_path_a = path{3};
       % img_path_list_a = dir(strcat(img_path_a,'*.png'));
       % file_name = img_path_list_a.name
        new_file_path = file_path;
        index_dir=strfind(new_file_path,'\');
        new_file_path = new_file_path(1:index_dir(end)-6);
        new_file_path = strcat(new_file_path,'ground_truth')
        mkdir(new_file_path)
        image_name = img_path_list(1).name;
        image1 = imread(strcat(file_path,image_name));
        image2 = uint8(zeros(size(image1)));
        
        original_image_path =  new_file_path(1:index_dir(end)-6)
        original_image_path =  strcat(original_image_path,'images\')
        original_image_value = dir(strcat(original_image_path,'*.png'))
        file_name = original_image_value.name
        for j = 1:img_num
            image_name = img_path_list(j).name;% ͼ����
            
            
            fprintf('%d %d %s\n',i,j,strcat(file_path,image_name));% ��ʾ���ڴ����·����ͼ����
            %ͼ������� ʡ��
            image = imread(strcat(file_path,image_name));
            %image = im2bw
            image2 = image2 + image;
            imwrite(image2,strcat(new_file_path,'\',file_name))
        end
    end
end