####################### Build Hosts #####################
docker build . -t host_kzouggar-1 --target host_kzouggar-1
docker build . -t host_kzouggar-2 --target host_kzouggar-2
####################### Build Routers #####################
docker build . -t routeur_kzouggar-1 --target routeur_kzouggar-1
docker build . -t routeur_kzouggar-2 --target routeur_kzouggar-2