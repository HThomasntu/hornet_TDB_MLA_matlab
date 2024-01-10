clear all 
close all
load masking_parameters.mat

hornet_X = [];
bee_X = [];
bg_X = [];
bgs_X = [];

for pulse = 1:size(A_x,1)
    
    if pulse < 89
       hornet_X(end+1,:) = A_x(pulse,1);
       
    elseif pulse > 88 && pulse < 201
        bee_X(end+1,:) = A_x(pulse,1);
        
    elseif pulse > 281
        bgs_X(end+1,:) = A_x(pulse,1);
        
    else
      bg_X(end+1,:) = A_x(pulse,1);
    end
end


hornet_Y = [];
bee_Y = [];
bg_Y = [];
bgs_Y = [];

for pulse = 1:size(A_y,1)
    
    if pulse < 89
       hornet_Y(end+1,:) = A_y(pulse,1);
       
    elseif pulse > 88 && pulse < 201
        bee_Y(end+1,:) = A_y(pulse,1);
        
    elseif pulse > 281
        bgs_Y(end+1,:) = A_y(pulse,1);
        
    else
      bg_Y(end+1,:) = A_y(pulse,1);
    end
end


figure(1)
plot(bee_X, bee_Y,'bo')
hold on 
plot(hornet_X, hornet_Y,'ro')
hold on
plot(bg_X, bg_Y,'ko')
hold on
plot(bgs_X, bgs_Y,'co')

save('polygonal_areas.mat','bee_X','bee_Y','hornet_X','hornet_Y','bg_X','bg_Y','bgs_X','bgs_Y')