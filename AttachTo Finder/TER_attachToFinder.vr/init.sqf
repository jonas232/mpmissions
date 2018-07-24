pointerObject = "Sign_Sphere10cm_F" createVehicle [0,0,0];
pointerObject setObjectTexture [0,"#(argb,8,8,3)color(0,1,0,1,ca)"];
pointerObject hideObject true;
allMemP = false;
deleteMemP = true;
pointerCollision = true;
excluedObj = [pointerObject,player,objNull];
firstTime = true;

player addAction ["Open AttachTo Finder", {createDialog "TER_attach"}];