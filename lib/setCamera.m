function setCamera(out)

[mRear,nRear,pRear] = size(out{1});
[mFloor,nFloor,pFloor] = size(out{2});

 ax = gca;
%  ax.CameraPosition = [nRear/2,mRear/2, -mFloor/2];
 ax.CameraTarget = [nRear/2,mRear/2,1];
 campos( [nRear/2,mRear/2, -nFloor])
  ax.CameraViewAngle = 90;

 ax.Projection = 'perspective';
end
