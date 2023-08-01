function [Hw] = Get_W(img,r,c,ni)

grey = rgb2gray(img);
Sob = edge(grey);
Hw=zeros(1,ni);
SumS = @(block_struct) sum(sum(block_struct.data));
imgsum = blockproc(Sob,[r c],SumS);
vector=reshape(imgsum.',1,[]);
[val,ind]=sort(vector,'descend');
w=1.0;
for i=1:ni
    vc=ind(i);
    Hw(vc)=w;
    w=w-0.05;
end

end

