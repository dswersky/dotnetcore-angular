FROM microsoft/dotnet:2.1-sdk AS build
WORKDIR /app
COPY *.sln .
COPY angularapp/*.csproj ./angularapp/
RUN dotnet restore

COPY angularapp/ ./angularapp/
WORKDIR /app/angularapp
RUN curl -sL https://deb.nodesource.com/setup_10.x | bash - && apt-get install -y nodejs
RUN dotnet publish -c Release -o out


FROM microsoft/dotnet:2.1-aspnetcore-runtime AS runtime
WORKDIR /app
COPY --from=build /app/angularapp/out ./
ENTRYPOINT ["dotnet", "dotnet-angular.dll"]


