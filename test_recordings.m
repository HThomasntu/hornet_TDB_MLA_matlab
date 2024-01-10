close all
clear all
load masking_parameters.mat
load polygonal_areas.mat

% load the .mat file to test:
load 29-06-23.mat

x = hornet_X;
y = hornet_Y;
 
xx = bee_X;
yy = bee_Y;

xxx = bg_X;
yyy = bg_Y;

xxxx = bgs_X;
yyyy = bgs_Y;


% create hornet mask:

hornet_data = [x,y];
plot(hornet_data(:,1),hornet_data(:,2),'*')

shrink_f = 0.1; 

jbH = boundary(hornet_data(:,1),hornet_data(:,2),shrink_f);
hold on;
plot(hornet_data(jbH,1),hornet_data(jbH,2));
fill(hornet_data(jbH,1),hornet_data(jbH,2),'r');
hold on;
hold on
plot(x,y,'o','MarkerEdgeColor','black')

%%%-- check any point come inside boundary --%%
[m_bound, n_bound] = size(jbH);

for i = 1:1:m_bound
    x_bp(i,1)= hornet_data(jbH(i,1),1);
    y_bp(i,1)= hornet_data(jbH(i,1),2);
end

bound_cord = [x_bp y_bp];
ans_logic_hornet = inpolygon(df_x,df_y,x_bp,y_bp);

if ans_logic_hornet == 1
    disp(" The point falls inside the polygon");
else
    disp(" The point falls outside the polygon");
end

% create bee mask: 

bee_data = [xx,yy];
plot(bee_data(:,1),bee_data(:,2),'*')
shrink_f = 0.1;  

jbB = boundary(bee_data(:,1),bee_data(:,2),shrink_f);
hold on;
plot(bee_data(jbB,1),bee_data(jbB,2));
fill(bee_data(jbB,1),bee_data(jbB,2),'k');
hold on;
plot(df_x,df_y,'o', 'MarkerEdgeColor', 'green');
hold on
plot(xx,yy,'o','MarkerEdgeColor','white')
plot(xx,yy,'.')

%%%-- check any point come inside boundary --%%
[m_bound2, n_bound2] = size(jbB);

for i2 = 1:1:m_bound2
    xx_bp(i2,1) = bee_data(jbB(i2,1),1);
    yy_bp(i2,1) = bee_data(jbB(i2,1),2);
end
 
bound_cord2 = [xx_bp yy_bp];
ans_logic_bee = inpolygon(df_x,df_y,xx_bp,yy_bp);

if ans_logic_bee == 1
    disp(" The point falls inside the polygon");
else
    disp(" The point falls outside the polygon");
end


% create winter background mask: 

bg_data = [xxx,yyy];
plot(bg_data(:,1),bg_data(:,2),'*')
shrink_f = 0.1;  

jbBG = boundary(bg_data(:,1),bg_data(:,2),shrink_f);
hold on;
plot(bg_data(jbBG,1),bg_data(jbBG,2));
fill(bg_data(jbBG,1),bg_data(jbBG,2),'b');
hold on;
plot(df_x,df_y,'o', 'MarkerEdgeColor', 'green');
hold on
plot(xxx,yyy,'o','MarkerEdgeColor','white')
plot(xxx,yyy,'.')

%%%-- check any point come inside boundary --%%
[m_bound3, n_bound3] = size(jbBG);

for i3 = 1:1:m_bound3
    xxx_bp(i3,1) = bg_data(jbBG(i3,1),1);
    yyy_bp(i3,1) = bg_data(jbBG(i3,1),2);
end
 
bound_cord3 = [xxx_bp yyy_bp];
ans_logic_bg = inpolygon(df_x,df_y,xxx_bp,yyy_bp);

if ans_logic_bg == 1
    disp(" The point falls inside the polygon");
else
    disp(" The point falls outside the polygon");
end


% create summer background mask:

