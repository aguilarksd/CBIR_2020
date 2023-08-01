function [subimage_block] = GetImageblocks(subimg,block_size)

[M,N]=size(subimg);
M = block_size*floor(M/block_size);N = block_size*floor(N/block_size);
subimg=imresize(subimg,[M,N]);
bs=block_size/2;
avgO = @(block_struct) mean(mean(block_struct.data));
subimage_block = uint8(blockproc(subimg,[bs bs],avgO));

end

