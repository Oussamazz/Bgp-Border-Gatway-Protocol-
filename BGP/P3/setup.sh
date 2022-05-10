####################### Build Hosts #####################
docker build . -t host_iel-ferk-1 --target host_iel-ferk-1
docker build . -t host_iel-ferk-2 --target host_iel-ferk-2
docker build . -t host_iel-ferk-3 --target host_iel-ferk-3
####################### Build Routers #####################
docker build . -t routeur_iel-ferk-1 --target routeur_iel-ferk-1
docker build . -t routeur_iel-ferk-2 --target routeur_iel-ferk-2
docker build . -t routeur_iel-ferk-3 --target routeur_iel-ferk-3
docker build . -t routeur_iel-ferk-4 --target routeur_iel-ferk-4
