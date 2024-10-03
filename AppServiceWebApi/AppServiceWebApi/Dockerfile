FROM mcr.microsoft.com/dotnet/aspnet:8.0 AS base
USER $APP_UID
WORKDIR /app
EXPOSE 8080
EXPOSE 8081

FROM mcr.microsoft.com/dotnet/sdk:8.0 AS build
ARG BUILD_CONFIGURATION=Release
WORKDIR /AppServiceWebApi
COPY ["AppServiceWebApi/AppServiceWebApi.csproj", "AppServiceWebApi/"]
RUN dotnet restore "AppServiceWebApi/AppServiceWebApi.csproj"
COPY . .
WORKDIR "/src/AppServiceWebApi"
RUN dotnet build "AppServiceWebApi.csproj" -c $BUILD_CONFIGURATION -o /app/build

FROM build AS publish
ARG BUILD_CONFIGURATION=Release
RUN dotnet publish "AppServiceWebApi.csproj" -c $BUILD_CONFIGURATION -o /app/publish /p:UseAppHost=false

FROM base AS final
WORKDIR /app
COPY --from=publish /app/publish .
ENTRYPOINT ["dotnet", "AppServiceWebApi.dll"]
