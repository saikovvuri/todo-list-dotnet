FROM mcr.microsoft.com/dotnet/core/sdk:3.0.100 AS builder

WORKDIR /src
COPY src/ToDoList.csproj .
RUN dotnet restore

ARG RID='linux-x64'

COPY src/ .
RUN dotnet publish -c Release -o /out -r ${RID} ToDoList.csproj

# app image
FROM mcr.microsoft.com/dotnet/core/runtime-deps:3.0

EXPOSE 80
WORKDIR /data
WORKDIR /app
ENTRYPOINT ["./ToDoList"]

COPY --from=builder /out/ .