bgs_data = [xxxx,yyyy];
plot(bgs_data(:,1),bgs_data(:,2),'*')

shrink_f = 0.1; 

jbS = boundary(bgs_data(:,1),bgs_data(:,2),shrink_f);
hold on;
plot(bgs_data(jbS,1),bgs_data(jbS,2));
fill(bgs_data(jbS,1),bgs_data(jbS,2),'c');
hold on;
plot(df_x,df_y,'o', 'MarkerEdgeColor', 'green');
hold on
plot(xxxx,yyyy,'o','MarkerEdgeColor','black')

%%%-- check any point come inside boundary --%%
[m_bound4, n_bound4] = size(jbS);

for i4 = 1:1:m_bound4
    xxxx_bp(i4,1)= bgs_data(jbS(i4,1),1);
    yyyy_bp(i4,1)= bgs_data(jbS(i4,1),2);
end

bound_cord4 = [xxxx_bp yyyy_bp];
ans_logic_bgs = inpolygon(df_x,df_y,xxxx_bp,yyyy_bp);

if ans_logic_bgs == 1
    disp(" The point falls inside the polygon");
else
    disp(" The point falls outside the polygon");
end


% which mask does each point fall into?

new_matrix = zeros(3, length(df_x));

for i = 1:length(df_x)
    ans_logic_hornet = inpolygon(df_x(1,i),df_y(1,i),x_bp,y_bp);
    ans_logic_bee = inpolygon(df_x(1,i),df_y(1,i),xx_bp,yy_bp);
    ans_logic_bg = inpolygon(df_x(1,i),df_y(1,i),xxx_bp,yyy_bp);
    ans_logic_bgs = inpolygon(df_x(1,i),df_y(1,i),xxxx_bp,yyyy_bp);
    if ans_logic_hornet == 1 && ans_logic_bee == 0 && ans_logic_bg == 0 && ans_logic_bgs == 0 
        disp ("the point falls inside hornet")
        rule_all(1,i) = 999;
        new_matrix(1,i)= df_x(1,i);
        new_matrix(2,i)= df_y(1,i);
        new_matrix(3,i)= rule_all(1,i);
    elseif ans_logic_hornet == 0 && ans_logic_bee == 1 && ans_logic_bg == 0 && ans_logic_bgs == 0
        disp ("the point falls inside bee")
        rule_all(1,i) = 998;
        new_matrix(1,i)= df_x(1,i);
        new_matrix(2,i)= df_y(1,i);
        new_matrix(3,i)= rule_all(1,i);
    elseif ans_logic_hornet == 0 && ans_logic_bee == 0 && ans_logic_bg == 1 && ans_logic_bgs == 0
        disp ("the point falls inside background ")
        rule_all(1,i) = 997;
        new_matrix(1,i)= df_x(1,i);
        new_matrix(2,i)= df_y(1,i);
        new_matrix(3,i)= rule_all(1,i);
    elseif ans_logic_hornet == 0 && ans_logic_bee == 0 && ans_logic_bg == 0 && ans_logic_bgs == 1
        disp ("the point falls inside weak bee ")
        rule_all(1,i) = 996;
        new_matrix(1,i)= df_x(1,i);
        new_matrix(2,i)= df_y(1,i);
        new_matrix(3,i)= rule_all(1,i);
    else
        disp ("the point falls in no category")
        rule_all(1,i) = 995;
        new_matrix(1,i)= df_x(1,i);
        new_matrix(2,i)= df_y(1,i);
        new_matrix(3,i)= rule_all(1,i); 
    end
end


[a b] = find(new_matrix(3,:) == 999); % hornet
[c d] = find(new_matrix(3,:) == 998); % bee
[e f] = find(new_matrix(3,:) == 997); % winter background
[g h] = find(new_matrix(3,:) == 996); % summer background
[i j] = find(new_matrix(3,:) == 995); % no category
