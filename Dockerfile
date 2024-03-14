FROM mcr.microsoft.com/dotnet/sdk:7.0 AS build-env
WORKDIR /App

# Copy everything
COPY . ./
# Restore as distinct layers
RUN dotnet restore
# Build and publish a release
RUN dotnet publish -c Release -o out

# Build runtime image
FROM mcr.microsoft.com/dotnet/aspnet:7.0
WORKDIR /App
COPY --from=build-env /App/out .
ENTRYPOINT ["dotnet", "docker.dll"]

# docker file oluşturduktan sonra öncelikle projeyi derleyip publish ediyoruz. sonrasında container oluşturup ayağa kaldırıyoruz.
# create a container = docker create --name core-counter counter-image
# start container = docker start core-counter
# stop container = docker stop core-counter
# single run = docker run -it --rm counter-image
# aktif container için = docker ps, tüm containerlar için = docker ps -a
# remove container = docker rm core-container
# remove image = docker rmi core-container:latest ya da docker rmi mcr.microsoft.com/dotnet/aspnet:7.0
# tüm yüklü imajları listelemek için docker images
