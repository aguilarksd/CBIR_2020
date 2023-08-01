function [subimage_block] = GetHSVblocks(subimg,block_size,M,N)

M = block_size*floor(M/block_size);N = block_size*floor(N/block_size);
subimg=imresize(subimg,[M N]);
bs=block_size/2;
avgO = @(block_struct) mean(mean(block_struct.data));
subimage_block(:,:,1) = blockproc(subimg(:,:,1),[bs bs],avgO);
subimage_block(:,:,2) = blockproc(subimg(:,:,2),[bs bs],avgO);
subimage_block(:,:,3) = blockproc(subimg(:,:,3),[bs bs],avgO);

end

