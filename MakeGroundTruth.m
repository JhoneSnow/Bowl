clc;
clear;
p = genpath('E:\Downloads\stage1_train');% 获得文件夹data下所有子文件的路径，这些路径存在字符串p中，以';'分割
length_p = size(p,2);%字符串p的长度
path = {};%建立一个单元数组，数组的每个单元中包含一个目录
temp = [];
for i = 1:length_p %寻找分割符';'，一旦找到，则将路径temp写入path数组中
    if p(i) ~= ';'
        temp = [temp p(i)];
    else 
        temp = [temp '\']; %在路径的最后加入 '\'
        path = [path ; temp];
        temp = [];
    end
end  
clear p length_p temp;


file_num = size(path,1);% 子文件夹的个数
for i = 1:file_num
    
    file_path =  path{i}; % 图像文件夹路径
    img_path_list = dir(strcat(file_path,'*.png'));
    img_num = length(img_path_list); %该文件夹中图像数量
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
            image_name = img_path_list(j).name;% 图像名
            
            
            fprintf('%d %d %s\n',i,j,strcat(file_path,image_name));% 显示正在处理的路径和图像名
            %图像处理过程 省略
            image = imread(strcat(file_path,image_name));
            %image = im2bw
            image2 = image2 + image;
            imwrite(image2,strcat(new_file_path,'\',file_name))
        end
    end
end