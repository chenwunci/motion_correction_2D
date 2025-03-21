% clear all
% close all
function  [z_slice_num, time_num] = transfer_stack_tif()
A = dir('.\img_crop\');


z_slice_num = length(A)-3+1;
fname = strcat('.\img_crop\',A(3).name);

info = imfinfo(fname);
img_h=info.Height;% break to line 15 , check first
img_w=info.Width;% break to line 15 , check first

for zz = 1:z_slice_num %1~3ok
    
    total_img = tiffreadVolume(fullfile('.\img_crop\',A(zz+2).name));
    time_num = size(total_img,3);
    save(strcat('total_img_',num2str(zz),'.mat'),'total_img','zz', "-v7.3");
end



%% Part2: Choose the brightest img
mean_of_img=zeros(1,z_slice_num);
for zz =1:z_slice_num
    load(strcat('total_img_',num2str(zz),'.mat'));
    mean_of_img(zz)=mean(total_img(:));
end

[max_v max_idx]=max(mean_of_img);
save('brightest.mat','max_idx');


