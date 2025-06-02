# CONSTRUCCION POR CAPAS
# Imagen para compilar
FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build

# Creamos un directorio
WORKDIR /app

# Copiar archivos locales
COPY . ./

# Dependencias
RUN dotnet restore CiudApp.API/CiudApp.API.csproj
# Compilamos
# WORKDIR /app/API
RUN dotnet publish CiudApp.API/CiudApp.API.csproj -c Release -o /app/out

# Imagen del runtime
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /app
COPY --from=build /app/out .
# Comando de ejecución
ENTRYPOINT ["dotnet", "CiudApp.API.dll"]

