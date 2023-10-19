docker pull mcr.microsoft.com/dotnet/sdk:7.0 AS build
WORKDIR /src
COPY ./Storage.API/Storage.API.csproj .
RUN dotnet restore "Storage.API.csproj"
COPY . .
RUN dotnet publish "Storage.API.csproj" -c Release -o /publish

FROM docker pull mcr.microsoft.com/dotnet/runtime:7.0 AS final
WORKDIR /app
COPY --from=build /publish .

ENTRYPOINT ["dotnet", "Storage.API.csproj"]