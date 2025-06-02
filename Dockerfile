FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
WORKDIR /webapp

# Copiar y restaurar dependencias
COPY *.csproj ./
RUN dotnet restore

# Copiar todo y publicar en modo Release
COPY . ./
RUN dotnet publish -c Release -o out

# Imagen final
FROM mcr.microsoft.com/dotnet/aspnet:8.0
WORKDIR /webapp

COPY --from=build /webapp/out ./

EXPOSE 8080

ENTRYPOINT ["dotnet", "DockerDoNetApp.dll"]
