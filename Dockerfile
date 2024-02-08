FROM ubuntu:latest
WORKDIR /react-app
RUN apt-get update && apt-get install git maven default-jre -y
COPY . .
WORKDIR ./target
EXPOSE 3000
CMD ["java","-jar", "Demo-Maven-Project-0.0.1-SNAPSHOT.war"]
