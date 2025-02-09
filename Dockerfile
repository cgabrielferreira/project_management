# Use uma imagem base do Maven para construir o projeto
FROM maven:3.8.4-openjdk-17-slim AS build

# Defina o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copie os arquivos de código-fonte para o contêiner
COPY src /app/src
COPY pom.xml /app

# Compile o projeto e crie o arquivo JAR, ignorando os testes
RUN mvn clean package -DskipTests

# Use uma imagem base do OpenJDK para executar a aplicação
FROM openjdk:17-slim

# Defina o diretório de trabalho dentro do contêiner
WORKDIR /app

# Copie o arquivo JAR da etapa de construção para o contêiner
COPY --from=build /app/target/*.jar /app/app.jar

# Defina o comando para executar a aplicação
CMD ["java", "-jar", "app.jar"]